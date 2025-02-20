Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A1C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Iy-0006jX-0Z; Thu, 20 Feb 2025 11:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iv-0006ii-Kx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9It-0008B3-Sv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:37 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f26a82d1dso674014f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068494; x=1740673294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fIe0UZtBM69Mht7MkuDzNVt6Q9Xi+y9ptgUmQ4yjGXo=;
 b=lApXJ8Aqa8hcDIauW0Y2P4kMDGlvjZaCj2NVxg994qpsYMV+rxfAJEWoMfVb8RX7hZ
 fEROx94Zc/y0EWgMOsLVbfc/4cNMj0Vq5mkP1Ca/9DGYfOyJQOyvV3Ft40OScHL2EpMJ
 SnIuzfjdAGHk984Z5sKDekshewre4sIxMRi+9Om3aucgmKRRpFZwth2wKZD3eMHesR9M
 qkYIF5RGjiagSsT5bseUuE2LXRFfUkIe78UFYVotvOsly9MhIqiJoBXiePeJ5IicyOey
 BeF5rS2pGg6INvzKjKhdAJslAxJLqD3jom2d1okNXL+4it7VERHVgT3obC2s1eDPftsM
 ltsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068494; x=1740673294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fIe0UZtBM69Mht7MkuDzNVt6Q9Xi+y9ptgUmQ4yjGXo=;
 b=vEAZg7/wjFrQXfybOADOujntZJLBSkmqdL1FH9N+538DlPUKH/7YfhCftwH6Q+xOKf
 VGQRCvq2AV0NvONn4Q3SuCDYq/QSJ57yOTJ/uYdKKhw0IPddCpuuWPuB79a4ZqpWonTh
 uxTFO92wOh4FGaVs5Bd8RCwrkJQkZqEgmFDn1PYiVeTz0mS1uMRaG15VePoxG0hEGAmP
 zrvSdaDRFTWgYf0gAtgwUx/azFQNHonM55m9CelklUkiNncqs+xQjU3OClzDc5auYdyW
 ZabzgULM/d/nY4KH+JoZH46EBJ0HJMNxJEv7ByAfOUus11HKTRfWyp/IYHKtn0HMcPl9
 IrhA==
X-Gm-Message-State: AOJu0YxIR7IM/+/iMfpFycKpHqlv6oRGjB1YydBpOZNC6wLIr2Y9U6eS
 rLOpjhOhxiNCzMx3rJFo6yXdfNnlpsG+FdGKIjXf0eVLHwJieGJMyvOC+gT6mxo7BueIzhgWFyP
 N
X-Gm-Gg: ASbGncuycn2MFFlvY+F88feBaTdqWhhMRryWSY79FIO4ZZdYAINKFEYBcTe3iIE9t/z
 jBzcHDPhiT9rpWG+5tnwx0aiqdcxny5AujM/BqCEC9PSnC6B6KX5V0zyC/AAPevZx7TwpHspJuB
 sV4peEWjQI4tT9xLuHgqEgEVT3cDxUHE9jBsHgV9zKmM5CpJt+fLs3ozgrWCz4RQk+7LBt4Ciqh
 W/RMYsOqoqxC1tApUnkS3rLo8/MuDiNuOiZno08ZOzQrpMpqre/SWLyfBQJWZ7ssMOXRp+Jz0uq
 DpsmfCduk4WN4aLTj/S78g==
X-Google-Smtp-Source: AGHT+IHQqa/rxlbgaJYpP1B9EPxhS1m6qFeFkVdbhKXBOXenU5XYbTGABtvgdQAbW7RH1tNQNi2emQ==
X-Received: by 2002:a5d:64e6:0:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-38f33f1193cmr17948347f8f.7.1740068494276; 
 Thu, 20 Feb 2025 08:21:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/41] hw/intc/arm_gicv3_cpuif: Don't downgrade monitor traps
 for AArch32 EL3
Date: Thu, 20 Feb 2025 16:20:47 +0000
Message-ID: <20250220162123.626941-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

In the gicv3_{irq,fiq,irqfiq}_access() functions, there is a check
which downgrades a CP_ACCESS_TRAP_EL3 to CP_ACCESS_TRAP if EL3 is not
AArch64.  This has been there since the GIC was first implemented,
but it isn't right: if we are trapping because of SCR.IRQ or SCR.FIQ
then we definitely want to be going to EL3 (doing
AArch32.TakeMonitorTrapException() in pseudocode terms).  We might
want to not take a trap at all, but we don't ever want to go to the
default target EL, because that would mean, for instance, taking a
trap to Hyp mode if the trapped access was made from Hyp mode.

(This might have been an attempt to work around our failure to
properly implement Monitor Traps.)

Remove the bogus check.

Cc: qemu-stable@nongnu.org
Fixes: 359fbe65e01e ("hw/intc/arm_gicv3: Implement GICv3 CPU interface registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-7-peter.maydell@linaro.org
---
 hw/intc/arm_gicv3_cpuif.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 9cad8313a3a..8a715b3510b 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -2300,9 +2300,6 @@ static CPAccessResult gicv3_irqfiq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
@@ -2365,9 +2362,6 @@ static CPAccessResult gicv3_fiq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
@@ -2404,9 +2398,6 @@ static CPAccessResult gicv3_irq_access(CPUARMState *env,
         }
     }
 
-    if (r == CP_ACCESS_TRAP_EL3 && !arm_el_is_aa64(env, 3)) {
-        r = CP_ACCESS_TRAP;
-    }
     return r;
 }
 
-- 
2.43.0


