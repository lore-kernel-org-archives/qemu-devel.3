Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2264FF588EE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEr7P-0002aV-2E; Mon, 20 Apr 2026 12:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wEr7F-0002Zs-8a
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:04:54 -0400
Received: from 12.mo534.mail-out.ovh.net ([46.105.38.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wEr7B-0008La-Kj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:04:52 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4fzr0X0XjWz69Df;
 Mon, 20 Apr 2026 16:04:44 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Mon, 20 Apr 2026 16:04:43 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.118.110])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4fzr0W2X9Zz7tpv;
 Mon, 20 Apr 2026 16:04:43 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.2])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 A0BA21923A4E; Mon, 20 Apr 2026 16:04:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006c14620b7-62dd-4835-b067-d1c837c195b1,
 EAA5D49A92D75878AB6B5DB8F91ADF3A5E4E180D) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <0c533df3-b06c-4fc6-a4b9-6e17206525a3@kaod.org>
Date: Mon, 20 Apr 2026 18:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
 64-bit
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Xu <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-7-jamin_lin@aspeedtech.com>
 <3ee36a34-573e-48aa-91e3-9140244717f0@kaod.org> <aeJNdLTRSZQiEiP_@x1.local>
 <TYPPR06MB8206C244CD249505E6B543F8FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206C244CD249505E6B543F8FC2F2@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 5664120960398634029
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGvwZSjt39E3HlnwmuEG8hDeh17NAVdT5eVOqgxCxFCkjjPXHU7aSo5ft44RwcFezCW87m3vSkjGIhC2uD+aVm0+0XjD/yrh6evairdT1LDhzjkLrBda8vscQ3+W1L4UTHhrp/WE1LAgk9jTk5WvEbfBv1jXSBCzJB0EldqNJ92ezYtsr1iA2zg4c6SjBWGOt5cooDjWbof9ay/tozsWd+fMlghWmzTbxawBlhOWjam4pzNkJbnZ8lWhiCRTjhs69y4/AmIv5QwflDtpIzgVCcJb5k62CwfIMpP9pKgySAveigw/8ZJzC8/ueQgA+ssT3EM0nBXM3zz104sk1K+lQwrS7aartV24n9CzenXehCLzDaj4vqZREBdY9haGdpeaBdiX3LAHxRPN2ga6wtbgIsaejBLK6Yeofs+3gugnEvQt+nM+YCB3xxOTdk9EceDOApbiGj+1S2/Ct+x1uQm+AuoLMqfjzoljIAff4lcddjRTyhVZAU6kWkoK8q+uPxkiECyuZZMwa0jUZfdSDC3UJgirSfOXthw2DkOyDarNyYfgI2Xg/wuC4ayccawlOHIavixorUL7/y9Oo20bCTs4IcslE9s4eHVWUIxCUD1YLBaQxWgVE7ZeuseE37d7tfNhZVs0N5wjr2l/hwyIOn6ba8eQUA7s/zPoPAhENB2NSOK5Q
DKIM-Signature: a=rsa-sha256; bh=elFmBHnkOK5JuvbSDcpWtsM1VRPeh5OWZrEiTqAmlgQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1776701085; v=1;
 b=ihts3t80fCUW5CHg8aNkuUGWchzzXsGe8gBOwGp7Zmsnwduj3iaV2gVHrDX3DqDAM1MzfbNp
 2A2vweMmIpE6qjnBci0izYu+mhNdxFD79b+w5XKuSTQZH+UOvXSGptxWGHCQ8BJFe4aYs7nv0rq
 xHjbHTb7xs64SRnV+t88t6HX9p97OhGF7czSg1sLjTNFIRQKcZog5b6uVf5H0vKo3StoVByZyLD
 H77l8oSSSnDSIbdnFJkUVHO30xygSfRytKZT6LvncZTyuGIaIczzvHy/X+wNczLtqZCbjFHtdzC
 DHKKQC54xT9molCUM7NCB4zrjgU6Q9952X64XIT7Wjd1Q==
Received-SPF: pass client-ip=46.105.38.145; envelope-from=clg@kaod.org;
 helo=12.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 4/20/26 07:56, Jamin Lin wrote:
> Hi Peter, Philippe, Cédric
> 
>> Subject: Re: [PATCH v3 06/17] hw/usb/hcd-ehci: Change descriptor addresses to
>> 64-bit
>>
>> On Fri, Apr 17, 2026 at 09:01:34AM +0200, Cédric Le Goater wrote:
>>> + Peter, Fabiano,
>>>
>>> On 4/16/26 03:49, Jamin Lin wrote:
>>>> Change internal EHCI descriptor addresses from uint32_t to uint64_t.
>>>>
>>>> The following fields are updated:
>>>> - EHCIPacket::qtdaddr
>>>> - EHCIQueue::{qhaddr, qtdaddr}
>>>> - EHCIState::{a_fetch_addr, p_fetch_addr}
>>>>
>>>> Update get_dwords() and put_dwords() to take 64-bit addresses and
>>>> propagate the type change through the descriptor traversal paths.
>>>>
>>>> Adjust NLPTR_GET() to operate on 64-bit values:
>>>>
>>>>       #define NLPTR_GET(x) ((x) & ~0x1fULL)
>>>>
>>>> so that link pointer masking works correctly when descriptor
>>>> addresses exceed 32-bit space. The previous mask (0xffffffe0)
>>>> implicitly truncated addresses to 32 bits.
>>>>
>>>> This patch does not change the on-wire descriptor layout yet.
>>>> It only removes the internal 32-bit address limit and prepares for
>>>> later patches that will add full 64-bit QH/qTD/iTD/siTD support.
>>>>
>>>> Update the EHCI trace-events prototypes for QH, qTD, iTD, and siTD
>>>> to use uint64_t for the address argument and print it with PRIx64.
>>>> This ensures full 64-bit addresses are shown in trace output and
>>>> improves debugging of queue heads and transfer descriptors.
>>>>
>>>> Migration compatibility:
>>>>
>>>> The fetch address fields in EHCIState are extended from 32-bit to
>>>> 64-bit, requiring a VMState version bump (v2 -> v3).
>>>>
>>>> Backward compatibility is preserved by keeping the legacy 32-bit
>>>> fields (a_fetch_addr_pre_v3, p_fetch_addr_pre_v3) for pre-v3
>>>> migration streams via VMSTATE_UINT32_TEST(), and introducing new
>>>> 64-bit fields for v3+.
>>>>
>>>> In post_load, pre-v3 state is promoted to the 64-bit fields.
>>>
>>> Since ehci is supported by downstream, I'd prefer that the migration
>>> maintainers also verify the implementation.
>>
>> Thanks, I'll only look at the migration bits.
>>
>> [...]
>>
>>>> @@ -2441,6 +2445,11 @@ static int usb_ehci_post_load(void *opaque, int
>> version_id)
>>>>            }
>>>>        }
>>>> +    if (version_id < 3) {
>>>> +        s->a_fetch_addr = s->a_fetch_addr_pre_v3;
>>>> +        s->p_fetch_addr = s->p_fetch_addr_pre_v3;
>>>> +    }
>>>> +
>>>>        return 0;
>>>>    }
>>>> @@ -2470,9 +2479,14 @@ static void usb_ehci_vm_state_change(void
>> *opaque, bool running, RunState state)
>>>>        }
>>>>    }
>>>> +static bool ehci_core_is_before_version_3(void *opaque, int
>>>> +version_id) {
>>>> +    return version_id < 3;
>>>> +}
>>>> +
>>>>    const VMStateDescription vmstate_ehci = {
>>>>        .name        = "ehci-core",
>>>> -    .version_id  = 2,
>>>> +    .version_id  = 3,
>>>>        .minimum_version_id  = 1,
>>>>        .pre_save    = usb_ehci_pre_save,
>>>>        .post_load   = usb_ehci_post_load,
>>>> @@ -2501,8 +2515,12 @@ const VMStateDescription vmstate_ehci = {
>>>>            /* schedule state */
>>>>            VMSTATE_UINT32(astate, EHCIState),
>>>>            VMSTATE_UINT32(pstate, EHCIState),
>>>> -        VMSTATE_UINT32(a_fetch_addr, EHCIState),
>>>> -        VMSTATE_UINT32(p_fetch_addr, EHCIState),
>>>> +        VMSTATE_UINT32_TEST(a_fetch_addr_pre_v3, EHCIState,
>>>> +                            ehci_core_is_before_version_3),
>>>> +        VMSTATE_UINT32_TEST(p_fetch_addr_pre_v3, EHCIState,
>>>> +                            ehci_core_is_before_version_3),
>>>> +        VMSTATE_UINT64_V(a_fetch_addr, EHCIState, 3),
>>>> +        VMSTATE_UINT64_V(p_fetch_addr, EHCIState, 3),
>>
>> TL;DR: I feel like we still need machine type compat properties.
>>
> 
> I don't understand this: Could you please describe it in more detail?
> 
>> Details:
>>
>> When a v2 stream arrives, two _TEST()s will do the loading, then
>> post_load() extend it to 64bits, looks fine.
>>
>> When a v3 stream arrives, two _TEST()s got skipped then latter two take effect.
>> post_load() skips.  Looks fine.
>>
>> When migrating to another QEMU, due to the fact saving vmstates always take
>> vmsd's version declared (3), I don't see how it can migrate back to a v2 stream;
>> it didn't know about v3.
>>
>> Jiamin, have you tested migrating from a new QEMU binary back to another
>> old one?  For upstream and serious devices, we need to guarantee
>> bi-directional migrations, back and forth.
>>
> 
> Sorry, I am not familiar with the design of QEMU migration, and I don't know how to test it.
> I added these hook functions based on Philippe's suggestion and review.
> Could you tell me how to test migration to ensure both version 3 and version 2 are workable?


Migrating a running guest back and forth between QEMU [1] and [2]
should be possible :

[1] path/to/qemu-10.2/install/bin/qemu-system-x86_64 -M pc-q35-10.2 \
     ... \
     -device usb-ehci \
     -device usb-kbd
      
[2] path/to/myqemu-with-patches/install/bin/qemu-system-x86_64 -M pc-q35-10.2 \
     ... \
     -device usb-ehci \
     -device usb-kbd

This is required to guarantee forward and backward compatibility of
QEMU pc-q35-10.2 machine instances.



C.

