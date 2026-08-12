Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE0C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9va-0004rN-Bl; Wed, 12 Aug 2026 10:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu9vH-0004lo-Jq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu9vF-000873-6u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786544831;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bjt17HnbRgZU/Z7fmtdPOAfM3XUeJTR3im/Eaik9j/4=;
 b=LSFGWref6elekvT0uD03dixF1vYzrroPtWtQVzCVOJKP15pTAKGhJdk15BRwdfwvIofshK
 hH4HTx1HzsHz/ah5twSqTY6Lu3iqjmc0vII56U+qpH43y4Wqjs47dlUOLyF/HdbS0Lce39
 jooicg71GEpJeZNhll0Y4c2aaooCFjM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-f5NmcUn1OJS-9mPjwrh7fw-1; Wed,
 12 Aug 2026 10:27:07 -0400
X-MC-Unique: f5NmcUn1OJS-9mPjwrh7fw-1
X-Mimecast-MFC-AGG-ID: f5NmcUn1OJS-9mPjwrh7fw_1786544825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADA29195608F; Wed, 12 Aug 2026 14:27:04 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A62A1956044; Wed, 12 Aug 2026 14:27:01 +0000 (UTC)
Date: Wed, 12 Aug 2026 15:26:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
Message-ID: <anyCswBYBZWeMt3I@redhat.com>
References: <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
 <anxQdlwxAtqfl-N-@redhat.com>
 <cc88ff07-474f-48d6-a2a4-1a2c3f64f3fd@oss.qualcomm.com>
 <anxvMQpZlBUu5SaB@redhat.com>
 <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9db3cc07-61e6-4740-823d-112ec80f216b@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Aug 12, 2026 at 07:09:29AM -0700, Pierrick Bouvier wrote:
> On 8/12/2026 6:03 AM, Daniel P. Berrangé wrote:
> > On Wed, Aug 12, 2026 at 05:54:49AM -0700, Pierrick Bouvier wrote:
> >> On 8/12/2026 3:52 AM, Daniel P. Berrangé wrote:
> >>> On Mon, Aug 10, 2026 at 03:26:26PM -0700, Pierrick Bouvier wrote:
> >>>> I have been experimenting today with static filtering of types, as you
> >>>> suggested, and came up with two possibilities. Before implementing this
> >>>> for all types, I would like to get some feedback on which way is the
> >>>> best for you.
> >>>>
> >>>> 1. Add a new callback is_available to TypeInfo, similar to existing
> >>>> interface.
> >>>> Pros: local information is present in type definition, making obvious
> >>>>       why a type is available or not. Very easy to implement
> >>>>       since only type_register_static has to be modified to check it.
> >>>> Cons: Add a new field to each existing type. Not the end of the world
> >>>>       in terms of memory consumption, but worth mentioning.
> >>>> 2. Add conditional around each type_register_static, or add an
> >>>> alternative type_register_static_cond function.
> >>>> Pros: I don't see any
> >>>> Cons: Decouples type information from type definition, makes it harder
> >>>>       to follow why a type is available or not. Much more verbose since
> >>>>       we need to modify all type_register_static buried in macros.
> >>>>
> >>>> Based on this, I'm much more in favor or 1. The fact availability
> >>>> information is in the same location than type definition is the biggest
> >>>> advantage for me.
> >>>>
> >>>> On example given above, this would give something like this:
> >>>> static const TypeInfo emulated_card_info = {
> >>>>      .name          = TYPE_EMULATED_CCID,
> >>>>      .parent        = TYPE_CCID_CARD,
> >>>>      .instance_size = sizeof(EmulatedState),
> >>>>      .class_init    = emulated_class_initfn,
> >>>>      .is_available  = target_config_X,
> >>>> };
> >>>>
> >>>> Would that work for you?
> >>>> Do you have a 3rd way to offer to solve the problem we have?
> >>>
> >>> In the case of user creatable objects, we represented a classes'
> >>> conditional availablity in QAPI schema. For example:
> >>>
> >>>   { 'struct': 'InputLinuxProperties',
> >>>     'data': { 'evdev': 'str',
> >>>               '*grab_all': 'bool',
> >>>               '*repeat': 'bool',
> >>>               '*grab-toggle': 'GrabToggleKeys' },
> >>>     'if': 'CONFIG_LINUX' }
> >>>
> >>> Now this isn't quite a match for what we want, as QAPI schema is
> >>> common to all targets and used to control the code generator to
> >>> turn off output. Thus the permitted CONFIG_xxx are only those in
> >>> config-host.mak, not any from $TARGET-softmmu-config-devices.mak
> >>>
> >>> The other scenario in QAPI is the concept of features:
> >>>
> >>> { 'struct': 'SevCommonProperties',
> >>>   'data': { '*sev-device': 'str',
> >>>             '*cbitpos': 'uint32',
> >>>             'reduced-phys-bits': 'uint32',
> >>>             '*kernel-hashes': 'bool' },
> >>>   'features': ['confidential-guest-reset']}
> >>>
> >>> where again we just have a list of named strings. Features are fully
> >>> dynamic, and crucially they are introspectable so applications can
> >>> query at runtime what is available.
> >>>
> >>> The introspection concept is something that is highly likely to be
> >>> relevant to our use cases here. If we have a single binary with all
> >>> types, it would be very valuable to be able to query it once to
> >>> discover everything in one go, instead of havnig to query it over
> >>> and over again for each target. That implies the application doing
> >>> the query needs to be told about per-target usage restrictions on
> >>> types it is querying.
> >>>
> >>> We don't have QAPI schema for QDev devices currently, but it is likely
> >>> we will do so in the future. We can't wait for that though as there is
> >>> no clear ETA.
> >>>
> >>> What this all says to me though, is that instead of an 'is_available'
> >>> method, we should instead just list the conditions as data in the
> >>> TypeInfo struct directly. IOW a list of const strings like this:
> >>>
> >>>  static const TypeInfo emulated_card_info = {
> >>>       .name          = TYPE_EMULATED_CCID,
> >>>       .parent        = TYPE_CCID_CARD,
> >>>       .instance_size = sizeof(EmulatedState),
> >>>       .class_init    = emulated_class_initfn,
> >>>       .available     = (const char *[]){ TARGET_AARCH64, CONFIG_something .... },
> >>>  };
> >>>
> >>> This will make it easy to add in introspection at a later date.
> >>>
> >>> The limitation is that this can only express an "AND" condition.
> >>> You can not do complex AND+OR+grouping conditions that you could
> >>> express in code, but IMHO that is not likely to be a problem.
> >>> In the worst case you can define a higher level "CONFIG_BLAH"
> >>> that encapsulates the complex condition.
> >>>
> >>
> >> Those strings names reuse existing target config identifiers, which
> >> can't be done because of config poisoning.
> >> The string compare will definitively be visible at boot time, so we
> >> should rely on enum instead if we go in this direction.
> >>
> >> I'm a bit worried about verbosity of the result:
> >> .available     = (const char *[]){ ENUM_NAME_TARGET_AARCH64, {} }
> >> versus:
> >> is_available = target_aarch64
> > 
> > The verbosity could be hidden behind a macro that takes a tar
> > 
> > #define QOM_AVAIL_TGT(name) \
> >    .available = (const char *[]) ENUM_TARGET # name, NULL }
> > 
> > So usage becomes
> > 
> >   static const TypeInfo emulated_card_info = {
> >      .name          = TYPE_EMULATED_CCID,
> >      .parent        = TYPE_CCID_CARD,
> >      .instance_size = sizeof(EmulatedState),
> >      .class_init    = emulated_class_initfn,
> >      QOM_AVAIL_TGT(AARCH64),
> >   }
> > 
> > A separate macro could be defined for the more complex case
> > wanting multiple config options.
> >
> 
> Then we'll have different macros for:
> one target, a collection of target, a mix of target and config, config
> only. Plus, we hide what was clear in the first place with:
> .is_available = target_aarch64.
> I'm not super fond of the result to be honest.

That's a different interpration of "clear".

What I'm proposing exposes the rules as data, and that ensures
the rules are clear to machines.

What you're proposing exposes the rules as code and that is only
clear to human reviewers.

>  >> 99% of the types will be filtered by target only, for which we have
> >> functions in target-info API. Only a few of them will need custom
> >> functions. It would be worth having a nice/short way to write this
> >> without having to declare all combination in a file.
> >> One of your point was to not include more macros, and seems like we'll
> >> end up this way.
> > 
> > In this case the macros expand to data that is machine consumable
> > at runtime, so I thjnk that's a good tradeoff.
> > 
> >> The introspection argument is good, but will we really need that? The
> >> whole point of conversation was to register only types available,
> >> ignoring the rest. If you want introspection, it means registering all
> >> types and selectively filter them.
> > 
> > Yes, introspection is critical to mgmt apps and places where we
> > forget/miss it cause endless pain.
> >
> 
> We can easily make a mechanical replace on all '^\s*\.is_available'
> lines when it will be needed. Feels like we are anticipating a bit too
> much, and there would be no cost to change that later.
> 
> I would kindly ask again to consider if you would be ok to delay this to
> when it's effectively introduced on QAPI side.
> 
> Would you be open to it?

Introspection has always been a critical problem in QEMU and rectifying
it after the fact is very costly. IMHO we need to do this as data from
day one rather than knowingly taking a path that makes introspection
harder.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


