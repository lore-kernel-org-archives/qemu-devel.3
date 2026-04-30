Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49456FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJrP-0006rO-Ns; Thu, 30 Apr 2026 01:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIJrL-0006os-Hi
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:22:47 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIJrJ-0006UT-3P
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:22:46 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso314171a91.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777526563; x=1778131363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yh+z7xiP60EABO3cTvH29j9rfKWffE9v91aJ4lXZ+mo=;
 b=YpXIuxNn4CiGOtO9xdUwbXrTJi6f5b1M5WvSIpw4F1XzHyJhr5uun9zYtHjIK1nUnm
 wsuDuNLWlyvij4HNJ1fBqPbeLNu8YgPEc5x5m6+0Z+zvlgKqV6R5y/T5V2Bay2IglTId
 CgEGCkKX9qbf6+gffKZmsjqIFvZbujrRZhsIcp1I3GqQHayB1ctu2666jnVBLztRwo4u
 wveGWfyTlr1ZuhIzgFjkLFcEZ2Dtl14NlEYyjTuEV6qZ8dSwy47jSUFwKnJjN7XrxNCd
 sN+JHFyHgZysFl/ACSyn/TWgLbQQrXzN/FsylnTaUq/dmWwDm30rNWyp1cW7IqOv5PjU
 3ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777526563; x=1778131363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yh+z7xiP60EABO3cTvH29j9rfKWffE9v91aJ4lXZ+mo=;
 b=f3gQ2bgTWo9sJ4I8xCYu2Y31ho33J2vHGFMY8BXOlLdodRaaYnZyxeR4tRG3xt8URV
 8AlevOiJXb+FakiSC0jtNR+F8JUCRcAcX+2R0jvaMxWEJgMaGeuSgZNfRiGJ+05Fv2vi
 DA6BEfpwaDsJHhIGspm2/tazpdkQiF+e7qpT0+J0ORVqVREd5h1J60HxYxXL2/a6Ou1e
 nyRbBpsEBqq13t1DL3rsxJ9W6BllLR6RFpq2Sz4bUvPkS0nm5OpSgMe1RVS+aPJ/vfrL
 pGAQoMf0ogwI10hFBG9+zWedX11ll9OK/9TPTP/3P9EYKOsNj1VZCkFrnUyXyVX2UZ5d
 YMoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gGeZI9DqpJsiEPBsZCKeS4CLAQ5joT8kIa60l5D5JM4wibsD2ItbCE26O1OUvZZzdl2fMY/0OiIZt@nongnu.org
X-Gm-Message-State: AOJu0Yzu6Y0CEfmSVResjhbN8uoeFla8TSddcxACJl5gzVBClI6lubIF
 tY/2StczDRMzlOwh9mNq5raSoGaB220mUoRNfClB7GFiuFZRugFN//p4
X-Gm-Gg: AeBDievUw9yydkfF6kI+07512MLZOgq5j4c5XntGBBNWObDP566diTdeEIskL6umHYf
 DcehWThLRfjLGjLMXn1ISZP/KEkA3Z1aIbkoE3XOI0te9OY13wLuEKoc1KJVE97ZobZ+r0YpCXp
 FRbpuwfr5byrNeeEGR7xfQgpM/7kr8t/StBsr4rtfc2tMBfTaY6i7Ym1TEwj5JBjnmZrgxjoOAi
 Ir3Cx4YsqpaQ5zEYN5SnNDkQf803P6yI+dwFD0PoTDqOcZjdXwPzvepAeHO+dnIx6iQHl4gUMcI
 sgmAG1u0rFaoYIKgwKFfP4j6qs+440kRPyqj9iDXr1RbAyTGGmx57CsYYPSoP2iPlMLLXLNcHEj
 rO4gXCLIl2s3kli7+l287/pFqLl+c3Rv4K7sRKtX/nLsEFb8095YtwunSIBhYYKXYpFHPFNRAGt
 aXwIQ5y9gsYyZHh75RzPfqkwzQIr2MvCMijE2NSJIUYrtqOm/LppaX
X-Received: by 2002:a17:903:bd5:b0:2b2:5597:bad4 with SMTP id
 d9443c01a7336-2b9a24fc0efmr10258205ad.30.1777526563546; 
 Wed, 29 Apr 2026 22:22:43 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988985b52sm38934965ad.75.2026.04.29.22.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:22:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/2] target/riscv: Deprecate the shakti_c machine
Date: Thu, 30 Apr 2026 15:22:18 +1000
Message-ID: <20260430052218.771358-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430052218.771358-1-alistair.francis@wdc.com>
References: <20260430052218.771358-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V shakti_c machine hasn't had meaningful contributions since 2021
and is currently unmaintained. The machine is scheduled to be removed as it
appears to have no users.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/about/deprecated.rst | 8 ++++++++
 hw/riscv/shakti_c.c       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index f3622dcf93..041f71c5bf 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -282,6 +282,14 @@ firmware is available to boot it. It can be replaced by the
 ``ast2700fc``, another multi-SoC machine based on the newer AST2700
 SoCs which are excepted to receive better support in the future.
 
+
+RISC-V Shakti machine (since 11.1)
+''''''''''''''''''''''''''''''''''''''''''
+
+The RISC-V ``shakti_c`` machine hasn't had meaningful contributions since 2021
+and is currently unmaintained. The machine is scheduled to be removed as it
+appears to have no users.
+
 Backend options
 ---------------
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 49a39b3021..852d5b9797 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -83,6 +83,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, const void *data)
     mc->init = shakti_c_machine_state_init;
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->deprecation_reason = "Currently unmaintained with no known users";
     mc->default_ram_id = "riscv.shakti.c.ram";
 }
 
-- 
2.53.0


