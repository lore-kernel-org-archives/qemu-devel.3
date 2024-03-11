Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0128C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 11:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rje7m-0002gS-Tr; Mon, 11 Mar 2024 07:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7k-0002fP-Rx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:21 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1rje7h-00020P-Jx
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:47:20 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1710157620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z66H8/DCP5DiWcStfO/8vBe9gjZpCeznMPMTANzIqgk=;
 b=CJATwZXEhYG0F6otY00RujeLv9RSMSbOt9kjMTZmeJ/9FugPdHfof/vS08vWPtDOtLiGUa
 6nmlpXV63ep7Qv0QvgfrGWT68qLb+ZyT9T3h/XuiDUcvHK9Dvc0vkgzKJpSnmn5MNc1MF7
 bLeOu2hM4nz+W2766y9cLgMTAVFKEIgKkcUHiTq7g9BdNhFvMYwmm5ZQRpvp888VkUKaua
 pk9w3oxexNtext8WcfYd5jy24wZI6xBEk+kfoOUIJQojONRVPG0fjdWxNq+x6nsxuxEt2/
 3ZkdzDhxXdNSik0mxGfiEZDLW8Shg6p+935oNuiOF/TbQO1dnDUWKr7QG1YAzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1710157620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z66H8/DCP5DiWcStfO/8vBe9gjZpCeznMPMTANzIqgk=;
 b=dXTt92Oy09GhRFO7ydbWdfH2AVYXVLLtHPkTW5HnXf1UX1ynmi87tTMlzOc6u9vLMJLXqX
 0tlrrC/WM5xtrWDA==
Subject: [PATCH v3 0/3] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Date: Mon, 11 Mar 2024 12:46:57 +0100
Message-Id: <20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADHv7mUC/33NQQ7CIBCF4as0rMXA0NDgynsYFyBgxyitULGm6
 d2lXRljXP4vmW8mklxEl8iumkh0GRN2oYTYVOTU6nB2FG1pAgxqJpikd90j9RhvTx0dvaQuUOk
 NBy6UkNaScthH53Fc0cOxdItp6OJr/ZH5sv7lMqeMSq58wwE01Gp/xfAYYhdw3FpHFjLDJ9P8Z
 KAwwoBy2hhllP5m5nl+A6Dpk/v/AAAA
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710157619; l=1238;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VEZFNUVEykc8v3O8MOtGhefWJjc6UyGkc2l3vrErCho=;
 b=312iwVHcTAsuMfS4CRBI5RUeOjoYToAK4h6OgHURw8CV/A5+Udmn3m4eKpc2D1TZYvJmksP2e
 FuQins7xi5bCzYT5nxVMMc8SHeQ8QAb3xubeoAjrVEFHdXMviX+M+NE
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
Changes in v3:
- Drop already picked up patches
- Drop include of pragma.json
- Introduce new enums FirmwareFormat and FirmwareArchitecture
- Link to v2: https://lore.kernel.org/r/20240307-qapi-firmware-json-v2-0-3b29eabb9b9a@linutronix.de

Changes in v2:
- Add review tag from Philippe
- Add Fixes tag (Philippe)
- Add testcase (Philippe)
- Link to v1: https://lore.kernel.org/r/20240306-qapi-firmware-json-v1-0-619f7122a249@linutronix.de

---
Thomas Weißschuh (3):
      docs/interop/firmware.json: add new enum FirmwareFormat
      docs/interop/firmware.json: add new enum FirmwareArchitecture
      docs: add test for firmware.json QAPI

 docs/interop/firmware.json | 36 ++++++++++++++++++++++++++++++++----
 docs/meson.build           |  5 +++++
 2 files changed, 37 insertions(+), 4 deletions(-)
---
base-commit: 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


