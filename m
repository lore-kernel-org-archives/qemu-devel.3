Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28E2CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umxDv-0007ny-Ma; Fri, 15 Aug 2025 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namhyung@kernel.org>)
 id 1umxDt-0007nU-PC
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:24:09 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <namhyung@kernel.org>)
 id 1umxDr-0006mS-Pv
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:24:09 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 212E1419C9;
 Fri, 15 Aug 2025 16:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B60C4CEEB;
 Fri, 15 Aug 2025 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755275045;
 bh=4W3MexmDLIj0LLuVBsUoXVIfys/oLMGtURiFQUEH13U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUphFxrWKV+6n7KpkD3VVRbo27xzyyN/vWebfUiwoAS3RvQSWcpYef5mbG32vq0xD
 Hj0/e3bePcSFamI9nK1ma1Z1tJgmnKrGZNeX7nNEd7c2k/TECv6Usta5G6k2J1kTXq
 LsLm0KSBqNf5NIpDJGBe/pMGF4IRBd7RfiQ0AFAHXmAiB/AdFCFFEAZWTG5KJ1UEeH
 gx7uzJLw+iJTkPJ6nbo75iUvpli22kP4Ea4eVzyFa0QL+rwrRi3uUMsyrZOzUynbnX
 vzx4mQ8pLbKA4C23C8MVuQVsKobT/zIxnc9HN1TNS3GmfWQ6VfTQjsBHkx+jBmRUuP
 bmqcMI4Wr142Q==
Date: Fri, 15 Aug 2025 09:24:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>,
 Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <aJ9fIUkM04HhRgSR@google.com>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh> <aJ5EupUV9t0jToY3@google.com>
 <2025081536-resonate-wafer-6699@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025081536-resonate-wafer-6699@gregkh>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=namhyung@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 15, 2025 at 07:33:41AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 14, 2025 at 01:19:06PM -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > Thanks for the report!
> > 
> > On Wed, Aug 13, 2025 at 02:50:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 13, 2025 at 05:46:26PM +0530, Naresh Kamboju wrote:
> > > > Long story:
> > > > 1)
> > > > The perf gcc-13 build failed on x86_64 and i386.
> > > > 
> > > > Build regression: qemu-arm64 ARM64_64K_PAGES ltp syscalls swap fsync
> > > > fallocate failed.
> > > > 
> > > > > Ian Rogers <irogers@google.com>
> > > > >     perf topdown: Use attribute to see an event is a topdown metic or slots
> > > > 
> > > > Build error:
> > > > 
> > > > arch/x86/tests/topdown.c: In function 'event_cb':
> > > > arch/x86/tests/topdown.c:53:25: error: implicit declaration of
> > > > function 'pr_debug' [-Werror=implicit-function-declaration]
> > > >    53 |                         pr_debug("Broken topdown information
> > > > for '%s'\n", evsel__name(evsel));
> > > >       |                         ^~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > 
> > > Already fixed.
> > 
> > Are you sure?  I'm not seeing the fix.  Can you share the commit id?
> 
> I dropped the offending perf patch:
> 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=4199b872a5585e025f62886724f4f9ae80e014ae
> 
> Did that not work for you?

Oh sorry, I misunderstood you.  I thought you have a fix.

Thanks,
Namhyung


