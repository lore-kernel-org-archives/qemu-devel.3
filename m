Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F328C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 12:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFCcJ-0007vH-EL; Thu, 06 Jun 2024 08:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCcH-0007uv-M2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:53:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sFCcF-00050K-Tn
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 08:53:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42163fed884so655735e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 05:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717678394; x=1718283194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tr8fX3JUlpurx/NdhH5O+ErUpu/8WmiPn+iVeOfsrhc=;
 b=MLeLIwiv+1OVxzEPx65msJ53P2rF1pm/CcvtrCcST0QNPjvNyvv8Q/SS0jDkfUXL8D
 EsToV0ssC0a2lXwuMqp4MaNrB2PqpfYSs6zB+3YJCFcT5ozG9HIjOJAd56lopBqi7dYi
 mzq6ejo0uBf/VN19+O3Il1jkgepef5RTHDQbMaFs7tdYCq/MVqt8BqHzZHO16PyohGsD
 nQ8ULv2BibzRjWskVHXojgj3mG60hTQWrOLWKM/93JZa0pwjqvCaElHqNMvvvrwowpeE
 Y7khZu2hQxIzNKC9/y0I7vmyuJKQOAzEybKQq7co04gDGIjdY2IuWzOo3D/QZo2N4hwP
 VZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717678394; x=1718283194;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tr8fX3JUlpurx/NdhH5O+ErUpu/8WmiPn+iVeOfsrhc=;
 b=KjjwDBxvXAi4k8NuaUsvG8x12Uf7b5gwXTkLBtEQs+CQGZiALMJPCOQVkblO4c2XE8
 77L7rZ20gVxNjhydTXDKTjRg+8qxr5BAr5ypJq0TW7dfjPWxjoII/yYGUysKq7XfR6S2
 V67ZZm5o1MkzEkuXk5lNNqXp1DyfzOrT/oHtStFkTdfCENek5vL9hpLoml3F+s3HuDgT
 TtN6YSFi+flqrb/r0yUnnQsNJ6EMMKLOLDkUpas3aeNKJsaMEIxssEb8W3LkEux+B/jS
 wJKMKPtL8qiP7GW9WhMUH3aEHcj3tWXno+Rc3vFsB8b0WB6dHOxqdQxUuKBWPijJ/Q3G
 8axw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSEyRKJicCIrd8V46V4hj8O1LURcn6UcbU64kWkgrmBvSgm8Khl2OD5rnS859sZri9TcdSPj74vyk4BhAXuYID/ym+zKQ=
X-Gm-Message-State: AOJu0YxuruIrDHYN0dRAzr5XyBTqE6nzPl1VnbGLiMkg3/w6UwhFs+iM
 5q1nxiNWlwJaLMLOuq1t2nTy/dygUQtEsDQFBgJrTpkjAAEoWxe6iL4fsfQN2HQ=
X-Google-Smtp-Source: AGHT+IE3TZazcgcnmoYqR9FRgk3uIHSkT++w43C8WkRLipnpz7/gY0e/toLFy3H0ZPkP9bVNzJ1Law==
X-Received: by 2002:a05:600c:a42:b0:421:205f:52de with SMTP id
 5b1f17b1804b1-42156340d05mr46051425e9.26.1717678393943; 
 Thu, 06 Jun 2024 05:53:13 -0700 (PDT)
Received: from [192.168.183.175] (94.red-88-29-105.staticip.rima-tde.net.
 [88.29.105.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d69e71sm1475500f8f.65.2024.06.06.05.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 05:53:13 -0700 (PDT)
Message-ID: <f13e7f01-3058-463f-b74f-9f6369fa484c@linaro.org>
Date: Thu, 6 Jun 2024 14:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/5] meson: Pass objects and dependencies to
 declare_dependency()
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
References: <20240527104937.30443-1-pbonzini@redhat.com>
 <20240527104937.30443-4-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527104937.30443-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/5/24 12:49, Paolo Bonzini wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> We used to request declare_dependency() to link_whole static libraries.
> If a static library is a thin archive, GNU ld keeps all object files
> referenced by the archive open, and sometimes exceeds the open file limit.
> 
> Another problem with link_whole is that suboptimal handling of nested
> dependencies.
> 
> link_whole by itself does not propagate dependencies. In particular,
> gnutls, a dependency of crypto, is not propagated to its users, and we
> currently workaround the issue by declaring gnutls as a dependency for
> each crypto user.  On the other hand, if you write something like
> 
>    libfoo = static_library('foo', 'foo.c', dependencies: gnutls)
>    foo = declare_dependency(link_whole: libfoo)
> 
>    libbar = static_library('bar', 'bar.c', dependencies: foo)
>    bar = declare_dependency(link_whole: libbar, dependencies: foo)
>    executable('prog', sources: files('prog.c'), dependencies: [foo, bar])
> 
> hoping to propagate the gnutls dependency into bar.c, you'll see a
> linking failure for "prog", because the foo.c.o object file is included in
> libbar.a and therefore it is linked twice into "prog": once from libfoo.a
> and once from libbar.a.  Here Meson does not see the duplication, it
> just asks the linker to link all of libfoo.a and libbar.a into "prog".
> 
> Instead of using link_whole, extract objects included in static libraries
> and pass them to declare_dependency(); and then the dependencies can be
> added as well so that they are propagated, because object files on the
> linker command line are always deduplicated.
> 
> This requires Meson 1.1.0 or later.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-ID: <20240524-objects-v1-1-07cbbe96166b@daynix.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/build-system.rst    |  3 ++-
>   meson.build                    | 44 +++++++++++++++++++---------------
>   gdbstub/meson.build            |  4 ++--
>   pythondeps.toml                |  2 +-
>   tcg/meson.build                |  6 +++--
>   tests/qtest/libqos/meson.build |  2 +-
>   6 files changed, 35 insertions(+), 26 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


