Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0549DC44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkO8E-0000ds-2K; Thu, 16 Jul 2026 11:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkO81-0000cK-Ey
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:36:03 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wkO7y-0000UE-4l
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:36:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f365afc5aso2869850f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784216156; x=1784820956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qGRv1iACF/W7xipo6w+p0h9KaQ9oJwQJl0EIgH4YJ5c=;
 b=tih5tJj0117XUohQaL1xk1NHP9GoRIr4CNqy/P4Q0XsYevvD21unEO16hbBxWoobYL
 VCMUd2ZjB+/08ZKiwWLJCOuVhJ3KoTfWjBw+uAC7tXFuRuTDva5BQyIPDxMWE5lqpdvH
 qPcvfgYIsZbGUnb8II4r14phWW8QsWzUGS3QF5rLFWWg/RYOXlhHsR0yVEvlyy129R2B
 jkFXZR7pGm+wcft0R9Jx3mbkh6ysOoYQn+6imgb/Iqofua7U4kE8adgaopPKusOu/XqT
 8K+4PXiuD27dFG17AGVYDsAqt7+iWC85G88V9R408dTokFCLs1nFq/9M+Emp1pD69s/7
 DNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784216156; x=1784820956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qGRv1iACF/W7xipo6w+p0h9KaQ9oJwQJl0EIgH4YJ5c=;
 b=nfjKnSBkjCaXDCdJ+qldAJ0HuEdMxfeIUcsVtRh0AUuY16q6VKxb9osZe3wAjc/JbU
 khqwgkFDFHrS69STDWz1inDBG2d0fyuqQMdrjFKNBRitGYD2QsybnWhRThh+DDPr3lHb
 bNN/tcWAcixcQjYIt16oj+7hkT4gLKgrMn48b3z9g6oXYDbpCqzYcXZm4p72F5PHBuY9
 4JGf/r0ohF/8UvSw3sdKpPzW2fVgn5RMUv1EwpmIgnHOSrbC1/Cwq+FCemQD6ojzux7b
 tzy1RYmuiNflO5LPOWxKlaKH2z/92WgPtO8FkfS87dD5U/guEEGlahnV8/c0sbeePzTV
 Tnuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RraHUIVJnwRoFxgRNcInmfIaHvEHQIRSFxf26+DNJoZRnhSLz6MzKzes5p9V0ZNFwUKq781CQDsjUml@nongnu.org
X-Gm-Message-State: AOJu0YyyUK4QP1IIrC3egmyWJyVqOedlH52D5xpVZNZF9b1C3JNJpKTc
 UJIWEvsArS6kylFmM14kIvnKwRIZR2xDyw4bleGmQ4Gyx1ZyGNXsaBkyoK6BN3zPCNY=
X-Gm-Gg: AfdE7ckDQfiDxyMxK6esO7PRjnKQgsbAx4GHnYQEsOYdX2a+SfxkTw1F9Dc9azt7Pj6
 wccZ1toZEaw5q2Fi5JLSC2RoYPYGhRBQavcdMjHKllpz98vLK5soaZgR7cbAzVZUp/6yAPSxlvV
 kv3AXr/iKYaVGunj0D+4LFHpFMg7g9TtGC3/pQ8hJ+jcskU4R9NRC4cFZFsY3c4Zq9dz/rQLqHc
 LQcAgrlfuthTimWn084FsMQPA+UNjMGEZ4c8MpqlgCUoLgjEadHl73pWjmhSTzaHKWsTU2iDgqs
 1tYcPii8yS11VOHYyHKG/tMP43Fg+ulOCCcA6KCGMH08+V3dOrGi4PLGt1BZhjWpqzJ5HtNzWpw
 Ouse7h22UljR7Fwd8JSBCvhWWqbC9rIi1wZ24q04Vu9F1rHyNBcz8rPfZwnzuc9KaDEEqVVMknW
 I=
X-Received: by 2002:a05:6000:4914:b0:473:1706:7f01 with SMTP id
 ffacd0b85a97d-47f488bf7bamr13484007f8f.43.1784216155807; 
 Thu, 16 Jul 2026 08:35:55 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4ca9:146f:3485:e2c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f476e9d02sm26443062f8f.19.2026.07.16.08.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 08:35:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/1] qcow2: do not try to clear the dirty bit on a read-only
 node
Date: Thu, 16 Jul 2026 17:35:52 +0200
Message-ID: <20260716153552.3376009-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=den@openvz.org; helo=mail-wr1-x429.google.com
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

qcow2_do_close() -> qcow2_inactivate() clears the dirty bit with a
plain write to bs->file, unconditionally. A read-only node can still
be dirty, inherited from an earlier writable session, and that write
then hits a missing BLK_PERM_WRITE and asserts in
bdrv_co_write_req_prepare() (block/io.c) on an entirely ordinary
close -- closing is expected, the dirty bit on a read-only node
is not.

Skip the clear for read-only nodes, same as read access already does.
Any other still-dirty node keeps the unguarded write: it is expected
to hold write permission, and a missing one there is a bug worth
seeing.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/qcow2.c              |  6 +++++-
 tests/qemu-iotests/039     | 11 +++++++++++
 tests/qemu-iotests/039.out |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2ab6ddd7b0..adb177e6b6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2870,7 +2870,11 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
 
-    if (result == 0) {
+    /*
+     * A read-only node cannot resolve an inherited dirty bit here;
+     * leave it dirty, same as plain read access already does.
+     */
+    if (result == 0 && !bdrv_is_read_only(bs)) {
         qcow2_mark_clean(bs);
     }
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index e43e7026ce..94a8bfe754 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -84,6 +84,17 @@ $QEMU_IO -r -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
 # The dirty bit must be set
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Read-only open must not crash on close =="
+
+# We must not try to write the QCOW2 header to a read-only image.
+$QEMU_IMG info --image-opts \
+    "driver=$IMGFMT,read-only=on,file.driver=file,file.filename=$TEST_IMG,file.read-only=off" \
+    > /dev/null
+
+# The dirty bit must still be set: this open never wrote any guest data
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Repairing the image file must succeed =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index 8fdbcc528a..c66361128f 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -24,6 +24,9 @@ read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 incompatible_features     [0]
 
+== Read-only open must not crash on close ==
+incompatible_features     [0]
+
 == Repairing the image file must succeed ==
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
-- 
2.53.0


