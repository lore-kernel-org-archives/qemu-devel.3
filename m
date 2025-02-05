Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D2AC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfiSO-0005PI-J5; Wed, 05 Feb 2025 11:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfiSL-0005Od-Gj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:40:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfiSJ-0001GW-TR
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:40:53 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3702196f8f.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738773650; x=1739378450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hcpfla+JH/ONcyGxMA8WeagzmFNCui9cGjaDBGmZTQ=;
 b=yYHtyPGcjiMTTEpmuUJYhK7UN/QWaRfZSYTF95uINFTR1vKB29/++ff5/08jTU27IA
 8Mpa7m+RAYu+degGVNHR19lujgYwyJM6JhYcrOgYXvrlb5EB5Y9MnmY5OcBNsumVU58O
 yKL2f7fDw6wkFbFjYCPINmhUXL37ydoqfOYV4VnFyS57w3bvjsxKOoQImlOlXrx96qq0
 7FScLJPBRnVhZ3bhIi8LdTKBAwq9eVI0PjGOLaZOejDfUhNt69O6gaS2VP7YpS67z67u
 prIOwJlOOER8wwwudigkHwrrN6qf5pCIZ2TesCRjc8vFfNW+CcAYTFuQlNVzWPdFz/2x
 /N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738773650; x=1739378450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hcpfla+JH/ONcyGxMA8WeagzmFNCui9cGjaDBGmZTQ=;
 b=Kz9edbH78OrVQTbDNHgfWwFPux0FPdgQy+ruQ5TvQI1PaNsEi6397BenIW7mVQQRG9
 9HEn/bqaWyG/MK4/QrJm1x1Bw/IVD9WuKzUSFqY0rZR01GlVOCOxvU3dq8e/7H04g4iU
 6lxclbuxr4hJpPD8CRM/mejTXKWvYCfGT0nxjldk2pDfCSFg9rBNqn42ntxMnRgxw+Pn
 TKkZIT1PBkkGaT37+xNBUGmX/veCUYcBygpVdOig59eb7D5ZJ70ip168bDOuWkUclE+8
 BbYRngqD4XymW2DUR4GCPnpLYMk7PChFEuYKnwXnIMrfnKSlkzSSxd3zO6w/DOWMP3JO
 q9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtp+G5pkUTX3FnUwLhtlkFs7C+ZJ9PHmU4svbKFDFZuG+tBwJ3GgEUdxyFZDe5fMUB0BWcHkuKe2BV@nongnu.org
X-Gm-Message-State: AOJu0Yx6FP3ASCadrKOkiDCrSW3Cmiq466Z82zthP36E1IHKTpdn7mOS
 tTFAWBCpHbPdvLVyP4feoDb52cwSaSMZZswHa5bTgc7A7I5Tg3ucgr2LOJyxTCU=
X-Gm-Gg: ASbGncv708Gk9Rc7Hn0XaiKkgdQkA2JOLUCI8/UPvv9r+7Mh/4bDvqE2sRMRvbr7wVv
 t4P8YNyyLpBrRNFVw82bIianEwTL36WpTbjndguqPamadosaxGcgYIemxPHRrBUR27vLB9LHkje
 DxbZ2JarhNEb2q93IfxTn7Nl+WvJlYGv42OQwVU4X5WyvxU1eh7CAZn4yc6FU+pNfAsHN6c8Lnp
 jxcVwxVKY/gWXS7s3uPVyshWf+f+n+c5vSY26HlZ+YTAyplerkJ4f+A04M4CiDiA2gR4jmkIVUw
 1jrrbs20fmJ6ijYFhiK3v0h2DSky+9EGMIrP21wEJUBZfRNfyjnzK+ppEew=
X-Google-Smtp-Source: AGHT+IEb4Wj8/W+0jhpWMeWGEtXteqE6da0CaWZh4RnR54g++oUfaHPrJKJh+b0U5SnXLFzsHj1gxQ==
X-Received: by 2002:a5d:4dc1:0:b0:38b:f4dc:4483 with SMTP id
 ffacd0b85a97d-38db489fbd3mr2049060f8f.29.1738773649762; 
 Wed, 05 Feb 2025 08:40:49 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11200sm25933995e9.38.2025.02.05.08.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 08:40:49 -0800 (PST)
Message-ID: <9edd3138-3411-4459-96c3-d48c30e197e0@linaro.org>
Date: Wed, 5 Feb 2025 17:40:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205155946.2811296-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 5/2/25 16:59, Daniel P. Berrangé wrote:
> The test_mem_addr_space is validating handling of QEMU with various
> memory address settings. All of the test cases are setting 'maxmem'
> to a value that exceeds the 32-bit address space, so these must all
> be skipped on 32-bit hosts.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/__init__.py   |  2 +-
>   tests/functional/qemu_test/decorators.py | 12 ++++++++++++
>   tests/functional/test_mem_addr_space.py  | 17 ++++++++++++++++-
>   3 files changed, 29 insertions(+), 2 deletions(-)


> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index 1651eb739a..d3a8cf0483 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -5,6 +5,7 @@
>   import importlib
>   import os
>   import platform
> +import sys
>   from unittest import skipUnless
>   
>   from .cmd import which
> @@ -118,3 +119,14 @@ def skipIfMissingImports(*args):
>   
>       return skipUnless(has_imports, 'required import(s) "%s" not installed' %
>                                      ", ".join(args))
> +
> +'''
> +Decorator to skip execution of a test on 32-bit targets
> +Example:
> +
> +  @skipIf32BitTarget()
> +'''
> +def skipIf32BitTarget():
> +    enoughBits = sys.maxsize > 2**32
> +    return skipUnless(enoughBits,
> +                      'Test requires a host with 64-bit address space')

skipIf32BitHost?


