Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44044CD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsbZ-0001Vy-Mj; Fri, 29 May 2026 04:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbM-0001PM-3r
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSsbJ-0005Qo-1u
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:29:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4905529b933so52910145e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780043391; x=1780648191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=az9S1vGVboCrXLR85YpBzY90OGFAcAq/GvXnwLVzHvg=;
 b=GJp2m1XrBNZ5Iv23uv1slfZRTsot06xHYSUraSIuaYUeNPwDw6HqmcyC00dLiVCWwq
 sDgwRZj3c1aWgjrKogwN2RCa5PRUb+URfr9FyaO0Rcqm68EPZtUHwSdwcpWcpJ3tRG1K
 n+mQ9M0IelEwTzduV/LjY1rp4KgtZ3F0MduXPCkz+9j/n1lSCF7aAcQHQFNutMcWQxZ6
 mEXQPhdUf765hPglLAmmWU1OI30JJV1d8zKSEXbttFzHh0TlBgGLh8eaETZeUMeWURgM
 itvnnsco5xE/fQO+co6ppqhxIvqEzh3v0GybopZ5gsHYIWy7Y/5w64UpTnsOFt/F0Fwf
 CN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780043391; x=1780648191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=az9S1vGVboCrXLR85YpBzY90OGFAcAq/GvXnwLVzHvg=;
 b=smQyAlxWZ1V7/b4n2CVStL4DDn+uUpwzA8xcSGCZQ8Yri7GYrtm5rYwPPdqx0wCjpb
 pCBCYFH6LqwwYnx1Dr1+eFERxbdPeI9jzySgTdNfGPQSNxG5omblRCpQKiJVfewW0230
 /KjctZ66N/UDqLZ5tvMP/tqdK6o9QP4E+aFANyo00uHTTw8YS4zcu+/UyY70J7/uC8Jo
 ejgf/ug3UO4iXq3CMOvIKSzA7oB3WV85xE0OmDsFTEGLJ81bvvG1Ex2K74wYU1c9ZZkk
 VQd8dqkADS99euAZ6x+MEDKWZuEyjMDasUbJW4wQcVUQJ2aKypAxWesVwG/8V85h9r61
 xoKA==
X-Gm-Message-State: AOJu0YyQ6MvyDCsUyhGCcA591pEMnhgeloDDBTEdiHq6Pq0wZ7QHGL+t
 OMyOTfGKKLHonFsCWHDLNzLhoTUhwwa8VMQIbWws7CAu4/bmeSTl+AdOKBEbeJ395qY=
X-Gm-Gg: Acq92OGSZ6NxX+BjgwrwPtEofK6Y8t5mEfkcGt5FPszWwmRpTT7dLH+9T3HVyWyABuO
 SAEdHn81m1UO+4y0c8e3xEjJ396EqL+ICjrCokfmTws2V/OkjC5szIWUIEKR1mnt8a+WmaJYhkJ
 FT7wADRYgRhr+OcFF2DT3wXikc6n0Wdxkmpc2Y3jkOmqvUdHwfQdd5YPDoNwqTnyZATFejsXsPK
 fdv1j2q200+LuzoEI62XbIpZNByzJf61/1vhC+Sc4SgwdyBf8oBdE4phvx0IJFdOAvTDk3rapOK
 WdTmoN1zag3sGrKZyembjYZL250Vmp6JDmMz8+t0UBciEqAK5oFWUCG2yENQm0UVfLdxcZ70NBw
 IDrm7lyTYP3iIpgW427Zt22J2NzngVPKA19Q7WZ9bs9gXKQQIq3wxGNpgjf9cVaWvJdGgElUscD
 sHCWW6jotdmW6/NSk+v0D/PmfceQc3oaxbpg==
X-Received: by 2002:a7b:cc1a:0:b0:490:845c:a1ea with SMTP id
 5b1f17b1804b1-4909c0b0c32mr25010795e9.21.1780043391324; 
 Fri, 29 May 2026 01:29:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0e42sm23561455e9.8.2026.05.29.01.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71AFC602E1;
 Fri, 29 May 2026 09:29:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 3/8] target/arm: redefine event stream fields
Date: Fri, 29 May 2026 09:29:42 +0100
Message-ID: <20260529082948.363931-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529082948.363931-1-alex.bennee@linaro.org>
References: <20260529082948.363931-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

The event stream control bits are the same for both CNTHCTL and
CNTKCTL so rather than duplicating the definitions rename them to be
useful in both cases.

We will need these in a later commit when we start implementing event
streams.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/internals.h | 11 +++++++----
 target/arm/helper.c    |  8 ++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index fb9df50da29..93f5bd0e830 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -272,14 +272,17 @@ FIELD(VSTCR, SA, 30, 1)
  * have different bit definitions, and EL1PCTEN might be
  * bit 0 or bit 10. We use _E2H1 and _E2H0 suffixes to
  * disambiguate if necessary.
+ *
+ * The event stream bits (EVN*) are in the same position for
+ * CNTKCTL_EL1/CTNKCTL.
  */
 FIELD(CNTHCTL, EL0PCTEN_E2H1, 0, 1)
 FIELD(CNTHCTL, EL0VCTEN_E2H1, 1, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H0, 0, 1)
 FIELD(CNTHCTL, EL1PCEN_E2H0, 1, 1)
-FIELD(CNTHCTL, EVNTEN, 2, 1)
-FIELD(CNTHCTL, EVNTDIR, 3, 1)
-FIELD(CNTHCTL, EVNTI, 4, 4)
+FIELD(CNTxCTL, EVNTEN, 2, 1)
+FIELD(CNTxCTL, EVNTDIR, 3, 1)
+FIELD(CNTxCTL, EVNTI, 4, 4)
 FIELD(CNTHCTL, EL0VTEN, 8, 1)
 FIELD(CNTHCTL, EL0PTEN, 9, 1)
 FIELD(CNTHCTL, EL1PCTEN_E2H1, 10, 1)
@@ -289,7 +292,7 @@ FIELD(CNTHCTL, EL1TVT, 13, 1)
 FIELD(CNTHCTL, EL1TVCT, 14, 1)
 FIELD(CNTHCTL, EL1NVPCT, 15, 1)
 FIELD(CNTHCTL, EL1NVVCT, 16, 1)
-FIELD(CNTHCTL, EVNTIS, 17, 1)
+FIELD(CNTxCTL, EVNTIS, 17, 1)
 FIELD(CNTHCTL, CNTVMASK, 18, 1)
 FIELD(CNTHCTL, CNTPMASK, 19, 1)
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 34487eeaa36..bed58e65b4d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1769,9 +1769,9 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint32_t valid_mask =
         R_CNTHCTL_EL0PCTEN_E2H1_MASK |
         R_CNTHCTL_EL0VCTEN_E2H1_MASK |
-        R_CNTHCTL_EVNTEN_MASK |
-        R_CNTHCTL_EVNTDIR_MASK |
-        R_CNTHCTL_EVNTI_MASK |
+        R_CNTxCTL_EVNTEN_MASK |
+        R_CNTxCTL_EVNTDIR_MASK |
+        R_CNTxCTL_EVNTI_MASK |
         R_CNTHCTL_EL0VTEN_MASK |
         R_CNTHCTL_EL0PTEN_MASK |
         R_CNTHCTL_EL1PCTEN_E2H1_MASK |
@@ -1786,7 +1786,7 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
             R_CNTHCTL_EL1TVCT_MASK |
             R_CNTHCTL_EL1NVPCT_MASK |
             R_CNTHCTL_EL1NVVCT_MASK |
-            R_CNTHCTL_EVNTIS_MASK;
+            R_CNTxCTL_EVNTIS_MASK;
     }
     if (cpu_isar_feature(aa64_ecv, cpu)) {
         valid_mask |= R_CNTHCTL_ECV_MASK;
-- 
2.47.3


