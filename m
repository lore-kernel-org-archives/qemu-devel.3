Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D436C982DA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7wV4-0007p2-5N; Sat, 19 Sep 2026 10:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUO-0007lY-PN
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:29 -0400
Received: from dog.ash.relay.mailchannels.net ([23.83.222.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUM-0004c4-Hx
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:28 -0400
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 2CBF17A0C27;
 Sat, 19 Sep 2026 14:56:22 +0000 (UTC)
Received: from sh-cp12.mia1.servername.online
 (100-99-183-215.trex-nlb.outbound.svc.cluster.local [100.99.183.215])
 (Authenticated sender: hostpapa)
 by relay.mailchannels.net (Postfix) with ESMTPA id AC81A7A081C;
 Sat, 19 Sep 2026 14:56:21 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostpapa|x-authuser|frode@tennebo.com
X-MailChannels-Auth-Id: hostpapa
X-Lonely-White: 72d244c1680b68ad_1789829782089_81419357
X-MC-Loop-Signature: 1789829782089:822851766
X-MC-Ingress-Time: 1789829782089
Received: from sh-cp12.mia1.servername.online (sh-cp12.mia1.servername.online
 [199.204.250.122]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.183.215 (trex/8.0.2); Sat, 19 Sep 2026 14:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tennebo.com
 ; s=default;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/0wR4Ov23fh6BtymCRDbaiVe3XrqxcjTwN2zI+RhXY=; b=0/bjrn/mbkKl0ybZqXV72xegE+
 D3nGGCV4CM/2sX7mncTAOm5HZLwPJa0UpR3Upj+gLxKZCoiT7KBR5rZHoasI7xeBD8JD116M6Etwo
 lJZJ3auhsion8xBwjDyx9yaEeGYslVpBsZjjtwnADvgvN5T7p8rIhgzE6OW6OPXkQYFT1DBRDIG39
 6kVk3VvdWYQkxRdiZdkk0opYgQAwhM0qKLyW2nqj53XepKV9QscCkAwhqVcEeOAJRtlUEygELgPYp
 SiL67ICMRx0iyvfnrFrAv6qDtBpCT+LNWx13EIMFTSOT/PtyGiJ6QLXer7/AulLkHoBHmjhvFnWjD
 qKkg0PLA==;
Received: from 55a44a6c.bb.online.no ([85.164.74.108]:50478 helo=[127.0.1.1])
 by sh-cp12.mia1.servername.online with essmtpa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100)
 (envelope-from <frode@tennebo.com>) id 1x7wUE-0000000BpqJ-2FB4;
 Sat, 19 Sep 2026 10:56:20 -0400
From: =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Subject: [PATCH 0/3] hw/sparc, hw/sparc64: add hostid=/machineid= -machine
 properties
Date: Sat, 19 Sep 2026 16:56:01 +0200
Message-Id: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIGirmoC/x3MQQqDMBBA0avIrA3EpG2wVykiaWeqszFhRkUI3
 t3g8i3+L6AkTArvpoDQzsppqejaBn5zXCYyjNXgrHvZvgsmIo5z0pVx1O1rsqRMstaFeQQfLTq
 K/klQ+yz05+N+f4bzvAA8KxDiawAAAA==
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
X-Mailer: b4 0.13.0
X-AuthUser: frode@tennebo.com
Received-SPF: pass client-ip=23.83.222.48; envelope-from=frode@tennebo.com;
 helo=dog.ash.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:57:06 -0400
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

This series adds "hostid" and "machineid" as -machine sub-properties
for the sun4m and sun4u/sun4v machine families:

    qemu-system-sparc  -machine SS-20,hostid=0x352e09,machineid=0x80
    qemu-system-sparc64 -machine sun4u,hostid=0x352e09,machineid=0x72

Background: these machines report a classic 32-bit Sun "hostid" to
the guest OS (as read by hostid(1), and historically use by some
software for license checks), built from two independent pieces stored
in the emulated NVRAM/IDPROM - a fixed per-model machine-type byte, and
the low 24 bits of the machine's Ethernet MAC address. QEMU already
reproduces this scheme, but until now neither half was settable from
the command line: the machine-type byte was fixed per hwdef, and the
low 24 bits always tracked whatever MAC ended up on the emulated NIC.
Both properties default to that existing behaviour when left unset,
so this series is fully backward compatible.

Patch 1 adds a small shared helper (hw/sparc/sun_hostid.c) rather
than duplicating the property getter/setter logic between the two
machine families: a generic SunHostIDProps struct that a machine's
own instance struct embeds anywhere, located via byte offset, plus
two functions to register the properties on a class and initialise
an instance.

Patch 2 wires this into sun4m, via the existing sun4m-common
abstract machine class.

Patch 3 wires it into sun4u/sun4v. Since sun4u.c had no shared
abstract machine class before this series, patch 3 introduces one
(sun4u-common) as the parent of both "sun4u" and "sun4v", and
registers the properties on it once - both machines pick them up
through QOM's class-hierarchy property lookup. The "niagara" machine
(hw/sparc64/niagara.c) is a separate machine family that does not
use this NVRAM/IDPROM hostid mechanism and is unaffected.

PS: This is my first patch set for QEMU.

---
Frode Tennebø (3):
      hw/sparc: add shared sun_hostid helper for hostid/machineid properties
      hw/sparc: add hostid= and machineid= -machine sub-properties
      hw/sparc64: add hostid= and machineid= -machine sub-properties

 docs/system/target-sparc.rst   | 23 +++++++++++
 docs/system/target-sparc64.rst | 22 +++++++++++
 hw/sparc/meson.build           |  1 +
 hw/sparc/sun4m.c               | 55 ++++++++++++++++++++++----
 hw/sparc/sun_hostid.c          | 88 ++++++++++++++++++++++++++++++++++++++++++
 hw/sparc64/meson.build         |  1 +
 hw/sparc64/sun4u.c             | 74 +++++++++++++++++++++++++++++++----
 include/hw/nvram/sun_nvram.h   | 11 ++++--
 include/hw/sparc/sun_hostid.h  | 48 +++++++++++++++++++++++
 9 files changed, 306 insertions(+), 17 deletions(-)
---
base-commit: f8296b816fabd370307cd22b0270b610fc0fa279
change-id: 20260917-add_hostid_sub-properties-473a0d2ea35e

Best regards,
-- 
Frode Tennebø <frode@tennebo.com>


