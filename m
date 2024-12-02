Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC46D10DBC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 08:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI1mU-00084I-Vb; Mon, 02 Dec 2024 03:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI1mT-00083o-CN
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI1mQ-0001CM-Np
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733128059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gikd+g9TTHlt9zFaPPtOippFHjVFapF4C1AbD6Oagn0=;
 b=XdUzW1MVn0ev/hosj0YK/QmDqDNNbLSCyb0lmhjLkTQ0LgYpE4MbqBwfx3FEurFM9VXGd7
 gq1Yo5zmDlHNZYiCsLvPh8bsgz7Gv6QUYZpim/doelrJaCzQgM4C0SvOejwTBncVRMnPXd
 cyGOKhlxj4ROPxXMwIGLgxKBGzn05UQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-XDy6hhnIMA6pQXjb7cv6sw-1; Mon, 02 Dec 2024 03:27:37 -0500
X-MC-Unique: XDy6hhnIMA6pQXjb7cv6sw-1
X-Mimecast-MFC-AGG-ID: XDy6hhnIMA6pQXjb7cv6sw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a90fecfeso29280275e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 00:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733128056; x=1733732856;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Gikd+g9TTHlt9zFaPPtOippFHjVFapF4C1AbD6Oagn0=;
 b=UJRgKypTMeNLbQQIFPLDzkhI03u86l5D8rZfYjcTRexwFIPS/Uau4pkEKZJO2wek9B
 Xcini1dRJiKGZSdvW5ZuLKewzvG4+h4xw+/WW2BkShkFTSbEGKxKAPO3geTWmswO/rQF
 D0hTtUrUPGnLnp6AMP0wm71wTVYo4Zbov8CI8Npo3eIrEvFs5jCesa4IFyxMHOU2vu5s
 Zz51EXNDaQ+9LfaoGIKkmcr53xoNrMa7saKYcHgwbbuBk5RkCUdXWW/PZSBc3dMjrZR6
 40gWh0+aqUJIHj8NPf6F6YjLWs6X0de83KXS2+LL3lrUcvOrESLy1ZT8Y3JOIxCPDeRO
 5cLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLF/wKYQMqd1smvKaPYxUCEM9GBJCwTw7Cb0beEODZhhu652Ktzw4wEXtKU/C4fVXuWu9rmv6KQZny@nongnu.org
X-Gm-Message-State: AOJu0YxEE/sJVDbp/fIGEsUIX4enT74QkLPH2qgjqPYWGGRJIfjWkEi/
 EFfXjdc5MA1MbMiCglhl0pXmQzGGdyrwp+o5eaeHEbPoqmTrH/ZGf9dgsHVLO7oiqaXvzoG+9IW
 +PtIYBKnSuGrXOZN2KE4X+e3ALX4xwT0X7Mg/i3mSPaykvKdAjMyq
X-Gm-Gg: ASbGncssZShD95P7LKuUOdFzvQQY4q0JhBQ5jzYlUH5cC/zfxAurYlGdRWLUZr+KIi2
 96LupMy5zqvRYotSj3fW04HT5H6N6RSPACtIJARhbUOlv5lAbXLUJZmtQ/mskq9iW3wGNeQbWju
 gz/E04YEH8V0A8vYt7RWXleFotXtfcHcg/RwyX4ED4DxF3AJAxSD7ZrWz9M9ezAgpkb3Gs+Erc0
 BEDWYb4b3FN+kKn1qIpIkWFvxxfYNb6KRBJ2Kig0Z48X+nIlSk2DXJYQWkO1XgVR7zwzk5qRr0=
X-Received: by 2002:a05:600c:4747:b0:431:586e:7e7 with SMTP id
 5b1f17b1804b1-434a9dbc646mr165862125e9.1.1733128056144; 
 Mon, 02 Dec 2024 00:27:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfRajvcQgXz1bMA5aOt7KjAM71F30b84LucXoS8wEgl9S9JEaWBR/PWux4HUkuP5k+L4VPWw==
X-Received: by 2002:a05:600c:4747:b0:431:586e:7e7 with SMTP id
 5b1f17b1804b1-434a9dbc646mr165861975e9.1.1733128055771; 
 Mon, 02 Dec 2024 00:27:35 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dc9707sm145491015e9.25.2024.12.02.00.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 00:27:35 -0800 (PST)
Message-ID: <3cc78a57-98c0-4dec-89f3-3b277603ae78@redhat.com>
Date: Mon, 2 Dec 2024 09:27:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] tests/functional: introduce some helpful decorators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> Reduce repeated boilerplate with some helper decorators:
> 
>   @skipIfNotPlatform("x86_64", "aarch64")
> 
>    => Skip unless the build host platform matches
> 
>   @skipIfMissingCommands("mkisofs", "losetup")
> 
>    => Skips unless all listed commands are found in $PATH
> 
>   @skipIfMissingImports("numpy", "cv2")
> 
>    => Skips unless all listed modules can be imported
> 
>   @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")
> 
>    => Skips unless env var requests flaky tests with the
>       reason documented in the referenced gitlab bug
> 
>   @skipBigData
> 
>    => Skips unless env var permits tests creating big data files
> 
>   @skipUntrustedTest
> 
>    => Skips unless env var permits tests which are potentially
>       dangerous to the host

That are good ideas! And certainly less error prone than specifying the 
names of the environment variables over and over again.

> diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
> index 8fddddbe67..7dee3522f2 100644
> --- a/tests/functional/qemu_test/__init__.py
> +++ b/tests/functional/qemu_test/__init__.py
> @@ -13,3 +13,6 @@
>       exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
>   from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
>   from .linuxkernel import LinuxKernelTest
> +from .decorators import skipIfMissingCommands, skipIfNotMachine, \
> +    skipFlakyTest, skipUntrustedTest, skipBigDataTest, \
> +    skipIfMissingImports
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> new file mode 100644
> index 0000000000..d25fec7b2d
> --- /dev/null
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Decorators useful in functional tests
> +
> +import os
> +import platform
> +from unittest import skipUnless
> +
> +from .cmd import which
> +
> +'''
> +Decorator to skip execution of a test if the list
> +of command binaries is not available in $PATH.
> +Example:
> +
> +  @skipIfMissingCommands("mkisofs", "losetup")
> +'''
> +def skipIfMissingCommands(*args):
> +    def has_cmds(cmdlist):
> +        for cmd in cmdlist:
> +            if not which(cmd):
> +                return False
> +        return True
> +
> +    return skipUnless(lambda: has_cmds(args),
> +                      'required commands(s) "%s" not installed' %

s/commands(s)/command(s)/ ?

> +                      ", ".join(args))
> +
> +'''
> +Decorator to skip execution of a test if the current
> +host machine does not match one of the permitted
> +machines.
> +Example
> +
> +  @skipIfNotMachine("x86_64", "aarch64")
> +'''
> +def skipIfNotMachine(*args):
> +    return skipUnless(lambda: platform.machine() in args,
> +                        'not running on required machine(s) "%s"' %

plural sounds strange here (like all machines would be required at the same 
time), I'd maybe say "not running on one of the required machine(s)" ?

> +                        ", ".join(args))
> +
> +'''
> +Decorator to skip execution of flaky tests, unless
> +the $QEMU_TEST_FLAKY_TESTS env var is set. A bug URL

Since it is the "official" documentation of this decorator, I'd maybe rather 
use the full words: "environment variable" instead of "env var"

> +must be provided that documents the observed failure
> +behaviour, so it can be tracked & re-evaluated in future.
> +
> +Historical tests may be providing "None" as the bug_url
> +but this should not be done for new test.
> +
> +Example:
> +
> +  @skipFlakyTest("https://gitlab.com/qemu-project/qemu/-/issues/NNN")
> +'''
> +def skipFlakyTest(bug_url):
> +    if bug_url is None:
> +        bug_url = "FIXME: reproduce flaky test and file bug report or remove"
> +    return skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'),
> +                      f'Test is unstable: {bug_url}')
> +
> +'''
> +Decorator to skip execution of tests which are likely
> +to execute untrusted commands on the host, or commands
> +which process untrusted code, unles the

s/unles/unless/

> +$QEMU_TEST_ALLOW_UNTRUSTED_CODE env var is set.
> +Example:
> +
> +  @skipUntrustedTest()
> +'''
> +def skipUntrustedTest():
> +    return skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'),
> +                      'Test runs untrusted code / processes untrusted data')
> +
> +'''
> +Decorator to skip execution of tests which need large
> +data storage on the host, unless the
> +$QEMU_TEST_ALLOW_LARGE_STORAGE env var is set

Maybe we should also provide some direction what is meant with large 
storage. I've seen some tests that are skipped since they create a disk file 
with 128 MiB. And others are always executed though they create a disk file 
with 512 MiB or even more. What would be a good recommendation here?
(My gut feeling is maybe ~ 1 GiB? Or better less?)

> +Example:
> +
> +  @skipBigDataTest()
> +'''
> +def skipBigDataTest():
> +    return skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'),
> +                      'Test required large host storage space')

s/required/requires/ ?
(the other decorators use present tense, too)

> +'''
> +Decorator to skip execution of a test if the list
> +of python imports is not available.
> +Example:
> +
> +  @skipIfMissingImports("numpy", "cv2")
> +'''
> +def skipIfMissingImports(*args):
> +    def has_imports(importlist):
> +        for impname in importlist:
> +            try:
> +                import impname
> +            except ImportError:
> +                return False
> +        return True
> +
> +    return skipUnless(lambda: has_imports(args),
> +                      'required imports(s) "%s" not installed' %

s/imports(s)/import(s)/ ?

> +                      ", ".join(args))

  Thomas


