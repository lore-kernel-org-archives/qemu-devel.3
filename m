Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D90606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZNCy3NnP;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MUhdpZiu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7G1-000872-Px; Wed, 28 Oct 2026 13:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FW-000706-0e
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7FT-0003nQ-UY
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CjpUzIsNOb0Gi1AMTefZD+fS3OB+LfiwSls4fdj5fMg=;
 b=ZNCy3NnPihT5CLy/a3Fcrp1QrMmOW0II4PHj2Prsv0c8OOD/nJZcEzgmkOFYE9DqJWCEti
 840fnG+MBgyJ9msbzlsYHfYGhuc0GkbYAqzzOvSk1zT/Xr3dVi6mBbgRtQBclKPD5c5R4K
 HdN+7vxNlDdvg4nPIsN/Lln7GHoAAok=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-SFHbFDREMv-d4vY1cJBULQ-1; Wed, 28 Oct 2026 13:15:38 -0400
X-MC-Unique: SFHbFDREMv-d4vY1cJBULQ-1
X-Mimecast-MFC-AGG-ID: SFHbFDREMv-d4vY1cJBULQ_1793207736
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a204ac318aso7501475e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207736; x=1793812536; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CjpUzIsNOb0Gi1AMTefZD+fS3OB+LfiwSls4fdj5fMg=;
 b=MUhdpZiu0B8xoBVk6k2cZ45Y95RalXhehS8lZWECkRWq0IZRnG++F7CEM7VQszkcex
 WxXPfX7Caxe4L/jWear+62xoEYqAJJTIWukplIz7hETSCXDvhqKDy39tKN6J5tawO3o9
 U1wm3X6Wyd7tN8GmYoK4ezPrctclFK276wBF1c3+F9BXXB9evadZVxQIRhXBUA7r5Wdn
 cCvD1L3h8JSZr8pq/mNxn5ysDY104CyBgr4prjEpd5rRVBhNsc9YypkGKQ+6WzpIhK2c
 umk+kXZH8J7NH0IhXQa9P4w2minjGOQ/ZWzxmOhiQHWFdChiH3/av6jYj4ruO/4cy4/U
 Z6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207736; x=1793812536;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CjpUzIsNOb0Gi1AMTefZD+fS3OB+LfiwSls4fdj5fMg=;
 b=tdjH+lra1VmXbAToVVJ5/D5C01Blwl+Aow0ZmjmnTGqfOD7YjpBTEkWXaU+9Hn6rvS
 uIgUrU9yrgTVuzBDwV09Uy7axIsktvk//tsRa7CPClQn2zKEGmhIrKDwckgaEhkVCBCd
 WSWPWV7g6pq4dsOTA+cI4K3jSmTg6xoQCRCTSBL7YMm7DHPtuyjdxBAHl+D9fxXbYMlz
 W2ggQBrXjuB9FA47ous8sQEwJRslPyZvxXuo9xonBmzL2hvBtSVDDPqYw/YytqgtcayD
 3kUrXAE40ZIkbUgPiP5ADDtEtyG+Hi2jBNIR49usJB+4bghD/8kBZK2LWxuQcuBt18t+
 UrQg==
X-Gm-Message-State: AFq9FYLDaXAlTJHfgEwAB6sP6UwTkApSRKhcRxyly+L43P6LOeQCiIKz
 hJsZWblWICMD8c9HpG6JIkqkA+L2B5CddpbcuI9J7ozW0MQpoD8DtCawHikpF3UO0Ot2J4o7jrd
 T9PjDaRqR14IfIOCotmGWmOzmGrmre9SoXavr37EYSOF04FJ8UxyOykYopqrLHPhf2LLFAxTver
 w+TaKNwKYCB7T558sVfruVIPQMGA6AmUfPwQ==
X-Gm-Gg: AYBFou1I/rTaBTBDmpqNM3gVnvgFXu8KBqhHqSUIHna+R4uA+2PufoHQLOJEpQGDUzm
 +jscOzZvdZXAOnT7ZNpQWfmiFfWLwLWXaOmT9eIXwEMFnagGp+WrDAUqDCk3fC8a3QrEDNsD9JX
 TueE/t2gPrkzy6H7vvd7HeKU2ItkA9kz0EReEcPFx14hEaxNOCfFiaO0VGVaMiBxme4DENSNWp8
 5tUZJxLiXaZTFvCEp8pFd/852Bl4SbtdhqrM7FkqQMk7U+2Gr5tTDLNKud70QV5FFpU+JEvBY4u
 hQ367ssq+A+p5co0pgz8gbPCPI9xpZhRowNoXliKd/u9Tw0DFCefFygQ75ehZN54ZYfZr8/TPqy
 MPeeLDuGEeGUMIJDQDDqiq688Ny3xqDvNBEHgkSG4
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4a9678c3cadmr71204515e9.35.1793207736298; 
 Wed, 28 Oct 2026 10:15:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3556:b0:4a2:1cc:6551 with SMTP id
 5b1f17b1804b1-4a9678c3cadmr71203535e9.35.1793207735736; 
 Wed, 28 Oct 2026 10:15:35 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f7f52e2sm6898845e9.9.2026.10.28.10.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:35 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Junjie Cao <junjie.cao@linux.dev>, Anisa Su <anisa.su@samsung.com>,
 linux-cxl@vger.kernel.org
Subject: [PULL 36/78] hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox
 teardown counterpart
Message-ID: <a900c591ce1d3d5a017044f34d658b5b632000db.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

The primary CCI teardown is open-coded, guarded by .initialized, at
the two places that need it: the reset path (before
cxl_device_register_init_t3() brings the mailbox back up) and
ct3_exit().

Factor it into cxl_destroy_mailbox_t3(), the teardown counterpart of
cxl_initialize_mailbox_t3(), keeping the .initialized guard inside the
helper: the primary CCI is only brought up from the reset path, so the
first reset after realize and an unrealize before any reset must both
skip the teardown.

No functional change.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260729144645.1552511-5-junjie.cao@intel.com>
---
 include/hw/cxl/cxl_device.h | 1 +
 hw/cxl/cxl-mailbox-utils.c  | 7 +++++++
 hw/mem/cxl_type3.c          | 8 ++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b7e20e3fe4..608d05165a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -325,6 +325,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 603677a97b..bc00fec9f8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4843,6 +4843,13 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
     cxl_init_cci(cci, payload_max);
 }
 
+void cxl_destroy_mailbox_t3(CXLType3Dev *ct3d)
+{
+    if (ct3d->cci.initialized) {
+        cxl_destroy_cci(&ct3d->cci);
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set_t3_ld[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 734397da62..04558a114f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1076,9 +1076,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     msix_uninit_exclusive_bar(pci_dev);
     g_free(regs->special_ops);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
         cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
     }
@@ -1344,9 +1342,7 @@ static void ct3d_reset_hold(Object *obj, ResetType type)
                               ct3d->flitmode);
     cxl_component_register_init_common(reg_state, write_msk,
                                        CXL2_TYPE3_DEVICE, ct3d->hdmdb);
-    if (ct3d->cci.initialized) {
-        cxl_destroy_cci(&ct3d->cci);
-    }
+    cxl_destroy_mailbox_t3(ct3d);
     cxl_device_register_init_t3(ct3d, CXL_T3_MSIX_MBOX);
 
     /*
-- 
MST


