Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9BFC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 23:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgY0q-0001oS-QR; Tue, 20 Aug 2024 19:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgY0k-0001n0-Fg
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:11:36 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgY0h-0004G0-98
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 19:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail; t=1724195488; x=1724454688;
 bh=IUlq2TH9ffX37NP35tXMdRDVEqbgSDXpi8SzuVTV8+E=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Yi0ip5zt2gPepbnE50Zbcc0NtAaQ5nhjiyEiYThAxMCVOSlCxfDX5B664lMxuW7+a
 KME8reyiPZh1/PjohcGImz5tb2ohas0zIRG4r/XcrS5EWZau9mJx/m9DlGdT16p6gE
 L/OcXPMXkivINde4FGrUHkecsm4pVQ6pI/U5J1iRW37qBSat105VTxUXEmnkzIJPVJ
 /l0sGKlNIxVtZrszNYTrtA4ZREVKgNTARpQ4z4pOMxzfSrHo+yKlBL24fq79vSm15L
 Ue8c0qEQvfFVv+cQPjcVIblQ2JYq5S3xaTHXyDcXexdqPPwZtxiOIn7RJoGemvBmxe
 vm3TTueL1y0jA==
Date: Tue, 20 Aug 2024 23:11:24 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] hw/i386/pc: Remove vmport value assertion
Message-ID: <ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: f6e5e63cabc03973306fe1463412a2b100c306df
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.136; envelope-from=kamil@szczek.dev;
 helo=mail-40136.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

There is no need for this assertion here, as we only use vmport value
for equality/inequality checks. This was originally prompted by the
following Coverity report:
 >>> CID 1559533:  Integer handling issues (CONSTANT_EXPRESSION_RESULT)
 >>> "pcms->vmport >=3D 0" is always true regardless of the values of
 >>> its operands. This occurs as the logical first operand of "&&".

Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
Reported-By: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
---
 hw/i386/pc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7779c88a91..5302fd96b4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1221,7 +1221,6 @@ void pc_basic_device_init(struct PCMachineState *pcms=
,
         isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }
=20
-    assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);
     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
         pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
             ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
--=20
2.45.0



