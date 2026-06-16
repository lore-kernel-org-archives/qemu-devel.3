Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAFACD98ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQik-0005sx-55; Tue, 16 Jun 2026 06:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQii-0005rG-Fs
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:36 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQig-0003fx-Px
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:36 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36bb3551f6eso3412752a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604513; x=1782209313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyznDJY0L2Bq22y7heSsow547LinZLhsCPsjjbdM4sU=;
 b=Q2bsISYt5Z0PL3wDIq/+Xbj7O8lR/xOhNbKoEBRMk85yHmPRdrkoB0DxP+AypxpI5J
 ruN1qDq5Becj2Gejow26x9qxlrbiYhBigyTS0fNzW1wxrlV6WuUV31IiHtD7nz/Bt7gc
 duvP/jRmdb2lE6jMPiOh9nIWO4g98ueeiM6zZqREaWQ5te1pZlxkXxlEgJjXNKssC3y1
 TNMLK1lGU9kFSLH9WFq57eigo7H3QgEl91p90xBWLAqc68Gy0LvAj/rl2AyTKutyEfXz
 4yIeOhxyZ2eUAIaZnv16Zc34wqcRRaeY+MbnUDoovxFSFv91vYsp6IVMjIk4p1yQH5l9
 8zpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604513; x=1782209313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VyznDJY0L2Bq22y7heSsow547LinZLhsCPsjjbdM4sU=;
 b=ooZNqCGrDbqCvpVmscWLS9Ye/Ke7Rg/7IA0yszMkk51H4UfWJCF+nB0NwIG+nJ4amm
 gorqD1554Cmw3Ffk54zMDZZzywSvt8N1/+aGTPPSPasd3Kpw+e1l0oMhUL6GRGr8j8Zx
 dbs7YqSk4x+MUFwIy2gA2lm2/jTsoUqjWpHdxCopTeB8pwNGg13sJFWrKki9Xyr9ZsDm
 VkVKZ0BiGJ0vmn1dttwWrjuQ1hI0eY+HlWMt88fUCmIbdLO/QMJtA+EF4DqbTBrmZ3F8
 9ahGdX7/ezpZOJyIlMjVhtj+57O/Gt9Iop15WTKrN7hUXeTKvKtvqYWibDAOExPnBN4s
 bUhw==
X-Gm-Message-State: AOJu0YwnPpUof42FT2N6VRu+ShBH+T7wu1ePHZoDEd4BE/rVM2HzWDiL
 V6aKvrMAB2TdBqzp9bvt/8TSVnPSzir6djnRcGKSPzWhnqbfF4TugWjgYmH9UvVo
X-Gm-Gg: Acq92OHZP8TqpkABMlGiSvGApeayapVrn4DN/ZIFRa82NwmL959lrgZeHqXxLCQCGz7
 9LMH/TBcnWw487YNFyJBw4gpXzh3i/qZ7Y7kimjfj2nIBbQVBUEzv/fJjBfG1xsAQS9G0RXQ+BI
 DROrf7awPJS9PM5VXcipijvHGZvLukUdrfRQFg2N2nrx+xvaTwOshDLgCqZT9jekzJE9+lojTTz
 mMF6mYTNnW3vv4d82ULnKdRPUUPTsMgLmd1Tg7ITcwI38aMbCrX3GWQPkfDJS8I9oTJ7GQsSkWk
 67mvazqgAwP1ObB9McXBm3U5EFSS7SHr2XMHacCG+FHaOhyQ8X1LGKZpm2Pldol6ezWugQhURK6
 0a1Gc8jBIWCFD/s5PQ2+KgNugI85Xxv7kqjinrZt/una9pMAM1A56khgSCr7uI7zv9LsYQ4JDDR
 WxyyLeHXuQ2Yh4r9wjAZdkGM8HhS9KtbFf1DrNsad1
X-Received: by 2002:a17:90b:2dca:b0:366:10f1:3d86 with SMTP id
 98e67ed59e1d1-37c2bd75872mr14951022a91.22.1781604513468; 
 Tue, 16 Jun 2026 03:08:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 51/83] target/riscv: Expose and document the CPU 'big-endian'
 property
Date: Tue, 16 Jun 2026 20:04:54 +1000
Message-ID: <20260616100527.1939565-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

Now that the full big-endian data path is in place (runtime MSTATUS
bits, boot code, and page-table walks), expose the "big-endian"
property to users via DEFINE_PROP_BOOL and document it in
docs/system/target-riscv.rst.

Document that the property models fixed-endian hardware: it selects
harts whose MBE/SBE/UBE fields are fixed to 1, and it does not model
a mixed-endian implementation where software can toggle those bits at
runtime.

The property can be enabled from the command line, e.g.:

    -cpu <cpu>,big-endian=on

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-12-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/target-riscv.rst | 29 +++++++++++++++++++++++++++++
 target/riscv/cpu.c           |  1 +
 2 files changed, 30 insertions(+)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ad5d1ddaf..afd86ca2ba 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -95,3 +95,32 @@ the images they need.
 * ``-bios <file>``
 
 Tells QEMU to load the specified file as the firmware.
+
+RISC-V CPU endianness
+---------------------
+
+The RISC-V ISA specifies that instruction fetches are always little-endian,
+while data accesses can be either little-endian or big-endian under control
+of the MSTATUS ``MBE``/``SBE``/``UBE`` bits (see section 3.1.6.5, "Memory
+Endianness", in the RISC-V Privileged Specification).
+
+QEMU implements the full data-endianness behaviour described by those bits.
+In addition, the RISC-V CPU object exposes a ``big-endian`` boolean property
+which models a big-endian-only hardware implementation, where the
+``MBE``/``SBE``/``UBE`` bits are hardwired to 1. When the property is set,
+the CPU is reset with all three bits initialised to 1, so the guest starts
+executing in big-endian data mode from the reset vector. The property is a
+static, per-CPU hardware configuration option and is not meant to be toggled
+at runtime.
+
+The property does not model a mixed-endian implementation where software can
+toggle ``MBE``/``SBE``/``UBE`` at runtime. QEMU's RISC-V CPUs treat these
+fields as fixed by the CPU configuration: they are reset to 0 by default and
+to 1 when ``big-endian`` is enabled.
+
+The property can be enabled from the command line, for example::
+
+    -cpu <cpu>,big-endian=on
+
+No upstream CPU model currently defaults to big-endian; the property is
+provided so that big-endian-only RISC-V CPU variants can be modelled.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cc793aef18..5a3560308f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2525,6 +2525,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
 
 static const Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
+    DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
 
     {.name = "pmu-mask", .info = &prop_pmu_mask},
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
-- 
2.54.0


