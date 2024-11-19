Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF50D6C291
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 20:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDUci-0002OC-7U; Tue, 19 Nov 2024 15:14:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUcc-0002Nr-NZ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDUca-0007Sm-OJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 15:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732047286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNxcwpI1pDgrg6REsIkUNIWBG9xPo+dUkPNalaG+9OE=;
 b=fIoeowq6bb25L5KVGRgd0YLK01Ds7CfWTOpKTlY5IixGlUQDtK+IdTWZtR3deytWBoh2l/
 Vl9c+xztxKx4/13iFAqljWR5H05m/CFMo1hjiW2pRyaBHflyMyN74XntBS5qHNwQZ/VcL4
 7noNFny4wD/qIEbrXWgnxTQsR4z3w7k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-dqLEhkNpNNaQwj7QpkO6qA-1; Tue, 19 Nov 2024 15:14:43 -0500
X-MC-Unique: dqLEhkNpNNaQwj7QpkO6qA-1
X-Mimecast-MFC-AGG-ID: dqLEhkNpNNaQwj7QpkO6qA
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d41a460386so16397576d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 12:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732047283; x=1732652083;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNxcwpI1pDgrg6REsIkUNIWBG9xPo+dUkPNalaG+9OE=;
 b=NvzkYZSw3sJokyuuLRQKsZ3KDzA5s4k4uQG9MvasKeyloacPGBDbFGrtx+nvrTMYH5
 j1TVVYtlasT2cMJ/XPRwvPSSXEhiqys5Qb2yGcwLYibQ7oRwrthSMHI2K7uJrLv4Jium
 D/740bOB4iQ/1p/ouiwLVOGqIi8bESg9N/8nZgW3WSzwo4rTDun2+yVyEw9KXiPov8hm
 OPjSMRvioN/ObiUgetxym/FD6BxGnCGsEFuu2Pz7Gbe9JOlnyAcRFXWjb6qMSHNDEuo3
 Q9mDl6qB7y/TAG4PCwepxmNONezPl6RVdpKTEqr+ShfrMMwwlEuAUiSD4ZSmymoBQt9m
 0+dA==
X-Gm-Message-State: AOJu0YyD12yRZE2ctOTKlWiG+0WtIbnEtDDERco7HRau90AjwwmK7Emi
 05vweW1UoZkY2zRZ41QlJkD/tPQWHpMKEU/8eWB9qUM0x4PHjXx0iu/4tQvu9/lRaopm8SaHnwl
 42/x66sDcokUrAb+Gsb22gea4rR+8NYBdx8RkHpFuHuxuSW/gdZFF
X-Received: by 2002:ad4:596d:0:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6d4378288f1mr3691596d6.33.1732047283343; 
 Tue, 19 Nov 2024 12:14:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbwfXhK/CSl3V8Pm7DKLABSlkUlvgoaWeAdp+U8h7rDquwYeE/nUXvIuGpyfF9Sy1KVBZwdg==
X-Received: by 2002:ad4:596d:0:b0:6d3:b936:60d1 with SMTP id
 6a1803df08f44-6d4378288f1mr3691336d6.33.1732047283043; 
 Tue, 19 Nov 2024 12:14:43 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d4380f55bdsm60656d6.59.2024.11.19.12.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 12:14:42 -0800 (PST)
Date: Tue, 19 Nov 2024 15:14:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/5] qdev: Make device_set_realized() always safe in tests
Message-ID: <Zzzxr9YC0Zcs_k5N@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-4-peterx@redhat.com>
 <Zzxee1_WHrZvIxqX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zzxee1_WHrZvIxqX@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 19, 2024 at 09:46:35AM +0000, Daniel P. Berrangé wrote:
> On Mon, Nov 18, 2024 at 05:13:28PM -0500, Peter Xu wrote:
> > Currently, a device can be realized even before machine is created, but
> > only in one of QEMU's qtest, test-global-qdev-props.c.
> > 
> > Right now, the test_static_prop_subprocess() test (which creates one simple
> > object without machine created) will internally make "/machine" to be a
> > container, which may not be expected when developing the test.
> > 
> > Now explicitly support that case when there's no real "/machine" object
> > around, then unattached devices will be put under root ("/") rather than
> > "/machine".  Mostly only for this single test case, or for any future test
> > cases when some device needs to be realized before the machine is present.
> > 
> > This shouldn't affect anything else when QEMU runs as an emulator, as that
> > always relies on a real machine being created before realizing any devices.
> > It's because if "/machine" is wrongly created as a container, it'll fail
> > QEMU very soon later on qemu_create_machine() trying to create the real
> > machine, conflicting with the "/machine" container.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/core/qdev.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> > index 5f13111b77..eff297e584 100644
> > --- a/hw/core/qdev.c
> > +++ b/hw/core/qdev.c
> > @@ -475,9 +475,17 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
> >  
> >          if (!obj->parent) {
> >              gchar *name = g_strdup_printf("device[%d]", unattached_count++);
> > +            Object *root = qdev_get_machine();
> >  
> > -            object_property_add_child(container_get(qdev_get_machine(),
> > -                                                    "/unattached"),
> > +            /*
> > +             * We could have qdev test cases trying to realize() a device
> > +             * without machine created.  In that case we use the root.
> > +             */
> > +            if (!root) {
> > +                root = object_get_root();
> > +            }
> 
> IMHO modifying the qdev.c code to workaround limitations of the test suite
> is not a nice approach. Even if it is more work, I'd say it is better to
> properly stub a /machine object in the test case, so that it complies with
> expectations of qdev.c

Yeah I can give it a shot.

Meanwhile I just noticed that the assertion I added in the last patch may
be too strict, considering that "/machine" is actually not a container
object itself..  I think no test crashed because all such users used
qdev_get_machine() as the 1st parameter to container_get() to start the
walk, then the container_get() won't walk the "/machine" object itself, but
anything afterwards.

I still think it's possible some other objects got to be used as a
container even if it's not TYPE_CONTAINER, like the machine object.

So maybe.. what we really want is not "assert everything is a container",
as fundamentally every object "can" be a container itself.. supporting
childs in the properties.  What we really need might be that we never try
to silently create containers where it shouldn't..

I'll need to rethink about the series a bit.

-- 
Peter Xu


