Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEC6C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 18:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkTDr-0002o8-Dy; Wed, 13 Mar 2024 14:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkTDp-0002n3-H0
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:21:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkTDo-0007w1-0m
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 14:21:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e6b459b457so50663b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710354058; x=1710958858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y5Oe5PylNVWZYqe4Ru7IuPn5NqtA63B9U4CZo1rmTfM=;
 b=QWBvvpt+JAdqVN95D1Tqr9TCY5QIzaIqALPJEhSAm7VU+HorE1gF5Z2HYG7RwPYggH
 rxqF0ZkSYTXdBTbz6JHoyaiY7VeqifTkmLNjrJGT9DNUXsvP4n5N75PjMJzCQlBwuOep
 L9uEO7OAWeF+Pi7dfJmho3TUO+qeLyJTFkeshy4U367SHDFvwdRISTfxUdtNG7fNAJkv
 Q2Z8EhxqEKi2OjDlGjK8E+b/oYm6XTOO3CdqAlxY1gtdC9I79GKHvEeATwU0C6y04hhr
 oLSoSazkIURu02eAeQmHcdC4rLhcLbfPLANSk0UTc23gG+MdiFSwOW3GIdjx6M+ZjPpU
 l+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710354058; x=1710958858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5Oe5PylNVWZYqe4Ru7IuPn5NqtA63B9U4CZo1rmTfM=;
 b=qXM47D0xyEm3mXTnAffxp7ewv/nbT84C35E6W2f6PYNy6Boz3V0onSDEIJ8+wTd2Q+
 5yVkFxOHIed0wz50X4dOY3G91lEjm84VsjRCMBsY61FxoYdXNSE8BurbZzsNMmln+VrL
 kRkCkQQ61QHrXuO1fdRTAVUdwY62RcpcvKm92YqdgJNKi5U2By2G6izbcevSmK2UnXup
 /0MNpe30znl0LswAw/zNqk3yLPm5taHc8Jn+aQCelcoA2NF1eeDYiYaejLNKI033K7j7
 thcY/jcot+g/fYRfVZn7Ac755gj53IAXjE/yUWmbYlyck3rihLccSdhfqwijSsC8QKrm
 5xiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWp9689FSFWbvHJernbSeykzSKV8t1SR6MDtaw8Pg/1gWKhK/PZLzrA+g34E2kCtt1vXPQZ7D7vZ61mwz+JygsY6kvcaU=
X-Gm-Message-State: AOJu0YwVRrq1nse/5u9q7ITqjR1V6/8q+hPQx/7pFrL4rRXwiMzKPrR5
 BBOBhnywCI7dovtR+CG8sZGAf93vOncXwk/ArzoUh6H8T+vrnAfQg2IZVd3i3rk=
X-Google-Smtp-Source: AGHT+IFInqwzooRcyp3lKolnKQP+vSRNSZQNiMbfvikaLAeAENg0ujwpFcInV7NErrnUw9jLIu2lLg==
X-Received: by 2002:a05:6a20:43a9:b0:1a1:67a6:511e with SMTP id
 i41-20020a056a2043a900b001a167a6511emr2965946pzl.2.1710354058592; 
 Wed, 13 Mar 2024 11:20:58 -0700 (PDT)
Received: from localhost.localdomain ([49.37.251.185])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a62be16000000b006e6a16acf85sm3457528pff.87.2024.03.13.11.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 11:20:58 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v5 3/3] target/riscv: Enable sdtrig for Ventana's Veyron CPUs
Date: Wed, 13 Mar 2024 23:50:09 +0530
Message-Id: <20240313182009.608685-4-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313182009.608685-1-hchauhan@ventanamicro.com>
References: <20240313182009.608685-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Ventana's Veyron CPUs support sdtrig ISA extension. By default, enable
the sdtrig extension and disable the debug property for these CPUs.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e0710010f5..a7ea66c7fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -568,7 +568,9 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     cpu->cfg.ext_zicbom = true;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.debug = false;
     cpu->cfg.ext_zicboz = true;
+    cpu->cfg.ext_sdtrig = true;
     cpu->cfg.ext_smaia = true;
     cpu->cfg.ext_ssaia = true;
     cpu->cfg.ext_sscofpmf = true;
-- 
2.34.1


