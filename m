Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F4BC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1truf9-0006ly-7z; Tue, 11 Mar 2025 04:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1truey-0006l4-5z
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1truew-0006jl-2l
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741680494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkJjeRoc6mEUAou/LZwl/I3fpPe7ZBYGaQFkpeBI7yE=;
 b=V52uWPTSVFC25g0F1Cfm4VMx8kmV1S34CVyGkY0+4jint6llqVq8ZK9Q2eINiCn6EA9py2
 WsdIEk9kPPTDBzBaWSBEwfetMCd1oszDkyjwWNLmBgWKG9Dz7UL35B91o0jZC/IZspv7YN
 GsH0XJ96QP7aW5KoCLLMflOgjKyis10=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-pCwD9KUKPBuN_fgRTvdx9g-1; Tue,
 11 Mar 2025 04:08:11 -0400
X-MC-Unique: pCwD9KUKPBuN_fgRTvdx9g-1
X-Mimecast-MFC-AGG-ID: pCwD9KUKPBuN_fgRTvdx9g_1741680490
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D034A19560BB; Tue, 11 Mar 2025 08:08:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.205])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00E81828A8C; Tue, 11 Mar 2025 08:08:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6F41018000A3; Tue, 11 Mar 2025 09:08:06 +0100 (CET)
Date: Tue, 11 Mar 2025 09:08:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, 
 Wei.Huang2@amd.com, bsd@redhat.com, berrange@redhat.com, ddutile@redhat.com, 
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
Message-ID: <o4swru5qsoemfs3acxcsifrzy45n4mptxh2vg3ulvnfwgirbv7@6iqvfqb76nh7>
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <20250310135731.00005b1f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310135731.00005b1f@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  Hi,

> As a heads up, I believe we have a similar problem with a few of the CXL IDs.
> The root port and type 3 device both use Intel IDs that were not reserved
> for this purpose.  VID=0x8086, DID=0x7075 and DID=0x0d93

Essentially we have two kinds of PCI devices in qemu.

 * The ones which try to mimic existing hardware, they usually have the
   PCI ID of the device they are emulating (and use the qemu subsystem ID).
   The classic example is the cirrus vga.  There are also many intel
   chipset devices for piix4 ('pc' machine type) and ich9 ('q35' machine
   type) with intel IDs.

 * The ones which are PCI class implementations and do not need a
   specific ID for drivers to accept them.  Most of them have a
   PCI device ID from the 1b36 vendor ID range.

The former tend to be older devices (before hardware standardization was
a thing, also before we got a range from 1b36 for qemu), and the latter
tend to be newer devices.  There are also a bunch of exceptions for
historical reasons.  The ahci emulation has a ich9 id.  xhci even has
two variants (one mimicking a NEC host adapter, one with qemu device id).

So, in short, using the intel IDs is not necessarily a problem.  Depends
a bit on what kind of device we are talking about.  For PCI class
devices it usually is more useful to have a qemu ID though.

> Switch ports and switch-cci are using valid Hisilicon IDs that are for
> emulation of these device only and are registered in our tracker
> for these IDs so won't get 'reused'.

That is perfectly fine.  There is no need to change IDs, although it
makes sense to document that fact in docs/specs/pci-ids.rst

Moving them to qemu pci id range is an option too if you prefer that.
Your choice.

take care,
  Gerd


