Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41289C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 05:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s77X7-0000AR-Fl; Wed, 15 May 2024 01:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s77W0-000075-HX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 01:49:31 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1s77Vy-0004np-2Z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 01:49:23 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3c9995562a0so2850314b6e.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 22:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715752041; x=1716356841;
 darn=nongnu.org; 
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2mhJk8kOTI1n5O8eoYArEaJFnjT1XkQSdnP3IiQG98=;
 b=Dlb85wIhgsyLxD/x7fyGMC935MwU04rWpQJyY4m0hddW8OxVsP6T44Jl15RR5P2EOv
 XqRTpGal9M8RtiErllYCftA/xM/muujInolPGC19Xfb0CuKSB06+GsUL/6LF/fzzEKkK
 MIcAcAw9OjD03+J5VauUZhephErJPDyj+vXWh78LeoVAJq6mYBsXuRnhEQrvfyEoMIzS
 lqPFbRn4cmfPOF4Dc2L8n49A11WB6OlOurQ82p6waoW2VkjqfkM47LM+2jsK+xy+FEXt
 i5u+ggtTqS1/2OO/CUQIU9JJ95yFvIryeC90GIEA9sMkIgJ3Yv++QGACoYzOZ2hnGMdv
 NYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715752041; x=1716356841;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2mhJk8kOTI1n5O8eoYArEaJFnjT1XkQSdnP3IiQG98=;
 b=soGl9oDYUOhLW2IcFqFLhbTrV+bgKmkiXrQ2+gvy3wZgEA601pRCYhoCENdOZhz7oN
 UEz/1VyENyGhTPsbNMw+kt4FUGrcr3Ta6HbpcHbPCP3nLiLZkVwvx8C2nw1kdXjORjXj
 HLx09EeGh52X4wpgQw8gHpCCFnA8UqNHoSAQRlFeruIgoja87mUGEbe3vbTHnpmOztJl
 ie8WjVFjG4hPdQRllQVvwLVifjYJii6lg4iZmi+kQGGLpmn9BkKcu9mClbw45StntqVQ
 DW/s+/bJSMCAhP5ICNwMDo531CdqICD5KSkbqeTRMhQk2Eevwl/PxMBq5HaFQgUbRGi5
 jUxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo4wVhe8EiYpK7KJuCLUv2zhgqjim6rbwyt7Xpt7IG1/CFmqpbfRpuRVzio/nVDTsKSgh1Nfs4yjkKwzKMXVNnHb46tpI=
X-Gm-Message-State: AOJu0YxjEZC0sx9BhOhpseoAWTOD8RjmHpPsUGYns4BG2wjwnAgEwHUr
 0Eh/lra1oPzXBhy8yLws0y2V3d+zBeBdLHyvDB867vMA2CfowipEPlMk/UCm+0E=
X-Google-Smtp-Source: AGHT+IEfxmdvKnmC2iZV/J+t9VbgUllvyTqLWTbQXp0GNCkw3yZubWdXd0gONZraR6OylQqflXHGRg==
X-Received: by 2002:a05:6808:19a8:b0:3c9:69f2:749c with SMTP id
 5614622812f47-3c9970698b8mr20319113b6e.24.1715752036372; 
 Tue, 14 May 2024 22:47:16 -0700 (PDT)
Received: from smtpclient.apple ([103.172.41.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6340a449f1esm10455452a12.11.2024.05.14.22.47.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 May 2024 22:47:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH v3 2/2] vhost-user: fix lost reconnect again
From: Li Feng <fengli@smartx.com>
In-Reply-To: <CAMDpr=crBG2ViSRSmrmtGQ7gn90XB_QHLdt74EbgG-k2hxiPhg@mail.gmail.com>
Date: Wed, 15 May 2024 13:47:02 +0800
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Yajun Wu <yajunw@nvidia.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BF8DF49-CB9A-4D0A-A994-099A7925DF09@smartx.com>
References: <20240514061239.86461-1-fengli@smartx.com>
 <20240514061239.86461-3-fengli@smartx.com>
 <CAMDpr=crBG2ViSRSmrmtGQ7gn90XB_QHLdt74EbgG-k2hxiPhg@mail.gmail.com>
To: Raphael Norwitz <raphael@enfabrica.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=fengli@smartx.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: 29
X-Spam_score: 2.9
X-Spam_bar: ++
X-Spam_report: (2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> 2024=E5=B9=B45=E6=9C=8814=E6=97=A5 21:58=EF=BC=8CRaphael Norwitz =
<raphael@enfabrica.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Code looks good. Just a question on the error case you're trying to =
fix.
>=20
> On Tue, May 14, 2024 at 2:12=E2=80=AFAM Li Feng <fengli@smartx.com> =
wrote:
>>=20
>> When the vhost-user is reconnecting to the backend, and if the =
vhost-user fails
>> at the get_features in vhost_dev_init(), then the reconnect will fail
>> and it will not be retriggered forever.
>>=20
>> The reason is:
>> When the vhost-user fail at get_features, the vhost_dev_cleanup will =
be called
>> immediately.
>>=20
>> vhost_dev_cleanup calls 'memset(hdev, 0, sizeof(struct vhost_dev))'.
>>=20
>> The reconnect path is:
>> vhost_user_blk_event
>>   vhost_user_async_close(.. vhost_user_blk_disconnect ..)
>>     qemu_chr_fe_set_handlers <----- clear the notifier callback
>>       schedule vhost_user_async_close_bh
>>=20
>> The vhost->vdev is null, so the vhost_user_blk_disconnect will not be
>> called, then the event fd callback will not be reinstalled.
>>=20
>> With this patch, the vhost_user_blk_disconnect will call the
>> vhost_dev_cleanup() again, it's safe.
>>=20
>> In addition, the CLOSE event may occur in a scenario where connected =
is false.
>> At this time, the event handler will be cleared. We need to ensure =
that the
>> event handler can remain installed.
>=20
> Following on from the prior patch, why would "connected" be false when
> a CLOSE event happens?

In OPEN event handling, vhost_user_blk_connect calls vhost_dev_init and =
encounters
an error such that s->connected remains false.
Next, after the CLOSE event arrives, it is found that s->connected is =
false, so nothing
is done, but the event handler will be cleaned up in =
`vhost_user_async_close`
before the CLOSE event is executed.

Thanks,
Li

>=20
>>=20
>> All vhost-user devices have this issue, including =
vhost-user-blk/scsi.
>>=20
>> Fixes: 71e076a07d ("hw/virtio: generalise CHR_EVENT_CLOSED handling")
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>> hw/block/vhost-user-blk.c   |  3 ++-
>> hw/scsi/vhost-user-scsi.c   |  3 ++-
>> hw/virtio/vhost-user-base.c |  3 ++-
>> hw/virtio/vhost-user.c      | 10 +---------
>> 4 files changed, 7 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>> index 41d1ac3a5a..c6842ced48 100644
>> --- a/hw/block/vhost-user-blk.c
>> +++ b/hw/block/vhost-user-blk.c
>> @@ -353,7 +353,7 @@ static void vhost_user_blk_disconnect(DeviceState =
*dev)
>>     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
>>=20
>>     if (!s->connected) {
>> -        return;
>> +        goto done;
>>     }
>>     s->connected =3D false;
>>=20
>> @@ -361,6 +361,7 @@ static void vhost_user_blk_disconnect(DeviceState =
*dev)
>>=20
>>     vhost_dev_cleanup(&s->dev);
>>=20
>> +done:
>>     /* Re-instate the event handler for new connections */
>>     qemu_chr_fe_set_handlers(&s->chardev, NULL, NULL, =
vhost_user_blk_event,
>>                              NULL, dev, NULL, true);
>> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>> index 48a59e020e..b49a11d23b 100644
>> --- a/hw/scsi/vhost-user-scsi.c
>> +++ b/hw/scsi/vhost-user-scsi.c
>> @@ -181,7 +181,7 @@ static void =
vhost_user_scsi_disconnect(DeviceState *dev)
>>     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
>>=20
>>     if (!s->connected) {
>> -        return;
>> +        goto done;
>>     }
>>     s->connected =3D false;
>>=20
>> @@ -189,6 +189,7 @@ static void =
vhost_user_scsi_disconnect(DeviceState *dev)
>>=20
>>     vhost_dev_cleanup(&vsc->dev);
>>=20
>> +done:
>>     /* Re-instate the event handler for new connections */
>>     qemu_chr_fe_set_handlers(&vs->conf.chardev, NULL, NULL,
>>                              vhost_user_scsi_event, NULL, dev, NULL, =
true);
>> diff --git a/hw/virtio/vhost-user-base.c =
b/hw/virtio/vhost-user-base.c
>> index 4b54255682..11e72b1e3b 100644
>> --- a/hw/virtio/vhost-user-base.c
>> +++ b/hw/virtio/vhost-user-base.c
>> @@ -225,13 +225,14 @@ static void vub_disconnect(DeviceState *dev)
>>     VHostUserBase *vub =3D VHOST_USER_BASE(vdev);
>>=20
>>     if (!vub->connected) {
>> -        return;
>> +        goto done;
>>     }
>>     vub->connected =3D false;
>>=20
>>     vub_stop(vdev);
>>     vhost_dev_cleanup(&vub->vhost_dev);
>>=20
>> +done:
>>     /* Re-instate the event handler for new connections */
>>     qemu_chr_fe_set_handlers(&vub->chardev,
>>                              NULL, NULL, vub_event,
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index c929097e87..c407ea8939 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -2781,16 +2781,8 @@ typedef struct {
>> static void vhost_user_async_close_bh(void *opaque)
>> {
>>     VhostAsyncCallback *data =3D opaque;
>> -    struct vhost_dev *vhost =3D data->vhost;
>>=20
>> -    /*
>> -     * If the vhost_dev has been cleared in the meantime there is
>> -     * nothing left to do as some other path has completed the
>> -     * cleanup.
>> -     */
>> -    if (vhost->vdev) {
>> -        data->cb(data->dev);
>> -    }
>> +    data->cb(data->dev);
>>=20
>>     g_free(data);
>> }
>> --
>> 2.45.0
>>=20


