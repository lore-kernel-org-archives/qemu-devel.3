Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B9CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 17:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rptn3-0000GJ-E7; Thu, 28 Mar 2024 13:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rptn2-0000G7-9S
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 13:43:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rptn0-0006oG-Hi
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 13:43:47 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so1567444a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711647824; x=1712252624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eL+BpJbM7TyKVXuF3CQSlpesCBcXfQWuheeHVx8/v2I=;
 b=x+raPeaotiR/FBWn7WfS3E1EpX3C1Qf20XeFA2Hutoc6av8/5sfcyYwolGjUsZoz37
 CxeRoKeVHoRyBiPhr7Y84kISJrCc1sWjwXJuSg2/qkowaacBLM6WcxfSML3+T9goDQoA
 nFvledYoql22A+U3hGvuOWZCLkUIESY4HSS0S7rovnfkFX19egV/b1BUFHXl3FmHmmVo
 XiABwdzmnhHvhTAHWX2N4hynmFLz8xMAjASgFvCjEEiACiyAgWQrMRJ40pumflg01VVj
 tG+q7oAgNobKrtKRa6vNOFIFa5G9X6p8Z12KCfd9PasLoULTTZaPSf88FK4Twa4h1FGP
 jKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711647824; x=1712252624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eL+BpJbM7TyKVXuF3CQSlpesCBcXfQWuheeHVx8/v2I=;
 b=ogG8GhHpkRK+EiSYnRUbKLh3glw+2jMxr0+AdTFfzrsh22zH2fSDa9UXM0TPW+aCS9
 f/fc+ANMaQN7xY89swrDI3nVYKPK3N4M6tg15lJVsra6CQ6eUqx5AeeI+pPfV1fETaIc
 iTRD44fseng8MBWP1+MT/pZD/tAdYQxN8vyGw6h0VuNDt+n4P2O14l+ELH8o2JuFQFs9
 +IBjSEVCnmOwhZy+TdOiz/VtT2YPKRyRhSUhTZHUEMGMcEov+8SLYgFpd5V5MRyBxi9S
 qrrAZkIFvbO1TTKE7ae8gN6Te7z5jlD6O7fXnmsXc2PL8bi4AxBElkOweb2vW4ayhVzS
 BrNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR/5yxCNIwUx3EcLPJCbogCbKjrQsZN5eAe3RemiON0Xd8dmoqyW681hB7s07LXma0OHyKoYWgucXCEMixg2XX54Ubzmk=
X-Gm-Message-State: AOJu0YyVPo8zwRcfXOe4ErxhPTcVS/0IExYaPOZXECJ0h+LENaAweb9h
 gI3QVeqvEJRu0aBSZzot0jknmEdX3uOofWOzVtKFgZc0DW/lMWjI16JjKwyrj8SrRt9vdxkLv1v
 o
X-Google-Smtp-Source: AGHT+IFESRNLzu8IDYFjvIEYTIaO4EwtqDWlWKbPrzYqY6jXetU4d2vauycem/hIzzk0NGO1YMx+2Q==
X-Received: by 2002:a50:d51c:0:b0:56b:ff72:e6bb with SMTP id
 u28-20020a50d51c000000b0056bff72e6bbmr2054407edi.40.1711647824607; 
 Thu, 28 Mar 2024 10:43:44 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 el11-20020a056402360b00b0056c249798absm1057393edb.71.2024.03.28.10.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 10:43:43 -0700 (PDT)
Message-ID: <63600417-9187-4d0b-8bcc-db7e965ff008@linaro.org>
Date: Thu, 28 Mar 2024 18:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] Refactor common functions between POSIX and
 Windows implementation
To: aidan_leuck@selinc.com, qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com
References: <20240328154049.3090753-1-aidan_leuck@selinc.com>
 <20240328154049.3090753-2-aidan_leuck@selinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240328154049.3090753-2-aidan_leuck@selinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 28/3/24 16:40, aidan_leuck@selinc.com wrote:
> From: aidaleuc <aidan_leuck@selinc.com>
> 
> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
> ---
>   qga/commands-common-ssh.c | 50 ++++++++++++++++++++++++++++++++++++++
>   qga/commands-common-ssh.h | 10 ++++++++
>   qga/commands-posix-ssh.c  | 51 +++------------------------------------
>   qga/meson.build           |  1 +
>   4 files changed, 64 insertions(+), 48 deletions(-)
>   create mode 100644 qga/commands-common-ssh.c
>   create mode 100644 qga/commands-common-ssh.h


> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 236f80de44..c82ccfe629 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -9,12 +9,13 @@
>   #include <locale.h>
>   #include <pwd.h>
>   
> +#include "commands-common-ssh.h"
>   #include "qapi/error.h"
>   #include "qga-qapi-commands.h"
>   
>   #ifdef QGA_BUILD_UNIT_TEST
> -static struct passwd *
> -test_get_passwd_entry(const gchar *user_name, GError **error)
> + static struct passwd *
> + test_get_passwd_entry(const gchar *user_name, GError **error)

Modulo this spurious change,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thank you for your various iterations,

Phil.

