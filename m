Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B951C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqZf-0001Q7-I1; Fri, 02 Feb 2024 05:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZe-0001PB-Jd; Fri, 02 Feb 2024 05:15:06 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZd-0004Fw-0f; Fri, 02 Feb 2024 05:15:06 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a358ec50b7cso113369466b.0; 
 Fri, 02 Feb 2024 02:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706868903; x=1707473703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L72jtWav+wlpWsiMwJ1pzhRe8oFDo7kH+C8pFJwOQzM=;
 b=TRUiovLGK7Uc+r/fP15/aLzqumHDBKg0/lyKmpI6CDpMXCQtmfXWp/Sz8MN6V9/TBe
 iadsoDg3CrmCLrz//TNI6A3mpo2gNCGRuduXKo/hy4uSsCpHKIjbo5rjMBTsIoWc7qp5
 2AF9Rg4BUXXKJRz611Iy9Z/0GgCMqLzhxhxuQ7l/Sy/OjdnM5ll8O7R4zFQ7F2+xHU60
 FvXk0uSVoM+L8yF7FZLq4zQhuMUAP7oVuHwEIo6l1fTLbuUh+7sPMhSouYs8H/3TreaJ
 rtl0NS6AY8xFjr8J78U72hDz3GtxG+RErSLbnesgyAmVpsas+il575I35MVmyVHPBy5w
 bE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868903; x=1707473703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L72jtWav+wlpWsiMwJ1pzhRe8oFDo7kH+C8pFJwOQzM=;
 b=fTFcymGzBbkBzx3fxpXUq5XbYZ79+sIZtu9Rne//WkWKqAoSZiJHcXxpMUJ08mdP8B
 PNX3UqlqHVEaCjFU2rOw3R/SneolnD7N9ZpNBSCOvw+HEuKjA7pt9VciNPTPuMvHFq68
 x0l0V5WOzhEx+qn1fv9ddQXCwLNFbYD0EDYbPO2junVvhS+aYjwBpCLzvl1OzaArsODo
 6ot2XOfNhj3NDPcbzM5H1FZVvOpJjsJ9eaXOR+HHLdJkpuO1EcohY41swXeGoxuijUYx
 cLOjJhpU7uOud0lbaZ6Juhx4ckEGpyTAAtWDA6iPvKp5DM9+l4SAU5KA2W5DNKeibNyR
 w0Ag==
X-Gm-Message-State: AOJu0YzEQKtX33KgwgSP+57sJhNHtVlUEw9rpsDBAXxBT46aamXtUNTF
 YHyH8TD6gcusflIwTEzmUtLonwLonVf0YQrPrDeYPEd2BnTLJc25
X-Google-Smtp-Source: AGHT+IF2BTGSUEznAfiOEnxdloLMrwxgLI12wYJsqIRngnD/kp15w0vf9vr0HTlAyEs1vczxAh8crw==
X-Received: by 2002:a17:906:5788:b0:a35:6274:c440 with SMTP id
 k8-20020a170906578800b00a356274c440mr1270490ejq.23.1706868903367; 
 Fri, 02 Feb 2024 02:15:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWEpDFAYjpiJi4l1gA99L4rgxgpMe85KC/iSPpAN1ZyrihkDGvF9dQztrwXhSEQXv+PFvidFYZDGZpslrYal3EEQaRYE/5zBofSMOtAgyA8lPwNPpf8wyL+0TmP+QXGFaPCxqFEMZie0f3/JAy1zqRIwRiCKD/yix0jSckHLwcrrrl3Zbh1iIfV8vZ16ylqhNfpc2uBaZF+8vsKlTfYby8ZvZ6BSZXEPVOEuxPcAba+auXZDfR4/L3fMR4Kmpu/Np4JCvG3voB8bqunacbo2j3zc+yGe480/KbzQzfiMPzfpNrbSSDGDYPhJi8rKPcoY7tXE+hFmAilUWpkkP2XvkdUas+0jo/MUweqO8yP7R6tQXcm+x7JzHzOw/A=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a36fe6fe976sm579722ejc.190.2024.02.02.02.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:15:02 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 6/6] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Fri,  2 Feb 2024 10:14:39 +0000
Message-Id: <20240202101439.3714106-7-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101439.3714106-1-me@deliversmonkey.space>
References: <20240202101439.3714106-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ded84f2e09..23d1692b59 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -175,6 +175,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_12_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_12_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_12_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1496,6 +1499,12 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-zvfbfmin", ext_zvfbfmin, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfwma", ext_zvfbfwma, false),
 
+    /* Zjpm v0.8 extensions */
+    MULTI_EXT_CFG_BOOL("x-ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smnpm", ext_smnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smmpm", ext_smmpm, false),
+
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


