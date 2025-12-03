Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BAFD1269D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 10:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQkAt-000214-9t; Wed, 03 Dec 2025 05:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQkAq-000208-Eo
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:33:29 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQkAo-0000wM-HW
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 05:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=AMca8AaX18aw2OACe/Lk4XSq8OFEFUnlzFUqAi+mmPc=; b=r8UDwsBBVbiurO6UJ5K43CagoG
 3CLpOJnf/Q3qAfxmzVNiNU1Q2EJ8gJivKFHrTq71SdzOsoAMzwwRKHz2hahUxneDyeUuWkV3YKvR/
 h5aQkAel6FfMIoImsUWVMET2dERe9tFUBhf77PXG/Wh1tY4vpEvO+Mw7N6xJBweYdnppZdjfYatXO
 M64N54xSCWP4Iug0KzuOoQMAhQmw0O1pU+xOO8/y8Kg86vv8fYKrhu2dv93AgTGmK28kHL3m7EinA
 VgiB45ZSVYyckxKf3v65rR2I0B+YowNO8b9kCdOKAcCYaRj+zhjbHkkpZNTmJCUmRomECE0yBWWrU
 Ax96KLejDB6WkwDr5BrRLeOZNMDxRK4ebnZTB0jfj/ZKedGEj6I32kRRGQ22c2C9fVnFFkCIKQ5mt
 ajxaTye5PS1QFVS+AhjCds6KFEFMNiedax1UhNpr0b28lpEupL99aSG2LXIjQzPN+PZHDuU5UQ2DY
 6ecLGEp4hbq2DJ39PPtjslGTVXajaU7SeiqgKeY2/kwzln1Ubffc+8zcr/JFOPCHke3K+b2GIP26Q
 dWQlut2yOdjHRSbeJG2s61zro6678OGH9vPHgS0+X1PAcgKw+YnEGj9rk9PoeY0FSpulDeaZ/lo+c
 F7LUWfv1e6cGlGYtyJ/t7SUdfkZ95bq6W0iVn9Xrg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Greg Kurz <groug@kaod.org>, Andrey Erokhin <language.lawyer@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
Date: Wed, 03 Dec 2025 11:33:22 +0100
Message-ID: <5030911.GXAFRqVoOG@weasel>
In-Reply-To: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Monday, 1 December 2025 19:00:53 CET Andrey Erokhin wrote:
> I was trying to boot from a directory tree owned by an ordinary user,
> and some daemons weren't happy about non-root ownership of some files
> 
> Example use:
> -virtfs local,path=rootfs,mount_tag=root,security_model=mapped,uid=0,gid=0
> 
> Works with any security_model

First I thought do we really want to open that rabbit hole and add permission 
management to the CLI options? However I get why this might be useful for 
mapped[-*] security models.

But for passthrough it is not of any use, is it? Just saying, because you 
write it "Works with any security_model".

Also while it is very handy to have a short option name like "uid" and "gid", 
for the sake of long term progression and clarity an option name like 
"default-uid" would be more appropriate.

The patch is also missing the required documentation changes for these new 
options BTW.

/Christian

> Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>
> ---
>  fsdev/file-op-9p.h      |  5 +++++
>  fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
>  fsdev/qemu-fsdev.c      |  2 ++
>  hw/9pfs/9p-local.c      | 15 +++++++++++++++
>  hw/9pfs/9p.c            |  2 ++
>  system/vl.c             |  9 +++++++++
>  6 files changed, 45 insertions(+)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index b9dae8c84c..46fb88001e 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -15,6 +15,7 @@
>  #define FILE_OP_9P_H
> 
>  #include <dirent.h>
> +#include <sys/types.h>
>  #include <utime.h>
>  #include "qemu-fsdev-throttle.h"
>  #include "p9array.h"
> @@ -94,6 +95,8 @@ typedef struct FsDriverEntry {
>      FsThrottle fst;
>      mode_t fmode;
>      mode_t dmode;
> +    uid_t dflt_uid;
> +    gid_t dflt_gid;
>  } FsDriverEntry;
> 
>  struct FsContext {
> @@ -107,6 +110,8 @@ struct FsContext {
>      void *private;
>      mode_t fmode;
>      mode_t dmode;
> +    uid_t dflt_uid;
> +    gid_t dflt_gid;
>  };
> 
>  struct V9fsPath {
> diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
> index 07a18c6e48..c99abb3de6 100644
> --- a/fsdev/qemu-fsdev-opts.c
> +++ b/fsdev/qemu-fsdev-opts.c
> @@ -46,6 +46,12 @@ static QemuOptsList qemu_fsdev_opts = {
>          }, {
>              .name = "dmode",
>              .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "uid",
> +            .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "gid",
> +            .type = QEMU_OPT_NUMBER,
>          },
> 
>          THROTTLE_OPTS,
> @@ -92,6 +98,12 @@ static QemuOptsList qemu_virtfs_opts = {
>          }, {
>              .name = "dmode",
>              .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "uid",
> +            .type = QEMU_OPT_NUMBER,
> +        }, {
> +            .name = "gid",
> +            .type = QEMU_OPT_NUMBER,
>          },
> 
>          { /*End of list */ }
> diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
> index 57877dad0a..faa84dc033 100644
> --- a/fsdev/qemu-fsdev.c
> +++ b/fsdev/qemu-fsdev.c
> @@ -58,6 +58,8 @@ static FsDriverTable FsDrivers[] = {
>              "writeout",
>              "fmode",
>              "dmode",
> +            "uid",
> +            "gid",
>              "multidevs",
>              "throttling.bps-total",
>              "throttling.bps-read",
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 5ce97b76a6..cecf4aa50c 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -198,6 +198,12 @@ static int local_lstat(FsContext *fs_ctx, V9fsPath
> *fs_path, struct stat *stbuf) if (err) {
>          goto err_out;
>      }
> +    if (fs_ctx->dflt_uid != -1) {
> +        stbuf->st_uid = fs_ctx->dflt_uid;
> +    }
> +    if (fs_ctx->dflt_gid != -1) {
> +        stbuf->st_gid = fs_ctx->dflt_gid;
> +    }
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
>          /* Actual credentials are part of extended attrs */
>          uid_t tmp_uid;
> @@ -788,6 +794,12 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
> if (err) {
>          return err;
>      }
> +    if (fs_ctx->dflt_uid != -1) {
> +        stbuf->st_uid = fs_ctx->dflt_uid;
> +    }
> +    if (fs_ctx->dflt_gid != -1) {
> +        stbuf->st_gid = fs_ctx->dflt_gid;
> +    }
>      if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
>          /* Actual credentials are part of extended attrs */
>          uid_t tmp_uid;
> @@ -1570,6 +1582,9 @@ static int local_parse_opts(QemuOpts *opts,
> FsDriverEntry *fse, Error **errp) return -1;
>      }
> 
> +    fse->dflt_uid = qemu_opt_get_number(opts, "uid", -1);
> +    fse->dflt_gid = qemu_opt_get_number(opts, "gid", -1);
> +
>      if (fse->export_flags & V9FS_SM_MAPPED ||
>          fse->export_flags & V9FS_SM_MAPPED_FILE) {
>          fse->fmode =
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index acfa7db4e1..492379d361 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -4317,6 +4317,8 @@ int v9fs_device_realize_common(V9fsState *s, const
> V9fsTransport *t,
> 
>      s->ctx.fmode = fse->fmode;
>      s->ctx.dmode = fse->dmode;
> +    s->ctx.dflt_uid = fse->dflt_uid;
> +    s->ctx.dflt_gid = fse->dflt_gid;
> 
>      s->fids = g_hash_table_new(NULL, NULL);
>      qemu_co_rwlock_init(&s->rename_lock);
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
> 
>                  olist = qemu_find_opts("virtfs");
> @@ -3301,6 +3302,14 @@ void qemu_init(int argc, char **argv)
>                      qemu_opt_set(fsdev, "security_model", security_model,
>                                   &error_abort);
>                  }
> +                uid = qemu_opt_get(opts, "uid");
> +                if (uid) {
> +                    qemu_opt_set(fsdev, "uid", uid, &error_abort);
> +                }
> +                gid = qemu_opt_get(opts, "gid");
> +                if (gid) {
> +                    qemu_opt_set(fsdev, "gid", gid, &error_abort);
> +                }
>                  socket = qemu_opt_get(opts, "socket");
>                  if (socket) {
>                      qemu_opt_set(fsdev, "socket", socket, &error_abort);



