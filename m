Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB7BC282D2
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 17:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpVqk-0002fL-R9; Tue, 04 Mar 2025 12:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tpVqV-0002dy-5s
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 12:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tpVqN-0000pU-OF
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 12:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741108449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UBOcm5K8gpjphkyzRxon8w0pKIphh10DRxSFhLg+W4=;
 b=SCVKqgWdvTIrbhpWzhg1EzF8aASu9wmus1nY+DP4eXrJyxNMpPGqGDYuoFY42BZs3c0VnL
 zB9Lp3B5Ve+YHON6h26j6LRgJZfqgGvEU2MLG0U75vyLG/C50SIO7jzq+mUti0QKYMpnRO
 Ne7xoPI9NcDN3oDhOHu8IyuYjOqp6oc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-QxU0W7WKPw2cenh3cPWWeg-1; Tue, 04 Mar 2025 12:14:07 -0500
X-MC-Unique: QxU0W7WKPw2cenh3cPWWeg-1
X-Mimecast-MFC-AGG-ID: QxU0W7WKPw2cenh3cPWWeg_1741108446
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39104223bb5so1262632f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 09:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741108446; x=1741713246;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8UBOcm5K8gpjphkyzRxon8w0pKIphh10DRxSFhLg+W4=;
 b=JYkX0ry0gnzmtCV77UojKuDkNWQit9o8doE4UBFqxlK2raouk7PxMBN9CmAQFMHoCD
 9pPFJKy0ZAP6hmkhDStST/bpuYfcQN4mQisRFGwH1nDfdW22ldDIerNmknAVyxwYjxrq
 eJcmamQQKAIaCEIbXlHDOn79nUGiwBKcV9tHiZKm2iya99p7TlOuzUYIXwdHkAtcyMcT
 fHhUvd+P08+CFNYRhwYWdXiyO13tx5O2KGzUxXv1VT1e6kU4mienfYE/gYn4LldLRUpt
 lFhPSvyFBSalfrnyYYDM9b2I0dHuXbfR4KK4IZRW0+TS0dmGMC1yymRXWaln47sTbYDn
 e53g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgOGCFlJ6bx3gblIfuSVvZhYYywh6JVVfXoL0uwumdmzMce9jOHlseOhjwd9uWwd8E6RI5d37iy2mA@nongnu.org
X-Gm-Message-State: AOJu0YwCmDlT8jLiyAYw3RmvhvY15c04+MyB1GePhfpnC9v3YsK9Twsw
 JkVIaKfNntOfpZ+m30UYic1VFzKwPP3L/+ftz5t2R1l5PwYc9iSHucoJ75T523+vQoOql3V8RPY
 W2FFcEjGiuaOwBtYapaxEbAkOHTbgGrm1hoBiukrz99LY8rhmaT8p
X-Gm-Gg: ASbGncsxSswNlx2XTjHDbr1U3pbONClTYLwLuBD8U+TOojtW7E5iv7Ep+hN9BRDE6ep
 4hvncbUSGcZc9CltPX1q1k7c53t7m6DJuP5XlmBN74iM3P1PoJzVW19qsTrMdWC3uJJCa+njk9w
 8kg8x2p2/3Nuf0z9i7Np7Fmfmgp9YbSvVhRAR6xuucnf57Zj0duvYA6dG3SQ1fSxBf8v5O9y9iq
 1Hto8gRnMLAS3SSq1emzhWtVSHTCl/CQm/jiMxr+haRX9Vd0qT5dN+vCyroEVvSRk3w8JsIndID
 zzbs7z9vgg==
X-Received: by 2002:a5d:6d89:0:b0:390:f815:78ca with SMTP id
 ffacd0b85a97d-390f8157bf2mr10248923f8f.30.1741108445871; 
 Tue, 04 Mar 2025 09:14:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtE9EVmfNW5vaG+RTfslL22E5ZPBPmpoqKrdXPOedERedtC1CxTTbq/dnEHyYuAQJHDOsLaQ==
X-Received: by 2002:a5d:6d89:0:b0:390:f815:78ca with SMTP id
 ffacd0b85a97d-390f8157bf2mr10248898f8f.30.1741108445461; 
 Tue, 04 Mar 2025 09:14:05 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1514:ea00:6409:9e94:fe6f:3eb6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bbb15841dsm99258155e9.1.2025.03.04.09.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 09:14:04 -0800 (PST)
Date: Tue, 4 Mar 2025 12:14:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 eric.auger.pro@gmail.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, marcel.apfelbaum@gmail.com
Subject: Re: [PATCH v2 0/5] PCI: Implement basic PCI PM capability backing
Message-ID: <20250304121346-mutt-send-email-mst@kernel.org>
References: <20250225215237.3314011-1-alex.williamson@redhat.com>
 <df7cdd6f-0d12-4903-9614-8f74e76416f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df7cdd6f-0d12-4903-9614-8f74e76416f7@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Mar 04, 2025 at 01:18:45PM +0100, Cédric Le Goater wrote:
> Hello Michael,
> 
> Could you please re-ack (or not) v2 ?
> 
> Thanks
> 
> C.


pci things:
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> On 2/25/25 22:52, Alex Williamson wrote:
> > v2:
> > 
> > Eric noted in v1 that one of the drivers had a redundant wmask setting
> > since pci_pm_init() enabled writes to the power state field.  This was
> > added because vfio-pci was not setting wmask for this capability but
> > is allowing writes to the PM state field through to the device.  For
> > vfio-pci, QEMU emulated config space is rather secondary to the config
> > space through vfio.
> > 
> > It turns out therefore, that vfio-pci is nearly unique in not already
> > managing the wmask of the PM capability state and if we embrace that
> > it's the pci_pm_init() caller's responsibility to manage the remaining
> > contents and write-access of the capability, then I think we also
> > solve the question of migration compatibility.  The new infrastructure
> > here is not changing whether any fields were previously writable, it's
> > only effecting a mapping change based on the value found there.
> > 
> > This requires only a slight change to patch 1/, removing setting of
> > the wmask, but commit log is also updated and comments added.  I also
> > made the bad transition trace a little more obvious given Eric's
> > comments.  Patch 2/ is also updated so that vfio-pci effects the wmask
> > change locally.  The couple drivers that don't currently update wmask
> > simply don't get this new BAR unmapped when not in D0 behavior.
> > 
> > Incorporated reviews for the unmodified patches.  Please re-review and
> > report any noted issues.  Thanks,
> > 
> > Alex
> > 
> > v1:
> > 
> > https://lore.kernel.org/all/20250220224918.2520417-1-alex.williamson@redhat.com/
> > 
> > Eric recently identified an issue[1] where during graceful shutdown
> > of a VM in a vIOMMU configuration, the guest driver places the device
> > into the D3 power state, the vIOMMU is then disabled, triggering an
> > AddressSpace update.  The device BARs are still mapped into the AS,
> > but the vfio host driver refuses to DMA map the MMIO space due to the
> > device power state.
> > 
> > The proposed solution in [1] was to skip mappings based on the
> > device power state.  Here we take a different approach.  The PCI spec
> > defines that devices in D1/2/3 power state should respond only to
> > configuration and message requests and all other requests should be
> > handled as an Unsupported Request.  In other words, the memory and
> > IO BARs are not accessible except when the device is in the D0 power
> > state.
> > 
> > To emulate this behavior, we can factor the device power state into
> > the mapping state of the device BARs.  Therefore the BAR is marked
> > as unmapped if either the respective command register enable bit is
> > clear or the device is not in the D0 power state.
> > 
> > In order to implement this, the PowerState field of the PMCSR
> > register becomes writable, which allows the device to appear in
> > lower power states.  This also therefore implements D3 support
> > (insofar as the BAR behavior) for all devices implementing the PM
> > capability.  The PCI spec requires D3 support.
> > 
> > An aspect that needs attention here is whether this change in the
> > wmask and PMCSR bits becomes a problem for migration, and how we
> > might solve it.  For a guest migrating old->new, the device would
> > always be in the D0 power state, but the register becomes writable.
> > In the opposite direction, is it possible that a device could
> > migrate in a low power state and be stuck there since the bits are
> > read-only in old QEMU?  Do we need an option for this behavior and a
> > machine state bump, or are there alternatives?
> > 
> > Thanks,
> > Alex
> > 
> > [1]https://lore.kernel.org/all/20250219175941.135390-1-eric.auger@redhat.com/
> > 
> > 
> > Alex Williamson (5):
> >    hw/pci: Basic support for PCI power management
> >    pci: Use PCI PM capability initializer
> >    vfio/pci: Delete local pm_cap
> >    pcie, virtio: Remove redundant pm_cap
> >    hw/vfio/pci: Re-order pre-reset
> > 
> >   hw/net/e1000e.c                 |  3 +-
> >   hw/net/eepro100.c               |  4 +-
> >   hw/net/igb.c                    |  3 +-
> >   hw/nvme/ctrl.c                  |  3 +-
> >   hw/pci-bridge/pcie_pci_bridge.c |  3 +-
> >   hw/pci/pci.c                    | 93 ++++++++++++++++++++++++++++++++-
> >   hw/pci/trace-events             |  2 +
> >   hw/vfio/pci.c                   | 34 ++++++------
> >   hw/vfio/pci.h                   |  1 -
> >   hw/virtio/virtio-pci.c          | 11 ++--
> >   include/hw/pci/pci.h            |  3 ++
> >   include/hw/pci/pci_device.h     |  3 ++
> >   include/hw/pci/pcie.h           |  2 -
> >   13 files changed, 127 insertions(+), 38 deletions(-)
> > 


