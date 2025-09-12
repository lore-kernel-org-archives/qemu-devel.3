Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486FFCA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 07:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwy5l-0006Q7-0t; Fri, 12 Sep 2025 03:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwy5Z-0006PB-Kj
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:20:58 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uwy5P-0000bk-QX
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 03:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757661648; x=1789197648;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Cb8z5eqPo5m7nJsc0mKKTzoYMMsWFB+2c//8n6wRToc=;
 b=HRIAn7b1Wd8g47XEeQWfUBDPT1Hu6ZAedm0Jnm3412YKkVQFgALuHpwM
 AQwCWusrtLww5xT2Nt//DVWk/zTCm666PmmiVK1ZKhB1farUPlvO7hJh6
 d9d+eQTTOHAAygM7vfkpFQn/Rs6y2eKtaGlfgLj7Jada0jvGB7YyHLk0n
 OcCwg1ZS6SGqZt4ewtktGrkcjKmm/dpNllGqJo+QtR9azYp+eWNhu6MHX
 n/3QJtaKwLRbqtyL8t6SVCbDR50FQ6SD6srJ+KLZo4aBADrhZ4tLO77gh
 qa2slqKrR7H0FEM8Iu1WqqLIedfk4nvAXuVPZrymw1EMMi17YnaE1zO5y g==;
X-CSE-ConnectionGUID: xAgYSQ0MTxmQU765dQCZtg==
X-CSE-MsgGUID: QogB7LH5Sf+f5d/JWfrFcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="59042830"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="59042830"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 00:20:43 -0700
X-CSE-ConnectionGUID: 3bCe6G3DRjmViMyaJHJK1g==
X-CSE-MsgGUID: eTpjFfZNQlCP4XjXyIPTbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="204669426"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 12 Sep 2025 00:20:42 -0700
Date: Fri, 12 Sep 2025 15:42:29 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
Message-ID: <aMPO5YZK3EgWBJdC@intel.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
 <CAJ+F1CJCJUgnFRvc6LCCMdLVrXAoaTqWzuYtKE+siW+-8vZ4=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJCJUgnFRvc6LCCMdLVrXAoaTqWzuYtKE+siW+-8vZ4=Q@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Sep 11, 2025 at 03:18:44PM +0400, Marc-André Lureau wrote:
> Date: Thu, 11 Sep 2025 15:18:44 +0400
> From: Marc-André Lureau <marcandre.lureau@gmail.com>
> Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
> 
> Hi
> 
> On Thu, Sep 11, 2025 at 2:05 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Mon, 8 Sept 2025 at 11:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > This includes:
> > > - bumping MSRV to 1.83.0 to support const_refs_to_static
> > > - Zhao's safe, builder-based implementation of migration callbacks
> > > - Manos's qdev properties macro.  While bit-based properties are
> > >   not yet supported, that's a small change overall.
> > > - the Rust crate split from Marc-André
> > > - adding proc macro aliases in individual crates, also from Marc-André
> > >
> > > I'm still not convinced about having "bql" depend on "migration",
> > > but I am convinced by the crate split between "util" and "bql",
> > > so we can move the implementation of VMState from "bql" to
> > > "migration" later if needed.
> > >
> > > For the purpose of getting this in as an easy-to-use base for future
> > > development, I'm disabling CI from Debian and Ubuntu.  The plan is:
> > > - that Debian will require trixie to enable Rust usage
> > > - that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
> > >   (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)
> > > - that Marc-André or someone else will add Rust to other CI jobs
> >
> > How far into the future does moving to 1.83.0 push our
> > "we can enable rust and make it mandatory" point? I was
> > hoping we would be able to do that sometime soon but this
> > sounds like we're going to be still a long way out from that :-(
> 
> I suppose most distro will want to backport a newer rust in their
> stable distro, like ubuntu is doing or debian with rustc-web. With
> that, it shouldn't be too long before we could make Rust required.
> 
> fwiw, I am working on a series to enable Rust on our various
> CI/docker/vm. I am mostly left with issues from windows and macos ..
> (btw, if someone can help me investigate the linking issue on mac
> https://gitlab.com/marcandre.lureau/qemu/-/jobs/11301499123, perhaps a
> temporary ssh somewhere?)

Just a guess...

It seems "-llibqemuutil.a" may tell the linker to search for
liblibqemuutil.a.dylib or liblibqemuutil.a.a [*] :-(

[*]: https://manp.gs/mac/1/ld#l

-Zhao


