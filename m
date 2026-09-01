Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37298C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONQ-0001AG-OF; Tue, 01 Sep 2026 09:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONO-00019V-FV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:10 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONM-0007F3-TD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:10 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c25b661d37dso130229566b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268687; x=1788873487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zpDvYgVwxn68m/EmgaVJMbAXY1Rn3V/cvPIY9Du+jCI=;
 b=jPLU/T0YM7/+vTOx1PSxJqBkAVVOIVifLsyclN0znxR+UTv53zAH0qSparwsy9+qVI
 VNOTf2hvbHp8+2SNeXhSWEgBl75UlyD/yopV9PmJZuGUiA0rOX2Nk9vSXnGpG35mBIYW
 AgWD8ApZ4oKay2KAN2RogM73PLbQz9SGmio6vSHIkB3u4n0X/xqwGD6WAiEDg65GuCfW
 s1ER4BEtVWCr11QLA+ZFONDbZbgP6V5Xc/sojNxjSX/Rc0IvJ1CGIIIPXeJ21yUrDNUf
 WbuwTiIKuzS66qILC7fP9WCmIC4smHGe8qvROX17zlWkI0HpTHJoESd9J7QvuIdT11mG
 ikuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268687; x=1788873487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zpDvYgVwxn68m/EmgaVJMbAXY1Rn3V/cvPIY9Du+jCI=;
 b=meZN0PdRMOQzr0ERMM53y4/D4aVN3anAySTs+W6Q/WzoHpCaiFuvYlITieYFf/W1x4
 TFIrfQI4ZTIfuryQDgmkY/ZsqR35Zt8OOfu0PQ0vfSM0dP4N+P7ZblPTj1Z+Un+rwwOQ
 ElAKJVXhSNkbzEuI9P4oNIo1M7fhMRP+rGELlJma6je5RmxFtgFQObsfj8rZIiyisuC/
 i9z9HzoyMOgq1X5ynEwqjePXTWQKkaYcBR5dv6GrOt4pvM1Nwlu0W5IZWiLpWAxxo1I3
 /idchn+GN5WM+QxNzlhAva6+2oIX/I7hhoBJDhn3MRs8Mht538ZvMmy78SFYVval3uzI
 Buig==
X-Gm-Message-State: AFuF++lfGVZ6Gk7cF7clVau+CyyYSH4jaCCsjPI8tFEjYnEaOSxSw+gn
 mkFG80RglbmEo3t7xUxqljIdNEP9/WL/+msU8XyV0yp18W8HsdBL9KhfVXnNeFLCphpFOhcDe+k
 NdNuxXpQ=
X-Gm-Gg: AR+sD12+nVt9Mh/22NNfLyIIp+Z0ngk3dqb2VD7jZ3imTLhd7wmvEiilU0FOZlZBh4W
 b1wTJmVl+dCI1+Pw/D3LOSdxcyoSgmT3m1AAjn+unPZehfJmu8h7Ze2c/rejDHcDZs/mD735bB/
 Yr9NaaawHkL1j/5gWVwP0pgiJ3MRkT/VqkP025Yg+6rKFyAXcXkPVj7uUgFRtWja87h2iaYLFU2
 3+G4t9DsbUKscuo54NHbN0ytHYT3w/41n6qDJ1TMZdMeh/xV/z7aOPsnmazDG+/zc8Q+ij6W1SR
 1VErsg7GfFP3rNL2R+lV2lAq7jL9WwY3/tqicRjjNY01kT206FdC/UN7yeZxqxVLZYwKSrNlYOF
 v/2x2vAb8g41TTJLrKqvOiuAv3DK9EEzZ+x+mRZ7zi6ImJo0zo1Ln1EyA1f6NWJSgHhbbDl8HSP
 tAjfZhXNFCNKzVA5BwiDDWjx+wK+6SDyvynt3IwDBCgObc4kyXP0cPSZliZ5rHf5w8McF4fNxVW
 f9t9qfjfOXK5N901jzJvJutsoY09b0vg8emGFG3tE/ehDjaPrZXdLHpWpiD0cBlZC9dYMLqNsP2
 fvmJ
X-Received: by 2002:a17:907:e009:20b0:c25:afb6:2d91 with SMTP id
 a640c23a62f3a-c25afb62f6dmr508943466b.2.1788268687328; 
 Tue, 01 Sep 2026 06:18:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/58] target/arm: Enable FEAT_FGWTE3 for -cpu max
Date: Tue,  1 Sep 2026 14:17:07 +0100
Message-ID: <20260901131732.2263947-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260806172709.333300-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index ff02435975b..e342ebb4445 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -78,6 +78,7 @@ the following architecture extensions:
 - FEAT_FAMINMAX (Floating-point maximum and minimum absolute value instructions)
 - FEAT_FCMA (Floating-point complex number instructions)
 - FEAT_FGT (Fine-Grained Traps)
+- FEAT_FGWTE3 (Fine-Grained Write Trap EL3)
 - FEAT_FHM (Floating-point half-precision multiplication instructions)
 - FEAT_FP (Floating Point extensions)
 - FEAT_FP16 (Half-precision floating-point data processing)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 251c4b3cf60..2d48b736bc7 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1466,6 +1466,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64MMFR4);
     t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
+    t = FIELD_DP64(t, ID_AA64MMFR4, FGWTE3, 1);   /* v9.4: FEAT_FGWTE3 */
     SET_IDREG(isar, ID_AA64MMFR4, t);
 
     t = GET_IDREG(isar, ID_AA64ZFR0);
-- 
2.43.0


