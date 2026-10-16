Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A09BCCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 01:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHWPS-0005Nr-9x; Thu, 15 Oct 2026 21:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWMG-0000Sx-2H
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:43 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xHWME-0004ID-Il
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 21:03:39 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2e5378b281aso33799695ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792112616; x=1792717416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yy6Zl78c3NO2zuE+UCOh3WBHxwZVYNNzsACHtZLfSrc=;
 b=ifr61cmZ1xkNopt3wyRVz1oC7QAHsN9u5az7iPLVgtnQEaOY0CvkwGrnYkJkx4v6yE
 u2QDxPa7BQRPmQ+lucPviYFElIyA+9jjS8svksrkkFqIa1Yx+TL6cji8SjpHRF1Xuthp
 NM6Dx0ROCknyJ3iEDEkqPMWjsAYnYCA0Pfhd0sJ0eLlPDoEPS9Ulb0t+SQSarTXZYGbd
 lQO/scSFKDL+gZX9tN3VlnkKsBuONxcGLY/OEi8X4p8JUZXfBpyBD17YwJ0PkqD1yl2U
 vM4V6gxuy+az1oCciX/Z9V+2Ml6g9bioexe5miMy3m2dN8I0Xro+fUdvk4WCsML/0oKi
 EWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792112616; x=1792717416;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yy6Zl78c3NO2zuE+UCOh3WBHxwZVYNNzsACHtZLfSrc=;
 b=mKYCX6ni1hvCBxekZY8vbKaAIgUjeNoPfjPrSwPZvSS7tKrRTKBoiihgXEYY4kTk1b
 pefu+xj5WB0GApRISnz/Qx9/D3EKGgZ2+TYzK6LTMVwB0J2qtlpq2lj9mgGF2k7N0Q92
 BRQwzaEgHMBr03MilKs0Rqn940Baa0vpcCJSfKAGT8sJ76rdZhmayxrLZJcaBSAZmCSS
 YDoZlMXj5JdMTXcXhiW6S4KIOxShKlFOnal4emaRa9EicTejzepwb5CsZ1VB+9RDpzLx
 ohr3rx6H6+smVrfg2F2BIlmWQoi1sSYsuZBRzttlwWwWxQAATXWMuKOkd1FWM21Qb2Jb
 F/lg==
X-Gm-Message-State: AFq9FYJhB3I0hPYuZG9DHiUnV76GPtEe3h6R9jFVFPBA8ImiYLjg/vbq
 jkrojt6rzPg4E/FLkmlcVG8bQZv89AO/R1VwSyrzg3ctsPPj5pKkn5smwx8YMg==
X-Gm-Gg: AYBFou3ygyPKbFfFyu2xfiQincQqwToN+BRWWpvZr/3ZoJM2mNh7VJcMxQUUHdpfrjn
 XSIVnP8mEQGN2NmK1uOnW7kjza/V6zR61RJtOzHUEOQfeLinI2YqjxaQDgL+3wV6R7OxumcExVY
 xjMD3vlEG5LidImssElCJaPFX7hSsz2MQUfQ2hbGzxp7YKdeHLXJFrvEdJ3wQS4NK88tVzIbfCl
 11ScMyOcbA32uBvBIjlLb8BCM2Kw0gTDsMDdHKt0nsvgEzfhcfsu97Phoy20z9AxpSaFvf8qvTy
 /iape5G+cvv+dCpxCbdDNLCeJg7V20FDVycyG5RIAwfArP+9MfyqntZ21t9kybxpgBDHMOD8iO6
 QnVlssAYiFOf40Rjjcmt9w4vQEIKLpT1IadeRmp1U/XXAVe1ABMGBRBKlv/xLanEXSjbMXUXvpJ
 dCErW44yC7+XFPb5U5wqSguPXIyRH7f7WlzsAJnCejXZjtqYhDL485o+AVGGAbDMkIG6gsxQnoB
 Jo4KM7xSfOX6Gmv
X-Received: by 2002:a17:903:8c3:b0:2e9:460e:ca49 with SMTP id
 d9443c01a7336-2e9460eec39mr61865325ad.18.1792112615925; 
 Thu, 15 Oct 2026 18:03:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e833f1asm2513995ad.43.2026.10.15.18.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 18:03:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 17/50] target/riscv: Document kvm_riscv_set_irq()
Date: Fri, 16 Oct 2026 11:02:04 +1000
Message-ID: <20261016010237.1102834-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

Describe the supported interrupt and the effect of @level.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260930174508.81497-3-philmd@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm_riscv.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
index 0e27ce8bf3..aef681f0a2 100644
--- a/target/riscv/kvm/kvm_riscv.h
+++ b/target/riscv/kvm/kvm_riscv.h
@@ -22,6 +22,12 @@
 #include "target/riscv/cpu-qom.h"
 
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
+/**
+ * kvm_riscv_set_irq:
+ * @cpu: RISC-V CPU
+ * @irq: Interrupt to set or clear (only %IRQ_S_EXT is supported).
+ * @level: %0 to clear the interrupt, non-zero to set it.
+ */
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aia_irq_num, uint64_t aia_msi_num,
-- 
2.55.0


