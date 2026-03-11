Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED551125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0N77-0005Bl-Ni; Wed, 11 Mar 2026 13:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0N72-0005BI-2N; Wed, 11 Mar 2026 13:12:49 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1w0N6y-0003Ua-C1; Wed, 11 Mar 2026 13:12:47 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F0E8243C4D;
 Wed, 11 Mar 2026 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A008AC4CEF7;
 Wed, 11 Mar 2026 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773249161;
 bh=DhyJ46ud/A5fNoWRab1FMxcDxnSoM8mhTOmKLC6hVD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tVap41pg6pnZqY0O5pO5QtBduY1MA/YBLjTwQ/izREpf9QkKWNuJRQhBuzOHeIyEG
 HF8/fceL2iWs++572T19xz3LhZgWfnGUMTKcDX9DzDc+LxWB3RpBVieZxv6PgbrXck
 ossJDZUWbwUzZO2ycYf8ybCbKzqvqUV7nG0GPojRLvciZlOTQIhWjg21/koS/vgUVd
 uI7sjrgnJ/7IwGsOfp0ACVNNHTyWG0EbwKHNFk+x0fMjTQlYRQ3+F7BDQljgG+BxNL
 w6cDE4bFCTcFYeLR/6FvM1GUNVG0sRO4+ggNBI1tcRmF8Q3JLEDYfoMvVKrymCRZCy
 tWadiB1xjxoRw==
Date: Wed, 11 Mar 2026 17:12:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>,
 qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 00/14] Add ARM64 support for MSHV accelerator
Message-ID: <20260311171240.GB3612627@liuwe-devbox-debian-v2.local>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <877brii9wq.fsf@draig.linaro.org>
 <9D4583F5-0591-473F-8FFA-1EDF416AF447@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D4583F5-0591-473F-8FFA-1EDF416AF447@unpredictable.fr>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=wei.liu@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 06:02:26PM +0100, Mohamed Mediouni wrote:
> 
> 
> > On 11. Mar 2026, at 17:54, Alex Bennée <alex.bennee@linaro.org> wrote:
> > 
> > "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com> writes:
> > 
> >> This series adds ARM64 guest support to the MSHV (Microsoft Hypervisor)
> >> accelerator, enabling QEMU to run aarch64 VMs on Microsoft's hypervisor
> >> using the mshv Linux kernel module.
> > 
> > Does GitLab (or anything we plug into it) support runners on Arm64 with
> > HyperV and a Linux Dom0?
> > 
> > I looks like we would need a dedicated runner to defend the
> > functionality on CI.
> 
> 
> The MSHV license doesn’t allow for any use outside of Azure Kubernetes Service,
> despite MSHV (for x86) being public.
> 
> And Dom0 is technically not required as there’s L1VH, but that’s even less documented to
> the outside and not set up for more local use - but hopefully will make its way to Windows 
> client at some point :/

Direct Virtualization (the marketing name for L1VH) will become
generally available on Azure at some point (hopefully within this
calendar year). I am not sure about Windows client though.

Thanks,
Wei

