Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37520D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSW2-0002NY-HP; Thu, 15 Jan 2026 13:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVR-0000jM-9q
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005wx-VQ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso762395f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503333; x=1769108133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5Cau6/2yzQZEna3TOFcOvbLNRZLiSt2qOjwpRD0Axo=;
 b=NxlU559OForscdRDB2WfmZnpAhZAneyk3Ycr3WfqwQQDj2PKdnp1EadvS+nm8RdFv2
 Gj9p+A6kLO0CVtXw09opqpyFC3lHHdt0Cl6/nwGXxPHTtd78CmnhDzqVu3mR5xOKp2C5
 NoYVTgmyJHbh2wGwje8yX/COoFD5W0LvCLGFBhPbFO8J9BrE728krlDEA79XN7xfkhei
 AeM4i2UQhKWC1T9kioc84cTBkZQSAPOV9TyoEjlOs0MQMVHnZXqStiHhXVhOgGdrXtGE
 w5bD7FItUAKe57/VIq1WsGp9mKMn4roQHdOum0o+gC+hk5mBHHJs9f2aGiroBVd1VrHF
 AAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503333; x=1769108133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x5Cau6/2yzQZEna3TOFcOvbLNRZLiSt2qOjwpRD0Axo=;
 b=CDZegl/2UbLWJUoBCrORHaO0zAGCEV204WHzBFxbaqbLKzrwHvrW1Wc35Rh3g3M5xM
 VgVixNKPiEbqKMLDxilNBgCKIlKp3FCISBEgrxvHCW4QAwEOvqii4mJtuHiFe4nOU9ml
 e++/+FUc0xkSh1PSF+/TTBegBhNWxqqZ27c4dH8M7t1016PDUe0sNvo1UUPydxcxIhKB
 6cAGj/VK0myjR2vpFRQ2sfb9Zs7y//n5vxDtryhP0Ztdl/yTpVC6k2AIg4ZkOUYZR6M7
 C9GxC2VWiigPlHbmfXYhFVWOEveZzY2N2Nl2ssg65fD6vFHopoHAugDIZuMoH02wO0uq
 w8uw==
X-Gm-Message-State: AOJu0Yx6PD4UPpyiRk1x/9Dp8eUjzdxfTB57C/sZ5ySRe5finhhl0SHQ
 DmtKdm966J0Wo2wA4CeJhOYnqE2Q7MiFtlC4mRdnW1DIANJChYlggavzH2Z1c1vCcU4Aa77RJie
 P/x9E
X-Gm-Gg: AY/fxX67X8CbHaBPyIXSkzrPCMp8SSr+VLNK9khVE3s945D03fBOWGavv4+xHm17PVa
 vtsanu5CXiEEgepyQiup7AAtzFMATU1Q6VujmjDQOLSmB7Ac33+QHQFcWEDZBrfwvoIThK33lny
 u+U2QvhK1dzvPgRQOsewywVZAM1mmFGmc1rIn9E63aJ+kqxkdqYIdoSnqPxzviHHcs7cMys4GQ3
 5ZVbVINlLc6WLDmo0cJdZO1XyxZbnAsAyVTooMmUl9Q7/hywRS0YlX+mGjG6rV364F4MN69JV0k
 /0ay+kwAoe4eOj4QigoCqd2WV4/HzOmX7rwJsEas5VReElkPihz4jK7t5uc/AR7AaIosFsAFu7Q
 rN/cWiJO1mS1caV9USI09MyaMcIiHT6oIBa9cIr++QDMmtxDpu0tIvKXNJ22Ousn2r3rDxm1TG1
 iNHNAc5PHDUJN3YhIZ0GBArke0l+KbhujpjTGNcYDxzOlLjVSmRR+oMJY/qHMahR98ABIg3Gjhf
 XAjJvMQ704NhT3L1w8YljCt4nUVuAjVu8CNB8Xyc6zVqA==
X-Received: by 2002:a05:6000:184f:b0:42f:9f18:8f59 with SMTP id
 ffacd0b85a97d-4356a060d83mr358255f8f.42.1768503332815; 
 Thu, 15 Jan 2026 10:55:32 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/25] target/arm: Rename access_aa64_tid5() to access_tid5()
Date: Thu, 15 Jan 2026 18:55:07 +0000
Message-ID: <20260115185508.786428-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

There is no equivalent access_aa32_tid5() (HCR_EL2.TID5 only exists
starting from v8); rename access_aa64_tid5() to access_tid5() to line
up with the naming we now have for the TID1 and TID3 check functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251231170858.254594-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index acfb2cbc31..dce648b482 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5429,8 +5429,8 @@ static const ARMCPRegInfo dcpodp_reg[] = {
       .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
 };
 
-static CPAccessResult access_aa64_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
-                                       bool isread)
+static CPAccessResult access_tid5(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  bool isread)
 {
     if ((arm_current_el(env) < 2) && (arm_hcr_el2_eff(env) & HCR_TID5)) {
         return CP_ACCESS_TRAP_EL2;
@@ -7467,7 +7467,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         ARMCPRegInfo gmid_reginfo = {
             .name = "GMID_EL1", .state = ARM_CP_STATE_AA64,
             .opc0 = 3, .opc1 = 1, .crn = 0, .crm = 0, .opc2 = 4,
-            .access = PL1_R, .accessfn = access_aa64_tid5,
+            .access = PL1_R, .accessfn = access_tid5,
             .type = ARM_CP_CONST, .resetvalue = cpu->gm_blocksize,
         };
         define_one_arm_cp_reg(cpu, &gmid_reginfo);
-- 
2.47.3


