Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EBBFD88C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05cw-0001Ft-3w; Tue, 10 Mar 2026 18:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cs-0001F4-DM
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:30 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cq-00073C-As
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:29 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 2226bf5753dc04c7deb71992648278e3d76779ea72d219165660fe5e09f26e23 with SMTP id
 69b09bf43d2e7d2b970e413c; Tue, 10 Mar 2026 22:32:20 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181939;
 bh=Y42Luw1CtgLH7cB6YHzfHy4VIE56Mr+D+EZNW7tBsvc=;
 h=X-Mailgun-Dkim:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
 To:Cc:X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:
 Date:Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=ee4B6QMTcbSMe9627D8Xt9mVnQIOi+gousML5DSXc8PjdrLUWb8VVYjWKBh/grUzr
 KHH496ki4uUCsAXlbE4AvSloL6tIkPgHIMDZ/I3Sr0iL0k57StGFg37D1mAFOAoIlo
 ul/rkZ+nO32TYRbJQ9dJGWRLCT2FAlifdn5On0G1XVyNEjOsOlEJGNTkjZHJ96PQQY
 WF85nNGp9ShUU0A1UthAMkb1S5CaOeX3OJufI5VfuU3aUckdV+ezdNHtd1GkJF6fNC
 /x0u9B1mqswcPsQMvKOlMxuF34m+3kVMnXQEGKpfPfKGD+II7WMm8RLTQbQNJiOc52
 +jKciuXs0RD/g==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Subject: [PATCH 00/15] hw/alpha: QOMify Clipper and Typhoon
Date: Tue, 10 Mar 2026 17:31:40 -0500
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQ6CMAyA4VchPdtkG2OJvorxUKC4JjKwJUZDe
 Henx+/w/zsYq7DBpdlB+SUmS6nwpwaGTOXOKGM1BBeSa73D5zLL9EF6rJkwdb7tYorxHEaoyao
 8yfu/u96qezLGXqkM+TeZyTZWOI4vC+kJ3XcAAAA=
X-Change-ID: 20260310-qomify-alpha-65135464492d
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4183; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=l5hXVhhZtwq8zdzh8XiF1ZJ5EnTK6dRJZp3zOeDPx2k=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP5o73iNYeE0w1cdgZoz7A6x2M6Z8GzGroenTsff+
 RDM9EH9dUcpC4MYF4OsmCLL5bMSZx1yd3elrfxxH2YOKxPIEAYuTgGYiMhKRoYNc2w8eF+/V93v
 rSxl3Bh59NJkplWapflse3y3ZXnevaLE8M8yKOew1VIJHpO5M/5aVm32992rzNH6n7mr0+R5+ra
 PQbwA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

This series expands Alpha's use of the QEMU Object Model.
Currently, Typhoon's typhoon_init() serves as both
instance_init and realize for the chipset. The helper takes
several arguments that are passed to it by the machine (in
clipper_init()); to QOMify Typhoon and give them proper
hooks, this series incrementally eliminates all of the
parameters of typhoon_init().

But first, some small cleanups of checkpatch.pl style problems
and input validation in Patches 1-3.

Part of the motivation behind the series was to get Alpha
ready for the Resettable Interface, and Patch 4 helps with that
by using rom_add_blob_fixed() so that the initrd parameters are
in-place upon reset (once that is possible).

Patches 5 and on begin the QOMification process in earnest:
To begin, we define an instance_init skeleton that adds property
links for the CPUs to point to Typhoon's cchip.cpu elements and
some plumbing. Next, to parent the CPUs to the machine in
clipper_init() and remove the `cpus` array from the typhoon_init()
signature, we replace cpu_create invocations with object_new(),
add them as children, and set their links. Since we iterate over
the CPUs, we took this route instead of multiple DEFINE_PROP_LINKs
in a Property array.

Note: Patch 8 (the final CPU patch) eliminates `cpus` from the
init helper's (typhoon_init) prototype but also add a TyphoonState
pointer to it, because we'll need it until the end of the series
when all the remaining parameters have been eliminated.

Patch 9 replaces the two qemu_irq pointers in typhoon_init() with
qdev_{get,init}_gpio_in_named() invocations.

Ten deals with RAM; here, we use the DEFINE_PROP_LINK macro in a
Property array since we only need to add and set the link property
to the existing machine->ram.

Patches 11-13: Since the Typhoon expects a function pointer and a
static configuration value to be provided to it (via typhoon_init)
by the board, we extend the TyphoonClass definition to hold these
as members: the PCI IRQ mapper and minimum PCI device slot,
respectively; in the Clipper, we define the Typhoon subclass
(TYPHOON_PCIHOST_CLIPPER) such that it assigns both of these
hardware constants in the (sub)class_init.
After this leg of the series, typhoon_init() only has the
TyphoonState pointer remaining as a parameter; it needs
this, because it still realizes the bus among other things.

Patch 14: So that we could move the realize out of typhoon_init(),
first we need to be able to extract the PCI bus that it returns.
We do this in clipper_init() using QOM path resolution via
object_resolve_path_component().

Patch 15: Finally, with the return value and other parameters
eliminated, we can split the logic of typhoon_init() into its
instance_init and realize hooks, and replace it with
sysbus_realize_and_unref() in clipper_init(). Huzzah!

Thanks,
Yodel

---
Yodel Eldar (15):
      hw/alpha/typhoon: Fix whitespace and block comment style problems
      hw/alpha/dp264: Fix block comment style problems
      hw/alpha/dp264: Validate kernel and initrd sizes
      hw/alpha/dp264: Use rom_add_blob_fixed() for initrd params
      hw/alpha/typhoon: Create instance_init and class_init
      hw/alpha/dp264: Add CPUs as children of the machine
      hw/alpha: Use QOM composition for the Typhoon chipset
      hw/alpha: Set CPU link properties and use them
      hw/alpha: Convert IRQ pointers to named GPIOs
      hw/alpha: Expose RAM to typhoon via QOM property link
      hw/alpha: Explicitly define TyphoonClass in alpha_sys.h
      hw/alpha: Move PCI IRQ mapping to TyphoonClass subclass
      hw/alpha: Move minimum PCI device slot to TyphoonClass
      hw/alpha: Use QOM path resolution to get Typhoon PCI bus
      hw/alpha: Split typhoon_init() into instance_init and realize

 hw/alpha/alpha_sys.h |  18 +++-
 hw/alpha/dp264.c     | 121 ++++++++++++++++++++-------
 hw/alpha/typhoon.c   | 226 +++++++++++++++++++++++++++++++--------------------
 3 files changed, 249 insertions(+), 116 deletions(-)
---
base-commit: 63ec1f769490d8371fd03220eaede91cc7dd7c80
change-id: 20260310-qomify-alpha-65135464492d


