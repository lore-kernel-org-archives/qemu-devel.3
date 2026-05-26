Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F01CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmf-0000ez-2K; Tue, 26 May 2026 10:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmU-0008T8-TJ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmT-0001KR-D4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:18 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso6661974f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805756; x=1780410556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/htVi7EBPeCyHiWwBzi+o97F5mILVA770CYe2rqVw5I=;
 b=wgFBqvKbk3ghvP4sse+/eNhTz/mhpL6s+5lImM6NlYhh+C2GRSc9Ad82U25PcLqSYF
 DeL10QLxUTCyVu4ZCap6rN3Mq5AmiVZEcq5VsQ2ul10I0UVBNquRGUEu4QTLqLR43OpE
 IyOh4DcumlU3MztrOYM+I8vs8QeSw5f2XsrTDPNTD2NQ+Kfxv18iBkJQGLjQKDpaEH53
 GwmEVtwYGUworit3Bh4zRVdAHbBRsKIugL0Jvi4S242dWkNJgWiY3BdNeWGxFg6iFytN
 fjdunCuWt3REJt54hOo6q6tVeXCjAOxTDUc5cJIxfRE311H4PpafilJx9U9AWD3TaAg9
 5nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805756; x=1780410556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/htVi7EBPeCyHiWwBzi+o97F5mILVA770CYe2rqVw5I=;
 b=lNzzJD8vlpTtHKfdwJlVnQ202mI82Rnw9uAeZe/IyIw2tYIacqgfa7sxevJdttPbDC
 TeWkX5zkD0cNLUOSHzXeHVPnb5uwbQgccnaDDsn6p0DuxgtBgF653QpAN//YJphxy/gG
 ku8dJDHFRjqdQMbMJwxHBapamseB5VaYH8TRzejNnCBMlJsEC53wJUmMK/gLF0EtVn0+
 JBDoj0aa170TtX5INW7r050wtgah25yKPAks4RDYqSubVySVZlHF7r+Zz3dEHyMHT1ei
 qAlrOWWwjHT2xrnoof8B9e2cPPt9Jk8gKGFr7cA59dHECUeqU0b1s627RJ4TV+MRoxG2
 2Euw==
X-Gm-Message-State: AOJu0YxjUkAZFlGc5W5tLzAT6U7PIQ+8C4LIEZH2J8V/NCSWc0Qj7yFR
 7ef+FTKWQsiDBG3ifUMNEDe85X7kgB68n69XbfFBBvyS/zD/kKgs6kqJLo2sSRY61oJAkaQ+NSq
 74Rnw
X-Gm-Gg: Acq92OH+OUyf6i4KLy5uF35Zzzw9QLgB7lkQarEpPlocTETx3VkL6C3T80o7JOy45ar
 sAsXPGsMVfuPB8e3mLy0G1M2AYAQ/SKxW8p26Mf2Imzn2dclnSyLyQFSx0khOFCe7OgvCH6YBLx
 P9i49T8tiAbfvLUMjIm6pSsvPW+hsPN27pwkMGNebwOGovz/yuu+B0e52vIPu0/Ao/dpn4qa5pd
 lZmt6YfLnWC3dnKRlPRqyiy5pV03cyIyNoc5n7gnu+y5vE2nqUDTF84s8OdhdSgJe/5nCcSDfHH
 /gxL/F+qX4bgVy4At4XWzaL0Fdd2e5vM2l+hg/kst5yAF98VUzdx0aiOEBGoyQspKmqs07O5MOu
 An5qtXu+CUzTyXZ9N/3MQrts0qDyIXoriJVC9RithfuFFQJ3yzcfWqp3wUclHU1K4mZVzJEKmOM
 l9c/QHDAcwFI33hJcEQRLA3XVJd92FikmLL+dcs/uNpb8MuSTFhNX0MG6u3FS8GRNsR8j1FltDQ
 QBVSqVf6PsQcqg95z4cQEcBP//ao/ptvOpG9YhAHXlD8Dx6ppak
X-Received: by 2002:a5d:6f18:0:b0:449:acdb:3009 with SMTP id
 ffacd0b85a97d-45eb38a83bbmr32973430f8f.6.1779805756040; 
 Tue, 26 May 2026 07:29:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/54] target/arm/ptw: Flip sense of arm_cpu_get_phys_addr
 return value
Date: Tue, 26 May 2026 15:28:21 +0100
Message-ID: <20260526142850.2326589-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-13-peter.maydell@linaro.org
---
 target/arm/ptw.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6146367e23..8cfa22fb69 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3965,7 +3965,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
         result->attrs.debug = 1;
         result->lg_page_size = res.f.lg_page_size;
     }
-    return !ok;
+    return ok;
 }
 
 bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
@@ -3975,12 +3975,7 @@ bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
     CPUARMState *env = &cpu->env;
     ARMMMUIdx mmu_idx = arm_mmu_idx(env);
 
-    /*
-     * Note that this function returns true on translation success,
-     * but arm_cpu_get_phys_addr() and all the other get_phys_addr
-     * style functions in this file return true on failure.
-     */
-    if (!arm_cpu_get_phys_addr(env, addr, result, mmu_idx)) {
+    if (arm_cpu_get_phys_addr(env, addr, result, mmu_idx)) {
         return true;
     }
 
@@ -3992,10 +3987,10 @@ bool arm_cpu_translate_for_debug(CPUState *cs, vaddr addr,
     switch (mmu_idx) {
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
-        return !arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E10_0);
+        return arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E10_0);
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
-        return !arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E20_0);
+        return arm_cpu_get_phys_addr(env, addr, result, ARMMMUIdx_E20_0);
     default:
         /* translation failed */
         return false;
-- 
2.43.0


