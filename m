Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F8BC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 19:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttASB-0006eJ-M5; Fri, 14 Mar 2025 15:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttASA-0006e5-IO
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 15:12:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ttAS3-0003dB-Mf
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 15:12:18 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225477548e1so45558015ad.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741979530; x=1742584330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0T7IyfPUaQS/KrTw/krn4syJRu51POk3pp1dll0cN7g=;
 b=Sm3HO0jDLfyFT5HcXDCNJJaYAznEkJByHpN12y4z8dYKMu9mKURK6fPjG3GPFgOp/a
 gNdq7AwPpNH2biGWV4IzAY1jfIY1n+QDZnBYXBE18s8gVqkbKxrSz9B+0QxaXWhRCyjM
 +7ntZmtZy6H+dPnWFzAlts94cAylcqJqdXgtOVD2hkgEnNfWm+ZonngSQlQTiyUjovxy
 uhcfRejn4qNVcn1WRWqUuuK67Nh1Ur1jLA2GtIIaDfIZK4awvTLfGKhPTB+42mYBvFU9
 cjkQgY1eFBZtYeX7dTfTk4ZssMrrMrkds/x/jspbdh7Q2Y06sSSXBs21oQjeZBtDfe6X
 76zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741979530; x=1742584330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0T7IyfPUaQS/KrTw/krn4syJRu51POk3pp1dll0cN7g=;
 b=G/Qrepxw/SkyGwPaeWG6t7ZuQEVcWnYqrVecPYdRzGBolWAyRwiUmE3Ap1WfhsnDbE
 f7M4yEQVsj8L7yiTxvYn/HajPeSQrR2zZOSrZxN25sog5xXxOZGgYXxey/OTVWjZDXQg
 Rw5uxv46e3TK8Q3xe/Umodpk/L38Y8I4BeK7JcXjR7bZiz/Wu2T+BvSw4RE04l72RatO
 yOhkYw9eCOWlmhrioPKrVUfOT7b8BmwxXD2vsS2yHYb9rGza+a+Io53q9jS1ATozVmu/
 iKaqFbfy6Pm26MQRSmAQ/rfwUaUDZOrlQdV31ACfietpFGO0Ntkx1WuefcXKLPYKcZan
 oCMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpHveOB53F+mDJ+4D1KHm2qOKl0ryTbXuvnJxFMhShqZyE4i6qUQbVZy1jWJ3uRAD5AFfHboyOWX7+@nongnu.org
X-Gm-Message-State: AOJu0YyDLq23/xk+yI0qloO1GdJaL6MZNnJ8KsVD0W+2GOKeJgBlbMvz
 M2gdSCHxhWX6iFV2D4emUdAXhvVOLxU6Kf6//DiqOpPdsZ7JmwM8p88fEqwDLrg=
X-Gm-Gg: ASbGncuemmT7moN8IJs4pkZKmEwH6ZRnSwlKhYwT7l8iCp1ZKeNHDaQ43bhJE8/n+eZ
 wUe9nTunXk1RTZ9j1ZQ3DSkMihQIAEtRc6B8UiJsTDzxuMrflRPH7foPdT0cSonk+Be6Q5/hbX1
 Wxhw4FQIpMY+u7in7ylJQuBdbF2oB+9aMvSFxsvG92V/a8smgO5BJaBjNqkS2Vvx1RRE/tTUdxR
 KrKKMfRZzAULWkyOaeisI8x8rKXEF7/MQh4EWq+3/JaY+dETMGcFJkVISIDVDnfIgmJ6QM/NBci
 qWISHmbrwmJSCmUyckaENzTrQjIaLRl51NkN6bJpOiAF342dO0PNo4f2nA==
X-Google-Smtp-Source: AGHT+IFU5lQUPPTjncITI3cJyInH/aqlvifE+B98Y2PU0+Qk25lRbcy8l50rPLTANycHgI0+VnzCcw==
X-Received: by 2002:a05:6a20:bc98:b0:1f6:6539:e026 with SMTP id
 adf61e73a8af0-1f66539ffb9mr381334637.15.1741979529768; 
 Fri, 14 Mar 2025 12:12:09 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea7c759sm2574713a12.59.2025.03.14.12.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 12:12:09 -0700 (PDT)
Message-ID: <44fc2b85-ab20-401a-9c71-54240bb1e503@linaro.org>
Date: Fri, 14 Mar 2025 12:12:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: disable split_debug on Windows and on non-git
 builds
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20250314153824.65303-1-pbonzini@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250314153824.65303-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/14/25 08:38, Paolo Bonzini wrote:
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
>   configure         | 4 ++++
>   meson_options.txt | 2 +-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 02f1dd2311f..9aece67ed08 100755
> --- a/configure
> +++ b/configure
> @@ -1864,6 +1864,10 @@ if test "$skip_meson" = no; then
>         { test "$host_os" = linux || test "$host_os" = "windows"; }; then
>         echo 'werror = true' >> $cross
>     fi
> +  if test -e "$source_path/.git" && test "$host_os" != "windows"; then
> +      echo 'split_debug = true' >> $cross
> +  fi
> +
>     echo "[project options]" >> $cross
>     if test "$SMBD" != ''; then
>       echo "smbd = $(meson_quote "$SMBD")" >> $cross
> diff --git a/meson_options.txt b/meson_options.txt
> index 3432123fee2..f3546b9abc1 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -362,7 +362,7 @@ option('debug_mutex', type: 'boolean', value: false,
>          description: 'mutex debugging support')
>   option('debug_stack_usage', type: 'boolean', value: false,
>          description: 'measure coroutine stack usage')
> -option('split_debug', type: 'boolean', value: true,
> +option('split_debug', type: 'boolean', value: false,
>          description: 'split debug info from object files')
>   option('qom_cast_debug', type: 'boolean', value: true,
>          description: 'cast debugging support')

Unfortunate coincidence, this appears at the same time MSYS2 fixed some 
issue triggering a segfault [1]. So I didn't investigate further the 
current issue, thinking something else have been changed I don't know where.

Would be better to revert it completely indeed, creating another build 
configuration is not worth the (cheap) disk storage saved.

[1] https://github.com/msys2/MINGW-packages/issues/23577

