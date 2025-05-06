Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79100C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJYT-0007Nx-Ft; Tue, 06 May 2025 10:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVU-0002C1-NN
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVS-0002BX-U1
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso25467935e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542569; x=1747147369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IsF/CSowd+jniSJy7riyQNMBm1JGaQMWj1ippYdOx1k=;
 b=qPi0QCFg9qkRpp5zZoegQPTW7L/3j428P6QYkUB/Ab0pNN3waXOFsdxCanzr4DRXXy
 sEMRWK1df7UF7MwBCus+dJN4bLh9RhFeRw6EgsTCD/cM5OpjLCyqPS8y3x66rZsciJCH
 YePANTDMy9Kdu/78qspgief/StQUr1T2jN7JrQHc4U8h02svo74f5xlGXutP4SVW74JR
 dKc5CgJjZYHx0JeDfvZ3SQZnit5TRiKVGteo1kSfrXdP3vUF1ns9A6Qg678OJn063xSO
 /yUTCWhnWGEb37VI6l3f42uQz11CQ+f3Rtajf1GSwtNs5oolIofilwgiL8tpsyiE2hcV
 usvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542569; x=1747147369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsF/CSowd+jniSJy7riyQNMBm1JGaQMWj1ippYdOx1k=;
 b=eUEFEH7/drqTyvILrvHu5H+SOf85UNTAf6UP5RubBCyFFXpVvu4CjEZ3TWhAg/Xa6g
 QBbBnVtQsxr7K8594Xk8R/eEoAvVnlMSAtYwYvTMJ+FGhkQcwsjYrANKMIiwmch7Jp7/
 /CQ8T6ChphK68j1lfbCwm9zRjRh6VuW427DLjpDUfLFgWtyltTjriBcOmR12ePGmJsae
 TpQvu7bjwOCg16u2V51pAiUKoOsMKQWrIeLwK5WtzihWNmT5nn8wh+bVHCSuqitQtvLZ
 80heaWP5OuGfp7JJy8yWtKzA5s5AtkK2G8Th7VLpyStOBaiNl62pWalUhDN+dRUSpsNV
 dqAg==
X-Gm-Message-State: AOJu0YxRL7TEmda3FzMK6UMksWPKnxqP4c0bAgNMAud130AOuPKgQSpP
 +j4T69nXxOLBYMh7YAei6T/cHdpC4p4zJFlWHfGPrg7uBkjlxd4yjRZpqd9pzZrKnwqr8CR0tjR
 B
X-Gm-Gg: ASbGncv+zCO2b/n5ZBs4gelEcdGzYBKPvo+kow9KlhZyf6ygXsEaFvnRPCXab2CtI5e
 hkblclH/mkYemxQ3gK7Cv4zwF+i1aYLQoIPnM4+zg5SiPtnMVtwWxyQewlT+R6oF4zdGorG3fdP
 tXuzaTIytAEXq4sjDxUw0Fwyq5ie9YmTRWTcRaoLB/an/yR2aYI/T0b4VtDy5nbxsAw5tPovLS4
 xCx7GJY283bCMfehoY/i8WXClDt1BTEMTNkef8EQz/ENYsOMjhNNsD89irqzvdyduqZ0NPmcu02
 MaOh/0Wyt0o0+UVB3CvDqmC1yUAdksa81Cvv7X8dp6me9Kw=
X-Google-Smtp-Source: AGHT+IH/zzU3EeHt17geySXSwgsJuzHuWNjfsmB8njaqPF5W8ytOjnB9IwbWaGKDBBpZJX0POLy1ZA==
X-Received: by 2002:a05:600c:a413:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-441cbc3e6c1mr54232805e9.22.1746542569236; 
 Tue, 06 May 2025 07:42:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] hw/arm/virt: Update comment about Multiprocessor
 Affinity Register
Date: Tue,  6 May 2025 15:42:11 +0100
Message-ID: <20250506144214.1221450-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Support on ARMv7 has been dropped in commit 82bf7ae84ce
("target/arm: Remove KVM support for 32-bit Arm hosts").
Update the comment in virt_cpu_mp_affinity() to avoid
mentioning it.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429153907.31866-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bd1a68673a7..03fef07c9da 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1766,12 +1766,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
     uint8_t clustersz;
 
     /*
-     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-     * GIC's target-list limitations. 32-bit KVM hosts currently
-     * always create clusters of 4 CPUs, but that is expected to
-     * change when they gain support for gicv3. When KVM is enabled
-     * it will override the changes we make here, therefore our
-     * purposes are to make TCG consistent (with 64-bit KVM hosts)
+     * Adjust MPIDR to make TCG consistent (with 64-bit KVM hosts)
      * and to improve SGI efficiency.
      */
     if (vms->gic_version == VIRT_GIC_VERSION_2) {
-- 
2.43.0


