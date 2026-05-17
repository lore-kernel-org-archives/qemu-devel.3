Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63532CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSh-0007kQ-QS; Sat, 16 May 2026 20:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS0-0006VL-1v
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:48 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPRx-0006na-EM
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:47 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so435920a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978024; x=1779582824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiL04P2CzHdch1eAb8Dy0QC+hd+UkcPVAZS3KCpqoms=;
 b=mE9H3bpk4nH3dsyKeDrx+sACsQEasWLzjX4u78FCc8J+ofDAks3mKv62+hmi79SoHv
 ibC1GujvXuIi2lljTuRKVYc/smMQY5qCIWzziTa7hF5gdmhpyKDyuxMyacZoXkG89ElP
 vnpJJNUHHYWO0hGRwgMsfKGW1Ghvy0bcdKwpWORxfN9C3T70gZX3mVCD7Dwubw4aElCq
 cuQK5nn5jPNCQNQH0xaC4KEUymqtQlM5WGFR1w/4H/bdJ8yIV3l61Iuo020WobjSEvHw
 MC9iPkXVdx8MTJGuVIt5XDD4Qsr+LXaBPlNvhPNzrgrPyiQGmuGV2ijB8BYyeclB6Z3m
 eAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978024; x=1779582824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiL04P2CzHdch1eAb8Dy0QC+hd+UkcPVAZS3KCpqoms=;
 b=GjIVYlfU8AHhkWikBJvQnkYlgzk/W9jC/VqNGKTksHgHkfCP/yP7uodnmmjD+cORu9
 Edl5Q9IS7CDVzLXTZ8m8LMixHTvMTlNnh+LHKjZK1DGm/sm8VXZrphLbraR3SWos1QJQ
 92DMltnlYbIIKRtjTKfUilfO3IkRCCNwCqFASbGlHY8zCTD5kllI9+esJ5+6CZID6tIv
 OtH4+SCw6bo9GL8b664JOK+idsFXrkW7IC9B3EVO7tFoN6PZmyDxPGraThvGLXZ0Qc65
 u1f5HvlKDyzURj4PWw0GZcDXiEUnTPYoLmEbaSJ0sZ0BdbqugsTdgTrO8eipTiWUa+ey
 vXpQ==
X-Gm-Message-State: AOJu0YwVfnYngMQ57ZboqMh6nWIufHmT3BKTWW3995kJnApPCpacQgS0
 zPSMZLQU+J9hFu3/h0ItocfZN/lWrVi4OvNCVbo6oUstFNkbMwEj+E74kjGmBBdT1tZ6Jt1gfrC
 kUOg8
X-Gm-Gg: Acq92OFdcZQ+CRZudU+50LtcHw9q4XEeQErNi/Wwj3L6Sq/UVg3ZchuZTdU6w6cXsXD
 cCcPHEI//ONUyDORRxq1I9I9rloM5uGjayxEYYOTH+Iw7xwndSrsYd4OvQi1BzcyPDDsLxvXlWS
 qdE4pHdFcieuN9BV1rAZQTF1+X7qtfOCGRamQkYp+GnVEqElJ3vdE4Xn+nBseGK1rh6+ZxdK+c+
 WsgSpLWWJ2WM49Azf5w6hE6kLMj9vUGoEJGykzoy8XLge/MK6/hu064O0s7T36o2pjZ3ioYzBKz
 9cBOFx1/jbAbY3IZpZoR1dTfdpOMi8i5yBwbrelSQjJE6rPTi35UBu14WKSsYz1rQDfKBgzpSih
 jOWarxz+kB+yKDw2q3K187wTCM8HmqKIu4c8/aGXZv+0XBW7WBJQrpHPggplvwq61n8i+WMg1Pl
 1jQeK4BTKFANqqHx4INNI2WRhuBUWE
X-Received: by 2002:a05:6a20:3d21:b0:3aa:f9cb:d43e with SMTP id
 adf61e73a8af0-3b22e72bda3mr10524353637.18.1778978024022; 
 Sat, 16 May 2026 17:33:44 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 44/63] target/arm: Enable FEAT_SME_LUTv2 for -cpu max
Date: Sat, 16 May 2026 17:29:43 -0700
Message-ID: <20260517003002.321430-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8d0c057902..90214a355a 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1388,6 +1388,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
     SET_IDREG(isar, ID_AA64SMFR0, t);
 
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index b6f0ca9351..0dd6b554a0 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -158,6 +158,7 @@ the following architecture extensions:
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
+- FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SVE (Scalable Vector Extension)
 - FEAT_SVE_AES (Scalable Vector AES instructions)
 - FEAT_SVE_B16B16 (Non-widening BFloat16 arithmetic for SVE2)
-- 
2.43.0


