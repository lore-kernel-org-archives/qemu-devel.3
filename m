Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51FDC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 04:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn9bo-0001Z6-0U; Thu, 21 Mar 2024 00:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rn9bi-0001XH-Cx
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 00:00:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rn9bf-0002bn-Jl
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 00:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710993642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoEfbVUA4oeshnBTHztVo9G5+Fh187KCdU5FooIUy5w=;
 b=OKNgGD/x4X6kmwwy4G1RyvKaVDbjvGgu1lth5IZPyojIV7zu0OcEngluZinps/1UHaCzJO
 Bmri4aUQ/r9is+L7I3M2FqSKP37sMZ3w3Q/2z24qYvYrjxrlOIqfp9y/GCKBD9fk/r8T0+
 MoolmWB1aFkiYjTqmnUdgrbZBNs8sD8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-Ok2SLqubNzSTpdFUSPHnHw-1; Thu, 21 Mar 2024 00:00:41 -0400
X-MC-Unique: Ok2SLqubNzSTpdFUSPHnHw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6e6cced0068so514220b3a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 21:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710993640; x=1711598440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoEfbVUA4oeshnBTHztVo9G5+Fh187KCdU5FooIUy5w=;
 b=BxqIcsNWIXJUT7jx6hdUO1LU9T7vgWlzjz/9Ih4gXl6o04b+jVK2l0yhqOG8zVDq5W
 gubgUWAOdCfMLh1RQA9s3a2DcAQ4r1Mi1osoVdSGyZYVXbS7Q6dHbCPePrxA1m9qXQu/
 wdpBIfSSEyl3U8nRkH3bMRAWcC/iOaDplnimP76C1iMX8X5YUWMnqM8XkX+dw3ETsxsn
 MEXXVSVwoFkpHjbVgEI2Bj5+fRBip/3V0Ibrs/J9uJ1uMAsCfXxJQWhjX5zIXeFHfhYS
 VY+shoN+StO9KegCtOO27V8lXnZiFjx3mBapzz/SZ6X9FYzDIbet2ypS+qGatevhZPiw
 Vo2w==
X-Gm-Message-State: AOJu0YxNOwP0yTxyb6TemhhrQobjh5uL7p/WVoKKW+v/e2llCAlwvCIq
 uiB9PXR3hwvf+L3B119xhk2T0HWBRZZgjwJhYLM5GKtS/xEMi+xzKKt4tIBAboN9AabdmSFY6Cz
 /kHrQ4/AhyKwDMYn4cESEPnhCqfzvQrCXBdtR7KSG9yOGb1PQa8UFW3nFacUVliuijIGUGXJGeR
 pHYtTk6MWnWIyfyWVnkiPRUWZN3gv6eKYPOy260Q==
X-Received: by 2002:a17:902:eb45:b0:1dd:96ca:e1ae with SMTP id
 i5-20020a170902eb4500b001dd96cae1aemr3931971pli.69.1710993639635; 
 Wed, 20 Mar 2024 21:00:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOkaPi333lSGZOdk7yAa/SfSJVXPogeIZsv313fjs2EslYIoUTcUR/QX+FCjylB5lhD84A3Xh4RWSRIQptRdI=
X-Received: by 2002:a05:6a20:a903:b0:1a3:3e30:a7e6 with SMTP id
 cd3-20020a056a20a90300b001a33e30a7e6mr3393745pzb.59.1710993199087; Wed, 20
 Mar 2024 20:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
 <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
 <CACGkMEvjB45RzonvWMQ=OnDpm5M04u6ab6tT7b0=sMsEyBB-Vg@mail.gmail.com>
 <7c118fa7-2288-45f1-aa67-5bf650d65b51@oracle.com>
 <CACGkMEsHY+1752e0tt58uQevUkoAcSRgZRNoMPPYgXZ5SEkWMw@mail.gmail.com>
 <318cef20-96a6-4476-a8f5-1653b1465a69@oracle.com>
In-Reply-To: <318cef20-96a6-4476-a8f5-1653b1465a69@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 11:53:07 +0800
Message-ID: <CACGkMEsLXLfz_sA2adX6ZF0wcNmKfeoDq4KD-X5Q2oK47ANw0Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] vhost: dirty log should be per backend type
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 joao.m.martins@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Mar 21, 2024 at 4:29=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 3/19/2024 8:25 PM, Jason Wang wrote:
> > On Tue, Mar 19, 2024 at 6:06=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 3/17/2024 8:20 PM, Jason Wang wrote:
> >>> On Sat, Mar 16, 2024 at 2:33=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>>
> >>>> On 3/14/2024 8:50 PM, Jason Wang wrote:
> >>>>> On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@orac=
le.com> wrote:
> >>>>>> There could be a mix of both vhost-user and vhost-kernel clients
> >>>>>> in the same QEMU process, where separate vhost loggers for the
> >>>>>> specific vhost type have to be used. Make the vhost logger per
> >>>>>> backend type, and have them properly reference counted.
> >>>>> It's better to describe what's the advantage of doing this.
> >>>> Yes, I can add that to the log. Although it's a niche use case, it w=
as
> >>>> actually a long standing limitation / bug that vhost-user and
> >>>> vhost-kernel loggers can't co-exist per QEMU process, but today it's
> >>>> just silent failure that may be ended up with. This bug fix removes =
that
> >>>> implicit limitation in the code.
> >>> Ok.
> >>>
> >>>>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>>>
> >>>>>> ---
> >>>>>> v3->v4:
> >>>>>>      - remove checking NULL return value from vhost_log_get
> >>>>>>
> >>>>>> v2->v3:
> >>>>>>      - remove non-effective assertion that never be reached
> >>>>>>      - do not return NULL from vhost_log_get()
> >>>>>>      - add neccessary assertions to vhost_log_get()
> >>>>>> ---
> >>>>>>     hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++------=
------
> >>>>>>     1 file changed, 33 insertions(+), 12 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>>>> index 2c9ac79..612f4db 100644
> >>>>>> --- a/hw/virtio/vhost.c
> >>>>>> +++ b/hw/virtio/vhost.c
> >>>>>> @@ -43,8 +43,8 @@
> >>>>>>         do { } while (0)
> >>>>>>     #endif
> >>>>>>
> >>>>>> -static struct vhost_log *vhost_log;
> >>>>>> -static struct vhost_log *vhost_log_shm;
> >>>>>> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> >>>>>> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> >>>>>>
> >>>>>>     /* Memslots used by backends that support private memslots (wi=
thout an fd). */
> >>>>>>     static unsigned int used_memslots;
> >>>>>> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhos=
t_dev *dev,
> >>>>>>             r =3D -1;
> >>>>>>         }
> >>>>>>
> >>>>>> +    if (r =3D=3D 0) {
> >>>>>> +        assert(dev->vhost_ops->backend_type =3D=3D backend_type);
> >>>>>> +    }
> >>>>>> +
> >>>>> Under which condition could we hit this?
> >>>> Just in case some other function inadvertently corrupted this earlie=
r,
> >>>> we have to capture discrepancy in the first place... On the other ha=
nd,
> >>>> it will be helpful for other vhost backend writers to diagnose day-o=
ne
> >>>> bug in the code. I feel just code comment here will not be
> >>>> sufficient/helpful.
> >>> See below.
> >>>
> >>>>>     It seems not good to assert a local logic.
> >>>> It seems to me quite a few local asserts are in the same file alread=
y,
> >>>> vhost_save_backend_state,
> >>> For example it has assert for
> >>>
> >>> assert(!dev->started);
> >>>
> >>> which is not the logic of the function itself but require
> >>> vhost_dev_start() not to be called before.
> >>>
> >>> But it looks like this patch you assert the code just a few lines
> >>> above the assert itself?
> >> Yes, that was the intent - for e.g. xxx_ops may contain corrupted
> >> xxx_ops.backend_type already before coming to this
> >> vhost_set_backend_type() function. And we may capture this corrupted
> >> state by asserting the expected xxx_ops.backend_type (to be consistent
> >> with the backend_type passed in),
> > This can happen for all variables. Not sure why backend_ops is special.
> The assert is just checking the backend_type field only. The other op
> fields in backend_ops have similar assert within the op function itself
> also. For e.g. vhost_user_requires_shm_log() and a lot of other
> vhost_user ops have the following:
>
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
>
> vhost_vdpa_vq_get_addr() and a lot of other vhost_vdpa ops have:
>
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);
>
> vhost_kernel ops has similar assertions as well.
>
> The reason why it has to be checked against here is now the callers of
> vhost_log_get(), would pass in dev->vhost_ops->backend_type to the API,
> which are unable to verify the validity of the backend_type by
> themselves. The vhost_log_get() has necessary asserts to make bound
> check for the vhost_log[] or vhost_log_shm[] array, but specific assert
> against the exact backend type in vhost_set_backend_type() will further
> harden the implementation in vhost_log_get() and other backend ops.

As discussed, those assertions are to make sure of the logic
dependencies of other functions. (The assignment of vhost_ops doesn't
happen in those functions).

>
> >
> >> which needs be done in the first place
> >> when this discrepancy is detected. In practice I think there should be
> >> no harm to add this assert, but this will add warranted guarantee to t=
he
> >> current code.
> > For example, such corruption can happen after the assert() so a TOCTOU =
issue.
> Sure, it's best effort only. As pointed out earlier, I think together
> with this, there are other similar asserts already in various backend
> ops, which could be helpful to nail down the earliest point or a
> specific range where things may go wrong in the first place.

Ok, I think I'd leave the decision to Michael.

Thanks

>
> Thanks,
> -Siwei
>
> >
> > Thanks
> >
> >> Regards,
> >> -Siwei
> >>
> >>> dev->vhost_ops =3D &xxx_ops;
> >>>
> >>> ...
> >>>
> >>> assert(dev->vhost_ops->backend_type =3D=3D backend_type)
> >>>
> >>> ?
> >>>
> >>> Thanks
> >>>
> >>>> vhost_load_backend_state,
> >>>> vhost_virtqueue_mask, vhost_config_mask, just to name a few. Why loc=
al
> >>>> assert a problem?
> >>>>
> >>>> Thanks,
> >>>> -Siwei
> >>>>
> >>>>> Thanks
> >>>>>
>


