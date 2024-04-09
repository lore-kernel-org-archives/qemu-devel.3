Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CB2CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dp-0003CB-Mq; Tue, 09 Apr 2024 01:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dm-0003Ah-EN
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dk-0005Ia-RT
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ed0938cd1dso3148137b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639003; x=1713243803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QdlWMWgnGp4nnm6wecPBCmGBGP6RpnH+ptC3EDh4jQk=;
 b=Ol7HKID2WkaGoMSBXbMMflP/AN2JZhIYhPFU1Gu3ZSCbgDdR5fuT0aPMKoKxHeBV0y
 g2OyLYKkyi078ttj30SqFHqoUV2sC35jZAN+PVGJELvdPnpJCqfEkf/tqXFMjpwFUfWQ
 Vxsg0F93dSRlLU66UVxooINTyPsLysdgzWYD9nDcMiIDsJcPzFaaTxGTGPtxkqsk9D6E
 vz9x6d2V7Oh9Q/pt5SV+cRTpMGTAJ1ChkcPN5JtwO9kw1Js3s2iaBV+1YkH03IDeKbiJ
 tW6IF+LQ1pvV6Xke1mo9kbPzvpnpL+6tdxZoMJQ1EOzEjI391xR0/wSrsZtpl7V+MAi5
 25fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639003; x=1713243803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QdlWMWgnGp4nnm6wecPBCmGBGP6RpnH+ptC3EDh4jQk=;
 b=DgvnUsXMM2QYbI4E2LayDNiS11X+gZXDp8WfacfKx5zmmeuQxzLIvkRhF5lEHyBKIw
 ACvnvtmb5P8JoNWWeZMCRDJIezlDZ+yZAPHhOXd/So4hOQgSjs4vT2RNi2xu9cNoFtRG
 ukYNrO+rAGopWc/nDjpMVhdbIsHc3jTrCPv47DASYfWSu47aDAUj+Td4712f3xqZ+lo1
 Dht17hwVvfvZU5Hba3IjXFlYKlNbRIT9CT0YfZKDwxNkJqFhs02BDlUD9GM8opNH9pG4
 D4jJT1llIzqOh01prmNSMTpgqOB/wq/izd0Gks2MN8opEO7h/ql+Vpi4taem//kEYUXo
 j9Zw==
X-Gm-Message-State: AOJu0YxRupx6eCTGuftRGLCjT4Smbw4zXoiFJE/oHb+T8cfHBXnJIkSl
 l+0x9OfgHOHccTfyNJpmrDepR1GU8fpYwEQ0WukxOpRJ6IV2+aD1vnw4Zmmxf3THymnobunlshS
 5
X-Google-Smtp-Source: AGHT+IE68Xp9uYsz8GoBgAvFoyhhtpuLIVfCio7Nc/OqS7em6mWgxaWCMUiI+Eqtc2n/9AIro/oU+w==
X-Received: by 2002:a05:6a00:3d44:b0:6ea:bf1c:9dfd with SMTP id
 lp4-20020a056a003d4400b006eabf1c9dfdmr14465987pfb.27.1712639003022; 
 Mon, 08 Apr 2024 22:03:23 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/28] target/i386: Add {hw,
 sw}_reserved to X86LegacyXSaveArea
Date: Mon,  8 Apr 2024 19:02:48 -1000
Message-Id: <20240409050302.1523277-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

This completes the 512 byte structure, allowing the union to
be removed.  Assert that the structure layout is as expected.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 5860acb0c3..5f9c420084 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1419,23 +1419,34 @@ typedef struct {
  */
 #define UNASSIGNED_APIC_ID 0xFFFFFFFF
 
-typedef union X86LegacyXSaveArea {
-    struct {
-        uint16_t fcw;
-        uint16_t fsw;
-        uint8_t ftw;
-        uint8_t reserved;
-        uint16_t fpop;
-        uint64_t fpip;
-        uint64_t fpdp;
-        uint32_t mxcsr;
-        uint32_t mxcsr_mask;
-        FPReg fpregs[8];
-        uint8_t xmm_regs[16][16];
+typedef struct X86LegacyXSaveArea {
+    uint16_t fcw;
+    uint16_t fsw;
+    uint8_t ftw;
+    uint8_t reserved;
+    uint16_t fpop;
+    union {
+        struct {
+            uint64_t fpip;
+            uint64_t fpdp;
+        };
+        struct {
+            uint32_t fip;
+            uint32_t fcs;
+            uint32_t foo;
+            uint32_t fos;
+        };
     };
-    uint8_t data[512];
+    uint32_t mxcsr;
+    uint32_t mxcsr_mask;
+    FPReg fpregs[8];
+    uint8_t xmm_regs[16][16];
+    uint32_t hw_reserved[12];
+    uint32_t sw_reserved[12];
 } X86LegacyXSaveArea;
 
+QEMU_BUILD_BUG_ON(sizeof(X86LegacyXSaveArea) != 512);
+
 typedef struct X86XSaveHeader {
     uint64_t xstate_bv;
     uint64_t xcomp_bv;
-- 
2.34.1


