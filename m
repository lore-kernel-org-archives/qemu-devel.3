Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C8606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT5lE-00053z-OP; Mon, 16 Nov 2026 18:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xT5lC-00053i-UA
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:05:14 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xT5lA-00049Y-LO
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:05:14 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8D85D60C347;
 Tue, 17 Nov 2026 00:05:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id DS3BZg_V3tbj; Tue, 17 Nov 2026 00:05:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 19BE860C072; Tue, 17 Nov 2026 00:05:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 181B713B61E;
 Tue, 17 Nov 2026 00:05:05 +0100 (CET)
Date: Tue, 17 Nov 2026 00:05:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
In-Reply-To: <5c7129b8-ff72-408f-a6db-9a629ba66f5d@oss.qualcomm.com>
Message-ID: <95f9ab7e-f50a-07c8-6804-7c74f7a22ce3@eik.bme.hu>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
 <CAE2XoE8+=z+LcdqFWoLc=Ho8d7QGBgkJL8jL4cgup-o_X2fTrw@mail.gmail.com>
 <1447ca17-52a6-c069-d3b0-f778c60dca20@eik.bme.hu>
 <avt7apWvO-6QwI_u@redhat.com>
 <5c7129b8-ff72-408f-a6db-9a629ba66f5d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1150318056-1794870305=:91907"
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1150318056-1794870305=:91907
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 16 Nov 2026, Pierrick Bouvier wrote:
> On 11/16/2026 1:53 PM, Daniel P. Berrangé wrote:
>> On Sun, Nov 15, 2026 at 04:31:01PM +0100, BALATON Zoltan wrote:
>>> On Sun, 15 Nov 2026, Yonggang Luo wrote:
>>>> On Thu, Nov 12, 2026 at 9:31 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>
>>>>> All QOM types must have a globally unique typename, however, for
>>>>> user convenience, some might also want to have aliases which are
>>>>> permitted to be ambiguous. Define an "Aliased" interface which
>>>>> can be implemented by types which want to support aliases.
>>>>>
>>>>> When resolving an alias, if there are multiple QOM types with a
>>>>> matching alias this is considered an error. Ambiguity can be
>>>>> resolved by matching system state, with the selected target
>>>>> being the currently implemented filter.
>>>>>
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> ---
>>>>>  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
>>>>>  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
>>>>>  2 files changed, 134 insertions(+)
>>>>>
>>>>> diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
>>>>> index d222a3d7481..010e37d63f7 100644
>>>>> --- a/include/qom/object_interfaces.h
>>>>> +++ b/include/qom/object_interfaces.h
>>>>> @@ -27,6 +27,17 @@ DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>>>>>
>>>>>  typedef struct TargetSpecific TargetSpecific;
>>>>>
>>>>> +#define TYPE_ALIASED "aliased"
>>>>> +
>>>>> +typedef struct AliasedClass AliasedClass;
>>>>> +DECLARE_CLASS_CHECKERS(AliasedClass, ALIASED,
>>>>> +                       TYPE_ALIASED)
>>>>> +#define ALIASED(obj) \
>>>>> +     INTERFACE_CHECK(Aliased, (obj), \
>>>>> +                     TYPE_ALIASED)
>>>>> +
>>>>> +typedef struct Aliased Aliased;
>>>
>>> I wonder if it would be simpler to add the possibility to define aliases to
>>> all QOM objects as standard instead of by an interface? This is useful for
>>> other cases, it came up here too for example:
>>> https://lists.nongnu.org/archive/html/qemu-ppc/2025-02/msg00113.html
>>> Or maybe this could be done with this interface by common super classes
>>> implementing it such as device and machine allowing aliases that commonly
>>> need it to use it but then it would be quite widespread use to consider just
>>> adding it to object right away which may also help interaction with arch.
>>> Why separating it into an interface is better when we need it for most
>>> objects?
>>
>> We really don't need it for most objects. It is somewhat common for
>> machine classes, just because we have many called 'virt', but even
>> they are a minority of all machines. The number of places we might
>> need it outside of machines will likely not exceed single digits.
>>
>> The core QOM framework tries to be a fairly "pure" object model
>> without QEMU specific aspects to its design. It is somewhat
>> inspired by GObject, and I still rather regret that QEMU is not
>> using GObject as it would have done everything we need and made
>> life easier.
>>
>
> I guess QOM predated it?

I think it does not but GObject was fairly new at the time and maybe QEMU 
wanted to stay independent and not affected by changes in other project. 
But this was before I started following QEMU so I'm not sure about it.

> I always thought QOM was made by secret C++ lovers who couldn't use the
> language in QEMU.
>
>> Stuff that starts to get QEMU specific is pushed into interfaces
>> like UserCreatable, or abstract base classes like "Device". IMHO
>> it is beneficial to retain this conceptual division, as it lets
>> us understand the behaviour of QOM as a framework in isolation
>> from the bulk of QEMU.
>>
>
> That seems like a good rationale about what to implement where. It's
> more debatable about having an interface or a machine field though.
> I personally like the interface concept for this, even though it comes
> with extra verbosity.

We may need it later in devices if we resurrect the linked idea (which I'd 
like to try eventually) so it should either be in QOM Object or an 
interface that Device or its sub classes can implement and not only 
machines. I only thought that it may be less boiler plate and maybe 
simpler implementation if it's not an interface but just adding another 
hash table similar to the one storing type names or even allowing multiple 
names for same objects within QOM and then it would be easier to search 
for objects by alias that way, but if it works with an interface I don't 
mind much.

Regards,
BALATON Zoltan
--3866299591-1150318056-1794870305=:91907--

