Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42717C35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8tw-00064g-22; Fri, 14 Mar 2025 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tI-0005fQ-Ce
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tt8tD-0008JC-SK
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:32:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224100e9a5cso48995405ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741973522; x=1742578322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ipPAyCMNYKQgJ+e1Pj22cNEjWMul6XXi9iVGdQZJ7Rc=;
 b=xYpxq0h+ebVTHIFOxqOTni3MZq7i51vLM/Fq6xr3oB+lL5j6gnulNtIi1/nvoTA+9L
 i+Em+bU1uCB9SlekJRhF9tJNn/5re4+HcwBYSPFnIvHjGdniWSqe2fu9cTTJBnh/Eoss
 YkifVC3c22qadqgAgxnrIEqIqvJ4H5ATUuDWuN5wzDD0FBMaZw2yPFHX01s7BMDYD6f+
 aaUTA0yEgiwFyQzkZIFrP0b+NjO7ptPndqxtYaQItgxs7tD7WvSnA6EimTOJTIhfVb3E
 fUMz2ut3DMhpipXVn9f7Fo5mo16C9hm/5V1lJxquceMMG04WUKl+WhxBMP/NPKhN3Byz
 /EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741973522; x=1742578322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ipPAyCMNYKQgJ+e1Pj22cNEjWMul6XXi9iVGdQZJ7Rc=;
 b=RJy8gnZxJzqgPaHFbhpHTLTAAPO7HxeDT2vP6FLxpi2L7lKY+nMfdCNhX5vLBwrFf8
 CzO5yAhU9uwt6/Gfmc5L64K+8XIJslb9AdpIDDIUgNjsnnrnR0OSbnaCkG6SPGTu6j7W
 utXaIQqSu9GBzYUl1ik0qLWrkSJyyApgGuxu27GeLZYYtaj9G9NyaYOz4OmDWYv6Qorq
 gYWoEl2vULRup03jvKTmlR9U2gW56DJwWxP8pyPJqr1eHje7Lh4uPY9Wht3zqxSh1Mpp
 2pPC6vxuMjudHAtuhit/lyM3aWkSHo9b5Q095501pPri9vrWhOzLoSj2A2EOIyZS1dJd
 a7wQ==
X-Gm-Message-State: AOJu0Yyt1+H83e0CXnV7pPirf7V6U6J71aBWr5Ud1YZ4DjozOzkyk3O5
 Bx+FMUK5iCEuhr6ciaSx4T3v+ZE3MKFXKxHU/1Xyeb7VYlnJ4aCa82cd4AGPdLqsQt4cOhYDB4E
 x63c=
X-Gm-Gg: ASbGnctNZd2VS1/6pZYchf4uApvrGmMQtuRcTJOiFPY3X/2/oBtQfRQHpI+/tSO0CGd
 uu5QqmhBeu5RdRfXoxKGwF7MLeq/kNVH/1v6VJYMPtYGrMuvI13Br67fILbeF/wUDSVz809TDZw
 8746EAAvaTfkKE2rRv8QjbEDQJ6Y9lJ4Lpss3dLDKXLDTctUdM+rD7q0BrkbiqqLgv9cHCA3Pfx
 mo98qTamX2n8zy934YhitM/0wZ7DoLEkqK6ne29IxNuIGpTfuTNUOG9oQ7cLAxaM8iT9vIwx0ee
 ViEVQEHnp4DRGGhVMp6oP/XH1eepIOXEM8hd3rpZ1f/6
X-Google-Smtp-Source: AGHT+IEtHSmevJ6R5avE3bKBZZosO5sZ+P9hAoOgJtZ8OftQtbIF6mLlVq94OOMFZzJGHDBT5BJrHg==
X-Received: by 2002:a05:6a21:6d88:b0:1f5:7873:3053 with SMTP id
 adf61e73a8af0-1f5c12ec5b1mr4773946637.29.1741973522470; 
 Fri, 14 Mar 2025 10:32:02 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9cd03bsm2990529a12.8.2025.03.14.10.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 10:32:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 15/17] include/exec/memory: move devend functions to
 memory-internal.h
Date: Fri, 14 Mar 2025 10:31:37 -0700
Message-Id: <20250314173139.2122904-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

Only system/physmem.c and system/memory.c use those functions, so we can
move then to internal header.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 19 +++++++++++++++++++
 include/exec/memory.h          | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index b729f3b25ad..c75178a3d6b 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -43,5 +43,24 @@ void address_space_dispatch_free(AddressSpaceDispatch *d);
 
 void mtree_print_dispatch(struct AddressSpaceDispatch *d,
                           MemoryRegion *root);
+
+/* returns true if end is big endian. */
+static inline bool devend_big_endian(enum device_endian end)
+{
+    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
+                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
+
+    if (end == DEVICE_NATIVE_ENDIAN) {
+        return target_words_bigendian();
+    }
+    return end == DEVICE_BIG_ENDIAN;
+}
+
+/* enum device_endian to MemOp.  */
+static inline MemOp devend_memop(enum device_endian end)
+{
+    return devend_big_endian(end) ? MO_BE : MO_LE;
+}
+
 #endif
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 70177304a92..a3bb0542bf6 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -3138,24 +3138,6 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
-/* returns true if end is big endian. */
-static inline bool devend_big_endian(enum device_endian end)
-{
-    QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
-                      DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
-
-    if (end == DEVICE_NATIVE_ENDIAN) {
-        return target_words_bigendian();
-    }
-    return end == DEVICE_BIG_ENDIAN;
-}
-
-/* enum device_endian to MemOp.  */
-static inline MemOp devend_memop(enum device_endian end)
-{
-    return devend_big_endian(end) ? MO_BE : MO_LE;
-}
-
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
-- 
2.39.5


