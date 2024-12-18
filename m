Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151FCE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2dH-00085H-QB; Wed, 18 Dec 2024 17:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zk-0003Tu-En
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:32 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2Zj-0003J6-3K
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:31:28 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21636268e43so2077205ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561085; x=1735165885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/T6s7NuyqbCwN2jCWIlgsYdz1CmvdWGUJ2hvWilD9qM=;
 b=XDrdYFdyMDYxBfX+LorVaqokW8FfXQljtYPFwgCmM65BCFKhH17SsgejDFjlcdOTsL
 npU8ursY4JrtVprmkv4WKUoYBhgZW9Mohd146kv7z56NiIjSTiQX4SesteQpK27sVNzy
 aGRcAot1Xb4YC6duOCqFWDwrYzzU8tF7N4uCIH3Go7Ue7j3getZ68D9Fkv2wuM5GIRMN
 /nZ37cWTSKCjGQJK2bDzP/F0xTuPIXhQf9qhHjDn6uRc09yqjqkrhXYBn6Yy5ZXBibGr
 dIi1bCtyGt2qnZfi9PhNiQAjDPuWlTJeSWq5b/zc9d27cyWIISvOXZjNy7ZiG9sZq3i2
 inrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561085; x=1735165885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/T6s7NuyqbCwN2jCWIlgsYdz1CmvdWGUJ2hvWilD9qM=;
 b=m6jtl8QeibfRB8qKzBBcg8dDJ8/1FGemE+VpHz1OBz6Xq+KF0gJxFc/HAjP86SgQHY
 dBEPUg4vLRvLKY1S1s7oncNf/bwOfPQmVrgz7USlWOn9xA1KSdYCtmWBeVVS72WCEIdZ
 1eFur4QrA6aw3uxdzEx86kXRTBF/xyb+Mzi2pSg5nVP9PE2OlllvWigERD7yn+yAN2ob
 kflxCVlfRxLxeL+8gSJeLbsEDV3NhrHAuUXu4qnaqbwR8qAUG1SkJA28EKKWNdg/oobf
 6+iF5sK+BFKIFx31FNjJVe/KKq6oZY4v0Prfp739asNYHFGzQirpUnUPlFm60+9+vJHV
 luZQ==
X-Gm-Message-State: AOJu0YxoM7cwiom6n3ncVEniT3hI7XrZRMNSvQTl/KIH0O0+W5s4oGfh
 xldS2aPb9aGLOn6LxRXhmQUv96oUDd/Plm2vcChfTJJoV+sAdoDaQtHywkZG
X-Gm-Gg: ASbGnctvlMsXL1/Y1cCtYADJBdHyYPmEk8AvcrCcoWzyDR4EheR5vxBwg2NGc8Vya+P
 e9RVO1Nqh+8bPZRotinJZxCAirsum5qGM3xW0QmDgOqZqLZ8qdIbVx+KutqwFp4Tcyx9xmy1liL
 Ai4DaXj1W0OYI2IAFck+6mvkIJcrIWvFK3SfzhCLd0jGEzrWDazt0njwvN2ruUHx097HgHpPh7F
 G32TR0FP2waF+FicJ912Uv7bVD85dgmCIDO6AuTKt9Y2F+e+iOBNAeu3rq2cxdePVClINoTVB5I
 zQfxXeORGWenQ9rPyCHQp4yZ+4XDvqVUeLIK6bzJpUBL/k/tDjn8TgpRgRNcUN4=
X-Google-Smtp-Source: AGHT+IFnnKyQgDZJBSkaJH/7x7n8jpOjiUrUs+AoA9CX+l7IRzrrccnFzo98a7R3PwJ6Kku/TtiE1Q==
X-Received: by 2002:a17:902:f607:b0:215:bf1b:a894 with SMTP id
 d9443c01a7336-219d96723a2mr17729445ad.24.1734561085462; 
 Wed, 18 Dec 2024 14:31:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:31:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 23/39] MAINTAINERS: Cover RISC-V HTIF interface
Date: Thu, 19 Dec 2024 08:29:53 +1000
Message-ID: <20241218223010.1931245-24-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The HTIF interface is RISC-V specific, add
it within the MAINTAINERS section covering
hw/riscv/.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241129154304.34946-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27c21cd578..3bba2efbc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -324,8 +324,10 @@ S: Supported
 F: configs/targets/riscv*
 F: docs/system/target-riscv.rst
 F: target/riscv/
+F: hw/char/riscv_htif.c
 F: hw/riscv/
 F: hw/intc/riscv*
+F: include/hw/char/riscv_htif.h
 F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
-- 
2.47.1


