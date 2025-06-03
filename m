Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A28C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 11:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMPcX-0006Pb-Ft; Tue, 03 Jun 2025 07:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPcW-0006J7-53
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:15:52 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMPcT-0004OR-Ui
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 07:15:51 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso55188015e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748949348; x=1749554148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Moj9sLMMT/Uxf3iJ02si+007HqfklfHY4MMSiRMjvk8=;
 b=F8SRXVwW3mgMett5O2MOvSo1EZJkj29qwdkPlwFbBETezMt6DYNPTefyCWPHEbL41n
 uDAczFa7gxjJNezVelOgBanZ7mDqlO0+Qzh5N3f7mZWNaOhS6ogZgVzLy0mHw0JYZcH3
 04wGSgFXChc4jIlC6L1rKt4aAdxKiCd/89qZAZqlteQcboZbVYk81jNJhZZm3X96j+iq
 IHPqmnsABhSUxluyY+frJR6V6FESeQaBgKwGvb1lOILORq9CjF/zBawii7E29QgdJX8u
 0in9pG8OgcTMjiOfvDbKH8SiES+lgBQwlWHG7fHrLHZE5zHpKecuI/Bc/wV0XejuFmic
 sNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748949348; x=1749554148;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Moj9sLMMT/Uxf3iJ02si+007HqfklfHY4MMSiRMjvk8=;
 b=bJQfYKzw30q/qITiBw/ogpWgyODo09zgoIXuSce20VtzRZ+ypJnEoFiaaQWtUAXtww
 K5IkBEzcS6b680UVkpEM+Zr3FtgrinSS31eA7M5spwbjB2nnjjzjsmGwMFitaL78yykR
 5NItbzAbo7WBm1T7F76kQq61hC8R49+NAUPqnDNAUvsOLmXy72i9kJyM/conCxqwGOll
 TQgjUzWGfZi5hVUdOSemfmzkdiRWo645wTEC1d6zNKqCgDs4Jn2abc4eJqZIPFkWOAIs
 P0K6nNLu4N7kZUSNpCvoU5Bxl6vaWH74xesea2QJCzdDuO1z7NAVon7g+PWveGe0yihA
 rIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNcou31loiFfAtT1f+BZSBw+QH106KeDLEsxsfCzmSi2y53V0U1Rxmf04tZlzdXidyrpdhvhrrC+Hv@nongnu.org
X-Gm-Message-State: AOJu0Yy/t4P+1xbpGPle3qDOs5RSJn08PcdF/pFNiEdVDG00uvctbHYZ
 1Vp8rOUSPCZuNask6eUdcshl/W6BSIqhx107zHouJ2lLJVpRS4V8bDmbVkZKhA6g9WI=
X-Gm-Gg: ASbGncsCLYqxtxvL+zEfxIFBJvCAkqtQ+pE6A/Ao0alc9kVlzzw1GvN97IMLp9RPI/4
 qJDnWDPYB5wgosZaxrTdZmvB+5PNS7bjUJh9JuebAEpiHfHT5hIPhXw2Fqll3TSxLaVHuXDzr7p
 ModzluprlfBlLxdkKESiHA3peWb4Nd1Ngmr/lQzyJ66X2JwS5ZlkWPOV4IEe1YMDtPQs18QZUTY
 PT/XJPJkvOzugHBdsPG39Dsr+atECiCZh5SSvoXYiQX40KJjpZsfMOr1msT//+NOvhEN7AMpMoe
 1NABJHgXlzGFju8ZGOTwj7QKej4OWMQH4dFwzF/NxxiGZDljNYQgY2hochj/6mCwHnfptPAPCFf
 Rw9ydONIJ9f35AU2nXF2B6TOyVAkylnXHyso=
X-Google-Smtp-Source: AGHT+IHKlaEiDDUjPN/gC43fJsTiMV65JsLfqq2KZb4BvdPoznA3uSKOn28riAxc7tgR8c5CqrcOCA==
X-Received: by 2002:a05:600c:500b:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-4511ecb9d73mr96838295e9.7.1748949348298; 
 Tue, 03 Jun 2025 04:15:48 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009752esm17913452f8f.74.2025.06.03.04.15.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 04:15:47 -0700 (PDT)
Message-ID: <5a98caec-9d24-47b5-a723-23ee60bd63b9@linaro.org>
Date: Tue, 3 Jun 2025 13:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] target/loongarch: fix vldi/xvldi raise wrong error
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Cc: maobibo@loongson.cn, lorenz.hetterich@cispa.de, qemu-stable@nongnu.org
References: <20250603082510.353876-1-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250603082510.353876-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/6/25 10:25, Song Gao wrote:
> on qemu we got an aborted error
> **
> ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Bail out! ERROR:../target/loongarch/tcg/insn_trans/trans_vec.c.inc:3574:vldi_get_value: code should not be reached
> Aborted (core dumped)
> bu on 3A600/3A5000 we got a "Illegal instruction" error.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2971
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index dff92772ad..9fb72fe914 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3465,7 +3465,7 @@ TRANS(xvmsknz_b, LASX, gen_xx, gen_helper_vmsknz_b)
>   static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>   {
>       int mode;
> -    uint64_t data, t;
> +    uint64_t data = 0, t;
>   
>       /*
>        * imm bit [11:8] is mode, mode value is 0-12.
> @@ -3568,19 +3568,27 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>               t1 = (b7 << 9) | ((1-b6) << 8) | (b6 ? 0xff : 0);
>               data = (t1 << 54) | (t0 << 48);
>           }
> -        break;

Dubious because previous 'data' would be dead...

>       default:
> -        generate_exception(ctx, EXCCODE_INE);
>           g_assert_not_reached();
> +        break;
>       }
>       return data;
>   }
>   
> +static bool check_vldi_mode(arg_vldi *a)
> +{
> +   return (a->imm >>8 & 0xf) <= 12;
> +}
>   static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
>   {
>       int sel, vece;
>       uint64_t value;
>   
> +    if (!check_vldi_mode(a)){
> +        generate_exception(ctx, EXCCODE_INE);
> +        return true;
> +    }
> +
>       if (!check_vec(ctx, oprsz)) {
>           return true;
>       }


