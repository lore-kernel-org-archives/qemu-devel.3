Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090AFC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGEq-0001Fy-Mq; Fri, 11 Jul 2025 12:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaG3I-0003YU-4l
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:52:46 -0400
Received: from quyllur.org ([185.247.226.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <unisono@quyllur.org>)
 id 1uaG3G-0001q0-Ig
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:52:43 -0400
Received: from quyllur.org (localhost [127.0.0.1])
 by quyllur.org (OpenSMTPD) with ESMTP id 1d1f21e2;
 Fri, 11 Jul 2025 18:52:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; s=dkimselector; bh=5aq6QtDa6VajchZx0
 TztYXXq7FQ=; b=VSQLMyamDwXVR8l5UAfixx+Jtwh5W0ubEgQNoErWjdILLGwut
 TbasAFwfsgWRCAD5z8icb0/CacpvsShJurqUrF9XyRh8o75eQkH1WqYuHRw5fYfD
 Vso/+yPV+tPrvszCvJDNKuhLpEUbA5Gr+1XzgdkRhwcCgLlThSun9FAQMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=quyllur.org; h=from:to:cc
 :subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding; q=dns; s=dkimselector; b=GW3SsBUw4Og
 s8oKLZqyd4cH/PD6yV/JQwME52uA3ueVBcoJbNGdBRFcfNh37xyKNUR3dq4Hpq46
 mQ5t7MlGRj/Jjr913s7D7oYyV42kBQo2GZp1Mv6+Zuk5k/5xfj6lMFiIH++0HD3S
 H09uURZDW61du5VMdHTmnBFwU38MJNc0=
Received: from Rizin (<unknown> [194.127.199.111])
 by quyllur.org (OpenSMTPD) with ESMTPSA id 35c7895b
 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO); 
 Fri, 11 Jul 2025 18:52:19 +0300 (EEST)
From: unisono@quyllur.org
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, atar4qemu@gmail.com, laurent@vivier.eu,
 mark.cave-ayland@ilande.co.uk, philmd@linaro.org,
 Rot127 <unisono@quyllur.org>
Subject: [PATCH v2 3/3] Assign the GDB register XML files of Sparc64 to
 Sparc32plus.
Date: Fri, 11 Jul 2025 10:51:41 -0500
Message-ID: <20250711155141.62916-4-unisono@quyllur.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711155141.62916-1-unisono@quyllur.org>
References: <20250711155141.62916-1-unisono@quyllur.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.247.226.42; envelope-from=unisono@quyllur.org;
 helo=quyllur.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Rot127 <unisono@quyllur.org>

Commit 3/3

Signed-off-by: Rot127 <unisono@quyllur.org>
---
 configs/targets/sparc32plus-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 7a16934fd1..0d9cf44652 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,4 +5,5 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
-- 
2.50.0


