Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1388C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 15:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtocj-0007zN-Sf; Tue, 11 Aug 2026 11:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtoci-0007y8-63
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:40 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtocR-0004EW-TN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 11:42:39 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so5117105a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786462942; x=1787067742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T8YkIbuYP6oHQdOgTR0NrIthQ4doKOz3zlklOIKET+U=;
 b=PAC3beZ638BYg+suie0a8S5qqApJGG6fWxc5OQMHIaAkkQWZlQW/QZiwqmWfPk7YZ9
 5uuFiakv2k1an+5AE+s+NdQGWnUYTxvplMZxntkJWVXcaRpXjssW1+7fWVa8ruk4tZMv
 JMigQ0G1WeB/wsTD51cbcvqQmmtlMBaMtEcPw3KwCSzvK5xed0kf1rPCF9wyDwQEG/xT
 dCgKAobCl3kYn+vs+xUxFkvaoKdJ3yc8hbC3hK968/RDkFf2GQupD76qJuScRhhb1cJp
 pC7yoCQnfDBR0OUr61c8eP7IVL6REXyeOYfS+q/M1jQw+XGx3a01W1vOOecAsYv19gCm
 6m+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786462942; x=1787067742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=T8YkIbuYP6oHQdOgTR0NrIthQ4doKOz3zlklOIKET+U=;
 b=Uru0EyBuBEc/RTunk/fs4L8L59JX+95SRIwrhMKrr+prEYrPaOmQgt12sGR/heeWLY
 FlXAYXwSQ1xXfvLtoznUw5qtbsAtECa7NMKMnQW2A3303DH4K7zlvevLDpRjhn9ffz4w
 ycneOZGidMC6hr18sIfKtVIVdAxazDUmxfPqCS5pF9Pm8P9z2kwMA6XfMJpX9YkzSRNs
 9HxGO0Tr1F2UAah2ONztIz7b0o4Hx12ByPUgXUBYuSxYgE3RXKH6aHPT2WtmOoedg9kO
 YofXwXInBW2UuhkjWHRoqh2OAkZnQsLYW9NenF0AKgYZ1lBWfun/xp1cEgTaZgaS8L6h
 l+4w==
X-Gm-Message-State: AOJu0YwRKo0vJ4AMq8tK1JExSezPhDuiKMWdAcP+rQ6doTNyUf9gETsp
 h8lCCyB9yPcBaKBdUdRxlcDIBff6q5qDjd/7va0PqLFbgHipWQDJLIVddcxKA376EZOhpdbXguE
 KncmC
X-Gm-Gg: AR+sD12uobKzcsWJBY1vLhIo77qAMr6Fh5oCQdareJKOYOP18yK3BfVm8Qx18cD6nqP
 NHC56dIljEBULbLouIrqrmIRTk1ADzRWdKyXu+UTMzahXIeYXa/bskfaYSeAsZ8vOotK1egPV/j
 LXEj+40ksu4rEBNCs5ahiguR2moRsozK2LnxUM5Am18BlW3htqpS6YZoT7Q+kIMDc096e/2Aas1
 0N2PkuiL5qxOaesDkui58efkIb3Z2L/nB6YSZsAHNz56GdBzXCmRondl8j8UCLOC2NMbv1Rc5Ua
 S6s+1wEMLfvMuzzGpzn/xexBw7/qolVXaZmgAQwbcPpwEmn0lQEaS+BglGPz2SQr45HD0FowG1p
 UliP5S5zQC2Z/GONRkQUe/f3zJIHEwfOzAb/JKzf9aQ0T7WKZ+TOgYSVNG/pX2BTyajzRdbh1wE
 9u0IcvTjWxW17RgZMUSwE6JZCEG3i2PUUOHZi0nGsiSO4IQ33JMBNk5w8z
X-Received: by 2002:a05:6402:4544:b0:698:4992:77e7 with SMTP id
 4fb4d7f45d1cf-6a36449d25amr2161717a12.7.1786462942412; 
 Tue, 11 Aug 2026 08:42:22 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362e34d4bsm841128a12.12.2026.08.11.08.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 08:42:21 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 4/4] qcow2: repair a dirty image when it becomes writable
Date: Tue, 11 Aug 2026 17:42:13 +0200
Message-ID: <20260811154213.184947-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811154213.184947-1-den@openvz.org>
References: <20260811154213.184947-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=den@openvz.org; helo=mail-ed1-x52b.google.com
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

A dirty image must be repaired before anything allocates a cluster in
it. qcow2_do_open() does that, but only for a node that is writable
from the start. A node opened read-only skips it, and nothing revisits
the question once that node becomes writable, which block-commit does
routinely: commit_active_start() and commit_start() reopen the base
read-write for the duration of the job.

With lazy refcounts the on-disk refcount block then still accounts for
the metadata clusters only, so the allocator restarts at the front of
the image and hands out clusters that L2 entries point at. Two guest
offsets end up sharing one host cluster. Nothing fails, the corrupt bit
stays clear, and a clean close clears the dirty bit, so no later open
repairs the image either.

Do the repair in qcow2_reopen_commit_post(). bdrv_reopen_prepare() runs
before bdrv_list_refresh_perms(), so it holds no BLK_PERM_WRITE and,
with auto-read-only, bs->file may still have an O_RDONLY descriptor.
commit_post cannot reject the reopen, so signal corruption if the
repair fails rather than let writes alias live clusters. That drops
bs->drv, so return the error and skip the bitmaps. An inactive node is
skipped: bdrv_activate() calls qcow2_do_open() again through
qcow2_co_invalidate_cache().

With lazy refcounts the dirty bit stays set for the whole writable
session, so a node that is merely writable says nothing. Repair only
when it has just become writable, which BDRVReopenState remembers:
a read-write to read-write reopen must not scan a live image.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block/qcow2.c              | 17 +++++++++++
 tests/qemu-iotests/039     | 60 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out | 36 +++++++++++++++++++++++
 3 files changed, 113 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 553a94d003..bac3e49cf5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2147,8 +2147,25 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 
 static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
 {
+    BDRVQcow2State *s = state->bs->opaque;
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    if (!state->was_writable && bdrv_is_writable(state->bs) &&
+        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
+        BdrvCheckResult result = {0};
+        int ret;
+
+        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
+        if (ret < 0 || result.check_errors) {
+            /* This clears bs->drv, there is nothing left to reopen */
+            qcow2_signal_corruption(state->bs, true, -1, -1,
+                                    "Could not repair dirty image");
+            error_setg(errp, "Could not repair dirty image");
+            return -EIO;
+        }
+    }
+
     if (state->flags & BDRV_O_RDWR) {
         Error *local_err = NULL;
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index db52c580d1..dd4f48fa14 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -136,6 +136,66 @@ $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
 # The dirty bit must not be set
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Reopening a dirty image read/write should repair it =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must be set
+_qcow2_dump_header | grep incompatible_features
+
+# Without the repair this write would alias the cluster at offset 0
+$QEMU_IO -r -c "reopen -w" \
+            -c "write -P 0xb1 1M 512" \
+            -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
+
+# The dirty bit must not be set
+_qcow2_dump_header | grep incompatible_features
+_check_test_img
+
+echo
+echo "== A read/write reopen must not check the image =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "reopen -o l2-cache-size=1M" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must still be set, it belongs to the running session
+_qcow2_dump_header | grep incompatible_features
+
+echo
+echo "== A failed repair must fail the reopen =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "none"
+iotype = "write"
+errno = "5"
+EOF
+
+# The repair cannot write, so the reopen itself must report the failure
+$QEMU_IO -r -c "reopen -w" -c "read -P 0x5a 0 512" \
+    "blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG" 2>&1 \
+    | _filter_testdir | _filter_qemu_io
+
+rm -f "$TEST_DIR/blkdebug.conf"
+
 echo
 echo "== Creating an image file with lazy_refcounts=off =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index 3c71e5a3dd..c0e1bf0a09 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -64,6 +64,42 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 incompatible_features     []
 
+== Reopening a dirty image read/write should repair it ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     [0]
+ERROR cluster 5 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+wrote 512/512 bytes at offset 1048576
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+incompatible_features     []
+No errors were found on the image.
+
+== A read/write reopen must not check the image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     [0]
+
+== A failed repair must fail the reopen ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+ERROR cluster 5 refcount=0 reference=1
+Rebuilding refcount structure
+qemu-io: ERROR writing refblock: Input/output error
+qcow2: Marking image as corrupt: Could not repair dirty image; further corruption events will be suppressed
+qemu-io: Could not repair dirty image
+read failed: No medium found
+
 == Creating an image file with lazy_refcounts=off ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
-- 
2.53.0


