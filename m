Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C8C54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmeYF-0004YD-LY; Tue, 19 Mar 2024 14:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmeYB-0004XT-4R
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rmeY9-0007su-0y
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710874259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RSbqtND9/mjwNUd9Dgm2TGpPJGE+aWvOrCqrjJnBnJk=;
 b=eJgd8wbTdFwsYJRApYzSmVa2sXJKo3CQDxEoHNPAnXGPWTOmUL0zEBx8d9xI5sVgp9AjsM
 aVpZouAgiTIGhvSDUjh3v8cguUMWe4srAjf2h8wD0qvvmxfkfGKeBSkOMrWaejNk84RPT3
 Lnyk2pSlveVQ++y/fePieL0zfUPd32M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Cu-hB8kLMG2UF6M8yWdDEA-1; Tue, 19 Mar 2024 14:50:57 -0400
X-MC-Unique: Cu-hB8kLMG2UF6M8yWdDEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B89E8007A6;
 Tue, 19 Mar 2024 18:50:56 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA6A63C20;
 Tue, 19 Mar 2024 18:50:55 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:50:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, fam@euphon.net, t.lamprecht@proxmox.com,
 w.bumiller@proxmox.com
Subject: Re: [PATCH] block/io: accept NULL qiov in bdrv_pad_request
Message-ID: <20240319185034.GC1127203@fedora>
References: <20240319091341.303414-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J9S/dtcBNMOND2p9"
Content-Disposition: inline
In-Reply-To: <20240319091341.303414-1-f.ebner@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--J9S/dtcBNMOND2p9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:13:41AM +0100, Fiona Ebner wrote:
> From: Stefan Reiter <s.reiter@proxmox.com>
>=20
> Some operations, e.g. block-stream, perform reads while discarding the
> results (only copy-on-read matters). In this case, they will pass NULL
> as the target QEMUIOVector, which will however trip bdrv_pad_request,
> since it wants to extend its passed vector. In particular, this is the
> case for the blk_co_preadv() call in stream_populate().
>=20
> If there is no qiov, no operation can be done with it, but the bytes
> and offset still need to be updated, so the subsequent aligned read
> will actually be aligned and not run into an assertion failure.
>=20
> In particular, this can happen when the request alignment of the top
> node is larger than the allocated part of the bottom node, in which
> case padding becomes necessary. For example:
>=20
> > ./qemu-img create /tmp/backing.qcow2 -f qcow2 64M -o cluster_size=3D327=
68
> > ./qemu-io -c "write -P42 0x0 0x1" /tmp/backing.qcow2
> > ./qemu-img create /tmp/top.qcow2 -f qcow2 64M -b /tmp/backing.qcow2 -F =
qcow2
> > ./qemu-system-x86_64 --qmp stdio \
> > --blockdev qcow2,node-name=3Dnode0,file.driver=3Dfile,file.filename=3D/=
tmp/top.qcow2 \
> > <<EOF
> > {"execute": "qmp_capabilities"}
> > {"execute": "blockdev-add", "arguments": { "driver": "compress", "file"=
: "node0", "node-name": "node1" } }
> > {"execute": "block-stream", "arguments": { "job-id": "stream0", "device=
": "node1" } }
> > EOF

Hi Fiona,
Can you add a qemu-iotests test case for this issue?

Thanks,
Stefan

>=20
> Originally-by: Stefan Reiter <s.reiter@proxmox.com>
> Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
> [FE: do update bytes and offset in any case
>      add reproducer to commit message]
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>  block/io.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index 33150c0359..395bea3bac 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1726,22 +1726,29 @@ static int bdrv_pad_request(BlockDriverState *bs,
>          return 0;
>      }
> =20
> -    sliced_iov =3D qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
> -                                  &sliced_head, &sliced_tail,
> -                                  &sliced_niov);
> +    /*
> +     * For prefetching in stream_populate(), no qiov is passed along, be=
cause
> +     * only copy-on-read matters.
> +     */
> +    if (qiov && *qiov) {
> +        sliced_iov =3D qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
> +                                      &sliced_head, &sliced_tail,
> +                                      &sliced_niov);
> =20
> -    /* Guaranteed by bdrv_check_request32() */
> -    assert(*bytes <=3D SIZE_MAX);
> -    ret =3D bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
> -                                  sliced_head, *bytes);
> -    if (ret < 0) {
> -        bdrv_padding_finalize(pad);
> -        return ret;
> +        /* Guaranteed by bdrv_check_request32() */
> +        assert(*bytes <=3D SIZE_MAX);
> +        ret =3D bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
> +                                      sliced_head, *bytes);
> +        if (ret < 0) {
> +            bdrv_padding_finalize(pad);
> +            return ret;
> +        }
> +        *qiov =3D &pad->local_qiov;
> +        *qiov_offset =3D 0;
>      }
> +
>      *bytes +=3D pad->head + pad->tail;
>      *offset -=3D pad->head;
> -    *qiov =3D &pad->local_qiov;
> -    *qiov_offset =3D 0;
>      if (padded) {
>          *padded =3D true;
>      }
> --=20
> 2.39.2
>=20
>=20

--J9S/dtcBNMOND2p9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmX53noACgkQnKSrs4Gr
c8iatAf8DP/oO0mZvaGXV8KnpTNaEdnvJYrd5/UHgMca0IiSK7ZWH0YfiHb09w8t
vbFIr4hrLzwdpygmAexav01B+J0bdV1jBxBcxYPRoVha2axq2ABUmxhMoROxXfcG
EOKlTz0xgnxhmGwQ77/UtltepKzbm+cHmT0+raLNa+R3wLBZxtavZpK8EAqbHkjQ
WmT+MToQnE+fGeZkz+3hRuTkoVJJh0Udez/dwgIa3hh0azDQGx4G9Bs47xhA6Kxi
FAo0XbgW0mfItim+xDJRbCcEDKedsa7FMKZnNpDj2vLaPYvMvE5Zf1apgVt+/6Vm
/PwMQllMiKqe5TcKu53yZL9sAgjBJg==
=+b+3
-----END PGP SIGNATURE-----

--J9S/dtcBNMOND2p9--


