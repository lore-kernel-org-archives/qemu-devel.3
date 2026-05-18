Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54EECD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsJg-0005uh-CH; Mon, 18 May 2026 03:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOsJT-0005pe-Mm
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:22:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1wOsJS-0004hf-A7
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:22:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82fa8d6425bso809659b3a.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1779088973; x=1779693773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Juer4Wjgt/0ZOAgysQ1XXcC/XVrTou51vlfeuKtO0KA=;
 b=cCEIgTGmBaLx9NIi/Z6lqOnCQ2j6qTm+A1PvNkCGokWOFLzYppfYttpD8+sCiOxqxe
 /n/1ULFe5QnxnKOgqd9tyD8HnaJpAlBYZOPtgkIAFvw3ab/HGlK3aoFf4Cwx19a9spfw
 S0NblYi6kutpMJaSwPfXPb89mz9TdSerkM/5MIGoSblBGmvv72gODCXr1oAatoGaviX/
 AiX35nIpTG1fu/eKKHNrmNqmeAodLPL3TET64BLWFcVl5c8iwJTW14LNey/kkRYPJ35B
 WQT3Ynj2ka67HCdnPIy0POBqP7eyZLEwmiIXIfOy0d3CvemN/aMgz248h185b3xKkMj0
 K6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088973; x=1779693773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Juer4Wjgt/0ZOAgysQ1XXcC/XVrTou51vlfeuKtO0KA=;
 b=jujm3SpvgsP6skGD++QZ6In+W0PCrvrJ1JTGI8nHhKEpsxBjAGO4sCYOclgH8Lmp/o
 2zOokBEvJGLw67ZGP7+AV8QWOAuZwwcYAe57xD30BdKx8G1a8DNdpZVHZfb8ijkv4DGm
 DVSJRukMiF4Pdq0iYsEHIImdu4CrRVIIzh8O5ctXSLvYieDpqskZ89TEzCuXdZozR8O6
 S/IDI2tB1funrtrpvVUglbiekJCWoeI0EvUrRlGE4qBXQkzHwCeTTokQFpE/9xtbKyen
 Ewyo2ruyQLWV7DSmvW5w7EH4lpK6b6+1aUTg1Fo8twdBVYFmw0pzXcr6KhuYaT2v5kdi
 kWvQ==
X-Gm-Message-State: AOJu0YzqcGkUylZ95EjChvHlu9D85f1LWYAkPPWsI8P8kc/8/OFKFgAX
 EAjvwp9f18IiuNH9stfhYmO9qbXVsh6tir0A6q7FZbldHHpj47POVgJYbWHr4Q/bt40yWQJESAN
 IymqBPRNQt6bBOKh8ygh6mMwsivcReBjqCQmlKFTnfpmuH6stzps13cg72bjM4EbUHmgj8GDVb7
 5GzU5sLWRPiP5fULmXJkGIr5+6PQ63GvJ7onY/TePUimk=
X-Gm-Gg: Acq92OGlkrTthfkNCcpCjElUvsR3XiTSoeQlDFiQ6z1+WOPPTrGKSNe/inKEBeSndyg
 TYC2k/1uyrsKYDC0HxvnmUNqpkx11BIivtdNwUcnY0IojUbLyYXMcMV1amrAQlrHXqnWZeAsTio
 Y04SoYvn7TLVhb9vmoh94dfy2U8HdIXZ901bQeiJoO1TMkMhinMoQTJ+LP+DADqNi8MLhXg0dSG
 96Bc/2fZQPvP/HG9f1QxKgS6S6fvJ3FRzIMfZogI83wF2SvC/dnyFZd8oVRarSwbYUpRhhYGRh0
 cUxZOtjS36RiS6BUSSauNo2A3eExMdPqoXROZEnLmEUVPiwH/Hsi8+sO7pLekN7QEkvsrVBi2NE
 WKPLxiAInqVweccPs75CayAoxlOMt9UIyZ7K43fBWaXb/vkKdNq1+iHUKVqwml59o5HuLlEk/6C
 GNDimLC/7D+2l8uLNwU/sJ5b1lBMZpUCqeC6KEjGzHInhTmuDd7P8FD+I5XLMiYg==
X-Received: by 2002:a05:6a00:1c81:b0:82c:e775:d43a with SMTP id
 d2e1a72fcca58-83f33de5276mr13648651b3a.35.1779088972573; 
 Mon, 18 May 2026 00:22:52 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19c5c045sm16502348b3a.37.2026.05.18.00.22.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 00:22:52 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Jay Chang <jay.chang@sifive.com>,
 Frank Chang <frank.chang@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v2 2/2] hw/riscv: Refactor riscv_iommu_ctx_put() for Bare mode
 handling
Date: Mon, 18 May 2026 15:22:39 +0800
Message-ID: <20260518072239.16293-3-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260518072239.16293-1-jay.chang@sifive.com>
References: <20260518072239.16293-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=jay.chang@sifive.com; helo=mail-pf1-x434.google.com
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

Align SPEC: Bare mode contexts are not cached, so they require
direct memory deallocation via g_free instead of hash table cleanup.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 hw/riscv/riscv-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c5c04e336e..f06a121945 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1390,7 +1390,16 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
 
 static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
 {
-    if (ref) {
+    unsigned mode = get_field(s->ddtp, RISCV_IOMMU_DDTP_MODE);
+
+    if (!ref) {
+        return;
+    }
+
+    /* ref is pointing to ctx in Bare mode. Bare mode ctx is not cached */
+    if (mode == RISCV_IOMMU_DDTP_MODE_BARE) {
+        g_free(ref);
+    } else {
         g_hash_table_unref((GHashTable *)ref);
     }
 }
-- 
2.48.1


