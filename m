Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FC8F54AC6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52vK-0001tv-QE; Tue, 24 Mar 2026 10:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w52vF-0001t2-7s; Tue, 24 Mar 2026 10:39:57 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w52vC-0007GH-DB; Tue, 24 Mar 2026 10:39:56 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5FE88596A46;
 Tue, 24 Mar 2026 15:39:47 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id cOmbp0JPFJy8; Tue, 24 Mar 2026 15:39:45 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 587AB596A44; Tue, 24 Mar 2026 15:39:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 56722596A41;
 Tue, 24 Mar 2026 15:39:45 +0100 (CET)
Date: Tue, 24 Mar 2026 15:39:45 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 marcandre.lureau@redhat.com, Chad Jablonski <chad@jablonski.xyz>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v6 0/8] ati-vga fixes
In-Reply-To: <5d1301df-aee0-44c0-a317-806331c16c35@tls.msk.ru>
Message-ID: <a9ce2924-ecb7-e992-1748-1f799f0de4fd@eik.bme.hu>
References: <cover.1774110169.git.balaton@eik.bme.hu>
 <68e1536d-5ffc-4c06-bbab-cece627a69c6@tls.msk.ru>
 <5d1301df-aee0-44c0-a317-806331c16c35@tls.msk.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2068789412-1774363185=:19704"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--3866299591-2068789412-1774363185=:19704
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 24 Mar 2026, Michael Tokarev wrote:
> On 24.03.2026 16:38, Michael Tokarev wrote:
>> On 21.03.2026 19:30, BALATON Zoltan wrote:
>
>>> BALATON Zoltan (8):
>>>    ati-vga: Fix colors when frame buffer endianness does not match host
>>>    ati-vga: Also switch mode on HW cursor enable bit change
>>>    ati-vga: Do not add crtc offset to src and dst data address
>>>    ati-vga: Avoid warnings about sign extension
>>>    ati-vga: Fix display updates in non-32 bit modes
>>>    ati-vga: Add work around for fuloong2e
>>>    ati-vga: Simplify pointer image handling
>>>    ati-vga: Make sure hardware cursor data is within vram
>> 
>> This stuff feels like it should be picked up for qemu-stable too,
>> what do you think?

Some of it might be but there were changes to ati-vga which likely cause
that these won't apply to older versions. Since ati-vga is still in
development and little used I would not bother backporting these.

> Um, this is a bit difficult, since there were quite some
> refactoring of this area for 11.0, so for previous qemu
> releases we should either pick up these refactorings or
> back-port the new changes.  Neither of which seems very
> important.

Yes, since ati-vga still needs more features to be emulated for most 
drivers it only works with a few simple and obscure ones (e.g. MorphOS) so 
those who want to use those should just update to latest QEMU. Most other 
drivers need the command processor which we don't emulate yet so they 
won't work anyway so it's not stable material yet in general.

Regards,
BALATON Zoltan
--3866299591-2068789412-1774363185=:19704--

