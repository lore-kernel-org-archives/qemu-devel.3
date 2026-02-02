Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6BBE7FDDB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn146-0004HM-Cy; Mon, 02 Feb 2026 16:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13D-0001n7-JZ
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:45 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn13C-0004TP-4R
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:01:39 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3903985f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770066096; x=1770670896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVuCsHVaLMzFjACHbSaALeEzWdGEbdUIemaoG00K/Fk=;
 b=NBBl4hE7CapzCQP1OUCNAjaAMDLjW/50JNIsf+vrymA7YNYZXhoX7ib6PxxXT1nvwf
 R8Cq7v112rMwZPLWSHTKZ1p2eSt7EE3GZEsAhNOJzaiaHGkKwEJIQZoAOns2ehKiehUX
 5m6hn997EBPsdMAhRu1hSU6rMxwqL5v3HUR0cn5mcHFBYZIDNcpyz4DRdF2fyt3fg770
 7C9VV76Dlu/USAgfGiaofoIFmXeIpTkNIHXbrXb5BDFdrco1ZQV5XY1RC0YWC3rwm/kX
 F1AaAOFcHI2OdKG/ToK3KMJdvm3FnhISLN3eEFvI0Lfy3qFZtji3QrkNXkh4Ur7pl6qd
 7CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770066096; x=1770670896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZVuCsHVaLMzFjACHbSaALeEzWdGEbdUIemaoG00K/Fk=;
 b=ZiBwji2pbYEUgVP8MUfIY3sdk2tvL3Lg4JE7ZvHheFFzrFr5q7kEIszRgzo10Hp7c3
 1W8DJAKAq04UTX0+QIkY/H48JWXXrLmtpuIsRiVhNyesbNoZkrl+7hcRncNQZ9srhfpK
 Q9pIMAAa2oT36JUp6iEr9V+FcFd19O7i0oZVU29IEMVuwN0t9h5lGkXShuIFi1y7K9rV
 loQorjR6OGCVHAhn0XyVWnSlB6E4tdvAN03lhuH+rCJSQ5q/y8lmE2QipIA+/aYF5bXh
 IoUQ42CkPoKAzOvUi6q99DcNpd/pUYopamt5ONUN06wbOzVFRiT5wnhwqmJ1K4qs08CB
 T9xw==
X-Gm-Message-State: AOJu0Yy+5k/Y/Hx7cLPb0Kp2yqPy0M6h1qkHiwUKkGVYvzvzkPIhhOBR
 xcE+n4GCyAB+baDvnWkkjBNDb8M8JcMRE6kFJvU1g8lZ4hAg54LR63zqCVcRUi0mnRXNvHvDz3x
 IHsMT9GE=
X-Gm-Gg: AZuq6aL49MzDq7JLDPjmDJRpJ2AUVxRaVRQETR0nb//tm01Wd/q2DpJ0sHnU3VxgL7Z
 SpTM1vCnWNacnmfFHJoigLZaIvtK0ijrdZvLvVD3SDWX712+1ievSemSdkZSDyptcslRuAR+8Sb
 oey6Cc8oLzzTWMzA6UgEjUIw77oGrobf7kRfR30h6U+l6+jpcRxtDHVkCzP/9FA8KPXo4vqVGCn
 NbfG6f12aTslJ9TfzLvOCv7GlCCw4cYyKIvuvWxKz5UHdzFRcCeEsoiEwhMdyIeY9KHJOu+UiQv
 2RuJ3wn1NnfRYMWvVXiXUiOvnCGTYSub6veESscu8bXH51lVBrLkwD50chgx2+c/ol8T8NC0b80
 rbkkW9PLk7x24gIfCxXnmgihDBrr3YdSa8Ny75QF+yBPKlB15vDE8X0sTze6iT51u6/ZQICcPO3
 TJQoao2GMD8IFPw5r+TEymF9WTHLD2+V33bIqOgUk44OSLDFeGDfVAx5S5AflF
X-Received: by 2002:a05:6000:1ac8:b0:430:f790:99d7 with SMTP id
 ffacd0b85a97d-435f3a9a9c5mr20909260f8f.27.1770066096283; 
 Mon, 02 Feb 2026 13:01:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm49168105f8f.42.2026.02.02.13.01.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:01:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 04/11] target/ppc: Expect page translation hash addresses
 to be aligned
Date: Mon,  2 Feb 2026 22:00:58 +0100
Message-ID: <20260202210106.93257-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202210106.93257-1-philmd@linaro.org>
References: <20260202210106.93257-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

The page translation hash addresses are aligned:
remove the misleading MO_UNALN flag.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/ppc/tcg-excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 6f5d82af636..a8c67364669 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -161,7 +161,7 @@ static void do_hash(CPUPPCState *env, target_ulong ea, target_ulong ra,
 {
     uint64_t calculated_hash = hash_digest(ra, rb, key), loaded_hash;
     unsigned mmu_idx = cpu_mmu_index(env_cpu(env), false);
-    MemOp op = MO_TE | MO_UQ | MO_UNALN;
+    MemOp op = MO_TE | MO_UQ;
     MemOpIdx oi = make_memop_idx(op, mmu_idx);
     uintptr_t retaddr = GETPC();
 
-- 
2.52.0


