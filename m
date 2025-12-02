Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F4D116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 12:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQP5w-0006c5-TZ; Tue, 02 Dec 2025 07:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5t-0006aG-Sj
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:57 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vQP5s-0006TZ-43
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 07:02:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477770019e4so45189305e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 04:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764676973; x=1765281773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=b7yl0SAsbV38hEIskAbccXsEI3efA5lyMPGt89TEYVO02Pvvdn/I2yvLTNtJh0dTtw
 5nQzz9WFNHGHyWHaR8bwh3c/Ne8cPy1dSrKCU2KrSPcY/tdKhvuf0ys4NSzJSfl4kVBQ
 KU0JUFEgrA59SrV708ORucjHpClH/3QjnbHtvqDZqnEqz90qhOKaknNM3s2qphrIoyRu
 wwDKvNH5VTr+ihak2LgHi6IV8/395oizwtjwHzy8kGUUa43Xy8LH7jzZJpsHfKPFs96C
 TkG9NrObPSK6Q0AB4mCLq7T7QOTBUC1m6HS/PPwbJUHONjz+CrW57FLou7OkUeLgmSsl
 LJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764676973; x=1765281773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=GB7R3cS53e/vjOZPr01fEmBBvTcsGxXQb8eCjsgtNKOmucLKActtm1rVZTsKGju8nc
 cJVKlYqkf9PcavJ7txQUDFvfHdquuOWb43rBJoRs3olg13adi58Lt3PRXarbrRDbWVnJ
 R4di7uuRedK5nUAcuttjQ9UIBnnAJZZcoG5n/YDw2ULi7PyR9n3IYkzvJyAvHEtzNCfb
 np0uZjd94hSeLGEU3zkuUNlu1Mwe0WLVNNQhJv6pWr60ja6vr3OSY2ihm6AWxT7SBgvr
 BAC7VUuw/XaLCrt0xmWgxkK+kGnhblonWloZDJOKZzl1/JvDoHBSvUrufTBERBVue0IG
 OKbw==
X-Gm-Message-State: AOJu0YzHq4ncjHizCmuWUGM72Xn69mVLnDUlK/brxIOmPmLkgZ+ZyXxK
 uWfQ3Pl41/FlUHJhPurBHueIcAdajkz4uYIGwf4/hp+qRaE/OtpFatJvvoYGlffmjqyzYnXc+oI
 H/fFM
X-Gm-Gg: ASbGncvb7Brsbui0hdyFEQleK0lZZ2hQaxjNPBxl1C2arpAkeIIxmtfhRN/PbxGb0q0
 noTagQslpNt8gn12cL2ehlPnPMgIibfEjQ8XKUGIbe41WDPdQYlhnOcgIAhcrAx3WslPc8wLZ05
 G2iMvxjKa1pII3dEXZ/tw0zMFOo83TjrWS1PlQoBjkLfv5H3coBvg1mCeY3JCBpEHC1FgiYH9at
 C/MHbly16Do+0/ur/quW8QVhEnZcPPm4FIcR3IB+/ZvcaKlP/EMZ7/ClKGQNOuZASojxUfn10b6
 UBsXNN7SELKNtFKFHq8infTpizBI0Em3QlYmHsb7T99TDnVZPWUPghhL19NoYVzB0yjC1qAAlyz
 wZJMibaEs1ZtPQL6dGKqR5Y5EiGUJj6qVvq3IAgc2weL0CA/jWjvn1vbd/uzIHUzVMOJirnW34v
 rm6nRE+PHqeBwh
X-Google-Smtp-Source: AGHT+IE5b/oTjboP4thoJJ1gnXDwACZ9b9/ceSSkWXRGfAyK+mn0WpljWj4t7DKTLgspIwfyb7QMCA==
X-Received: by 2002:a05:600c:1c27:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-47904b2bfd9mr308568975e9.30.1764676972735; 
 Tue, 02 Dec 2025 04:02:52 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:d0df:e484:1145:883f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0e21e8sm381169835e9.15.2025.12.02.04.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 04:02:52 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V4 1/4] target/arm: Enable ID_AA64MMFR4_EL1 register.
Date: Tue,  2 Dec 2025 12:00:38 +0000
Message-ID: <20251202120250.763150-2-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202120250.763150-1-jim.macarthur@linaro.org>
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..c20334fa65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0


