Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83826CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHOZd-0004Bs-4Z; Thu, 15 Oct 2026 12:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHOZb-0004Bk-RS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHOZZ-0002G4-H8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 12:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792082692;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=PZ9pyrQrnee46RKeI3S/lfT/EkCioyWD9rXLJWW1d2s=;
 b=BA1jzUvYTSu1ZF/prC5D1L4uWqOlENBqYQpGuXNQSG9E4gGhFkLDCzEbU2wjY7cNZp8PWU
 opz1hNrsgYuUnqCE3BnGuSNHD8baidcpsid+x5vk6D3RwKm++mIfiMoJUN13sLTaV7Y+gg
 NlTVcElYhewkrgdvI/lFmvPjkcNGhA4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-vzhQ_zUaP8KIyTFTRYFiEA-1; Thu,
 15 Oct 2026 16:44:49 +0000
X-MC-Unique: vzhQ_zUaP8KIyTFTRYFiEA-1
X-Mimecast-MFC-AGG-ID: vzhQ_zUaP8KIyTFTRYFiEA_1792082688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E519B1800635; Thu, 15 Oct 2026 16:44:47 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EAE81800677; Thu, 15 Oct 2026 16:44:46 +0000 (UTC)
Date: Thu, 15 Oct 2026 17:44:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
Message-ID: <atEC-pIGhLYLXVmC@redhat.com>
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015163352.1751191-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 15, 2026 at 05:33:52PM +0100, Peter Maydell wrote:
> The documentation for device_class_set_parent_realize() suggests that
> the parent realize function pointer is "usually in the instance
> structure".  This is definitely wrong, because the function pointer
> is a class thing, and should live in a class struct, not an instance
> struct.  Update the documentation to correct this, instead
> recommending that it should be placed in the class struct for the
> child class.
> 
> At time of writing, of the 75 or so uses of this function, about 50
> put the parent_realize pointer in the child class struct, and about
> 25 in the parent class struct.  We recommend the former both because
> it is the more common choice, and also because it makes more logical
> sense: it's the child that knows (a) that it exists at all and that
> (b) it wants to have a realize method that will mean it needs to
> chain back to the parent, and we shouldn't need to edit the parent's
> class struct because we want to add a child class that chains to its
> realize method.

I'm confused why we need to store a copy of the parent's
realize method at all, when we can just reference it from
the parent class struct ?

Taking one example

  static void pl050_kbd_realize(DeviceState *dev, Error **errp)
  {
      PL050DeviceClass *pdc = PL050_GET_CLASS(dev);
      PL050KbdState *s = PL050_KBD_DEVICE(dev);
      PL050State *ps = PL050(dev);

      if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
          return;
      }

      ps->ps2dev = PS2_DEVICE(&s->kbd);
      pdc->parent_realize(dev, errp);
  }

why wouldn't we rewrite that as

  static void pl050_kbd_realize(DeviceState *dev, Error **errp)
  {
      PL050DeviceClass *pdc = PL050_GET_CLASS(dev);
      DeviceClass *parent = DEVICE_CLASS(object_class_get_parent(OBJECT_CLASS(pdc)));
      PL050KbdState *s = PL050_KBD_DEVICE(dev);
      PL050State *ps = PL050(dev);

      if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
          return;
      }

      ps->ps2dev = PS2_DEVICE(&s->kbd);
      parent->realize(dev, errp);
  }

am I missing a reason we need to store the parent's
realize method pointer ?


> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/core/qdev.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> index 8e91e2fcb08..1330e0153d4 100644
> --- a/include/hw/core/qdev.h
> +++ b/include/hw/core/qdev.h
> @@ -953,9 +953,18 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n);
>   *
>   * This is intended to be used when the new realize function will
>   * eventually call its parent realization function during creation.
> - * This requires storing the function call somewhere (usually in the
> - * instance structure) so you can eventually call
> - * dc->parent_realize(dev, errp)
> + * @parent_realize should be where you want to save the pointer to
> + * the parent class realize function; the recommended location is a
> + * field named "parent_realize" in your class's class struct.
> + * (Some existing code puts the field in the parent class's class
> + * struct; this will work but is not the preferred thing for new code.)
> + *
> + * In your realize function you should chain to your parent's
> + * realize function using something like::
> + *
> + *    MyThingClass *mc = MY_THING_GET_CLASS(dev);
> + *    (do your child class realize actions here)
> + *    mc->parent_realize(dev, errp);
>   */
>  void device_class_set_parent_realize(DeviceClass *dc,
>                                       DeviceRealize dev_realize,
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


