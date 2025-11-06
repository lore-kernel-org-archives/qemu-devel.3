Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C037CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 11:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGy37-000597-F0; Thu, 06 Nov 2025 06:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGy31-000582-To
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:21:01 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGy30-0002nR-3V
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 06:20:59 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3d5bb03d5c2so518762fac.1
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 03:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762428056; x=1763032856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A4Cm1X0FRT6nMV7NKszGwc7YW2PJtWPtLODjaZRG/Rs=;
 b=BlFYyWzcjiQMfmFawQfh3K34uXWXbtXzr8DfmbpsMLkUJcLEOIgEXJtBPE8Hn7bjaW
 TOAIIpBt0LKJkXS61XksTBZ5zH+ZBIrN8/Xgzp9gp0I2n0/MYrnrelP/PURUQvmS8Dwv
 Xatm0N99Q1Sr4c4uFnsSN3DJMgZh18ej95Oryv1GxlK3GDMeiKJGonzHdcottQn8eYKw
 jOlSuBZss9eeXkh/Gy/OJ1m+2hEZeZWEY18/QujdedHTx3cwwHzRm1cd09rFVwIbVIyH
 z1WEyY09AVoS9NYd7BJpais1rytot9MGMx+ggdJWnNrn8avWFxtwxSJZlWWMcI1dtWFS
 hjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762428056; x=1763032856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A4Cm1X0FRT6nMV7NKszGwc7YW2PJtWPtLODjaZRG/Rs=;
 b=BXzmlzsxPZP3Jxh2X4paw5Dm9b+MJLwhOn8t13GRlI76W9/A3zN/FZaMCClcdKWEQ2
 7AADHKInEObW/ch/h2sMeuWKagNYjCRM4PfBFhHFhnIpZ48ZWBkMaSLkb+krcxN1V6UT
 2m8AFWxX8Wiw6ujhZtgfvDETEJXOmhXJtUYnVnX3S7LUs7qwHtHiHoq6Bhf0Kt4RU3de
 oHbTO6EVskejf07+6RdENLd9HJwCBwr4FqROHu6eoOSu3D6JjJ7yNaB8JyVZLw489iqt
 8XRY2mIUpZb1VXXQwvvy1lDskFQrm9hJv2pO6QlN89KlN6CJPag+A24kBiqoG0UKzONO
 1iMA==
X-Gm-Message-State: AOJu0YwnrhKro5Tz0h3h5L45au1Mg5isWK2Vh01ZFDF6AiZXR7xqJ3L5
 2lDYcdpEj1g2h0a8YSFzR+scqeBQPqyc+RIQwnYd6jnz7YGOmDx79WNClCpjVfBqyeSUB002/ZN
 9gto7hUw=
X-Gm-Gg: ASbGnctHaR/i3olCcdFLEBtuYi6PMJVnZc+AtUR/u0z51rIKO+cLOKAaWVUhvvSjDE1
 c9/Hcvlj3bTR1bZsDWUbthLeQ8B+Gcsx4fAJgIbxfUftdiM3hhaisUiy97M+Prq5JyDeClgA84m
 by9reMtWHXTMPxSuM7YNvzOIB7ljseJyZEXCFMf2xFPDkdJQkbmVikU0F1YPDbovPJd5O/90Pz/
 Qut8SgGXJJwQTxVXyi1wkNbjUEBHNBHSLEvpDT+cUAUPH7FbYFr4GmT5QZ7/awRDb2qNjzD1oL6
 4UKz26khMcWk4SagHQty0O6dx2exap8xT7k1zam3IDB49qWxE3JIDlovWmyPVRJud9zENcO9bCj
 1rMRU+UnDjqNlRuYflfqWTSJI8nPNx/iQmCetJezsAqZpDdJwATxVjnOpQHqSc62ypUg3rRafeP
 EfuApyqYCaSrL1mDL3bIWiZcp2QwrNAw==
X-Google-Smtp-Source: AGHT+IFZetbvhg8tLiQlizod7UrTOcoGmJ/D1cxNY7x8tY2HHNsZM8vZxRFSlCXt8tLjDd77sf18Ag==
X-Received: by 2002:a05:6871:2896:b0:3d2:86bd:2ad2 with SMTP id
 586e51a60fabf-3e19c0556b9mr3491807fac.35.1762428056483; 
 Thu, 06 Nov 2025 03:20:56 -0800 (PST)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc2:7873:e847:e589:d030:667d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e30a439b97sm932716fac.16.2025.11.06.03.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 03:20:56 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/2] scripts: RISC-V python script to check isa_edata_arr[]
Date: Thu,  6 Nov 2025 08:20:44 -0300
Message-ID: <20251106112044.162617-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106112044.162617-1-dbarboza@ventanamicro.com>
References: <20251106112044.162617-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x32.google.com
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

Keeping isa_edata_arr[] from target/riscv/cpu.c in order is not a fun
time. The RISC-V specification rules are very convoluted (Z extensions
first, then if it's a Z extension then there's the IMAFD subcategory
S and X exts are always alphabetical ...), very hard to follow during
the patch review process, and in the end this array keeps getting
out of order constantly during development.

This script aims to ease the suffering of reviewers by reading the
array from target/riscv/cpu.c and pointing ordering errors that
were introduced in the file:

$ ./script/riscv-isaedata-check.py
Wrong ordering: ssstateen must succeed ssctr

A successful run will give no output and retval 0.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 scripts/riscv-isaedata-check.py | 164 ++++++++++++++++++++++++++++++++
 target/riscv/cpu.c              |   3 +
 2 files changed, 167 insertions(+)
 create mode 100755 scripts/riscv-isaedata-check.py

diff --git a/scripts/riscv-isaedata-check.py b/scripts/riscv-isaedata-check.py
new file mode 100755
index 0000000000..a276dc952f
--- /dev/null
+++ b/scripts/riscv-isaedata-check.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+# Copyright (c) 2025 Ventana Micro Systems Inc.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+#
+# Check if isa_edata_arr[] from target/riscv/cpu.c is
+# ordered according to the RISC-V specification.
+#
+
+import os
+
+"""
+This script aims to check the ordering of isa_edata_arr[] array
+from target/riscv/cpu.c.
+
+The RISC-V riscv,isa ordering has a lot of rules (see the comment
+right before isa_edata_arr[] in target/riscv/cpu.c) and we're not
+able to keep up with it during the review process. In the end
+every new extension added has a good chance of breaking it.
+
+The idea with this script is to try to catch these errors earlier
+by directly reading isa_edata_arr[] and pointing out discrepancies
+found. E.g.:
+
+$ python3 riscv-isaedata-check.py
+Wrong ordering: sspm must succeed ssctr
+
+This indicates that 'ssctr' must be put earlier that sspm in the
+array.
+
+A successful run of this script has a retval = 0 and no output.
+"""
+
+def ext_is_sorted(ext1: str, ext2: str) -> bool:
+    """Check if the RISC-V ISA extension 'ext1' comes after
+       the RISC-V ISA extension 'ext2' using the RISC-V sorting
+       rules. We're summing up these rules in 3 steps when
+       comparing isa_edata extensions:
+
+        1. If both extensions does not start with 'z', they're
+           sorted with regular alphabetical order;
+
+        2. A 'z' extension always precedes a non 'z' extension;
+
+        3. If both extensions starts with 'z', check the second
+           letter of both:
+             - if they're the same, sort it in alphabetical order;
+             - otherwise, sort it via the Z extension category
+               (IMAFDQLCBKJTPVH).
+
+       Args:
+            ext1 (str): lower-case RISC-V isa extension name
+            ext2 (str): lower-case RISC-V isa extension name
+
+       Returns:
+            bool: True ext1 precedes ext2, False otherwise.
+    """
+    z_order = ['i','m','a','f','d','q', 'l', 'c', 'b',
+               'k', 'j', 't', 'p', 'v', 'h']
+    order1 = len(z_order)
+    order2 = len(z_order)
+
+    if ext1[0] != 'z' and ext2[0] != 'z':
+        return ext1 < ext2
+
+    if ext1[0] == 'z' and ext2[0] != 'z':
+        return True
+
+    if ext1[0] != 'z' and ext2[0] == 'z':
+        return False
+
+    # At this point we know both starts with 'z'. If
+    # they're both the same z_order use alphabetical
+    # order.
+    if ext1[1] == ext2[1]:
+        return ext1 < ext2
+
+    # Get the order within the z category for each
+    for i in range(len(z_order)):
+        if ext1[1] == z_order[i]:
+            order1 = i;
+        if ext2[1] == z_order[i]:
+            order2 = i;
+        if order1 != len(z_order) and order2 != len(z_order):
+            break
+
+    if order1 < order2:
+        return True
+
+    return False
+# end ext_is_sorted
+
+
+def get_extension_name(line: str) -> str:
+    """Given a 'line' str in the format
+
+       ISA_EXT_DATA_ENTRY(ext_name, ...)
+
+       Return 'ext_name' if successful or None otherwise.
+    """
+    match_str = "ISA_EXT_DATA_ENTRY("
+    match_idx = line.rfind(match_str)
+
+    if match_idx < 0:
+        return None
+
+    last_idx = line.find(",")
+    if last_idx < 0:
+        return None
+
+    match_idx += len(match_str)
+
+    return line[match_idx:last_idx]
+#end get_extension_name
+
+
+def main():
+    dir_path = os.path.dirname(os.path.realpath(__file__))
+    filename = dir_path + "/../target/riscv/cpu.c"
+
+    try:
+        with open(filename, 'r') as file:
+            isaEdataFound = False
+            ext1 = None
+            ext2 = None
+
+            for line in file:
+                if "const RISCVIsaExtData isa_edata_arr[]" in line:
+                    isaEdataFound = True
+                    continue
+
+                if not isaEdataFound:
+                    continue
+
+                if "{ }" in line:
+                    break
+
+                tmp = get_extension_name(line)
+
+                if tmp is None:
+                    continue
+
+                if ext1 is None:
+                    ext1 = tmp
+                    continue
+
+                if ext2 is None:
+                    ext2 = tmp
+                else:
+                    ext1 = ext2
+                    ext2 = tmp
+
+                if not ext_is_sorted(ext1, ext2):
+                    print(f"Wrong ordering: {ext1} must succeed {ext2}")
+                    exit(1)
+    except FileNotFoundError:
+        print(f"Error: The file '{filename}' was not found.")
+    except Exception as e:
+        print(f"An error occurred: {e}")
+# end main
+
+
+if __name__ == '__main__':
+    main()
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 79fda08f9d..93c02bab27 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -102,6 +102,9 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
  *
  * Single letter extensions are checked in riscv_cpu_validate_misa_priv()
  * instead.
+ *
+ * **NOTE**: please run ./scripts/riscv-isaedata-check.py every time a
+ * new entry is added in this array.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
-- 
2.51.1


