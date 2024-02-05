Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16D6C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 17:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2Ob-0002pD-A9; Mon, 05 Feb 2024 12:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rX2OZ-0002oj-V4
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:04:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rX2OX-0002JD-Ox
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707152672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ySbhE08hFtQ2UR9w/PYczmItGuK08ky94kE7rMgiDRQ=;
 b=EMKymS3I9CKnq6xrir/mtXe4KFUY501RQ5rCLkAn1VPG3iarxirlLhISribu9FSUAQVYAL
 P8dqdNyP45/TryV6DiDYYhwNcrl08SGDu0ikUwCa3DdDnH2KPHViFHBUpoFy5DGWXEaXv1
 /D/5VkUsf+zWDeejZ3432y+kq5k/WwI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-h3bCbWJwO4CM3GBKq0C6Pw-1; Mon, 05 Feb 2024 12:04:31 -0500
X-MC-Unique: h3bCbWJwO4CM3GBKq0C6Pw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7817253831cso624174785a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 09:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152670; x=1707757470;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ySbhE08hFtQ2UR9w/PYczmItGuK08ky94kE7rMgiDRQ=;
 b=HYextInkOJ5sjsMrN+d6MCYfb4ndPccIMVmkZrzJPFIVO1kv48BOGLzzigXn1myJ4X
 94ycXxwC6azSqu5KLSpJyN/GoNfNUABt7T0HWCqWoKlNvisTaEWtyJtw4D129oeK2ZUp
 v0B/WipVzt6pSn+0EALskKwD31vhqbBq6yydN37VEgcc/WL/KS7VE2Zm4Mory6BwL0KP
 9gg9baH4G5Xy2ksRxTlEEOr1mhqSbySFCCtBWmcVj1avdmjm/uLjnePT6eaHenzTMk/Q
 nGkMSP2jLTGlcTXUY7c8PepToI+pL2XL15GEDPNlczCycMvhvra4dkhFv1ZqBGnsNX25
 YqYA==
X-Gm-Message-State: AOJu0YyRYFP3qwxO7KIxA7ob3NRAcVUd3G1me/E2F0sBCQyuP6346LzK
 mrWiN/kuJUpgn2hkjjxFjMbJRpnbw+jhJ1l35GdOSZ0+Hmng3t5fcJko0gcFt2YINO4NQdqz+X5
 FLxtPcJoEtMtmvrLFqT1AKgaJ1WgYOp5IQySOx3d+aQbqkcbAVGR7
X-Received: by 2002:a05:620a:5d:b0:785:4599:6db9 with SMTP id
 t29-20020a05620a005d00b0078545996db9mr36798qkt.26.1707152670567; 
 Mon, 05 Feb 2024 09:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGu3Q6LtwGikL+KW4AKg4AbIW12P3VR65OcSCi12vtlvPUTRhd/iMV4RcNLXgUDp6gPauGWLw==
X-Received: by 2002:a05:620a:5d:b0:785:4599:6db9 with SMTP id
 t29-20020a05620a005d00b0078545996db9mr36771qkt.26.1707152670199; 
 Mon, 05 Feb 2024 09:04:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUUM6YPg1wUz6Bdz3RXzYqyfHulQ0j2NyuznMHf19iX++qHIrf91UZ6xwrQ3jcZufkqUTqRykxdtJSqK0q608cADtqo5hUxEESx/YY/Fh0Bjty6LUZzDxHH6j4ny/tXhL4dgs3arOwjX2BN8H0amwh6Mop6UQd/xUGbbh9W1tJKvfT44EEKJp9dUpG24oUOtQ==
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 vw6-20020a05620a564600b007839e82e148sm101652qkn.129.2024.02.05.09.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 09:04:29 -0800 (PST)
Message-ID: <8a9f3802-af41-4189-94b7-c09e5b9617d9@redhat.com>
Date: Mon, 5 Feb 2024 18:04:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] target/s390x: Emulate CVB, CVBY and CVBG
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
References: <20240202141318.95962-1-iii@linux.ibm.com>
 <20240202141318.95962-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240202141318.95962-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 02/02/2024 15.11, Ilya Leoshkevich wrote:
> Convert to Binary - counterparts of the already implemented Convert
> to Decimal (CVD*) instructions.
> Example from the Principles of Operation: 25594C becomes 63FA.
> 
> Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/helper.h            |  2 +
>   target/s390x/tcg/insn-data.h.inc |  4 ++
>   target/s390x/tcg/int_helper.c    | 72 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/translate.c     | 16 +++++++
>   4 files changed, 94 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 332a9a9c632..cc1c20e9e3f 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -88,6 +88,8 @@ DEF_HELPER_FLAGS_3(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i128, i64)
>   DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
> +DEF_HELPER_3(cvb, void, env, i32, i64)
> +DEF_HELPER_FLAGS_2(cvbg, TCG_CALL_NO_WG, i64, env, i128)
>   DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
>   DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
>   DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index 388dcb8dbbc..e7d61cdec28 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -293,6 +293,10 @@
>       D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_16u, 0, 0, ct, 0, 1)
>       D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_16u, 0, 0, ct, 0, 1)
>   
> +/* CONVERT TO BINARY */
> +    C(0x4f00, CVB,     RX_a,  Z,   la2, 0, 0, 0, cvb, 0)
> +    C(0xe306, CVBY,    RXY_a, LD,  la2, 0, 0, 0, cvb, 0)
> +    C(0xe30e, CVBG,    RXY_a, Z,   la2, 0, r1, 0, cvbg, 0)
>   /* CONVERT TO DECIMAL */
>       C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
>       C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
> diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
> index 121e3006a65..17974375e98 100644
> --- a/target/s390x/tcg/int_helper.c
> +++ b/target/s390x/tcg/int_helper.c
> @@ -25,6 +25,7 @@
>   #include "exec/exec-all.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
> +#include "exec/cpu_ldst.h"
>   
>   /* #define DEBUG_HELPER */
>   #ifdef DEBUG_HELPER
> @@ -98,6 +99,77 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
>       tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>   }
>   
> +void HELPER(cvb)(CPUS390XState *env, uint32_t r1, uint64_t dec)
> +{
> +    int64_t pow10 = 1, bin = 0;
> +    int digit, sign;
> +
> +    sign = dec & 0xf;
> +    if (sign < 0xa) {
> +        tcg_s390_data_exception(env, 0, GETPC());
> +    }
> +    dec >>= 4;
> +
> +    while (dec) {
> +        digit = dec & 0xf;
> +        if (digit > 0x9) {
> +            tcg_s390_data_exception(env, 0, GETPC());
> +        }
> +        dec >>= 4;
> +        bin += digit * pow10;
> +        pow10 *= 10;
> +    }
> +
> +    if (sign == 0xb || sign == 0xd) {
> +        bin = -bin;
> +    }
> +
> +    /* R1 is updated even on fixed-point-divide exception. */
> +    env->regs[r1] = (env->regs[r1] & 0xffffffff00000000ULL) | (uint32_t)bin;
> +    if (bin != (int32_t)bin) {
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +    }
> +}
> +
> +uint64_t HELPER(cvbg)(CPUS390XState *env, Int128 dec)
> +{
> +    uint64_t dec64[] = {int128_getlo(dec), int128_gethi(dec)};
> +    int64_t bin = 0, pow10, tmp;
> +    int digit, i, sign;
> +
> +    sign = dec64[0] & 0xf;
> +    if (sign < 0xa) {
> +        tcg_s390_data_exception(env, 0, GETPC());
> +    }
> +    dec64[0] >>= 4;
> +    pow10 = (sign == 0xb || sign == 0xd) ? -1 : 1;
> +
> +    for (i = 1; i < 20; i++) {
> +        digit = dec64[i >> 4] & 0xf;
> +        if (digit > 0x9) {
> +            tcg_s390_data_exception(env, 0, GETPC());
> +        }
> +        dec64[i >> 4] >>= 4;
> +        tmp = pow10 * digit;
> +        if (digit && ((tmp ^ pow10) < 0)) {

That tmp ^ pow10 caused some frowning for me first, but it's just a check 
whether the sign changed, right? ... a comment in front of the line might be 
helpful.

> +            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        }
> +        tmp = bin + tmp;
> +        if (bin && ((tmp ^ bin) < 0)) {
> +            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        }
> +        bin = tmp;
> +        pow10 *= 10;
> +    }
> +
> +    g_assert(!dec64[0]);
> +    if (dec64[1]) {
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +    }
> +
> +    return bin;
> +}

Patch looks sane to me now, but I'd appreciate if Richard and/or David could 
have a look at this, too!

  Thomas


