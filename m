Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7272DFCA199
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzier-00038Q-UV; Mon, 09 Mar 2026 18:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzieo-00035r-J8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:58 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziel-0004ZD-OO
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:58 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79906e5c7f1so9975307b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093654; x=1773698454; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HuKa+5wJp5vlnvtkVWzlsoBzIs1CAqcZV5v+8zXp2z0=;
 b=SheNSUS1SVY8VhKD3YPYDMrHmZCTPhlLLaAMk1B3abO0OfPJq0CjwkKjKs4IDdJK+M
 bw2KqmRj0ZkZC0eTxmKKMffBMDhunuDJ1CKK/Fn/TfOvTbOmWYsWQu7wBuACDeB3KSVw
 lTez4tyNqwJCUkMH3OiQU3IbN4ErpH1ETRrDRx6fbzhdz8hw6rFG7DQGtnFuhSeS2E6x
 ln0ZBvBPO+ozloxZNUkqoBMDpMquFiB3Nu27gnv/2QWhe/yo1BmBL3DN/+Ft6zn4M2gg
 PKuZVBkoTlVV/TrSgmbCtg8qoom0YOvC6Wh3dQPD5tYFHi1S1YMaALDHl3OKODaSVe4C
 OCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093654; x=1773698454;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HuKa+5wJp5vlnvtkVWzlsoBzIs1CAqcZV5v+8zXp2z0=;
 b=uLl34JBYEEyZwAJQMLOyW9YLLbCp+5jNFAaD/gtkKo77fz/Ekwy5EqukY+RQZIqDpm
 UiVcVSk8rm0lkUuNmqUgCVzOee1gKk9Eo27w4fh10gkh7PY0aZcBQGOBe4Z3c43iyJau
 jvZeVJiQsMuuilI4RvnLMuJA04GKsWj2lpZNj6u9EpSEu+I19EOuw+JepqDBvRp8Cqud
 Ilyw3ytEcRk/LEfjjzX4s0uQyp6+1XAp53bIvxUJvVLu5AEeTp7ZITamEqdLTrvIQGB7
 HrkdHy64k1SVwXLoXPYav79FTbMNmdI2a6mBE1NSygldhpY7mqIutyC7DgphIpoGh80A
 on/Q==
X-Gm-Message-State: AOJu0Yy6CS/ONXgiENoUEuD8AudNEEKKU07Rn6z2EGS7/wb2td1nAoNw
 PZWXhuIcNXdplAF5qVuClplmeZqtsGukkp4TzQxoTOvZEjf/zGOeZala
X-Gm-Gg: ATEYQzx8Zws3ygkoPMsXMejmPRtLxXqeiLGzVzwIEVNJWhqVrqDOdR3myCzCSlQXy0X
 b5seSSE+aKeX5x+MgI+CGtGYQOAExuIVK6iurXCihgXZ6ukrCa7rt6C9e5/h377r4dABB/cCOjP
 DruPVAyyFG7JKuz/TS4hkMCrPB5OV+rAozWxjyxaTcKUVK3QrdTqpB8BZHXxEtApaqTcEZcUCF+
 IY0KvVLC5F15VcVzAndbimqOW8BUnMFyjw2zJeoVTiKvjNNLNFux6dwaYTam79zzPLaPFbwe8P2
 bRS6acxRZrAEwY6sFXhuDlRxJb67TwuPS+P0g8dyCt9xJvoLQNU3+s2pHBZBAqr89IRZH7pK7aA
 3+b59nScuAw4ePiIkKI4QrN0me4WsWPT+blyx1HMi6o2/2o6X5GDs/6snCAVtV9x2YEoYbkz9f2
 BPxvK9Tq3udxZwNtDDa9cZBRehUbTxCHn03ZfWId4niAUldg==
X-Received: by 2002:a05:690c:dc8:b0:799:939:e82f with SMTP id
 00721157ae682-799093a04a1mr17054767b3.26.1773093653897; 
 Mon, 09 Mar 2026 15:00:53 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:53 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:43 -0400
Subject: [PATCH v4 11/13] docs: add MTE4 features to docs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-11-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=2273;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=SKqzsgfGBjCCy0M3W5MnUoYPUiZpeZ5BL7yzFuAZ0j8=;
 b=8zvGzJ2A+yT2c3VP0Z73umKrnCZTZwg1+N0ThhzcQ6U2ksnjgoO6iqVF5V1nidkqa3aWpNVvr
 O1SPUeacE6jASOOrf5bIFHoUmgjNdRNHy48vkL3LTfXmmTY1tm74Xv9
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x1130.google.com
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

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 5 +++++
 target/arm/tcg/cpu64.c        | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 7787691853..0f529ba6bb 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -109,6 +109,11 @@ the following architecture extensions:
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
+- FEAT_MTE_PERM (NoTagAccess memory attribute)
+- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
+- FEAT_MTE_STORE_ONLY (Store-only tag checking)
+- FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
+- FEAT_MTE_NO_ADDRESS_TAGS (Address tagging disabled)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 84857fb706..7838bb52ea 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1281,8 +1281,16 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
+    t = FIELD_DP64(t, ID_AA64PFR1,
+            MTEX, 1);   /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     SET_IDREG(isar, ID_AA64PFR1, t);
 
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR0);
     t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
     t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */

-- 
2.52.0


