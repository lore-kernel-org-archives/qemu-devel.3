Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349A6C47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkWg-0007JQ-D0; Wed, 24 Jan 2024 16:11:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkWe-0007JC-Iw
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:11:12 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSkWc-0004x8-UQ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:11:12 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso4349241a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706130669; x=1706735469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kQDL11g53pCVU/eOIwDhpYn6KRKNRmbK4sFqPyWfOTA=;
 b=WDxwypyVzsyb+/emCWtjZc0F4NK1UAIYLWGCTpEzBwDOCOhzIHKfAxm9V/Wvwj6YJA
 d8Qd9qr+xC0tXjDhtiXjIeB/blosOMyyQqn9jAOSDphPaEfe6MUY3u/zXyirD4nZfmBH
 GqL5ARt37jbz9VUCe+w3JYbgAkbl1geolBg8KFRqfAbMsogapwAzer5OmXajy528F3CT
 IfKvo1o/GGpZGAe/oPGfdOTOiJipKN+IRnRskh7y06CrR2NrCx5eF9zlan7GR9Y4M0PJ
 aoSs/3ySNfRTyZOXEMdAyMd5rf1yq9IQQ6TV6xf2yqEHXpyDspyJVoUxROsgsaWQL2V/
 d1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130669; x=1706735469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kQDL11g53pCVU/eOIwDhpYn6KRKNRmbK4sFqPyWfOTA=;
 b=KSfTF08Gq5dOvibthFKEA8T2XVri1mpsRQwcHD/Ga8CDeaWWngEfpO6g/Lw/ZukmoN
 A3GT47PdzUaezOE8OMLUDzqB3LggYSIYdFiRaHUpbx0nn7Temr6vhubNQCv1QPweA/Zn
 u6BgwTG0CdeFpJMpRk1jrPh7jnAOOp0DNWxBV8k3/2bP64Mlb5yyiMF2x0fkjtBvTlAw
 eEGUgN4mtJY+uDsDApdtkFM9lw7vYdJCHT0zYBarVYI2O/MY0PwDAlFGlMuA1xOEAGOw
 /05vViQwr4ubfDlFu3j9EzONiw0y10ysO9dse0S7D+CK5BHNJl4YAoc5rB3QEqQVlVbF
 X1rg==
X-Gm-Message-State: AOJu0YwBMKyDpj+SQS0DOogtuBlVpHRwHoyEXtAMwCeySW/yl5huJvDI
 V9cK4bR/4kTpiHxKfWtXIS9BwskdXc4PH3E5xcs4Fs7AmXn+SrAHjqB++SNSHQ7CzQdtAHVi/+o
 n
X-Google-Smtp-Source: AGHT+IGh+LCsx+LskQjRpZEYCcfO8qXjE5aQMo3c6dta2Pw9n+6g+xN7GvDXKM9HfztI6d19DrkRpw==
X-Received: by 2002:a05:6a20:9593:b0:19b:5cf9:45ac with SMTP id
 iu19-20020a056a20959300b0019b5cf945acmr56567pzb.81.1706130669053; 
 Wed, 24 Jan 2024 13:11:09 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 q24-20020aa79838000000b006dba11edc7csm13664451pfl.218.2024.01.24.13.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 13:11:08 -0800 (PST)
Message-ID: <3aad97e2-7a2d-4629-bca2-0e5a0f439082@linaro.org>
Date: Thu, 25 Jan 2024 07:11:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240124075609.14756-1-philmd@linaro.org>
 <20240124075609.14756-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240124075609.14756-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/24 17:56, Philippe Mathieu-Daudé wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> tcg/ should not depend on accel/tcg/, but perf and debuginfo
> support provided by the latter are being used by tcg/tcg.c.
> 
> Since that's the only user, move both to tcg/.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-ID: <20231208003754.3688038-5-iii@linux.ibm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   {accel/tcg => tcg}/debuginfo.h | 4 ++--
>   {accel/tcg => tcg}/perf.h      | 4 ++--

Headers should be in include/tcg/.

> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -63,7 +63,7 @@
>   #include "tb-context.h"
>   #include "internal-common.h"
>   #include "internal-target.h"
> -#include "perf.h"
> +#include "tcg/perf.h"

Since it is used from accel/tcg/,

>   #include "tcg/insn-start-words.h"
>   
>   TBContext tb_ctx;
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index e7a9b3775b..b8e52f3fb0 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -62,7 +62,7 @@
>   #include "hw/boards.h"
>   #include "qemu/cutils.h"
>   #include "sysemu/runstate.h"
> -#include "accel/tcg/debuginfo.h"
> +#include "tcg/debuginfo.h"

... and hw/core/.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

