Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F348DC3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 12:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWxDS-0002GD-Po; Thu, 25 Jul 2024 08:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWxDR-0002F7-QT
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:05:01 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWxDO-0000bA-T6
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 08:05:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso433474f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721909094; x=1722513894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJzZT5Lqe+MAj6BoPpFXBWFKt+GsMGvrj0O2PBvvU3w=;
 b=QvVZrigo7HeJxDYBMnlHHny6q41aLF//Z/Ztfg/u/kaPK/a/+Nz62uLmShI0z0IghN
 UsG+xxPRRGv+aqV1Pq1s7zIf3TzpzijoZXRZLadOfoJpY7Ngr3rxDxgScvqrIf3uXnll
 ux1wBEfBg4JqYcxRwhsGT0sBi6PDfAXYagwd40nY0yQzIDgmjAO6Gp3Oyd75DiCSELyy
 f1Ik6pdoR7zVKO7vEY7pBGGew5z4x1bIgNtSgjk0iDpWnXyd3qgZvimnSpaKlvgJGFeS
 37iCMJRU+9nFUuDeaRqHZ7DQJWTFIU5sCoxiV98KHb+nl9Cb+sV9BZdQvAv0d3Ry5q8w
 NgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721909094; x=1722513894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJzZT5Lqe+MAj6BoPpFXBWFKt+GsMGvrj0O2PBvvU3w=;
 b=ewAs9egTYA03vxmJ94isF4tRlJbE735VYP6fgYN9/ksjBBmYX1VcHRglTzxd95mlC9
 PoyAxWSx3UPduCSogEelXf64BWNFQYT0bybVIrbxhSOwXtT7rtzBikBEYUjgsikJ6fa2
 YNBcesaqoCY9G+oVFU7IlKFQWvG+IpOit8W9EVXalXr8xGh5OD7tOqGgR/H07Af7IBt1
 fS12kKHAJY7POZMbiaPNL7Rr3N99fR7dz1AQTShHEaMHU+RYICm/jIZGdvEtBxBSW9y3
 tUKVpKLO5WLmB/x4H4Q9xW7kP4ZuwHCbWWDP5ZmlP6rTSa4LuuxPENLDFCzqbp3HFo9v
 H/Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9+kA+Tj6r6zgiY9p0m+4wZ5x3C86aNjFlffnHjwicvIvcmnQ44ROkdIM1r95tOxGSJHYfKQbgkY53RhvnWSYKd1dFgC0=
X-Gm-Message-State: AOJu0Yy3B/IhEnqVK36LvCppzwU/PDLD+iHQZR2zruDBnS6jICy8ChiS
 xsHGGrGP7RJkss7yL1bwfJtANW1laoXVnLTkDTvZk+BSxFF1k/1ItDgiaLBDEHs=
X-Google-Smtp-Source: AGHT+IHfBY1eqKqA32kPsP8NWdU5RCfNzBCG++47m4sVjfXoJiIHf9LuTgqH1uci8Q3A+gHtW5NYnQ==
X-Received: by 2002:adf:efd2:0:b0:367:4dbb:ed4e with SMTP id
 ffacd0b85a97d-36b3193a8f2mr1790893f8f.0.1721909094269; 
 Thu, 25 Jul 2024 05:04:54 -0700 (PDT)
Received: from [192.168.1.102] ([176.187.216.35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36800cdasm2042583f8f.64.2024.07.25.05.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 05:04:53 -0700 (PDT)
Message-ID: <24fad245-6410-487f-b70c-1832f2adb267@linaro.org>
Date: Thu, 25 Jul 2024 14:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/23] tests/functional: Convert avocado tests that
 just need a small adjustment
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-7-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240724175248.1389201-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 24/7/24 19:52, Thomas Huth wrote:
> These simple tests can be converted to stand-alone tests quite easily,
> e.g. by just setting the machine to 'none' now manually or by adding
> "-cpu" command line parameters, since we don't support the corresponding
> avocado tags in the new python test framework.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  6 ++
>   .../test_info_usernet.py}                     | 11 ++-
>   .../test_ppc_74xx.py}                         | 74 ++++++++-----------
>   .../version.py => functional/test_version.py} | 13 ++--
>   4 files changed, 53 insertions(+), 51 deletions(-)
>   rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
>   mode change 100644 => 100755
>   rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
>   mode change 100644 => 100755
>   rename tests/{avocado/version.py => functional/test_version.py} (78%)
>   mode change 100644 => 100755


> diff --git a/tests/avocado/version.py b/tests/functional/test_version.py
> old mode 100644
> new mode 100755
> similarity index 78%
> rename from tests/avocado/version.py
> rename to tests/functional/test_version.py
> index c6139568a1..5e566d76b1
> --- a/tests/avocado/version.py
> +++ b/tests/functional/test_version.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Version check example test
>   #
>   # Copyright (c) 2018 Red Hat, Inc.
> @@ -9,17 +11,18 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   
> -from avocado_qemu import QemuSystemTest
> +from qemu_test import QemuSystemTest
>   
>   
>   class Version(QemuSystemTest):
> -    """
> -    :avocado: tags=quick
> -    :avocado: tags=machine:none
> -    """
> +
>       def test_qmp_human_info_version(self):
> +        self.machine = 'none'

API is self.set_machine('none'), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


