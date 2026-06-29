Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F50CC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgC-0007Af-0h; Mon, 29 Jun 2026 08:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfi-0006wS-3e
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:07 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfc-0007Pz-IZ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:02 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so2707145f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734457; x=1783339257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zvLNc0vzKaBuvu31NLedVEX7bGRGAQf2IsYZSe4AZqo=;
 b=ts9CCARj2yoSJ4ps05ZryaMquWgtTyqesZFtHV2i+uyliXtfEjZ4N8maN1A1/hlzDv
 CsdxL63n5hvsg6rUxSUTaaZloQVe6+l2Vr7BeH5ldXRWi9ktPodUxlVoczYsRgBlQ2BU
 ekDX2nKTRw5BrWuIUn9+/t76bKtwMkaDCWK2NLFPcs/oK0SROhYjn7dHMhCSwRvXYYPV
 jQ5mljcGo5KCBx++nrOkrD9IE1H4njHLgNq1UhD5kbRVVmgbuf37RIhChxl9HJmHZnAJ
 ESKiTZBWNy+9lSyZF6AL1mI9Wxy+19IUXwP8ARcehDTETgG7NWCw3dBhUdux4QX4aRKn
 FyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734457; x=1783339257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zvLNc0vzKaBuvu31NLedVEX7bGRGAQf2IsYZSe4AZqo=;
 b=N8AaudhQ0s1CAm3go8shqelMw2jJOlzjdbKMqGsBm/Dsgp2mw3zNoAQHhWokHSCBI0
 s3aoo/g0NumH//6+F/NCvzKSjBtxD42uG0AS62161uCEMmJAaF6i+xFoPLHqxfPZJGB/
 8nysPZsv/NdP+N8czVVevwJf86+goCy0q/NEU3otygKXcD7Axt5DrXRyOvJJViBfDVWA
 5RI1xeZWcECDbCe8TIUzagM29AA4bjs5Am3b09VnN1a4TStuKtXmDxicvUfGjTJYFCNF
 aJPA2hkg8B6kjt5vhUL024B8fvjd5zYb+IJF1nG8d0KsA1i07NKAyRnd/1u6/0fhI6Iu
 ATxQ==
X-Gm-Message-State: AOJu0Yy9mGAU259tjdgRjtzjo2o1nSsbD7fht2808k0sHLqQpJZQLvz6
 gT03s3+13WDIWw0NlztNXddKJqsxx9II7jaqlft0Y3kelfSfeJeEPHqd9pOHwjQjGkHY6ikBaYj
 YbSki
X-Gm-Gg: AfdE7cnffPr+pDRVzF+iKbIldXHm5nHG33I5MEkkdrskyiBvUOtGQ2BlWliMjaaV3DU
 eFJ0I/pNlXhl0i9Nkwc18OiCEe0VDnYbu7LSqUv18TLjhzTIOHyEm7N+ISZCTGRyfCNOSLHrnia
 FR+1cqiubR4Ijs/xSmYkQIkXCXX2rOxh5ComRftKQKdBz+dinROqvng16WaNFg1Xd0nSHd41aCk
 kiOrHFtENJzz3tVy6DG9LU4MPRtRbbHQCDa2wUT5CnYKCpyByiRjaFphnnVOouRgKxZUl+RHKM9
 H3fwEs9s1zNt/VTwjh8JPjOBYR6LrDxRk1qBm4Fgxocu2/UW3iNc6iezqK6VuhkF33eh3nBxBz7
 aiXKGBQx6AqL+6B4i5WKqDOK2n+Gl+nK7Ab6y4GmCdt0Nft4DPSgyxtjFCWNs98USHd75UHbHly
 kK+RzjsJ5GzdFd0xaj7LIBR0Hcvdb1sT3yUqxeCjBgdku6V0jSsvCCuNf98KJZLsaHtU8AScCqO
 B+03LCvbJt0MOC+TYyMyA==
X-Received: by 2002:a05:6000:382:b0:471:e4fc:d881 with SMTP id
 ffacd0b85a97d-4750079f963mr234750f8f.30.1782734457256; 
 Mon, 29 Jun 2026 05:00:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.00.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:00:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/54] target/arm: GICv5 cpuif: Tag ICC_PPI_PRIORITYR<n> regs
 as ARM_CP_NO_RAW
Date: Mon, 29 Jun 2026 13:00:00 +0100
Message-ID: <20260629120032.1645265-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

The GICv5 system registers are all tagged with ARM_CP_NO_RAW, because
we don't want them to use the standard mechanisms for migration or
KVM state synchronization.  (GICv5 handling of both migration and KVM
support is a "will be implemented later" feature.) We missed this tag
on the ICC_PPI_PRIORITYR<n>_EL1 registers; add it.

Fixes: ef540c1d301 ("target/arm: GICv5 cpuif: Implement PPI priority registers")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260615105029.2898872-4-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 09c3fdda61..1aa4bde799 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -950,7 +950,7 @@ void define_gicv5_cpuif_regs(ARMCPU *cpu)
                 .name = name, .state = ARM_CP_STATE_AA64,
                 .opc0 = 3, .opc1 = 0, .crn = 12,
                 .crm = 14 + (i >> 3), .opc2 = i & 7,
-                .access = PL1_RW, .type = ARM_CP_IO,
+                .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
                 .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_priority[i]),
                 .writefn = gic_ppi_priority_write, .raw_writefn = raw_write,
             };
-- 
2.43.0


