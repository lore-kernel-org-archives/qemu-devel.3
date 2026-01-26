Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C688EC88E58
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkGmZ-0005yi-PX; Mon, 26 Jan 2026 02:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeI-0002kU-Ip
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:05:05 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vkGeF-00044d-LW
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 02:04:33 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-823075fed75so2179036b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jan 2026 23:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769411061; x=1770015861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QiBLBmuJrU9Jg04Dyfz191OWwD91URVjxfllKljJsDk=;
 b=Wdm9ASPCae7FvJSrkCKvAD+xiQnw9mvMphcPKZQAOh9hoiol4ElgsZnhwbQEhQOuAs
 CIqLi4ZVSvr3ebFwePhjSLnim80v4LpmG0W1oD64/EhJXWVV084DQn13SNdkqK4gd4Yv
 fT3i7/lRNAPVru6FNYsaK1izIoej86lA+dB8rtDUEG8MdP/kYRKFOQNAI0vKJRNCDXxi
 QlAyQqBncu6rtvu47XUj7U0vnH/rbrdre6j2x2hApigWIxwfiFvBvbIP150gLUKZhdii
 xByBxc9C6s+dN/8ZdTu64FkVwclIIDLyBMQoSB+46pC5TPAMGZX9LpUROhQHqMuTvEd6
 577w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769411061; x=1770015861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QiBLBmuJrU9Jg04Dyfz191OWwD91URVjxfllKljJsDk=;
 b=OpI9gZ87MfOSCwqBzitERC2kGLnh92tKMKS0WDk5TjD5xyG0yZ+EsyI4bOFOkzKjzZ
 e5ce3QU6CfLBewZ4E3Km/gOjXrcKCRH65j03eSXZhrztXu4d815IptgVoSx7R3EtUi7t
 4kb5uWqYDLmAVIIlnDyioZJ0k20+I2xVSbOL4ZldBWc1/rUQzKcm4MwSVRy+XnymMYuu
 O3FhU48GdS8DWtUeIi4tBr93BYtO1KAYv/3y9ay6fDjeeQvlbDRgEyWUVoUQ/GmxvM1D
 YlfCqyX2iACxr21OOWVx1GhilyQ/cpyV1C2dq0ThK6rwFgCJ7azhhiHpEFuTejoKRg72
 DcGg==
X-Gm-Message-State: AOJu0Yysc5F9PGVJLOYiol/EVVprJ34a6SAL48hFjQTMdcP2tjy+NGoV
 n/4tEwz+Vev5KlvDn5axm8+E6+/oVqHahCOVMI3Permp/siyLyNIKQrNiwq+eSmy
X-Gm-Gg: AZuq6aK2XnAQ8pvCOi/nC+fPUrlZ7IiXNdFau+8Ihd94TB3ewdaOpHzCWWg745CYAst
 UodKfUf0cFO03yQbUGci/eKRZdebchMocnSP4VP8fDi49YmoWdUAy6HI1bUZUXOFq9U5eHxEpsL
 xDKtJmNr+RYWv5McUgSW9n5wFvP2OFE5nRbrfD7uGFArtEM4OJwlQRNc7iFYTN8REhBdvQRTqMp
 JeUsi+si04ppWkFpvLb9lHmwi9Hffa8tPoRX+D3vm8gm2233rlpdIEwlrw3eh8V2X2TflpzZ4bz
 MQXuQFLctyQlu3QuZNE2DHo/1WXnvqpPzzjeC5LqqcyqEGk8sr9ggqCYD6SPjuP5d+hBA+Cx7sh
 WIBoayiF3LpivD6pkwBUknqQNoH7bZ/ij5eUt7ACRfv/5xxyOx4hcsmS7pN9WGjqhbFDObV+1pM
 YOKqfDI9lCq5WipJ41i63Zbb0HO0OhDjjBy+wCO0xzfg==
X-Received: by 2002:a05:6a00:22cf:b0:822:6834:9abc with SMTP id
 d2e1a72fcca58-8234129c3c4mr2979648b3a.24.1769411061316; 
 Sun, 25 Jan 2026 23:04:21 -0800 (PST)
Received: from brahms.. (fp93c00990.tkyc601.ap.nuro.jp. [147.192.9.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-823187716ebsm8661487b3a.66.2026.01.25.23.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 23:04:20 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 03/33] tcg/wasm64: Add constraint definitions
Date: Mon, 26 Jan 2026 07:03:16 +0000
Message-ID: <e8e8ce20cf8ba879a690ad579d45fb26b5b6f517.1769407033.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769407033.git.ktokunaga.mail@gmail.com>
References: <cover.1769407033.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The Wasm backend integrates a forked TCI so its constraints are defined to
remain compatible with TCI.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm64/tcg-target-con-set.h | 19 +++++++++++++++++++
 tcg/wasm64/tcg-target-con-str.h | 14 ++++++++++++++
 tcg/wasm64/tcg-target.c.inc     | 13 +++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 tcg/wasm64/tcg-target-con-set.h
 create mode 100644 tcg/wasm64/tcg-target-con-str.h

diff --git a/tcg/wasm64/tcg-target-con-set.h b/tcg/wasm64/tcg-target-con-set.h
new file mode 100644
index 0000000000..0dc41ebe33
--- /dev/null
+++ b/tcg/wasm64/tcg-target-con-set.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Wasm target-specific constraint sets.
+ *
+ * Based on tci/tcg-target-con-set.h
+ *
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
+ * Each operand should be a sequence of constraint letters as defined by
+ * tcg-target-con-str.h; the constraint combination is inclusive or.
+ */
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O1_I1(r, r)
+C_O1_I2(r, r, r)
+C_O1_I4(r, r, r, r, r)
diff --git a/tcg/wasm64/tcg-target-con-str.h b/tcg/wasm64/tcg-target-con-str.h
new file mode 100644
index 0000000000..21ddbcc01a
--- /dev/null
+++ b/tcg/wasm64/tcg-target-con-str.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define Wasm target-specific operand constraints.
+ *
+ * Based on tci/tcg-target-con-str.h
+ *
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * Define constraint letters for register sets:
+ * REGS(letter, register_mask)
+ */
+REGS('r', MAKE_64BIT_MASK(0, TCG_TARGET_NB_REGS))
diff --git a/tcg/wasm64/tcg-target.c.inc b/tcg/wasm64/tcg-target.c.inc
index 3affc17232..0b12c4ea03 100644
--- a/tcg/wasm64/tcg-target.c.inc
+++ b/tcg/wasm64/tcg-target.c.inc
@@ -75,3 +75,16 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     tcg_debug_assert(slot >= 0 && slot < 128 / TCG_TARGET_REG_BITS);
     return TCG_REG_R0 + slot;
 }
+
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
+{
+    return C_NotImplemented;
+}
+
+/* Test if a constant matches the constraint. */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    return ct & TCG_CT_CONST;
+}
-- 
2.43.0


