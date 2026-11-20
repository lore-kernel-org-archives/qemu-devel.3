Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EF4606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SC9l5Vlz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUKN4-0006Xn-Kq; Fri, 20 Nov 2026 03:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUKN0-0006Rs-5I
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 03:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xUKMw-0001Jb-2q
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 03:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795164796;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGj1YLqRulacKklrr5yY0qbQHITOeMw1PDVdicszIqI=;
 b=SC9l5VlzzOXfAEbrJJKfWOs5XDitAXXF5IV+PqExw68jW3UFGbdF06XBaiuJcipyyU1+B6
 vVZEh8c6x/erWIzbCN7+AATbLTVYQpHeE0fJpnSp7X3dZ1NXI+y9W9WBW5MiUCewMVkVyi
 pcBbS5Yr+wNuQsBP5PcCUVunv5BRf84=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-qYGn8PqYOgeddjKBvNTrkA-1; Fri,
 20 Nov 2026 08:53:12 +0000
X-MC-Unique: qYGn8PqYOgeddjKBvNTrkA-1
X-Mimecast-MFC-AGG-ID: qYGn8PqYOgeddjKBvNTrkA_1795164791
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B73ED180054C; Fri, 20 Nov 2026 08:53:10 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4D00195605B; Fri, 20 Nov 2026 08:53:08 +0000 (UTC)
Date: Fri, 20 Nov 2026 08:53:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jag Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: x-remote-object breaks QOM introspection
Message-ID: <awAKcZ-HG5M7qjVQ@redhat.com>
References: <87jymbjyia.fsf@pond.sub.org>
 <E30ADD82-0779-4294-B235-D27FD379C9D6@oracle.com>
 <877bi9e4mi.fsf@pond.sub.org>
 <C03B480F-3701-4DEB-A9DD-6C0F80A62568@oracle.com>
 <av8i7zkyTMX91FZs@redhat.com> <87mrr484cq.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mrr484cq.fsf@pond.sub.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:21:57AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Nov 19, 2026 at 04:13:31PM +0000, Jag Raman wrote:
> >> 
> >> 
> >> > On Nov 19, 2026, at 1:07 AM, Markus Armbruster <armbru@pond.sub.org> wrote:
> >> > 
> >> > This Message Is From a New Sender
> >> > You have not previously corresponded with the sender of this message.
> >> > Report Suspicious
> >> > Jag Raman <jag.raman@oracle.com> writes:
> >> > 
> >> > >> On Nov 17, 2026, at 9:58 AM, Markus Armbruster <armbru@pond.sub.org> wrote:
> >> > >> 
> >> > >> Watch this:
> >> > >> 
> >> > >> $ qemu-system-x86_64 -S -nodefaults -display none -qmp stdio
> >> > >> {"QMP": {"version": {"qemu": {"micro": 90, "minor": 1, "major": 11}, "package": "v11.2.0-rc0-3-g38171f59ccb-dirty"}, "capabilities": ["oob"]}}
> >> > >> {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}
> >> > >> {"return": {}}
> >> > >> {"execute": "qom-list-properties", "arguments": {"typename": "x-remote-object"}}
> >> > >> --> qemu-system-x86_64: (null) is not a PCI device
> >> > >> {"return": [{"name": "type", "type": "string", "qapi-type": "str"}, {"name": "devid", "type": "string", "qapi-type": "str"}, {"name": "fd", "type": "string", "qapi-type": "str"}]}
> >> > >> 
> >> > >> The error message is suspicious. Origin:
> >> > >> 
> >> > >> static void remote_object_machine_done(Notifier *notifier, void *data)
> >> > >> {
> >> > >> RemoteObject *o = container_of(notifier, RemoteObject, machine_done);
> >> > >> DeviceState *dev = NULL;
> >> > >> QIOChannel *ioc = NULL;
> >> > >> Coroutine *co = NULL;
> >> > >> RemoteCommDev *comdev = NULL;
> >> > >> Error *err = NULL;
> >> > >> 
> >> > >> dev = qdev_find_recursive(sysbus_get_default(), o->devid);
> >> > >> if (!dev || !object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
> >> > >> error_report("%s is not a PCI device", o->devid);
> >> > >> return;
> >> > >> }
> >> > >> 
> >> > >> o->devid is null, dev is null.
> >> > >> 
> >> > >> Glibc's %s shows null pointer as "(null)". There are libcs that simply
> >> > >> crash.
> >> > >> 
> >> > >> Stack backtrace:
> >> > >> 
> >> > >> #0 remote_object_machine_done (notifier=0x5555587d17e8, data=0x0)
> >> > >> at ../hw/remote/remote-obj.c:93
> >> > >> #1 0x000055555578700e in qemu_add_machine_init_done_notifier
> >> > >> (notify=0x5555587d17e8) at ../hw/core/machine.c:1721
> >> > >> #2 0x00005555556f26dd in remote_object_init (obj=0x5555587d17c0)
> >> > >> at ../hw/remote/remote-obj.c:149
> >> > >> #3 0x0000555555cbda2d in object_init_with_type
> >> > >> (obj=0x5555587d17c0, ti=0x5555577c02d0) at ../qom/object.c:430
> >> > >> #4 0x0000555555cbde2c in object_initialize_with_type
> >> > >> (obj=0x5555587d17c0, size=136, type=0x5555577c02d0) at ../qom/object.c:512
> >> > >> #5 0x0000555555cbe6fa in object_new_with_type (type=0x5555577c02d0)
> >> > >> at ../qom/object.c:710
> >> > >> #6 0x0000555555cbe784 in object_new
> >> > >> (typename=0x555558356a10 "x-remote-object") at ../qom/object.c:726
> >> > >> #7 0x0000555555e2d6be in qmp_qom_list_properties
> >> > >> (typename=0x555558356a10 "x-remote-object", errp=0x7fffffffd888)
> >> > >> at ../qom/qom-qmp-cmds.c:290
> >> > >> [...]
> >> > >> 
> >> > >> I believe using qemu_add_machine_init_done_notifier() is wrong here.
> >> > >> Could we use UserCreatableClass method complete()?
> >> > >
> >> > > Hi Markus,
> >> > >
> >> > > The remote_object_machine_done() notifier exists so qdev_find_recursive()
> >> > > has a chance to find o->devid. We could setup this notifier UserCreatableClass
> >> > > method complete() if you prefer.
> >> > 
> >> > I guess that unbreaks QOM introspection, because complete() doesn't run
> >> > there.
> >> > 
> >> > Can you explain why you need to defer code to machine init done?
> >> 
> >> When x-remote-object is instantiated, the PCI device identified by o->devid may not
> >> yet exist because it appears later in QEMU’s command-line options. As a result,
> >> qdev_find_recursive() may fail to find it. Deferring the lookup until machine init done
> >> ensures that all devices have been instantiated and can be found using qdev_find_recursive().
> >
> > We've already got hacks to process different -object classes at
> > different phases of command line processing. It sounds like
> > x-remote-object needs to be set to be processed after -device.
> >
> > ie we need a new object_create_very_late() to be run after
> > qemu_create_cli_devices()
> 
> Many devices interact with supporting objects.  We have a common
> frontend / backend pattern:
> 
> * The device (frontend) has a property identifying the object (backend).
>   The property setter resolves the property value to an object of the
>   required type, and fails if it can't.  This also fails device
>   creation.
> 
>   CLI works, because we execute -object before -device.
> 
>   Monitor works as long as users object_add before device_add.
> 
> * Ideally, the device can work with any object of the required kind.
>   When it can't, which isn't rare, its .realize() checks the object is
>   suitable, and fails if it isn't.  This also fails device creation.
> 
> Why isn't this workable here?

The relationship between the object and device is reversed from
the normal direction in the case of x-remote-object.

Normally an object provides some kind of backend service that
is consumed by the device.

In this case the device can be any PCI endpoint and x-remote-object
is consuming the device, in order to export it over the network
to another "client" QEMU process which uses the x-pci-proxy-dev.


So in the monitor you would use object_add x-remote-object after
device_add <whatever>, and likewise the CLI should create
"x-remote-object" after processing all -device.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


