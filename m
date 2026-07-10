Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E33C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qi-0001zf-8f; Thu, 09 Jul 2026 22:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QN-0001ci-RF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:12 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QL-0008WQ-Co
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:11 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso287579a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652228; x=1784257028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KCKfH9COIDQuGdY+gAsHKTofIOH+wj3D7nq+4tMertw=;
 b=m+XX/NIkma+VNHSH/N9GmXsQvEJWYgtK2LCxmlJ/t9L020dsuMNbIzX9gich+VxBlg
 A9N7DY4RgzRzcbE8zMkK/3kIEfMvd0EYEgwdWyHTDg2SVii/pmRjy2hKCF7C4tAj+96I
 w6NvjKmFuQIirgBh3ssvXwlyV+neRjsJTCVxTVKo/3gK5l32BpS9RXfuYPATUeybK7Kp
 6xo8wW9JKAm1Ab/4rMbQC8i+td4/MnmZAN9T7sBQGNCB42XHQHopGJGj4cJ4Eh2EZI5f
 8tIusY0Qr6RmqpMl9yoJnXdlHr5H8TeOf74n8ErmPfcBzGsGYMP0HHr8oaQVnT6BiZrz
 urNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652228; x=1784257028;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KCKfH9COIDQuGdY+gAsHKTofIOH+wj3D7nq+4tMertw=;
 b=AfHJlein0RpSr0R3mmNTM5v8w37QV6bgG9rNEL3p74KLlUWgZ+QoiTG3i9oQlzE/iZ
 3NZXzYjwgMTQvHtvU5P09lD0gVr87ZbfpUtVxxUnUv8Uz7pPzIy0x5Q74/r3zL/i7qm8
 CPllcSOafo3fYWUuJ7Tq9gZSHSn6Y0E4Tqs9FX+e32d4MCscAOhgXnZOp1DJpBrY3V/k
 o98OcfBg84IjFC38LZkR3L6Dlv/UXH50yN3llKe2dh1uvXcpBllRmL08HKYkjLfiwFa+
 VD542GoSwTNWkDghPjVZbt6aTrNIv2fEGCOf3w1NB+tNnLCG8Tm8ezHxetXz6ZoXVF/C
 pIZw==
X-Gm-Message-State: AOJu0Yz3KSfeI58PvAO72KPxqlpJlm1Ths6MzNAhBmUH8Jfk5BUVcNcb
 RLUv8zQzLg7OLK4YAw0v8Y0qxqEq8MofwCMLeisoTzTmeVHbalNp6g+SY7kfQw==
X-Gm-Gg: AfdE7ckdM3XRIlTo/C1TCm6e8hmrgQk3zvx8keikBDZuZvuIzS5Q6R/3Tqdm1DMObII
 gPHir3+ZOCU0vy+2BswENIf131ZfqUkuGghnIHEkU6Bodr92kJG2J3i6HkkJuiBFk8CIjWzo8HM
 CyXyTyO0tEZ+lBsj2hxD6sOoZsycAGl03M+/pvtb331encBzBrMogkcVxAMVAjQqWbU8qjMXiBX
 oZYNwREUHJY/RxtibGX29WNgdWI4TP/Ykdr7kB7879dWsNbym3MrTRwJCbvibfRL05fMAVSaudJ
 U6/YwHFa2Cwjb2di5VzBxP4g0QIxcdoWFLyQrQ7xsilZoQ3wue8upEZN1/PG1fSKfQa2KqvKQxH
 U/43BfBgT8Me4V84XfuV/7lF8U2kBRknaX4QWEiWI7Glzmn+OoECpy3WNtQyxiDhWUKZKeK9YVF
 HZCmyamk9RKyCJgh2ZFPnkyt0Nk+ftqHo=
X-Received: by 2002:a05:6a20:734b:b0:3b4:8880:2089 with SMTP id
 adf61e73a8af0-3c0bce8fd22mr10888009637.16.1783652227857; 
 Thu, 09 Jul 2026 19:57:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/40] target/riscv: move riscv_cpu_set_geilen() to riscv-imsic
Date: Fri, 10 Jul 2026 12:55:13 +1000
Message-ID: <20260710025525.1704417-29-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

riscv_imsic.c is the only caller.  Having it sitting in the TCG only
cpu_helper.c gets in the way of --disable-tcg for no good reason.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-23-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  1 -
 hw/intc/riscv_imsic.c         | 13 +++++++++++++
 target/riscv/tcg/cpu_helper.c | 13 -------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7618110412..7a4d8abe07 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -646,7 +646,6 @@ int riscv_cpu_pending_to_irq(CPURISCVState *env,
 
 
 bool riscv_cpu_fp_enabled(CPURISCVState *env);
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen);
 bool riscv_cpu_vector_enabled(CPURISCVState *env);
 void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 7e5b5349ba..ebb55191c7 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -46,6 +46,19 @@
 #define IMSIC_EISTATE_ENPEND           (IMSIC_EISTATE_ENABLED | \
                                         IMSIC_EISTATE_PENDING)
 
+static void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
+{
+    if (!riscv_has_ext(env, RVH)) {
+        return;
+    }
+
+    if (geilen > (TARGET_LONG_BITS - 1)) {
+        return;
+    }
+
+    env->geilen = geilen;
+}
+
 static uint32_t riscv_imsic_topei(RISCVIMSICState *imsic, uint32_t page)
 {
     uint32_t i, max_irq, base;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 6b39152ee2..71a96a20ef 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -526,19 +526,6 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)
     }
 }
 
-void riscv_cpu_set_geilen(CPURISCVState *env, uint8_t geilen)
-{
-    if (!riscv_has_ext(env, RVH)) {
-        return;
-    }
-
-    if (geilen > (TARGET_LONG_BITS - 1)) {
-        return;
-    }
-
-    env->geilen = geilen;
-}
-
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
 {
     CPURISCVState *env = &cpu->env;
-- 
2.54.0


