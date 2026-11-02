Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D6606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wItQLq3g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNs3i-0000mR-IC; Mon, 02 Nov 2026 08:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1xNs3g-0000mC-ML
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:26:44 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1xNs3f-0001Ez-4r
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:26:44 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3ab60ff4273so2531304a91.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793626001; x=1794230801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zJyZ0urrV6B37TtnHcNHsTyQasIBfd6W4kQZ46tJ0yE=;
 b=wItQLq3gc0WqCFcphF5Gaacl+JsnQBXORfH/BbdHqaBSmnjtYlsbCCfQGRErNDzEH+
 t0XhGMgfEekGlrpaPX5x8qPLxiI5vSbf/epDHuI2vLhcXlpMsqm9/ojUnREclPUN94yQ
 Jm6gCy+3q+PsxXqZKdaSDg1yxCSs4m74dydHNRbudCS4eaycJKJgISYOEH7CRUp3mbyT
 Gcdajz00V6YYTmJtzL5yM7IbUquH6ZU7rK65zvSldHD02aroHBX0aFry1ebih11NJ16u
 jwREuhhA9psj+0avyX3V5FMdg39ekxkGGd+9+SMpmT0DDwGyJWsSwjL4/+CWm5+M87fF
 7DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626001; x=1794230801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zJyZ0urrV6B37TtnHcNHsTyQasIBfd6W4kQZ46tJ0yE=;
 b=kDs5dCBNF1cN7b2KjUIpWBqPCFeu1ZPrghmWVzHb1hTaFyPYH6oBwhROO2tr+ORpys
 YZnI6xghNL7TQ49i2DAsSopCGHiABhV5BaiFHiPW8A4Hr3jv8iA5XQLSJRv09uI6R1Be
 dO7TyVs43EEBN6ca7pCiqpyA+I/xk7gSFJoJ+rsqfOUI4awF3WcHujLfdse9EuvJt9OD
 Krho4+UhZ78qniK4IRl1qE5fZkO+YcTRRi6cOC+RJRXb/fqpunaZ3RLNOdYQwYk2B09i
 RaEOV7D1DRL3TUYu+TgM/WiZpU8smdhlqePidDR0o2LVtQIQYFRX+mOQ3Bacwl79VI9i
 v/IA==
X-Gm-Message-State: APuU4Z+LWtrx7xFKpyFJQ+XizaVtS/j7wWTpBdrA37WcQ/5HMXV5BfW2
 kV5prdgy6Eh4HsvfavyAOLZZP6X0CXWb3m6G0i7JtKRRHOQ1SmyNp/jOPblCEcAh
X-Gm-Gg: AYBFou3Icf4h+1lQAH+M/p67y09zl0g9Y7ktQs+DjXNWE5cxXxSCH/FHVxKYNl/7EQP
 zghEmpNMFHszBqSTJwJdHF8SFIj7kL9cd67W40XYSXgaawr1YqhhUZemYWYo/h/w38bbdBO9chF
 ZJE/Jv7ZB7uVK994RP57L7oyygiXp8K3Rzd/bEX9NMqtqxrymy8mGNgGzZxCCLTfkQJkGDEaO1u
 BoXz7wvWx5kt47fwtN7iFcp6YbPFZecu8yYikf2w1+bgphROPT1bW8bcUa/KrOZAN2OhGdyDeZ4
 O1mhYRnyq9fzsTmOo3QmYpvDNIcC7p+L/XmxLaIGtJ1r80n+vKt06BBdbcqUiND0Fe3MbPWvVWq
 Or0x5QksLDyAZBywdHOP8zGMbAJx1KlF/R4bOa9pFX5lNSgDTa0L1Pi7raYmdoB8/EHRBSNHWap
 2o2FTQlKXKqin6f3DLqNMAqnsk4Lc+F3teWM4l29kUZhx+s+84NRvM5VNgxIOUnnUiCCIdfPiVy
 vg7ITcy9dABEPi8xd1Hoeumj0BfHtIAqSTPuTKtLlzxvIdiTZE+mxuvVkpSr8pTFOBoQsY2/aOu
 avDjxKHjhB1o3mN0Xqe4dhHWiCz/AVrH
X-Received: by 2002:a17:90b:2891:b0:3ab:1e1c:837f with SMTP id
 98e67ed59e1d1-3ae898484d4mr7791139a91.47.1793626000983; 
 Mon, 02 Nov 2026 05:26:40 -0800 (PST)
Received: from NB-8855.Dlink ([5.144.121.177])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae88024fd1sm7142271a91.2.2026.11.02.05.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:26:40 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH] accel/tcg/cpu-exec.c: Wake up gdb client after WFI
Date: Mon,  2 Nov 2026 16:26:30 +0300
Message-ID: <20261102132630.1424100-1-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=sergeev0xef@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In TCG there is a logic to wake up gdb client
after each TB executed if single-step mode enabled.
But when executing wfi we won't reach that logic,
cz long jump is performed. So after executing wfi
we do not wake up gdb client, and the next instruction is missed.

Furthermore, wfi sets `cpu->exception_index = EXCP_HLT`,
so we cannot set `cpu->exception_index = EXCP_DEBUG` as we usually do.

The desired behavior would be:
1. Perform wfi as is
2. Wait for hart to wake up (`cpu->halted = 0`)
3. Wake up gdb client

So let's modify `cpu_handle_exception()`. If we handle EXCP_HLT,
and single-step mode is enabled, instead of clearing `cpu->exception_index`
we schedule EXCP_DEBUG.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4794
Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
---
 accel/tcg/cpu-exec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9ead35418d..08f9186b67 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -715,6 +715,16 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *excp)
             cpu_handle_debug_exception(cpu);
         }
         cpu->exception_index = -1;
+
+        if (*excp == EXCP_HLT && unlikely(cpu_single_stepping(cpu))) {
+            /*
+             * After processing the halt, ensure an EXCP_DEBUG is
+             * raised when single-stepping so that GDB doesn't miss the
+             * next instruction.
+             */
+            cpu->exception_index = EXCP_DEBUG;
+        }
+
         return true;
     }
 
-- 
2.55.0


