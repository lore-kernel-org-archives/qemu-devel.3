Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E174BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 06:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkHpH-0000Yn-0h; Wed, 13 Mar 2024 02:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHow-0000Vc-Cj
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkHoo-00008w-PN
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 02:10:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dd3c6c8dbbso10536955ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 23:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710310220; x=1710915020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vyCSucVrf+Vy6cdbeKJg8n86g0EOFvFg8cc6rgKBkXE=;
 b=O1XzvURpM9KzjUhOWBuzmFQxfmvkpIZDIx8+CGYCfNXd6ej67r8wvnaOSozEol/7rA
 kXU+osbVwOk6rqp+BW6seOqKE5Ydx1plNAaCfOTvELRiFF7DWibVdCoj9X5Aw5LY30Is
 zwusqnf19gGptufwGQCd9QqsBzM+5dOZGt4CAIoI5edzkJh/oTd1+1E6a9bVJv0c51DL
 LXtQucwliCxwkZlemgo91ubLb0oJHt69yzyi0gJWBXJA8CRh34CKTQ7fQzSRuAciWmOW
 QFP2nUDFOeqOmtuPUNJfxLxEbSXrw5qc7LqgWbBJ8BtTniJEmBFNoXkf1XkMcT7ryqAg
 /Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710310220; x=1710915020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vyCSucVrf+Vy6cdbeKJg8n86g0EOFvFg8cc6rgKBkXE=;
 b=lFAYfpX16LPETAqhwDhsoOHnk19qaHfnbC0E+7Bu6OiVfxX0Bo7mOcbf8McsNaQqrg
 Ami99YQkuuK20sXbNqmqAfs7+F3/M1wYyvW6cI1MsLjy7Yc6RUR+NnyvySDNJclwOoeF
 C6E9tVQxpKPcbmk7WDclg84WWKhwcOib23QO+hYuhHqsx3iy6QDI4Z/xOcWENSFBm7O/
 t55CYGTWgqAgW8uJmcBH6PQ3IbZ4mEs4e7aQU6iuXuELNbrh7quGNCNyJNIzHssWlnAo
 9VEKRG8REAxaPdmso3RlL0XzjlR4R4ei0k7KUMt1tN97NGYv7H1428O8y6qXk+uf8i1C
 hmRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8y9OR1iMKm9XLvWyU7ccQtico410d2TlaljmH07n4VjoDVKSbj2lVZ0hIpqIdMfVGltpzCxQeBdMp9aZn3FwgIfcjJFM=
X-Gm-Message-State: AOJu0YyaU/vYXPyjWqMrXKMHcB2LRtc6EqWrDYPwWpIgqK7WMKCQ62IX
 OnDp4YzB5SjVBp2XciEV3O7QawkjfufJKRDG4Rw+MPpB3mer2Y/G0D0HgsXPlKo=
X-Google-Smtp-Source: AGHT+IHip3y4zqqJRj41qLIwWeZ8MuB5IVmlZCLDAvyP/3xR6jazyXhLhFblBobsdr5I3xSOKdialQ==
X-Received: by 2002:a17:902:e843:b0:1dd:b883:3398 with SMTP id
 t3-20020a170902e84300b001ddb8833398mr3826257plg.4.1710310219966; 
 Tue, 12 Mar 2024 23:10:19 -0700 (PDT)
Received: from localhost.localdomain ([106.51.83.242])
 by smtp.gmail.com with ESMTPSA id
 kj14-20020a17090306ce00b001dd3bc79142sm7755402plb.264.2024.03.12.23.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 23:10:19 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] target/riscv: Enable sdtrig for Ventana's Veyron CPUs
Date: Wed, 13 Mar 2024 11:39:31 +0530
Message-Id: <20240313060931.242161-4-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313060931.242161-1-hchauhan@ventanamicro.com>
References: <20240313060931.242161-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
index ab057a0926..9ddebe468b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -568,7 +568,9 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     cpu->cfg.ext_zicbom = true;
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.debug=false;
     cpu->cfg.ext_zicboz = true;
+    cpu->cfg.ext_sdtrig = true;
     cpu->cfg.ext_smaia = true;
     cpu->cfg.ext_ssaia = true;
     cpu->cfg.ext_sscofpmf = true;
-- 
2.34.1


