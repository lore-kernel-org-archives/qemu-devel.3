Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2844C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 05:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfL5-0004d5-Hu; Fri, 17 Jan 2025 00:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfL3-0004ce-LF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:13 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfL2-0005tI-3Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:13 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21619108a6bso28374935ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093370; x=1737698170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cp5f3kg9zIslyjr9hU6JHqBBz0dse5PTFBcH8e3sU7M=;
 b=BptWPi0H0gGgAMxkxhpiX9mvvkZ4J9nueYvV1abtZjG0sZ4+f7IJqwLn6b0hPzwO2i
 vrClPMUOYdu+X2jWVNfBc79jrzcei/DrY3En0AA/JPfBs0dAwOwOi+7RxWIQ6uQXHLFp
 FHYHrdr8HPJ89pFkEmCdoBlPuJhj/RrlJGJRy3bKW5rpjxZVQBnbDIlhAcIJlTgdJOQJ
 glh/1cqUQGiTdq9P3pRZc/rmcDS1mNs62PxG9qk6o5KN3fFIJmQ2JgOpEk0D25cKrb4H
 fsvkqr4H6DfXfyaUdb9y0722bUQy2kWE8DmjBUMQxYDmd93p188RtrK53y6MWLc0GbRy
 K3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093370; x=1737698170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cp5f3kg9zIslyjr9hU6JHqBBz0dse5PTFBcH8e3sU7M=;
 b=l661CV6N4zZHci177dbD3K53HjcCwpGpgtFpQAUnDmU6fYQRO09oCDqDqoE2wfyNbw
 +J3Fs183gTcXWfGvjamPid2L7TnWB9+BvJKayAiShrkd0471cC82HXFLPyK3EGoUW2/V
 +U8d5MzhrAjbuQ0wHJugsGMBanpX3kA6qaqgTmcKz6IsZ7Y79sGMwwZrgL22cpS52XPW
 eegvg/heu4XYsT2Vn0rJ8Algyr0vXd/581k3xsO0FXYvATmDfBcehntEozav68eH/Hpk
 mjmdEvv6/1EDP/3GLJY74RZL/axoNTScufdUh5pgGV0kta0bGl8TUqID75C43Fzj0plw
 Wqow==
X-Gm-Message-State: AOJu0YyoGbwug9Ef03vgoNsx7q8+xWInGzspYHA5qJPjQEaDtl58Uqyj
 7Rmbz6bmxkH+p4+rngtQQQjzEzT2B6Uiha/CCM6ktH8wNCm0V1+cuzDDcg==
X-Gm-Gg: ASbGncseDg9P4D9sFHsc3upRE90nD11YgV/r7OknOcQZ0clfK6nNfImXQcl/POV+DfM
 1ZixAFyjG3CfHUO8yzYbZGDlV1u0V7m5zwaAJXjbBn6na9HarkeIIDayOg4qyTnvU7eNMHKQG3r
 +U1Z/JMCKn05/zOi2WmJH930QhdQoiT9jqLyt01cbnuEcU8xGVta1EI0q1HOAkNdElqotw7Wk/B
 E8FfR1MQgBYbL0AkcrWkbeM2SP/rFSsdWV5kOBmsffzhfHPeGL1pd/f+WIG0lWTO2GPTgVhiccE
 U/RdLjQ4R34fx1/74u0nENnXJHMVw7QAxZTn2GjOqTXyXixYOU1Kp4hNB12z
X-Google-Smtp-Source: AGHT+IH/vxdpqLXsz3KBDI2jl+UwQk7Gm2P1zsxiA7WLwaHNnPbNsvovEH5Bo4v8Utsif8pYayuZMA==
X-Received: by 2002:a17:902:ebcd:b0:212:6187:6a76 with SMTP id
 d9443c01a7336-21c354016c5mr27900695ad.14.1737093370311; 
 Thu, 16 Jan 2025 21:56:10 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:09 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Craig Blackmore <craig.blackmore@embecosm.com>,
 Helene CHELIN <helene.chelin@embecosm.com>,
 Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/50] target/riscv: rvv: speed up small unit-stride loads and
 stores
Date: Fri, 17 Jan 2025 15:55:04 +1000
Message-ID: <20250117055552.108376-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Craig Blackmore <craig.blackmore@embecosm.com>

Calling `vext_continuous_ldst_tlb` for load/stores up to 6 bytes
significantly improves performance.

Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
Co-authored-by: Craig Blackmore <craig.blackmore@embecosm.com>

Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241218142353.1027938-3-craig.blackmore@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0f57e48cc5..ead3ec5194 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -393,6 +393,22 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         return;
     }
 
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * For data sizes <= 6 bytes we get better performance by simply calling
+     * vext_continuous_ldst_tlb
+     */
+    if (nf == 1 && (evl << log2_esz) <= 6) {
+        addr = base + (env->vstart << log2_esz);
+        vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart, ra,
+                                 esz, is_load);
+
+        env->vstart = 0;
+        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        return;
+    }
+#endif
+
     /* Calculate the page range of first page */
     addr = base + ((env->vstart * nf) << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
-- 
2.47.1


