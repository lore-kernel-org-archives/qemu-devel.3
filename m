Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51166C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Lf-0000gQ-0d; Sat, 09 Mar 2024 14:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KJ-0007NN-Gk
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:54 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2KF-0003Mf-Jb
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:25:45 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso3383410a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012339; x=1710617139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4izzVDpY+AQ8hh1OPoQkok5+Cmay4u8VvPo/ani8Qjo=;
 b=N/fn7alnSp9IdsX0dSZWScKpNNh+gwvaIuz+GllWqNE40p3+nUzNYUMqxxGqLDsBkW
 SY4L09EcM/AswTVjPfQlsbDbkgs3tq4fTnR+qjD6Sk2Qhm0okiO2PfRYbxmOxEPItX2V
 X9zNZZu6Fro9VLEaELA14czQ8KPOunIX+7N2/XDxFUYwAwCV0Pg3zW3o8a6s5bJ+/Xzf
 vMAqCm2IhnAF66GvjFAWhbxddPopXFaDbcRKHOngPoBWfjXlEHwesucX+Tfvl2prRX0z
 JMBZovSm9AWUzezluT4LMTjGIJ+O0Z+nLtvnLFwVIJ6K4XR+XP7+UiyBD6udqWwi9Ywi
 9lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012339; x=1710617139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4izzVDpY+AQ8hh1OPoQkok5+Cmay4u8VvPo/ani8Qjo=;
 b=n0wmNcK4Jvl0XcjqN0fl20z3FjeN6tyhvhpkLBqOjYLV8eVyySO3HB1jO1rfw2J0vs
 iviTq6atbEHhYJ90tEPogepAaS/bEki/7IqZyQ/r3cBLbitE5nwniWoLXxzQSoD5XrZx
 ckWrXIj7+diqNPti0tMidvyq03+bHiTbeCqYIPIFj/xEFVhXCltQuQAM6KxXVFrODpPd
 T9M5zM89r3HyHSl7XGEGNCH/6SAyDtb+FgT7UtGlCZu0cyAONmi6QbgH9Yzk58umn039
 JEa0i42pSjWLTw1hax9j9/7UHP8ZxRuoYp9zrfYWpHvMXbW1zaxrU9gMFCTLvR6M7Gvk
 /ZoQ==
X-Gm-Message-State: AOJu0YxgZgDXxnRPBwazW/HX6U9OCBpz5F/Nk+U6BOM1j01UYzczfC4c
 3OTZkvSfq+mBbUSV5HbUZXM3d5MLGw7VcnBCwxlOly9WXd5qmKMhUpMfxNZgBMc7f6QWj0G3YFQ
 g
X-Google-Smtp-Source: AGHT+IHYQn/wV3sAEi0VFsI5hwT2XA7fxKADL4Tdvyqkbq1LXxwkEtcQ4rc7snCEpBUGrqzK3CV7Sw==
X-Received: by 2002:a50:cd45:0:b0:568:2578:f520 with SMTP id
 d5-20020a50cd45000000b005682578f520mr1778835edj.35.1710012339700; 
 Sat, 09 Mar 2024 11:25:39 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 n1-20020aa7c441000000b0056452477a5esm1183979edr.24.2024.03.09.11.25.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:25:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Xiaoling Song <xiaoling.song@intel.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 34/43] tests/unit/test-smp-parse: Use CPU number macros in
 invalid topology case
Date: Sat,  9 Mar 2024 20:22:01 +0100
Message-ID: <20240309192213.23420-35-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Use MAX_CPUS/MIN_CPUS macros in invalid topology case. This gives us the
flexibility to change the maximum and minimum CPU limits.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240308160148.3130837-6-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-smp-parse.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 1874bea086..84e3422774 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -323,15 +323,21 @@ static const struct SMPTestData data_generic_invalid[] = {
                         "sockets (2) * cores (4) * threads (2) "
                         "== maxcpus (16) < smp_cpus (18)",
     }, {
-        /* config: -smp 1
-         * should tweak the supported min CPUs to 2 for testing */
-        .config = SMP_CONFIG_GENERIC(T, 1, F, 0, F, 0, F, 0, F, 0),
+        /*
+         * config: -smp 1
+         * The test machine should tweak the supported min CPUs to
+         * 2 (MIN_CPUS + 1) for testing.
+         */
+        .config = SMP_CONFIG_GENERIC(T, MIN_CPUS, F, 0, F, 0, F, 0, F, 0),
         .expect_error = "Invalid SMP CPUs 1. The min CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 2",
     }, {
-        /* config: -smp 512
-         * should tweak the supported max CPUs to 511 for testing */
-        .config = SMP_CONFIG_GENERIC(T, 512, F, 0, F, 0, F, 0, F, 0),
+        /*
+         * config: -smp 512
+         * The test machine should tweak the supported max CPUs to
+         * 511 (MAX_CPUS - 1) for testing.
+         */
+        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
         .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 511",
     },
@@ -575,8 +581,8 @@ static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     /* Force invalid min CPUs and max CPUs */
-    mc->min_cpus = 2;
-    mc->max_cpus = 511;
+    mc->min_cpus = MIN_CPUS + 1;
+    mc->max_cpus = MAX_CPUS - 1;
 }
 
 static void machine_with_dies_class_init(ObjectClass *oc, void *data)
-- 
2.41.0


