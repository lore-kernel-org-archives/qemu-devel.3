Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFB8C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 11:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcNHX-00073A-UU; Mon, 27 Jan 2025 06:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcNH3-0006qp-C1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:27:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcNGy-0002ur-7t
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 06:27:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso28304355e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 03:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737977238; x=1738582038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5G4uQcdWEEYcrkDnKmN/Wnx0lr4v5vW4hQqGLNo2IKU=;
 b=chAV1WlaUJ81BnN9MCbWMgCxqk8+BXhMD6pDQyxjiCXbv/agH/M7p1HQ5BAjaieKac
 UFxilqC42gS3VkrPDJwad/YI7FKMYYhiYKRFEuBsAd0zAcejae55v28NUT4v2Ah+/moK
 4AVN1M/r1x7IW4mFxcOSO8IBH/YaBPW2SnJKE49nckWAiHq7vsWNnP9ZPOwgxmDHGgrO
 zhrPUUHqG241X8Z6h3UNQ5XbeWm4On/GjHE0A4qwE+zZO/noDh57uIJScDtdy73IhzKk
 GzoiMv3LYYaxzsfvVoEk09Nk8qQaIuCfUrE8OH/RrlAh1N7sqp1I6LZKkodcnQqk390g
 DX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737977238; x=1738582038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5G4uQcdWEEYcrkDnKmN/Wnx0lr4v5vW4hQqGLNo2IKU=;
 b=ba8MmpLIyHR6En3qm5UGUwkSbsW9R8xQbUFo9JXVAa7BrJfP1qsdnrlhdV3mRlfGOj
 rEB5WruVZ8Lf8OI2yGsBMi/q5XUOpnMRYiKEGz+WumK7DZvDQhEJUqLcnf1Pre3ezkCv
 rqo1pEvoHYta4BHGR+IJ5reLiOqO8kzyFBU4NP7lHh8SWhvR+F4xF7eCgAQKv7yakJOB
 bbyNoCyNtYAs7bapQAU0IjHqFnRHncG0IEHwYnI5gU3Syg7yPpUyFfP+olCPMP5Vl5Zb
 /A+03L1HOCpVGQgrBS92M5MVtmtgNMsrXxRROSboqSlyQQNc8FTYzuWUufkuTxGdo/TL
 mTig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuEMys2mYNVD1QZAQZrvOOKGK0kMa2NlY4iSl5H9OaFUdebh/5Mp7kKIXT3yKqc00Jna+CvOM3y9Ny@nongnu.org
X-Gm-Message-State: AOJu0YxL0dWKRQ0FhDOZMrjPPUE/4USxDJ/x8hVOmIf3MZ2ituRWVGcq
 eyaSSnHIrdBXs4Anxn8Jqq03iGEIHISSoge4kFEa+O5Xt3OFkUkVwNbZjKKjK74=
X-Gm-Gg: ASbGncsnq9lwaxcHg0qhj+PnM0k9RafmrBLKegLXTuZqhMQggEqvzC73+UMhc7nXQC2
 KA6syX6cLIlXxF6ADDEGfO2ioQ2Ptp4w/9hUs6likKgEFkjpt6/wefBVFnDW6hWz9WiMp14g2gR
 CotSkweTIf80S66qpt2YErbJdgVna/f4rgwb2ohxLhdCghhAdHUHxbc5TwBi9gToK778hmjae7x
 oHtgwUhJM6P+GPEnDQhOQYAcfWOijbocYmEbil3u4MO0R64F/ijTcLFku9gyAszbZIsuApGWAhi
 MmeXFb+OJA==
X-Google-Smtp-Source: AGHT+IFS5qvE5400iYt8aAuVvZh7h5/kbFszigU/fBrdiBGEIHN8RXMtn2inPKA3g9KNd0dZFx0Ufg==
X-Received: by 2002:a05:6000:1a8c:b0:38a:888c:6786 with SMTP id
 ffacd0b85a97d-38bf57c063fmr36670530f8f.52.1737977238492; 
 Mon, 27 Jan 2025 03:27:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176449sm10925329f8f.11.2025.01.27.03.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 03:27:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/arm: deprecate the pxa2xx CPUs and iwMMXt emulation
Date: Mon, 27 Jan 2025 11:27:14 +0000
Message-Id: <20250127112715.2936555-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127112715.2936555-1-peter.maydell@linaro.org>
References: <20250127112715.2936555-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The pxa2xx CPUs are now only useful with user-mode emulation, because
we dropped all the machine types that used them in 9.2.  (Technically
you could alse use "-cpu pxa270" with a board model like versatilepb
which doesn't sanity-check the CPU type, but that has never been a
supported config.)

To use them (or iwMMXt emulation) with QEMU user-mode you would need
to explicitly select them with the -cpu option or the QEMU_CPU
environment variable.  A google search finds no examples of anybody
doing this in the last decade; I don't believe the GCC folks are
using QEMU to test their iwMMXt codegen either.  In fact, GCC is in
the process of dropping support for iwMMXT entirely.

The iwMMXt emulation is thousands of lines of code in QEMU, and
is now the only bit of Arm insn decode which doesn't use decodetree.
We have no way to test or validate changes to it. This code is
just dead weight that is almost certainly not being used by anybody.
Mark it as deprecated.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/about/deprecated.rst | 21 +++++++++++++++++++++
 target/arm/cpu.h          |  1 +
 target/arm/cpu.c          |  3 +++
 target/arm/tcg/cpu32.c    | 36 ++++++++++++++++++++++++------------
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962a..29de49351d1 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,27 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+linux-user mode CPUs
+--------------------
+
+iwMMXt emulation and the ``pxa`` CPUs (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``pxa`` CPU family (``pxa250``, ``pxa255``, ``pxa260``,
+``pxa261``, ``pxa262``, ``pxa270-a0``, ``pxa270-a1``, ``pxa270``,
+``pxa270-b0``, ``pxa270-b1``, ``pxa270-c0``, ``pxa270-c5``) are no
+longer used in system emulation, because all the machine types which
+used these CPUs were removed in the QEMU 9.2 release. These CPUs can
+now only be used in linux-user mode, and to do that you would have to
+explicitly select one of these CPUs with the ``-cpu`` command line
+option or the ``QEMU_CPU`` environment variable.
+
+We don't believe that anybody is using the iwMMXt emulation, and we do
+not have any tests to validate it or any real hardware or similar
+known-good implementation to test against. GCC is in the process of
+dropping their support for iwMMXt codegen. These CPU types are
+therefore deprecated in QEMU, and will be removed in a future release.
+
 System emulator CPUs
 --------------------
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9a6e8e589cc..71df9d3a0c4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1114,6 +1114,7 @@ struct ArchCPU {
 
 typedef struct ARMCPUInfo {
     const char *name;
+    const char *deprecation_note;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, void *data);
 } ARMCPUInfo;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc0231233a6..8a0e3d12f3f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2756,6 +2756,9 @@ static void cpu_register_class_init(ObjectClass *oc, void *data)
 
     acc->info = data;
     cc->gdb_core_xml_file = "arm-core.xml";
+    if (acc->info->deprecation_note) {
+        cc->deprecation_note = acc->info->deprecation_note;
+    }
 }
 
 void arm_cpu_register(const ARMCPUInfo *info)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 2ad21825255..0f1c5bc87e8 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -1026,19 +1026,31 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
     { .name = "ti925t",      .initfn = ti925t_initfn },
     { .name = "sa1100",      .initfn = sa1100_initfn },
     { .name = "sa1110",      .initfn = sa1110_initfn },
-    { .name = "pxa250",      .initfn = pxa250_initfn },
-    { .name = "pxa255",      .initfn = pxa255_initfn },
-    { .name = "pxa260",      .initfn = pxa260_initfn },
-    { .name = "pxa261",      .initfn = pxa261_initfn },
-    { .name = "pxa262",      .initfn = pxa262_initfn },
+    { .name = "pxa250",      .initfn = pxa250_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa255",      .initfn = pxa255_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa260",      .initfn = pxa260_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa261",      .initfn = pxa261_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa262",      .initfn = pxa262_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
     /* "pxa270" is an alias for "pxa270-a0" */
-    { .name = "pxa270",      .initfn = pxa270a0_initfn },
-    { .name = "pxa270-a0",   .initfn = pxa270a0_initfn },
-    { .name = "pxa270-a1",   .initfn = pxa270a1_initfn },
-    { .name = "pxa270-b0",   .initfn = pxa270b0_initfn },
-    { .name = "pxa270-b1",   .initfn = pxa270b1_initfn },
-    { .name = "pxa270-c0",   .initfn = pxa270c0_initfn },
-    { .name = "pxa270-c5",   .initfn = pxa270c5_initfn },
+    { .name = "pxa270",      .initfn = pxa270a0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-a0",   .initfn = pxa270a0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-a1",   .initfn = pxa270a1_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-b0",   .initfn = pxa270b0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-b1",   .initfn = pxa270b1_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-c0",   .initfn = pxa270c0_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
+    { .name = "pxa270-c5",   .initfn = pxa270c5_initfn,
+      .deprecation_note = "iwMMXt CPUs are no longer supported", },
 #ifndef TARGET_AARCH64
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
-- 
2.34.1


