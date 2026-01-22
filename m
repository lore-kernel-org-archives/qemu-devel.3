Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44395D6CFA2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 21:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj1oi-0003Re-VF; Thu, 22 Jan 2026 16:02:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oY-0003Ld-KD
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj1oW-0005JD-U0
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 16:02:02 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so16448305e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 13:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769115719; x=1769720519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZixBBXw9pW9Lb2/N+W+Mo89Bf4jJ5ucu9PIzWSFCxg=;
 b=uKWlzzYOaOONYCGfOyy9FabVkzqH35t8G1khL1j0MrGOJCiLkKc9d9AT2B9eyqiB2f
 XnoLvosYP2Wylr+ztx3WacEADRJTrxyyxrr28knRd6VeKxOqcC7qDv9nrKGyspQsC0EG
 zO90yfaqUyLo39MccOQ7g4Iz2rPVpRcSDavpvMR+HPsNmMNKiyVGrAvAHwNzoSO7qKkH
 lN3wxTFMtsYGbsupOcPlvG4PvLdKgEDotheMCAsMnkuQEnWlPF0JF39zg7pXD2nnk10Q
 8DepJu51yuf37Pb7gvIbzqGU/fhiT4Vp2bxE3MFif7+wUvx96wXV1wjo0C6A+/f2/uUs
 HhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769115719; x=1769720519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pZixBBXw9pW9Lb2/N+W+Mo89Bf4jJ5ucu9PIzWSFCxg=;
 b=wp5cECxXXptVfMO7wiMWOtWkAafx1J/V09Wo3P2JiKBSFxibNGUMJs+a1QhGTb2zKM
 xJTSsOwPtwWuLCNyx7HrhWW4GIve4heBy50X5rs+Uvmp4zU8OvdYu7rCzb8ljMSRgxZo
 OBwKXyieDNVSSTcHxgnkqUjcJyxaKPn2xYEU8NL6TGMj/BlvpYgCbfjGSCEIsBHgz8h7
 sLTcFV9fWDQRK0wxY9rLQIOLgI2wAbJQgLpmRw8s7ONouhcsQSS9bTJcJaptUWohI7rw
 Ih9lsifvJCwNiS+qlc0XYry7X6odLiUoEBsK62QgdAgUXxa+up13x2fD7K5N8phJAtKu
 Yvmg==
X-Gm-Message-State: AOJu0YyyNbLIUFDqHkABUFu3xXh73zztfayPYrfTdYJdZSPoqzORgE5Q
 u7rihCe5T1jNn/LJya/hByc0w5UfJv93/WiMX5vyx9zXC9U2M56DBFs9vk8lWtlMYIQd232C9fw
 0ExkmbmuWZw==
X-Gm-Gg: AZuq6aIWbTLDt6ZFcR0gaVW8peKzobBiOmXZGhtCtrAX5/V0FIl8wBKezgl8vMAVSbG
 j/8e1aAcoe2C3qTvEMyrn3vFhAjv9N04UxvypRh+oVp4qLpy6eos95bwKImE//yeYV8Gqzpx22+
 guD8XMOmVEv/0phkfW6N/dCSwvUbmRk+FbUP0gKpOYDj1h64KyKkfqPQn6IBAslW0UxKCH9pl1n
 I2YYkJ36RzORYZudgocymy6zXtlEOl/EpnaB1DAM0KgaT87pZNz8lgXqaXGrfPLwJ5HUtMm7124
 /LEWQpz3FD0o5s55bXt0PYTi3Y8t5X5lhc26E4k/9QfE2J1U6fCWKCkHAzHtZ+PZI3/+dYWOXG0
 oRtSHFw9RSzuJCyQefrSSiNlNLLk8J4OkLXMbFFdaBqMgRQuKMjPb0qD/5lbknuwbkPMwMkhEst
 yasNEB12TWtovk19EsLv4AZlbhbk0Cvit9DO3dvH33+hLHvEtXWpQvUf08TLv9
X-Received: by 2002:a05:600c:6217:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-4804d664990mr8920045e9.0.1769115719013; 
 Thu, 22 Jan 2026 13:01:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8a5b2dsm8310935e9.9.2026.01.22.13.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 13:01:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>,
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 08/11] target/ppc: Check endianness via env in
 ppc_disas_set_info()
Date: Thu, 22 Jan 2026 22:00:58 +0100
Message-ID: <20260122210101.55358-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122210101.55358-1-philmd@linaro.org>
References: <20260122210101.55358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

disas_set_info() shouldn't bother with env->hflags,
access env->msr directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 58816c51a74..0808284b722 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7456,7 +7456,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 {
     CPUPPCState *env = cpu_env(cs);
 
-    if ((env->hflags >> MSR_LE) & 1) {
+    if ((env->msr >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
     } else {
         info->endian = BFD_ENDIAN_BIG;
-- 
2.52.0


