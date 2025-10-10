Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B67CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqN-0007Hc-Sm; Fri, 10 Oct 2025 09:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cq5-0006ve-2p
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:19 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpG-0003wl-3M
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:16 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1333702f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101575; x=1760706375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tWYSJKZV/KW1c4fToUoxKrkpMIhLUZuK/qErLfRFHHc=;
 b=lFduxQ6bJKgFvaXtzNOr3dyixqcD53y/ipd5lvw8e4/XXvOXTTrfHTDTIKu7UBIyKT
 mxMh61hZwwQhxky1Jp2CXeuWiwtngS2fOb+sHBbMyfUyLLviOxz831IcqcYRXZZWiAUv
 HMjaom83ybSOlAzFL7Svbd9OMhbFbrsRcEFJeYZ1lqeg35qYHSKIo6WJQ0DMO23j4udj
 kObsqRYlUHlkS3n9y7Yh0Vw7HcwbowRR8tHfMCaig+R4OD66OZ4KSt7CRPdcqUYN/E/u
 LENoF5Aw7mTHrkfQ3LjQPULsMXeTiZY6SyzH1pjh42xFU/gTtDwr9gnIox8ep+FLqqQH
 DZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101575; x=1760706375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWYSJKZV/KW1c4fToUoxKrkpMIhLUZuK/qErLfRFHHc=;
 b=AuuQOymcbYGg1TGW+8ZfWaHMhtgFLG0OIxuEEBc7v4y1gfwVz+tSDZV3hajK3xyf0i
 zc+rw8KZCs5ZoFKiKySiTARsucwIYJSJXSmY/5lhGcAYzMJ/Dd+z025dkFJ+XnvI+MRd
 xFqP6VXxiKtnctadnr0KF9BKNl2qSPSOILewlqAqPpBT+9gxWQ3EfDQVVU48vWInJwot
 4Gz/g5qGwiKFS6LabQWC7TKpXj/0EXzPOADOrcI4TAByEeglL6khv2VqpVTBwwJ1dloT
 2+kF5kBz7sPdw+GKE0ea9hrFey8U50RxvHXhWqW6Lj0/36VWMYxSzw6L1tnejX4B/oeG
 VG7A==
X-Gm-Message-State: AOJu0YzW3gpN9mkDRT3nj5OUW+0pKTGbQsO0hOpGEiaT65keyofqLYD5
 37Qf1WQFu1W5a4ebGHIcCYmeLCV4F4oSXhTM6WsmA6JG5Brnb9/ttv+obGH44VJYqVlwdSwFM6w
 DvCtc
X-Gm-Gg: ASbGncs6gDVeVND4di7ps7h6HBdUjFg5R8eB6k+XJip2hdScYzZfRCzHK+h54kCpB9N
 aYw0SHAKVvug3vkG7WO3TB9MELQ5GZ2Eloqs131wv53XCmWglnX8SgIy/2BkZGZuaOi1FaKaaYu
 Rahft8Z0gbtrESrRLC6Kp5bykd70a39q9bNeOXyKv45gCyZrpZ7fsyIOTgCV2UcMDHNCetDxNyW
 i2oloZQZslMEu0vsWddCMQ1viRlGQ4GXDP1xOfIx5qCmtxBl/SuTffgbXtKMHaUtKfDmUxcKlxQ
 gjoweWv7TKUAxBD6CQLbYee3Taigpp0GozBrW+wmBP17F4WTgwX8Og3DalT9UZM2DR7i3wqCHfv
 zyhqHIyxwjV1V/nY1soHcDXiGZHpd+hZC21+u4pI5v3gZGiL39oWKs/zCKJDU/A==
X-Google-Smtp-Source: AGHT+IFs14Eu9rPXVgW7Rk78Ob6bQq6TOrqIq+4Y7kQrEk60gGvo6y5Bam5TINiZugrrInHXvte3xw==
X-Received: by 2002:a05:6000:615:b0:410:3a4f:12c5 with SMTP id
 ffacd0b85a97d-4266e8e6da0mr7613961f8f.60.1760101574928; 
 Fri, 10 Oct 2025 06:06:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/76] target/arm: Split out access_nv1_with_nvx
Date: Fri, 10 Oct 2025 14:04:51 +0100
Message-ID: <20251010130527.3921602-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-41-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2875f0ddd2e..5d40266d96b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3423,15 +3423,16 @@ static void mdcr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static CPAccessResult access_nv1_with_nvx(uint64_t hcr_nv)
+{
+    return hcr_nv == (HCR_NV | HCR_NV1) ? CP_ACCESS_TRAP_EL2 : CP_ACCESS_OK;
+}
+
 static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
     if (arm_current_el(env) == 1) {
-        uint64_t hcr_nv = arm_hcr_el2_nvx_eff(env);
-
-        if (hcr_nv == (HCR_NV | HCR_NV1)) {
-            return CP_ACCESS_TRAP_EL2;
-        }
+        return access_nv1_with_nvx(arm_hcr_el2_nvx_eff(env));
     }
     return CP_ACCESS_OK;
 }
-- 
2.43.0


