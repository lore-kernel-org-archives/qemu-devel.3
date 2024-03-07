Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80239C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:06:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCVt-0004LR-Rj; Thu, 07 Mar 2024 07:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVm-0004JZ-3U
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:10 -0500
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVX-0005Nc-91
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:09 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709813143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY5z0Q70mVP2sc6P4PwS55CFvs8UA0Pj2qrEPrwo4yg=;
 b=rpHPWT5j736EUymV9YIQzw2u2uPQ5HwkiapmX57jLssPh9AIMFJLmI1ydV6t0bfv91h2Ww
 ZDOVrLYGetZ2F7LNvEHXVeLKyQV3XQwxxooWdZATkUV9+rDr3pjuDt9s7WzAY0rRorrLAQ
 q6NVN1WlKI5d6uToW2G65D+28S/zpPOw/FV/FguuU6eRS9zdYfUfYoEib8JAs8vpCqfY2g
 dseZceljF0zEeXM1u8w7VreozN203hcUSPDKbe9/y76NcMbUPTgzDf6SfSteVdpUoO5pUO
 JJjszkKJ+aIH7mf7ulyr2XzjORjwVU//yiAJUuU90sGoGpK8aa1qBbwm9pXQYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709813143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY5z0Q70mVP2sc6P4PwS55CFvs8UA0Pj2qrEPrwo4yg=;
 b=vUr3eUgM+qRMYqfesrGShcJtySz1q0sNyqzqENnzsUwNbzN3wbpURLOLCkv270AWHPZiFQ
 KwliTxjZcGAP0lBw==
Date: Thu, 07 Mar 2024 13:05:37 +0100
Subject: [PATCH v2 4/5] docs/interop/firmware.json: Include pragma.json
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-qapi-firmware-json-v2-4-3b29eabb9b9a@linutronix.de>
References: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
In-Reply-To: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709813140; l=717;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Dmz2IfF4HypS2lmqdLItaX+F+55t3ea5WAn6dS2/fY=;
 b=pUFZfZn4HeX5EvXXHmHtImaqSnmdNB+P5vaWvpb4b0luLLwVMXJNXs3MGaegpc1Mb1YqrUnIB
 a6gES0rOwVzAgvvWc/cMw3kFlVR8qKr+5xW+AuSwJz2D/3mxiObxM2f
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
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

The files included by firmware.json use names that do not satisfy the
generators requirements.
By including pragma.json these errors are suppressed.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 4ac840e2b413..a7e9a22a0046 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -10,6 +10,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+{ 'include' : '../../qapi/pragma.json' }
+
 ##
 # = Firmware
 ##

-- 
2.44.0


