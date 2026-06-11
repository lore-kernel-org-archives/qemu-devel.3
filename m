Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF56CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 13:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXfVb-0007qs-VB; Thu, 11 Jun 2026 09:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXfVL-0007oh-TT
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:31:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXfVG-0001Wd-2u
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 09:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781184682;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0s0mOvx8AESiHumw1FEpaRC6j+sy5K9uOYvzE3khxcE=;
 b=cSZ//oaPhvAx3ZYa9uot8heDhTdgYWn7Jko7zVQx6sAQFmD0KWKpXVqP2i6GAOfryk7znw
 +d0HqHE/kZE5o6GZFpkHova0zzw+4s8A0oh9qYe8rgQEmHyGr8hcAiwpj9stWSJAg5Cn/j
 oBbcjYUJ0umuRDJI5izPZKtDD3fSHEA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-MzoC7E44PU6hEYF77W1vUg-1; Thu,
 11 Jun 2026 09:31:19 -0400
X-MC-Unique: MzoC7E44PU6hEYF77W1vUg-1
X-Mimecast-MFC-AGG-ID: MzoC7E44PU6hEYF77W1vUg_1781184677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D227195D023; Thu, 11 Jun 2026 13:31:16 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.8])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6D5C1800667; Thu, 11 Jun 2026 13:31:09 +0000 (UTC)
Date: Thu, 11 Jun 2026 14:31:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH v2 00/10] migration/qom: Remove TYPE_DEVICE dependency on
 migration object
Message-ID: <aiq4mkFnRwek-_j4@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <87jys75npb.fsf@suse.de> <aimtYbka4GB9Qyk6@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aimtYbka4GB9Qyk6@x1.local>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 10, 2026 at 02:30:57PM -0400, Peter Xu wrote:
> On Tue, Jun 09, 2026 at 07:54:56PM -0300, Fabiano Rosas wrote:
> > Hi,
> > 
> > After we discussed your v1 I started playing with this in parallel and
> > stumbled into pretty much all of the issues this series resolves. Nice
> > work!
> 
> Good to know at least it looks reasonable for someone.. thanks. :)
> 
> Looks like Dan still has concern that I use the ptrs in obj props but I'll
> discuss it later separately.
> 
> > 
> > I applied a patch [0] on top of this series to allow using the
> > command-line to create the migration object. It can set all (most)
> > options with -object migration,id=mig1,key=val,...
> > 
> >  $ ~/qemu-system-x86_64 -nodefaults -nographic -S \
> >  -object migration,id=mig1,announce-initial=99,downtime-limit=99,multifd-channels=99,multifd-compression=zlib,multifd=on
> >  ...
> >  (qemu) info migrate_parameters
> >  (qemu) info migrate_capabilities
> >  ...
> >  announce-initial: 99 ms
> >  downtime-limit: 99 ms
> >  multifd-channels: 99
> >  multifd-compression: zlib
> >  multifd: on
> > 
> > I'm not saying we should do that now. I just want to check with you to
> > make sure we're not closing the door for future improvements:
> 
> IIUC it works, maybe indeed it's a better way than "-incoming config:" at
> least in that we stick with the current APIs.
> 
> Said that, it does bypass the singleton work I did previously:
> 
> https://lore.kernel.org/r/20241029211607.2114845-1-peterx@redhat.com

You can force  a QOM object into being a singleton if you like.

In the UserCreatable interface "complete" callback, for the first
instance that's completed, stash its pointer in a global var,
and then when subsequent instances are created have "complete"
always report an error.


> > 1) It seems the "help" option is tied to the class. Setting options
> > work, but the help says otherwise:
> > 
> >  $ ~/qemu-system-x86_64 -nographic -object migration,id=mig1,help                                                                            
> >  There are no options for migration.
> 
> This one is easy, something like this should work:

This is an example of why this needs to be using class properties,
not instance properties.

>  bool type_print_class_properties(const char *type)
>  {
> +    g_autoptr(Object) obj = NULL;                                                                                                       
>      ObjectClass *klass;
>      ObjectPropertyIterator iter;
>      ObjectProperty *prop;
> @@ -134,7 +135,12 @@ bool type_print_class_properties(const char *type)
>      }
>  
>      array = g_ptr_array_new();
> -    object_class_property_iter_init(&iter, klass);                                                                                      
> +    if (object_class_is_abstract(klass)) {                                                                                              
> +        object_class_property_iter_init(&iter, klass);                                                                                  
> +    } else {                                                                                                                            
> +        obj = object_new_with_class(klass);                                                                                             
> +        object_property_iter_init(&iter, obj);                                                                                          
> +    }                                                                                                                                   
>      while ((prop = object_property_iter_next(&iter))) {
>          if (!prop->set) {
>              continue;

No, we don't want to do that - everything intended to be used
with -object needs to be using class properties.



> > diff --git a/migration/migration.c b/migration/migration.c
> > index ae0c373549..22c8ced766 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -297,7 +297,16 @@ void migration_object_init(void)
> >  {
> >      /* This can only be called once. */
> >      assert(!current_migration);
> > -    current_migration = MIGRATION(object_new(TYPE_MIGRATION));
> > +
> > +    Object *root = object_get_objects_root();
> > +    ObjectProperty *prop = g_hash_table_lookup(root->properties, "mig1");
> > +
> > +    if (prop->opaque) {
> > +        current_migration = prop->opaque;
> > +        object_ref(current_migration);
> > +    } else {
> > +        current_migration = MIGRATION(object_new(TYPE_MIGRATION));
> > +    }
> 
> A quick comment for this one; maybe better with:
> 
>      Object *mig_obj = object_resolve_path_component(object_get_objects_root(),                                                          
>                                                      "mig1");                                                                            
> 
> Or even better:
> 
> static int find_migration_object(Object *obj, void *opaque)
> {
>     if (object_dynamic_cast(obj, TYPE_MIGRATION)) {
>         *(Object **)opaque = obj;
>         return 1;
>     }
>     return 0;
> }
> 
> Then:
> 
>      object_child_foreach(object_get_objects_root(),
>                           find_migration_object, &existing);

If you want a singleton pattern, then it is simpler to just stash
the "Migration" object pointer in the "complete" method, and not
assume anything about the ID name the mgmt app chose to use.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


