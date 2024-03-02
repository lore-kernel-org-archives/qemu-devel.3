Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04991C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgIMX-0002at-FU; Sat, 02 Mar 2024 00:56:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgIMW-0002ag-4Y
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:56:44 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgIMU-0000cQ-9q
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:56:43 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-21fa0ec227eso1400275fac.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709359000; x=1709963800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHzxeZahoeOHL3vAMHqU3P9pcDfqE42pzi5+X3i2bNc=;
 b=HYF/nT8Yy4c8dJrJkJp6k0daR3MbLDFjHKJR/mduCX1sdgy5Jac2CI1RJNcuvAMfWW
 vwuC09nlX1alIcfvdkqCxPZkgEl00/Vv+Pb37S+asUgm7GvueTi/U4Z1+dUFUrMVWNSV
 SGFDOpIsaUbTTUyRMBsooMGxPoGKis/cekJAvlQpjZNnQ9SRBGICPg7Imvb18RD+71QA
 K+g2y1LG8YvETS94SNG+Kt/oMu6LXCXuntlNgiu/N23alRdk2b//p0nZV1XXeRsNMpAI
 HdrOoSTnFHfh3VR8lvwZShFANzj1xyqR7nYcZ1YLd1n9urJDgeVAGFntfi7EnCa9BPtT
 3Cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709359000; x=1709963800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHzxeZahoeOHL3vAMHqU3P9pcDfqE42pzi5+X3i2bNc=;
 b=PchPp2j+ScdIAkXsIvoAYpf679yYmQ6tedoKt4uFq5Q85U8WEQgEXZYesxUZ3Q4L7p
 QUP8poOzw+L+hcJMus7TiJO+TUuUpCFHpfK0bYhKehcmmA3X1bL9hNa1s4ZXukCOZ7Gy
 fcDQH0W5YPhp43FbgkpviLuIMyMf4tup71HkL8Lqn17qtKZP3hxOHO6Xh5E/Ibmi+sl6
 Gnia2Pc3La4eSF6QRiiHv5ghpbMGASnWJ0RjOyJdhkwwZA7McjXexNYxJ66NqfOiuVE2
 Z1vEMhR+ulgCvIf3JtqBk8XOXhrnnuxrAl5Fkrpg2HXE/WC6mlldSZQd0os6PvzjTcXE
 y/zQ==
X-Gm-Message-State: AOJu0Yx4mUkTD6Jc2rdrgI5EgBX2wngU+2p6PiblYHoNjWZxvbj0NmD6
 LoUi7T5nxvXB/4M9PK/17KvKM36pQelRFeCMsNr3Y8VrTyFsYakgVze74eGxborIneyZKcXrjet
 1
X-Google-Smtp-Source: AGHT+IFa+d2fIc1mHHhGanx233cpKPpv4VzDZPa7g9e4zWQK9NRqrU8BcAzQGlfx6jciw0U2P44qSA==
X-Received: by 2002:a05:6870:23a9:b0:220:c50e:9133 with SMTP id
 e41-20020a05687023a900b00220c50e9133mr3390532oap.45.1709359000565; 
 Fri, 01 Mar 2024 21:56:40 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a62e10d000000b006e560192a7dsm3830448pfh.105.2024.03.01.21.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:56:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 40/41] target/sparc: Implement monitor asis
Date: Fri,  1 Mar 2024 19:16:00 -1000
Message-Id: <20240302051601.53649-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ignore the "monitor" portion and treat them the same
as their base asis.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/asi.h         | 4 ++++
 target/sparc/ldst_helper.c | 4 ++++
 target/sparc/translate.c   | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index a66829674b..14ffaa3842 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -144,6 +144,8 @@
  * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
  * and later ASIs.
  */
+#define ASI_MON_AIUP            0x12 /* (VIS4) Primary, user, monitor   */
+#define ASI_MON_AIUS            0x13 /* (VIS4) Secondary, user, monitor */
 #define ASI_REAL                0x14 /* Real address, cacheable          */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
 #define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
@@ -257,6 +259,8 @@
 #define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
 #define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
 #define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_MON_P               0x84 /* (VIS4) Primary, monitor         */
+#define ASI_MON_S               0x85 /* (VIS4) Secondary, monitor       */
 #define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
 #define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
 #define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 1ecd58e8ff..82cf4ba074 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1371,6 +1371,10 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_TWINX_PL: /* Primary, twinx, LE */
     case ASI_TWINX_S:  /* Secondary, twinx */
     case ASI_TWINX_SL: /* Secondary, twinx, LE */
+    case ASI_MON_P:
+    case ASI_MON_S:
+    case ASI_MON_AIUP:
+    case ASI_MON_AIUS:
         /* These are always handled inline.  */
         g_assert_not_reached();
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5694420a93..15c9d5b59a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1622,6 +1622,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_BLK_AIUP_L_4V:
         case ASI_BLK_AIUP:
         case ASI_BLK_AIUPL:
+        case ASI_MON_AIUP:
             mem_idx = MMU_USER_IDX;
             break;
         case ASI_AIUS:  /* As if user secondary */
@@ -1632,6 +1633,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_BLK_AIUS_L_4V:
         case ASI_BLK_AIUS:
         case ASI_BLK_AIUSL:
+        case ASI_MON_AIUS:
             mem_idx = MMU_USER_SECONDARY_IDX;
             break;
         case ASI_S:  /* Secondary */
@@ -1645,6 +1647,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL8_SL:
         case ASI_FL16_S:
         case ASI_FL16_SL:
+        case ASI_MON_S:
             if (mem_idx == MMU_USER_IDX) {
                 mem_idx = MMU_USER_SECONDARY_IDX;
             } else if (mem_idx == MMU_KERNEL_IDX) {
@@ -1662,6 +1665,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL8_PL:
         case ASI_FL16_P:
         case ASI_FL16_PL:
+        case ASI_MON_P:
             break;
         }
         switch (asi) {
@@ -1679,6 +1683,10 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_SL:
         case ASI_P:
         case ASI_PL:
+        case ASI_MON_P:
+        case ASI_MON_S:
+        case ASI_MON_AIUP:
+        case ASI_MON_AIUS:
             type = GET_ASI_DIRECT;
             break;
         case ASI_TWINX_REAL:
-- 
2.34.1


