Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932F9E6B244
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6q2h-0002w2-VP; Fri, 01 Nov 2024 07:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6q2d-0002vP-2w
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:42:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6q2b-000887-4K
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730461327;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrq2uBgbh0z6z/m4x+L5KVk/I3stax1HAxidKosaEbk=;
 b=BKFVv8WbZ/J1/1FcDM34E/ZMdw8uSZNmr52Mz2ZE+dN8Idh5nn0Ov9frBHuPG8aFCFvvYH
 o7mVWzABwPHa6XtttIEZ6mHpjsydyQRfkP6NeAjryIqVQx8ArdvlnKW/I7fDBEV2xU6gYR
 EhDaQv15HtaoeF6Xhheg/Yi7OYw56VE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Dw1LtEXsN-2Dh0JjK_IiMg-1; Fri,
 01 Nov 2024 07:42:02 -0400
X-MC-Unique: Dw1LtEXsN-2Dh0JjK_IiMg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB5E81955D92; Fri,  1 Nov 2024 11:41:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7D4F19560A2; Fri,  1 Nov 2024 11:41:54 +0000 (UTC)
Date: Fri, 1 Nov 2024 11:41:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/3] qdev-properties: Accept bool for OnOffAuto
Message-ID: <ZyS-fx0zjRJTOgkt@redhat.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-1-b2394236e053@daynix.com>
 <Zx_Ag0_MFem7Qn3a@redhat.com>
 <3dd9b22b-2e0c-4999-aab0-eac751923c35@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dd9b22b-2e0c-4999-aab0-eac751923c35@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 31, 2024 at 04:21:08PM +0900, Akihiko Odaki wrote:
> On 2024/10/29 1:49, Daniel P. Berrangé wrote:
> > The parent msg was sent off-list orignially, so below is a copy
> > of my feedback to that off-list posting.
> > 
> > On Tue, Oct 22, 2024 at 01:50:38PM +0900, Akihiko Odaki wrote:
> > > Accept bool literals for OnOffAuto properties for consistency with bool
> > > properties. This enables users to set the "on" or "off" value in a
> > > uniform syntax without knowing whether the "auto" value is accepted.
> > > This behavior is especially useful when converting an existing bool
> > > property to OnOffAuto or vice versa.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   hw/core/qdev-properties.c | 17 ++++++++++++++++-
> > >   1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> > > index 86a583574dd0..f0a270bb4f61 100644
> > > --- a/hw/core/qdev-properties.c
> > > +++ b/hw/core/qdev-properties.c
> > > @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
> > >       .set   = set_string,
> > >   };
> > > +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
> > > +                            void *opaque, Error **errp)
> > > +{
> > > +    Property *prop = opaque;
> > > +    int *ptr = object_field_prop_ptr(obj, prop);
> > > +    bool value;
> > > +
> > > +    if (visit_type_bool(v, name, &value, NULL)) {
> > > +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> > > +        return;
> > > +    }
> > > +
> > > +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
> > > +}
> > 
> > My feedback is the same as last time this was posted.
> > 
> > This is adding redundant new input-only & secret syntax for every
> > usage of OnOffAuto across QEMU.
> > 
> > "consistency with bool" isn't a expressing a compelling advantage.
> > 
> > The new permitted values are invisible to applications, beacuse
> > introspecting QAPI schema for the "OnOffAuto" type will never
> > report them, and querying the value of a property will also never
> > report them.
> > 
> > I'm not seeing an advantage, or clear problem solved, by adding
> > this.
> 
> The intent of this patch is to ease migration from bool to OnOffAuto; a user
> should be able to set the "on" or "off" value without knowing the "auto"
> value is accepted.
> 
> The redundancy of syntax is already present with bool. If it is problematic,
> the redundant syntax should be deprecated altogether, whether the type is
> OnOffAuto or bool.

The redundant syntax for bool is only present in the legacy QemuOpts
based CLI syntax. If using modern JSON syntax, or QMP, it is required
to use the navtive JSON bool type.

This proposed change to OnOffAuto is affecting both legacy and modern
syntax, adding redundancy to both, here none currently exists for the
latter. So this is qualatively different from the status quo, and
taking us in a direction we don't want to go.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


