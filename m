Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09E2FDEE29
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxNO-0007ai-3L; Thu, 23 Apr 2026 12:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFxNL-0007aU-MH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:58:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wFxNJ-0001sv-Sw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776963481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U12YSLBM/S2r/iw3/rkp71u5Yn5c3NGuWbtdRd56dPo=;
 b=NPkSGzd0eNQrpMZiahLyCz/YvlqQy52luiwhk/aND7qwuDwbjPrte9qOE0WamCA7RiCLlW
 GLknpj6WUsanfSW68gaBUgR4BJ3GYOH+Dq9IB9q9RezECK1h2quzqzlZ2D+vCS25aV3jul
 x4TbrWnqA/5f6kLXDX/6kOsqNEkjXck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-KI6gDEZ6P3-fwdrom__Z3Q-1; Thu,
 23 Apr 2026 12:57:51 -0400
X-MC-Unique: KI6gDEZ6P3-fwdrom__Z3Q-1
X-Mimecast-MFC-AGG-ID: KI6gDEZ6P3-fwdrom__Z3Q_1776963470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 435831956048; Thu, 23 Apr 2026 16:57:50 +0000 (UTC)
Received: from localhost (unknown [10.44.32.119])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1FF9300070A; Thu, 23 Apr 2026 16:57:48 +0000 (UTC)
Date: Thu, 23 Apr 2026 12:29:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: mr-083 <matthieu@minio.io>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, its@irrelevant.dk,
 kbusch@kernel.org, berrange@redhat.com, mr-083 <matthieu@min.io>,
 Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com
Subject: Re: [PATCH] block: add blockdev-attach QMP command
Message-ID: <20260423162927.GA529033@fedora>
References: <20260415173905.71224-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ffV7S53+P2LmfPw"
Content-Disposition: inline
In-Reply-To: <20260415173905.71224-1-matthieu@min.io>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--9ffV7S53+P2LmfPw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 07:39:05PM +0200, mr-083 wrote:
> Add a blockdev-attach QMP command that attaches a block driver state
> tree to a device's block backend.  Unlike blockdev-insert-medium, this
> works for non-removable devices such as NVMe namespaces.
>=20
> After drive_del removes a device's backing store, the BlockBackend
> remains attached to the guest device but has no BlockDriverState.
> blockdev-attach reconnects a block node (previously created with
> blockdev-add) to the device's BlockBackend via blk_insert_bs().
>=20
> This separates the two concerns as recommended: blockdev-add creates
> the block node, blockdev-attach associates it with the device.
>=20
> Example usage with NVMe namespace hot-swap:
>   drive_del drv0
>   blockdev-add node-name=3Dnode0 driver=3Dqcow2 file.driver=3Dfile \
>                file.filename=3Ddisk.qcow2
>   blockdev-attach id=3Dns0 node-name=3Dnode0

Hi Matthieu,
I came across a quirk here:

  $ qemu-system-x86_64 \
      --blockdev file,filename=3Dmy-lun.img,node-name=3Ddrive1 \
      --device nvme,serial=3Dnvme0 \
      --device nvme-ns,id=3Dnvme-ns0,drive=3Ddrive1
  (qemu) drive_del drive1
  Error: drive drive1 is in use

But when I change --blockdev to --drive, it succeeds. I think this
second scenario is the one that you have been testing.

I also tried the QMP blockdev-del command together with --blockdev, and
it fails:

  $ qemu-system-x86_64 ... \
      -qmp unix:/tmp/qmp.sock,server=3Don,wait=3Doff
  $ qmp-shell /tmp/qmp.sock
  (QEMU) blockdev-del node-name=3Ddrive1
  {"error": {"class": "GenericError", "desc": "Node drive1 is in use"}}

It seems logical that a disk image that's in use by NVMe emulation
cannot be removed. So now I'm wondering if there is a bug or a
historical reason why drive_del allows drives to the removed at runtime
even when media change is not supported.

CCing Kevin Wolf and Markus Amrbruster as they may know the answer.

Depending on the answer this may influence the test workflow in this
patch. It's unclear to me what is being tested here since this does not
simulate a real error that a physical NVMe drive could raise?

I think the intention is to fail I/O so a test can simulate a period
where the drive is down. QEMU has the blkdebug driver which could be
inserted into the block graph to fail I/O requests - maybe that is
appropriate for your test and may not require new monitor commands (see
blkdebug examples in tests/)?

Stefan

>=20
> An HMP wrapper is included for convenience.
>=20
> Signed-off-by: Matthieu <matthieu@min.io>
> ---
>  block/monitor/block-hmp-cmds.c | 10 ++++++++++
>  block/qapi-system.c            | 36 ++++++++++++++++++++++++++++++++++
>  hmp-commands.hx                | 16 +++++++++++++++
>  include/block/block-hmp-cmds.h |  1 +
>  qapi/block.json                | 33 +++++++++++++++++++++++++++++++
>  5 files changed, 96 insertions(+)
>=20
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmd=
s.c
> index 1fd28d59eb..8a3d821e01 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -195,6 +195,16 @@ unlock:
>      hmp_handle_error(mon, err);
>  }
> =20
> +void hmp_blockdev_attach(Monitor *mon, const QDict *qdict)
> +{
> +    const char *id =3D qdict_get_str(qdict, "id");
> +    const char *node_name =3D qdict_get_str(qdict, "node-name");
> +    Error *err =3D NULL;
> +
> +    qmp_blockdev_attach(id, node_name, &err);
> +    hmp_handle_error(mon, err);
> +}
> +
>  void hmp_commit(Monitor *mon, const QDict *qdict)
>  {
>      const char *device =3D qdict_get_str(qdict, "device");
> diff --git a/block/qapi-system.c b/block/qapi-system.c
> index 54b7409b2b..ec89645bc1 100644
> --- a/block/qapi-system.c
> +++ b/block/qapi-system.c
> @@ -304,6 +304,42 @@ void qmp_blockdev_insert_medium(const char *id, cons=
t char *node_name,
>      blockdev_insert_medium(NULL, id, node_name, errp);
>  }
> =20
> +void qmp_blockdev_attach(const char *id, const char *node_name,
> +                         Error **errp)
> +{
> +    BlockBackend *blk;
> +    BlockDriverState *bs;
> +    int ret;
> +
> +    GRAPH_RDLOCK_GUARD_MAINLOOP();
> +
> +    blk =3D qmp_get_blk(NULL, id, errp);
> +    if (!blk) {
> +        return;
> +    }
> +
> +    if (blk_bs(blk)) {
> +        error_setg(errp, "Device already has a medium inserted");
> +        return;
> +    }
> +
> +    bs =3D bdrv_find_node(node_name);
> +    if (!bs) {
> +        error_setg(errp, "Node '%s' not found", node_name);
> +        return;
> +    }
> +
> +    if (bdrv_has_blk(bs)) {
> +        error_setg(errp, "Node '%s' is already in use", node_name);
> +        return;
> +    }
> +
> +    ret =3D blk_insert_bs(blk, bs, errp);
> +    if (ret < 0) {
> +        return;
> +    }
> +}
> +
>  void qmp_blockdev_change_medium(const char *device,
>                                  const char *id,
>                                  const char *filename,
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 5cc4788f12..ce32ed33ab 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -207,6 +207,22 @@ SRST
>    actions (drive options rerror, werror).
>  ERST
> =20
> +    {
> +        .name       =3D "blockdev-attach",
> +        .args_type  =3D "id:s,node-name:s",
> +        .params     =3D "id node-name",
> +        .help       =3D "attach a block node to a device (non-removable)=
",
> +        .cmd        =3D hmp_blockdev_attach,
> +    },
> +
> +SRST
> +``blockdev-attach`` *id* *node-name*
> +  Attach a block driver state tree (created with ``blockdev-add``) to a
> +  device's block backend. Unlike ``blockdev-insert-medium``, this works
> +  for non-removable devices such as NVMe namespaces. The device must
> +  have no medium inserted (e.g. after ``drive_del``).
> +ERST
> +
>      {
>          .name       =3D "change",
>          .args_type  =3D "device:B,force:-f,target:F,arg:s?,read-only-mod=
e:s?",
> diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmd=
s.h
> index 71113cd7ef..34d30915fc 100644
> --- a/include/block/block-hmp-cmds.h
> +++ b/include/block/block-hmp-cmds.h
> @@ -21,6 +21,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
> =20
>  void hmp_commit(Monitor *mon, const QDict *qdict);
>  void hmp_drive_del(Monitor *mon, const QDict *qdict);
> +void hmp_blockdev_attach(Monitor *mon, const QDict *qdict);
> =20
>  void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
>  void hmp_drive_backup(Monitor *mon, const QDict *qdict);
> diff --git a/qapi/block.json b/qapi/block.json
> index 46955bbb3e..c05d3b5ac1 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -295,6 +295,39 @@
>    'data': { 'id': 'str',
>              'node-name': 'str'} }
> =20
> +##
> +# @blockdev-attach:
> +#
> +# Attach a block driver state tree to a device's block backend.
> +# Unlike blockdev-insert-medium, this works for non-removable
> +# devices such as NVMe namespaces.  The device must currently have
> +# no medium inserted (e.g. after drive_del removed the backing).
> +#
> +# @id: The name or QOM path of the guest device
> +#
> +# @node-name: name of a node in the block driver state graph
> +#
> +# Since: 11.1
> +#
> +# .. qmp-example::
> +#
> +#     -> { "execute": "blockdev-add",
> +#          "arguments": {
> +#              "node-name": "node0",
> +#              "driver": "qcow2",
> +#              "file": { "driver": "file",
> +#                        "filename": "disk.qcow2" } } }
> +#     <- { "return": {} }
> +#
> +#     -> { "execute": "blockdev-attach",
> +#          "arguments": { "id": "ns0",
> +#                         "node-name": "node0" } }
> +#     <- { "return": {} }
> +##
> +{ 'command': 'blockdev-attach',
> +  'data': { 'id': 'str',
> +            'node-name': 'str'} }
> +
>  ##
>  # @BlockdevChangeReadOnlyMode:
>  #
> --=20
> 2.53.0
>=20

--9ffV7S53+P2LmfPw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnqSOYACgkQnKSrs4Gr
c8iD6AgAjE0F1h5Jh8FRBzIYVFdncuoYEDg5hS5FXqp5c/+luUste00Y5u5fWFJm
mY+apBVxw8e/24Uv61EO833edJoDaC1Oiow5ThK4B7NT9BQS3Y4AkTfhkSj01ZDk
SlFlCHJm+1Ttf0L3aSSTxhkStRoGYsN0lLuKN6EHkFdZbnQFuUDx4cgyG8Ne/7L1
Se2HkPbsWWwdg7MGp76JlnEQyaIz+rI8VEE+wMavZd5EyBxrADe+wvzIuTaWXCBa
6/cki+oMklGX+knmJ9Jj272ilx0rTmTqMgfsP9XN4UqXLoxR1sK4vX/5ReScWhgZ
gp1kewWtv2Dio1N2p/3MJiGVrXH0DA==
=ME/l
-----END PGP SIGNATURE-----

--9ffV7S53+P2LmfPw--


