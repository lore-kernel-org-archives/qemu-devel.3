Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA8CC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 12:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whRmt-0004fc-VL; Wed, 08 Jul 2026 08:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whRms-0004fU-NI
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whRmq-00083a-UV
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 08:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783515240;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0uUWa4l8BF8JZjrU587zaVYjWirgAn9Ots1NEBf+tM=;
 b=E014CNoyISZKyPA0uv1uNv+OCFo/QdbqxFVoRAv+LUvD3rR03LccOdtOqPcc1mYl3fMQ6D
 sHrasZFplg/ikNsLOTQAeC+dAYVUXgfxyxT8+yveiMLxHMPj70NGUTj9m81h+lKLVG0d8E
 NteyMM0iqcgItv0qAWM7WctZJOMLEU0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-kJ3FIJSJNBWRbcAnWCu2ZA-1; Wed,
 08 Jul 2026 08:53:58 -0400
X-MC-Unique: kJ3FIJSJNBWRbcAnWCu2ZA-1
X-Mimecast-MFC-AGG-ID: kJ3FIJSJNBWRbcAnWCu2ZA_1783515237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62934195604A; Wed,  8 Jul 2026 12:53:57 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5026E18005BB; Wed,  8 Jul 2026 12:53:54 +0000 (UTC)
Date: Wed, 8 Jul 2026 13:53:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 richard.henderson@linaro.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
Message-ID: <ak5IXipr3F9we3oX@redhat.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
 <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
 <ak4lRc9u5ol0DtCM@redhat.com> <87fr1tk9pu.fsf@pond.sub.org>
 <ak40R8r6q6X0bDyF@redhat.com> <875x2pk5ld.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875x2pk5ld.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 08, 2026 at 02:50:54PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Jul 08, 2026 at 01:21:49PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Wed, Jul 08, 2026 at 11:16:30AM +0100, Peter Maydell wrote:
> >> >> On Fri, 3 Jul 2026 at 10:09, Mark Cave-Ayland
> >> >> <mark.caveayland@nutanix.com> wrote:
> >> >> >
> >> >> > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> >> >> > ---
> >> >> >  include/hw/i386/pc.h | 2 ++
> >> >> >  hw/i386/pc.c         | 8 ++++++++
> >> >> >  hw/i386/pc_sysfw.c   | 7 +------
> >> >> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >> >> >
> >> >> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> >> >> > index 309de2eda1..16cb0ec01f 100644
> >> >> > --- a/include/hw/i386/pc.h
> >> >> > +++ b/include/hw/i386/pc.h
> >> >> > @@ -40,6 +40,8 @@ typedef struct PCMachineState {
> >> >> >
> >> >> >      Object *alias_pcspk;
> >> >> >      Object *alias_rtc_time;
> >> >> > +    Object *alias_pflash0;
> >> >> > +    Object *alias_pflash1;
> >> >> >
> >> >> >      /* Configuration options: */
> >> >> >      uint64_t max_ram_below_4g;
> >> >> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> >> > index 13c9c1bfc8..11eef176f4 100644
> >> >> > --- a/hw/i386/pc.c
> >> >> > +++ b/hw/i386/pc.c
> >> >> > @@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
> >> >> >                                     offsetof(X86MachineState, acpi_dev),
> >> >> >                                     object_property_allow_set_link,
> >> >> >                                     OBJ_PROP_LINK_STRONG);
> >> >> > +    object_class_property_add_alias(oc, "pflash0",
> >> >> > +                                    offsetof(PCMachineState, alias_pflash0),
> >> >> > +                                    TYPE_PFLASH_CFI01,
> >> >> > +                                    "drive");
> >> >> > +    object_class_property_add_alias(oc, "pflash1",
> >> >> > +                                    offsetof(PCMachineState, alias_pflash1),
> >> >> > +                                    TYPE_PFLASH_CFI01,
> >> >> > +                                    "drive");
> >> >> 
> >> >> Does making these class properties fix
> >> >> https://gitlab.com/qemu-project/qemu/-/work_items/3254
> >> >> (which is a report that "qemu-system-x86_64 -machine pc-q35,help"
> >> >> doesn't list these properties) ?
> >> 
> >> Not showing object properties is a bug.
> >> 
> >> Cannot be fixed for object properties that are created outside the
> >> object's instance_init().
> >> 
> >> Now, object properties created in instance_init() should almost
> >> certainly be class properties instead.  Converting them all fixes the
> >> fixable part of the bug:
> >> 
> >> > Yes, it ought to, as that CLI logic iterates over class properties.
> >> 
> >> One property conversion at a time.
> >> 
> >> There's a quicker fix, though.
> >> 
> >> -machine TYPE.help uses type_print_class_properties() to show
> >> properties.  Here's its loop:
> >> 
> >>     object_class_property_iter_init(&iter, klass);
> >>     while ((prop = object_property_iter_next(&iter))) {
> >>         if (!prop->set) {
> >>             continue;
> >>         }
> >> 
> >>         g_ptr_array_add(array,
> >>                         object_property_help(prop->name, prop->type,
> >>                                              prop->defval, prop->description));
> >>     }
> >> 
> >> -device TYPE,help uses qmp_device_list_properties() to show both.
> >> Here's its loop:
> >> 
> >>         obj = object_new_with_class(klass);
> >> 
> >>         object_property_iter_init(&iter, obj);
> >>         while ((prop = object_property_iter_next(&iter))) {
> >>             ObjectPropertyInfo *info;
> >> 
> >>             [...]
> >> 
> >>             info = g_new0(ObjectPropertyInfo, 1);
> >>             info->name = g_strdup(prop->name);
> >>             info->type = g_strdup(prop->type);
> >>             info->description = g_strdup(prop->description);
> >>             info->default_value = qobject_ref(prop->defval);
> >> 
> >>             QAPI_LIST_PREPEND(prop_list, info);
> >>         }
> >> 
> >>         object_unref(obj);
> >> 
> >> Is there any excuse not to do it this way?
> >
> > Something would need to validate that instantiating a machine type
> > for help usage won't trip over any edge cases. Could be done with
> > unit tests.
> 
> tests/qtest/device-introspect-test.c covers this for devices.

Ah, good, I was misled by its name into thinking it was only devices,
not machine types too.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


