Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A614CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkuK-00043V-53; Fri, 01 May 2026 06:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuH-000421-8x
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIkuF-0000Cy-4t
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso16032825e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630533; x=1778235333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PWDJWe2AZnBQY7IEBTYHtAZi/b84KqQOngZk5MTLZWU=;
 b=EPfgCyv530SKKZqhAfto+zEIYx/DSem6+rcMRqSkWVIiiPACDwSnFXFs0r9tgVhJoA
 nTHhkjZyw5vzHEF/WQIkj/6uZHVHu/6L+o2vV+lOf9EOdSCxfV/aKc9crGwseEDujjgy
 N/5k+6IeHVB4XOd1BdQbxT2ZOWE0tLFV34QV5W+pAwitR4NUK276juXK907J/VDKC7lM
 +FUqFV3cB5htvIVyuDejcn4ssS9CaTi4WTfs5AJ5yrMTTk3hCB76kkDKaNdI06W/bdmW
 NHTchkGlef3FL48g71nX2e+EzYNVRaNKxCiH26SsYi+2/sZNiRNkvpLgJp8AJglrckbS
 O8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630533; x=1778235333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PWDJWe2AZnBQY7IEBTYHtAZi/b84KqQOngZk5MTLZWU=;
 b=Z/ByJ2N18CyGbxWliPhqCsbRL/cWPc6crW2+I5F9Q7iglbZOtsXymxQnv7N+FCqDbj
 HlXJZ2325O+5g4gguyCU+FbTgTX/ns+9neDEN2AFsTLFXJhi/9WBp7Kx803zxuoAlOvA
 z1sJBnh+obhlLOmK/IwoAqCA7wmeP8o6vo3LmbiUPZixcoesLeo2+zjzPdXoUHuHtYfn
 BBly6V1BJGSu7zS6FNkkLKNRJZgAVncVCXvQnf+j6F+v6OUn1g9+ZZLQ22JR9WGEYnnB
 tx1ccgd4R3j6GHpvlC4khSwAtjxVfq5BGhej92OPnlVfbsDYRhw0QGjKGSxuYr+3uCYt
 /p+Q==
X-Gm-Message-State: AOJu0YyHes8JJL+R54uNqsyl5O42CkY+JeDpdjOFbz8TG7mYfQv0bpCL
 z9OATjTQEJgEBYO615ckIsCx0yF/VY1PMbEkfH0aaOUGjI1gjiC0+hkPKT61OVEOoOhPhoES2C5
 qrthj
X-Gm-Gg: AeBDietVYsm5O9QEBin1V8bAZ0Gxvom2c47fXzEMAaPiVzEkmeAQR6xQ0JFWHbhDA9L
 onvABjdn+BOYlu9dGgeYr1980Q1gCNS8XmEiqAjKIetF5WKvxqnk4FwuiDCIfeRwV9orBHhGK3z
 FQg9g+QNXggrVSSKuKE9LX0sQ7Z6pHc9A77bj/zfaD43CaXnkdRmZWcXQ3OE4fVyGWZc0TIY2jM
 06pRYw/gdEfMYFtbv9oUFhIzcwUwvpBkQ3TfIo5xbNpL5hWgxoZYBdI6O6E4qwv9eqI4waspPdQ
 3GG4l5dnJnCRpdUCgkm5crMC/UFGNdMyZLWerGninAlFijRX9dl2xzCwDcZIWRTsy1wRYAjvDXw
 Xmub+WJ1JM180dAxjNgX9JZPOX8X8jfupb5uheHDK2WTW3iX9rDhiy+9MoQJ99oh3ICAw5CCbIc
 Eha4qu/gD3fLf/p4FBg/ctkEA24M0sjbUyTxRrnmtm9ujlPxDh4jk4gDhV2DwW3c0J6AFDJk0Tl
 qdd4m0erIznEnsYJff0A3vwnJOs9uRVEmh0ofZVbA==
X-Received: by 2002:a05:600c:8719:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-48a8ebaa93cmr39418675e9.28.1777630533518; 
 Fri, 01 May 2026 03:15:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/28] hvf: arm: allow exposing minimal PMU for
 kernel-irqchip=on
Date: Fri,  1 May 2026 11:14:58 +0100
Message-ID: <20260501101505.3485916-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

When running with the Apple vGIC, a minimum PMU is exposed by Hypervisor.framework
if a valid PMUVer register value is set. That PMU isn't exposed otherwise.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260429190532.26538-9-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 9d64f2e1a5..390a3529ff 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1145,6 +1145,25 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar);
 
+    /*
+     * Windows wants at least the PMU's cycles counter to be available.
+     *
+     * With kernel-irqchip=off, we "emulate" the cycles counter
+     * in reference to time in QEMU. Having that, even with
+     * ID_AA64DFR0_EL1.PMUVer = 0 is enough to make Windows happy.
+     *
+     * As it's a very inaccurate implementation with its only purpose
+     * being making Windows boot, expose ID_AA64DFR0_EL1.PMUVer = 0
+     * when kernel-irqchip=off.
+     *
+     * When kernel-irqchip=on *and* ID_AA64DFR0_EL1.PMUVer = 1,
+     * the OS provides its own PMU emulation, which is currently
+     * a cycles counter only emulation.
+     */
+    if (hvf_irqchip_in_kernel()) {
+        FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
+    }
+
     ahcf->isar = host_isar;
 
     /*
-- 
2.43.0


