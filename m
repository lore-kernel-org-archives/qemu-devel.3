Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C9606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VXgTy4w+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KTk0SnfI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Fy-0007rR-VR; Wed, 28 Oct 2026 13:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FU-0006zo-MA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FS-0003nI-VE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pf8PmGwR2YJ387k0YNnxAMREMMMwLfksgc13IZc+PLg=;
 b=VXgTy4w+TW8Px4EKB0lW1LwkGLMMwEm/hvbKUI4v+7Mm/XC8zV6tPtoAGpRKDky0LciUPN
 vGqyZTfkxjtRuOuwEl4p2D78PTa6T7a12t8MIabgw/rcC2I6unRYSh55DFRjBxfl7QydsK
 zL4PJ/XSDtg1Y4bNrvqkDLGxPNbroC4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-PjNBj-zAOJmSiAD7-SPqfg-1; Wed, 28 Oct 2026 13:15:35 -0400
X-MC-Unique: PjNBj-zAOJmSiAD7-SPqfg-1
X-Mimecast-MFC-AGG-ID: PjNBj-zAOJmSiAD7-SPqfg_1793207734
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e00f3929bso1386180f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207734; x=1793812534; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pf8PmGwR2YJ387k0YNnxAMREMMMwLfksgc13IZc+PLg=;
 b=KTk0SnfIx39/+qIxlYnxahwqg73OYo8LUUWtPc3mdrn3ShelzsKlSp9JOWbZlqKA09
 7EolxKhhgde6cohHiqB8TFyRZNSxIAayxMj3tcooQDeaDpaccZkiChjln6liLSqo8D0T
 Qa4trm2s+9WQr7+ZMfFDJSPISyZDIMw/H8yGOSXApqZVJz6gVDnzrNNFpo0mxc3psD9B
 pmGAoydtDKWJPHqaOHdr4ejxHBJbRZS26QOT6KXSvLXkZ2i1pf71BVtSMAvh7qz/+asj
 UiwDZ3Unxh6mcd+bQxM5XQVB78+LJu1Cn97nhkxvExDQgJrWaIgAje1TGM+nRjAMnPfG
 pE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207734; x=1793812534;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pf8PmGwR2YJ387k0YNnxAMREMMMwLfksgc13IZc+PLg=;
 b=wkj+w1jHn2HHu/02BzRG8vwwjtWcoMzazr0A5xbE3f4EUqd7qpJwJ0rGOCItfBs53T
 g3BMkk1LN3d3qNdqU38ExJG0fJfc5femtlGRJHvQcXVCdQ0mvqe1gvfVyQ6WDbZJFAAs
 ZGgwWskEuzk0Geaf0qh/aEGazA9wFDbopIlERWkacuYpNRjLsxYo1WZTEj1w09h9aqfW
 IdVK9PCjIRcLozulHG93MqnqaBB7q/HqLbplXi+G9emLibV7Yvsft3+BdPal8BkNnxQq
 pKWue4qm7cnYJKsfMD0/eJP0pfIHZTqRhUHTJruNKsflbH/bbju/X3ZBGo/zYF8j3AKL
 yXaA==
X-Gm-Message-State: AFq9FYKqQk0l04AxZSx+zuVeURK1BY3xaiVHxZHLO5BS6twGpVSKe9A6
 lzwL42utfbzsPn3jkW1V028d3QDImqR7ry6Snj6vaomc5pU5CBEa8h/0WfVh+kS08+AYXa8wUnp
 XddOK7ppY+cUc2zx09FVB/5uOSZoo2jqGmCe6oTnTeQSQ3mMThLO8+SRwuud48gOM2PpBFMU/4K
 VCp7r3BDD8t6D7X+HjGYAKsxOwxE8eJIK+BA==
X-Gm-Gg: AYBFou19xKmapTHEGu1kLidbFc6dwSLqYZ5zEY2AaX+CvusHsiLbdeothQbk3Pvmb9H
 +jyRXaJ1y02xh99/2uxEd75btuG+fu/8GPzfsTLxSMKkW3H3d6vJIQoxRbEhjKxV++4JVSSxnSv
 ecG4fxRjDHqpb4RWZ6eOj++o+tkSMMv8l5nu8/JesMpueMxCOUB4CFGM40MgkemOIpJsukSV27u
 YsFF+f0DX5fa2poDfStzW6UMw7z0QiqAaCRLMow+dGSezbLMEqgRjoPX/IIpJHOq2NkdaSt/cVI
 VBxbX+XqsVFi0QJm2Q27X3FhVG/sF+aynT6QuA1AFdh457bU5FsHOz6EjRHTmB8NXQu5cipg9/9
 /TOUdmQFVdB0VMyUwlknPetLROoPQm64euTdiHO0X
X-Received: by 2002:a05:6000:2285:b0:48d:ed0e:6bb4 with SMTP id
 ffacd0b85a97d-48e6494c244mr494914f8f.4.1793207734093; 
 Wed, 28 Oct 2026 10:15:34 -0700 (PDT)
X-Received: by 2002:a05:6000:2285:b0:48d:ed0e:6bb4 with SMTP id
 ffacd0b85a97d-48e6494c244mr494832f8f.4.1793207733364; 
 Wed, 28 Oct 2026 10:15:33 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3705sm35312066f8f.45.2026.10.28.10.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:32 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 35/78] hw/cxl: convert cxl-type3 to three-phase reset
Message-ID: <a59e80eb792ade6efc48aac5bf0589587e02a5e6.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Junjie Cao <junjie.cao@intel.com>

Replace the deprecated device_class_set_legacy_reset() registration
with the three-phase resettable interface, following the pattern
already established by the CXL root port (cxl_rp_reset_hold).

Only the hold phase is needed; enter and exit are left NULL.  The
parent hold phase is chained for correctness: TYPE_PCI_DEVICE installs
no hold phase today, so parent_phases.hold is currently NULL and the
chained call is a no-op, but capturing and invoking it is the correct
forward-compatible pattern and mirrors cxl_rp_reset_hold().

No functional change — the reset body is identical; only the
registration path and function signature change.

Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-4-junjie.cao@intel.com>
---
 include/hw/cxl/cxl_device.h |  2 ++
 hw/mem/cxl_type3.c          | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa5f9..b7e20e3fe4 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -805,6 +805,8 @@ struct CXLType3Class {
     /* Private */
     PCIDeviceClass parent_class;
 
+    ResettablePhases parent_phases;
+
     /* public */
     uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 363ac632f9..734397da62 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1329,13 +1329,18 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
     return address_space_write(as, dpa_offset, attrs, &data, size);
 }
 
-static void ct3d_reset(DeviceState *dev)
+static void ct3d_reset_hold(Object *obj, ResetType type)
 {
-    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    CXLType3Dev *ct3d = CXL_TYPE3(obj);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(obj);
     uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
-    pcie_cap_fill_link_ep_usp(PCI_DEVICE(dev), ct3d->width, ct3d->speed,
+    if (cvc->parent_phases.hold) {
+        cvc->parent_phases.hold(obj, type);
+    }
+
+    pcie_cap_fill_link_ep_usp(PCI_DEVICE(obj), ct3d->width, ct3d->speed,
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
@@ -2467,6 +2472,7 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
     CXLType3Class *cvc = CXL_TYPE3_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
@@ -2480,9 +2486,11 @@ static void ct3_class_init(ObjectClass *oc, const void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "CXL Memory Device (Type 3)";
-    device_class_set_legacy_reset(dc, ct3d_reset);
     device_class_set_props(dc, ct3_props);
 
+    resettable_class_set_parent_phases(rc, NULL, ct3d_reset_hold, NULL,
+                                       &cvc->parent_phases);
+
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
-- 
MST


