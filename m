Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A3AC3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 18:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Ow1-0005Di-UY; Thu, 03 Apr 2025 14:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u0Ovs-0005BF-CX
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u0Ovl-0006e0-Va
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 14:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743703481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zA54mzJX1QM4ZbqBQn/Jr/oljogyDh/69nY++/8aROc=;
 b=dX3hId5boBi48XjcoXHgaU3gXhZ2oJ906IM6f1XP/y8+sbv7R2SGmKcFPiBKV8E7kh1HbE
 dHSpICRT75FxQT4eqcpnHNS/lcBbvXtDQ0WcmxRHyGwoRhFe+wusmiWcvTWN+NS0cEOTDf
 tLY8O7DVxjj5JdKrL2sVGMRJdwHyijI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-ME4EOxsoOjaWVHAxhymFBg-1; Thu, 03 Apr 2025 14:04:40 -0400
X-MC-Unique: ME4EOxsoOjaWVHAxhymFBg-1
X-Mimecast-MFC-AGG-ID: ME4EOxsoOjaWVHAxhymFBg_1743703479
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912e4e2033so635566f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 11:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703479; x=1744308279;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zA54mzJX1QM4ZbqBQn/Jr/oljogyDh/69nY++/8aROc=;
 b=LyrIBK7UogTIjrgacMe6TX9GzDfiFA+iqkyFTabOPEcXS9lRQjNB5uHWPuXJBWRq9A
 Xd6FFCB4cEzsArVrcDru+yghgb81MbYlU+61jDatzaWMEiZNX8lBEUWD021+6Z2yGA6n
 kGjexcwymPYkfsTy8f/Fdc0SxnxUlYikCs9I9hyZh8xJXsQmhI/iWwr37nCBceXDKCLS
 LIaDIYd5WwcYkC4yIrYIdhbmMU8X+VFOkbj2OQGbTm6J94jb/RJ4RFS7Lb/1pbb9xnH4
 vC+P2ysaqfez8LL9ou+fFE1oaabFz3LprLpxngM0HwFWTqK66t+9gepRF+OvJhScUgLz
 qLDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhGf0g80U/uAm847+MzjxARy9yjeP6Rdf2nT9x7e9iBst2oGJ5bpYgYAUkyMytgu03GwmpeI+klPGd@nongnu.org
X-Gm-Message-State: AOJu0Yy6zB+9dyLwI5MKHospAG5Ht7atWdIkp/Fh00rOWxw2Btq/w+1q
 qaiQZmvjhwPysPFzTt0SbiAz/rOn67wt8nXr+9fQ+bPEjEZ1vaj5BKpBQaLAtXbVQxjgHUU+9CP
 N6Frq7Gi7VjJf2lGSBU4ctochSnIIZWrs43Y5bFesnZ0TKRDTRhCg
X-Gm-Gg: ASbGncsEeD779oX1/6qTmA+YSvsSUYlzvxgjTxm9xDUldQbMyWWC+Bsg8k90Gv6tf/x
 D2trUIZVgjPSKFtkawQgbGEHNMFZcxGS9Erp9gd1Wn8e8dF+QBpDvrz+uMXuc9MUVe+0LxLYXWt
 WXYzFV701BIheJ6fqs6jTTOnkkQtSW615RMRPgOOv55QUwevCSplJjOYhP4YxLxp1KNIeloOZk0
 rMKxPGCvxilawvcTCSQZVTzAbvGYkDNiqnTg9hoRLE5pFAxXMW93c+/K0OvXRL3myERDdDemXle
 woPq0vQ8tZq4ASH+ZXHf5+Vc6MN8cRVp71lTHLTlKZol
X-Received: by 2002:a05:6000:2489:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-39cb35aaaeamr280814f8f.32.1743703478921; 
 Thu, 03 Apr 2025 11:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvY9PmpMXz4cYGfu5GYif1bYn2tLZnL1GXdG8t3vb5h0XpXGyMwPGNuahoR45Mx7Oergww5A==
X-Received: by 2002:a05:6000:2489:b0:391:4873:7943 with SMTP id
 ffacd0b85a97d-39cb35aaaeamr280761f8f.32.1743703478312; 
 Thu, 03 Apr 2025 11:04:38 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-76.web.vodafone.de. [109.42.51.76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d9cfsm2368607f8f.78.2025.04.03.11.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 11:04:37 -0700 (PDT)
Message-ID: <7c417483-7d5d-456f-8187-56b5264f539e@redhat.com>
Date: Thu, 3 Apr 2025 20:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 02/14] tests/functional: Add a decorator for
 skipping tests on particular OS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>
References: <20250403151829.44858-1-philmd@linaro.org>
 <20250403151829.44858-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250403151829.44858-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/04/2025 17.18, Philippe Mathieu-Daudé wrote:
> Since tests might be failing on some operating systems,
> introduce the skipIfOperatingSystem() decorator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py   |  2 +-
>   tests/functional/qemu_test/decorators.py | 15 ++++++++++++++-
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 45f7befa374..af41c2c6a22 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -15,6 +15,6 @@
>   from .linuxkernel import LinuxKernelTest
>   from .decorators import skipIfMissingCommands, skipIfNotMachine, \
>       skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
> -    skipIfMissingImports
> +    skipIfMissingImports, skipIfOperatingSystem
>   from .archive import archive_extract
>   from .uncompress import uncompress
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index 1651eb739a7..b6a1d41c55c 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -5,7 +5,7 @@
>   import importlib
>   import os
>   import platform
> -from unittest import skipUnless
> +from unittest import skipIf, skipUnless
>   
>   from .cmd import which
>   
> @@ -26,6 +26,19 @@ def skipIfMissingCommands(*args):
>       return skipUnless(has_cmds, 'required command(s) "%s" not installed' %
>                                   ", ".join(args))
>   
> +'''
> +Decorator to skip execution of a test if the current
> +host operating system does not match one of the permitted
> +ones.

"permitted ones" sounds like you'd need to specify the ones that are allowed 
to run the test, but it's rather the other way round, you have to specify 
the ones that are not able to run the test. I'd suggest to rewrite the 
comment accordingly.

> +Example
> +
> +  @skipIfOperatingSystem("Linux", "Darwin")
> +'''
> +def skipIfOperatingSystem(*args):
> +    return skipIf(platform.system() in args,
> +                  'not running on one of the required OS(s) "%s"' %

Same here, maybe rather: "running on an OS (%s) that is not able to run this 
test" ?

  Thomas


