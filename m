Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828C7C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Qi-00022F-HV; Thu, 09 Jul 2026 22:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QQ-0001hB-I7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:16 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1QO-00005a-Iv
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:57:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cacd69a9c0so3621995ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652231; x=1784257031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sJ4GzyYWAt8H/QdB1+UXeV27z/djHMVpk4vZdImGOZc=;
 b=dzXwI7PdbgMVo+L784vMxlPcIQqyjtSbXke6vMFfAnS9DHNtwYjUAFhQCR9yB5cbJx
 /wLPsEuqtt6QX5yXf9HStFVy92HW0nn+ezKiO0JKmOaGEzQugmpoldoHa/fCVlet0k7s
 gdryfFb1ABjHXIhW3MNaZx7TtQ16hk5Fa5HqDfYK3Ujn4T6+tCoyw934KOsd8odkPQr5
 CTw5CGLXkQh6fLdupNvYUQGTh4z+pkMVA6Q6I2rJrC/itbOxSk8RV5VKe0cZWpcRmPkA
 RkYZQsu7Wc49loJCygMo1eeBtvDmtpncIeTRQ6NMn5MV41XlZTNr44cwQdoT2vsLKH2K
 Qo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652231; x=1784257031;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sJ4GzyYWAt8H/QdB1+UXeV27z/djHMVpk4vZdImGOZc=;
 b=D2i/lV/H7EDtIWErHRDNxAtDO6ohSUJQ0GsXyHJFLgfIhvdvtC4fxjD8r1o/asIn31
 onsDjhI5W+xm/0yk3G90bPIQYO/6VzMAGa3IrHwSzrg1Ulzr8gtliKwmYibMD3nut+eS
 kk4wMTQvlb4Rm7D/0/0H+6Xo+VGeG7o/+OvFvVLuqD+hm+skZHmVDlhXW7gW3a2mODXw
 iiDJEVVIq1a70pHMbG+gb8CbJvuQuF3b7Vr+H0jPG70/jMhisavEAtx65MVBjVV6B0D+
 fYjf4f6khrqenpLqsU3BHVp5zaziepXTszsLcXVzoDAafxgkeUZe4EEI7VBmoJbdKy5f
 MsbQ==
X-Gm-Message-State: AOJu0Yzh/v5b6EvzbTn7elfAQiBPgeDojW+qEk2ugMgQa2/Tl8UsKe3T
 P2ZYO7okP9OPBis+2xeNXv7d8OFW34CRlfa8rPX7QblEhpcRc5EJcPM8SGzCFQ==
X-Gm-Gg: AfdE7clY/4wyKdoQ3WxiYdRHJm/gzekXBDclR8s7AJNCaldrXfsi/baANA9NaSljEML
 qEwRDZbUaoBk1buJxmESJezYj/PpQWmVTk4Oj01AQli+Q2r+alki28AEH/MR+uxrV54wE7Zr6H7
 /6HgA7TqU+BgCly+eodD3SL5GSwzT6ZKfe4uxm6RCWMigoI0LT+EvS2VBSqwK3d1FTKVBYGH43n
 kg3GFmL9PsnzTLNlYZaJcPBsRXD/QHAx0cRRUmlzjOMQBqU1cb8EAheZTx3815dud/oImcWbAHg
 zjt0JX3tudkBLJ4+uYNt0zUdxl3WHQ7I0rJZn2dXmloenAdoU7MLfg6qo3O33TZNeA2l0mApn+W
 xbKAjYNdQ3O5y/CU+gXLYh7T/roD67vjsGwmpkG8f0++rZN2bQjKGFUfn22fMCzSF7Nadvm9fUs
 nMikUhMO/x3eQLFmZ3L5pUedge7iNN5KtF7/lnYgUGgw==
X-Received: by 2002:a05:6a21:6817:b0:3bf:6c08:2b27 with SMTP id
 adf61e73a8af0-3c0bcb7f05amr12078231637.47.1783652230935; 
 Thu, 09 Jul 2026 19:57:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:57:10 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 29/40] target/riscv: move riscv_cpu_set_aia_ireg_rmw_cb() to
 riscv_imsic
Date: Fri, 10 Jul 2026 12:55:14 +1000
Message-ID: <20260710025525.1704417-30-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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
Message-ID: <20260703180538.3346781-24-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  3 ---
 hw/intc/riscv_imsic.c         | 11 +++++++++++
 target/riscv/tcg/cpu_helper.c | 10 ----------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7a4d8abe07..c9dfa7daff 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -680,9 +680,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
-                                   aia_ireg_rmw_fn rmw_fn,
-                                   void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 #endif /* !CONFIG_USER_ONLY */
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index ebb55191c7..d6b46cdca2 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -376,6 +376,17 @@ static void riscv_imsic_reset_enter(Object *obj, ResetType type)
     }
 }
 
+static void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env,
+                                          privilege_mode_t priv,
+                                          aia_ireg_rmw_fn rmw_fn,
+                                          void *rmw_fn_arg)
+{
+    if (priv <= PRV_M) {
+        env->aia_ireg_rmw_cb[priv] = rmw_fn;
+        env->aia_ireg_rmw_cb_arg[priv] = rmw_fn_arg;
+    }
+}
+
 static void riscv_imsic_realize(DeviceState *dev, Error **errp)
 {
     RISCVIMSICState *imsic = RISCV_IMSIC(dev);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 71a96a20ef..07d9222652 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -590,16 +590,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
-                                   aia_ireg_rmw_fn rmw_fn,
-                                   void *rmw_fn_arg)
-{
-    if (priv <= PRV_M) {
-        env->aia_ireg_rmw_cb[priv] = rmw_fn;
-        env->aia_ireg_rmw_cb_arg[priv] = rmw_fn_arg;
-    }
-}
-
 static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
                              bool virt)
 {
-- 
2.54.0


