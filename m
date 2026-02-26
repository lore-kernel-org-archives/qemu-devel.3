Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB85FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjSZ-0002y0-P2; Thu, 26 Feb 2026 17:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRt-0002ZD-Cc
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:18 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRr-0001uV-KJ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:08 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43987b97701so933790f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143385; x=1772748185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3ZvAyTB+J8g8R55NOM7HtC99XIoDKv+zKI4lqiJNnQ=;
 b=g6wEGga0t66ZERMexP6VSTtTD9NnOImA5NX7n4NVQoIjqYi93wzpZcREmAdmonU6S+
 thEVd6fYUk48nTOUjPDxL0q5rPlhrbv/s8tCF1enDALyHVYdvkDHo/HcpNIy5XPUzZoi
 UoQxZ5jG1MUCXDBGJpFh5OH13s9afn8mSvUj47wfiRfzScYqcq4v6cOjPFJvb3/HFOj1
 AyQ5oVNIurcKVuNmahgD7zjVm3W2mLSUasrAT5WNVZdNscq6xFKuB2FRBJYexFq6ZhkQ
 k7BL/+oSZJPEjMoUTbmf+YBb+KGi/ypk6LezHCpyOOijBx1TvtSAu/j8/+x0olp823MA
 2jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143385; x=1772748185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E3ZvAyTB+J8g8R55NOM7HtC99XIoDKv+zKI4lqiJNnQ=;
 b=IPh/bdxCTJ5ZEk6ZMGfZo3EcvBfYFH1SK+jEPeyiI8Z5NyY6ztedxsoYyeW8iOlO55
 u6AYVqgXz9xjF/5lC/G8v3EriBJacRjv9bJtxo1zBRQq5KnmunFzTAQOW3O+z8IraLRY
 MuDvDEViY8cXH6EBalBq3GPfrJTSE1gt2yPSawsjWUI1T+k/Ls5z1abMhMwOw/l18NQ8
 FLle61llkUF+yTBSNO0ouOTfKgXFoXpGfauxNluvBa6IDc4/b+7nIfhZrdqEtNKFIBmn
 vPIf8f12UxZyqNT9HnxWeK7QqJ7F79p3F2wddg9XM3mzxYMr9Jed8g0sRfxy/mwUJcil
 7Xrg==
X-Gm-Message-State: AOJu0YyUaoSLiufTyyFjGyU2ZnKrnGD8eqetdNPE49FoeiPZFm9w8L9x
 2cLi6eMb5BBYZBI2YXsFfBoVb+0izrryje39J76Y/4A3r+t7aSuZYXjOzbLpaAxuCDEyI67KHlh
 Goih7KM8=
X-Gm-Gg: ATEYQzzMhMh3HI7kfd1qMJcxVKVET2dwClxzy6C59wZwa4JWegRE0Y3oYNP4BJLXxJD
 vnhfqFbw/8HEHmFalVaDI5hlk+sHy5+67PTMqJ4UrKEOtWllPPuZkDCqfL/iAC9dS4MOYLcOwOw
 TLHhrDCtwLYoQDuj8/gVbMCPUdbk3cRcBy7W4Hme2UFX9bRji4QgblOHucvc9YL1p1pAqooyYOw
 s6lXhQYdOayBJ/ZLBglepR9APTwDYU7O+qy8aMa0Y3UcdQNeJII5Kd/eeJ9uQcnlMSDZkvpSpqP
 ZGvSM9JOG/L2b4Fa0OZ1snGONtPoqxoUkUPrtIp1Sh0iDMNnABTF02LmHKNEdGnmceHPKCpWRN/
 Reesp3eIHjJWbWRUiqJs9rw9TpY5YcrOgL6vjfY5rQHUrQMK0POikG0dNwombIyi7AyyQ5Vcgu8
 YqimvZKRSnu34xTiIrfYWvqO/SVG9AVGDINkB2oesDMRSYY0uhWmJ9fgheN4g6w/hIPFYOCvaN
X-Received: by 2002:a5d:5d82:0:b0:431:808:2d58 with SMTP id
 ffacd0b85a97d-4399de3a446mr584432f8f.51.1772143384696; 
 Thu, 26 Feb 2026 14:03:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c763e78sm2368017f8f.26.2026.02.26.14.03.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:03:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 5/7] system/memory: Display address spaces starting at
 0x0000.0000
Date: Thu, 26 Feb 2026 23:02:23 +0100
Message-ID: <20260226220226.20164-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226220226.20164-1-philmd@linaro.org>
References: <20260226220226.20164-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Since AddressSpace root MemoryRegion can be remapped, it is
bogus to use the MemoryRegion address as the AddressSpace
absolute address. Besides, the AddressSpace APIs take an
@addr argument expecting AddressSpaces start at 0x0000.0000.

Substract the MemoryRegion address in mtree_print_mr() to
display AddressSpaces starting at 0x0000.0000.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index d5060774834..1106f48d0d5 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3360,7 +3360,7 @@ static void mtree_print_mr_owner(const MemoryRegion *mr)
 }
 
 static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
-                           hwaddr base,
+                           hwaddr offset, bool detect_overflow,
                            MemoryRegionListHead *alias_print_queue,
                            bool owner, bool display_disabled)
 {
@@ -3374,7 +3374,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
         return;
     }
 
-    cur_start = base + mr->addr;
+    cur_start = mr->addr + offset;
     cur_end = cur_start + MR_SIZE(mr->size);
 
     /*
@@ -3382,7 +3382,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
      * happen normally. When it happens, we dump something to warn the
      * user who is observing this.
      */
-    if (cur_start < base || cur_end < cur_start) {
+    if (detect_overflow && (cur_start < offset || cur_end < cur_start)) {
         qemu_printf("[DETECTED OVERFLOW!] ");
     }
 
@@ -3462,7 +3462,7 @@ static void mtree_print_mr(const MemoryRegion *mr, unsigned int level,
     }
 
     QTAILQ_FOREACH(ml, &submr_print_queue, mrqueue) {
-        mtree_print_mr(ml->mr, level + 1, cur_start,
+        mtree_print_mr(ml->mr, level + 1, cur_start, true,
                        alias_print_queue, owner, display_disabled);
     }
 
@@ -3641,7 +3641,8 @@ static void mtree_print_as(gpointer key, gpointer value, gpointer user_data)
     struct AddressSpaceInfo *asi = user_data;
 
     g_slist_foreach(as_same_root_mr_list, mtree_print_as_name, NULL);
-    mtree_print_mr(mr, 1, 0, asi->ml_head, asi->owner, asi->disabled);
+    mtree_print_mr(mr, 1, -mr->addr, false,
+                   asi->ml_head, asi->owner, asi->disabled);
     qemu_printf("\n");
 }
 
@@ -3688,7 +3689,7 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
         const MemoryRegion *mr = ml->mr;
 
         qemu_printf("memory-region: %s\n", memory_region_name(mr));
-        mtree_print_mr(mr, 1, 0, &ml_head, owner, disabled);
+        mtree_print_mr(mr, 1, 0, false, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
-- 
2.52.0


