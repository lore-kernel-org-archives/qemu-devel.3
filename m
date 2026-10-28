Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F7606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jIr5EFz3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GXRj77FB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7Gz-0001cW-QR; Wed, 28 Oct 2026 13:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Fe-00077K-3V
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FW-0003no-DI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AIt1SMuBtROHEbuliWSeNBUdFvYjjD22gy4AEmd1QVc=;
 b=jIr5EFz3qGD2ruAlHnTnmlwQbTN1I7YsRd5vToUga+265MXNEBPOl4T+V+bTVVJAkZmOLI
 n/OmOXgS26RSlVDJ1BxlqQFf1lK719dHWvglOfWye6OvfFjvi2/NjQzNVCE6xvaaKFF1qc
 vi150l/KG5yf+3R5Ma9XL1H0pvylnIM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-STIFpF4TPym0HQDfi_cFwg-1; Wed, 28 Oct 2026 13:15:33 -0400
X-MC-Unique: STIFpF4TPym0HQDfi_cFwg-1
X-Mimecast-MFC-AGG-ID: STIFpF4TPym0HQDfi_cFwg_1793207733
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c46582442so803030f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207732; x=1793812532; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AIt1SMuBtROHEbuliWSeNBUdFvYjjD22gy4AEmd1QVc=;
 b=GXRj77FBjZOuwh0dJVrU10nuybvwHtq5jQJVmwFvCZdcQHbQhWfhwAzUgRWn+KDit6
 JKi4FxK56QLEt3iebLrdckWRl6q/9v3D5iycSsJk/5yig6NfacuJhU2jjhSElT698fAP
 9fJRolNdMrGCQu8a965H8DJJspml9LM3Ndmlq6xCAGJLUrLppDEUx3ABw1jw+1vE9N1h
 SBfCkrek7qDYBHOS/Pqhllg8h7FWfCzK060dvwwZD75UQES6o9usCzzhdoyR7GH771fA
 idEZ94F25KFBHVfvD+I/QzBUBxL0mlmn1+7VYeuHncqhC8nky5Cbv3sL6sMvS++y98qK
 0ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207732; x=1793812532;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AIt1SMuBtROHEbuliWSeNBUdFvYjjD22gy4AEmd1QVc=;
 b=oKQqQBn5mIrdckTJVjLZ+wUPv7ovs2bo2ggEM4tv44olI92X1p91XYMSfWmK6Zd/uX
 5CI2p9FQFoEQBEHiUKDVvQZXWgnZuwY9bMtvhtyDphtcVfaAQkwmmi5v+EbqKwe4+mSg
 p0MQXrWUGiIGZr2p6OyjAjnBiafzWrYJybDtwTemsOvXYw+rShrmHOjsiX4G7eCAChMy
 W9NosPON2Iryo0pEzagbNUdLjt0bjSccSSMO30Ib0ND8yn3+6GY8SKcLy5pdL6ESV6x9
 VAKwZV1o4n6uAE1BNQRSIHP1tPmYxT+4euRAHKIBgsEVbuU3j7Ob2tIt3Vqss7eOImQz
 O0wg==
X-Gm-Message-State: AFq9FYJO7OLDGNr/Gxz4km/kU0BYgxqljcBizpt0CueGJ1M7DZ7w7Vwc
 xwUZq2rOFPYu3hseyDQjuTf49+UockIICUW1qjTvikiGcOP0OWwcgbynV4X1g+9VGZmaMcCHz4c
 LIDm4THh5RQSNYoyMIaY1TPJK16gqsZQCAao2BpUOtmvQmfX6eRTFffNKHwInjEbsdie9m3TfIf
 EIo9QV4d03UEExmxQlrTKKx/1iIXOAT2YozA==
X-Gm-Gg: AYBFou1uDDjX2Dv+tcqBwtphhhqM3QI/aEIaTGAZ9B9RLBJv/52cgYRMEs07LYmztU6
 EqL+xLE8MF+5PBcvjyL2rb8sIyzbVJeo+8QdTkAJeGgl/TxJy7rP/BJGjw02KYpqRyJ762wwb/h
 1UoDhWu0gkMIG0s+EzonuL1IROEqhbGOoKWe5urcrVdewFL1snTNgrjmYsw/15sJ578UEAZayZB
 jat9MnnT1tSKrli6I/MtzFaMxxVWcqirwsh2SfqCqkv7DlC+GvEfBvIAfIl1FeTdUJRoeUgAR+i
 PKV8UErjWYPs8ZsLOv/o5PyOzCH1Rcwq6cmpsTxuwsqhwpu04wJWxycvKgFF5qawS90smXebsjg
 +xW42OZOj7aXwu5nDkWCImYfmfEPoFOnv4Y+z67F+
X-Received: by 2002:a5d:6512:0:b0:48e:82f:48f7 with SMTP id
 ffacd0b85a97d-48e5d5b565bmr5621191f8f.10.1793207731506; 
 Wed, 28 Oct 2026 10:15:31 -0700 (PDT)
X-Received: by 2002:a5d:6512:0:b0:48e:82f:48f7 with SMTP id
 ffacd0b85a97d-48e5d5b565bmr5621119f8f.10.1793207730933; 
 Wed, 28 Oct 2026 10:15:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3da7sm30955744f8f.20.2026.10.28.10.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:30 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>, qemu-stable@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 34/78] hw/cxl: destroy primary CCI before re-initialization on
 reset
Message-ID: <ae32a69fabebf1f0805786085fe98d6cf32f8946.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

ct3d_reset() re-initializes the primary CCI through the call chain
cxl_device_register_init_t3() -> cxl_initialize_mailbox_t3() ->
cxl_init_cci(), but never calls cxl_destroy_cci() first.  Each reset
cycle therefore leaks the old timer and leaves the old mutex
undestroyed while silently overwriting the CCI state.

Per CXL r4.0, the "Mailbox Interfaces Ready" bit in the Memory Device
Status register (Table 8-212) is set after a Conventional Reset or CXL
Reset once the device has re-initialized its mailbox interfaces.  The
CCI is the software abstraction of these interfaces and must be properly
torn down before re-initialization.

The secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) already follow
the correct destroy-before-reinit pattern in the same function; apply
the same discipline to the primary CCI.

Also destroy the secondary CCIs in ct3_exit() where they were
previously leaked at device removal time.  Guard the primary CCI
teardown there with the same .initialized check used for the secondary
CCIs: the primary CCI is only brought up from the reset path
(cxl_device_register_init_t3()), so a device that is unrealized before
its first reset would otherwise tear down a never-initialized CCI.

Fixes: cac36a8faffc ("hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState")
Cc: qemu-stable@nongnu.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-3-junjie.cao@intel.com>
---
 hw/mem/cxl_type3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a04dc74ecc..363ac632f9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,7 +1076,15 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    cxl_destroy_cci(&ct3d->cci);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1331,6 +1339,9 @@ static void ct3d_reset(DeviceState *dev)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
MST


