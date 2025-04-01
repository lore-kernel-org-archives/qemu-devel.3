Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CE9C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 10:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzYx2-0008TU-E4; Tue, 01 Apr 2025 06:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1tzYwl-0008SD-Ty
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:34:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1tzYwj-0003qZ-EF
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 06:34:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223fb0f619dso100883635ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 03:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743503656; x=1744108456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NbUSum+DgGcGwGBoxVvU4PaK5B642fZ4CQdeAwgUjQ=;
 b=lLqyjg1VNaT+Wq0Vn3n5wpwDIGZXN7+9YmJ0vbiXqUbsxs6NS3yCCuzD4E/8Ldsjyz
 POFFvuDFO2TMXsRepJxmZtnSv89TK2wLpkGaI6EGEW7dxG8S4wDck+YfchpEiWDRSryZ
 ssVmUQCLOAjIwFQoI8vzl1fc8HJWcRu5cv/p5w7LPKfTH5AAxVSEq3QwYHAjETC+P0lP
 0bLyuxT62/fDry0OfXMAo8Xz/pniQh7KDvRP8YjBD0WnvtIWvyvgFRIr7vNeXk8R9FEe
 vr0pl1Qwmq82lGh9XL6xbykaiJklhA5Bv/KaoFcljl+2cRVzL+UDZPCp5/2XqmNU/CwM
 eNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743503656; x=1744108456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NbUSum+DgGcGwGBoxVvU4PaK5B642fZ4CQdeAwgUjQ=;
 b=aS0sKCcTikK5u8Cl+WLsw+stQ5dBH+YHAW71b1GZfOAEfl4pP1HLs3tTxx3zNpBir+
 ge213EnVNkmSR1afQGywX8L0G+4tkOWa69qMBpNLTHBOMg5hlFMb4x/kFDB86a78zADL
 3Lqs4yLlWhDLfx/oj8FlcV7Og7lOAWSyTR0d+iNn5emfEwFxTz6KVRRlG3/B0/d4H/tl
 coZUq+Sak3WOX/5rkJrhzSv/+wP42anyH+3bevvwDiyt7Non1uxm44rDZCdg4NL+JdMY
 RfEz62Q7L8XxiZuvtHPZjGF7b6hGNwIHq1q4TbsQUgKUSlGiixD7YOlr5pnD16PJpllL
 jCkQ==
X-Gm-Message-State: AOJu0Yw5PYZxB3t4YtFYceDS+QbtzpGwZjOlm1t/qJk/h7if9o3whgPA
 xRPv8FxTk5qOCmHJ5eo0s6bF1kOdiW5p5XPOoZqBrMwd7WNGPDOLZdiqNCawwzFa5J0pjw0RN3o
 hsvfIA1d/JQbeO6NF5gj/YGgcKxO4ADBXxjNmh6ahJX4cJC9a4l45SPweLUm7VnTaIq8paKKcxH
 CYnHX56MBs2vyLeo2w1Q1Myoo69ewGEQUcoSdp
X-Gm-Gg: ASbGncu6udSDg+vPVkgynN9djOACSOVu+IReGWA8US8BBEXdaBOffTlVG2jiEY1usGk
 kIuXw24hCpKohx8D8ZnYPQ94RZ2Fc2AX4AYxeQl0vEU9mee/RicR/zc+9hVU9WipKr6hEhuK6Bk
 /yajKx1vSQcqT43nR/DOcwlyiDyidkHz3PELsttY4V6YXozheADgbQhJzCp/qB+p5GYH1dBMAf6
 NCGr81WOY1cUh7nLeMX+l+lTcbjFDMkNHUKYWbL3WlvA7D4Z2gRyIIY+Tt7fJXzN6hKrbMYvMNb
 XEGRQl029N/nuEpuoE0HzZefdoV88SU/E0JSOX6n5LUVdCFnFxwcCEmSJHjPirlGvQoAgDPnAET
 KUNheN/Bj
X-Google-Smtp-Source: AGHT+IGcr34i6AKbI+z9OGINU7yuSyTLNd3DA591DW7R+T34QYVNUnJih2Q7SrHaBVrEHkx52UeBHg==
X-Received: by 2002:a17:902:cec4:b0:223:501c:7576 with SMTP id
 d9443c01a7336-2295be64dacmr43550085ad.12.1743503655561; 
 Tue, 01 Apr 2025 03:34:15 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1ded6asm85211795ad.184.2025.04.01.03.34.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 03:34:15 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 2/2] target/riscv: Restrict midelegh access to S-mode harts
Date: Tue,  1 Apr 2025 18:33:44 +0800
Message-ID: <20250401103344.84257-2-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401103344.84257-1-jay.chang@sifive.com>
References: <20250401103344.84257-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jay.chang@sifive.com; helo=mail-pl1-x62d.google.com
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

RISC-V AIA Spec states:
"For a machine-level environment, extension Smaia encompasses all added
CSRs and all modifications to interrupt response behavior that the AIA
specifies for a hart, over all privilege levels. For a supervisor-level
environment, extension Ssaia is essentially the same as Smaia except
excluding the machine-level CSRs and behavior not directly visible to
supervisor level."

Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
aia_smode32 predicate.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Jay Chang <jay.chang@sifive.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 975d6e307f..81a57249bf 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -372,8 +372,11 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
 static RISCVException aia_smode32(CPURISCVState *env, int csrno)
 {
     int ret;
+    int csr_priv = get_field(csrno, 0x300);
 
-    if (!riscv_cpu_cfg(env)->ext_ssaia) {
+    if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
@@ -5832,7 +5835,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
 
     /* Machine-Level High-Half CSRs (AIA) */
-    [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
+    [CSR_MIDELEGH] = { "midelegh", aia_smode32, NULL, NULL, rmw_midelegh },
     [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
     [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
     [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },
-- 
2.48.1


