Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B33CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpb3-0006r3-Tb; Tue, 26 May 2026 07:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpb2-0006po-Fy
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:16 -0400
Received: from mail-dl1-x1241.google.com ([2607:f8b0:4864:20::1241])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wRpb0-000838-DE
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:05:16 -0400
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-134fe980658so11974860c88.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779793513; x=1780398313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+XvviqvKj4ZoSnaaiFnYLjFG8B4wrvLkMwc4gBDkwek=;
 b=r5jU1d4TA2ppQOOfBwsxnxK7s/fmMy909x9t6fiIHiKv5GK3zDmiiqTUojBk0Mz5Xp
 7j4oL+41w0yuOU7OPJtBe1793BbuwwQJLns0MrTIBzoXHFqO3DfpIWVo9bq34OwaeyOu
 jCfH5YzRMwO3J5KSJQ07CBQYNuCq+B1FJR/mVk4DbDCBrBY4AWXe4joTRzMiWq1dqpYt
 aLzzW1yWG4oLGqDJWL4pG1JEIe0L6uV2SLlnjYt+yOAlUCwaG+tZaZphFbQqLuFufyhb
 FHDssPesblY0k5csUw6gsCCND3sSrStpbdRQBvPS+tuGuNmTTTKxcrNlH2/mlWIwUWZC
 njEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793513; x=1780398313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+XvviqvKj4ZoSnaaiFnYLjFG8B4wrvLkMwc4gBDkwek=;
 b=c7NoXbjB/MmwCZbXrJKoCia6lQgLlfKCAJuhsHQOLRIggMjDbPV/ANd2yHiI/VNp5V
 EHtU/NHu84MDeIvMolf45mOyeBwCApFCPC0rTr6Qk1KfkQhxB96GfEMDhOh9jPHfyFYm
 /0sjaXCOpm5lAcgaKeYiLoazTnVTuRmngwKScXkbRzG0ojiMfHOsuuw+f5ILA5C2PfFv
 FagaYKXQiYndtSAklgUrRYin7vfhIkgDjMkAgxOgVWc0cwhceOG//wfyma+aR+p8xDtN
 2g40g7bxteOcq1oc+mjiLrFXQNcV9AWdDzbrdkWjc/ZCoS4kcwPt1YHjBa2xtyG7yrS8
 n9Dg==
X-Gm-Message-State: AOJu0YxzLrkXCyS1vmdpTdZVNLctiaIgkjVcHOiV0aMOEyghS2xZk3E1
 yE410ja5aBgFgMfAUTenSNwh42+S02QCrlDrXjp0bS8HftiwJu8Hng4QBSLgozpxOkdU1w==
X-Gm-Gg: Acq92OEn12+dHM5/XwlMfWRTL9QIPUMbzXTe5YxNOkqH3P2TTcmEz6JCwzFZIoyN4hp
 QzDXMG0ZdA1YDgi1Nbns3WuParvmRPxPJNZH4BF8f25IyYoNZSeWkr68xhllOHbx9va3ZZWnWn9
 uioZffh56qI/VvM7opLuVbeWthyp/mxPBkU7pcWdHK3sN7ERN5/nC5xntEdK8SUhKrzeto5VW3H
 00oVhzK6jrzh/s9bt1FAmIumaKzqGGJKxaEGzxQ3rZSNDKKGdx4fgAupSdtDxtYUC11HXTwtViF
 pAaiK/hLlFSGCJmv9OONV9AhoTP9ctKGt/dqXLWAJ6MrNxcrRW3ibsdqAoUegHhRrWketWisnXU
 UvfMahgkHUlbSpUwDEFHVBFs/FIUmXZUZ+xVgLV+UAxNnWxCM+dJtTqZXxZ5lwKeEfQFGoj0r4p
 5OIEjghe0ujnCnNLzqzVQYNK8GNr0uDA35n5Zex+FS6KAsykOgl21vXfD3fn62BHcE00ipwtX1u
 aVUwKNRzlY=
X-Received: by 2002:a05:7022:22b:b0:136:c565:e851 with SMTP id
 a92af1059eb24-136c565eb5amr3056306c88.31.1779793512600; 
 Tue, 26 May 2026 04:05:12 -0700 (PDT)
Received: from openkylin.. (ec2-3-101-81-203.us-west-1.compute.amazonaws.com.
 [3.101.81.203]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366a2e634csm9250276c88.2.2026.05.26.04.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:05:11 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, daniel.barboza@oss.qualcomm.com
Subject: [PATCH v2 1/5] target/riscv: Remove unused tcg/tcg.h include
Date: Tue, 26 May 2026 19:04:46 +0800
Message-ID: <32c6c8ac5e0eb7a8da660054bb9e59ddfc154e25.1779792111.git.fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779792111.git.fritchleybohrer@gmail.com>
References: <cover.1779792111.git.fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1241;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1241.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..1dea66972d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -36,7 +36,6 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
-#include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
-- 
2.43.0


