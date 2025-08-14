Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74785CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 15:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umZuw-0006tV-HC; Thu, 14 Aug 2025 11:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1umZuu-0006sv-6B
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:31:00 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregkh@linuxfoundation.org>)
 id 1umZuo-0006yj-V0
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:30:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8B0775C5575;
 Thu, 14 Aug 2025 15:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51789C4CEED;
 Thu, 14 Aug 2025 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1755185450;
 bh=cvTYcOO2SFOCDjwerP1KEOTUieXi4c8bDV0Z2qhr2s4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jTOR52cELhkyDE+NrphwZYdLWf4cfJAMhSsdNkjjGXFVbnh3vqBpW91wVEGUkEYtJ
 JRwUwCFEaf4x+OyYrdf0R9Ua1H5/GNFbwLX4h6vwnDEiIka6iFvJzrjB6meClf4B8X
 WkXh/Yp7lXXwYtX1kgmHJ7Jz6UEKqS9UWLtHT8Mc=
Date: Thu, 14 Aug 2025 17:30:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org, Joseph Qi <jiangqi903@gmail.com>,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
 Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <2025081436-upchuck-shush-adba@gregkh>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
 <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42aace87-1b89-4b17-96f1-3efbabc4acf3@huaweicloud.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=gregkh@linuxfoundation.org; helo=dfw.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 14, 2025 at 09:27:49AM +0800, Zhang Yi wrote:
> On 2025/8/13 22:53, Greg Kroah-Hartman wrote:
> > On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> >> Hi Greg,
> >>
> >>>> 2)
> >>>>
> >>>> The following list of LTP syscalls failure noticed on qemu-arm64 with
> >>>> stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> >>>>
> >>>> Most failures report ENOSPC (28) or mkswap errors, which may be related
> >>>> to disk space handling in the 64K page configuration on qemu-arm64.
> >>>>
> >>>> The issue is reproducible on multiple runs.
> >>>>
> >>>> * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> >>>>
> >>>>   - fallocate04
> >>>>   - fallocate05
> >>>>   - fdatasync03
> >>>>   - fsync01
> >>>>   - fsync04
> >>>>   - ioctl_fiemap01
> >>>>   - swapoff01
> >>>>   - swapoff02
> >>>>   - swapon01
> >>>>   - swapon02
> >>>>   - swapon03
> >>>>   - sync01
> >>>>   - sync_file_range02
> >>>>   - syncfs01
> >>>>
> >>>> Reproducibility:
> >>>>  - 64K config above listed test fails
> >>>>  - 4K config above listed test pass.
> >>>>
> >>>> Regression Analysis:
> >>>> - New regression? yes
> >>>
> >>> Regression from 6.16?  Or just from 6.15.y?
> >>
> >> Based on available data, the issue is not present in v6.16 or v6.15.
> >>
> >> Anders, bisected this regression and found,
> >>
> >>   ext4: correct the reserved credits for extent conversion
> >>     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> >>
> >> Report lore link,
> >>
> >> https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> > 
> > Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> > :)
> > 
> 
> Hi,
> 
> This issue has already fixed in 6.17-rc1 through this series:
> 
> https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/
> 
> 
> To fix this issue in 6.16, it's necessary to backport the whole series
> instead of just pick 5137d6c8906b ("ext4: fix insufficient credits
> calculation in ext4_meta_trans_blocks()") and 95ad8ee45cdb {"ext4: correct
> the reserved credits for extent conversion").  Otherwise, this will make
> the problem more likely to occur.

Thanks, I'll just postpone this one for now.

greg k-h

