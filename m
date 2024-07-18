Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADF3C3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGd7-0004Pl-06; Wed, 17 Jul 2024 22:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGca-0001Mx-SJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:55 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGcW-0003fF-GY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:11:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc611a0f8cso772415ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268704; x=1721873504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rTV/9kQyF11tzWqFUGlJ6f4whn2rX97OUGdwnboGFc=;
 b=AXxmLBejL6+m6RA/3udz4ZWN7IkNSwzymphsyUL1hyC3XxqiqmDwO4/z4yfO923klP
 6RZobWt+YF0b5OFSc4n1R77S5MqsXwepBxHLtNnwxm0vsLytYBMnNlXWyfbttKf2ywKg
 Sen4ZrDZAUnzS3acMXHckKSGdtzR2bIIxx0QGoxaZ97+E7m7RtwbFrt0rzlBdy9IjJ6b
 N+wrDLyceXY04D1ChzdtVG0qz8umQYJARadegs/C3IvyVE7C65I5TNSwvNDoSMjJSLQb
 nu5qrjE+exOEDZ8wgSIdXb4O1k0QAFOLRBY/WIxZ9qHfTvDat2kXHnxq978q3iZm3ELE
 OszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268704; x=1721873504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rTV/9kQyF11tzWqFUGlJ6f4whn2rX97OUGdwnboGFc=;
 b=IlabM8sj4oCVmPzCqNMrwv59FAHaXm5QnE/ZKySUm3x1ZMRpVJjaZbr3tZDKLSPM6M
 04XySqLeh3+yASiaXa8Z0/pcwyApZXe8ncwKFM/r4pfNiRv4RBCRE82VEY3ZWTbUjsYG
 DY6wN7xTO3mZNUdaFa0JegGdyqQtXtYBIAlXZNy2QSOXHKLMhnTUC1OSnYI/2vvpAZSo
 Q/Fk5XpAtPwUahJqwbUNwX5j5C/Vk2tA7IuqO19NO2Nl/FSesCXorOhHi4eoWqhdXItz
 tAbNBhksgNTrfBzak/ogCOSGsjTLDd7/SKJzuJOZlb90LLD2/xQaK8To+6upk0oHGrYv
 uXiQ==
X-Gm-Message-State: AOJu0YzP0/Hn2xpIEKsrsswVKqMdRWuXigXq5nB+6awVe2AgWyvR69O0
 1fhZjnlnbdmz/6TYtg2zDtQuEUCEovozbMEdo5fHjYXHeqZr3IKQ+16CwKdm
X-Google-Smtp-Source: AGHT+IF0vmIJpOC8FIBHPlXRS/o+91tKxeitcyviJlUUvnkYdv28D7sKfx9urnz5TPzD/sRHT3WDjw==
X-Received: by 2002:a17:902:fb0c:b0:1f9:f3c6:ed37 with SMTP id
 d9443c01a7336-1fc4e131887mr26903805ad.14.1721268704358; 
 Wed, 17 Jul 2024 19:11:44 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:11:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Atish Patra <atishp@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 27/30] target/riscv: Expose the Smcntrpmf config
Date: Thu, 18 Jul 2024 12:10:09 +1000
Message-ID: <20240718021012.2057986-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Atish Patra <atishp@rivosinc.com>

Create a new config for Smcntrpmf extension so that it can be enabled/
disabled from the qemu commandline.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240711-smcntrpmf_v7-v8-13-b7c38ae7b263@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4efe7ee3b0..a90808a3ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1472,6 +1472,7 @@ const char *riscv_get_misa_ext_description(uint32_t bit)
 const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
+    MULTI_EXT_CFG_BOOL("smcntrpmf", ext_smcntrpmf, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
-- 
2.45.2


