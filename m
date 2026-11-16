Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E97606A32F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=kwkCUsKv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3F4-0006wi-0E; Mon, 16 Nov 2026 15:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3F0-0006tW-BV; Mon, 16 Nov 2026 15:23:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ey-0004J3-06; Mon, 16 Nov 2026 15:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860377; bh=ayC99CeWUdnYoLhS2o8UvAsdFLLwzdssg/YOmtA1/0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kwkCUsKvuTBbd48hZLu8N+c+tdDua8pMmBw9YjoGHr2jR8gO0k/mXKznIX3ATw7yv
 Ku6oDWK7mlopnxqnL6F2VLcIr5fSZlbMESpT6zA8Pp6LPLIjXhZyQOUIYOWeXhQ3hU
 dv/wDqPPK1WEGBXnL+vFbT4f/WVEIwoonqSb/ozWevxQrwpYQ0vhbIS1jNzi+8UY02
 Mb+tdxj98tcwbIvY/kdvcSy1NGxiM1U7YOuAoW5moNVhdMCCMgn3//nNOWyJN0G7DP
 Xu/CqLSqTWhjn2MeT4gPvrWly7LDzzK6ngnZlPQLg8DzCn0lwpHjta0R2BYcOZffq5
 GC/oO54ZvJuTg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C7AA1E716A;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 99D4545FB9F;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 87E2FB8E2E; Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 48/59] iotests: Filter out ZFS in several tests
Date: Mon, 16 Nov 2026 23:18:52 +0300
Message-ID: <20261116201922.534306-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Blake <eblake@redhat.com>

Fiona reported that ZFS makes sparse file testing awkward, since:
- it has asynchronous allocation (not even 'fsync $file' makes du see
  the desired size; it takes the slower 'fsync -f $file' which is not
  appropriate for the tests)
- for tests of fully allocated files, ZFS with compression enabled
  still reports smaller disk usage

Add a new _require_disk_usage that quickly probes whether an attempt
to create a sparse 5M file shows as less than 1M usage, while the same
file with -o preallocation=full shows as more than 4M usage without
sync, which should filter out ZFS behavior.  Then use it in various
affected tests.

This does not add the new filter on all tests that Fiona is seeing ZFS
failures on, but only those where I could quickly spot that there is
at least one place where the test depends on the output of 'du -b' or
'stat -c %b'.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250523163041.2548675-8-eblake@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
(cherry picked from commit c49dda7254d43d9e1d4da59c55f02055ba7c4c1b)
(Mjt: pick this one up for _require_disk_usage function which will be used next)
(Mjt: drop changes to tests/qemu-iotests/tests/mirror-sparse which is not in 10.0.x)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index ae0fc466910..55548439aad 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto file fuse
 _supported_os Linux
+_require_disk_usage
 
 # in kB
 CREATION_SIZE=128
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index f74f053b719..bbbf550a5af 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -77,6 +77,7 @@ _supported_os Linux
 
 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_disk_usage
 
 size=$((1 * 1024 * 1024))
 
diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index c463fd4b113..eba00b80adb 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -41,6 +41,7 @@ _supported_os Linux
 
 _default_cache_mode writeback
 _supported_cache_modes writeback writethrough unsafe
+_require_disk_usage
 
 echo
 echo "=== Check mapping of unaligned raw image ==="
diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
index 35039d20a89..6da85e6a113 100755
--- a/tests/qemu-iotests/253
+++ b/tests/qemu-iotests/253
@@ -41,6 +41,7 @@ _supported_os Linux
 
 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_disk_usage
 
 echo
 echo "=== Check mapping of unaligned raw image ==="
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index ea81dc496a0..88aa2491301 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -51,6 +51,7 @@ _unsupported_fmt vpc
 
 _supported_proto file # We create the FUSE export manually
 _supported_os Linux # We need /dev/urandom
+_require_disk_usage
 
 # $1: Export ID
 # $2: Options (beyond the node-name and ID)
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 237f746af88..e977cb4eb61 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -996,6 +996,36 @@ _require_large_file()
     rm "$FILENAME"
 }
 
+# Check whether disk_usage can be reliably used.
+_require_disk_usage()
+{
+    local unusable=false
+    # ZFS triggers known failures on this front; it does not immediately
+    # allocate files, and then aggressively compresses writes even when full
+    # allocation was requested.
+    if [ -z "$TEST_IMG_FILE" ]; then
+        FILENAME="$TEST_IMG"
+    else
+        FILENAME="$TEST_IMG_FILE"
+    fi
+    if [ -e "FILENAME" ]; then
+        echo "unwilling to overwrite existing file"
+        exit 1
+    fi
+    $QEMU_IMG create -f raw "$FILENAME" 5M > /dev/null
+    if [ $(disk_usage "$FILENAME") -gt $((1024*1024)) ]; then
+        unusable=true
+    fi
+    $QEMU_IMG create -f raw -o preallocation=full "$FILENAME" 5M > /dev/null
+    if [ $(disk_usage "$FILENAME") -lt $((4*1024*1024)) ]; then
+        unusable=true
+    fi
+    rm -f "$FILENAME"
+    if $unusable; then
+        _notrun "file system on $TEST_DIR does not handle sparse files nicely"
+    fi
+}
+
 # Check that a set of devices is available in the QEMU binary
 #
 _require_devices()
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap b/tests/qemu-iotests/tests/write-zeroes-unmap
index 7cfeeaf8391..f90fb8e8d27 100755
--- a/tests/qemu-iotests/tests/write-zeroes-unmap
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap
@@ -32,6 +32,7 @@ cd ..
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
+_require_disk_usage
 
 create_test_image() {
     _make_test_img -f $IMGFMT 1m
-- 
2.47.3


