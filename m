Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0655E9E308
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 14:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqAs8-00058r-Mn; Wed, 11 Feb 2026 09:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vqAs5-00058a-RT
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:07:14 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vqAs3-0006Ry-3B
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 09:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=EgyE3agijo5DVtNY+eXBVcHKBt+PImr5g4uQkfOae5c=; b=qWnt1QRiRvwF/OLNl4hUwwi71A
 bvZjvni0nEHpl43icLqGY9FKQBD1Ippey1VLT/epe9O/lt1lxxxmFoP6tnyMSlRniXvPbwaokfgtX
 7rQa0Dq3jZB/7MqxXsWCq+9GkdEPcJGyB8dAst1+1dZO3bpwEMRLaM8+xBqt8tYmoBWATsYA2k1sF
 micjUjvfHlyDcDFXokpTGpdO3B1S2hUZOTtU+4HyWbBTokaTdBhEUXDAhNvbVobVQDRoUDP4ID/Ig
 tdiY3FGhjI/tft1hq4YN+soWzOFbkMcKdVqo8CEmyvElL8c/kpER/bDTk0OkQFmqFElf41EsYZjar
 c1U1OdvaZU1+R5qZGtv/iZZONGL8hqZZj9yluRxexxg98w6P2rDML8U4om3vuyEoDgBM+fcHricN6
 rpin//b6X9nWlUAZoM2LcFtedy9K38Cx+6zk/ClhScTPiPEel1mdPKws+5ypPKfyY28TwPBlr4h5k
 yZx8CHP10ZtS1EtP7sNvbnO8c/1yBTcjRyjYfgqiDE+VWd51lL5KgSV+gs/NBc9HWwkkDdX3QyF2W
 zu8MGqtb3Q/5zwH3WU1RGqzmGFT+/f/YphrEa4ZeGGIy8p3eQ5wtDKaDbio1n7jIbuop9GKecgVC5
 LrkXSsPPa1Jfet7odBRYLBYxpEGYzVrmouCs/eHH0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Andrey Erokhin <language.lawyer@gmail.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
Date: Wed, 11 Feb 2026 15:07:06 +0100
Message-ID: <12835278.O9o76ZdvQC@weasel>
In-Reply-To: <5e904364-240a-4853-ad28-b2e3c5ac8f83@gmail.com>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <5961971.DvuYhMxLoT@weasel>
 <5e904364-240a-4853-ad28-b2e3c5ac8f83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 10 February 2026 10:45:09 CET Andrey Erokhin wrote:
> On 30/01/2026 19:30, Christian Schoenebeck wrote:
> > On Wednesday, 28 January 2026 20:13:45 CET Andrey Erokhin wrote:
> >>> I was trying to boot from a directory tree owned by an ordinary user,
> >>> and some daemons weren't happy about non-root ownership of some files
> >>>=20
> >>> Example use:
> >>> -virtfs
> >>> local,path=3Drootfs,mount_tag=3Droot,security_model=3Dmapped,uid=3D0,=
gid=3D0
> >>=20
> >> I personally switched from fuse-overlayfs to user namespaces+kernel
> >> overlay
> >> fs (for writeable overlay for rootfs) long time ago, so I do not need
> >> uid=3D0,gid=3D0, I'm being mapped to 0:0 in the user namespace. I want=
ed to
> >> publish this change to support users which can't use user namespaces, =
but
> >> yesterday I realized I could just run QEMU (with fuse-overlayfs) under
> >> fakeroot =F0=9F=A4=A6=E2=80=8D=E2=99=82=EF=B8=8F
> >=20
> > Nevertheless you already came more than half way to finish this. All it
> > would take is adding some lines to the command line docs.
> Do you mean smth. like this?

Yes, but you know the drill: top post as v2, please.

> (BTW, is it OK that there is no fmode/dmode processing in system/vl.c?)

You mean error handling of these options. Well, earlier error handling on o=
ne=20
hand might be more desirable, but OTOH it might also be more complicated to=
 be=20
handled in vl.c than either in 9p.c or 9p-local.c I guess.

/Christian

>=20
> ---
>  fsdev/file-op-9p.h      |  4 ++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  fsdev/qemu-fsdev.c      |  2 ++
>  hw/9pfs/9p-local.c      | 25 +++++++++++++++++++++++++
>  hw/9pfs/9p.c            |  2 ++
>  qemu-options.hx         | 24 ++++++++++++++++++++----
>  system/vl.c             |  9 +++++++++
>  7 files changed, 74 insertions(+), 4 deletions(-)
>=20
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index b9dae8c84c..10f3a7270c 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -94,6 +94,8 @@ typedef struct FsDriverEntry {
>      FsThrottle fst;
>      mode_t fmode;
>      mode_t dmode;
> +    uid_t dflt_uid;
> +    gid_t dflt_gid;
>  } FsDriverEntry;
>=20
>  struct FsContext {
> @@ -107,6 +109,8 @@ struct FsContext {
>      void *private;
>      mode_t fmode;
>      mode_t dmode;
> +    uid_t dflt_uid;
> +    gid_t dflt_gid;
>  };
>=20
>  struct V9fsPath {
> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> index 07a18c6e48..c99abb3de6 100644
> --- a/fsdev/qemu-fsdev-opts.c
> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -46,6 +46,12 @@ static QemuOptsList qemu_fsdev_opts =3D {
>          }, {
>              .name =3D "dmode",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "uid",
> +            .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "gid",
> +            .type =3D QEMU_OPT_NUMBER,
>          },
>=20
>          THROTTLE_OPTS,
> @@ -92,6 +98,12 @@ static QemuOptsList qemu_virtfs_opts =3D {
>          }, {
>              .name =3D "dmode",
>              .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "uid",
> +            .type =3D QEMU_OPT_NUMBER,
> +        }, {
> +            .name =3D "gid",
> +            .type =3D QEMU_OPT_NUMBER,
>          },
>=20
>          { /*End of list */ }
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 57877dad0a..faa84dc033 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -58,6 +58,8 @@ static FsDriverTable FsDrivers[] =3D {
>              "writeout",
>              "fmode",
>              "dmode",
> +            "uid",
> +            "gid",
>              "multidevs",
>              "throttling.bps-total",
>              "throttling.bps-read",
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 5ce97b76a6..f20b1c5d1a 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -198,6 +198,12 @@ static int local_lstat(FsContext *fs_ctx, V9fsPath
> *fs_path, struct stat *stbuf) if (err) {
>          goto err_out;
>      }
> +    if (fs_ctx->dflt_uid !=3D -1) {
> +        stbuf->st_uid =3D fs_ctx->dflt_uid;
> +    }
> +    if (fs_ctx->dflt_gid !=3D -1) {
> +        stbuf->st_gid =3D fs_ctx->dflt_gid;
> +    }
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
>          /* Actual credentials are part of extended attrs */
>          uid_t tmp_uid;
> @@ -788,6 +794,12 @@ static int local_fstat(FsContext *fs_ctx, int fid_ty=
pe,
> if (err) {
>          return err;
>      }
> +    if (fs_ctx->dflt_uid !=3D -1) {
> +        stbuf->st_uid =3D fs_ctx->dflt_uid;
> +    }
> +    if (fs_ctx->dflt_gid !=3D -1) {
> +        stbuf->st_gid =3D fs_ctx->dflt_gid;
> +    }
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
>          /* Actual credentials are part of extended attrs */
>          uid_t tmp_uid;
> @@ -1587,6 +1599,19 @@ static int local_parse_opts(QemuOpts *opts,
> FsDriverEntry *fse, Error **errp) }
>      }
>=20
> +    if (fse->export_flags & V9FS_SM_PASSTHROUGH) {
> +        if (qemu_opt_find(opts, "uid")) {
> +            error_setg(errp, "uid is invalid in the passthrough security
> mode"); +            return -1;
> +        }
> +        if (qemu_opt_find(opts, "gid")) {
> +            error_setg(errp, "gid is invalid in the passthrough security
> mode"); +            return -1;
> +        }
> +    }
> +    fse->dflt_uid =3D qemu_opt_get_number(opts, "uid", -1);
> +    fse->dflt_gid =3D qemu_opt_get_number(opts, "gid", -1);
> +
>      fse->path =3D g_strdup(path);
>=20
>      return 0;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index acfa7db4e1..492379d361 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -4317,6 +4317,8 @@ int v9fs_device_realize_common(V9fsState *s, const
> V9fsTransport *t,
>=20
>      s->ctx.fmode =3D fse->fmode;
>      s->ctx.dmode =3D fse->dmode;
> +    s->ctx.dflt_uid =3D fse->dflt_uid;
> +    s->ctx.dflt_gid =3D fse->dflt_gid;
>=20
>      s->fids =3D g_hash_table_new(NULL, NULL);
>      qemu_co_rwlock_init(&s->rename_lock);
> diff --git a/qemu-options.hx b/qemu-options.hx
> index ab23f14d21..84f108d9ad 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1806,7 +1806,7 @@ ERST
>=20
>  DEF("fsdev", HAS_ARG, QEMU_OPTION_fsdev,
>      "-fsdev
> local,id=3Did,path=3Dpath,security_model=3Dmapped-xattr|mapped-file|passt=
hrough|n
> one\n" -    "
> [,writeout=3Dimmediate][,readonly=3Don][,fmode=3Dfmode][,dmode=3Ddmode]\n=
" +    "
> [,writeout=3Dimmediate][,readonly=3Don][,fmode=3Dfmode][,dmode=3Ddmode][,=
uid=3Duid][,
> gid=3Dgid]\n" "
> [[,throttling.bps-total=3Db]|[[,throttling.bps-read=3Dr][,throttling.bps-=
write=3D
> w]]]\n" "
> [[,throttling.iops-total=3Di]|[[,throttling.iops-read=3Dr][,throttling.io=
ps-wri
> te=3Dw]]]\n" "
> [[,throttling.bps-total-max=3Dbm]|[[,throttling.bps-read-max=3Drm][,throt=
tling.
> bps-write-max=3Dwm]]]\n" @@ -1816,7 +1816,7 @@ DEF("fsdev", HAS_ARG,
> QEMU_OPTION_fsdev,
>      QEMU_ARCH_ALL)
>=20
>  SRST
> -``-fsdev local,id=3Did,path=3Dpath,security_model=3Dsecurity_model
> [,writeout=3Dwriteout][,readonly=3Don][,fmode=3Dfmode][,dmode=3Ddmode]
> [,throttling.option=3Dvalue[,throttling.option=3Dvalue[,...]]]`` +``-fsdev
> local,id=3Did,path=3Dpath,security_model=3Dsecurity_model
> [,writeout=3Dwriteout][,readonly=3Don][,fmode=3Dfmode][,dmode=3Ddmode][,u=
id=3Duid][,g
> id=3Dgid] [,throttling.option=3Dvalue[,throttling.option=3Dvalue[,...]]]`=
` \
>  ``-fsdev synth,id=3Did[,readonly=3Don]``
>      Define a new file system device. Valid options are:
> @@ -1870,6 +1870,14 @@ SRST
>          host. Works only with security models "mapped-xattr" and
>          "mapped-file".
>=20
> +    ``uid=3Duid``
> +        Specifies the default uid for files and directories. Works with
> +        security models "mapped-xattr", "mapped-file" and "none".
> +
> +    ``gid=3Dgid``
> +        Specifies the default gid for files and directories. Works with
> +        security models "mapped-xattr", "mapped-file" and "none".
> +
>      ``throttling.bps-total=3Db,throttling.bps-read=3Dr,throttling.bps-wr=
ite=3Dw``
> Specify bandwidth throttling limits in bytes per second, either for all
> request types or for reads or writes only.
> @@ -1911,12 +1919,12 @@ ERST
>=20
>  DEF("virtfs", HAS_ARG, QEMU_OPTION_virtfs,
>      "-virtfs
> local,path=3Dpath,mount_tag=3Dtag,security_model=3Dmapped-xattr|mapped-fi=
le|passt
> hrough|none\n" -    "      =20
> [,id=3Did][,writeout=3Dimmediate][,readonly=3Don][,fmode=3Dfmode][,dmode=
=3Ddmode][,mu
> ltidevs=3Dremap|forbid|warn]\n" +    "      =20
> [,id=3Did][,writeout=3Dimmediate][,readonly=3Don][,fmode=3Dfmode][,dmode=
=3Ddmode][,ui
> d=3Duid][,gid=3Dgid][,multidevs=3Dremap|forbid|warn]\n" "-virtfs
> synth,mount_tag=3Dtag[,id=3Did][,readonly=3Don]\n",
>      QEMU_ARCH_ALL)
>=20
>  SRST
> -``-virtfs local,path=3Dpath,mount_tag=3Dmount_tag
> ,security_model=3Dsecurity_model[,writeout=3Dwriteout][,readonly=3Don]
> [,fmode=3Dfmode][,dmode=3Ddmode][,multidevs=3Dmultidevs]`` +``-virtfs
> local,path=3Dpath,mount_tag=3Dmount_tag
> ,security_model=3Dsecurity_model[,writeout=3Dwriteout][,readonly=3Don]
> [,fmode=3Dfmode][,dmode=3Ddmode][,uid=3Duid][,gid=3Dgid][,multidevs=3Dmul=
tidevs]`` \
>  ``-virtfs synth,mount_tag=3Dmount_tag``
>      Define a new virtual filesystem device and expose it to the guest us=
ing
> @@ -1980,6 +1988,14 @@ SRST
>          host. Works only with security models "mapped-xattr" and
>          "mapped-file".
>=20
> +    ``uid=3Duid``
> +        Specifies the default uid for files and directories. Works with
> +        security models "mapped-xattr", "mapped-file" and "none".
> +
> +    ``gid=3Dgid``
> +        Specifies the default gid for files and directories. Works with
> +        security models "mapped-xattr", "mapped-file" and "none".
> +
>      ``mount_tag=3Dmount_tag``
>          Specifies the tag name to be used by the guest to mount this
>          export point.
> diff --git a/system/vl.c b/system/vl.c
> index 3b7057e6c6..d363b046a6 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -3253,6 +3253,7 @@ void qemu_init(int argc, char **argv)
>                  QemuOpts *fsdev;
>                  QemuOpts *device;
>                  const char *writeout, *sock_fd, *socket, *path,
> *security_model, +                           *uid, *gid,
>                             *multidevs;
>=20
>                  olist =3D qemu_find_opts("virtfs");
> @@ -3301,6 +3302,14 @@ void qemu_init(int argc, char **argv)
>                      qemu_opt_set(fsdev, "security_model", security_model,
>                                   &error_abort);
>                  }
> +                uid =3D qemu_opt_get(opts, "uid");
> +                if (uid) {
> +                    qemu_opt_set(fsdev, "uid", uid, &error_abort);
> +                }
> +                gid =3D qemu_opt_get(opts, "gid");
> +                if (gid) {
> +                    qemu_opt_set(fsdev, "gid", gid, &error_abort);
> +                }
>                  socket =3D qemu_opt_get(opts, "socket");
>                  if (socket) {
>                      qemu_opt_set(fsdev, "socket", socket, &error_abort);
> --





