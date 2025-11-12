Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB35CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 09:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ73h-0007Of-Tp; Wed, 12 Nov 2025 04:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ730-0007Cb-JG
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vJ72u-0000Jw-G2
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 04:21:49 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso471815f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 01:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762939287; x=1763544087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=fPfyF5hKVyr3iZa9GTSdpaDHppCHnnEahpbOedK286gV52on7a5yVtbtRQklQ1/smA
 KzjCalrZOuZNgTzE21GBifJu598hNqVV2obK0EFH7WaOJh+N+S1C17B9FmMM1A9Qbcge
 9mUh+LRWL4DUETYcuKCv5yn5Vsl7G8IPp75Wl6PecilXwvDG7vKC851FlPKlEiYpv8ZZ
 uO9w6mE4ekLbjzJlcLKK1f5rIiQVsYmElV+KvJf03QN+rD98VsPwOYqyGCxGeTWeAWQf
 QXOMHkRp8k91jxg+++g5UBWQ7Zo1/2+HjTbZCYnoyun8Y9VDZTE8EWA/YTGROH2+WVgh
 Fe+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762939287; x=1763544087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=fM6r9/D57fg3/AApr9P1uTGJ3uj6jHl4RtkBSrgCt5V0e6lwnIo9Xep28PYwE6lMJP
 eUSO5fWel/eUcA6CfYd6F8Lb78Sb+Ng1NMfw0b7BNPz/GSwiWPopK7c7VL6f2uEmmKMD
 kQ+/LZ+oU71zSAF6eSlm5EVOW7FfZAxFa/aZXdtrAk/21SF2jXQ7lXW2csA7HNqzeLcR
 AJEv3h2+sI2NXkeA40nSSrfDlFaUD8w1yTMVkjQD0v+gmKrsh3tda4nsOmPK6Qyl2MjQ
 2nzJkB2HG4XMTumKFDYOlMPaPXnPoI8hQUwTGlRxC0yilRAs5FBXfdzfGeYO3ZQrz9hp
 6uBw==
X-Gm-Message-State: AOJu0Yzxz+TL0ih5+4EbRsp5F7/aO3xZsMd2Zzg2SJxwguM1mNt4cQHc
 qi2GSfvJ3NksEZqFkaQf1+HL9VDHFfpPG9UHgUc8l9P6qc1IhebC/Qtoqif5LjM3HWSV3j6IXrM
 cMf1SpXg=
X-Gm-Gg: ASbGncsLqRvxMOw4B7BBCTSd9m6y2vOKtolEAxuBJt8oxYYuXrxMwTEjYBsSMzhog8+
 G/kWK/6LxjcwhwP7rNOOptyOvF+oAXMdXQKWt2R/BuogF/gyd6s3ekOLl3aYu3aoptNHFgIrt13
 Q1ToiVV8NGMh0LKt2alNICIDy4QyrowdSUDA3vqLEaVg/OdMEQ5i0kHndNxCKvASgVn4F4uCjKv
 ZyJG9fXR5+iXqHez3XxlxNkSwNxhfaFzrBpDKNyNCp5GBpDbAiTjd4sj7009HkIEgA+xtgStF1L
 AjsBEJ2zy9p306siTbTKHzVbgSFD/3owzkbnAty+tYNRmj+ymiXyQgRgDpwkWmD3hXHgxVb3Mg1
 pUyjwUkFIHhBlnZJhx9ZQUeOYNXcVZC6IC4ELQTWzhiNMYd/DT/pRI19FOyN7i7l7ji1hwuChkk
 h3
X-Google-Smtp-Source: AGHT+IHFbuEN5HICSyOn0+tfLKgeGHIeAIzmuZNoT6F1/uT8jvGGVcVFbg1iMuQG2/d6NX/1T/vcLg==
X-Received: by 2002:a05:6000:24c9:b0:429:d170:b3ac with SMTP id
 ffacd0b85a97d-42b4bb8f198mr2228118f8f.13.1762939287450; 
 Wed, 12 Nov 2025 01:21:27 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:df7:7499:aeed:c296])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62bf35sm32572495f8f.7.2025.11.12.01.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 01:21:27 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 1/3] target/arm: Enable ID_AA64MMFR4_EL1 register
Date: Wed, 12 Nov 2025 09:17:50 +0000
Message-ID: <20251112092048.450090-2-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112092048.450090-1-jim.macarthur@linaro.org>
References: <20251112092048.450090-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..c20334fa65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0


