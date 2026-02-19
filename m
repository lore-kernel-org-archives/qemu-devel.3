Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563BFE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1MZ-0007BE-JN; Thu, 19 Feb 2026 05:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1vt1MO-00074G-Su
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:18 -0500
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1vt1MJ-00061S-97
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:14 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1771497233; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S23fA7GGIkPbz4YHihWwcX6k6o2tNz2d+bjUNgmmr3Pc5z1hN9sSF8/imWa6m/gUwRDqCOwFpayai6kp0AeEj4Q0tD7kmW/ZV71bBeoKgXDjhWmvU5WgDB9bOBa+Rfvc3IvfAKBY6PM6W3NczMgT2X4mR2rEe+V9ChlM565w2js=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1771497233;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oYrLU/d2EKxYh1FOQZ9q559V/3dQ1WZt1aKGNJfOQKE=; 
 b=YKcwNYJuVFvTXzDTK649SclxiGsixn9RlQrfrlGvuhD2jxtaujVMZjFf0yRCWWNAxUuXBbxyQ0WXlIKDdc8rIUZN+urLHmgoguWdBVWeYH5wwFRb0S+85CMM6RwG4ibNmW3j5OZdIDEvce0ZJTEb98hdRtTMFt8yPO4JcUI1LFk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771497232; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=oYrLU/d2EKxYh1FOQZ9q559V/3dQ1WZt1aKGNJfOQKE=;
 b=NJKPNkX4qNaVkKfNjJ/01e4O707xBStcrK0jspz5uLhGX7VvYPtkYtJ6zQdyz98I
 BWKZ5DIBqjiz80MEmfiDcV3A/iqNcTo3BQ19YjRo30bFX770H3p1bKE+wfbqZJenSG8
 djzOypN270NKIdBMvVPZiKqF7mKQaFFQZ9rOScDc=
Received: by mx.zohomail.com with SMTPS id 1771497228729933.5633510812086;
 Thu, 19 Feb 2026 02:33:48 -0800 (PST)
Date: Thu, 19 Feb 2026 10:33:44 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org,
 Wei Liu <liuwe@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: Re: [PATCH 03/10] accel/mshv: use mshv_create_partition_v2 payload
Message-ID: <aZbnCCXdRrmrYRg-@anirudh-surface.localdomain>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
 <20260211155410.203883-4-magnuskulke@linux.microsoft.com>
 <aY3WZg1JedxHtze2@anirudh-surface.localdomain>
 <20260218062358.GA2236050@liuwe-devbox-debian-v2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218062358.GA2236050@liuwe-devbox-debian-v2.local>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 18, 2026 at 06:23:58AM +0000, Wei Liu wrote:
> On Thu, Feb 12, 2026 at 01:32:22PM +0000, Anirudh Rayabharam wrote:
> > On Wed, Feb 11, 2026 at 04:54:03PM +0100, Magnus Kulke wrote:
> > > When using the extended request format we can instruct the hypervisor to
> > > provision enough space for requested XSAVE features. This is required
> > > for supporting QEMU models provided via the -cpu flag properly.
> > > 
> > > Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> > > ---
> > >  accel/mshv/mshv-all.c          |  35 +++++--
> > >  include/hw/hyperv/hvgdk_mini.h |   2 +
> > >  include/hw/hyperv/hvhdk.h      | 185 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 214 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > > index bed0fa298e..8446f7128a 100644
> > > --- a/accel/mshv/mshv-all.c
> > > +++ b/accel/mshv/mshv-all.c
> > > @@ -112,19 +112,38 @@ static int resume_vm(int vm_fd)
> > >  
> > >  static int create_partition(int mshv_fd, int *vm_fd)
> > >  {
> > > -    int ret;
> > > -    struct mshv_create_partition args = {0};
> > > +    int ret, i;
> > > +    uint64_t pt_flags;
> > > +    union hv_partition_processor_xsave_features disabled_xsave_features;
> > > +    union hv_partition_processor_features disabled_processor_features;
> > > +    struct mshv_create_partition_v2 args = {0};
> > >  
> > >      /* Initialize pt_flags with the desired features */
> > > -    uint64_t pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
> > > -                        (1ULL << MSHV_PT_BIT_X2APIC) |
> > > -                        (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES);
> > > +    pt_flags = (1ULL << MSHV_PT_BIT_LAPIC) |
> > > +               (1ULL << MSHV_PT_BIT_X2APIC) |
> > > +               (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
> > > +               (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
> > >  
> > > -    /* Set default isolation type */
> > > -    uint64_t pt_isolation = MSHV_PT_ISOLATION_NONE;
> > > +    /* enable all */
> > > +    disabled_xsave_features.as_uint64 = 0;
> > >  
> > > +    /* Enable all proc features by default */
> > 
> > Instead of enabling all features by default, we could query which
> > features are supported by the hypervisor on this host and enable only
> > those.
> > 
> > To query supported features get the HvPartitionPropertyProcessorFeatures
> > property via HvCallGetPartitionProperty (with HV_PARTITION_ID_SELF).
> > 
> > I think this would be more robust. This is what Cloud Hypervisor (well,
> > technically, the mshv crate) does.
> > 
> 
> While I think querying the hypervisor is the correct action, are we
> sure this gives all the supported features on the host?

Yes, I confirmed this with the hypervisor team when implementing it in
the mshv crate.

> 
> Is there a case that the Linux root partition  has a reduced set of
> properties?

It is my understanding that the processor features we expose to a guest
must always be a subset of the processor features of the root/parent
partition. So, if some proc feature is not available for root, we cannot
make it available for any guest partitions either.

Thanks,
Anirudh.

> 
> Wei
> 

