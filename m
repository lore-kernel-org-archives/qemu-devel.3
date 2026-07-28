Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF7FC54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtV-0003YT-Ka; Tue, 28 Jul 2026 11:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtU-0003XX-LY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtR-0002hN-TH
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:00 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so1441f8f.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253136; x=1785857936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qJoWo6IWghEa8NGO4hqbax4oCMGEskJxTM6dWHfvgM=;
 b=fILXVbhjz5eqYVsshvHwk51/eluod6uV+UqtpZlS/6KUJYwENm8ZlBrQnADMLU8Q/y
 rY09uT5H3Fwq8zShwD+HptvNRAuUwqXLudah/7FRXP+nt2oBS01lpTMYdbc6s9hTKayA
 lgQFcioeqvNFET/7MaavrWoF5eNDPwvkbhlrt2Ts4tvVLEdmYeD6VYJwf1NvKgBxbVzd
 0B30NfCy8wzyNBo/9V4ps3wKoPwp0UOmhAA8JLPfMeN5xCWvnR9l/FZbE6WpAWBtPJod
 WjQ5SUOf+bR+L/FswRD7Z0Q5v+AZtVO89e2JeY5cinkR45qf9gauUm4+xNMi8W51gM77
 T9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253136; x=1785857936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qJoWo6IWghEa8NGO4hqbax4oCMGEskJxTM6dWHfvgM=;
 b=RVr4NjOHEK7g6nEmQ2pBrzZimxXvOl1xDT7mFroIW7VRrFf48bRrziLVaU6W7c1U+c
 efm9YruBohJx2DSsT5Y2eBaBqyrm76qrhlNUxtzFBWjWTHfR6Sx4aj9c3n84E9y3Oz71
 BKMAe/YtEseh29D0HUKQNn9GJQ7p8z8RZcxeqc3J1vsppYDse86cHACv9d0bfeqp7fWb
 dbh0pMsV5ectHXSDz1Y7Fj+Dh+HPc1HJ99Jz/Z2h80sBC4ZMWUHhxDOtrZsuunNfYCYS
 ClDWDzSPP5uoEy+qnsJset5L1kGm2yfbO8Mf8Q/MvAm8jINrLqBQe2Dq625G5HZLm4O7
 7V2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrL4fV/TMdSE61zz3IIyzSo+6ly+iElwjct3L/BmlPKZfP2DxqSX8TV9aK/AG1u5mAON1u4grvjkzpU@nongnu.org
X-Gm-Message-State: AOJu0Yz+pzAt+HZE8efztoU3fX14cvW0KzW67kVqW9Pr01olwK5dj6Ej
 Fv4XE4FwwnFi1NZBQo6witeBZjcuTJOfBlTlXserVLiQTqIV30PAYl+3Wn+tHnXkuZw=
X-Gm-Gg: AR+sD10xxgmdsKnMskTNU+fUP01QBPwvqMcOZ+RIJ6nfORY8bb96ql9l3ZCyLyKZSRo
 xyKOwDM43KpG168KSW11nC7MWA1Efch1cVX4JVn7Ys582Su6oB5IY5KVfkkgnCF0XmirlRERftd
 cxWazLkDmT6TF1FXP7Wx9Ri62BjQ8lZ0UjMXXTWpyoZsfNf35Ng9j8SgotlB+oAVNxIsKWAhydM
 3x4SWpZZUAvVEMzVigppTAz1pjz2KDhuyJYDvWfZKu2TdYeUbDbMC4rrz4KmCTw7VIwPY3P7Y5l
 kKl+JSGFGM15CP4X85Cd6tyQChILs1n+q3p8linEFCASx2UwFeVTicJ/AZAVuWKr6I3wUJypdNC
 FoWs5tP0QuhvyjEhsn1855VkKI1KRxW2OfQhxHOKmoupU9Vz3+4ZBNyOMu2l9Y/bM9ThLOykBmk
 i46gHU4Kwe
X-Received: by 2002:a05:6000:4283:b0:47f:93b6:8d05 with SMTP id
 ffacd0b85a97d-47fb1e14297mr3409865f8f.0.1785253136285; 
 Tue, 28 Jul 2026 08:38:56 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 4/9] parallels: reject BAT entries pointing outside backed
 storage
Date: Tue, 28 Jul 2026 17:38:44 +0200
Message-ID: <20260728153849.601939-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

parallels_open()'s BAT scan and parallels_check_outside_image() only
checked entries against the file's upper end, matching just half of
what docs/interop/parallels.rst requires: an entry's offset must be
both >= data_start and < the file size. An entry below data_start
resolves into the header/BAT region itself, corrupting metadata on
write or losing the write silently on a partial overlap, and neither
qemu-img check nor the open-time scan ever caught it.

Check both bounds everywhere a BAT entry is resolved to a host
offset: seek_to_sector(), the open-time scan (without letting a bad
entry inflate data_end), and parallels_check_outside_image().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c                             | 27 +++++++--
 tests/qemu-iotests/tests/parallels-checks     | 58 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 35 +++++++++++
 3 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index e3d26a6650..8a7e8b4aba 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -119,6 +119,7 @@ static uint32_t bat_entry_off(uint32_t idx)
 static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
 {
     uint32_t index, offset;
+    int64_t cluster_off;
 
     index = sector_num / s->tracks;
     offset = sector_num % s->tracks;
@@ -127,7 +128,14 @@ static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
     if ((index >= s->bat_size) || (s->bat_bitmap[index] == 0)) {
         return -1;
     }
-    return bat2sect(s, index) + offset;
+
+    cluster_off = bat2sect(s, index);
+    if (cluster_off < s->data_start || cluster_off + s->tracks > s->data_end) {
+        /* Cluster is outside of the image file or overlaps the header. */
+        return -1;
+    }
+
+    return cluster_off + offset;
 }
 
 static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
@@ -703,18 +711,22 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t i;
-    int64_t off, high_off, size;
+    int64_t off, high_off, size, data_start_off;
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
+    data_start_off = s->data_start << BDRV_SECTOR_BITS;
 
     high_off = 0;
     for (i = 0; i < s->bat_size; i++) {
         off = bat2sect(s, i) << BDRV_SECTOR_BITS;
-        if (off + s->cluster_size > size) {
+        if (off == 0) {
+            continue;
+        }
+        if (off < data_start_off || off + s->cluster_size > size) {
             fprintf(stderr, "%s cluster %u is outside image\n",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
             res->corruptions++;
@@ -1398,11 +1410,18 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         sector = bat2sect(s, i);
+        if (sector == 0) {
+            continue; /* not allocated */
+        }
+        if (sector < data_start || sector + s->tracks > file_nb_sectors) {
+            /* Cluster is outside of the image file or overlaps the header. */
+            need_check = true;
+            continue;
+        }
         if (sector + s->tracks > s->data_end) {
             s->data_end = sector + s->tracks;
         }
     }
-    need_check = need_check || s->data_end > file_nb_sectors;
 
     if (!need_check) {
         ret = parallels_fill_used_bitmap(bs);
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 9535024885..abd119bc7b 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -222,6 +222,64 @@ _img_info
 echo "== an unallocated cluster still reads as zeroes =="
 { $QEMU_IO -r -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST BAT ENTRY POINTING OUTSIDE IMAGE =="
+
+echo "== corrupt image: point first cluster far outside the file =="
+poke_file_le "$TEST_IMG" $BAT_OFFSET 4 1000000
+
+echo "== read-only read must return zeroes, not an I/O error =="
+{ $QEMU_IO -r -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== write must allocate a fresh cluster instead of trusting the entry =="
+{ $QEMU_IO -c "write -P 0x77 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== file did not grow anywhere near the bogus offset =="
+file_size=`stat --printf="%s" "$TEST_IMG"`
+if [ "$file_size" -lt $((16 * 1024 * 1024)) ]; then
+    echo "file size sane: yes"
+else
+    echo "file size sane: no ($file_size bytes)"
+fi
+
+echo "== data reads back correctly =="
+{ $QEMU_IO -r -c "read -P 0x77 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image, with a small cluster size so the BAT table itself spans
+# more than one cluster and there is room to point before data_off.
+_make_test_img -o cluster_size=512 65536
+
+SMALL_CLUSTER_SIZE=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+SMALL_CLUSTER_SIZE=$((SMALL_CLUSTER_SIZE * 512))
+DATA_OFF=$(peek_file_le $TEST_IMG $DATA_OFF_OFFSET 4)
+echo "cluster size: $SMALL_CLUSTER_SIZE, data offset (sectors): $DATA_OFF"
+
+# Cluster index 1 starts at this byte offset, which must be < data_off
+# in sectors * 512 for this test to actually exercise the bug.
+VICTIM_OFFSET=$SMALL_CLUSTER_SIZE
+
+echo "== TEST BAT ENTRY POINTING BEFORE DATA AREA =="
+
+echo "== corrupt image: point first cluster into the BAT table itself =="
+poke_file_le "$TEST_IMG" $BAT_OFFSET 4 1
+
+echo "== qemu-img check detects it without repairing =="
+_check_test_img
+
+echo "== bytes at the victim offset before write =="
+echo "$(peek_file_le "$TEST_IMG" $VICTIM_OFFSET 4)"
+
+echo "== write must allocate a fresh cluster instead of clobbering the BAT =="
+{ $QEMU_IO -c "write -P 0x88 0 $SMALL_CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== bytes at the victim offset are unchanged =="
+echo "$(peek_file_le "$TEST_IMG" $VICTIM_OFFSET 4)"
+
+echo "== data reads back correctly =="
+{ $QEMU_IO -r -c "read -P 0x88 0 $SMALL_CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 6fb2014e8e..914616d023 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -140,4 +140,39 @@ virtual size: 4 MiB (4194304 bytes)
 == an unallocated cluster still reads as zeroes ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST BAT ENTRY POINTING OUTSIDE IMAGE ==
+== corrupt image: point first cluster far outside the file ==
+== read-only read must return zeroes, not an I/O error ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== write must allocate a fresh cluster instead of trusting the entry ==
+Repairing cluster 0 is outside image
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== file did not grow anywhere near the bogus offset ==
+file size sane: yes
+== data reads back correctly ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+cluster size: 512, data offset (sectors): 2
+== TEST BAT ENTRY POINTING BEFORE DATA AREA ==
+== corrupt image: point first cluster into the BAT table itself ==
+== qemu-img check detects it without repairing ==
+ERROR cluster 0 is outside image
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+== bytes at the victim offset before write ==
+0
+== write must allocate a fresh cluster instead of clobbering the BAT ==
+Repairing cluster 0 is outside image
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== bytes at the victim offset are unchanged ==
+0
+== data reads back correctly ==
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.53.0


