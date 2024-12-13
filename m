Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A1E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5ad-0003AI-7p; Fri, 13 Dec 2024 08:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM5aX-00038g-DE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:20:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tM5aT-0006kR-8y
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734096006;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDVPbiR3ltA744kJJVDgG00hc45F88qSKEtNzbzyiqI=;
 b=gRcQUIXregrVewE+7JZO2XGuhuA4jeJnGJNyT9Px3vzzTCTo5JT8bX0w+TXTclzBu/eL5e
 ZNF71rRiu5kZOG54tKNJIXxk8By5U6VrwnxC51B9b3HFZl8LvA1tj65Amm9ZpQibG0gfej
 GNnsQm9pPjxFTS3mdRugCZ4cS6+ggkI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-qICFY9fNMmCDeWlDKOWCDQ-1; Fri,
 13 Dec 2024 08:20:00 -0500
X-MC-Unique: qICFY9fNMmCDeWlDKOWCDQ-1
X-Mimecast-MFC-AGG-ID: qICFY9fNMmCDeWlDKOWCDQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9824B19560A5; Fri, 13 Dec 2024 13:19:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 775DB195605A; Fri, 13 Dec 2024 13:19:50 +0000 (UTC)
Date: Fri, 13 Dec 2024 13:19:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, nicolinc@nvidia.com, ddutile@redhat.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z1w0cgrK6Ri6smFM@redhat.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1wsslDnwlth3A8+@nvidia.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Dec 13, 2024 at 08:46:42AM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 13, 2024 at 12:00:43PM +0000, Daniel P. Berrangé wrote:
> > On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum via wrote:
> > > Hi,
> > > 
> > > This series adds initial support for a user-creatable "arm-smmuv3-nested"
> > > device to Qemu. At present the Qemu ARM SMMUv3 emulation is per machine
> > > and cannot support multiple SMMUv3s.
> > > 
> > > In order to support vfio-pci dev assignment with vSMMUv3, the physical
> > > SMMUv3 has to be configured in nested mode. Having a pluggable
> > > "arm-smmuv3-nested" device enables us to have multiple vSMMUv3 for Guests
> > > running on a host with multiple physical SMMUv3s. A few benefits of doing
> > > this are,
> > 
> > I'm not very familiar with arm, but from this description I'm not
> > really seeing how "nesting" is involved here. You're only talking
> > about the host and 1 L1 guest, no L2 guest.
> 
> nesting is the term the iommu side is using to refer to the 2
> dimensional paging, ie a guest page table on top of a hypervisor page
> table.
> 
> Nothing to do with vm nesting.

Ok, that naming is destined to cause confusion for many, given the
commonly understood use of 'nesting' in the context of VMs...

>  
> > Also what is the relation between the physical SMMUv3 and the guest
> > SMMUv3 that's referenced ? Is this in fact some form of host device
> > passthrough rather than nesting ?
> 
> It is an acceeleration feature, the iommu HW does more work instead of
> the software emulating things. Similar to how the 2d paging option in
> KVM is an acceleration feature.
> 
> All of the iommu series on vfio are creating paravirtualized iommu
> models inside the VM. They access various levels of HW acceleration to
> speed up the paravirtualization.

... describing it as a HW accelerated iommu makes it significantly clearer
to me what this proposal is about. Perhaps the device is better named as
"arm-smmuv3-accel" ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


