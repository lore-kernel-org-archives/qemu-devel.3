Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA14C3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBgZ-0000CU-9X; Fri, 12 Jul 2024 04:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBgT-0008PJ-5y
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBgN-0006jb-7M
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eNxysIzpNpUsVYWY/XtUS6B42bIF67boJ1ZJIdS5J/M=;
 b=iF8SIr5dqbYrsi7kD9/do8d1F4wAKkLXmnuTjPd0f4NxFA81S2lVhxUx9xxBGwFEEOpVbA
 tE/yoRl6cwc0UFknUUBzAgPc1yU+FuadjyXuGDdu5DU6aWRB+8/clVGHGxxrBkD/5B7ldL
 RrQzSHtDuDjf9yh9ibkNAvR+/EzZCMk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-X9hvoNK5MnWFrVRnb-dJjQ-1; Fri, 12 Jul 2024 04:31:02 -0400
X-MC-Unique: X9hvoNK5MnWFrVRnb-dJjQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-653306993a8so29759427b3.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773062; x=1721377862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eNxysIzpNpUsVYWY/XtUS6B42bIF67boJ1ZJIdS5J/M=;
 b=Xmhkf1pL8Ps7hLSrVC+rDozqyFnHkMljBTmGo0J/Jj0oD+9k3NDkaIn1iXvgENlV5Q
 +PgkpS28eVdZUTZiCIigWD/MOJPdU/GFVK8uFxclmEvttdmZQim+VEOW0bYXgttKLTcb
 BourXrBH2F8DpQEC6UGt7/120Te5E4xYUNCEVYLWf+hfImOFfBd23beMbQTaNPoPAUGQ
 KvVw5IreuQAXAqO2W5MtPD4PTuTRaKaBHOIt2YMhWwwao3tMph4e7RXajiyW8W92S+ss
 lt+fTU0cR92umycutNjdvSPE3Fx3toqET5xNdwhtkG0JD3ajutFWFWqXxWR1g18rONmf
 Btdw==
X-Gm-Message-State: AOJu0YwJvFVFl8O/UfVT6iO60/K5QeYC+XxIO3co9g5bvJsbjSMhrsiJ
 qCpMiKjhYv28p9747QyvWCP6pKckiZK1jYGEEm4K9jwac6Y0PUdT2fI8gKkOpwqfIdQm0seNvoY
 Nkp0uujJ/VKkya46ZN57zx3ZnFGsNnaFFtYpm5VUGtxSb4jOZSpDQdjqNdcMUa4SWr/AnCQ4FYr
 j1975jxowiBH1jiH1doaSVvkkxsQ8=
X-Received: by 2002:a0d:eb8f:0:b0:645:44d:82cf with SMTP id
 00721157ae682-658ee790cf8mr121660927b3.1.1720773061777; 
 Fri, 12 Jul 2024 01:31:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcU25kLZ+HwdSvi8pgqfeV/ePoOsS/0FmgD7/b64ZQyHn53iIASs4L/jeGso1lZCByREsV24C07dhuS45iXAI=
X-Received: by 2002:a0d:eb8f:0:b0:645:44d:82cf with SMTP id
 00721157ae682-658ee790cf8mr121660717b3.1.1720773061356; Fri, 12 Jul 2024
 01:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-3-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-3-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:30:50 +0300
Message-ID: <CAPMcbCq2-eEtHf1eD5oYR3AOLxTW375ZkEGW-SdSyPR4FeEL4w@mail.gmail.com>
Subject: Re: [PATCH v2 02/22] qga: move linux vcpu command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000000fbff7061d08b3b0"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--0000000000000fbff7061d08b3b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The qmp_guest_set_vcpus and qmp_guest_get_vcpus command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-linux.c | 141 +++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-posix.c | 139 ------------------------------------------
>  2 files changed, 141 insertions(+), 139 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 214e408fcd..78580ac39d 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -13,6 +13,7 @@
>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qga-qapi-commands.h"
>  #include "commands-common.h"
>  #include "cutils.h"
>  #include <mntent.h>
> @@ -284,3 +285,143 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>      return i;
>  }
>  #endif /* CONFIG_FSFREEZE */
> +
> +/* Transfer online/offline status between @vcpu and the guest system.
> + *
> + * On input either @errp or *@errp must be NULL.
> + *
> + * In system-to-@vcpu direction, the following @vcpu fields are accessed=
:
> + * - R: vcpu->logical_id
> + * - W: vcpu->online
> + * - W: vcpu->can_offline
> + *
> + * In @vcpu-to-system direction, the following @vcpu fields are accessed=
:
> + * - R: vcpu->logical_id
> + * - R: vcpu->online
> + *
> + * Written members remain unmodified on error.
> + */
> +static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
> +                          char *dirpath, Error **errp)
> +{
> +    int fd;
> +    int res;
> +    int dirfd;
> +    static const char fn[] =3D "online";
> +
> +    dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> +    if (dirfd =3D=3D -1) {
> +        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> +        return;
> +    }
> +
> +    fd =3D openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
> +    if (fd =3D=3D -1) {
> +        if (errno !=3D ENOENT) {
> +            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn=
);
> +        } else if (sys2vcpu) {
> +            vcpu->online =3D true;
> +            vcpu->can_offline =3D false;
> +        } else if (!vcpu->online) {
> +            error_setg(errp, "logical processor #%" PRId64 " can't be "
> +                       "offlined", vcpu->logical_id);
> +        } /* otherwise pretend successful re-onlining */
> +    } else {
> +        unsigned char status;
> +
> +        res =3D pread(fd, &status, 1, 0);
> +        if (res =3D=3D -1) {
> +            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath,
> fn);
> +        } else if (res =3D=3D 0) {
> +            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath=
,
> +                       fn);
> +        } else if (sys2vcpu) {
> +            vcpu->online =3D (status !=3D '0');
> +            vcpu->can_offline =3D true;
> +        } else if (vcpu->online !=3D (status !=3D '0')) {
> +            status =3D '0' + vcpu->online;
> +            if (pwrite(fd, &status, 1, 0) =3D=3D -1) {
> +                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")",
> dirpath,
> +                                 fn);
> +            }
> +        } /* otherwise pretend successful re-(on|off)-lining */
> +
> +        res =3D close(fd);
> +        g_assert(res =3D=3D 0);
> +    }
> +
> +    res =3D close(dirfd);
> +    g_assert(res =3D=3D 0);
> +}
> +
> +GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
> +{
> +    GuestLogicalProcessorList *head, **tail;
> +    const char *cpu_dir =3D "/sys/devices/system/cpu";
> +    const gchar *line;
> +    g_autoptr(GDir) cpu_gdir =3D NULL;
> +    Error *local_err =3D NULL;
> +
> +    head =3D NULL;
> +    tail =3D &head;
> +    cpu_gdir =3D g_dir_open(cpu_dir, 0, NULL);
> +
> +    if (cpu_gdir =3D=3D NULL) {
> +        error_setg_errno(errp, errno, "failed to list entries: %s",
> cpu_dir);
> +        return NULL;
> +    }
> +
> +    while (local_err =3D=3D NULL && (line =3D g_dir_read_name(cpu_gdir))=
 !=3D
> NULL) {
> +        GuestLogicalProcessor *vcpu;
> +        int64_t id;
> +        if (sscanf(line, "cpu%" PRId64, &id)) {
> +            g_autofree char *path =3D
> g_strdup_printf("/sys/devices/system/cpu/"
> +                                                    "cpu%" PRId64 "/",
> id);
> +            vcpu =3D g_malloc0(sizeof *vcpu);
> +            vcpu->logical_id =3D id;
> +            vcpu->has_can_offline =3D true; /* lolspeak ftw */
> +            transfer_vcpu(vcpu, true, path, &local_err);
> +            QAPI_LIST_APPEND(tail, vcpu);
> +        }
> +    }
> +
> +    if (local_err =3D=3D NULL) {
> +        /* there's no guest with zero VCPUs */
> +        g_assert(head !=3D NULL);
> +        return head;
> +    }
> +
> +    qapi_free_GuestLogicalProcessorList(head);
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
> +int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error
> **errp)
> +{
> +    int64_t processed;
> +    Error *local_err =3D NULL;
> +
> +    processed =3D 0;
> +    while (vcpus !=3D NULL) {
> +        char *path =3D g_strdup_printf("/sys/devices/system/cpu/cpu%"
> PRId64 "/",
> +                                     vcpus->value->logical_id);
> +
> +        transfer_vcpu(vcpus->value, false, path, &local_err);
> +        g_free(path);
> +        if (local_err !=3D NULL) {
> +            break;
> +        }
> +        ++processed;
> +        vcpus =3D vcpus->next;
> +    }
> +
> +    if (local_err !=3D NULL) {
> +        if (processed =3D=3D 0) {
> +            error_propagate(errp, local_err);
> +        } else {
> +            error_free(local_err);
> +        }
> +    }
> +
> +    return processed;
> +}
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 76af98ba32..a8ef41f175 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -2003,145 +2003,6 @@ void qmp_guest_suspend_hybrid(Error **errp)
>      guest_suspend(SUSPEND_MODE_HYBRID, errp);
>  }
>
> -/* Transfer online/offline status between @vcpu and the guest system.
> - *
> - * On input either @errp or *@errp must be NULL.
> - *
> - * In system-to-@vcpu direction, the following @vcpu fields are accessed=
:
> - * - R: vcpu->logical_id
> - * - W: vcpu->online
> - * - W: vcpu->can_offline
> - *
> - * In @vcpu-to-system direction, the following @vcpu fields are accessed=
:
> - * - R: vcpu->logical_id
> - * - R: vcpu->online
> - *
> - * Written members remain unmodified on error.
> - */
> -static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
> -                          char *dirpath, Error **errp)
> -{
> -    int fd;
> -    int res;
> -    int dirfd;
> -    static const char fn[] =3D "online";
> -
> -    dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);
> -    if (dirfd =3D=3D -1) {
> -        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
> -        return;
> -    }
> -
> -    fd =3D openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
> -    if (fd =3D=3D -1) {
> -        if (errno !=3D ENOENT) {
> -            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn=
);
> -        } else if (sys2vcpu) {
> -            vcpu->online =3D true;
> -            vcpu->can_offline =3D false;
> -        } else if (!vcpu->online) {
> -            error_setg(errp, "logical processor #%" PRId64 " can't be "
> -                       "offlined", vcpu->logical_id);
> -        } /* otherwise pretend successful re-onlining */
> -    } else {
> -        unsigned char status;
> -
> -        res =3D pread(fd, &status, 1, 0);
> -        if (res =3D=3D -1) {
> -            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath,
> fn);
> -        } else if (res =3D=3D 0) {
> -            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath=
,
> -                       fn);
> -        } else if (sys2vcpu) {
> -            vcpu->online =3D (status !=3D '0');
> -            vcpu->can_offline =3D true;
> -        } else if (vcpu->online !=3D (status !=3D '0')) {
> -            status =3D '0' + vcpu->online;
> -            if (pwrite(fd, &status, 1, 0) =3D=3D -1) {
> -                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")",
> dirpath,
> -                                 fn);
> -            }
> -        } /* otherwise pretend successful re-(on|off)-lining */
> -
> -        res =3D close(fd);
> -        g_assert(res =3D=3D 0);
> -    }
> -
> -    res =3D close(dirfd);
> -    g_assert(res =3D=3D 0);
> -}
> -
> -GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
> -{
> -    GuestLogicalProcessorList *head, **tail;
> -    const char *cpu_dir =3D "/sys/devices/system/cpu";
> -    const gchar *line;
> -    g_autoptr(GDir) cpu_gdir =3D NULL;
> -    Error *local_err =3D NULL;
> -
> -    head =3D NULL;
> -    tail =3D &head;
> -    cpu_gdir =3D g_dir_open(cpu_dir, 0, NULL);
> -
> -    if (cpu_gdir =3D=3D NULL) {
> -        error_setg_errno(errp, errno, "failed to list entries: %s",
> cpu_dir);
> -        return NULL;
> -    }
> -
> -    while (local_err =3D=3D NULL && (line =3D g_dir_read_name(cpu_gdir))=
 !=3D
> NULL) {
> -        GuestLogicalProcessor *vcpu;
> -        int64_t id;
> -        if (sscanf(line, "cpu%" PRId64, &id)) {
> -            g_autofree char *path =3D
> g_strdup_printf("/sys/devices/system/cpu/"
> -                                                    "cpu%" PRId64 "/",
> id);
> -            vcpu =3D g_malloc0(sizeof *vcpu);
> -            vcpu->logical_id =3D id;
> -            vcpu->has_can_offline =3D true; /* lolspeak ftw */
> -            transfer_vcpu(vcpu, true, path, &local_err);
> -            QAPI_LIST_APPEND(tail, vcpu);
> -        }
> -    }
> -
> -    if (local_err =3D=3D NULL) {
> -        /* there's no guest with zero VCPUs */
> -        g_assert(head !=3D NULL);
> -        return head;
> -    }
> -
> -    qapi_free_GuestLogicalProcessorList(head);
> -    error_propagate(errp, local_err);
> -    return NULL;
> -}
> -
> -int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error
> **errp)
> -{
> -    int64_t processed;
> -    Error *local_err =3D NULL;
> -
> -    processed =3D 0;
> -    while (vcpus !=3D NULL) {
> -        char *path =3D g_strdup_printf("/sys/devices/system/cpu/cpu%"
> PRId64 "/",
> -                                     vcpus->value->logical_id);
> -
> -        transfer_vcpu(vcpus->value, false, path, &local_err);
> -        g_free(path);
> -        if (local_err !=3D NULL) {
> -            break;
> -        }
> -        ++processed;
> -        vcpus =3D vcpus->next;
> -    }
> -
> -    if (local_err !=3D NULL) {
> -        if (processed =3D=3D 0) {
> -            error_propagate(errp, local_err);
> -        } else {
> -            error_free(local_err);
> -        }
> -    }
> -
> -    return processed;
> -}
>  #endif /* __linux__ */
>
>  #if defined(__linux__) || defined(__FreeBSD__)
> --
> 2.45.1
>
>

--0000000000000fbff7061d08b3b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:02=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The qmp_guest_set_vcpus and qmp_guest_get_vcpus command=
 impls in<br>
commands-posix.c are surrounded by &#39;#ifdef __linux__&#39; so should<br>
instead live in commands-linux.c<br>
<br>
Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@=
linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 141 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-posix.c | 139 ------------------------------------------=
<br>
=C2=A02 files changed, 141 insertions(+), 139 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 214e408fcd..78580ac39d 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -13,6 +13,7 @@<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
+#include &quot;qga-qapi-commands.h&quot;<br>
=C2=A0#include &quot;commands-common.h&quot;<br>
=C2=A0#include &quot;cutils.h&quot;<br>
=C2=A0#include &lt;mntent.h&gt;<br>
@@ -284,3 +285,143 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return i;<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
+<br>
+/* Transfer online/offline status between @vcpu and the guest system.<br>
+ *<br>
+ * On input either @errp or *@errp must be NULL.<br>
+ *<br>
+ * In system-to-@vcpu direction, the following @vcpu fields are accessed:<=
br>
+ * - R: vcpu-&gt;logical_id<br>
+ * - W: vcpu-&gt;online<br>
+ * - W: vcpu-&gt;can_offline<br>
+ *<br>
+ * In @vcpu-to-system direction, the following @vcpu fields are accessed:<=
br>
+ * - R: vcpu-&gt;logical_id<br>
+ * - R: vcpu-&gt;online<br>
+ *<br>
+ * Written members remain unmodified on error.<br>
+ */<br>
+static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 char *dirpath, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 int fd;<br>
+=C2=A0 =C2=A0 int res;<br>
+=C2=A0 =C2=A0 int dirfd;<br>
+=C2=A0 =C2=A0 static const char fn[] =3D &quot;online&quot;;<br>
+<br>
+=C2=A0 =C2=A0 dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);<br>
+=C2=A0 =C2=A0 if (dirfd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, dirpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fd =3D openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);<br>
+=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s/%s\&quot;)&quot;, dirpath, fn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (sys2vcpu) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;online =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;can_offline =3D false;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!vcpu-&gt;online) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;logical p=
rocessor #%&quot; PRId64 &quot; can&#39;t be &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;offlined&quot;, vcpu-&gt;logical_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } /* otherwise pretend successful re-onlining =
*/<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char status;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D pread(fd, &amp;status, 1, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;pread(\&quot;%s/%s\&quot;)&quot;, dirpath, fn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (res =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;pread(\&q=
uot;%s/%s\&quot;): unexpected EOF&quot;, dirpath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (sys2vcpu) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;online =3D (status !=3D=
 &#39;0&#39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;can_offline =3D true;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (vcpu-&gt;online !=3D (status !=3D &=
#39;0&#39;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D &#39;0&#39; + vcpu-&g=
t;online;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pwrite(fd, &amp;status, 1, 0=
) =3D=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(e=
rrp, errno, &quot;pwrite(\&quot;%s/%s\&quot;)&quot;, dirpath,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } /* otherwise pretend successful re-(on|off)-=
lining */<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(res =3D=3D 0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 res =3D close(dirfd);<br>
+=C2=A0 =C2=A0 g_assert(res =3D=3D 0);<br>
+}<br>
+<br>
+GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestLogicalProcessorList *head, **tail;<br>
+=C2=A0 =C2=A0 const char *cpu_dir =3D &quot;/sys/devices/system/cpu&quot;;=
<br>
+=C2=A0 =C2=A0 const gchar *line;<br>
+=C2=A0 =C2=A0 g_autoptr(GDir) cpu_gdir =3D NULL;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 head =3D NULL;<br>
+=C2=A0 =C2=A0 tail =3D &amp;head;<br>
+=C2=A0 =C2=A0 cpu_gdir =3D g_dir_open(cpu_dir, 0, NULL);<br>
+<br>
+=C2=A0 =C2=A0 if (cpu_gdir =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;failed to =
list entries: %s&quot;, cpu_dir);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 while (local_err =3D=3D NULL &amp;&amp; (line =3D g_dir_read=
_name(cpu_gdir)) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestLogicalProcessor *vcpu;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(line, &quot;cpu%&quot; PRId64, &amp=
;id)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *path =3D g_strd=
up_printf(&quot;/sys/devices/system/cpu/&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cpu%&quot; PRId64 &quot;/&quot;, i=
d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu =3D g_malloc0(sizeof *vcpu)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;logical_id =3D id;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;has_can_offline =3D tru=
e; /* lolspeak ftw */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_vcpu(vcpu, true, path, =
&amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, vcpu);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (local_err =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* there&#39;s no guest with zero VCPUs */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(head !=3D NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return head;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 qapi_free_GuestLogicalProcessorList(head);<br>
+=C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp=
)<br>
+{<br>
+=C2=A0 =C2=A0 int64_t processed;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 processed =3D 0;<br>
+=C2=A0 =C2=A0 while (vcpus !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *path =3D g_strdup_printf(&quot;/sys/devi=
ces/system/cpu/cpu%&quot; PRId64 &quot;/&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vcpus-&gt;value-=
&gt;logical_id);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_vcpu(vcpus-&gt;value, false, path, &a=
mp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++processed;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpus =3D vcpus-&gt;next;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (processed =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return processed;<br>
+}<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 76af98ba32..a8ef41f175 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -2003,145 +2003,6 @@ void qmp_guest_suspend_hybrid(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0guest_suspend(SUSPEND_MODE_HYBRID, errp);<br>
=C2=A0}<br>
<br>
-/* Transfer online/offline status between @vcpu and the guest system.<br>
- *<br>
- * On input either @errp or *@errp must be NULL.<br>
- *<br>
- * In system-to-@vcpu direction, the following @vcpu fields are accessed:<=
br>
- * - R: vcpu-&gt;logical_id<br>
- * - W: vcpu-&gt;online<br>
- * - W: vcpu-&gt;can_offline<br>
- *<br>
- * In @vcpu-to-system direction, the following @vcpu fields are accessed:<=
br>
- * - R: vcpu-&gt;logical_id<br>
- * - R: vcpu-&gt;online<br>
- *<br>
- * Written members remain unmodified on error.<br>
- */<br>
-static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 char *dirpath, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 int fd;<br>
-=C2=A0 =C2=A0 int res;<br>
-=C2=A0 =C2=A0 int dirfd;<br>
-=C2=A0 =C2=A0 static const char fn[] =3D &quot;online&quot;;<br>
-<br>
-=C2=A0 =C2=A0 dirfd =3D open(dirpath, O_RDONLY | O_DIRECTORY);<br>
-=C2=A0 =C2=A0 if (dirfd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;open(\&quo=
t;%s\&quot;)&quot;, dirpath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 fd =3D openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);<br>
-=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;open(\&quot;%s/%s\&quot;)&quot;, dirpath, fn);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (sys2vcpu) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;online =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;can_offline =3D false;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!vcpu-&gt;online) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;logical p=
rocessor #%&quot; PRId64 &quot; can&#39;t be &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;offlined&quot;, vcpu-&gt;logical_id);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } /* otherwise pretend successful re-onlining =
*/<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char status;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D pread(fd, &amp;status, 1, 0);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &q=
uot;pread(\&quot;%s/%s\&quot;)&quot;, dirpath, fn);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (res =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;pread(\&q=
uot;%s/%s\&quot;): unexpected EOF&quot;, dirpath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fn);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (sys2vcpu) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;online =3D (status !=3D=
 &#39;0&#39;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;can_offline =3D true;<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (vcpu-&gt;online !=3D (status !=3D &=
#39;0&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D &#39;0&#39; + vcpu-&g=
t;online;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pwrite(fd, &amp;status, 1, 0=
) =3D=3D -1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(e=
rrp, errno, &quot;pwrite(\&quot;%s/%s\&quot;)&quot;, dirpath,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fn);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } /* otherwise pretend successful re-(on|off)-=
lining */<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D close(fd);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(res =3D=3D 0);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 res =3D close(dirfd);<br>
-=C2=A0 =C2=A0 g_assert(res =3D=3D 0);<br>
-}<br>
-<br>
-GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 GuestLogicalProcessorList *head, **tail;<br>
-=C2=A0 =C2=A0 const char *cpu_dir =3D &quot;/sys/devices/system/cpu&quot;;=
<br>
-=C2=A0 =C2=A0 const gchar *line;<br>
-=C2=A0 =C2=A0 g_autoptr(GDir) cpu_gdir =3D NULL;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 head =3D NULL;<br>
-=C2=A0 =C2=A0 tail =3D &amp;head;<br>
-=C2=A0 =C2=A0 cpu_gdir =3D g_dir_open(cpu_dir, 0, NULL);<br>
-<br>
-=C2=A0 =C2=A0 if (cpu_gdir =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno, &quot;failed to =
list entries: %s&quot;, cpu_dir);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 while (local_err =3D=3D NULL &amp;&amp; (line =3D g_dir_read=
_name(cpu_gdir)) !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GuestLogicalProcessor *vcpu;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int64_t id;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sscanf(line, &quot;cpu%&quot; PRId64, &amp=
;id)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree char *path =3D g_strd=
up_printf(&quot;/sys/devices/system/cpu/&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;cpu%&quot; PRId64 &quot;/&quot;, i=
d);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu =3D g_malloc0(sizeof *vcpu)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;logical_id =3D id;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpu-&gt;has_can_offline =3D tru=
e; /* lolspeak ftw */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_vcpu(vcpu, true, path, =
&amp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, vcpu);<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (local_err =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* there&#39;s no guest with zero VCPUs */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert(head !=3D NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return head;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 qapi_free_GuestLogicalProcessorList(head);<br>
-=C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 return NULL;<br>
-}<br>
-<br>
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp=
)<br>
-{<br>
-=C2=A0 =C2=A0 int64_t processed;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 processed =3D 0;<br>
-=C2=A0 =C2=A0 while (vcpus !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *path =3D g_strdup_printf(&quot;/sys/devi=
ces/system/cpu/cpu%&quot; PRId64 &quot;/&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vcpus-&gt;value-=
&gt;logical_id);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 transfer_vcpu(vcpus-&gt;value, false, path, &a=
mp;local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(path);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ++processed;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 vcpus =3D vcpus-&gt;next;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (local_err !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (processed =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err)=
;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return processed;<br>
-}<br>
=C2=A0#endif /* __linux__ */<br>
<br>
=C2=A0#if defined(__linux__) || defined(__FreeBSD__)<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000000fbff7061d08b3b0--


