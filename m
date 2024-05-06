Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD38C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wxE-0004uf-Vo; Mon, 06 May 2024 07:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s3wxD-0004t0-A1; Mon, 06 May 2024 07:56:23 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s3wxB-00029F-3U; Mon, 06 May 2024 07:56:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed9fc77bbfso1240118b3a.1; 
 Mon, 06 May 2024 04:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714996578; x=1715601378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fEkT0a9CzXfL+fGc/Kr1dzLKVBwamSUx3XhwoONdOEQ=;
 b=nRl3YLlYpXe7p8h2zRAKoSGo/cDsqBmrHOpymTAMlPxA7ZSyng1uDWgGKasdNVILvF
 am+kAAOhuYY9rbUOf5bMGqsvdMd+sJveQMjszpj12AsE/a0XVbS4+lbkF4gUgiPd0l9V
 TYfb+17DUH3fsRrcMWhN2i7P1KvO7MjI3Jeh7SMScigoml5tXauDIkZnshHdkDcYbxMx
 fk5+UxWOnRe+IEN9bXH6FcquwSwMEqa0IY6qn0XlkjzM0nJv9yEV+Ge/dKZf0QbpkuQE
 /kWFhRxoDNKUF39rJyrRCv9rxZ+tG349Y+w0eF5aoFgwW38D46JouqjiVIRi/6/FECfb
 9rWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714996578; x=1715601378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fEkT0a9CzXfL+fGc/Kr1dzLKVBwamSUx3XhwoONdOEQ=;
 b=S7AYfxSoYkqKQU94omz3z63x5XAfN1Ct6ugqvwFNJRIiSa+3igJDrQiyWQtKxDZvDT
 UV6E+viqJ+b+vNDk7vdSflfqFTCbpddGujb5RRL0Hm6qcDhLAWOqn8STyeIpHXwG0o8l
 Unptnpdnj0VpmZsLYmaJo0DV0v6ILT1ebHlYQ6BXO49rFzg0ShKNsvBkVszt00IHTkMi
 2rithjGTv8BHfvmUKZcX/bb8RlY1PhSgpOEzojaKSWMKbXKT0Y11d7oJWfFTRMS2JzAK
 URWJXbIhPgZiLyZe2VLflaC4ZCri5y9hIzlquV84nHhSP/XDfE7GwjyPLb+V2AS1HpAN
 sPtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxEHFa0J1lzejkUpGdlUeYmjiSYO1hB8KDzGIF6CibPPO2TwM8DzqTIBWpldPU62phU7u2tB6/mEIvl7PjbdeLQyIhTNhkmIuzYOcy4u2RSOTfRGxQpH7Bfz/xw2M=
X-Gm-Message-State: AOJu0Yyi8/5h/X3vEdoaWcYLGiLj2asCKDujw0Iy9z+Lg567oV0C423i
 QTVli6PUVB74b8po5hj4l1dHzHB9daWmvnwbxJOoTbFXVRLxjvdHvYirag==
X-Google-Smtp-Source: AGHT+IHxVdvxtciyfFKvus5HOsPMgYoB+fA5bGB6HvYcOAMINZgWvVDrCu2Y3q03sAbFnl42ie1YOQ==
X-Received: by 2002:a05:6a00:1799:b0:6f3:ed26:e4f5 with SMTP id
 s25-20020a056a00179900b006f3ed26e4f5mr11994503pfg.7.1714996577966; 
 Mon, 06 May 2024 04:56:17 -0700 (PDT)
Received: from wheely.local0.net (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a056a00234700b006f44c2ef5easm5748019pfj.101.2024.05.06.04.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 04:56:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH] spapr: Migrate ail-mode-3 spapr cap
Date: Mon,  6 May 2024 21:56:05 +1000
Message-ID: <20240506115607.13405-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This cap did not add the migration code when it was introduced. This
results in migration failure when changing the default using the
command line.

Cc: qemu-stable@nongnu.org
Fixes: ccc5a4c5e10 ("spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for H_SET_MODE hcall")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr.h | 1 +
 hw/ppc/spapr.c         | 1 +
 hw/ppc/spapr_caps.c    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4aaf23d28f..f6de3e9972 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1004,6 +1004,7 @@ extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
 extern const VMStateDescription vmstate_spapr_cap_rpt_invalidate;
+extern const VMStateDescription vmstate_spapr_cap_ail_mode_3;
 extern const VMStateDescription vmstate_spapr_wdt;
 
 static inline uint8_t spapr_get_cap(SpaprMachineState *spapr, int cap)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d2d1e310a3..065f58ec93 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2169,6 +2169,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_ail_mode_3,
         &vmstate_spapr_cap_nested_papr,
         NULL
     }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0a15415a1d..2f74923560 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -974,6 +974,7 @@ SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
 SPAPR_CAP_MIG_STATE(rpt_invalidate, SPAPR_CAP_RPT_INVALIDATE);
+SPAPR_CAP_MIG_STATE(ail_mode_3, SPAPR_CAP_AIL_MODE_3);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
-- 
2.43.0


