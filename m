Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD87C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxo-0003j2-Q9; Tue, 04 Mar 2025 20:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxm-0003cU-W6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:23 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxl-0008UY-5m
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:22 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22356471820so101625845ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139660; x=1741744460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf4OFfZLYs9fg6MlQAoWht8j3rKgxmF7ZOPYqVae8KI=;
 b=CAlfUuZDpbAfr6bR//ovap/aQQ3C4rqdVhGAVXg0fvVe5VK2nYAUpTGt3h9IaN3ZTQ
 7D4LzPxLXs7ymLlO3AzDMqqmLMEWUYcsH5UmMFd+sGfR6Lv/DCNJmSFQYeXTSVsMNWdf
 7SEF/snN91oldfDfLWJrMP4JEJC3XLwtQDQ6r5cx8fuZj6JMHwyqseKrE93oOGyRhhBi
 GOwJLN6vxTLuYEzWrhXg0jBJ9xgmu94rkth6F/MiqcgpSDbMHtL/PQBpbJtwiOuq0cyF
 XRq+SxKoRC4FrXK0O24LU9GVxoPJvyEN1n2eQW4XFD3T7EaR3cAGSZpY4erMzWodxzG/
 5kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139660; x=1741744460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf4OFfZLYs9fg6MlQAoWht8j3rKgxmF7ZOPYqVae8KI=;
 b=SZFXFB5oFptgKzqYfZCODx4YqrxvpGXMVmLfB8slcwAolaML+a3c+hoYn+vVVPX2AY
 jyvSId9qe8wS+coEj5WQ3xOmkcZEJGAv8yHnT9VkQ22ttIvfLIlSxEp62UCarbH9tDxi
 bks3V0qUIhRTM2znKM/588yTNPCqenmiuu6RCpNzONQ9fN3I4J3QetsGEQzvPI7JP6Yt
 YPoy+aBO+R0IAqtkzNmvg/fLKp/FJgQcH8QENokvkFCmpcVDpdUGMtTveZ+X0z2IARvK
 Ih74Z01++YmE4zaUUZY4v/1k8diixIr105ofBggMy220JCjfFicDeEJJ5mVUe/Jn6f5E
 NEqw==
X-Gm-Message-State: AOJu0Yzkn4OITwSFbuzHfetBZeGNwmofy9BNRcA4Jo25R4sqs7L88dbe
 IqrYWWnWWu7epaMleJlwmJKCJjL2zzvQ9O6xhqdFmnXiT9llIZUBkmvYKDNKwdw=
X-Gm-Gg: ASbGnctM9nyuAh+bIYQySBqbtTfOk4TzmR0v6YstTkwm7wqxyfyYxuazI9jRXi7l6Vc
 kRxHGUDyvvZWR5hbFnV6OeYuZNzDOPji9hRVFX/bi6UYWkKzfoy5lmTpW0Ei7fS66cb5G2XKmkl
 1CJQ+oWZfUFpy4P7d+8q+3Ucxr/+rW6LRLQTbwet17idrmoHDwbi2uMpn2H7xp2IllTqEh/rSgF
 uhSq5yL6HqlFKjG74KVjDhka/UZ9h/nech+iIUKeKK5EdP847cb+3Hbz0vJnVScrjcxonnxe2PU
 5CIbvwsXJYN2ou5D3z3LICOgEjFuZqSV65E4YWoDCZE1LNzI3jJDnm1v8dMnqc57epU85AkpXRO
 Gzx50DpykUsvFAR6w4/dfUjp4iupqIq5UEoPXykAZ/PzErLg/a7g=
X-Google-Smtp-Source: AGHT+IHIltxntf1CQdXEb2Pb4JwUNopLmDfJ4AUpAO1Jsf9ed1lGZr7iep6pC6hesnLmclc8KYyrkQ==
X-Received: by 2002:a17:902:e848:b0:223:5124:a16e with SMTP id
 d9443c01a7336-223f1c6b189mr28410725ad.5.1741139659668; 
 Tue, 04 Mar 2025 17:54:19 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Jason Chien <jason.chien@sifive.com>
Subject: [PULL 22/59] target/riscv: Remove obsolete sfence.vm instruction
Date: Wed,  5 Mar 2025 11:52:30 +1000
Message-ID: <20250305015307.1463560-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jason Chien <jason.chien@sifive.com>
Message-ID: <20250205-b4-ctr_upstream_v6-v6-1-439d8e06c8ef@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.c.inc | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 942c434c6e..a98dab0205 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -119,7 +119,6 @@ sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
-sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** NMI ***
 mnret       0111000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 73f940d406..27d5558d63 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -147,8 +147,3 @@ static bool trans_sfence_vma(DisasContext *ctx, arg_sfence_vma *a)
 #endif
     return false;
 }
-
-static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
-{
-    return false;
-}
-- 
2.48.1


