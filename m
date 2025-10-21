Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451A8CCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBwU-00069c-Mf; Tue, 21 Oct 2025 08:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBBwQ-00069J-ND
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:58:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBBwN-0000An-IY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:58:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EDABA5972E3;
 Tue, 21 Oct 2025 14:58:12 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id J2gg7NigFLSw; Tue, 21 Oct 2025 14:58:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E20745972E1; Tue, 21 Oct 2025 14:58:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DFDBF5972DE;
 Tue, 21 Oct 2025 14:58:10 +0200 (CEST)
Date: Tue, 21 Oct 2025 14:58:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 34/43] audio: rename AudioState -> AudioBE
In-Reply-To: <CAJ+F1CKoi5iYZHTxMWKUtx=kRbW2BjtoAzMVGLe8by0Dnmb+KQ@mail.gmail.com>
Message-ID: <4e621485-01c0-653f-b521-9fcc4272fa92@eik.bme.hu>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-35-marcandre.lureau@redhat.com>
 <1bd34160-d034-465b-a1ac-0e734ed40484@redhat.com>
 <d26b8838-c4a9-443f-a651-f46901a40865@redhat.com>
 <CAJ+F1CLoaufD_1tFUd_1uckWZLXVQ7E-GpRDZRDXtfi6unBw7A@mail.gmail.com>
 <32170b83-473c-4eb8-96dc-9180c51fe872@redhat.com>
 <CAJ+F1CKoi5iYZHTxMWKUtx=kRbW2BjtoAzMVGLe8by0Dnmb+KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2015573042-1761051490=:49605"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--3866299591-2015573042-1761051490=:49605
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 21 Oct 2025, Marc-André Lureau wrote:
> On Tue, Oct 21, 2025 at 2:49 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 10/21/25 12:40, Marc-André Lureau wrote:
>>>>> BE and FE aren't used in existing code though.  Looking at current use:
>>>
>>> There is a top-level backends/ though. I meant to say that it's
>>> usually clearer for everyone when we talk about "backend" vs
>>> "frontend" (or not?), and I wish we would follow that naming more in
>>> the code.
>>
>> Yes, but the front-end should have a *pointer* to a backend.
>>
>>>>> - BlockDriverState*/BlockBackend*
>>>
>>> I am not very familiar with the block subsystem, but it is seems
>>> BlockBackend is actually the backend and BlockDriverState is
>>> implementation data detail. Correct me if I'm wrong
>>
>> Yes, note the "*".  What I meant above is "the frontend has a
>> BlockBackend*, which itself has the internal BlockDriverState*".  Same
>> for character and NICs below.
>>
>>>>> - Chardev*/CharBackend
>>>>>
>>>
>>> Those are actually always confusing... and I remember I attempted to
>>> rename it in the past... CharBackend is the front-end side..
>>
>> Yes, they are confusing.  I'm not sure why it failed, but
>> s/CharBackend/CharFrontend/ does get my vote.
>>
>>>> QEMUSoundCard's name field is basically unused, and QEMUSoundCard should
>>>> be just an Audiodev*.  There's no need for a separate AudioFE struct.
>>>
>>> For audio, it's pretty obvious that we have "backend" object to
>>> implement the host audio subsystem details, while "QEMUSoundCard" is
>>> the "frontend", or "client/user" context.
>>
>> I agree, but unlike character devices, QEMUSoundCard is not needed at
>> all.  So you can drop it and only leave Audiodev*, or AudioBackend* (but
>> I prefer Audiodev* which matches both the option name and Chardev*).
>>
>
> I see, I'll try to remove QEMUSoundCard.
>
> AudioState can't easily be renamed to "Audiodev" though, since that's
> the QAPI type name. There are slight typename differences between QAPI
> types for chardev and audiodev. Is it breaking QMP APIs to change
> typenames? I guess not, I might be wrong. However, this will likely
> break external code generators based on QAPI (qapi-rs etc)..

I'm getting lost where this is going but keeping AudioState for the QOM 
type seems better than using another name just to try to be consistent 
with char backends that was said to have a confusing naming above. So 
maybe keep the QOM convention for audio and call it AudioState and later 
try to match Char to this if that needs similar QOM'ification? If this is 
replacing QEMUSoundCard then maybe AudioCard can also be considered for 
keeping consistency with local names. But I don't know what I'm talking 
about so I stop here and let you agree on something.

Regards,
BALATON Zoltan
--3866299591-2015573042-1761051490=:49605--

