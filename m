Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C2EEC1430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 13:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxPWY-0000YC-IN; Tue, 03 Mar 2026 08:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxPW5-0000Ev-Gl
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:10:27 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vxPW3-0000jV-2y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 08:10:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 988F1596A0A;
 Tue, 03 Mar 2026 14:10:19 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JdGUgkfkNFcW; Tue,  3 Mar 2026 14:10:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 294AE5969FA; Tue, 03 Mar 2026 14:10:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 273585969F2;
 Tue, 03 Mar 2026 14:10:17 +0100 (CET)
Date: Tue, 3 Mar 2026 14:10:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 4/8] memory: Remove memory_region_init_ram_nomigrate()
In-Reply-To: <CAFEAcA_u=6KuDNs+DT9yOvPwNac1tTMfx+0r2drDjvKHHt+etg@mail.gmail.com>
Message-ID: <dfb1d623-7f64-b5dc-89bb-8a827a9b1996@eik.bme.hu>
References: <cover.1772397447.git.balaton@eik.bme.hu>
 <ff683ccd3433cdaa72aa6b5c97dc9431c67ff5c5.1772397447.git.balaton@eik.bme.hu>
 <CAFEAcA_u=6KuDNs+DT9yOvPwNac1tTMfx+0r2drDjvKHHt+etg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 3 Mar 2026, Peter Maydell wrote:
> On Sun, 1 Mar 2026 at 21:03, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> This is rarely needed and we can use
>> memory_region_init_ram_flags_nomigrate() instead which is now the only
>> nomigrate variant left.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> I don't think this one is worth doing. We might as well
> wait until we can get rid of the VGA case.

There are two more uses that pass non-0 flags so even with the vga we 
can't completely remove memory_region_init_ram_flags_nomigrate(), the vga 
and xtensa are the ones that can use 
memory_region_init_ram_flags_nomigrate with flags=0 then we don't need 
memory_region_init_ram_nomigrate. But if everybody is so attached to this 
function for only these two uses that are to be removed soon I can drop 
this patch and keep memory_region_init_ram_nomigrate for now but I don't 
see why.

>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>> index d427d68e50..b025cc53a8 100644
>> --- a/hw/xtensa/xtfpga.c
>> +++ b/hw/xtensa/xtfpga.c
>> @@ -163,8 +163,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
>>              sysbus_mmio_get_region(s, 1));
>>
>>      ram = g_malloc(sizeof(*ram));
>> -    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
>> -                           &error_fatal);
>> +    memory_region_init_ram_flags_nomigrate(ram, OBJECT(s), "open_eth.ram",
>> +                                           16 * KiB, 0, &error_fatal);
>>      vmstate_register_ram_global(ram);
>>      memory_region_add_subregion(address_space, buffers, ram);
>>  }
>
> We should change this to memory_region_init_ram(), taking
> the compat break (which is fine for xtensa).

There's a patch in the follow up series that will convert this:

https://patchew.org/QEMU/cover.1770753117.git.balaton@eik.bme.hu/d2407882ecc62a51781dec51791c91d331802fa3.1770753117.git.balaton@eik.bme.hu/

so until then I chose to just preserve this for now as this is the 
simplest change here and we still have a similar one in vga but if we 
finally can get over this series and can discuss the follow ups then this 
should eventually be converted during that. So I don't think it matters 
when we take the migration break for this device and this way it's 
simpler. If we could remove the vga one now then it might worth to do the 
same here but since that's still there I think this is OK too.

Regards,
BALATON Zoltan

