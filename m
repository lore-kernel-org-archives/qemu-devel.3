Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9C606A32A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dbehamj0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=f30LbTrC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7F6-00060f-KO; Wed, 28 Oct 2026 13:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7Ea-00054e-WD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7EX-0003Uh-Og
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OSUT2xSumvpPMiOOBEsvAcJhkOMnkF1J1FA5y4DMEM=;
 b=dbehamj0izw9rdPHNoTDDtx9a4l/fm+mxOKPaZXgzX80A0CGZUrfJ4H29E2WGJ3fPBZ6Im
 qOiypDvg2RWjX+/8N2nAN3CyDZb3tQ3LIq8Rtv6phNm9jCsEJI1V2JlVY4eEBMJlqUCRGI
 /GtA1AqUBnizCBsrkd02FnL1DSow4xA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-KL80lNBGPsiOGUKQsxrstg-1; Wed, 28 Oct 2026 13:14:39 -0400
X-MC-Unique: KL80lNBGPsiOGUKQsxrstg-1
X-Mimecast-MFC-AGG-ID: KL80lNBGPsiOGUKQsxrstg_1793207678
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e1d839ddaso797522f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207678; x=1793812478; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3OSUT2xSumvpPMiOOBEsvAcJhkOMnkF1J1FA5y4DMEM=;
 b=f30LbTrCuBhTr1cEKwEFwZUZgYF+CbpLbggsGXZGtzC1EyN3qPLcrJcznO1F9Vf4nh
 Ysdn51PREmxkWbc8zeY3kvFodrXr7dAswfc1n3d0MNalpkN7di4GTN5xW+Syh4TMmTSe
 InqQQxrIA0GIuwCIt3DGxWwNzPc4mcafzI3qY+39pfQMX2XV+k4KgMTNatTvDE4CL55N
 qf6gkPGCQGfuHXch1fPfrbtk1YOsGNnLFVM1NdPf4mrKIP1+2FjxZFW+HLj6gl3BZkcS
 S9BA3ScJ+v0/5QDY9z8Ukq9/oo2a9URpSSmj+T2PfWK36HIOXmhP6VYr+/MknPrcNh8N
 K9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207678; x=1793812478;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3OSUT2xSumvpPMiOOBEsvAcJhkOMnkF1J1FA5y4DMEM=;
 b=pd+ZN9d2w/FOgDMC4ZeA+WUTGrGBiX08vXch/GHQhJBlTmWoBUsj29G7x1WKPGna3N
 dHRLyMUB02+/hkGeGljo/LQp5AqE0HURpWIfJg+M1FIY2nkAxoPDxFB6qmQUP+UXOIVZ
 tuSmVX4m4OvdwZiFzWdFT4SyJIbebXQxdWk7pZwRyqAXshHrWRRFfgJaOs72Z5sqdJr1
 huh/EuWtU8QKy4rlycZNO2KVnzqX4vEb97vpwCC/H6QGPnZTzV2MLtk0JnrXKxtCepAK
 wOWCSFiLQFO/wEdToN7f06BNZH79g4I5TMxao8cNw3OtU/WKHh312Ohxa196cDZ7geC8
 13uA==
X-Gm-Message-State: AFq9FYKR4WrrhY0GunhByEMTH80yT63q8IYRTh1UwrUcr0TzgQyAeIhb
 i28Wn22mAPqUAv6aNnUujReLVtmi7Zt2gdSePltwe+W8YcktMLKqz61rWZpxNQcgW5aMwVLb+jo
 BWVlFH79prYr0APmOeEnZyyjtu2c1qdwLm3wW27FICzhHmq00puV9QFcsLMTn28Lj5aMuaTHmlE
 RNBpzM/G5B4y9eR6ajeI5d/z8KUFFupF189A==
X-Gm-Gg: AYBFou3vKpdC5nAEZObMMvY64Al01VBuDTyD5POf6TUzreMgCv10ouS0YaTb37FCZHw
 petuIU+gauyzf6Y6kBeEthq1aESIqkY3zbjCO5tAhOpZ4K5Gfi57N8f/XmWRM1/EWx1mCXpGWI6
 EiUN6F61M3K6mUsFuhd30d7OIDwQd1oKBXBVCMIBa17eGKj14SDoMKTCossBnOlngawVHgaFQN9
 6ndgkmD7eovw1AqbQ+RHlJaJFd2yPxyI6RbSOQVc45wVUxjaiFmA2ak8O9Ovb9kOFzpLjXxDj0n
 RKHaDqXs2+uLWLQi2azYPlan6I7zWn1ooC6ygvNwrhon3R+hnCzscqC5bETyzCup7psJZScMzL1
 5hlEbGBCEE+x7bS760QITah+wkyoswUYjyo56wLdH
X-Received: by 2002:a05:6000:2dc3:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-48e5d5979b3mr7303191f8f.28.1793207678237; 
 Wed, 28 Oct 2026 10:14:38 -0700 (PDT)
X-Received: by 2002:a05:6000:2dc3:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-48e5d5979b3mr7303088f8f.28.1793207677471; 
 Wed, 28 Oct 2026 10:14:37 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8d5sm31063061f8f.28.2026.10.28.10.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:14:36 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Mark Kanda <mark.kanda@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 16/78] vhost: add vhost_reset_owner op
Message-ID: <fbba41b890d7c65b82fe611cf26ac6631a464703.1793207602.git.mst@redhat.com>
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

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-7-36c38bd15ffc@virtuozzo.com>
---
 include/hw/virtio/vhost-backend.h | 2 ++
 hw/virtio/vhost-kernel.c          | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aa..fb580aa417 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f..55d316b88e 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
-- 
MST


