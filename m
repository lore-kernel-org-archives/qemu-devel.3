Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67462606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gV/PJc/g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT15z-0001wR-1Z; Mon, 16 Nov 2026 13:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT15w-0001vT-EQ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xT15u-0002Cd-CY
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794852375;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VraIfG6p1F6ltWR9vjcAwxkoKHONplgHgADBMiCCJuw=;
 b=gV/PJc/gWTazxhgTF+g4/Dkb8E+Mrt3q4+W4V8X0+PtpTAYACSdhZwvHI49omGyadSSuym
 qtp+62i02fQqHrI8VxoktGukDgyKp/kg0irFM/7r7I4U/ia86edDoHblSp5f3JNYt3aetX
 Yvummh+7gKwFlu4TRvB0BfaYaKI86jU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-1yhiKhqqP6OykLE2-l7YnA-1; Mon,
 16 Nov 2026 13:06:13 -0500
X-MC-Unique: 1yhiKhqqP6OykLE2-l7YnA-1
X-Mimecast-MFC-AGG-ID: 1yhiKhqqP6OykLE2-l7YnA_1794852372
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 794DE1955F7E; Mon, 16 Nov 2026 18:06:12 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1A7518004FC; Mon, 16 Nov 2026 18:06:09 +0000 (UTC)
Date: Mon, 16 Nov 2026 18:06:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 19/26] hw/char: mark common serial / console devices
 as secure
Message-ID: <avtGD4N677h5o85q@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
 <20261113184254.2524253-20-berrange@redhat.com>
 <1725710c-a202-406e-9eb6-d8a42a62d86a@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1725710c-a202-406e-9eb6-d8a42a62d86a@oss.qualcomm.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 02:36:39PM +0100, Philippe Mathieu-Daudé wrote:
> On 13/11/26 19:42, Daniel P. BerrangÃ© wrote:
> > These are needed as a baseline feature for many virtualization use
> > cases on x86, PPC64 and s390x.
> > 
> > Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > Acked-by: Cornelia Huck <cohuck@redhat.com> #sclpconsole(-lm)
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   hw/char/debugcon.c       | 1 +
> >   hw/char/sclpconsole-lm.c | 1 +
> >   hw/char/sclpconsole.c    | 1 +
> >   hw/char/serial-isa.c     | 1 +
> >   hw/char/serial-pci.c     | 1 +
> >   hw/char/serial.c         | 1 +
> >   hw/char/spapr_vty.c      | 1 +
> >   7 files changed, 7 insertions(+)
> > 
> > diff --git a/hw/char/debugcon.c b/hw/char/debugcon.c
> > index a1b370b90be..f38ce7b765e 100644
> > --- a/hw/char/debugcon.c
> > +++ b/hw/char/debugcon.c
> > @@ -134,6 +134,7 @@ static const TypeInfo debugcon_isa_info = {
> >       .parent        = TYPE_ISA_DEVICE,
> >       .instance_size = sizeof(ISADebugconState),
> >       .class_init    = debugcon_isa_class_initfn,
> > +    .secure        = true,
> >   };
> 
> What is the rationale for using the debug console in virtualization?

SeaBIOS/EFI are in the virtualization use and the debugcon is how
you get logs out of them to figure out what's gone wrong when they
break. IMHO that makes it worthwhile to include, and as a device,
it is simple enough that it isn't likely to give us a security
burden.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


