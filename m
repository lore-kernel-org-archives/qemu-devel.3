Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5900EC9831E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 07:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAMVq-0001Pr-Fx; Sat, 26 Sep 2026 03:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRb-0005Fe-Rw
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:45 -0400
Received: from mail-dy2-x0e.google.com ([2607:f8b0:4864:36::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xAMRZ-0000e4-AY
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 03:03:34 -0400
Received: by mail-dy2-x0e.google.com with SMTP id
 5a478bee46e88-3413069aa25so879270eec.0
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790406212; x=1791011012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rzW6PsmtOZwl+8GHz3e9WkPlmisOxZZN4sxAfBryYXI=;
 b=N9+U7WXcfYt2f/7Prz0O4CuygOC11I8l7ffunvkpL6OahOCQ1hUy7qwWIG8Er79URp
 khi/KiuNvCsL0Jh2g74FF+bHMQBBMrAkAJwZLNa3Y6PCGFaU5J/VJH+YhXlwbpz/Z6Yd
 yLhgnfUnzeKIfhsXozfkPloFpCgbdRt53FS3VACyLNg6eXIqSfiuKgRbyZ8ySi2qoDtA
 BpXczyoBbASRK7VylSCHqk5+/RFoqLzjHv44sZh2yLOAzlO5zHCnwzRKqUvJcFzkOLCu
 xZnxJBEsKiGacOCPVRPMS+ALdJVuue7DMEcEg3Dnl1UcoLqYrs8gft6Zrra24BDyqSip
 Gy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790406212; x=1791011012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rzW6PsmtOZwl+8GHz3e9WkPlmisOxZZN4sxAfBryYXI=;
 b=zykeMvWrmwAVStfLKxGetWAtWDivLGH7S16MWz4mXFtaVFRON26w3GOk5PEJs8P386
 AWDWfaWjEn4C9yH/iX1OjxYDkG2MPVfEZsITkWvEgBQ9DL2rgWNG3nyrxzZm1JIsjtQB
 Id8dY79FXPnK8tHP+mqcqY9LJ57gfJrVC5VbXyJmhC0sC0FW3zxDmz4JK7zUIgbDbwB4
 EPS0KtxGRnSh5emMRZJLPPPHwFCg42a5KKOxRuS48aBtF7o16aouGWUin0MsUaXrAHso
 iSPeMKKq3pt3phUdt/NqBss7qML4JMsZwWfxefp0PXo2YpSsFPVcpe0DkKPqGLrWGLiC
 u5vw==
X-Gm-Message-State: AFuF++lo4yCMl1cUdmRA5DXEH0O8NQfndJ6GJeyxRRHRD4fL7N+CrWtQ
 JuNYHqx0YlNxE+Y9yx6SrisEBMJjSTeFIbcsMWJr73KH9AFR6r417ru96tdduc9i
X-Gm-Gg: AYBFou3seXmxGFuHR/sJ1M/qfC7U/9NldDp20jj6uPTNbHVwuAqV7j++TSUoW4cjx6L
 uNCbHLvrz90gJrwgPhP76mlnibI57xoXnmepYIOWDiw90dzoXQSc3Q54IH3YbnC4YfLZQwJ8xkK
 wuDCaArYm59xLGOMgfLsBAoikH23Whu3tauhSw7SRpfFFWcAgAJqMlzPwY20vmAdfbHHVN1Mr0y
 yGIfocfHJ7PvRWpv2YDvC7JoIv5i0its5dLpM1m+FW7r5Mil0FQ33bKlGECUcppxd9R8jzMM/+7
 dsVAFTwdtYC8U4U7Tc4sAy8RqsSbMfqwuHqmmwC74wIgEG9nreIlGfFnt9lnT4OAq4lE8sTGYNO
 yKEEb4UCU19h5AXzCkhT4WgrRAEzuDJfBQFiDdrEVD2HjPnT9tcAzm7B8UsIsgrXAPPZCsUz2xW
 MXEDyHUxnZtIrh613sEaZBFilk8XuEo6kZeGNEeyLocnjntopChdUGpp9ZxtgHNHRnFm/G+gtCK
 egODUpNSKW1dR9yKOYrrhgqPhGFWhw5
X-Received: by 2002:a05:7300:cacb:b0:33e:a0c3:4176 with SMTP id
 5a478bee46e88-342738466b6mr1902861eec.27.1790406211560; 
 Sat, 26 Sep 2026 00:03:31 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:03:30 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v4 37/55] accel/tcg: keep cpu-ldst endian aliases per-target
Date: Sat, 26 Sep 2026 15:00:36 +0800
Message-ID: <20260926070057.1234-38-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:36::e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wrap the TARGET_BIG_ENDIAN cpu_ld*_data aliases in
COMPILING_PER_TARGET so common code can include cpu-ldst.h.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/accel/tcg/cpu-ldst.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 1facabccb23..e3082db53e5 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -1,5 +1,5 @@
 /*
- *  Software MMU support (per-target)
+ *  Software MMU support
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -423,6 +423,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifdef COMPILING_PER_TARGET
 #ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
@@ -470,5 +471,6 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 #endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
+#endif /* COMPILING_PER_TARGET */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0.windows.1


