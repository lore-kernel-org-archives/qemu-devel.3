Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE27C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoYx-00054q-SS; Wed, 06 Mar 2024 05:31:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYo-0004oz-Kr
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYl-0007cy-IA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709721088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY5z0Q70mVP2sc6P4PwS55CFvs8UA0Pj2qrEPrwo4yg=;
 b=gNy0QP3RjK5E48quMtrnS8lQx4UeOOoZlPayBSEZemeefHyVjYeL4L+/E8PdmnUXpirK+C
 L51PowpKgYMwvx5bvnJJZRX94xpQGVfxUelD8KP0oXbkixtsJAaIsHKNLk0TjBdzMJXwLL
 qc6sCJWSsX25Mk+8guCMhB5Et1FJSPbASCCx9dwAPXv1NU6ohGDZHK4GdH5X2trzmhePnY
 H1L0LslkWTAXipCQfO6Rhaan0HS2TO1akrn3sydTn61P1NWm74cu291qeArt+ZFMevaFLW
 UNSxTXI17HQZl6Pil/nUUOamyRiBt0rHvMCU2cvYx8sJqkkxb2ItgwLv0KqyVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709721088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vY5z0Q70mVP2sc6P4PwS55CFvs8UA0Pj2qrEPrwo4yg=;
 b=AKO87j4ALQ3k2I6LAgBUk3v5rP7NdRNyOXAg3MjePj3WB+q7FJuaDCRXp4DrUQYpQPMxMf
 8odDAjk4rdT1W1AA==
Date: Wed, 06 Mar 2024 11:31:25 +0100
Subject: [PATCH 4/4] docs/interop/firmware.json: Include pragma.json
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-qapi-firmware-json-v1-4-619f7122a249@linutronix.de>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
In-Reply-To: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709721085; l=717;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5Dmz2IfF4HypS2lmqdLItaX+F+55t3ea5WAn6dS2/fY=;
 b=NdxPy4RFdHaxkvO55ybQAVT+v9kaPQ+g8YJA9oNHfWFFiZhsI0HjE0ayoyt3ppLFg/DuCuIwg
 qhHke2/8QvkAKR3+vw1gNjOMw83jLkOpyrGVNuXyFt60W5Z+UfK5bxW
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


