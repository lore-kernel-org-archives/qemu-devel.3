Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F034C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 06:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBqOq-0005DT-NM; Tue, 28 May 2024 02:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBqOp-0005Cl-1f
 for qemu-devel@nongnu.org; Tue, 28 May 2024 02:33:31 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBqOi-00079W-SV
 for qemu-devel@nongnu.org; Tue, 28 May 2024 02:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716878005; x=1748414005;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=SlQgWHgTN11nJLO6E8qeChyAHBxtKVmNeV46RQXK/7E=;
 b=DF3KTwJPd2o80LGcI6ZOGF75f1rBjxQmGz2vEC39ltjhElFPfmK+XhpO
 fxpfR6VRXsKbcYFYp29RZJ2v9pl4Yi7lmXBNgJ2LNTbI/cP00vvKgsMxO
 8VVqRGvYkIc1T8msyFc0PYbZNVXEhqJut4jMJOYnx0UrDkDyy6436sJKe
 sZTKK0NV1LldkRPmGVG7Tk6JVQM5fqvFWcHZWxNtrVmyFISkMPbROahet
 zlHUUrSKvBVKoGTOYmtFXqkbA2j6MPq/0JaACiUUuKLR1d2KosCMcpXDo
 OpHp5rUBbOyzebaFUz10e4B2iJE455baEPfu9p1pMOSckxiqKuGSZU/An A==;
X-CSE-ConnectionGUID: 150PUv1NTRy57pUHDuxEDQ==
X-CSE-MsgGUID: 2KF98gDgTFywqVrEAMzY7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17038240"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="17038240"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 23:33:22 -0700
X-CSE-ConnectionGUID: lqo6SHqiTEaXr4Km7iNx2A==
X-CSE-MsgGUID: UIFzbFo4SzK/z2hGtHBZkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; d="scan'208";a="39767110"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 27 May 2024 23:33:20 -0700
Date: Tue, 28 May 2024 14:48:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <ZlV+Su4hziCFymVt@intel.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
 <20240527195944.GA913874@fedora.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527195944.GA913874@fedora.redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Stefan,

On Mon, May 27, 2024 at 03:59:44PM -0400, Stefan Hajnoczi wrote:
> Date: Mon, 27 May 2024 15:59:44 -0400
> From: Stefan Hajnoczi <stefanha@redhat.com>
> Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
> 
> On Mon, May 27, 2024 at 04:14:15PM +0800, Zhao Liu wrote:
> > Hi maintainers and list,
> > 
> > This RFC series attempts to re-implement simpletrace.py with Rust, which
> > is the 1st task of Paolo's GSoC 2024 proposal.
> > 
> > There are two motivations for this work:
> > 1. This is an open chance to discuss how to integrate Rust into QEMU.
> > 2. Rust delivers faster parsing.
> > 
> > 
> > Introduction
> > ============
> > 
> > Code framework
> > --------------
> > 
> > I choose "cargo" to organize the code, because the current
> > implementation depends on external crates (Rust's library), such as
> > "backtrace" for getting frameinfo, "clap" for parsing the cli, "rex" for
> > regular matching, and so on. (Meson's support for external crates is
> > still incomplete. [2])
> > 
> > The simpletrace-rust created in this series is not yet integrated into
> > the QEMU compilation chain, so it can only be compiled independently, e.g.
> > under ./scripts/simpletrace/, compile it be:
> > 
> >     cargo build --release
> 
> Please make sure it's built by .gitlab-ci.d/ so that the continuous
> integration system prevents bitrot. You can add a job that runs the
> cargo build.

Thanks! I'll do this.

> > 
> > The code tree for the entire simpletrace-rust is as follows:
> > 
> > $ script/simpletrace-rust .
> > .
> > ©À©¤©¤ Cargo.toml
> > ©¸©¤©¤ src
> >     ©¸©¤©¤ main.rs   // The simpletrace logic (similar to simpletrace.py).
> >     ©¸©¤©¤ trace.rs  // The Argument and Event abstraction (refer to
> >                   // tracetool/__init__.py).
> > 
> > My question about meson v.s. cargo, I put it at the end of the cover
> > letter (the section "Opens on Rust Support").
> > 
> > The following two sections are lessons I've learned from this Rust
> > practice.
> > 
> > 
> > Performance
> > -----------
> > 
> > I did the performance comparison using the rust-simpletrace prototype with
> > the python one:
> > 
> > * On the i7-10700 CPU @ 2.90GHz machine, parsing and outputting a 35M
> > trace binary file for 10 times on each item:
> > 
> >                       AVE (ms)       Rust v.s. Python
> > Rust   (stdout)       12687.16            114.46%
> > Python (stdout)       14521.85
> > 
> > Rust   (file)          1422.44            264.99%
> > Python (file)          3769.37
> > 
> > - The "stdout" lines represent output to the screen.
> > - The "file" lines represent output to a file (via "> file").
> > 
> > This Rust version contains some optimizations (including print, regular
> > matching, etc.), but there should be plenty of room for optimization.
> > 
> > The current performance bottleneck is the reading binary trace file,
> > since I am parsing headers and event payloads one after the other, so
> > that the IO read overhead accounts for 33%, which can be further
> > optimized in the future.
> 
> Performance will become more important when large amounts of TCG data is
> captured, as described in the project idea:
> https://wiki.qemu.org/Internships/ProjectIdeas/TCGBinaryTracing
> 
> While I can't think of a time in the past where simpletrace.py's
> performance bothered me, improving performance is still welcome. Just
> don't spend too much time on performance (and making the code more
> complex) unless there is a real need.

Yes, I agree that it shouldn't be over-optimized.

The logic in the current Rust version is pretty much a carbon copy of
the Python version, without additional complex logic introduced, but the
improvements in x2.6 were obtained by optimizing IO:

* reading the event configuration file, where I called the buffered
  interface,
* and the output formatted trace log, which I output all via std_out.lock()
  followed by write_all().

So, just the simple tweak of the interfaces brings much benefits. :-)

> > Security
> > --------
> > 
> > This is an example.
> > 
> > Rust is very strict about type-checking, and it found timestamp reversal
> > issue in simpletrace-rust [3] (sorry, haven't gotten around to digging
> > deeper with more time)...in this RFC, I workingaround it by allowing
> > negative values. And the python version, just silently covered this
> > issue up.
> >
> > Opens on Rust Support
> > =====================
> > 
> > Meson v.s. Cargo
> > ----------------
> > 
> > The first question is whether all Rust code (including under scripts)
> > must be integrated into meson?
> > 
> > If so, because of [2] then I have to discard the external crates and
> > build some more Rust wheels of my own to replace the previous external
> > crates.
> > 
> > For the main part of the QEMU code, I think the answer must be Yes, but
> > for the tools in the scripts directory, would it be possible to allow
> > the use of cargo to build small tools/program for flexibility and
> > migrate to meson later (as meson's support for rust becomes more
> > mature)?
> 
> I have not seen a satisfying way to natively build Rust code using
> meson. I remember reading about a tool that converts Cargo.toml files to
> meson wrap files or something similar. That still doesn't feel great
> because upstream works with Cargo and duplicating build information in
> meson is a drag.
> 
> Calling cargo from meson is not ideal either, but it works and avoids
> duplicating build information. This is the approach I would use for now
> unless someone can point to an example of native Rust support in meson
> that is clean.
> 
> Here is how libblkio calls cargo from meson:
> https://gitlab.com/libblkio/libblkio/-/blob/main/src/meson.build
> https://gitlab.com/libblkio/libblkio/-/blob/main/src/cargo-build.sh

Many thanks! This is a good example and I'll try to build similarly to
it.

> > 
> > 
> > External crates
> > ---------------
> > 
> > This is an additional question that naturally follows from the above
> > question, do we have requirements for Rust's external crate? Is only std
> > allowed?
> 
> There is no policy. My suggestion:
> 
> If you need a third-party crate then it's okay to use it, but try to
> minimize dependencies. Avoid adding dependening for niceties that are
> not strictly needed. Third-party crates are a burden for package
> maintainers and anyone building from source. They increase the risk that
> the code will fail to build. They can also be a security risk.

Thanks for the suggestion, that's clear to me, I'll try to control the
third party dependencies.

> > 
> > Welcome your feedback!
> 
> It would be easier to give feedback if you implement some examples of
> TCG binary tracing before rewriting simpletrace.py. It's unclear to me
> why simpletrace needs to be rewritten at this point. If you are
> extending the simpletrace file format in ways that are not suitable for
> Python or can demonstrate that Python performance is a problem, then
> focussing on a Rust simpletrace implementation is more convincing.
> 
> Could you use simpletrace.py to develop TCG binary tracing first?

Yes, I can. :-)

Rewriting in Rust does sound duplicative, but I wonder if this could be
viewed as an open opportunity to add Rust support for QEMU, looking at
the scripts directory to start exploring Rust support/build would be
a relatively easy place to start.

I think the exploration of Rust's build of the simpletrace tool under
scripts parts can help with subsequent work on supporting Rust in other
QEMU core parts.

From this point, may I ask your opinion?

Maybe later, Rust-simpletrace and python-simpletrace can differ, e.g.
the former goes for performance and the latter for scalability.

Thanks,
Zhao



