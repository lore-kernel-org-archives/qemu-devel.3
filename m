Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8B0D6AB17
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q20-0008Dc-3H; Thu, 02 Apr 2026 17:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1x-0008Cc-P6
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q1w-00072V-DX
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:56:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65c4152313fso1837829a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167006; x=1775771806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsiOCFpX98FF4Vw1kJYQcgkoeQF3bMwWWwwrSBOoVn4=;
 b=a78sGn8ICd4izn/gMjCWTWiixvCKW2YHcdi1R5IvzyQGA03p5HJJOL3hsalwmRLfaA
 2RSEeJAGi/GDd/esgI/1FvQqqGGPyJbZJHQpZlegigI/BIn/k1MzH9B/Ela/21vUXUts
 fX5Zo8wcMxduf+UJTU2FCezw3eSfJsu6NENyZzxzr7jGe6X1D78/fO2H3cvH2VqlcmG5
 +xvTaspeArqD975/eZrP7A4KgytV2docIp8gIDpVV8C2f47796lx7xGeQRkk+JAWy1TK
 QwGt0CkzQmwC4w8wEc/6IneoUYet6ablHiB/9yugPIH1ppx0hLzqkcgRAsy3kUS9SrPP
 8etQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167006; x=1775771806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YsiOCFpX98FF4Vw1kJYQcgkoeQF3bMwWWwwrSBOoVn4=;
 b=mEYnVlpH00rwNvzjDRl2Xlj/7nFqBFLD6fBeKe29+rSKgOoCRA9HJGWoDKx9R2cuZY
 efhHe3bYtxjxbZ+V5O9T1+ZTnlmH12gMcaLzoZU6AMEg/wyvZ/4ouvAMlUrgjnhN2D7U
 ENUNar7bccgs2iy8WHIy3dvs2oYeIh2DZKj4+KxSknWgxUWTPQroYY82kFLCh787zzT/
 5anJ0IdMA8MZ1I7by5pZlDqVtxmN7N5LbYTIOqmMykD8n5FV3G3LQZnDSrbsLj6ZEoH+
 Eoz8GIMy0WPXQv4uKNgQLsqEKgFNMa5CLyOBBOOK5VPmDzfVWiRvUfIAoUvvWLhSar/y
 12SA==
X-Gm-Message-State: AOJu0YxOl4v/uHdmwwzcOowVJ7nG70dKgWINddwF4zOxRxi1w6Ta09wp
 Rx2I77OIzdGeo8OOKEjMknBXMxGJV7bFDkYoO6yTNriQw6nLNnXnb1BVB73/6u+h
X-Gm-Gg: AeBDietcGvwKm4QzofMAx7yFal/e8ccwhcJpw57jQAZrWd0Zudy/uSIGvY/z/EbBSxi
 l8R7PocTCdAoKmxGr6vsAUkI3XPeKZw0DmrdoAiuOoxoe3X+LPi976bcWG7AGyOu38zYUGlkxhP
 fHzNFccb2pCXX2X5y0+wncql8YdX4vJYWU7rqiF0/y7KTaBJAMzovXe+WeMnLhJIYksR57Me9fj
 yDfSGgq/7i0fT9Jx2MQ2BreMxvhXswbfcf7YOzGybRBbnlw+VL6Cx3SA76duy5xOK4Cg3RNKfHC
 SSf5IQwnQUUQifgTHBzsqOXPY/Q+/ZwhALCTda3dA4HmGZtZbCRLzyE4YLK8+VZN+JaWduwdJyr
 bvHYDO5YuA5F8P9N8ZEYtoZA4HvjmHSopSBSj45w09nBBJ5rbJ2BYzlQv/Fqd5xSrCrNtM608Fc
 HhlCDa4j1Wl+I+b/zExv170EeFIdAtHb5wmQbYlZFjbND8ZkDRkqKZLLJvdJW/MSsoITq9gw==
X-Received: by 2002:a17:906:9fd0:b0:b97:34e7:ea87 with SMTP id
 a640c23a62f3a-b9c67454a03mr25355866b.19.1775167005540; 
 Thu, 02 Apr 2026 14:56:45 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:56:45 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/33] util/log: add log entry for fdt generic utils
Date: Thu,  2 Apr 2026 23:55:48 +0200
Message-ID: <20260402215629.745866-4-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce dedicated log mask for hardware device
tree processing, to selectively enable diagnostic
for FDT-based machine creation.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 include/qemu/log.h | 1 +
 util/log.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index 92956e5d0f..8d48ee332a 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -38,6 +38,7 @@ bool qemu_log_separate(void);
 #define CPU_LOG_TB_VPU     (1u << 21)
 #define LOG_TB_OP_PLUGIN   (1u << 22)
 #define LOG_INVALID_MEM    (1u << 23)
+#define LOG_FDT            (1u << 24)
 
 /* Lock/unlock output. */
 
diff --git a/util/log.c b/util/log.c
index 7cffbc1bf8..d88a47394b 100644
--- a/util/log.c
+++ b/util/log.c
@@ -531,6 +531,7 @@ const QEMULogItem qemu_log_items[] = {
       "include VPU registers in the 'cpu' logging" },
     { LOG_INVALID_MEM, "invalid_mem",
       "log invalid memory accesses" },
+    { LOG_FDT, "fdt", "log Device Tree info." },
     { 0, NULL, NULL },
 };
 
-- 
2.43.0


