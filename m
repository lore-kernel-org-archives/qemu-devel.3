Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92552606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zG0mhuUS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsEJ-0005lo-JC; Mon, 02 Nov 2026 08:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDC-0003Nt-8v
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:35 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsD9-0002KA-NR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:32 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1680770f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626590; x=1794231390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPPVX2OXNoHeGPMSiBiV6sfdJ9MTJ2NXzgTWKyvy44E=;
 b=zG0mhuUSVu59vf0DNz+RefvT0UgqH2+A0XEZL6yFbRZBbkgm+R/kkPuNYX8B7i7MFx
 IY8I7PCWgXxd8MevrddGkXxVRq3yzwy0Kh7P0Wzrd9QeaZHqsRQ+xWYzC0HhRX7clW4B
 PTs48eP9SaRpJYFXMA+quisTmpRci+oUd5przNvo5BnTSJ/OMKnzfoRKHACbHzsglm0U
 b/DsxffOwF0bodCGBm0lvwtftIwfSp8SDysaoB3bTwhpfgTKUVktUK9tfEvwAE0NkCcC
 a5IGp+eRjV8/u2Tkp8V+6W/D8rhuJFCBrAna0x7YfLnakI+BELRb8+o442ux8sGRdAq+
 OSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626590; x=1794231390;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EPPVX2OXNoHeGPMSiBiV6sfdJ9MTJ2NXzgTWKyvy44E=;
 b=BpV2pNcNqqvbJP/jEdJ9QMDlwawqZPWCUVu53+5Mml94dNQUARFbLCALNA3irxNPGK
 SWPM4cBwizfGsrl1kBMuzv5FxpSYPW2qvjd1LtAFHu3i5rGR/WEgKkGBOGhsnfs7zbTM
 TNyQWAggPYZRB/nXQTHWTLqtMlO2LuIXEjfZWqpoEFoMlfJTz9raKGpi/+B17Ia2YCBE
 Zqo1WWkGfCbLJ73L2B9xnd9U7v9ggNTDjU7E05NYyfxUOkfMpjlykIGxhjabVh2YTuSp
 s9gLvMqOGdKxThCUqgKqEjTAhButg/oqmDwdE+XQ7T4ZiGNSU7HuLY23yQojv3WLkL7K
 2TAQ==
X-Gm-Message-State: APuU4Z8Hdx7KGrBRy/z3Na2/qFuitwmlyDcluKxJ2LhBG4VZ8Dw6prIv
 Vq5Tyz9koJn+XvUTmgKbSlT4OAJEJbHMS83ARFcqKgUbVtbs+WmrLoj/lVT0iR249p7ubtDIBu7
 2m+/PoTI=
X-Gm-Gg: AYBFou06FEVq1ZVmID3j/Bsh8JbGC0M5m2JEgpyK5jxS3AJJhIsIGIMjB24OBfdMR0g
 IgghAHoqdMaNDmFOB57i/xD7ZPIZwg558Xv2mTAcn/cP+tczl7I7lBBXeOEMstyijZq9HiYuUca
 vlltwXIuPZCAwxuG8vo+NShfyxAifVD/naAbckn5dy87VbfsVKUXqnSOGmHXLIN2SiM/xZ0nyah
 lF0gOO/lV2KrCOn2Mg5fQXe2VTJBy9k+6JIBpz6VLfPBErBNr8IcLIE6pP+8DZ7mBJryaEw931L
 CfvKnC/HBsmFuqaqX/NJQ7HHmgeQgzL+OfsG1mftvTdVhOmLiJtZfPIOLkHCOLQWPiRlk/Z7ioi
 hbKQKtNcT+ZiND3PP4RXrR+lcP7WzuE85FAt5DDVezP7x68+PhHTPe1+mjN6CMXp0M8QAbCrJbz
 cM3DrN/yAJTwV2SRoVopxVWku620jRhZYC2KqTV7JFJUEauL5nU/oNeG+zuvkHYLSeCo3T677Ii
 NGX/kb3RqBYLHcAPDub/dHbzYkYqESFKQsCnvCDhV18wjMqYp5ZayeY46W3f+ZDI/sm8K4ao298
 y8Aw5EyBSEL6m/DBptNQrW4n+4lVTNAv4jW3qnOFAE6H+Xvh2rOcUMM8ueAwPi2HbzYMTxjwjWf
 Y0LxWM92I3TAA04SBSPqhHSGwZ5M7A5p8pg==
X-Received: by 2002:a05:6000:29c9:b0:48d:ff06:c634 with SMTP id
 ffacd0b85a97d-48e6e5036ecmr13034843f8f.54.1793626590244; 
 Mon, 02 Nov 2026 05:36:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/47] target/arm/cpu64: fix typos in
 kvm_arm_set_cpreg_mig_tolerances()
Date: Mon,  2 Nov 2026 13:35:36 +0000
Message-ID: <20261102133547.1375701-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sebastian Ott <sebott@redhat.com>

Fix a couple of typos and a #xa0 space.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261030143435.57230-2-sebott@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 64103df0a7f..2eed467f5ae 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -771,15 +771,15 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
      */
 
     /*
-     * TCR_EL1 was erroneously unconditionnally exposed before linux v6.13.
+     * TCR_EL1 was erroneously unconditionally exposed before linux v6.13.
      * See commit 0fcb4eea5345 ("KVM: arm64: Hide TCR2_EL1 from userspace
      * when disabled for guests")
      */
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 2, 0, 3),
                                      0, 0, ToleranceNotOnBothEnds);
     /*
-     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionnally exposed
-     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
+     * PIRE0_EL1 and PIR_EL1 were erroneously unconditionally exposed
+     * before linux v6.13. See commit a68cddbe47ef ("KVM: arm64: Hide
      * S1PIE registers from userspace when disabled for guests")
      */
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 2),
-- 
2.43.0


