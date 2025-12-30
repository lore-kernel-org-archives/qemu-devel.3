Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5153E94122
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 14:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaaku-00056E-RI; Tue, 30 Dec 2025 09:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vaakr-00051B-Qe; Tue, 30 Dec 2025 09:31:21 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vaakp-0005bU-Gz; Tue, 30 Dec 2025 09:31:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0C65B596A0E;
 Tue, 30 Dec 2025 15:31:15 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id j3YYsJlYOYju; Tue, 30 Dec 2025 15:31:13 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F1B545969FA; Tue, 30 Dec 2025 15:31:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF46F5969F6;
 Tue, 30 Dec 2025 15:31:12 +0100 (CET)
Date: Tue, 30 Dec 2025 15:31:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, Alexander Graf <agraf@csgraf.de>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Jason Wang <jasowang@redhat.com>, 
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/3] system/memory: Extract 'qemu/memory_ldst_unaligned.h'
 header
In-Reply-To: <b81fec3d-022a-4b40-8b65-fc0904b88dab@linaro.org>
Message-ID: <27c5ad59-5a71-f0a2-b0e7-c03487ae4f62@eik.bme.hu>
References: <20251228161837.12413-1-philmd@linaro.org>
 <20251228161837.12413-3-philmd@linaro.org>
 <ffcf5368-9b35-d1c8-16ba-6b517e056469@eik.bme.hu>
 <0102f50b-0778-4a32-9bab-a4786a7b1b92@linaro.org>
 <b81fec3d-022a-4b40-8b65-fc0904b88dab@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1383952829-1767105072=:39524"
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

--3866299591-1383952829-1767105072=:39524
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 30 Dec 2025, Philippe Mathieu-Daudé wrote:
> On 28/12/25 21:04, Philippe Mathieu-Daudé wrote:
>> Hi Zoltan,
>> 
>> On 28/12/25 17:46, BALATON Zoltan wrote:
>>> On Sun, 28 Dec 2025, Philippe Mathieu-Daudé wrote:
>>>> Unaligned memcpy API is buried within 'qemu/bswap.h',
>>>> supposed to be related to endianness swapping. Extract
>>>> to a new header to clarify.
>>>> 
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> include/qemu/bswap.h                 | 62 +------------------------
>>>> include/qemu/memory_ldst_unaligned.h | 67 ++++++++++++++++++++++++++++
>>>> accel/tcg/translator.c               |  1 +
>>>> hw/display/ati_2d.c                  |  1 +
>>>> hw/display/sm501.c                   |  2 +-
>>>> hw/remote/vfio-user-obj.c            |  1 +
>>>> hw/vmapple/virtio-blk.c              |  1 +
>>>> net/checksum.c                       |  1 +
>>>> ui/vnc-enc-tight.c                   |  1 +
>>>> util/bufferiszero.c                  |  2 +-
>>>> 10 files changed, 76 insertions(+), 63 deletions(-)
>>>> create mode 100644 include/qemu/memory_ldst_unaligned.h
>>>> 
>>>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>>>> index b77ea955de5..e8b944988c3 100644
>>>> --- a/include/qemu/bswap.h
>>>> +++ b/include/qemu/bswap.h
>>>> @@ -1,6 +1,7 @@
>>>> #ifndef BSWAP_H
>>>> #define BSWAP_H
>>>> 
>>>> +#include "qemu/memory_ldst_unaligned.h"
>>> 
>>> If it's included here do users need to also include it separately or if so 
>>> should some of those users lose bswap.h include now instead of including 
>>> both this header and bswap.h? I think it's simpler to only include it here 
>>> and let users get it through bswap.h unless you review and remove now 
>>> unnecessary bswap.h includes from places that only need this hearder but I 
>>> don't know if that's worth the effort.
>> 
>> bswap API users have to include <qemu/bswap.h>,
>> users of ld/st_unaligned() one have to include <qemu/ 
>> memory_ldst_unaligned.h>.
>
> Let me try again.
>
> Users of the ld/st_unaligned() API have to include
> <qemu/ldst_unaligned.h>; if they don't use <qemu/bswap.h>
> then first it is pointless to include it, but furthermore
> it saves few compilation cycles for the unused inlined
> bswap functions.
>
> Users of the bswap() API have to include <qemu/bswap.h>
> (which indirectly includes <qemu/ldst_unaligned.h>, but
> this is irrelevant).
>
> Users of both the bswap() and ld/st_unaligned() APIs have
> to include both <qemu/bswap.h> AND <qemu/ldst_unaligned.h>,
> even if it is indirectly included. That makes the use of
> APIs more explicit in the source file, and furthermore it
> avoids code churn when indirect headers are reworked.

Your patch added #include of the new header to 8 files so this is already 
causing churn in the hope of avoiding it.

> For recent examples see commits 34bcd8f4ff9 ("hw/int/loongarch:
> Include missing 'system/memory.h' header") or fdda97b47e6
> ("hw/arm/virt-acpi-build: Include missing 'cpu.h' header").
>
> Is it clearer?

I did not notice that you removed bswap.h from 2 files and thought the 
patch only added the new header. In that case my comment does not apply 
but I still see this more as a churn than useful cleanup. OK, host endian 
does not swap but if you consider that the le and be functions in bswap.h 
are based on the he functions then you can just leave these there. If it 
bothers you add a comment, that's still less churn.

Regards,
BALATON Zoltan
--3866299591-1383952829-1767105072=:39524--

