Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72151606A33C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gFgMa/WX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNCaZ-0003qx-6G; Sat, 31 Oct 2026 13:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCaX-0003qW-LG
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:09:53 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNCaW-0001Vq-3O
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 13:09:53 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-15943c9c005so1247368c88.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793466590; x=1794071390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yUNIvB3FxzBkZ+ejHoX3nLFFjBvTWomjc/HNnaE4vXI=;
 b=gFgMa/WXzE4oRLlyZEEaUfmh1cTxiUA0lqGLYNaggf69yPknRpkwEcCiZjtv+mYZN8
 WUpx37u864iVFDagKI/yIqar6dkp7N68uge03DWxxyEa5DzN09BxT4mvtgCvVeHJM1Sj
 ajeFT6ftFRvBa4lb/hrlIuNnn7x9BLxhq3xMcr/JCF/ZwgypIssD0QOtJOehlYT1uSuq
 2AYII9jaNA3IGDDtp+RYymHtC7/VeinqNf3c7f8rAOMtqlWgLb7WhOaCu7+jiFmRklMg
 wVugATb/6AvGTgyKrU+XV/A3qbLt+LSoyo+MOq0DHFUkIke0HmyWUg8gvQDKY6ttyotr
 JAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793466590; x=1794071390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yUNIvB3FxzBkZ+ejHoX3nLFFjBvTWomjc/HNnaE4vXI=;
 b=STCr07YOtrizZ7cDnDZszutLN0Fh6CQFTxH36Z0wk9y6K5ED5D1x4WfL9xMu3uWuMJ
 tMCXWSCZtiGbQ5FfwhGEFXJkrHKACqq0GrODQA9mb6nRVI8aQJMxh4gHBqNGhqE3Li03
 uJO19XEv/ZtcwbunFflqkkMjeM3vlS3ZxVkXe+YhhA90vg7bQ32CLVdsm60LYZDtGZL2
 MEhsbfesO3pslk+akbOZzdmcMgPE7TWEV47feclvtTsBsVqf0PFWXa7JXnLADYdWdv+D
 TqaxxHtUjtw7zsjJs+sx7n6RXU/KuBTawLBK5/jcLLY0pq9+XKzsumzDngyjLHns0rJ4
 E45A==
X-Gm-Message-State: AFq9FYKVwVtPqkkd3gN99BSzsETbrlRnCz+1imA0WiqLg+PKue18GvGe
 bzNq696efNg0+DYhgwe2MxmhBPjolaoAt1/dE/yWRkutqY2R9K311xrLJB9suQP3
X-Gm-Gg: AYBFou1g3bd79fmalF9DxBuX5XvWAobSm8DAsO1bcxhsQDkJR7+j57zfWjSNDD0PTb8
 GRcvw+unS+Ik6fxccJ8oaO8fRHgK5UI/+bbz57gwU0Hp5JU76wATaFDXWCrwDBvoC1YrrkkVu0o
 cBAky3ttwbUM/fGxIbpuFNsCxki736UqohpCfLzLg7HTE0ecY4sdmgAy42QUczXeNkAXddG3cqm
 f2q6JCS5mC74U+d31HNu1y2B/QBv0BR4IsjNWRalH4J53NICrJbUy2ZWLrGwwyjje4zoOQAQy/G
 7Z3kzg2Knk/iIBlxMr/0TfTbR3x2tZKEElMP7l8P7JwRoJEyqbYMr2aLFjy5tiu4u7hBPAxCEcN
 ZM/aIWY5pINkqFmdMjPT5M/R8ALBEiQKN9K6v5thJhcdCfz3M9XJ1Xh0iBXIbx17Ssqy8Ww0vf5
 T9Wyhw+8sm85REkfXts3HuQaKtP5kO3xu8+JUvUL85369xQ94NQ6Z3A2rvx2KJtrZxdrhPOBKiD
 /k9PZjioL/pTIbghf+7bgfCiWd7DzyVDPqs0SyXA85Wp1tNlzWaFmfWcIFqx3pl+ZAheYTxIrLa
 Jq+fO0DeUM5obU1QKgCl0chQiqE3m0ZNWX8810Uvm5hMF4gnXw==
X-Received: by 2002:a05:7022:208a:b0:1b0:4272:4282 with SMTP id
 a92af1059eb24-1b042725256mr1322960c88.17.1793466590235; 
 Sat, 31 Oct 2026 10:09:50 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac1854da78sm23749065c88.6.2026.10.31.10.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 10:09:49 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH v3 3/3] Revert "target/riscv/tcg: restrict tcg-accel-riscv-cpu
 to riscv targets"
Date: Sun,  1 Nov 2026 01:09:25 +0800
Message-ID: <20261031170925.789-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261031170925.789-1-luoyonggang@gmail.com>
References: <20261031170925.789-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is redundant now as all accel-$cpu_type parent is already registered.

This reverts commit ec65e16fd2ba012d57b1bbfcfcd04c31c4111924.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2a7796c382e..1369b7c4ded 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1754,7 +1754,6 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = riscv_tcg_cpu_accel_class_init,
-    .is_available = target_base_riscv,
     .abstract = true,
 };
 
-- 
2.55.0.windows.3


