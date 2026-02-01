Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C90E7C6F9
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 01:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmLwl-0002yv-KJ; Sat, 31 Jan 2026 20:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vmLwh-0002yi-EK
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 20:08:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vmLwe-000073-Oi
 for qemu-devel@nongnu.org; Sat, 31 Jan 2026 20:08:10 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4359a16a400so2866638f8f.1
 for <qemu-devel@nongnu.org>; Sat, 31 Jan 2026 17:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769908085; x=1770512885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=MXvBNH349CruVNx0ankHtqUQYjA5qOdQSjNldxNhDmo=;
 b=lXggBoftBXCzwctio6oqvkPAbKPh36U7CI2jqlARSHblAm17ts9+JfHjUrEMmgTp3d
 Cs22RBnWMo17RwDDRgWG+ISa2Eow8Oxh19yoQnJDkw6keXkWAM9IxUbopRz1vwD8TxfD
 LltYAbfQ5s/QWsyPKC5zw1XxbxHy91rCTXBLySpWvGTh+fhC9id+gmRwQFcl3FBwCQZg
 Aq4EbC7mbqI7xV4oVMThwuvAbeQLPIlh6dENfdHqjlQJweFED1RDrYMHgWBf0mR0Ph8i
 rl4lG1TXdC5IhxiFF42ACUkQBbELjPHrtU3cuuFawmIqvGnvabFFZnieJOHPIAsbXq07
 1Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769908085; x=1770512885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MXvBNH349CruVNx0ankHtqUQYjA5qOdQSjNldxNhDmo=;
 b=CHgdxMqqqR/KqHSOqxt61PIVtOp75MvaGwGvgZqxp6pQW6WB4slQzOo/OUFxzvD7/M
 k+6aeobobvUbBrz8TJkJJPVqIZm0BJp5Ube+00xQ/ePLycJBaIQKxABbByouFVb90DTc
 VqWdoAhF2Zas1jERGbG83j3/jCAZigST5xMDmUYFQ2Ywi1/uicAJPw1SyQ29C3SlYJZr
 +nUyQufigkYpQZt6Mm8YFSRXPU16PheKcnTQXq64btteUOpNmwIL9MG6cH1qCmFBRYmP
 E9gsIbobAUvp85C4ao2jMSX0ne7v8NejxSzJE3qznNmhU+49cZ00EoSkxWCXwpfuQsZP
 k+pA==
X-Gm-Message-State: AOJu0YzIdMK+MqJZFPRjJ369nKqEbDe7/4w0XPi4C4NBWlIpASmL2G8P
 sWl9ICNZ10c1uH3tBWwoBmfAxkBXtz9bUrYHBVtZBzzwQDWOAJmRBgwLESi01Q==
X-Gm-Gg: AZuq6aIEF9fEaQjFk/QgDAgB0nRjWq1TigJg/xn6ObAyghDYRSmhT5wMlqq6IylKPj9
 oL8SaVMx/6ZkPZrjNkHBJ9mzsKszksjUDSCG0kuG5RJJkoGO4lTzy2lsb67R3GS8sp254OIi1yh
 AuHzMwhZeAI5sZhKLXWbNpI4yCXiaYDoV2ZGLUHWkBoPnl6LDWXWJK1keTXen1kLCtjH4FV1WNO
 ru5rhXIsEDe8tEosb5iYumBsTHLiFO0m/eQKvjGoe37JqyAgs9ILrYbPwxahZZGFVPanQrBHYCh
 F29TmsjSP0BRoq+IvCn81R1nV7ftgUjoARAPB5rwRa04gr/StUeevSUusJZq+vvkBcW8x/qmGeb
 6wt2FLhVo4NTE9z5NjR3J0acjmuy4WQlFwMOjvfZg3KV9qz8WZzgdXPu+aHPkHl8qc9NZjbfXZb
 MU71GpSKm/2+8NI9aGZwcVFvgBP6UBNfLA+fAv2yU=
X-Received: by 2002:a5d:5f54:0:b0:430:fd0f:2910 with SMTP id
 ffacd0b85a97d-435f3a92801mr10979253f8f.26.1769908084372; 
 Sat, 31 Jan 2026 17:08:04 -0800 (PST)
Received: from localhost.localdomain ([92.180.8.65])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ed952sm33922358f8f.10.2026.01.31.17.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 17:08:04 -0800 (PST)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: qemu-devel@nongnu.org,
	laurent@vivier.eu,
	razvanghiorghe16@gmail.com
Subject: [PATCH v2] linux-user: Fix mremap() with old_size == 0
Date: Sun,  1 Feb 2026 03:03:43 +0200
Message-ID: <20260201010436.5735-1-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When old_size is zero and old_address refers to a shareable mapping,
mremap() should create a new mapping of the same pages according to the
mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this case.
Previously, QEMU's target_mremap() rejected this valid case with EFAULT during
the initial validation, before checking for the special old_size == 0 behaviour.

This patch adds proper handling for old_size == 0:
- Validates that MREMAP_MAYMOVE flag is set (required by man spec)
- Passes the call through to the host mremap()
- Creates a new mapping without invalidating the original, with both
beeing valid and sharing the same physical memory frames.

Tested with the reproducer from the issue on qemu-riscv64.
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
---
 linux-user/mmap.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4bcfaf7894..b1a84eb60a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1117,6 +1117,38 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         errno = EINVAL;
         return -1;
     }
+
+    if (!old_size) {
+        if (!(flags & MREMAP_MAYMOVE)) {
+            errno = EINVAL;
+            return -1;
+        }
+        mmap_lock();
+        if (flags & MREMAP_FIXED) {
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags, g2h_untagged(new_addr));
+        } else {
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags);
+        }
+
+        if (host_addr == MAP_FAILED) {
+            mmap_unlock();
+            return -1;
+        }
+        new_addr = h2g(host_addr);
+        prot = page_get_flags(old_addr);
+        /*
+         * For old_size zero, there is nothing to clear at old_addr.
+         * Only set the flags for the new mapping. They both are valid.
+         */
+        page_set_flags(new_addr, new_addr + new_size - 1,
+                       prot | PAGE_VALID, PAGE_VALID);
+        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
+        mmap_unlock();
+        return new_addr;
+    }
+
     if (!guest_range_valid_untagged(old_addr, old_size)) {
         errno = EFAULT;
         return -1;
-- 
2.43.0


