Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE36C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoYs-0004w9-TS; Wed, 06 Mar 2024 05:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYn-0004oQ-Nq
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYl-0007c1-4v
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:41 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709721087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJN5C7mPg4JpTDfs4+Z0qlukHU9wN5HwlA6H1wdCiPM=;
 b=TdTfq+Wvof3D3EGlugd1qz+oCdwtAgbKKpgsm1sdN86NjgrfYZBxKzXUq+iUYXoBdX41Dv
 Hb4Pr9zNzUJU5mmRq5ItoDnLMZCoRAZKjYq2egnNj0v2yh+dPR8e3j9AHze8WKgngTUd5s
 IULIadE5V7+xSmm6gqh0iUrgG3XzKEkPzOtmiSk42Qoo1TFfRzQa3BAL26MemuMLG0f6rq
 9xLGx4Bx191hIqLrAM1tCE2aXPrrqWsZGgoYQ+s0ouWCI90L8PFXdBe0iVYTZVaw3WN1oH
 1+hPXttiU6r37u79IgUg+ebexYcPv+JoErwIgrpqyPj356PsAOnoL2vz6oLBmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709721087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJN5C7mPg4JpTDfs4+Z0qlukHU9wN5HwlA6H1wdCiPM=;
 b=qvjiTQSFvBpV/5R33i1y6QCPYDzkAQ39TrGdzOPflGHB8hQWXo0GSEz7ksm/6BwRu6t3gZ
 QGp9UosJbyTLOIAA==
Date: Wed, 06 Mar 2024 11:31:24 +0100
Subject: [PATCH 3/4] docs/interop/firmware.json: Use full include paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240306-qapi-firmware-json-v1-3-619f7122a249@linutronix.de>
References: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
In-Reply-To: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709721085; l=692;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=edhsrNNWkc8ZNoA2dLKp83fwmLRb+lKMvBbZImT+cGU=;
 b=WyctScn4oRfEehHAbO+tqWCjC18VfFrO6879EA7ReQSI4cBFFDZa3n2cO/0qRGlhaPl9M2/hF
 PytBMjxn0pkCgkvGV94qKUQvKXYT3w2DbiWhSmKtyhMiLLcMrzqRy7f
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

The included files are part of the toplevel QAPI directory and need to
be included from there.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 54a1fc6c1041..4ac840e2b413 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -14,8 +14,8 @@
 # = Firmware
 ##
 
-{ 'include' : 'machine.json' }
-{ 'include' : 'block-core.json' }
+{ 'include' : '../../qapi/machine.json' }
+{ 'include' : '../../qapi/block-core.json' }
 
 ##
 # @FirmwareOSInterface:

-- 
2.44.0


