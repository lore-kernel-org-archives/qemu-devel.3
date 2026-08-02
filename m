Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4DEC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 10:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqT6E-0003Uz-0S; Sun, 02 Aug 2026 06:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1wqT6B-0003Ur-TS
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 06:07:15 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1wqT69-0005sv-R4
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 06:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1785665223; bh=+h07xQQSFtahSSvfllVdclzNPYELeR2ZY7WFgTfPaaw=;
 h=From:Date:Subject:To:Cc:From;
 b=phiiNSS6A5Kruar1l5XvDG5POAdhS3zJFjMf/H7IbVgBtArMSB70Wq+51v3BSFEq+
 b+7LyJtfcuu7dUY4J+qmqubPfMx5rCYhPDv2U4PhZFMeOe9Rlv8KTBtNt0r3lbzdz5
 bzDQsEHz90mfl26Z3OokwRI9II2Vth6Q9WRS/uRA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 02 Aug 2026 12:07:03 +0200
Subject: [PATCH] hw/misc/pvpanic-mmio: Announce support for all pvpanic events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260802-pvpanic-mmio-shutdown-v1-1-483771ad0c9e@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywrCMBBA0V8ps3YgHVBaf0Vc5DG1IzQJmT6E0
 n831uVZ3LuDchFWuDc7FF5FJcWK9tKAH218MUqoBjJ0M50hzGu2UTxOkyTUcZlD2iL2NlzJcUe
 u7aG2ufAgn/P7eP6ti3uzn38zOI4vRkPQCnkAAAA=
X-Change-ID: 20260802-pvpanic-mmio-shutdown-9ad52be82b19
To: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Cc: Alexander Graf <graf@amazon.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785665223; l=1195;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=+h07xQQSFtahSSvfllVdclzNPYELeR2ZY7WFgTfPaaw=;
 b=wRIEfzH1KrNbwVt6HQ7x0CNUAbslK5gftgxyolJDcBMi3TPPAT4cO8KYveJXseR3LIKD961wu
 Rx29LMw9BvECHxSBcOO4baG6xBk1Fi3xAzYpzdmUsfg9w+f631cJ0XF
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The pvpanic-mmio also supports the PVPANIC_SHUTDOWN event by virtue
of using the generic pvpanic core.

Currently this is not expressed in the 'events' property,
so users can not discover this support.

Switch to the generic PVPANIC_EVENTS macro which automatically contains
all events supported by the generic pvpanic core.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 hw/misc/pvpanic-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
index a173a1a9a589..40b167b8d8dd 100644
--- a/hw/misc/pvpanic-mmio.c
+++ b/hw/misc/pvpanic-mmio.c
@@ -33,7 +33,7 @@ static void pvpanic_mmio_initfn(Object *obj)
 
 static const Property pvpanic_mmio_properties[] = {
     DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
-                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+                      PVPANIC_EVENTS),
 };
 
 static void pvpanic_mmio_class_init(ObjectClass *klass, const void *data)

---
base-commit: b428fe036233cbd15d37e3c027ab6ca4d3661a80
change-id: 20260802-pvpanic-mmio-shutdown-9ad52be82b19

Best regards,
--  
Thomas Weißschuh <thomas@t-8ch.de>


