Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB0FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 20:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5lV-000487-Lp; Tue, 11 Mar 2025 15:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kO-00014I-5U
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:41 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts5kF-0000A5-EF
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:58:36 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22185cddbffso3407015ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741723108; x=1742327908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/B5foK4Qy0OvFQVWNYpVAAsAF+tVTKpBxl4Jl8CdPFE=;
 b=fKUIl7sdE0EUMvdS4qpkgpG/tORRIIDbtwWqSt3ScaCVPUgLkZyIIAIjzoxgbFuY7O
 KFR/r0LpRJPoFYW9S+xTHbYLBkZVQFbio/BzmXej2kylrieUiVactUFgl6Fc7zr074YS
 UaTMSHG3irEUzmtrsCcZqrIlwwWVLPkMCM+dDV04CuYte2Tpz/6r9XmvG3FtGoikCGPR
 Y78g68GXBuQxKdLAVhBn4dIH4W4mZodV7Ap+iGCMlXj/aVJYJE+MKND6isBCv2FbU8ST
 ycb3Q49SIKQEIVCe85DPwiwQ0V5OHBtNZFocp+ALRrMyspsSIORgX27qDhpTgSCKUe6F
 gYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741723108; x=1742327908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/B5foK4Qy0OvFQVWNYpVAAsAF+tVTKpBxl4Jl8CdPFE=;
 b=qkfTcL7BAbxYbDAsxonD/15psOaY+uA1I7sHboxFrkxsaekungdIlLwAsWRBzQvVkU
 dmumj/vWjv4haboxR1fu7BH/IcR8NdPV8u5RWKdn+DpivA92GWPoXkKwUSFWJyJLCge2
 B15TQfeAbA8ZWOiOLEH9/c7/PLZ0XMHTOstDxj5d6Jo4B9m4UppcKuHkZZdVnuLE2RFk
 go725n90a0QX0Jb2RVLV8TzQL77TfH2B57DZG0Xs5IbTw0FE9HgisA8E9PRpZyN/5iyw
 JVC8VC9qOtBUxXDnLXIPRdOyOBDWnK9z0DMullNfSGBWIFaaVHV7A5ehEQTMAGugUcZH
 4Xig==
X-Gm-Message-State: AOJu0Yxb7mFvP6XD1byIghoL24z3iAKMXEbTCOWcrOB58u0BIGAcjZcj
 t+XzuFH8fhfQ0C2pBx0QF2tW2+wmmV1mwoBIasenQsqPR3C3jDrItEk6CeJ8+fN/ZtmODP+tSxH
 T/Sc=
X-Gm-Gg: ASbGnctL5ZULAXS8hB1T9Wc37Ko/8GZcSZHmuolcDzdvgTGsva35EYrmrmoWncFSnyZ
 Z66x2MkhhFlnQfbpK2gqa4uE2sXUYflKUYI3JJi9s3rgQ18tOwLcjazHM1FrOdBKpXsFjeViwml
 h3hnJUM36ehRvMkDKDcwP0Q6H/oe67Q5TKCabLwyoTvsbJMC/41TcxqZGuRyiVqQKxNTs0Wmjmy
 DzlxdZqDs/dJryBCc+J7Hoo9wfTpQysP0XHMWv3BuRMDbf0fRsMNn1ZL66brVjgcZSs1C4Jhf82
 IekF/0nVwEGrIO8s9LW7mTYSHt0yYx6hYx4iilFfZb7Q
X-Google-Smtp-Source: AGHT+IEFWhkhOunU64h5Vgyk432uXoYWcCQsdf3Qo3RWjfxu/zqVxr3PiSl8C3ffFvP7C/aGeequIA==
X-Received: by 2002:a05:6a00:638b:b0:732:57d3:f004 with SMTP id
 d2e1a72fcca58-736ec5f1748mr5532672b3a.6.1741723107984; 
 Tue, 11 Mar 2025 12:58:27 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a6e5c13asm9646981b3a.157.2025.03.11.12.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 12:58:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, kvm@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 manos.pitsidianakis@linaro.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>, alex.bennee@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 15/17] include/exec/memory: move devend functions to
 memory-internal.h
Date: Tue, 11 Mar 2025 12:58:01 -0700
Message-Id: <20250311195803.4115788-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
References: <20250311195803.4115788-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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


