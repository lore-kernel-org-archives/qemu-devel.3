Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22B606A32E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f6EnznzM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNOh-0006Gv-3R; Fri, 06 Nov 2026 12:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPNOe-0006Gk-9r
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:06:36 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xPNOY-0001hk-R1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:06:36 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b305e10ac7so7227187b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 09:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793984789; cv=none;
 d=google.com; s=arc-20260327;
 b=YEkOzG8vEu8NSvaVT7K9jClIqFE5e2JTCYMpHxgK6bkeKdSIyTqsoYe+PNc9E3yfNX
 qKW/VahX7+O5Npua6fAYhrQyfQGw7Ue/5TTryIw4dAxFlPY+gz7w4mHCqjePJQ2Tbz7y
 ILDK0vyp/aJxNCKbi6Sj1gZJug3vFcr4cVeoiixzG0wKOaffjnnIAr8l6S/YW8UcUVe2
 ahnG7PU1OaV7fsptlQkC6ShDdfKikxQPvC2m33cMbVCHsgGc0FgAoRX05zukgXcq/dwh
 VMoxzEaZy2ngXX0K06LoxDXmi2XMNKco4JWk/EK2IQ7nFDX0kt2mci9AP5bdzXAVZFO9
 GogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Zqe/LnXd8OtFc35dbN4GQtQkMUFWIyKVwUJ2gZ3cPbY=;
 fh=evYu65HJqNwMd16sFKkvgyTnNtakHsnIGR2/vsBd+ww=;
 b=M/gm6wTAClVfzYWPldWKTarG1Zbx1757vu6zPnZnfZ65nDUEkJlSnEb+BiAVg8Jho5
 0c19JMVZjqw0YbfRPa8yvy3ui8pDMy23ffPtWuRvEV4XvVsR4YxYdTT0A+qpZslpygg0
 zaHWN6ndBadbIeMxXhShi3kTYuGe2z1JulJqqujCptQkv7R4ElHMmd1YI00egXdZCxsz
 4PDn+/WXaorLNizAUZ+9k0Ql6lJzZV/6GIc5Pe79hxwbIaUM3UgEwgVOUR1gg9vysofH
 gzmNnil+tGSi4N/I0y3hpzmJrXHg7MGcPwJmT5h+eCEad5AW4AIPRDxdqnuYoeBisWRp
 LYnQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793984789; x=1794589589; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Zqe/LnXd8OtFc35dbN4GQtQkMUFWIyKVwUJ2gZ3cPbY=;
 b=f6EnznzMvT3EefaN0HT4hBbUqfEcGgbsW5JPwcY4jueTy0xYHer8WcIjQiHV4LhJT8
 nw2ZDPD9M0nVTHwfbjOy63mpbn9K8YygUnFM14DYxKMuOXK39K84Ne5e1OAujTcPGd1P
 P+2O0HzzpvmUNu9v20POi4D8O+l1uQg9FxeY8XyqMsyE515/pDzX6Zz9uYnSvpkyExd0
 ztMPloFzxgLMXDp6KvYEn81ymeZKb8rAj8IhiKc8yYEcvXnjKZXk8A5k6Z+O0mOfs6px
 xZK7/ghyNAtwpOEmIqxHG86P8OCdLl6G7+/J+U8cV4COkkuPMyY5wyqsThYbJpU4NMDr
 ndPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793984789; x=1794589589;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Zqe/LnXd8OtFc35dbN4GQtQkMUFWIyKVwUJ2gZ3cPbY=;
 b=BP+avdeypEvVTAPTTxplN63cydK1frylnJO0p5TvaCIB/A8BJcKC1OZAKHYInHCUFV
 0CtSdQXA68imYrz606RgrzLvPu/SnISMlr/UqEpK69aEEj2mPm76ERkD7rtVN2js3wU4
 EHjzrbVBrJLUlp+KoH2bgnbk5le+3vmq9ox4vql5La70qbIs4/bFza0vdmua5zpfKN0g
 tmrMmijJzeYOb5VYjMa/qQQa5HxQNCqMlKl6z6E7EUh8ktOJ9X2HqAMTGdCp9cGadOLR
 HVC/AJvn4/E6iWmFQfVGiH6ctAdMl76SN2D9YYjrygKta1H9eaqpYrWPItMYOKONgox/
 7YBg==
X-Gm-Message-State: APuU4Z+a5LU2cRpu2xrAtxqzW+CmYCOaI6NfRGdGLS+lDyZLIQRRieFP
 PT7hIBYWG4uTWX4T6K66Y+PJPyCfZKfWSKpWsnYmf8B23MZ3P0n3Ec6mmBuSjfwdSz8s52SxaVM
 oQtBI/klAn0ZSFrUWyATkRAE0Ah8onRAPbmuC3pBg9Q==
X-Gm-Gg: AYBFou2HJHe7eQhLcZSJAZYcKxqJ3yVccvVLp+Nnt0JcSotTUGaSR16aHPchsYP+AxP
 790f0KN4hH4KtGqWF5QOC46RGdwCOB2qKlqSt191dJY08FGVXIldAQ+X9YinhBbjZzfMS/WW+60
 2HWEvf7kBhBJYYDu/1pqSEoOjZn8C1bz438BglXzAY4O5xktTR+tilj9xKC273XB+lZEpxMjheK
 fMcdGl+ab8ZVZ11w42YNhaef0oJd5tLmjA2QqMcExC9f6JtS/Z0gnsERrJkp5LkV6hRUtNtTxW/
 MwIN0DPCtBg1mkPidAho9911jVwxinPZknv8McziJiJV4txMOzR597J+HtUSgW2CZn0hj7ufHAK
 Lmg/GhKkkMbv7a4jNmpsWPxwBnc2bESejV+4feQiE5oA301g1JT/tWa2kW1dHU9QIb/Ld/yaNL5
 ws8KUmL4vTL4y2mq9+K9CD
X-Received: by 2002:a05:690c:1c:b0:8b0:bc6c:9229 with SMTP id
 00721157ae682-8b34197215fmr18896507b3.27.1793984788828; Fri, 06 Nov 2026
 09:06:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106155858.3779237-1-peter.maydell@linaro.org>
 <20261106155858.3779237-2-peter.maydell@linaro.org>
 <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
In-Reply-To: <a66e5489-7898-43b6-a7c3-8a7a3deedbb7@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2026 17:06:17 +0000
X-Gm-Features: AclHuK_1S0v8OiSQmaAxPjFoeBzMLRMNp3fYvOuoBWGK8GXKi0S3PYbkBBr0Ni0
Message-ID: <CAFEAcA8jLh_5B563-Y-JmhFoimssDB71Lncq8vy4cf9RdqVm6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "meson: rewrite scripts/qemu-version.sh
 directly in meson.build"
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 16:59, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 11/6/2026 7:58 AM, Peter Maydell wrote:
> > This reverts commit ab78ac76f44a1241e76fd32d248df62d83f1ea58.
> >
> > The change to create the version header in meson.build loses
> > the dependency needed for the header file to be built when
> > it doesn't exist. This means that:
> >
> >  * if you delete the build/qemu-version.h file, an incremental
> >    rebuild fails, rather than recreating it
>
> That's not what I observe. From current master, file is correctly
> recreated. Do you still observe a problem with a clean build folder?

Yes.

$ git log --oneline -1
f71afb409a8 Merge tag 'pull-loongarch-20261105' of
https://github.com/bibo-mao/qemu into staging
$ rm -rf build/arm && mkdir build/arm && (cd build/arm &&
'../../configure'
'--target-list=arm-softmmu,aarch64-softmmu,arm-linux-user,aarch64-linux-user,aarch64_be-linux-user'
'--cc=ccache gcc' '--with-pkgversion=pm215' '--enable-debug'
'--enable-docs') && make -C build/arm -j20
[...]
$ make -C build/arm -j20
make: Entering directory '/home/pm215/qemu/build/arm'
[1/35] Generating tests/include/QAPI test (include) with a custom command
make: Leaving directory '/home/pm215/qemu/build/arm'
$ make -C build/arm -j20
make: Entering directory '/home/pm215/qemu/build/arm'
[1/27] Compiling C object qga/qemu-ga.p/main.c.o
FAILED: qga/qemu-ga.p/main.c.o
/usr/bin/ccache gcc -m64 -Iqga/qemu-ga.p -Iqga -I../../qga -I. -Iqapi
-Itrace -Iui -Iui/shader -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fdiagnostics-color=auto
-Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g -mcx16 -msse2
-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
-fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero
-fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body
-Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2
-Wformat-security -Wformat-y2k -Wignored-qualifiers
-Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute
-Wmissing-prototypes -Wnested-externs -Wold-style-declaration
-Wold-style-definition -Wredundant-decls -Wshadow=local
-Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings
-Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value
-isystem /home/pm215/qemu/linux-headers -isystem linux-headers -iquote
. -iquote /home/pm215/qemu -iquote /home/pm215/qemu/include -iquote
/home/pm215/qemu/host/include/x86_64 -iquote
/home/pm215/qemu/host/include/generic -iquote
/home/pm215/qemu/tcg/x86_64 -pthread -fPIE -MD -MQ
qga/qemu-ga.p/main.c.o -MF qga/qemu-ga.p/main.c.o.d -o
qga/qemu-ga.p/main.c.o -c ../../qga/main.c
In file included from ../../qga/main.c:33:
/home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
qemu-version.h: No such file or directory
   11 | #include "qemu-version.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
[etc]

I have run into this problem about a dozen times this week with
different build trees and different git branches, and it is very
annoying.

> The problem seems to be crossing this commit, which we can't do anything
> about since it's there.

Yeah, it's going to be a broken git bisect for that part of
history, which is unavoidable. But the current state of git
is (a) broken and (b) not clearly what we actually want, per
the other thread.

-- PMM

