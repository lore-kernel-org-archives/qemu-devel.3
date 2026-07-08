Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE538C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whZAS-0001TN-Bx; Wed, 08 Jul 2026 16:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whZAQ-0001TE-Ui
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 16:46:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whZAP-0000CC-A2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 16:46:50 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668K9gau3711092
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 20:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dI6qQEKI9cuvl4FjTBp89+kwgobgAJurW8pVMeIClvM=; b=iV9uk0KkcRtc/bFn
 njQLAi9N9wqpT3KQ8EXP0U1L9+eIPAOVANN02ulE5VbkS4pDnPwnJPPUCkJTxnO+
 Qf9liPqkWpI+qoDuUw2KxrxDZXWq4WlOUo9/LvtoomqIZ+97f4rg1Yim2bWHNmAJ
 kz4xjLID666hH65k1uxucmGuqtLodpefwa20KN4zGuAJ2EY0i8evQw/06RPfC1p0
 3tBNDy9AxJ9yGDrdYjvvloa6b/tuLyn1pQynv12qwk532mO70lfu3icekWKDKLsP
 hecQdLLwca089bJtncACcWPE6Wps3aHpuoRtqV2NMkL3BwaHjGx0QbUHRGWXdPao
 C5LBNw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqwbk5f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 20:46:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92d1cae5939so38804885a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783543606; x=1784148406; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dI6qQEKI9cuvl4FjTBp89+kwgobgAJurW8pVMeIClvM=;
 b=LCLXBGOx81RpdUMgHoIN7DTRG49+A69VKV4lerAugGZeFO0OScpSAR3AAGz5tTBhhO
 6hBuTxTZMx47oO/nknmWr9wYsB9HsLGBmx4JEgk2Fcq7HJwzOukkDaeRelR3IlXg4hhJ
 7YLx3ajtnvIMIbaFEk2/R7uK9lZjfPyk2YZP7Ki5HCG65adZJOKk09NnmUPQLwafID6o
 swNJ7ak2DnnhmBi0fPfVXsuweXNwnHxVBiN/gh9d+6znfS9rXAQybBSOCz4uYW3DG3DV
 p/rfkmWzbPlzr+4ufveaAU8D/C9Ne6ot6zltXtrJaN6Wxok02Ac1Vp5N4Vo8XGSERvvq
 cOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783543606; x=1784148406;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dI6qQEKI9cuvl4FjTBp89+kwgobgAJurW8pVMeIClvM=;
 b=Qa38Ys0e7mtxKT59b+aK+cd+tLby/ocPJxfcFWkjoWV/iS4rpafxVYLYYHF2T+9n8x
 Qd5HwdcjUsmiesFbqnglh4iMbgnUPjrJ5KaGhOScL3HOD0n2ny3+dbWiyZ+kzYPJh/2C
 3djfJ1VwSBAmy/ZlDtsCb7JK3gfs/22gl4BN10l3xWssy+4fEKkTCi/VD2CSazMGFCFw
 WXzGoe8r3lGa1FTBXyWtWDdvpNrv5VrgpiW01gosKdevdQQPeBV8Ey+/1mvWCsrltgCo
 i7qwoOFPGmLv5H+pn8R2/RPg4qIBAqX7GbWMyO/nIQ8XTEISfFjBSdXqZMJnnjpD58l6
 JocA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5TnnkPLkxeP6CEyvf0k8jpNh6qpx1eWNrtFGTRMyWVxawkMp+uG8fsK7/dY5LthZcXJftAlCRbfDG@nongnu.org
X-Gm-Message-State: AOJu0YzdmCwD6s2qy8jSFq+L8jGlhw4mQyiw/WVSs8T0hXMLn88VltQB
 D3jwo5LvGa2ynR4kpqxVG/5QT4K3uFcjO3Y5fzv7+9bilCcQ9r9tXfmq3yYm6rU9d0cVrc2XJNF
 MwWobCbxYvnSJkKKtwiKqoEfRzeh8T+XraYJOUkNmHp0SxC3JCh7Z1eskcg==
X-Gm-Gg: AfdE7cm+52HyoSOlaFWSr5OfwsmvziME0QrttLjZeEczkSi79Fu3TMPcwh4/m13bL34
 zRvYzl5Q2PR8D1+YKamwvwmTjwaGvAipTe0x6OKGTUYfQLqTepR8/JCL8N5PzRLDjcwxKBGgk6n
 aF6hILq/PISGHEH1/mJurihwONaJyIjaWSUaz/QhWJaiQP/mXpYhsmSTuLSqNbtY00AOuOqsVMA
 22U2qeGNKFbdzcJTzuwFm6j16VdQRmLPbKtfvK1nMzoDihl+joXEncYWCDwMWnjF8Zvb4fT3A5v
 hDb6b9rxggiRSodwb2g7Ikot145JMOLCcRPO7d9di9VHipi3UEwUUUvX9hMbLghYV4Md5bI9swz
 t9kdCFCTGD2XYC7+yd/ZqoeN8hvwdbyXkX6jV0fcmecuOj34VLq7i7ZWvX//vJw==
X-Received: by 2002:ac8:7d91:0:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-51c8b2addaemr45436581cf.11.1783543605944; 
 Wed, 08 Jul 2026 13:46:45 -0700 (PDT)
X-Received: by 2002:ac8:7d91:0:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-51c8b2addaemr45435111cf.11.1783543603203; 
 Wed, 08 Jul 2026 13:46:43 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm9612785e9.2.2026.07.08.13.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 13:46:42 -0700 (PDT)
Message-ID: <b14f3deb-97a4-498f-a7b1-e634478f2ad8@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 22:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add
 missing apt update
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMyBTYWx0ZWRfXyfXS9BVidkA4
 CJt783wAe/ao8/+8wDwZbWBdj8ukjF8TQCKq30PWB/H2svqzbLDYRSVfMG5DV75d+qHrtqFzl4Z
 u85oi/Q4PMZ47NSMVHzemP+NlqyzIPV1G+eWFTroZehj50SNWM3aZEITMRlm9XaS2m7IcmwJWyh
 wM7SGcSu+nrs2YlakFn7+IITPY6RtWKsgAHBrn4KdoXTSNNAoBkYLBkrBOLyblgHwSUY7mhCdga
 ByTeQZ9Ix2IXi74osZ7hqTWcWkKiBskSm8xgP28xmqsWXRI6nmxAm16ekGI7RuocNnj8+mH6Z3c
 YY3lKR7WLMKWMnm6N6vVOegTkpOGAw6Tz/lnTUODbZyzJ/g3r+0Bop66eFVA9tByoLP2cULU1uB
 4oqvwvZt2ZRuCb0G3Ic6w+9K/JyMqiJ3o3jcFfG9QZcjQuscTXxDyrFimvhX37j3phWtXui47cx
 dktc8NrsA4BXK7u2A2Q==
X-Proofpoint-GUID: Wy4VtHcUHpi6hDV7WRINfqQan64TF7f8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIwMyBTYWx0ZWRfX20CImACz6svY
 CldhA4+DUssDVpfCXzFF1/QVY90xNZXT7ToA/zdUd0Vpac4NUg6mChjSaKN37AZvqJiBFY0y9j+
 pBPOF4QT6B9/DlunuzzLZEaJrEwZ8sM=
X-Proofpoint-ORIG-GUID: Wy4VtHcUHpi6hDV7WRINfqQan64TF7f8
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4eb736 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=n6MYwUk4AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080203
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

On 7/7/26 23:46, Pierrick Bouvier wrote:
> RUN statements should always use apt update && apt install together:
> https://docs.docker.com/build/building/best-practices/#apt-get
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
>   tests/lcitool/refresh                      | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

