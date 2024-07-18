Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQA8-0008BI-F7; Thu, 18 Jul 2024 08:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA4-0008AD-FJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:04 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA1-0003tZ-Cw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:03 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721305379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1DDecY2CNs/KYlhESu+7Ks+xwCfoEqrer8QTqku9Jw=;
 b=BH/MQ/5nM7KQPENOjMskr5NzC9/TyRRCcDjfO5fYKOV9pgwhzTqw+67Rb79uDSClqiWB+1
 EX2N/tZJiR0s0DJZlKGuhL/rVsYr3TMvusDfhs5/jtHQmeYoVnCNKwN0T1dKSFtleTPxh/
 kvMpA0TX8YppT0eYZCdA2TgDimj1gAr4j8m4LHad96EHamq/NMRtQeZo+44af1hmRUov6E
 aetXD8xMuPMtKjYCj4CzdzKk2eZW0zml54GRyKDKEwn64jmm86/8ApNPWHit/WjLQu993Q
 R5tMsbhY4YxbOTt4SSwZCdV5Tm7H+dlYUUdT0Hy4JniOlpfaYF/UVavNClcOPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721305379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1DDecY2CNs/KYlhESu+7Ks+xwCfoEqrer8QTqku9Jw=;
 b=qlW7+JqbZjDFazV3ZUgxLROBJBEysxdimvW8RpHO75Fks5Q6CTu1+9+07ZxrOHGWLclBiN
 lsYpzLxmGOEXSlDA==
Date: Thu, 18 Jul 2024 14:21:47 +0200
Subject: [PATCH v5 3/4] docs/interop/firmware.json: convert "Example" section
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240718-qapi-firmware-json-v5-3-0dba12d7aaf5@linutronix.de>
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
In-Reply-To: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721305377; l=778;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=x/QTmRlQohiKwdha1V5OaaAH5ZGyY4FvEq648CpilwY=;
 b=F0wznKeEpp5lsroSbGQZi0xJnMzbxVTcdFBQr2Ftjarkv6vrV9xEDfas1jNxIPt7y/WCtSzSB
 kiVWhaWnLA5CaFcvqv4Md28khWIoIXSzRSAy0YNhV0kPt2+jVTDci4I
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Since commit 3c5f6114d9ff ("qapi: remove "Example" doc section")
the "Example" section is not valid anymore.
It has been replaced by the "qmp-example" role.

This was not detected earlier as firmware.json was not validated.
As this validation is about to be added, adapt firmware.json.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 docs/interop/firmware.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 2eb0be11d595..eea82eef3a07 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -471,7 +471,7 @@
 #
 # Since: 3.0
 #
-# Examples:
+# .. qmp-example::
 #
 #     {
 #         "description": "SeaBIOS",

-- 
2.45.2


