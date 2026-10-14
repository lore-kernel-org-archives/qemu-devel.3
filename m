Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E57BCC6B20
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqPs-0005EK-Ii; Wed, 14 Oct 2026 00:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGqPr-0005EB-K0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:16:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGqPp-0004zC-PI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:16:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E1072K2874347
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VXDAZVLjKASt9//cUvPb7FgwJDY/c2BwQw0CG5tZyZQ=; b=J/twICUDNJXMY1Bt
 OlbzC3Qqn5+w/tkS8B/XcJz+Ao582lBafpoChiYlVhwMOztw11GFeYWUWSMhX9eF
 SdMd8O1nBj2j3RM+PwPxaZRB68/X6TpAofnlwAR2Hg4gkNmgGBSFmqoP2bx+QwZ9
 wviYm26Qh6sFcr6uGjCImyOcXkVHfdfCS5z2YnlvbnH0/on9+NI/KoCmLP2VZGpB
 XOKaMUaHY9ycKAdM46HkO50u3VCA8cRjFLIoVzbMPjm+R1BK6hHj5GejZvlw6de0
 ZNpmV7fbL7oeH03SR21v1NcePgaFWZVT5mwgooQMHJoTvYnWpIVqNR4oHEQGE/EA
 B8HjuQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9yphgms5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 04:16:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb6391e89so811040285a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 21:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791951391; x=1792556191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VXDAZVLjKASt9//cUvPb7FgwJDY/c2BwQw0CG5tZyZQ=;
 b=PZQ5lb5B7hWHyq7CXe0WdqIVPYvlkReTydDBUehTrCxV/EmZxCmbZwMex+bw/iJCB2
 IxaKHeFKgul/uJMZmLRC4QBe35LDmCxD3ziur3W7/0hVAWiDkWeV7np5QDkSIEs4fy55
 HqEWvHp7bYiAF0z9Jcvk3Bow8+EOFM2q4etJMf6G/THJRfeVExrU5Im+fNC4fQCi6+hL
 +0D48Bswv+4AvgNQ59/NzTxKaV9gM2q4QoKo5NIJpRI8Y6xEpP9drQ8yY7+lCa9vekbX
 Xtv8RBuDbLPrDRk89mtpnR1bVHECbyWEEmQ+ICHH/R2C/5vKReatUQX8iu0f4ZlwIS8C
 StHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791951391; x=1792556191;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VXDAZVLjKASt9//cUvPb7FgwJDY/c2BwQw0CG5tZyZQ=;
 b=bSJPfqLcZvSPGO0j02oHc58IimGOkaaWDdRMSNufk0Dqg9o9rsCckGBtvTP6ZYuImg
 fFmD2RVKWLYf0CSMQYn1UrsaCaOKnFJGkfjRzMQjO65idaKKFogrn69OP1n++OItOAz9
 km4Gmt6CtBDZVQ9FLeOzvRw8cm/WNvVKCXToKdBY2FFIRvlDHK2OWUPSkk4wB3a0c1QT
 yePRwrcREkN3Rv4rQp6qR4pZUnyym8B65lXKJRsmRpNLRYD8SiE36M6+ToQCTonwbBgs
 MvrHhAzCXf1mGPrQxt5q4eIAyyTt/kjSzvq0ksTCR4PYt6y46MAxuH+JQW7Ctp84GL+d
 qatg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy0DCvVXJoSfm1twuJJPnpGWr0RBXZqBoWNh709Rc4i0p1XznOBQvWJIQyiaPY0saQSMDZAG6Xtd9M@nongnu.org
X-Gm-Message-State: AFq9FYJy3RmaHemd/s2fT8vbejYKr2tE794fWL8veW+kXNbANwCVCTZT
 BMHx6/uYTZsKd4g0U2IuVYs10YAs4Q8q+NG0OO14TUS5yVYVOwoHGRz59gC5WqRlhEaCkIdt8ns
 qdVCTZ+aSeHBu3Xn6vzlvMKB+p62mF9/fxY62Z/l+CXf9iegx9VownQriIg==
X-Gm-Gg: AYBFou2/q9m/HPlu3f1Do8FOtm1x/u1btl7h74T5K9MaNF1C/wU8JFJ/Xv54XMNXqqG
 Hvm9E0ciDD7pzaVzY1Uin43/sQiU2ytk0wQdwmej8AEmnicZFPvGJ26AoUVJyXF2c3wdr9xezy9
 lMi8yjJLvXQ1E0AxXYKllISchHc/hhUJx8kUTYHXkHR8ZuO4u0VDtubzlEj3WnAv6BHcZG04WKL
 39emYY0I5KkaANn9nJw18OjbjGn0CeGAdqhI4jNG5XG1gMWA87IgVSHAW7ytOIKoxoouvEmB/nB
 3F66uhCAN0ghG/ElF2GKR5t/9NOvqWqGgGIl6sNGCVn7gKTjbY2inhEC4F6aj/VX6k0XdMBn8lI
 AHwMgfVZzHyo384kkHStg/wFPH2/NxYXiZA==
X-Received: by 2002:a05:620a:700c:b0:93f:5ac:14a3 with SMTP id
 af79cd13be357-93f05ac3c99mr64025885a.73.1791951391389; 
 Tue, 13 Oct 2026 21:16:31 -0700 (PDT)
X-Received: by 2002:a05:620a:700c:b0:93f:5ac:14a3 with SMTP id
 af79cd13be357-93f05ac3c99mr64023085a.73.1791951390807; 
 Tue, 13 Oct 2026 21:16:30 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac37acsm8866559f8f.34.2026.10.13.21.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 21:16:29 -0700 (PDT)
Message-ID: <72240455-9409-491e-84fe-f29efb7187a6@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 06:16:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/27] MAINTAINERS: Move Conor Dooley to PolarFire SoC
 reviewer
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor@kernel.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-28-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014012323.322790-28-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IbkrKADKVMx7d2xOxvijXW7O89OH0JM_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX+NS4S0RH+YB4
 glN0whzR3cN4EvE/VuFKHfaDz5RLIei7d9662EC0q0F54WxRFIJDU3m0o0KxLhFyiBBQqhpB2iF
 5ICbxVInGHH98mTLSTDO5isCgD+W7rc=
X-Proofpoint-ORIG-GUID: IbkrKADKVMx7d2xOxvijXW7O89OH0JM_
X-Authority-Analysis: v=2.4 cv=Uv72pOwB c=1 sm=1 tr=0 ts=6acf0220 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8 a=VMbe3sGbamrDEHPUlTkA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX0a3yycYLzDze
 x6VKm9OEmIiFLOUHvERDsPzK2ziuSHPw3g5nl9Wx3Qj4g2JlpQshpBPX4Yqx4aLCBKrH9z9Ebno
 xR1JWvhVRrawbmL9CBlLKjT9V/wDyWseCrOAm5nMdAo+YATIBuKxpfl9cMW+aJtk+oQBFn6zw8W
 qkngdusTvLb+pf96U+R4Xlqzrcm35B4o7O/PFADbUI6kIWQG7P7ry4iVVhBlvX0oyaF0/uY2g+U
 8NM1jy/Fi3FrDnCzoFFSdtl8exmeGUNs8iGc/yDP/rQSBhyL1fxr8CoqDdIX52B8tbGJAcMTkRr
 Q9NE/T7Xw3guQRj95tsaBzOk0dubeBG1uflQekvniOuUilRfzLaMmzvEwhNQ4r7DKwHc/6osIMm
 f6ulHqnUKBXgphAy4lYQ2FuCqpulo2isCThT7OHaq8AaVDXfi9dlmOqhTvBKzTZudaEwgCqbe7s
 3KXQjOuPkLkuVoP5hNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140016
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

On 14/10/26 03:23, Bin Meng wrote:
> Conor asked not to be listed as a maintainer, since that could imply
> that Microchip sponsors his work on the platform.

Hmm we hit a limitation of MAINTAINERS format.

If so, the Sebastian is in the same situation.

(we had a similar case with PIIX3:hobbyist / PIIX4:cloud in the past)

> 
> Keep him listed as a reviewer so he continues to receive relevant
> patches without suggesting an active maintenance commitment.
> 
> Suggested-by: Conor Dooley <conor@kernel.org>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Acked-by: Conor Dooley <conor@kernel.org>
> 
> 
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - New
> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0edc7385fd..40232cb65e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1794,8 +1794,8 @@ F: tests/tcg/riscv64/test-crc32.S
>   
>   Microchip PolarFire SoC Icicle Kit
>   M: Bin Meng <bin.meng@processmission.com>
> -M: Conor Dooley <conor@kernel.org>
>   M: Sebastian Huber <sebastian.huber@embedded-brains.de>
> +R: Conor Dooley <conor@kernel.org>
>   L: qemu-riscv@nongnu.org
>   S: Supported
>   F: docs/system/riscv/microchip-icicle-kit.rst

Is tooling confused when we define the same section twice?

Microchip PolarFire SoC Icicle Kit
M: Bin Meng <bin.meng@processmission.com>
S: Supported
F: docs/system/riscv/microchip-icicle-kit.rst
F: hw/riscv/microchip_pfsoc.c
F: hw/char/mchp_pfsoc_mmuart.c
F: hw/misc/mchp_pfsoc_dmc.c
F: hw/misc/mchp_pfsoc_ioscb.c
F: hw/misc/mchp_pfsoc_sysreg.c
F: include/hw/riscv/microchip_pfsoc.h
F: include/hw/char/mchp_pfsoc_mmuart.h
F: include/hw/misc/mchp_pfsoc_dmc.h
F: include/hw/misc/mchp_pfsoc_ioscb.h
F: include/hw/misc/mchp_pfsoc_sysreg.h

Microchip PolarFire SoC Icicle Kit
M: Conor Dooley <conor@kernel.org>
M: Sebastian Huber <sebastian.huber@embedded-brains.de>
S: Odd Fixes
F: docs/system/riscv/microchip-icicle-kit.rst
F: hw/riscv/microchip_pfsoc.c
F: hw/char/mchp_pfsoc_mmuart.c
F: hw/misc/mchp_pfsoc_dmc.c
F: hw/misc/mchp_pfsoc_ioscb.c
F: hw/misc/mchp_pfsoc_sysreg.c
F: include/hw/riscv/microchip_pfsoc.h
F: include/hw/char/mchp_pfsoc_mmuart.h
F: include/hw/misc/mchp_pfsoc_dmc.h
F: include/hw/misc/mchp_pfsoc_ioscb.h
F: include/hw/misc/mchp_pfsoc_sysreg.h


