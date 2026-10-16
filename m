Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD4FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPL-00056r-7x; Thu, 15 Oct 2026 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMB-0000Qe-3i
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWM9-0004Hr-B3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:34 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2db80fcdf8bso34399655ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112612; x=1792717412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CmyD6lY57V+HOwn6C0x+f/UFPrshUSJ5Ppnc/XtHel4=;
 b=OCQz0U162tiyOgn7XbQoiNz3O65JiVZspQ4/cBBLzn9WBzBXCmPMRLGA4w0+Lk+1iA
 qk1kGEOelE6k604ui0OMwuZgNoNlo7BvHbqeC+VfdbanEIYCJCfMLzsrdcq1WgA8/qOQ
 EsOM20ZuQOJzi8epRaSsERNpB3WryogdqOGxco4u0I6ejbvkLQE6mFyoASqHFka0xnWV
 n3GEGgdXRBozNqmESsthQd/9RfFZtgYIEooZndI2+32asdF9BsJfpuBE+fB7XtWtpRWy
 qRMz8HiTFvBWXL8HzGjHnjL6wYsKtnMAGr73LyZrAK3PshxHiUMxrDNeH5bQxrdVSpLC
 cYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112612; x=1792717412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CmyD6lY57V+HOwn6C0x+f/UFPrshUSJ5Ppnc/XtHel4=;
 b=YKZrK1JtVB6Q6JZmhhwqoETINkE4BtvW/7GGw1RxdIRLhmAl66Peptqgw3heQh9x/t
 hA0Xn1HkNUzObNtqX8Y5j22RelCjCdLnxC21ILup1jhR2ioEo4p4ZVUOcpgdcqtPs5Sr
 GyZMGHtkbWnHJjvjKwLkcv/MVplVMIMV1rWrSLWDLnBKRtWej2Qmfh7y1ULjyBWsActl
 x7MAwM/t74dsltX7r7a847fWEutXLKbwbczP3agOKZLjc8j8o3ajNOBxt439wh+okihZ
 NHf62y+j+lvcKoV+lsDb82RcbPAaaTziGoCcTpJFpwg7WLMOMyTzhxEYpAxxS2lCb2vX
 XQsQ==
X-Gm-Message-State: AFq9FYLp5ZQB+H80SIg/cchJBG21tXyqrQl/6qoFC/1pOlZSi9tdQ0oX
 VZNDHSs4+Ic2J5Zaj/c+GhcRLuERKodK73er47Ux34vul5xwlYrqgfoROg5DdA==
X-Gm-Gg: AYBFou2NTX8w2wl8da5vSkFJFENHM6ZYysD06rAkEcvBGyXR68xhVGV02wj708d5o5X
 7w5t3xs6q3S3QzvejmUfdP/chBbvuOj6XK4WZW95kicq2XD2lbcZAqgiLiIZUpXZX+teb6INBgx
 e6uE/tQkORUgQU8S2n7CAQbR9SKHvY4JVE1IqP6gXxXOh7HcUOZ0dxQWamqzHmsU4ja1/PPHrFD
 +rVH8B/RA6oOqP33hnJGQafMdXGsVKKuLFqaszCzpRrgiYCxea7jsIJlI3tIbSSwB48ohjZVJyx
 SYt8AUkOdOdlRcxxypgmG27EJVS7t4SSJH6XrqSj9uK+iWz/Ph4Ln8WrscmL7vdnopULGgpqDza
 +4q3Lox9SNdSXGRvsUBoNbI3oDN8ZKOa7kIlKZiupcILLvjc1dWBUeplG4UR6fjEoFXsw+Zw0Ph
 GvapbtrGn+AROcpA1KWYr0qZergcypLurDUuNy7MZz3fD0v6bNZrnWWW5FElVpTUQ/LHtrWRC64
 kB/k1zVdCfU2mtftwPczdgZ3/o=
X-Received: by 2002:a17:903:1b63:b0:2e7:ff72:203f with SMTP id
 d9443c01a7336-2e842bd0f74mr164673695ad.61.1792112611849; 
 Thu, 15 Oct 2026 18:03:31 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:30 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 16/50] target/riscv: Document riscv_cpu_update_mip()
Date: Fri, 16 Oct 2026 11:02:03 +1000
Message-ID: <20261016010237.1102834-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-2-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5489c564ae..24b22032e1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -688,6 +688,20 @@ bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
 bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
 void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
+/**
+ * riscv_cpu_update_mip:
+ * @env: CPURISCVState
+ * @mask: Mask of the MIP bits to update
+ * @value: New values for the bits set in @mask.
+ *         Use BOOL_TO_MASK() for boolean values.
+ *
+ * Set or clear the Machine Interrupt Pending register (MIP)
+ * bits selected by @mask.
+ *
+ * Note: VSTIP is not maintained in MIP, so it is ignored here.
+ *
+ * Returns: the value of mip before the update.
+ */
 uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
                               uint64_t value);
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
-- 
2.55.0


