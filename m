Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E04EE6B6B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh1-0001Mi-5D; Fri, 06 Feb 2026 16:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfP-0007CO-IB
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:07 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfN-0002kH-QU
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:07 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4362cdf1d5aso905570f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414424; x=1771019224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uOxfqhX5weYKm/5VH7kGCYrhfAXwgGoppwfJHJGwlCA=;
 b=S2zdi/54fl9vtchGbHPXh3uqoZcEFDlaXJYHShsGbRaFf3VgJ9py53/MdS8OffeahW
 EBAfXxqr/nGiMTvblPgINaUnJaUmPinyDzF6OJWJukFSXA7QoMxSadIoPa3G4y23Cpnz
 FAXtXUAtUdbnRiX0W02Jz2IuvVYjOnQoQ0ejP1OfGhpgYZpfEtprC4lVSEXKUpHGEOQ3
 mscH2yW/LfoHJRabKFDDGoWu933VYrcKIPnRBzn9FQeODnDxpZALN+FT//ji2rzcQTgD
 pTRIyFwyg/3/lxOti4FEvN0+KcDWLSMUd8roFl7RCVwySGgf0gjtBo6wFaK+cH2/aG0T
 nEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414424; x=1771019224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uOxfqhX5weYKm/5VH7kGCYrhfAXwgGoppwfJHJGwlCA=;
 b=J5IczPVEtcwHPD4EXIofsE/Cb8vGNHjloP7X08dC+jS+l2WlPjYmX06W8nmH3sQnb6
 5JjqVadHfeE3QwYydytteMV2CkkjYEpYyqVhPRhH8DCsQJuh5Yks2a1j/TkXEAOTUpGD
 Mv21B1apbHMN7X7oS3kSTbA5OP88OdMU1AnGMk41eKziX1QlfTpkFgo+FDkC4CGVrlg6
 blRnnNPMrFbvS9cYfK7a0I1Z1xyZlYPrCfQb4U9qyldpPhuIKCny/rUi5+PwRxuIgxiR
 ffEDdBgTCDCXx+xc9cndwCowgiKeKjV9XL6SMtTzoe9q36xyr1vZ7DCBoBSDipOXkMxl
 pztg==
X-Gm-Message-State: AOJu0YwWe+5i85DAEFOoCCJs+6267+6mzfzZu4jU/uAJ/nlf6+3KYMoR
 MT52Yf91k8+d98i7ot1Ap3IvdfBLLu5ZZdHOus1mxveTNFM/76pYhE34cUGF2GZRoZ18VGeEQS/
 6jRhhOnI=
X-Gm-Gg: AZuq6aLTp/Y6s/zR2z5zOQdcUk5yp6y7r2jcP6p+AzDIkH3c+xSj+0PccIr32uoXsiJ
 I8YOiderQNarSg6pY9WfPU/74juNaByY2k/jYwaUpb2f1U6052zsQrC+pApB1UUncNOUCks28W9
 MpYmDk6du6oqbHIEslrC81Yi/jhXTICbIY0H/cF+GPj49FoRpyjcU1KRrT1v6cVoNmX5PU8Akx9
 VPncJe77O6EMjTTpBBRKY17YPMT5R0lt3PiOR6sTv7JFY2zycYaaj+Ojej6ZXj+QzMj19Zl+hvw
 t1Q2If6G7YYr+WGr3d1ks3FQiPL7/dZyshmYakNfmDErAig0WIr3Bg+IRdm33Zf9cgwuH0Fl9FG
 9r1e1JDXrtmYBdQDVSdDLxAhwfCYi2bOGMUn0obHZIbiqMzsqUeud5AAklYmO3jBZSAVvAF28hT
 X2/pF7Zs+yvqb3JELsB3ow7miuLm2/n8s7IIrr7N+EGQNT45AZIwlRFpS+T+VZ
X-Received: by 2002:a05:6000:2307:b0:436:1989:a1ba with SMTP id
 ffacd0b85a97d-4362933be47mr6161161f8f.10.1770414423859; 
 Fri, 06 Feb 2026 13:47:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362974b176sm7902373f8f.37.2026.02.06.13.47.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 20/30] hw/intc/ioapic: Replace legacy st_phys() ->
 address_space_st()
Date: Fri,  6 Feb 2026 22:44:38 +0100
Message-ID: <20260206214448.22008-21-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault. However the
IOAPIC datasheet (82093AA Order Number: 290566-001) doesn't
mention any fault occuring when the system bus (ISA bus) is
accessed. The ISA bus neither offer a way to signal recoverable
access faults. Therefore just inline the stl_le_phys() call,
not specifying any memory transaction attribute nor expecting
transation result, per the definition in
"system/memory_ldst_phys_endian.h.inc":

  42 static inline void ST_PHYS(l)(ARG1_DECL, hwaddr addr, uint32_t val)
  43 {
  44     ADDRESS_SPACE_ST(l)(ARG1, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
  45 }

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260204204103.46343-4-philmd@linaro.org>
---
 hw/intc/ioapic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 87ca1af5421..1b3f1e824ac 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -141,7 +141,8 @@ static void ioapic_service(IOAPICCommonState *s)
                  * the IOAPIC message into a MSI one, and its
                  * address space will decide whether we need a
                  * translation. */
-                stl_le_phys(ioapic_as, info.addr, info.data);
+                address_space_stl_le(ioapic_as, info.addr, info.data,
+                                     MEMTXATTRS_UNSPECIFIED, NULL);
             }
         }
     }
-- 
2.52.0


