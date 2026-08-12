Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED18C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu84H-0004g4-2S; Wed, 12 Aug 2026 08:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu84F-0004ck-7m
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:28:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu84D-0002uE-L4
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:28:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so7897315e9.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537700; x=1787142500; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7ij3+8VW7idpsr5F4bCyRDP9tJsfdaQIlG6y11raT8g=;
 b=OmVOMma6RGvwWCm+9ZDBALOxjibXtw0Oft8icXDp41LuAOtHMdZjUjCD3NJlWWMrm0
 PTUMAc1F53f03YgCZ4cPZqhHarL881icNlAM9UGSxs3pgrmwq8E5XTMoFY9g7GD8SXbz
 CsV61DD0J9U7Qwau8OiXNk/UUGgypqQQUGeEZ9/bmLZj+yG9gVskHKz0t1VaTjc8tG8e
 KZMpQnvv1iWf6AlMJc9GeVETd6P0CElBxRfZnDLh9Cs7YYqf+lpk3kFaXmCEeRQ7e9gf
 D/CiwSNIoOMe24GeP9GUN0p+04Oto1ERJBdNMUZV2T2cSLj7h0QjJjFoAIsx9B3gM0EV
 5Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537700; x=1787142500;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7ij3+8VW7idpsr5F4bCyRDP9tJsfdaQIlG6y11raT8g=;
 b=MgJhlNjMkpr7Yu6cZL15fLd8xw0YtxwQRQmX3NWjssXo6Vh4YnYc8EB3qqGhyA9mgA
 Z/a8w0/Yoi74960dXfZ9lZ2m1O+grwQLWfoTfRMQSErU+cfrOMtaqB5+JztThJtTGTKB
 PBL795DbQictEzQRhxu+L2cQ9WDuRCLAIEQUWTNd3rzHGLX8cM+IMUSbGbkBQ2+lQIVj
 Tva68ZFAHhNTBmabmfCMYqPCc0Y6QbveUqiBqGgzwGKEfLwez26KCcwfMv9UOVAIEtxV
 yvMcG6/YoUi3On28Gpcbc/yOwsushjTdYTo3N38StA2eg24+q+YgkQL3WofXjgXiqqdA
 5e9Q==
X-Gm-Message-State: AOJu0Yw1Xu+zfuzOEopJBM/FXCagP3scu+JbeZBD+srJK/Uy5/+TgBfz
 1augZV9rNs0Sn1PgUVDnue4/OnHIuQ+knIPfm20Sr1F6xQ6TJG/llxny2jb0xv4yVic=
X-Gm-Gg: AR+sD11DhGjJ0oUGuzYRAv7KEOAhyhpdALVYt1MQaTzinczmQCqKTi2wxiJcmpujhVX
 n6ApkNe5BC2v7buTDIdStN4qM/IfHGhv0KR9wwxi60vc/f4gDsCdWH/sLzVqe6NTrjijgJrfkW1
 CO+Ca5BLXal+RoNq4VT595RwdcEqhhb6cO1Nprn6ZpObG0JHOqG/cU5BHbZvM7tTKe2t/cjsZan
 Zrzw64vHgqcxJgH7dZOwEX6POTcYuLtnhCF+F7ZjzgLwZjmgrU3PW9kdyy28+q1MxTZaUWRaobE
 tP5+Nd/kAi/Y6JFmztrJEsJwUzb7SIVbrxvaYMP7iwEwCjRSGt8CXGoP0FJ2CvrbbARhLsSssxK
 nZRfD8vdr7SCsOAmRgJDQfmyG42oxb3lW6lGR3IB6wT7iXnui8GrQuXBS3t/NwQ0o5OoQ2xF8wp
 E/Rz6ryVUq7aWF0te7d7oGpEV1TSteT47QkpT/YNIGFu5WhwOSVk3oKSa0/uxv
X-Received: by 2002:a05:600c:46c6:b0:498:ee7:e407 with SMTP id
 5b1f17b1804b1-4997c1649f5mr53642565e9.17.1786537699666; 
 Wed, 12 Aug 2026 05:28:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997aaa4a8csm73800505e9.3.2026.08.12.05.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:28:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB3DA5F886;
 Wed, 12 Aug 2026 13:28:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 102/103] meson.build: add summary for TCG tests
In-Reply-To: <20260728044248.137626-103-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:46 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-103-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 13:28:17 +0100
Message-ID: <87pkznzfoe.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Replacing existing summary that only contained information about
> existing cross compilers with a full summary for all targets.
> We add gdb and container information.
> We specify cc for each target (softmmu + linux-user) independently
> in case we would use different cc for bare metal vs user binaries.
>
> Users can query full command line for tests by building tests with
> tcg-tests target, so no need to repeat it here.
>
> Output before change:
>
> $ ./configure
>   Cross compilers
>     aarch64                         : /path/to/qemu/build/pyvenv/bin/pyth=
on3 -B /path/to/qemu/tests/docker/docker.py --engine auto cc --cc aarch64-l=
inux-gnu-gcc -i qemu/debian-arm64-cross -s /path/to/qemu --
>     aarch64_be                      : /path/to/qemu/build/pyvenv/bin/pyth=
on3 -B /path/to/qemu/tests/docker/docker.py --engine auto cc --cc aarch64-l=
inux-gnu-gcc -i qemu/debian-all-test-cross -s /path/to/qemu --
>     alpha                           : alpha-linux-gnu-gcc
>     ...
>
> Output after change:
>
> $ ./configure --disable-containers
>   TCG tests
>     gdb                             : /usr/bin/gdb-multiarch
>     container command               : NO
>     cc for aarch64-softmmu          : NO
>     cc for aarch64-linux-user       : NO
>     cc for aarch64_be-linux-user    : NO
>     cc for alpha-softmmu            : alpha-linux-gnu-gcc
>
> $ ./configure --gdb=3Dgdb --container-command=3Dpodman
>   TCG tests
>     gdb                             : /usr/bin/gdb
>     container command               : podman
>     cc for aarch64-softmmu          : aarch64-linux-gnu-gcc (from 'debian=
-all-test-cross' container)
>     cc for aarch64-linux-user       : aarch64-linux-gnu-gcc (from 'debian=
-all-test-cross' container)
>     cc for aarch64_be-linux-user    : aarch64-linux-gnu-gcc (from 'debian=
-all-test-cross' container)
>     cc for alpha-softmmu            : alpha-linux-gnu-gcc
>     ...

Nice ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

