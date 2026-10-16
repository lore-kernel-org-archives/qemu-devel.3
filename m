Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40586CCF2C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 20:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHoU8-0005aG-BS; Fri, 16 Oct 2026 16:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoU5-0005a1-TA
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:24:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHoU3-0000FR-EQ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 16:24:57 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GJesO53637075
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RolsD56YuzIxs/AMdsyb9pJDGy4hT7UBIDFXOn9U+NU=; b=FhDMXnP23BSXlLDn
 qQIr3nRUju/+pY1C7XUfweUUvjLSUOg3niBG8aCL1gcMLxFI4YuiPdxpxRIom9s/
 mQAIh9twYwe50Gr4T9skUbB2iNZJbn6HFRvckAmD2BCr8LPcDK6+/rp5HHSYXWSp
 YuJpTJk6GjqHymVf5zfxB7/G+uYGGGQcybtoYp86bO97HB+92WUxypqk1RLWwkfQ
 KK8ZYW97bl37qBOR6N5r7Kn0d1zqgM8zIrfQyXMhvO/3w/pFYy2N83kNr6X68gso
 L8DCq7gI1g6Htq4m97JbX94n2j4Z1kf2KOebPCXJ4HBeGuEkddBVjnnwcZPugzD4
 +qfpiQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbmmq1k1n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 20:24:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91bc57d4d11so7922166d6.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 13:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792182293; x=1792787093; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RolsD56YuzIxs/AMdsyb9pJDGy4hT7UBIDFXOn9U+NU=;
 b=diAnkVu9sK2HtL1Ociq29SXp/C0AodMaQZi2lVUx75uLB8+eonDrUB51Rto0Ql+K0u
 3B/eGTLgsD1B8NNxxNTZhrPZp/DbUFOWVzqI8pcXd1UhR8loyzyIS4TYzz4RyaDqRelP
 P1HmDOyetEneufx13wcgRFrZ5XRpmy1vy6nVPxfpfKSgUkl8BMtqMWGLKtNwtiByF7Bh
 YexAAep77Z1x06nkfgUU6CAddZYIphgZcdPw51OVcyobP+t0kqT47/VQUZEnJuahpF1d
 vTY2QHBuffkkzv8cSdPm73/uG/fNs8rxnRymVmJeWfoL6kO2XOX/H/83gl30TVcG/mfm
 jlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792182293; x=1792787093;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RolsD56YuzIxs/AMdsyb9pJDGy4hT7UBIDFXOn9U+NU=;
 b=dP5f7RrmsPMxceHSm5UAw0ACUFJZSxHKL3W9l6LtSUFFuG2vZcymENPUUKWXupzbGx
 BUF/yfv7CKFa1w/NN6A2jNyWdxCoK1Hfatww7HlGVyoikYmNzY/IuhD4VeqcCICdHR+3
 5bBPmoil4H6E7ymCzyvgNwj8ZShjtWKorgXTgOX8ifnM9Mj0eDxRCQ+bgeE4k76fKEV0
 TC6gZ1Mj49aPaoF4LlnQdtoZi4VFjjtHbpqiUWLW0ToGZ5FoAgGhWY84pKUAtwdbG5wi
 SSk2W2BEEH2i/9VKxXZ//nstgipQl461zTtEawicPmc1idC7pQgWB9ARy+Nnzr33qJWb
 yezw==
X-Forwarded-Encrypted: i=1;
 AKwUvBymBPROr/Nx/sF9F6pvgVf8ho1bMB8Kf5zgdcRQsAlx8iH+foXPwWMGKWg479XAx+/HO2mht3v9EJwp@nongnu.org
X-Gm-Message-State: AFq9FYIaon6rwINLs0VJZtSdiPQ9vL8NngzOjvlC00R6Lp7U8X9mcb1s
 c/ja4TMYc8P+OVAXpgozQCRjAJJ/XnSTIOQnqI/jZOOT/ZPXNa0+yBeLXsHmd01BaX4YVnDy9Fn
 EumqB5rS7mgGUTm3IXEP73+TC+hZ12UoboKYDzr4xy7JiRO899HUhCsO0vg==
X-Gm-Gg: AYBFou0k/rAf4HZo020Ou+KkJrY8L+M82j+4BJji3ZkHit2VbfzvkJr+G5acQ8L3wnK
 C03cdH+g6Gt3OMLrsbMaouHVoe4gmQH0HFGv7uOokUpWmr8dRfz5EmoaAOFwoCT3ZaYXH5fiW0d
 ccOvDw2VH8ZeDZfMZ6lGWCZhHLaGSQsQdmnAKZrz/viop6W3E0ufRWVGmZoNvXE+jGqTvW/xVVF
 gSlZat5W/lwh2qWaIw7Oi7dE4QZWYq8MtdaF7Tc1BAUPgkelCYgfcO64sDq85gp+mj3ZJs8w9j5
 IrZ2/OXidJXzknqufkI0EQqbnw5i7yVfrY+BZP/292WgIovg1GHOB/7zrmOFM2Dlxkq/ouMMfBq
 HBet1NjuvW09fI4YmuCBuS5fawuzWRrZAmnA=
X-Received: by 2002:a05:6214:5002:b0:91b:8025:6827 with SMTP id
 6a1803df08f44-91bdf0e6631mr20028476d6.21.1792182293433; 
 Fri, 16 Oct 2026 13:24:53 -0700 (PDT)
X-Received: by 2002:a05:6214:5002:b0:91b:8025:6827 with SMTP id
 6a1803df08f44-91bdf0e6631mr20028036d6.21.1792182292987; 
 Fri, 16 Oct 2026 13:24:52 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bd13f4b89sm24245466d6.34.2026.10.16.13.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 13:24:52 -0700 (PDT)
Message-ID: <454610b4-d78b-487d-bcb6-1aee60ab0216@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 17:24:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target-info: add target_base_riscv
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>
References: <20261016182751.264704-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016182751.264704-5-pierrick.bouvier@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261016182751.264704-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX7ig6XKKRzX2w
 79QztOrabCTMSdIHpBQlr7x74yAJptzhltTyG1YBk1fiQ6iyutTW901Ubg4fbu5PnvJiB9Y3Iy/
 MRjufWudPjicuVhQ29cgPXjF1a5bMn0=
X-Authority-Analysis: v=2.4 cv=P9uvFSAu c=1 sm=1 tr=0 ts=6ad28816 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=diCWU8RCQUWoiRqdljYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA4MSBTYWx0ZWRfX4u4NtgIkkwBn
 21vbCTSruLGCeDZaqkkwNUi1bpMOAJUi8xrq0EQ20PCRJKU3kxxNem2PzeMhol4vzPI6PWy/Bet
 rZWvcgwPIMLl2Ouy5QrXBmyOcEOBGAGLxNGaiyhYF9vZU7pXlrsQFREdMynKK1FGTDcjwDEYR9K
 G7R0H+/7OOroAsKdXIMuGHLQ+i3uah2B04PpAFfq8P3ZwbGHQgh4OeZGODreoTtXW/Pr+Tg7TPO
 eqSEdcDSPnBJil1vneMro37od8hjKMzYJW3XLcehnG8D4dT7X/vw0/JPxKhw+ksi7jH5z9NoRQw
 E0gEvru5KeFxzlG3hxK9VaP+9rwteCpIkOS0CnMi9dAzGJgAwQovMJGatfkQ9uFOyXlFvvkqC/Q
 43A2qgSXkE9AHVdyqBgkeJDqwcpW8PQpyaN6wys2feqbLJ/9LhW0Su2e24/RiBfd9aZTl/yc66W
 2FXDNbTQxAPlTKADsDA==
X-Proofpoint-GUID: RIAdp1eTnnV9dEvoTshEYHGTVxtoEFOs
X-Proofpoint-ORIG-GUID: RIAdp1eTnnV9dEvoTshEYHGTVxtoEFOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 10/16/2026 3:27 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/qemu/target-info.h |  7 +++++++
>   target-info.c              | 11 +++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 862097c6c63..b0f3b4cfb8b 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -112,6 +112,13 @@ bool target_ppc64(void);
>    */
>   bool target_s390x(void);
>   
> +/**
> + * target_base_riscv:
> + *
> + * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
> + */
> +bool target_base_riscv(void);
> +
>   /**
>    * target_riscv64:
>    *
> diff --git a/target-info.c b/target-info.c
> index 254530d8ea5..e827026bd23 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -104,6 +104,17 @@ bool target_s390x(void)
>       return target_arch() == SYS_EMU_TARGET_S390X;
>   }
>   
> +bool target_base_riscv(void)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_RISCV32:
> +    case SYS_EMU_TARGET_RISCV64:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>   bool target_riscv64(void)
>   {
>       return target_arch() == SYS_EMU_TARGET_RISCV64;


