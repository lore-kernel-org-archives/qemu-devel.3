Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B80F9D0D1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 13:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCe5b-00015a-4P; Tue, 14 Apr 2026 09:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCe5Y-00014s-Le
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:46:00 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCe5W-0008Ob-OS
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 09:46:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43cfd96354aso3309464f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776174356; x=1776779156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0mNkdPXxr2ePXsov8BXa9LSoBKxXyVZpicAGJJswXug=;
 b=TtWAR75feETO5mT7wetuhEPufPoYhWypjC6fjii81dGLwCo0f8BLadfxZ/I81EGNMO
 LZTU/BXZElNkI/Y+KFtixul2uYqunHt48hobi5USl7hAPUlnVI+JT28rEP48/fRIhAed
 CXhJ9jZWLSjturfLGLr05cWlZwfT6Two/mDsoRu9+uMnpgeeUVdrfs/HW7+K+XSdL2s0
 uepVWrY4hJWcecD5KOq9g5Vo+GVMVk6D0h8mk8U3mPtcfpzjvzxzbuYccvwjeS2mrwyC
 gvGCkzJSlsq1SfBL9J0GS1qMT/fZQ/yUG8faMCNFKvpLg7of3n+0N9VuodzOd4wZExhj
 Y5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776174356; x=1776779156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0mNkdPXxr2ePXsov8BXa9LSoBKxXyVZpicAGJJswXug=;
 b=KnlWb1muTIWTdRrQ1VPUGrr9+Dy4p1QA/6yYCZQ7RLYC0o5sfARHD+wzbJIr1k68sB
 I4d9/Kwrpr9apgFSYutFqmi4rjYfGM3LZke86nVnVgBJyWv6/TLvjN9hEg/AsYPJKF6/
 /Tn2Bz9gSJ4d0tsGqOtp+D70B7UdxJ9cRMq7DU5Bg7I456h/xuygEg9QTeGI0BBX/ooM
 lWDdsKA5dcIkG47TS9KB/AsFI0rBmSmkQy0lM0maZ3tdzJ2Lj553MbfwtxzjVd7LhImc
 oH9isQBNs3lv7EmWVNl0smO/rcNVU1GRJhqubEMV7nPHtu40d7A19ssKV9I/boI246IX
 /xTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4xmmILTGjsWJWoIRM3kYB3i0ZXrVjHCDe9+wyVS+eQHTml6s5JkgeulrbkNDZyoXtkmLBBZke8WyQ@nongnu.org
X-Gm-Message-State: AOJu0YxRADg0XP8G0xXTYXPzqD6uPre0C10BpJgZGbT6nWImx81P4Bj6
 MZThRAp1/RV1T61DvxBnzRYbA40mL4j/GldbDEA6wx9OO1XlKNCfz2GaCNttny4XC3s=
X-Gm-Gg: AeBDieva8ZOpHRCphDQ80hYa+/ZlM/egqx+4S2uTKw0wo6zGlOODFjUjxfaCet858Zf
 LZf7rk0TAe/bIZpl+BXPiRmkFxQ92kTLZXzLYb4x3tG6bVN6miCUnPyg742UtP5deOqAEy253K+
 EDjhpMWmIB/ihYACUYMekIP/rF8D/HvpnUohP0n2BNfs2laYS2en3RzVWtkemf45lInB8UefeVG
 AfyJABL2+0jJZigId/KZmRWNK+1fv/5TQ5ugvk4kZfSCRvXlNXh8C0lsn8NCje6uyErOuf7tE1V
 Nv02vtagHwUwfc1KEo1+t/OQwmeiMurWaHGDHnqzD2USVaIZg8aT3fvu/F2W8ahCiHz1FZD/1yH
 57btl3V37eP4zypbUSiryfJaB0SoRjEwZ+D12DZCe6HrFpIx2P1qJJYSm9HEsydKpMa5ZmUiJD1
 /aY2XSdBTTZdFtDEHCXok/fodvq60DuPuieV8vn8qSWRN25mfHE9VKmqwYWGkEsf8ZFg==
X-Received: by 2002:a05:6000:1847:b0:43c:f52b:7ff6 with SMTP id
 ffacd0b85a97d-43d642c09d8mr25311030f8f.37.1776174356500; 
 Tue, 14 Apr 2026 06:45:56 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d73b44b3esm25260970f8f.13.2026.04.14.06.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 06:45:55 -0700 (PDT)
Message-ID: <4476e946-c8dd-49ab-9221-38b2bd4c2715@linaro.org>
Date: Tue, 14 Apr 2026 15:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] hw/sd/sd: Use multi-byte/block writes for block
 path
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-3-dc1cf172ee57@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204-sdcard-performance-b4-v3-3-dc1cf172ee57@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/2/26 14:22, Christian Speich wrote:
> When writing/reading blocks via WRITE/READ_MULTIPLE_BLOCK we try to
> directly pass this request down to the block layer. This can only be done
> for properly sized and aligned accesses, other access still use a bounce
> buffer but still benefit from copying as much data in one memcpy as
> possible.
> 
> RPMB is limited to the slow path using a bounce buffer.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sd.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 168 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 2c81776df316feda75f97e15cc9bbd1538f1a21c..c9cfd3620b563fbe7520cfe361e14b57cd8f7472 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1112,24 +1112,36 @@ static const VMStateDescription sd_vmstate = {
>       },
>   };
>   
> -static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
> +static void sd_blk_read_direct(SDState *sd, void* buf, uint64_t addr,

(QEMU coding style: "void *buf")

> +                               uint32_t len)
>   {
>       trace_sdcard_read_block(addr, len);
>       addr += sd_part_offset(sd);
> -    if (!sd->blk || blk_pread(sd->blk, addr, len, sd->data, 0) < 0) {
> +    if (!sd->blk || blk_pread(sd->blk, addr, len, buf, 0) < 0) {
>           fprintf(stderr, "sd_blk_read: read error on host side\n");

I'd rename sd_blk_read -> sd_blk_read_bounce_buffer (or similar) and
use sd_blk_read for the one you named sd_blk_read_direct. (Ditto write).

Patch LGTM otherwise!

>       }
>   }
>   
> -static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
> +static void sd_blk_read(SDState *sd, uint64_t addr, uint32_t len)
> +{
> +    sd_blk_read_direct(sd, sd->data, addr, len);
> +}
 > +> +static void sd_blk_write_direct(SDState *sd, const void *buf, 
uint64_t addr,
> +                                uint32_t len)
>   {
>       trace_sdcard_write_block(addr, len);
>       addr += sd_part_offset(sd);
> -    if (!sd->blk || blk_pwrite(sd->blk, addr, len, sd->data, 0) < 0) {
> +    if (!sd->blk || blk_pwrite(sd->blk, addr, len, buf, 0) < 0) {
>           fprintf(stderr, "sd_blk_write: write error on host side\n");
>       }
>   }

