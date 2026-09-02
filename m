Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B003DC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cjw-0005BL-UC; Wed, 02 Sep 2026 00:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cjv-0005BB-Uq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1cju-0008Bd-Gg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:38:23 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTM5Q3751043
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CAsDtw56jzenNK4v47oKVh6P9zS/6pzvFuCWSzz6Tbk=; b=C5F7mZe4Dz7s+xCl
 VavLixcbU8zkQg6OLKqh0XcVqlA5ZWxCPIr7/RiLgogXXdgrZmn9FlG3SfwgXfRj
 87ROy9FZaWz8TR6CPLUU1PbIwCm3ozhEBEeetZTbDxMsxzgzYAjSK8AwTdpvgFV9
 ffg7JhGugr49JIDIyeCib58Qp5u4qrIaD/QPmN874bMMEjVyW7VXt/mcPL0VyM4f
 d9GjQijMKqf955ht6W6gOqi5wLDl0GnaK31Jv976/8PaCFPUWR32sdElcaRzpVSL
 1PsawNor+EYmjwdoE5L3nbwEpTnj1i8kjfYL0jno4UprkyZOmYUDzEPcpjOixdmE
 BO/Bsw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w240u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:38:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso119986385a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323900; x=1788928700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CAsDtw56jzenNK4v47oKVh6P9zS/6pzvFuCWSzz6Tbk=;
 b=LhqGadKH+MoA28t7jjU1jkdTrycO095zgVTciZriOn9n1hZWcm0U1fDVM6zD/zcu+u
 nHx7B1FYvbEQGvpivK1yA3SqU1D8S7Y1N8ObXb7vZSrzy0NN5Vyr9ZFTrTSsDt1foW3O
 0dgpC9QKO0ABiB/GZakkSmaUQgh+bQsIw6agsBD0uemJRbXm8Z16WGrAJcuUvnkPsqJp
 IBn2CO4crZ9fcRaWWzQjPRjw6z1v+aaTNmg5U1p4wnNb6dvGnGFQejVJW2F2GhpKNxMV
 D61QzLwz4xBVeBGpdVNFFpsrBOBY5ZV/A6PVKO4wMDNJ5t6R5hzIuPaDx4cvaA1W9SLp
 uU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323900; x=1788928700;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CAsDtw56jzenNK4v47oKVh6P9zS/6pzvFuCWSzz6Tbk=;
 b=tBXhYhPPk76uEBJE3kUYCywX4kMyqO9QJShE/CPVRfmhN1IGwKbrNxZcNaA3HTpHGE
 w3bbYa4kAGdQX7cfi6wonTz+/9Vr2l1PD9kSwoVVvtgt36P6aF4NJWmCJ8ub/Rm70ETl
 TbKnLccs6r6uglYSDWuNuyyrT3HPzb9TkyPAcfSgpBmTH6JkTCv+bm0ajeah05CBfV5u
 7hpdBKalr9Ql+97fZ9nNnG3/Qkq3vH9ZejHWlfCsB2pmHVM4h30OGkvdgCl7nBA2qulo
 HY2+XfTYoBBIfnj6/vBIn3yj7NGgUjtR4xGp0zxGVR4a9/wz8SCl0q8zjLngaz+MJKdG
 baOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro9D9dnVw0xazDhEu+8Ejpyj6XDBvqvryYiehe4GM68XBUY5FXJ365yQlxXGDlrmyuSUkIkauyyV/6I@nongnu.org
X-Gm-Message-State: AFuF++kfdr5nYym7ztR/quU5z0HGtb2/O20+Da+LGV7AeWP45b+X9/Lc
 3+EVJ1ByS6hPkVPjpK/kITn3IsL4H1YtWJyzaJmAY5/h/+JJb0KDO6yM2fmZUljkRMLIlRGCFtu
 iZBlC1q24HxptVnz1t8VZdV9nqMKzTsU+vnMt1ZZw1aGAAcWoC2IOnISvHgDDopkdvg==
X-Gm-Gg: AR+sD1332TE07g3cxJ6s73+btAVR6tnL5k7DrCR8VkM/mzTy6GpLy9PqbxmXvvmq2GA
 q+N/IYibvE+L7x/8AHIBrppd5oA3g5b4RX6TSPfKEW6pQ/Tx4XZ8/+DCR3bWQGYdCHOjubQLp5+
 p8GyQRDVjHdO2DUa/8t3V61fa4u5t4z1Xn8Qs4ZYv8pUWa8MeACcADF0MxNLboVwpqx7rQqnKeh
 RRzeNi+jjnRerCTptPJXOIQtU5pWxqNhzDPH+23cgMXLT7RaHGGN3gHef+FldbL9Gwueev1CtuY
 npXpEUVVLfVNj8uRIH5ylkwLD8AeJA41e5E75Qcd4jXJGrkXUze/elmRVOId0/vb8AXKBTsOU0h
 UovjRFWvWNFFUFoYoE3A=
X-Received: by 2002:a05:620a:a1d5:20b0:914:e3dd:17ea with SMTP id
 af79cd13be357-93960e2132amr227663585a.12.1788323900385; 
 Tue, 01 Sep 2026 21:38:20 -0700 (PDT)
X-Received: by 2002:a05:620a:a1d5:20b0:914:e3dd:17ea with SMTP id
 af79cd13be357-93960e2132amr227661185a.12.1788323899942; 
 Tue, 01 Sep 2026 21:38:19 -0700 (PDT)
Received: from [192.168.69.226] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e7315bsm3708294f8f.7.2026.09.01.21.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:38:19 -0700 (PDT)
Message-ID: <e8a7fa6d-2096-4058-b405-c7dc09c02cd5@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:38:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-10-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u1xr6Ef5fiFSRRbmP1md7TUFItYaf9R-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX2M94dPutHs16
 MecTVPIkyGUdkBI6sEMMYBZcfko4uL5VfVXkQEO+IfDQm5mueQfpuEp4dj69CnXVWK+v+L9hsH+
 +aZ8s9Qf51RvkkgJwOSEOGJ7YNQu8kI=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a97a83c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: u1xr6Ef5fiFSRRbmP1md7TUFItYaf9R-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX1OrdHXX+iVim
 M1v0C1SL82FVgY+K+SrWzsbyPlK/vNxNkmwjgPbp+YfGJV1ytBXxMr2Blu3U6j9CLK+7h68lakW
 PFD5d2ojkR2VIC9y7zunP+u1aa6p0p7EBFoVI0EvE2Y6M8p92J9N52aSWOH76qyLg7wA+z7+v3P
 wRp3VWrihe4ZzjhtzpGvl+Cgt5hW+waTF5WT3MNqUDdJDzOvL968Zep0m1CUIZAyK/NBg/ufIH6
 hHXhKZcS1f++zERYZsce067PleNwUyfyaPv1hkrx+oneUQVamF55hu+pwBOT+LwWePrm8zIa9Oj
 AXgOZVV+vQA6NL5d51pMsCq558eGauAPJZsGmMgv1425VRJ/e0G9EOkUmiaKmH+eUDm6qQJdxrr
 8nuELtXwXVZPJBcsI0Z6jzRaB4n7zuJBIkXkYy2ltnhdcwwsGU2Nr7sxV9ypGtf5qN0+j1HpXUK
 F35qGcpd9BQgE97O1Ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020039
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/arm/digic_boards.c         |  2 +-
>   hw/arm/imx25_pdk.c            |  2 +-
>   hw/arm/kzm.c                  |  2 +-
>   hw/arm/max78000fthr.c         |  2 +-
>   hw/arm/mcimx6ul-evk.c         |  2 +-
>   hw/arm/msf2-som.c             |  2 +-
>   hw/arm/netduino2.c            |  2 +-
>   hw/arm/netduinoplus2.c        |  2 +-
>   hw/arm/olimex-stm32-h405.c    |  2 +-
>   hw/arm/stm32vldiscovery.c     |  2 +-
>   include/hw/arm/machines-qom.h | 14 --------------
>   11 files changed, 10 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

