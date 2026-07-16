Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1AFC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNKE-0000NU-KB; Thu, 16 Jul 2026 10:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNIH-0006V0-6A
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNI8-0007bx-U8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2caf228a910so52217825ad.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212943; x=1784817743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=K9MeHOQ3kfrt1YCJ7B9SAvk98HRbesL0E0fehZienqaM068g33pH+F6ordCaWdSydl
 PXJK7bL/L2qKnUml3Xj7ESjvElfiwlP8cgF8hjJlm6EE1q4b7dM2eemmDvMcn2fHtbrA
 3QFmkYAz5DFZYIZ3tROtrFbFNiPg08kkqo/sgAOuZTrlvyJBXAbq2uRwJWdj3cH1XsmZ
 wrh/4xK2EBp/Rnufk6KDYg/tJCzVxM9lnSo8BPKVIfOdD9XlBN4tT5X+PyEq2JJ3TLo8
 1P9tLxNt1+KGc7S7/0g/dykb2z0XM3SZQEG8sa1nVFWtkM3lKybpFT4ze+Jw03aUkUps
 GEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212943; x=1784817743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=YKtDC5VhGO3mt2xtM9uA+W7afhQy1uJCBWUiLIagduX97qOio/lF0/K0GIVyfmTwxn
 qo5EvbpqYfx0I3HnUogu3+3qrRq7ELXx84djCy7PVUZTRPccrW0ij8FiVrotW/f6TJ08
 cu68BTOeCU/2FqGls0fQVnHoBesHMfvssAEaJVnjOd9TssU0cNM0TyVQeTIxjlUUARTk
 KeNHA3Y7U0UQYLeDnSpIidmdrzAnQrtP+VxLfe3480FyblCJrxUpD27b19FoqpcU6QVd
 ToqcWUkeDdHeuNslyZF6o0K4u80RK4k9I2dAuOEc7TYOakfSsIVLXDnIZR7MdiZtCpPn
 AVzw==
X-Gm-Message-State: AOJu0YyrGO8GcgATv0ignr3FZYx8fYEbCIQOQa3VhlSA75fJFSk8kBcP
 W6C0e3i2GR10lQv8Asq9nArxMe2ClVlIzIbkyUVYaFG0LU3F3tDz6b1J0Fac1xYws/M=
X-Gm-Gg: AfdE7ckw49HLCCzqpRFH3RugJK5aVPmpUQE4gfjcahnNzG+Pl/W0WDGsF/Gk3lREpk6
 +lzcXX+eUYOcownczUtEPvTaHlLih57FIww+rwlcVV4GbJLzl0qxcj8myzMFa7JDWl3NbTZDwjo
 phW6PgZxPqN/Ii2lc4XiR8EnL0JKUqZROp62FjsuGickVI5Sy4727EqF9DjRpY4i/41HN1wLmf9
 S7I4VBL6JHKvFrYv0bD9Oh6zbLjfP1PgBnvdbBXQc69CSUhYeEGJHLAvcceFkM8gbNu3lfXPbQN
 euyjlmlSmuEh7BkiLauuK98tSxYtFcBMVA8Yrkc3WoFz3CYoOu3nsO/GI5NhlTeeYWml0K2EPh5
 eaRgrMLzf1SCXK3NRuRDQP0ohDPtKFPVsS9VcsJqgllgJo4u/TlA+VscB5Zkbnpwu3BMYfbAUjl
 ufz43MsvFnGQTjTmSRBYXD1nwbakASrUmlVdlUkwgn
X-Received: by 2002:a17:902:e883:b0:2ca:e565:7b15 with SMTP id
 d9443c01a7336-2cf03bd5282mr75551645ad.10.1784212943238; 
 Thu, 16 Jul 2026 07:42:23 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.42.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:42:22 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V10 12/15] xen-block: Update tracking iothread users with
 holder name
Date: Thu, 16 Jul 2026 22:40:37 +0800
Message-ID: <20260716144043.76414-13-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..b5bf8d359f 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
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
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
+        iothread_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.49.0


