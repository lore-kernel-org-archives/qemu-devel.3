Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A84C282D9
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzk-0002AS-OU; Tue, 04 Mar 2025 20:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzR-0000Nv-Jv
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:06 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdzP-0000YB-Ut
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:56:05 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2234daaf269so102538095ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139762; x=1741744562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwnFGXQgJ850S3H1p6IaPijGGzDxuh3yBXRCUGnBbro=;
 b=Po5T21P2edlZK9J7Pau5PoWYvWsmj/ObKRZwiAq4GF2unWAxdKT2lUA3tDgbmImsG7
 0qt+CwB+CS7FEJ6svP2bEe8QUkUj2eZdD+0V1J8MEmT9cuB6iyE/s/ePqKPvwnKbygGU
 XEftM3tsptL2SH8tCBT2L+Iv3fbF1MYF4ur2ZaH6zSD7nPS0faHxUZGO6J4jsAxSad6E
 uT3q0uwKlCyrm3RL5mL1vkY+pkl2j/L3D9wFouhvk5YUV0Y2b4vqyer3m+TXaJYT19ni
 DIOtcEJV7UpY21814a2f8QVjXOtkfVtFFsHKSFc3L3FcRFHhZ2Yv4mNygvQoKgezFB1k
 KGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139762; x=1741744562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwnFGXQgJ850S3H1p6IaPijGGzDxuh3yBXRCUGnBbro=;
 b=CsLCrbj2c9aYDVtOpBX+zpSmgqhNjyIK+JOd5OwmChiuGT2XW3JV69H1BE2fqeMV+I
 0+NFlolGS/3Y/LA4Uqxp9kOHOqiU3nvWVaHjx1Y9wvkSGOmxXd9divp8UXcD3PYKPgGA
 haKoFHZrpPrknr5MJMA2i8CmSFkg0r0IGVLt2a4Ljz8S+IDnOy74QdWwG3H2LxSYnmnt
 huT2tYqITv2zyITQk00pbeOuLtzb5XVVCyd+l/vnraRnz1sYTdKQR5CyIwTPB6iNveJs
 FwpvbiY4UuGGEM3zjWssXPyCSO/0qnrMcdoYJyYdQgu/Q9OIcUw1PSftKGNrJ8kfrfID
 aI7g==
X-Gm-Message-State: AOJu0Yxwzzl6VuWmemq9bBetYbl0RN3jBI1grVfuetLCqrzUb8Z9GLsM
 Pw9eJWIcvDJW7y/nynq0D9/AXmHKJy6Z8ED2XkUe+Zx9zPuSTibre+sy1zojFLE=
X-Gm-Gg: ASbGncs1LIxmTQUJXYtIj6hZzElCmgMvZCBII22ze7z25UaBvWTgUfh+Kr27wYejPgz
 +Djl42NVPENILHJFULDFAHiNQxkC3XvlNy1V/9DodbG3/Mv8CekcbWNN2UHJLWC2VZ58cu0CHrm
 vt/830bCi9xNMCB3mSMrE3VNOqNneWWFSuhx5Az84YTq0qGVVHQSJM9No98m7oySX2S76kWq9i2
 gGs7vmOFnSUFLqbkkzKaC9ZMpBrE9Tf2jQva2GtJtikuszgsTBQhvg9MWv0dQQBjw5rzXk1bqsR
 tAiPBtGtjOPkjI7H+fja9/0Vdhk6HRCD3TnP2vq+4c9DHls1TDhpMJQqS/ogwhSqFs7o8oRqJC3
 kxVh+v+4BVRZzmDDKKhWiRzYG2RyXInydkpYTVQ8NhygFWLDKHUY=
X-Google-Smtp-Source: AGHT+IHQLcCScilRE4lM0OCKVidcJC2L89suDgjYYASTWBlxAxipNt8F85MNy99UfOeZWA8mQu8GNw==
X-Received: by 2002:a17:903:244f:b0:223:5379:5e4e with SMTP id
 d9443c01a7336-223f1c79b6amr23867015ad.10.1741139762254; 
 Tue, 04 Mar 2025 17:56:02 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:56:01 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 57/59] target/riscv/cpu: remove unneeded !kvm_enabled() check
Date: Wed,  5 Mar 2025 11:53:05 +1000
Message-ID: <20250305015307.1463560-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Remove the !kvm_enabled() check in kvm_riscv_reset_vcpu() since the
function is already being gated by kvm_enabled() in
riscv_cpu_reset_hold().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250224123120.1644186-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index e436083dbb..e110e0b909 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1611,9 +1611,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
     CPURISCVState *env = &cpu->env;
     int i;
 
-    if (!kvm_enabled()) {
-        return;
-    }
     for (i = 0; i < 32; i++) {
         env->gpr[i] = 0;
     }
-- 
2.48.1


