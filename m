Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4714D1812A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0NZ4-0002Dl-IT; Mon, 14 Oct 2024 12:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0NYs-0002Ct-0s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:04:47 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0NYn-0005gZ-8t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:04:42 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c9625cfe4dso3158051a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728921878; x=1729526678; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WXXoG0ooP8NCZGwSsVydSt1QCz7l6JRtzYFrC+yHzD0=;
 b=V88uYV0bssPSjl3ILQF5YhTLWpD9T4jlEQumvhG+ruJFWU3nl632jUhh+o9jQu6FlZ
 dX9yOMKpizFKcgCLnKb6pEEk8ChPtt3bxS2dbwbJOFwD9jGDOb40rjminMR408VrHtbQ
 F/y1a8EAcpTrgNBbfJmfq3OoxlJ21E4OAoooGMJsgyX6z19cH6CRQg/DAHTfEAhY72Pl
 W9ddj98ImL32cau43X2Ett6dUeN9xPYcHWur+7+H0V2xR8VKIUa3cSnbL8FbBRw+i9UP
 qmQBHKzSkPvz11ONnvtMCh1Az01T2QLq8xuhy05XYMUJ+WgyUagZojdm4+zVNDPZnvKA
 oVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921878; x=1729526678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WXXoG0ooP8NCZGwSsVydSt1QCz7l6JRtzYFrC+yHzD0=;
 b=tdNEgpvBnybYGFNNW+TKykJl7DfIzaMYXSdVvnnKBVoVaKbiRvh1owNGe3eERH1EIu
 i8QjthqX6uEglQMqEXvtYZUBRKANsEL+tjytTF5UODTE9MPXacEbF0jS6rOM5ip+z8+/
 FfT6WilTPEZSUGubxzGJm+406L40lQwm7yBuARYu9M2jPjzkpLw4bfyOLurPb/XTZ02r
 vXala5v49kUfc42D2NE2vQNcB7elF4ir26EzfTXpNWBaeiuczpsfv5zQYRpg3DZzfE3E
 5VngXsnQL24tFub2gafOEKZeY4Dzvu24BxJNsS9FTIpxTRhYXLmJutW+vE2bAD0yaQhL
 lduQ==
X-Gm-Message-State: AOJu0YwK9sMYYBCs1fJgpCB/arVgGEFHcBGIYUWxEfzmQIPMmMTzlOHC
 KDq+Yue3A+Rp2j20vAI9fg4CLleMuil06GFWkhGUDtp3Th9I4+F48Ae89+FgnCp27BgCguDtGKk
 RvEKVfC2q4EF0XyvIeYtkdG59SfAgyExFGWnLYQ==
X-Google-Smtp-Source: AGHT+IGJJ85rpEmct88Zi9+AscL+YkSb4PhArnZiLCBx0xjbpw5ilC85+WTgfHQV4NQ0a8yaMp/TsVVKGMZreRBom2c=
X-Received: by 2002:a50:cbcd:0:b0:5bf:1bd:adb3 with SMTP id
 4fb4d7f45d1cf-5c95ac0dbb9mr5803965a12.14.1728921878223; Mon, 14 Oct 2024
 09:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241014143640.196735-1-pbonzini@redhat.com>
In-Reply-To: <20241014143640.196735-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 17:04:26 +0100
Message-ID: <CAFEAcA8n81hFE0ZpuXEBUnWFmH1L0WPde9t17D6vqtwup3Aqkg@mail.gmail.com>
Subject: Re: [PATCH] meson: check in main meson.build for native Rust compiler
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 14 Oct 2024 at 15:36, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> A working native Rust compiler is always needed in order to compile Rust
> code, even when cross compiling, in order to build the procedural macros
> that QEMU uses.
>
> Right now, the check is done in rust/qemu-api-macros/meson.build, but this
> has two disadvantages.  First, it makes the build fail when the Meson "rust"
> option is set to "auto" (instead, Rust support should be disabled).  Second,
> add_languages() is one of the few functions that are executed even by
> "meson introspect", except that "meson introspect" executes both branches
> of "if" statements!  Therefore, "meson introspect" tries to look for a
> Rust compiler even if the option is disabled---and then fails because
> the compiler is required by rust/qemu-api-macros/meson.build.  This is
> visible for example if the compilation host has a stale
> scripts/meson-buildoptions.sh and no rustc installed.
>
> Both issues can be fixed by moving the check to the main meson.build,
> together with the check for the cross compiler.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> ---


Applied directly to git, thanks.

-- PMM

