Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713E3C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Szx-00060I-Hu; Mon, 07 Sep 2026 02:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szv-0005zR-Gx
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szu-0006AC-3C
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d715f4a587so45944335ad.2
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763109; x=1789367909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8RfjQjVOX1tJDdARKFAxVYWhrl5wDLHiadJICm/sXU=;
 b=WUtReERJa/M0MP4mkeq0uJti6Dmr67bF1XkcZ5XUCRnDopEsSGD5Iru8hQmAxeNt9v
 PnNBcdoLKRiN8P2z/LVunz49sK7WZTR1/MHlhG/svXaj7KYWctS2R17kAfCha9CInrMp
 5jdLL082XnizM3b8fOzwr7C8mQdlAgiX4Ly7w/e8T/MvCgbk/WAWclEx2/0yGYjt9Q9v
 ePpZaGZaQkb0iuOYOZS61PVJ/w256b1rWrjCU3jxziocuXUX8KfmPtptLCxoVOQ4rrUq
 9k5knH/hGDq8uXa+EtiAB7ARfPWscwRiwSQJQvv8x3xuQ9rrBnAril0iTP5l5EE70752
 6eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763109; x=1789367909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8RfjQjVOX1tJDdARKFAxVYWhrl5wDLHiadJICm/sXU=;
 b=SJdelPbHs/YZgeNdIaa7OqUGQm7EWwCc6V3BWXfpqesekUrYR1NoPZPRXWG2LMmIdA
 18i7pqmC/KhLSYgpMlrrYJBO2fRLqn3LA0BLgL21e/pgBc2SXGuNNCSdmSm5aWrlScTF
 qpcJTozsV2UdZnKy/+0QfUMsGrJvwEvy2j3F7/296+yOmXjdfovOF6kwFdqVTwpVSAg7
 SHhGLfL4eLVTXdnUoVs7ay1jshwVFJKO7HIDSL01+eMUGLRHsCRJQyvc6ipgrEDxSgNx
 iw4mJV2A46MdUvB6o8idd0k9glLiCfI8xKjy15rdPZkuG0BcLkX38v8CDz7Os0b5VmCN
 B0Pw==
X-Gm-Message-State: AFuF++niZO4ncWki7HskcaWpGhcLGXFxeUTqrYX1sYyFNojHwmxvdmrC
 uk1zdhzHV1l5zTx7axjzSZQF0AUkFVvbWM5yJkW4L4rsba4n9b0n38rTmyK2WYw82Vx2Eg==
X-Gm-Gg: AYBFou1JS4fx0yEKLXv/UHOzGkFVqBMDMc2OtWSepD1gcd8N/i54C0U7hqAlnGREJWY
 p66aJa84Vt4vxhmfa3hT/hM39UyecZbqVYNGmvoXNgP19R+hV/ZzaVcsF6aneM7l2zzs+qm566t
 136tLEkniVapsI03GwvOocOJAD3MqHqSPN9mLzWLLhqDLHOv0k1W5oF2xSu9LuWpzkDID7NMNlX
 Bnq5wDugWX0ejCjsaRWXL60nKxz+g+b+0yRKtGrw2WzLEENTHjoQyuBB4fC3xo6Vyoo+nIJtFLs
 972gWJY8qhm5PAL5vjYEAcQig/M5FQMTAW5cZ3LJ9+a0GGOOTRmEcHrX27/pms2jYLHflpq/nr+
 baAIujO6pgcn9SUHfPojCPnesf1AgwgDYQZHhK0CKGij6JdrFQ2DgbyBBdPBKjQvyJ7XdHM+N6T
 itaa6lfd7DmJEQnNe7L2cAEXX4lN9owCln6TbVMS+PbrDYd6vhuhtkdp5G79IUx2xPOZWOSOAgt
 rOt7Wqyoyin4uBD
X-Received: by 2002:a17:903:198e:b0:2d9:383a:30f1 with SMTP id
 d9443c01a7336-2db125ce07cmr357668705ad.4.1788763108763; 
 Sun, 06 Sep 2026 23:38:28 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:27 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 11/14] xen-block: Update tracking iothread users with
 holder name
Date: Mon,  7 Sep 2026 14:37:22 +0800
Message-ID: <20260907063725.626685-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace raw object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..9dfe06e1be 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.43.0


