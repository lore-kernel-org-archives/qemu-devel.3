Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA1C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCVj-0004Ig-RE; Thu, 07 Mar 2024 07:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVh-0004IW-Va
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:05 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVU-0005NQ-TK
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:05 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709813142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDJ4WyDiRonQJjHk+OC2X9TomiEYD/eSMnpE5vNGYEQ=;
 b=31QBE+/bqMJtxCjIkY8sHlku5Z00jD5lywtpbGgidJc7CiN3T/7pLUIiKPWkpM2DHTofBn
 saHeDZyKejZw2pbBpXDfMYQnsHEXX5wRIB9esiqdZKwdAWrETfR1IHVg4gujUeXxSPd/f/
 kj9w1AbKBitk79FhSuDhX+9UixbXtdpxOkTFQQbVoc0dCqitutSxJ10EuPbs8fKaMF9Q8y
 ZQJyikJ/GdUlaH7K3w2s3uDpoxoTNu3g5sRLRCKBu7PXhd7NN4CJm6+HY9ylQ463iLRm+y
 j3XtTDiKCXPTHIRBQ1Q27OYUyc4a4zvlkwlPmNrYjSvtH1PmSud3HiumYWtN8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709813142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XDJ4WyDiRonQJjHk+OC2X9TomiEYD/eSMnpE5vNGYEQ=;
 b=JWxVyzDt8HpyNfNvzwnhsmrAbA0jhW/OGFguHaMbxcj4RTPL4ICeOWiUEPajJCsqaGOSXF
 iRK7edH84eFDBzBw==
Date: Thu, 07 Mar 2024 13:05:35 +0100
Subject: [PATCH v2 2/5] docs/interop/firmware.json: Fix doc for
 FirmwareFlashMode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240307-qapi-firmware-json-v2-2-3b29eabb9b9a@linutronix.de>
References: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
In-Reply-To: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709813140; l=717;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=iwgp+nFvI7bz1Mz0mz79uwGg2lN87jgjKTie/Dtnj+0=;
 b=xSNEy5N40RGLyDo99BfCi2N+Ewb9HZizqVX+tvf9edDbRTRYL2+3nC1HVuqReHnygS7d711cK
 6Mp6erhzJ+gDLiNpkt3YWqQHAvIz12WpGsZ8vCZb08Gof1ci5Jq9yPL
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes: 2720ceda05 ("docs: expand firmware descriptor to allow flash without NVRAM")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


