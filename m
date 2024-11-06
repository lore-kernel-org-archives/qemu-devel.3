Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9ABD59F53
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jbL-0008Cp-Sz; Wed, 06 Nov 2024 12:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jbJ-0008Ce-Ln
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:13:49 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jbH-0006Xm-Mm
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:13:49 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so322485e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730913226; x=1731518026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lf/fduOrI62mj3L6jsDXUi1wvVXBCifqB8irtE1aL4A=;
 b=EixIhfO2AqMfvcFeZqRiA9E2mkX+G7y7YpQwYKStJKZv7IQRR2FZsjac9beCKbf0Fj
 mFb+w3UNgdZwEnq7HCL9TxvXNzheefQ/QfzCRFxlv0ezOuAli4uwVNEMulLUZONJZw53
 dzkQh3Gw95HvSytXBBhfCUITS9d1mKj29uMW9w430Eye1ue/yd9KjjTP8Ra9Ooh6qKV5
 MGgyg/K1Z/uC0Klt97rGFFsRjib7xrdNC9j0y7m9sP3mBib19xwvFkHTR5nBpDOFjVPA
 U54MiOLrL04A73eR5MfPGl9XqYd0P5lgpWAkT/xGvn2Mh/zxdXh0Jg+R4hVTJ847mHuY
 TZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730913226; x=1731518026;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lf/fduOrI62mj3L6jsDXUi1wvVXBCifqB8irtE1aL4A=;
 b=M5bQNQo/Ij+xhv7qa5/vvZqJesox/xxBgHwlUYJsKzVcn1uNfwOicowc2MaS1TmhDq
 0Fps5pvqm8JIYE51D8i+X4TwgTk9GRBCOTNCeb8CCG07fAmz2w2hISJeJMwcO4EKohNO
 Us1OW4JXJTrmIr8dBhdxD2jpk+hsaEH9m/TAeivtz1jZU+/yZl7nMuBAvZcZfDTeRlC1
 v7K8xmXkO7zduXe9r15DSJjtcpJomwEWDGLeBdlP63LVLVJy2jI6LaqYTzymdVoqzFqH
 3hB0pkJ8k8D2wL1/zQMiTXE81sx94Lj6sqWxpi+o2dCkIoyyX+1m/bdPj7hkUM5y0gbj
 ZocA==
X-Gm-Message-State: AOJu0Yx7VXZ68b5ZT5P73CAXzfEvukB3Gxf8JsoyWzgIwV/XUX6RTSAn
 G8daA4qhPIDIu0Yhf/rFG5y9SyXrniHbh3Gk3+hrV48QC+EMsLvAa4ugHx1RuDUgOzJzS5575yT
 WYd8SRJ8w
X-Google-Smtp-Source: AGHT+IE91/VzmzzIL6WFQ19nHML1GUvucmzybaek4uYROeBqU2BaZsst/heSSbh20Sqh2TQ995L/7A==
X-Received: by 2002:a05:600c:4f85:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-4327b6fd60dmr205327165e9.11.1730913225657; 
 Wed, 06 Nov 2024 09:13:45 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6ce192sm30432705e9.26.2024.11.06.09.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:13:45 -0800 (PST)
Message-ID: <c240de83-a429-4e52-beca-97ec0a1488c8@linaro.org>
Date: Wed, 6 Nov 2024 09:13:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] Enable building plugins on Windows with Clang
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/30/24 21:04, Pierrick Bouvier wrote:
> For now, it was only possible to build plugins using GCC on Windows. However,
> windows-aarch64 only supports Clang.
> 
> The first patches (already posted and normally pulled) are fixes and
> prerequisite to build plugins with meson. They are integrated here because it's
> not possible to have two based-on in the cover letter.
> 
> Then, we fix compilation warnings on Windows.
> After that, we can enable linking with Clang on Windows.
> 
> Finally, we enhanced the plugin symbols export list (automatically generated,
> and not a static file), and we report some of the information we discovered on
> the path in the documentation.
> 
> Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and aarch64
> hosts.
> 
> Pierrick Bouvier (12):
>    scripts: remove erroneous file that breaks git clone on Windows
>    contrib/plugins/cflow: fix warning
>    meson: build contrib/plugins with meson
>    contrib/plugins: remove Makefile for contrib/plugins
>    qga: fix -Wsometimes-uninitialized windows warning
>    qga: fix missing static and prototypes windows warnings
>    win32: use compiler option instead of attribute gcc_struct
>    plugins: enable linking with clang/lld
>    plugins: add missing export for qemu_plugin_num_vcpus
>    plugins: detect qemu plugin API symbols from header
>    plugins: eradicate qemu-plugins.symbols static file
>    docs: add information on how to setup build environments
> 
>   MAINTAINERS                               |   1 +
>   docs/about/build-platforms.rst            |   4 +-
>   docs/devel/build-system.rst               | 100 ++++++++++++++++++++++
>   configure                                 |  18 ----
>   Makefile                                  |  10 ---
>   meson.build                               |  14 ++-
>   include/qemu/compiler.h                   |   7 +-
>   include/qemu/qemu-plugin.h                |   1 +
>   subprojects/libvhost-user/libvhost-user.h |   6 +-
>   contrib/plugins/cflow.c                   |   6 +-
>   qga/commands-windows-ssh.c                |   2 +-
>   contrib/plugins/Makefile                  |  87 -------------------
>   contrib/plugins/meson.build               |  28 ++++++
>   plugins/meson.build                       |  36 ++++++--
>   plugins/qemu-plugins.symbols              |  59 -------------
>   qga/vss-win32/install.cpp                 |   6 +-
>   qga/vss-win32/provider.cpp                |   5 +-
>   qga/vss-win32/requester.cpp               |   8 +-
>   scripts/meson-buildoptions.               |   0
>   scripts/qemu-plugin-symbols.py            |  45 ++++++++++
>   tests/tcg/plugins/meson.build             |   3 +-
>   21 files changed, 238 insertions(+), 208 deletions(-)
>   delete mode 100644 contrib/plugins/Makefile
>   create mode 100644 contrib/plugins/meson.build
>   delete mode 100644 plugins/qemu-plugins.symbols
>   delete mode 100644 scripts/meson-buildoptions.
>   create mode 100755 scripts/qemu-plugin-symbols.py
> 

I won't make a v2 of this series, as the build with clang is currently 
impossible, due to use of gcc_struct attribute. Maintainers have a 
strong preference to wait for official support in clang.

Most of the interesting patches (build system, warning fix) have been 
pulled or will be though.

