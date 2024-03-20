Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD4FC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 17:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmzat-0003IR-JZ; Wed, 20 Mar 2024 13:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzar-0003HR-Ia; Wed, 20 Mar 2024 13:19:13 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rmzap-0006eF-Tc; Wed, 20 Mar 2024 13:19:13 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a468004667aso6379066b.2; 
 Wed, 20 Mar 2024 10:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710955150; x=1711559950; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pEt6Y91A7HM8RCal+AzIsE2i5XHB8wZ5gv0UJ8gFKI=;
 b=d7KTUuUDSssPzdsMYYDQ+2VQHw9qcQ3FUsVc2/NCP7U71+F1uA9+XdgvjwkJoZ954X
 kpdJAkVYDcjasBatMbM25FVCYFzHSMXlUb+76nOX0dBSJrNFSoxsxVcOKt2KaqMjpj/4
 EbH61s5FVD6aJJws7A0Ws8QcIhHCj+SJAXz+d4S5E+t2YjM/c9pOC3vBWLgCCz+4gw7z
 s51a334DPWEx6vYjTQqQksZ2csejgtgjO9eCNOum+OfRmnU92+hTEGxatOmWjg/WuJ2f
 wd7htxIyuonahtrvsiGGRj1PcEE9aI66OBN8hhpf/Ev8uR4EXyZFMYpI0EUN4PxjD+mG
 duiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710955150; x=1711559950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pEt6Y91A7HM8RCal+AzIsE2i5XHB8wZ5gv0UJ8gFKI=;
 b=c56ZUmYRPsqftpLga3P6jKeAcxSE1utpTLa7f/aN0B5ZZhL8R8VctV/7XtV5FSAnwl
 zghB23VuL3y++e2KOzvfpz4REjlingjT2BfWVjzlqmm7DV7xhfkvh64NRxAAsk+e+/Tw
 d/CM6MQd+ZXew7pOJ34f+tNzOgvT94j5EdrmIynlHPihPo41J8/08RtJh3X5nUA//Gu1
 suYsMZV01TdKSRi8v5sunnRmmP9xI9Pgw8AaNx6mjN2xTQoFcxmzuFquDRNruqIhNl0H
 UJALKodqGv7wEjhkOYwoGzzOG9Qi82uxoeKjW56J6jC0+U7uY0atpWtFcIQ2vt9U8MUm
 3uGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbYnvLFkICnC+hud2csLuj/mGD+VUKv63hj8Nl2HrRxDoi6dW3N5uU0+6mTAUAhvEtUgL/1632f5LYrVArD3+8+NcWVh6piiOYk5fUOOvUXX6uhj47S7Y74ofYCg==
X-Gm-Message-State: AOJu0YzTWw+Svt4VPiEKLvIbLHO9BuaHtVqcFu+vjQrVF6njmHp5k8Ly
 TZ7MTG6SZPR614L8CymGb/m6yqj+o28cEgwF8tW7wsIO6lxQm7SS
X-Google-Smtp-Source: AGHT+IE+KBVk9BqSUknzL5iFw4h7Upe8/Rni/qGxT+ubhbC8jkdIhz6ecUUbu9nE0gQgSTI0eTGgjw==
X-Received: by 2002:a17:907:5cb:b0:a46:c56f:fe39 with SMTP id
 wg11-20020a17090705cb00b00a46c56ffe39mr6820068ejb.39.1710955150086; 
 Wed, 20 Mar 2024 10:19:10 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 pv27-20020a170907209b00b00a4576dd5a8csm7481639ejb.201.2024.03.20.10.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 10:19:09 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v8 6/6] target/riscv: Enable updates for pointer masking
 variables and thus enable pointer masking extension
Date: Wed, 20 Mar 2024 20:18:50 +0300
Message-Id: <20240320171850.1197824-7-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320171850.1197824-1-me@deliversmonkey.space>
References: <20240320171850.1197824-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x632.google.com
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

From: Alexey Baturo <space.monkey.delivers@gmail.com>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73c69f3d0a..9e3bf6c5c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,6 +190,9 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
     ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
+    ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_12_0, ext_ssnpm),
+    ISA_EXT_DATA_ENTRY(smnpm, PRIV_VERSION_1_12_0, ext_smnpm),
+    ISA_EXT_DATA_ENTRY(smmpm, PRIV_VERSION_1_12_0, ext_smmpm),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
@@ -1561,6 +1564,11 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 
 /* These are experimental so mark with 'x-' */
 const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+    /* Zjpm v0.8 extensions */
+    MULTI_EXT_CFG_BOOL("x-ssnpm", ext_ssnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smnpm", ext_smnpm, false),
+    MULTI_EXT_CFG_BOOL("x-smmpm", ext_smmpm, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


