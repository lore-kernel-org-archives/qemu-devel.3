Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125DBC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGh-0008Bl-7o; Tue, 28 Jul 2026 06:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGf-0008Ay-7C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:37 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGd-0008J0-3g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:36 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15f47e6297so394099066b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235354; x=1785840154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c49tA2kmkgqkYuO/8OxNBkqfpXW7FHoFYG45qhc9Iks=;
 b=tBwCHvH/jIL2R8R/Zj8mOrWhh8kIKwLzSYg2IPyKc3Fy31BNj6KoXYRYaG91Mzv6zo
 QvlJ9siyMS9mprFOcZrtFdFlfP0X/pix4Dqg4kHvQ39vf2U8C7S1lHZOpzOpNAXcbodo
 diM4B+yECX1Eh7q+GgiQJ71eJuQdtGG1hrEk/4oh7fXsKpaxBQm3q02U53aY4Dj8wTSB
 +op3hzHBA3zbjSsgLbdKI31YTS2Zj4NQn4qsHjn98fvXlx5iA7UwV95xot5qpswa9vSi
 zZwqheBd9jT5CWlAVvY8OyKI/gHILrxole5qzDY4QdxjpbdqdRGaVGCyQnIPSe5oyLjh
 LkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235354; x=1785840154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c49tA2kmkgqkYuO/8OxNBkqfpXW7FHoFYG45qhc9Iks=;
 b=UYQH15+DJXW2ta3uDiEuoVyBgkrmoLban95OSWcCRqYJDQKYXuvHJfkGZ+fvB0R5Vv
 cKUjSp/h2y4cX2JX08BCfeQvZQY/1lbpSzXOjG1T67sYPRIkpm/RRIQHe+hRgyh+EXU+
 0fH7OLbcOQEDHSMlHcXh1LDT2TOqkn8bZQ1kaB43ioXTpq/Z/RnzDWO5fLZptk9L47/Y
 KQuxcwRKVkj8QKrEWTaqrbJazCckXKuYkybkQz1vW9RIj62gqo/P/2GXhwLBR5N2kMG4
 oJTWVa364oHeLPa6DmJKt/RlWlJv2RFUxoIBINyn1JKZZ7jDaL5m+5vp9Gr8ahHY9NaI
 hQyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXJVT6UCiFA9QzV9IE64OkjIIRVukpNjY1Owrdd22mWS2k1lGJ15gJjcC4v62MBciep2PM3yZKjmng@nongnu.org
X-Gm-Message-State: AOJu0YxD3mxUEWphqgFXcAl3v/x7pJcmxdPqEon7KHMitPEeut7VMDU5
 y2y3dv4QhClcMHpj68ZKTf19ZwoXdMO1RUhjjTxc7mekL/0QJckTIB8DSFVRE+vvbrc=
X-Gm-Gg: AR+sD11GrgUNA+1318/L1O+xO7JBrAn9POnM8PBMrKXQF18J7DEiGfg17mruLROy7MG
 pZQWoWXE2tqqNstpuQ5Mh8IZFcflykaercq/5RkbVL3q0+74QxzSox6N3bAEqfW8BCR6FEpYxjg
 t3qKOaVz42+IlVrnVOftPUU20axN/ZmCU1eN8aGQm81tS01MMAalLM7Sr2iKrQFkxBYffxghxWa
 wopC3kjRWk3UODvYB37y2oU9nazYYw75BST7wNMvJBt0tQ7kaNyugwsGjJAKBZq6OMPo1q2KaFP
 MFZAatia3EZlejB70peRY44swh3LFXWNGMHXTZwlIAAjR5xV+hCOnybhzoNebKBnu4zCdD87EcP
 ORYdrdrGdI06YvtBV/Vc2/tY/IQxnGnTCUVhzMvuVjgWXVEIj+U0Hy/Su5H5z/KNdvA==
X-Received: by 2002:a17:907:d28:b0:c16:4e5:944a with SMTP id
 a640c23a62f3a-c1f720c6126mr89363866b.21.1785235353586; 
 Tue, 28 Jul 2026 03:42:33 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Feifan Qian <bea1e@proton.me>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 8/9] parallels: validate BAT capacity against advertised disk
 size
Date: Tue, 28 Jul 2026 12:42:20 +0200
Message-ID: <20260728104221.3981592-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=den@openvz.org; helo=mail-ej1-x631.google.com
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

parallels_open() copied nb_sectors, tracks, and bat_entries from the
image header without checking that the BAT actually covers the
advertised virtual disk size. An image whose header claims more
sectors than its BAT covers passes the generic block-layer bounds
check on open. A write into the gap between BAT coverage and the
advertised size then reaches allocate_clusters(), whose internal
assert(idx < s->bat_size && idx + to_allocate <= s->bat_size) aborts
the process instead of returning a normal I/O error.

Reject such images at open time by requiring
bat_size * tracks >= total_sectors, matching the invariant that
allocate_clusters() already assumes.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3804
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c                             |  6 ++++++
 tests/qemu-iotests/tests/parallels-checks     | 21 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  7 +++++++
 3 files changed, 34 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 8a7e8b4aba..93b5fa9dcd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1328,6 +1328,12 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         return -EFBIG;
     }
 
+    if ((uint64_t)s->bat_size * s->tracks < bs->total_sectors) {
+        error_setg(errp, "Invalid image: Catalog size too small for "
+                   "advertised disk size");
+        return -EINVAL;
+    }
+
     size = bat_entry_off(s->bat_size);
     s->header_size = ROUND_UP(size, bdrv_opt_mem_align(bs->file->bs));
     s->header = qemu_try_blockalign(bs->file->bs, s->header_size);
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index eef1c86809..66199fff1a 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -225,6 +225,27 @@ echo "== an unallocated cluster still reads as zeroes =="
 # Clear image
 _make_test_img $SIZE
 
+echo "== TEST OVERSIZED VIRTUAL DISK CHECK =="
+
+BAT_ENTRIES_OFFSET=32
+NB_SECTORS_OFFSET=36
+
+TRACKS=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+BAT_ENTRIES=$(peek_file_le $TEST_IMG $BAT_ENTRIES_OFFSET 4)
+COVERED_SECTORS=$((BAT_ENTRIES * TRACKS))
+
+echo "== advertise one more cluster than the BAT covers =="
+poke_file_le "$TEST_IMG" $NB_SECTORS_OFFSET 8 $((COVERED_SECTORS + TRACKS))
+
+echo "== open must fail cleanly instead of aborting =="
+{ $QEMU_IMG info "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== write into the uncovered range must fail cleanly too =="
+{ $QEMU_IO -c "write -P 0x41 $((COVERED_SECTORS * 512)) $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image
+_make_test_img $SIZE
+
 echo "== TEST BAT ENTRY POINTING OUTSIDE IMAGE =="
 
 echo "== corrupt image: point first cluster far outside the file =="
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 86d5b6ac2d..7b73498271 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -147,6 +147,13 @@ Child node '/file':
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST OVERSIZED VIRTUAL DISK CHECK ==
+== advertise one more cluster than the BAT covers ==
+== open must fail cleanly instead of aborting ==
+qemu-img: Could not open 'TEST_DIR/t.parallels': Invalid image: Catalog size too small for advertised disk size
+== write into the uncovered range must fail cleanly too ==
+qemu-io: can't open device TEST_DIR/t.parallels: Invalid image: Catalog size too small for advertised disk size
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST BAT ENTRY POINTING OUTSIDE IMAGE ==
 == corrupt image: point first cluster far outside the file ==
 == read-only read must return zeroes, not an I/O error ==
-- 
2.53.0


