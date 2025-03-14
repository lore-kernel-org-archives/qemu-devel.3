Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D6C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 16:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt896-0005Y1-00; Fri, 14 Mar 2025 12:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt88y-0005XW-8X
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:44:24 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt88v-0001vc-3b
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 12:44:19 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so1880756276.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741970655; x=1742575455; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tveQHSPaS+AlTWhls9X/c/Yt5dERDeAm5jVUIi8lTNQ=;
 b=LEXcUPa9m1pmfq0+ZPDMcXzwOTZ5vzA7VMaTlo4DL5NKbaplKvsQON7WFH7I0Y+98x
 V8jI+10h0/NF7KkmPR83jXjn7qjHOQgIRbpMOlN3njTnWNM5DP20YRV/KPXBDUec69F8
 35woXxms4BCZLOCoAtXXNyw18aYnBI3RRpuQEL4+PxCjl4LYoMi79C7hOntiYvE5ek7x
 sHaSkFXfqhW/r5EJ9yg0kcgmYWbXuq5ullC+WxrXSHPmtlpZ/y4B4WLjjSQOePPtFlGw
 X7fwmM0ADUz9yLvNbJEm3RuPI9+nY7UKOB3tf8kmQFlrWr4Fj4QBkGqxu8mg/aA529Aq
 gNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741970655; x=1742575455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tveQHSPaS+AlTWhls9X/c/Yt5dERDeAm5jVUIi8lTNQ=;
 b=cN/vpuc+BhH9f1j5D1AYrRj9tV/2A6m8TXuU6Ag9r235YAW7kH/WrUU/wW8TjvCGen
 YjtFBsiBV7mpJ4v9CrIkqXvGthUau1iZ53M+C0J7ZPbWu6HMb/ZORzinx1asFR8DOObb
 g2fnAlLGBni4ibpPW9UC1Kaaw7HWh2tSYLZEPIuNxSeZBxL0/f0GKzOoTrYCFAjY+kB4
 zAFdbNu9M+5liRjtxnDNGqMk5lu7xgNu0nx/EikDEqcUv1+76+UUYbQbtcMAYuYgvHpC
 sOeTh4ItGPbzN/8fyL/eiR9MZt4cgAiPArwgiEKz5R+upHk0uhyrGlFfpvDLHG6OJjis
 D/Ug==
X-Gm-Message-State: AOJu0Yxe090PfVRxVNHf0s44FPG4KoCweBPHcX48R9eDDIwwtaSg+Zf2
 3lg4tB1e+2N1HDYqHAvChZuFIR+W+D1svUJ3w+DZnBFHIDIgfiHv5gmw5KIqdJZJEH+bQxXWFsu
 FMZ3tj/xMxTN/EC4dhbdR1zut00SS2Kpgdq++kw==
X-Gm-Gg: ASbGncseJIvOT6xnG8AbsmDnN07y1gh5vyjrTszAr4miIu1iXn7d9ZNYvUgljB7ywVW
 oHWefG8UCTzyeK46Gd2VZFxDBMtA6VxBaITIiXg26D0rPhleTQ8BDxl1+RbUzV1PLajB1F6KMk9
 dfqO2cvT32mMP2QSpAaymNlFCokVbM+YWiTosdDA==
X-Google-Smtp-Source: AGHT+IFAKvtqe/7st8JfcFkt5hufzFuQV3HvhQO2GzJ25lLFSlQJX7yxHAqRGLwmFqce5GUdyj8PyeBvu9GGVoHHfeo=
X-Received: by 2002:a05:6902:2011:b0:e5b:1b55:1325 with SMTP id
 3f1490d57ef6-e63f652f73emr3669813276.25.1741970654956; Fri, 14 Mar 2025
 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250314153824.65303-1-pbonzini@redhat.com>
In-Reply-To: <20250314153824.65303-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Mar 2025 16:44:01 +0000
X-Gm-Features: AQ5f1JqHo5JB0WBWLymlbqYxEmoUPDYbzQ2EgIiVvj6L3m9TsknxF_p23T3gxTE
Message-ID: <CAFEAcA8J05Mp+VB9j+PEcB=ttpeAVZ-rJOPRAP53jhSqnp4oMA@mail.gmail.com>
Subject: Re: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Konstantin Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Fri, 14 Mar 2025 at 15:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> -gsplit-dwarf is reported to produce broken binaries on Windows.
> The linker produces warnings but exits successfully:
>
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
> qga/qemu-ga.exe:/4: section below image base
> /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/bin/ld:
> qga/qemu-ga.exe:/24: section below image base
>
> and as a result qemu-ga.exe fails to start.
>
> On top of this, also disable -gsplit-dwarf unless building from git.
> Similar to -Werror, split debug info is probably not the best choice
> for people that want to build for installing.
>
> (Random thoughts: there is a tension here between adding an option
> that is useful for QEMU developers, and messing things up for everyone
> else by doing something decidedly non-standard.  For example, distros
> are starting to create a fake git repository just so that they can
> use "git am" to apply patches; while some of them, for example Fedora,
> are wise, or paranoid, enough to pass --disable-XXX for everything and
> then turn back on what they want, it cannot be expected that everyone
> does this.  It may be safer to make --enable-split-debug default off
> for everybody and add it somewhere in docs/.  For now I am keeping it
> enabled but we could consider doing something different during the hard
> freeze period).
>
> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure         | 4 ++++
>  meson_options.txt | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 02f1dd2311f..9aece67ed08 100755
> --- a/configure
> +++ b/configure
> @@ -1864,6 +1864,10 @@ if test "$skip_meson" = no; then
>        { test "$host_os" = linux || test "$host_os" = "windows"; }; then
>        echo 'werror = true' >> $cross
>    fi
> +  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
> +      echo 'split_debug = true' >> $cross
> +  fi

Same remark as on the other patch: can we have a comment
explaining why we disable this on Windows, please, ideally
with a URL of a bug report against the toolchain ?

thanks
-- PMM

