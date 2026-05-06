Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42B9CD3436
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZOJ-000645-UT; Wed, 06 May 2026 06:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wKZOI-00063r-2c
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:22:06 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wKZOG-0004dq-Hw
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:22:05 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.68])
 by linux.microsoft.com (Postfix) with ESMTPSA id CCB0C20B7165;
 Wed,  6 May 2026 03:21:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCB0C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1778062919;
 bh=+EiWO18oybcBpodGldlQ16X2Wy2rPFercPNx9NA+TZQ=;
 h=From:To:Cc:Subject:Date:From;
 b=exSUEDOZAu49duk2L6EviXR4fXU04DU0uk29cJg8GhJBayjfeTHLBJ5h7fjv1L2Rk
 E2Rzs1qBzC3BiFaT0AC/iIdgR1IqaFyM7M9d78UNhlGBxYdkq7Pu0S0+jil5UxhQhe
 ttquUvaoxVnvSpQgesc12v/Y9stFGZOElTBDggXo=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>
Subject: [PATCH] =?UTF-8?q?MAINTAINERS:=20Add=20Doru=20Bl=C3=A2nzeanu=20as?=
 =?UTF-8?q?=20MSHV=20reviewer?=
Date: Wed,  6 May 2026 12:21:56 +0200
Message-Id: <20260506102156.501805-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index afa178c5cc..c6c0e1b4ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -587,6 +587,7 @@ F: docs/system/whpx.rst
 MSHV
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
+R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
 S: Supported
 F: accel/mshv/
 F: include/system/mshv.h
@@ -602,6 +603,7 @@ F: include/system/nitro-accel.h
 X86 MSHV CPUs
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
 R: Wei Liu <wei.liu@kernel.org>
+R: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
 S: Supported
 F: target/i386/mshv/
 
-- 
2.34.1


