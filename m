Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220C7606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fBdOSXqO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7Qv-0007qo-3h; Wed, 11 Nov 2026 07:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7Qr-0007qZ-Jn
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xR7Qn-0003lg-I8
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794400079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ybc1tgcM8C6/wTRnWiIddEMZD9v7gewi516lpTDQIA=;
 b=fBdOSXqOhKRRyH90A60q4DTrXkwBYkdCFbLgEXJMYBJeY8iL6Slhp/LUh3PvucsUPwK3s/
 vi9JmNOpjLx3PFL27NsdNJA64OW2bcaYDb0KKmO3pH9VX2AL1ett5j9R1CoZLbXv1ajccn
 IkcM/5mc3o4yh3VxUWfA+30FdIcIcks=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-SxdJEiJXPtuTxAGmOXJHFA-1; Wed,
 11 Nov 2026 07:27:28 -0500
X-MC-Unique: SxdJEiJXPtuTxAGmOXJHFA-1
X-Mimecast-MFC-AGG-ID: SxdJEiJXPtuTxAGmOXJHFA_1794400046
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 727D01955DC4; Wed, 11 Nov 2026 12:27:26 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37DAF19634EF; Wed, 11 Nov 2026 12:27:22 +0000 (UTC)
Date: Wed, 11 Nov 2026 12:27:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: qemu-system-x86_64 appears to have sgx-epc, but not
 memory-backend-epc
Message-ID: <avRfKD2snrmJC3c-@redhat.com>
References: <87zew5j3iv.fsf@pond.sub.org> <ats0_RfeVugAofN9@redhat.com>
 <CAFEAcA_wabjzp0KF69-ay75QoOk=jE-TygrD-T-b60dw1iOs=g@mail.gmail.com>
 <87bj7vwokb.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bj7vwokb.fsf@pond.sub.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 01:16:36PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Fri, 23 Oct 2026 at 11:21, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>
> >> On Thu, Oct 22, 2026 at 02:58:16PM +0200, Markus Armbruster wrote:
> >> > My build of qemu-system-x86_64 has device sgx-epc:
> >> >
> >> >  --> {"execute": "qom-list-types", "arguments": {"implements": "sgx-epc"}}
> >> >  <-- {"return": [{"name": "sgx-epc", "parent": "device"}]}
> >> >
> >> > The device as a link property to a memory-backend-epc:
> >> >
> >> >  --> {"execute": "qom-list-properties", "arguments": {"typename": "sgx-epc"}}
> >> >  <-- {"return": [...
> >> >                  {"name": "memdev", "type": "link<memory-backend-epc>"},
> >> >                  ...]}
> >> >
> >> > However, type memory-backend-epc does not exist:
> >
> >> There is some rather dubious code that conditionally registers
> >> the type
> >>
> >> static void register_types(void)
> >> {
> >>     int fd = qemu_open_old("/dev/sgx_vepc", O_RDWR);
> >>     if (fd >= 0) {
> >>         close(fd);
> >>
> >>         type_register_static(&sgx_epc_backed_info);
> >>     }
> >> }
> >>
> >>
> >> Normal practice is for types to be unconditionally registered.  Do we
> >> have any examples outside of this SGX case where we conditionally
> >> register types ?   Should we change this to follow normal practice ?
> >
> > TYPE_MEMORY_BACKEND_MEMFD does the same. I did a quick grep for
> > "calls to type_register not indented by exactly 4 spaces" and
> > I think the other cases are "misindented" or "data-driven
> > type registration" rather than trying to do things conditionally
> > (but I didn't actually look at all of them, instead making
> > guesses based on variable names, so maybe there's one or two
> > more I missed).
> 
> Alright, I looked.  In addition to "misindented" or "data-driven", I
> found:
> 
> * register_types() in hostmem-memfd.c registers "memory-backend-memfd"
>   only when a test of memfd_create() succeeds.  This is what Peter
>   reported.
> 
> * virtio_ccw_gpu_register() in hw/s390x/virtio-ccw-gpu.c registers
>   "virtio-gpu-ccw" only when have_virtio_ccw, which is true when
>   hw/s390x/virtio-ccw.c gets compiled into the binary.  So it's
>   effectively compile-time conditional.
> 
>   I wish it was literally compile-time conditional, either in meson or
>   using #if.

That looks like it is dead code to me. hw/s390x/meson.build does

  hw_s390x_modules = {}
  virtio_gpu_ccw_ss = ss.source_set()
  virtio_gpu_ccw_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_CCW'],
                        if_true: [files('virtio-ccw-gpu.c'), pixman])
  hw_s390x_modules += {'virtio-gpu-ccw': virtio_gpu_ccw_ss}

it doesn't look like 'have_virtio_ccw' can ever be false, due
to the CONFIG_VIRTIO_CCW Kconfig check ?

> 
> * qemu_console_early_init() in ui/console-vc.c registers "chardev-vc" if
>   it's not already registered.  early_dbus_init() in ui/dbus.c,
>   early_gtk_display_init() in ui/gtk.c, and
>   spice_app_display_early_init() in ui/spice-app.c all register it.
> 
>   These are all QemuDisplay .early_init() callbacks.
>   qemu_display_early_init() calls the selected display's .early_init(),
>   if non-null.
> 
>   Because qemu_console_early_init() runs after
>   qemu_display_early_init(), this always registers a "chardev-vc": the
>   active display may register its own, and when it doesn't, we get
>   ui/console-vc.c's.
> 
>   More moving parts than I'd like.
> 
> I'm going to post patches for backends/hostmem-{epc,memfd}.c.  I don't
> plan to clean up the other two at this time.
> 
> [...]
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


