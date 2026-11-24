Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D870606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 02:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rg2ID7TD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVgPv-0002Ku-GV; Mon, 23 Nov 2026 21:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVgPj-0002Jj-RW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:37:47 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xVgPh-0001vX-Ij
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 21:37:47 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-97ccbba8e86so961960241.3
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795487863; x=1796092663; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V9bDPwxcW2pVTL6smRTCsWfybXvx6ay6VC/mxwjBTfo=;
 b=Rg2ID7TDgAeNvvzlRlbJQ2hLq2gzNFWpvdk9UCBgAYi054t3/lOgnaUyRN2jBermX0
 iwLID5AyKnHPO+ujz1VsYN5PleShZAFNEAqpP3ufkLonoYU7dHkhaYEfIhB5yNq4iIxC
 dCRf9adpw7v4uFybgHchMnJnqfxSgXuIFrB+itgf1VfrOYtnYVLeOQLZ1ImjVmk42nhg
 Och3mSo0yJyziJJgGnV4wYbSKqBEs5vl/fZamEEx2NmEBAEYU+AZ4fU/VLj2QXoshzyD
 XyAmkldaaPcoW9QOzcmcOS2h/x0134iOs1fyiTt+jeqD6hl5yaHQ++RD21O3f5isMcFP
 N5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795487863; x=1796092663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V9bDPwxcW2pVTL6smRTCsWfybXvx6ay6VC/mxwjBTfo=;
 b=Cx51wnegbtyeyvAi6L4gQIlrvVgLjaXq8pxSeRTGFo418WhJY40cI+PlWQb0q59Jy+
 sm9j4SK18QvwuOBppnfD3mux+606Gh8P80RGPr/GD2GpHqnq6ab9UhoeWkomqJ7Ybeja
 MjUeSVN8GOjKmPU8Lk/b1fnWV0yV6I7YEJ2MxC7TGdXIXBBCgXoXQInO0qJuBlCSU8xx
 xanmdlhRnDvALBtTbm0+DWVjzZ0Y4ZiMEpZoyEsLdSdku0zpaVVyLAsYZ4j5yYdglZkS
 jkFTnwaw4qdilQzW7FQaJbvtKIE5/Zh0tA+M8BYM7HnAjbcPlCCNXsm1kw2KQSsRL/Dy
 rFqQ==
X-Gm-Message-State: APuU4Z9ESm2N1bOS4wNSKJAPljbDuXvpqIzmO76rdlskAyPmgUx/J1Ye
 REp1Meqi1dpvnI1cUc2OLoQVXGPWnMZdM4LwiWurXo8zBVEJUYFtTJpt
X-Gm-Gg: AZFdTZcHe1qlfCIDlp/4ygKG60C50AAbL3klMUI+RIPAU9K4YeyPXKedXjK69hBW9T5
 rcEXl7Y32SnorUNA584aP39RxeN50K1oRG3CGQiKeLhIQIsR7u5Ga3f1TTkhY5JFggIZj93hz5/
 CrUyZ15hx6lsmku09QnbrIOy4Uo3OBmVka7qDNIN9Okv+v0g+oOvndTCUBLfVQMYzChBOE2JIL9
 NMbdIcjJPulQiPwwHwI4Dk1yNaodjEV4kztmTpPVe7vL7J8yjSQYnFNmp0aCtXoyo8DTM/ClIbA
 SQohdNaUeBx/yJhWnmCXJ+0pjqfR/v47Ra2obJBPKbx/D9rvEYPntB5yW7/Sm8E83QnwAJVYDAN
 RPPNzxyEakYyIN7pfKKPszSp66qJNST1tceUZtcTqWGz+yqe38ayCbgmSBSVhK0AsSGkRVHy3Ex
 FYKTtjgGHEhiu2vUnBTfKDdv156ObOoboSePO1gXxpYx6Zw1/RAj3+z9/9Tv6nouWK0gIhTVMUl
 pjLRnzYFm9WLCZv4t1hdTWKVCjv1G0ydUxi2tCYpP1VcTnBDXJJl4QJZxDyx1Ggtrp7bt3Xlbgp
 64s7j6t9mqmNVUz3HQ==
X-Received: by 2002:a05:6102:504b:b0:7ce:5952:125d with SMTP id
 ada2fe7eead31-7d7396cc165mr5651326137.36.1795487863339; 
 Mon, 23 Nov 2026 18:37:43 -0800 (PST)
Received: from [192.168.0.131] ([2804:14c:3b83:954b::e84d])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6e05ac5asm13618504241.9.2026.11.23.18.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 18:37:42 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
Date: Mon, 23 Nov 2026 23:37:09 -0300
Subject: [PATCH v2 2/2] tests/qemu-iotests: cover the dmg LZFSE
 truncated-decode fix
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dmg-short-decode-v2-v2-2-e1dee5893891@gmail.com>
References: <20261123-dmg-short-decode-v2-v2-0-e1dee5893891@gmail.com>
In-Reply-To: <20261123-dmg-short-decode-v2-v2-0-e1dee5893891@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Julio Faracco <jcfaracco@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795487852; l=7438;
 i=jcfaracco@gmail.com; s=20261112; h=from:subject:message-id;
 bh=PNSpGV3Ya9PdtaRwSSkOqFhdp0VUW1gzuqiW0vh27BY=;
 b=GqvfuWhZYovaTzrsdEKJzNtVxBvtLVx3Vs+IyAT9nMHAaGR07MF6w+lbDdZJapDShnW7+31BQ
 vUWrfaCIDajAJsCpt+psLwKgjfXRue/ZCZDWiDHLI0kdhbcriDt30HL
X-Developer-Key: i=jcfaracco@gmail.com; a=ed25519;
 pk=hAqVCeSg6RtgTRedcz7HIqiICyRcEDanumwIF9bNBHg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=jcfaracco@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a regression test for the LZFSE truncated-decode heap disclosure.
It builds a minimal DMG (koly trailer, plist, BLKX block, LZFSE data
fork) whose chunk declares two sectors of output while its LZFSE stream
only decodes to one, and checks that reading the chunk now fails with an
Input/output error instead of leaking stale heap bytes.

A valid single-sector DMG is verified first with qemu-io; if the
'dmg-lzfse module is missing' error occurs, the test is skipped. Any
other failure is treated as a regression.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 tests/qemu-iotests/tests/dmg-lzfse-short     | 141 +++++++++++++++++++++++++++
 tests/qemu-iotests/tests/dmg-lzfse-short.out |   2 +
 2 files changed, 143 insertions(+)

diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short b/tests/qemu-iotests/tests/dmg-lzfse-short
new file mode 100755
index 0000000000..c057ebb05a
--- /dev/null
+++ b/tests/qemu-iotests/tests/dmg-lzfse-short
@@ -0,0 +1,141 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Regression test for the dmg LZFSE short-decode heap disclosure.
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# A crafted DMG can declare a chunk output size larger than its LZFSE
+# stream actually produces.  dmg_uncompress_lzfse_do() used to accept
+# such a short decode and hand the untouched tail of the (unzeroed)
+# uncompressed chunk buffer to the guest -- a heap disclosure.  Reading
+# such a chunk must now fail with an I/O error instead.
+
+import base64
+import os
+import struct
+
+import iotests
+
+ULFO = 0x80000007  # LZFSE compressed block type
+SECTOR = 512
+
+
+def lzfse_uncompressed_stream(payload: bytes) -> bytes:
+    """A valid LZFSE stream: one uncompressed block + end-of-stream marker."""
+    return (b'bvx-' + struct.pack('<I', len(payload))  # uncompressed block
+            + payload
+            + b'bvx$')                                   # end of stream
+
+
+def build_dmg(stream: bytes, decl_sectors: int, total_sectors: int) -> bytes:
+    """
+    Build a minimal DMG with a single LZFSE chunk.  The chunk declares
+    decl_sectors sectors of output; when that exceeds what 'stream'
+    decodes to, the decoded output is truncated.
+    """
+    data_fork = stream
+
+    # BLKX ("mish") block: 204-byte header followed by one 40-byte entry.
+    mish = bytearray(204)
+    struct.pack_into('>I', mish, 0x00, 0x6d697368)        # 'mish' magic
+    struct.pack_into('>I', mish, 0x04, 1)                 # version
+    struct.pack_into('>Q', mish, 0x08, 0)                 # first sector number
+    struct.pack_into('>Q', mish, 0x10, total_sectors)     # sector count
+    struct.pack_into('>Q', mish, 0x18, 0)                 # data fork offset
+
+    entry = bytearray(40)
+    struct.pack_into('>I', entry, 0x00, ULFO)             # entry type
+    struct.pack_into('>Q', entry, 0x08, 0)                # sector number
+    struct.pack_into('>Q', entry, 0x10, decl_sectors)     # sector count
+    struct.pack_into('>Q', entry, 0x18, 0)                # compressed offset
+    struct.pack_into('>Q', entry, 0x20, len(data_fork))   # compressed length
+    mish += entry
+
+    xml = (b'<plist><dict><data>'
+           + base64.b64encode(bytes(mish))
+           + b'</data></dict></plist>')
+
+    buf = bytearray()
+    buf += data_fork
+    xml_off = len(buf)
+    buf += xml
+    koly_off = len(buf)
+
+    # UDIF trailer ("koly" block), 512 bytes, big-endian.
+    koly = bytearray(512)
+    struct.pack_into('>4s', koly, 0x000, b'koly')         # signature
+    struct.pack_into('>I',  koly, 0x004, 4)               # version
+    struct.pack_into('>I',  koly, 0x008, 512)             # header size
+    struct.pack_into('>Q',  koly, 0x018, 0)               # DataForkOffset
+    struct.pack_into('>Q',  koly, 0x020, len(data_fork))  # DataForkLength
+    struct.pack_into('>Q',  koly, 0x028, 0)               # RsrcForkOffset
+    struct.pack_into('>Q',  koly, 0x030, 0)               # RsrcForkLength
+    struct.pack_into('>Q',  koly, 0x0d8, xml_off)         # XMLOffset
+    struct.pack_into('>Q',  koly, 0x0e0, len(xml))        # XMLLength
+    struct.pack_into('>q',  koly, 0x1ec, total_sectors)   # SectorCount
+    buf += koly
+
+    assert koly_off == len(buf) - 512
+    return bytes(buf)
+
+
+def main() -> None:
+    payload = b'\xab' * SECTOR
+
+    with iotests.FilePath('good.dmg') as good_path, \
+         iotests.FilePath('evil.dmg') as evil_path:
+
+        # A well-formed single-sector chunk must be readable.  Skip only
+        # when QEMU was built without the LZFSE module; treat any other
+        # failure as a real regression.
+        good = build_dmg(lzfse_uncompressed_stream(payload),
+                         decl_sectors=1, total_sectors=1)
+        with open(good_path, 'wb') as f:
+            f.write(good)
+
+        res = iotests.qemu_io('-f', 'dmg', '-r', '-c', 'read -P 0xab 0 512',
+                              good_path, check=False)
+        if res.returncode != 0:
+            if 'dmg-lzfse module is missing' in res.stdout:
+                iotests.notrun('LZFSE decompression not available')
+            iotests.log('FAIL: valid LZFSE chunk failed to read')
+            iotests.log(res.stdout)
+            return
+        iotests.log('valid LZFSE chunk reads: ok')
+
+        # Same 512-byte stream, but the chunk claims two sectors (1024 bytes).
+        # The decoded output is truncated and must be rejected with an I/O error.
+        evil = build_dmg(lzfse_uncompressed_stream(payload),
+                         decl_sectors=2, total_sectors=2)
+        with open(evil_path, 'wb') as f:
+            f.write(evil)
+
+        res = iotests.qemu_io('-f', 'dmg', '-r', '-c', 'read 0 1024',
+                              evil_path, check=False)
+        if res.returncode == 0:
+            iotests.log('FAIL: truncated LZFSE decode was accepted')
+            return
+        if 'Input/output error' not in res.stdout:
+            iotests.log('FAIL: unexpected error reading truncated LZFSE chunk')
+            iotests.log(res.stdout)
+            return
+        iotests.log('truncated LZFSE decode rejected: ok')
+
+
+iotests.script_main(main, supported_fmts=['dmg'],
+                    supported_protocols=['file'],
+                    supported_platforms=['linux'])
diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short.out b/tests/qemu-iotests/tests/dmg-lzfse-short.out
new file mode 100644
index 0000000000..03014a6d28
--- /dev/null
+++ b/tests/qemu-iotests/tests/dmg-lzfse-short.out
@@ -0,0 +1,2 @@
+valid LZFSE chunk reads: ok
+truncated LZFSE decode rejected: ok

-- 
2.56.1


