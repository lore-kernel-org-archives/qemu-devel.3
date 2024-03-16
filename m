Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23ADAC54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJH-0002xr-F6; Fri, 15 Mar 2024 21:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ4-0002ra-3g
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:54 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJ2-0000lW-G7
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:57:53 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29de4c33441so1467807a91.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554271; x=1711159071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4/P6RWm6w7Ud7tHYlYhwMNF/R2rr67Q03MPgnoMVeQ=;
 b=XT2cDvRcs9v1z7XDuYkT2v6GLve2SGglhG7IgEKj/bMFS0PHH/mx0qqlrpU1CD9Bs7
 R+1b+c9NHcGKR2+p5NMmh8T/ZRZnB5tlTBYtO7aWTt4J/5HDumo8ROVhekSIZVZ7Duv2
 LQH71ChXGhcl2TVCjBY1GCFzfvSqcpm4Cft6KvDrcbRyVm+WppHEaidxyFu+ahlktpVF
 w/JFzKun4DZCEJRteFUvUQJ7vAHoiF65Vi9qbzmWzMd4pHFdFA6u1C57jgxkd7QiVX7L
 j3ofxdOr7mmCG63TNRz2tuyVsZcVCdZYcnC0uNyRLgHIXiyLSIoE8V89hNEHLnr94xl9
 C3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554271; x=1711159071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a4/P6RWm6w7Ud7tHYlYhwMNF/R2rr67Q03MPgnoMVeQ=;
 b=jpJAZHexfk6WNN5adjRJArw5qLXdxTBw+jsKWrk4V2xKmw0YbIJhN++ZkiHD9GbVkY
 u1Kx8+gmZAHEXhWF5NTHlfQyt20whyQh/iHy7rKx07X4MRhlAfCPU2G8JeyFNXjCk++U
 dUffGUQKibYgMXeCmUDwsbHPG/DDIiI8Xkictz8i8qRxgVBZtJrrACyH/dloG19+TKNs
 sdhgRlCo4eNkPjz/OMX2E9XA8AsRHdmVfdKvnvq8qJ4EFiYY/Sv+Kum/mfd/KikReLoK
 2qh+72tyrJy/fnadZdmcdmZA5W76nwsjY+IQYDTmNsv1jS8nXibeexJP0lCUZf5rl5ry
 NxBg==
X-Gm-Message-State: AOJu0YwnMWe+gU/VPDd/ZYF/Sr5Ebyo53h3tCgkV04mwG8sJtIbe58D1
 Ttd4VcMBr3qRxXHocZtzgQGsNSX19hb4wtYcnLxbIFnEgW7Irus6RWlaLA0xCJRa1KxPhUZ/Qgh
 D
X-Google-Smtp-Source: AGHT+IER7hahu9Bz95UeDTFUDA/iqNGXaOLZU4ukf7dZR96GT5hLU+nWSZN1tSDCJz/uQ9125hCCgQ==
X-Received: by 2002:a17:903:943:b0:1de:de26:f6b3 with SMTP id
 ma3-20020a170903094300b001dede26f6b3mr6499331plb.26.1710554271164; 
 Fri, 15 Mar 2024 18:57:51 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:57:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 13/22] tcg: Remove TCG_CALL_PLUGIN
Date: Fri, 15 Mar 2024 15:57:11 -1000
Message-Id: <20240316015720.3661236-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Since we no longer emit plugin helpers during the initial code
translation phase, we don't need to specially mark plugin helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  2 --
 plugins/core.c    | 10 ++++------
 tcg/tcg.c         |  4 +---
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 95a7f4d010..df66e8f012 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -353,8 +353,6 @@ typedef TCGv_ptr TCGv_env;
 #define TCG_CALL_NO_SIDE_EFFECTS    0x0004
 /* Helper is G_NORETURN.  */
 #define TCG_CALL_NO_RETURN          0x0008
-/* Helper is part of Plugins.  */
-#define TCG_CALL_PLUGIN             0x0010
 
 /* convenience version of most used call flags */
 #define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
diff --git a/plugins/core.c b/plugins/core.c
index b0a2e80874..b0615f1e7f 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -339,9 +339,8 @@ void plugin_register_dyn_cb__udata(GArray **arr,
                                    void *udata)
 {
     static TCGHelperInfo info[3] = {
-        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         /*
          * Match qemu_plugin_vcpu_udata_cb_t:
          *   void (*)(uint32_t, void *)
@@ -375,9 +374,8 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
         !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
 
     static TCGHelperInfo info[3] = {
-        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG | TCG_CALL_PLUGIN,
-        [QEMU_PLUGIN_CB_RW_REGS].flags = TCG_CALL_PLUGIN,
+        [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
+        [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
         /*
          * Match qemu_plugin_vcpu_mem_cb_t:
          *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0bf218314b..363a065e28 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2269,9 +2269,7 @@ static void tcg_gen_callN(void *func, TCGHelperInfo *info,
 
 #ifdef CONFIG_PLUGIN
     /* Flag helpers that may affect guest state */
-    if (tcg_ctx->plugin_insn &&
-        !(info->flags & TCG_CALL_PLUGIN) &&
-        !(info->flags & TCG_CALL_NO_SIDE_EFFECTS)) {
+    if (tcg_ctx->plugin_insn && !(info->flags & TCG_CALL_NO_SIDE_EFFECTS)) {
         tcg_ctx->plugin_insn->calls_helpers = true;
     }
 #endif
-- 
2.34.1


