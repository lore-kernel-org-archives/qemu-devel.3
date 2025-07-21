Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0801C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYu-0007lp-If; Mon, 21 Jul 2025 09:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYO-00017M-Vm
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYM-0005Lo-Tk
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:40 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so3302567f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104457; x=1753709257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S8k9vbZWrI9+KrHmalDtLLG34nLTiZteSToHN3jBdkY=;
 b=cPLhqzBb+KJeTGxhEdhlyDPgIeLerrNOwQl+2KNJSGBEmmXiSB1tgNrlh9Jl+eGOQz
 LAVXvf8mu1rmF4HWSftc2M+p3QZg2dVzjlDelBCWGc8EIRe2qfalYwDL+kXGu4c+fvx1
 JjxLWRoAmpSs5bGRwgZrOHcojZxGkRhCntdDgMrLxlYmDzlGkfZAwK3rncm3D2pDCQyr
 Yzg9sp+YLYbPHossW967DappDqMt7hN8vGR7+GppuqZ1fMXIAHmtG4UDNN6AEpiM6+Fd
 rH8cztny6FSgXUgomt6eWBK2c1+CBnhLnV234rciJUIpavtiK6iaSsqy5GHhnY7LQYNH
 Dutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104457; x=1753709257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8k9vbZWrI9+KrHmalDtLLG34nLTiZteSToHN3jBdkY=;
 b=WlP2DBUQ9dHrwLHczO5R6zg/mDHmDp/8qE3WqYVF9Jo8CukpS1usYhv4s4e0tjCadT
 YUzJi9LK9Sie3PNhSKiL9CHuXE/z8se9DlPmpZ5h3fXmGG/WplNi8vALyNsq0WfofKVv
 RJCERnocT+uBHW9VOMmIZ6JVaR9zWGr5CpKXBNuTUUd1xGE4o/UE479ZsNNBZl3orwCI
 cqy82f4G7VaJd1ArwbgeOUVz63dlMIOP7WcajSx/IQ/EvvYy1ecYyg5bq3IoiZLI27Vb
 6BcSD/QGwUIKDbCcB2ppzTJqeBgB0rC8lJE/FrMiLqBRMvDweeQp86LbGlYEcq23Guri
 vJ8g==
X-Gm-Message-State: AOJu0Yy4b1emI+ZaL7nYMWB3L8tMG9W7cYkQ7IJ2ub8T08sL4bZ637XO
 atssgFRyOyi9pRprkWsOUHXxRtwmI4CStkvKTWWHx64h76bVeqHXbzdjH6JZ5DDW0GiYP/TqXH0
 uPFtn
X-Gm-Gg: ASbGncs7Pt+IJk4lmB4Ih8k4tYy227sBdVdtJ92eL5tuSDaUKzQZzP/SBpxFpJURcwj
 BNAbXFTL4ErappybLn3JRLy0hRscvk1WEEU/Hkybcbz0daNlV93Q0QTvpu/k90KFuae+hJUbfMe
 bJHPX4vTJTu0uL1gr7BHl53hEGj6ch4jVHVrvmGZ3RjAWkBZmxp40movQ++BK1QmtCuNwRCzeLM
 N31QxL0iiMaL3rt0NR+JvJR5AGSOtJTobyOOJNGKwbAe+FvK7vej36uLGcYy4fcx2QBap/6RJcB
 fCSsmvbpw17SZB2fCmbgMQI59eWW5AXqBuc4CspyQmoQFOG88jx1FsHxSA1mGzOAln+lQjRA5t9
 f5Lg26BsJ9pAM2TrPNgjuNNjI1pgq
X-Google-Smtp-Source: AGHT+IEsIYeG3WXdBV7MFXMNhPXH3ATgF1KI5Zxg8d46STSHuIH/BehK5Y90kFQWCSsgkMrfB4ubGA==
X-Received: by 2002:a5d:588f:0:b0:3a4:e7d3:bd9c with SMTP id
 ffacd0b85a97d-3b60e4c9102mr14727419f8f.17.1753104457024; 
 Mon, 21 Jul 2025 06:27:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] hvf: arm: Add permission check in GIC sysreg handlers
Date: Mon, 21 Jul 2025 14:27:15 +0100
Message-ID: <20250721132718.2835729-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Zenghui Yu <zenghui.yu@linux.dev>

Quoting Peter Maydell:

" hvf_sysreg_read_cp() and hvf_sysreg_write_cp() do not check the .access
  field of the ARMCPRegInfo to ensure that they forbid writes to registers
  that are marked with a .access field that says they're read-only (and
  ditto reads to write-only registers). "

Before we add more registers in GIC sysreg handlers, let's get it correct
by adding the .access checks to hvf_sysreg_read_cp() and
hvf_sysreg_write_cp(). With that, a sysreg access with invalid permission
will result in an UNDEFINED exception.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Message-id: 20250714160139.10404-2-zenghui.yu@linux.dev
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8f93e42b34b..861657df966 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1263,6 +1263,9 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
 
     ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
     if (ri) {
+        if (!cp_access_ok(1, ri, true)) {
+            return false;
+        }
         if (ri->accessfn) {
             if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
                 return false;
@@ -1543,6 +1546,9 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
     ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
 
     if (ri) {
+        if (!cp_access_ok(1, ri, false)) {
+            return false;
+        }
         if (ri->accessfn) {
             if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
                 return false;
-- 
2.43.0


