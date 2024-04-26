Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D36CC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 12:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Khg-0003Bz-T0; Fri, 26 Apr 2024 08:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khd-0003A2-Uq
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s0Khb-00064m-33
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 08:29:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41b79451145so6704185e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 05:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714134556; x=1714739356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N0nd37JbIqFWOk7TVvpZsBjDnU/+rTPYGOgPUq3SDrY=;
 b=AXqnKx4FbHeeJXfIuj3UCBTL1pLdXSthtg832dHJ9ggZerQCNOUDreXyKJEUulqhRg
 oecRk88yZNhLXtPdJ7vdjTgNsA4w1Rsxt5rtaT/OTgWJCTsIqP+TlsPQO/j3/KoOqrz5
 BHsct3d8bFj1vxYOxVjj02EZS94M3Jjkw6iKAcIEIZA9PJq1lZ4RZRendNhSX7XZ30qy
 REj9BZkzeQhkjgM4KJlCAuOf8mAcwYJDRteFgQBYoEaVjXSNuul2zc6P8SDUMCgIvDI6
 gg3efamYVpL5agODwePI6+r1rvOzucEg58cVlDpWUnk/T/AGX1xHikUl5iUmrQVgzQz/
 sgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714134556; x=1714739356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N0nd37JbIqFWOk7TVvpZsBjDnU/+rTPYGOgPUq3SDrY=;
 b=jBBRgQfYB98mFrFYmSpnoqdeRKTprhVd9bDdQUJw+KybMh2OPK50hPfEgms7MK+IDi
 kSPdolwkcagZ2LeoefPIhOZD02eOVNFgFb7QxxfnKsyitq5YgiW9SSiqPg5QQaZnUj7B
 9KqxAPLbOu5gbtAcmWIazlM70BCz1OyRkS8nxFT3Vb7CY1gk3Ke3alYxSOyztbJWxCda
 zJzoolocqZJWLp20DKd5n7eJxn1XTZEFVzO+YMPHAS4MnldTx16QaBg1/DWqy8+qXqw1
 nzcSDa6dHW26fN7cOb5CKL4dC7pct8jVWmVB7hqRDqaQtmp39G0V7pUYZs5Q57EUmBZy
 O17Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT0vGLBjFQhGm3wkyLuTvo1tzVKJPr7pRHyKiwMm1PU+J4lTADNumPX2obZtR3dg72GOpqGvSolEy1rNLzpnz5XGjWa7Y=
X-Gm-Message-State: AOJu0YytrmFTeU6Z4F+/rmpHKCReRAJkOAY8qBGae72iY0xint+XNIsW
 /8azTRRQZeVq2/thTwXw4Am5AwhTVdJPFPWmb5Kx1kmPlBUMkFEx8vy7wwXGnu8=
X-Google-Smtp-Source: AGHT+IG8SvxrQNIjmW4bPYl1czbbKbVwvl1QZZJle5Gy+D+sJo8gvacM9RYndo/t2J7f0GdTWFnMtA==
X-Received: by 2002:a05:600c:4e47:b0:41a:e995:b924 with SMTP id
 e7-20020a05600c4e4700b0041ae995b924mr1758805wmq.33.1714134556360; 
 Fri, 26 Apr 2024 05:29:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c460f00b0041a964b55ddsm1397134wmo.1.2024.04.26.05.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 05:29:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: [PATCH v2 2/4] hw/arm/sbsa-ref: Force CPU generic timer to 62.5MHz
Date: Fri, 26 Apr 2024 13:29:11 +0100
Message-Id: <20240426122913.3427983-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426122913.3427983-1-peter.maydell@linaro.org>
References: <20240426122913.3427983-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Currently QEMU CPUs always run with a generic timer counter frequency
of 62.5MHz, but ARMv8.6 CPUs will run at 1GHz.  For older versions of
the TF-A firmware that sbsa-ref runs, the frequency of the generic
timer is hardcoded into the firmware, and so if the CPU actually has
a different frequency then timers in the guest will be set
incorrectly.

The default frequency used by the 'max' CPU is about to change, so
make the sbsa-ref board force the CPU frequency to the value which
the firmware expects.

Newer versions of TF-A will read the frequency from the CPU's
CNTFRQ_EL0 register:
 https://github.com/ARM-software/arm-trusted-firmware/commit/4c77fac98dac0bebc63798aae9101ac865b87148
so in the longer term we could make this board use the 1GHz
frequency. We will need to make sure we update the binaries used
by our avocado test
 Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
before we can do that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I leave it up to the sbsa-ref maintainers exactly when they
want to shift to 1GHz (probably after a TF-A release with the fix?)
---
 hw/arm/sbsa-ref.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f5709d6c141..36f6f717b4b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -60,6 +60,19 @@
 #define NUM_SMMU_IRQS   4
 #define NUM_SATA_PORTS  6
 
+/*
+ * Generic timer frequency in Hz (which drives both the CPU generic timers
+ * and the SBSA watchdog-timer). Older versions of the TF-A firmware
+ * typically used with sbsa-ref (including the binaries in our Avocado test
+ * Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
+ * assume it is this value.
+ *
+ * TODO: this value is not architecturally correct for an Armv8.6 or
+ * better CPU, so we should move to 1GHz once the TF-A fix above has
+ * made it into a release and into our Avocado test.
+ */
+#define SBSA_GTIMER_HZ 62500000
+
 enum {
     SBSA_FLASH,
     SBSA_MEM,
@@ -767,6 +780,8 @@ static void sbsa_ref_init(MachineState *machine)
                                     &error_abort);
         }
 
+        object_property_set_int(cpuobj, "cntfrq", SBSA_GTIMER_HZ, &error_abort);
+
         object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
                                  &error_abort);
 
-- 
2.34.1


