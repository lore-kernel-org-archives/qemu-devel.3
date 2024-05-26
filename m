Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DB9C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 09:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBAce-0006KQ-6E; Sun, 26 May 2024 05:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcc-0006JR-Hl; Sun, 26 May 2024 05:56:58 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amjadsharafi10@gmail.com>)
 id 1sBAcV-0003pc-V0; Sun, 26 May 2024 05:56:58 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6f855b2499cso1675970a34.1; 
 Sun, 26 May 2024 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716717409; x=1717322209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSbMFsmslcfQACtPzQzMghuQaxr5NDYpNXTcVsfGjAU=;
 b=aWBJ/uAqPQ3Bbi9FmhUAwdQ6g5K8/2O2QpfcVCmvUhGRxrva5coQseaNRzlh9lB2WT
 pjXmaU1O1x/lGMhsJjO7qkWgET34juRgT93AwLviqFgULFNAD+BleUwIM+/F4nMaZeVv
 uWsPID9pQvnx+Z/qPqJgHsrRse1CRxxFEIpZZr2+8XLgOARZr8rWdpcag3iRCd4SQPm7
 98kPjbZmiHogTRQotwVQCDjpDHS1xXbZvqyFYn47yDdAT3TT3f9Jmon4morwj/cbSjzj
 ZuqTseSX8H9UXL1vPs7z3ScENx5Kv0HEhONMrW/2KxlUK+QJAj/eoU6Z445+axOG/+sG
 Khzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716717409; x=1717322209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSbMFsmslcfQACtPzQzMghuQaxr5NDYpNXTcVsfGjAU=;
 b=XCVeZHdC+PcZHhVkjRDpPZbyv46WHkz9Dy5gDkLzdwbXhwWGheOfR0meQDgbWHdnE6
 Y2jjcYEWLDunyuJyI+tOKiGuKp048cL/HdM2pu4ghVj0YppNItqzE7hJJOsefOGztrff
 R5aHAnW9Y8px1Y5A4UenAGFW/jm95zqdu1rzJLmvwaUgcAWhe0LwBGtom/CJkPnP2edP
 vrOQndmsQEEQsQyvRFPZEswDC1lks5whMyPnevyZmaKtjKfOqam5DAkGCvUV+dJoDncR
 FsbP+kuuCwJ7uZXmZVquD3fJW9Au8s0V9U0uFbJSMBLuaLUrlCs8cU4EiH9cooZqVAi9
 zNVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW510tut0Id2d4bOzBg6YuYdTpd6Gq60tzT/UrscrWaAGikejHDAB71pUqo/obVQtbSlN+JXArHI2tEo2o0fxXCjNMfCbA=
X-Gm-Message-State: AOJu0Ywg5D6VBpl0A3lxig0lH4qiD8KAWP3O9imtkR1DATepi18yHT06
 SZxSep1WTvnQYwklvv3la56EJRF3e8XRZItxk9JPstbUWqZfCfrVUtxHm3l+
X-Google-Smtp-Source: AGHT+IFbt8X2EKHda3ZHbJUVt2P6mPBbnXa9Uu7sY0sFEKedg8bgJO5YFPN1B6CULm46nWMSY8Xhhw==
X-Received: by 2002:a05:6830:148d:b0:6f0:e470:1915 with SMTP id
 46e09a7af769-6f8d0b22c30mr7300501a34.24.1716717409154; 
 Sun, 26 May 2024 02:56:49 -0700 (PDT)
Received: from amjad-pc.. ([192.228.203.229]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm4021368a12.46.2024.05.26.02.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 02:56:48 -0700 (PDT)
From: Amjad Alsharafi <amjadsharafi10@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>,
 Amjad Alsharafi <amjadsharafi10@gmail.com>
Subject: [PATCH v3 6/6] iotests: Add `create_file` test for `vvfat` driver
Date: Sun, 26 May 2024 17:56:06 +0800
Message-ID: <3e3e3887ddd9f95cba952fad6b5fb1040e126140.1716717181.git.amjadsharafi10@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716717181.git.amjadsharafi10@gmail.com>
References: <cover.1716717181.git.amjadsharafi10@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=amjadsharafi10@gmail.com; helo=mail-ot1-x336.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We test the ability to create new files in the filesystem, this is done by
adding an entry in the desired directory list.
The file will also be created in the host filesystem with matching filename.

Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
---
 tests/qemu-iotests/fat16.py        | 124 +++++++++++++++++++++++++++--
 tests/qemu-iotests/tests/vvfat     |  29 +++++--
 tests/qemu-iotests/tests/vvfat.out |   4 +-
 3 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/fat16.py b/tests/qemu-iotests/fat16.py
index 6ac5508d8d..e86bdd0b10 100644
--- a/tests/qemu-iotests/fat16.py
+++ b/tests/qemu-iotests/fat16.py
@@ -16,9 +16,11 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 from typing import List
+import string
 
 SECTOR_SIZE = 512
 DIRENTRY_SIZE = 32
+ALLOWED_FILE_CHARS = set("!#$%&'()-@^_`{}~" + string.digits + string.ascii_uppercase)
 
 
 class MBR:
@@ -265,7 +267,7 @@ def write_fat_entry(self, cluster: int, value: int):
             + self.fats[fat_offset + 2 :]
         )
         self.fats_dirty_sectors.add(fat_offset // SECTOR_SIZE)
-    
+
     def flush_fats(self):
         """
         Write the FATs back to the disk.
@@ -293,7 +295,7 @@ def next_cluster(self, cluster: int) -> int | None:
             raise Exception("Invalid FAT entry")
         else:
             return fat_entry
-    
+
     def next_free_cluster(self) -> int:
         """
         Find the next free cluster.
@@ -338,6 +340,67 @@ def read_directory(self, cluster: int) -> List[FatDirectoryEntry]:
             cluster = self.next_cluster(cluster)
         return entries
 
+    def add_direntry(self, cluster: int | None, name: str, ext: str, attributes: int):
+        """
+        Add a new directory entry to the given cluster.
+        If the cluster is `None`, then it will be added to the root directory.
+        """
+
+        def find_free_entry(data: bytes):
+            for i in range(0, len(data), DIRENTRY_SIZE):
+                entry = data[i : i + DIRENTRY_SIZE]
+                if entry[0] == 0 or entry[0] == 0xE5:
+                    return i
+            return None
+
+        assert len(name) <= 8, "Name must be 8 characters or less"
+        assert len(ext) <= 3, "Ext must be 3 characters or less"
+        assert attributes % 0x15 != 0x15, "Invalid attributes"
+
+        # initial dummy data
+        new_entry = FatDirectoryEntry(b"\0" * 32, 0, 0)
+        new_entry.name = name.ljust(8, " ")
+        new_entry.ext = ext.ljust(3, " ")
+        new_entry.attributes = attributes
+        new_entry.reserved = 0
+        new_entry.create_time_tenth = 0
+        new_entry.create_time = 0
+        new_entry.create_date = 0
+        new_entry.last_access_date = 0
+        new_entry.last_mod_time = 0
+        new_entry.last_mod_date = 0
+        new_entry.cluster = self.next_free_cluster()
+        new_entry.size_bytes = 0
+
+        # mark as EOF
+        self.write_fat_entry(new_entry.cluster, 0xFFFF)
+
+        if cluster is None:
+            for i in range(self.boot_sector.root_dir_size()):
+                sector_data = self.read_sectors(
+                    self.boot_sector.root_dir_start() + i, 1
+                )
+                offset = find_free_entry(sector_data)
+                if offset is not None:
+                    new_entry.sector = self.boot_sector.root_dir_start() + i
+                    new_entry.offset = offset
+                    self.update_direntry(new_entry)
+                    return new_entry
+        else:
+            while cluster is not None:
+                data = self.read_cluster(cluster)
+                offset = find_free_entry(data)
+                if offset is not None:
+                    new_entry.sector = self.boot_sector.first_sector_of_cluster(
+                        cluster
+                    ) + (offset // SECTOR_SIZE)
+                    new_entry.offset = offset % SECTOR_SIZE
+                    self.update_direntry(new_entry)
+                    return new_entry
+                cluster = self.next_cluster(cluster)
+
+        raise Exception("No free directory entries")
+
     def update_direntry(self, entry: FatDirectoryEntry):
         """
         Write the directory entry back to the disk.
@@ -406,9 +469,10 @@ def truncate_file(self, entry: FatDirectoryEntry, new_size: int):
             raise Exception(f"{entry.whole_name()} is a directory")
 
         def clusters_from_size(size: int):
-            return (size + self.boot_sector.cluster_bytes() - 1) // self.boot_sector.cluster_bytes()
+            return (
+                size + self.boot_sector.cluster_bytes() - 1
+            ) // self.boot_sector.cluster_bytes()
 
-        
         # First, allocate new FATs if we need to
         required_clusters = clusters_from_size(new_size)
         current_clusters = clusters_from_size(entry.size_bytes)
@@ -438,7 +502,7 @@ def clusters_from_size(size: int):
                 self.write_fat_entry(cluster, new_cluster)
                 self.write_fat_entry(new_cluster, 0xFFFF)
                 cluster = new_cluster
-            
+
         elif required_clusters < current_clusters:
             # Truncate the file
             cluster = entry.cluster
@@ -464,7 +528,9 @@ def clusters_from_size(size: int):
             count += 1
             affected_clusters.add(cluster)
             cluster = self.next_cluster(cluster)
-        assert count == required_clusters, f"Expected {required_clusters} clusters, got {count}"
+        assert (
+            count == required_clusters
+        ), f"Expected {required_clusters} clusters, got {count}"
 
         # update the size
         entry.size_bytes = new_size
@@ -505,3 +571,49 @@ def write_file(self, entry: FatDirectoryEntry, data: bytes):
             cluster = self.next_cluster(cluster)
 
         assert len(data) == 0, "Data was not written completely, clusters missing"
+
+    def create_file(self, path: str):
+        """
+        Create a new file at the given path.
+        """
+        assert path[0] == "/", "Path must start with /"
+
+        path = path[1:]  # remove the leading /
+
+        parts = path.split("/")
+
+        directory_cluster = None
+        directory = self.read_root_directory()
+
+        parts, filename = parts[:-1], parts[-1]
+
+        for i, part in enumerate(parts):
+            current_entry = None
+            for entry in directory:
+                if entry.whole_name() == part:
+                    current_entry = entry
+                    break
+            if current_entry is None:
+                return None
+
+            if current_entry.attributes & 0x10 == 0:
+                raise Exception(f"{current_entry.whole_name()} is not a directory")
+            else:
+                directory = self.read_directory(current_entry.cluster)
+                directory_cluster = current_entry.cluster
+
+        # add new entry to the directory
+
+        filename, ext = filename.split(".")
+
+        if len(ext) > 3:
+            raise Exception("Ext must be 3 characters or less")
+        if len(filename) > 8:
+            raise Exception("Name must be 8 characters or less")
+
+        for c in filename + ext:
+
+            if c not in ALLOWED_FILE_CHARS:
+                raise Exception("Invalid character in filename")
+
+        return self.add_direntry(directory_cluster, filename, ext, 0)
diff --git a/tests/qemu-iotests/tests/vvfat b/tests/qemu-iotests/tests/vvfat
index e0e23d1ab8..d8d802589d 100755
--- a/tests/qemu-iotests/tests/vvfat
+++ b/tests/qemu-iotests/tests/vvfat
@@ -323,7 +323,7 @@ class TestVVFatDriver(QMPTestCase):
 
         with open(os.path.join(filesystem, "file0.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
-    
+
     def test_write_large_file(self):
         """
         Test writing a large file
@@ -342,7 +342,7 @@ class TestVVFatDriver(QMPTestCase):
 
         with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
-    
+
     def test_truncate_file_change_clusters_less(self):
         """
         Test truncating a file by reducing the number of clusters
@@ -359,7 +359,6 @@ class TestVVFatDriver(QMPTestCase):
         with open(os.path.join(filesystem, "large1.txt"), "rb") as f:
             self.assertEqual(f.read(), b"A")
 
-    
     def test_write_file_change_clusters_less(self):
         """
         Test truncating a file by reducing the number of clusters
@@ -376,7 +375,7 @@ class TestVVFatDriver(QMPTestCase):
 
         with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
-    
+
     def test_write_file_change_clusters_more(self):
         """
         Test truncating a file by increasing the number of clusters
@@ -392,7 +391,27 @@ class TestVVFatDriver(QMPTestCase):
 
         with open(os.path.join(filesystem, "large2.txt"), "rb") as f:
             self.assertEqual(f.read(), new_content)
-    
+
+    def test_create_file(self):
+        """
+        Test creating a new file
+        """
+        fat16 = self.init_fat16()
+
+        new_file = fat16.create_file("/NEWFILE.TXT")
+
+        self.assertIsNotNone(new_file)
+        self.assertEqual(new_file.size_bytes, 0)
+
+        new_content = b"Hello, world! New file\n"
+        fat16.write_file(new_file, new_content)
+
+        self.assertEqual(fat16.read_file(new_file), new_content)
+
+        with open(os.path.join(filesystem, "newfile.txt"), "rb") as f:
+            self.assertEqual(f.read(), new_content)
+
+    # TODO: support deleting files
 
 
 if __name__ == "__main__":
diff --git a/tests/qemu-iotests/tests/vvfat.out b/tests/qemu-iotests/tests/vvfat.out
index fa16b5ccef..6323079e08 100755
--- a/tests/qemu-iotests/tests/vvfat.out
+++ b/tests/qemu-iotests/tests/vvfat.out
@@ -1,5 +1,5 @@
-.............
+..............
 ----------------------------------------------------------------------
-Ran 13 tests
+Ran 14 tests
 
 OK
-- 
2.45.0


