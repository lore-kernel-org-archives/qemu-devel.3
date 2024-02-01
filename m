Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2EFC4828E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 08:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVSDT-0000C9-MR; Thu, 01 Feb 2024 03:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rVSDS-0000Bb-3s
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:14:34 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rVSDQ-0002oX-DV
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 03:14:33 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-59a27fbe832so314364eaf.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 00:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1706775271; x=1707380071;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8xd9SGhmJ+pFOTZaX4mP+etfguksCBa8zBo7QZ+B6c=;
 b=i0n+qM1EcbKmn+w9UjVYqC1xwd8vkZffLF5L9s9nd38b08yn1KQpGfoI4YH9bBYDti
 29uk9EXeQ9F6NJYZLVEYqLuLZsUFw7ui34hvG/1OKud+Vw3mS5nFHLFcDWXjcf99jvWD
 +Tp1kTZj/rowBTDuro/Ua1lhtDDAC6wq8V1X9+Am9JViVEFj4FM3uZHBoYPzPnGjoQBs
 r9vHcNl2kVYrQlESULc/udeGIcfWRLg4x/Gi2PgbYkPBJwRT8TC6w/sda1VDRLBLwz6C
 YoLb5nvejSyjRy6El76jmJ5w+i6KTl/XrYdJziAmZzR5ODkDbk+OJydUVJ5G8j+J1ZoJ
 /JfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706775271; x=1707380071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8xd9SGhmJ+pFOTZaX4mP+etfguksCBa8zBo7QZ+B6c=;
 b=BqkGx/tDmvKG9c6DwKuV8qJUwPWFp/2WQePzm2g7K54I720k2l0xrF55Y3hv+30jZR
 BFbYhIWFPAfL1YehuWZCelUB0irGnSi02++8WdBIC3PYlrdqYJ/tT19AMuzEgUaCGl1K
 cv79WZc5jV5A/YXT9jQD45uD1nK46CZFIt1lF4CqrwjDR+DEeDZtQLBzNlGq2WfcdaVV
 UMoQSR2SFxNs8NZDrKQi9A7qUEcHEDl/VksO0jiZ4RZ+ImqLc3SKmYq+GQWz7QLhFFUm
 unLFyxqDRzjVV33JSkQIU9jvhdch3h+grNysKvrbi7+gRN0ry15QtYd/MXdSrJoSFBBg
 L1RQ==
X-Gm-Message-State: AOJu0YzL9ZgGbWEX0ouG/W9aEdrOQnbddPpxbjECezJK+KIgqOZ6q2dQ
 cGiZBq5ejKhW6wKXCx9t7SxQsQA/NZ6q4UAuxdlWBgR0uNPp9OWIC1QSOPulH3/Ah5EarATc67S
 rZTw=
X-Google-Smtp-Source: AGHT+IHr1Omf8WReIohi1a7UnbIk2Nj0aO4cbWL3O6dC0/PqR/WfYY8LdN9ueEggALMwQy4Ei8fXUQ==
X-Received: by 2002:a05:6871:822:b0:214:7e6e:5bbe with SMTP id
 q34-20020a056871082200b002147e6e5bbemr1909819oap.16.1706775270876; 
 Thu, 01 Feb 2024 00:14:30 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXTnQL6E6EJ3/JfwBHM+88XRpBayJ6Ab4O9rPYt28oXr5Z3X1i81YjoAFkEaHPwRD3taAdJkXdG+cGaBh67ufp66JoKCgF3aSZR6pAmRr7j5Wsah65cRXTDi6MlwGGh/VAAxeZ4Fu02XasUWQiL2yyYIQwTNpBsE9ocUNg=
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 38-20020a631366000000b005d6c208fbd2sm11943780pgt.35.2024.02.01.00.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 00:14:30 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] system/memory.c: support unaligned access
Date: Thu,  1 Feb 2024 17:13:12 +0900
Message-Id: <20240201081313.1339788-2-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
References: <20240201081313.1339788-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The previous code ignored 'impl.unaligned' and handled unaligned accesses
as is. But this implementation cannot emulate specific registers of some
devices that allow unaligned access such as xHCI Host Controller Capability
Registers.
This commit checks 'impl.unaligned' and if it is false, QEMU emulates
unaligned access with multiple aligned access.

Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 system/memory.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index a229a79988..a7ca0c9f54 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -535,10 +535,17 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
                                       MemTxAttrs attrs)
 {
     uint64_t access_mask;
+    unsigned access_mask_shift;
+    unsigned access_mask_start_offset;
+    unsigned access_mask_end_offset;
     unsigned access_size;
-    unsigned i;
     MemTxResult r = MEMTX_OK;
     bool reentrancy_guard_applied = false;
+    bool is_big_endian = memory_region_big_endian(mr);
+    signed start_diff;
+    signed current_offset;
+    signed access_shift;
+    hwaddr current_addr;
 
     if (!access_size_min) {
         access_size_min = 1;
@@ -560,19 +567,24 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
         reentrancy_guard_applied = true;
     }
 
-    /* FIXME: support unaligned access? */
     access_size = MAX(MIN(size, access_size_max), access_size_min);
-    access_mask = MAKE_64BIT_MASK(0, access_size * 8);
-    if (memory_region_big_endian(mr)) {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size,
-                        (size - access_size - i) * 8, access_mask, attrs);
-        }
-    } else {
-        for (i = 0; i < size; i += access_size) {
-            r |= access_fn(mr, addr + i, value, access_size, i * 8,
-                        access_mask, attrs);
-        }
+    start_diff = mr->ops->impl.unaligned ? 0 : addr & (access_size - 1);
+    current_addr = addr - start_diff;
+    for (current_offset = -start_diff; current_offset < (signed)size;
+         current_offset += access_size, current_addr += access_size) {
+        access_shift = is_big_endian
+                          ? (signed)size - (signed)access_size - current_offset
+                          : current_offset;
+        access_mask_shift = current_offset > 0 ? 0 : -current_offset;
+        access_mask_start_offset = current_offset > 0 ? current_offset : 0;
+        access_mask_end_offset = current_offset + access_size > size
+                                     ? size
+                                     : current_offset + access_size;
+        access_mask = MAKE_64BIT_MASK(access_mask_shift * 8,
+            (access_mask_end_offset - access_mask_start_offset) * 8);
+
+        r |= access_fn(mr, current_addr, value, access_size, access_shift * 8,
+                       access_mask, attrs);
     }
     if (mr->dev && reentrancy_guard_applied) {
         mr->dev->mem_reentrancy_guard.engaged_in_io = false;
-- 
2.39.2


