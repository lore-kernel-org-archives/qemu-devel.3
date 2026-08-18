Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DB5C5DF67
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwCBL-0002pq-K8; Tue, 18 Aug 2026 01:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCBJ-0002pJ-IV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:16:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwCBH-0004nQ-Om
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:16:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67I342Lx3298981
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x6lsE4uchYxMjudcp2iKsrOqtZYJi9mKrd6usR8KqbA=; b=KEcNtzrSngScab4J
 bAkrFjVyDRRhuJbYnuCIXXFz9zJzGaHE2/RYArZ9blzakRV4MPJBTU95izBQh37m
 ftS1CiM4qv1akA0upiDm8nrasjqfx+qynCCdR1YmfsR/Bj79Y+Qf1WyGQMSubtQO
 GsZQY8VTd6S0y+27fsRJ+h9ruXcvmnSD2Xceulpx2W/tn01wO+GgjDEOh2IzwTev
 K5HrgXQNjBokFBN0Vs7GVUDHVlyhVLIgsLyXA1rQttNG8rbL57hUuhrBJRYNTTcu
 oFE21vD2BFxJ2DpiZHsklcgESzdq0Y2YkBBTx/Yjofrb6QHbH7KiHs1UG8lSmZIP
 HafLWg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4f5prftv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 05:16:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936708f129aso340371685a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787030169; x=1787634969; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x6lsE4uchYxMjudcp2iKsrOqtZYJi9mKrd6usR8KqbA=;
 b=Te+Dlr6k+bUMqM25UqoZU/oKQzq1AyUj3EzQQH8XuVDEJQHgiy6a6KohlRw5Wo5Je7
 bhpivNkGLffhMo/tmv8A+krnlp5xU4gef3S38JxTys6EQhRZoQ14VfL5te5QBPD5dO+M
 tRYXlp7gXUlJ3ttbSxEH62BNqLulwJ25KRXiGdBRxTnEfLxe6C6pX8LFARCyO8pnKY+J
 XqnKnvG9z7VHknm97C9PMnIVUgb+wtGTenGu8CmplK3JSL3a5M3s9MIz4r/pKN0MH2RM
 aiGe+gr+ubcUQhlgUb6PA4j9BaZfJQJd+gdyeigGq8FY24GU4SVf6IkGNPalAAoXJN8E
 yy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787030169; x=1787634969;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x6lsE4uchYxMjudcp2iKsrOqtZYJi9mKrd6usR8KqbA=;
 b=PPwWbH5NV8LbzbPAc+pSF15KH0IuNiEbUSNfE+q2cVGeNCVGg59TCqlVnD/xBeTpUc
 ynlbjCtqfmXSPdJymgTllaWvrQ+2VlYwiwXTkw7cShw2WR3HoHI8AFEtC1XS3CHKXcZ5
 wCV8Gvlw4+owF6im75bkzOmYmmS1YwW4Vb16eBPQ70P4uCdcv4LeoKegicA22lr+6BIm
 /f55HmzS0bP9Fuha51OCzaNp2sQCrxVCUZrrpBU2Y3Eyl6MUrQRYL7x3iofLo8kAM4pC
 vk4xfFeFeJ+RtdEhjHR7V1+amh0V7iXYmaoyaOv34gRYdwPJc4wbim3Op1okWWjWoGM7
 T01w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0s0WJlIj0Xb/NDU7zmnWOeuSnolmAV7SgfZHJj/WpAF0f/ZdwHrxgxXZKKbbKtZFXL6X7vU6TQOOX@nongnu.org
X-Gm-Message-State: AOJu0Yy/IdcurR28A44PSQoxUib7xdQmgEs6YU2njr03UobdocF/Zwcp
 88vMVglcgKW6SO4mjZTYux+qEcvJB4YxvyKi2eJIP8jeWJf1xeWIafShGs+WSNfFb0WTFd4wzZp
 QFbEIv7arxaO0oKU9TiBz60zxcEgh3dpBAHkfbpL60l8BxmEWgTItOi6RDA==
X-Gm-Gg: AR+sD12daphrIW+a4d2FYYDJajb13jbbcRRYGcIQXNydV6hvY006khj/FODLK7iV7/J
 QQu98F2OZ+9oIlYXQdx7Uk4pQth5UrgM6UxJ8aGBFqQIF93vMLRY4NjI1fhdbH0xPluvCZ+4nYb
 3xstHx6+BlF6sMHcHPQ15V/yJK63uDI1yWpNtigxN3Xlspygi+DPcYYJ6G/DE53LPeLQfLEjpd8
 le6Q4B/R/ZTY+Kd9DF5pgLPkPoesHqIhCAMih3G9blz2sHs/GVl/TfHQmyFTKuC471656nWQSgP
 7/crDqHQzpGyBtQHlrXFu+IteXkV3fyaCJZASb2M4WfLpBrCDmtqaJY2tDbxilN/ArJnBDorZqm
 HQCW8P9kBllpU0sdfngdIfQxbmW5VuFYkfek=
X-Received: by 2002:a05:620a:7114:b0:934:9524:2e89 with SMTP id
 af79cd13be357-93704b12e59mr519894085a.13.1787030168938; 
 Mon, 17 Aug 2026 22:16:08 -0700 (PDT)
X-Received: by 2002:a05:620a:7114:b0:934:9524:2e89 with SMTP id
 af79cd13be357-93704b12e59mr519891585a.13.1787030168505; 
 Mon, 17 Aug 2026 22:16:08 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b660sm9036744f8f.15.2026.08.17.22.16.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 22:16:07 -0700 (PDT)
Message-ID: <25744bee-b2da-4430-9c03-e2272cec33d3@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 07:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/15] hw/ide: report the default CHS translation in
 IDENTIFY DEVICE
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260817205242.1199851-1-den@openvz.org>
 <20260817205242.1199851-6-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260817205242.1199851-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S+/pBosP c=1 sm=1 tr=0 ts=6a83ea99 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=6rqHouBjAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=zXmn7Lei_6h_rgYG5H4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Hx1yvPaMooE3kwe23bt7:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: EgFkyJAh1fTPHSsmLzzse-N5YUDBC1V7
X-Proofpoint-ORIG-GUID: EgFkyJAh1fTPHSsmLzzse-N5YUDBC1V7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX3q0IZJfiV07O
 trwnHn/A96u2xpeu4RKu6swz5b19TcXYIlpOYNMQvaoyOT03uYfi8OnzIU6x3uEmDxtQRmP9D/C
 iT3X2htQKKNa94DNkPQXnCCIqLsA8Fb2eRACD/tqFxR0tdfx8/krZpXceShodL5xamclHGM8+Oh
 1Kd+VPbw4xNw6+w8996Aatz/s9HJGiqUP91WuxwkqvAwcKsKb5YOiOW5N4XuoRcci6NypeKvj1r
 VRDbUNT5h+OtD0tHSAZTAzugPO0CwGlnu5tXYfOqRb5pYh+56nJHxJ2b22PleuMOpM0gb/nT8RM
 fthOTE+nslfK+XvhEMHRnUiB31CKHd07iUme83LuFJhgJd1iYU5hflXv4frr/59xOysRTVbG2Xv
 OWP2OLn8jroNaV/Cja9XUTRHJYs1q1qZdVTsKlGSbwEPZG7jdLllDVP3VPLyqVOJDCC/bWVS08Q
 61t5bWUi3uxfgKQ37/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzNiBTYWx0ZWRfX6y6CyjJpd674
 RKFURNE58y7aRj1GubuVBAhgldSBePkfPSl2BnkNLytQXQU+DfAv0XqReg00Qp6TcYrn9+tJ039
 YbodrSNPIUFiMJ8kZTvDqa4C40+o5WU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180036
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

On 17/8/26 22:52, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> IDENTIFY DEVICE words 1, 3 and 6 describe the default CHS translation,
> and ATA-5 8.16.8 requires INITIALIZE DEVICE PARAMETERS to leave them
> alone; the translation in effect is described by words 54 to 56 instead.
> Words 3 and 6 were filled from s->heads and s->sectors, which the command
> replaces, so a guest that selected a translation of its own was told that
> its choice was what the drive came with, and could no longer find out the
> default. Word 1 is already right, as no command changes s->cylinders.
> 
> Report s->drive_heads and s->drive_sectors, which ide_init_drive() keeps
> for exactly this, along with the retired word 4 derived from them. The
> CompactFlash data labels those words as the default geometry too, and
> INITIALIZE DEVICE PARAMETERS is accepted for CFA drives, so fix both.
Cc: qemu-stable@nongnu.org

> Cc: John Snow <jsnow@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 176e4961bb33 ("hw/ide/core.c: Implement ATA INITIALIZE_DEVICE_PARAMETERS command")
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   hw/ide/core.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 747fa71677..befbab9486 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -138,11 +138,12 @@ static void ide_identify(IDEState *s)
>       memset(p, 0, sizeof(s->identify_data));
>   
>       put_le16(p + 0, 0x0040);
> +    /* Words 1, 3 and 6 describe the default translation (ATA-5 8.16.8) */
>       put_le16(p + 1, s->cylinders);
> -    put_le16(p + 3, s->heads);
> -    put_le16(p + 4, 512 * s->sectors); /* XXX: retired, remove ? */
> +    put_le16(p + 3, s->drive_heads);
> +    put_le16(p + 4, 512 * s->drive_sectors); /* XXX: retired, remove ? */

If we are deliberately keeping this, can we update the XXX comment?
Otherwise LGTM:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>       put_le16(p + 5, 512); /* XXX: retired, remove ? */
> -    put_le16(p + 6, s->sectors);
> +    put_le16(p + 6, s->drive_sectors);
>       padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */
>       put_le16(p + 20, 3); /* XXX: retired, remove ? */
>       put_le16(p + 21, 512); /* cache size in sectors */
> @@ -332,8 +333,8 @@ static void ide_cfata_identify(IDEState *s)
>   
>       put_le16(p + 0, 0x848a);                    /* CF Storage Card signature */
>       put_le16(p + 1, s->cylinders);              /* Default cylinders */
> -    put_le16(p + 3, s->heads);                  /* Default heads */
> -    put_le16(p + 6, s->sectors);                /* Default sectors per track */
> +    put_le16(p + 3, s->drive_heads);            /* Default heads */
> +    put_le16(p + 6, s->drive_sectors);          /* Default sectors per track */
>       /* *(p + 7) := nb_sectors >> 16 -- see ide_cfata_identify_size */
>       /* *(p + 8) := nb_sectors       -- see ide_cfata_identify_size */
>       padstr((char *)(p + 10), s->drive_serial_str, 20); /* serial number */


