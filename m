Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EBC0FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLR2-0003CC-QO; Mon, 27 Apr 2026 08:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO4-0008BH-On
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:35 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNw-0005jE-IV
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so68793535e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294101; x=1777898901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VsXVphtTzSqGkb8cuK6ICBOoamz39qRjTqSYcGiqm6A=;
 b=SYG5U5k4pY9wGpZmn6x6ZXvJzx8coEVFEt5yGogMPUv7LVXzL1jO89usvNj1nyRA3P
 fYaE/VgtkjQqbeU6c0v2Ns3HaVlKZgMa0po/gS24KE//GYXNilwrKMiqaLnRVPWfwm/f
 zSNe1g7zGX5/ZFV4kPzpZh/TNYntbIjw0ZCHJl+yTyk04/HetmOBkPV35B31vkHuGco/
 ezRBQwkr9AdeFEobDVACPFki1dpMUg1/yU2xU0ZWEnQQEDceAF10wFDQPfDVrYgoyf1f
 TEZvCD52S39ZIr7RzAyNrpHYVaD4yUQDpo/V8ddku1JNa9zbl21SK48VoBMQfH5BrcS7
 wScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294101; x=1777898901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VsXVphtTzSqGkb8cuK6ICBOoamz39qRjTqSYcGiqm6A=;
 b=e0woX6HSMwm8fAl4l1T9+zpBmLTDjEv83j9ogECeyPnr+5S4evHAL2vAlyfXKEYj6y
 OHCD5lx0AP9bB2fM86VoWhOa2kRMBJfqVtLD0EC8V6qVL+1vkEYAZDPKeA4W9+1FsZBx
 whm8gg7FIYWUFNE6B9VReLbg++qGYcOJyH2WCTPpvYzKv97NFmIY4x5BTeLjdJOeGNmZ
 iDO5dEK7JVRjDI/wyRPqQNBq6lP/KtBjtrgg65NB8+8j8Su0OdF7QKFEMgm5iLDL7eST
 a0rk7G7l/QBNSuA0m/8wHYE2B9sb/kQOr0tfDUUP01cVwLHKdbmjWsZ608oLpjhhiI07
 XDWg==
X-Gm-Message-State: AOJu0YwMqdRZmfP7tXe/T14eV56lvEf+2z+cIDXanOCUvrbVBED+Ecv7
 2qdytX29PrrcrjwPJGpNw2gv71Kd8uPqDtjwHdyinR4YFqMLg6Sy/iVPMdYBQ/rpsLic2v1ntLZ
 G9m2c
X-Gm-Gg: AeBDietKVlVFnfuYf1zaNDe3aEF07/xKpzucI1x19dd674SARqQrDgljRZl9GH/aYtM
 9S58dq4YixgAvc8pL4IzL6+gHywUlbCb40sfF4XZl3FHg4JV1Qu2z1I35uqL81KsfMa2/l69oa6
 jk2FwRlYHn443qN6xc85xadXf2ui8Ie9xMMHtgPUQ3W10rBvAJh9wYvuiHEEFF52pzVhMxn3H7V
 +zLOONm7kDGMapI3JMSxB71kdjqOhJSLXa3vjB9dZ2VsLSb8WaehAFGCasbxskL/WOfCJ0pHlHr
 YOdxmycekG7hT4l0zUHw4m4GTF+7qdPhxqDirM8zcTyf9c0IQDmw4EPWDVjyHB3lp8uz3Qjf2t1
 bSD6618cvjkuHys2ftk81rZxy6B1j4MjQj5GZv2k94i/pR9sCwqROHJr5I8SKDZYb/yVsGcadXA
 Nbngt1FcigdSAp5T9UlZSZDhjHJEsDVYUI6FhqMB+uQKYouWuQGY2ui4t0nNThlBgMBnislJbCf
 ec7CCVNkRnve1JhdgD8xVGBhxPlNVg/Pcr5emfl2A==
X-Received: by 2002:a05:600c:8b84:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-488fb76e4aamr663834355e9.17.1777294101056; 
 Mon, 27 Apr 2026 05:48:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/63] target/arm: migrate SME trap syndromes to registerfields
Date: Mon, 27 Apr 2026 13:47:19 +0100
Message-ID: <20260427124738.966578-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-6-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 63c8e66ea9..6105347598 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
     return res;
 }
 
+/*
+ * ISS encoding for an exception due to SME functionality
+ */
+FIELD(SME_ISS, SMTC, 0, 2)
+
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 {
-    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL) | etype;
+    uint32_t res = syn_set_ec(0, EC_SMETRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
+
+    return res;
 }
 
 static inline uint32_t syn_pacfail(bool data, int keynumber)
-- 
2.43.0


