Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CD7C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwlml-00084E-O5; Wed, 19 Aug 2026 15:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwlmj-000840-PS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwlmi-00037z-Ds
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787167031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8WUHk4yUUZdBzc4YHEJEfNH9Mn6TQsHqPnYNGnr9iqc=;
 b=DNNQVXXSPsZDnZLe6FsKV8ABH7oo2wI/nRY/TTwKzZ9Wq7EPrG9oBrJl2vH0W/FOuMD7wz
 DS8q6Da9xhgTl30dVQz0lcKeJGNA5O8CxseLDf+ShKipDsZW89R2kkVttAeq53Ra1E/JY+
 ZPeldCskLX5KE+uASldaxLHypUZJfEQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-UxxPfyd0NeW2Sc9Zu6ColQ-1; Wed,
 19 Aug 2026 15:17:02 -0400
X-MC-Unique: UxxPfyd0NeW2Sc9Zu6ColQ-1
X-Mimecast-MFC-AGG-ID: UxxPfyd0NeW2Sc9Zu6ColQ_1787167021
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2A671801311; Wed, 19 Aug 2026 19:16:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D26B180034C; Wed, 19 Aug 2026 19:16:57 +0000 (UTC)
Date: Wed, 19 Aug 2026 15:16:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V12 07/15] virtio-vq-mapping: track iothread-vq-mapping
 references using device path
Message-ID: <20260819191657.GF222512@fedora>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-8-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+IX8647Ob/JqdU18"
Content-Disposition: inline
In-Reply-To: <20260814174830.1691540-8-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--+IX8647Ob/JqdU18
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 01:48:21AM +0800, Zhang Chen wrote:
> diff --git a/hw/virtio/iothread-vq-mapping.c b/hw/virtio/iothread-vq-mapp=
ing.c
> index 55ce62986c..1859d39630 100644
> --- a/hw/virtio/iothread-vq-mapping.c
> +++ b/hw/virtio/iothread-vq-mapping.c
> @@ -77,6 +77,7 @@ bool iothread_vq_mapping_apply(
>          IOThreadVirtQueueMappingList *list,
>          AioContext **vq_aio_context,
>          uint16_t num_queues,
> +        char *holder,

const char * is clearer. It indicates that this function doesn't modify
or free its argument (making ownership clear).

>          Error **errp)
>  {
>      IOThreadVirtQueueMappingList *node;
> @@ -93,10 +94,13 @@ bool iothread_vq_mapping_apply(
> =20
>      for (node =3D list; node; node =3D node->next) {
>          IOThread *iothread =3D iothread_by_id(node->value->iothread);
> -        AioContext *ctx =3D iothread_get_aio_context(iothread);
> +        const IOThreadHolder io_holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path =3D holder,
> +        };
> =20
> -        /* Released in virtio_blk_vq_aio_context_cleanup() */
> -        object_ref(OBJECT(iothread));
> +        AioContext *ctx =3D iothread_ref_and_get_aio_context(iothread,
> +                                                           &io_holder);
> =20
>          if (node->value->vqs) {
>              uint16List *vq;
> @@ -120,13 +124,19 @@ bool iothread_vq_mapping_apply(
>      return true;
>  }
> =20
> -void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list)
> +void iothread_vq_mapping_cleanup(IOThreadVirtQueueMappingList *list,
> +                                 char *holder)

const char *

--+IX8647Ob/JqdU18
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqGASkACgkQnKSrs4Gr
c8hVYQf9G90P4FGiFsGkmnRceceRuR+Aagvq+/lmd+6cQeKjiJNegkAGOgO27U6R
CbzMASI1t1zOs9lFh8ZIv3fY96G8Vg6jxAJfK4LUX7/Kdr2i/UgHrnYOjvomrb+J
coGPPsmFCg7y1iYqoGIkX5db5lm6saofbAinXsEpErfzIql3/8oFVy2g1aGk13NW
AjusiLZVPMTB6VW27QHeuvFWBLNcU0avEGCoFiMnkS393k636b+WWBSUImXZxDQd
o3A/W51jKejLPEkY5Qg9pyPHRHu1/JOUmCOxhKsuu35MKLUz8Mm9iBYHdbi0BqLK
kuKQJkq/bnWEDtKDEYWQHbN1iVkwuA==
=Rfp5
-----END PGP SIGNATURE-----

--+IX8647Ob/JqdU18--


