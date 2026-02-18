Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BBDE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 06:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsayr-00039J-1z; Wed, 18 Feb 2026 01:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vsayp-000396-J9
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:24:11 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1vsayn-0001bg-Uf
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 01:24:11 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DA13543509;
 Wed, 18 Feb 2026 06:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98930C19421;
 Wed, 18 Feb 2026 06:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771395839;
 bh=S/03koDnJpuhteaQXEu6aYlXZ3/rFBHqQ1rC0fMjJYM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a6GuvtE390+FD4Z0AMtX9r/kIU8q15zJYA4HqGL7QWy4bqn3YGVFMdxwmSwOj38tJ
 7e0dUwCKsfZ+Ucmqj7rysX0yoBVv4f49S+t+sOwinTIwt4XgW7Mc6Ma5zThALAEPjK
 XCdt84MXh7mYmGMQw8VCoqpwP1hoo916yRlgG7Z0cQhn6c4QWgbRMwhdsnNmNoYe0L
 gMkL051wMf3mA2lwwQrGqQcQLEEDuDN4Ocm/AE7G+ms2mav9eCM/yDn9NTAO64iLYb
 RKgJRPIfeF3poNw+o/a2QIfBQYMgqGuajo54RCFUhg4vevrQ2HHZ/TPaT+1oUXq1/s
 aNnPGE5LNoPeA==
Date: Wed, 18 Feb 2026 06:23:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <20260218062358.GA2236050@liuwe-devbox-debian-v2.local>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
 <aY3WZg1JedxHtze2@anirudh-surface.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY3WZg1JedxHtze2@anirudh-surface.localdomain>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=wei.liu@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
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

On Thu, Feb 12, 2026 at 01:32:22PM +0000, Anirudh Rayabharam wrote:
> On Wed, Feb 11, 2026 at 04:54:03PM +0100, Magnus Kulke wrote:
> > When using the extended request format we can instruct the hypervisor to
> > provision enough space for requested XSAVE features. This is required
> > for supporting QEMU models provided via the -cpu flag properly.
> > 
> > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > ---
> >  accel/mshv/mshv-all.c          |  35 +++++--
> >  include/hw/hyperv/hvgdk_mini.h |   2 +
> >  include/hw/hyperv/hvhdk.h      | 185 +++++++++++++++++++++++++++++++++
> >  3 files changed, 214 insertions(+), 8 deletions(-)
> > 
> > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > index bed0fa298e..8446f7128a 100644
> > --- a/accel/mshv/mshv-all.c
> > +++ b/accel/mshv/mshv-all.c
> > @@ -112,19 +112,38 @@ static int resume_vm(int vm_fd)
> >  
> >  static int create_partition(int mshv_fd, int *vm_fd)
> >  {
> > -    int ret;
> > -    struct mshv_create_partition args = {0};
> > +    int ret, i;
> > +    uint64_t pt_flags;
> > +    union hv_partition_processor_xsave_features disabled_xsave_features;
> > +    union hv_partition_processor_features disabled_processor_features;
> > +    struct mshv_create_partition_v2 args = {0};
> >  
> >      /* Initialize pt_flags with the desired features */
> > -    uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
> > -                        (1ULL << MSHV_PT_BIT_X2APIC) |
> > -                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
> > +    pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
> > +               (1ULL << MSHV_PT_BIT_X2APIC) |
> > +               (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
> > +               (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
> >  
> > -    /* Set default isolation type */
> > -    uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
> > +    /* enable all */
> > +    disabled_xsave_features.as_uint64 = 0;
> >  
> > +    /* Enable all proc features by default */
> 
> Instead of enabling all features by default, we could query which
> features are supported by the hypervisor on this host and enable only
> those.
> 
> To query supported features get the HvPartitionPropertyProcessorFeatures
> property via HvCallGetPartitionProperty (with HV_PARTITION_ID_SELF).
> 
> I think this would be more robust. This is what Cloud Hypervisor (well,
> technically, the mshv crate) does.
> 

While I think querying the hypervisor is the correct action, are we
sure this gives all the supported features on the host?

Is there a case that the Linux root partition  has a reduced set of
properties?

Wei

