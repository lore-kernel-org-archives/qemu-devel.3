Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA1DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCVp-0004KI-Uz; Thu, 07 Mar 2024 07:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVk-0004J1-Mq
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:08 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVX-0005NV-8w
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:08 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709813142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJN5C7mPg4JpTDfs4+Z0qlukHU9wN5HwlA6H1wdCiPM=;
 b=zXInkvftyzufq7B4w8dSyDHOZ04MYu50941ddC1nLutoTbM+79gOtCk7CaVGfjcV6p4PfD
 pW4iRPShzsVtksgkc2NsEDtUvZceoMrO/tm6tUKs6Jsfgeno9s3E2I/jWyFp0Hc1lVDjZm
 u3K2KtENVcwPEcfrhhHkFR1IwIGQvvqlfxlm+tNXF1LBkGDQdWImHVXVQrM+J/wkIzP+YX
 Tgj2WMz591dFP5/iWfsDQigfri0186PRZPnVUjHbBeRPUG2DcyHDQ7hbB2IkHAN3HCVToH
 2LDWkmDxGCvRtJOlv+IjUTKXhxNJjaKyNBpCSkAxGq14XfmsoAvF4sPw8jKJ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709813142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJN5C7mPg4JpTDfs4+Z0qlukHU9wN5HwlA6H1wdCiPM=;
 b=vhwfWVsScftblelYX7S/vWnBodvWqg4EkimEJZCapt0qivl6rVTk+VY80MabC60W2Esxk5
 NpCOv36GaoILkGAw==
Date: Thu, 07 Mar 2024 13:05:36 +0100
Subject: [PATCH v2 3/5] docs/interop/firmware.json: Use full include paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-qapi-firmware-json-v2-3-3b29eabb9b9a@linutronix.de>
References: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
In-Reply-To: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709813140; l=692;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=edhsrNNWkc8ZNoA2dLKp83fwmLRb+lKMvBbZImT+cGU=;
 b=R9NFmz752ponVr+LpPHRsQE6WQ/7GKUQW51nEjErILFPbQi8avj+4dPlDENGTQSxRHXfdik/Z
 BCPYPg+4ZjqB7vOHTE6jwI0YrDrbjtpwFC3W9M3RIZZtDv3XrSQP2pK
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


