Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF66AC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683n-0002tH-NM; Mon, 14 Sep 2026 10:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683S-0002eP-LT
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:12 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683L-0005mn-3f
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:07 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so9583295e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397580; x=1790002380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iP+2NOIdwPzYJO1zWMz+Ov7zV1TiXqsEYFhNlD2DqBQ=;
 b=OWfJMz6cTp60YDShIXtmeEeNb1Kbp1Em1SR7Ff6idazpHiJ3+h0uvG/DTSWYUjK+yK
 5NU9ecr3w3zmb4lFp/MdebTD0fAbJuLRzH+DozcyfJ4YnT39nCpuGZOL2luTAxSydXX/
 Gt5/uzsgBXJhZBgtnbTXOm9UV3f8Uts+JeyTm4H4TVNEGsvmteA1+gdtN1xtfzqZyEem
 +DTvKm25kSXeUE0t1mN0OidnrbwPbWkyClJCupuBSI1Qc7k+N1VZg6j7v9ZXVVbVvZzo
 BtO7mhnvi15P+FtkjzXPhCdyn3ZgE/VUd1GGtYzRoopeMhLub1diAWwH9K4iNLmm7KF/
 A/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397580; x=1790002380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iP+2NOIdwPzYJO1zWMz+Ov7zV1TiXqsEYFhNlD2DqBQ=;
 b=RsUAC7o0pCuIgkmTI56HRHSfDv2U1mxDzDGMbzDyuQRavIMApilNRgrlr+BeTEKJrg
 tpfukbqoXwoQQ/mWyZMJ5motI6xFXpW5+9aYr3trBPwsbo2wengHRgNksrtM5WbfV6vy
 0Mz1NTxsHEwQe+s0TqUYrHPTu7Yq526F962ICExHqDMvryIh1G3xoOnfSk7r3YVTMRNj
 UMoOMg3aGXDr7sVRI0Ue5vMLaWByCmahOGIRhfmJkjVZ2dczV16txA26td6G0Vf98ibI
 pxru6HLkw8Sdz6QQZVogx/qi7wMF05dYMQpY5xzCZgHJZ39kfRC4HSaX80wcj+TDoYCG
 oe2A==
X-Gm-Message-State: AFuF++k9SogzoHN8wHfKSF7S7nmpS98t63pP0kkSv5jWrUffYiy715tj
 eRq/srAECWusFowjijHE/O8U4apj7eZdQ8/uAGqaMBjYWQmTVW0F4B57JQzvzTZ7glXsUdiOKgc
 8fUXl
X-Gm-Gg: AYBFou2HAmukFeT35SzDKNvB8reZE/AFneYVRQpbU3SPgcMiiwJteEFDalaCJAslxYA
 ybX31mGY+k6JoMeSy4AXU3CnLzes6MjL2FWW+R9vSBK0/lDhQXPlPhiIp+khAAoDmzSrckbHR4N
 ATWWOEIKsS0yymxMCg+Zg7/6iXOEwdrv9RzAZpSkJTpzqL/UzIjIQmBrXA9ALKn2Bp2MxGtNnau
 Xm+NqYW5qy1KMZ2V6HTt5Zsi4lkQXaXMA1pw6mIX4mim92bstEFGfMhDr/k2IYqDRrFBKd8Bb0g
 nqVS93bpQDyznIHeL6oT8anxz6xOepWN2JZxh9oRwp3Z0ZZuqUhyVLQnikn83XhF+u02N+WiaJf
 jC/gyqyWlmRNgMShRqWw9IFAxGcNXPoFEbo4odoODnCTXNn+hjqRVq0SBtDVq94DgKBCH7HVYaA
 KHTVL2mJZVwlCsuB0nmDq37vdEozpvWU8xM2vrEMQ/yqK6KhBbCIRDqtn9qxc2zSGdwGhNW5o1r
 di/gE0=
X-Received: by 2002:a05:600c:4ecc:b0:49e:6be6:d783 with SMTP id
 5b1f17b1804b1-49e7a5f419amr67189965e9.0.1789397578904; 
 Mon, 14 Sep 2026 07:52:58 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:52:58 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v2 4/9] iotests/124: cover backup of zero clusters and holes
Date: Mon, 14 Sep 2026 16:52:45 +0200
Message-ID: <20260914145250.2792879-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

The backup tests compare content only, and their sources hold data
alone, so nothing pins how backup treats zero clusters and holes. Back
up a source mixing data, write-zero and holes with sync=full, sync=top
and sync=bitmap, and check the target with qemu-img map, which tells a
copied cluster apart from a write-zero and from an untouched one.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/124     | 344 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/124.out |   4 +-
 2 files changed, 345 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index ab9ea4d8b5..30730e7f67 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -22,8 +22,11 @@
 #
 
 import os
+from collections import namedtuple
+
 import iotests
-from iotests import try_remove
+from iotests import (compare_images, qemu_img_create, qemu_img_map, qemu_io,
+                     try_remove)
 from qemu.qmp.qmp_client import ExecuteError
 
 
@@ -748,6 +751,345 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         self.check_backups()
 
 
+# Backup of sources mixing data, zero clusters and holes.
+
+Extent = namedtuple('Extent', ['start', 'length', 'kind'])
+Case = namedtuple('Case', ['size', 'layout', 'expected'], defaults=[None])
+
+source_img = os.path.join(iotests.test_dir, 'source')
+base_img = os.path.join(iotests.test_dir, 'base')
+target_img = os.path.join(iotests.test_dir, 'target')
+
+SIZE = 64 * 1024 * 1024
+MB = 1024 * 1024
+CLUSTER = 64 * 1024
+
+# Data, write-zero and holes, every combination at a cluster boundary.
+MIXED = Case(SIZE, [
+    (0, MB, 'data'),
+    (2 * MB, MB, 'zero'),
+    (5 * MB, 2 * MB, 'data'),
+    (8 * MB, MB, 'zero'),
+    (10 * MB, MB // 2, 'data'),
+    (20 * MB, 4 * MB, 'zero'),
+    (30 * MB, MB, 'data'),
+])
+
+# Single-cluster runs, and a zero run ending exactly at EOF.
+BOUNDARY_SIZE = 16 * MB
+BOUNDARY = Case(BOUNDARY_SIZE, [
+    (0, CLUSTER, 'zero'),
+    (CLUSTER, CLUSTER, 'data'),
+    (2 * CLUSTER, CLUSTER, 'zero'),
+    (3 * CLUSTER, CLUSTER, 'data'),
+    (4 * CLUSTER, 8 * MB, 'zero'),
+    (4 * CLUSTER + 8 * MB, CLUSTER, 'data'),
+    (BOUNDARY_SIZE - CLUSTER, CLUSTER, 'zero'),
+])
+
+# A zero run past the old block_copy_chunk_size() 16M cap.
+LARGE_ZERO = Case(48 * MB, [
+    (0, MB, 'data'),
+    (4 * MB, 32 * MB, 'zero'),
+    (40 * MB, MB, 'data'),
+])
+
+# Image size not a multiple of the cluster size: a partial tail cluster.
+TAIL_SIZE = 4 * MB + 4096
+TAIL_CLUSTER = (TAIL_SIZE // CLUSTER) * CLUSTER
+TAIL_DATA = Case(TAIL_SIZE, [
+    (0, MB, 'data'),
+    (2 * MB, MB, 'zero'),
+    (4 * MB, TAIL_SIZE - 4 * MB, 'data'),
+])
+# The partial tail cluster falls out of zero_bitmap, so it copies as data.
+TAIL_ZERO = Case(TAIL_SIZE, [
+    (0, MB, 'data'),
+    (2 * MB, TAIL_SIZE - 2 * MB, 'zero'),
+], [
+    (0, MB, 'data'),
+    (2 * MB, TAIL_CLUSTER - 2 * MB, 'zero'),
+    (TAIL_CLUSTER, TAIL_SIZE - TAIL_CLUSTER, 'data'),
+])
+
+
+def coalesce(extents):
+    out = []
+    for e in extents:
+        prev = out[-1] if out else None
+        adjacent = prev is not None and prev.start + prev.length == e.start
+        if adjacent and prev.kind == e.kind:
+            out[-1] = prev._replace(length=prev.length + e.length)
+        else:
+            out.append(e)
+    return out
+
+
+def layout_to_extents(layout, size, gap='hole'):
+    extents = []
+    pos = 0
+    for offset, length, kind in layout:
+        if offset > pos:
+            extents.append(Extent(pos, offset - pos, gap))
+        extents.append(Extent(offset, length, kind))
+        pos = offset + length
+    if pos < size:
+        extents.append(Extent(pos, size - pos, gap))
+    return coalesce(extents)
+
+
+def create_image(path, size, backing=None, opts=None):
+    args = ['-f', iotests.imgfmt]
+    if opts:
+        args += ['-o', opts]
+    if backing:
+        args += ['-b', backing, '-F', iotests.imgfmt]
+    qemu_img_create(*args, path, str(size))
+
+
+class TestBackupZeroClusters(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for img in (source_img, base_img, target_img):
+            if os.path.exists(img):
+                os.remove(img)
+
+    def hmp_write(self, drive, cmd):
+        res = self.vm.hmp_qemu_io(drive, cmd)
+        assert 'error' not in res['return'].lower(), res
+
+    def write_layout(self, layout):
+        for offset, length, kind in layout:
+            opt = '-z' if kind == 'zero' else '-P 0x5a'
+            self.hmp_write('src', f'write {opt} {offset} {length}')
+
+    def assert_map(self, case, backing=False, gap='hole'):
+        # Content is not enough, pin the data/zero/hole split as well.
+        def classify(e):
+            is_hole = e['depth'] > 0 if backing else not e['present']
+            return 'hole' if is_hole else ('zero' if e['zero'] else 'data')
+
+        actual = coalesce([Extent(e['start'], e['length'], classify(e))
+                           for e in qemu_img_map(target_img)])
+        layout = case.expected if case.expected else case.layout
+
+        self.assertEqual(actual, layout_to_extents(layout, case.size, gap))
+
+    def add_source(self, case=MIXED, backing=None, opts=None):
+        create_image(source_img, case.size, backing, opts)
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'src',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': source_img},
+        })
+
+        # Write through the node, so an attached bitmap sees it.
+        self.write_layout(case.layout)
+
+    def dirty_layout(self, case):
+        # A new bitmap tracks nothing yet: dirty all, then re-apply.
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.hmp_write('src', f'write -z 0 {case.size}')
+        self.write_layout(case.layout)
+
+    def do_backup(self, sync, case, target_backing=None, prefill=None,
+                  **kwargs):
+        create_image(target_img, case.size, target_backing)
+
+        if prefill is not None:
+            # Not zero, so a skipped cluster is provably untouched.
+            qemu_io('-c', f'write -P {prefill} 0 {case.size}', target_img)
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'target',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': target_img},
+        })
+
+        self.vm.cmd('blockdev-backup', device='src', target='target',
+                    job_id='bk0', sync=sync, **kwargs)
+        self.wait_until_completed(drive='bk0')
+
+        self.vm.cmd('blockdev-del', node_name='target')
+        self.vm.cmd('blockdev-del', node_name='src')
+
+    def backup_and_check(self, sync, case, gap='zero', backing=False,
+                         **kwargs):
+        self.do_backup(sync, case, **kwargs)
+        self.assertTrue(compare_images(source_img, target_img))
+        self.assert_map(case, backing=backing, gap=gap)
+
+    def test_full(self):
+        self.add_source()
+        self.backup_and_check('full', MIXED)
+
+    def test_full_zero_overwrite(self):
+        # full skips holes, so only check that zero overwrites prefill.
+        case = Case(SIZE, [(2 * MB, MB, 'zero')])
+        self.add_source(case)
+        self.do_backup('full', case, prefill=0xcc)
+        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
+
+    def test_bitmap(self):
+        self.add_source()
+        self.dirty_layout(MIXED)
+        self.backup_and_check('bitmap', MIXED, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_top(self):
+        # Non-zero backing data, so a hole and an explicit zero differ.
+        create_image(base_img, SIZE)
+        qemu_io('-c', f'write -P 0x33 0 {SIZE}', base_img)
+
+        self.add_source(backing=base_img)
+        self.backup_and_check('top', MIXED, gap='hole', backing=True,
+                              target_backing=base_img)
+
+    def test_boundary_full(self):
+        self.add_source(BOUNDARY)
+        self.backup_and_check('full', BOUNDARY)
+
+    def test_boundary_bitmap(self):
+        self.add_source(BOUNDARY)
+        self.dirty_layout(BOUNDARY)
+        self.backup_and_check('bitmap', BOUNDARY, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_large_zero_full(self):
+        self.add_source(LARGE_ZERO)
+        self.backup_and_check('full', LARGE_ZERO)
+
+    def test_large_zero_bitmap(self):
+        self.add_source(LARGE_ZERO)
+        self.dirty_layout(LARGE_ZERO)
+        self.backup_and_check('bitmap', LARGE_ZERO, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_huge_zero(self):
+        # A zero run past the cap on a single write-zeroes request, so it
+        # has to be split. qemu-io caps one write at 2G, hence three.
+        case = Case(2560 * MB, [(0, 1024 * MB, 'zero'),
+                                (1024 * MB, 1024 * MB, 'zero'),
+                                (2048 * MB, 512 * MB, 'zero')])
+        self.add_source(case)
+        self.backup_and_check('full', case)
+
+    def test_tail_data(self):
+        self.add_source(TAIL_DATA)
+        self.backup_and_check('full', TAIL_DATA)
+
+    def test_tail_zero(self):
+        self.add_source(TAIL_ZERO)
+        self.backup_and_check('full', TAIL_ZERO)
+
+    def test_tail_zero_bitmap(self):
+        # Same tail rounding as test_tail_zero, via the bitmap scan.
+        self.add_source(TAIL_ZERO)
+        self.dirty_layout(TAIL_ZERO)
+        self.backup_and_check('bitmap', TAIL_ZERO, bitmap='bm0',
+                              bitmap_mode='never')
+
+    def test_mixed_cluster(self):
+        # 4K source clusters, so content varies inside one 64K cluster.
+        case = Case(2 * CLUSTER, [
+            (0, 8 * 1024, 'zero'),
+            (8 * 1024, 8 * 1024, 'data'),
+            (CLUSTER, CLUSTER, 'zero'),
+        ], [
+            # A mixed cluster must be data, or the data at [8k, 16k) is lost.
+            (0, CLUSTER, 'data'),
+            (CLUSTER, CLUSTER, 'zero'),
+        ])
+        self.add_source(case, opts='cluster_size=4k')
+        self.backup_and_check('full', case)
+
+    def test_top_zero_broken(self):
+        # An overlay hole before an explicit-zero run: the zero prefix
+        # must stop at the hole, or the backing data under it is lost.
+        size = 2 * CLUSTER
+        create_image(base_img, size, opts='cluster_size=4k')
+        qemu_io('-c', f'write -P 0x33 0 {size}', base_img)
+
+        # [0, 4k) stays a hole, the zero run spills into cluster 1.
+        case = Case(size, [(4096, CLUSTER, 'zero')])
+        self.add_source(case, backing=base_img, opts='cluster_size=4k')
+
+        self.do_backup('top', case, target_backing=base_img)
+        self.assertTrue(compare_images(source_img, target_img))
+
+    def test_bitmap_straddle(self):
+        # One dirty run straddling a zero/data transition, both ways.
+        case = Case(SIZE, [])
+        self.add_source(case)
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+
+        # One contiguous dirty run each: [7M, 9M) zero to data, and
+        # [15M, 17M) data to zero.
+        self.write_layout([
+            (7 * MB, MB, 'zero'),
+            (8 * MB, MB, 'data'),
+            (15 * MB, MB, 'data'),
+            (16 * MB, MB, 'zero'),
+        ])
+
+        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never')
+        self.assertTrue(compare_images(source_img, target_img))
+
+    def test_bitmap_fragmented(self):
+        # Isolated single-cluster dirty spots: nothing outside them
+        # may reach the target.
+        case = Case(SIZE, [])
+        self.add_source(case)
+
+        # Written before the bitmap exists, so untracked.
+        self.hmp_write('src', f'write -P 0x5a 0 {16 * MB}')
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+
+        # The only dirty bit in the data region, with a pattern of its own.
+        data_island = 4 * MB
+        self.hmp_write('src', f'write -P 0x7b {data_island} {CLUSTER}')
+
+        # The only dirty bit in the hole region.
+        zero_island = 24 * MB
+        self.hmp_write('src', f'write -z {zero_island} {CLUSTER}')
+
+        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never',
+                       prefill=0xcc)
+
+        # Only the two isolated spots should have reached target ...
+        qemu_io('-c', f'read -P 0x7b {data_island} {CLUSTER}', target_img)
+        qemu_io('-c', f'read -P 0 {zero_island} {CLUSTER}', target_img)
+
+        # ... everything else must still hold the prefill pattern.
+        qemu_io('-c', f'read -P 0xcc 0 {CLUSTER}', target_img)
+        qemu_io('-c', f'read -P 0xcc {8 * MB} {CLUSTER}', target_img)
+
+    def test_bitmap_clean_zero_gap(self):
+        # A clean zero run between two dirty ones must stay prefilled.
+        case = Case(16 * MB, [])
+        self.add_source(case)
+        self.hmp_write('src', f'write -z 0 {16 * MB}')
+
+        self.vm.cmd('block-dirty-bitmap-add', node='src', name='bm0')
+        self.write_layout([(2 * MB, MB, 'zero'), (6 * MB, MB, 'zero')])
+
+        self.do_backup('bitmap', case, bitmap='bm0', bitmap_mode='never',
+                       prefill=0xcc)
+
+        qemu_io('-c', f'read -P 0 {2 * MB} {MB}', target_img)
+        qemu_io('-c', f'read -P 0 {6 * MB} {MB}', target_img)
+
+        qemu_io('-c', f'read -P 0xcc 0 {2 * MB}', target_img)
+        qemu_io('-c', f'read -P 0xcc {3 * MB} {3 * MB}', target_img)
+        qemu_io('-c', f'read -P 0xcc {7 * MB} {9 * MB}', target_img)
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'],
diff --git a/tests/qemu-iotests/124.out b/tests/qemu-iotests/124.out
index fa16b5ccef..5ce2f9a2ed 100644
--- a/tests/qemu-iotests/124.out
+++ b/tests/qemu-iotests/124.out
@@ -1,5 +1,5 @@
-.............
+..............................
 ----------------------------------------------------------------------
-Ran 13 tests
+Ran 30 tests
 
 OK
-- 
2.53.0


