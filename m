Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF4C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkjNC-0001O7-1Z; Thu, 14 Mar 2024 07:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMt-0001LF-9b
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hchauhan@ventanamicro.com>)
 id 1rkjMq-0007I2-Di
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:35:27 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1dde367a10aso247425ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 04:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710416120; x=1711020920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNWDQzg7Cj2NmO7oV7q03WSZVn4J1P7IOb9ROmxn1Qs=;
 b=i78tVxtIPXB1hLdOY797hImfgOLGO04WZqSVqZphQTrwE6ODrqLBeyoW2J+koVxix2
 EWsQAN2e7WyX4fMIsPejFFuvJbk5mZ3TsYcoUS11YDBQx3dzjkrNmmfA3uzw8OzW505F
 syUkjS9gK+o3vav2M1vo841U5/1NDXxFVuE65TRpyuQmfw6D/vNHvck6gwJr6P+WEntp
 4Rgh7GmOjvyQKMRX3rPZfqr3XpNPa5KmHqvEnb5930Qa3lUE0DboE7JdHnDr+XBKMvnd
 JtU92TlEAL30+2YX0lfrr+IpN8kA25wFmWWA50W74d2Vt4/9C+m4uOOCR1djObYfzkcs
 i8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710416120; x=1711020920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNWDQzg7Cj2NmO7oV7q03WSZVn4J1P7IOb9ROmxn1Qs=;
 b=iNW5IuRStZTlQfYJ8Yvdh908JgLP8lUWj7sWt+/eKpoDwbRdSu86pp0i0D3MAUmXb/
 wXrYcRmrBdDEE7GbtNDeqf28Pt2YAtn5rl5JTg8wMWbDSC/B2XxrhBHIC7os40xEmPm6
 hTpJiQfgEd6c4raUyYpckD5Mgpc086sBZnOiGmUpep4GRgDeQuNBFF/i9Kjj8RXOWvRr
 /NxgWeAnpYiIzJe5MvC+T8A+PbXMxjHL2K1Aya34T3D5j9IUTx2ulkw9GSFeLIVl+m+E
 HYEREH9JHRVYIFEHhGHLnEh6abcTTxDqS1z2vhgGB9WIiXBJiXC7OmquXOyf6PGdIZdF
 PRPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa4vHgSUGz21gyxLItkHUigMYIOCzpefOeIy991qQ8WtMv12kZu2OzOpmcpjQfj1t5v1l9g7AS9c9QMDxNapru6G4nbZU=
X-Gm-Message-State: AOJu0YziAtD2Y7Hv4xv6tRD2YH5iZvq8x7wZnOJ0USxLZ9BLSFpXSl2I
 QLhrXRBZAO+VckacfmXpO9nXCWh15OpLb6ycyCxaMHoi0VhzFHvZJMiXXv7IEX3pX7Ek8R0H86f
 a898=
X-Google-Smtp-Source: AGHT+IEMiIdwVR/qco9lcEISeI3075BXQAmycq13RyanmtV6Bs5IvejyhislGKRpsmay/wpgkkOGdw==
X-Received: by 2002:a17:902:d50f:b0:1dc:3c:fb67 with SMTP id
 b15-20020a170902d50f00b001dc003cfb67mr1531812plg.5.1710416120349; 
 Thu, 14 Mar 2024 04:35:20 -0700 (PDT)
Received: from aryabhatta.. ([49.37.251.185]) by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001dc6f7e794dsm1465859plg.16.2024.03.14.04.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 04:35:20 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com
Subject: [PATCH v6 3/3] target/riscv: Enable sdtrig for Ventana's Veyron CPUs
Date: Thu, 14 Mar 2024 17:05:10 +0530
Message-Id: <20240314113510.477862-4-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314113510.477862-1-hchauhan@ventanamicro.com>
References: <20240314113510.477862-1-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=hchauhan@ventanamicro.com; helo=mail-pl1-x62f.google.com
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
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 66c91fffd6..3c7ad1c903 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -569,6 +569,7 @@ static void rv64_veyron_v1_cpu_init(Object *obj)
     cpu->cfg.cbom_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.ext_zicboz = true;
+    cpu->cfg.ext_sdtrig = true;
     cpu->cfg.ext_smaia = true;
     cpu->cfg.ext_ssaia = true;
     cpu->cfg.ext_sscofpmf = true;
-- 
2.34.1


