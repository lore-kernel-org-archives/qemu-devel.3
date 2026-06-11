Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C177CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXg78-000899-M9; Thu, 11 Jun 2026 10:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXg76-00087D-Jd
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXg74-0003gt-Ep
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 10:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781187029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oVpjzEagnpW4axIk4JCjtQ0zJHih/2KHetrCMySV/b4=;
 b=T4jhKr1Kcblo9eVnoPgRpEx0pk/Py75X3PM1AuTf76uHxcSuagBLGMyeyWhWkMwcb+MlcM
 bD/w4LrbiFyIA4OTxVnmNrhLqKcmD7K5PN8P3cde13fNji+a8PaQHrZ5u0aYCovHZaRLV6
 oPdGyILVC8OMVjxAkw6iIvYIZKPP05o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-N6pq66FVM0-zNcgRMSDgCQ-1; Thu, 11 Jun 2026 10:10:25 -0400
X-MC-Unique: N6pq66FVM0-zNcgRMSDgCQ-1
X-Mimecast-MFC-AGG-ID: N6pq66FVM0-zNcgRMSDgCQ_1781187024
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b37e1f47so68504515e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781187024; x=1781791824; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oVpjzEagnpW4axIk4JCjtQ0zJHih/2KHetrCMySV/b4=;
 b=IwMq+Gpj53guK6FNV78jVMt3/s6W33iEaUGnOTlMQ8p587N/yKEZZnq2haqaRMr8QN
 9p7OpdQvINA/hMF6AN4KsT2xg6r+H+Jm9ITZvEv+qcS7Qwt8Smpy6AlUjSJGwWcUgmSo
 DRF4WpSMZ3ApMiU1fdw7rXMWgFdjsllde9DNNgpxLR/BNltTg8wh4wvm4HSuYP/YI63/
 zSomHCqoIGQ7i3BYqJVgXOXKfnV4K8GTnR+zvw+zjWi2Z/I2i3CR1r29GfscB2RLrpzz
 dVEiwHZAhymEpSoSKV82jOHTUDkqPDLtL2KsSUXetpa9eXxQXVvjRuYgMX1vrxNJ5AeM
 DhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187024; x=1781791824;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVpjzEagnpW4axIk4JCjtQ0zJHih/2KHetrCMySV/b4=;
 b=F15gskn58PTPPyW6FIEau+rvV3PS2INBaMkckZQnR8DdtZnvHbvddMIcgAJ2YaSSTB
 QfLhzHdrv86i1vGsRANuwNq/oNAzPrUOa38EPiKUrmvx8cfayO3YAyaMIYOZ3nVXZEY8
 WkUzngy2ywIAzBKd+fi2eFvW2G/2XV5zApxQ5ix7r0TvwPDlMxqkTHWRLKBm5IazYkL3
 dWQEOzE+YY9AC8Pw8H43dXeB9xF8pGTHoWo86e/p0oknsWD+16YC5nqUThkReraJ/jIh
 FA5+qTJAUxR7IzChhs2mr9ybKmR3VfL/J/BEz096iCseJNCjo8Lhq3ApaclMbPKRmk+k
 DLdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kDCdBUaWBFOO8T73u2W0iIPeJ1VJZbhGK5NuPkCvfDStFtWiSQWL+tn6EqpkWavSaUPGggx9XhPmm@nongnu.org
X-Gm-Message-State: AOJu0Yy2f96T8l2b0ubC1WZwtx6uEXWYcp0xWQxJ2c+Qzp+WEwlEHQto
 oSnnoKkXrP6pxFGMs6pozlKITAOtIvhYZApDhQB9/yyDFHJTOkWcbGU1Mn3Me0osrwuYPcgDA/I
 ZQqPxU8NcIpuC+Dk4aEVjT8f2JUUI7gSMx9IlaTMP+QVbtQ6rGlvl+VkY
X-Gm-Gg: Acq92OF5CX7TU8T54T6E7hDN7YJO7AbMZVguT3SmORBVDkyH8ufx07QBDhbS6K7yz6M
 rKNsggLIukTU87zINdg5otckvvjewpNqF8LYq4xe/lgs2NyVJA/cBKK/qyH2MIbHqKF/bQQwC/Z
 Kpu1/eooJorcyOZzC65HeXIeMOXl/qdhuho18d2qF3qSxY8WIXFhcwkz7zJsP5mMdjL/A6EM34A
 sNmcQj7nuG+fujNXkav5VSBeNgNpF1xAYwivdyimCJjmqirJhaB02wrB8Lg7MY1b2RuaJJX+NWS
 ShEp9HeALMPHD67BRtuqhM+xT6noPx+JhgT0fcft4a6UC9bj2Ej3jq3zYGy0Fu64XKb0vF+tWIk
 i6gyhdoocafhCmPefyYEkScsH6flKair83kRxtab7lRAE6vC6f7UWXg==
X-Received: by 2002:a05:600c:4f95:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490e55b8672mr40261365e9.5.1781187024201; 
 Thu, 11 Jun 2026 07:10:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4f95:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490e55b8672mr40260765e9.5.1781187023608; 
 Thu, 11 Jun 2026 07:10:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e532c778sm54491575e9.14.2026.06.11.07.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:10:23 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:10:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611093049-mutt-send-email-mst@kernel.org>
References: <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org>
 <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
 <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
 <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 11, 2026 at 01:48:51PM +0100, Peter Maydell wrote:
> On Thu, 11 Jun 2026 at 13:34, Gavin Shan <gshan@redhat.com> wrote:
> >
> > Let me try to summarize what I understood. As VFIO is concerned, there
> > are multiple memory regions for one particular PCI BAR, and they're stacked
> > up. The memory regions for PCI BAR#4 of the GH100 card looks as below.
> >
> >    (qemu) info mtree
> >               :
> >    address-space: pci_bridge_pci_mem
> >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> >
> >    (1) Its MemoryRegionOps is NULL. No data accesses are routed to this region
> >    (2) The data accesses routed to this region is handled by pread() and pwrite()
> >    (3) The data accesses routed to this region is handled by memcpy() before
> >        commit 4a2e242bbb.
> >
> > There are identified PCI devices who have quirks, see vfio_bar_quirk_setup().
> > Accesses to part of the PCI BAR have to be emulated by the extra IO regions,
> > something like below for rtl8168 PCI device, where two extra IO regions are
> > stacked up for the quirks.
> >
> >    address-space: pci_bridge_pci_mem
> >      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
> >        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
> >          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
> >            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
> >            0000042000000010-0000042000000014 (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[0]  <---- (4) quirk[0]
> >            0000042000000018-000004200000001c (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[1]  <---- (5) quirk[1]
> >
> > Access on 0000042000000010-0000042000000014 should be routed to region (4) quirk[0]
> > and access on 0000042000000018-000004200000001c should be routed to region (5) quirk[1].
> > However, accesses to 0000042000000000-0000042000000020 are routed to region (3) before
> > commit 4a2e242bbb and the data transfer is done by memcpy(), bypassing region (4) and
> > (5). It's not the expected behavior and why memcpy() isn't expected on device rtl8168's
> > PCI BAR due to the quirks, answering your question.
> >
> > With commit 4a2e242bbb applied, the accesses will be routed to the correct region.
> 
> The way I read 4a2e242bbb's commit message, it isn't about things being routed
> to the wrong region. It's about the handling of areas which aren't in the small
> quirk regions but which are in the same 4K page as them. These have to
> be handled
> via the memory subsystem's "subpage" mechanism. This does route
> everything to the
> correct region, but if the region (3) is marked as "direct access is OK" then
> QEMU assumes that any kind of direct access is OK, i.e. this behaves
> like true RAM.
> It then does a memcpy access to a BAR that's really a bank of device registers,
> and this goes wrong.
> 
> > Back to our case (GH100 card), there are no quirks for the PCI BAR (0009:01:00.0 BAR 4)
> > so it's fine mark the RAM DEVICE region as directly accessible. We perhaps needn't host
> > to export the capability (VFIO_REGION_INFO_CAP_DIRECT_ACCESS) suggested by you. It's
> > safe to mark any PCI BARs as directly accessible if they have no quirks attached. All
> > the devices except those listed in vfio_bar_quirk_setup() are capable of this.
> 
> I still feel like there are different kinds of PCI BAR here ("this BAR is
> true RAM and can be accessed arbitrarily" vs "this BAR is full of registers
> and can't be handled that way") and the vfio code in QEMU needs to set up
> the memory regions differently for the two cases. For your example I think
> it would be fine to have direct-access even if there were some kind of
> quirk memory region, because for the parts of the BAR that aren't covered
> by a quirk overlay the underlying BAR still allows "entirely like RAM,
> any alignment and size is OK" accesses.
> 
> -- PMM


Yea, and I feel this is the main part: 

    The assumption here is that accesses initiated by the VM are
    driven by a device specific driver, which knows the device
    capabilities.


Frankly I don't get why a big hammer of disabling direct access
was taken, when all we apparently need to do is to make sure
small aligned accesses through BAR stay aligned and same size.

I guess it felt safe - a vfio specific change, and emulating device
accesses was assumed to be slow path, anyway.

Except it no longer is with people wanting to do direct io
into device BARs.

Isn't it basically the below?
At least I checked asm and it produces the correct code.
And then the whole pile of hacks can be reverted?


diff --git a/system/physmem.c b/system/physmem.c
index 7bcbf87573..aab4390d40 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3272,7 +3272,29 @@ static MemTxResult flatview_write_continue_step(MemTxAttrs attrs,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, true);
 
-        memmove(ram_ptr, buf, *l);
+        switch (*l) {
+        case 1:
+            __builtin_memmove(ram_ptr, buf, 1);
+            break;
+        case 2:
+            __builtin_memmove(ram_ptr, buf, 2);
+            break;
+        case 4:
+            __builtin_memmove(ram_ptr, buf, 4);
+            break;
+        case 8:
+            __builtin_memmove(ram_ptr, buf, 8);
+            break;
+        default:
+            memmove(ram_ptr, buf, *l);
+            break;
+        }
         invalidate_and_set_dirty(mr, mr_addr, *l);
 
         return MEMTX_OK;
@@ -3365,7 +3387,29 @@ static MemTxResult flatview_read_continue_step(MemTxAttrs attrs, uint8_t *buf,
         uint8_t *ram_ptr = qemu_ram_ptr_length(mr->ram_block, mr_addr, l,
                                                false, false);
 
-        memcpy(buf, ram_ptr, *l);
+        switch (*l) {
+        case 1:
+            __builtin_memcpy(buf, ram_ptr, 1);
+            break;
+        case 2:
+            __builtin_memcpy(buf, ram_ptr, 2);
+            break;
+        case 4:
+            __builtin_memcpy(buf, ram_ptr, 4);
+            break;
+        case 8:
+            __builtin_memcpy(buf, ram_ptr, 8);
+            break;
+        default:
+            memcpy(buf, ram_ptr, *l);
+            break;
+        }
 
         return MEMTX_OK;
     }
-- 
MST


