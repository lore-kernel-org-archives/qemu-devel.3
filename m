Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2421AC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbOs-0000Lo-1z; Wed, 24 Jul 2024 08:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sWbOF-0000Fg-LG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:46:46 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sWbO9-00084W-M7
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:46:41 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721825176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=97dHBtWqxI9bCu+8KQVAUp3d7BmuICoCZpZ7MkoDSyo=;
 b=EQIEpEhHAebovM/ZZUfc3/BIf+i9uR+BOHs7x8TH5ZwClnYAV4dpd3zUgNOOeLacVg+6PT
 qKAPI3OzZ06LqwRjfX79K50k4Xt1/tOp2PdASGDbUoIIJb45apIaUQjRM5ky5V7lxFxTuV
 2qlR5JvW/k0CtYwPmmoSdbazLsrRaDtRwxcMAOlkB3X4ou5eDIwfK7e6M5qUJ7MkuRLN7p
 Qcp/T27I48b6r5tRV2Nceglosv3jjFqHqphGnr+/qOyaOz5Em8Z4wDu/b1fT6SnBZzDXlt
 sgU6VFI7WmC2yYHe3ft64xjeK4zsX7xpFC8vjF7g6Ynut5IDkYCORlS3hxx8XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721825176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=97dHBtWqxI9bCu+8KQVAUp3d7BmuICoCZpZ7MkoDSyo=;
 b=FxdaS5t+aqslbaGByqZCHmqHUDx+DZUG1EjZS9TFNo1Ztc1/rdzLV9/wdlpSGrwB9edKwS
 zRi6Xathw0sUl5BA==
Date: Wed, 24 Jul 2024 14:45:53 +0200
Subject: [PATCH v7] docs: add test for firmware.json QAPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240724-qapi-firmware-json-v7-1-12341f7e362d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAID3oGYC/4XPzU7DMAzA8VeZciYodr6WnXgPxCFpXBYE6UhGG
 Zr67qS7UKEIjn9L/lm+skolUWWH3ZUVmlNNU25h73ZsOPr8TDzF1gwFKiGF4e/+lPiYytunL8R
 f6pS5GQMgSCdNjKwtngqN6XJDH59aH1M9T+XrdmOGdfonNwMX3IAbLSB6VO7hNeWPc5lyutxHY
 is545axXQYbIwM68iG44HyPkRsGoMvIxgxE3pDUFFSXUT+MhX2XUY1Ryg1kLMaghx6j/2d0Y0Q
 MHjBa70fdY8yWcV3GrE8hyUjSiaD3v5llWb4BP9LE4BsCAAA=
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721825175; l=2757;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=N4+A+OV8VpogRXFjz8y/2I1Hha+QZvk8IHxLo0x9G8k=;
 b=kBNtcj/bHrIrpyS+uJYYslnp1jBKz3CwfbdDOdzjJ9CSaJfQuXIRnjAzB0eoD/a/f2cT3DUWd
 WZ6wJTftP3JDXrvBFrR+0BmI/0c752FYlh9t0CArNbIeuIUxa6RFstW
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
Received-SPF: pass client-ip=2a0a:51c0:0:12e:550::1;
 envelope-from=t-8ch@linutronix.de; helo=galois.linutronix.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

To make sure that the QAPI description stays valid, add a testcase.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
docs/interop/firmware.json is currently not usable with qapi-gen.py due
to various non-functional issues.
Fix those issue to provide compatibility.
---
Changes in v7:
- Drop already applied patches
- Remove "test_env" from docs/meson.build
- Remove explicit "python" invocation from docs/meson.build
- Validate patch through Gitlab CI
- Remove Hanna and Kevin from Cc again
- Link to v6: https://lore.kernel.org/r/20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de

Changes in v6:
- Style cleanups
- Improve the comment for qcow2
- Document the new enums as Since: 3.0 (7.1 for the loongarch64 arch)
- Link to v5: https://lore.kernel.org/r/20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de

Changes in v5:
- Add Reviewed-by from Daniel
- Add patch to drop Example section
- Link to v4: https://lore.kernel.org/r/20240718-qapi-firmware-json-v4-0-449ce672db5c@linutronix.de

Changes in v4:
- Update "since" to 9.1
- Add comment to 'member-name-exceptions'
- Document enum members and drop 'documentation-exceptions'
- Link to v3: https://lore.kernel.org/r/20240311-qapi-firmware-json-v3-0-ceea6e35eb4a@linutronix.de

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
 docs/meson.build | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/meson.build b/docs/meson.build
index 9040f860ae1a..322452c87787 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -99,3 +99,8 @@ if build_docs
   alias_target('html', sphinxdocs)
   alias_target('man', sphinxmans)
 endif
+
+test('QAPI firmware.json regression tests', qapi_gen,
+     args: ['-o', meson.current_build_dir() / 'qapi',
+            meson.current_source_dir() / 'interop/firmware.json'],
+     suite: ['qapi-schema', 'qapi-interop'])

---
base-commit: 6410f877f5ed535acd01bbfaa4baec379e44d0ef
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


