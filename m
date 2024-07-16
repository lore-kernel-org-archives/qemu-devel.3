Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D636C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTke0-0003ic-3S; Tue, 16 Jul 2024 12:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sTkdw-0003UX-Ou
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sTkdr-0000WA-VE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 12:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721145781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yB4AxlEEPuHJDRDMcxc71g4V/TGK3tF7rWkhub3hXRo=;
 b=DxecuAs1KtbREytgegA9lRfQv3jrch1sA1JRqilPcyXgsulqTMj/MPtvzTHWQpo4Cxt8JX
 yBMseZCWHhQxrLq50+6kyEnVIASHgr42ypgtKiFUC759k6PWiMbbW3TyavyX3mqE4x9CQg
 WU6W/buNcWs+EN4120dUvvznS0GQHas=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-lf-xQHAMPKGPeDFvFwROjQ-1; Tue, 16 Jul 2024 12:02:59 -0400
X-MC-Unique: lf-xQHAMPKGPeDFvFwROjQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e03b3f48c65so10152713276.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 09:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721145778; x=1721750578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yB4AxlEEPuHJDRDMcxc71g4V/TGK3tF7rWkhub3hXRo=;
 b=Mh7pJ/nmCq9VkTeena2HcByhWb/I6RhPyE5hlZI4yJaJvT1PXlwxSILuGwzcgdKYBS
 ViIXSRS/kjVfkhzu5Ggma6EC9fkE9A3UpytSPGzx/eFzJmJr9Qsa5rnFgtRBMPoWPDn7
 Gc6RS7VOQ3LZokgOXYiDDH4Diahxsww5/sfOLGRuLfWXz40o9KfX4+wqW9USgoHo0OkZ
 5Ayo8aWoqIanuS7BkH/GWJfLZotIH2Dy1CvkgyZqPS43R/5xS2i8iDv0an7MuW/EFL+Q
 qUoVpSNo8eiA+MBGvj4SU8DVQj8dSJMg9KzJdXisx97kwG7GRkJgH3S/b+01GGZBA6To
 dTlg==
X-Gm-Message-State: AOJu0YxfokOxYlTy1FiubNiXUw8Awb7SfJLJvCmzhdB7JEIt1C1VDppm
 UPaZVQ71pPK5lrHhz/9pE9G9UIEuz5y5FKDNtFfMvQNPgOo8L9g7Tf7KHSTUFB8cdIRr45c42PI
 p+OE0bf/6uIlDTZ8egHukA6TyiFDLpyF7SdlCdU8p+nbsxIYOe6zlhAwYuyk6g/fe4aX7ZFoCi8
 bQiy/ZJsCfEUJaB+PcW0hfZOdL8k8=
X-Received: by 2002:a05:6902:102f:b0:e03:2bfc:b1f0 with SMTP id
 3f1490d57ef6-e05d56b75e7mr2975067276.16.1721145778516; 
 Tue, 16 Jul 2024 09:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Iq1Ws3ktvWKMo5AAm81KxwgMZNuwhzhVsP1bQYUODiB7PA4K3PT+b8zGPFbXD7YJrO8C8x3VZcfbWBdxQOo=
X-Received: by 2002:a05:6902:102f:b0:e03:2bfc:b1f0 with SMTP id
 3f1490d57ef6-e05d56b75e7mr2975029276.16.1721145778053; Tue, 16 Jul 2024
 09:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240715095939.72492-1-zhao1.liu@intel.com>
 <20240715095939.72492-2-zhao1.liu@intel.com>
 <CAJaqyWcRv53hNYXT31tZ9M317OTBsxSgQ5bJvo1y-E=VoVS24g@mail.gmail.com>
 <ZpXnKCoz/7hRJZ6+@intel.com>
In-Reply-To: <ZpXnKCoz/7hRJZ6+@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 16 Jul 2024 18:02:22 +0200
Message-ID: <CAJaqyWdP_xuU6q_cLeq1tHx5Hjd=5VJ85Rq8mT7DRpm=Q1EKiw@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vdpa-dev: Check returned value instead of
 dereferencing @errp
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 16, 2024 at 5:05=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> On Mon, Jul 15, 2024 at 11:01:08PM +0200, Eugenio Perez Martin wrote:
> > Date: Mon, 15 Jul 2024 23:01:08 +0200
> > From: Eugenio Perez Martin <eperezma@redhat.com>
> > Subject: Re: [PATCH] hw/virtio/vdpa-dev: Check returned value instead o=
f
> >  dereferencing @errp
> >
> > On Mon, Jul 15, 2024 at 11:45=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com>=
 wrote:
> > >
> > > As the comment in qapi/error, dereferencing @errp requires
> > > ERRP_GUARD():
> > >
> > > * =3D Why, when and how to use ERRP_GUARD() =3D
> > > *
> > > * Without ERRP_GUARD(), use of the @errp parameter is restricted:
> > > * - It must not be dereferenced, because it may be null.
> > > ...
> > > * ERRP_GUARD() lifts these restrictions.
> > > *
> > > * To use ERRP_GUARD(), add it right at the beginning of the function.
> > > * @errp can then be used without worrying about the argument being
> > > * NULL or &error_fatal.
> > > *
> > > * Using it when it's not needed is safe, but please avoid cluttering
> > > * the source with useless code.
> > >
> > > Though vhost_vdpa_device_realize() is called at DeviceClass.realize()
> > > context and won't get NULL @errp, it's still better to follow the
> > > requirement to add the ERRP_GUARD().
> > >
> > > But qemu_open() and vhost_vdpa_device_get_u32()'s return values can
> > > distinguish between successful and unsuccessful calls, so check the
> > > return values directly without dereferencing @errp, which eliminates
> > > the need of ERRP_GUARD().
> > >
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: "Eugenio P=C3=A9rez" <eperezma@redhat.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > ---
> > >  hw/virtio/vdpa-dev.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> > > index 64b96b226c39..7b439efdc1d3 100644
> > > --- a/hw/virtio/vdpa-dev.c
> > > +++ b/hw/virtio/vdpa-dev.c
> > > @@ -50,6 +50,7 @@ vhost_vdpa_device_get_u32(int fd, unsigned long int=
 cmd, Error **errp)
> > >
> > >  static void vhost_vdpa_device_realize(DeviceState *dev, Error **errp=
)
> > >  {
> > > +    ERRP_GUARD();
> >
> > Good catch, thank you! But removing the err dereferencing eliminates
> > the need for ERRP_GUARD(), doesn't it?
> >
>
> Thanks Eugenio! You're right and I forgot to delete it. I'll post a new
> version.
>
>

Good! With that removed,

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!


