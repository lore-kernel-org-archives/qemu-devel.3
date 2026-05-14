Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F872CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 10:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNSzg-0001OQ-Sp; Thu, 14 May 2026 06:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSzV-0001Ib-8I
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:08:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNSzT-0005N4-9f
 for qemu-devel@nongnu.org; Thu, 14 May 2026 06:08:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso48487725e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778753305; x=1779358105; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yIMRvXftjREaWbFIdvg/u3BbsXe4sqM2d4+VfxhqnHg=;
 b=QlZoeiOeeLyzuMVjddyvJ2ujbXylvRBrspg9Ph7K/UA+oHlo1l15JvQtOJyME46xjA
 KGxZ9kczJ6zJ1qcPDKyfc41kYlTDHvkU5y9F6N9mCR5j3cvgiyZ1XkE+ux1WuZXOTn7J
 V15IHE5zZcy7W9LMRA3MGl9TFBjDVfA/QVXApLeL0xCKIHSegiQ4fQZbB13exST7xJ7R
 yvxipTZD05kI65LPHGG/LmQym/0WLIEFRkzyYCCYgJgrd4YD3eQv2w33dt/6RiA+PjsJ
 FHRT58c/cV4djqIlh7F8iPW4SSw1qSbigaz/LpHZ/VpJ99UPrfRNJMrbp9Mm2PotjTOL
 MyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778753305; x=1779358105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yIMRvXftjREaWbFIdvg/u3BbsXe4sqM2d4+VfxhqnHg=;
 b=gWU4cPe0i5ywAm/d9eReuPhZOkcgDq4tB7R+Cp/y0bv4m3FZQbbHfY5M4Gm804MVrM
 9VUf1rWtHAhuKQbb4L6lRSbKlfzpmfR1RxL8WXcCG9PbqJczKir0JG3AxQbwDNLv0nUs
 U1PcxqYC0WQc7PPqwf08ePDnAVQsoKI6k+Gj7BAoeBQ24uwq12euXnJZ7N/CzWD/GGDs
 lOoRAy9aE2NOJx+255OCfBuAaWAUao6EIUqJZcR51OM5pK9Btsyeb5waj/ghML4H85s+
 NHtO3KYTpC+I+kwT6q6X2ONyU3GUW/dvg9EYteSpUtowHJy6kaXmskp5N0LFVwl+Ec7k
 Sjpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/O4C8JmI0K4J3mtu2NutKvogd6S/hTpR53kT3eXhwk1WBUbVfosqhxNyHqWN4SsceZu9dBksKLiN01@nongnu.org
X-Gm-Message-State: AOJu0YyYSFRWS8RkbW2FsUz93J9nVeVsRPp7cxjE/Guze+smMo3NwEZE
 WnBA5kZrXNTsHq/GscI0LHAGEbHL4ws/F44QVIzrpoupZq3lmaXxzwvcrjL8VsJwUWw=
X-Gm-Gg: Acq92OFE1LRxsWMqrG3/nX0vvhd5ruqGT2kzNUA2Ciwu8qIFiQG3uh6cLolFf3pJ3XK
 ef8sDLhVEu6NOXRGB3a+DAcFEcQom4c93jRsOgHFsETH3ZQPEllBsc1mQjV4NTwYgtvBKsfrynW
 mFU2elBbjKO+9qgun71JWKc62kJTZ3Io3bV21CjyVFFxU8OUiIsYSA7IWG1nHbLxnA9jmlSkqRy
 rA7loHQVQz90jz9Z8pC+tHaNAQ2qUaj0M0yVLO00ayYzbLGYCAn3FTXftr7TCblSZiL7LpfVj14
 NNZobP6hjapdvZgYKNYoxA3XPQHEQEJ/bZ3pwP3ptf0o4cs2+Ftu64lZIG1U1TSsN5DalKg4Dwl
 E8Oet9uqz486yRXh9rpKK5Bf7EJqkowdumvJSB7M4Us8OZEz7TzVzdjfErCnk7ky19zKSuKzpDi
 rSc5P6l3FpksnnDrra+2OqcSitCId80DEGg/bOBXkkFytMkGbo1zBGPqbYzik0l3sKcQ==
X-Received: by 2002:a05:600c:8b2b:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48fc9a4db09mr116071305e9.29.1778753305370; 
 Thu, 14 May 2026 03:08:25 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64a22a9sm56555645e9.8.2026.05.14.03.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 03:08:24 -0700 (PDT)
Message-ID: <931c9f86-0dd6-4b59-a8df-db1f5b69b83a@linaro.org>
Date: Thu, 14 May 2026 12:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/35] target/mips: add Octeon SAAD instruction
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
 <20260511-mips-octeon-missing-insns-v2-v6-12-5062889c4d3c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-12-5062889c4d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 11/5/26 20:22, James Hilliard wrote:
> SAAD is the doubleword form of SAA: it atomically adds rt to the
> naturally aligned 64-bit doubleword at base and discards the old memory
> value.
> 
> Route it through the common SAA/SAAD translator so the MemOp selects the
> aligned doubleword transaction size.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split SAAD out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> 
> Changes v3 -> v4:
>    - Note that SAAD shares the Octeon+ gated SAA translator path.
> 
> Changes v4 -> v5:
>    - Drop the Octeon+ gated wording/path and keep SAAD under the existing
>      Octeon feature bucket.
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index d6b241de42..d77717cd50 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
>   &saa         base rt
>   @saa         ...... base:5 rt:5 ................ &saa
>   SAA          011100 ..... ..... 00000 00000 011000 @saa
> +SAAD         011100 ..... ..... 00000 00000 011001 @saa
>   
>   &lx          base index rd
>   @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index 441d71d57b..daeaf07072 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
>   }
>   
>   TRANS(SAA,  trans_saa, MO_UL);
> +TRANS(SAAD, trans_saa, MO_UQ);

Ditto previous patch: s/MO_UQ/MO_64/.

>   TRANS(LBX,  trans_lx, MO_SB);
>   TRANS(LBUX, trans_lx, MO_UB);
>   TRANS(LHX,  trans_lx, MO_SW);
> 


