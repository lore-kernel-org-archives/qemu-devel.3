Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED37C02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJs0-00013T-4A; Sat, 18 Jan 2025 20:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJry-00013A-IE
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:54 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrx-000399-24
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:54 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee76befe58so5795517a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249170; x=1737853970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zWsQs1jxZ/+3ne+7ik2niz81I2v6BydOgtfx06Z55s4=;
 b=S5zf+Ncnhr+STOWt//OL9LaXPRT7wB2iceFVoX2mR2VpPahvl3/WyH/RJEciD3EhH+
 fTNZFnfo5lQvbB9MyW3/8qmJ2r8Gz1a+EoU9paHJ2wS0IfyHzpiWE7Nnl3KHGk7yQjgq
 mEUyzRthd9WGlztvEtRpp3DkMcihvN5whI+1LIAZf9hRADFzvnZIxMAQMS3awXo9WFln
 aytrmKRUockEi0RZDfJuH+UbbultpLBFi3ubpgFVAZI4MZkuOqMdsGhIloW0PlNkncve
 b46dXTfWEpn6FzTaxSR23LbVXAz/ep/oEYDmV8aNh1lfaV5Ij67ICbjy3nmIgHZGxEea
 Cf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249170; x=1737853970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWsQs1jxZ/+3ne+7ik2niz81I2v6BydOgtfx06Z55s4=;
 b=gY7dmEcTEv7OA2zCG91yqmN6BRvqnUFxsGMSmy0dMQIG1KTJ+a0/2R/P2Tvje1ZfDX
 A3+CZJyDAAC+ucMMdNtEAdOYNwhpfSegrOGB2tkpdMoBvYRUyK9+XSOvMaFX+i5YRYqI
 ezsN3bHTf+j6v3/LoUR3ZYsfKvAzm/uOTFQ7AL0ZqZQsWwFiwBU+2e4GwjXpOVt/ARJM
 JkLHIyVN1ehQDDVf7EvW8dSWj0YDmiqH+uS8mblQ5CltfXqNhYmrw15eWVZyvc5FNTzZ
 PFVg25A6V8YVcZkbx0JUWe8urkmx9fi7b67YmS0ZdWT2PShBVQl74guTmsagu+qTMSvh
 0Yog==
X-Gm-Message-State: AOJu0YwnTtnWZ1eyivhXuzvo5NgR/icM10CLHJlU5unkfLGh4Ww0hrRD
 6IrFov36t4n4Q16Z0tHgiGz7t1jTMV+iUY2mjkFoiVbNjRR8n3Rdma36QgNQ
X-Gm-Gg: ASbGncvVn418Z+gl1G1y6hbGJaUnrolUlADfAy+rlcMArkE9siymuTV9V6mKt8GZG5D
 hVqwdORk1urR2649FX8iwRX4bTOXG/Co4ivA4gwPVBEXQAqeElHwEHXkcutlRNlQtS5BKlkQ2o2
 90wPTRk8aVpshn7AyXKinfXs6McNU2sL/dxOpOYgvSFrIW31OWobySiibMExBth6bimIt3uqppp
 kXDZ20OnE9eqH1nb0JaXFZ3nbwL2rLVQDLnuE+btaTrG27bVaxXXT7hanqznJ0yuSztpHDWTjhD
 DYCDCJDOB5PSfKxEkB6b4BeRBHBDdZYqnw1It+jc5ANiCIaiV2Eqm1bdj5w3QHoiwqiC6EvrLg=
 =
X-Google-Smtp-Source: AGHT+IGmFg+Wea3FMJhJBOEdDeIt3fj5wyxF7ham6EEaJ3wsH6tFIe6CaC34pCrT/xjiJTr/gqAZVA==
X-Received: by 2002:a17:90b:2c83:b0:2ee:c918:cd42 with SMTP id
 98e67ed59e1d1-2f782d4eea7mr10295762a91.22.1737249170230; 
 Sat, 18 Jan 2025 17:12:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 04/50] target/riscv: add shcounterenw
Date: Sun, 19 Jan 2025 11:11:39 +1000
Message-ID: <20250119011225.11452-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1032.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shcounterenw is defined in RVA22 as:

"For any hpmcounter that is not read-only zero, the corresponding bit in
hcounteren must be writable."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 332 -> 346 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b8d5120106..07bcf96e86 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -183,6 +183,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
+    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
     ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
     ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 4f231735ab..460808d017 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


