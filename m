Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDD0C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQik-0006XS-0e; Fri, 21 Feb 2025 05:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlQii-0006XD-HH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:57:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlQig-0003c0-Az
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 05:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740135440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=douF3ObJnNM82Zek65syU6wIVUS/vRBSfP5K72wyy/Y=;
 b=FjrOpZuRO8ht5q0c4xTPlZvsT72MOmMb+L6lqX1z8Ll2LNsbhWJ+Wpf+dsgWm0hDpcPAAN
 gRlrI2csf+F+K0ERQJmxH0+AQ9fVxtIO1Ha4ukooSHEfE1xOJM7+8WJV9k3ymCQmIdCP/a
 oLNke/Wf5DQ9IyHjUcT9u2sETo3iJKk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-x-2PNbESP7G-TnCqAigMMw-1; Fri, 21 Feb 2025 05:57:18 -0500
X-MC-Unique: x-2PNbESP7G-TnCqAigMMw-1
X-Mimecast-MFC-AGG-ID: x-2PNbESP7G-TnCqAigMMw_1740135437
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-438e180821aso9917635e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 02:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740135436; x=1740740236;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=douF3ObJnNM82Zek65syU6wIVUS/vRBSfP5K72wyy/Y=;
 b=qeMcRdsyIEQ3gWz8YQnTXxaUvEHVVvSxg9a78fyRokmAAjJNS/ztxOE+8D+5vg38cZ
 XEBRuB5MDDOBjnjk12YyiHmQ/cktIq27ljTADERpZaYsCBC3l+c7wXGs3tT31StSwspc
 r7mgMglIMWOnGCvisY6uNgUCUS0doE2ZQoGHNlJ2pcaCltLW2kMRy0LFqEjus7qHkgtR
 DDBPJWI6L1a5s7eiCV0yySa8y41zzaEJPUszxwFBZUAeabRmoM3N1moYgb5+9sS+9l7Z
 B24bOyIC4fnNoBaCF5ceCZ5e2v2bHZAEPHL01nolhc+Iurt4McGHIL8dIJRS2NRSgbIx
 bbzg==
X-Gm-Message-State: AOJu0YwAyWE075U9OO1nYDGOSsuW5xZTjLZArbpRS/Q6j93bcUDzUDXB
 O1fpk9OegPG/m1f8DNLEGVGdP8zLRwWV8xUoTDeNaZmC93zwEBBJneaIZG/CnZKhm1q6iTx6vla
 iCMP24GKOgHNXQv8MEfoU3hM3tPGhPOuiFEUuMdwui/PCM1pzshrY
X-Gm-Gg: ASbGnctGeBjycmCOvBrkB0f3Ry3iiuvzHgo++Arvko7Wh2zb12k1IW/mUpnBzx7Xlyg
 +L4M/3zGkrG/Thp7grJ9PzoJvz6fnzBoQPSQLVzOnCAN5MKyy6cQuycaNICHy4OaDiqinN9qEaF
 6wvth7pXYtJMCTV+t6axYfVGlp5kYoqgslzkcQc7tfH5QNP3YnodAR2jFDMLz0+1SQHueYBuM2e
 3G6T3fykm6E9RomX/XOLZqxWGH3pF/nmlZ3H0n9s9/VOlHE1blJprNkFcMlYTTt+yD3b4Of2xVg
 Uxwh+H04
X-Received: by 2002:a05:600c:1ca1:b0:439:a4d9:34a3 with SMTP id
 5b1f17b1804b1-439ae1e6619mr21849275e9.12.1740135436204; 
 Fri, 21 Feb 2025 02:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu/mSgmWMC4mgiuoCzWUizawe8ewm3JbhgaRipd0eS6ie7XJW9ksmDMsOS73JgKlkCkVFhug==
X-Received: by 2002:a05:600c:1ca1:b0:439:a4d9:34a3 with SMTP id
 5b1f17b1804b1-439ae1e6619mr21848905e9.12.1740135435637; 
 Fri, 21 Feb 2025 02:57:15 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f7:f008:ef3e:6af4:9a76:513])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d8e62sm23155358f8f.71.2025.02.21.02.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 02:57:14 -0800 (PST)
Date: Fri, 21 Feb 2025 05:57:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
 "minwoo.im@samsung.com" <minwoo.im@samsung.com>
Subject: Re: [PATCH v3 00/19] intel_iommu: Add ATS support
Message-ID: <20250221055659-mutt-send-email-mst@kernel.org>
References: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221080331.186285-1-clement.mathieu--drif@eviden.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Feb 21, 2025 at 08:07:25AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> This patch set belongs to a list of series that add SVM support for VT-d.
> 
> Here we focus on implementing ATS support in the IOMMU and adding a
> PCI-level API to be used by virtual devices.
> 
> This work is based on the VT-d specification version 4.1 (March 2023).
> 
> Here is a link to our GitHub repository where you can find the following elements:
>     - Qemu with all the patches for SVM
>         - ATS
>         - PRI
>         - Device IOTLB invalidations
>         - Requests with already pre-translated addresses
>     - A demo device
>     - A simple driver for the demo device
>     - A userspace program (for testing and demonstration purposes)
> 
> https://github.com/BullSequana/Qemu-in-guest-SVM-demo


more build failures:
https://gitlab.com/mstredhat/qemu/-/jobs/9206060668


> ===============
> 
> Context and design notes
> ''''''''''''''''''''''''
> 
> The main purpose of this work is to enable vVT-d users to make
> translation requests to the vIOMMU as described in the PCIe Gen 5.0
> specification (section 10). Moreover, we aim to implement a
> PCI/Memory-level framework that could be used by other vIOMMUs
> to implement the same features.
> 
> What is ATS?
> ''''''''''''
> 
> ATS (Address Translation Service) is a PCIe-level protocol that
> enables PCIe devices to query an IOMMU for virtual to physical
> address translations in a specific address space (such as a userland
> process address space). When a device receives translation responses
> from an IOMMU, it may decide to store them in an internal cache,
> often known as "ATC" (Address Translation Cache) or "Device IOTLB".
> To keep page tables and caches consistent, the IOMMU is allowed to 
> send asynchronous invalidation requests to its client devices.
> 
> To avoid introducing an unnecessarily complex API, this series simply
> exposes 3 functions. The first 2 are a pair of setup functions that
> are called to install and remove the ATS invalidation callback during
> the initialization phase of a process. The third one will be
> used to request translations. The callback setup API introduced in
> this series calls the IOMMUNotifier API under the hood.
> 
> API design
> ''''''''''
> 
> - int pci_register_iommu_tlb_event_notifier(PCIDevice *dev,
>                                             uint32_t pasid,
>                                             IOMMUNotifier *n);
> 
> - int pci_unregister_iommu_tlb_event_notifier(PCIDevice *dev, uint32_t pasid,
>                                               IOMMUNotifier *n);
> 
> - ssize_t pci_ats_request_translation_pasid(PCIDevice *dev, uint32_t pasid,
>                                             bool priv_req, bool exec_req,
>                                             hwaddr addr, size_t length,
>                                             bool no_write,
>                                             IOMMUTLBEntry *result,
>                                             size_t result_length,
>                                             uint32_t *err_count);
> 
> Although device developers may want to implement custom ATC for
> testing or performance measurement purposes, we provide a generic
> implementation as a utility module.
> 
> Overview
> ''''''''
> 
> Here are the interactions between an ATS-capable PCIe device and the vVT-d:
> 
>                                                                                           
>                                                                                           
>   ┌───────────┐                 ┌────────────┐                                            
>   │Device     │                 │PCI / Memory│                                            
>   │           │ pci_ats_request_│abstraction │ iommu_ats_                                 
>   │           │ translation_    │            │ request_                                   
>   │┌─────────┐│ pasid           │ AS lookup  │ translation                                
>   ││Logic    ││────────────────>│╶╶╶╶╶╶╶╶╶╶╶>│──────┐                                     
>   │└─────────┘│<────────────────│<╶╶╶╶╶╶╶╶╶╶╶│<──┐  │                                     
>   │┌─────────┐│                 │            │   │  │                                     
>   ││inv func ││<───────┐        │            │   │  │                                     
>   │└─────────┘│        │        │            │   │  │                                     
>   │    │      │        │        │            │   │  │                                     
>   │    ∨      │        │        │            │   │  │                                     
>   │┌─────────┐│        │        │            │   │  │                                     
>   ││ATC      ││        │        │            │   │  │                                     
>   │└─────────┘│        │        │            │   │  │                                     
>   └───────────┘        │        └────────────┘   │  │                                     
>                        │                         │  │                                     
>                        │                         │  │                                     
>                        │                         │  │                                     
>                        │                         │  │                                     
>                        │    ┌────────────────────┼──┼─┐                                   
>                        │    │vVT-d               │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  │ │                                   
>                        │    │                    │  ∨ │                                   
>                        │    │┌───────────────────────┐│                                   
>                        │    ││Translation logic      ││                                   
>                        │    │└───────────────────────┘│                                   
>                        └────┼────────────┐            │                                   
>                             │            │            │                                   
>                             │┌───────────────────────┐│                                   
>                             ││  Invalidation queue   ││                                   
>                             │└───────────∧───────────┘│                                   
>                             └────────────┼────────────┘                                   
>                                          │                                                
>                                          │                                                
>                                          │                                                
>                              ┌────────────────────────┐                                   
>                              │Kernel driver           │                                   
>                              │                        │                                   
>                              └────────────────────────┘
> 
> v3
>     - Rebase onto master
>     - Fix compilation issue in non-debug mode (Michael)
> 
> v2
>     - Rebase on master after merge of Zhenzhong's FLTS series
>     - Rename the series as it is now based on master.
>     
>     - Changes after review by Michael:
>     	- Split long lines in memory.h
>     	- Change patch encoding (no UTF-8)
>     
>     - Changes after review by Zhenzhong:
>     	- Rework "Fill the PASID field when creating an IOMMUTLBEntry"
> 
> 
> 
> Clement Mathieu--Drif (19):
>   memory: Add permissions in IOMMUAccessFlags
>   intel_iommu: Declare supported PASID size
>   memory: Allow to store the PASID in IOMMUTLBEntry
>   intel_iommu: Fill the PASID field when creating an IOMMUTLBEntry
>   pcie: Add helper to declare PASID capability for a pcie device
>   pcie: Helper functions to check if PASID is enabled
>   pcie: Helper function to check if ATS is enabled
>   pci: Cache the bus mastering status in the device
>   pci: Add IOMMU operations to get memory regions with PASID
>   intel_iommu: Implement the get_memory_region_pasid iommu operation
>   memory: Store user data pointer in the IOMMU notifiers
>   pci: Add a pci-level initialization function for iommu notifiers
>   atc: Generic ATC that can be used by PCIe devices that support SVM
>   atc: Add unit tests
>   memory: Add an API for ATS support
>   pci: Add a pci-level API for ATS
>   intel_iommu: Set address mask when a translation fails and adjust W
>     permission
>   intel_iommu: Return page walk level even when the translation fails
>   intel_iommu: Add support for ATS
> 
>  hw/i386/intel_iommu.c          | 125 ++++++--
>  hw/i386/intel_iommu_internal.h |   2 +
>  hw/pci/pci.c                   | 111 ++++++-
>  hw/pci/pcie.c                  |  42 +++
>  include/exec/memory.h          |  51 +++-
>  include/hw/i386/intel_iommu.h  |   2 +-
>  include/hw/pci/pci.h           |  83 ++++++
>  include/hw/pci/pci_device.h    |   1 +
>  include/hw/pci/pcie.h          |   9 +-
>  include/hw/pci/pcie_regs.h     |   5 +
>  system/memory.c                |  21 ++
>  tests/unit/meson.build         |   1 +
>  tests/unit/test-atc.c          | 527 +++++++++++++++++++++++++++++++++
>  util/atc.c                     | 211 +++++++++++++
>  util/atc.h                     | 117 ++++++++
>  util/meson.build               |   1 +
>  16 files changed, 1278 insertions(+), 31 deletions(-)
>  create mode 100644 tests/unit/test-atc.c
>  create mode 100644 util/atc.c
>  create mode 100644 util/atc.h
> 
> -- 
> 2.48.1


