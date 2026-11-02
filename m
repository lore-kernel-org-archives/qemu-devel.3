Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE98606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Qome5FX9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNsDM-0003hA-P8; Mon, 02 Nov 2026 08:36:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDD-0003O6-Mp
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:35 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xNsDB-0002KN-Vy
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 08:36:35 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so3082221f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 05:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793626591; x=1794231391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=54xZs65WkcRPSZeKsXI8ywihGTRL8YnDiF0FalkdAzQ=;
 b=Qome5FX90zDttRN1JURz7tY2T2Nbi+WwPgf0teEP9/qEI5GN+XV1+4ZOnCkw0kcUOs
 mcKnu8SMiIp2oFbyEu8ZUHW3Xmfx+tuGq1b8+SzHF29f9aRxqLPgxjWkc0jklfSmeYs4
 21IILyVHTy7dhz4SjcfpBfeUA6AynzipNJYumEemAQ9idkBLjC8VT8tU4KS91e8+DyOT
 HtWF5OkgxuZYG5YSOhMXX+3qIiwjxGtjKrJ97PN8yvcknIu1tktlhxwsco+12JDVuBzD
 z39tZ2nMOTMBKnwc7ADngyOYMmfwzyfuxjjKFtWFOz1s0/i2IHMfi0Ngu23EMb4GQrlB
 Rk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626591; x=1794231391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=54xZs65WkcRPSZeKsXI8ywihGTRL8YnDiF0FalkdAzQ=;
 b=QAfgNeEXIx4qOu4XN9sqQumBzZtN508QjAe9jPkQElW+PLQGI+66bk/zbDYllSHyFv
 MTXY2ASoO37NoKDinqO7cYwyswpNj6tiP8yFToRvEFRrNZaKopyY94wvm6mwbyRzYaW6
 zDvis1xJ/N5GDJETUdHGoXeLk7lrKZvFAEyFSPLYWceK8Ydhnu//IRugeoQ0J12+sDo/
 n3FQA0Z3jWRZ3YxSabDgv/eVc+bCuO7/lHW0b2Xhajh6DoWcMcuyGGwtfKjwk/1W6oAg
 KgLaT6lgXhxeTmYbGQYuiiyQZshO2eh6L6c/W0aVNNU8OZcjLjw9gf2wALsMDxz0Icir
 SGKw==
X-Gm-Message-State: APuU4Z/SOl9px4QDIIi7tkuXN0a0Stg74V0gga655NL/Y/MxHQwF0BIA
 eCbc7X5FgsnBx5d1QnrW5ujotkljswLolRtmjOT/R9E06+hH08Qcj+jWTG5thysEcI14cAlP9PD
 8AKMx42w=
X-Gm-Gg: AYBFou28hgXKUbiN+0n4J5tK+3BV8xjm7JjHkyd8yx7Nlc6D0cWbQVRqXF+nroP+4Y3
 IYc65baJLTcTaw8dX6VSiJ3vceLb0oZ+vx0kxBlSazm7RMwZradxpf1ZDBRJ9gZxoX+xAvz4lKF
 udQ8CJwRg6voZIn4B/u9CB/NCgKl6pdMatgC0EfOMZdWUes4VJiy0712BUW8kqJXLWsbM5DbQsk
 DrvDpb2HHn86susNY3T/wMMKTZy6Er3T+Ezx2ELJZHdnb0izbJBnqSuqbW4y6J8cuPqp+2uokwQ
 q5g43bQQQz7q6if/rBf9P1A51qdZu5UHYdoGC+sP1WvfDjKeh1A3eVlL5RnjEqPv31a/Pcp3dox
 SJtalZDjx/+12hhQdk1TrJwMW+U5kKI6db/+NmCPPGkdF66IntqzEcUZH04ewF9xrB09gQUdkkq
 COkZJ8zEdBFDBYAzsEAc6vf0Uy1QqFBkDJJg/Ag5ZShsSpdkxPDGt/wCgoeJW7tNOaxVePI1hpp
 9DtNWmI3M/m8voQD/8n7OuQ0CJTyEdBgFGQLtpfRpGWQ+TMyyVyvXLOAOAVk7WuGU63EXSatILG
 4FlXP5ohf+7xXdVnGRbm2f5owDeIKbdZklIeXtzvVQiVxnPYJTgLNxUKrUn1/mpjSldZO1IKyRN
 W2GUFFQYPbv25Sm3WTThYhthJJlpoJDddXlzMVw30hR3mF4klb7pHov0=
X-Received: by 2002:a05:6000:4559:b0:48d:ff71:dd97 with SMTP id
 ffacd0b85a97d-48e6e2bdd94mr15645289f8f.7.1793626591260; 
 Mon, 02 Nov 2026 05:36:31 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm22556760f8f.6.2026.11.02.05.36.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:36:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/47] target/arm/cpu64: Define cpreg migration tolerance for
 PMMIR_EL1
Date: Mon,  2 Nov 2026 13:35:37 +0000
Message-ID: <20261102133547.1375701-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102133547.1375701-1-peter.maydell@linaro.org>
References: <20261102133547.1375701-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

PMMIR_EL1 is exposed from Linux v7.3 onwards. Backward migration
to an older kernel would fail without cpreg migration tolerance
definition for this register.

Since qemu does not set KVM_ARM_VCPU_PMU_V3_STRICT the guest will
RAZ this register for both the old and new kernel.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20261030143435.57230-3-sebott@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 2eed467f5ae..159bc08b73b 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -787,6 +787,14 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
     arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 10, 2, 3),
                                      0, 0, ToleranceNotOnBothEnds);
 
+    /*
+     * PMMIR_EL1 was unconditionally exposed for linux 7.3 with commit
+     * 453f6ff04b8d ("KVM: arm64: Expose PMMIR_EL1.SLOTS under strict
+     * PMUv3 UAPI"). Tolerate backward migration to an older kernel.
+     */
+    arm_register_cpreg_mig_tolerance(cpu, ARM64_SYS_REG(3, 0, 9, 14, 6),
+                                     0, 0, ToleranceNotOnBothEnds);
+
     /*
      * KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
      * from v6.15 onwards. Backward migration from a >= v6.15 to an older
-- 
2.43.0


