Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F225C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWa0-0006Xo-UK; Thu, 01 Feb 2024 07:54:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rVWZy-0006Wx-VT; Thu, 01 Feb 2024 07:54:06 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rVWZw-00071v-Uo; Thu, 01 Feb 2024 07:54:06 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 4FB4BA00ED; Thu,  1 Feb 2024 13:54:02 +0100 (CET)
Date: Thu, 1 Feb 2024 13:54:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, 
 Miroslav Rezanina <mrezanin@redhat.com>
Subject: Re: [PATCH] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
In-Reply-To: <13ab647c-df89-49ab-8f76-8ce57d519aab@redhat.com>
Message-ID: <alpine.LMD.2.03.2402011352080.16176@eik.bme.hu>
References: <20240201082916.20857-1-thuth@redhat.com>
 <alpine.LMD.2.03.2402011326360.16176@eik.bme.hu>
 <13ab647c-df89-49ab-8f76-8ce57d519aab@redhat.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-1045938643-1706792042=:16176"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1117279078-1045938643-1706792042=:16176
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Feb 2024, Thomas Huth wrote:
> On 01/02/2024 13.39, BALATON Zoltan wrote:
>> On Thu, 1 Feb 2024, Thomas Huth wrote:
>>> For distros like downstream RHEL, it would be helpful to allow to disab=
le
>>> the CompactFlash device. For making this possible, we need a separate
>>> Kconfig switch for this device, and the code should reside in a separat=
e
>>> file.
>>>=20
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> hw/ide/qdev-ide.h=C2=A0 | 41 ++++++++++++++++++++++++++++++++
>>> hw/ide/cf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 58 ++++++++++++=
++++++++++++++++++++++++++++++++++
>>> hw/ide/qdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 51 ++--------------------=
------------------
>>> hw/ide/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
>>> hw/ide/meson.build |=C2=A0 1 +
>>> 5 files changed, 106 insertions(+), 49 deletions(-)
>>> create mode 100644 hw/ide/qdev-ide.h
>>> create mode 100644 hw/ide/cf.c
>>>=20
>>> diff --git a/hw/ide/qdev-ide.h b/hw/ide/qdev-ide.h
>>> new file mode 100644
>>> index 0000000000..3dd977466c
>>> --- /dev/null
>>> +++ b/hw/ide/qdev-ide.h
>>=20
>> This may be unrelated to this patch but we already have=20
>> include/hw/ide/internal.h which may be a place these should go in but th=
at=20
>> header is in inlcude because some files outside hw/ide include it. I've=
=20
>> found three places that include ide/internal.h: hw/arm/sbsa-ref.c,=20
>> hw/i386/pc.c and hw/misc/macio.h. Only macio is really needing internal =
IDE=20
>> parts the other two just uses some functions so macio is probably the=20
>> reason this wasn't cleaned up yet. In any case, maybe this could go in=
=20
>> include/hw/ide/internal.h to avoid introducing a new header or somehow m=
ake=20
>> this a local header where non-public parts of hw/ide/internal.h could be=
=20
>> moved in the future. Such as rename include/hw/ide/internal.h to ide.h a=
nd=20
>> name this one internal.h maybe?
>
> I don't like headers that much that just collect a lot of only slightly=
=20
> related things. That only causes problems again when you have to unentang=
le=20
> the stuff one day. So what's wrong with having a dedicated header for the=
=20
> stuff in hw/ide/qdev.c ?

Maybe that it's not obvious from the name that it belongs to qdev.c as the=
=20
names are not the same. Also some of the qdev stuff that should be in this=
=20
header are in include/hw/ide/internal.h so these will still be split=20
arbitrarily.

Regards,
BALATON Zoltan
--1117279078-1045938643-1706792042=:16176--

