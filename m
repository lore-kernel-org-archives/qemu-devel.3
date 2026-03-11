Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E693112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LLy-0003Ms-Ez; Wed, 11 Mar 2026 11:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LLb-0002Lp-D5; Wed, 11 Mar 2026 11:19:43 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LLZ-00012t-LF; Wed, 11 Mar 2026 11:19:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242230; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mjZGFSlSgaCwIkrL7LayG+y0T/AUrxm/lxfSpxtHzviFbp+LyHYGVPI466ZHfl0HIwT0pTumjavK2JHTtYGDrcR24nMG82fQ4F70KIR3mQhgYfEKNLia/KlrrBUla9L5nDzuYRlzxuf7NNDbkpP+byS60oBeqNzQwW/Y/OUwvr8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242230;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=diw+ikQFEGuRZqEiB8tryGpZD6ZRwHVrWgg/iJylPK0=; 
 b=Nu0b3N9IMOtvpkDSA6xRJT+x4R7++Dri4nzLFRwhvqtjuUcghRBDj7vhVUQbf0BOphzu66rKsAxYjpVK39y6mKO8U2xnhe5cFtZhvXVBoFSSAQgdFH5r7UeaybDyjP6+7VwuP14qPFD99FuAKgVjJOp175UsTan83XMYajvZ3A0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242230; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=diw+ikQFEGuRZqEiB8tryGpZD6ZRwHVrWgg/iJylPK0=;
 b=J4xznKLFQ7yCw7Ilk0hFgwODiAFiuJVJSFqQgoay+nWd/wJSRqYWpv1B27x8lhtt
 3+qQhseA+E3WFxWfhPNUo4V5m7tiIp1KDBkCmuJ4QCYYjIpc3Hp4hH2yr7/pHik0oIK
 53F5VgAW3ZxKgqlWOtGfz0xQ5BR1X+WaITv/kLSI=
Received: by mx.zohomail.com with SMTPS id 1773242228842311.86975317946917;
 Wed, 11 Mar 2026 08:17:08 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Wed, 11 Mar 2026 15:15:41 +0000
Subject: [PATCH 14/14] MAINTAINERS: updates for MSHV arm64 code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mshv_accel_arm64_supp-v1-14-c31699b7bc1f@anirudhrb.com>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add myself and Aastha Rawat as maintainers.

Add Magnus Kulke as reviewer.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1614fd7e..e36b10a8dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -606,6 +606,14 @@ R: Wei Liu <wei.liu@kernel.org>
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
 M: Cameron Esfahani <dirty@apple.com>
 M: Roman Bolshakov <rbolshakov@ddn.com>

-- 
2.43.0


