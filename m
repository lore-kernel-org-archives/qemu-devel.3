Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91354C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 02:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u73gC-0008QT-Ki; Mon, 21 Apr 2025 22:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u73g8-0008PY-B5; Mon, 21 Apr 2025 22:48:08 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u73g6-0000Xk-30; Mon, 21 Apr 2025 22:48:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3965872b3a.0; 
 Mon, 21 Apr 2025 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745290083; x=1745894883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vzl0dw5uyUGkAFVL9sbZNFQL5TZWh8CfZO659Fc76pQ=;
 b=JxOkkXmQW2AMqjjPavG2ikS7WfSlSauflQGiF6lwJxNSA0MCwTRkh30XVOfhoBnP9T
 zuunJ6H+Gj0EU/ppXFiGBtmwc7MN1LVALjyzIJW8Uaxu+ZvAIb/rSZbv8y9L5seI9CXD
 w6lGPYYy8ZVOJn8hDqOR73fsUM/jW4v5zLbRo29jsEcBK3+sqYqPPsC7I0k3Zxegwre8
 80WTMDb7pUiuQgH+ZvldFqZXZ4ztexm+zqqXtBbp9kkHfmk90/LCeD1Sz2+Gef1F+HAR
 qH8viuLLvVsGyuC7hw1zS6BNvYVxjx2ZhpdRi3tunK+h8ujSnifuefSPBPj1WHt6FmB2
 o86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745290083; x=1745894883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vzl0dw5uyUGkAFVL9sbZNFQL5TZWh8CfZO659Fc76pQ=;
 b=H+9Hgo+LVklDgMAt8paCh3N8BHTemxJyDY2kd7lprXnT5zqhoMVbz3iaJftbsuZh7B
 mx2jNk3QdvsGVtFm/xbwinyJQBFQtaiOuTSpuBFU9ZkJCUZ2ZQafxSzPvwYl9NbD4KxI
 yXT35gUCDFPhHCVbkNDcYuyos+mQ2+ETLUf/946f0wZ0mq1UW0+b3rSE4sZsf+bVu/UO
 HoNiURC9z07DrDcAJAOvbKwzCnH5nZm3DNUJLtR9LLPelPK03+lYQbg8Lhy1uMkBTGx6
 GO1Wd44OyZMlnUDDC/8ibt8whPlMFX4k9WtpocIMRZGhEZBkFysNTV8ZR+KlghE2+QzF
 sfFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWesELQEH3BGzPeo2qLqmZ5nDYWmQ9tfp6b9tcJvnK79FYAvogu7U682yjH8MI29SwclthKUTIdjdNn@nongnu.org
X-Gm-Message-State: AOJu0YzBdgz1Sm8LDS8QHxGRjWibCYIZOi4VcyBJan+/0nzugAOk+Ka+
 SzXxkMRqxPS+SIPzl82J3bgEMEwzH2Afjimt67IoR7trgmkL5bQl
X-Gm-Gg: ASbGncvf147/x7koFedEfan+OoaZqrKJV+zAJyZWYPSxWqyfoImgCxmKqPf2n/pY1Rf
 nQHDdpPa6do65oS74wqC+u4DbZOBiqYBTTaoLArthcWaQXcNr0d3dgjLwmMBzm4c/uY82RrSQQ3
 ht0h7JE1hQs2XdYjasAFCaPJunzlkPs8gw9ClzL6xpk0Hj0bgPoI+hjbx/+CrofikP/4Sw1kLi/
 3XWWYnQbQYr+Av747Lw+GGQBJity8eDB5dx7hmAMGcbuWZdj+pNEJ7FhrbF8mjGStZbJeljDI4H
 uMLZX3h2FPirnQ0gG6ad/GX8KZ9W25340tphaPPv0m4n+tmdwJ/FM6AkWhgR8b8Dptn6I0kXv0h
 crpdYNZWJ2OKQqHisBp+m/dSNLkVo9LkSJlZTEsfKsMmCV8SXOJBbxB24
X-Google-Smtp-Source: AGHT+IEFvwegkdKbwBg1yjexbOSuOJxWuw0yVXHUoEzED37OBkDdKDbVQ/C+QnMpfYsEvHPvS0b4aA==
X-Received: by 2002:a05:6a00:1306:b0:736:7960:981f with SMTP id
 d2e1a72fcca58-73dc1494032mr20287812b3a.8.1745290083494; 
 Mon, 21 Apr 2025 19:48:03 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbfa574fasm7639408b3a.99.2025.04.21.19.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 19:48:02 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, uwu@icenowy.me
Cc: qemu-devel@nongnu.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] MAINTAINERS: Add common-user/host/riscv to RISC-V section
Date: Tue, 22 Apr 2025 12:47:52 +1000
Message-ID: <20250422024752.2060289-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..d1551d9cc6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -328,6 +328,7 @@ F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
+F: common-user/host/riscv*
 F: tests/functional/test_riscv*
 F: tests/tcg/riscv64/
 
-- 
2.49.0


