Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48135C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYqQo-0001IT-7D; Fri, 17 Jan 2025 12:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYqQm-0001IJ-Pb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tYqQj-0002Cu-5R
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737136007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I1l/AiEJI0wy8osr2BAV7EJXZUzxgnTvqoIhSz//jFk=;
 b=aWJWGNi15xgJZQDFXa5z36Jhct5PH7h3R9cteKJwuUAGvdXeLC8ayDISo0ndekyGq7qV2I
 8i6FT5eGLnLoJ2vQeJpG83yU4GONRaNlL2EjhLx/GlIL0rLeHrWPV2lauaKsZVLC2Qgi9f
 xC/Dr43y3bGDBhr+Sl2OBJO7Go6oE3o=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-upcTxgZlOAGN7xDUh5QPhQ-1; Fri, 17 Jan 2025 12:46:43 -0500
X-MC-Unique: upcTxgZlOAGN7xDUh5QPhQ-1
X-Mimecast-MFC-AGG-ID: upcTxgZlOAGN7xDUh5QPhQ
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6f2515eb3so185305985a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737136003; x=1737740803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1l/AiEJI0wy8osr2BAV7EJXZUzxgnTvqoIhSz//jFk=;
 b=MGfUbBakEkXawFPDRhPyjsTqV/+ArXSe5XoXXaZESmN49E5104PAC+URUuLtxniJ+e
 vE6vpeXUYZctASVVCWm4jcz1zYu7eYqA6faehYO1qnn8crewRWnYZlV1YMy0Cxv6GuZg
 bexSEMoTH9A3Rn/cdRSRQ+bx7xdVlbf8ropE8m1ETw7sZlCp685KCnrQuHQaAt6GoziX
 xi9vexA2cNtN7wPmUDtmGadcmr/Jk3bdrgvrx5xKCYc8prAnqj9cLv1gTeBxgxOAO3cM
 5Q8Oe7rRzzDlyk2SuqFHs+TztVKcuQCIMIZa+4IGnxCz550DtayZ7hxntqtFA8dgk9JF
 MOeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuNFxafLNTs+Z8cEZEbFqWwtEuRZeGYROJdiyLZcoF9F3YyFi8wIjTzXyvtJAY/ISgmWrQG5hMR5dC@nongnu.org
X-Gm-Message-State: AOJu0YyL+StT2QiG6Q32a2Y3d07ozfBI+w5/di9DG3x7nP2aKz5v3F3A
 HaJdA94AJfBAyUsA8JI/m+Y/Y9Aj3IROfyeK/uu3XWrTo/G/FKSXwke2EmednicvwFoFuc4kW7s
 NHfgpJ3CQDZF4uamdMx+BJ+pd3AEdi+hy0qYs1i2RY8c+89c7jfb0
X-Gm-Gg: ASbGncvcv7NiL2ZYGzbAnYASk8SHyt4hUbQ7ZJjGEWxQT9yE6x/4PNtU37GQTlLDdOx
 IgpiI3Up2FDvNwipF6xpDbzIoUuwMMGRSOCURz2Vm0DMAhsBHFdjRC8XjIqnq4FPmykg+I4YyEa
 uiA8g55CXAVmpF+TNrx3tt2iky8OWzytg7yH8qzDqAQixdm5WQWDAh5DKAlYmx8J+IKnmzrdcUX
 3+szxgD6tp9HYfNALl7LD3bWXosiTjIt5vnpa68IyI2EqFkaJtV0/T5HsMqzmJR+qWMh+L12Vl3
 TAmUNxb1IyaD863DzQ==
X-Received: by 2002:a05:6214:2586:b0:6d4:b1e:5418 with SMTP id
 6a1803df08f44-6e1b21c46b2mr57513926d6.33.1737136002731; 
 Fri, 17 Jan 2025 09:46:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8KrAj7C7IM7YY9Y7W+uXkWTmN5V/Fd6eLApQGgsF3ygGVQUTLwyEuyPqghK5G047Fvs8Kww==
X-Received: by 2002:a05:6214:2586:b0:6d4:b1e:5418 with SMTP id
 6a1803df08f44-6e1b21c46b2mr57513366d6.33.1737136002295; 
 Fri, 17 Jan 2025 09:46:42 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc1109esm13563156d6.44.2025.01.17.09.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:46:41 -0800 (PST)
Date: Fri, 17 Jan 2025 12:46:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4qXfgJMAySLFeOm@x1n>
References: <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com>
 <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com>
 <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com>
 <Z4fezdR1ApN8ZLTS@x1n>
 <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com>
 <Z4kYxLsIbzq7jWzz@x1n>
 <627beb0f-e6f7-4733-997b-038b70195485@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <627beb0f-e6f7-4733-997b-038b70195485@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jan 17, 2025 at 03:24:34PM +0900, Akihiko Odaki wrote:
> On 2025/01/16 23:33, Peter Xu wrote:
> > On Thu, Jan 16, 2025 at 02:37:38PM +0900, Akihiko Odaki wrote:
> > > On 2025/01/16 1:14, Peter Xu wrote:
> > > > On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
> > > > > Functionally, the ordering of container/subregion finalization matters if
> > > > > some device tries to a container during finalization. In such a case,
> > > >                         |
> > > >                         ^ something is missing here, feel free to complete this.
> > > 
> > > Oops, I meant: functionally, the ordering of container/subregion
> > > finalization matters if some device tries to use a container during
> > > finalization.
> > 
> > This is true, though if we keep the concept of "all the MRs share the same
> > lifecycle of the owner" idea, another fix of such is simply moving the
> > container access before any detachment of MRs.
> > 
> > > 
> > > > 
> > > > > removing subregions from the container at random timing can result in an
> > > > > unexpected behavior. There is little chance to have such a scenario but we
> > > > > should stay the safe side if possible.
> > > > 
> > > > It sounds like a future feature, and I'm not sure we'll get there, so I
> > > > don't worry that much.  Keeping refcount core idea simple is still very
> > > > attractive to me.  I still prefer we have complete MR refcounting iff when
> > > > necessary.  It's also possible it'll never happen to QEMU.
> > > > 
> > > 
> > > It's not just about the future but also about compatibility with the current
> > > device implementations. I will not be surprised even if the random ordering
> > > of subregion finalization breaks one of dozens of devices we already have.
> > > We should pay attention the details as we are touching the core
> > > infrastructure.
> > 
> > Yes, if we can find any such example that we must follow the order of MR
> > destruction, I think that could justify your approach will be required but
> > not optional.  It's just that per my understanding there should be none,
> > and even if there're very few outliers, it can still be trivially fixed as
> > mentioned above.
> 
> It can be fixed but that means we need auditing the code of devices or wait
> until we get a bug report.

We'd better have a solid example.

And for this specific question, IIUC we can have such problem even if
internal-ref start to use MR refcounts.

It's because we have a not very straightforward way of finalize() an
object, which is freeing all properties before its own finalize()..

static void object_finalize(void *data)
{
    ...
    object_property_del_all(obj);
    object_deinit(obj, ti);
    ...
}

I think it used to be the other way round (which will be easier to
understand to me..), but changed after 76a6e1cc7cc.  It could boil down to
two dependencies: (1) children's unparent() callback wanting to have the
parent being present and valid, and (2) parent's finalize() callback
wanting to have all children being present and valid.  I guess we chose (1)
as of now.

So I suppose it means even with your patch, it won't help either as long as
MRs are properties, and they can already all be gone in a device finalize()
even with your new patch.

From that POV, qdev unrealize() could be a good place for such cleanups
while making sure all properties are present.

> 
> > 
> > My gut feeling is when we need serious MR refcounting (I'd expect due to
> > the current heavy code base it might be easier to start a new project if
> > that's required.. that's why I was thinking maybe it will not happen.. but
> > if it will..), we'll do more than your change, and that also means
> > memory_region_ref() must start to refcount MRs, because a serious MR
> > separate refcounting should mean MR can go on the fly before the owner.
> 
> Actually there is one example: virtio_gpu_virgl_map_resource_blob() in
> hw/display/virtio-gpu-virgl.c creates a MR that can be removed before the
> device. To make this possible, it specifies MRs themselves as their and let
> them refcount without help of the device.

.. I am definitely surprised that we have code that assigns obj->parent to
be itself.

Putting the self parenting aside.. and to the topic: I don't think this is
an example for internal-MR use case?

When the owner is itself, then it's not sharing the owner of the parent MR
(which is b->hostmem in this case, which should probably be owned by
VirtIOGPU object instead).  So IIUC no matter which way we choose on the
current discussion, it won't affect the result.

Not to mention, the MRs are always properly detached always when the
resource is unmapped:

virtio_gpu_virgl_unmap_resource_blob():
        /* memory region owns self res->mr object and frees it by itself */
        memory_region_set_enabled(mr, false);
        memory_region_del_subregion(&b->hostmem, mr);

So from that POV it's a very good citizen.. it doesn't need anything to be
auto detached.

Below can be off topic, but since we're discussing this use case..

My gut feeling is that it can cause trouble at some point having MR itself
as parent.

For example, I will not be surprised that some day QMP command
qom-list-properties provide a --deep pararmeter, then this will hang that
command trying to look at child forever in a loop.

It can easily break in other ways too, e.g. when we add an assertion
anywhere for "obj->parent != obj" (which should really make sense.. from a
object model POV), or when we want to take a ref to parent (for obj->parent
reference) then it'll be a "real" circular reference, comparing to what
we're discussing on auto-detach so far (which is IIUC a pretty "weak"
circular ref; IOW, if del_subregion is always properly done, this patch not
needed).

Meanwhile the other free() overwrite:

    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;

I suppose it can be error prone too whenever we want to provide a common
free() for MRs and this one can be easily overlooked..

I'm not familiar with GPU stuff, but reading it closer I do feel like it's
kind of a slight abuse on all above..

If to stick with "owner shares the same lifecycle for its MRs" idea and fix
all above, IMHO we could make virtio_gpu_virgl_hostmem_region to be a QOM
object, then it can be a proper parent for the MR.

-- 
Peter Xu


