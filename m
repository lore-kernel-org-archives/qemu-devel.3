Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DDBCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 11:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svEBS-0002He-6Z; Mon, 30 Sep 2024 07:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1svEBO-0002CV-Kq
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1svEBN-0000OH-4w
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 07:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727694191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hw8YcsLe/Ag+itjuGnKt5uz/BlTfIkWS1GlmGrTGtOg=;
 b=KZmRHfcJCjO0A0MxhYnCBmlLsGHa/U2gNiSr+EsVnnMogwuSAxvrz6co5OdLtUoyhv8ywn
 6VtxBx4PB/nSgnDPyhl4hp26/0Fkjl6fi/dY0as/KujVi6Z/fEUT4GcECRrXLclL0h+3NO
 y2s9tga9nOFB6YsvD9KTbJiSVzZS2UY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-TtO2ofSsOGqKhtU2ROMI4w-1; Mon, 30 Sep 2024 07:03:10 -0400
X-MC-Unique: TtO2ofSsOGqKhtU2ROMI4w-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6e2317d1cb7so68831597b3.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 04:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727694190; x=1728298990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hw8YcsLe/Ag+itjuGnKt5uz/BlTfIkWS1GlmGrTGtOg=;
 b=Gp8/T+SbAcrr7QmSQJPwaqk5XoPe0/THwAvqwDJcQsCA4tEs/+RZiQybElxivPXRVn
 fzGcCpQ+coAKp9kqt89Dd0lryv7bdYfrpKWn8ZH9IAELaIzrqSU0QwkEZFOVpO1GhBdw
 PQIMLZC46n9rU2ZTnm8z5OFEPWRmezJ9XcQIRLUSoKp3hAPSYFMdRNtq2YRnbCmIEbhc
 e1JqbAcHKib/Y5SUb0SRwbtTbMjV1sGxzuUlMGmXLo/DggPaPpHL3rdaCK4CsDj9kFto
 p64ACyHbbFv3MnrjyXlVBeLAwG2byI99GF0QUqs5n9NBoQfVMLNuhM27P/NFnYiZfwwV
 o5aw==
X-Gm-Message-State: AOJu0Yxtw8e9AK2PjbYaegl/wv6sfytd3UE6XCvfQ2VJr0dpz6c/7M12
 7ogIn2iA21jHgr/eaZfMNhZcoKQEDKS3Rd5e0Ug0sMirjSKIPEi09bXQDZK+l0iU9b2W874xB0e
 BHzhojUD269pWhO0g+8E+Z4grpOiNMVuUVlmXaUFmCu6sMmLSqr7i5egDbYoPHRSoENmad7y4Hg
 oGyU4Ybv2dbhZJmUkn+g0gZ6wvvfA=
X-Received: by 2002:a05:690c:3745:b0:6e2:1a23:7c07 with SMTP id
 00721157ae682-6e24754f0edmr93469037b3.11.1727694189564; 
 Mon, 30 Sep 2024 04:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDG3RXLTkz+bqAr59oZ2OqttjbCpDRpjdfytJdRkRk2lhT7El4n3+MsjN+ildVlMsEXc1gI4MMwLOk7gu9vU0=
X-Received: by 2002:a05:690c:3745:b0:6e2:1a23:7c07 with SMTP id
 00721157ae682-6e24754f0edmr93468707b3.11.1727694189060; Mon, 30 Sep 2024
 04:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-20-marcandre.lureau@redhat.com>
In-Reply-To: <20240930081458.1926382-20-marcandre.lureau@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 30 Sep 2024 13:02:33 +0200
Message-ID: <CAJaqyWf2OAy74jK6yBWiy9fZ-OL=v7V=A-60kViG5K8SM2qJDQ@mail.gmail.com>
Subject: Re: [PATCH v3 19/22] RFC: hw/virtio: a potential leak fix
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 qemu-block@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Eric Blake <eblake@redhat.com>, Hyman Huang <yong.huang@smartx.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 30, 2024 at 10:17=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> vhost_svq_get_buf() may return a VirtQueueElement that should be freed.
>
> It's unclear to me if the vhost_svq_get_buf() call should always return N=
ULL.
>

Continuing conversation of v2,

Yes there are situations where vhost_svq_get_buf can return a valid
buffer here and we could leak memory, so this fixes a bug.

So,

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 3b2beaea24..37aca8b431 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -414,6 +414,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const Vh=
ostShadowVirtqueue *svq,
>      return i;
>  }
>
> +G_GNUC_WARN_UNUSED_RESULT
>  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
>                                             uint32_t *len)
>  {
> @@ -528,6 +529,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size=
_t num)
>      size_t len =3D 0;
>
>      while (num--) {
> +        g_autofree VirtQueueElement *elem =3D NULL;
>          int64_t start_us =3D g_get_monotonic_time();
>          uint32_t r =3D 0;
>
> @@ -541,7 +543,7 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size=
_t num)
>              }
>          } while (true);
>
> -        vhost_svq_get_buf(svq, &r);
> +        elem =3D vhost_svq_get_buf(svq, &r);
>          len +=3D r;
>      }
>
> --
> 2.45.2.827.g557ae147e6
>


