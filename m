Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1134AC4450E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkKB3-0002Rb-Co; Thu, 16 Jul 2026 07:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKB0-0002Lh-MV
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkKAy-0005EE-P7
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 07:22:50 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-495437bb891so2606515e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784200967; x=1784805767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R1x24EIH9Zws+U6zhZ4YK6KCdLCmyavM2XPJ+59zwwk=;
 b=ZJtq0Ub+9v021oWQQBI7hJDc9AzQlZ3Af6Q8eEQ5BCbS9DA0zCSIannX54ZzrPF/2X
 lzy+hp1u2JZWgPe1k5koz4HegzAWuW/G7hRzvvi5CkM1Wvd//eiW12C4NpiEyuH+wXkB
 pSg96pGahqx7V+G9XOBmd+3h8vmsz1eJc99aSx1+f28sArPcQtyq1aok1YSneiQwF0+l
 PmnGKNhw0vDB27QrEC97KjWuxSUBprAt3vbpbM123U6D8fzIYwn2EXO3dh6vAdgX1N/O
 6Zh9oMAeZdv6RYO1N1Uy5IVCeuzbyHcGZ9d0YR//9RBAqZNUlML4SKNafnhMFEbsMeiY
 WuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784200967; x=1784805767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R1x24EIH9Zws+U6zhZ4YK6KCdLCmyavM2XPJ+59zwwk=;
 b=Bgt54JpJ8W1gu92dnV6z2Qqt0j2FvcG685FL5KXu5Irlm08/RYvB0DPWUEo1c6DVqE
 +bjhrqdgjn+5LURPbPe/SHni+tcYfnxtZTg3lr0G3eijrG0iRhGjqfsOBlt8vRMEfYOf
 up8iu/tDXmk5msMEfi6lYh/8epJaWixCIQxHJboR3ZM+OPy8AgqlCoTcPg6ZEXewnpFS
 5yEg+o9WkCPplLfYM0dSqlUixE60MgkBbWFUHncVGT/rUCF+x79GRctUMsB7S5hs+87S
 /WgNZ31nZBKIiXZe6GcI3ZG3Upp/DGE7rQu9ZkiZihCshfTI/nIfqqebO7PV7SwbpE0e
 O3Cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAitWvdvxlf9vaV8foWZaBqF3631AdsvPR6vhOZEBV3ZIkbjIczYu1Z0yK2Je7pw387Sc4/b99STIq@nongnu.org
X-Gm-Message-State: AOJu0Yzb443QtGTRo9IzGXkRodXAvms1/UfZq85UV61U2J2D0MHBjLFl
 TnBsLfggXaJ1WgkkRdstIKCU1/E3cFnGo4d2eRsy5WV7vPJ2UVFCwtru/gh/dOgDqao=
X-Gm-Gg: AfdE7cmwR3B9XMsFTFTGsY1kg2ri8dvBRGBoGzn802toxD3PNCaM0HOhzmPBQadVDdZ
 pZSwnSboLwjzcR/7BKVoTeuBHvohBqChdu8xIw+uxA3TBu6Aos1tXH1qYCe7vy6Cr2Q2eyllb1C
 2nPZbMqLwUEMJIt/itLWrd4avSIh4qYx2ZOkpson0MwQO/s7o9MNSAtILFH0Lrn59FCgg/pPvDK
 Ef1GCWX5s4eYieSGXKTvEHUwv/RjHI9e5NLuJyEd2TEQzax62f1otwKTDnJqjPTtL5vETQnygwd
 CepoBKwX1eOqHshQRhVJMJSLtnXmDwMqC0V+Hk8+fIO0df6xk97aiQnVSyrZzCAFAoLLPwZkso5
 XlTjR2qbQKoERKlCVG9amvV1M+XyCx+iqhZph67O4pamW9iouc2SCV1w70BUDYcmOU+DeNoQU0O
 U=
X-Received: by 2002:a05:600c:3552:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-4954286a3b4mr22010785e9.1.1784200967328; 
 Thu, 16 Jul 2026 04:22:47 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4ca9:146f:3485:e2c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a96fdsm24019672f8f.24.2026.07.16.04.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 04:22:46 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 2/3] migration/block-dirty-bitmap: reject bitmap load onto
 ro node
Date: Thu, 16 Jul 2026 13:22:41 +0200
Message-ID: <20260716112242.3000035-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716112242.3000035-1-den@openvz.org>
References: <20260716112242.3000035-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=den@openvz.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

dirty_bitmap_load_start() creates an incoming migrated bitmap with
bdrv_create_dirty_bitmap() and, if the source marked it persistent,
calls bdrv_dirty_bitmap_set_persistence() without checking whether
the destination node can be written to. Same gap as
qmp_block_dirty_bitmap_add(), reached via incoming migration: a
persistent bitmap for a read-only destination (e.g. a migrated
CD-ROM-class attachment with dirty-bitmaps migration enabled) ends
up writable in memory on a node that can never store it.

Reject it the same way, with one difference from the QMP path:
every destination node is BDRV_O_INACTIVE until migration completes,
so bdrv_is_writable() would reject every incoming persistent
bitmap, not just read-only ones. Check bdrv_is_read_only() alone.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/block-dirty-bitmap.c                | 22 +++++++++----
 tests/qemu-iotests/tests/migrate-bitmaps-test | 33 +++++++++++++++++++
 .../tests/migrate-bitmaps-test.out            |  4 +--
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index cba54e25cd..1b8f39c12b 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -812,13 +812,6 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
         error_report("Bitmap with the same name ('%s') already exists on "
                      "destination", bdrv_dirty_bitmap_name(s->bitmap));
         return -EINVAL;
-    } else {
-        s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
-                                             s->bitmap_name, &local_err);
-        if (!s->bitmap) {
-            error_report_err(local_err);
-            return -EINVAL;
-        }
     }
 
     if (flags & DIRTY_BITMAP_MIG_START_FLAG_RESERVED_MASK) {
@@ -835,6 +828,21 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
         persistent = flags & DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
     }
 
+    /* Not bdrv_is_writable(): nodes stay inactive until migration ends. */
+    if (persistent && bdrv_is_read_only(s->bs)) {
+        error_report("Cannot make migrated bitmap '%s' persistent "
+                     "on read-only node '%s'", s->bitmap_name,
+                     bdrv_get_node_name(s->bs));
+        return -EINVAL;
+    }
+
+    s->bitmap = bdrv_create_dirty_bitmap(s->bs, granularity,
+                                         s->bitmap_name, &local_err);
+    if (!s->bitmap) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
     if (persistent) {
         bdrv_dirty_bitmap_set_persistence(s->bitmap, true);
     }
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index 8fb4099201..cb9154ca8d 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -206,6 +206,39 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.vm_b.launch()
             self.check_bitmap(self.vm_b, sha256 if persistent else False)
 
+    def test_migration_to_readonly_destination(self):
+        granularity = 512
+        mig_caps = [{'capability': 'events', 'state': True},
+                   {'capability': 'dirty-bitmaps', 'state': True}]
+
+        self.vm_b.add_incoming("defer")
+        self.vm_b.add_drive(disk_b, 'read-only=on')
+
+        self.add_bitmap(self.vm_a, granularity, True)
+        self.vm_a.hmp_qemu_io('drive0', 'write 0 4096')
+
+        self.vm_a.cmd('migrate-set-capabilities', capabilities=mig_caps)
+        self.vm_a.cmd('migrate', uri=mig_cmd)
+        while True:
+            event = self.vm_a.event_wait('MIGRATION')
+            if event['data']['status'] == 'completed':
+                break
+        self.vm_a.shutdown()
+
+        self.vm_b.launch()
+        self.vm_b.cmd('migrate-set-capabilities', capabilities=mig_caps)
+        self.vm_b.cmd('migrate-incoming', uri=incoming_cmd)
+        while True:
+            event = self.vm_b.event_wait('MIGRATION')
+            if event['data']['status'] in ('completed', 'failed'):
+                break
+
+        self.assert_qmp(event, 'data/status', 'failed')
+
+        # A failed incoming load makes the destination process exit on
+        # its own; reap it so tearDown()'s shutdown() is a clean no-op.
+        self.vm_b.wait()
+
 
 def inject_test_case(klass, suffix, method, *args, **kwargs):
     mc = operator.methodcaller(method, *args, **kwargs)
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
index cafb8161f7..73e375a9d7 100644
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test.out
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
@@ -1,5 +1,5 @@
-.....................................
+......................................
 ----------------------------------------------------------------------
-Ran 37 tests
+Ran 38 tests
 
 OK
-- 
2.53.0


