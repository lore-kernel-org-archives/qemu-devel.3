Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B7EC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyG9S-0002lQ-5p; Fri, 28 Mar 2025 16:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG9F-0002Yt-Fd
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:17:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tyG99-0001jy-QP
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:17:46 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso4031077a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193062; x=1743797862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwUPZ+L2hFvy3TQ3YWy3ONotl5xixQyjc7h1YHE/O3Y=;
 b=xJ2mZMjgP/P8iU7xQgE+GL0A5wSIrhK8HDI6RNVCXldXGqo5dhQ92WoVeez5Kn+AKN
 VR87S43aPf9lOIj+xgh8JqwCeYvXmzDsui3V8jQ0hmXBMddvGPTqcPBSU/8G0GddngmK
 V/y5i4xFhfJfrJaCMmUnMBiid65UpBGMGYbQZhnFoL3atWZa7RLXxFQS3fxQar+6h/Qa
 mX26wuPhxl1tjZgRuonOzRaTZCPN2ffBhVGcFmV4cgFNz58GRWVhttp/J1WEYbiLY725
 GytFQZyH0ZQYlTnxX9MwRQV+t2ksaCx8sK4I80IvMqB2GtZwOYjbxAPefGKDocpCzEYj
 ys9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193062; x=1743797862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwUPZ+L2hFvy3TQ3YWy3ONotl5xixQyjc7h1YHE/O3Y=;
 b=RJtm9EYVh1kxRgpe5JDpA8wfTW5B317L4YB1FSB994OLUQ+WV548ItxTwrDZL8wb9W
 2VX1NJ6iv/NSNeG4e+Et03XPWuRejHxSqn3/OFOHhr2sivmnTMjdCPs2g2/bynPApqP7
 t0QxsOEL93P5S4yRnEIldRE7JUHpc+EsNRI7XgBcLrIl4VpFwOwYO4c/euAK+l1E6Bg9
 GNk46ClTGQM41e3XtA9LjLK/gv/0Pb11J7QxtF+8cNb3asyo4H4uAZWRanAuet5ggY87
 OGTihT1YFBOjxXjicFfeWCavdkAdK1gZuq2UX+2EbB1s66stTxNbrW0vWoZP4dRDrcsd
 UaDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiCqMmpEfebTsURVIKfWKLeH6Hhzlrw57IVJiT8QCrxjzsh9qLUCcYjjCZGYY5tnTOgnCd7+uurXm5@nongnu.org
X-Gm-Message-State: AOJu0Yy1+Vjf+9gASCKjw1V9nYtOH383whiyXYWY80IQsxYlHCEwmrcC
 2AoWxs5/tGMaCgijtDm+5w1XcJvcQ3G9WMivBKpqwH28jD0JJ7Ty3clXAYe8ZEs=
X-Gm-Gg: ASbGncsTaSvXDqqsqCIv4Ue2txQADxgve+4VOX6WSSCShb2LBMogVFWbP0+LA8cM5tQ
 jC9E8y7IF/NHMy5cT7JdsV9mooDnBQwpPrjctbPbPX+wsOjq3AKVAppOA4qCBjLmgXFjNTFo+1I
 l597XG6H5sxDG+gsBoipUF6s3yecHQKoWqwzMVR/EoexlSm23G55axmd0+1w7c9GHx7/cnft2uf
 aVijPz+DBYeFt/+Uxr4BiY9icfrDCRaX4B+E7l+5OJAcLOxENdqBKlvEgubha8eDh/nHXLSGHoi
 3cPq/IX03lkO7v6k0iOikQap5Br5EyyQiJOz1A3ulTbl1z1f4WRW+M3CNDQ=
X-Google-Smtp-Source: AGHT+IEmllAzB7YBur2tCym3TIvaO6brp8kJSQllmpbLYj14lGnaVpIadPAs/kx6PbnIQpiTtCG8Ag==
X-Received: by 2002:a05:6402:34c2:b0:5ed:191c:ed23 with SMTP id
 4fb4d7f45d1cf-5edfcbe918fmr602130a12.3.1743193061942; 
 Fri, 28 Mar 2025 13:17:41 -0700 (PDT)
Received: from [10.154.28.14] ([193.32.126.156])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17b2eacsm1793431a12.59.2025.03.28.13.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:17:41 -0700 (PDT)
Message-ID: <34cd1a35-24c5-46d1-8be7-9a5d9bb152b4@linaro.org>
Date: Fri, 28 Mar 2025 13:17:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] accel/tcg: Remove page_protect
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-4-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250328200459.483089-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ed1-x533.google.com
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

On 3/28/25 13:04, Richard Henderson wrote:
> Merge the user-only page_protect function with the user-only
> implementation of tb_lock_page0.  This avoids pulling
> page-protection.h into tb-internal.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h        | 11 +++--------
>   include/user/page-protection.h |  1 -
>   accel/tcg/user-exec.c          |  2 +-
>   3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
> index 68aa8d17f4..f7c2073e29 100644
> --- a/accel/tcg/tb-internal.h
> +++ b/accel/tcg/tb-internal.h
> @@ -51,28 +51,23 @@
>   
>   #endif /* CONFIG_SOFTMMU */
>   
> +void tb_lock_page0(tb_page_addr_t);
> +
>   #ifdef CONFIG_USER_ONLY
> -#include "user/page-protection.h"
>   /*
>    * For user-only, page_protect sets the page read-only.
>    * Since most execution is already on read-only pages, and we'd need to
>    * account for other TBs on the same page, defer undoing any page protection
>    * until we receive the write fault.
>    */
> -static inline void tb_lock_page0(tb_page_addr_t p0)
> -{
> -    page_protect(p0);
> -}
> -
>   static inline void tb_lock_page1(tb_page_addr_t p0, tb_page_addr_t p1)
>   {
> -    page_protect(p1);
> +    tb_lock_page0(p1);
>   }
>   
>   static inline void tb_unlock_page1(tb_page_addr_t p0, tb_page_addr_t p1) { }
>   static inline void tb_unlock_pages(TranslationBlock *tb) { }
>   #else
> -void tb_lock_page0(tb_page_addr_t);
>   void tb_lock_page1(tb_page_addr_t, tb_page_addr_t);
>   void tb_unlock_page1(tb_page_addr_t, tb_page_addr_t);
>   void tb_unlock_pages(TranslationBlock *);
> diff --git a/include/user/page-protection.h b/include/user/page-protection.h
> index 51daa18648..d5c8748d49 100644
> --- a/include/user/page-protection.h
> +++ b/include/user/page-protection.h
> @@ -16,7 +16,6 @@
>   #include "exec/target_long.h"
>   #include "exec/translation-block.h"
>   
> -void page_protect(tb_page_addr_t page_addr);
>   int page_unprotect(tb_page_addr_t address, uintptr_t pc);
>   
>   int page_get_flags(target_ulong address);
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 667c5e0354..72a9809c2d 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -657,7 +657,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
>       }
>   }
>   
> -void page_protect(tb_page_addr_t address)
> +void tb_lock_page0(tb_page_addr_t address)
>   {
>       PageFlagsNode *p;
>       target_ulong start, last;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


