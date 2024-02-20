Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31161C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLsW-0000Cb-Tf; Tue, 20 Feb 2024 03:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsS-0008TX-KT
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:24 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rcLsN-0008CX-Ig
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:53:24 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a3e87b2de41so179876966b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708419198; x=1709023998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkp6172BQTI4XTV/rD4fH3YQaLWfoOyj86RHXRoWlp8=;
 b=DQmvYRP75IQi1PnWKraQGBp4ckE3Jwxjlz6HtfOlmkI8taj72clejy7BOVMx8tNjz8
 rK4U7PJc3dvcoDgMCHH8SIbQrpJXjaD4FwUHVTg+GFiLzhh3ePYfWN4ColjwQtVQW5jb
 iTcuN7OiNBkMeaN96a/uFh5M2yqL3sljT3RKqUbKmO4aKI3ObXNv6JVZOxDdqC02It9j
 XvfNWSGtq1IV6FGEcQ4TssB6STPh3nU66IqYl8WIRlmPOZQWOaJxA47xl05ppJypQazX
 Gu7ot3xFpnZoDt7UnKzHJqWqxazlNthXeCHYQyHzoXymXGat7gCYVfjE/fqa5RhvmfO1
 4fpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708419198; x=1709023998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkp6172BQTI4XTV/rD4fH3YQaLWfoOyj86RHXRoWlp8=;
 b=S/Ve8ZZtA1MYkBERx5SLG9dj7KzSaQ0LlCB6GnuORUo0mdYh4JvZu41774R6kYWcdh
 3woMMdEEcHLXedbjip2/0JYRP7NKWRnHzVSDYbvW96OSAMBWVM4ygu8xGoLiDS1WVDT+
 lKWIPuyZo3TYYnSaBpZWTdEQ8t5+CJceGHkzFtT9jJ3g9oAOmN48vm+zMLB9YYc8VSb2
 93YNPQOx7GF7rx9e1IfisAWj86SMJmnX9r7VjHLPmIVUR7zyLPeYUCOGCawC5kkG1a+N
 oMIL7D3eOOmH3zwKotZgxSHMpA1IZEu1cYMY5qK6milZklt+n3ue342KppfNu5gBYWWz
 imLQ==
X-Gm-Message-State: AOJu0YwaKaocFE3LNCA2eOa9eY2FU/kB13ptVgoNcaPxsCh2oBI86HIJ
 J+6JxoS37eCHXfCDZtW7fpuZ+DDthD1IAzuWTOB72TOQpZPlip03W7akmc3ZDyMQB2Sypd0oKKN
 TkQk=
X-Google-Smtp-Source: AGHT+IGpNeTTp5UTwLiCsOCnn/s0uF/RU+a1QpbasPKyoXE8ik9k/ZmKRzpn8vTKGP4srkT//qNC4A==
X-Received: by 2002:a17:906:c49:b0:a3e:e90f:e258 with SMTP id
 t9-20020a1709060c4900b00a3ee90fe258mr1390768ejf.16.1708419198264; 
 Tue, 20 Feb 2024 00:53:18 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 cu3-20020a170906ba8300b00a3d014fa12esm3747876ejd.196.2024.02.20.00.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:53:18 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v1 09/21] include/exec/plugin-gen.h: correct typos
Date: Tue, 20 Feb 2024 10:52:16 +0200
Message-Id: <d3a488b11917054cf4f13010e0f56d7b619a1257.1708419115.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
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

Correct typos automatically found with the `typos` tool
<https://crates.io/crates/typos>

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/exec/plugin-gen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index c4552b5061..b18edd6ab4 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -19,7 +19,7 @@ struct DisasContextBase;
 #ifdef CONFIG_PLUGIN
 
 bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
-                         bool supress);
+                         bool suppress);
 void plugin_gen_tb_end(CPUState *cpu, size_t num_insns);
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
 void plugin_gen_insn_end(void);
-- 
γαῖα πυρί μιχθήτω


