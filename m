Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FF1FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQz-0002sh-OP; Mon, 27 Apr 2026 08:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNy-00087g-WC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:31 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNr-0005hI-Up
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so134257745e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294094; x=1777898894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EoqVhLGhx4yCMUlMBNquuLKcWQ2+z8TbZ+uuLLh8Iag=;
 b=XhAaqXETDXRjknmsL3MLmjQIjjxvkxuRQBNdylLUXbZ02VhMsLl39zDbmn3OQNNf1N
 Q0wHSO0zYrmq7+eskWLNekeEmYtF8n0LLa3vQIJEM2DNcVeRjSmT3h6y+sTLQrAO2vTz
 zh7DB277WTjV5lKdOGatJ7hc729P1Kps7GCWKloeeFw5rZDtOu2NGy6CCE17ESBwSBFQ
 hB+4csreLLgLe3mNiXx3vIDqiUaAeTH8bxz92LNq28SvJOr0UAVBNFxmjvGnGOZj1hov
 YTbN6Ok2FpQwMNByms7EK7Im7OHhiWmA8m5UttrMv1W0sjRvMBzZrJ0+khRjfefs3zPh
 h+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294094; x=1777898894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EoqVhLGhx4yCMUlMBNquuLKcWQ2+z8TbZ+uuLLh8Iag=;
 b=Xyu70JGigjEK2W+QCMR3kSpXA8hjpvthoEhz7z6JRjXlA4HTiNUk9T/Ze1E3cb4+Mn
 t/Xw7rdO2eEv6/g4mNzwwesfK59saVIZ5l6MUAqQokMjGxKsXY8YT0xYVRRw/e2Ggm0/
 9vxE8x2cIbURnQd8bbzdbrx4IZiG4xdvc4l/mnN8e+rKHqiWXkp9W50i7gF0GnB89Gl9
 JaVX/rC8pjhwoujXiZpD6i0ucyZqry+6cNhyy94/FG5+j8E6RHuyJPghS0vjCWr886cq
 p9h7o5zxOtQiru7mOpxG9S9V+NQ7TfZXejA6vU2vlY3B4PpmsyRVS6CUaxqNyp1Dj0eM
 p1+Q==
X-Gm-Message-State: AOJu0Yw2aC6omu0LY6IzNlt1UVFwMSzZ20E0cqOOvJJYO2u29LkPE8qE
 8uD1DyA8tXOmngyJ0WwwI+wcxcs5EEb4Hj/YHXTXI5+0DkMgVF645NR0idV9J2lKPO5ArMyIEVe
 hvXTS
X-Gm-Gg: AeBDiesWswc7kTXI8DnrYgTsZgyIoLQG/M2DZhwB4TBc/obQk22BekFcficAiPOevT+
 2Zl5/QEr9yhhy1xqFjYXSbuos48GtuH2zhGejubFWF3N9eQ4OYSqJ4R6+AkiS8eZOLi+npToVq/
 WINEzrjzY2/UQC4BYhBLjdeF3et6UHys3TwpHMYKBn5TrtDwoUu8q/voxZN6Ld7g9CIPJAmZR9H
 5Q60aOOlvMU8+3orJA6P9dhbbnJaTDkmtMgyd/OJO8B0IAM3qdKDDckoylS5IHwLeoFQsbUF4ei
 T2eCS9aOcAZIqZUlOx1tJUVhaz3b3toFkeIhr69++bT/WQc2QeGtGXYv8WLeiPotFhu4pCEVbx8
 BV8FGdseWk171ZeTtTykTswxiuftoqTxgnMSDpmx7mIW4pbqAund49IlrPAbKXRVwcOiCNTCnOg
 PaALWwr5Wz09gC6aB02K8pUvKGhJzZ/bGs9sU6xK8aaZRq5Sg/8f+ha0rXXjyxnDevn25ECJ+ur
 0kA6gFqTqaYHVZmJmgDwMy3CCpPgIzZdlEETDpKMw==
X-Received: by 2002:a05:600c:190f:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48a6315da72mr207675615e9.26.1777294094151; 
 Mon, 27 Apr 2026 05:48:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/63] Revert "target/arm: Reinstate bogus AArch32 DBGDTRTX
 register for migration compat"
Date: Mon, 27 Apr 2026 13:47:11 +0100
Message-ID: <20260427124738.966578-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Eric Auger <eric.auger@redhat.com>

This reverts commit 4f2b82f60431 ("target/arm: Reinstate bogus AArch32
DBGDTRTX register for migration compat). We don't need that commit
anymore as the AArch32 DBGDTRTX register is declared to
be safe to ignore in the incoming migration stream.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260420140552.104369-8-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 352c8e5c8e..8477ca5def 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -171,13 +171,6 @@ static void dbgclaimclr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     env->cp15.dbgclaim &= ~(value & 0xFF);
 }
 
-static CPAccessResult access_bogus(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   bool isread)
-{
-    /* Always UNDEF, as if this cpreg didn't exist */
-    return CP_ACCESS_UNDEFINED;
-}
-
 static const ARMCPRegInfo debug_cp_reginfo[] = {
     /*
      * DBGDRAR, DBGDSAR: always RAZ since we don't implement memory mapped
@@ -240,28 +233,6 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 4, .opc2 = 0,
       .access = PL0_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-    /*
-     * This is not a real AArch32 register. We used to incorrectly expose
-     * this due to a QEMU bug; to avoid breaking migration compatibility we
-     * need to continue to provide it so that we don't fail the inbound
-     * migration when it tells us about a sysreg that we don't have.
-     * We set an always-fails .accessfn, which means that the guest doesn't
-     * actually see this register (it will always UNDEF, identically to if
-     * there were no cpreg definition for it other than that we won't print
-     * a LOG_UNIMP message about it), and we set the ARM_CP_NO_GDB flag so the
-     * gdbstub won't see it either.
-     * (We can't just set .access = 0, because add_cpreg_to_hashtable()
-     * helpfully ignores cpregs which aren't accessible to the highest
-     * implemented EL.)
-     *
-     * TODO: implement a system for being able to describe "this register
-     * can be ignored if it appears in the inbound stream"; then we can
-     * remove this temporary hack.
-     */
-    { .name = "BOGUS_DBGDTR_EL0", .state = ARM_CP_STATE_AA32,
-      .cp = 14, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
-      .access = PL0_RW, .accessfn = access_bogus,
-      .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.43.0


