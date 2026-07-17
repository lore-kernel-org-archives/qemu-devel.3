Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7D1C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkiLe-0002aK-GP; Fri, 17 Jul 2026 09:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkiLa-0002a3-1w
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkiLX-0005Gl-D1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 09:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784293876;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EgS5PZqk0ZbjaZorfCi5SB9bMpxiQdU+GQBiWsEBtjQ=;
 b=NWfdQ1pF+l6UFxiUOLEQ+b1w974ZSUpWDSAWTaSq6NToRqSMw5ECiMUMP0bhFfTj87890I
 iEUN3PJeew22oxKwTh/GelNkRwjv+S1EbdYaqUNtRe5lKp7YUoaFFzDf7AmPTXm14ge+sC
 XcRR4kIXvNBrf2HReChJNFe1QWoFpyQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-8CiBWeTwNTS02VNH_HFrRw-1; Fri,
 17 Jul 2026 09:11:12 -0400
X-MC-Unique: 8CiBWeTwNTS02VNH_HFrRw-1
X-Mimecast-MFC-AGG-ID: 8CiBWeTwNTS02VNH_HFrRw_1784293871
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59A6119540D3; Fri, 17 Jul 2026 13:11:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B5D63004180; Fri, 17 Jul 2026 13:11:05 +0000 (UTC)
Date: Fri, 17 Jul 2026 14:11:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 4/5] qom/object.h: add missing documentation for
 object_class_* property functions
Message-ID: <alop5gYJ1IX1uyMP@redhat.com>
References: <20260717112022.444367-1-mark.caveayland@nutanix.com>
 <20260717112022.444367-5-mark.caveayland@nutanix.com>
 <aloffnKdpvj_2XzU@redhat.com>
 <0f723410-d701-456f-b7e5-c51eec3a7573@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f723410-d701-456f-b7e5-c51eec3a7573@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jul 17, 2026 at 01:56:05PM +0100, Mark Cave-Ayland wrote:
> On 17/07/2026 13:26, Daniel P. Berrangé wrote:
> 
> > On Fri, Jul 17, 2026 at 12:19:11PM +0100, Mark Cave-Ayland wrote:
> > > This is so that the object_class_* property functions appear in the generated
> > > QOM documentation at devel/qom-api.html.
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > > ---
> > >   include/qom/object.h | 140 +++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 140 insertions(+)
> > > 
> > > diff --git a/include/qom/object.h b/include/qom/object.h
> > > index 11f55613fc..95fdf01e30 100644
> > > --- a/include/qom/object.h
> > > +++ b/include/qom/object.h
> > > @@ -1818,6 +1818,37 @@ ObjectProperty *object_property_add_link(Object *obj, const char *name,
> > >                                               Object *val, Error **errp),
> > >                                 ObjectPropertyLinkFlags flags);
> > > +/**
> > > + * object_class_property_add_link:
> > > + * @oc: the object class to add a property to
> > > + * @name: the name of the property
> > > + * @type: the qobj type of the link
> > > + * @offset: the offset from the object instance where the link object reference
> > > + *   is stored
> > > + * @check: callback to veto setting or NULL if the property is read-only
> > > + * @flags: additional options for the link
> > > + *
> > > + * Links establish relationships between objects.  Links are unidirectional
> > > + * although two links can be combined to form a bidirectional relationship
> > > + * between objects.
> > > + *
> > > + * Links form the graph in the object model.
> > > + *
> > > + * The @check() callback is invoked when object_property_set_link() is called
> > > + * and can raise an error to prevent the link being set. If @check is NULL, the
> > > + * property is read-only and cannot be set. Care must be taken to handle NULL
> > > + * values for @val.
> > > + *
> > > + * Ownership of the pointer that @child points to is transferred to the
> > > + * link property.  The reference count for *@child is
> > > + * managed by the property from after the function returns till the
> > > + * property is deleted with object_property_del().  If the
> > > + * @flags %OBJ_PROP_LINK_STRONG bit is set,
> > > + * the reference count is decremented when the property is deleted or
> > > + * modified.
> > 
> > Copy+paste mistake I presume - object_class_property_add_link does not
> > have a @child property, as this is only declaring the property on the
> > class, not setting the link's value on the object.
> 
> Interestingly enough I see that object_property_add_link() doesn't have a
> @child property either (it appears to have been changed to @targetp). I can
> easily fix that up in a separate patch.
> 
> How would we describe the ownership in terms of a class property? I'm not
> sure the last paragraph makes any sense given that a class property always
> exists. From looking at the code I think the last paragraph should simply
> read something like:
> 
> "If the @flags %OBJ_PROP_LINK_STRONG bit is set, the reference count of the
> linked object is incremented when the property is set, and decremented again
> when the property is modified."

Yeah that sounds reasonable..


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


