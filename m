Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93331C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWF3-0001Ve-JY; Wed, 13 Mar 2024 17:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWF2-0001V1-L2
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWEy-0007py-N7
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:34:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-413eee86528so2228745e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365663; x=1710970463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBkHrPM3L+Twu6UqfDL2FrSyFRu3n6fnatxa83i/Hyg=;
 b=I437kgiG66I2bLr5WT0oT0B9o0NyniwhC/BMdRWe4TKKo35fnN6bIgTH1BwGeeC1Cr
 o5JDfgvq2bXcnsFsqzCH0tzyCnNkCN3MzOmpgUuy1A0OZP1fo/c4yCmrxsNYv6bCNdC4
 B0hss/24ZGin+5X60hFwupaP/Qyg4+M86knPdtRJRaz5smobddUEB6Ap9R5g0M24M8YU
 wKLkck4DmiFShN+rx7Xw4oJO+RRWUA8UUbyUhR65ti8BsjRt4xf8ZJRgd4+G6YDhTDnr
 vW4oUbpSK15BH/Pmx4p13kjTQq1MScT/dxO0y7e0JhXGjCtfWc/P7ROPkq2PSrsPJVcg
 4ACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365663; x=1710970463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RBkHrPM3L+Twu6UqfDL2FrSyFRu3n6fnatxa83i/Hyg=;
 b=QQVTGKDedf0rVWhwZEQRmaWLbPOkbvgf6koNc7zyMjxAXi2OQ2E8RIRyuSa/vwgr5P
 5iOJY0yQuZxQxxg6gWbNeWFZH1SaM5MMBTt5/TLfqVNlNC/gafBFDxihP+h8tLMKoCaU
 AdGOuHpiaEjBGjpCwCykeDxPHkYdSDvc58Unogc8VkRrJTiYcl61oFDqo8ccQU/wLSPR
 i8YiAjitFi0tFlcUwroXOacdJkqJ3+V4CPsKZ5EtzBcamxqt5VVzLDmgCpXwHw769KhG
 cfv3sKgHoPR6p0lk856n+PSBdnarDALM6ogKBxrjzeO95VW2PqANfMWaibO9KrjaZ7bG
 lUEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHUrBrygIX6CPzrrAL0V2fhavBCAj4bHu8xTbMo337T8PaA/7HCK2e9LXn9dVCstG/pKyEogtFc2IVdHoh6+46lULttD0=
X-Gm-Message-State: AOJu0YwWdWTgpepqM/qjmJI+W1+Fh/gE5LX3TMLMrm7d/5jvd0xkiC7X
 ABWbvk0ORMOlo4KHf18OM0p0EhN9etKlT3JDNW3u8VNySWO2t7r2/grCFH8LxII=
X-Google-Smtp-Source: AGHT+IEWLRD6Rh+ERvL57+fMf1xEvhJUJETwoZ1vcdA8xOEE01AU/8Y6q9JfqJq+DbaVOo4wDpWZRQ==
X-Received: by 2002:adf:e8ce:0:b0:33b:62c0:6181 with SMTP id
 k14-20020adfe8ce000000b0033b62c06181mr2353388wrn.42.1710365663045; 
 Wed, 13 Mar 2024 14:34:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 j30-20020a05600c1c1e00b004133825e6cfsm3459020wms.24.2024.03.13.14.34.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 13 Mar 2024 14:34:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-9.1 06/12] tcg/sparc64: Check for USER_ONLY definition
 instead of SOFTMMU one
Date: Wed, 13 Mar 2024 22:33:33 +0100
Message-ID: <20240313213339.82071-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313213339.82071-1-philmd@linaro.org>
References: <20240313213339.82071-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since we *might* have user emulation with softmmu,
replace the system emulation check by !user emulation one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 176c98740b..56915a913b 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -78,7 +78,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_REG_T2  TCG_REG_G2
 #define TCG_REG_T3  TCG_REG_O7
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 # define TCG_GUEST_BASE_REG TCG_REG_I5
 #endif
 
@@ -961,7 +961,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, SAVE | INSN_RD(TCG_REG_O6) | INSN_RS1(TCG_REG_O6) |
               INSN_IMM13(-frame_size));
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
     if (guest_base != 0) {
         tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG,
                          guest_base, true, TCG_REG_T1);
@@ -1075,7 +1075,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->aa.align = MAX(h->aa.align, s_bits);
     a_mask = (1u << h->aa.align) - 1;
 
-#ifdef CONFIG_SOFTMMU
+#ifndef CONFIG_USER_ONLY
     int mem_index = get_mmuidx(oi);
     int fast_off = tlb_mask_table_ofs(s, mem_index);
     int mask_off = fast_off + offsetof(CPUTLBDescFast, mask);
@@ -1147,7 +1147,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_bpcc0(s, COND_NE, BPCC_PN | BPCC_ICC, 0);
     }
     h->base = guest_base ? TCG_GUEST_BASE_REG : TCG_REG_G0;
-#endif
+#endif /* CONFIG_USER_ONLY */
 
     /* If the guest address must be zero-extended, do in the delay slot.  */
     if (addr_type == TCG_TYPE_I32) {
-- 
2.41.0


