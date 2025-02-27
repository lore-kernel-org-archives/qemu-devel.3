Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A151DC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnanq-0001C2-GJ; Thu, 27 Feb 2025 05:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1tnanh-0001Am-2X
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:07:31 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.granados@kernel.org>)
 id 1tnane-0006HM-GJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:07:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F7876114C;
 Thu, 27 Feb 2025 10:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905C9C4CEDD;
 Thu, 27 Feb 2025 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740650834;
 bh=dR2P4DeU4hjU5qXGCmg3q8hBwlnKbiLBsGak6c8YJoQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HT48FbPezlSNIDWsjMN8TOwbFNy1EKzC/5VNGmb6GizuUqHEopvv8o0NBvuLxK48a
 wbdXTXCNWFzG5D0k2a+YaIm1sY16NQbi2pkDhBU6rXp0K5hoiA1+fa9+tP1eP9q/a5
 y3zBhn9GD0Wf7bR5WtCPglkbQIjDhnEoZL9MxXd531ZLORVJ6lOg3/lKKIK8151WP4
 79WDo8EsgwmWLdSkIVvHJEEekkcjUwxRXM9ZeJVSIKjq/Xk1RG/X4JHyqoPr9Ua5sa
 oZcuvOCMGv4ifOb43O1jh6WrVEtKZY+XL5dtMRX87BolQzP0W79Y0WZWVTKIhKzfd5
 dsJHydfTQPMjg==
Date: Thu, 27 Feb 2025 11:07:05 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] build: Replace meson introspection argument with a
 builddir
Message-ID: <opabljxycyh2huu4yicopg5dkur56pntyehozkrp2tai5orgnz@frubtj4drvma>
References: <20250204-jag-fix_meson-v1-1-ecb6bdb1db51@kernel.org>
 <5ea3a240-1805-40f8-9c5d-af12794ea34c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea3a240-1805-40f8-9c5d-af12794ea34c@redhat.com>
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=joel.granados@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_SBL_A=0.1,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 24, 2025 at 11:57:24AM +0100, Paolo Bonzini wrote:
> On 2/4/25 21:10, Joel Granados wrote:
> > Replace the meson introspect argument with the build directory instead
> > of the meson.build file. The introspect command accepts an optional
> > build directory not a file.
> > 
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> > For some reason this causes an error when I "remote" compile qemu.
> > In any case, the introspect only accepts directories, so having it point
> > the to the meson.build file is a mistake.
> 
> Unfortunately, the help for "meson introspect" doesn't tell the whole
> story...  Instead, https://mesonbuild.com/IDE-integration.html under "Build
> options" says:
> 
>    Since Meson 0.50.0 it is also possible to get the default
>    buildoptions without a build directory by providing the root
>    meson.build instead of a build directory to meson introspect
>    --buildoptions.
> 
>    Running --buildoptions without a build directory produces the same
>    output as running it with a freshly configured build directory.
Thx for the clarification. Never would have thought to looking to the
IDE-integration. If it *is* supposed to work with the file instead of
the BUILDDIR, maybe the error is somewhere else.

> 
> The idea here is to make it possible to update the meson-buildoptions.sh
> script even in case the build directory if somehow hosed.  So I'd rather
> avoid this patch if possible.
> 
> What's the error that you have and do you have a reproducer?

Here is the error I see:
cmd:
  meson introspect --buildoptions /home/joel/src/qemu/meson.build

output:
  meson.build:88:12: ERROR: Unknown compiler(s): [['rustc']]
  The following exception(s) were encountered:
  Running `rustc --version` gave "[Errno 2] No such file or directory: 'rustc'"

When I pass it a builddir it actually gives me all the buildoptions
(which is what I expect)
cmd:
  meson introspect --buildoptions /home/joel/src/qemu/bdir

output (Just pasted a few values as it is too long):
  [{"name": "build.cmake_prefix_path", "value": [], "section": "core",
  "machine": "build", "type": "array", "description": "List of additional
  prefixes for cmake to search"}, {"name": "build.pkg_config_path",
  "value":
  ["/nix/store/xslbksjj97g6nagcx4n5maj9fpvnyhvs-glib-2.82.1-dev/lib/pkgconfig",
  "/nix/store/06q0p7bhn2ffxxya20rrfqdib3h32csn-zlib-1.3.1-dev/lib/pkgconfig",
  "/nix/store/30gl46y1afg6crvcw9v3ipb6hmkmd7hj-libffi-3.4.6-dev/lib/pkgconfig",
  "/nix/store/08dqyhwwvn0yvc0zziw9q8vc4njb7jal-lz4-1.10.0-dev/lib/pkgconfig",
  "/nix/store/zcg3yygpamw1hk28yd46zswvyjf26vnz-libslirp-4.8.0/lib/pkgconfig",
  "/nix/store/3alx4nrhy7ss32i6fmfgj0hp96pfjvx6-python3-3.11.11/lib/pkgconfig",
  "/nix/store/l8g4dx38bkhfphgwyhi513nhw2x47c6r-python3-3.11.11/lib/pkgconfig"],
  "section": "core", "machine": "build", "type": "array", "description":
  "List of additional paths for pkg-config to search"}, {"name":
  "auto_features", "value": "auto", "section": "core", "machine": "any",
  "choices": ["enabled", "disabled", "auto"], "type": "combo",
  "description": "Override value of all 'auto' features"}, {"name":
  "backend", "value": "ninja", "section": "core", "machine": "any",
  "choices": ["ninja", "vs", "vs2010", "vs2012", "vs2013", "vs2015",
  ...

Quickly looking at the error message and at line 88 shows me that it has
to do with the build trying to call the rust compiler (which I do
**not** have installed). It seems that have_rust has the true value even
though I do not have it installed. However all this goes away when I
pass it a builddir.

Maybe the fix is to change the detection logic for the rust compiler?
FYI:
1. These are the lines that have rust in the meson_options.txt:
  option('rust', type: 'feature', value: 'disabled',
         description: 'Rust support')
  option('strict_rust_lints', type: 'boolean', value: false,
         description: 'Enable stricter set of Rust warnings')
2. This is how I run configure:
  ../configure --target-list=x86_64-softmmu --disable-docs

Notice that in meson.build:88 the value of has_rust depends on
have_system which in turn depends on target_dirs. Does target_dirs have
values outside a builddir?

Hopes this helps clarify my situation

Best

-- 

Joel Granados

