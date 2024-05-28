Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC80C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmp9-0002ju-SO; Mon, 27 May 2024 22:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp8-0002fi-TO
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:26 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmp7-0003jY-3Y
 for qemu-devel@nongnu.org; Mon, 27 May 2024 22:44:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f8e859eb20so250631b3a.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 19:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864263; x=1717469063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ueu7vuYmn8RUHwOpB4gRtq7cx4bSTGY9+BukiSLE2tw=;
 b=IHArGdhy8HnMWBLaBDH2uq/5U/sH4dvDzqaYeqiNDsN9ZmpDGleqUdtIhw7OkuM4Tt
 I6pgZOxgCrj6ZpDf5IYl5W54OqNbde+E/R5OcKG8kXi8+0IQ6MmJfc6iS0P5R+6fFALf
 6QC3YMkWISnM/h+Q5yTyIUG6hn1217QR72T+QmlTRHHacwCRa3e78GhkTcYB56nOi3i0
 TlumyLrV2QSM9+7n8J+z/qIW4Ko3lUBlEeycdyjo8I7ktdbfFin/EEZ3JHkG/Uzna99+
 vpiPMd+VuqEh+gcF3YdK8JBuEeXj2iK5WOcdKQUb3OuXrtZJ0Ogjzewq4u3oiZyXxZ+P
 QQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864263; x=1717469063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ueu7vuYmn8RUHwOpB4gRtq7cx4bSTGY9+BukiSLE2tw=;
 b=qAWeiy4KE9i2hs2GUbJlIf8n/YjBaEulF03SGlhqwLWvdVriZ8I+kp0+IVI4D+7vH6
 4iQYtvTnbTFPdhYSamQjA62qLixnPvj4BZP32o0i2MNO7FlhyMF26TtleYUTB1Vc/fhm
 qwRvQlysmfJiI7ZuajoB24EZAL8m9zJ90VUIdhdsALZVVB+vT2iXyqFfQtlzhD93jtU6
 4oy+lNiI81YQG6i4wvz5cxpRaKVkDWOqyBuAZXuIvR8hDFGBbChLwezqdyEEnZwbfRTX
 EusZsUtcSu4M5rRG3D72rAREzTN42WkfMGp+qApBMFPtRcGOiUHCMKGzXL8TxJ/eEg7w
 RkwA==
X-Gm-Message-State: AOJu0Yzy5xKa4r0aljP/YmskREeHTJiThostelesDH+AgQ7KwgTTrkWr
 H9vKmajSXsDlCr/TqHd+q7dFyo+q8ehKzOE6Jgx1Uy2ZKNL2Q2ETPxMZJg==
X-Google-Smtp-Source: AGHT+IHQsMDxnNUkEE816fbrBtWokGXFfoWvW/VAqBjHtNk+We9kF9dhJQBLZGFx7NmXARRjdT/GBQ==
X-Received: by 2002:a05:6a20:9d8e:b0:1b1:ec00:dac8 with SMTP id
 adf61e73a8af0-1b212df058amr10592912637.27.1716864263583; 
 Mon, 27 May 2024 19:44:23 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:44:23 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 08/28] target/riscv/debug: set tval=pc in breakpoint exceptions
Date: Tue, 28 May 2024 12:43:08 +1000
Message-ID: <20240528024328.246965-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

We're not setting (s/m)tval when triggering breakpoints of type 2
(mcontrol) and 6 (mcontrol6). According to the debug spec section
5.7.12, "Match Control Type 6":

"The Privileged Spec says that breakpoint exceptions that occur on
instruction fetches, loads, or stores update the tval CSR with either
zero or the faulting virtual address. The faulting virtual address for
an mcontrol6 trigger with action = 0 is the address being accessed and
which caused that trigger to fire."

A similar text is also found in the Debug spec section 5.7.11 w.r.t.
mcontrol.

Note that what we're doing ATM is not violating the spec, but it's
simple enough to set mtval/stval and it makes life easier for any
software that relies on this info.

Given that we always use action = 0, save the faulting address for the
mcontrol and mcontrol6 trigger breakpoints into env->badaddr, which is
used as as scratch area for traps with address information. 'tval' is
then set during riscv_cpu_do_interrupt().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-ID: <20240416230437.1869024-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 1 +
 target/riscv/debug.c      | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8ad546a45a..179cf3d1a1 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1718,6 +1718,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             tval = env->bins;
             break;
         case RISCV_EXCP_BREAKPOINT:
+            tval = env->badaddr;
             if (cs->watchpoint_hit) {
                 tval = cs->watchpoint_hit->hitaddr;
                 cs->watchpoint_hit = NULL;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index e30d99cc2f..b110370ea6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -798,6 +798,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
                     /* check U/S/M bit against current privilege level */
                     if ((ctrl >> 3) & BIT(env->priv)) {
+                        env->badaddr = pc;
                         return true;
                     }
                 }
@@ -810,11 +811,13 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                     if (env->virt_enabled) {
                         /* check VU/VS bit against current privilege level */
                         if ((ctrl >> 23) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     } else {
                         /* check U/S/M bit against current privilege level */
                         if ((ctrl >> 3) & BIT(env->priv)) {
+                            env->badaddr = pc;
                             return true;
                         }
                     }
-- 
2.45.1


