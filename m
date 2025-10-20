Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2F4CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 15:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAs0J-0006mB-48; Mon, 20 Oct 2025 11:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vAs05-0006kb-KU; Mon, 20 Oct 2025 11:40:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vAs02-0004Qf-Uf; Mon, 20 Oct 2025 11:40:45 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9D6DE59730B;
 Mon, 20 Oct 2025 17:40:39 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id NedUc6zPide3; Mon, 20 Oct 2025 17:40:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 892EC59730E; Mon, 20 Oct 2025 17:40:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 86E5B597309;
 Mon, 20 Oct 2025 17:40:37 +0200 (CEST)
Date: Mon, 20 Oct 2025 17:40:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3 11/13] hw/boards: Extend DEFINE_MACHINE macro to cover
 more use cases
In-Reply-To: <72cef0eb-085f-4d91-a1ff-69a0fdd872c0@linaro.org>
Message-ID: <d980d334-84ad-f65b-7b40-a378eb266de2@eik.bme.hu>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <d75c8bbed97650f1a4d2d675444582a240a335b4.1760798392.git.balaton@eik.bme.hu>
 <9a1fe708-66a1-489c-ad2f-23705497c470@linaro.org>
 <00108467-9f4f-4078-a430-0f18297da94c@linaro.org>
 <72cef0eb-085f-4d91-a1ff-69a0fdd872c0@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-868875285-1760974837=:88125"
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

--3866299591-868875285-1760974837=:88125
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Oct 2025, Philippe Mathieu-Daudé wrote:
> On 20/10/25 17:11, Philippe Mathieu-Daudé wrote:
>> +Pierrick
>> 
>> On 20/10/25 17:05, Philippe Mathieu-Daudé wrote:
>>> On 18/10/25 17:11, BALATON Zoltan wrote:
>>>> Add a more general DEFINE_MACHINE_EXTENDED macro and define simpler
>>>> versions with less parameters based on that. This is inspired by how
>>>> the OBJECT_DEFINE macros do this in a similar way to allow using the
>>>> shortened definition in more complex cases too.
>>>> 
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>   include/hw/boards.h | 16 ++++++++++++++--
>>>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>>> index 665b620121..fd3d549ff5 100644
>>>> --- a/include/hw/boards.h
>>>> +++ b/include/hw/boards.h
>>>> @@ -762,7 +762,8 @@ struct MachineState {
>>>>           } \
>>>>       } while (0)
>>>> -#define DEFINE_MACHINE(namestr, machine_initfn) \
>>>> +#define DEFINE_MACHINE_EXTENDED(namestr, PARENT_NAME, InstanceName, \
>>>> +                                machine_initfn, ABSTRACT, ...) \
>>>>       static void machine_initfn##_class_init(ObjectClass *oc, const void 
>>>> *data) \
>>>>       { \
>>>>           MachineClass *mc = MACHINE_CLASS(oc); \
>>>> @@ -770,8 +771,11 @@ struct MachineState {
>>>>       } \
>>>>       static const TypeInfo machine_initfn##_typeinfo = { \
>>>>           .name       = MACHINE_TYPE_NAME(namestr), \
>>>> -        .parent     = TYPE_MACHINE, \
>>>> +        .parent     = TYPE_##PARENT_NAME, \
>>>>           .class_init = machine_initfn##_class_init, \
>>>> +        .instance_size = sizeof(InstanceName), \
>>>> +        .abstract = ABSTRACT, \
>> 
>> IIUC we don't want to have abstract type with interfaces, but
>> only QOM leaves. So maybe better always use .abstract = false in
>> DEFINE_MACHINE_EXTENDED()?
>> 
>>>> +        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
>>> 
>>> IIUC Richard asked for array argument in order to save .rodata?
>>> 
>>>>       }; \
>>>>       static void machine_initfn##_register_types(void) \
>>>>       { \
>>>> @@ -779,6 +783,14 @@ struct MachineState {
>>>>       } \
>>>>       type_init(machine_initfn##_register_types)
>>>> +#define DEFINE_MACHINE(namestr, machine_initfn) \
>>>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>>>> machine_initfn, \
>>>> +                            false, { })
>>>> +
>>>> +#define DEFINE_MACHINE_WITH_INTERFACES(namestr, machine_initfn, ...) \
>>>> +    DEFINE_MACHINE_EXTENDED(namestr, MACHINE, MachineState, 
>>>> machine_initfn, \
>>>> +                            false, __VA_ARGS__)
>
> Hmm how can be sure the __VA_ARGS__ argument is { NULL } terminated?

The same way as for OBJECT_DEFINE_TYPE_EXTENDED. This is modelled after 
that as noted in the commit message.

Regards,
BALATON Zoltan

>>>> +
>>>>   extern GlobalProperty hw_compat_10_1[];
>>>>   extern const size_t hw_compat_10_1_len;
>> 
>
>
--3866299591-868875285-1760974837=:88125--

