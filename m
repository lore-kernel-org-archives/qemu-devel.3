Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DF9CCD19A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MyE-0004vR-LG; Thu, 16 Oct 2025 08:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxb-0004Ki-6k
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MxY-00008G-4r
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:19:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-471075c0a18so7178375e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617190; x=1761221990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+0UM2tTv0SeN6/gJZySU/ntFINe0lll48hUY4V5BcM=;
 b=fA/5T1rAXL2mg6laqdwxHe6xj07TU6cnIrgoYDQnbFByssNI5VPS7wPegaotOCglLY
 OiwcM6EJztGZ/WN2i49GGRQzJKGTUsJizqN9tuYSz053InnOJES8/lvxb9VPtj3PAlfW
 SgfowbsUwZ+illL0mKPPkevcEiRz4dJb1ms+u2YaMVTYEXPZZs6OSEzLOHixgfdQyHMA
 VJ13r1vV3EOtDooNu0gy6KKJmHzZ9+xcpvtwYECzD323azH+Pi5A9bRfj8KF63QzHfli
 aY2rHyEOAsyJmWzg2stxYUBZVURoAx5wyNOCTLp10PKlehR4ybAHaZ83Ag4aaAM6rijR
 B+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617190; x=1761221990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+0UM2tTv0SeN6/gJZySU/ntFINe0lll48hUY4V5BcM=;
 b=Q3oFqIlLIv/4wgEs5CNbWOXDhEo4pEPrJwSazkOr8L5dfZI38UwAgQW0nAk9ljWqAn
 gA35kjClRIzFl3TnpXINKEOPpETsA4im1lDW4oO7TIrO9NKxqzgBWuo+hcaFdAYz4E8z
 56Qu3YBD/UQCK4OK/9Xz9CYvcLCjejsPBzttzLjJLQ8V+o0gLWzNTQl1VAFy/TnVJLru
 k5FQ9CmvqISJ9b4WcrtPjNrzJCnmgaUSMIKQ5uz5AhcEKgjZuri6cF4K07D9SbvC+eLj
 kqAxJt46d0PA0cqckmuepOWfB2daVWku1NETLHnHM20pHsgu/FqHOOzxdrpkigKBJVEh
 5DGg==
X-Gm-Message-State: AOJu0Yy/5FZADBFka811Cbc+/qz9OvRJQ5bwgmSF58VwYsYBJ4bDf2mP
 YgVksL7YLx7OgSd3VD8dHnOOw0WGIdkFPSmXtJcdSM75hb3NpSMWD994dCiZ4sOJUTLdzyXL1Vz
 xtLqklZ0=
X-Gm-Gg: ASbGncsfllfpbpBWEgOG/FAQps1dzw32Qut+ILajjWCL0Fn27bszf8XID0i4SUzZiV3
 vYopAln+XA5TqPPbQBeLD2cf1gJQLFv81Hd59/jW7Qbq5bpaIl/vPgZJw23d072bN3c1B805pSD
 N9mBQ9/DMgmVR10Vf2RiszMzS6CXgUoyVUrltLpM0CGm8EOZQXdLtGvLtL2OBP/33nQi8tIzNZa
 HLgFGh1yBH8Caa5Oj3Cf91esaHIHwep1P0wrtn2EMYI8IfhMNg8X6+UQcu1Zz94wfZuScAzCX8C
 DFmO9ir/WEvy5qF5E8gfeeYMyX/0R0ws0yodRV0WvUkiMOsaHZvQqSs86qXmiOXQTFIZR3QxjfL
 W8UVdj0oXE/vwyb+9wIF9Ro7t3/PcgeTLLDeY+Dp1hAvAoO80m1iWWzFyuC3rotNu7x5RyeE7o5
 eGSouVCC2MK3PCGL6T15ECKAMOb9tny5sjjAz1sp8l84Xoa26EPid9dg==
X-Google-Smtp-Source: AGHT+IFVCvQsCJ8fYdLW0PgDC7ecCpvxwSEUlkSYhOF+y5CA632OoqK2wZPSMj6Uh4R3mwXgsIMgfQ==
X-Received: by 2002:a05:600c:1f06:b0:46e:384f:bd86 with SMTP id
 5b1f17b1804b1-46fa9a9443fmr206357435e9.5.1760617189784; 
 Thu, 16 Oct 2025 05:19:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711441f66dsm23800745e9.2.2025.10.16.05.19.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:19:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/75] target/sh4: Remove target_ulong uses in
 superh_cpu_get_phys_page_debug
Date: Thu, 16 Oct 2025 14:15:11 +0200
Message-ID: <20251016121532.14042-56-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
type since commit 00b941e581b ("cpu: Turn cpu_get_phys_page_debug()
into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20251008064814.90520-5-philmd@linaro.org>
---
 target/sh4/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 55ab1dc9947..f5c37c2d80d 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -231,11 +231,11 @@ static int itlb_replacement(CPUSH4State * env)
 /* Find the corresponding entry in the right TLB
    Return entry, MMU_DTLB_MISS or MMU_DTLB_MULTIPLE
 */
-static int find_tlb_entry(CPUSH4State * env, target_ulong address,
+static int find_tlb_entry(CPUSH4State *env, vaddr address,
                           tlb_t * entries, uint8_t nbtlb, int use_asid)
 {
     int match = MMU_DTLB_MISS;
-    uint32_t start, end;
+    vaddr start, end;
     uint8_t asid;
     int i;
 
@@ -291,7 +291,7 @@ static int copy_utlb_entry_itlb(CPUSH4State *env, int utlb)
 /* Find itlb entry
    Return entry, MMU_ITLB_MISS, MMU_ITLB_MULTIPLE or MMU_DTLB_MULTIPLE
 */
-static int find_itlb_entry(CPUSH4State * env, target_ulong address,
+static int find_itlb_entry(CPUSH4State *env, vaddr address,
                            int use_asid)
 {
     int e;
@@ -309,7 +309,7 @@ static int find_itlb_entry(CPUSH4State * env, target_ulong address,
 
 /* Find utlb entry
    Return entry, MMU_DTLB_MISS, MMU_DTLB_MULTIPLE */
-static int find_utlb_entry(CPUSH4State * env, target_ulong address, int use_asid)
+static int find_utlb_entry(CPUSH4State *env, vaddr address, int use_asid)
 {
     /* per utlb access */
     increment_urc(env);
@@ -326,7 +326,7 @@ static int find_utlb_entry(CPUSH4State * env, target_ulong address, int use_asid
    MMU_IADDR_ERROR, MMU_DADDR_ERROR_READ, MMU_DADDR_ERROR_WRITE.
 */
 static int get_mmu_address(CPUSH4State *env, hwaddr *physical,
-                           int *prot, target_ulong address,
+                           int *prot, vaddr address,
                            MMUAccessType access_type)
 {
     int use_asid, n;
@@ -393,7 +393,7 @@ static int get_mmu_address(CPUSH4State *env, hwaddr *physical,
 }
 
 static int get_physical_address(CPUSH4State *env, hwaddr* physical,
-                                int *prot, target_ulong address,
+                                int *prot, vaddr address,
                                 MMUAccessType access_type)
 {
     /* P1, P2 and P4 areas do not use translation */
-- 
2.51.0


