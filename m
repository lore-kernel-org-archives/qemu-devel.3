Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249D4C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPsu-0002wY-VC; Tue, 05 Mar 2024 03:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPsm-0002sD-3k
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:10:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rhPsj-0003nK-U4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709626231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z3adD3uiPjEOwLSm8EeWzBQaHJetS1oLKIdTLsoeUyY=;
 b=CP3LGvJDclj3R9UQCAmTiXl1dZg0Gny9LMKbM75+FLH2dNBzHlLU9xjjoej66ZJsakq9EP
 4mubv1I8vohCZu9Ule8WTmomPTcHVdXewlDX0sID+cGEjyf+7TwLPItU7C+EtwHgQMGWof
 6Rupa/o/HHFGxUIv3hsNvHVEGj/cwFo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-XzvoO4OSOymDidvsgIZECg-1; Tue, 05 Mar 2024 03:10:30 -0500
X-MC-Unique: XzvoO4OSOymDidvsgIZECg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-609a1063919so9338417b3.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709626230; x=1710231030;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3adD3uiPjEOwLSm8EeWzBQaHJetS1oLKIdTLsoeUyY=;
 b=gNyIOlIpcy9CB9ZwgjrsMzy4hj51wgQXLwADg9xgi+Xg8vLnFRu2zLzwATuzUjAWPi
 +2U/na52G+i/bIUs2LJVy7Gqi8ITjaU6MZE+t7iM4z1zWasPEkvAIDr3L1yq9Ubp727Q
 /lUidRRZfwARreb9VQB3YiOXa1K0RGN60XtOQ1Z9YUP9U6YEUjHedjYTn81AmK30i9uy
 7dc+0WFJN3osqgl38ZcFCAQm5xyI0yQsIkJHniSWlmLqLoGmnaikMrLKyV74uk8TpewD
 wbwOYX7oq1Zk6L16qSSbqODyQ7MsKtxm2UuxQissCb1Tdi9ZVRRXvZWFgHmpXbsP+z48
 bdAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiOIDTyzXdb3fve6KExBOSOkMmbI3Y7ZHvf5+feNBFOSLwmYtHC2zIrAkXasILdh3GS8OL7YCjk/NErROQLKiaE6jdliY=
X-Gm-Message-State: AOJu0YxJAFoYU0wmcVuOzNQit+WAl7gwxknDDBVxh2hEEZw0GpKzDhwG
 dHbIH4QLRwmqEFeHNNy1pAJBonzniHgHrWUDJhO1IQOjVamzc29VHb97nmUtfoLJ2G1GvssoSh2
 09xpgZgcbzO24r+q5fb5WaKC5iBn8lUyvG+qSfQE+N3i238WA4c6VKXpuufm5wFftXZJ5m46jLX
 vtOQUquMcp4egHL3beH5ruJ1UI85c=
X-Received: by 2002:a0d:fb83:0:b0:609:716a:4cb5 with SMTP id
 l125-20020a0dfb83000000b00609716a4cb5mr12770038ywf.12.1709626230034; 
 Tue, 05 Mar 2024 00:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwOB264u5Z7CcsO/tA8R/hXv04MCoxPMXJP4LJsfSSpWR9z+Aj4edkjgOLwZm2se7jgazvgkHxvBCURqqDpZw=
X-Received: by 2002:a0d:fb83:0:b0:609:716a:4cb5 with SMTP id
 l125-20020a0dfb83000000b00609716a4cb5mr12770014ywf.12.1709626229796; Tue, 05
 Mar 2024 00:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20240301134330.4191007-1-jonah.palmer@oracle.com>
 <CAJaqyWfD96Dh9gVavzC22KuaG4bwJ0m7sbWOsy9fR4y1HJ3-Gg@mail.gmail.com>
 <PH0PR13MB56827829C8502484EACF080D88222@PH0PR13MB5682.namprd13.prod.outlook.com>
In-Reply-To: <PH0PR13MB56827829C8502484EACF080D88222@PH0PR13MB5682.namprd13.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 5 Mar 2024 09:09:54 +0100
Message-ID: <CAJaqyWdr5PyxNJ2D_HMk8U2xEpfPTebi4d91V3ONs91yNibwOw@mail.gmail.com>
Subject: Re: [RFC 0/8] virtio,vhost: Add VIRTIO_F_NOTIFICATION_DATA support
To: Xinying Yu <xinying.yu@nephogine.com>
Cc: Wentao Jia <wentao.jia@nephogine.com>,
 Rick Zhong <zhaoyong.zhong@nephogine.com>, 
 Jonah Palmer <jonah.palmer@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, 
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, 
 "raphael@enfabrica.net" <raphael@enfabrica.net>,
 "kwolf@redhat.com" <kwolf@redhat.com>, 
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, 
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>, 
 "thuth@redhat.com" <thuth@redhat.com>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "david@redhat.com" <david@redhat.com>, 
 "iii@linux.ibm.com" <iii@linux.ibm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, 
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, 
 "virtio-fs@lists.linux.dev" <virtio-fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 5, 2024 at 4:21=E2=80=AFAM Xinying Yu <xinying.yu@nephogine.com=
> wrote:
>
> Of course,  I am glad to do.  And I need to clarify that our use case onl=
y support VIRTIO_F_NOTIFICATION_DATA  transport feature on DPDK vDPA framew=
ork which the backend type is NET_CLIENT_DRIVER_VHOST_USER and use user_fea=
ture_bits. So the new feature add on vdpa_feature_bits  will not under veri=
fied in our case.  Not sure this meets your expectations?

As long as the driver keeps using notification data it is not able to
tell the difference between one scenario or another, so yes.

> One more thing, I would ask how do  I get the full series patch? Do I cop=
y the RFC line by line from this link[1]?
>

lore.kernel.org is a good alternative as Thomas mentioned. Another
good one IMO is b4, which allows you to download the series and apply
with "git am" too using "b4 mbox
<20240301134330.4191007-1-jonah.palmer@oracle.com>" (untested).

https://pypi.org/project/b4/

Thanks!

> Thanks,
> Xinying
>
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg00090.htm=
l
>
> ________________________________
> From: Eugenio Perez Martin <eperezma@redhat.com>
> Sent: Saturday, March 2, 2024 4:32 AM
> To: Wentao Jia <wentao.jia@nephogine.com>; Rick Zhong <zhaoyong.zhong@nep=
hogine.com>; Xinying Yu <xinying.yu@nephogine.com>
> Cc: Jonah Palmer <jonah.palmer@oracle.com>; qemu-devel@nongnu.org <qemu-d=
evel@nongnu.org>; mst@redhat.com <mst@redhat.com>; jasowang@redhat.com <jas=
owang@redhat.com>; si-wei.liu@oracle.com <si-wei.liu@oracle.com>; boris.ost=
rovsky@oracle.com <boris.ostrovsky@oracle.com>; raphael@enfabrica.net <raph=
ael@enfabrica.net>; kwolf@redhat.com <kwolf@redhat.com>; hreitz@redhat.com =
<hreitz@redhat.com>; pasic@linux.ibm.com <pasic@linux.ibm.com>; borntraeger=
@linux.ibm.com <borntraeger@linux.ibm.com>; farman@linux.ibm.com <farman@li=
nux.ibm.com>; thuth@redhat.com <thuth@redhat.com>; richard.henderson@linaro=
.org <richard.henderson@linaro.org>; david@redhat.com <david@redhat.com>; i=
ii@linux.ibm.com <iii@linux.ibm.com>; cohuck@redhat.com <cohuck@redhat.com>=
; pbonzini@redhat.com <pbonzini@redhat.com>; fam@euphon.net <fam@euphon.net=
>; stefanha@redhat.com <stefanha@redhat.com>; qemu-block@nongnu.org <qemu-b=
lock@nongnu.org>; qemu-s390x@nongnu.org <qemu-s390x@nongnu.org>; virtio-fs@=
lists.linux.dev <virtio-fs@lists.linux.dev>
> Subject: Re: [RFC 0/8] virtio,vhost: Add VIRTIO_F_NOTIFICATION_DATA suppo=
rt
>
> Hi Wentao / Rick / Xinying Yu,
>
> Would it work for you to test this series on your use cases, so we
> make sure everything works as expected?
>
> Thanks!
>
> On Fri, Mar 1, 2024 at 2:44=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
> >
> > The goal of these patches are to add support to a variety of virtio and
> > vhost devices for the VIRTIO_F_NOTIFICATION_DATA transport feature. Thi=
s
> > feature indicates that a driver will pass extra data (instead of just a
> > virtqueue's index) when notifying the corresponding device.
> >
> > The data passed in by the driver when this feature is enabled varies in
> > format depending on if the device is using a split or packed virtqueue
> > layout:
> >
> >  Split VQ
> >   - Upper 16 bits: last_avail_idx
> >   - Lower 16 bits: virtqueue index
> >
> >  Packed VQ
> >   - Upper 16 bits: 1-bit wrap counter & 15-bit last_avail_idx
> >   - Lower 16 bits: virtqueue index
> >
> > Also, due to the limitations of ioeventfd not being able to carry the
> > extra provided by the driver, ioeventfd is left disabled for any device=
s
> > using this feature.
> >
> > A significant aspect of this effort has been to maintain compatibility
> > across different backends. As such, the feature is offered by backend
> > devices only when supported, with fallback mechanisms where backend
> > support is absent.
> >
>
> Hi Wentao,
>


