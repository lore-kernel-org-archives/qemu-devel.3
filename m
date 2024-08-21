Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFD2C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgjoQ-0002Hz-1T; Wed, 21 Aug 2024 07:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgjoO-0002Gj-48
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:47:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgjoM-0002Lm-40
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 07:47:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so3940425e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724240852; x=1724845652; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8nGti/MwGWFNvegeyX1wL0D7P+mvNabGDWblN1KZQnM=;
 b=tLgLCr99jE48Oqa3JNX+g9zeZ9zeHhvTUo7mHeMFdooMrOiXcF7WfofzUPldi5FvzF
 u+FWKhtcK2KgGQiBhPlqtWP4M77TCIcGS3Y4+65LxebFG6y1CJj0tD2855N2/WZfVNdz
 R6sr0+sQbDrwVkArE+bZwnQ19cQ4hW3vCClLbbDo5q+4ewSUVR0TIkpcJrr6HCXqAPaT
 CVUbb4ruSexLT8lYoUnMKb+YJKcM1I+VRIyjoCXZCP3o835HwxGylX/FBVPHgY4iiehD
 2Eiv6O0ZtIz4FDpeV4CLZGCrgbktwby7Yc57YPii2d56wPfpt5NVu44D2WD4Z20zqBEW
 QP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724240852; x=1724845652;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8nGti/MwGWFNvegeyX1wL0D7P+mvNabGDWblN1KZQnM=;
 b=IEUm32g09zioWaUBSLuu1ty+V7sJwJ2F6lQQA9EjT+jbTXRyBv/4ge/GVgyH1zXgyZ
 OrjBQTsLIvUauioIDbG0st9roIgEZpUhdI+KNNWVh18Ux4dbe6RF0VYoJZ6gni+vHN73
 8RWQsWyfkrPjt+RiBrQOFq58DhtSvDMAgOo3j72x+Q27lOC0Ls4UH8SLb2B8FVlW3XNU
 BtswhGNOBPO8BAVPFtK3XXgY/Y9siUn1JeVFa6ju+T7JeYhhUC9iVJqws+RKVGn5Chk4
 GeFefsxe9+wFxUD98uV4eN7lGCBh+LdTWWTtCj7nUFKx46ymWqHax1nTXAdYEqeMM6VK
 qx7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuEsnUVJDxpmv1ze1SByX5sGK4uIPT7q1H1DlTGnopaN5qHG7cJxB+smYLLIN8VCud5IF61nogedTV@nongnu.org
X-Gm-Message-State: AOJu0Yy2Uz2bIbuCahqIQ8nuDI5gv2ZgjNTdFgJnNVOxWwTEVEnPKn7u
 J1Xens0Cze8HGA0qcs7P3/9mMQotMT+6Kbw6drB9pt6PFgYK3odw2c0DkLHkSco=
X-Google-Smtp-Source: AGHT+IH82D3kRqGUcs2CEFVzBLvXUsHg9mJHBNfMLZFRpT8V+DBjpiWy7vXplhkp00oKACHFqLUWPw==
X-Received: by 2002:a05:600c:3104:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-42abe654bb6mr11312255e9.6.1724240851829; 
 Wed, 21 Aug 2024 04:47:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.218.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a047sm15545290f8f.11.2024.08.21.04.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 04:47:31 -0700 (PDT)
Message-ID: <7146afbe-cf4f-4524-9f67-34c8dada74c3@linaro.org>
Date: Wed, 21 Aug 2024 13:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/35] tests/functional: Convert the ppc_hv avocado
 test into a standalone test
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-27-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-27-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
> A straight forward conversion, we just also have to remove the decorator
> @skipUnless(os.getenv('SPEED')) since all non-trivial functional tests
> are running in SPEED=thorough mode now. Also make sure that the extracted
> assets are writable, so that the test does not fail if it gets re-run
> and there are stale read-only files already around.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                   |  2 +-
>   tests/functional/meson.build                  |  2 +
>   .../test_ppc64_hv.py}                         | 53 ++++++++-----------
>   3 files changed, 25 insertions(+), 32 deletions(-)
>   rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (85%)
>   mode change 100644 => 100755


> diff --git a/tests/avocado/ppc_hv_tests.py b/tests/functional/test_ppc64_hv.py
> old mode 100644
> new mode 100755
> similarity index 85%
> rename from tests/avocado/ppc_hv_tests.py
> rename to tests/functional/test_ppc64_hv.py
> index 0e83bbac71..df59667e07
> --- a/tests/avocado/ppc_hv_tests.py
> +++ b/tests/functional/test_ppc64_hv.py
> @@ -1,3 +1,5 @@
> +#!/usr/bin/env python3
> +#
>   # Tests that specifically try to exercise hypervisor features of the
>   # target machines. powernv supports the Power hypervisor ISA, and
>   # pseries supports the nested-HV hypervisor spec.
> @@ -7,10 +9,10 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> -from avocado import skipIf, skipUnless
> -from avocado.utils import archive

Pre-existing, "archive" is not used.

> -from avocado_qemu import QemuSystemTest
> -from avocado_qemu import wait_for_console_pattern, exec_command
> +from unittest import skipIf, skipUnless
> +from qemu_test.utils import archive_extract
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern, exec_command


