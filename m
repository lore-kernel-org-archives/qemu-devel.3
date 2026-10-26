Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E96F606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bKdmUDUG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOOo-0006DK-HY; Mon, 26 Oct 2026 13:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLOOb-000642-LX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xLOOZ-0006o1-7T
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793035320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0N+J0eSN0GaDgWI4xsNGHX5YrHS/1A7eBvj/4s7q3s=;
 b=bKdmUDUGql4LpJYv3b9vmU0NY0rqzb1cu9UN5pHe+NIYx+kkejGW9w30KeQHkL+Q5bDyf3
 k3DEn8+lna3pc+k2NVmyPfef0+g9U5VZt0PhrG/BELUDHQN4vSCA0rmxdcldwVqsV1jBAl
 abx4uNyQ8wh1JYQfEEndFjrSxGslhpg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-hVrqzK1-O3C0XMoutajDbw-1; Mon,
 26 Oct 2026 13:21:58 -0400
X-MC-Unique: hVrqzK1-O3C0XMoutajDbw-1
X-Mimecast-MFC-AGG-ID: hVrqzK1-O3C0XMoutajDbw_1793035317
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2787F180060C; Mon, 26 Oct 2026 17:21:57 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033381800444; Mon, 26 Oct 2026 17:21:54 +0000 (UTC)
Date: Mon, 26 Oct 2026 17:21:52 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: ObjectPropertyInfo design (was: [PATCH v7 00/65] Hi)
Message-ID: <at-MMBGue0-1q5jG@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87ik2tj0g3.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ik2tj0g3.fsf@pond.sub.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 04:04:44PM +0200, Markus Armbruster wrote:
> Marc-André's series evolves ObjectPropertyInfo and ObjectPropertyValue:
> it adds member @qapi-type and changes many values of member @type.
> 
> I'd like to take a step back and discuss design.  I trimmed Cc:
> accordingly.
> 
> 
> = The current interface
> 
> qom-list returns information on an object's properties, one
> ObjectPropertyInfo per property.
> 
> qom-list-properties returns information on properties an instance of a
> type is known to have[*], one ObjectPropertyInfo per property.

This is 

> 
> qom-list-get returns information on the properties of several objects,
> one ObjectPropertyValue per property.

Since 'qom-list-properties' is really introspecting types, rather
than instances, I'd add its companion:

  query-qmp-schema  returns information on properties from
  user creatable QOM objects, via the ObjectOptions union
  which handles data of arbitary complexity and nesting,
  with strictly QAPI types only. Obviously missing QDev
  and other internal only types.

> * @description is rarely present (I see under 15% in a quick test).  The
>   description text is commonly misleading for QMP.  For instance, qdev
>   bool properties have description "on/off".  The possible values are
>   actually JSON false and true.

With query-qmp-schema  we have a description for 100% of properties,
enforced by the QAPI schema parser. Only applies to UserCreatable QOM
objects though.

I see descriptions as primarily a documentation thing for humans, and
perhaps for machines which are trying to generate code frmo QAPI
schema and want to use descriptions for docs. These are both static
querying tasks.

I don't see descriptions as useful for mgmt apps at runtime for
deployed QEMus.

> * @default-value can be useful with qom-list-properties, which operates
>   on types.  I doubt it is with qom-list, which operates on objects.

Likewise, IMHO this is useful info statically, but not at runtime.

> Let's pretend @description doesn't exist, and @default-value exists only
> with qom-list-properties.
> 
> This makes qom-list-get strictly more powerful than qom-list, so let's
> further pretend qom-list doesn't exist.
> 
> 
> = Simplified interface for the sake of discussion
> 
> qom-list-properties returns information on properties an instance of a
> type is known to have[*]: @name, @type, and maybe @default-value.

In the ideal world 'qom-list-properties' would not need to exist,
but it has to for the forseeable future, since none of QDev is
modelled in QAPI schema currently. 

> qom-list-get returns information on the properties of several objects:
> @name, @type, and maybe @value.
> 
> 
> = The meaning of @type
> 
> Three cases:
> 
> 1. For a child property (created with object_property_add_child() etc.),
>    @type is "child<T>", where T is the child's QOM type.
> 
> 2. For a link property (created with object_class_property_add_link()
>    etc.), @type is "link<T>", where T is the target's QOM type.
> 
> 3. For other properties, @type can be anything.  We commonly use QAPI
>    type names (occasionally misspelled), and also "well-known" (but
>    undocumented) non-QAPI names for primitive types.  Every now and
>    then, developers get lazy and use values like "list", or creative and
>    use values like "guest statistics".  Nobody has gotten sufficiently
>    masochistic to use values starting with "child<" or "link<" so far,
>    although nothing would stop that.
> 
> Cases 1 and 2 go against the QAPI/QMP design maxim "don't encode stuff
> in strings".

They're not particular nice internally either as part of QDev/QOM.
ie this is gross as a design approach:

  static inline bool object_property_is_child(ObjectProperty *prop)
  {
    return strstart(prop->type, "child<", NULL);
  }

> Case 3 is is hard to use for anything.  You're forced into stupid and
> brittle hardcoding.
> 
> Marc-André's work adds a new optional member @qapi_type that refers to a
> QAPI type in the output of query-qmp-schema.  It's present for a large
> subset of case 3.  When it's present, @type should not be used.
> 
> It also cleans up many crap cases of 3, but without making it robust.  I
> understand this isn't something the series tries to do, it's just
> something that's easier to do than not to do.  If it creates
> compatibility problems, we have to not do it.  I hope it doesn't.
> 
> 
> = Can we do better?
> 
> What information are we trying to convey?  Four cases:
> 
> 1. Child property: the child's QOM type
> 
> 2. Link property: the target's QOM type
> 
> 3. QAPI-backed property: the property's QAPI type
> 
> 4. Other property: we have nothing useful to offer
> 
> Case 4 should go away eventually.
> 
> How would we encode this in QAPI on a green field?  With a union, of
> course:
> 
>     { 'enum': 'ObjectPropertyKind',
>       'data': [ 'child', 'link', 'qapi', 'other'] }
> 
>     { 'struct': 'ObjectPropertyInfoLink',
>       'data': { 'qom-type': 'str' } }
> 
>     { 'struct': 'ObjectPropertyInfoQAPI',
>       'data': { 'qapi-type': 'str' } }
> 
>     { 'union': 'ObjectProperty...',
>       'base': { 'kind': 'ObjectPropertyKind',
>                 ... more ... },
>       'discriminator': 'kind',
>       'data': {
>           'child': 'ObjectPropertyInfoLink',
>           'link': 'ObjectPropertyInfoLink',
>           'qapi': 'ObjectPropertyInfoQAPI' } }
> 
> To make this a compatible evolution of ObjectPropertyInfo, we need
> ... more ... to be
> 
>                 'type': 'str',
>                 '*description': 'str'
>                 '*default-value': 'any',
> 
> Sadly, we need to duplicate the union for ObjectPropertyValue.  There,
> ... more ... needs to be
> 
>                 'type': 'str',
>                 '*value': 'any'
> 
> We should deprecate @type.  I'd also deprecate @description.
> 
> Thoughts?

We currently have

  { 'enum': 'ObjectType', .... }

which provides a name in QMP schema for every QOM type that
implements UserCreatable.

We could relatively easily  extend that to cover *all* QOM
types in existance, with some judicous grepping of TypeInfo
classes.

It would be nice if we could enforce at runtime though that
anything passed to type_register() was listed in 'ObjectType'
enum to catch omissions. Not sure if there are any unexpected
dragons if we make type_register() check the type name
against  'ObjectType_lookup' from qapi-types-qom.h ?

Then your

>     { 'struct': 'ObjectPropertyInfoLink',
>       'data': { 'qom-type': 'str' } }

could at least reference 'ObjectType' instead of 'str' and be
aligned more with query-qmp-schema.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


