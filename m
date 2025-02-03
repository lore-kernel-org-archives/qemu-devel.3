Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF4C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf59x-00080o-3p; Mon, 03 Feb 2025 17:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tf59v-00080L-MX
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:43:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1tf59t-0004xj-LQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:43:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5B58A5C659B;
 Mon,  3 Feb 2025 22:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC262C4CED2;
 Mon,  3 Feb 2025 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738622588;
 bh=w5vf9cG5VK6b/SnMprT06cGeL1SqYhsAOQKm3TDtL3o=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Zn39Xx+LWRwbeiAtmL8Y+Fm2zomYFjVAgcPxHtXy6C9CvcdLac5DmRK6uxcnD7wJQ
 Bh+q8L/UeOKN1OMSkJutspLeRq+qezb/FDNANW6ko3d5Uz/tmMPB10CCrHpGLxcT1c
 yDKbEefk89GG0W3MZxl4E+aknG7aYc2XE7x1r6SLaIVNWpBb73pbXE2OUa4v/HZGAZ
 lvLaIPR0P6eKfgsN62v/lgwfmXxcQTxuYePaZs8barJtIh6Ov5OXn+ltSVa+3ubdDx
 0qBRBxNbQsYR8/NnEHu4qcIFFSNxbOYptO+mTYJlOajTx/TV0qiG1sI4+nn5vvDIej
 pwoAHSZ7lMj1g==
Date: Mon, 3 Feb 2025 14:43:05 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Richard Henderson <richard.henderson@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Stefano Stabellini <sstabellini@kernel.org>, mark.cave-ayland@ilande.co.uk, 
 berrange@redhat.com, philmd@linaro.org, thuth@redhat.com, 
 andrew.cooper3@citrix.com, anthony.perard@vates.tech, michal.orzel@amd.com, 
 jbeulich@suse.com, julien@xen.org, roger.pau@citrix.com, 
 xen-devel@lists.xenproject.org, bertrand.marquis@arm.com
Subject: Re: [PATCH v2 00/14] meson: Deprecate 32-bit host support
In-Reply-To: <e40c39d4-425c-4566-af41-373941894045@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2502031438170.11632@ubuntu-linux-20-04-desktop>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
 <467a5a58-952e-4930-8e91-744eda6d87d9@redhat.com>
 <e40c39d4-425c-4566-af41-373941894045@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-12469339-1738622583=:11632"
Content-ID: <alpine.DEB.2.22.394.2502031443030.11632@ubuntu-linux-20-04-desktop>
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-12469339-1738622583=:11632
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2502031443031.11632@ubuntu-linux-20-04-desktop>

+Xen maintainers


On Mon, 3 Feb 2025, Richard Henderson wrote:
> On 2/3/25 04:54, Paolo Bonzini wrote:
> > On 2/3/25 04:18, Richard Henderson wrote:
> > > v1: 20250128004254.33442-1-richard.henderson@linaro.org
> > > 
> > > For v2, immediately disable 64-on-32 TCG.
> > > 
> > > I *suspect* that we should disable 64-on-32 for *all* accelerators.
> > > The idea that an i686 binary on an x86_64 host may be used to spawn
> > > an x86_64 guest via kvm is silly and a bit more than niche.
> > 
> > At least Xen used to be commonly used with 32-bit dom0, because it saved
> > memory and dom0 would map in guest buffers as needed.  I'm not sure how
> > common that is these days, perhaps Stefano knows.
> 
> As a data-point, debian does not ship libxen-dev for i686.
> We cannot build-test this configuration at all.
> 
> I can build-test Xen for armhf, and I guess it would use i386-softmmu; it's
> unclear whether x86_64-softmmu and aarch64-softmmu are relevant or useful for
> an armhf host, or as an armhf binary running on an aarch64 host.


On the Xen side, there are two different use cases: x86 32-bit and ARM
32-bit.  

For x86 32-bit, while it was a very important use case in the past, I
believe it is far less so now. I will let the x86 maintainers comment on
how important it is today. 

For ARM 32-bit, I do not think we ever had many deployments, as most are
64-bit. Even when there are deployments, they do not typically use QEMU,
as QEMU is less important for Xen on ARM compared to x86. Therefore, I
would not block your cleanup and deprecation because of that. I will let
the other ARM maintainers chime in.
--8323329-12469339-1738622583=:11632--

