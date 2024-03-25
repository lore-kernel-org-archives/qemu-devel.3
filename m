Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ADDC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokQ9-0000z5-BP; Mon, 25 Mar 2024 09:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rokQ6-0000yR-3m
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:31:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rokQ4-0006u1-7F
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:31:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33fd12a06fdso3083369f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373478; x=1711978278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UG7Md5ptENEJSsV0K7ydj7dMPAW9+5Dt7UXUOoP4TX0=;
 b=o+quYPS5M+MvXc44TmfQyDp5JG7Q38wEn5SJHK6j8MGsWwhnyxbJcoPeVhC8ZEtvZQ
 TN/LNXbREeFThWyp3L020tHiE1bVzWZASGQaIJrqVDF+I+s31qhN3rX6qBRYAPt2+J7T
 aGCG+2pgX8s6L6rrGQvzWjdKjKXxgwKEuO9mNrplqYzYioD697EMzjYfHJNen78ax5Rv
 IDGx5j9ALAkZfFmaMAQwqnsHcDoCEXA1LwztDQm/EV9smhVaSBwfcLFIjYqdJlg0JZ4J
 mizGrxzhjKmAM8okyEpDUh/I7Ddv7tEV8qhfMwO95cQwG+uHtnhE0OVb0I5oCDONonp1
 nEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373478; x=1711978278;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UG7Md5ptENEJSsV0K7ydj7dMPAW9+5Dt7UXUOoP4TX0=;
 b=eoqr2i3xUlCQxeGwjFhA+X5UPMJvw9/cnl3GUPsST6/HzlrtI5nNU6bQyU7RBj4E3R
 NZId2V4vWbv/0PPIvRuXqODjTjOSX9JrKjgnhTGk35eE1vlUn30B+9NKFGlO/9StQpFk
 c4XmKcYWY0ENg2NTFwsGceQKjNsz8Cpezh5t0fhnl917u5BNzWVG8x7cTxgl1m1lsXm+
 HQkU/MhmAwA6+/XndhC0Cqmr8KtP2vjjFQOHw4YafvpLyGLK450WK3cXihiPklJ60ypV
 5wDxbIAlx5B8XhplTQOiZPK2FgYMQuA7Eix90t70K09GvWQ0vauVtSchTH/RH9F4jWpc
 4VDA==
X-Gm-Message-State: AOJu0YzvCI8ModxwbZWyuHgt36c8zdzNi15F98Ht6EtAH1/HjO4XQ0Ne
 XJ0E8ycH6OTJpQuvZGBSmmucema2tiByIt0HKt0oEklg0+4tvbJZAn4bP6AlWrybCzyDX8fXsF/
 S
X-Google-Smtp-Source: AGHT+IFD24/odmixbK1LHstBWiwtzIVG9IZOYEIum3t7efXk7JAvN8hyLEvhprmp3x33+BdNOYHY8Q==
X-Received: by 2002:a5d:4d07:0:b0:341:b4db:c8d6 with SMTP id
 z7-20020a5d4d07000000b00341b4dbc8d6mr4341397wrt.71.1711373477724; 
 Mon, 25 Mar 2024 06:31:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a056000174a00b0033ec9ddc638sm9596027wrf.31.2024.03.25.06.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 06:31:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH for-9.0] target/arm: take HSTR traps of cp15 accesses to EL2,
 not EL1
Date: Mon, 25 Mar 2024 13:31:16 +0000
Message-Id: <20240325133116.2075362-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The HSTR_EL2 register allows the hypervisor to trap AArch32 EL1 and
EL0 accesses to cp15 registers.  We incorrectly implemented this so
they trap to EL1 when we detect the need for a HSTR trap at code
generation time.  (The check in access_check_cp_reg() which we do at
runtime to catch traps from EL0 is correctly routing them to EL2.)

Use the correct target EL when generating the code to take the trap.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2226
Fixes: 049edada5e93df ("target/arm: Make HSTR_EL2 traps take priority over UNDEF-at-EL1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c8a24706750..69585e6003d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4585,7 +4585,7 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
             tcg_gen_andi_i32(t, t, 1u << maskbit);
             tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
 
-            gen_exception_insn(s, 0, EXCP_UDEF, syndrome);
+            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
             /*
              * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
              * but since we're conditionally branching over it, we want
-- 
2.34.1


