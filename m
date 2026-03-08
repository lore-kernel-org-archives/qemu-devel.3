Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71B3EA853A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHx6-0003gU-7h; Sun, 08 Mar 2026 13:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwr-0003ek-Ob
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:50 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHwp-0003nL-1G
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:29:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C3FE6600AE;
 Sun,  8 Mar 2026 17:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F97C116C6;
 Sun,  8 Mar 2026 17:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772990985;
 bh=QIdUQ5ojIh6pUED378YIZDxyX5WSDR8KZ+KkV6/pMI4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NrGNfYrkD+9JGnxShLTLRbsCWesGkb4TT2+KWnc1B1PXsO/pk8mPFotI9zpeaUVzO
 1dVzUaoV0pOzQZDKtc0PGMLxHpS18crA/ryZIxECEz7Er6+4ADQxBBxhJTigyxVhfZ
 9GTOML4Jkb8inVNlibrYiYfywUi7Mt50CzYUcsza/tGsAxV0fnW0eEIiIZ35lnsuz1
 AoGDGwJOMT2pNtKYTF/D8aJaGiRyUa1YP9+KcyYe9lAxUjsY9bsGc4qLkrQGT0G3vI
 CR0MAA6orJb/XpbdMJ+mhMtTXC2p5adqjwGgRTNknbBXZedVS1wOXJBeR6FSxjUVD7
 agD4CTuRwONVw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/12] hw/char: Drop disable property of Diva GSP card
Date: Sun,  8 Mar 2026 18:29:26 +0100
Message-ID: <20260308172936.2835-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The "disable" property is not used, so drop it.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/char/diva-gsp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/char/diva-gsp.c b/hw/char/diva-gsp.c
index 280d0413c6..2be5183216 100644
--- a/hw/char/diva-gsp.c
+++ b/hw/char/diva-gsp.c
@@ -51,7 +51,6 @@ typedef struct PCIDivaSerialState {
     SerialState  state[PCI_SERIAL_MAX_PORTS];
     uint32_t     level[PCI_SERIAL_MAX_PORTS];
     qemu_irq     *irqs;
-    bool         disable;
 } PCIDivaSerialState;
 
 static void diva_pci_exit(PCIDevice *dev)
@@ -159,20 +158,18 @@ static void diva_pci_realize(PCIDevice *dev, Error **errp)
 
 static const VMStateDescription vmstate_pci_diva = {
     .name = "pci-diva-serial",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PCIDivaSerialState),
         VMSTATE_STRUCT_ARRAY(state, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS,
                              0, vmstate_serial, SerialState),
         VMSTATE_UINT32_ARRAY(level, PCIDivaSerialState, PCI_SERIAL_MAX_PORTS),
-        VMSTATE_BOOL(disable, PCIDivaSerialState),
         VMSTATE_END_OF_LIST()
     }
 };
 
 static const Property diva_serial_properties[] = {
-    DEFINE_PROP_BOOL("disable",  PCIDivaSerialState, disable, false),
     DEFINE_PROP_CHR("chardev1",  PCIDivaSerialState, state[0].chr),
     DEFINE_PROP_CHR("chardev2",  PCIDivaSerialState, state[1].chr),
     DEFINE_PROP_CHR("chardev3",  PCIDivaSerialState, state[2].chr),
-- 
2.53.0


