Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A415FC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmp7-0002Yx-Kp; Mon, 27 May 2024 22:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp6-0002Ry-HN; Mon, 27 May 2024 22:44:24 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp4-0003jK-NC; Mon, 27 May 2024 22:44:24 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f4a6a54416so2388495ad.0; 
 Mon, 27 May 2024 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864261; x=1717469061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGSDVwJ0PbsAM8k/8MYYmnPwZRw9PEeElr3mXEVUI30=;
 b=RI1EiTh+YNL71hCrmLbIsMBV8nZ0BH5YYdBkU3Yd92xt6UsdcxdE8eyr1pEcqxaQnO
 +7IU+RfvE8hvYZYUlEUARW2QdUJIeohysDfWETIaSoGsdQKZRJ/1QeurGGFTR+7SEIQh
 BEiIQC5MQFuD+6o5lnhrSL4tPOs9H6T3fnGuo7HMDNA5l3IVAEyCZ6AioIoxgzDC5A6/
 fISOhhGWEkrg2pRP3Y1k1nvtbcDBBSBnC6CaSyYL9Swg0W248KBgxoKLbgevLbTgvnVB
 adfDyEy4rmuJSTj4SjfiOuuDxGawOX4d19/UN1eTo6qWp/3jIMyF/eLJiLPbbVnDfedp
 GwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864261; x=1717469061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGSDVwJ0PbsAM8k/8MYYmnPwZRw9PEeElr3mXEVUI30=;
 b=D7FNXDuj2ti7abaGigU39+o+Xejmzk+BOePFlQD+W/GkwdGCr/c+aYgGPQp9P0/iM9
 e3DPr30gxgl2gv1keS3mjwGyNOGo5XBC3JdsdL8+CcmkPdxKUzICvYIxkNE0tNYnfnus
 ymBTxUmZ/EgmrFhprZ1YnO8rfHTLtPVG9ujgSN8xPP5ycc91d/nLL9eAYPQN7BVYYgIA
 moCJfLF0yhUS9Nz2wbkIuHI0R79OJ2Z2WBmKYVeqOt6/Q6LNZ1fhIaAafftbOrvQvnup
 w1vsE1xtDLoTZxsWOMz9m6XcDmLwvDcH2C58Dzx+HIybQtJmnRCQ7bAJqIv3NY+kKD6x
 Xjxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdJbg1zfXkame7FV/OJS2ZLW/WexFyvHuTRyfCnKXnWh3tbiyLsvz0GqvFlJqaOeFBHDrLPUX/mVwP5itQcOz2UHyDRANV
X-Gm-Message-State: AOJu0Ywx3EWVcS5tC/QHn2ueUMGq7EnerT83pLwnDTZTrdCBxkJ5MnXe
 pgxmuTz6RJ31F8bUFi1r26lK9Cui+6fB/RotqNppTKTe0yw6eBKl1XciHA==
X-Google-Smtp-Source: AGHT+IHGAfKNgC+eh987FAw8Sl72Piu8iMc1GAsWmASL+ZlTv59TPy4ud9SnNgwFdb6kWjyXViCgkg==
X-Received: by 2002:a17:902:d58c:b0:1f2:fcc0:66f with SMTP id
 d9443c01a7336-1f448248a0emr165604775ad.31.1716864260654; 
 Mon, 27 May 2024 19:44:20 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/28] target/riscv/kvm: tolerate KVM disable ext errors
Date: Tue, 28 May 2024 12:43:07 +1000
Message-ID: <20240528024328.246965-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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


