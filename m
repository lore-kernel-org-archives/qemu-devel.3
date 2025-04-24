Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53110C369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kve-0002AD-QM; Wed, 23 Apr 2025 20:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktU-0005pN-4C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktQ-00055W-2M
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:47 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so309781b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456202; x=1746061002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yL9Lx/EDFze6tE4WbhZDruyf3oGDShcQ9b5DcTeuWRg=;
 b=qCJacPgwpJRTjZg5vLwQqLZt/WC9bnkb/gTiPTeObVTIto0H2+u/Ahqh1/ZaM0b5cw
 Y+qtBoCvokgMJIg3yn2Lx7bsf4blYap9FpCWF8YU9aYXt2tBoYn3wt7XASSJOCz2l5OL
 t63fbZqWrNelqL9E6BnRvhn3Cp2fvq2EDvFNf0v8TQnKNdehFJrMyZLo3XxOzeIZ9mx2
 W1ZfY+7XKZs0NX04xZfRGUkqO1CL8c7oGzUVvvik76KBk8drtPqNJBtsacbpCuGzF401
 OkxLTffLX7coYWt5iqM2eL3nSio7DP+gDOPsssBAW2ve1l+0/DNrMy/+PxrOAcFuegOA
 Iobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456202; x=1746061002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yL9Lx/EDFze6tE4WbhZDruyf3oGDShcQ9b5DcTeuWRg=;
 b=QZxPRE5nJvP5YiqoXb027UKBhopnsWczYqDIlaIATi4VpI1X3V5SWgEWuhf9zRdVhw
 iz8GOLwaYs3royxxPc9TfiY2kaalJ2kSfH1gzBzdjv9jEk2RoCFFpV98/CD9y0t/8UTq
 6T/eP1OOxBLNgZDCxMG+MGsrO3UtoZsIbJ1DgSMy1HBcvTReat6MCaSP+zobL1PVf5Fc
 7s+MLvmaEDzLm6cDdNAq1l06K69i2hR7Zt9gpOCldz/z6YmxeGyZymErELzGQYzgDhkU
 cpiTO0X4ICJKVmHgHoixPNy59uPZfZR6zMLFGGYwvePTAXYa2b3vdj6g2jCiqUafTC7x
 YUZQ==
X-Gm-Message-State: AOJu0Yy0OPZn2E6TIEOO5qzN+VGyPr2Ir/mVMHwSf/Yud38cn8O/yJun
 oGuWMd/pb1hMKmE3S4yTFv2PeAvmMTQ1GbcQPJFJUiVxVD1EBwU+tea3VinxSYrXh1obAW8VTBz
 N
X-Gm-Gg: ASbGnct2KHMk6EV/332q4uHWWXwGwNu1XPpvFDS0a1qeNnlWDr2RNPX7LKJcFUjQPT4
 wdi+7IU2fsouiR3WvfnukG4+/3wDlXqZMYFDFEQWeiVRki5nVqn3aSAMMiE7sYeaHNNg2UjNmSD
 cJhgwFG4acQirSyU0pRDqZTZkO2/bP1OV4yzPmeBILdPVsyjvqASdiTONm0pm4oAyMgtvCL5n1p
 drQVQzk8I/mBq+tQamNEA5xfmUslgQSBMgWRZul6C93Y00pJGtueFPsIZaEQ5ou64mV/ke/fUSt
 sJ+UbpqgOj82rLingGkedxudj8F72xNlzzpXLG9tTZDhfSdABcqUIfLYUVmGfY1NtMy90VHSoh5
 OnVputgCazg==
X-Google-Smtp-Source: AGHT+IHBqNc55yFRRXU5zE5HNIIcYLRiImieexB0nKmN9iQ7B1VVFyA4LMt/jzDinct3+BEEvc6qaQ==
X-Received: by 2002:a05:6a21:4006:b0:203:bb3b:5f1e with SMTP id
 adf61e73a8af0-20444e6fab4mr856239637.1.1745456201670; 
 Wed, 23 Apr 2025 17:56:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 091/148] target/sparc: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:36 -0700
Message-ID: <20250424004934.598783-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-21-philmd@linaro.org>
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 57fbf16ad2..af3cec43e7 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
+    .mmu_index = sparc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
@@ -1033,7 +1034,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
-- 
2.43.0


