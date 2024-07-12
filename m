Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C42C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBjf-0004kn-Dt; Fri, 12 Jul 2024 04:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBjc-0004dA-Iq
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBjY-00070g-Is
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nA6Aip4SfsneSOoIz9HibVnd49Xkgude/rp1vu1Uywc=;
 b=R1V5Iaok7KES1ocLvD0isT2+IXLyNqStmsG/lby8eHJLTSUBv2kgV53GvOzOLAhxhD+FaK
 lEn6flUC+8kJEYV9DJVgPJLMxrf4baoSIPSlRT1GbQd2cm/H8PY1FPOOkO3Js6D5SOrwob
 5MZGuNmAR5A3R9Iqd1bwujWnYk6OUkw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-uQ91ImtJPZCs1BH1CyBOIw-1; Fri, 12 Jul 2024 04:34:25 -0400
X-MC-Unique: uQ91ImtJPZCs1BH1CyBOIw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6590a57788aso28766337b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773265; x=1721378065;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nA6Aip4SfsneSOoIz9HibVnd49Xkgude/rp1vu1Uywc=;
 b=gO0kEPv5DKuW7Snv8pKoc+pJLRYowGVwsKFuKAu0t0PupMBJQhG0FR9EfhO6f10tE7
 2xCc9NDmAokIYSgAdUNSJFsrWc+Lm/qnm+jyOLnTCTK3bl27IycuQlDhzpGnqWwDMVU+
 FpqmFoCtl4KRzpfoyU52yfiH3RZPC79uqRpa+NJ009IaQyMRAWVaYeDGfVye3AqR0FSA
 mkF1vZDgKKcstzCMke71hPsZjlB4QdpyyIcEEgFlOMdrFpVp635HxNB70TWZndUpGjQq
 ORJj8tcdoN+C6IQp26mpnGbPcX605ci/kUHiAxhMqkjMC4RMv7SXQ6xoJyuA0Gvj1fpE
 VPDQ==
X-Gm-Message-State: AOJu0YxdxhTEvIw/MZB5TazhG7k2i4CyslHwS01lNGcTTNLSICCKnZrO
 VJBvIzwzJZPe7begGcHpg1MzQyQsUHjDkxzdgQ3DyqqeA1sErnfbeM/RpIR8vItXq39mjQQJzmz
 UFSbTvEBRaFl5NgZzLozzyYj1Xdo1sVH6kG6JwORYQchB59wyuXMcUUwBnVvMi/r+NdubT+GBt/
 JMNG6qpQQv1cLDmKRC0Li0PUOriJA=
X-Received: by 2002:a81:5b42:0:b0:650:8f3a:2ac6 with SMTP id
 00721157ae682-658ee790066mr122555317b3.1.1720773264670; 
 Fri, 12 Jul 2024 01:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGImDBtS/CQO2eyh5QN438xDGNy/aJXF5fWwqQe6MzvoNgJMmcnCnO4rccNRXMDHjPSlpcYX6cQiUejqaO4zbc=
X-Received: by 2002:a81:5b42:0:b0:650:8f3a:2ac6 with SMTP id
 00721157ae682-658ee790066mr122555127b3.1.1720773264240; Fri, 12 Jul 2024
 01:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:34:13 +0300
Message-ID: <CAPMcbCoD1-TiB-3chq7ZqPFcTeKe33U_TyGK-_5Hgm4Vb=Ws7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/22] qga: move linux memory block command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002785c9061d08bf13"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000002785c9061d08bf13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The qmp_guest_{set,get}_{memory_blocks,block_info} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
>
> This also removes a "#ifdef CONFIG_LINUX" that was nested inside
> a "#ifdef __linux__".
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-linux.c | 308 ++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-posix.c | 311 +------------------------------------------
>  2 files changed, 309 insertions(+), 310 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index c0e8bd4062..73b13fbaf6 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -1595,6 +1595,314 @@ int64_t
> qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
>      return processed;
>  }
>
> +
> +static void ga_read_sysfs_file(int dirfd, const char *pathname, char *bu=
f,
> +                               int size, Error **errp)
> +{
> +    int fd;
> +    int res;
> +
> +    errno =3D 0;
> +    fd =3D openat(dirfd, pathname, O_RDONLY);
> +    if (fd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname=
);
> +        return;
> +    }
> +
> +    res =3D pread(fd, buf, size, 0);
> +    if (res =3D=3D -1) {
> +        error_setg_errno(errp, errno, "pread sysfs file \"%s\"",
> pathname);
> +    } else if (res =3D=3D 0) {
> +        error_setg(errp, "pread sysfs file \"%s\": unexpected EOF",
> pathname);
> +    }
> +    close(fd);
> +}
> +
> +static void ga_write_sysfs_file(int dirfd, const char *pathname,
> +                                const char *buf, int size, Error **errp)
> +{
> +    int fd;
> +
> +    errno =3D 0;
> +    fd =3D openat(dirfd, pathname, O_WRONLY);
> +    if (fd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname=
);
> +        return;
> +    }
> +
> +    if (pwrite(fd, buf, size, 0) =3D=3D -1) {
> +        error_setg_errno(errp, errno, "pwrite sysfs file \"%s\"",
> pathname);
> +    }
> +
> +    close(fd);
> +}
> +
> +/* Transfer online/offline status between @mem_blk and the guest system.
> + *
> + * On input either @errp or *@errp must be NULL.
> + *
> + * In system-to-@mem_blk direction, the following @mem_blk fields are
> accessed:
> + * - R: mem_blk->phys_index
> + * - W: mem_blk->online
> + * - W: mem_blk->can_offline
> + *
> + * In @mem_blk-to-system direction, the following @mem_blk fields are
> accessed:
> + * - R: mem_blk->phys_index
> + * - R: mem_blk->online
> + *-  R: mem_blk->can_offline
> + * Written members remain unmodified on error.
> + */
> +static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool
> sys2memblk,
> +                                  GuestMemoryBlockResponse *result,
> +                                  Error **errp)
> +{
> +    char *dirpath;
> +    int dirfd;
> +    char *status;
> +    Error *local_err =3D NULL;
> +
> +    if (!sys2memblk) {
> +        DIR *dp;
> +
> +        if (!result) {
> +            error_setg(errp, "Internal error, 'result' should not be
> NULL");
> +            return;
> +        }
> +        errno =3D 0;
> +        dp =3D opendir("/sys/devices/system/memory/");
> +         /* if there is no 'memory' directory in sysfs,
> +         * we think this VM does not support online/offline memory block=
,
> +         * any other solution?
> +         */
> +        if (!dp) {
> +            if (errno =3D=3D ENOENT) {
> +                result->response =3D
> +
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
> +            }
> +            goto out1;
> +        }
> +        closedir(dp);
> +    }
> +
> +    dirpath =3D g_strdup_printf("/sys/devices/system/memory/memory%" PRI=
d64
> "/",
> +                              mem_blk->phys_index);
> +    dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> +    if (dirfd =3D=3D -1) {
> +        if (sys2memblk) {
> +            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> +        } else {
> +            if (errno =3D=3D ENOENT) {
> +                result->response =3D
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;
> +            } else {
> +                result->response =3D
> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
> +            }
> +        }
> +        g_free(dirpath);
> +        goto out1;
> +    }
> +    g_free(dirpath);
> +
> +    status =3D g_malloc0(10);
> +    ga_read_sysfs_file(dirfd, "state", status, 10, &local_err);
> +    if (local_err) {
> +        /* treat with sysfs file that not exist in old kernel */
> +        if (errno =3D=3D ENOENT) {
> +            error_free(local_err);
> +            if (sys2memblk) {
> +                mem_blk->online =3D true;
> +                mem_blk->can_offline =3D false;
> +            } else if (!mem_blk->online) {
> +                result->response =3D
> +
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
> +            }
> +        } else {
> +            if (sys2memblk) {
> +                error_propagate(errp, local_err);
> +            } else {
> +                error_free(local_err);
> +                result->response =3D
> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
> +            }
> +        }
> +        goto out2;
> +    }
> +
> +    if (sys2memblk) {
> +        char removable =3D '0';
> +
> +        mem_blk->online =3D (strncmp(status, "online", 6) =3D=3D 0);
> +
> +        ga_read_sysfs_file(dirfd, "removable", &removable, 1, &local_err=
);
> +        if (local_err) {
> +            /* if no 'removable' file, it doesn't support offline mem bl=
k
> */
> +            if (errno =3D=3D ENOENT) {
> +                error_free(local_err);
> +                mem_blk->can_offline =3D false;
> +            } else {
> +                error_propagate(errp, local_err);
> +            }
> +        } else {
> +            mem_blk->can_offline =3D (removable !=3D '0');
> +        }
> +    } else {
> +        if (mem_blk->online !=3D (strncmp(status, "online", 6) =3D=3D 0)=
) {
> +            const char *new_state =3D mem_blk->online ? "online" :
> "offline";
> +
> +            ga_write_sysfs_file(dirfd, "state", new_state,
> strlen(new_state),
> +                                &local_err);
> +            if (local_err) {
> +                error_free(local_err);
> +                result->response =3D
> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
> +                goto out2;
> +            }
> +
> +            result->response =3D GUEST_MEMORY_BLOCK_RESPONSE_TYPE_SUCCES=
S;
> +            result->has_error_code =3D false;
> +        } /* otherwise pretend successful re-(on|off)-lining */
> +    }
> +    g_free(status);
> +    close(dirfd);
> +    return;
> +
> +out2:
> +    g_free(status);
> +    close(dirfd);
> +out1:
> +    if (!sys2memblk) {
> +        result->has_error_code =3D true;
> +        result->error_code =3D errno;
> +    }
> +}
> +
> +GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
> +{
> +    GuestMemoryBlockList *head, **tail;
> +    Error *local_err =3D NULL;
> +    struct dirent *de;
> +    DIR *dp;
> +
> +    head =3D NULL;
> +    tail =3D &head;
> +
> +    dp =3D opendir("/sys/devices/system/memory/");
> +    if (!dp) {
> +        /* it's ok if this happens to be a system that doesn't expose
> +         * memory blocks via sysfs, but otherwise we should report
> +         * an error
> +         */
> +        if (errno !=3D ENOENT) {
> +            error_setg_errno(errp, errno, "Can't open directory"
> +                             "\"/sys/devices/system/memory/\"");
> +        }
> +        return NULL;
> +    }
> +
> +    /* Note: the phys_index of memory block may be discontinuous,
> +     * this is because a memblk is the unit of the Sparse Memory design,
> which
> +     * allows discontinuous memory ranges (ex. NUMA), so here we should
> +     * traverse the memory block directory.
> +     */
> +    while ((de =3D readdir(dp)) !=3D NULL) {
> +        GuestMemoryBlock *mem_blk;
> +
> +        if ((strncmp(de->d_name, "memory", 6) !=3D 0) ||
> +            !(de->d_type & DT_DIR)) {
> +            continue;
> +        }
> +
> +        mem_blk =3D g_malloc0(sizeof *mem_blk);
> +        /* The d_name is "memoryXXX",  phys_index is block id, same as
> XXX */
> +        mem_blk->phys_index =3D strtoul(&de->d_name[6], NULL, 10);
> +        mem_blk->has_can_offline =3D true; /* lolspeak ftw */
> +        transfer_memory_block(mem_blk, true, NULL, &local_err);
> +        if (local_err) {
> +            break;
> +        }
> +
> +        QAPI_LIST_APPEND(tail, mem_blk);
> +    }
> +
> +    closedir(dp);
> +    if (local_err =3D=3D NULL) {
> +        /* there's no guest with zero memory blocks */
> +        if (head =3D=3D NULL) {
> +            error_setg(errp, "guest reported zero memory blocks!");
> +        }
> +        return head;
> +    }
> +
> +    qapi_free_GuestMemoryBlockList(head);
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
> +GuestMemoryBlockResponseList *
> +qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp=
)
> +{
> +    GuestMemoryBlockResponseList *head, **tail;
> +    Error *local_err =3D NULL;
> +
> +    head =3D NULL;
> +    tail =3D &head;
> +
> +    while (mem_blks !=3D NULL) {
> +        GuestMemoryBlockResponse *result;
> +        GuestMemoryBlock *current_mem_blk =3D mem_blks->value;
> +
> +        result =3D g_malloc0(sizeof(*result));
> +        result->phys_index =3D current_mem_blk->phys_index;
> +        transfer_memory_block(current_mem_blk, false, result, &local_err=
);
> +        if (local_err) { /* should never happen */
> +            goto err;
> +        }
> +
> +        QAPI_LIST_APPEND(tail, result);
> +        mem_blks =3D mem_blks->next;
> +    }
> +
> +    return head;
> +err:
> +    qapi_free_GuestMemoryBlockResponseList(head);
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
> +GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    char *dirpath;
> +    int dirfd;
> +    char *buf;
> +    GuestMemoryBlockInfo *info;
> +
> +    dirpath =3D g_strdup_printf("/sys/devices/system/memory/");
> +    dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> +    if (dirfd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> +        g_free(dirpath);
> +        return NULL;
> +    }
> +    g_free(dirpath);
> +
> +    buf =3D g_malloc0(20);
> +    ga_read_sysfs_file(dirfd, "block_size_bytes", buf, 20, &local_err);
> +    close(dirfd);
> +    if (local_err) {
> +        g_free(buf);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    info =3D g_new0(GuestMemoryBlockInfo, 1);
> +    info->size =3D strtol(buf, NULL, 16); /* the unit is bytes */
> +
> +    g_free(buf);
> +
> +    return info;
> +}
> +
>  #define MAX_NAME_LEN 128
>  static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
>  {
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 5da60e65ab..2a3bef7445 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -887,316 +887,7 @@ void qmp_guest_set_user_password(const char
> *username,
>  }
>  #endif /* __linux__ || __FreeBSD__ */
>
> -#ifdef __linux__
> -static void ga_read_sysfs_file(int dirfd, const char *pathname, char *bu=
f,
> -                               int size, Error **errp)
> -{
> -    int fd;
> -    int res;
> -
> -    errno =3D 0;
> -    fd =3D openat(dirfd, pathname, O_RDONLY);
> -    if (fd =3D=3D -1) {
> -        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname=
);
> -        return;
> -    }
> -
> -    res =3D pread(fd, buf, size, 0);
> -    if (res =3D=3D -1) {
> -        error_setg_errno(errp, errno, "pread sysfs file \"%s\"",
> pathname);
> -    } else if (res =3D=3D 0) {
> -        error_setg(errp, "pread sysfs file \"%s\": unexpected EOF",
> pathname);
> -    }
> -    close(fd);
> -}
> -
> -static void ga_write_sysfs_file(int dirfd, const char *pathname,
> -                                const char *buf, int size, Error **errp)
> -{
> -    int fd;
> -
> -    errno =3D 0;
> -    fd =3D openat(dirfd, pathname, O_WRONLY);
> -    if (fd =3D=3D -1) {
> -        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname=
);
> -        return;
> -    }
> -
> -    if (pwrite(fd, buf, size, 0) =3D=3D -1) {
> -        error_setg_errno(errp, errno, "pwrite sysfs file \"%s\"",
> pathname);
> -    }
> -
> -    close(fd);
> -}
> -
> -/* Transfer online/offline status between @mem_blk and the guest system.
> - *
> - * On input either @errp or *@errp must be NULL.
> - *
> - * In system-to-@mem_blk direction, the following @mem_blk fields are
> accessed:
> - * - R: mem_blk->phys_index
> - * - W: mem_blk->online
> - * - W: mem_blk->can_offline
> - *
> - * In @mem_blk-to-system direction, the following @mem_blk fields are
> accessed:
> - * - R: mem_blk->phys_index
> - * - R: mem_blk->online
> - *-  R: mem_blk->can_offline
> - * Written members remain unmodified on error.
> - */
> -static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool
> sys2memblk,
> -                                  GuestMemoryBlockResponse *result,
> -                                  Error **errp)
> -{
> -    char *dirpath;
> -    int dirfd;
> -    char *status;
> -    Error *local_err =3D NULL;
> -
> -    if (!sys2memblk) {
> -        DIR *dp;
> -
> -        if (!result) {
> -            error_setg(errp, "Internal error, 'result' should not be
> NULL");
> -            return;
> -        }
> -        errno =3D 0;
> -        dp =3D opendir("/sys/devices/system/memory/");
> -         /* if there is no 'memory' directory in sysfs,
> -         * we think this VM does not support online/offline memory block=
,
> -         * any other solution?
> -         */
> -        if (!dp) {
> -            if (errno =3D=3D ENOENT) {
> -                result->response =3D
> -
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
> -            }
> -            goto out1;
> -        }
> -        closedir(dp);
> -    }
> -
> -    dirpath =3D g_strdup_printf("/sys/devices/system/memory/memory%" PRI=
d64
> "/",
> -                              mem_blk->phys_index);
> -    dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> -    if (dirfd =3D=3D -1) {
> -        if (sys2memblk) {
> -            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> -        } else {
> -            if (errno =3D=3D ENOENT) {
> -                result->response =3D
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;
> -            } else {
> -                result->response =3D
> -                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
> -            }
> -        }
> -        g_free(dirpath);
> -        goto out1;
> -    }
> -    g_free(dirpath);
> -
> -    status =3D g_malloc0(10);
> -    ga_read_sysfs_file(dirfd, "state", status, 10, &local_err);
> -    if (local_err) {
> -        /* treat with sysfs file that not exist in old kernel */
> -        if (errno =3D=3D ENOENT) {
> -            error_free(local_err);
> -            if (sys2memblk) {
> -                mem_blk->online =3D true;
> -                mem_blk->can_offline =3D false;
> -            } else if (!mem_blk->online) {
> -                result->response =3D
> -
> GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
> -            }
> -        } else {
> -            if (sys2memblk) {
> -                error_propagate(errp, local_err);
> -            } else {
> -                error_free(local_err);
> -                result->response =3D
> -                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
> -            }
> -        }
> -        goto out2;
> -    }
> -
> -    if (sys2memblk) {
> -        char removable =3D '0';
> -
> -        mem_blk->online =3D (strncmp(status, "online", 6) =3D=3D 0);
> -
> -        ga_read_sysfs_file(dirfd, "removable", &removable, 1, &local_err=
);
> -        if (local_err) {
> -            /* if no 'removable' file, it doesn't support offline mem bl=
k
> */
> -            if (errno =3D=3D ENOENT) {
> -                error_free(local_err);
> -                mem_blk->can_offline =3D false;
> -            } else {
> -                error_propagate(errp, local_err);
> -            }
> -        } else {
> -            mem_blk->can_offline =3D (removable !=3D '0');
> -        }
> -    } else {
> -        if (mem_blk->online !=3D (strncmp(status, "online", 6) =3D=3D 0)=
) {
> -            const char *new_state =3D mem_blk->online ? "online" :
> "offline";
> -
> -            ga_write_sysfs_file(dirfd, "state", new_state,
> strlen(new_state),
> -                                &local_err);
> -            if (local_err) {
> -                error_free(local_err);
> -                result->response =3D
> -                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
> -                goto out2;
> -            }
> -
> -            result->response =3D GUEST_MEMORY_BLOCK_RESPONSE_TYPE_SUCCES=
S;
> -            result->has_error_code =3D false;
> -        } /* otherwise pretend successful re-(on|off)-lining */
> -    }
> -    g_free(status);
> -    close(dirfd);
> -    return;
> -
> -out2:
> -    g_free(status);
> -    close(dirfd);
> -out1:
> -    if (!sys2memblk) {
> -        result->has_error_code =3D true;
> -        result->error_code =3D errno;
> -    }
> -}
> -
> -GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
> -{
> -    GuestMemoryBlockList *head, **tail;
> -    Error *local_err =3D NULL;
> -    struct dirent *de;
> -    DIR *dp;
> -
> -    head =3D NULL;
> -    tail =3D &head;
> -
> -    dp =3D opendir("/sys/devices/system/memory/");
> -    if (!dp) {
> -        /* it's ok if this happens to be a system that doesn't expose
> -         * memory blocks via sysfs, but otherwise we should report
> -         * an error
> -         */
> -        if (errno !=3D ENOENT) {
> -            error_setg_errno(errp, errno, "Can't open directory"
> -                             "\"/sys/devices/system/memory/\"");
> -        }
> -        return NULL;
> -    }
> -
> -    /* Note: the phys_index of memory block may be discontinuous,
> -     * this is because a memblk is the unit of the Sparse Memory design,
> which
> -     * allows discontinuous memory ranges (ex. NUMA), so here we should
> -     * traverse the memory block directory.
> -     */
> -    while ((de =3D readdir(dp)) !=3D NULL) {
> -        GuestMemoryBlock *mem_blk;
> -
> -        if ((strncmp(de->d_name, "memory", 6) !=3D 0) ||
> -            !(de->d_type & DT_DIR)) {
> -            continue;
> -        }
> -
> -        mem_blk =3D g_malloc0(sizeof *mem_blk);
> -        /* The d_name is "memoryXXX",  phys_index is block id, same as
> XXX */
> -        mem_blk->phys_index =3D strtoul(&de->d_name[6], NULL, 10);
> -        mem_blk->has_can_offline =3D true; /* lolspeak ftw */
> -        transfer_memory_block(mem_blk, true, NULL, &local_err);
> -        if (local_err) {
> -            break;
> -        }
> -
> -        QAPI_LIST_APPEND(tail, mem_blk);
> -    }
> -
> -    closedir(dp);
> -    if (local_err =3D=3D NULL) {
> -        /* there's no guest with zero memory blocks */
> -        if (head =3D=3D NULL) {
> -            error_setg(errp, "guest reported zero memory blocks!");
> -        }
> -        return head;
> -    }
> -
> -    qapi_free_GuestMemoryBlockList(head);
> -    error_propagate(errp, local_err);
> -    return NULL;
> -}
> -
> -GuestMemoryBlockResponseList *
> -qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp=
)
> -{
> -    GuestMemoryBlockResponseList *head, **tail;
> -    Error *local_err =3D NULL;
> -
> -    head =3D NULL;
> -    tail =3D &head;
> -
> -    while (mem_blks !=3D NULL) {
> -        GuestMemoryBlockResponse *result;
> -        GuestMemoryBlock *current_mem_blk =3D mem_blks->value;
> -
> -        result =3D g_malloc0(sizeof(*result));
> -        result->phys_index =3D current_mem_blk->phys_index;
> -        transfer_memory_block(current_mem_blk, false, result, &local_err=
);
> -        if (local_err) { /* should never happen */
> -            goto err;
> -        }
> -
> -        QAPI_LIST_APPEND(tail, result);
> -        mem_blks =3D mem_blks->next;
> -    }
> -
> -    return head;
> -err:
> -    qapi_free_GuestMemoryBlockResponseList(head);
> -    error_propagate(errp, local_err);
> -    return NULL;
> -}
> -
> -GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    char *dirpath;
> -    int dirfd;
> -    char *buf;
> -    GuestMemoryBlockInfo *info;
> -
> -    dirpath =3D g_strdup_printf("/sys/devices/system/memory/");
> -    dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> -    if (dirfd =3D=3D -1) {
> -        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> -        g_free(dirpath);
> -        return NULL;
> -    }
> -    g_free(dirpath);
> -
> -    buf =3D g_malloc0(20);
> -    ga_read_sysfs_file(dirfd, "block_size_bytes", buf, 20, &local_err);
> -    close(dirfd);
> -    if (local_err) {
> -        g_free(buf);
> -        error_propagate(errp, local_err);
> -        return NULL;
> -    }
> -
> -    info =3D g_new0(GuestMemoryBlockInfo, 1);
> -    info->size =3D strtol(buf, NULL, 16); /* the unit is bytes */
> -
> -    g_free(buf);
> -
> -    return info;
> -}
> -
> -
> -#else /* defined(__linux__) */
> +#ifndef __linux__
>
>  void qmp_guest_suspend_disk(Error **errp)
>  {
> --
> 2.45.1
>
>

--0000000000002785c9061d08bf13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:44=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The qmp_guest_{set,get}_{memory_blocks,block_info} comm=
and impls in<br>
commands-posix.c are surrounded by &#39;#ifdef __linux__&#39; so should<br>
instead live in commands-linux.c<br>
<br>
This also removes a &quot;#ifdef CONFIG_LINUX&quot; that was nested inside<=
br>
a &quot;#ifdef __linux__&quot;.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 308 ++++++++++++++++++++++++++++++++++++++++++=
<br>
=C2=A0qga/commands-posix.c | 311 +-----------------------------------------=
-<br>
=C2=A02 files changed, 309 insertions(+), 310 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index c0e8bd4062..73b13fbaf6 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -1595,6 +1595,314 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorLi=
st *vcpus, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return processed;<br>
=C2=A0}<br>
<br>
+<br>
+static void ga_read_sysfs_file(int dirfd, const char *pathname, char *buf,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 int fd;<br>
+=C2=A0 =C2=A0 int res;<br>
+<br>
+=C2=A0 =C2=A0 errno =3D 0;<br>
+=C2=A0 =C2=A0 fd =3D openat(dirfd, pathname, O_RDONLY);<br>
+=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open sysfs=
 file \&quot;%s\&quot;&quot;, pathname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 res =3D pread(fd, buf, size, 0);<br>
+=C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;pread sysf=
s file \&quot;%s\&quot;&quot;, pathname);<br>
+=C2=A0 =C2=A0 } else if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;pread sysfs file \&quot=
;%s\&quot;: unexpected EOF&quot;, pathname);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 close(fd);<br>
+}<br>
+<br>
+static void ga_write_sysfs_file(int dirfd, const char *pathname,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, int size, Error **e=
rrp)<br>
+{<br>
+=C2=A0 =C2=A0 int fd;<br>
+<br>
+=C2=A0 =C2=A0 errno =3D 0;<br>
+=C2=A0 =C2=A0 fd =3D openat(dirfd, pathname, O_WRONLY);<br>
+=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open sysfs=
 file \&quot;%s\&quot;&quot;, pathname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (pwrite(fd, buf, size, 0) =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;pwrite sys=
fs file \&quot;%s\&quot;&quot;, pathname);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 close(fd);<br>
+}<br>
+<br>
+/* Transfer online/offline status between @mem_blk and the guest system.<b=
r>
+ *<br>
+ * On input either @errp or *@errp must be NULL.<br>
+ *<br>
+ * In system-to-@mem_blk direction, the following @mem_blk fields are acce=
ssed:<br>
+ * - R: mem_blk-&gt;phys_index<br>
+ * - W: mem_blk-&gt;online<br>
+ * - W: mem_blk-&gt;can_offline<br>
+ *<br>
+ * In @mem_blk-to-system direction, the following @mem_blk fields are acce=
ssed:<br>
+ * - R: mem_blk-&gt;phys_index<br>
+ * - R: mem_blk-&gt;online<br>
+ *-=C2=A0 R: mem_blk-&gt;can_offline<br>
+ * Written members remain unmodified on error.<br>
+ */<br>
+static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memb=
lk,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlockResponse *res=
ult,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 char *dirpath;<br>
+=C2=A0 =C2=A0 int dirfd;<br>
+=C2=A0 =C2=A0 char *status;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (!sys2memblk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIR *dp;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!result) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Internal =
error, &#39;result&#39; should not be NULL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/devices/system/memor=
y/&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if there is no &#39;memory&#39; direc=
tory in sysfs,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* we think this VM does not support onli=
ne/offline memory block,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any other solution?<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 closedir(dp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 dirpath =3D g_strdup_printf(&quot;/sys/devices/system/memory=
/memory%&quot; PRId64 &quot;/&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;phys_index);<br>
+=C2=A0 =C2=A0 dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);<br>
+=C2=A0 =C2=A0 if (dirfd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys2memblk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s\&quot;)&quot;, dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out1;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_free(dirpath);<br>
+<br>
+=C2=A0 =C2=A0 status =3D g_malloc0(10);<br>
+=C2=A0 =C2=A0 ga_read_sysfs_file(dirfd, &quot;state&quot;, status, 10, &am=
p;local_err);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* treat with sysfs file that not exist in old=
 kernel */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys2memblk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;online=
 =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;can_of=
fline =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!mem_blk-&gt;online) =
{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys2memblk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(er=
rp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (sys2memblk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char removable =3D &#39;0&#39;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;online =3D (strncmp(status, &quot;=
online&quot;, 6) =3D=3D 0);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_read_sysfs_file(dirfd, &quot;removable&quot=
;, &amp;removable, 1, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if no &#39;removable&#39; fil=
e, it doesn&#39;t support offline mem blk */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;can_of=
fline =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(er=
rp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;can_offline =3D (rem=
ovable !=3D &#39;0&#39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mem_blk-&gt;online !=3D (strncmp(status, &=
quot;online&quot;, 6) =3D=3D 0)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *new_state =3D mem_bl=
k-&gt;online ? &quot;online&quot; : &quot;offline&quot;;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_write_sysfs_file(dirfd, &quot=
;state&quot;, new_state, strlen(new_state),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;response =3D GUEST_ME=
MORY_BLOCK_RESPONSE_TYPE_SUCCESS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_error_code =3D fa=
lse;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } /* otherwise pretend successful re-(on|off)-=
lining */<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_free(status);<br>
+=C2=A0 =C2=A0 close(dirfd);<br>
+=C2=A0 =C2=A0 return;<br>
+<br>
+out2:<br>
+=C2=A0 =C2=A0 g_free(status);<br>
+=C2=A0 =C2=A0 close(dirfd);<br>
+out1:<br>
+=C2=A0 =C2=A0 if (!sys2memblk) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_error_code =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error_code =3D errno;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestMemoryBlockList *head, **tail;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 struct dirent *de;<br>
+=C2=A0 =C2=A0 DIR *dp;<br>
+<br>
+=C2=A0 =C2=A0 head =3D NULL;<br>
+=C2=A0 =C2=A0 tail =3D &amp;head;<br>
+<br>
+=C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/devices/system/memory/&quot;);<br>
+=C2=A0 =C2=A0 if (!dp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* it&#39;s ok if this happens to be a system =
that doesn&#39;t expose<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* memory blocks via sysfs, but otherwise=
 we should report<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* an error<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;Can&#39;t open directory&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\&quot;/sys/devices/system/memory/\&qu=
ot;&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Note: the phys_index of memory block may be discontinuous=
,<br>
+=C2=A0 =C2=A0 =C2=A0* this is because a memblk is the unit of the Sparse M=
emory design, which<br>
+=C2=A0 =C2=A0 =C2=A0* allows discontinuous memory ranges (ex. NUMA), so he=
re we should<br>
+=C2=A0 =C2=A0 =C2=A0* traverse the memory block directory.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 while ((de =3D readdir(dp)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlock *mem_blk;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((strncmp(de-&gt;d_name, &quot;memory&quot;=
, 6) !=3D 0) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(de-&gt;d_type &amp; DT_DIR)) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk =3D g_malloc0(sizeof *mem_blk);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The d_name is &quot;memoryXXX&quot;,=C2=A0 =
phys_index is block id, same as XXX */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;phys_index =3D strtoul(&amp;de-&gt=
;d_name[6], NULL, 10);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;has_can_offline =3D true; /* lolsp=
eak ftw */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_memory_block(mem_blk, true, NULL, &am=
p;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, mem_blk);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 closedir(dp);<br>
+=C2=A0 =C2=A0 if (local_err =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* there&#39;s no guest with zero memory block=
s */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (head =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;guest rep=
orted zero memory blocks!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return head;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qapi_free_GuestMemoryBlockList(head);<br>
+=C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+GuestMemoryBlockResponseList *<br>
+qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)<=
br>
+{<br>
+=C2=A0 =C2=A0 GuestMemoryBlockResponseList *head, **tail;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 head =3D NULL;<br>
+=C2=A0 =C2=A0 tail =3D &amp;head;<br>
+<br>
+=C2=A0 =C2=A0 while (mem_blks !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlockResponse *result;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlock *current_mem_blk =3D mem_blks=
-&gt;value;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_malloc0(sizeof(*result));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;phys_index =3D current_mem_blk-&gt;=
phys_index;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_memory_block(current_mem_blk, false, =
result, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) { /* should never happen */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, result);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blks =3D mem_blks-&gt;next;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return head;<br>
+err:<br>
+=C2=A0 =C2=A0 qapi_free_GuestMemoryBlockResponseList(head);<br>
+=C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 char *dirpath;<br>
+=C2=A0 =C2=A0 int dirfd;<br>
+=C2=A0 =C2=A0 char *buf;<br>
+=C2=A0 =C2=A0 GuestMemoryBlockInfo *info;<br>
+<br>
+=C2=A0 =C2=A0 dirpath =3D g_strdup_printf(&quot;/sys/devices/system/memory=
/&quot;);<br>
+=C2=A0 =C2=A0 dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);<br>
+=C2=A0 =C2=A0 if (dirfd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 g_free(dirpath);<br>
+<br>
+=C2=A0 =C2=A0 buf =3D g_malloc0(20);<br>
+=C2=A0 =C2=A0 ga_read_sysfs_file(dirfd, &quot;block_size_bytes&quot;, buf,=
 20, &amp;local_err);<br>
+=C2=A0 =C2=A0 close(dirfd);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 info =3D g_new0(GuestMemoryBlockInfo, 1);<br>
+=C2=A0 =C2=A0 info-&gt;size =3D strtol(buf, NULL, 16); /* the unit is byte=
s */<br>
+<br>
+=C2=A0 =C2=A0 g_free(buf);<br>
+<br>
+=C2=A0 =C2=A0 return info;<br>
+}<br>
+<br>
=C2=A0#define MAX_NAME_LEN 128<br>
=C2=A0static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)<br>
=C2=A0{<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 5da60e65ab..2a3bef7445 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -887,316 +887,7 @@ void qmp_guest_set_user_password(const char *username=
,<br>
=C2=A0}<br>
=C2=A0#endif /* __linux__ || __FreeBSD__ */<br>
<br>
-#ifdef __linux__<br>
-static void ga_read_sysfs_file(int dirfd, const char *pathname, char *buf,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int size, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 int fd;<br>
-=C2=A0 =C2=A0 int res;<br>
-<br>
-=C2=A0 =C2=A0 errno =3D 0;<br>
-=C2=A0 =C2=A0 fd =3D openat(dirfd, pathname, O_RDONLY);<br>
-=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open sysfs=
 file \&quot;%s\&quot;&quot;, pathname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 res =3D pread(fd, buf, size, 0);<br>
-=C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;pread sysf=
s file \&quot;%s\&quot;&quot;, pathname);<br>
-=C2=A0 =C2=A0 } else if (res =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;pread sysfs file \&quot=
;%s\&quot;: unexpected EOF&quot;, pathname);<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 close(fd);<br>
-}<br>
-<br>
-static void ga_write_sysfs_file(int dirfd, const char *pathname,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, int size, Error **e=
rrp)<br>
-{<br>
-=C2=A0 =C2=A0 int fd;<br>
-<br>
-=C2=A0 =C2=A0 errno =3D 0;<br>
-=C2=A0 =C2=A0 fd =3D openat(dirfd, pathname, O_WRONLY);<br>
-=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open sysfs=
 file \&quot;%s\&quot;&quot;, pathname);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (pwrite(fd, buf, size, 0) =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;pwrite sys=
fs file \&quot;%s\&quot;&quot;, pathname);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 close(fd);<br>
-}<br>
-<br>
-/* Transfer online/offline status between @mem_blk and the guest system.<b=
r>
- *<br>
- * On input either @errp or *@errp must be NULL.<br>
- *<br>
- * In system-to-@mem_blk direction, the following @mem_blk fields are acce=
ssed:<br>
- * - R: mem_blk-&gt;phys_index<br>
- * - W: mem_blk-&gt;online<br>
- * - W: mem_blk-&gt;can_offline<br>
- *<br>
- * In @mem_blk-to-system direction, the following @mem_blk fields are acce=
ssed:<br>
- * - R: mem_blk-&gt;phys_index<br>
- * - R: mem_blk-&gt;online<br>
- *-=C2=A0 R: mem_blk-&gt;can_offline<br>
- * Written members remain unmodified on error.<br>
- */<br>
-static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memb=
lk,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlockResponse *res=
ult,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 char *dirpath;<br>
-=C2=A0 =C2=A0 int dirfd;<br>
-=C2=A0 =C2=A0 char *status;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (!sys2memblk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DIR *dp;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!result) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Internal =
error, &#39;result&#39; should not be NULL&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/devices/system/memor=
y/&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if there is no &#39;memory&#39; direc=
tory in sysfs,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* we think this VM does not support onli=
ne/offline memory block,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* any other solution?<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 closedir(dp);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 dirpath =3D g_strdup_printf(&quot;/sys/devices/system/memory=
/memory%&quot; PRId64 &quot;/&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;phys_index);<br>
-=C2=A0 =C2=A0 dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);<br>
-=C2=A0 =C2=A0 if (dirfd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys2memblk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s\&quot;)&quot;, dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out1;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 g_free(dirpath);<br>
-<br>
-=C2=A0 =C2=A0 status =3D g_malloc0(10);<br>
-=C2=A0 =C2=A0 ga_read_sysfs_file(dirfd, &quot;state&quot;, status, 10, &am=
p;local_err);<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* treat with sysfs file that not exist in old=
 kernel */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys2memblk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;online=
 =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;can_of=
fline =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!mem_blk-&gt;online) =
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sys2memblk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(er=
rp, local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (sys2memblk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char removable =3D &#39;0&#39;;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;online =3D (strncmp(status, &quot;=
online&quot;, 6) =3D=3D 0);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_read_sysfs_file(dirfd, &quot;removable&quot=
;, &amp;removable, 1, &amp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if no &#39;removable&#39; fil=
e, it doesn&#39;t support offline mem blk */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;can_of=
fline =3D false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(er=
rp, local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;can_offline =3D (rem=
ovable !=3D &#39;0&#39;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mem_blk-&gt;online !=3D (strncmp(status, &=
quot;online&quot;, 6) =3D=3D 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *new_state =3D mem_bl=
k-&gt;online ? &quot;online&quot; : &quot;offline&quot;;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ga_write_sysfs_file(dirfd, &quot=
;state&quot;, new_state, strlen(new_state),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_e=
rr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;respons=
e =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GUES=
T_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out2;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;response =3D GUEST_ME=
MORY_BLOCK_RESPONSE_TYPE_SUCCESS;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_error_code =3D fa=
lse;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } /* otherwise pretend successful re-(on|off)-=
lining */<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 g_free(status);<br>
-=C2=A0 =C2=A0 close(dirfd);<br>
-=C2=A0 =C2=A0 return;<br>
-<br>
-out2:<br>
-=C2=A0 =C2=A0 g_free(status);<br>
-=C2=A0 =C2=A0 close(dirfd);<br>
-out1:<br>
-=C2=A0 =C2=A0 if (!sys2memblk) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;has_error_code =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;error_code =3D errno;<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestMemoryBlockList *head, **tail;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 struct dirent *de;<br>
-=C2=A0 =C2=A0 DIR *dp;<br>
-<br>
-=C2=A0 =C2=A0 head =3D NULL;<br>
-=C2=A0 =C2=A0 tail =3D &amp;head;<br>
-<br>
-=C2=A0 =C2=A0 dp =3D opendir(&quot;/sys/devices/system/memory/&quot;);<br>
-=C2=A0 =C2=A0 if (!dp) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* it&#39;s ok if this happens to be a system =
that doesn&#39;t expose<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* memory blocks via sysfs, but otherwise=
 we should report<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* an error<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;Can&#39;t open directory&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;\&quot;/sys/devices/system/memory/\&qu=
ot;&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* Note: the phys_index of memory block may be discontinuous=
,<br>
-=C2=A0 =C2=A0 =C2=A0* this is because a memblk is the unit of the Sparse M=
emory design, which<br>
-=C2=A0 =C2=A0 =C2=A0* allows discontinuous memory ranges (ex. NUMA), so he=
re we should<br>
-=C2=A0 =C2=A0 =C2=A0* traverse the memory block directory.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 while ((de =3D readdir(dp)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlock *mem_blk;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((strncmp(de-&gt;d_name, &quot;memory&quot;=
, 6) !=3D 0) ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(de-&gt;d_type &amp; DT_DIR)) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk =3D g_malloc0(sizeof *mem_blk);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The d_name is &quot;memoryXXX&quot;,=C2=A0 =
phys_index is block id, same as XXX */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;phys_index =3D strtoul(&amp;de-&gt=
;d_name[6], NULL, 10);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blk-&gt;has_can_offline =3D true; /* lolsp=
eak ftw */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_memory_block(mem_blk, true, NULL, &am=
p;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, mem_blk);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 closedir(dp);<br>
-=C2=A0 =C2=A0 if (local_err =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* there&#39;s no guest with zero memory block=
s */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (head =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;guest rep=
orted zero memory blocks!&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return head;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 qapi_free_GuestMemoryBlockList(head);<br>
-=C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-GuestMemoryBlockResponseList *<br>
-qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)<=
br>
-{<br>
-=C2=A0 =C2=A0 GuestMemoryBlockResponseList *head, **tail;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 head =3D NULL;<br>
-=C2=A0 =C2=A0 tail =3D &amp;head;<br>
-<br>
-=C2=A0 =C2=A0 while (mem_blks !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlockResponse *result;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestMemoryBlock *current_mem_blk =3D mem_blks=
-&gt;value;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D g_malloc0(sizeof(*result));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 result-&gt;phys_index =3D current_mem_blk-&gt;=
phys_index;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_memory_block(current_mem_blk, false, =
result, &amp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) { /* should never happen */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, result);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mem_blks =3D mem_blks-&gt;next;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return head;<br>
-err:<br>
-=C2=A0 =C2=A0 qapi_free_GuestMemoryBlockResponseList(head);<br>
-=C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 char *dirpath;<br>
-=C2=A0 =C2=A0 int dirfd;<br>
-=C2=A0 =C2=A0 char *buf;<br>
-=C2=A0 =C2=A0 GuestMemoryBlockInfo *info;<br>
-<br>
-=C2=A0 =C2=A0 dirpath =3D g_strdup_printf(&quot;/sys/devices/system/memory=
/&quot;);<br>
-=C2=A0 =C2=A0 dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);<br>
-=C2=A0 =C2=A0 if (dirfd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 g_free(dirpath);<br>
-<br>
-=C2=A0 =C2=A0 buf =3D g_malloc0(20);<br>
-=C2=A0 =C2=A0 ga_read_sysfs_file(dirfd, &quot;block_size_bytes&quot;, buf,=
 20, &amp;local_err);<br>
-=C2=A0 =C2=A0 close(dirfd);<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 info =3D g_new0(GuestMemoryBlockInfo, 1);<br>
-=C2=A0 =C2=A0 info-&gt;size =3D strtol(buf, NULL, 16); /* the unit is byte=
s */<br>
-<br>
-=C2=A0 =C2=A0 g_free(buf);<br>
-<br>
-=C2=A0 =C2=A0 return info;<br>
-}<br>
-<br>
-<br>
-#else /* defined(__linux__) */<br>
+#ifndef __linux__<br>
<br>
=C2=A0void qmp_guest_suspend_disk(Error **errp)<br>
=C2=A0{<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000002785c9061d08bf13--


