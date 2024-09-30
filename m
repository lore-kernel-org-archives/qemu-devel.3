Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E64CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCRG-00088W-Bu; Mon, 30 Sep 2024 05:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRF-00083q-7C
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRD-0004Uk-NG
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:11:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so31443795e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687486; x=1728292286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7J2h8RAUijw3GDZwtE7CevTrntbSJ/9Vqd2w1TdBKEw=;
 b=hnLLPfzN75iWkogIgLLcsCooPac4gZ3s89lXeXsXB7lMWlcrUxWDbG/xDrF3NvHuJN
 bq1eJdZnminePcEU1p6/FvyCHPOzfOHztbyXw0TEPQ4dkfKjY9s1SZpLf5bocODv040K
 qG8f/iOZRV9ARwJS2M21m5SqFX9TXJxkLpER0nXdLu4hrsDCVYMS7cI6YUztjlpoYPHx
 LoxHHHm+ZuuVNJ56LbJhLQ5qdM95Nj4pBOsfAdglJjNWJ6LUlGv/U7n/bKCC3lZaE6Tz
 tPUV5JVwBQoj68yBUzFSxrhlaROBQ70X3vNchCAnIV2kqY4I1RavkooaC8hrQVObKr8K
 ad3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687486; x=1728292286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7J2h8RAUijw3GDZwtE7CevTrntbSJ/9Vqd2w1TdBKEw=;
 b=XwBbAVuk8u0DH/Enq8UnQQ70Fcroau6YtZXyToJe6nDyeeeRzPQggebYSBzyNRDJHk
 Q20Nw7K2oCjMY6cIaigki9TB20z/P5Hl8rAOA1NqRY6GO77/D/5ODS2kcgOy1913+hVK
 mnHfOxW6Ng29EVV2Z/+VUOO/lrjRUXXz8yswIFRgq7piQ/RIuW/BBjC20fJVrUbYbFBl
 fn6ElRGMDaHk5jgj/5xyEfV/6qOqAZd2uAiPufM2Ujltz5RZfQJi9IPnR6FQrK4/RLKp
 7BQhKt1d45L1gwF6eb5A5Z2fOFlCeqaS1ozF2ZMhtucrONoanCspiPvyq3XEc0EHopeB
 MmSw==
X-Gm-Message-State: AOJu0Yz9vwgQhYSAz7C4Vge9EU8pagxDZhLAq2DA9c4LKz0Ga3EcfsBJ
 w6xPeVpusT26vsFybeu+JYcUAkxsGJjt8Ol3NihjDWHgm9NUZbNg/5tePIfJpVvUIaAMVnw9JdK
 G
X-Google-Smtp-Source: AGHT+IE1D5DLEiqGfFJkDc7w2uq6H/S5D9fmXDMbbyWdjifsOpgM6pDADWkyDK3YiAIoYFbr61HKmQ==
X-Received: by 2002:a05:600c:1912:b0:42c:b4f1:f2ad with SMTP id
 5b1f17b1804b1-42f58497379mr83771775e9.33.1727687485866; 
 Mon, 30 Sep 2024 02:11:25 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fbd3sm8491315f8f.84.2024.09.30.02.11.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:11:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 03/12] target/mips: Replace MO_TE by mo_endian_env() in
 get_pte()
Date: Mon, 30 Sep 2024 11:10:52 +0200
Message-ID: <20240930091101.40591-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Replace compile-time MO_TE evaluation by runtime mo_endian_env()
one, which expand target endianness from vCPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 3836137750..e98bb95951 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -601,7 +601,7 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
         return false;
     }
 
-    oi = make_memop_idx(op | MO_TE, ptw_mmu_idx);
+    oi = make_memop_idx(op | mo_endian_env(env), ptw_mmu_idx);
     if (op == MO_64) {
         *pte = cpu_ldq_mmu(env, vaddr, oi, 0);
     } else {
-- 
2.45.2


