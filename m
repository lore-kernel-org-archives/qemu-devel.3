Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9F710F9968
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 20:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAZU3-00079x-HN; Wed, 08 Apr 2026 16:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wAZU2-00078c-IG
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:26:42 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wAZU0-0003jh-SZ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 16:26:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 08C5F596A2B;
 Wed, 08 Apr 2026 22:26:39 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hrfzoSrYV-h9; Wed,  8 Apr 2026 22:26:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 589D35969F6; Wed, 08 Apr 2026 22:26:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 56FD65968DD;
 Wed, 08 Apr 2026 22:26:36 +0200 (CEST)
Date: Wed, 8 Apr 2026 22:26:36 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Chad Jablonski <chad@jablonski.xyz>
Subject: Re: [PATCH-for-11.0 0/6] Misc patches for 2026-04-07
In-Reply-To: <80621a59-8948-bbbb-eb83-e12495a06467@eik.bme.hu>
Message-ID: <4fdc9c3c-f089-4cde-371f-8a5e0e17f4a8@eik.bme.hu>
References: <20260407215900.63390-1-philmd@linaro.org>
 <14805e95-c831-4eea-ae67-f011cb463cd2@linaro.org>
 <80621a59-8948-bbbb-eb83-e12495a06467@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="3866299591-787268042-1775679962=:8636"
Content-ID: <4ecf699f-94ec-14ed-10ed-aed3ac27ee8d@eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-787268042-1775679962=:8636
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <959a3074-c8b9-3ba3-3d05-aa1eee38e63c@eik.bme.hu>

On Wed, 8 Apr 2026, BALATON Zoltan wrote:
> On Wed, 8 Apr 2026, Philippe Mathieu-Daudé wrote:
>> Cc'ing Peter directly due to mailing-list issues.
>
> Thanks a lot for taking care of these. I think you meant to send PULL instead 
> of PATCH. Here's one more:
> https://patchew.org/QEMU/20260408104935.1A55A5969F6@zero.eik.bme.hu/
> the v1 of which had a review by Marc-André that might stand for v2 too as 
> that makes the check even mode strict.

And this one seems to have been missed:
https://patchew.org/QEMU/20260404111318.8334E596A22@zero.eik.bme.hu/
I'd need this in 11.0 too.

Regards,
BALATON Zoltan

>> On 7/4/26 23:58, Philippe Mathieu-Daudé wrote:
>>> The following changes since commit 
>>> b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:
>>>
>>>    Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)
>>> 
>>> are available in the Git repository at:
>>>
>>>    https://github.com/philmd/qemu.git tags/hw-misc-20260407
>>> 
>>> for you to fetch changes up to 992e01e838733c8063f8a17e92034c5f35e34963:
>>>
>>>    ati-vga: Do not crash on 24 bits per pixel (2026-04-07 22:40:29 +0200)
>>> 
>>> ----------------------------------------------------------------
>>> Misc HW patches
>>> 
>>> Few fixes, mostly for VGA display models.
>>> ----------------------------------------------------------------
>>> 
>>> BALATON Zoltan (4):
>>>    cirrus-vga: Make frame buffer endianness little endian by default
>>>    ati-vga: Fix setting CRTC_OFFSET
>>>    ati-vga: Update mode on CRTC_PITCH change
>>>    ati-vga: Do not crash on 24 bits per pixel
>>> 
>>> GuoHan Zhao (1):
>>>    hw/arm/omap_sx1: map CS3 at the correct base
>>> 
>>> Philippe Mathieu-Daudé (1):
>>>    docs/about/removed-features: Replace 'since' -> 'removed in'
>>>
>>>   docs/about/removed-features.rst | 32 +++++++++++++-------------
>>>   hw/arm/omap_sx1.c               |  2 +-
>>>   hw/display/ati.c                | 40 ++++++++++++++++++---------------
>>>   hw/display/ati_2d.c             |  9 ++++++++
>>>   hw/display/cirrus_vga.c         |  2 ++
>>>   5 files changed, 50 insertions(+), 35 deletions(-)
>>> 
>> 
>> 
>
--3866299591-787268042-1775679962=:8636--

