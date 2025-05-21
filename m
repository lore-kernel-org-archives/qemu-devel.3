Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E8C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 10:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHgdO-0007vW-Uf; Wed, 21 May 2025 06:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHgdN-0007v8-8C
 for qemu-devel@nongnu.org; Wed, 21 May 2025 06:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uHgdK-00069P-TC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 06:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747823107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f06xahMSCC+mX6uINFhI8LXzLoZAcJW0RzYLwG52uek=;
 b=Ujrps9HN8nc5CbdEcU7zww006eLBJNhCpCzy0xRDUldS1a5N2/39bDgGVV/g6FWqNfITHw
 ZKJFKYtlRpbGGwpE7umeQm6FTRlZUvJ4H2jb90jqBA+1Amwk+pztLhYWsfouPiTb3u+osN
 9J9Y873ekt175P2SPuAjV3pZV353Lu8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-IsycTwQMOp262v6rX8nx4A-1; Wed, 21 May 2025 06:25:05 -0400
X-MC-Unique: IsycTwQMOp262v6rX8nx4A-1
X-Mimecast-MFC-AGG-ID: IsycTwQMOp262v6rX8nx4A_1747823105
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so44527015e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 03:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747823104; x=1748427904;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f06xahMSCC+mX6uINFhI8LXzLoZAcJW0RzYLwG52uek=;
 b=pdU+85nmMCbwf5f2HjtlrBse7l72UxNKHEX4orZWtL7wVepjfDtFVeNEXRS81PoA+L
 aAsaXYDQdDq2hQfNOaOh4VAzzxtSDWHgQrsORuaWujH83RF7Zt3uozZC3ObpjStioTKS
 o79Kt9QEBD6GvksmTGv8gbAcDfnHpr4ZcJpgpMt2rikZtUMqvUslLxJD3mpyV7AeFCSF
 jVX8TcC8vFqIhMAhmwMygcZFCHAzPiiHcx9aL7votvwT16hj4VHvbYmDGLTDOcmhiQPd
 USTgt0wYDtF9pyx9Ov1l4ZBI/79RFIC+KGgo8oRgML+PVL+CXD6w86WbZJ4c6GDktcqf
 bErA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiPQUmkzvDd9ch1N70pR79pCvcShBeivx6hE3JjMCzy8vdhxEH7GipNwHnlkAqTaOZLpOmAEcZQv+r@nongnu.org
X-Gm-Message-State: AOJu0Yyc9L5qmwR+QLqBpIBYL7x90ghpZZtdTqx8h76mVqPhcNANvVz4
 PrecIsFG9RqoT5xW/1VxBKMlqoAbcvRwug2OcFFJnSAnMv1riIxIuB5Nbx7R9aX+FTVHWQIWANV
 NFGBZx2j+6y816omnCHEl98yfmeqY5e3SQJR0WaNFgCI0u5uqjGotsSTw
X-Gm-Gg: ASbGncs191x8mHPpBhhHwB6p+i6fWM3x1B0X+bN4FW7M8ugDYqVKrtBodCKbRxV/JoJ
 AjQ0h3JSARhTMIPoVokuZNFo+MFW2k1eyReAk7oaM/Sx6IOU2XbEtMqxnuseUoc175YnDmteBMS
 j9V7vFT0QE4SzA7vLMlBNL6gSNnbvvDZDG2o8k9Plnq4zD2nv6wC7c/qDbk0aaNJIq8wvqoFRjt
 Z9OypzIwNgKuuHRx76e0SsMgOGZ+k86Xy/dATVbPZAV4uxeQfQRWscUpKHBqoOIexA2jsy3LWQe
 j4xoyFMJ774zfeUO2dH7WqEjBxaxfYmn412FUrVXWow=
X-Received: by 2002:a05:600c:8487:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-442fefd77c6mr171786745e9.1.1747823104548; 
 Wed, 21 May 2025 03:25:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQWy9RxCi2B250DZKTGe2NKlTZcBN2Gc9HTIp6VEjsTwRQddGll24ANhkNgPNc67J26NzQoQ==
X-Received: by 2002:a05:600c:8487:b0:43c:e7ae:4bc9 with SMTP id
 5b1f17b1804b1-442fefd77c6mr171786555e9.1.1747823104156; 
 Wed, 21 May 2025 03:25:04 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-448ba3d8facsm40429075e9.6.2025.05.21.03.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 03:25:03 -0700 (PDT)
Message-ID: <6a81df21-2da2-497c-8d6e-23d04d225575@redhat.com>
Date: Wed, 21 May 2025 12:25:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] tests/functional: add skipLockedMemoryTest
 decorator
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250417114008.169350-1-dtalexundeer@yandex-team.ru>
 <20250417114008.169350-2-dtalexundeer@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250417114008.169350-2-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

On 17/04/2025 13.40, Alexandr Moshkov wrote:
> Used in future commit to skipping execution of a tests if the system's
> locked memory limit is below the required threshold.
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   tests/functional/qemu_test/__init__.py   |  2 +-
>   tests/functional/qemu_test/decorators.py | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index af41c2c6a2..6e666a059f 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -15,6 +15,6 @@
>   from .linuxkernel import LinuxKernelTest
>   from .decorators import skipIfMissingCommands, skipIfNotMachine, \
>       skipFlakyTest, skipUntrustedTest, skipBigDataTest, skipSlowTest, \
> -    skipIfMissingImports, skipIfOperatingSystem
> +    skipIfMissingImports, skipIfOperatingSystem, skipLockedMemoryTest
>   from .archive import archive_extract
>   from .uncompress import uncompress
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index 50d29de533..c0d1567b14 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -5,6 +5,7 @@
>   import importlib
>   import os
>   import platform
> +import resource
>   from unittest import skipIf, skipUnless
>   
>   from .cmd import which
> @@ -131,3 +132,20 @@ def skipIfMissingImports(*args):
>   
>       return skipUnless(has_imports, 'required import(s) "%s" not installed' %
>                                      ", ".join(args))
> +
> +'''
> +Decorator to skip execution of a test if the system's
> +locked memory limit is below the required threshold.
> +Takes required locked memory threshold in kB.
> +Example:
> +
> +  @skipLockedMemoryTest(2_097_152)
> +'''
> +def skipLockedMemoryTest(locked_memory):
> +    # get memlock hard limit in bytes
> +    _, ulimit_memory = resource.getrlimit(resource.RLIMIT_MEMLOCK)
> +
> +    return skipUnless(
> +        ulimit_memory == resource.RLIM_INFINITY or ulimit_memory >= locked_memory * 1024,
> +        f'Test required {locked_memory} kB of available locked memory',
> +    )

Reviewed-by: Thomas Huth <thuth@redhat.com>


