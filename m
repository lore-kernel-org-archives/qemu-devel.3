Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651EEC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 12:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQAA-0008J6-Rp; Thu, 18 Jul 2024 08:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA6-0008BF-6q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:07 -0400
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sUQA1-0003tT-U6
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 08:23:04 -0400
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721305377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjNIpm5rIp+jmbtRnU7G/WkDxNQ2v5YAkid7VF8sB/I=;
 b=RGppQRthxle9A6CDA/xqEgR/Z2c1U1PbpLWmnchSE08NRilRSTmI7Wsb9r0lZUTw4wyMbr
 ngGnUHVSDRazSW/u5jKkfhkQo82YW+fRPKF5Hg+uyBXahWIvGQwbK9cHKgmBtctiQO6zwc
 fI49XX0UM9oBlFQ06Nll/wyE/U4rX2TzPcaJv89B/ZxBriUX4bWO+7CDkYrKnpbtpnJnLm
 dw+vHGb3Mr4qHLzUnGn1Ln00YLzBcxDRvvBy50/XuGyvB11UvJONff5XGlpKMBRROGESib
 FrBLztpSof3dwW9NmJ6X1JS0Isy1GCNYZuqYCIzAdimOwFTZFMfx0l1ANhrKtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721305377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OjNIpm5rIp+jmbtRnU7G/WkDxNQ2v5YAkid7VF8sB/I=;
 b=MiNqWi7H8q7dCmknohr1TcnXbMn2b+ltviiGwQwK1yYBvGhLD1pCE9LbfAyVVgGHUz8w/n
 5nTE/PR2THxgOkCQ==
Subject: [PATCH v5 0/4] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
Date: Thu, 18 Jul 2024 14:21:44 +0200
Message-Id: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANgImWYC/33NQW7CMBCF4asgr3GVGTtOzar3QCzseAJTFYfaE
 EAod8ewKUJWl/+T5pubyJSYslgtbiLRxJnHWKJdLkS/c3FLkkNpgQ3qRjVG/roDy4HT/uwSye8
 8RmkGDwjKKhOCKIeHRANfnuh6U3rH+Tim6/PHBI/1X24C2UgDdugA0aG2Xz8cT8c0Rr58BBIPc
 sJXpqsyWBjl0ZLz3nrraox6YQCqjCpMT+QMqZa8rjL6j+ngs8rowmhtezIdBt/278w8z3cVR/K
 tjQEAAA==
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721305377; l=1901;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rkZu0cEcXR9n5GtoKOk93v53TpKx8SIXSzSH+ra8HyM=;
 b=hQX0lIIVNLVs4xm44OfQyHBf7+exdateC2kaoehdHEnKGFaD/9gTpLoULFvG/gL4cfM6CfqO1
 xinEfBIfDSxCOicZXqAxSdaJmr6HZR8q6cXFBLHEqNgLSrebVbqH4pk
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

docs/interop/firmware.json is currently not usable with qapi-gen.py due
to various non-functional issues.
Fix those issue to provide compatibility.

Sorry for the quick resend, but the series got broken by the just-merged
pull "pull-qapi-2024-07-17" which made the newly introduced patch 3
necessary.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
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

 docs/interop/firmware.json | 48 +++++++++++++++++++++++++++++++++++++++++-----
 docs/meson.build           |  5 +++++
 2 files changed, 48 insertions(+), 5 deletions(-)
---
base-commit: d74ec4d7dda6322bcc51d1b13ccbd993d3574795
change-id: 20240306-qapi-firmware-json-6fb1213936dd

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


