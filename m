Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A588C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNZC-0000Xs-Lb; Fri, 08 Aug 2025 09:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNZ0-0000QP-Ba
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:55:21 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNYx-0003GB-13
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:55:18 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7825e2775so1960356f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661313; x=1755266113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/y71bLUWP106KUrQperc1jzs8a6oojIHAiN9gH4tWf4=;
 b=N+O8YxBab9cNVGLM31pvjVMBZ2Y4JcSqhNV66iKnZePiUGm+4BldZss7TzJmXexqgF
 NXvxoJUGFAL7OEz1Oz299h9Gm7cO+9wGZT6tGxHqWX1pSr1rZIYT0CiZtWw3kfffz5AD
 ibL77evIyBwo1UXkIYj6op3RyEdGI0XUWPM3FQjsf2o2hGwKmIxXdwLv0M+AaCbVfTNZ
 mwPiV8ucLcgC4TflvnKSmBzPoGUtLOaakjG+DICFMw+6aOZ35yb5Kro0fAxluSCqTILl
 rVE7qKHVOF13QSqoQnuNJhTRRL3dZnuHB05nhgOxgVqdlOJgWqTRoWKVvE3q1Gn2vABD
 8TIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661313; x=1755266113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/y71bLUWP106KUrQperc1jzs8a6oojIHAiN9gH4tWf4=;
 b=ZMA3j/e7l4ON/+CG+W/UQBAX6jdSlXHYclwqfgpzvE/uinhEIR08zwqm0dASW4YNRg
 9auAgfemCLqONniNyH2zdqlgjge2YWSkb54IzA000i+QNTPWuByYZKxFXmOrMssfnDGB
 alf+yCLDat4cxEJkZsxRXgykw5O2TqujX5dMYOkJifqw+/ZMJkt5MGUAVXdbjvwt9+1l
 Hz9qQ6FxmM+xqIJTB5Ms4rN2S5ThPagQJfajkn6Xjq69Zj7BoYSTa78JRWL54ixt9b29
 N9uWTmsa6C72SIms41C5PRJ4J7Uul0jVJa2CIMJBA6ApBQVmB3ZKQH9xsbphxNgl3Bc6
 Ymiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWj6kTFw+fQeo0GBpnS6GoTailKOY3NCbfwX0jOOHLkP4iPFpo2Azl5Ao28ShdHrkB2offQExEEVJD@nongnu.org
X-Gm-Message-State: AOJu0YxIPaZUoJdc6zmmms5scjrb0M2lcXAGqr9LcvXDppCQjFNywz+J
 DWsiRfS5/ssmJvKgs+FP59V65oC6LXIX9gJ3tZfuuiqvG72Vnky2ZwRlEBzc0Yks4h0qDtj1CAR
 P65ca
X-Gm-Gg: ASbGncvGsXewWnI9oko4m0t/xhWvb5kjzvINs775xVlHVogu2qtrxIAye34rqUuKQCa
 QDEG/NzzNShbaemrBSTh8XC4Z95bbjDddERgnvbwauinDaurqBMli5JTlQlVkgjBk0gd+KM7V+g
 GW3t2EZfDhtU+XPHT4FIjauiKTDksHdt7nM1pmDDhzRJA+mf7orfqeebvHoawlAnus28iIAbd2s
 zxWpElKa7lA7W8nwfB0gwFax6Oguzt3t2n6uM8319RiB2DIJvXGIIPdYeWX0azoFmbQwsaP4nLd
 +ShXY9+yXVyMgIOlr9SWgpubJX4qsfvtQIxa5HTYqYEbVxJCwTVtbsq+IlLAEdcqnHNEkGNnxpW
 FrYz9Og3bkC/3ooyCUqByjv4M0TcUPSRdTQN9aiL2jgvrVpsE4wBb2cBEBkSJsoyYZMfgF3slUx
 s6
X-Google-Smtp-Source: AGHT+IF440KaUl4xfKGnjpTyQg+szkNFAsvP3G5fH+9fKS7TvgYRDbv8e1l6lhi1AickSN2nZlMLhw==
X-Received: by 2002:a05:6000:26d2:b0:3b8:893f:a185 with SMTP id
 ffacd0b85a97d-3b900b7f46amr2412756f8f.53.1754661312993; 
 Fri, 08 Aug 2025 06:55:12 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5852e28sm135791235e9.9.2025.08.08.06.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 06:55:12 -0700 (PDT)
Message-ID: <6d876750-9d7b-4556-a1e5-06f7c7487eb0@linaro.org>
Date: Fri, 8 Aug 2025 15:55:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] migration/cpr: Clean up error reporting in
 cpr_resave_fd()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-5-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808080823.2638861-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 8/8/25 10:08, Markus Armbruster wrote:
> qapi/error.h advises:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
> 
> Do that.
> 
> The error message starts with "internal error: ", so maybe this should
> assert() instead.
> 
> Cc: Steve Sistare <steven.sistare@oracle.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   migration/cpr.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/cpr.c b/migration/cpr.c
> index 42ad0b0d50..908bcf83b2 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -7,6 +7,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "migration/cpr.h"
>   #include "migration/misc.h"
> @@ -100,10 +101,10 @@ void cpr_resave_fd(const char *name, int id, int fd)
>       if (old_fd < 0) {
>           cpr_save_fd(name, id, fd);
>       } else if (old_fd != fd) {
> -        error_setg(&error_fatal,
> -                   "internal error: cpr fd '%s' id %d value %d "
> -                   "already saved with a different value %d",
> -                   name, id, fd, old_fd);
> +        error_report("internal error: cpr fd '%s' id %d value %d "
> +                     "already saved with a different value %d",
> +                     name, id, fd, old_fd);
> +        exit(1);

My 2 cents, I'm not sure this information is more helpful than a plain
assertion (at least for users). No objection for this change.

>       }
>   }
>   


