Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB3DC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoYw-00052V-Ni; Wed, 06 Mar 2024 05:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYo-0004p2-N0
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYl-0007bw-50
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709721086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLvei/7SjNo1C7eeQ57fgkVcOpg2dEkc12NTAQRgSoY=;
 b=dFh1pLdJhbbsbtok+cM2nAjaaPXMas4WFiz3r8ux3sl5g/GkhZsjLvZh0nzjE75mIVxTTb
 Q6VM+PDjlYeTfQBnXMs2hQK26PvQti21XSpvk0EJwgG5xj8QQS/kO3ulZLQUOHph3a34RY
 dzUeYUO2jJL1Ra4W4obtkhbvFUctXZCPzOpR9AF+b120msGeWddhsiqbJq8LIwOGIw8Gms
 J2Z6YLiKM1PFbs69qVQsLeco3f+Z4z/YxjFE5JKrT1ytQ8KvdXnCufVhikv/414r1N80HW
 d/NVVyBX0lyA20+u1Ri0EW42rL2I7RBijLuz4yh52xrOnAQq99N6DvDOscjeCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709721086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLvei/7SjNo1C7eeQ57fgkVcOpg2dEkc12NTAQRgSoY=;
 b=dIg+ir79zt/FawlNOx3YfvbQxbab9Zl9Rj39h+0ESCPNNSJPdw9huNzrnwuVMe1hCdLCZ0
 zq9Z7blBAOHHGvCw==
Date: Wed, 06 Mar 2024 11:31:23 +0100
Subject: [PATCH 2/4] docs/interop/firmware.json: Fix doc for FirmwareFlashMode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-qapi-firmware-json-v1-2-619f7122a249@linutronix.de>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
In-Reply-To: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709721085; l=574;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=nd6zJx5lTfT4sj5BfIfSp3ZUom3OUMO1Z6kseUi0TQs=;
 b=n3C0Wbf/WzEzHiu5K6aojgFm28m0SYYF8NZsphtAJC6xx8RPfze4+GHRCgiSPE6jDVVVmmH6y
 TJIY29RWNaACwSNXBJLW1KOrD5xyyM5galexOIghAHCnR/vruYwutZd
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The doc title did not match the actual definition.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index a024f1b9bf3f..54a1fc6c1041 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -223,7 +223,7 @@
 
 
 ##
-# @FirmwareFlashType:
+# @FirmwareFlashMode:
 #
 # Describes how the firmware build handles code versus variable
 # persistence.

-- 
2.44.0


