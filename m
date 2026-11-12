Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C36606A32E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a/7mTHoj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX50-0007K5-UX; Thu, 12 Nov 2026 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xRWp1-0007bJ-UC
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:34:44 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcfaracco@gmail.com>)
 id 1xRWoy-0004Zr-8m
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 10:34:43 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-67be1e468a8so3651045d50.0
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794497679; x=1795102479; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zANwaYKdGSgNJt295Sr9bJFo22t9rxZ3P/MbCD+xx1w=;
 b=a/7mTHojffLkSlkgtCDkVZMyWNR1AB24SsedVoEht6Lwn1d3uMgEQdnU1BMuFvg5vu
 Olv5ZMy/aXKBNFwH4TjFWvgV71i6BlBOjndvrX6Z+L40E4lDtKVVu79KfOUS7Su36m6l
 kBiIb54mUZlTtTPom+ytqjjrZQPlUp3dRWdcJ37m1sqmxlH+8ZD3eO1BEznrV31C/ZGJ
 36wHEl5RDGK9o8e2n6xsr/6AsEu///z8HozEmuSPNO/7Z3B8MN3g/YI0Y91rYv6d8wpv
 EspQdVjWTMzErk7/3F2OI9awt546HlwfkBKgCfQmYY+OExvGV9hI2QfK/lNGZgNHr5g4
 mCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794497679; x=1795102479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zANwaYKdGSgNJt295Sr9bJFo22t9rxZ3P/MbCD+xx1w=;
 b=N4Kvn5SFeQaAhQpmTackU08LoGLdk8wMzjTM6Gpi3aW+6BRxx0yVM/tLC0A4xUQpx+
 daw6t/R3e/67Ga19UzmVmY4rkwdVDvt2DMJFXDqIsQ/Yq4MYrim/zQAWMfBbHBtPszpl
 /DdMbEuRW84o+3yuTr/pKPzGv1B6/Lqa8roS873gzuy0aRb8+136Mlly5ILXcXEAKz1J
 dScnUz/168ba3JEs84QZRJTZ5vooti2qoVVgag/WkuAk70CrnTTtnSs0roTXy2TBCmHS
 5gX6TJ6OiXROXa5qYqCK0KVpOk6evnQeIsCuBMvKaqZA2ndBcEP+c5275xDn0YLx5KjY
 vTsQ==
X-Gm-Message-State: APuU4Z9sXpGt23mddutB3yXxAwy/pg659M8VCgesdrSoWjPrwYySkG50
 4XCEfvf01kRNEvZmjhHqcPgHbLZBsFhuU9y9XIEw1JwFx+7Ripbdevju
X-Gm-Gg: AYBFou0RX+FPCxjcArJMnUW9Z/ZQel8cDCvYwHxr+JDjSdlcGI0LzefHAhi6x6y/9x9
 uYfIJdTwscUty+ZPD53sngV8bwywqlGoBUwazZ5fW9WKgwy2y30xDTXLcjkEFBkkTmV7/bmKYTp
 DU4x6BUSX4qlUfq10BkM2yBPrzstkYaHM/YANoLW2lQqr7alkHUY7niTG5IUEXS6H4/KEgGvVzf
 5Z2z6UbOcWJVCFeKEWBXxSgBPeUXwo+I44D8HI5tdqyXJ6NWuc3lcWkpoCOuolx6nbl3z3FtfRd
 tM9MT+YhyeXw4bE4QGsl7QrpsUtJ8TQhhXzO5+Z3XqtHEGNBLQc3+RoWX63q1fi5IWzwxC0ytqD
 5F3WqN/wH+UbBRKMY1QGd6cQTHXo1D174CEA3B5ceogQydfwQzNCSSkVynEmtKOr4aPFLuR6yCw
 9irCCNdn0zOocJ/iVY88RdVOqyCL3cfXFZErPEWP9ydAlY1YT62rhpu+Fr64TY26pI59xcy9AC1
 vUy3f9XdotUcJyY8EmN9dcd2UK3/LXK0jKbZS51Qtl8MXNXFjswMDzien/8fj+FbAJ6WRtxu3Ib
 pi23+c6uwIVH+X7NLg==
X-Received: by 2002:a05:690e:4509:10b0:67c:2752:e53c with SMTP id
 956f58d0204a3-67c67f6e4dcmr2990787d50.39.1794497678723; 
 Thu, 12 Nov 2026 07:34:38 -0800 (PST)
Received: from [192.168.0.195] ([2804:14c:3b83:954b::221c])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c58a09074sm7656618d50.18.2026.11.12.07.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:34:38 -0800 (PST)
From: Julio Faracco <jcfaracco@gmail.com>
Date: Thu, 12 Nov 2026 12:33:57 -0300
Subject: [PATCH 2/2] tests/qemu-iotests: cover the dmg LZFSE short-decode fix
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-dmg-short-decode-v1-2-f7f342097b60@gmail.com>
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
In-Reply-To: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 Julio Faracco <jcfaracco@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794497667; l=7218;
 i=jcfaracco@gmail.com; s=20261112; h=from:subject:message-id;
 bh=k/K8U+Tz7gp/lpKwrEoUljN2D+g0N1+lMDxrD+/1uL8=;
 b=Tc7MuC0TcvHXSSqqMw1O/C+u4Kwb61KKSiFXarm41Be1bvPzRJ7WNLNAOpMLeevrIyM2QeRE8
 3ovqfuStJ8/AynDtCXkHj2GkqaWl7PPFa3KamPWfgPilSvvwp1BaOuw
X-Developer-Key: i=jcfaracco@gmail.com; a=ed25519;
 pk=hAqVCeSg6RtgTRedcz7HIqiICyRcEDanumwIF9bNBHg=
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=jcfaracco@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:10 -0500
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

Add a regression test for the LZFSE short-decode heap disclosure. It
builds a minimal DMG (koly trailer, plist, BLKX block, LZFSE data fork)
whose chunk declares two sectors of output while its LZFSE stream only
decodes to one, and checks that reading the chunk now fails with an I/O
error instead of leaking stale heap bytes.

A valid single-sector DMG is converted first; if that fails, the test
is skipped as LZFSE support is not built in.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 tests/qemu-iotests/tests/dmg-lzfse-short     | 142 +++++++++++++++++++++++++++
 tests/qemu-iotests/tests/dmg-lzfse-short.out |   2 +
 2 files changed, 144 insertions(+)

diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short b/tests/qemu-iotests/tests/dmg-lzfse-short
new file mode 100755
index 0000000000..fc0b69cee3
--- /dev/null
+++ b/tests/qemu-iotests/tests/dmg-lzfse-short
@@ -0,0 +1,142 @@
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
+import sys
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
+    decodes to, the decode is short.
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
+    struct.pack_into('>Q', entry, 0x08, 0)               # sector number
+    struct.pack_into('>Q', entry, 0x10, decl_sectors)    # sector count
+    struct.pack_into('>Q', entry, 0x18, 0)               # compressed offset
+    struct.pack_into('>Q', entry, 0x20, len(data_fork))  # compressed length
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
+    struct.pack_into('>I', koly, 0x004, 4)               # version
+    struct.pack_into('>I', koly, 0x008, 512)             # header size
+    struct.pack_into('>Q', koly, 0x018, 0)               # DataForkOffset
+    struct.pack_into('>Q', koly, 0x020, len(data_fork))  # DataForkLength
+    struct.pack_into('>Q', koly, 0x028, 0)               # RsrcForkOffset
+    struct.pack_into('>Q', koly, 0x030, 0)               # RsrcForkLength
+    struct.pack_into('>Q', koly, 0x0d8, xml_off)         # XMLOffset
+    struct.pack_into('>Q', koly, 0x0e0, len(xml))        # XMLLength
+    struct.pack_into('>q', koly, 0x1ec, total_sectors)   # SectorCount
+    buf += koly
+
+    assert koly_off == len(buf) - 512
+    return bytes(buf)
+
+
+def convert_to_raw(dmg: bytes, name: str):
+    dmg_path = os.path.join(iotests.test_dir, name)
+    raw_path = dmg_path + '.raw'
+    with open(dmg_path, 'wb') as f:
+        f.write(dmg)
+    res = iotests.qemu_img('convert', '-f', 'dmg', '-O', 'raw',
+                           dmg_path, raw_path, check=False)
+    return res, dmg_path, raw_path
+
+
+def main() -> None:
+    payload = b'\xab' * SECTOR
+
+    # A well-formed single-sector chunk must convert cleanly.  Skip only
+    # when QEMU was built without the LZFSE module (so this would never
+    # work); treat any other failure as a real regression.
+    good = build_dmg(lzfse_uncompressed_stream(payload),
+                     decl_sectors=1, total_sectors=1)
+    res, _, raw_path = convert_to_raw(good, 'good.dmg')
+    if res.returncode != 0:
+        if 'dmg-lzfse module is missing' in res.stdout:
+            iotests.notrun('LZFSE decompression not available')
+        iotests.log('FAIL: valid LZFSE chunk failed to convert')
+        iotests.log(res.stdout)
+        sys.exit(1)
+
+    with open(raw_path, 'rb') as f:
+        if f.read() != payload:
+            iotests.log('FAIL: valid LZFSE chunk decoded incorrectly')
+            return
+    iotests.log('valid LZFSE chunk converts: ok')
+
+    # Same 512-byte stream, but the chunk claims two sectors (1024 bytes).
+    # The decode is short and must be rejected with an I/O error.
+    evil = build_dmg(lzfse_uncompressed_stream(payload),
+                     decl_sectors=2, total_sectors=2)
+    res, _, _ = convert_to_raw(evil, 'evil.dmg')
+    if res.returncode == 0:
+        iotests.log('FAIL: short LZFSE decode was accepted')
+        return
+    iotests.log('short LZFSE decode rejected: ok')
+
+
+iotests.script_main(main, supported_fmts=['dmg'],
+                    supported_protocols=['file'],
+                    supported_platforms=['linux'])
diff --git a/tests/qemu-iotests/tests/dmg-lzfse-short.out b/tests/qemu-iotests/tests/dmg-lzfse-short.out
new file mode 100644
index 0000000000..6802cf1a76
--- /dev/null
+++ b/tests/qemu-iotests/tests/dmg-lzfse-short.out
@@ -0,0 +1,2 @@
+valid LZFSE chunk converts: ok
+short LZFSE decode rejected: ok

-- 
2.56.0


