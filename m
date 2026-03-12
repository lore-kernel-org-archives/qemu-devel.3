Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D713C106ACE4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mXz-0007EJ-SK; Thu, 12 Mar 2026 16:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0mXx-0007Di-9y; Thu, 12 Mar 2026 16:22:18 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0mXv-0000fG-JH; Thu, 12 Mar 2026 16:22:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9134F60142;
 Thu, 12 Mar 2026 20:22:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B90C2BC86;
 Thu, 12 Mar 2026 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773346931;
 bh=DabPEGHcR6VK3mfH1dFfwKh0rkgVUxJVZ0Qjzbka9Oc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BO8egjJP+L4FrPELkTrW/qurPmhnZ9ung/zPY+EmahisQTDFsGGDs3WzS0QL55za3
 r2wBNblEf986ZOhyN4Y4NgERM37+06cLoCrTUqNyyBkOYOCSl/dShSf9M6s0YcZaF1
 yMNtwIQImqz05w6YDtRurc/dbPCbfgRah8HvMgFo+sDFkeFsk6/LyPNzs5A7XgoApl
 Arflvw1HxDR8wJg1ff/PBQi3kHOCjvwOjSbjRI7BeTWWcDerT9M9XB7EEyWMO2EWq5
 AwjmfaDyODiUwkbVbEw3qhV56gZePLf43+J+7JedIHGmaqv5TqpQzucqgMJ4B0n+Zn
 w26wGwfx9IoCg==
Date: Thu, 12 Mar 2026 20:22:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Wei Liu <wei.liu@kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/14] Add ARM64 support for MSHV accelerator
Message-ID: <20260312202209.GA124403@liuwe-devbox-debian-v2.local>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <877brii9wq.fsf@draig.linaro.org>
 <9D4583F5-0591-473F-8FFA-1EDF416AF447@unpredictable.fr>
 <20260311171240.GB3612627@liuwe-devbox-debian-v2.local>
 <6FE1FA7B-653C-4088-8F27-BCE249F50FEB@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6FE1FA7B-653C-4088-8F27-BCE249F50FEB@unpredictable.fr>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=tor.source.kernel.org
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

On Thu, Mar 12, 2026 at 06:20:10AM +0100, Mohamed Mediouni wrote:
> 
> 
> > On 11. Mar 2026, at 18:12, Wei Liu <wei.liu@kernel.org> wrote:
> > 
> > On Wed, Mar 11, 2026 at 06:02:26PM +0100, Mohamed Mediouni wrote:
> >> 
> >> 
> >>> On 11. Mar 2026, at 17:54, Alex Bennée <alex.bennee@linaro.org> wrote:
> >>> 
> >>> "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com> writes:
> >>> 
> >>>> This series adds ARM64 guest support to the MSHV (Microsoft Hypervisor)
> >>>> accelerator, enabling QEMU to run aarch64 VMs on Microsoft's hypervisor
> >>>> using the mshv Linux kernel module.
> >>> 
> >>> Does GitLab (or anything we plug into it) support runners on Arm64 with
> >>> HyperV and a Linux Dom0?
> >>> 
> >>> I looks like we would need a dedicated runner to defend the
> >>> functionality on CI.
> >> 
> >> 
> >> The MSHV license doesn’t allow for any use outside of Azure Kubernetes Service,
> >> despite MSHV (for x86) being public.
> >> 
> >> And Dom0 is technically not required as there’s L1VH, but that’s even less documented to
> >> the outside and not set up for more local use - but hopefully will make its way to Windows 
> >> client at some point :/
> > 
> > Direct Virtualization (the marketing name for L1VH) will become
> > generally available on Azure at some point (hopefully within this
> > calendar year). I am not sure about Windows client though.
> 
> Hi,
> 
> Could you ask if it’d be possible to have Windows client as an L1VH host, if even just Insider builds?
> 
> Either as a Windows Hypervisor Platform privilege (even no save/restore is okay, just being able
> to enable the privilege is good enough for testing), or through HCS for WSL2 (or just Hyper-V VMs)?
> 

I can pass on the question. Don't hold your breath though -- it is not
something engineers decide.

> Because at this point that’d solve the testability issue…

I agree. The more accessible this technology is, the better.

Wei

