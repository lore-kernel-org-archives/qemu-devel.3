Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7796CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS6OW-0001Qa-N8; Wed, 27 May 2026 01:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OO-0001Ol-8K; Wed, 27 May 2026 01:01:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1wS6OM-0004Hu-HI; Wed, 27 May 2026 01:01:20 -0400
Received: from localhost (unknown [131.107.147.136])
 by linux.microsoft.com (Postfix) with ESMTPSA id DEC1620B7167;
 Tue, 26 May 2026 22:00:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEC1620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779858045;
 bh=fr/y516bPIk2IsyJ9A83P5Pwv+/iEH/Ermzs0Xt5pIw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QSs+YNB2Fw+GHyGVgYKsAao9QSS5PkN3kyzIOv+2yMjNl55bdkiJRK9K8wOy+UN7e
 rLGvEaYgOo2xTmp82j0lZSTy5UhFV86R5HitdYMuWg0j6tQ4G13h4qEnfR5qGiNjC8
 9IqRr0CmQbTiCMUn2lKCVCY+VZhojR3pu+vRDtj8=
From: Aastha Rawat <aastharawat@linux.microsoft.com>
Date: Wed, 27 May 2026 05:00:51 +0000
Subject: [PATCH v4 15/15] MAINTAINERS: updates for MSHV arm64 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260527-mshv_accel_arm64_supp-v4-15-66d871dcdc53@linux.microsoft.com>
References: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
In-Reply-To: <20260527-mshv_accel_arm64_supp-v4-0-66d871dcdc53@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 =?utf-8?q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Magnus Kulke <magnus.kulke@linux.microsoft.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

Add myself and Aastha Rawat as maintainers.

Add Magnus Kulke as reviewer.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5c4831e2..761f802a98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -611,6 +611,14 @@ R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
 S: Supported
 F: target/i386/mshv/
 
+ARM64 MSHV CPUs
+M: Anirudh Rayabharam <anirudh@anirudhrb.com>
+M: Aastha Rawat <aastharawat@linux.microsoft.com>
+R: Magnus Kulke <magnus.kulke@linux.microsoft.com>
+S: Supported
+F: target/arm/mshv/
+F: hw/intc/arm_gicv3_mshv.c
+
 X86 Instruction Emulator
 M: Roman Bolshakov <rbolshakov@ddn.com>
 R: Phil Dennis-Jordan <phil@philjordan.eu>

-- 
2.45.4


