Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF999606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VcyaMjyW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AJadysbQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNRwK-0002iH-Ki; Sun, 01 Nov 2026 04:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRwJ-0002eN-7o
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:33:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNRwH-0005rG-NA
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 04:33:22 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K7QQ1320868
 for <qemu-devel@nongnu.org>; Sun, 1 Nov 2026 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vjSB4LDeJALQzuED1orO75o4jl26Cu3LHV5FBo6NDr0=; b=VcyaMjyW/18XhyKJ
 42NB+Eo+PSaq16N2g1Z/ssRxe+i+ajvayrQYDi1JmSwRTO/VRgOxoLusXbhhn8n0
 xsjzl2BfgoE8TJdFdGBHnso7Sbd08fef8nxpsE7EcW/JE4GS6GtSnyVPO+ftmfBt
 7a9kjQNXEaN0ajy0Y5xDa6816m47WOjJvTyK82+YY976tN7WzWfk/L2MHzCimgZs
 G9undzSQDPwkDX/kH1IARh4fM0e3tNiUp2+03X4Qf8Rhx7U+0IkhRWeunG9eGh1m
 vhkUHFkO7De+qtXkBbt/Ye60NBpF47H0EQPWQuvXjjBbcXlypnGBmz3NnP+AWc0/
 EpRr8A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fuchp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 09:33:20 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c0f73807eso27624746d6.0
 for <qemu-devel@nongnu.org>; Sun, 01 Nov 2026 01:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793525599; x=1794130399; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vjSB4LDeJALQzuED1orO75o4jl26Cu3LHV5FBo6NDr0=;
 b=AJadysbQ2lqy5es8xP0yTc/xUaLxDMN9J9974WxpC4SRM2RWWtRJ9Ghbxnn4U2DjSI
 N+NAmfHrha2uo9gG+nqgHM40fD2EfKZoQecUY4Qkex7SLKOJoB0QJj14yHyF3qiYKNP1
 /DcIBHhcVdlJMQX3ZcVGwWPRKgZQbDgjQ/7zYStu65vVd2l7pPwRHxWYRbMcAAMZ6JAk
 7fCpRMYDvVWXIZ9fMLJfDbZGxRM4sysapQiijcA3u9Dq3H9ZgVrMPoYvw3YTq3ri7AbY
 tsIapCRRgimK3/oljCQMODlb9J9pWXWAF5S6vSb+FUaXKc1/TD1tzpoa8WbEBiTEcKLP
 gJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525599; x=1794130399;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vjSB4LDeJALQzuED1orO75o4jl26Cu3LHV5FBo6NDr0=;
 b=RID802DU4J7s9EDace6gUD227dGcU9Y0fJLVAsVQIYWaWEF/UDM/FRK7phHM1WPl+t
 OJ7WtY0tIPQcFDmjC5hHyasdu4depV3UjnZO1SHS4/wslrb45eSKY3PVqrIWt9ekyGl5
 UpTsv7dSkhBRtkyqC2heJkBX/eoPa07YZPFAscUKkMzswx7kTNZN+gacJ1O9NlGMyzvZ
 gHbo08d5xmmCMZ0eK1RVJJQ2bNsb8eDahfOmtp5AKWR+tCWn/8xfbiXfhTO0pkuV7v7r
 hOtd0cdZ/YNPlCbVjjBlGUY7hq8G/VeU9Eq1KsjGk75u9H/SOSkTwaKwmQ43Mhljnt3/
 HGyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtzy/KWxy0AKEzsiyH+ZOA2EhcNdNGefVvrdqyZI6hPrlYq/Q1YEhQ+lM4HBAR0Przi9dqpudaFuOk@nongnu.org
X-Gm-Message-State: APuU4Z8drn7Md1qYO9daVuDr1K0kZYbcsJYj4Cdb3B03O75zB2x5n68L
 F/YtBpnsN5clKn098igFYEUipl6z8ZqwKmFiUFKxhpCEhcsJwlnGWonYDGasuURCDwfuTCdHZKF
 YMu5cx/dQ3v/r86eUYwy2RGMMFdKGAu41/OFOKKBjc9yTKIkIMmd8TxYfRA==
X-Gm-Gg: AYBFou1PT1DDuKnwZJu/Q0MxvFYWz2lLIyxfrjDije7Z1AQIM4qErej2PQE/qUehPk3
 WfTEiyXR6ZHzdSW74ZbjWGbJygCGJ58+E1yGRq28HkhGPboxK0L8vVYHKcL7o0ftKJJ0tErqEgP
 2TpXI6OCYH1UzDL+Iq417eWDvvy28hgdsaf5aq2h9cRj/W5bDTGzdi1Nv7ySTlQheGmw7eYtycL
 g0QAc8xXU3F4J3J4oRBjM2+OvQvLzG5if8R/tL8A1KP1CYVlBDV+unb0uyVUvH40Fo+Om3nfsLA
 mRuwbQXTKd9/9DxXmi26rH/65lsCDLFzGus/oEbLQ10z3YnSgxabcFflJvyLaZmwiyEqOkGm3E+
 cw/ktXiFWYZchJ2UpAY77gRQvMN4YVfAkFhtyjfUjRY9bc/Lhk14E6FlZP9FGMsNSiqc/MZprPu
 OnoYEyeHI+
X-Received: by 2002:a05:6214:cc5:b0:917:8783:341 with SMTP id
 6a1803df08f44-91ca4b9a559mr103086966d6.45.1793525599072; 
 Sun, 01 Nov 2026 01:33:19 -0800 (PST)
X-Received: by 2002:a05:6214:cc5:b0:917:8783:341 with SMTP id
 6a1803df08f44-91ca4b9a559mr103086786d6.45.1793525598563; 
 Sun, 01 Nov 2026 01:33:18 -0800 (PST)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7f4767asm62614196d6.21.2026.11.01.01.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 01:33:18 -0800 (PST)
Message-ID: <2dc56262-8580-4612-9c80-8aff6cf56078@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 06:33:14 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/27] hw/riscv: pfsoc: Enable 64-bit SDHCI system bus
 support
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Conor Dooley <conor@kernel.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org
References: <20261014012323.322790-1-bin.meng@processmission.com>
 <20261014012323.322790-14-bin.meng@processmission.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261014012323.322790-14-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfXwOWLMW5Cl+9L
 NGO2In8MntrhF+5RoDZC4H2sj0JMAB/ZS/Mp/w9656xauUuHOXw74ufyKbdObobttQhLl1Ptppg
 A/kmymCybaPWQ5EGGg0jAIdjDXEy+9Q=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae70760 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FRSEYCzRAAAA:8 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=X6nEVRAShBcqs7oysRMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=H4N_Y-AU75W7NKDNhZlT:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-GUID: bdBhqGoSDKkQuM6U22XnYfa1tf4flxnU
X-Proofpoint-ORIG-GUID: bdBhqGoSDKkQuM6U22XnYfa1tf4flxnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDAzNyBTYWx0ZWRfX7b5ifU5PsJaK
 JaAtNSAqnl4sVc9iZlw/zGLNYyJSTwolS1EQUoe61lLgADmb+4v7w/7vvbJsA16/wYW33gcj+82
 i1JPTegNVRaxzMNFVvvdkODoVaLSXqdYN01rrl/ZWCE+1ld5tBBApM83tDJvPMUJTeS99RLRCM2
 D+KcY7Wd+MLdirww5cGXgrQ9uQUGzX2zSTPYblqPOeZxU86Nq9WLdy+b1cp5Eo9ryAnfo6GPczF
 9EoXr36xE/WapYn9pM+hPMfbL/MxQK+L/iiIgl7V6SquJlMpd63kz51ltjD0MzhI2DVz/WOHcL9
 r7iPLCmcrkp/zOn+QZeqTjKyveG0n3WlSoO6+OjowjkxHcRpo34+ow8rM5OyDkmYUhHKvB6kZFS
 AK6UcwkGXcXTV06BJ9oHiItfrANQp0lwEW5aVtxLE9FPLuFEvtm6Ng0l9FLCwzyur/4o8Uj8guV
 yFf9Y1BZYEoTRXDJDGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010037
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/13/2026 10:22 PM, Bin Meng wrote:
> PolarFire SoC software selects 64-bit ADMA descriptors for the Cadence
> SDHCI controller. The controller supports those descriptors, but the
> Cadence property remains disabled by default for other integrations.
> 
> Enable the bus64bit property from the PolarFire SoC so the generic
> SDHCI descriptor engine can execute 64-bit ADMA transfers.
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> Tested-by: Conor Dooley <conor.dooley@microchip.com>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> 
> (no changes since v2)
> 
> Changes in v2:
> - New
> 
>   hw/riscv/microchip_pfsoc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index d0d8c8f84c..3d1b3246db 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -193,6 +193,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>   
>       object_initialize_child(obj, "sd-controller", &s->sdhci,
>                               TYPE_CADENCE_SDHCI);
> +    object_property_set_bool(OBJECT(&s->sdhci), "bus64bit", true,
> +                             &error_abort);
>   
>       object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
>   }


