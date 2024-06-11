Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C38C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 09:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGxpJ-0005Fw-J3; Tue, 11 Jun 2024 05:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sGxpI-0005FM-0V
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:30:00 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sGxpC-0007XO-9F
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 05:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718098194; x=1749634194;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0UDTQ+AMme+lFXkLTPohLTCXFIxaBp/hVqR7wVFWEr0=;
 b=EMHOduf0xHUXYC3cvpoICP2RxfCSA6NQg4rU5H57bPlwiyXj5O+g4KN7
 qEo8PJFczi8WEl4XpQI5Pdtk7FjZCKEWmZqYMFs8vZROXxusQoYO13O1x
 1ZB8w/w/AtdN8EhN2ZA7fOQA/CebysTw/qRahNtlTFUVpLWnJCpOhiUl7
 HhhHFUWmGOSyIYfhEArz4s73z7TNCbJESZUnnmlqkFpooKZGKiZHx3IwU
 S/ZBRBw5D/FS+xR6ygcOXwi8bzbujcpFFQv91HErdTIcGoV9nsk7yUmbn
 JN1FzXN7VtficlD8iiZRaD5f0XfahS1Z1a9Vb8CjfN4t2SX8ohyYQQ3xj g==;
X-CSE-ConnectionGUID: KXCOprf9RN+Ww1PyYhDCrw==
X-CSE-MsgGUID: iWlczk8ZR26Irf+HJIi+rA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12015335"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="12015335"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2024 02:29:52 -0700
X-CSE-ConnectionGUID: gD8f1pNWQa63dSbZ2QDkRQ==
X-CSE-MsgGUID: 2zy8WySoTwi/bYvEB86SzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="39956895"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 11 Jun 2024 02:29:48 -0700
Date: Tue, 11 Jun 2024 17:45:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Message-ID: <ZmgcrSYHwA0Z8Asq@intel.com>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <ZmgJVGMx81aHjg5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmgJVGMx81aHjg5f@redhat.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 11, 2024 at 09:22:44AM +0100, Daniel P. Berrangé wrote:
> Date: Tue, 11 Jun 2024 09:22:44 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
> 
> On Mon, Jun 10, 2024 at 09:22:35PM +0300, Manos Pitsidianakis wrote:
> > Hello everyone,
> > 
> > This is an early draft of my work on implementing a very simple device, 
> > in this case the ARM PL011 (which in C code resides in hw/char/pl011.c 
> > and is used in hw/arm/virt.c).
> 
> looking at the diffstat:
> 
> >  .gitignore                     |   2 +
> >  .gitlab-ci.d/buildtest.yml     |  64 ++--
> >  configure                      |  12 +
> >  hw/arm/virt.c                  |   2 +-
> >  meson.build                    |  99 ++++++
> >  meson_options.txt              |   4 +
> >  rust/meson.build               |  93 ++++++
> >  rust/pl011/.cargo/config.toml  |   2 +
> >  rust/pl011/.gitignore          |   2 +
> >  rust/pl011/Cargo.lock          | 120 +++++++
> >  rust/pl011/Cargo.toml          |  26 ++
> >  rust/pl011/README.md           |  42 +++
> >  rust/pl011/build.rs            |  44 +++
> >  rust/pl011/meson.build         |   7 +
> >  rust/pl011/rustfmt.toml        |  10 +
> >  rust/pl011/src/definitions.rs  |  95 ++++++
> >  rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
> >  rust/pl011/src/device_class.rs |  95 ++++++
> >  rust/pl011/src/generated.rs    |   5 +
> >  rust/pl011/src/lib.rs          | 575 +++++++++++++++++++++++++++++++++
> >  rust/pl011/src/memory_ops.rs   |  38 +++
> 
> My thought is that if we're going to start implementing devices
> or other parts of QEMU, in Rust, then I do not want to see it
> placed in a completely separate directory sub-tree.
> 
> In this example, I would expect to have hw/arm/pl011.rs, or hw/arm/pl011/*.rs
> so that the device is part of the normal Arm hardware directory structure 
> and maintainer assignments.

It has its advantages. Otherwise, as the number of Rust implementations
grows, the same mirror directory as QEMU will have to be rebuilt again
in the Rust directory.

Further, putting C implementations in the same directory, there is again
the question of why it needs to be duplicated :-) . This topic is
probably also beyond the scope of this RFC, but it's nice to have a Rust
example to start with.

Currently, pl011 exclusively occupies a cargo as a package. In the
future, will other Rust implementations utilize the workspace mechanism
to act as a second package in the same cargo? Or will new cargo be created
again?

Under a unified Rust directory, using a workspace to manage multiple
packages looks as if it would be easier to maintain. Decentralized to an
existing directory, they're all separate cargos, and external dependencies
tend to become fragmented?



