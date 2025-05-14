Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28595C3ABDE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAdQ-0005ty-Nt; Wed, 14 May 2025 07:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAdJ-0005sa-JQ
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:46 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAdH-00066r-6J
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:50:45 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8CCF55C0CE;
 Wed, 14 May 2025 13:50:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id SiaQK3C4m2Ty; Wed, 14 May 2025 13:50:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A6DCA55BC02; Wed, 14 May 2025 13:50:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A4FDE745682;
 Wed, 14 May 2025 13:50:37 +0200 (CEST)
Date: Wed, 14 May 2025 13:50:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Weifeng Liu <weifeng.liu.z@gmail.com>
cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 1/9] ui/gtk: Document scale and coordinate handling
In-Reply-To: <ce6e4a42353118fe41e59f2e6ef79d6df959692b.camel@gmail.com>
Message-ID: <a1bfa963-e4e2-f869-92e2-12312ad5dc89@eik.bme.hu>
References: <20250511073337.876650-1-weifeng.liu.z@gmail.com>
 <20250511073337.876650-2-weifeng.liu.z@gmail.com>
 <hyeijrn3pxl5r5ij2zryiaar5xcqpj7oigpzwgdl3bl5wslddu@fdfgzn27uy52>
 <ce6e4a42353118fe41e59f2e6ef79d6df959692b.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-844254991-1747223437=:15654"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

--3866299591-844254991-1747223437=:15654
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 14 May 2025, Weifeng Liu wrote:
> Hi Gerd,
> On Mon, 2025-05-12 at 13:46 +0200, Gerd Hoffmann wrote:
>> On Sun, May 11, 2025 at 03:33:11PM +0800, Weifeng Liu wrote:
>>> The existence of multiple scaling factors forces us to deal with
>>> various
>>> coordinate systems and this would be confusing. It would be
>>> beneficial
>>> to define the concepts clearly and use consistent representation
>>> for
>>> variables in different coordinates.
>>>
>>> Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
>>> ---
>>>  ui/gtk.c | 65
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 65 insertions(+)
>>>
>>> diff --git a/ui/gtk.c b/ui/gtk.c
>>> index 982037b2c0..9f3171abc5 100644
>>> --- a/ui/gtk.c
>>> +++ b/ui/gtk.c
>>> @@ -800,6 +800,71 @@ void
>>> gd_update_monitor_refresh_rate(VirtualConsole *vc, GtkWidget
>>> *widget)
>>>  #endif
>>>  }
>>>  
>>> +/**
>>> + * DOC: Coordinate handling.
>>> + *
>>> + * We are coping with sizes and positions in various coordinates
>>> and the
>>> + * handling of these coordinates is somewhat confusing. It would
>>> benefit us
>>> + * all if we define these coordinates explicitly and clearly.
>>> Besides, it's
>>> + * also helpful to follow the same naming convention for variables
>>> + * representing values in different coordinates.
>>> + *
>>> + * I. Definitions
>>> + *
>>> + * - (guest) buffer coordinate: this is the coordinates that the
>>> guest will
>>> + *   see. The x/y offsets and width/height specified in commands
>>> sent by
>>> + *   guest is basically in buffer coordinate.
>>> + *
>>> + * - (host) pixel coordinate: this is the coordinate in pixel
>>> level on the
>>> + *   host destop. A window/widget of width 300 in pixel coordinate
>>> means it
>>> + *   occupies 300 pixels horizontally.
>>> + *
>>> + * - (host) logical window coordinate: the existence of global
>>> scaling
>>> + *   factor in desktop level makes this kind of coordinate play a
>>> role. It
>>> + *   always holds that (logical window size) * (global scale
>>> factor) =
>>> + *   (pixel size).
>>> + *
>>> + * - global scale factor: this is specified in desktop level and
>>> is
>>> + *   typically invariant during the life cycle of the process.
>>> Users with
>>> + *   high-DPI monitors might set this scale, for example, to 2, in
>>> order to
>>> + *   make the UI look larger.
>>> + *
>>> + * - zooming scale: this can be freely controlled by the QEMU user
>>> to zoom
>>> + *   in/out the guest content.
>>> + *
>>> + * II. Representation
>>> + *
>>> + * We'd like to use consistent representation for variables in
>>> different
>>> + * coordinates:
>>> + * - buffer coordinate: prefix fb
>>> + * - pixel coordinate: prefix p
>>> + * - logical window coordinate: prefix w
>>> + *
>>> + * For scales:
>>> + * - global scale factor: prefix gs
>>> + * - zooming scale: prefix scale/s
>>> + *
>>> + * Example: fbw, pw, ww for width in different coordinates
>>> + *
>>> + * III. Equation
>>> + *
>>> + * - fbw * gs * scale_x = pw
>>
>> Well.  That is one possible approach (and this is what qemu is doing
>> today, for historical reasons, because most code dates back to pre
>> high-dpi days).
>>
>> A possible alternative would be to go for fbw * scale_x = pw, i.e.
>> let
>> the guest run in pixel coordinates instead of window coordinates. 
>> The
>> guest would do the high-dpi scaling then.  That requires setting
>> physical display width and height in ui_info, so the guest can figure
>> what the display resolution is and go into high-dpi mode if needed.

Does that assume the guest knows about hidpi and has its own scale factor? 
What if I want to run an old guest that cannot do hidpi on a modern host. 
Can I still specify a scale factor to scale it up to usable size? That's a 
use case I care about which might be unusual but does exist.

Regards,
BALATON Zoltan

>
> Thanks for your suggestion. Sounds like code could be simplified and be
> much easier to understand in this way. I will investigate it on top of
> this change.
>
> Best regards,
> Weifeng
>
>> We probably also need a non-high-dpi compatibility mode for old
>> guests.
>> That mode would start with "zooming scale = global scale" instead of
>> "zooming scale = 1", and the dpi calculation would have to consider
>> that too.
>>
>> (maybe best done on top of this nice cleanup).
>>
>> take care,
>>   Gerd
>
>
--3866299591-844254991-1747223437=:15654--

