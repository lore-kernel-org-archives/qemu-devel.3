Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477F0CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZshv-0001kp-Mk; Wed, 17 Jun 2026 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZshV-0001cQ-Uq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:01:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZshU-0008S4-5r
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:01:13 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFotT52600239
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CU+kAY/SbAGm+5s83poUPSyk4CGMXEJPbXoyXNomqPg=; b=pTBFd5jRRfco8upc
 wCeXJ9dMVjUKK2LF9iKJZUtPOuLOoVXy+5w0qfLsXfEQVpKCUyuqbZymRt6v3Z4V
 xt5nj3R49wxuzOxfhEDQDWLDa6B9Bi3kxvwZjqyH3nrWRJ5omewRL81fiphg6FZ+
 6KN1gC59e0W6anhyzJdRKXa/AeoUHIB/igp/HEFQZOpGiAC+K1VTHT4fwvpJOLcM
 SJFqmxeYzg66q25XmqPuX2SAdMNxSutAGMaUUHZicU3Yrc0nAd/QHAUohAClmTI0
 zs/W33HviMvM62bxo8J0Tu1xrpauVp5Sd3IksztvQU3pJcLtaztc5VP7qS9M2GDP
 Zzw1ZA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2425r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:01:09 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6b550a521so7005559a34.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781712068; x=1782316868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CU+kAY/SbAGm+5s83poUPSyk4CGMXEJPbXoyXNomqPg=;
 b=QT1kfSWMhl4MRj/zojzzM7/c7fXziQI40vnAmx8+C/8Cr9nuYFbYPdWjbtoIyKfDt8
 Og6wLupsxoRKNkAPbxguEnm8dtivgvsh7LsfsjanH+g8CCbH40cdsgKgUL74ZL9+FvU6
 Ukmxijc74Nvnone7X9lkRo/SUeDtmozaUMCJ3167Vwd//RfovqLyLuPgVXLoBb+pD0zG
 NYojPf1DU51tTTwgR+OH4OniUziKQqssH3j20h60NCAM5W8GTU/2uf+ahS9bG5z9lEai
 +64Qyb4gj6jOMpu0DVQxbIxmXgKWZ6Npng45Bi9EOZpbRWL+0MRg43N1cAkoO36DSxTi
 erxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781712068; x=1782316868;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CU+kAY/SbAGm+5s83poUPSyk4CGMXEJPbXoyXNomqPg=;
 b=bIFrj0ky4i89S9yt0lbMr0EZTRuUOhbuyzyOT2Qkyvr9PJBok4z2uM7pMZlRKHUUgV
 pPTEjVgkOvGR7EQZjDSwjESvWm846TXyxFFuNN2TcY1LwZFV5dLE0hnId46NDMEmW0IA
 lws3/+tDPeHzeCXadElXMPHI30Qph8tim/3Vb06HxIHLMWsW+YdztKDy4QiolZR8zfIV
 qGL9LoA9DaW/cRmyMHFcqhAER5LspLvBuHJJuv7m2U9dzlYQHx6iXVQbJumkXs4zJDDk
 Uj1Ioxax8oIakmoUzY4pbJJjPGg6WHgxd+3lkgGFhDQRqk2jKmlXacI187XnGpngEfEZ
 H9NA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cTnK5txayHxGVRF46mj11ar0Vs1R9/DwNnfM9/N70dEs3wDwlj/aUes/uZXcEttjpTUAfpvxwA6o7@nongnu.org
X-Gm-Message-State: AOJu0YyZYhxmJN6fIYCg2wKCudY8Cqxrd9CQtikywGsaVR82mxRn8TSR
 ZTsZsbjfPNdnXZfKGyW2wo7atxp09YGN9N3NDY4OrkncYTS5acr6O8UP9LkUjQj2kMqfeKzyWoh
 FxvKs3iNJaos19/jeE12M1NP/MoTuxrL6M4MclB1LcyeFkAOCQqJtZ4cygA==
X-Gm-Gg: Acq92OGNAXiBWDh7jCuFvMLeoCoyTHXCw+Rc0K3b0NAuffyUONL0XEdYuRHHwlAvtZU
 8L7PHU9BFXxmYKz3HcGhB5zQKa/VfHJXcqCZtuQanTd8rNsvUduWUCctOGvi6HNXSiJVDiviS3q
 cbW1vKKgPXtxA0fM4FVzAJGhlC1oQsz3X5cNlIyQxYWTwRnRpWVFzdBHclVKh24AWfzUWvPVRTC
 u/ojWqNPHjSzuRIO05I9US32li8W/RQNyQUhmbiRaxtduDJlA4+7oS7pJITYfpzBkiUZZ/CcJrL
 eZ813+OvqqGb/T7rxvPlWq81vBJ5lVcchKwaDDR5+CIcV2QkfLeaFp2/6CZVZv6uZojB3BOt8A5
 jLqHebAZNsgAgiysiJcwMH9A7+33WHgXc0v3UC0JG4GtcvRX65LB3iwlOi8H0Dw==
X-Received: by 2002:a05:6830:928:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7e90b14c072mr3788565a34.0.1781712068159; 
 Wed, 17 Jun 2026 09:01:08 -0700 (PDT)
X-Received: by 2002:a05:6830:928:b0:7dc:c7aa:22c7 with SMTP id
 46e09a7af769-7e90b14c072mr3788461a34.0.1781712067375; 
 Wed, 17 Jun 2026 09:01:07 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm50450329f8f.14.2026.06.17.09.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:01:06 -0700 (PDT)
Message-ID: <5f13ce5c-0d65-495c-a4f6-f01be0354b13@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: remove duplicate include
Content-Language: en-US
To: Osama Abdelkader <osama.abdelkader@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org
References: <20251126214322.64855-1-osama.abdelkader@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20251126214322.64855-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1MyBTYWx0ZWRfX5pikxQ0Hf00J
 XUHqbK69LIspOCTa/yeRapDBysMuOvfybfQxP+XDjlaolYOK76PSrSVIfk0+DPcv1VIPOUVZkPm
 potkdpTbGTigJTGvlJoHCu4EZI5uRlQ=
X-Proofpoint-ORIG-GUID: jJ3LWxLoHbJwbpT5sw-OBl_UmVXEtzEO
X-Proofpoint-GUID: jJ3LWxLoHbJwbpT5sw-OBl_UmVXEtzEO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1MyBTYWx0ZWRfXyZqK12Xf6n3N
 7ZCdT0F4MnkXHNwD5X2fYSsfTOAvqVEPBQRxC2jJQgxZderXCJlKwUQzEjdlHsv9VtQryhoMGqu
 /h6STnLcrQAJVxc65AwL0gUd2wd2/ZF0zmiV64abYx9TGeY7yGH/H/iicvqVAZpge82UNftVEmU
 qvdhNMmUB/KtELQ6RscMlzMWWefQa5Qb2QHksEgKzrs/pvCRwX93NDGt0INadUPqaSBZWNfyQ5C
 H7axzlBvsbdvQZP50AIjvQqAJizUE62QHVhzMlIpcOQL6G3KlztuR+MystBZycXDQ7F6c80SS6I
 T2GSzm+oCVsCQ6rF7InvEjQlMclMGfaAKL9/s2QueoNa+0QpwRr5u8DmRxXwv2rYN1krr/Xcm3I
 DxTpmFXSqchbOgbePsWyJ2GVZEbQbs2ci3N1K0DcuSPITHxw3YAFvClQBpqNPTv0zgPmOS1wQhX
 /w4vi/s7V2U8s5xdskA==
X-Authority-Analysis: v=2.4 cv=acpRWxot c=1 sm=1 tr=0 ts=6a32c4c5 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0qh-XUmV_KFcohtNKhIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170153
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/11/25 22:43, Osama Abdelkader wrote:
> tb-internal.h is included twice
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>   accel/tcg/cputlb.c        | 1 -
>   accel/tcg/tb-maint.c      | 1 -
>   accel/tcg/translate-all.c | 1 -
>   3 files changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

and queued, thanks!

