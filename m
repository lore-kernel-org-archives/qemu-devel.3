Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F4D3399F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 16:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5SxS-0007EU-5E; Mon, 28 Oct 2024 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5SxM-0007BW-4c
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5SxK-0002NH-BR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 12:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730134261;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JQMC1mQcAhmDS1b3Sr7x2toWr8eGybYiYqGnezOUii8=;
 b=Y/DmBAVis7aHFCrMH/i1mLRCCSDSrMdxf0J6KlFjpctqeTzulReZqW6MIYZtGXJ4FpyOl0
 1H/r09LXFO7kZV+2FVATFgNLohacweY59O4/+14M6EWQUNJoj0qTxQmRa8r9E+D7MorCvE
 WNPWKuUlq8/PQwG0rfGuwKuRBQ2jv3A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136--nb_znoVOd68WKLGUlImvQ-1; Mon,
 28 Oct 2024 12:49:18 -0400
X-MC-Unique: -nb_znoVOd68WKLGUlImvQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA0B41955F56; Mon, 28 Oct 2024 16:49:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A44911956086; Mon, 28 Oct 2024 16:49:10 +0000 (UTC)
Date: Mon, 28 Oct 2024 16:49:07 +0000
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
Message-ID: <Zx_Ag0_MFem7Qn3a@redhat.com>
References: <20241022-virtio-v2-0-b2394236e053@daynix.com>
 <20241022-virtio-v2-1-b2394236e053@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022-virtio-v2-1-b2394236e053@daynix.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The parent msg was sent off-list orignially, so below is a copy
of my feedback to that off-list posting.

On Tue, Oct 22, 2024 at 01:50:38PM +0900, Akihiko Odaki wrote:
> Accept bool literals for OnOffAuto properties for consistency with bool
> properties. This enables users to set the "on" or "off" value in a
> uniform syntax without knowing whether the "auto" value is accepted.
> This behavior is especially useful when converting an existing bool
> property to OnOffAuto or vice versa.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  hw/core/qdev-properties.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 86a583574dd0..f0a270bb4f61 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -491,6 +491,21 @@ const PropertyInfo qdev_prop_string = {
>      .set   = set_string,
>  };
>  
> +static void set_on_off_auto(Object *obj, Visitor *v, const char *name,
> +                            void *opaque, Error **errp)
> +{
> +    Property *prop = opaque;
> +    int *ptr = object_field_prop_ptr(obj, prop);
> +    bool value;
> +
> +    if (visit_type_bool(v, name, &value, NULL)) {
> +        *ptr = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +        return;
> +    }
> +
> +    qdev_propinfo_set_enum(obj, v, name, opaque, errp);
> +}

My feedback is the same as last time this was posted.

This is adding redundant new input-only & secret syntax for every
usage of OnOffAuto across QEMU.

"consistency with bool" isn't a expressing a compelling advantage.

The new permitted values are invisible to applications, beacuse
introspecting QAPI schema for the "OnOffAuto" type will never
report them, and querying the value of a property will also never
report them.

I'm not seeing an advantage, or clear problem solved, by adding
this.

> +
>  /* --- on/off/auto --- */
>  
>  const PropertyInfo qdev_prop_on_off_auto = {
> @@ -498,7 +513,7 @@ const PropertyInfo qdev_prop_on_off_auto = {
>      .description = "on/off/auto",
>      .enum_table = &OnOffAuto_lookup,
>      .get = qdev_propinfo_get_enum,
> -    .set = qdev_propinfo_set_enum,
> +    .set = set_on_off_auto,
>      .set_default_value = qdev_propinfo_set_default_value_enum,
>  };
>  
> 
> -- 
> 2.47.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


