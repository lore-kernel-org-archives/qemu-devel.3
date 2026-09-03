Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CE0C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fI-0002xQ-En; Thu, 03 Sep 2026 10:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fG-0002vw-Nx
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:42 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fD-00048Y-66
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:42 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2436536f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446618; x=1789051418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cQlgvs0K0xIlGh+yKAKDJcIf9T3Gw9z+mIu16XTKHjQ=;
 b=CsrRPviUcO+kKX20n0cL3INFH3OHuG5YIxn8ucKwYaUacYuvla7LgvkhSUYd1cvbl7
 uHqBOL4030oFiqqN1bJaZUrW7AcfMG3pONsrG9vruZnNhoa1m/gI+wmesfYGF9m5wCSI
 ZzOaM7rmn/8LUZTJwFB0FTj8dARcxdjyVBka4xSiWfQhLZjLeUq4/TG5P3EeFd/GdXcw
 pC6MDmCS/oiak5GeUJGNd34a4XeuxagUuGqskB53mKweoXhVHIat9AlPC52q5iBSXkB5
 uqnBIo7JXf8jL6GYlquzK9WuowWyhNGVStvsr1FYbCiejuC1bhr9wPMNi0SFRXDOct6B
 veIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446618; x=1789051418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cQlgvs0K0xIlGh+yKAKDJcIf9T3Gw9z+mIu16XTKHjQ=;
 b=nLJM01hdMVE8XJfqnSMLhfRJIluhoqfRpcVAcbolju7PotP7mmO/HpEKe6lZM/jfL6
 LLVv0xWTYmHIlkFvtALQGAbOKNiEWBX/u8zKunPcFCZjZQl8C2Wf7QgpbIFhbB//zpm9
 t+1YnR9+1IakvaIo0gjgun+I8gnT3jTwV9qXNmqDGhvxcHnko8syRyZoT2gUs0shWib+
 bGbcnRKnwsJmoou0P4z027T8Bj43EOJBSeDhVAM4Wx0GL8VsEN4srpvphaMRTdI+7/vs
 DMNPtuqNYJyDctoENH+Alc4CD2YbkFuY2qdSMDN5nG8XrB9bowhr9fBD7oT/m1B+Lqoo
 RRlQ==
X-Gm-Message-State: AFuF++lkWzxoz45BdA9qKMHr0i0EVZ2sEW0nFzNQzCTdKNYf91KuvGDE
 XzNhdrIuLvZ3e41UoB7CG6hQig+4c0KDmyf0YP/x9cbp9RMEL1eOVQjBPkCvmx0+LVYqTmEjPbQ
 cEy5K
X-Gm-Gg: AYBFou0aMLJu9s3PqXHz5HjEZ7SKsAdlrDR0nmMRKIDZ1zrCWTrMfBsrl/ilCEJ1DJv
 ok/9YQtuSN1QZdCjTTuX5L6MzADB1jPg9nabFAMRg32S52RAGlo+yZKTLnXeiV9dmzH75+BSAwH
 vHVBb31o5X6Ispud7gbt6pWjC9TIRivEMJX80yl93i1Nqq2XQaSzKYiRPUWXpeFQvtgbKiJsx9V
 dVfg83sIApzkGxvEICaVN3kR5IJvhfKWCwXMXC/vtTYS6sNI32nSFvoBkA0i4uSKRGU5ITqLTFO
 7jZtetaMxTKgkU+bQQyOl0wHjsAqJ0QYsZrh5oHg1dciGyxPlefYZUGCUma180u4Cq46CIDky+f
 z+M0perIFXqyLZ8p+SkiwsZWJxcKBY4lFQtcyBN0isvSzmP6hmuMAeMjpnr+59GzPD4ILI5e06x
 Yf/1JfjLQ7gmS1IiPVzk3eSRQPxYtiaNXjo4xamkiC548dHBaOs+JdudRz
X-Received: by 2002:a5d:4562:0:b0:485:83a6:b296 with SMTP id
 ffacd0b85a97d-485860d54c7mr1330821f8f.19.1788446617707; 
 Thu, 03 Sep 2026 07:43:37 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 23/25] iotests: cover a broken Format Extension and a
 combined repair
Date: Thu,  3 Sep 2026 16:41:41 +0200
Message-ID: <20260903144143.2328870-24-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=den@openvz.org; helo=mail-wr1-x435.google.com
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

From: Denis V. Lunev <den@openvz.org>

An image which was not closed correctly may have had its Format
Extension cluster reused by a guest write, which is what the reuse of
those clusters is for. It has to open anyway, as the payload is intact,
and it has to stop pointing at what is no longer an extension.

The same damage in an image which was closed correctly is what an older
qemu leaves behind, as it ignores the extension in read-write mode and
truncates the file to the end of the payload on close. Both shapes of
it are covered: the cluster overwritten with something which is not an
extension, and the cluster truncated away with the header still
pointing past the end of the file. Neither keeps the image shut, and
qemu-img info is enough to tell, as it opens the image on its own.

Rebuilding the used bitmap after a leak is repaired reports the errors
which come with a BAT pointing a cluster twice, and those are the ones
qemu-img check is there to fix, so a duplicate entry next to a leak is
covered too.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-checks     | 80 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 57 +++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 84eb526f44..ca89ed5d62 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -443,6 +443,86 @@ echo "== guest data was never in doubt =="
 # Clear image
 _make_test_img $SIZE
 
+echo "== TEST BROKEN EXTENSION OF AN IMAGE WHICH WAS NOT CLOSED =="
+
+EXT_OFF_OFFSET=56
+
+echo "== add a persistent dirty bitmap =="
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+
+ext_off=$(peek_file_le "$TEST_IMG" $EXT_OFF_OFFSET 8)
+
+echo "== a guest write may reuse the extension cluster, so clobber it =="
+poke_file "$TEST_IMG" $((ext_off * 512)) "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+
+echo "== pretend the image was not closed correctly =="
+poke_file "$TEST_IMG" "$INUSE_OFFSET" "\x59\x6e\x6f\x74"
+
+echo "== the image opens, the extension is dropped =="
+{ $QEMU_IO -c "write -P 0x11 0 64k" "$TEST_IMG"; } 2>&1 | _filter_qemu_io |
+    _filter_testdir | _filter_generated_node_ids
+
+echo "== and it stopped pointing at the broken extension =="
+echo "ext_off: $(peek_file_le "$TEST_IMG" $EXT_OFF_OFFSET 8)"
+
+echo "== an older qemu leaves the same damage behind a clean close =="
+_make_test_img $SIZE
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+ext_off=$(peek_file_le "$TEST_IMG" $EXT_OFF_OFFSET 8)
+poke_file "$TEST_IMG" $((ext_off * 512)) "\xaa\xaa\xaa\xaa\xaa\xaa\xaa\xaa"
+_img_info | _filter_generated_node_ids
+
+echo "== truncating the extension away is dropped as well =="
+_make_test_img $SIZE
+$QEMU_IMG bitmap --add -f $IMGFMT "$TEST_IMG" $BITMAP 2>&1 | _filter_testdir
+ext_off=$(peek_file_le "$TEST_IMG" $EXT_OFF_OFFSET 8)
+truncate -s $((ext_off * 512)) "$TEST_IMG"
+_img_info | _filter_generated_node_ids
+
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST REPAIR OF A DUPLICATE ENTRY NEXT TO A LEAK =="
+
+echo "== write two clusters =="
+{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_SIZE" \
+           -c "write -P 0x22 $CLUSTER_SIZE $CLUSTER_SIZE" \
+           "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== point the second BAT entry at the first cluster =="
+first=$(peek_file_le "$TEST_IMG" $BAT_OFFSET 4)
+poke_file_le "$TEST_IMG" $(($BAT_OFFSET + 4)) 4 $first
+
+echo "== leak a cluster at the end of the image =="
+file_size=`stat --printf="%s" "$TEST_IMG"`
+fallocate -xl $((file_size + CLUSTER_SIZE)) "$TEST_IMG"
+
+echo "== both are repaired in one go =="
+_check_test_img -r all
+
+echo "== and the image opens read-write afterwards =="
+{ $QEMU_IO -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST A LEAK WHICH DOES NOT FIT AN INT =="
+
+echo "== write one cluster =="
+{ $QEMU_IO -c "write -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== leave 3 GiB of unused space behind it =="
+truncate -s $((3 * 1024 * 1024 * 1024)) "$TEST_IMG"
+
+echo "== closing the image truncates it without complaining =="
+{ $QEMU_IO -c "read -P 0x11 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+file_size=`stat --printf="%s" "$TEST_IMG"`
+echo "file size: $file_size"
+
+# Clear image
+_make_test_img $SIZE
+
 echo "== TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY =="
 
 echo "== write two clusters =="
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index c6d9445440..f6806f82fa 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -302,6 +302,63 @@ qemu-img: warning: Dropping inconsistent bitmap b2c9e1a4-5d3f-4e8b-9a7c-6f0d1e2b
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST BROKEN EXTENSION OF AN IMAGE WHICH WAS NOT CLOSED ==
+== add a persistent dirty bitmap ==
+== a guest write may reuse the extension cluster, so clobber it ==
+== pretend the image was not closed correctly ==
+== the image opens, the extension is dropped ==
+qemu-io: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0xaaaaaaaaaaaaaaaa, expected: 0xab234cef23dcea87
+Repairing image was not closed correctly
+Repairing space leaked at the end of the image 1048576
+wrote 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== and it stopped pointing at the broken extension ==
+ext_off: 0
+== an older qemu leaves the same damage behind a clean close ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong IMGFMT Format Extension magic: 0xaaaaaaaaaaaaaaaa, expected: 0xab234cef23dcea87
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+== truncating the extension away is dropped as well ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Format Extension is outside the image file
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST REPAIR OF A DUPLICATE ENTRY NEXT TO A LEAK ==
+== write two clusters ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== point the second BAT entry at the first cluster ==
+== leak a cluster at the end of the image ==
+== both are repaired in one go ==
+Repairing space leaked at the end of the image 2097152
+Repairing duplicate offset in BAT entry 1
+The following inconsistencies were found and repaired:
+
+    2 leaked clusters
+    1 corruptions
+
+Double checking the fixed image now...
+No errors were found on the image.
+== and the image opens read-write afterwards ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST A LEAK WHICH DOES NOT FIT AN INT ==
+== write one cluster ==
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== leave 3 GiB of unused space behind it ==
+== closing the image truncates it without complaining ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+file size: 2097152
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
 == TEST A DUPLICATE IN THE LAST ALLOCATED BAT ENTRY ==
 == write two clusters ==
 wrote 1048576/1048576 bytes at offset 0
-- 
2.53.0


