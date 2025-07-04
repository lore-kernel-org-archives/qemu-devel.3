Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05B1C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRj-00060Z-Rn; Fri, 04 Jul 2025 06:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRh-0005zT-Oa
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:05 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRe-0006Fj-D9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso407440f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624100; x=1752228900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4O4V3IVlY7U/ZO9G8RGp5YV8GTOAnuzXOdvv3mDiNZI=;
 b=UHUPQxO89zRlO1qU9GOijvaEMN1p3XGwLuBmE/S70EpU8Wgd8RZNMsnoXQZwSvG/bs
 34ycb2rA5a4qHl3vd3qWKMuT6HuC4b7+piqFqfItAOzLQb/bYC7f4Ec24n7/z0+2vGVS
 ACFZK6RyKBEf4gsRn9hfReRPNJwC3/Ot6SLKvhCvDWX097Kxjaun+Vhoq6Usv0ljCSWa
 Ci6J/2rVDF4aDBXkWxTmsQwmo1N5UZRJDc8/+Jom4UY+pcq1GeHCJBDJURGyDFs3heey
 oDK0jfbJwPedwpLlnnsdcCO/GO0Po2Sv52WxV/xDj6CxZNMaHylTMmAt7ZRezw9oagnY
 1aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624100; x=1752228900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4O4V3IVlY7U/ZO9G8RGp5YV8GTOAnuzXOdvv3mDiNZI=;
 b=TGWKFczO3AGMnas4c5tTNvKY0/zh4VqsV1SnZOU0ycfdFsFTUSN7TJSXCQu9qaePaj
 7RrmFxelcZVZ5io9sGZSlb22QwyHoL9R+w+nco/peYSvpoAeI9/N3a61ht6C71JF7HL6
 TRXpUYOs7kVZQN0sUfcbVgpaBtndEbcMXc4spdPD7bxXIEIUNdREXLPQSpflyzj6BsZV
 6Sg78ItVOPpALODVFWKzLQUuw85IOhHCCnZ2hYpJWaz4UwD9i7L0VUvUIMxFL94Omzy3
 zk+0YhxJQ2EDEd/tBlLYsqRnC/O2j+yY4/u9pf3p1ruuRFAtA0l0xYf4VH45NNYBj3Ff
 1duA==
X-Gm-Message-State: AOJu0Yw8BxY2U4VIgLtvTg/XBSBSZZ1om9ECxFbEfd8IVbKJJVQeIg4L
 KmUlBLJO0Gr/V6+R5ClbusoXlTmM8dqqwQiVb7h8BhIuIlq8WjgOsPLhDYDm9bVwXsldWXnsPkJ
 5ABmf84I=
X-Gm-Gg: ASbGncsDIsnx1W5GzkkSHdzz3JOyjNipBH2z/hiQ9qiTN/hzLJPWTo3e30QR/SQQmLV
 xk4OwUE7x4DNwnw4wS8FQZ+Q+LXNXYy5uq/exh45bkIASTQppeRVNIcqa1IRrjJn3RJaW+lJ9Vr
 HH5TF62NnbBBGunnlcJCrKeU00UgLjZioJ/brq+yGAvPvhBoXVHwRCLhcBiQa/6OgLxj3ZGDGki
 yNVJ857q/c5LTk5+H3S3CD2NssiKOlngjRsfaXCsEtkOhjc1JvH6KZVFwuih1THZwmRHNnqYErW
 kyaTX3uv+4dghul6cS+8V2TRmCPGOn/SquCk6HsltDPcbHyAGjmmtk4YTLs2wdNkNuTeykESk+R
 wtC25wTcysyfTuHLH72dZiaBDqyVwsWKisJejtBnwXey8720=
X-Google-Smtp-Source: AGHT+IHsHRBtRsJC9qzdmZvBDxQ1+PcCNmqPS8AP4VkTUH0d/m/bx+DCBrhyUNfNC7Mu1J1csYWq1Q==
X-Received: by 2002:a05:6000:3111:b0:3a4:fc37:70e4 with SMTP id
 ffacd0b85a97d-3b4964fc7e9mr1721220f8f.58.1751624099571; 
 Fri, 04 Jul 2025 03:14:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d094csm2079828f8f.28.2025.07.04.03.14.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:14:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/31] accel/tcg: Remove profiler leftover
Date: Fri,  4 Jul 2025 12:14:06 +0200
Message-ID: <20250704101433.8813-6-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

TCG profiler was removed in commit 1b65b4f54c7.

Fixes: 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-9-philmd@linaro.org>
---
 accel/tcg/monitor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 7c686226b21..344ec500473 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -141,11 +141,6 @@ static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
-static void tcg_dump_info(GString *buf)
-{
-    g_string_append_printf(buf, "[TCG profiler not compiled]\n");
-}
-
 static void dump_exec_info(GString *buf)
 {
     struct tb_tree_stats tst = {};
@@ -196,7 +191,6 @@ static void dump_exec_info(GString *buf)
     g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
     g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
     g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
-    tcg_dump_info(buf);
 }
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
-- 
2.49.0


