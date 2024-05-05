Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C3C25B5C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 17:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3fS4-0001mI-55; Sun, 05 May 2024 13:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS1-0001kS-RC
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:01 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1s3fS0-0005iP-EM
 for qemu-devel@nongnu.org; Sun, 05 May 2024 13:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=dvBQsdhoKWzcCD+yDUk815AXmrrJkhfKRJl8yZEaMZc=; b=PygIKR8bGoCBF9ll
 gwWtdJk59KMllGgjEuxzSDdNgS0xI4SV32eSt1I4V2ALtjMivxV43r8zSliVQIukqlg96v0oGddim
 acZ/jStzb8vJ54irbJ3R1pqUmTN8Mp7c3i+qz2xKL17KwEQbBkCfeIzj+QAOuKmM4/Jv01PLYoCYV
 oEIXqORX4I3yCMRJ6Dvcizui56oI7iWLLi61osu0qWotZpRgLZZIPE3UEOU44gSkYEvZKF+w4WwbF
 FvektniCbGbDh1sGABeyqqU+2dDKOi6z35PLptjX3EYbVZ2aBg7OQtsS+Fby87NfU2e5yTSpWgvYl
 mFN4xIBabBmVQyO6/w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1s3fRx-004nca-1t;
 Sun, 05 May 2024 17:14:57 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: peter.maydell@linaro.org,
	laurent@vivier.eu
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 4/7] hw/usb/dev-network: Remove unused struct
 'rndis_config_parameter'
Date: Sun,  5 May 2024 18:14:41 +0100
Message-ID: <20240505171444.333302-5-dave@treblig.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240505171444.333302-1-dave@treblig.org>
References: <20240505171444.333302-1-dave@treblig.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

As far as I can tell it was never used.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 hw/usb/dev-network.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 2c33e36cad..d00d68b21d 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -475,14 +475,6 @@ struct rndis_packet_msg_type {
     le32 Reserved;
 };
 
-struct rndis_config_parameter {
-    le32 ParameterNameOffset;
-    le32 ParameterNameLength;
-    le32 ParameterType;
-    le32 ParameterValueOffset;
-    le32 ParameterValueLength;
-};
-
 /* implementation specific */
 enum rndis_state
 {
-- 
2.45.0


