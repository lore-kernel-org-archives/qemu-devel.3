Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2B8CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCIO-00040C-Ns; Thu, 18 Jun 2026 08:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1waCIL-0003zk-2X
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:56:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1waCII-0005gE-U0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:56:32 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7CA78596992;
 Thu, 18 Jun 2026 14:56:27 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id RxRy3eOCM4xh; Thu, 18 Jun 2026 14:56:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ED55E596990; Thu, 18 Jun 2026 14:56:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EBA2059698E;
 Thu, 18 Jun 2026 14:56:23 +0200 (CEST)
Date: Thu, 18 Jun 2026 14:56:23 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?GB2312?B?yNnS5bL9?= <rongyichang@xiaomi.com>
cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "armbru@redhat.com" <armbru@redhat.com>, 
 "eblake@redhat.com" <eblake@redhat.com>
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_=5BExternal_Mail=5DRe=3A_=5BPATC?=
 =?GB2312?Q?H_qemu=5D_ui=2Fsdl2=3A_add_grab-on-tablet_option_f?=
 =?GB2312?Q?or_absolute_input_devices?=
In-Reply-To: <8d662e1969be4a9a89c0b38991986ebe@xiaomi.com>
Message-ID: <ab92e599-e6aa-5ddc-a3e1-e0ea45fc032d@eik.bme.hu>
References: <178065435170.20548.15372728064868431795-0@git.sr.ht>,
 <f54a2b09-f144-abc3-6163-563908c336a3@eik.bme.hu>
 <8d662e1969be4a9a89c0b38991986ebe@xiaomi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-414663540-1781787383=:28959"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-414663540-1781787383=:28959
Content-Type: text/plain; charset=gb2312; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 6 Jun 2026, 荣义昌 wrote:
> Hi,
>
> Thanks for the review.
>
> If we use a generic name like "click-to-grab" (not tablet-specific),
> should we also consider the reverse direction — i.e., allowing relative
> (mouse) devices to use the tablet-style edge-ungrab/regrab behavior
> via something like "click-to-grab=off"?
>
> Currently relative devices always use click-to-grab, and absolute
> devices always use edge-based auto-grab. If we make this a generic
> toggle, the semantics would be:
>
>  -display sdl,click-to-grab=on   → both device types use click-to-grab
>  -display sdl,click-to-grab=off  → both device types use edge-ungrab

You are right, I haven't thought about that.

> However, edge-ungrab doesn't really work for relative (mouse) devices,
> because once the mouse escapes the window, SDL stops delivering motion
> events and the guest cursor becomes uncontrollable.

Is the problem with relative devices related to the issue I reported here:
https://lists.nongnu.org/archive/html/qemu-devel/2026-04/msg01858.html
(but got no answer for that so far)?

> So in practice, this option can only meaningfully change behavior for
> absolute devices. That's why I chose a tablet-specific name — to make
> it clear that it only affects absolute coordinate devices.
>
> That said, I'm open to "click-to-grab=on|off" if you prefer a more
> generic name. The implementation would remain the same (only affecting
> absolute devices), just with a more general name.
>
> What do you think?

I'd leave that decision to the maintainers, I'd prefer a generic name and 
fixing relative devices so edge-grab works for those too but without that 
having a generic option that behaves differently with absolute and 
relative devices can be confusing. Maybe changing the default to always 
use click to grab and adding an option to enable edge grab which could be 
enabled for both but only recommended to use with absolute device now 
until relative devices are fixed could work but I don't know if that would 
lead to inconsistencies with other display backends (but we probably 
already have inconsistencies so we should try to do what other backends do 
to stay consistent). I don't have enough knowledge to decide on this so 
that's all I could add to this.

Regards,
BALATON Zoltan

> Best regards,
> Yichang
>
>
> ________________________________
> 发件人: BALATON Zoltan <balaton@eik.bme.hu>
> 发送时间: 2026年6月6日 0:47:00
> 收件人: 荣义昌
> 抄送: qemu-devel@nongnu.org; marcandre.lureau@redhat.com; armbru@redhat.com; eblake@redhat.com
> 主题: [External Mail]Re: [PATCH qemu] ui/sdl2: add grab-on-tablet option for absolute input devices
>
> [外部邮件] 此邮件来源于小米公司外部，请谨慎处理。若对邮件安全性存疑，请将邮件转发给misec@xiaomi.com进行反馈
>
> On Fri, 5 Jun 2026, ~rongyichang wrote:
>> From: rongyichang <rongyichang@xiaomi.com>
>>
>> When using absolute coordinate input devices (e.g. virtio-tablet-device),
>> the SDL display backend implements a "soft grab" where the mouse is
>> automatically grabbed when it enters the window interior and ungrabbed
>> when it hits the window edge. This edge-ungrab behavior causes problems
>> in embedded emulation scenarios:
>>
>> 1. Mouse escapes the SDL window at edges
>> 2. SDL does not deliver BUTTONUP events for the escaped mouse
>> 3. The guest gets stuck in a pressed/touch-down state
>> 4. First click back into the window is silently dropped
>>
>> This issue is confirmed as a known SDL limitation (SDL issue #5301).
>>
>> Add a new -display sdl,grab-on-tablet=on option that makes absolute
>> coordinate devices use the same grab behavior as relative (mouse)
>> devices: user must click to grab, Ctrl+Alt+G to release, and no
>> automatic grab on window enter or edge-based ungrab/regrab.
>
> Maybe it's better to name the option click-to-grab or grab-on-click or
> something similar as that's what it changes and not specific to tablets.
>
> Regards.
> BALATON Zoltan
> #/******本邮件及其附件含有小米公司的保密信息，仅限于发送给上面地址中列出的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本邮件！ This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
>
--3866299591-414663540-1781787383=:28959--

