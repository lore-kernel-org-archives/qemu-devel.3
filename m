Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584D5CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 09:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHeHQ-0000yh-Vz; Fri, 16 Oct 2026 05:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeHP-0000y7-DK
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHeHM-0005NI-Tw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792143066;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMfn7NvvZIVwC55HyfXbXcSAjkVcuSNp2L/fNtLYZs0=;
 b=PXV8huga45imkR4BuDHSxnEhdwGC0vQ5xIt4B8j/4SbZ9lZMvF5/XbqO//0wDkrzs7wSwG
 FJjFeO/jwPsbINdazlJ8QB+Ui2gg3u0Vg/7QDtwy71mSBZmBKU/dMtTrgx5hmDrQg5Mh+r
 RpCpUF/GnW156uL5yy0ztc14VfLUi5A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-bo3uSIlyNB6cCWpBmUHS_Q-1; Fri,
 16 Oct 2026 09:31:04 +0000
X-MC-Unique: bo3uSIlyNB6cCWpBmUHS_Q-1
X-Mimecast-MFC-AGG-ID: bo3uSIlyNB6cCWpBmUHS_Q_1792143063
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 188781954B04; Fri, 16 Oct 2026 09:31:03 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97D5B1800677; Fri, 16 Oct 2026 09:31:01 +0000 (UTC)
Date: Fri, 16 Oct 2026 10:30:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
Message-ID: <atHu0kCSQTD9E34p@redhat.com>
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <atEC-pIGhLYLXVmC@redhat.com>
 <CAFEAcA-wEB15afO4Na8+8cF_Ja3v-8ewd8EdPavxJbfTmrL9GA@mail.gmail.com>
 <atHrFXxyIl3Nbvht@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atHrFXxyIl3Nbvht@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, Oct 16, 2026 at 10:15:01AM +0100, Daniel P. Berrangé wrote:
> On Thu, Oct 15, 2026 at 07:16:58PM +0100, Peter Maydell wrote:
> > On Thu, 15 Oct 2026 at 17:44, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > > On Thu, Oct 15, 2026 at 05:33:52PM +0100, Peter Maydell wrote:
> > > > The documentation for device_class_set_parent_realize() suggests that
> > > > the parent realize function pointer is "usually in the instance
> > > > structure".  This is definitely wrong, because the function pointer
> > > > is a class thing, and should live in a class struct, not an instance
> > > > struct.  Update the documentation to correct this, instead
> > > > recommending that it should be placed in the class struct for the
> > > > child class.
> > > >
> > > > At time of writing, of the 75 or so uses of this function, about 50
> > > > put the parent_realize pointer in the child class struct, and about
> > > > 25 in the parent class struct.  We recommend the former both because
> > > > it is the more common choice, and also because it makes more logical
> > > > sense: it's the child that knows (a) that it exists at all and that
> > > > (b) it wants to have a realize method that will mean it needs to
> > > > chain back to the parent, and we shouldn't need to edit the parent's
> > > > class struct because we want to add a child class that chains to its
> > > > realize method.
> > >
> > > I'm confused why we need to store a copy of the parent's
> > > realize method at all, when we can just reference it from
> > > the parent class struct ?
> > >
> > > Taking one example
> > >
> > >   static void pl050_kbd_realize(DeviceState *dev, Error **errp)
> > >   {
> > >       PL050DeviceClass *pdc = PL050_GET_CLASS(dev);
> > >       PL050KbdState *s = PL050_KBD_DEVICE(dev);
> > >       PL050State *ps = PL050(dev);
> > >
> > >       if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
> > >           return;
> > >       }
> > >
> > >       ps->ps2dev = PS2_DEVICE(&s->kbd);
> > >       pdc->parent_realize(dev, errp);
> > >   }
> > >
> > > why wouldn't we rewrite that as
> > >
> > >   static void pl050_kbd_realize(DeviceState *dev, Error **errp)
> > >   {
> > >       PL050DeviceClass *pdc = PL050_GET_CLASS(dev);
> > >       DeviceClass *parent = DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(pdc)));
> > >       PL050KbdState *s = PL050_KBD_DEVICE(dev);
> > >       PL050State *ps = PL050(dev);
> > >
> > >       if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
> > >           return;
> > >       }
> > >
> > >       ps->ps2dev = PS2_DEVICE(&s->kbd);
> > >       parent->realize(dev, errp);
> > >   }
> > >
> > > am I missing a reason we need to store the parent's
> > > realize method pointer ?
> > 
> > Because the parent class's struct doesn't have a pointer to
> > its realize method. pl050_class_init() does this to set
> > up its realize method:
> > 
> >     DeviceClass *dc = DEVICE_CLASS(oc);
> > 
> >     dc->realize = pl050_realize;
> > 
> > and that's the only place where pl050_realize is pointed to.
> > 
> > To put the child class's realize method into place we need
> > to overwrite the DeviceClass::realize field, which means we
> > need somewhere to put the old value.
> 
> We're overwriting the DeviceClass::realize field in the class
> struct instance for "pl050_keyboard". We still have the completely
> independent class struct instance for "pl050" (which is what
> object_class_get_parent() returns) that contains the 'realize'
> field value set by the parent class.
> 
> eg if I put a break on pl050_kbd_realize():
> 
>   (gdb) print pdc->parent_class->parent_class->parent_class->type->name
>   $5 = 0x555557de40a0 "pl050_keyboard"
>   (gdb) print pdc->parent_class->parent_class->realize
>   $6 = (DeviceRealize) 0x55555585db67 <pl050_kbd_realize>
> 
> and separately
> 
>   (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->parent_class->type->name
>   $7 = 0x555557de3ee0 "pl050"
>   (gdb) print ((DeviceClass*)(object_class_get_parent(pdc)))->realize
>   $8 = (DeviceRealize) 0x55555585daf4 <pl050_realize>
> 
> > We could alternatively solve this by saying:
> >  (a) every class struct must have a "realize" field,
> >      and the class init sets both DeviceClass::realize and
> >      MyClass::realize (perhaps restrict this to only "every
> >      class that has or might need to have subclasses")
> >  (b) to chain to the superclass realize, get the MyParentClass
> >      class pointer and call MyParentClass::realize
> > 
> > The support (or lack thereof) in QOM for methods like realize,
> > unrealize and reset which should pretty much always chain to
> > their parent class implementation is pretty terrible, so if
> > we can come up with something more ergonomic I'd be happy to
> > throw out the hacks we have today.
> 
> AFAICT, we can already do everything we need with the parent class
> to chain up parent virtual methods without having  to keep extra
> pointers around.

We can make it a little less ugly in the callers with a macro in
qdev.h thus:

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 8e91e2fcb08..18e85850c31 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -461,6 +461,9 @@ static inline bool qdev_is_realized(const DeviceState *dev)
  */
 bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp);
 
+#define qdev_realize_chain_parent(dev, dc, errp) \
+    DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(dc)))->realize(dev, errp)
+
 /**
  * qdev_realize_and_unref: Realize @dev and drop a reference
  * @dev: device to realize


which would be used thus:


diff --git a/hw/input/pl050.c b/hw/input/pl050.c
index 48df2734e26..abe939171f2 100644
--- a/hw/input/pl050.c
+++ b/hw/input/pl050.c
@@ -168,7 +168,7 @@ static void pl050_kbd_realize(DeviceState *dev, Error **errp)
     }
 
     ps->ps2dev = PS2_DEVICE(&s->kbd);
-    pdc->parent_realize(dev, errp);
+    qdev_realize_chain_parent(dev, pdc, errp);
 }
 
 static void pl050_kbd_init(Object *obj)
@@ -191,7 +191,8 @@ static void pl050_mouse_realize(DeviceState *dev, Error **errp)
     }
 
     ps->ps2dev = PS2_DEVICE(&s->mouse);
-    pdc->parent_realize(dev, errp);
+
+    qdev_realize_chain_parent(dev, pdc, errp);
 }
 
 static void pl050_mouse_init(Object *obj)
@@ -206,10 +207,8 @@ static void pl050_mouse_init(Object *obj)
 static void pl050_kbd_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    PL050DeviceClass *pdc = PL050_CLASS(oc);
 
-    device_class_set_parent_realize(dc, pl050_kbd_realize,
-                                    &pdc->parent_realize);
+    dc->realize = pl050_kbd_realize;
 }
 
 static const TypeInfo pl050_kbd_info = {
@@ -223,10 +222,8 @@ static const TypeInfo pl050_kbd_info = {
 static void pl050_mouse_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    PL050DeviceClass *pdc = PL050_CLASS(oc);
 
-    device_class_set_parent_realize(dc, pl050_mouse_realize,
-                                    &pdc->parent_realize);
+    dc->realize = pl050_mouse_realize;
 }
 
 static const TypeInfo pl050_mouse_info = {
diff --git a/include/hw/input/pl050.h b/include/hw/input/pl050.h
index 2cdfa74f73c..7169afc151f 100644
--- a/include/hw/input/pl050.h
+++ b/include/hw/input/pl050.h
@@ -17,8 +17,6 @@
 
 struct PL050DeviceClass {
     SysBusDeviceClass parent_class;
-
-    DeviceRealize parent_realize;
 };
 
 #define TYPE_PL050 "pl050"



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


