Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDED1C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XEK-00020p-Rh; Wed, 23 Apr 2025 06:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XEH-00020B-Uo
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:21:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7XED-00049i-QC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 06:21:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39efc1365e4so2298625f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745403676; x=1746008476; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cqcB40nTcXBQkh2PkxB+C2WqDdk2PaXTMOdvhK30HZI=;
 b=zSyIK9aya42MvLvUY35Q4CtG1Bcp6Kn8JbxYXxq2qwJ+p1CTq4I0MrOYhBtSuJQy7f
 6tbnlQo196KMl58jP5M3gDrJNyNLdte1xHb+FB6Q7cxl1q7cde2AwW+Sks6KWL5DIBt6
 fwfJInX2BAgY3xdMQ6uPtxUR2ssQF8CmpXGGcFQpGH+DHSPHxsTc1dHPGhHgKjt3afIo
 NnGauaoiTEk9Vleze758EHCC2Xc72TiYbTQkxZfMYAztjGHND2d5IIhti4HdLnv67KMC
 Pkb3nRqNEz0M+SKRQ+2u8UPxODzzCvQXiSYmig7SPvd0KY63vBdUwI5zpUYutn23mgfk
 lnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745403676; x=1746008476;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cqcB40nTcXBQkh2PkxB+C2WqDdk2PaXTMOdvhK30HZI=;
 b=LKc+9jGi37FQCd8/2qszsgQLuoK7lnZ016UghCj6t4jt9plG3N0li2aHCQL9h/xm5r
 laqwm8f7QVMRuivNHF8eSkFt/lp9uOpj/pEiG3pEak3E6H3sBANasicQVEXGEq8fVT8U
 trXHbi/fPlS6h9eCLFMxkzP8fBdr3wXdifcsur8KhPqKZAd+Ays42pwwl92SesqxeNlK
 Q1Ns7M9kWoFlbmXIx4h3d8cbkTHahkm3d9h3swYL+Cg3eUP0p+o1wRkSEiaOKD4BzgAM
 dnduTKuoQNYuG1aJDFKxxmLtFDz+Ujr7H7rAQno6E1Pr5zQ66E3nhPsgnNzp7OzQDCoa
 vKwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQLhjDH3EbiYhAzBYXedEDZXTVDFUX7JurVsV315S9nskwJgElKH56P4GctHsywItm1T1uHiiUYxmP@nongnu.org
X-Gm-Message-State: AOJu0YwsV0IWqJVM59xzCta6onPss3pEhfmajd1DMeSi6YWqug4Jd5PY
 fg/0zxvVhGHUK/nFQpzOqM06Ag1HT8mk6HuOwYv/hDy1emmp8UOh3TtiNIx0lw31V7T1Vy6ILXL
 z
X-Gm-Gg: ASbGncvJgnkzLJ3vlOamQv/maswFz0z/cqWZ752riobGiHGm6u3GLkudMgiDVMnY9QM
 bOLHY6iyGueBBYLq8Hc+06cjgMSz+3sNCpmquGQTdf6lIO7ijwxEL9zOLyARdYshuH3IJFOy1/x
 eYDf543Xtt/rzRhMBjRz40apm86ALDh57m7v0ujNQQN5lTt2jck1WRrxg/B88S5Iwh60ua60JEz
 G7HipFqErNZPzXtd9RZbfG0c2VyhChjRHHpGc7JcHz0E6/+yabEXx1K4KCUaRmzfQcyR2u9Khrl
 srzTfvIhHEiCMeCr72wi+xtcyRrbExI3RLicPzeIIy8ztOHy57IeH1gjRyP7KFPOTxvuXDNzFCg
 nlvBvZhVp
X-Google-Smtp-Source: AGHT+IHMYhXle55maStFp32+ecPvwurqcdHUDdgp47cIuBoWhDm1i4l46EZYbfqdcGC6Wj/2Mjyw1A==
X-Received: by 2002:a05:6000:22c2:b0:391:4873:7940 with SMTP id
 ffacd0b85a97d-39efbb05cfdmr14241454f8f.54.1745403675933; 
 Wed, 23 Apr 2025 03:21:15 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4332b2sm18578950f8f.30.2025.04.23.03.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 03:21:15 -0700 (PDT)
Message-ID: <9111e4f4-5e91-406a-9e57-f58c2bfa3b12@linaro.org>
Date: Wed, 23 Apr 2025 12:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 099/147] page-vary: Move and rename
 qemu_target_page_bits_min
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-100-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-100-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Widening Cc list.

On 22/4/25 21:27, Richard Henderson wrote:
> Rename to migration_legacy_page_bits, to make it clear that
> we cannot change the value without causing a migration break.
> Move to page-vary.h and page-vary-target.c.
> Define via TARGET_PAGE_BITS if not TARGET_PAGE_BITS_VARY.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/page-vary.h   | 9 +++++++++
>   include/exec/target_page.h | 1 -
>   migration/savevm.c         | 6 +++---
>   page-target.c              | 5 -----
>   page-vary-target.c         | 9 +++++++++
>   5 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/include/exec/page-vary.h b/include/exec/page-vary.h
> index 54ddde308a..101c25911c 100644
> --- a/include/exec/page-vary.h
> +++ b/include/exec/page-vary.h
> @@ -49,4 +49,13 @@ bool set_preferred_target_page_bits(int bits);
>    */
>   void finalize_target_page_bits(void);
>   
> +/**
> + * migration_legacy_page_bits
> + *
> + * For migration compatibility with qemu v2.9, prior to the introduction
> + * of the configuration/target-page-bits section, return the value of
> + * TARGET_PAGE_BITS that the target had then.

FYI X86 pc-2.9, pc-i440fx-2.9 [1] and ARM virt-2.9 [2] were waiting
the v10.0 release to get removed. The s390-ccw-virtio-2.9 machine
got removed few minutes ago [3]. The remaining one is pc-q35-2.9
which was deprecated and should be OK for removal, IIUC it is just
a matter of someone posting patches.

[1] 
https://lore.kernel.org/qemu-devel/20250117102738.59714-3-thuth@redhat.com/
[2] 
https://lore.kernel.org/qemu-devel/20250116145944.38028-9-philmd@linaro.org/
[3] 
https://lore.kernel.org/qemu-devel/20250423073610.271585-2-thuth@redhat.com/

> + */
> +int migration_legacy_page_bits(void);
> +
>   #endif /* EXEC_PAGE_VARY_H */
> diff --git a/include/exec/target_page.h b/include/exec/target_page.h
> index 8e89e5cbe6..e4bd7f7767 100644
> --- a/include/exec/target_page.h
> +++ b/include/exec/target_page.h
> @@ -63,7 +63,6 @@ static inline int qemu_target_page_bits(void)
>       return TARGET_PAGE_BITS;
>   }
>   
> -int qemu_target_page_bits_min(void);
>   size_t qemu_target_pages_to_MiB(size_t pages);
>   
>   #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c33200a33f..0c12e373b4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -50,6 +50,7 @@
>   #include "system/cpus.h"
>   #include "system/memory.h"
>   #include "exec/target_page.h"
> +#include "exec/page-vary.h"
>   #include "trace.h"
>   #include "qemu/iov.h"
>   #include "qemu/job.h"
> @@ -339,7 +340,7 @@ static int configuration_pre_load(void *opaque)
>        * predates the variable-target-page-bits support and is using the
>        * minimum possible value for this CPU.
>        */
> -    state->target_page_bits = qemu_target_page_bits_min();
> +    state->target_page_bits = migration_legacy_page_bits();
>       return 0;
>   }
>   
> @@ -462,8 +463,7 @@ static const VMStateInfo vmstate_info_capability = {
>    */
>   static bool vmstate_target_page_bits_needed(void *opaque)
>   {
> -    return qemu_target_page_bits()
> -        > qemu_target_page_bits_min();
> +    return qemu_target_page_bits() > migration_legacy_page_bits();
>   }
>   
>   static const VMStateDescription vmstate_target_page_bits = {
> diff --git a/page-target.c b/page-target.c
> index 321e43d06f..8fcd5443b5 100644
> --- a/page-target.c
> +++ b/page-target.c
> @@ -9,11 +9,6 @@
>   #include "qemu/osdep.h"
>   #include "exec/target_page.h"
>   
> -int qemu_target_page_bits_min(void)
> -{
> -    return TARGET_PAGE_BITS_MIN;
> -}
> -
>   /* Convert target pages to MiB (2**20). */
>   size_t qemu_target_pages_to_MiB(size_t pages)
>   {
> diff --git a/page-vary-target.c b/page-vary-target.c
> index 84ddeb7c26..6251d948cf 100644
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -23,6 +23,15 @@
>   #include "exec/page-vary.h"
>   #include "exec/target_page.h"
>   
> +int migration_legacy_page_bits(void)
> +{
> +#ifdef TARGET_PAGE_BITS_VARY
> +    return TARGET_PAGE_BITS_MIN;
> +#else
> +    return TARGET_PAGE_BITS;
> +#endif
> +}
> +
>   bool set_preferred_target_page_bits(int bits)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY


