Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9231FC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaOT-0005J6-0w; Wed, 22 Jul 2026 13:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO7-0005DH-EW
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:44 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO5-0001ax-I2
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:43 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so99490865e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739940; x=1785344740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c49tA2kmkgqkYuO/8OxNBkqfpXW7FHoFYG45qhc9Iks=;
 b=HYFKExrTam6DtA/g4VzX6Iu9DPC/Rkq1Gpu9gdLADaS6R4O168IX198r9eFM/EH+dJ
 68r/ih82GCBbHNzODfcix+f2nDVYEhhcvgzpERarHujD4o+OFQrSy4chc2h7PpSGWoqW
 TY0CWl49kzRJVpIv2vfDgJuqqt1v+jSQRok26nTBvtNZ2cUZGiarvJpn69SrcOH70dCC
 U729lcPbTNlzLTe7pwBJglMEqzTqw6rwEenug8qoUpPSs7B3f3c0A8Y/p+z1WJaORIRL
 d4RHl7epbI8VfUjtG0CYXUENdn8bMg8Htz817YEUp5pvkvwV20Bo6fGxxvubvmQrNUry
 oUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739940; x=1785344740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c49tA2kmkgqkYuO/8OxNBkqfpXW7FHoFYG45qhc9Iks=;
 b=mUaMdN83lTP47GfO0ZJJQS+ikvW34YD3M1IdKWn17+6zuDM/WL0DoXqdUo+1WDMbMC
 xPjvEJcO1XijN5W05AuxIovEnB7pgr8SLP4TGIvK6AZspIttKK3Yi2LxFyxpiWO/5W6J
 rOWqday9QxqMf7WQ28Jy7GYUaDnCDj+sVV2Dj1Nloa2PA0SNAHKd43Xb9zPpcFl7mHP/
 Jq9z+dSZFsVZRTVe0rGOTKmO5W3NCRBsgEOgf6PW8ET/h/4hI3jp6VP/i9j2V/nzRJL9
 2Q/XXi9qUPk3XimasAQChcw9yt+LJOxdThXLkjqiGtee3tvFTM1eRwpJOqYcEe4T9TJY
 +E6A==
X-Gm-Message-State: AOJu0Yxyz6/AzRkY6Ey4clRcNRf7CigNAlID5diFVcISmAOM/QLJuAJv
 Qcf7tjcpqgonqQvuOxmvGKD29uX6f7exmhNRvO79YP2KiJCzDLEf4Tt9LPJi09GWM4pg3ujzd11
 jUW0a
X-Gm-Gg: AR+sD12uBo++ZdItCRvI8VTvxOkjPBBImmimoeqo3M2HqqR15IEy5hwujklszFHUNy1
 AoS6fH1FBQOJm3IZ203ASB+zKPvke028oG7pj7YyfFzg25GXhPFwO0S2RGkFgd6/HaipmHesa9k
 xITOtNfwl5kYHXT8rnTePNFFnpNYhhNo1AD0UNtZV4aoskfbWLVCoJdM5YChl+Q29aCnV8BlDgU
 +7fxv3RWr+H4V80CITNL6LQ6QNWloZB1g/u/aa8+Y26orovYD62aBwuLzUXqYanz0vgF+tGcTu/
 lAFfnEdgL6M1YkaWcDzPYv5hNYwFa41oNFHPkvOq9znq7IdPdk6v+GvqES5F+TNg/7oPvv7mTS5
 tMW3KpAYt04QmPMQlnyh0a9ya5JHvuj6tvtHPKQF3TbvgE7Fj15z9djpaathTiUTIhGeNzSuapN
 U=
X-Received: by 2002:a05:600c:1d25:b0:495:6c44:633f with SMTP id
 5b1f17b1804b1-4956c4463c8mr37143635e9.31.1784739939918; 
 Wed, 22 Jul 2026 10:05:39 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:39 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Feifan Qian <bea1e@proton.me>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 8/9] parallels: validate BAT capacity against advertised disk
 size
Date: Wed, 22 Jul 2026 19:05:26 +0200
Message-ID: <20260722170527.2593225-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
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


