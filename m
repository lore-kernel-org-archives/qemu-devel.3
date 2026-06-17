Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DA2CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 13:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZqnV-0007JD-3U; Wed, 17 Jun 2026 09:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZqnS-0007Ir-MV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:59:14 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZqnQ-0001Hf-BM
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 09:59:14 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B77E596988;
 Wed, 17 Jun 2026 15:59:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id yGjjOM6XWF-S; Wed, 17 Jun 2026 15:59:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6C40E59698A; Wed, 17 Jun 2026 15:59:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 69C98596989;
 Wed, 17 Jun 2026 15:59:06 +0200 (CEST)
Date: Wed, 17 Jun 2026 15:59:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [RFC 0/7] qom: deprecate embedded objects and instance properties
In-Reply-To: <b98ac13d-e508-4c0b-ba78-6e0a63f73e65@nutanix.com>
Message-ID: <f07da77e-972a-d62d-da21-460f31cfc257@eik.bme.hu>
References: <20260616155554.264412-1-berrange@redhat.com>
 <b98ac13d-e508-4c0b-ba78-6e0a63f73e65@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-946656722-1781704746=:6462"
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

--3866299591-946656722-1781704746=:6462
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 17 Jun 2026, Mark Cave-Ayland wrote:
> On 16/06/2026 16:55, Daniel P. Berrangé wrote:
>
>> QOM has two rather unusual / surprising features historicall
>>
>>   * The ability to embed a QOM instance's memory inside another
>>     struct
>>   * The ability to register properties against the instnce
>>     instead of struct
>> 
>> While they both look convenient on the surface, they also
>> have significant undesirable side effects (see the commit
>> message for each patch for details).
>> 
>> The premise of this series is that their convenience does
>> not outweigh their downsides, and we would be better off
>> long term by eliminating their usage, rather than trying
>> to add more hacks on top to mitigate their downsides.
>> 
>> This comes out of two separate conversations this week
>>
>>   * Migration series where Peter proposed changes that
>>     make use of instance  properties. When I commented,
>>     Peter rightly pointed out that our docs do not
>>     discourage use of instance properties:
>>          https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2026-2D06_msg02368.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=v-N9FJZ1ugUjERquAp1KfuZ3B20G9mdbHpEEFP5zkfs&e=
>>
>>   * QOM series where Akihiko proposed some funky hacks
>>     to reference counting to better track object lifecycle
>>     when embedding structs. We had a short discussion about
>>     discouraging QOM embedding, so this is a real world
>>     proposal:
>>
>>       https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.gnu.org_archive_html_qemu-2Ddevel_2026-2D06_msg03459.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=mHTDgFeywt1U_2Q9uTnAyG6zp-VjguJ4DZIJAX59vaY&e=
>> 
>> This is not likely to be a quick task, so this series
>> starts small
>>
>>   * Adds a "QEMU_DEPRECATIONS" annotation for internal APIs
>>   * Deprecate the QOM instance embedding
>>   * Deprecate the QOM instance properties
>>   * Deprecate the memory region embedding APIs
>>   * Deprecate the IRQ embedding APIs
>>   * Convert PIIX to eliminate embedding as a
>>     demonstration.
>> 
>> The QEMU_DEPRECATIONS idea is an effect to improve our our
>> historic practice where we introduce a new preferred API
>> and never really tell anyone the old APIs is bad to use.
>> 
>> If --enable-deprecations is given to configure, every use
>> of a deprecated API emits a compiler warning. This is not
>> enabled by default in this series, since we have -Werror
>> by default.
>
> I'm not sure if we're ready to start flagging things via the compiler, 
> however I'm in broad agreement that this is direction we need to travel. 
> Thanks for beating me to it, and starting the conversation :)
>
>> Note that the proposal to stop embedding memory regions has
>> been made by Zoltan earlier this year and was rejected by Paolo:
>>
>>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.nongnu.org_archive_html_qemu-2Ddevel_2026-2D01_msg05435.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=oAY3a1R4rnhYdl7-qnoTVjVdGOX1Qj-GvGlOX77oZrk&e=
>>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.nongnu.org_archive_html_qemu-2Ddevel_2026-2D05_msg06665.html&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=VzbegkrZ5TGWl9jpxLUfD3gMp4ZZjyUrMiBfOzSjpcaOU-hz3SuUIaGUiIM4BQdV&s=WmpukrnrmuhhTz7hLgAA-9FStZ3fbzH3P1aT_U9f6GY&e=
>> 
>> I don't really agree with the analysis there. IMHO,  the
>> concept of embedding objects is to horrendous to allow to
>> live any longer. Yes, that's a big job, but long term it
>> is worth it.
>
> FWIW my main objection to the series was that it added yet another way of 
> doing something to fix a particular issue in legacy code. I have a suspicion 
> that if we can make everything in QOM properly refcounted then this approach 
> could work globally: in particular I can see it would fix issues where the 
> flatviews hold references to memory regions outside of the device lifecycle 
> until the RCU thread tidies up.
>
> However as you can see, there would be quite a bit of work to get there. But 
> at least if we can all agree on the way forward, we can start to get the 
> relevant changes in place.

We can't convert the whole code base at once and it's unrealistic to 
expect a single contributor like me to do that to accept my patch. What I 
proposed is a start that can be used now for the cases I have and can 
serve as a basis for future conversions. I did not propose to convert 
everything either because I think having both ref counted and externally 
managed memory regions can be useful in different cases and I don't see 
having two ways for this confusing considering we have object_new and 
object_initialize for same reasons. But if we deprecate object_initialize 
then the memory_region_init functions are not needed either.

Originally I also thought about splitting alloc and init similar to how 
macOS Foundation does it (i.e. [[obj alloc] init]) so the allocation of 
the memory region could be done by either object_new or embedded but that 
does not work due to object_new setting free function and 
object_initialize clearing it so you can only use either one or the other. 
Therefore since memory_region_init calls object_initialize we need a 
memory_region_new variant that uses object_new instead or we end up 
having to convert the whole code base again to decouple object 
initialization from memory_region_init so I did not go that way.

Regards,
BALATON Zoltan
--3866299591-946656722-1781704746=:6462--

