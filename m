Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E002DC561E6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfDE-000478-95; Wed, 05 Aug 2026 13:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD9-000466-Hf
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:24 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD7-0006Ge-OZ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:22 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-81dfdbd86d1so14138557b3.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950119; x=1786554919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HgJmxQG/lgNq5flxOHBgvkaSPD2nZexEe+ywvhh6NXw=;
 b=FD3m5cVdXG7MLSMaBPUaV2nfDRLMZD5SyFjP3K9hoZJwamrA8b9CcjkQinEoEKjjYE
 Xr6DDufc4HH1m6EqMR00DeOLXtp2wsdMREtvXTocTLq5d8RkiD1ePsPVLpi+9YzHMUS5
 I1y4RT7Gm6O9bQ2F8J8YAEMJY2cN4nBjUEsbN+MP4GlVZrqZID8p6k7aDkA+7t1Ws80E
 2TXR4TsEZbRU4V0H3yEnQXmOoH6UY0kq8slPTmwwW5+8aoZSQWQZzcNpyuxSjk4+o3S+
 kY8LmPJA1dWiIjxJKfquDrK3hnD3ZX1bJpPiiDE4Sc/gwd7jIBoTadSjrDpO+s9wetE5
 tt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950119; x=1786554919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HgJmxQG/lgNq5flxOHBgvkaSPD2nZexEe+ywvhh6NXw=;
 b=stT+3r7NSbtQU4XNrg+MCH3wVEnOziKoh95O/RcMbSdKR8LuNevvb2gYw3qdqulISy
 wHGRmtB6XVEXsx91Sv5mKoLTHFqQHZMaJT+lXJDZX905G+IZsc6vzUJ5hwzYBmbu7aLn
 0HFZ46ulVnZDMVaJigMxM6ZPsP0jHxOsHtVn/TW1LWjTsIuu0xyj43quas3pP/Uma+ok
 Zc/ya0+SMh6/23ClT7dTxbI6jZh8JFpXoa3HGvxHPys6p1uKnDlwaj/K9xtRi3EnEUyV
 OQyleGvcDT9cnODmwIWnzO1upnIDocoaoFgfqVgQxNwlWirZGbYsfFusO0PkduLJpQq1
 IKKg==
X-Gm-Message-State: AOJu0YxbcVo30jq+BxOZTG2CRfGRRitygVBetICbrVgyCzJittorxyRG
 oDoU2GyKsDV4mP3RLMui9KziaAgbYROTrAxRzpRPddzYKBEhL6oXLSy+nT34m9QuGPE=
X-Gm-Gg: AR+sD12nN1vCSE/vXAwPyMV7o5dcTebYhj6sYiskts8LGuTLqxW1cTcxwAjqTRYk9ss
 QetLmJ669bwGLocAwgIwNI1vkVt9O5v3cKGoWvztmU0Y1aCSZfI2sg3HRo3mkfoo8OiMI6OW2Aa
 EOLyuEcB9zarjENyUudLhIVgBI0KjLAO2GeIL1kaBKP7n2fCtUrFSUnKJQMMp6QnsWvoJLhqiyB
 T3DwYBipUoXAkEGlRSMm00ZjGjo2jxYZ+KSHS2IMovi/unJhX3DJuHOVOh4loTAY3kxGQG4QKZK
 EMwcf9ZlJ6lfF+IdQQjFnyxoNFdZYULsGseN9AZyUoA7ZmmIj5v7rR5xmeZwQDxDCdhofPSmS/D
 ouX9i2MIJ0oVyb1rD5hsMu1DVwv4mVCb2Rrd+yKmkFFLUE3DsRDw/mWPluol8dmEZJYPbv7Eqej
 OZjnmvX4+eFx5hbEbWIZ62sO2hI7y3oBU+Wz3S70ku+L2O7uwDG6gTlTnAz8kQ8ExH9DqRgBk=
X-Received: by 2002:a05:690c:630d:b0:812:996f:176d with SMTP id
 00721157ae682-8202230782fmr49443117b3.9.1785950119381; 
 Wed, 05 Aug 2026 10:15:19 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8201341ca2dsm24371757b3.25.2026.08.05.10.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:15:17 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/5] linux-user/sh4: write the floating-point registers to a
 core dump
Date: Wed,  5 Aug 2026 13:15:07 -0400
Message-ID: <20260805171507.3119442-5-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805171507.3119442-1-mattst88@gmail.com>
References: <20260805171507.3119442-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Write an NT_FPREGSET note for SH4, matching struct user_fpu_struct
from arch/sh/include/asm/user.h: fr0-fr15, xf0-xf15, fpscr, fpul.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/sh4/elfload.c    | 10 ++++++++++
 linux-user/sh4/target_elf.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git ./linux-user/sh4/elfload.c ./linux-user/sh4/elfload.c
index f03ce49e7d..41601626ca 100644
--- ./linux-user/sh4/elfload.c
+++ ./linux-user/sh4/elfload.c
@@ -52,6 +52,16 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     return hwcap;
 }
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUSH4State *env)
+{
+    for (int i = 0; i < 16; i++) {
+        r->fpregs[i] = tswap32(env->fregs[i]);
+        r->xfpregs[i] = tswap32(env->fregs[16 + i]);
+    }
+    r->fpscr = tswap32(env->fpscr);
+    r->fpul = tswap32(env->fpul);
+}
+
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
     for (int i = 0; i < 16; i++) {
diff --git ./linux-user/sh4/target_elf.h ./linux-user/sh4/target_elf.h
index 3fcb63d409..5923022036 100644
--- ./linux-user/sh4/target_elf.h
+++ ./linux-user/sh4/target_elf.h
@@ -25,4 +25,16 @@ typedef struct target_elf_gregset_t {
     struct target_pt_regs pt;
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches struct user_fpu_struct from arch/sh/include/asm/user.h.
+ */
+typedef struct target_elf_fpregset_t {
+    uint32_t fpregs[16];
+    uint32_t xfpregs[16];
+    uint32_t fpscr;
+    uint32_t fpul;
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


