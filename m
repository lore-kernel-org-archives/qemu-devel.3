Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7480C3ABBF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57N-0006eg-TR; Mon, 05 May 2025 19:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57I-0006XG-ME
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57G-0003hJ-N2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2295d78b45cso65339315ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487253; x=1747092053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=yKJNAwZUYYHLjzjp9IVz7VKpQewPrTqb4L441Fhuysad55lejtkLmZfMLZtcCCh4Mp
 +BTGYG034e2wsla9i9ANkLbWpHlLiszE1E4Iv4yrJFgCGHWaEtHlMyBmJlFJ3iBzUYP4
 Zwda4DfQFPFuS1EDnvX2yz5wbFF+gcvJrYbKtmUzYUbB/3HJLjLYlEPyxIEas5cEdPJw
 wD6A4JWZoncroZ21bz6DcD82bdhslQArxr5+cJiEnyZ6YfvD6nY1SCXDvZyLsVhcrfz4
 G77vNwTNDoUopVDbgIHOGu9Kzca6jD64XmdakTAWvR4WO2BUfvFaK3h+NABnc1Fm6Cjo
 L6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487253; x=1747092053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyeC1dYqzIyRbq0U6QJpnfGNVlqEyh7oNHL1QwbMptA=;
 b=wxwNzeNEpIWsFsup5UQqeg/0DhrqsRj2AEXNrnZ+ejGacVAGJdG8ItbfkMX76lUfFh
 FJplW0njIuSwETTffLEwckWwPjQ2pv8bmEyH6YQ+tn4FxNDpPRhTIyljWTA8WXeOi5tb
 Vj/kUbVCjxFhmlKmg+U2AjAiZ6OgzRGcbzyDEfn4TecMw6MYglcCk9g5X3lv0djVMzfL
 vTFMorVUsseSyJOf/8VP3QP2/bOHSiIRFBQHCalXZch3EyOknUE5zIqunK8y8NGA8LUh
 z/Xoo04yJyhctALqcmE0SwJDCdOvkDs6IUoZsVRRrQtONbgle+C9yNqRtIUOgu8hz7Uj
 v0Gg==
X-Gm-Message-State: AOJu0Yy1HJpz14QtHcvXWoqvm16qGwECWAoHjuI+Gv08xZSXyK4W5F/s
 JdEsvaqp5D9nG9ITtjleqtKRqEUG5YuK2wGUyN9K85efvc/uLT9AqT0IXh/xH+B0REf8j8uoHQ8
 05Yg=
X-Gm-Gg: ASbGncv1V6lHvp+YDXAVyiulGRfSUnvXL0GhuZT7RbIXIgbvmIMPyiWDFFSVAVDSyat
 PI+ostWL/ZbMC0gGKJVCVaXDKizFmDa1SYXgLyF/QnyK90bbEVGitWQMuZF0hN5aM1q2i05CDuL
 vjmcEkE5Y2as3iIwthtN1PDrdEKMb+Xtomqz6wYb8sflPDvd/j4er2uwO64Sg8brjC7KkhxaBq/
 uwrnqsULNRZTwJs3ukIR1Tqfg0ngskBy2QWqumr6MzZFvwlWX9J6P3klVu9vME97mAmWF8OYOPA
 HgYGVszO6UVKaiypIxdaO3VIJ4E6wh+rjbMZvHKH
X-Google-Smtp-Source: AGHT+IEQz1uooxmmnU26y3jx3diyYO9Qb7x/IWS7jSUjRxMekEpaYNdIascgkfukWRRtAFkV+bb+RA==
X-Received: by 2002:a17:903:2349:b0:220:be86:a421 with SMTP id
 d9443c01a7336-22e32f00884mr19329055ad.38.1746487253295; 
 Mon, 05 May 2025 16:20:53 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 37/50] target/arm/machine: remove TARGET_AARCH64 from
 migration state
Date: Mon,  5 May 2025 16:20:02 -0700
Message-ID: <20250505232015.130990-38-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

This exposes two new subsections for arm: vmstate_sve and vmstate_za.
Those sections have a ".needed" callback, which already allow to skip
them when not needed.

vmstate_sve .needed is checking cpu_isar_feature(aa64_sve, cpu).
vmstate_za .needed is checking ZA flag in cpu->env.svcr.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index f7956898fa1..868246a98c0 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -241,7 +241,6 @@ static const VMStateDescription vmstate_iwmmxt = {
     }
 };
 
-#ifdef TARGET_AARCH64
 /* The expression ARM_MAX_VQ - 2 is 0 for pure AArch32 build,
  * and ARMPredicateReg is actively empty.  This triggers errors
  * in the expansion of the VMSTATE macros.
@@ -321,7 +320,6 @@ static const VMStateDescription vmstate_za = {
         VMSTATE_END_OF_LIST()
     }
 };
-#endif /* AARCH64 */
 
 static bool serror_needed(void *opaque)
 {
@@ -1102,10 +1100,8 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_pmsav7,
         &vmstate_pmsav8,
         &vmstate_m_security,
-#ifdef TARGET_AARCH64
         &vmstate_sve,
         &vmstate_za,
-#endif
         &vmstate_serror,
         &vmstate_irq_line_state,
         &vmstate_wfxt_timer,
-- 
2.47.2


