Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED649C3ABA0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Ww-0000F5-59; Tue, 07 Jan 2025 03:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wf-0000C0-RY
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:21 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wd-0002sl-92
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:21 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef70c7efa5so17813253a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236878; x=1736841678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEqZADn63Oa+qbZio+VyWEMyVUQ4PiekMxjAmvOz7HQ=;
 b=Uh2zOhooqjHIeYIY7mPF2wTH1L8Kd2V+n7y3jm7mBRIvZ8G1Ddh0i8S98em1/42jlT
 Vyx/dxjRSzNQJaT7Ra4a1uHU1T/jMY9uWF5T5VXE2Uq11UNAVw5DEk+baoxWhiwnH8+0
 nMmMyB23svrsV/DfjskREgpbPzNvBPXUWwjx9w/S1wieRLPoTvQmHhUGHKSuuIJTuNjl
 0XsVzx5+VGRx8Ef/VEfzUXKIQMuMkpf8LkM9nBUTg4Dv5RdXdyqK+4NmeqQCcPC8CqCw
 R6Cp4/0b0xBE9nhwWMeo3k9lbDeV2cnC4F9Pt/Ca4hYVizNTOECQOAuGhKjkFcCdPcgW
 N6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236878; x=1736841678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oEqZADn63Oa+qbZio+VyWEMyVUQ4PiekMxjAmvOz7HQ=;
 b=GH//FS4fgiFjyduOhJkvU6/VvsX6rlfREyIFAN95BFxxU69QDKxhMu0j8ITTx/kP3Z
 qXZyP31A/JmIHMmKmNo3Zrl58RlTwThnIbpETtXmVc49AZZnDyGujgaEGHSWhLBTIeW2
 bcVVcL24PRYfYfrbdPV2c/61GJbrloywWrQa0ugskLl76wOnBc11bQuirJ2VcaaJuOsJ
 Ai/c0S6AVa4v85/TgXyzpB55ETKyWsOFDPLZOpbc8N/N26lsXgjgfIKImXAZztICoItl
 CgMCMDrew/0zSopB+tfPf/52uPWhVJqB6rtq5nRkrwvJJN8c6CDQBD4HA4GhA7ImjnAo
 F0PA==
X-Gm-Message-State: AOJu0Yx8wv/VbQo4mSq7Df+EWrw/s7so1JE7TEYL8LSPpMoEYCZWg4Zc
 sxgH5414R6p6KY1bqICpS4zqfO3TQb4LvYUjtuwbFzkEO3vcHSKk1kbrL1qrIf3C0IlMlbDLg6C
 k
X-Gm-Gg: ASbGnct2btLpiJgE6o70NyGiLwSRQXv6pg1NJahd6HPweIRIqo975noWVpKWM739aQk
 AVOft78EyGI+E0XSJNMNGQjgKz8RtMnjkcjMVi9pYWOl0fMSdKa1mKqtrIAWGheSfkK3THxlb35
 qOxndIJlokhjp3o9nldSPr5bfV19ejhxUmhbbc1AnkU8TCXE5uV7dZtENCzXTNiem7dRyc/pj9l
 Vd//p9Y1e0glpm9T3wwXY51xkTY1YgPjgkQAG4XfAFaUCNDIKGGD0ToCsDl4ZJ4aYWmMLWXyv/p
 xf/KDviKGhy9cKUi8Q==
X-Google-Smtp-Source: AGHT+IFz/Xmr11DhFGFV8YWOn1Kn83waoZVu74gL1cdB4eRKOivBXndF55uVaEDZS9BABxvMC9Oc1A==
X-Received: by 2002:a17:90b:5188:b0:2f5:747:cbd with SMTP id
 98e67ed59e1d1-2f507470dd8mr24703823a91.18.1736236877765; 
 Tue, 07 Jan 2025 00:01:17 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 03/81] tcg: Move tcg_op_insert_{after,
 before} decls to tcg-internal.h
Date: Mon,  6 Jan 2025 23:59:54 -0800
Message-ID: <20250107080112.1175095-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

These are not particularly useful outside of optimization passes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h  | 4 ----
 tcg/tcg-internal.h | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index fe053296ac..5d96cdfc30 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -854,10 +854,6 @@ void tcg_gen_call7(void *func, TCGHelperInfo *, TCGTemp *ret,
 
 TCGOp *tcg_emit_op(TCGOpcode opc, unsigned nargs);
 void tcg_op_remove(TCGContext *s, TCGOp *op);
-TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
-                            TCGOpcode opc, unsigned nargs);
-TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
-                           TCGOpcode opc, unsigned nargs);
 
 /**
  * tcg_remove_ops_after:
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 072b36d85c..a648ee7a0e 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -106,4 +106,9 @@ void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
+TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
+                            TCGOpcode opc, unsigned nargs);
+TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
+                           TCGOpcode opc, unsigned nargs);
+
 #endif /* TCG_INTERNAL_H */
-- 
2.43.0


