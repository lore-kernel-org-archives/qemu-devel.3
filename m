Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ABECFC52C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0I41-0004wc-J2; Mon, 14 Oct 2024 06:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0I3t-0004uS-5w
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:12:25 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0I3p-0002Co-Fw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:12:24 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c97cc837c3so1235549a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728900738; x=1729505538; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yJaFDhCJ8CniFR/QX4wpVIen0lcgsZNWDE3/cSAp79w=;
 b=LLD/2jHq+mM4DHXxYsX/iJJnR/mUbL1OCCciztlU7ULbIFglzbDTHPkGLea4lDLkcD
 1ixGwhQ7J3canMh0xspvIwHREGp0T0gV3V28d5byDFivqpziVuks78d9XUETtC5brxbT
 OkQC7zk0MAggsS4aqsPmCWXRzrSkarGhXZ/DrFoNi/j3QnrivggSnAmZoChEmV2CJiHr
 TQymdtj8ETnCniphYSozQZ5oQMTmeEnfIeAdCtYC7x5v6GstD1Rxo/5OQsujjXGoKWXx
 HhESL4HHbpWMGrBhCRAW4jzCdVs7NdlKMj/ijBs04fxiwkApD3oITqnUoHN6bEEIYzUU
 zsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728900738; x=1729505538;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJaFDhCJ8CniFR/QX4wpVIen0lcgsZNWDE3/cSAp79w=;
 b=iWJzgiZgYTJbfk02RkIDsSFm7AUTl7alEBpAm+FTmmvh6KWgQOYUfQLLYc8WWi2pI+
 lYZo04MI0UDtRAgMgvV21024nKvEWRlEG0SF21a3S1Q6bvBnfOdE+VmmPzmdx/S8gQrA
 WGWhKDaNoJK/Ghh6CT29Mx1UYepKywgeYFUjjNSYeRjCBXU434qz2bvLO092u61ThqVs
 tliEN88XI0vNZNEUxHgC+h5pdVfsSGhAzHEfpfP4r+ZNvY8VXOXCvtUlu7M8G3c21Nf1
 kJN4QT987MizXy90AtVhppRVYHtkNjRIbi1el2WlMntD4hexSDNyusVhkIfl20uWlrWF
 uGPg==
X-Gm-Message-State: AOJu0YyDq7gHN3VFNLZDrboQ642teW2vaS6i/NE9m/VXrRyBLXk/F+41
 EOLnCdF5n716WgoE6SelAoN/TGjTYCKRXMwh7pEKJXSgTKLZHMfkOeJ4ET+wRy2TTfEE7YN0Kco
 pd30ICy0chOXDS1zb+63hcRcO0qugC7RpTfm3Zw==
X-Google-Smtp-Source: AGHT+IFHXzvYzXeqpO6ElOYNyoPmIe66Lu4fskKfjCnzc5BktTLJicf+no4k/XcZRb9bRpHFL0P+vCdGhiMJBJ1RF8o=
X-Received: by 2002:a05:6402:5cd:b0:5c7:20fb:fce3 with SMTP id
 4fb4d7f45d1cf-5c948d246d4mr8076559a12.21.1728900737580; Mon, 14 Oct 2024
 03:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20241011153227.81770-1-pbonzini@redhat.com>
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 11:12:06 +0100
Message-ID: <CAFEAcA-2dR26AvpbV0dRob-Gc=wbN0Mh9rYYB19WH4Yr6ugXHQ@mail.gmail.com>
Subject: Re: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 11 Oct 2024 at 18:13, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 381d2c36e1242f849a55f4622e50b9a69cb92842:
>
>   docs: use consistent markup for footnotes (2024-10-11 13:08:32 +0200)
>
> v2->v3: new patches
> - scripts/archive-source: find directory name for subprojects
> - docs: fix invalid footnote syntax
> - docs: avoid footnotes consisting of just URLs
> - docs: use consistent markup for footnotes
>
> ----------------------------------------------------------------
> * first commit for Rust support
> * add CI job using Fedora + Rust nightly
> * fix detection of ATOMIC128 on x86_64
> * fix compilation with Sphinx 8.1.0
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes. (In particular, for the Rust stuff
we should be clear in the changelog about its status, including
security status, and what we recommend downstream distro
packagers do at this stage.)

-- PMM

