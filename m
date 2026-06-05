Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C05ACD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVOjX-0001x2-1x; Fri, 05 Jun 2026 03:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVOjV-0001wY-LR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 03:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wVOjT-0002uO-Ul
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 03:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780643561;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nj7rBGOOhFnBqw/e88JtHJvQzTNcEh1/lc9NIJN4uk0=;
 b=b+9YbG1YoYDfA1sd0f3w32ZaEjqc3YFy3J/is0pCJy8XRAixrNkHM1GcRueFN3ANNJXgXJ
 lWU9/My84ynwqsrHlKAKyJmUV4v13OQyk7AEfaGIe0/3D15ZYCgTDrRLudraPewdPUwnzr
 sz4Ww+ygy6YnRBqyiqhQOhul9tNImw8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-tifyOgfUOyWYlU1i_c1GoQ-1; Fri,
 05 Jun 2026 03:12:39 -0400
X-MC-Unique: tifyOgfUOyWYlU1i_c1GoQ-1
X-Mimecast-MFC-AGG-ID: tifyOgfUOyWYlU1i_c1GoQ_1780643559
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D93F91956094
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 07:12:38 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.34])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC9691766; Fri,  5 Jun 2026 07:12:36 +0000 (UTC)
Date: Fri, 5 Jun 2026 08:12:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Subject: Re: [PATCH v3 16/24] hw/i386/nitro_enclave: add instance finalize
Message-ID: <aiJ24S66EXEONThG@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-16-3f20c3a029a7@redhat.com>
 <aiGTNf5iyWnk1OS1@redhat.com>
 <CAMxuvazn3f8y+wR0YuBXjypHBpj3uGVPwHv_rAskH41FCumZig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazn3f8y+wR0YuBXjypHBpj3uGVPwHv_rAskH41FCumZig@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jun 05, 2026 at 12:18:50AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 4, 2026 at 7:01 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Sat, May 16, 2026 at 11:59:15AM +0400, Marc-André Lureau wrote:
> > > Property setter strings (vsock, id, parent_role, parent_id) were
> > > never freed because nitro_enclave_machine_info had no
> > > instance_finalize.
> > >
> > > Fixes: f1826463d2e8 ("machine/nitro-enclave: New machine type for AWS Nitro Enclaves")
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  hw/i386/nitro_enclave.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
> > > index a29f0044d0e..1ce9ee3358a 100644
> > > --- a/hw/i386/nitro_enclave.c
> > > +++ b/hw/i386/nitro_enclave.c
> > > @@ -337,11 +337,22 @@ static void nitro_enclave_class_init(ObjectClass *oc, const void *data)
> > >                                            "Set parent instance identifier");
> > >  }
> > >
> > > +static void nitro_enclave_machine_finalize(Object *obj)
> > > +{
> > > +    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
> > > +
> > > +    g_free(nems->vsock);
> > > +    g_free(nems->id);
> > > +    g_free(nems->parent_role);
> > > +    g_free(nems->parent_id);
> > > +}
> >
> >
> > Beyond these strings, nems->vnsm is initialized from
> > qdev_new(...) and I'm not seeing what frees that
> > device.
> 
> Correct, but it is followed by qdev_realize_and_unref(), thus it
> doesn't own a reference.

Ah yes, in that case

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>



> 
> >
> > I presume the qom test at the end only exposed the
> > string leaks ?
> 
> yes
> 
> thanks
> 
> >
> >
> > > +
> > >  static const TypeInfo nitro_enclave_machine_info = {
> > >      .name          = TYPE_NITRO_ENCLAVE_MACHINE,
> > >      .parent        = TYPE_MICROVM_MACHINE,
> > >      .instance_size = sizeof(NitroEnclaveMachineState),
> > >      .instance_init = nitro_enclave_machine_initfn,
> > > +    .instance_finalize = nitro_enclave_machine_finalize,
> > >      .class_size    = sizeof(NitroEnclaveMachineClass),
> > >      .class_init    = nitro_enclave_class_init,
> > >  };
> > >
> > > --
> > > 2.54.0
> > >
> > >
> >
> > With regards,
> > Daniel
> > --
> > |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> > |: https://libvirt.org          ~~          https://entangle-photo.org :|
> > |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
> >
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


