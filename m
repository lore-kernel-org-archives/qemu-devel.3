Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23A1C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4i-0001EZ-Vg; Fri, 20 Jun 2025 18:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfY0-00078T-K7
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:05 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXx-0005vb-M2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so2035360f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440539; x=1751045339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bv/X12n6Kj9j99MOv3JQyKa9x/TcC6fyD7QWfzQDFrk=;
 b=WNae4O7FKYrqcIxa0Z/Yah3Yyih2fa0rvfYZ7n7qjAqtA0CEUmqyEMR2dhMVXfYWK8
 pXdt39rnY67FqgYLqe7pJZQs+AMQa34k8QoTJtH2NwYnLdsF/RzxY9CppeECL05tOeKx
 LN1whwmG2SNjBAAFBUsl0oKXCjvDFoEwG9yUwOE4eWS/V5xtJ8WkUAOjah7kFViLHTYS
 GcbzK87KrwmMY9UoyrJETuRdNkSi8tIeA7RJzV+fJuM9n7QyLkJwVwEen6ll3J0T2YKu
 EhCF/jX4UkAeM9b0bIlzjvO6/3NuGxWvxmCcTHGYJ0gz/5JSL4pbxAEqMh/d6d5EXC02
 8qXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440539; x=1751045339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bv/X12n6Kj9j99MOv3JQyKa9x/TcC6fyD7QWfzQDFrk=;
 b=iyo/RNnJLU7kLXgrdqW2IPc/7sx2r3cYeaxuC9lkmEupIsTGuKrnbPOqsMnpmGSUt0
 fCCshwPmoEKs3Qgre//vcF6arTwqnSZyGGqYNq73+eMhSbjgrPyX7uQq4sDfKExiYEqk
 b2awiQzXuKIm33GIvjjjUAN0FBV1467WITM4712fpvoq+N2aEcq3PNGdyRwWJ5CG2t40
 dJR9c3gfMrxWdlIlm4SrXJGNLBP0IWLObdbc+jD8XsTdlwscOrxyIyMzJQregx73EJRm
 IaR/tazE64z17atSzGUg191i2LAtKDeXk2bDSb0y3tybxMqV/NOB/f8LZGSHgQzWksJ8
 mIrg==
X-Gm-Message-State: AOJu0YyUX3Droasbsg4lwIutEB4CI2YmxkDHFIENBXPJvLXi0+sfw3kG
 OiECp/Kz6aif4KBKl7BF2NgZY7whUsb/kDYjeCo6lHWTcz6p1eCDo1c/Dnn1167SsGYBw5rbIMG
 GVfcDHrDkGA==
X-Gm-Gg: ASbGncucMq+b4MfpWCY1IUrlsAgtAPfXOY9pOQRwSJj+Ud1vGjSs0prEdDuRhCmD37L
 H06PpqPKdOeQNB/netuS5Pbgy++VlPVQY1b7dLen5HmBKyb+08FPBVMrK6DTQtj5BTMS8mqoDpW
 T16jAC8uwQiQvWnHp4dr0FagWezNjZs8qzt7HDWQTEC6ZAUXGFQqNUPmp5+4/QlgL4eDvsrluPE
 4o5M9c8lvOXi17RcvZdEwzWDQX/3i2fpflVo/tPPTfdhM+8YpBxm1m202FGD7qLJn4ZpPJMvVqy
 vf4HqVI470KDjeFty0m2NSBLLZ/c3sLYTUp69n8ngUjEI2eOnY4H/YCgTMYQ1V4tJnJbSi1IqTW
 UtdsC5CQ3tvoigoWOXXhcIdF3AhZ3X9j4LQIPKwq+LfU9JpbosT64ugMm
X-Google-Smtp-Source: AGHT+IGrwYC0HGu7vvlCgYbe/gdP+oTZOo53e4uBjGWF+m70Mz78AdWH8TzIApTiDNmJ411hb9fzxQ==
X-Received: by 2002:a05:6000:4109:b0:3a4:f892:de7f with SMTP id
 ffacd0b85a97d-3a6d13071e8mr3101777f8f.36.1750440539502; 
 Fri, 20 Jun 2025 10:28:59 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117c19fsm2591121f8f.48.2025.06.20.10.28.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 08/42] accel/split: Implement
 gdbstub_supported_sstep_flags()
Date: Fri, 20 Jun 2025 19:27:16 +0200
Message-ID: <20250620172751.94231-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-all.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index cb910300931..413954af96c 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -77,7 +77,19 @@ static bool split_supports_guest_debug(AccelState *as)
 
 static int split_gdbstub_supported_sstep_flags(AccelState *as)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    int flags = -1;
+
+    if (hwc->gdbstub_supported_sstep_flags) {
+        flags &= hwc->gdbstub_supported_sstep_flags(sas->hw);
+    }
+    if (swc->gdbstub_supported_sstep_flags) {
+        flags &= swc->gdbstub_supported_sstep_flags(sas->sw);
+    }
+
+    return flags;
 }
 
 static void split_get_stats(AccelState *as, GString *buf)
-- 
2.49.0


