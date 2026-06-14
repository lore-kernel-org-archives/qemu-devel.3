Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72A4CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBb-0003Op-Ew; Sun, 14 Jun 2026 15:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBU-0003Hu-H8
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBS-00022t-QO
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NzyuGiME89aqDLR5LZsqNNgqW2rfSpG7SYs6XXdhRBU=;
 b=M+RFX/McxSHI1oVU4WjXBNVisBnmYVlmL91zinUXFTU6DtDaRdrQSxWQgILjmuYBjD1uce
 4wtk7d3JmqvQiKngQya2PqAa9Ksnag9srgYB6AcJgPKUDw4gAg+WHsxBW+9L8xN8rKI9w+
 KiKoW6nHtmXiOiaivT3gxu9n+Ko3Kak=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-I11cKia-MFOWb6OuYibddA-1; Sun, 14 Jun 2026 15:07:49 -0400
X-MC-Unique: I11cKia-MFOWb6OuYibddA-1
X-Mimecast-MFC-AGG-ID: I11cKia-MFOWb6OuYibddA_1781464068
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efa7755faso1005513f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464068; x=1782068868; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NzyuGiME89aqDLR5LZsqNNgqW2rfSpG7SYs6XXdhRBU=;
 b=t18S1PegH8VVtV3Pd86QpRse95O67Sx1zKt0xxRttWmHMC6Tktiwbs2t9v6J65BBhu
 2N4w7nxOe6ytfeUY0apQyBHEqobxHtGwTfeCYSOa9WQWF8AfrGMPYXPu6IEh+oOU8I+6
 +7v3RlmbuN9A7UPmzpFuxsp+aQEcZFftw/NPFtonVZpyypz8TsofPDdTnsA7NUEKPcQK
 U+6FeDx4PXjtMEO9Qb6WvxKldr16PUG0a/C3f2oAz1oiiaJ5QAe4D8QuLwepGJIC/cfj
 xNMtW2xtQAcNkWFCml6yT6fBE5aglPHIK1Cd29zIunz304pqHIo0E6BrfYzvCCxQ2yUy
 Gi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464068; x=1782068868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzyuGiME89aqDLR5LZsqNNgqW2rfSpG7SYs6XXdhRBU=;
 b=UB3qYlWgAsMk59vkGfMI0Wd8yd2KO82sYZMtXIFR9DV7FRLIPEwF5zwu1R7hp/Ynoi
 XGsi8CoUQMkdzj2SVE9VlqD9KljoPHEnTiU0nVVFskZjBdOBqZ/8NLEBct4BmjAbndqY
 rFaZAocajV3dWChy5DxllvfdEPrliih6JFOTrx5mefjgbdh9W9c48CqQlyDtUc5dKfz3
 XdFQFmVTIRlvI2/6/X2SXQLWs9h+r5/eB1qWJzM3CiYdxaCKOe8h2J+IQb316L6LGOFz
 GTXNcgbZp005NkbeImdRf+Hl7QO8yzOqySMtiR1hOI2BRu8uiyH7zFuqPdiJJfcTmkCh
 WRzw==
X-Gm-Message-State: AOJu0Yys2jl2XDpquwFvctJmACHU01iY7Typz+wMAS2kl2/noJi0RYaf
 kAwlbSjbDqzv0INfgNv1bv3tsdjMkNkmSypa+kTzVHOFIXlDlra6uDaGm3MoYfoJQFW18J8X1RP
 M8bp55/3TLFKrtxsaQ+llUgKPtubpNjq8sKBMmQP8SElsm1jjXXB3naQKLp14fwlpH4TfV3KM3U
 40rgbr/sw+PyrKxB3X3D0E8c/kVVoORyUYzw==
X-Gm-Gg: Acq92OEYR8E3z1FKrS8xWC9liOcYMvAhXA6cgofIlOdPUduUO3z/wuykwlrPQGr38md
 DLErcixcOx05k0dmtaZIUUIldDS4FulMJvZjM8Rsrqbdcvm7q4BxM9LS7e0qiDMraMPJ3mrEXyB
 uI21DWK8+QS99NU7qvXqILC9aI9qpNCG229FRlN1QONNHoWr07tfMMwlEoUG7i3wViBcekKcCS1
 g5tnckOF4OYj8HVj0XWVdV83d+ZGD6FSFZTWTD0DnPp1muSJ294FT7bpOeYWYvMfkEhtoOiuCCY
 bv7UW9t2NcxbKAZWgcNcvdGxxFHsGd4dMnwFjytlyRR45GW35r270Z8e/p5oOblmz0KlyHa+MNW
 qc3p+zSzD4txG3JBkyu2xmGF7dp6l/5jahOGz4Lj6fn8=
X-Received: by 2002:a05:6000:2082:b0:460:3234:77d4 with SMTP id
 ffacd0b85a97d-46074b8effdmr9861242f8f.42.1781464067704; 
 Sun, 14 Jun 2026 12:07:47 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:460:3234:77d4 with SMTP id
 ffacd0b85a97d-46074b8effdmr9861206f8f.42.1781464067174; 
 Sun, 14 Jun 2026 12:07:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f450sm29269901f8f.10.2026.06.14.12.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:46 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 046/106] vhost-user: make trace events more readable
Message-ID: <6fdb2219f46e39df9f4182e53e0f7f3e277e92f1.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-21-vsementsov@yandex-team.ru>
---
 hw/virtio/trace-events |  4 +--
 hw/virtio/vhost-user.c | 63 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 658cc365e7..aa1ffa5e94 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -25,8 +25,8 @@ vhost_user_set_mem_table_withfd(int index, const char *name, uint64_t memory_siz
 vhost_user_postcopy_waker(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
 vhost_user_postcopy_waker_found(uint64_t client_addr) "0x%"PRIx64
 vhost_user_postcopy_waker_nomatch(const char *rb, uint64_t rb_offset) "%s + 0x%"PRIx64
-vhost_user_read(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
-vhost_user_write(uint32_t req, uint32_t flags) "req:%d flags:0x%"PRIx32""
+vhost_user_read(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
+vhost_user_write(uint32_t req, const char *req_name, uint32_t flags) "req:%d (%s) flags:0x%"PRIx32""
 vhost_user_create_notifier(int idx, void *n) "idx:%d n:%p"
 
 # vhost-vdpa.c
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 31eaf65430..4fb136b7b3 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -114,6 +114,63 @@ typedef enum VhostUserBackendRequest {
     VHOST_USER_BACKEND_MAX
 }  VhostUserBackendRequest;
 
+#define VHOST_USER_CASE(name) \
+    case VHOST_USER_##name: \
+        return #name;
+
+static const char *vhost_req_name(VhostUserRequest req)
+{
+    switch (req) {
+    VHOST_USER_CASE(NONE)
+    VHOST_USER_CASE(GET_FEATURES)
+    VHOST_USER_CASE(SET_FEATURES)
+    VHOST_USER_CASE(SET_OWNER)
+    VHOST_USER_CASE(RESET_OWNER)
+    VHOST_USER_CASE(SET_MEM_TABLE)
+    VHOST_USER_CASE(SET_LOG_BASE)
+    VHOST_USER_CASE(SET_LOG_FD)
+    VHOST_USER_CASE(SET_VRING_NUM)
+    VHOST_USER_CASE(SET_VRING_ADDR)
+    VHOST_USER_CASE(SET_VRING_BASE)
+    VHOST_USER_CASE(GET_VRING_BASE)
+    VHOST_USER_CASE(SET_VRING_KICK)
+    VHOST_USER_CASE(SET_VRING_CALL)
+    VHOST_USER_CASE(SET_VRING_ERR)
+    VHOST_USER_CASE(GET_PROTOCOL_FEATURES)
+    VHOST_USER_CASE(SET_PROTOCOL_FEATURES)
+    VHOST_USER_CASE(GET_QUEUE_NUM)
+    VHOST_USER_CASE(SET_VRING_ENABLE)
+    VHOST_USER_CASE(SEND_RARP)
+    VHOST_USER_CASE(NET_SET_MTU)
+    VHOST_USER_CASE(SET_BACKEND_REQ_FD)
+    VHOST_USER_CASE(IOTLB_MSG)
+    VHOST_USER_CASE(SET_VRING_ENDIAN)
+    VHOST_USER_CASE(GET_CONFIG)
+    VHOST_USER_CASE(SET_CONFIG)
+    VHOST_USER_CASE(CREATE_CRYPTO_SESSION)
+    VHOST_USER_CASE(CLOSE_CRYPTO_SESSION)
+    VHOST_USER_CASE(POSTCOPY_ADVISE)
+    VHOST_USER_CASE(POSTCOPY_LISTEN)
+    VHOST_USER_CASE(POSTCOPY_END)
+    VHOST_USER_CASE(GET_INFLIGHT_FD)
+    VHOST_USER_CASE(SET_INFLIGHT_FD)
+    VHOST_USER_CASE(GPU_SET_SOCKET)
+    VHOST_USER_CASE(RESET_DEVICE)
+    VHOST_USER_CASE(GET_MAX_MEM_SLOTS)
+    VHOST_USER_CASE(ADD_MEM_REG)
+    VHOST_USER_CASE(REM_MEM_REG)
+    VHOST_USER_CASE(SET_STATUS)
+    VHOST_USER_CASE(GET_STATUS)
+    VHOST_USER_CASE(GET_SHARED_OBJECT)
+    VHOST_USER_CASE(SET_DEVICE_STATE_FD)
+    VHOST_USER_CASE(CHECK_DEVICE_STATE)
+    default:
+        return "<unknown>";
+    }
+}
+
+#undef VHOST_USER_CASE
+
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
@@ -308,7 +365,8 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
         return -EPROTO;
     }
 
-    trace_vhost_user_read(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_read(msg->hdr.request,
+                          vhost_req_name(msg->hdr.request), msg->hdr.flags);
 
     return 0;
 }
@@ -428,7 +486,8 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
         return ret < 0 ? -saved_errno : -EIO;
     }
 
-    trace_vhost_user_write(msg->hdr.request, msg->hdr.flags);
+    trace_vhost_user_write(msg->hdr.request, vhost_req_name(msg->hdr.request),
+                           msg->hdr.flags);
 
     return 0;
 }
-- 
MST


