Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7697DC52D71
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbDeC-0003fs-RT; Tue, 06 Aug 2024 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDeB-0003aJ-2H
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbDe8-0003z7-Ry
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 02:26:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fd78c165eeso1800555ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 23:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722925571; x=1723530371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MoTwcmHl5mcDqGL4UUvT/B4Y37addNNwVei5KB700ZE=;
 b=MxgQUfNYQWSIg4g2QeDoRzXR8vPsmB8NERdVMFARYp2d4Ulu3hYKnPMKfM782Qf7XI
 aV/bjcOX+fhb9qtFb2IPWykrRYyiHtquguQtFgsTZXu8Qs5xNRedzq6K61sDcjuBjOw7
 LUCrOMBKf9vE0VlJotguhL315NpOuvHvOig5qcbi5kUDQ3jSJkCABLW+JgLK1qEwghpp
 DZnzCz8feqxSM6ev5bR1LP85eQb+Bei6wVeMVajzLZQDVuhyQ92u31sUipoSxTvk8Bsd
 +8rTIDeaTOTpVkVF3qRp45oMFvzJ6CNXX2yyBFnBs3SCtnBu1ayEvttJRDzqcUP8nOVO
 MMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722925571; x=1723530371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MoTwcmHl5mcDqGL4UUvT/B4Y37addNNwVei5KB700ZE=;
 b=vQurD9MwdkQUTjgsM5q3ug618tf1xjayyi+wXR2jTGOudnricfWflCDOUAnh/Ooixt
 uZxMHshB4BXRMDxFi8WjmrpCCX0FJIiBP7nvXtlr7feQzeotJ0GFdCvDC531jmyRbkx4
 0OfWEveivMewL7750iXrSEhwqlHOmnImjIDCr83od3FJUW+zaADOxqpLZFC0vSNAKNXD
 1CrV7ss/5jtLCVC/prz8IJsFqzR38w++m66RqK3AgYIVFzusD2L8YEfl3sNaEGd4Z7Qp
 yUYNdr+KvbpvxDMzlLovr3jnkAGCWkS/FqSPOr6dNsuOOfzCSiTdt1JVRWQAu2ulSHVR
 wcCQ==
X-Gm-Message-State: AOJu0Yxaq82HrVzKUOrtrVYBRLP4tkhEJisMvvvu2Y9O3orwnG+3nLMh
 DFzjU1tI84HXxIr9j3WYozFcp+WJryJer3uO8+CSGu4m3atEZx41S+RZHKH3
X-Google-Smtp-Source: AGHT+IEC48/uJnwZpMuWhnrQaO+o3WSskFr2Ji/M2NIoDlFjc9p9yczC3oLq7xG5tBGEcOGerWreGQ==
X-Received: by 2002:a17:902:e745:b0:1fc:58fc:caf7 with SMTP id
 d9443c01a7336-1ff572733edmr174070515ad.14.1722925570797; 
 Mon, 05 Aug 2024 23:26:10 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5927f161sm79464975ad.232.2024.08.05.23.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Aug 2024 23:26:10 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 5/5] roms/opensbi: Update to v1.5.1
Date: Tue,  6 Aug 2024 16:25:45 +1000
Message-ID: <20240806062545.1250910-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806062545.1250910-1-alistair.francis@wdc.com>
References: <20240806062545.1250910-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

A new minor version of OpenSBI was just released after our bump to
OpenSBI 1.5. It contains significant bug fixes that it's worth doing
a new update for QEMU 9.1.

Submodule roms/opensbi 455de672dd..43cace6c36:
  > lib: sbi: check result of pmp_get() in is_pmp_entry_mapped()
  > lib: sbi: fwft: fix incorrect size passed to sbi_zalloc()
  > lib: sbi: dbtr: fix potential NULL pointer dereferences
  > include: Adjust Sscofpmf mhpmevent mask for upper 8 bits
  > lib: sbi_hsm: Save/restore menvcfg only when it exists

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240805120259.1705016-2-dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 268312 -> 268312 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 272504 -> 272504 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 7ec260ff40..b2e740010b 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 090c0cf6ac..018b4731a7 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 455de672dd..43cace6c36 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 455de672dd7c2aa1992df54dfb08dc11abbc1b1a
+Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20
-- 
2.45.2


