Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B305C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQVI-0002BE-GZ; Wed, 12 Jun 2024 12:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHQVH-0002AZ-Fg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 12:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHQVF-0002Tx-NQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 12:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718208432;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8gZC9sFbKgdeP7G05F9emmLdcMbSZ0QAmmc/5aZFAGA=;
 b=CB1vEncb63OSQM73S3s/SpeM2blSi0Gagwh1w4FRkC3PtQNQLGxjVR9ARYWQvQCi+24Tix
 0akx8X+pPyiydlAAHz44a+RDQNrNFNaEuXuqrFpRfykbgHMd9UJJfLN8JlPCzBGAN74Edr
 CbaKbN+5YCdvHZvQedbLXxtG8l4UpDY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-2hxNrrsYMNCt6-Jn_NhAUw-1; Wed,
 12 Jun 2024 12:07:08 -0400
X-MC-Unique: 2hxNrrsYMNCt6-Jn_NhAUw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C5D31955F01; Wed, 12 Jun 2024 16:07:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3E2F1956087; Wed, 12 Jun 2024 16:07:00 +0000 (UTC)
Date: Wed, 12 Jun 2024 17:06:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH v2 3/5] rust: add PL011 device model
Message-ID: <ZmnHoajecti472mi@redhat.com>
References: <rust-pl011-rfc-v2.git.manos.pitsidianakis@linaro.org>
 <0fde311846394e9f7633be5d72cc30b25587d7a1.1718101832.git.manos.pitsidianakis@linaro.org>
 <CABgObfY8BS0yCw2CxgDQTBA4np9BZgGJF3N=t6eoBcdACAE=NA@mail.gmail.com>
 <ez270.x96k6aeu0rpw@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ez270.x96k6aeu0rpw@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 05:14:56PM +0300, Manos Pitsidianakis wrote:
> On Wed, 12 Jun 2024 15:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > I think this is extremely useful to show where we could go in the task
> > of creating more idiomatic bindings.
> > 
> > On Tue, Jun 11, 2024 at 12:34 PM Manos Pitsidianakis
> > <manos.pitsidianakis@linaro.org> wrote:
> > > +pub const PL011_ARM_INFO: TypeInfo = TypeInfo {
> > > +    name: TYPE_PL011.as_ptr(),
> > > +    parent: TYPE_SYS_BUS_DEVICE.as_ptr(),
> > > +    instance_size: core::mem::size_of::<PL011State>(),
> > > +    instance_align: core::mem::align_of::<PL011State>(),
> > > +    instance_init: Some(pl011_init),
> > > +    instance_post_init: None,
> > > +    instance_finalize: None,
> > > +    abstract_: false,
> > > +    class_size: 0,
> > > +    class_init: Some(pl011_class_init),
> > > +    class_base_init: None,
> > > +    class_data: core::ptr::null_mut(),
> > > +    interfaces: core::ptr::null_mut(),
> > > +};
> > 
> > QOM is certainly a major part of what we need to do for idiomatic
> > bindings. This series includes both using QOM objects (chardev) and
> > defining them.
> > 
> > For using QOM objects, there is only one strategy that we need to
> > implement for both Chardev and DeviceState/SysBusDevice which is nice.
> > We can probably take inspiration from glib-rs, see for example
> > - https://docs.rs/glib/latest/glib/object/trait.Cast.html
> > - https://docs.rs/glib/latest/glib/object/trait.ObjectType.html
> > - https://docs.rs/glib/latest/glib/object/struct.ObjectRef.html
> 
> 
> There was consensus in the community call that we won't be writing Rust APIs
> for internal C QEMU interfaces; or at least, that's not the goal

I think that is over-stating things. This was only mentioned in passing
and my feeling was that we didn't have that detailed of a discussion
because at this stage such a discussion is a bit like putting the cart
before the horse.

While the initial focus might be to just consume a Rust API that is a
1:1 mapping of the C API, I expect that over time we'll end up writing
various higher level Rust wrappers around the C API. If we didn't do that,
then in effect we'd be making ourselves write psuedo-C code in Rust,
undermining many of the benefits we could get.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


