Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C665D11198
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kok-00079x-Rr; Sun, 03 Nov 2024 19:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koj-00079S-Nw; Sun, 03 Nov 2024 19:19:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koi-0002GV-7V; Sun, 03 Nov 2024 19:19:37 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso2831456b3a.3; 
 Sun, 03 Nov 2024 16:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679574; x=1731284374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjJKXaqs1iegzxz1bDudDPZPn8CH5RdfS7pWj3NCT6c=;
 b=mdwhBkTX9bdupTqil03ICE++p36e34Kxmw1X0eYY+bGSK6cQw1NTlBzWzp4JeEEW6Q
 a/6Vf44aCVXz3PWx6f0xQYJgUH+iF+4W07IF9ne62qvh0QqBcs5sAMzcmCYBUVdGhXIF
 SuerSkZEZzm76lSyvTisO3IuirfYkbbWSbgqZJGnQJ5Opm+DMAZrO6TV4RruUKxCSWz5
 GWKFi9iaZ1OLFRvN6Qn4+5rDxV1R4TjqCNW8MGkdhHz43b6tutPZk6jP21nogizPAUbq
 xi++zfY8rv6+pwceqZ1EZfqvo6vrJGXWnDi7hOcQqIFf047TkfvGr3EVAGFYqRJ9piYE
 FYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679574; x=1731284374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjJKXaqs1iegzxz1bDudDPZPn8CH5RdfS7pWj3NCT6c=;
 b=P7uu7PzT5Kq6P5+Cz5wpY5/o5d4Jn4SKAKPasqGSL4B1fQC53exlGUItGSuytD0fhq
 OQkjIdN2GS0l9jQ7MjbqATh9CCpyAHGCFQusXEDNVApIS4A2kAdG31o1Fnqlq2s0AP29
 bn+raIdXexmtHMKwZd8y3nn+yxr3NZmkXI/JGNsE5ysMjxneSfjbBJLQJzRblu117crV
 evjecgpK1C/MpfLuF3FsoCE8xb91wo+eWjCE2V3Ebo2Lhlb9QNxzOJYZZ5nbFFcNotwZ
 zRvFTOKqz7QrQ2ZrY/RhHDPoRWDo+kXIt2jNvPPy5JkRKHZQANvDL6kjfCBwrmZkNGBW
 EqVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoI1ADHwffNO2pZ+FuumlCyMz7vOlRB7UBXp4hDsAhKUMWGjDt048O8nc8yZidvZgBRXYVtQpzyA==@nongnu.org
X-Gm-Message-State: AOJu0YzIcOR/dB3tq0Z9LXtIPQxspPKBVQW5vpPHNqgnwpfWHtvIgrGm
 Ri0U8JTJAI8XIz6KdIsGnHmKYwyrj+PT2pR73Z85mOI3qiYrbW1n5BOPOg==
X-Google-Smtp-Source: AGHT+IEoVzhlMMyBp9YZXRbcCvsLDWNK9jeXh/6O4VQJBpgF+hfJUUBI9y7GWCoYMVqhF9oEq7HOeA==
X-Received: by 2002:a05:6a21:78d:b0:1d8:aca7:912 with SMTP id
 adf61e73a8af0-1dba5409a21mr15403489637.28.1730679574367; 
 Sun, 03 Nov 2024 16:19:34 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/67] target/ppc: PMIs are level triggered
Date: Mon,  4 Nov 2024 10:17:55 +1000
Message-ID: <20241104001900.682660-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

In Book-S / Power processors, the performance monitor interrupts are
driven by the MMCR0[PMAO] bit, which is level triggered and not cleared
by the interrupt.

Others may have different performance monitor architecture, but none of
those are implemented by QEMU.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index f33fc36db2..701abe1b6d 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2187,7 +2187,6 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_DECR);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case 0:
@@ -2250,7 +2249,6 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case PPC_INTERRUPT_EBB: /* EBB exception */
@@ -2330,7 +2328,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case PPC_INTERRUPT_EBB: /* EBB exception */
@@ -2444,7 +2441,6 @@ static void ppc_deliver_interrupt(CPUPPCState *env, int interrupt)
         powerpc_excp(cpu, POWERPC_EXCP_SDOOR_HV);
         break;
     case PPC_INTERRUPT_PERFM:
-        env->pending_interrupts &= ~PPC_INTERRUPT_PERFM;
         powerpc_excp(cpu, POWERPC_EXCP_PERFM);
         break;
     case PPC_INTERRUPT_THERM:  /* Thermal interrupt */
-- 
2.45.2


