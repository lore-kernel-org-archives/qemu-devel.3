Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827E9C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmmaY-0000Ug-V5; Tue, 19 Mar 2024 23:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rmmaX-0000UD-3C
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rmmaV-0008Af-AB
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710905156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ebuVTKQrSax4MiNgBHTxKrUWOBy5rxZ2Vt0StZ8nhrQ=;
 b=g+f9xbXM3tJuamzGZbVwLmX6tP4F/58MvsSmi9Q51h4se2xgIoIRDJ1Uhrh/G4syJODmnC
 UQaywqIp1Cvq6nkJXtkUms9b/BYAcgu1vSkDeiS9DUsEEdv6kP/7RfEbI77Pdkq2rqLaYk
 8T56LrIfGVPAzKu9erO9IQUA+ovE7Rk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Zg4V8VHqMTyQrJY8XavfWQ-1; Tue, 19 Mar 2024 23:25:53 -0400
X-MC-Unique: Zg4V8VHqMTyQrJY8XavfWQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6e6bab4b84dso6017119b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710905153; x=1711509953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebuVTKQrSax4MiNgBHTxKrUWOBy5rxZ2Vt0StZ8nhrQ=;
 b=pxA5x6wohydiisDLiZAMiRQPM9JGb5BBysDrS8U8+qwUKlyHt1ig98O1ibnRs4lL0g
 B4EnbVr1SyXkjXk61sSIK0f3KOEnNsoFkdzPHx8rv+bqAVmUjpDok9V1a4CBCZMdKFT8
 Ulgh5RXo9CErqWoO908HO8wsPTwwSu+sGxN+8mAoDNBbj+ygkvroNp6h8IJI+0gxVxa6
 rjHLKtjYcOXjqwyoJx3M+4R5AQU4nOMSvQLqfuQ7CdzxuZXmy/om9NNsvBauMwgsfzPJ
 VD6xorG/i/6Geajpccx7Ymm5LIk873mijf13gBIRQsjp+2PyPKfN+Vy/trbXvRkmJFt5
 nCTg==
X-Gm-Message-State: AOJu0YyYpPVamFHdFJvX4YpbH3kZSbRpPSjgi4AVLGF/Yp/qqk6xXXo/
 WNDtbvBSQG0djBx8toRKUbdsqqSLJUYwZ1bUAK/RNLPKa87yAl9ajBMsT2DLfcoZQ+TbH6RzCZT
 NGVOo+QVt3pLlVsSEs6u4wxb3wK1OtLvJ25zYRit8ZP/oTGHyBpFih3WBmFY8StZgn7sYKLs+8U
 XanQcYrVNbPl5Yo+/Q5jsOK18cWLE=
X-Received: by 2002:a05:6a21:8cc1:b0:1a3:62d9:6ddc with SMTP id
 ta1-20020a056a218cc100b001a362d96ddcmr1177659pzb.34.1710905152690; 
 Tue, 19 Mar 2024 20:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIAtjuP/Jz/jYnxVg0IQ1af+O7BflF1OB6paTbXdAYAN1p4xIH4RIo9tC4oJmI+UQnhN85ZqIMuUlez0KJAKU=
X-Received: by 2002:a05:6a21:8cc1:b0:1a3:62d9:6ddc with SMTP id
 ta1-20020a056a218cc100b001a362d96ddcmr1177639pzb.34.1710905152300; Tue, 19
 Mar 2024 20:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <1710448055-11709-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEt2-naXvHjCcPyQAoSfto44OVaSUqPtg_gvS8-wrhNwZA@mail.gmail.com>
 <9cb9fe47-f173-4cf1-8bc0-01971e47559c@oracle.com>
 <CACGkMEvjB45RzonvWMQ=OnDpm5M04u6ab6tT7b0=sMsEyBB-Vg@mail.gmail.com>
 <7c118fa7-2288-45f1-aa67-5bf650d65b51@oracle.com>
In-Reply-To: <7c118fa7-2288-45f1-aa67-5bf650d65b51@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Mar 2024 11:25:41 +0800
Message-ID: <CACGkMEsHY+1752e0tt58uQevUkoAcSRgZRNoMPPYgXZ5SEkWMw@mail.gmail.com>
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
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 6:06=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 3/17/2024 8:20 PM, Jason Wang wrote:
> > On Sat, Mar 16, 2024 at 2:33=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 3/14/2024 8:50 PM, Jason Wang wrote:
> >>> On Fri, Mar 15, 2024 at 5:39=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> There could be a mix of both vhost-user and vhost-kernel clients
> >>>> in the same QEMU process, where separate vhost loggers for the
> >>>> specific vhost type have to be used. Make the vhost logger per
> >>>> backend type, and have them properly reference counted.
> >>> It's better to describe what's the advantage of doing this.
> >> Yes, I can add that to the log. Although it's a niche use case, it was
> >> actually a long standing limitation / bug that vhost-user and
> >> vhost-kernel loggers can't co-exist per QEMU process, but today it's
> >> just silent failure that may be ended up with. This bug fix removes th=
at
> >> implicit limitation in the code.
> > Ok.
> >
> >>>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >>>>
> >>>> ---
> >>>> v3->v4:
> >>>>     - remove checking NULL return value from vhost_log_get
> >>>>
> >>>> v2->v3:
> >>>>     - remove non-effective assertion that never be reached
> >>>>     - do not return NULL from vhost_log_get()
> >>>>     - add neccessary assertions to vhost_log_get()
> >>>> ---
> >>>>    hw/virtio/vhost.c | 45 +++++++++++++++++++++++++++++++++---------=
---
> >>>>    1 file changed, 33 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >>>> index 2c9ac79..612f4db 100644
> >>>> --- a/hw/virtio/vhost.c
> >>>> +++ b/hw/virtio/vhost.c
> >>>> @@ -43,8 +43,8 @@
> >>>>        do { } while (0)
> >>>>    #endif
> >>>>
> >>>> -static struct vhost_log *vhost_log;
> >>>> -static struct vhost_log *vhost_log_shm;
> >>>> +static struct vhost_log *vhost_log[VHOST_BACKEND_TYPE_MAX];
> >>>> +static struct vhost_log *vhost_log_shm[VHOST_BACKEND_TYPE_MAX];
> >>>>
> >>>>    /* Memslots used by backends that support private memslots (witho=
ut an fd). */
> >>>>    static unsigned int used_memslots;
> >>>> @@ -287,6 +287,10 @@ static int vhost_set_backend_type(struct vhost_=
dev *dev,
> >>>>            r =3D -1;
> >>>>        }
> >>>>
> >>>> +    if (r =3D=3D 0) {
> >>>> +        assert(dev->vhost_ops->backend_type =3D=3D backend_type);
> >>>> +    }
> >>>> +
> >>> Under which condition could we hit this?
> >> Just in case some other function inadvertently corrupted this earlier,
> >> we have to capture discrepancy in the first place... On the other hand=
,
> >> it will be helpful for other vhost backend writers to diagnose day-one
> >> bug in the code. I feel just code comment here will not be
> >> sufficient/helpful.
> > See below.
> >
> >>>    It seems not good to assert a local logic.
> >> It seems to me quite a few local asserts are in the same file already,
> >> vhost_save_backend_state,
> > For example it has assert for
> >
> > assert(!dev->started);
> >
> > which is not the logic of the function itself but require
> > vhost_dev_start() not to be called before.
> >
> > But it looks like this patch you assert the code just a few lines
> > above the assert itself?
> Yes, that was the intent - for e.g. xxx_ops may contain corrupted
> xxx_ops.backend_type already before coming to this
> vhost_set_backend_type() function. And we may capture this corrupted
> state by asserting the expected xxx_ops.backend_type (to be consistent
> with the backend_type passed in),

This can happen for all variables. Not sure why backend_ops is special.

> which needs be done in the first place
> when this discrepancy is detected. In practice I think there should be
> no harm to add this assert, but this will add warranted guarantee to the
> current code.

For example, such corruption can happen after the assert() so a TOCTOU issu=
e.

Thanks

>
> Regards,
> -Siwei
>
> >
> > dev->vhost_ops =3D &xxx_ops;
> >
> > ...
> >
> > assert(dev->vhost_ops->backend_type =3D=3D backend_type)
> >
> > ?
> >
> > Thanks
> >
> >> vhost_load_backend_state,
> >> vhost_virtqueue_mask, vhost_config_mask, just to name a few. Why local
> >> assert a problem?
> >>
> >> Thanks,
> >> -Siwei
> >>
> >>> Thanks
> >>>
>


