Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DF0C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 14:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM6x5-0000Gw-1o; Tue, 25 Jun 2024 10:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM6x3-0000G3-78
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:15:17 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM6x0-0003M3-MU
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 10:15:16 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-361785bfa71so4279274f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719324913; x=1719929713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v0zUfakwZ2DPhTV/ehMsF7r0fHgJBBol2EgKTf3v5Xo=;
 b=TgtK39myNTDX7GzaI5oLb+K+iDbxwZvQ2+PbcClgqnVjCV4PrlRvTXKDoshF6kzrYu
 l+c+Q/H8oXutLRfdKPztLBab73FQebR/V+qr1M3hBnahT0rGw8gZoaQq0C1qdpiUKkuz
 VZygMA5MvkiAJMV1vcO+VGiTgM09Z18kC/uzZiLzgdVz/Qpkawm6IlpuanCsQf3i/j2S
 TeieKopRPy+jUwPHLyWsjOKDG/3pZ8BNYrfaUV3/uTpcbtRQHjv0lXBdmCklEYZ0mJJP
 2IjvKFPZIL9JY5dApLax1m/vFTnoM+K6y0ENFta+RSXDpwZMkLxnqCKqbUv9ceIrSV7g
 Dq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324913; x=1719929713;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v0zUfakwZ2DPhTV/ehMsF7r0fHgJBBol2EgKTf3v5Xo=;
 b=epB6PCexjh8BkIINxiHQ1f08EPtia+qOcAJ33AMkTeMYmgAWXntTLxkFU1njY0lEMp
 gruFkKQC988KwjBCl5jRvd2QPWJxalXmwJip962BtaKW8EQPVhaWtDwTW/G5eX0XHaSC
 ps3pg8kPVcOdoZJx/HqBpbVH26pNzkfBqbEEpjnIFLHKBbwRq31mppoOkPysshE8dwEE
 9+Wi8BJZEgRVKklkHyY7DFocafB9qSiVvkX1SGBz+ys2tcfCRKh3KswHSJKTJlDODF+L
 tEar2wVTqR7jkUhw18F/KSC66PF6WcHfmfRLIzePSbN5DqfUAuOrh6ztKkiiczG3Iasw
 4/iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD16zDmMyF8iNof1z+dTIEcjGP2dJ3/335Q9Ox7j8h6+rBvrDsS5Xn0O0BPJ1yXLUJMMcU/rkc6TZFTSEv2abyhP6Jp4Y=
X-Gm-Message-State: AOJu0Yz5J6s7WsOmLy1Pc2Kyg/j+HM9BPA/ENzijxv/+5fzsuKNM2omO
 PGhoIYKSkTFfRieqY9QeZleW0Fi0BA1klusvAb+NNyJWw6M0NdfIiAVGWpL3CJY=
X-Google-Smtp-Source: AGHT+IGoiK8OLf33oPz3iGDHB2tE03SFahSJZleMrrVRfSOvLea11kbXHUY43yRQ7tA+qv94H0IlLg==
X-Received: by 2002:a5d:47ac:0:b0:366:e982:8b8d with SMTP id
 ffacd0b85a97d-366e9828bf9mr6003374f8f.11.1719324913051; 
 Tue, 25 Jun 2024 07:15:13 -0700 (PDT)
Received: from [192.168.69.100] (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366eef51a14sm6719821f8f.83.2024.06.25.07.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 07:15:12 -0700 (PDT)
Message-ID: <bf3e7678-b289-4a7a-bd0b-5665ad8cdf8a@linaro.org>
Date: Tue, 25 Jun 2024 16:14:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] target/arm: Make some MTE helpers widely available
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org
References: <20240624053046.221802-1-gustavo.romero@linaro.org>
 <20240624053046.221802-6-gustavo.romero@linaro.org>
 <bdb11f59-43e5-4715-adfe-1a1a4d7bdf1f@linaro.org>
Content-Language: en-US
In-Reply-To: <bdb11f59-43e5-4715-adfe-1a1a4d7bdf1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 24/6/24 09:47, Philippe Mathieu-Daudé wrote:
> Hi Gustavo,
> 
> On 24/6/24 07:30, Gustavo Romero wrote:
>> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
>> available to other subsystems.
> 
> Again, you can make them available externally by removing the
> static scope. I'm not keen anymore on inline function definitions,
> please justify why you need them. Inline functions often requiere
> more headers to be pulled in, and behind the preprocessing overhead,
> it makes header maintenance more painful.

If my comment is unclear and you don't have any strong justification
to add inlined declarations, what I am requesting is:

-- >8 --
diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
new file mode 100644
index 0000000000..0e7a67cf0f
--- /dev/null
+++ b/target/arm/tcg/mte_helper.h
@@ -0,0 +1,68 @@
+/*
+ * ARM MemTag operation helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_MTE_H
+#define TARGET_ARM_MTE_H
+
+#include "exec/mmu-access-type.h"
+
+/**
+ * allocation_tag_mem_probe:
+ * @env: the cpu environment
+ * @ptr_mmu_idx: the addressing regime to use for the virtual address
+ * @ptr: the virtual address for which to look up tag memory
+ * @ptr_access: the access to use for the virtual address
+ * @ptr_size: the number of bytes in the normal memory access
+ * @tag_access: the access to use for the tag memory
+ * @probe: true to merely probe, never taking an exception
+ * @ra: the return address for exception handling
+ *
+ * Our tag memory is formatted as a sequence of little-endian nibbles.
+ * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
+ * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
+ * for the higher addr.
+ *
+ * Here, resolve the physical address from the virtual address, and return
+ * a pointer to the corresponding tag byte.
+ *
+ * If there is no tag storage corresponding to @ptr, return NULL.
+ *
+ * If the page is inaccessible for @ptr_access, or has a watchpoint, 
there are
+ * three options:
+ * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page 
is not
+ *     accessible, and do not take watchpoint traps. The calling code must
+ *     handle those cases in the right priority compared to MTE traps.
+ * (2) probe = false, ra = 0 : probe, no fault expected -- the caller 
guarantees
+ *     that the page is going to be accessible. We will take watchpoint 
traps.
+ * (3) probe = false, ra != 0 : non-probe -- we will take both memory 
access
+ *     traps and watchpoint traps.
+ * (probe = true, ra != 0 is invalid and will assert.)
+ */
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra);
+
+/**
+ * load_tag1 - Load 1 tag (nibble) from byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ */
+int load_tag1(uint64_t ptr, uint8_t *mem);
+
+/**
+ * store_tag1 - Store 1 tag (nibble) into byte
+ * @ptr: The tagged address
+ * @mem: The tag address (packed, 2 tags in byte)
+ * @tag: The tag to be stored in the nibble
+ *
+ * For use in a non-parallel context, store to the given nibble.
+ */
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag);
+
+#endif /* TARGET_ARM_MTE_H */
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a50d576294..25ea24ee53 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -29,6 +29,7 @@
  #include "hw/core/tcg-cpu-ops.h"
  #include "qapi/error.h"
  #include "qemu/guest-random.h"
+#include "mte_helper.h"


  static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
@@ -50,42 +51,10 @@ static int choose_nonexcluded_tag(int tag, int 
offset, uint16_t exclude)
      return tag;
  }

-/**
- * allocation_tag_mem_probe:
- * @env: the cpu environment
- * @ptr_mmu_idx: the addressing regime to use for the virtual address
- * @ptr: the virtual address for which to look up tag memory
- * @ptr_access: the access to use for the virtual address
- * @ptr_size: the number of bytes in the normal memory access
- * @tag_access: the access to use for the tag memory
- * @probe: true to merely probe, never taking an exception
- * @ra: the return address for exception handling
- *
- * Our tag memory is formatted as a sequence of little-endian nibbles.
- * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
- * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
- * for the higher addr.
- *
- * Here, resolve the physical address from the virtual address, and return
- * a pointer to the corresponding tag byte.
- *
- * If there is no tag storage corresponding to @ptr, return NULL.
- *
- * If the page is inaccessible for @ptr_access, or has a watchpoint, 
there are
- * three options:
- * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page 
is not
- *     accessible, and do not take watchpoint traps. The calling code must
- *     handle those cases in the right priority compared to MTE traps.
- * (2) probe = false, ra = 0 : probe, no fault expected -- the caller 
guarantees
- *     that the page is going to be accessible. We will take watchpoint 
traps.
- * (3) probe = false, ra != 0 : non-probe -- we will take both memory 
access
- *     traps and watchpoint traps.
- * (probe = true, ra != 0 is invalid and will assert.)
- */
-static uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                         uint64_t ptr, MMUAccessType 
ptr_access,
-                                         int ptr_size, MMUAccessType 
tag_access,
-                                         bool probe, uintptr_t ra)
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access,
+                                  bool probe, uintptr_t ra)
  {
  #ifdef CONFIG_USER_ONLY
      uint64_t clean_ptr = useronly_clean_ptr(ptr);
@@ -287,7 +256,7 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
      return address_with_allocation_tag(ptr + offset, rtag);
  }

-static int load_tag1(uint64_t ptr, uint8_t *mem)
+int load_tag1(uint64_t ptr, uint8_t *mem)
  {
      int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
      return extract32(*mem, ofs, 4);
@@ -320,8 +289,7 @@ static void check_tag_aligned(CPUARMState *env, 
uint64_t ptr, uintptr_t ra)
      }
  }

-/* For use in a non-parallel context, store to the given nibble.  */
-static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
  {
      int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
      *mem = deposit32(*mem, ofs, 4, tag);
---

Or if you prefer a diff to squash on this commit:

-- >8 --
diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
index 6a82ff3403..0e7a67cf0f 100644
--- a/target/arm/tcg/mte_helper.h
+++ b/target/arm/tcg/mte_helper.h
@@ -9,6 +9,8 @@
  #ifndef TARGET_ARM_MTE_H
  #define TARGET_ARM_MTE_H

+#include "exec/mmu-access-type.h"
+
  /**
   * allocation_tag_mem_probe:
   * @env: the cpu environment
@@ -51,11 +53,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, 
int ptr_mmu_idx,
   * @ptr: The tagged address
   * @mem: The tag address (packed, 2 tags in byte)
   */
-static inline int load_tag1(uint64_t ptr, uint8_t *mem)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    return extract32(*mem, ofs, 4);
-}
+int load_tag1(uint64_t ptr, uint8_t *mem);

  /**
   * store_tag1 - Store 1 tag (nibble) into byte
@@ -65,10 +63,6 @@ static inline int load_tag1(uint64_t ptr, uint8_t *mem)
   *
   * For use in a non-parallel context, store to the given nibble.
   */
-static inline void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
-{
-    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
-    *mem = deposit32(*mem, ofs, 4, tag);
-}
+void store_tag1(uint64_t ptr, uint8_t *mem, int tag);

  #endif /* TARGET_ARM_MTE_H */
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index da6bc72b9c..25ea24ee53 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -256,6 +256,12 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t 
ptr,
      return address_with_allocation_tag(ptr + offset, rtag);
  }

+int load_tag1(uint64_t ptr, uint8_t *mem)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    return extract32(*mem, ofs, 4);
+}
+
  uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
  {
      int mmu_idx = arm_env_mmu_index(env);
@@ -283,6 +289,12 @@ static void check_tag_aligned(CPUARMState *env, 
uint64_t ptr, uintptr_t ra)
      }
  }

+void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    *mem = deposit32(*mem, ofs, 4, tag);
+}
+
  /* For use in a parallel context, atomically store to the given 
nibble.  */
  static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
  {
---

Regards,

Phil.

