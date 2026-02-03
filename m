Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFDE8B36D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnP38-0001L6-PG; Tue, 03 Feb 2026 17:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnP35-0001Kg-6J; Tue, 03 Feb 2026 17:39:07 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vnP33-0000mJ-Dp; Tue, 03 Feb 2026 17:39:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 60D6C5969FA;
 Tue, 03 Feb 2026 23:39:01 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id gE0Hl3H2c2rv; Tue,  3 Feb 2026 23:38:58 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CFD325969F6; Tue, 03 Feb 2026 23:38:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA48B5969F3;
 Tue, 03 Feb 2026 23:38:58 +0100 (CET)
Date: Tue, 3 Feb 2026 23:38:58 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v4 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
In-Reply-To: <3e6fcc5f-154d-4a71-aa7f-d42f04136616@linaro.org>
Message-ID: <221a990d-cad7-e39c-2c2c-1aace5c3c3af@eik.bme.hu>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
 <3e6fcc5f-154d-4a71-aa7f-d42f04136616@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1529982551-1770158338=:45002"
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

--3866299591-1529982551-1770158338=:45002
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 3 Feb 2026, Philippe Mathieu-Daudé wrote:
> On 3/2/26 21:56, Pierrick Bouvier wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> 
>> Endianness access is constant between device resets.
>> Use the field instead of calling the same function.
>
> Maybe we should justify here, simply adding from your v3 comment:
>
>  When doing automated benchmark with fio (see instructions
>  in [*]) this resulted in a +1.4% speedup vs existing code.
>
>  [*] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/

What does existing code refer to here? According to cover letter it's 
within 0.003% of existing speed so not actually faster but only a tiny bit 
slower. The speed up above maybe from previous version of the series 
without this patch so maybe clarify that more if you include this in the 
commit message.

Regards,
BALATON Zoltan

>> 
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>>   hw/virtio/virtio.c                |  4 ++--
>>   2 files changed, 14 insertions(+), 14 deletions(-)
>
>
>
--3866299591-1529982551-1770158338=:45002--

