Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F86DC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoYq-0004ri-HB; Wed, 06 Mar 2024 05:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYn-0004oP-Oh
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:42 -0500
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rhoYk-0007bZ-Do
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:31:41 -0500
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1709721085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OtA/QiUqtSmMzFP6J0LwSLTKy/Ge/8kwtxsDyLo56h8=;
 b=Y9j1FYzVsRcf1vOy6BoFrkkIlPeRNSDzciiaS9XoD/je2XzLo/Ke/9sw5887Pj1/zGpzaK
 vMhgryOZ4qlFxIrrXYc+yhkXWS4jHQFvpXcij9hUazCik3jLbWS9inJyHxqohql3KSvJvG
 Go8MRHEKfSZ8I/eSbzy3FTQ0UfybyISKxdCIHCTT5ekPzCM83oiNAC0pSD0q0QN2a1t2p6
 sDFwA1mHoHEwnbPsDKNOJORbWFt5B94/2gkr0i6NG0/m/rwsS5wjFttWqaOUwLyW9CpNoF
 2RefnixPiAM2r32sLaVW2XBqR+PtHlCcNxPLZ+xoNTU0zg0o9pT4rMNydDKoTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1709721085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OtA/QiUqtSmMzFP6J0LwSLTKy/Ge/8kwtxsDyLo56h8=;
 b=Ldn0zai+jBntpvgkl+SwgDAn+pC1+T5HRRoK75HIit6ZflCVQN1X3wfXhyzn7eNavFf0/o
 cWtVXvuipnxpe+CQ==
Subject: [PATCH 0/4] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Date: Wed, 06 Mar 2024 11:31:21 +0100
Message-Id: <20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPlF6GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwMz3cLEgkzdtMyi3PLEolTdrOL8PF2ztCRDI0NjS2OzlBQloMaCotS
 0zAqwodGxtbUAdeUvVGQAAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709721085; l=803;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EVtrlZq5eeXONSP6QtwodpnfAxHW7OGxNW1th3b2MOk=;
 b=xNQ0TqUe7hqktDQkojzLNZ3TAmHPSoGHZrdjZ3DEVq5Gsnz3hYKuGZxnEr0w5WRWbRToF8g+i
 xhYnQodnw8DDq4WFkJdymyieuo/3imYuH5hM9la8crSnjFJ8xH1V2R6
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

docs/interop/firmware.json is currently not usable with qapi-gen.py due
to various non-functional issues.
Fix those issue to provide compatibility.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (4):
      docs/interop/firmware.json: Align examples
      docs/interop/firmware.json: Fix doc for FirmwareFlashMode
      docs/interop/firmware.json: Use full include paths
      docs/interop/firmware.json: Include pragma.json

 docs/interop/firmware.json | 392 +++++++++++++++++++++++----------------------
 1 file changed, 197 insertions(+), 195 deletions(-)
---
base-commit: db596ae19040574e41d086e78469014191d7d7fc
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


