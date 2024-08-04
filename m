Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4EDC3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 14:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sac9Y-00080K-Ja; Sun, 04 Aug 2024 10:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sac9X-0007zh-DH
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 10:24:07 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luzhixing12345@gmail.com>)
 id 1sac9V-0005u0-NM
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 10:24:07 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso8364881b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722781444; x=1723386244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x2R9ne5DfdGUUGMxzmrdwOWCGaoNP/K5T/DLLYSkhZU=;
 b=hX74vD44EraAZWGmMdLzZOVC5eWvbYGIIg1zFT6kC+qD2Iyc5hGKVHfejwY3PgrBj+
 dt33Xu+76hoVf6kD7koZvNM3UBC3bZnGlHgJ+/L68RN4vGedUMPQlPkHltFUShtdLGi8
 1St7+fj4OGlmHsjLewPiFtDT56IRdAE7WOcZ/b34qDXDxUsa6MftqNbHk6H9B5Di1x2o
 gMxYFo/sJNuL+E+Uo1wt/7z4YDpnNeV8+EoKBvlBvcE7Zv7U418ghJCJ65F+FceZ7pXY
 tLwWoZb3Luf8wCJIffSPJTlqhbNiXwngCv5ZjW32fc7NQrJuxdXDvrVzx26IBrp6onma
 rf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722781444; x=1723386244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2R9ne5DfdGUUGMxzmrdwOWCGaoNP/K5T/DLLYSkhZU=;
 b=MyI3Ug+VxzdnZ2XXgiTwrN2987ELhgMPUe/U5sJ68jCgRDn8dWhwdYZ3X7R79PkJyT
 pH9dj/Qtmsu8cFvD75Y8HbTDScFsTQEF5U3/P51qnhItgE2twRRaDNERxmrLQyb9vHRf
 eRcI0fdg6ZJeAI9L1Wk3wf8n78G78aBFkhOlsYWyPm/rJDI5jnzR9f6TfUFUudp5vH8B
 5Qm54xiNEdmwgkTDFadb1BIsF4ASSIkKukAjpwVAi9kG/PC7sNa2eekwoFst4rm6Li44
 9vd8fhpE1eQi3/y9sspXBMzbfXZipHh2psQgOsHle2l5+rY2grJwjJ7AYmBN9ZY71zCM
 svNg==
X-Gm-Message-State: AOJu0YxrRLbYE+rfa9I+33Ve4VF/z3O0UeI0jOE1R1/e0TANbs66dKeT
 jBvs1EMJPPpUiH2RjUSow5KAryBhpP4bCpf8+wiOFSJgyNg3kn7bgWFER8AOGUs=
X-Google-Smtp-Source: AGHT+IHf2J8IEv8Mj9SEMAqIzErwANFBT57m75d8/84378qbF/Bt2dRsoVqcDaUUJXsMUEYAsOuefA==
X-Received: by 2002:a17:903:1251:b0:1fb:98db:ad5f with SMTP id
 d9443c01a7336-1ff5722de68mr124981395ad.5.1722781443935; 
 Sun, 04 Aug 2024 07:24:03 -0700 (PDT)
Received: from localhost.localdomain ([223.104.134.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b5886sm49567305ad.299.2024.08.04.07.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 07:24:03 -0700 (PDT)
From: luzhixing12345 <luzhixing12345@gmail.com>
To: qemu-devel@nongnu.org
Cc: luzhixing12345 <luzhixing12345@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] vhost-user: rewrite vu_dispatch with if-else
Date: Sun,  4 Aug 2024 22:23:53 +0800
Message-Id: <20240804142353.25342-1-luzhixing12345@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luzhixing12345@gmail.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

rewrite with if-else instead of goto

and I have a question, in two incorrent cases

- need reply but no reply_requested
- no need reply but has reply_requested

should we call vu_panic or print warning message?

---
 subprojects/libvhost-user/libvhost-user.c | 39 +++++++++++++----------
 subprojects/libvhost-user/libvhost-user.h |  6 ++--
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 9c630c2170..187e25f9bb 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -2158,32 +2158,39 @@ vu_dispatch(VuDev *dev)
 {
     VhostUserMsg vmsg = { 0, };
     int reply_requested;
-    bool need_reply, success = false;
+    bool need_reply, success = true;
 
     if (!dev->read_msg(dev, dev->sock, &vmsg)) {
-        goto end;
+        success = false;
+        free(vmsg.data);
+        return success;
     }
 
     need_reply = vmsg.flags & VHOST_USER_NEED_REPLY_MASK;
 
     reply_requested = vu_process_message(dev, &vmsg);
-    if (!reply_requested && need_reply) {
-        vmsg_set_reply_u64(&vmsg, 0);
-        reply_requested = 1;
-    }
-
-    if (!reply_requested) {
-        success = true;
-        goto end;
-    }
 
-    if (!vu_send_reply(dev, dev->sock, &vmsg)) {
-        goto end;
+    if (need_reply) {
+        if (reply_requested) {
+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
+                success = false;
+            }
+        } else {
+            // need reply but no reply requested, return 0(u64)
+            vmsg_set_reply_u64(&vmsg, 0);
+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
+                success = false;
+            }
+        }
+    } else {
+        // no need reply but reply requested, send a reply
+        if (reply_requested) {
+            if (!vu_send_reply(dev, dev->sock, &vmsg)) {
+                success = false;
+            }
+        }
     }
 
-    success = true;
-
-end:
     free(vmsg.data);
     return success;
 }
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index deb40e77b3..2daf8578f6 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -238,6 +238,8 @@ typedef struct VuDev VuDev;
 
 typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
 typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
+typedef uint64_t (*vu_get_protocol_features_cb) (VuDev *dev);
+typedef void (*vu_set_protocol_features_cb) (VuDev *dev, uint64_t features);
 typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
                                   int *do_reply);
 typedef bool (*vu_read_msg_cb) (VuDev *dev, int sock, VhostUserMsg *vmsg);
@@ -256,9 +258,9 @@ typedef struct VuDevIface {
     vu_set_features_cb set_features;
     /* get the protocol feature bitmask from the underlying vhost
      * implementation */
-    vu_get_features_cb get_protocol_features;
+    vu_get_protocol_features_cb get_protocol_features;
     /* enable protocol features in the underlying vhost implementation. */
-    vu_set_features_cb set_protocol_features;
+    vu_set_protocol_features_cb set_protocol_features;
     /* process_msg is called for each vhost-user message received */
     /* skip libvhost-user processing if return value != 0 */
     vu_process_msg_cb process_msg;
-- 
2.34.1


