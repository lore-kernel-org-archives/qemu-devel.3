Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4A8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 22:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgXi9-00046H-Ac; Tue, 20 Aug 2024 18:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgXi5-000456-M1
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:52:18 -0400
Received: from mail-40136.proton.ch ([185.70.40.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamil@szczek.dev>) id 1sgXi2-0001hR-0j
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szczek.dev;
 s=protonmail; t=1724194327; x=1724453527;
 bh=aCtHMdfzBtkQ+jo/s2WUPwOCw/uVA70giOODpNrTYUc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=QMu88Tt17Lz6H5GHPpLELCfyqJxe9QCPJdw/0TRDZ38C7aDdtItSNV1BM60OD1bhW
 jGknHEwB+9q/4L92tuQqDhpPFemE1dpNDCGM7XaX8bPSsS04C0p7GSj8XLPRHa2wHu
 VScjNuGB6pC47lH9jyj1sJNYWgu4/dXaq/pfN6kV4SoCrtmbJSgqX5Mrh51TqWZWzc
 eKYEX7ryvPlTpwb5keCtaEVJK2Auwv47yE/DyZzSVI5aKUXlcqFZt+KCWbHa0t8obQ
 laxSvpxHjLeH1rVyhwaFNq1KU65P91oPIQIs291cfz+e6SlM7ms7dZ/aAiy4TW3gFd
 eIDWlI27Qac2Q==
Date: Tue, 20 Aug 2024 22:52:05 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?utf-8?Q?Kamil_Szcz=C4=99k?= <kamil@szczek.dev>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] hw/i386/pc: Fix enum value assertion
Message-ID: <oPimw5pKWjOolRVo_7-wrc75fq9RQccGIZFwWLTLupIprA9PaVm6IDzlE5M_MEZLCWtT31P55BAwc1VgCpEGyB21qyGLDRekNlK6ueu4MaA=@szczek.dev>
Feedback-ID: 37679334:user:proton
X-Pm-Message-ID: 4ab8994b27a5a1a2790ffa1d289d2b4dc0b5d0cb
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

Coverity reported:
 >>> CID 1559533:  Integer handling issues (CONSTANT_EXPRESSION_RESULT)
 >>> "pcms->vmport >=3D 0" is always true regardless of the values of
 >>> its operands. This occurs as the logical first operand of "&&".

Signed-off-by: Kamil Szcz=C4=99k <kamil@szczek.dev>
Reported-By: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7779c88a91..523dfe3f3f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1221,7 +1221,7 @@ void pc_basic_device_init(struct PCMachineState *pcms=
,
         isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }

-    assert(pcms->vmport >=3D 0 && pcms->vmport < ON_OFF_AUTO__MAX);
+    assert(pcms->vmport < ON_OFF_AUTO__MAX);
     if (pcms->vmport =3D=3D ON_OFF_AUTO_AUTO) {
         pcms->vmport =3D (xen_enabled() || !pcms->i8042_enabled)
             ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
--
2.45.0



