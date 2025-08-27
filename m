Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8489ACA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4bD-0003YK-9R; Tue, 26 Aug 2025 21:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4bB-0003XI-Hh
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:13 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4b9-0007DQ-HL
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:13 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77053017462so2567640b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256709; x=1756861509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ggwb1PQpRrrkLOGCaS9ng6BrXdIGDe+gz4mi5GKaHg4=;
 b=RY9RBnWYuCqEOD+8ufxyOCGQfU4o+JriHwSSCyzHt4Zp7CNQKFaoRXkcXMODO9QqRx
 q29rY50q+UVC3kRkJF/ePwjwDYG11szpEOS3BbYE1fE5/SQ7Skg87F9gjN4uTujRDdSu
 fnt1oj/MPvoCAqVjX3sOOtFSxTSjjs7X9SOKP01tAWpQlH0uMFD2foxFS0odMZ7SU8WD
 TXOux+/X8iljDxcLXZGZyGexNGV9B9il7hiNodgJvVzkoPNgzU4J8toKEkEf0rgsAF82
 hz21u8XP+rOewyAv2IxIxJUmUGpmnBdKBAhhisq2S3+JYV8YqVWLY8znJIRHjI8/OwsR
 jVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256709; x=1756861509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ggwb1PQpRrrkLOGCaS9ng6BrXdIGDe+gz4mi5GKaHg4=;
 b=qy90esSMljBtlA7mkGWJkhkys81yHhvPzoaHuNfte4pktdPlScqTRFB0u5eyejm/U3
 wSQU6WBcqTzZFnSrLsHy61w9s4paLjT4aiBb8qoePhIcGWpbdBOYilXAMPnYF4cBJXGs
 aF2koy9YdnVJr3lOyCgbbNLlsxbxvawm2gzwxF+QZTv5iuZ4CfRSG3KwifHbomyh+5LK
 jmE/ikXFxxdj8nP4NhoVtq3rURguc4hdrpYkVbAFZ2vfWN6JX7jdu9zMJ+Arba4A0bsj
 IOf6CdeU4qmk+6NtrX/j4fM49R3plwCjMvE5kEtWman7vSY3c8KxRFz029piq0NIQKcI
 fLKQ==
X-Gm-Message-State: AOJu0YzpHgxP6+cGWj1TtZbxcFbN75DQyWoKyTcQ2Yb6mBFJjvcyavV8
 llJKD2suRVSpT9gB3xyuC2p7ia+HqxjI83pjuBuOcjjnYNUR7Ly+frYKhDgWWiOk2GoOqmnCF1B
 A+TbSOEE=
X-Gm-Gg: ASbGncsw03KU28etPx+B5nEOldc2L9R+H1pzZkgvsrITAJy/yWhvGM6Q1qevQ3S7R8F
 Cp70nkoD2ah8x1fTo0Qo00NhZAe4kF7i3jzMzhn7j5aHLlYw5uPffCB3W3BVKH26i8exYRUP/PJ
 pdmvxKPErrAMCEEzzwuNMxfI3s417y8Cl4E5KfuJr/yNhbEXH3EVQsQjxtHpV5tNnsvitCZmqKX
 3dUmrLoI1RauJRroUWIZAC0QkZ0mAIl8elLgAhldoc0kuIgPq1EZzjQuSwE64Tn4wJPBY3mLFdu
 j9gnPRGtdY+8vDqCQuQscR6posHxd58W56Sl2R5Hp26PInxHJNnSzJYVArD6VEWwhtYiFFEMGVK
 CAlRIYfS/rpPh8cBX1iZu2gpBTKKbeWjux/GrEmVFZNnKF2U=
X-Google-Smtp-Source: AGHT+IHo+9tb4fg7yF/iu+ukHEiCLEDeDjjpFctjRINkMMnSU6BBn4Ddz0POx9nW7/d6DpumBAVVQg==
X-Received: by 2002:a05:6a20:b32a:b0:243:6e7b:9666 with SMTP id
 adf61e73a8af0-2436e7ba22dmr10754084637.28.1756256709413; 
 Tue, 26 Aug 2025 18:05:09 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/61] target/arm: Introduce KVMID_AA64_SYS_REG64
Date: Wed, 27 Aug 2025 11:03:48 +1000
Message-ID: <20250827010453.4059782-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Allow us to create kvm ids directly, rather than going
through ENCODE_AA64_CP_REG + cpreg_to_kvm_id.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm-consts.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index c44d23dbe7..fdb305eea1 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -180,4 +180,15 @@ MISMATCH_CHECK(CP_REG_ARM64_SYSREG_OP2_SHIFT, KVM_REG_ARM64_SYSREG_OP2_SHIFT);
 
 #undef MISMATCH_CHECK
 
+#define KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2)    \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
+     ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
+     ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
+     ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
+     ((crm) << CP_REG_ARM64_SYSREG_CRM_SHIFT) |         \
+     ((op2) << CP_REG_ARM64_SYSREG_OP2_SHIFT))
+
+#define KVMID_AA64_SYS_REG64(op0, op1, crn, crm, op2)   \
+    (KVMID_AA64_SYS_REG_(op0, op1, crn, crm, op2) | CP_REG_SIZE_U64)
+
 #endif
-- 
2.43.0


