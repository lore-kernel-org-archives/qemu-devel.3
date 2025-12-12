Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04548D4336E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 05:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTvrS-0004yi-St; Fri, 12 Dec 2025 00:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTvrP-0004yS-TX
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 00:38:36 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vTvrM-0004DB-Hx
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 00:38:35 -0500
Received: from [10.200.7.128] (fs96f9c361.tkyc007.ap.nuro.jp [150.249.195.97])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BC5c9dL087779
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Dec 2025 14:38:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=TMXCoPpQ1o252foa+z8GrMyfvToXNj5wgim2bIgPEmk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:From:Subject:To;
 s=rs20250326; t=1765517894; v=1;
 b=ROUsGU1kbwAkDeMLe5aQn33Z/pMrwDv/Lg4KTZI5JK/LePXbd/PxblSdqN39svge
 b0J8cHPfrbXPMTO2kFfcHrOrZ/zt41g9t3RpAKZPbQQXyI9IgiCE4//oG6pGH3JH
 S9WUYurWU6ydufnufw572XHdUk5xK/J1MwNS3GQAfkxdxpQvaY6AlEwr5tHQsINP
 88GJTSL0XPsToQZ+SvtWRmxWlocVC3aNr2xQIzWzolVtpkwX2eby5IYHdj1XdhYb
 q6Fdi89LwlVlJdchDGEnvIdgTz/3qPACQJiNm2y23N+eNEi7PhK4MRM8JTbaYENM
 UgIH+r9I5eNjTWVLDtSqwA==
Message-ID: <f900753b-b94f-47cd-8ebb-c82e7bae7b72@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Dec 2025 14:38:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
 <a3b5e158-adae-4c66-89f9-7f0af26c63da@rsg.ci.i.u-tokyo.ac.jp>
 <aTrp9o3d8pAapahL@x1.local>
Content-Language: en-US
In-Reply-To: <aTrp9o3d8pAapahL@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/12/12 0:57, Peter Xu wrote:
> On Fri, Dec 12, 2025 at 12:28:21AM +0900, Akihiko Odaki wrote:
>> I'm actually less sure if the first half makes sense than the second half.
>>
>> Exporting Property from QDEV did make me think it may be polluting the
>> codebase with QDEV-specifics, but its motivation (creating properties
>> without defining accessors) is clear and it meets its requirement.
>>
>> The motivation is less concrete for the first half. It says the current code
>> is explicit, but it is a relative term. I'm not sure if specifying
>> TYPE_OBJECT_COMPAT is less explicit (or more implicit) than calling
>> object_apply_compat_props(). Also, having a class for compat props but not
>> for global props makes the decision look arbitrary. It is nice to have some
>> clarification on these.
> 
> Thanks for the comments, Akihiko.  I can explain.
> 
> I explicitly only included object_apply_compat_props() in the current
> OBJECT_COMPAT class (rather than set_globals()) is almost two-fold:
> 
>    - Inclusion of qdev_prop_set_globals() makes the 1st half start to depend
>      on the 2nd half, that I don't see it strictly necessary.  E.g., one
>      immediate motivation of me looking at this problem is Vladimir's series
>      on virtio-net/tap [1].
> 
>      That series should only need patch 1-6 of this series as minimum to
>      enable machine compat properties for TAP (after QOMify, if that makes
>      sense on its own).

It is possible to have another type that inherits TYPE_OBJECT_COMPAT and 
does the second half.

> 
>    - qdev_prop_set_globals() itself has a trivial dependency currently
>      against qdev hotpluggable or not:
> 
>      object_apply_global_props(OBJECT(dev), global_props(),
>                                dev->hotplugged ? NULL : &error_fatal);
> 
>      There's way to decouple that I guess, however I just don't see it
>      necessary yet.  The only real user will be migration object, which
>      doesn't need to depend on this anyway, as long as Property APIs can be
>      exported.

Theoretically, there may also be a call of object_apply_compat_props() 
that has some dependency on its state in the future, but such a future 
concern should be treated later; I'll focus on existing callers of 
object_apply_compat_props() and global_props() in the following 
discussion too.

> 
> Do you think we should keep open-code object_apply_compat_props() instead?

Yes, that's my conclusion so far, but please see below for the explanation:

> 
> In reality, that also works for me at least on figuring out the current
> problem [1], and if Property API exported I can also open code it for
> migration object.  It's just that IMHO it's cleaner we have the light class
> to do this (so as to avoid providng post_init() hooks all over the places).

Avoiding providing post_init() hooks is a nice concrete explanation of 
the goal.

That said, the migration object provides post_init() hooks anyway, so 
the question will be if avoiding post_init() hooks will simplify the 
existing callers of object_apply_compat_props().

Looking into the codebase, there are four users of 
object_apply_compat_props(); hostmem, qdev, accel, and sev. Only hostmem 
and qdev call object_apply_compat_props() in their post_init() hooks, 
and qdev needs the hook anyway for the same reason the migration object 
does.

So there is only one post_init() hook added for 
object_apply_compat_props(): host_memory_backend_post_init(). And even 
this can be simplified; since object_apply_compat_props() and the hook 
has the same signature, hostmem can simply do:

.instance_post_init = object_apply_compat_props,

... and drop host_memory_backend_post_init().

This is much simpler than adding the object-compat type, so probably 
it's too early to add the type.

Regards,
Akihiko Odaki

> 
> [1] https://lore.kernel.org/all/20251030203116.870742-1-vsementsov@yandex-team.ru/
> 


