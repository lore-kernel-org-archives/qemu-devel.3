Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6B8C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 05:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiPuh-0000q0-7H; Sat, 11 Jul 2026 01:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wiPue-0000ps-RT
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 01:06:04 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1wiPua-0003wm-LQ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 01:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783746349;
 bh=Q7FuBRKB6UcRVF5SG8jdFX5zpQxwxYAdgPRRvH7+wdE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=DPaVoctlCwag12J2rYNsHqxotl87wxOaHxGGgjVQOTbtrdpCd37bFAnHNRcI89/PK
 +jPyWTOKdDpQk4JWC0IefG+hvhxjCq3T1TG/GlRRCQtdJ0Rbou/dPSukmWu2s33Il9
 +7y5bBXWD1ywnA6lBEP4bMTrVpHz+SAtUwC1CN3T3TMya3oV9KIlnhfECagCYge0Cr
 rriDVQLXTKhWfSNCTmhlhqfX1F7ybOTxID3dlVGnBilJM5m1CwYAoF61fLuNsmNmOq
 WNLtplFcwAcTuu7lFQhlva3x469RAjYcJxo0n92jtbnFQTKsP/dTiflaWpv1Vbw+d5
 X04L11y2wx13w==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id AFC202FF3B9;
 Sat, 11 Jul 2026 05:05:49 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 8D816380C9A;
 Sat, 11 Jul 2026 13:05:18 +0800 (CST)
Message-ID: <5a303ce5-cb6f-43b9-857f-39cffc8c7d67@sjtu.edu.cn>
Date: Sat, 11 Jul 2026 13:05:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] docs/about/emulation: document the dlcall plugin
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260710212601.583352-1-functioner@sjtu.edu.cn>
 <20260710212601.583352-3-functioner@sjtu.edu.cn>
 <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <990f11f5-c8fd-4cf6-b186-180e24452ff3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi,

On Fri, 10 Jul 2026 15:57:52 -0700, Pierrick Bouvier wrote:
> Great work, the workflow is now ready!
> 
> A few small issues are left with lib dependencies.
> 
> libstdc++
> ---------
> 
> LD_LIBRARY_PATH=$DEVKIT/lib:build/host \
> ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libdlcall.so \
> -E LD_LIBRARY_PATH=$DEVKIT/x86_64/lib:thunks/x86_64 \
> -L /usr/x86_64-linux-gnu/ \
> build/guest/main
> build/guest/main: error while loading shared libraries: libstdc++.so.6:
> cannot open shared object file: No such file or directory
> 
> Indeed, libstc++ is not available in machine's x86_64 sysroot by
> default. It works with -L $DEVKIT/x86_64/sysroot but as mentioned
> previously, we don't want to use another sysroot than the one that user
> has, since it can contain extra libraries we are not aware about (or
> Lorelei one can bring extra dependencies that we don't want).
> 
> So the last thing needed is to link statically libstdc++ for guest thunk
> and host thunk. In addition, you can do it for lorelei .so (I mean .so
> included in devkit), so thunking is fully self contained and does not
> require extra dependencies from the system where it runs.
> Same for libgcc.
> Link parameters you need are -static-libstdc++ -static-libgcc.
> Once added, all thunks and lorelei devkit should be portable between
> different machines 👍.
> 
> The only base dependency we can assume will be present is libc (which
> also includes libm.so).
> We could argue if c++ should be considered as a base dependency also.
> For debian (+ubuntu), fedora and archlinux, it's not.
> See what is included in debian libc package. For instance, in our case:
> https://packages.debian.org/trixie/all/libc6-amd64-cross/filelist
> 
> doc
> ---
> 
> While at it, please add -L /usr/x86_64-linux-gnu/ to command line so it
> matches the default people will use.
> 
> rpath
> -----
> 
> It seems that .so in thunks have rpath set to $ORIGIN:$ORIGIN/../../lib,
> which should not be needed. LD_LIBRARY_PATH will specify where to find
> the correct libraries, please remove it.
> 
> You can use this command to double check this:
> readelf -d thunks/libhello_HTL.so thunks/x86_64/libhello.so
> No RUNPATH should be present.
> 
> thunks/libhello_HTL.so has an explicit dependency to
> build/host/libhello.so. It should not include build/host and just link
> to libhello.so. Remove rpath also.
> 
> thunks/x86_64/libhello.so, remove rpath.
> 
> To clarify, lorelei-devkit-*/*/lib/* can use rpath since devkit itself
> is self contained. Thunks can not.
> 
> -----
> 
> Once solved, we'll have a clean and minimal workflow, which ensure
> thunks do not require any extra dependency.
> 
> With this, any user will be able to grab a lorelei devkit + a thunk
> tarball and use it as a drag and drop replacement for their system
> libraries, as long as it matches their version of course.
> 
> Keep up the good work!
> Pierrick

Thanks for the careful review.

On libstdcxx / libgcc: rather than static-linking them into every thunk, I'd
prefer to bundle the shared libraries in the devkit and let the thunks link
against them dynamically. The reasoning:

The devkit already has to carry libstdcxx for LoreTLC itself, which is a 
large
C++ program. Shipping it once as a shared library and having the guest and
host thunks link that same copy avoids baking a static libstdc++ into every
thunk, and keeps LoreTLC and the thunks on one runtime.

The portability you're after is preserved. libstdc++.so.6 and libgcc_s.so.1
sit beside the lorelei runtimes (the devkit's host lib/ and guest 
x86_64/lib/),
so they are found on the same LD_LIBRARY_PATH the run already sets. A clean
Fedora or Arch container with only libc installed runs a devkit + thunk pack
directly, nothing else needed. The one base dependency we assume is still
libc. The devkit brings its own libstdcxx and libgcc.

So static vs dynamic doesn't change what the user must have installed. I 
went
with dynamic because it's the smaller and simpler of the two here.

For the rest: I'll drop the RPATH from the thunk libraries, make the host
thunk record its real library's SONAME (libfoo.so) instead of the build 
path,
and add -L /usr/x86_64-linux-gnu/ to the documented command.


