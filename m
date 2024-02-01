Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5AEC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 06:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVQzy-0003qA-0z; Thu, 01 Feb 2024 01:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVQzw-0003px-En
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVQzt-0003Xt-3I
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 01:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706770588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wZznG/+Fd0I3peLA7G8ZzOGySjHxzI/Z1ZmBLsUUQLI=;
 b=OCCfIi4UaDEsLofisMWIUWpKTbP0O3bkY12Mvv1kEbsxjzSsoOWRzl0epuiMxGOlbhd98Z
 ckF333Wh3ZzPdkNwXK1/m2azTV+sbweyFSKz9FTWmJIevdV5JwSoZwV4ql1JzZLaorPJy5
 vbrCqnPwbvObzBWVCzJ6afb3nKykq0M=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-zxXcCj3zPZ6HJGdkubqpJg-1; Thu, 01 Feb 2024 01:56:25 -0500
X-MC-Unique: zxXcCj3zPZ6HJGdkubqpJg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7853c364e60so83730785a.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 22:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706770585; x=1707375385;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZznG/+Fd0I3peLA7G8ZzOGySjHxzI/Z1ZmBLsUUQLI=;
 b=KxnYKi0JaErmwb/xMCI8PdcbkK5m6/viVA50sD2vTPBIGXn/+98By0qsmHYmg5d9ol
 hm51wVFjpyaGJpCNfMCGxbt7YyjcS1WLWor+/fK0apOSboix561oVzDQJzjF+pjP+HUJ
 FAIfnnOxu14rO2dFMTxq9mXeoiISNlLaz2tt4i2fbXbSLi4RInUcRLy1SOJRmnMJDFAW
 ierHJFQiMheYBHg7pqskk5oNqYoxf5wmzGFVnoJD1JNp8CVW/hAP39u0hGTbrMTj8HnF
 6mTGaajImdDJSkFf6OV+NzVG5/xGM2tcshQiGtoejnrCZ5EIulp1pZd0aNK6FpzAzyOG
 a8ZA==
X-Gm-Message-State: AOJu0Yw5ko2+sGASOr2TYmDi5WnNP86dLHEbMfjlsZeklKBuu+RJKc3W
 Ye46QvYOszWAH9qbtzsJ/bssaytg3Gs7BGL6X0EdeQFD7XgLv4/jRa5KTme+pJGbfYMVEGokYXN
 WmiiwZLGcHXAC9UkjgiXqnuOU5s+Ftql309cLUiBh2oSzFRWuMSu6
X-Received: by 2002:a05:620a:13c4:b0:783:930f:e576 with SMTP id
 g4-20020a05620a13c400b00783930fe576mr1703121qkl.31.1706770585550; 
 Wed, 31 Jan 2024 22:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4bIiEG6h8xGHR5ynE1o9b6RtD56hxcerVX71376DdJa+FbYWBEyTw1VGDbzC3VE47I9AImw==
X-Received: by 2002:a05:620a:13c4:b0:783:930f:e576 with SMTP id
 g4-20020a05620a13c400b00783930fe576mr1703113qkl.31.1706770585292; 
 Wed, 31 Jan 2024 22:56:25 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 pj41-20020a05620a1da900b007853f736893sm567261qkn.5.2024.01.31.22.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 22:56:25 -0800 (PST)
Message-ID: <05177b91-c98e-415b-b9ee-40a8a4497c31@redhat.com>
Date: Thu, 1 Feb 2024 07:56:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] target/s390x: implement CVB, CVBY and CVBG
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
References: <20240131230938.325919-1-iii@linux.ibm.com>
 <20240131230938.325919-4-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240131230938.325919-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/02/2024 00.07, Ilya Leoshkevich wrote:
> From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> 
> Convert to Binary - counterparts of the already implemented Convert
> to Decimal (CVD*) instructions.
> Example from the Principles of Operation: 25594C becomes 63FA.
> 
> [iii: Use separate functions for CVB and CVBG for simplicity].
> 
> Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> ---
>   target/s390x/helper.h            |  1 +
>   target/s390x/tcg/insn-data.h.inc |  4 ++++
>   target/s390x/tcg/int_helper.c    | 40 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/translate.c     | 12 ++++++++++
>   4 files changed, 57 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 332a9a9c632..3c607f4e437 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -88,6 +88,7 @@ DEF_HELPER_FLAGS_3(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i128, i64)
>   DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
> +DEF_HELPER_FLAGS_3(cvb, TCG_CALL_NO_WG, i64, env, i64, i32)
>   DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
>   DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
>   DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index 388dcb8dbbc..9eb998d4c25 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -293,6 +293,10 @@
>       D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_16u, 0, 0, ct, 0, 1)
>       D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_16u, 0, 0, ct, 0, 1)
>   
> +/* CONVERT TO BINARY */
> +    C(0x4f00, CVB,     RX_a,  Z,   la2, 0, new, r1_32, cvb, 0)
> +    C(0xe306, CVBY,    RXY_a, LD,  la2, 0, new, r1_32, cvb, 0)
> +    C(0xe30e, CVBG,    RXY_a, Z,   la2, 0, r1, 0, cvbg, 0)
>   /* CONVERT TO DECIMAL */
>       C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
>       C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
> diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
> index 121e3006a65..002d4b52dda 100644
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
> @@ -98,6 +99,45 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
>       tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>   }
>   
> +uint64_t HELPER(cvb)(CPUS390XState *env, uint64_t src, uint32_t n)
> +{
> +    int64_t dec, sign = 0, digit, val = 0, pow10 = 0;
> +    const uintptr_t ra = GETPC();
> +    uint64_t tmpsrc;
> +    int i, j;
> +
> +    for (i = 0; i < n; i++) {
> +        tmpsrc = wrap_address(env, src + (n - i - 1) * 8);
> +        dec = cpu_ldq_data_ra(env, tmpsrc, ra);
> +        for (j = 0; j < 16; j++, dec >>= 4) {
> +            if (i == 0 && j == 0) {
> +                sign = dec & 0xf;
> +                if (sign < 0xa) {
> +                    tcg_s390_data_exception(env, 0, ra);
> +                }
> +                continue;
> +            }
> +            digit = dec & 0xf;
> +            if (digit > 0x9) {
> +                tcg_s390_data_exception(env, 0, ra);
> +            }
> +            if (i == 0 && j == 1) {
> +                if (sign == 0xb || sign == 0xd) {
> +                    val = -digit;
> +                    pow10 = -10;
> +                } else {
> +                    val = digit;
> +                    pow10 = 10;
> +                }
> +            } else {
> +                val += digit * pow10;
> +                pow10 *= 10;
> +            }
> +        }
> +    }
> +    return val;
> +}

I just noticed that there was even a v5 of Pavel's patch where David noted 
that the fixed-point-divide exception checks are still missing, see:
 
https://patchwork.kernel.org/project/qemu-devel/patch/20180902003322.3428-4-pavel.zbitskiy@gmail.com/ 


Could you add those, too, please?

  Thanks,
   Thomas


