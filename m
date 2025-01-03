Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52ABE77188
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlCX-0000SY-JR; Fri, 03 Jan 2025 12:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCO-0000S9-FQ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:11:00 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCL-0006nV-EZ
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso123745775e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924255; x=1736529055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFOLOeMz7nvWSObnCUJsVQrXvjleVQMv9sXlW+9Cp1o=;
 b=Dv9AHlLEy6FKDGC3fNW45b1TcNhGhnXbt15irFsF51B4Eqv/zdBTlNsdEXYThKKA4E
 CSaCnZ+Nrh9a6izERArAOt5DM6p3AevHWuRi0fJMG+PJs3yrL0Mb68RFE4a9UXzKfDdw
 Wp/JrB3o1ypwS3ys7uTzYzsvVkoCo4LR9w/pGU8446DznlFLSD/HTHkV73LwoC8/xbzP
 UyzserCsY+TY6lMDHFdPRio/tET8RoeO/c5medVvN6fuqq/gdWCSALaFonZ7nBuzOy6Q
 yGa6T0s8jislrW7E/umlEKz4sAGVc7vumUs+t3Yv9c7BsBD8K5pPqf6rvrmwosjWZF34
 lQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924255; x=1736529055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFOLOeMz7nvWSObnCUJsVQrXvjleVQMv9sXlW+9Cp1o=;
 b=WJOq/ARHV9+gna9FN/LR4G8wfYjA6Q/z5n3q7o6C5l/kbnY2Zult+8/YQmN8avCNrC
 B51P+vKYaoslv2hTDrh2QJ/Ou6jTH2CT7u+SUKa9C10oKPDwyBoABQg1EluzvRxM8cnC
 eKlDYoqYKcjglOnbnoQrzbaApbrddRTNJ+HxH6Ud0T+5wAKlWY6Ov62N2J6zZcHewuE/
 PU1KGFFGwCV0MousiEewj9J2nD8a/cze1OYbPs2bFDijgi6bVSNTj5iVAfpbzwdhIbdm
 blL6e69eA0Ma3KnB5UZu+7tpJphA91V90PJderMacQI8E70aDfD6XljEGJiqgrfZ0I1G
 Yk1Q==
X-Gm-Message-State: AOJu0YxZY+FbdSUHHL8XckMFtuTO6LJPtOQxLhIAPWfw3+MyH8N+r1fH
 fw0rmq0j3s0oJ1cDVNdy8UxvqLlBnlWBJxPO8SjyBBJD9PlbEoPf8GM95yUQM/wO6XTbo4VIrPa
 htrM=
X-Gm-Gg: ASbGnctb9FtnM7O9Zelk1qAWQxYc5IMaf/AZFRsd6MOFpW8DlBMEa8n94MbUUH67PdJ
 nLpYBAaTZBg6mBFP3UGW+O/TNKk6bMlP44L4zAg04JHWDwQzWd/WiD7aKXTFnsY8y8MnwfSgfnq
 XjNP32sA07/uYwKiYVw9weZpa/pX093v2QmM0q/t9lKnaIoX/JGa+50/Xe8QnJ/P69Lrhfgjas0
 mQo338xrm7mYs9CWLC0gfMxxaDUuqHh4KU/qgjOem8K+DpRZ7z5+wqWRNb1DLqaCy3rHnKhCrKt
 SfK2T+b8v8RN3FTxN4v+kUYj1Fed6Wo=
X-Google-Smtp-Source: AGHT+IF+rrMTjue2+vuHoiVnpaonjflsL6Kb9Yitix7awOVRt+ocOHs/fJ/l5ks1VsYkMQngWSqRcg==
X-Received: by 2002:a05:600c:45c6:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-43668b4808fmr385949495e9.23.1735924255552; 
 Fri, 03 Jan 2025 09:10:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219578sm493380585e9.20.2025.01.03.09.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:10:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] semihosting/arm-compat: Include missing 'cpu.h' header
Date: Fri,  3 Jan 2025 18:10:35 +0100
Message-ID: <20250103171037.11265-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org>
References: <20250103171037.11265-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

ARM semihosting implementations in "common-semi-target.h"
must de-reference the target CPUArchState, which is declared
in each target "cpu.h" header. Include it in order to avoid
when refactoring:

  In file included from ../../semihosting/arm-compat-semi.c:169:
  ../target/riscv/common-semi-target.h:16:5: error: use of undeclared identifier 'RISCVCPU'
     16 |     RISCVCPU *cpu = RISCV_CPU(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index d78c6428b90..86e5260e504 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -166,6 +166,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 
 #endif
 
+#include "cpu.h"
 #include "common-semi-target.h"
 
 /*
-- 
2.47.1


