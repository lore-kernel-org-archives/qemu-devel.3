Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB1606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wy7zj3i2;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fWgk1vZm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7FK-0006hS-Vj; Wed, 28 Oct 2026 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ew-0005VC-D9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Eu-0003fD-IU
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Jdo0MNsNItJfj/nlSx1WFYuM61u90pqfihGxAJKP3I=;
 b=Wy7zj3i2n8cACACbqVx3M9GkRG0OI8jo9XPXPaBRrMK/DHQ9xWjFtaR8UqmO+bTFjMKdBW
 qntPW/PKVhlMblPtBTlZQn8XmRuEaWY9uM4YkLTrRuSAhd/MI9pt1edXV+8//5yqPByjqy
 7+zvCSFfhaAYsv+mfB4qQApK8BSHFBc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-9qNcZ03VOLia573k3qpZsw-1; Wed, 28 Oct 2026 13:15:00 -0400
X-MC-Unique: 9qNcZ03VOLia573k3qpZsw-1
X-Mimecast-MFC-AGG-ID: 9qNcZ03VOLia573k3qpZsw_1793207699
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso7343265e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207699; x=1793812499; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Jdo0MNsNItJfj/nlSx1WFYuM61u90pqfihGxAJKP3I=;
 b=fWgk1vZmlU19T7ZpX3zahtDMTNaA13CcDV81VDxtMdvDrfsaqCit5BHJOHJgLS+K0k
 47EeY0g6yWnmM5nwtelSuyYPB6sgYMdKIxhyckfbgCjTnxRJkUM5qaKsGee8msz2BXCA
 vQpTpH11GIYLeDyaoM85S5KP9PYVhplgYT+Q3i+1YWQO/tDtHE3sKGWOmVqorhAcCoZn
 Ux5H1tY/9KfHc/IsjRDk3E1l3OH8lnzo5GB4Z/+2pXbF7S1gIQe9FW1mqzfpny6s7gT+
 KRf0PENip+Z5x5Dl/IdVqIrRSy0P/EX2u0rGKWDPIb2rhxaHUHnn/zKaSOLRtCiqR0dn
 Izcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207699; x=1793812499;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Jdo0MNsNItJfj/nlSx1WFYuM61u90pqfihGxAJKP3I=;
 b=vwnuLYruPEKSZwMgRiZRcUZzdTBPsta0bVk7mP0Q6Ilsk1ds3EbHy7qRdeK4JZiURW
 3+yY9pP9pHsjomVNiDOA10M1Ddz0ZyuWNS51hjbPj+HGsiNtUmUSO3ofk6bZME1dsuYC
 iJPyUFA8D8A9FiT80zDIIpTVrdexpDtPC6p15BrzGW7oh2S4UK9kI9MGWffBf9QIGx6k
 /YkYp9oLWQ+dfhXyFRYNKB/LGmODcvyCcceUCfUlclHkHEBDV/Wgva4pDWHWdgFEkl7r
 arbWelPDtHYW2TIa6gJPQui1Wx7UWJxN1s2cQiBMpkXtAAnyl7+ITlOggvGYtpjS+WUl
 /j8w==
X-Gm-Message-State: AFq9FYL9bRo5TGa1AzkoxRCvAS0gDBORFPn3DMozIWRUEYRlo9oZ3gNC
 8UpaBUd6145W21YRawpDvhlwEzLEbpllU09+b4u4Ek2EBuANcNJpEPNP0F1SBwkqbbF3d5rBJm5
 oSghsfDcCv3dQWwvOIl76gDJi1eY7a2Ms00hkQC3ZZLx1b5rlT9jwkFUl7KYFJLKC0JRfGpQKZt
 naC1eBey+BPVydiaN0A64nKUK59Ifk77y+tQ==
X-Gm-Gg: AYBFou2XuqNj503Tanq0SKzrMBU/t+a6jOG1ni0e2L5zoE44mOnK4YydhNwz+kkvgDP
 AfhZQtuMp+7osqCMVW/Ochevcje/WcCRRcQRoLAjAwS+8ixoe1ePc5v1puw9Craf/+Q2TIK7tge
 3bk23zRMveUuIB6Xuiri3l49anpPg8kTR06rfiZim0MIDvihjSiro6Y0uQOTxX88GbaWctmdoSL
 rC6AzFD6/CotFIfQ07PeJCVDFP0jJnwG7r9BRo18BiDOtNdXN0DVGt8SMnRS6dp23WXuGONFeng
 uzcDIqsuPKkx4CGMvA6a4xVLZ+imFxEVAtefXrP193GVmw2mpZBmycK6XRLDifgqaNKZKZSJghD
 sSSTq063or+KUfCeSUUBpVr0Uyz2zxuRurdmzaFB9
X-Received: by 2002:a05:600c:a30a:b0:4a2:40:8d2c with SMTP id
 5b1f17b1804b1-4a9672f9531mr52838875e9.26.1793207699221; 
 Wed, 28 Oct 2026 10:14:59 -0700 (PDT)
X-Received: by 2002:a05:600c:a30a:b0:4a2:40:8d2c with SMTP id
 5b1f17b1804b1-4a9672f9531mr52838005e9.26.1793207698526; 
 Wed, 28 Oct 2026 10:14:58 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd39a9sm30564750f8f.46.2026.10.28.10.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:57 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 22/78] vhost: add vhost_dev_set_owner() /
 vhost_dev_reset_owner() helpers
Message-ID: <b52ef58c684ae481ee5ccc4166a63f816c0fde77.1793207602.git.mst@redhat.com>
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Wrap the set_owner/reset_owner backend ops in dev-level helpers, matching
other vhost_dev_* wrappers, so device code can take or release ownership
without reaching into vhost_ops directly.  vhost_dev_init() now uses
vhost_dev_set_owner(). Both return -ENOSYS if the backend has no such op.

No functional change.  These are used by the following vhost-vsock patch to
hand a device between owners during CPR.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-13-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost.h | 25 +++++++++++++++++++++++++
 hw/virtio/vhost.c         | 20 +++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index b2b644c0d1..8127a9a5a2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -178,6 +178,31 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
                            VhostBackendType backend_type, Error **errp);
 
+/**
+ * vhost_dev_set_owner() - take ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_SET_OWNER on a device that has already been set up, e.g. to
+ * complete a CPR handoff on the destination, or to take the device back on
+ * the source after a failed CPR.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_set_owner(struct vhost_dev *hdev);
+
+/**
+ * vhost_dev_reset_owner() - release ownership of a vhost device
+ * @hdev: the common vhost_dev structure
+ *
+ * Issue VHOST_RESET_OWNER so that another process can take the device over
+ * with vhost_dev_set_owner(), e.g. on the CPR source once the VM is stopped.
+ *
+ * Return: 0 on success, -ENOSYS if the backend has no such op, negative
+ * errno on failure.
+ */
+int vhost_dev_reset_owner(struct vhost_dev *hdev);
+
 /**
  * vhost_dev_cleanup() - tear down and cleanup vhost interface
  * @hdev: the common vhost_dev structure
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index dfdfd49da3..56fa434588 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1703,6 +1703,24 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
     return 0;
 }
 
+int vhost_dev_set_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_set_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_set_owner(hdev);
+}
+
+int vhost_dev_reset_owner(struct vhost_dev *hdev)
+{
+    assert(hdev->vhost_ops);
+    if (!hdev->vhost_ops->vhost_reset_owner) {
+        return -ENOSYS;
+    }
+    return hdev->vhost_ops->vhost_reset_owner(hdev);
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
@@ -1720,7 +1738,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    r = vhost_dev_set_owner(hdev);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_set_owner failed");
         goto fail;
-- 
MST


