Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D501C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCVp-0004K2-V1; Thu, 07 Mar 2024 07:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVk-0004Is-3F
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:08 -0500
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1riCVU-0005NO-TQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:06:07 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709813140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=the+Np51LQ3fQ9bibbuSHIVbS8I0UhpamNL/WKXXflE=;
 b=3uZF7+G/KjcMQcaNpWqrUnidGWt6khRN45s8HAYIDQEpSm6CmbXM69C9TDYjYbqxIm7Hms
 ARUfZ9CtGUHlmaAXB2pM2E2VT4ypl6rTRGbTo2YPwxkxYZCYSA5I0j5I54+hY3Vp6cZ/8L
 kKGdGlTi1wDdQXlv7lXyCLt9Jq37oPVmZgrsRX+SFce9ogx7wzrRDqg1KU3wwfRm2iM6rU
 E0neo8MFQSS9WyPAFUdLV0e49ZnI4ekHULaO/rPAMRF8eo4y87n1RK6cfyvIBt2dORdEXo
 MVE0Utb4vyUqstj3M3dl9d3jettcrAxJWutRiNGZtCi21+nx7mknh/Y+O+LY0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709813140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=the+Np51LQ3fQ9bibbuSHIVbS8I0UhpamNL/WKXXflE=;
 b=5P2I+mnUpiZhFC3gmXtfL02+LgtJtA/mROKHLg0l7fs3FTD/i1Vcrb8lVPvgAjN47Xr0ok
 Wni6ak9vf2DC8tBQ==
Subject: [PATCH v2 0/5] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Date: Thu, 07 Mar 2024 13:05:33 +0100
Message-Id: <20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI2t6WUC/32NQQ6CMBBFr2JmbU07kBpceQ/DotqpjNEWp4gYw
 t2tHMDle8l/f4ZMwpThsJlBaOTMKRbA7QYunYtXUuwLA2qsdaWterqeVWB5vJ2QuuUUlQ1ng6Z
 qKus9lGEvFHhao6e2cMd5SPJZP0bzs39zo1FaWdOEvUF0WDfHO8fXICnytPME7bIsXzExZg64A
 AAA
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709813140; l=1097;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=a6rgMdLbAuC0HmbsyJTcRjjNPQLH9+X69ZHvTvzHt1k=;
 b=p52TOvB+I23G4v2fQx5pQgnIsZerNFSDnH1yMDdstj9o94Mykuez60iYaCMht8zwE3Ik3/trg
 94FddqtanZgD/g1rKdZU+xX505yxNjQoVw9y2CK1dOsdy19m9eP1KJK
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

docs/interop/firmware.json is currently not usable with qapi-gen.py due
to various non-functional issues.
Fix those issue to provide compatibility.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Add review tag from Philippe
- Add Fixes tag (Philippe)
- Add testcase (Philippe)
- Link to v1: https://lore.kernel.org/r/20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de

---
Thomas Weißschuh (5):
      docs/interop/firmware.json: Align examples
      docs/interop/firmware.json: Fix doc for FirmwareFlashMode
      docs/interop/firmware.json: Use full include paths
      docs/interop/firmware.json: Include pragma.json
      docs: add test for firmware.json QAPI

 docs/interop/firmware.json | 392 +++++++++++++++++++++++----------------------
 docs/meson.build           |   5 +
 2 files changed, 202 insertions(+), 195 deletions(-)
---
base-commit: 8f6330a807f2642dc2a3cdf33347aa28a4c00a87
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


