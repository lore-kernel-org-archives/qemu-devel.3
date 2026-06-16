Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277BCCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQic-0005cT-K2; Tue, 16 Jun 2026 06:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQib-0005br-0E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:29 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiZ-0003d2-7S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:28 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c86307c4e6bso1517534a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604506; x=1782209306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=783WOVRdzAZMS0Kq52fQLIJbCbqqdOyC83jusazd0xU=;
 b=pEc1nrc62bXGyJE62HgdwZdGKSKxVnGgLw8OudXkFLJhOzb15bdrgfeNFJJp9fX1yp
 3xQipo8ijLyzLG4wwMxYSaI6Cis5NhJjbpsY6nWMpDelD2aplU5/Idhnn+sJp6hAKajS
 jDOilsB3cXq0ue5siHcPZWr37H978lAhTrOg8yBy7nSZ3+8b+/neLlG5QBSKUBQnsypv
 f3UzBVFzu9f/7q2gARlZRQptzElub1XpAmD/oONIeUQvDd9MVMqRlTtVnfyJrxIlgOiO
 MKQfOeYHHzxcOlLoSh0D9lRs2Wym9+duYwunphLDuRYVpJakAOQ5yFM+xj+qML9o3rLV
 soaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604506; x=1782209306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=783WOVRdzAZMS0Kq52fQLIJbCbqqdOyC83jusazd0xU=;
 b=ZtC9yB6PXdNPWbyj0wCx4tfCUBs1vsCJOZQn06yvPnVoHdz/n3tTuqnH4H5xbulZ5V
 qx6MFuqVnVOuuT4P4AETPf6JNfYRp/fUXEh6CHWunm6bkxLI62GjAmeWXO5nQBQ6Syij
 kq4boULM5Ei3IwbRT00y661bJZ5gx/2HgBzItqNUtwt+EtDTSni1/mjBcANBHRIlv/Q0
 efVNZaNMSr2QMohLSVH3fjoc9Xm9HRvPNwosinZzJoOLCUB0ZNo1/kHgMlswuoSZE8z/
 NC2/w8GScMzyujADdqbPOazrjzN4K2GsW8F6KtFIEHlzOK6mUWjJ4B52jaoz2aiQv4jl
 HWhA==
X-Gm-Message-State: AOJu0Ywm0QM0qk9ItnTeZplZn9s0GishdidO4yqlsRvgKJ0GiX/lklg3
 WD0ykLdygXenq4cX8aculyQlxzjBRAxeyulNHTiut+3R0fszwQWSaB4xxdS5bfh4
X-Gm-Gg: Acq92OHwFopQ7PP9i+Dt5WW69KZHQo3iM9hbEC3oLxhmtZWWsB4fnU5TCUaPTCm9MvI
 UysZGw8Yhyzj/LkvhPnbI7k/vRfYuIyK+P15bAXNcxX+ubqnAA+SYhPTcsRm0hJlhid9ilIPLki
 7w6BKEKVmnlx8TSE2lmX/nP15ssVMGcRuMK5vk2Vvxtl/OXvWxEUFnFCpU25pH8Co7vq+N6N0fZ
 AfzTb+m7vyf44sJDAteNQlm4pEJFjejgD2x2+FE6lO+WLV5VQLwvo/exlPpxpjRwHHIT3Z+uDeu
 EAUBQ0jwpvC1Zeqtb4UqNOvbiE87m/xQ85NKtrhXWR391Xi/5LvPUojwkAZZN0BBXQYKvEskHq1
 4OlkwQz/OOlWW6+0Mi9LLdZhVGGhHjhoIXkbtKZ10eBrsgECiqmaC428R9xL1PxmJxENmJQ4r3D
 N5DnTbB5jR4pjpUr2KTerBf8F8bBp7+WaiXkIJ4c4p
X-Received: by 2002:a05:6a20:2443:b0:3b4:813d:dc1 with SMTP id
 adf61e73a8af0-3b7e49c16eemr3380073637.31.1781604505741; 
 Tue, 16 Jun 2026 03:08:25 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 49/83] target/riscv: Add big-endian CPU configuration field and
 reset logic
Date: Tue, 16 Jun 2026 20:04:52 +1000
Message-ID: <20260616100527.1939565-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add a big_endian field to RISCVCPUConfig and wire it into the CPU
reset path. When cfg.big_endian is set, riscv_cpu_reset_hold()
writes 1 into the MSTATUS MBE/SBE/UBE fields using set_field();
otherwise it writes 0. This makes the reset value deterministic on
both cold and warm reset.

This models fixed-endian harts, not mixed-endian implementations where
the guest can toggle MBE/SBE/UBE at runtime. The MBE/SBE/UBE bits are
not included in the writable mask of any mstatus/mstatush/sstatus CSR
write path (unchanged by this series), so the value chosen at reset is
effectively hardwired per section 3.1.6.5 of the RISC-V Privileged
Specification.

The user-facing property and documentation are added in a later patch,
once the full endianness support is in place.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-10-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/cpu.c                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 734fa079f2..9eb47af0a7 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -157,6 +157,7 @@ BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
 
+BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
 BOOL_FIELD(pmp)
 BOOL_FIELD(debug)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ee74cc5b20..cc793aef18 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -740,6 +740,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
             env->mstatus = set_field(env->mstatus, MSTATUS_MDT, 1);
         }
     }
+    /*
+     * Model fixed-endian harts: MBE/SBE/UBE are initialized from the
+     * CPU configuration and are intentionally not writable via status CSRs.
+     */
+    env->mstatus = set_field(env->mstatus, MSTATUS_MBE, cpu->cfg.big_endian);
+    env->mstatus = set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_endian);
+    env->mstatus = set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_endian);
     env->mcause = 0;
     env->miclaim = MIP_SGEIP;
     env->pc = env->resetvec;
-- 
2.54.0


