Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD212E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Xj-0001GI-3l; Tue, 07 Jan 2025 03:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X3-0000JS-M9
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:46 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4X0-0002y4-R0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:45 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166360285dso224235715ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236901; x=1736841701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hXNhITSRxm0szT46Zs5pcTERA4MwJjF3kXEJOZEuyw=;
 b=TSXzIHJrUxqFaGz0k5dBhYqRBAabPFQcPbDjEx4CM+Ot4Ad9WCyE5nVyB7vs04tj1L
 3to6WayTNZ0fq/hehwFr6Iav3xwVKDTBPe1DeMF76VjCa81HLMEyI/DnTJVZFUa0Rg7o
 E6ZUMVVyso9FEappH5IVUQL33iJ+1KGpZyK71hYjqi6qnzgnmMxm0RUWLkPuaX4/m/Pq
 lNXLuFDoYO+wDoyPJH6EeWF9bvp5yCLl9PP9uWMO226totUwvCA7I/p0sS6uukxCdEC2
 JBv7xSm7olrS197cEIe6dfm9j7jdBCcdWiE/NCwyGLkZTWy4QNVoBkC4GQLTWAOdr6KE
 BlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236901; x=1736841701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hXNhITSRxm0szT46Zs5pcTERA4MwJjF3kXEJOZEuyw=;
 b=B/FjRisDzBJfH/Do9A75H71XgdQ9xxEIVN42WKopp5A4Adp2aLG2CY6vZyyV9QxcxW
 B/sT1aXZbk6sIXeqZ/9LyP+7aUcEvJ85rBl4aD+4hEO0w/Vo55qskKVzutEGY6a0sWE0
 neUzAbXE1lOMQKD6VzMted7QhG0ibNfIU8hRuSWLXN9McbCCL3K2wMxa8gtLRkBz4Mm2
 QOf8zQJEQn31i8D1MyXq+iwdwm0Y1G3G9Sj1BnMFmkp4ncfQ/tQGMNfNhgX92xOq7DZk
 HUzUKDUmu8EYXoNoQWDJmqCW7VpcLGXv1h3mayVi/oK1+vH4cKl68pUqDg6D8xGSV8a+
 m+yw==
X-Gm-Message-State: AOJu0Yz5OtK6lWlmMbjzNxVAAhVN1kCwUOtM14nQkhGVn9ocj+u1KRG8
 VaOz65Cah0f+nSTYY6k4Rckj2cFksV+27YwhUBzm+B7m+dKsVGwwBNBxeZaZe0/GNCZO7b+dSys
 R
X-Gm-Gg: ASbGncsLOiGOatchySs4BhvBM1/2yrYcUHxmoVj9oanDZXh542BceaAUf2HcVeI9GLA
 GASkO7DeEpt54+tG+wNnc+wQHJIUKBnNIo86jL82XGkcaH5Z+YiEgg1ABlcVo9xX8FHCgvZUDJh
 FQdjzyOpUMZBWnWzh3x+fq8Ab9DzymOOEJ4uO5ByPJe2ERqrtVxyvtkwzkdMGe1hHwrvS6Mj060
 S7IwF2hJOkoZCfpjZr3PuYCQBPZBbG9pMcEHxV4GHzbEJXHLrEMWI2dTp/uzhji4Rx0kEieMzsH
 wuLIxK8371dVn+iOgQ==
X-Google-Smtp-Source: AGHT+IFnY5xBMPI4NT+gqEqHJV2PkPwJD8XtM470BfFT7KBpmrTIiN4A3pOW941IJfHaIWq1ZyxLwQ==
X-Received: by 2002:a17:903:2345:b0:215:9a73:6c45 with SMTP id
 d9443c01a7336-219e6e9dee3mr920455165ad.22.1736236901556; 
 Tue, 07 Jan 2025 00:01:41 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 26/81] tcg: Add TCG_OPF_NOT_PRESENT to opcodes without
 inputs or outputs
Date: Tue,  7 Jan 2025 00:00:17 -0800
Message-ID: <20250107080112.1175095-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

The br, mb, goto_tb and exit_tb opcodes do not have
register operands, only constants, flags, or labels.
Remove the special case in opcode_args_ct by including
TCG_OPF_NOT_PRESENT in the flags for these opcodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h | 8 ++++----
 tcg/tcg.c             | 3 ---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 14aff6e7f9..724e7a9de8 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -33,7 +33,7 @@ DEF(set_label, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 /* variable number of parameters */
 DEF(call, 0, 0, 3, TCG_OPF_CALL_CLOBBER | TCG_OPF_NOT_PRESENT)
 
-DEF(br, 0, 0, 1, TCG_OPF_BB_END)
+DEF(br, 0, 0, 1, TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 
 #define IMPL(X) (__builtin_constant_p(X) && (X) <= 0 ? TCG_OPF_NOT_PRESENT : 0)
 #if TCG_TARGET_REG_BITS == 32
@@ -42,7 +42,7 @@ DEF(br, 0, 0, 1, TCG_OPF_BB_END)
 # define IMPL64  TCG_OPF_64BIT
 #endif
 
-DEF(mb, 0, 0, 1, 0)
+DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
@@ -193,8 +193,8 @@ DEF(mulsh_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_mulsh_i64))
 /* There are tcg_ctx->insn_start_words here, not just one. */
 DEF(insn_start, 0, 0, DATA64_ARGS, TCG_OPF_NOT_PRESENT)
 
-DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
-DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 80744b86bb..cf6d881945 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3371,9 +3371,6 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
     assert(tcg_op_supported(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op)));
 #endif
 
-    if (def->nb_iargs + def->nb_oargs == 0) {
-        return NULL;
-    }
     if (def->flags & TCG_OPF_NOT_PRESENT) {
         return empty_cts;
     }
-- 
2.43.0


