Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC2EC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIV-00012H-1v; Fri, 07 Mar 2025 10:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIT-000112-EO
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIR-0008KE-ML
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:33 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so1051203f8f.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360050; x=1741964850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JgJS/SVQeQz4sdPOdeejG5h+ujK/Zmmbe/SnJbGOVC4=;
 b=s99krChcdcGKCIidrXLGsnnVnXmsbe3WfLzpO7XNLqlieoJk1GFJVFvla9o7zpLSCh
 6BciYlADtrDIOlms0EeOFEjMKfDedZz1nsefw7o7Rs5rE5JYir9eaqI+NsQwBc84sVk2
 vdX7jRHMKl8UadqAEKm9/+zuJC//wGRnd8Q7CUQKPp19XeSNVw9IBmbDqzO1bkNH7A9e
 O8YaE3jBizFW5Z3nn8gX8eCHiqzyzVAWkDmNt6psnp0Mu+IXzE3wZmKNVD/QEza0utnG
 Zex0j16yU+1vGlulm8+l00WfJnQgOEai9Ekkd2y6+tBLvkNlsn0Am7i5rv5LWbIWKPod
 k2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360050; x=1741964850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgJS/SVQeQz4sdPOdeejG5h+ujK/Zmmbe/SnJbGOVC4=;
 b=igTnabsFNROh6ESewFk0m9ALrXFQcG/jNNc4O14myhRJxOlObFMl0SaZm0hTncAGDN
 9WcIq3ougp7VCWWnk7Kr6gdRCvvOVfMkMrpY+4qmB2JjBcodMqU1EFswlYWK9ds2qoBp
 dFSJF8VVYnCyqYfA2pjQMZ78OFyO39HLVzT/6XfCKfNQD7Ty9fjxYDJfWTnDkKm13zLc
 GKxGe5DqhNyevFS0sclTEnlJv8y689c9BH2AQw8+kMVEbiaoWqFCNyBqhTjRyCYl1OBH
 vh0oRfKVHUtYQ70XL7q8Tyuui/JFPJu8zrXVXTbiQ5ck4vE1BSS6SZbiVLh9WGgPtiUm
 IW3A==
X-Gm-Message-State: AOJu0Yzd/Bn6sDXnfUojCKvdNEw4VbFajz9HazqD0cjHxqLngIlKx7M0
 ZzEnqacuF7CjuKSMh58nKCmjbUP3PrkwVUgj/GEkHd2znMRRQbcQa/heTfrusiW9exCU0Acd1xp
 s
X-Gm-Gg: ASbGnctTmp/V2tmsKrZv0Q9P9vhAmvjCz/x/RG+4ImB5YVUIFt8SsArCFN4AcsSchdp
 /saAxQxYRO1XcQcVsRi9Y6/8h0T8mXnIckYbjn4ghaOE+otSNOh9/Dm2brQW5xgprDZ/oLcnH5H
 +B38CywnE1Cz5X3RrlCTqXM3TLksYNe2XHrjPCk5ZQvjcpyBpIOKrhQxuToL+uYGynvexhZ998i
 gouibx7z4HcWfxQtTMNi3lzBxlI8X8SgS6pcaXGFkD0WJjY5XC2moQGHhCi0VQbYfwAFne5WJXJ
 h7DVuGR/WkSndHOSHg3wicgy8OzUmKC02DUVhC/iX7eCNTUeeLk=
X-Google-Smtp-Source: AGHT+IETWHkAgGuZpYG/2wfbGn5u+wgVKUno0rEx0xHFcld+P5+fuxObCSgQgEcWmgo/O6iUE0S4TQ==
X-Received: by 2002:a5d:64eb:0:b0:391:1806:e25c with SMTP id
 ffacd0b85a97d-39132d1d3e0mr2461684f8f.17.1741360049679; 
 Fri, 07 Mar 2025 07:07:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] target/arm: Make dummy debug registers RAZ, not NOP
Date: Fri,  7 Mar 2025 15:07:03 +0000
Message-ID: <20250307150708.3222813-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In debug_helper.c we provide a few dummy versions of
debug registers:
 * DBGVCR (AArch32 only): enable bits for vector-catch
   debug events
 * MDCCINT_EL1: interrupt enable bits for the DCC
   debug communications channel
 * DBGVCR32_EL2: the AArch64 accessor for the state in
   DBGVCR

We implemented these only to stop Linux crashing on startup,
but we chose to implement them as ARM_CP_NOP. This worked
for Linux where it only cares about trying to write to these
registers, but is very confusing behaviour for anything that
wants to read the registers (perhaps for context state switches),
because the destination register will be left with whatever
random value it happened to have before the read.

Model these registers instead as RAZ.

Fixes: 5e8b12ffbb8c68 ("target-arm: Implement minimal DBGVCR, OSDLR_EL1, MDCCSR_EL0")
Fixes: 5dbdc4342f479d ("target-arm: Implement dummy MDCCINT_EL1")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2708
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250228162424.1917269-1-peter.maydell@linaro.org
---
 target/arm/debug_helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 36bffde74e9..a9a619ba6b1 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -1037,7 +1037,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
     { .name = "DBGVCR",
       .cp = 14, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tda,
-      .type = ARM_CP_NOP },
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * Dummy MDCCINT_EL1, since we don't implement the Debug Communications
      * Channel but Linux may try to access this register. The 32-bit
@@ -1046,7 +1046,7 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
     { .name = "MDCCINT_EL1", .state = ARM_CP_STATE_BOTH,
       .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tdcc,
-      .type = ARM_CP_NOP },
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * Dummy DBGCLAIM registers.
      * "The architecture does not define any functionality for the CLAIM tag bits.",
@@ -1075,7 +1075,8 @@ static const ARMCPRegInfo debug_aa32_el1_reginfo[] = {
     { .name = "DBGVCR32_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 2, .opc1 = 4, .crn = 0, .crm = 7, .opc2 = 0,
       .access = PL2_RW, .accessfn = access_dbgvcr32,
-      .type = ARM_CP_NOP | ARM_CP_EL3_NO_EL2_KEEP },
+      .type = ARM_CP_CONST | ARM_CP_EL3_NO_EL2_KEEP,
+      .resetvalue = 0 },
 };
 
 static const ARMCPRegInfo debug_lpae_cp_reginfo[] = {
-- 
2.43.0


