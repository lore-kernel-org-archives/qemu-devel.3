Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E58DC5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwl58-0002As-Gi; Wed, 19 Aug 2026 14:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwl56-0002Ad-02
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:32:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwl54-00041g-K3
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787164325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yfqYsoTpcUZTN6AON5IUbxPxH2mhlO8lGHSzx2kSSHg=;
 b=MSEHH16PGEwvyiPSAVAor9QAIXEukYGrw5XrRMrOvBTsgJWoplTpBizo0hBoyIkBgRH+2h
 EB923cH+bgJQMDeGNiU/SdjeC9yeln0fncpSfTpIcShazxB6I/NeBFszIPGi1yIM6gqXIg
 4fyA2Utt6SEUx67vmt7471DJdYNLJB4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-KsFMGPsQMOW63spqBOS9iQ-1; Wed,
 19 Aug 2026 14:32:00 -0400
X-MC-Unique: KsFMGPsQMOW63spqBOS9iQ-1
X-Mimecast-MFC-AGG-ID: KsFMGPsQMOW63spqBOS9iQ_1787164319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 902D01955DCB; Wed, 19 Aug 2026 18:31:59 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C21E9180049F; Wed, 19 Aug 2026 18:31:58 +0000 (UTC)
Date: Wed, 19 Aug 2026 14:31:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V12 05/15] block/export: track IOThread references
Message-ID: <20260819183157.GD222512@fedora>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-6-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HQ7McR43VNgT63O3"
Content-Disposition: inline
In-Reply-To: <20260814174830.1691540-6-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--HQ7McR43VNgT63O3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 01:48:19AM +0800, Zhang Chen wrote:
> @@ -139,7 +140,16 @@ BlockExport *blk_exp_add(BlockExportOptions *export,=
 Error **errp)
>              goto fail;
>          }
> =20
> -        new_ctx =3D iothread_get_aio_context(iothread);
> +        holder_id =3D export->id;
> +        const IOThreadHolder holder =3D {
> +            .type =3D IO_THREAD_HOLDER_KIND_BLOCK_EXPORT,
> +            .u.block_export.export_id =3D holder_id,
> +        };
> +
> +        new_ctx =3D iothread_ref_and_get_aio_context(iothread, &holder);
> +        multithread_count =3D 1;

This changes behavior in:

  ret =3D drv->create(exp, export, multithread_ctxs, multithread_count, err=
p);

Now export drivers will see drv->create(exp, export, NULL, 1, errp);
                                                     ^^^^  ^

Before it was drv->create(exp, export, NULL, 0, errp).

fuse_export_create() has an assertion that fails now:

  if (multithread) {
      ...
  } else {
      /* Guaranteed by common export code */
      assert(mt_count =3D=3D 0);
      ...
  }

--HQ7McR43VNgT63O3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqF9p0ACgkQnKSrs4Gr
c8gjQgf+OkD96RC3mR+FuXop84Tf4hXHDVNWGGGesuYAVoDT9BTeiJm2TeTLL3v0
AM/j6jNQzcFPAidBiuwqWODMhExuT+mjcXaETnWfCnmDG3JuwANVbtLp5pds7xSH
oU+odgIfMC+gaci1sz1E6t0rDFebchq0nkAhUHgq1QlW7hdrO5FrJ8TLq5UAJHxt
uUiq3MfY0MnMZXHqT5pkLXcY1/10vl1yuQ3T+9m93LbpkXZvLJnpj4d7/sxKfp0o
Nm1SfSX8zZTXurERgLnnLuyniKEytfh+aRxlXIuvWTGC7tinggR+Lza1xLxMYPsP
6hhvZYLTjpXlDoSnq8EekWa/zw5l6w==
=DgI9
-----END PGP SIGNATURE-----

--HQ7McR43VNgT63O3--


