Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EC0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serJ4-0007CC-SX; Fri, 16 Aug 2024 03:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serJ2-00072y-I6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:28 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1serIx-00041X-Nj
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:23:28 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70d18d4b94cso1381926b3a.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723793000; x=1724397800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3m/SRRubX++Qz/UwX8F/bni9rPp5FWQysduj2u1aeQc=;
 b=GnUZL+5iMDYGmIW3Aen2e3fqKANyf1NKssKjRBJ6x8CpBS26EGyncLxzZdyfyevJbF
 u4wQTK2onBL7SgZ9Ruu1ixrSfLzwKkFV/Y+A2Y8o0Nd7zleVNvxuc+qz2aD6EsqVgAto
 cPdo0yUEetj/hr3jKuOHz2s+fJQapOFus1syu/AhQCpCEIiAm0dXipLF3zO8KtgwUu+x
 +ZqEsdaz7l82cIB3BNP4v4XdP4h8G8qLXCnBGUTxP4rBslcAaPgbQSUx5wfOqVVkurJ0
 TDJqtQa1BgLJPU0U4UiMkxRiuq34rL3P4PQ/BnwqKbVHJj4ZjYbFa8doaqtypTktKaPm
 ccDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723793000; x=1724397800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3m/SRRubX++Qz/UwX8F/bni9rPp5FWQysduj2u1aeQc=;
 b=X21rFg3TCztwVi4++63kQ9aRlOZxZsjRSEwddGh1O2PamHU2gEWCoay5lmR4w/7btf
 XOg88v8DFV2kLRgstMXW6I9ZU4F/Y0aith739jL2MfEBfyicOdM2HPeA+5BLp5ous1rJ
 zFl7l/DJS/lOZaoNdSRTpk9JHuiORfOfs6a+j1M8lb+ImSmR4VJOOczfZ9gFgYc5yZBx
 CtFunnzy5KBTlAxKJLOq6ylDfYqtHnAOUKcaMVD/1DNjwV2qHmyqmuZ+YSXdjRipkLKj
 /9vRmM0YhXcEMzk6g/XTjdBOSXRSD1y5xX3O+5mWyRLFQyZTa64HH24BZ9YF0OP88GtF
 TbuA==
X-Gm-Message-State: AOJu0YxfxrCORdskC+GRxYArR82w3T88/dr1PAeTsr9xTdGbbb79pw8U
 wNboiIJ08LuLILhQZuvbFLomNUBLhm2j2UPn4mKsDDr4rq95xT6IvXvBm47WiVA/PQzvq2zFl3E
 /Dk0=
X-Google-Smtp-Source: AGHT+IHpDA9xq5OUaiic8vvGN77FkN9uYrzYlw8wap0RUvcYN+rEjUDaZRzzIPcRX1X4pnxgqvBaEQ==
X-Received: by 2002:a05:6a20:9d8e:b0:1c8:bfa8:d55a with SMTP id
 adf61e73a8af0-1c904faa94amr2686523637.21.1723793000113; 
 Fri, 16 Aug 2024 00:23:20 -0700 (PDT)
Received: from stoup.. (2403-580a-f89b-0-1b6b-8c7b-90f9-144f.ip6.aussiebb.net.
 [2403:580a:f89b:0:1b6b:8c7b:90f9:144f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f037588esm20195525ad.171.2024.08.16.00.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 00:23:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: chauser@pullman.com,
	qemu-stable@nongnu.org
Subject: [PATCH v3 1/6] target/sparc: Restrict STQF to sparcv9
Date: Fri, 16 Aug 2024 17:23:06 +1000
Message-ID: <20240816072311.353234-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240816072311.353234-1-richard.henderson@linaro.org>
References: <20240816072311.353234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Prior to sparcv9, the same encoding was STDFQ.

Cc: qemu-stable@nongnu.org
Fixes: 06c060d9e5b ("target/sparc: Move simple fp load/store to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 113639083b..c803e8d1ba 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4521,7 +4521,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 
 TRANS(STF, ALL, do_st_fpr, a, MO_32)
 TRANS(STDF, ALL, do_st_fpr, a, MO_64)
-TRANS(STQF, ALL, do_st_fpr, a, MO_128)
+TRANS(STQF, 64, do_st_fpr, a, MO_128)
 
 TRANS(STFA, 64, do_st_fpr, a, MO_32)
 TRANS(STDFA, 64, do_st_fpr, a, MO_64)
-- 
2.43.0


