Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DA4CD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 21:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpxY3-0005lK-H2; Thu, 28 Mar 2024 17:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rpxY0-0005kx-L4
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 17:44:33 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rpxXx-0003Uk-Tj
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 17:44:32 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8E9704E6060;
 Thu, 28 Mar 2024 22:44:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bkq5OH6xuk1y; Thu, 28 Mar 2024 22:44:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44EDA4E605E; Thu, 28 Mar 2024 22:44:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 409FD7456B4;
 Thu, 28 Mar 2024 22:44:24 +0100 (CET)
Date: Thu, 28 Mar 2024 22:44:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Rene Engel <ReneEngel80@emailn.de>
cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, 
 akihiko.odaki@daynix.com, kraxel@redhat.com, balaton@eik.bme.hu
Subject: Re: Qemu Display Coacoa Patch Serie Qemu 9.0 RC1
In-Reply-To: <26c7f97e9ce7fc10de24da84aa10638a@mail.emailn.de>
Message-ID: <2b4fcc6d-6e23-2ac9-7f55-6b488e327cd3@eik.bme.hu>
References: <26c7f97e9ce7fc10de24da84aa10638a@mail.emailn.de>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1544451827-1711662264=:86866"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-1544451827-1711662264=:86866
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 28 Mar 2024, Rene Engel wrote:
> I wanted to discuss this topic with you again, there was already a patch series that worked well under Qemu with
> Pegasos2/AmigaOneXe/Same460 and AmigaOs4.1. The option zoom-to-fit=on should be used to adjust all resolutions provided by the guest
> system to the aspect ratio if there are no Virtio GPU drivers available that allow this. 
> 
> In my opinion exactly this option zoom-to-fit=on makes this possible. If you don't want to use this option you still have the possibility
> to deactivate it. In Qemu 9.0 RC1 not all resolutions are stretched like in previous patches e.g. 640x480/800x600/1024x720 etc. but this
> is exactly what we need for the Pegasos2/AmigaOneXe/Same460 machine with AmigaOs4.1. 

There seems to be a bit of confusion about how this zoom-to-fit option is 
implemented by different -display backends and I'm not sure what is the 
intended behaviour or how other -display backends handle it. Maybe a 
single option is not even enough to describe all possible preferences so 
another one i.e. keep-aspect=true|false may also be needed to cover all 
possible settings (don't zoom, zoom with aspect ratio kept, zoom to fit 
window even if that stretches the picture out of aspect ratio). For 9.0 
ptobsbly we should go for consistency with other backends now as adding 
new options is not possible during freeze and then resolve this 
afterwards.

> There are also problems within the resolutions with the mouse pointer 
> where the screen output flickers it currently affects all patch series. 
> I would be happy if we could find a solution for all this. 

The flicker may be due to the resize algorithm used by macOS not giving 
the same result always. To resolve it maybe yet another option may be 
needed to not zoom to full available window but try to keep the zoom 
factor some integer value to avoid fractional scaling but I'm not sure 
that's the best way to solve it.

Regards,
BALATON Zoltan

> I'll leave you 2 videos so you can decide for yourself what would make the most sense. It shows once for me the working zoom behavior
> which works very well and the behavior with Qemu 9.0Rc1 including new Cocoa patches. 
> 
> Qemu zoom-to fit=on for all Screenmodes working: https://www.youtube.com/watch?v=dnJ3W8egAFY
> 
> Qemu 9.0. RC1 zoom-to fit=on not working for all Screenmodes: https://www.youtube.com/watch?v=Ddq68ViudrA
> 
> 
> 
>
--3866299591-1544451827-1711662264=:86866--

