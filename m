Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F061AE7DEF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvyb-0008Uc-7K; Mon, 02 Feb 2026 10:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmvyZ-0008Tt-7y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:36:31 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmvyX-0005Ei-FH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 10:36:31 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so4020200f8f.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770046588; x=1770651388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4bJBIFXqDuMigdL/O55+VSdt0bBjeOO3ki6haMaoLo=;
 b=HgwLqbLnm17OdtSTiLvJEybo/jkXq+oEEvMBu+fKE0I3fXsZszsW+wXDXeh7DwTRJ5
 +rhJimgqaRW8v61rQo5LUbZDCaM0OIS8EC/3ppEArrKqnJVaKfSTk4U66177SrvA2HUQ
 eFoVKeFjmtQZ3VVBTrTaXJen25vwStlbIBxjNHv7iyl8otONXYLuReJmNvvAIFIBju+y
 /619pIYJkZGkoL3YlWm92W+W9Pi6QUs//GWTLYYis6sSIHqQCYIFUsQqy5i6C0K6PYGL
 huw0LKIk1LazWycbY7Jht6Pv5xekw1GwYyJZ+eb9leyS8XPoXg0atCMn0+BmBDJzmBpR
 Rd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770046588; x=1770651388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a4bJBIFXqDuMigdL/O55+VSdt0bBjeOO3ki6haMaoLo=;
 b=wGsg1nVV8bklGuiQ2YoiQhjppo7EERNDbDWP9bFnOz8e2bW09Hq8PmqxOutDJuM5TR
 VmMKDHIu47QBhGp5VAX1ytNkklatUwRLe2rbFdw3nBAxLKLnjOMsCebNoKDHFkK5FexN
 5l1SOqaxJOMo1XUxjLAdXDokjq9WmW6jWKrJXkknZYa31zcoT8IgnpgWpd+uvIFvVFkn
 reWUpM1S1lGDEO+/OiPWt9rdLycU+O3olrwn1dtxNt1b34nV7ers+y3AvWV1l+GTXpOX
 Z8ihQfYDwYOJK/d6SnlXlztd0Nd/QiY4ApYWEAD+4F1dscVi490//7SqP74PpPbchqih
 64wA==
X-Gm-Message-State: AOJu0YzvJYdfeJMXL9ksX2bp0r/qgS4UYJPCztNtVf7RJY4nfUUQ828V
 UYNPBUlodIUZVznOk29qSDcVzNGgn3XZ32Uot4c83TLC4C+P9Nbbnk3lgtmWvKne80CTmRvLR9E
 3hR/7f54=
X-Gm-Gg: AZuq6aJpmRxwQD07O+bZ48JbWn72Ojgy9cL3m3HoKbiO+W3iIEhoYUlEqcujYV5MLpv
 s/UrTj+JjAeuUSY+J94Vi2/VP1aZ9K4eeGVd2a76z3orxs203toDh28QWbbTSJbI0T3Mm0uOG8+
 wos+PtOt65hG6qXlh6Dpy3NSa1Z2rwCY8EOL1RmnQwnIyC1voH/cKeJKoho/R2ABnRqMN4L8LTM
 yaiU4vRl0E0Dd3hu6iqLcYgX46M8RxY+2p9esfhJvf2VCBIMRaSXLBNkQC/VtTh+YI5yg/bF4eN
 Jn8qH8AxT4JOzZTuyzxdw3UJ37g6lnMv4kEKePwnwb21PJDvhaOuWxbtSPob4wAV0Vpr6Aqtd4e
 mFXeXWTj3fNeSwHjzsiWC8kfjAGO4hB2O75R9CEXtDo6liC9t65Od2dMKY8/MyEen1rfaRAY+z9
 iXK/xlNeOZTSFokG90KOBGC3d+7X7LnwsMbTaZ1VXv7jQ/BumHXc4CP2nE+GMv
X-Received: by 2002:a05:6000:24c9:b0:435:9223:bfda with SMTP id
 ffacd0b85a97d-435f3a7bb22mr15257428f8f.21.1770046587280; 
 Mon, 02 Feb 2026 07:36:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm46250066f8f.27.2026.02.02.07.36.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 07:36:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/2] target/arm: Remove dead code
Date: Mon,  2 Feb 2026 16:36:17 +0100
Message-ID: <20260202153618.78675-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202153618.78675-1-philmd@linaro.org>
References: <20260202153618.78675-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Since commit a0032cc5427 ("target/arm: Make 'any' CPU just
an alias for 'max'") the 'any' entry is never used (we use
'max' instead): remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 0b0bc96bac2..2127d456ad6 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -897,9 +897,6 @@ static const ARMCPUInfo arm_tcg_cpus[] = {
 #ifndef TARGET_AARCH64
     { .name = "max",         .initfn = arm_max_initfn },
 #endif
-#ifdef CONFIG_USER_ONLY
-    { .name = "any",         .initfn = arm_max_initfn },
-#endif
 };
 
 static const TypeInfo idau_interface_type_info = {
-- 
2.52.0


