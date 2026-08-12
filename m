Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64796C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6Zt-0007Oz-So; Wed, 12 Aug 2026 06:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu6Zn-0007Og-7o
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wu6Zl-0005r4-9u
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786531967;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zyKPkpdeIPcobHyMsTz5+CRw/GzZPCTkCqp0+ppaYqM=;
 b=TX5rQKq+reTxvAzL+WABugHY6oGzix/QbZzFWrTRG6uK/gkf8YzpOlqcRhDQqhzUrq5+ce
 M5zvDKthq0X3OPimCWcEA8/AacyS32aJ0Avk9AYJvtwp47Ay9gw4ZkCkw+P0NK34JpoY8B
 Buxizv9BfvHwYpvpj0DQm7W5gkAw1Hs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-tVz5DABdN0mggzJSqJylCg-1; Wed,
 12 Aug 2026 06:52:45 -0400
X-MC-Unique: tVz5DABdN0mggzJSqJylCg-1
X-Mimecast-MFC-AGG-ID: tVz5DABdN0mggzJSqJylCg_1786531964
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4E471956089; Wed, 12 Aug 2026 10:52:43 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 604CE3002D28; Wed, 12 Aug 2026 10:52:41 +0000 (UTC)
Date: Wed, 12 Aug 2026 11:52:38 +0100
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
Message-ID: <anxQdlwxAtqfl-N-@redhat.com>
References: <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
 <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
 <anNqhjSU5tEDC0br@redhat.com>
 <a9c89dd7-6317-42f1-9e03-30e48c2d08aa@oss.qualcomm.com>
 <anRgKw58IMYoR4p-@redhat.com>
 <5bda3566-5ce5-46dc-a281-2cc07a56dc6f@oss.qualcomm.com>
 <077fc585-a6b8-455a-abdc-fd72e13b8315@oss.qualcomm.com>
 <anTPOqFKWFKAX_3C@redhat.com>
 <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <102a3de8-ac17-429a-9294-e3b159aa642a@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 10, 2026 at 03:26:26PM -0700, Pierrick Bouvier wrote:
> I have been experimenting today with static filtering of types, as you
> suggested, and came up with two possibilities. Before implementing this
> for all types, I would like to get some feedback on which way is the
> best for you.
> 
> 1. Add a new callback is_available to TypeInfo, similar to existing
> interface.
> Pros: local information is present in type definition, making obvious
>       why a type is available or not. Very easy to implement
>       since only type_register_static has to be modified to check it.
> Cons: Add a new field to each existing type. Not the end of the world
>       in terms of memory consumption, but worth mentioning.
> 2. Add conditional around each type_register_static, or add an
> alternative type_register_static_cond function.
> Pros: I don't see any
> Cons: Decouples type information from type definition, makes it harder
>       to follow why a type is available or not. Much more verbose since
>       we need to modify all type_register_static buried in macros.
> 
> Based on this, I'm much more in favor or 1. The fact availability
> information is in the same location than type definition is the biggest
> advantage for me.
> 
> On example given above, this would give something like this:
> static const TypeInfo emulated_card_info = {
>      .name          = TYPE_EMULATED_CCID,
>      .parent        = TYPE_CCID_CARD,
>      .instance_size = sizeof(EmulatedState),
>      .class_init    = emulated_class_initfn,
>      .is_available  = target_config_X,
> };
> 
> Would that work for you?
> Do you have a 3rd way to offer to solve the problem we have?

In the case of user creatable objects, we represented a classes'
conditional availablity in QAPI schema. For example:

  { 'struct': 'InputLinuxProperties',
    'data': { 'evdev': 'str',
              '*grab_all': 'bool',
              '*repeat': 'bool',
              '*grab-toggle': 'GrabToggleKeys' },
    'if': 'CONFIG_LINUX' }

Now this isn't quite a match for what we want, as QAPI schema is
common to all targets and used to control the code generator to
turn off output. Thus the permitted CONFIG_xxx are only those in
config-host.mak, not any from $TARGET-softmmu-config-devices.mak

The other scenario in QAPI is the concept of features:

{ 'struct': 'SevCommonProperties',
  'data': { '*sev-device': 'str',
            '*cbitpos': 'uint32',
            'reduced-phys-bits': 'uint32',
            '*kernel-hashes': 'bool' },
  'features': ['confidential-guest-reset']}

where again we just have a list of named strings. Features are fully
dynamic, and crucially they are introspectable so applications can
query at runtime what is available.

The introspection concept is something that is highly likely to be
relevant to our use cases here. If we have a single binary with all
types, it would be very valuable to be able to query it once to
discover everything in one go, instead of havnig to query it over
and over again for each target. That implies the application doing
the query needs to be told about per-target usage restrictions on
types it is querying.

We don't have QAPI schema for QDev devices currently, but it is likely
we will do so in the future. We can't wait for that though as there is
no clear ETA.

What this all says to me though, is that instead of an 'is_available'
method, we should instead just list the conditions as data in the
TypeInfo struct directly. IOW a list of const strings like this:

 static const TypeInfo emulated_card_info = {
      .name          = TYPE_EMULATED_CCID,
      .parent        = TYPE_CCID_CARD,
      .instance_size = sizeof(EmulatedState),
      .class_init    = emulated_class_initfn,
      .available     = (const char *[]){ TARGET_AARCH64, CONFIG_something .... },
 };

This will make it easy to add in introspection at a later date.

The limitation is that this can only express an "AND" condition.
You can not do complex AND+OR+grouping conditions that you could
express in code, but IMHO that is not likely to be a problem.
In the worst case you can define a higher level "CONFIG_BLAH"
that encapsulates the complex condition.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


