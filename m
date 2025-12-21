Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D82AE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 19:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXP5y-0000Fp-Rz; Sun, 21 Dec 2025 14:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vXP5v-0000FX-L7; Sun, 21 Dec 2025 14:27:56 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick@stwcx.xyz>)
 id 1vXP5t-0001bP-77; Sun, 21 Dec 2025 14:27:55 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 099A71400046;
 Sun, 21 Dec 2025 14:27:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Sun, 21 Dec 2025 14:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1766345269;
 x=1766431669; bh=HIihH6iIXgfdFhfaNbVGxngTf8So9yTxtH4tpFzN8gM=; b=
 pZvmgRlA+Qo4c+pEA9SWrnYoyweGNlJS36Zrggrw3uYQFWJSk/F42hPviIfX4LIQ
 8ayRgzpod9uLE9QYb6O9PvBysWg91UicDHhE0haftUDt8KEIuTbn0HZm07HJtZ5O
 iIghGpDX8Do/a6wcYkcw0PFnklHqYZ32O7RsCO//wZZL6Ce/+lW2cNJwUfNU4y3P
 hdCQ70Ct46gSWhwNsApRIsN8gA7J/e+OI8Dw90fzW1GSElkx9jx4ZKzC7k2dnM9A
 UUgkBhVTnzamf4GcRp7sfreE+UC/ct+Cw/n2OteRizBELI3jMM7cFJm18wnbJQ+t
 sgXSWE7q4HB2V9T2NyBT8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766345269; x=
 1766431669; bh=HIihH6iIXgfdFhfaNbVGxngTf8So9yTxtH4tpFzN8gM=; b=t
 hRQaBdSTG4uPo2StpmYMeyK/xi6KHBJGPiYbylRlrWIjpCiywOiuY7ZaV/TyAbCd
 ca3etjAgAAGznypUMvJx6gKexaLGcGHsELh/8Y6lX4QcNVeEYtVvASPVCZlouhMN
 j4oxdGDlDhRigukUAIxOYvjFyN9Q5+XkWRMK9+aI2ZT6a0y0wL2A0x9U1btsLHCS
 C6RzyKK7h4ZVYREmt7o/DiLe6yGNGsBeTIP51jwI5vpd6pkh2S9eLXWCSqs3bCLv
 s5rL7EUyCh90aeal16mevRCbeumsoPIG437Pv8zTKpulWupu1k7kzttkqaQerZnD
 8ROdlkZfAvazu3RbYLRdA==
X-ME-Sender: <xms:NEpIaXTMaLWf1syq7VRP0PRnlcZ5PtYf58j0Jfx2m3V7N5E770cvoQ>
 <xme:NEpIaRufO3wczWn5JdtLDk3AM78P6tTBDxwZdEJ6V71xUgiz26SEPU9Ks8Wo5beri
 e-dqvVB2_ogNkS0DRkThQY7zFSMwWm1cHNZlK2zpUfZziPPCYWY72M>
X-ME-Received: <xmr:NEpIaYZIcuNZzHEqSBn4Jj0VzcK1otBIG127eDKJlveP2ltug_odZWutjF_c-zrRJhYe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehgeeltdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculddvfedmnecujfgurheptgfghfggufffkfhfvegjvffosehtqhhmtdhhtdej
 necuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehsth
 iftgigrdighiiiqeenucggtffrrghtthgvrhhnpeevvedvudevvdevtdegveeggeeghfdv
 vefhueehudevffevvddufefgfeegvdfhtdenucffohhmrghinhepkhgvrhhnvghlrdhorh
 hgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
 mhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiiipdhnsggprhgtphhtth
 hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqrghrmhesnhho
 nhhgnhhurdhorhhgpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprh
 gtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohep
 tghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvghtrghnohhushesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepthhhuhhthhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:NEpIaXGGyotfJvTBtOOJwF6cG0FkyiItkMCeqJayJvaoQehKEpQ5XA>
 <xmx:NEpIacwe9LCNYS8bZd3Hw__olJz7KbGwSUuiskEBYnQwA6NxrmhsDw>
 <xmx:NEpIaZnUmdtI6I7aWb_QmY-6oZm7-Nff3yeNGK9Z62-Uo8ArWRfTSA>
 <xmx:NEpIaVnKAsfLLlBDCFHgT8IY_PguqC5rb9JzcVaFTl_OsfP4WLDCIg>
 <xmx:NUpIaeuItoX_MqIcUh_ucvtISX_TDcpadAgUwUkNtTevNzGTBkoNTgq4>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Dec 2025 14:27:48 -0500 (EST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Patrick Williams <patrick@stwcx.xyz>
Mime-Version: 1.0 (1.0)
Subject: Re: [PULL 11/11] tests/functional: Add gb200 tests
Date: Sun, 21 Dec 2025 14:27:36 -0500
Message-Id: <937D27BA-2BC0-46F2-9DB6-5B50DC35611F@stwcx.xyz>
References: <51e9eb2a-78d4-4ec4-84a2-aea8c45ab8d4@redhat.com>
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ed Tanous <etanous@nvidia.com>,
 Thomas Huth <thuth@redhat.com>
In-Reply-To: <51e9eb2a-78d4-4ec4-84a2-aea8c45ab8d4@redhat.com>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: iPhone Mail (23B85)
Received-SPF: pass client-ip=103.168.172.155; envelope-from=patrick@stwcx.xyz;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I wonder if I broke Catalina also by moving files around. I=E2=80=99ll doubl=
e check these URIs and send a fix for QEMU.=20

=E2=80=94 Patrick Williams

> On Dec 21, 2025, at 1:06=E2=80=AFPM, C=C3=A9dric Le Goater <clg@redhat.com=
> wrote:
>=20
> =EF=BB=BFHi,
>=20
> + Patrick
>=20
>> On 12/21/25 15:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Ed, C=C3=A9dric,
>>> On 4/7/25 10:37, C=C3=A9dric Le Goater wrote:
>>> From: Ed Tanous <etanous@nvidia.com>
>>>=20
>>> To support the newly added gb200 machine, add appropriate tests and
>>> extend do_test_arm_aspeed_openbmc() to support the hostname of this
>>> new system: "gb200nvl-obmc".
>>>=20
>>> Signed-off-by: Ed Tanous <etanous@nvidia.com>
>>> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-5-etanou=
s@nvidia.com
>>> [ clg: Adjust commit log to document do_test_arm_aspeed_openbmc() change=
 ]
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> ---
>>>   tests/functional/aspeed.py                    |  9 +++++--
>>>   tests/functional/meson.build                  |  2 ++
>>>   .../test_arm_aspeed_gb200nvl_bmc.py           | 26 +++++++++++++++++++=

>>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>>   create mode 100644 tests/functional/test_arm_aspeed_gb200nvl_bmc.py
>>>=20
>>> diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
>>> index 7a40d5dda736..b131703c5283 100644
>>> --- a/tests/functional/aspeed.py
>>> +++ b/tests/functional/aspeed.py
>>> @@ -8,8 +8,13 @@
>>>   class AspeedTest(LinuxKernelTest):
>>>       def do_test_arm_aspeed_openbmc(self, machine, image, uboot=3D'2019=
.04',
>>> -                                   cpu_id=3D'0x0', soc=3D'AST2500 rev A=
1'):
>>> -        hostname =3D machine.removesuffix('-bmc')
>>> +                                   cpu_id=3D'0x0', soc=3D'AST2500 rev A=
1',
>>> +                                   image_hostname=3DNone):
>>> +        # Allow for the image hostname to not end in "-bmc"
>>> +        if image_hostname is not None:
>>> +            hostname =3D image_hostname
>>> +        else:
>>> +            hostname =3D machine.removesuffix('-bmc')
>>>           self.set_machine(machine)
>>>           self.vm.set_console()
>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build=

>>> index fb87b957aa6c..050c9000b95c 100644
>>> --- a/tests/functional/meson.build
>>> +++ b/tests/functional/meson.build
>>> @@ -33,6 +33,7 @@ test_timeouts =3D {
>>>     'arm_aspeed_ast2600' : 1200,
>>>     'arm_aspeed_bletchley' : 480,
>>>     'arm_aspeed_catalina' : 480,
>>> +  'arm_aspeed_gb200nvl_bmc' : 480,
>>>     'arm_aspeed_rainier' : 480,
>>>     'arm_bpim2u' : 500,
>>>     'arm_collie' : 180,
>>> @@ -129,6 +130,7 @@ tests_arm_system_thorough =3D [
>>>     'arm_aspeed_ast2600',
>>>     'arm_aspeed_bletchley',
>>>     'arm_aspeed_catalina',
>>> +  'arm_aspeed_gb200nvl_bmc',
>>>     'arm_aspeed_rainier',
>>>     'arm_bpim2u',
>>>     'arm_canona1100',
>>> diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/fu=
nctional/test_arm_aspeed_gb200nvl_bmc.py
>>> new file mode 100644
>>> index 000000000000..8e8e3f05c1b2
>>> --- /dev/null
>>> +++ b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
>>> @@ -0,0 +1,26 @@
>>> +#!/usr/bin/env python3
>>> +#
>>> +# Functional test that boots the ASPEED machines
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +from qemu_test import Asset
>>> +from aspeed import AspeedTest
>>> +
>>> +
>>> +class GB200Machine(AspeedTest):
>>> +
>>> +    ASSET_GB200_FLASH =3D Asset(
>>> +        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/ma=
ster/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.s=
tatic.mtd.xz',
>> This test is failing for me:
>> 2025-12-21 11:10:40,608 - qemu-test - INFO - Downloading https://github.c=
om/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc=
-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz to /builds/philmd=
/qemu/functional-cache/download/b84819317cb3dc762895ad507705978ef000bfc77c50=
c33a63bdd37921db0dbc...
>> 2025-12-21 11:10:40,798 - qemu-test - ERROR - Unable to download https://=
github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-o=
bmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz: HTTP err=
or 404
>> urllib.error.HTTPError: HTTP Error 404: Not Found
>> qemu_test.asset.AssetError: https://github.com/legoater/qemu-aspeed-boot/=
raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc=
-20250702182348.static.mtd.xz: Unable to download: HTTP error 404
>> make: *** [Makefile:170: run-ninja] Error 1
>=20
> I believe this due to :
>=20
>  https://github.com/legoater/qemu-aspeed-boot/commit/52451b2472eeb40aa97e1=
31aeea327e9d4a8a78a
>=20
> To fix, I can 'revert' the change above or we can fix QEMU.
>=20
> Thanks,
>=20
> C.
>=20


