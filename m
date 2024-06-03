Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5246C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5gy-0004Bk-Rz; Mon, 03 Jun 2024 07:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gl-0003UJ-If; Mon, 03 Jun 2024 07:17:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sE5gj-0006Ce-Rn; Mon, 03 Jun 2024 07:17:19 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso26087255ad.1; 
 Mon, 03 Jun 2024 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717413435; x=1718018235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGSDVwJ0PbsAM8k/8MYYmnPwZRw9PEeElr3mXEVUI30=;
 b=ImdNNMYDwe/tzf7TwqM1rbun//444rMxU/8fJ4R4cfOCa0dAaZpHECRZUcooPx1HJQ
 rslAA+4XOelmBFnMwm53VqMnNbIEUAiz3f7xcBqPkwWvXI9pvslqMqRRj8oDi08/Ys9/
 tAEp1Qzv3tIOjixTobjaoUaKEG+JZnCYWIdQ2vM6bM6qqwJOQzhJaLa6avDR1uB2uq0O
 eaUWaL0NnXBFy92sWaryZzKpjHf76zEExPvXBZkW/9QTi0qMfRHA3lQ4T6rIuhPoGyWI
 IrJPL4jbninHw6p7y2ykbsk4oAhKcrPM1s5jCCHB70yAyBQNq6JMhgS/a/hnRVHCk9YS
 xb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717413435; x=1718018235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGSDVwJ0PbsAM8k/8MYYmnPwZRw9PEeElr3mXEVUI30=;
 b=YtFeOJxrbUXGQf2Nsqn4wwY+hBPl+58j2iqMn3d53OH9Mpf51Rdjb50Lbbq+xHiwa1
 HYJvf3zndVfxZaaVypZxh9gLSl7gqpFj2yxQ5w5bL137f1BfAGuWdOjECStr0GQ1J9Qj
 kenH7H07p7N8FUZfMZK8iagkCU1ouXaILITlPhzB7PnoDDDFYmXIP66fhua0Lvy733Jf
 nR/tjTTvqoPi8R4EPUESy75fQY0B6/R+1hEYWMsDtx1IW2m3yQhhpHniy+jX8DyNLsn5
 FJgsNkz/YL4SV+l+oIx6obgVnaBm+VK6N+ObFECFDoRl48Wm71tsmIsbc0yWNWbR5gLz
 dVag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtvigqEII3qStgKjV114X+KVs1DhZndgYVxKoGQrLAp0h1rghPWWPSjHx4A59KoXQxuq4BKlxuQhr23ixt9HjSPAjOxt8d
X-Gm-Message-State: AOJu0Yyh5+xFMm9If6qx7GOK1CxaBHNKRdUf0i0d7KwPidHXwbRRshki
 Tvc4E0OQ9AAFfzlbzoPDxOK4IRpo85TjdsDv5oBJRi9LR1leFXaoNAjUIg==
X-Google-Smtp-Source: AGHT+IFAg3VZ7ROFigISjmDeA5jJdZl+QOOCasuZE2brVx7JfamfoJp4Jr/BQG8w+xMl4PYNBkuVUQ==
X-Received: by 2002:a17:903:1109:b0:1f4:b7ff:ac4a with SMTP id
 d9443c01a7336-1f6370453a9mr98098025ad.37.1717413434916; 
 Mon, 03 Jun 2024 04:17:14 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e18c7sm62375435ad.177.2024.06.03.04.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 04:17:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 07/27] target/riscv/kvm: tolerate KVM disable ext errors
Date: Mon,  3 Jun 2024 21:16:23 +1000
Message-ID: <20240603111643.258712-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603111643.258712-1-alistair.francis@wdc.com>
References: <20240603111643.258712-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Running a KVM guest using a 6.9-rc3 kernel, in a 6.8 host that has zkr
enabled, will fail with a kernel oops SIGILL right at the start. The
reason is that we can't expose zkr without implementing the SEED CSR.
Disabling zkr in the guest would be a workaround, but if the KVM doesn't
allow it we'll error out and never boot.

In hindsight this is too strict. If we keep proceeding, despite not
disabling the extension in the KVM vcpu, we'll not add the extension in
the riscv,isa. The guest kernel will be unaware of the extension, i.e.
it doesn't matter if the KVM vcpu has it enabled underneath or not. So
it's ok to keep booting in this case.

Change our current logic to not error out if we fail to disable an
extension in kvm_set_one_reg(), but show a warning and keep booting. It
is important to throw a warning because we must make the user aware that
the extension is still available in the vcpu, meaning that an
ill-behaved guest can ignore the riscv,isa settings and  use the
extension.

The case we're handling happens with an EINVAL error code. If we fail to
disable the extension in KVM for any other reason, error out.

We'll also keep erroring out when we fail to enable an extension in KVM,
since adding the extension in riscv,isa at this point will cause a guest
malfunction because the extension isn't enabled in the vcpu.

Suggested-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240422171425.333037-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index d2491d84e2..473416649f 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -433,10 +433,14 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
         reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret != 0) {
-            error_report("Unable to %s extension %s in KVM, error %d",
-                         reg ? "enable" : "disable",
-                         multi_ext_cfg->name, ret);
-            exit(EXIT_FAILURE);
+            if (!reg && ret == -EINVAL) {
+                warn_report("KVM cannot disable extension %s",
+                            multi_ext_cfg->name);
+            } else {
+                error_report("Unable to enable extension %s in KVM, error %d",
+                             multi_ext_cfg->name, ret);
+                exit(EXIT_FAILURE);
+            }
         }
     }
 }
-- 
2.45.1


