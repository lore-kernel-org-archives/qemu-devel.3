Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8748F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lYm-0000zB-Jb; Mon, 06 Apr 2026 11:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lYl-0000ue-18
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:08:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lYi-0004ha-O7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:08:14 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35da01fc0baso2742140a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775488091; x=1776092891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJPkrPRKENr88k3iv21viHjC+2P1P68VpsZe0PTF3Vs=;
 b=EmdrMDHMKnaYSlsYcqRYlUzcBX8Xv4YzN8q0TmWdV8B6eYMNnzrnLPZwWrYFcDyFae
 D9tdxB4V9Pfj+WPfoHNuqCq+yZEIF/y3nEo0E0Lx3A/TaPCkPA+ndeUrWi6ygOG2xwjg
 GfPrt1BgSX1nWPAgcmsoaKm1FyjccfjbCsuY60VgL7zRBJ13x4wfcBxitz0KLAtwKsjY
 Ymuj6ifHVm8nICR4inMXpK5rB0vNw863HEV5lTcbhHGL5uw1vrfUYnvpZKv0WMpA+/q8
 rxoghaa2OtTVELIA08KK+Yf8JYS+GBBzZn0/+C4tv61UbRoGqQiBGPhETH5WV8UGtGUK
 s5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775488091; x=1776092891;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJPkrPRKENr88k3iv21viHjC+2P1P68VpsZe0PTF3Vs=;
 b=lU3k/F6t/CkdcN/dUuJZZpLUZGzb52Qlb7c9Sq9h89kNilzvqvb2kJmoPGcqQFijD3
 b20msnxRvGs5BRq22CPKczGYVCfnFYOm95Jn/nAakmijITmntEpG3kzkS3jTphi8Accr
 SnnkXQ5HtidbAx/NJvXgGGp38L8vFRKlHK3XsRetONGhVo7ZDqhIJS/cTieNA2UVSHdu
 92u5kL03cV3m3vRza9+LiYgdCjnslWXqElb8TmLSoanpLiSgmBoXueesa9JYdh80LDFn
 P/tAM/SRB/D8RtKSOusOH8DS9xj8VPkn9rjNgLlCUOhK0CuzeB4O8av3ZsHZlaodMCsm
 EYmA==
X-Gm-Message-State: AOJu0YzfODhNmYMXsrgiVyEcsl4SHMoT0f9SKW28rcIFDEuTa8uw9gFM
 8I9WSjlIOwpLUAZsqc0gP1xznQqyj0LRMi2k/9ni3U5jqRgIkIbCLDmqQw3n2ELyHu5sGhylA8L
 YFW+qCqMCUQ==
X-Gm-Gg: AeBDieu1vQ2tWzyz0jddG8dL1It4dwCEpNdtHaV6u77Fz/UWHVNj5afySLpqAUbKmDl
 3N6pC9xYjVxuf2bvmKzre/6Pd9Sos5vUmV2z3UBuqBQm2F4OPUyRrm4cmunoXUHmvnGD4tnxSas
 uaUTr7t7f46djgpO9ZU50DQtbLic3r4hvXaTRJ+F9pdmBeSBk2uM4mpx8zwOJG8DZYCkjigy5u4
 EollgScfPHW5rPi7U2yIn/UeINyfz/JxtU3kwO3+VpaXbPTwUc+5Oe64tCWAXGtTR75gXUaPvxE
 WEJ3Ha3HAgx4pr3m6sScQxXu4boLiW0DDv1ft2kkqHu6eflUu4S/kOLln5o2GuFeiB650ty/7sb
 fhJCzEViZqlIERzDS1fCMFqHk7XgK4FR8nGt6HdLtUFULd0xfrv1NSedyMP3EOMD9aqaLiXRUII
 r4i+pcUp06kqHNeAi8kxLfdJ13n0EucMO20bDs8kKFBL9nAo3undD52kay6arWJ69RXPexxQJ0w
 wKqwQ0g
X-Received: by 2002:a17:90a:d2ce:b0:35b:8d89:719b with SMTP id
 98e67ed59e1d1-35de678fc27mr11743185a91.1.1775488090981; 
 Mon, 06 Apr 2026 08:08:10 -0700 (PDT)
Received: from [192.168.1.168] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe624756sm24331114a91.5.2026.04.06.08.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 08:08:10 -0700 (PDT)
Message-ID: <04db9e59-795f-4604-843c-4fcfd4e64e0e@linaro.org>
Date: Mon, 6 Apr 2026 08:08:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] target/arm: single-binary
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/1/26 12:20 PM, Pierrick Bouvier wrote:
> This series tackles (most of) the rest of target/arm, especially tcg folder.
> 
> We extract tcg memory operation in a new header, with a new type representing
> virtual addresses.
> 
> Initially, I went down the way to have a dynamic definition of TCGv, which
> required much more boilerplate and runtime checks. After discussing with
> Richard, I realized it was not needed, and that could simply split 32 and 64 bit
> properly in different files instead. This approach will not work with other
> architectures, requiring something else, but it's enough for target/arm.
> 
> Files left are:
> - target/arm/tcg/mve_helper.c
> - target/arm/tcg/m_helper.c
> - target/arm/tcg/cpu32.c
> 
> v6
> --
> 
> - meson.build: extract decode files in separate variables and explicitly include
>    them in user and system code. The duplication is now minimized: one instance
>    for all system binaries, and one per user binary.
> 
> v5
> --
> 
> - reimplemented what v0 did with new approach defining new tcg-op-mem header
> - reapply all straightforward patches from v0
> - only translate.c is left, but first want to validate that changes here are ok
>    for maintainers before doing more.
> 
> v0
> --
> 
> See original thread:
> https://lore.kernel.org/qemu-devel/20260109053158.2800705-1-pierrick.bouvier@linaro.org/#t
> 
> Note about v1 -> v4
> -------------------
> 
> - After v0 which was trying to do too many changes, v1 to v4 focused on smaller
>    things, and all patches have been merged already.
>    https://patchew.org/QEMU/20260219040150.2098396-1-pierrick.bouvier@linaro.org/
> 
> Pierrick Bouvier (12):
>    include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
>    target/arm/translate.h: remove tcg-op.h include
>    target/arm/tcg/translate.h: remove tcg-op-gvec.h include
>    target/arm/tcg/translate.h: remove TARGET_AARCH64
>    target/arm/tcg/translate-vfp.c: make compilation unit common
>    target/arm/tcg/translate-neon.c: make compilation unit common
>    target/arm/tcg/translate-mve.c: make compilation unit common
>    target/arm/tcg/translate-m-nocp.c: make compilation unit common
>    target/arm/tcg/op_helper.c: make compilation unit common
>    target/arm/tcg/gengvec.c: make compilation unit common
>    target/arm/tcg/translate.c: remove MO_TE usage
>    target/arm/tcg/translate.c: replace target_ulong with uint32_t
> 
>   include/tcg/tcg-op-mem.h       | 126 +++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h           | 100 +-------------------------
>   target/arm/tcg/translate.h     |  14 +---
>   target/arm/tcg/op_helper.c     |   1 -
>   target/arm/tcg/stubs32.c       |  17 +++++
>   target/arm/tcg/translate-a64.c |   1 +
>   target/arm/tcg/translate-sme.c |   1 +
>   target/arm/tcg/translate-sve.c |   1 +
>   target/arm/tcg/translate.c     |   6 +-
>   target/arm/tcg/meson.build     |  51 +++++++++----
>   10 files changed, 192 insertions(+), 126 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h
>   create mode 100644 target/arm/tcg/stubs32.c
> 

v7 sent:
https://lore.kernel.org/qemu-devel/20260406150434.407201-1-pierrick.bouvier@linaro.org/T/#t

Regards,
Pierrick

