Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42A4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVxt-0006Zq-KV; Tue, 30 Jun 2026 06:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwz-0006AM-5g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:25 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1weVwt-0004ws-Sq
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 06:44:19 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-37fc01a7835so1528346a91.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1782816249; x=1783421049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWB1VMpEOQWXHjt4fAXcLPtGgLfNKt45L82Gan4wey4=;
 b=LBRvqTy89tYyzv+9k9yxa27miV04iFvnrHcC5R/z/taxKSp04miZ0KcdIxG+5FbHAF
 r0psZJ9map5kZ5Y0rXz8pjJ+pZeDb7VvK4e8xuKZ9tDXrFD1bVj16HV8+jg5Oe17zotv
 rox6DEJxFZW+qpOAfHpUCglloQAuTW/pjTwBJCeZMKIj9lhGt/YcbqAd/oqiO7+W3VLo
 +iicYW2eAPUDxcghJ68+mmW1KcsrWsK9/9VybNdzLQlvZ9yRt3dL/kSeuczUNfJqRg3D
 4Zx2tIs+Fg5lE4uKGFsgFDVQPBNwoWBCZIWoZL4rmvfcBLnDksJ58c1/Hk4CiP76PZP7
 Kpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782816249; x=1783421049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oWB1VMpEOQWXHjt4fAXcLPtGgLfNKt45L82Gan4wey4=;
 b=EWaxhkrwW5MSXYnHxpBdo142v/P0FilMHFuNZYFxA5+cXPKj5MLnSGgVxDwhm/nWh/
 IWIvd3i+IZBSMv0N+eluUxT5IpCnBiU8UvTW1M6fFPM9009ufaRF1E5VLbdqsUFL+kMC
 3hiQkDjwfgoJEj5CqQv+6MkAnhT5jcbavoTzwe5lHFxMLc6i3gpe7zZ3A+5V4rF5G09b
 ObBP7SvvOw1AJdaTFXawKh6yHdUUs84aOOPudXilvmxHrpb8AdPCewiWWtwfce9j2wQv
 fpMEjx1v6OtWhEDEbBmbXItA/0+37EzWjKPqeAcC63Qf3nvELXoq5/h4ClISLVxInb6M
 Kngg==
X-Gm-Message-State: AOJu0Yy+hHbVcaVh4ZWFMqYbZ5BeTGMu/dXG+DkzTHZemz7D9FmZ07Qb
 coBk+rFEF+q3Fa/8CMghDZHTC4EJOegr6IowMBbCy8uwQQPliQEPGlcR93K2R9AQrneW+zerlMU
 2JzlmKUZ4HzSw7xUfmwMDfMz0plxryPhUT/IpswFk3UceurTj3E7a/XO3Q/zL6n8+b0RtkWYe3h
 jjkjbZNrDYA0jRpGM89Ewo4Udw59/nfVeotb0TbToHcNif8Y1R
X-Gm-Gg: AfdE7cksDAT+FCMevGMopWmllU6H7UZspzdusAbqfEaAgow29pantgP/YmpK8y0d3t3
 clmhntiMCqj4XLWOiqYX0MREC7m6IL1EzVPk63+F8BjfvNr8JSss8h3KzG29xTZlDKVLk5gcZIb
 MzQ40nB/y2OylhRsGKAkuDt7IbcD9X/6qS8CyGjR8pAH1+xAfs166WMvAjN3T9yOFYsMtU9MF5b
 Rag/2yrCdMj2aK1Dqmw8WtB5+Zg5PDnpSCTPLuoQ2kmCrOja8JtVQoFbrvW5C9qmrc0Vp0RzUDw
 5O1t9GxAKE0g8k9mao6sEY1aXK2CI0PwuOYep4zD20jBuU86QilA3ulTkAPEPwbEFdEMiiF8xWx
 ewmbG6ufFiQZe2EYVjAQoNClPimqN9yAPScZRhW6nSTshZ4nY8yLcn64FeaYxZmt/mrRhKIaNeU
 Nh8p07+AG9evADNMIuJAIZJaheD6qDthF1wi8e3Oe28dcGUaGB4g==
X-Received: by 2002:a17:90b:2d05:b0:37f:9cdf:f039 with SMTP id
 98e67ed59e1d1-380527bcdc7mr2226233a91.28.1782816248814; 
 Tue, 30 Jun 2026 03:44:08 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9bbf95be56sm1274745a12.16.2026.06.30.03.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 03:44:08 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v3 5/5] target/riscv: Update Zicclsm ISA string and expose it
 as a CPU property
Date: Tue, 30 Jun 2026 18:43:50 +0800
Message-ID: <20260630104350.748267-6-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630104350.748267-1-frank.chang@sifive.com>
References: <20260630104350.748267-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frank Chang <frank.chang@sifive.com>

Update Zicclsm ISA string and expose it as a CPU property to allow user
to turn on/off Zicclsm extension.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a3cccdfed3c..8735a5ce846 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -144,7 +144,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
-    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, ext_zicclsm),
     ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
     ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
     ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
-- 
2.43.0


