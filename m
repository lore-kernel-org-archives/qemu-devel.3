Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E2FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 02:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUGbj-0005nG-HE; Wed, 17 Jul 2024 22:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbh-0005eX-4g
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:57 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sUGbf-0003QQ-K0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 22:10:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1fc491f9b55so3383305ad.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 19:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721268654; x=1721873454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXBEQF9zs1oJMQW6BSKePpj0g/kNbcxUENbnas9asNo=;
 b=bv414Y4A7tF/maSya+NPYfqaEe2qMn69R8INuVikOVpKX96zJlObcy27YWLW1xqeNO
 CCVqwdBCDTbcBR9mufGSVfKihzlZXfKOEtHY+/2KjcU8sAt7FdxqsboVxqPH/1Q1O3sq
 l4qOGbslVLJAwa2NqGvXusrNedRxnpqrLK5XCY9U8zlFHQE2YT2VI5/5nOOAcF5VI7iB
 NQJR+msh2HS6546PEA10odJvu6mEJ9sAKJWtA+IzA/l2tkVWBVlTZlwd3bi581lty4Ci
 vHkwfSwfW0r0f+k2eUASLrAkV5MpFqRf4Z75Ctq7hVjsNjnLaMK37KV4NI9cYnFPz3nB
 8XNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721268654; x=1721873454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RXBEQF9zs1oJMQW6BSKePpj0g/kNbcxUENbnas9asNo=;
 b=kz69fvhg7+3qR6sa8j7TuMVKX+9ffmwB8gstzgmAq27XMPvuJj4xHp7WohBK9wQYLA
 eKiWC4uzCNDYOGrv1BKKyB+3xFHOixZ/xJpjfKW9ZYEuE3Hj+8PF8PcKENtg1M/ljaZA
 G7nhUbvIWqlWQXIeOpiDFHAZiquIQeJbivLr5BXL4fRDKNtZ+kfi1gxPte3wrSC0Rxi5
 9edOOcVrOD597Ze21GgRl98GkSMHAeSYDtWklUCNCzoByJnO5ca+A639onYT0yFjyBy5
 87GgEiybSwoXEb+/dgSxY1qsUjB5iw7se0guZBTTyMB2NuVbv6wleWVq1DHOO0VOAgUR
 54zw==
X-Gm-Message-State: AOJu0YwArgp4sdco/XMwwM4BS71Annvtm6phjUh+FJZPplcB5o5qwNJh
 lVl4hJEQzhOOWNFwG8futGIC+1fYr1wFWSFuwKmBrxNbS7GyBobPs3YbD0Eq
X-Google-Smtp-Source: AGHT+IGqB7q7HOs/Q9OphzhcAeCaL6LI3Os3UOOAr2r4T/th8Lxzf7DeHOeEVZSmhLK+UiFdRmOcMQ==
X-Received: by 2002:a17:902:ced1:b0:1fc:4dd4:90d1 with SMTP id
 d9443c01a7336-1fc4e66fe96mr35448995ad.49.1721268653724; 
 Wed, 17 Jul 2024 19:10:53 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bba949bsm81999385ad.69.2024.07.17.19.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 19:10:53 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/30] target/riscv: Expose zabha extension as a cpu property
Date: Thu, 18 Jul 2024 12:09:52 +1000
Message-ID: <20240718021012.2057986-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240709113652.1239-11-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index de9c06904f..33ef4eb795 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -117,6 +117,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
+    ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
@@ -1478,6 +1479,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zcmop", ext_zcmop, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zama16b", ext_zama16b, false),
+    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
     MULTI_EXT_CFG_BOOL("zawrs", ext_zawrs, true),
-- 
2.45.2


