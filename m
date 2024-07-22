Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AC3C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqxV-0001bM-Il; Mon, 22 Jul 2024 07:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sVqxS-0001T4-2E
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sVqxP-0003ix-LX
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721646710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MB8xb3cQYchdpKTNa/Pfy7T0uzEe3LRRpxdyzALN0mw=;
 b=M6zJI5NEYL9mjQpl4d6xa9aWvU9WNv8q6K4yaJH1GUaHdaTUisHIx/S50emaL8QY4os6Q6
 9KnESgyp0/9VBjsbTxPMiyWB7ARN1+9xv7YYltslJ7FDmdIkj+fEWkYSNRqBFdy4Hh0QyN
 YPbgb27ya1d9J1YQ5ad86/x3DMdYAGI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-nGBF0J03PzGiDffPM-_mDQ-1; Mon, 22 Jul 2024 07:11:49 -0400
X-MC-Unique: nGBF0J03PzGiDffPM-_mDQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6688c44060fso112716977b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646709; x=1722251509;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MB8xb3cQYchdpKTNa/Pfy7T0uzEe3LRRpxdyzALN0mw=;
 b=iOTPfyWdF/HE34YnheFXqu/JHDRCY77qPseRObujekx5jhy2jHkA2q0gnUwHU5eyGA
 nIVwYnO6UEAoot2JrpMmrupgEO9SBrDt9kqjFPOylpqWQHfSOioRJlk1IYUVn/mlVigU
 qrAIeOEl+jRmOdkauLZ42e2t/ZfVrt/FOCy7EnCDnNKlo1wl+NFJhH5vaNmwvwPYLi7w
 HAf44h+y89pPuLGELeUt7G4OXr/Lhl4J7pRr9xaOUDmHxSrx9cW1KY6AdYMPqCOh7kuq
 zP7Il9Bs36QGYezMxivLql/zvcTRCcHFFAvsxqrGemZFylbS4OTxkWKTkCmt0aYCFskY
 utug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlNcZ+YOAYNHXnMtY8lk+iGIdNPtmyPLJuAvmRjiwsKsSSKZgw9LQjB0L0EhP4YLdIl0cqpBXsCVIg5+XlIp6ip51z4kk=
X-Gm-Message-State: AOJu0YwKmrN6CR6sm+9WNAgOxLvrp91okSJjJHcXJ1GzlIxtbYWbKl2/
 /4+FNEoVWK9KAbURJgPaSv/OQUKt1V9vx4fiXiHTy0qyolPOmG5wp3zV5Dg5BlN8mhKhi7mNfto
 y3LF84ugndOtC/uay6xEi2p1iwW9gsSk2+OGbVV3Yd8FQr/9mf3Co+6/xj7U80y+33HJTzH1qfn
 Mcp89Mrsciu8Y5OEaO4PWERsWUL2Q=
X-Received: by 2002:a05:690c:460c:b0:65f:645a:b3c4 with SMTP id
 00721157ae682-66ada52c0ebmr68654087b3.32.1721646709004; 
 Mon, 22 Jul 2024 04:11:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMwjxAdgWyzGQMKzT0m9Vw43++FUzxhNdxmx1F4qwoHQD+8GrTCN7F5ma7W16soDFk2v4D45bg++t/gTB14u4=
X-Received: by 2002:a05:690c:460c:b0:65f:645a:b3c4 with SMTP id
 00721157ae682-66ada52c0ebmr68653797b3.32.1721646708274; Mon, 22 Jul 2024
 04:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240710125522.4168043-1-jonah.palmer@oracle.com>
 <20240710125522.4168043-7-jonah.palmer@oracle.com>
 <20240720151557-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240720151557-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Jul 2024 13:11:09 +0200
Message-ID: <CAJaqyWesMrixZo+duwLqNUq311QpCvFJOWob8nnprYeK47T44g@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virtio: Add VIRTIO_F_IN_ORDER property definition
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Jul 20, 2024 at 9:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Jul 10, 2024 at 08:55:19AM -0400, Jonah Palmer wrote:
> > Extend the virtio device property definitions to include the
> > VIRTIO_F_IN_ORDER feature.
> >
> > The default state of this feature is disabled, allowing it to be
> > explicitly enabled where it's supported.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>
>
> Given release is close, it's likely wise.
> However, I think we should flip the default in the future
> release.
>

Should we post a new version with v9.2 tag enabling it?

> > ---
> >  include/hw/virtio/virtio.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index fdc827f82e..d2a1938757 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -373,7 +373,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >      DEFINE_PROP_BIT64("packed", _state, _field, \
> >                        VIRTIO_F_RING_PACKED, false), \
> >      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> > -                      VIRTIO_F_RING_RESET, true)
> > +                      VIRTIO_F_RING_RESET, true), \
> > +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> > +                      VIRTIO_F_IN_ORDER, false)
> >
> >  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> >  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> > --
> > 2.43.5
>


