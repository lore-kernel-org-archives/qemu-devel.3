Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070C2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 15:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjhr9-0001Ro-9g; Mon, 11 Mar 2024 11:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rjhqu-0001H5-3B
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rjhqr-0000Ue-QJ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 11:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710171967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klLcYPmwuvNOHTVTc6kUbAJpnu1dLjWB+xAjuP+Ho5M=;
 b=XPOFzMQbzT1Ju5dbSH1eaitLkFHhGT9sNTYzf3yWJ2Va157q0HUaxuiyvFWxFg9QEP0H89
 IB1lkc03qU8KkQNLgeyQHx7rFu5AQBsbDsL9NAQZuO2vDbrzF4aylSMEPNgBC2VWp2sDM5
 rids43BCt/0QP1nrjzoMK8UWrnSkNgk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-oXhiyTi1O_WCWsZvnsYD1g-1; Mon, 11 Mar 2024 11:46:05 -0400
X-MC-Unique: oXhiyTi1O_WCWsZvnsYD1g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33e6f9ce74dso2129254f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 08:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710171964; x=1710776764;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klLcYPmwuvNOHTVTc6kUbAJpnu1dLjWB+xAjuP+Ho5M=;
 b=KF3UNJVPDJr6ipCfb+Xmq/IbIV+M2MtkYQ2bYQlv0DR3/iBoZt1MmGAeRmP30lpwWR
 b8Zk78B2Xlt2FhvmGKjMc/TBtATnF2vREmUZk/0+yt/nRnzx+O/YdY0garlANCOeXS5Z
 XxaBTsIV7tXh0VsA3aCeUdpZ7wHjDMhLE53ChTcaOFtAka6K4REStz6oq+tFNhm2NVI4
 dRnirhUlNZNY9rkwNsYQaa7lFhOSM8XnlIOHawm751P/ZHHo9SWvz1hZ7lqDNaFgC6jY
 nKpTeNzDRCFbwBQeU8tWZxdWiPQWaT5lCCcHzpw/hVvzmAt0XIvqAqcZ65d7RzHtBkAV
 1K6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgu1BM9/oVwC6xnlwxbvyu6cabGK1Xr5dF7MZESJuA8J6qZOK+JiHvrx8/c8oMqOrT+Fkk+ZJ41MIJiQvBNcq2rAt70TE=
X-Gm-Message-State: AOJu0Yx0JWBanX/1NWi2fZ8pcamfjyQFq5yYLnkLOk02h8fjmOP53+Je
 EnslEYQK0kNfrUh2GsoJ6bCgdEKWC8MX5Z+fqrlMx0A2NT5UoB2EUwpL0FNJNcAMGh9fEEy53i5
 1K5lh5rAjCaSFxSHIWV9m5YbTqiK55wJgvhhSWMgHLOyMZeayaD6Y
X-Received: by 2002:a05:600c:1d28:b0:413:2cbb:4db9 with SMTP id
 l40-20020a05600c1d2800b004132cbb4db9mr1298643wms.28.1710171964482; 
 Mon, 11 Mar 2024 08:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvJ65+z59WleL0DWt6iLdvSq1xk4lqDYzj/E+EpWSzSaR5gRoZ8X/s7RIso8x64tBNvrjMKQ==
X-Received: by 2002:a05:600c:1d28:b0:413:2cbb:4db9 with SMTP id
 l40-20020a05600c1d2800b004132cbb4db9mr1298607wms.28.1710171963815; 
 Mon, 11 Mar 2024 08:46:03 -0700 (PDT)
Received: from redhat.com ([2.52.134.16]) by smtp.gmail.com with ESMTPSA id
 p11-20020a05600c358b00b00412ebd587ebsm16092471wmq.3.2024.03.11.08.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 08:46:03 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:45:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: ankita@nvidia.com, jgg@nvidia.com, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com,
 alex.williamson@redhat.com, pbonzini@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, ani@anisinha.ca,
 berrange@redhat.com, eduardo@habkost.net, imammedo@redhat.com,
 eblake@redhat.com, armbru@redhat.com, david@redhat.com,
 gshan@redhat.com, Jonathan.Cameron@huawei.com, aniketa@nvidia.com,
 cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 vsethi@nvidia.com, acurrid@nvidia.com, mochs@nvidia.com,
 dnigam@nvidia.com, udhoke@nvidia.com, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v9 0/3] acpi: report NUMA nodes for device memory using GI
Message-ID: <20240311114543-mutt-send-email-mst@kernel.org>
References: <20240308145525.10886-1-ankita@nvidia.com>
 <2f86279d-3c0e-447b-97ae-f4257b84ad71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f86279d-3c0e-447b-97ae-f4257b84ad71@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 11, 2024 at 11:39:11AM +0100, Cédric Le Goater wrote:
> On 3/8/24 15:55, ankita@nvidia.com wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>
> > 
> > There are upcoming devices which allow CPU to cache coherently access
> > their memory. It is sensible to expose such memory as NUMA nodes separate
> > from the sysmem node to the OS. The ACPI spec provides a scheme in SRAT
> > called Generic Initiator Affinity Structure [1] to allow an association
> > between a Proximity Domain (PXM) and a Generic Initiator (GI) (e.g.
> > heterogeneous processors and accelerators, GPUs, and I/O devices with
> > integrated compute or DMA engines).
> > 
> > While a single node per device may cover several use cases, it is however
> > insufficient for a full utilization of the NVIDIA GPUs MIG
> > (Mult-Instance GPUs) [2] feature. The feature allows partitioning of the
> > GPU device resources (including device memory) into several (upto 8)
> > isolated instances. Each of the partitioned memory requires a dedicated NUMA
> > node to operate. The partitions are not fixed and they can be created/deleted
> > at runtime.
> > 
> > Linux OS does not provide a means to dynamically create/destroy NUMA nodes
> > and such feature implementation is expected to be non-trivial. The nodes
> > that OS discovers at the boot time while parsing SRAT remains fixed. So we
> > utilize the GI Affinity structures that allows association between nodes
> > and devices. Multiple GI structures per device/BDF is possible, allowing
> > creation of multiple nodes in the VM by exposing unique PXM in each of these
> > structures.
> > 
> > Implement the mechanism to build the GI affinity structures as Qemu currently
> > does not. Introduce a new acpi-generic-initiator object to allow host admin
> > link a device with an associated NUMA node. Qemu maintains this association
> > and use this object to build the requisite GI Affinity Structure.
> > 
> > When multiple NUMA nodes are associated with a device, it is required to
> > create those many number of acpi-generic-initiator objects, each representing
> > a unique device:node association.
> > 
> > Following is one of a decoded GI affinity structure in VM ACPI SRAT.
> > [0C8h 0200   1]                Subtable Type : 05 [Generic Initiator Affinity]
> > [0C9h 0201   1]                       Length : 20
> > 
> > [0CAh 0202   1]                    Reserved1 : 00
> > [0CBh 0203   1]           Device Handle Type : 01
> > [0CCh 0204   4]             Proximity Domain : 00000007
> > [0D0h 0208  16]                Device Handle : 00 00 20 00 00 00 00 00 00 00 00
> > 00 00 00 00 00
> > [0E0h 0224   4]        Flags (decoded below) : 00000001
> >                                       Enabled : 1
> > [0E4h 0228   4]                    Reserved2 : 00000000
> > 
> > [0E8h 0232   1]                Subtable Type : 05 [Generic Initiator Affinity]
> > [0E9h 0233   1]                       Length : 20
> > 
> > On Grace Hopper systems, an admin will create a range of 8 nodes and associate
> > them with the device using the acpi-generic-initiator object. While a
> > configuration of less than 8 nodes per device is allowed, such configuration
> > will prevent utilization of the feature to the fullest. This setting is
> > applicable to all the Grace+Hopper systems. The following is an example of
> > the Qemu command line arguments to create 8 nodes and link them to the device
> > 'dev0':
> > 
> > -numa node,nodeid=2 -numa node,nodeid=3 -numa node,nodeid=4 \
> > -numa node,nodeid=5 -numa node,nodeid=6 -numa node,nodeid=7 \
> > -numa node,nodeid=8 -numa node,nodeid=9 \
> > -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.0,addr=04.0,rombar=0,id=dev0 \
> > -object acpi-generic-initiator,id=gi0,pci-dev=dev0,node=2 \
> > -object acpi-generic-initiator,id=gi1,pci-dev=dev0,node=3 \
> > -object acpi-generic-initiator,id=gi2,pci-dev=dev0,node=4 \
> > -object acpi-generic-initiator,id=gi3,pci-dev=dev0,node=5 \
> > -object acpi-generic-initiator,id=gi4,pci-dev=dev0,node=6 \
> > -object acpi-generic-initiator,id=gi5,pci-dev=dev0,node=7 \
> > -object acpi-generic-initiator,id=gi6,pci-dev=dev0,node=8 \
> > -object acpi-generic-initiator,id=gi7,pci-dev=dev0,node=9 \
> > 
> > The performance benefits can be realized by providing the NUMA node distances
> > appropriately (through libvirt tags or Qemu params). The admin can get the
> > distance among nodes in hardware using `numactl -H`.
> > 
> > This series goes along with the recenty added vfio-pci variant driver [3].
> > 
> > Applied over v8.2.2
> > base commit: 11aa0b1ff115b86160c4d37e7c37e6a6b13b77ea
> > 
> > [1] ACPI Spec 6.3, Section 5.2.16.6
> > Link: https://www.nvidia.com/en-in/technologies/multi-instance-gpu [2]
> > Link: https://lore.kernel.org/all/20240220115055.23546-1-ankita@nvidia.com/ [3]
> > 
> > Link for v8:
> > Link: https://lore.kernel.org/all/20240306123317.4691-1-ankita@nvidia.com/
> 
> v9 looks ready for QEMU 9.0. An Ack from the ACPI supporters is missing
> though.
> 
> Michal, Igor, Ani,
> 
> Did you have time to take a look ?
> 
> Thanks
> 
> C.

I tagged it already.

> 
> 
> > v8 -> v9
> > - Removed unused included headers based on Jonathan's suggestion.
> > - Collected Reviewed-by from Jonathan.
> > - Added acpi-generic-initiator support for i386
> > - Moved HMAT change from patch 1/2 to 2/3.
> > - Fixed nits.
> > 
> > v7 -> v8
> > - Replaced the code to collect the acpi-generic-initiator objects
> >    with the code to use recursive helper object_child_foreach_recursive
> >    based on suggestion from Jonathan Cameron.
> > - Added sanity check for the node id passed to the
> >    acpi-generic-initiator object.
> > - Added change to use GI as HMAT initiator as per Jonathan's suggestion.
> > - Fixed nits pointed by Marcus and Jonathan.
> > - Collected Marcus' Acked-by.
> > - Rebased to v8.2.2.
> > 
> > v6 -> v7
> > - Updated code and the commit message to make acpi-generic-initiator
> >    define a 1:1 relationship between device and node based on
> >    Jonathan Cameron's suggestion.
> > - Updated commit message to include the decoded GI entry in the SRAT.
> > - Rebased to v8.2.1.
> > 
> > v5 -> v6
> > - Updated commit message for the [1/2] and the cover letter.
> > - Updated the acpi-generic-initiator object comment description for
> >    clarity on the input host-nodes.
> > - Rebased to v8.2.0-rc4.
> > 
> > v4 -> v5
> > - Removed acpi-dev option until full support.
> > - The NUMA nodes are saved as bitmap instead of uint16List.
> > - Replaced asserts to exit calls.
> > - Addressed other miscellaneous comments.
> > 
> > v3 -> v4
> > - changed the ':' delimited way to a uint16 array to communicate the
> > nodes associated with the device.
> > - added asserts to handle invalid inputs.
> > - addressed other miscellaneous v3 comments.
> > 
> > v2 -> v3
> > - changed param to accept a ':' delimited list of NUMA nodes, instead
> > of a range.
> > - Removed nvidia-acpi-generic-initiator object.
> > - Addressed miscellaneous comments in v2.
> > 
> > v1 -> v2
> > - Removed dependency on sysfs to communicate the feature with variant module.
> > - Use GI Affinity SRAT structure instead of Memory Affinity.
> > - No DSDT entries needed to communicate the PXM for the device. SRAT GI
> > structure is used instead.
> > - New objects introduced to establish link between device and nodes.
> > 
> > Ankit Agrawal (3):
> >    qom: new object to associate device to NUMA node
> >    hw/acpi: Implement the SRAT GI affinity structure
> >    hw/i386/acpi-build: Add support for SRAT Generic Initiator structures
> > 
> >   hw/acpi/acpi_generic_initiator.c         | 148 +++++++++++++++++++++++
> >   hw/acpi/hmat.c                           |   2 +-
> >   hw/acpi/meson.build                      |   1 +
> >   hw/arm/virt-acpi-build.c                 |   3 +
> >   hw/core/numa.c                           |   3 +-
> >   hw/i386/acpi-build.c                     |   3 +
> >   include/hw/acpi/acpi_generic_initiator.h |  47 +++++++
> >   include/sysemu/numa.h                    |   1 +
> >   qapi/qom.json                            |  17 +++
> >   9 files changed, 223 insertions(+), 2 deletions(-)
> >   create mode 100644 hw/acpi/acpi_generic_initiator.c
> >   create mode 100644 include/hw/acpi/acpi_generic_initiator.h
> > 


