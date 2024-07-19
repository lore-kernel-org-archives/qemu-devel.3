Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5DBC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiBM-00009Q-43; Fri, 19 Jul 2024 03:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBJ-0008R2-3K
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:33 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUiBG-0002jr-Bk
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:37:32 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721374647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S5ZzYcL2At3sLvGX6r0bhU+dsaqEIyVyySegOEOTuwQ=;
 b=3iNJdEmWq/tTCuppDVqJiy9MI7oc1NUg6SWcLAyzWC5UC3MySQVZ5ZdkxVNoM90n/GV+Pn
 8GfTjLQO8KgERU5ZNCDOeWmIv3hbD/orUNF4frY0aujM5L2cDgqhFzFIJgeEUC7hLBEqP5
 Q7JemF7kt7pHOeC29Q9eCyoOLYLjkvTQCmb116I3dUzocKdiMv70zykEV/uhyxtKtYNDJM
 pjHbYSwkFo18Fh3WRoV89ddAKlGU/Vk+yv1KsfLDVNO480/WZ6SlGG1hLsmfYpkiJlplYj
 B4CzPaYsCA4qrYXEbT87/LKbrm5fPKjKy/FvPT5nd6T1vNUHBybJq0+LI88lMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721374647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S5ZzYcL2At3sLvGX6r0bhU+dsaqEIyVyySegOEOTuwQ=;
 b=cvNIeYNSTDu9Pxgusr/XRbKNBDzpnhml4hi4FqIzH7tdyF8YhjUS6+/V7CJwRFwir9P5Lk
 7iDf9/+X8KGRjxAQ==
Subject: [PATCH v6 0/4] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Date: Fri, 19 Jul 2024 09:37:21 +0200
Message-Id: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALEXmmYC/4XNzU5DIRCG4VtpWIuB4U9ceR+mCzgMdoxyKrTHm
 ubcu7QbG0N0+X7JPHNmDSthY4+bM6u4UKO59LB3GzbtQnlBTqk3AwFaKGH5R9gTz1TfP0NF/tr
 mwm2OEqTyyqbE+uG+YqbTFX3e9t5RO8z16/pjkZf1T26RXHArfXYSIID2T29Ujoc6FzrdJ2QXc
 oFbxg0Z6IyK4DHE6KMPI0bdMFIOGdWZCTFYVAajHjL6h3HyYcjozmjtJ7QOUjTTiDH/M6YzIsU
 gIbkQsvnNrOv6DbNMDJbUAQAA
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721374646; l=2090;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CKx+3XTths+1yMOOYeR2RHpEZ/izjHuyoZL9DLZPheI=;
 b=yyx/1VXRkW9sp9iOD/UFj0VTl5xtTVMWITNzfJ9icTdB9cA/vGAmIJ4OYxzuXCc2vv/Z8nHxP
 NcCquA+hlYqBt8ye9VmYMA9t3019zPPcY99vvp7vF68riuKOVhFBvte
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

docs/interop/firmware.json is currently not usable with qapi-gen.py due
to various non-functional issues.
Fix those issue to provide compatibility.

Kashyap, I stuck with the original wording for image format docs,
as I personally prefer them a bit.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
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
Thomas Weißschuh (4):
      docs/interop/firmware.json: add new enum FirmwareFormat
      docs/interop/firmware.json: add new enum FirmwareArchitecture
      docs/interop/firmware.json: convert "Example" section
      docs: add test for firmware.json QAPI

 docs/interop/firmware.json | 47 +++++++++++++++++++++++++++++++++++++++++-----
 docs/meson.build           |  5 +++++
 2 files changed, 47 insertions(+), 5 deletions(-)
---
base-commit: 23fa74974d8c96bc95cbecc0d4e2d90f984939f6
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


