Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D47C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 18:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZj7-0003Wa-Sd; Mon, 12 Aug 2024 14:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sdYlp-0005Qj-14
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 13:23:49 -0400
Received: from mail-4323.proton.ch ([185.70.43.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sdYln-0000gv-5U
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 13:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail3; t=1723483416; x=1723742616;
 bh=mZBp2vhSR2waE7EdO17DXw8lFTSdkl/Vm2P21KaeAP8=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=nrsjpn6QGnhSDCPWzE0WCvioDR6TpjpdIMEEAlyH0NTjoX7rY/J3Lg2GGfwB8I3ry
 SnIp8HA+eQ6oPrD9SltP/s7u7vCR/sIf/QJKNXBZ1ffN1o4pd4BCxE7TfEMx2cB/+N
 MVyCj2Q7zibEkPnZBwWggGZ+BjGOMlZ0C+kWv7gEHT2gvTteYNsJHVYcLR/FWr0JyE
 SwhP2SLBmH4Wk6hTWD0T6042neBzi3ifsxaCgWEjFbh0KkMKqzyvI/vxcJpl8PLF1u
 yNisyfFr2BRSgPqakehNVnDYwaIAwvIxJquIR2wcEFOUjVkNEaabm//CLGo9JPX0uJ
 QAIqhJa8EOkLw==
Date: Mon, 12 Aug 2024 17:23:31 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: [PATCH] hw/i386/pc: Add a description for the i8042 property
Message-ID: <15fhXFY6x78KW8P5gw0eKTW8kc17zejrJFxqnOyoBy6vw4W9rCmgDhoxssWosWFs_dbFtfsyjn9wpPrV3x8Nlzhy8mTJSEnXCr4qyHAhXSw=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 7741bce6cb91c32ba95a4f5e6d857656c731e82d
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.23; envelope-from=kamil@szczek.dev;
 helo=mail-4323.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Aug 2024 14:25:04 -0400
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

While working on exposing the i8042 property in libvirt I noticed that
the property is missing a description. This adds a simple description
so that QEMU users don't have to dig in the source code to figure out
what this option does.

Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
---
 hw/i386/pc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c74931d577..defbc33125 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1807,6 +1807,8 @@ static void pc_machine_class_init(ObjectClass *oc, vo=
id *data)
=20
     object_class_property_add_bool(oc, PC_MACHINE_I8042,
         pc_machine_get_i8042, pc_machine_set_i8042);
+    object_class_property_set_description(oc, PC_MACHINE_I8042,
+        "Enable/disable Intel 8042 PS/2 controller emulation");
=20
     object_class_property_add_bool(oc, "default-bus-bypass-iommu",
         pc_machine_get_default_bus_bypass_iommu,
--=20
2.45.0



