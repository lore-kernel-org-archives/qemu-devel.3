Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574ACC3DA45
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBfY-0006eN-11; Fri, 12 Jul 2024 04:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBfW-0006d2-0J
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBfR-0006UG-D1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lyvdL0bxXr/0ij+Oekn65UOR0pxNA3FokgJMS7N6LVw=;
 b=WEXjR5qs9t4MZXUcdcAAyreNRTysyhs5E/3g1rgvJLIBsgwz6PSVQ9KSp1MkiYe3fbgxZC
 HnMBj7gvYMNgLvr0lWHNTAPCRZ/cF7Y9IW8lQnfiGr6PgNag7euYj13w4WyO3xjofPyyMF
 ROqEAwxs7DWZCGXhOKudFTo3Y4oV/bs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-BJAWgzKnOjyQGMo0AGZGQg-1; Fri, 12 Jul 2024 04:30:05 -0400
X-MC-Unique: BJAWgzKnOjyQGMo0AGZGQg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-650fccfd1dfso29472657b3.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773005; x=1721377805;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lyvdL0bxXr/0ij+Oekn65UOR0pxNA3FokgJMS7N6LVw=;
 b=QS0Gt/y+6z+0IYgUYZK6NvLH8w1DrsG2X16cdjDX+MfGi8lR0qcHUZrcuL+40tys5j
 akw1FgWtklUSaFZCdhxkBD8rAzUpuB/hJcQBW+vQk22TAlscP54EenybFBD7SunrxZ/E
 wlfUb1XvpkwtlCridcBlXqYpwHOM9QEtyHpaeAt9acABAO2KzQxTtWip5hhTTv93nmhX
 m80o0ydePZpRXD15YPlksKXOr/o/t6KSa3B2rEhxpXBNShKNgHm5wDScQImpma+i7fOc
 LSvvtPSqhYq6j6Djaf0djpPaK9dzo81Rnm45tqBgoAE/HjD2kiQ5vnWiGuIukxaEBZFy
 qtNA==
X-Gm-Message-State: AOJu0YwKBK+cxHOb5bAnXUB8RT+jDew3cQz8SZeDdnNdF9rHXeTFLr+v
 FtfdrTcC+Uwrdl2Bg7yLBsfO3gU8zueIUklzfp9sh+TDImsDSbzgBxcJ4rVq9L6uzf0Eg8s9fvE
 fxic2u0J/6FJSgwdvKbrBaOL4JALqtynR9Rs120S5oHD00tb00c9I5sBspty6DcMCDqc40eHbTN
 Tm8uZZBHXXjWro6KE5Q39eRbWooBs=
X-Received: by 2002:a05:690c:4a0c:b0:63b:aaf1:b8c1 with SMTP id
 00721157ae682-658f02f5605mr132056297b3.37.1720773005152; 
 Fri, 12 Jul 2024 01:30:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+32iPZsjKlU4dSA5H9yOyk1hBpmPbdXZ+atQceyCfOTQrUMbl9hQt8c33SuVH2muFwOs8qaIywbFxJ2Tp0k=
X-Received: by 2002:a05:690c:4a0c:b0:63b:aaf1:b8c1 with SMTP id
 00721157ae682-658f02f5605mr132056177b3.37.1720773004837; Fri, 12 Jul 2024
 01:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613150127.1361931-4-berrange@redhat.com>
In-Reply-To: <20240613150127.1361931-4-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:29:54 +0300
Message-ID: <CAPMcbCpq+Js+Y6avdLfYVPjZA+eHz3SO1gwntgCnMoSae4iUFQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/22] qga: move linux suspend command impls to
 commands-linux.c
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b15ee0061d08af42"
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

--000000000000b15ee0061d08af42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:02=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> The qmp_guest_suspend_{disk,ram,hybrid} command impls in
> commands-posix.c are surrounded by '#ifdef __linux__' so should
> instead live in commands-linux.c
>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/commands-linux.c | 265 +++++++++++++++++++++++++++++++++++++++++++
>  qga/commands-posix.c | 265 -------------------------------------------
>  2 files changed, 265 insertions(+), 265 deletions(-)
>
> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
> index 78580ac39d..3fabf54882 100644
> --- a/qga/commands-linux.c
> +++ b/qga/commands-linux.c
> @@ -286,6 +286,271 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>  }
>  #endif /* CONFIG_FSFREEZE */
>
> +
> +#define LINUX_SYS_STATE_FILE "/sys/power/state"
> +#define SUSPEND_SUPPORTED 0
> +#define SUSPEND_NOT_SUPPORTED 1
> +
> +typedef enum {
> +    SUSPEND_MODE_DISK =3D 0,
> +    SUSPEND_MODE_RAM =3D 1,
> +    SUSPEND_MODE_HYBRID =3D 2,
> +} SuspendMode;
> +
> +/*
> + * Executes a command in a child process using g_spawn_sync,
> + * returning an int >=3D 0 representing the exit status of the
> + * process.
> + *
> + * If the program wasn't found in path, returns -1.
> + *
> + * If a problem happened when creating the child process,
> + * returns -1 and errp is set.
> + */
> +static int run_process_child(const char *command[], Error **errp)
> +{
> +    int exit_status, spawn_flag;
> +    GError *g_err =3D NULL;
> +    bool success;
> +
> +    spawn_flag =3D G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL |
> +                 G_SPAWN_STDERR_TO_DEV_NULL;
> +
> +    success =3D  g_spawn_sync(NULL, (char **)command, NULL, spawn_flag,
> +                            NULL, NULL, NULL, NULL,
> +                            &exit_status, &g_err);
> +
> +    if (success) {
> +        return WEXITSTATUS(exit_status);
> +    }
> +
> +    if (g_err && (g_err->code !=3D G_SPAWN_ERROR_NOENT)) {
> +        error_setg(errp, "failed to create child process, error '%s'",
> +                   g_err->message);
> +    }
> +
> +    g_error_free(g_err);
> +    return -1;
> +}
> +
> +static bool systemd_supports_mode(SuspendMode mode, Error **errp)
> +{
> +    const char *systemctl_args[3] =3D {"systemd-hibernate",
> "systemd-suspend",
> +                                     "systemd-hybrid-sleep"};
> +    const char *cmd[4] =3D {"systemctl", "status", systemctl_args[mode],
> NULL};
> +    int status;
> +
> +    status =3D run_process_child(cmd, errp);
> +
> +    /*
> +     * systemctl status uses LSB return codes so we can expect
> +     * status > 0 and be ok. To assert if the guest has support
> +     * for the selected suspend mode, status should be < 4. 4 is
> +     * the code for unknown service status, the return value when
> +     * the service does not exist. A common value is status =3D 3
> +     * (program is not running).
> +     */
> +    if (status > 0 && status < 4) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +static void systemd_suspend(SuspendMode mode, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    const char *systemctl_args[3] =3D {"hibernate", "suspend",
> "hybrid-sleep"};
> +    const char *cmd[3] =3D {"systemctl", systemctl_args[mode], NULL};
> +    int status;
> +
> +    status =3D run_process_child(cmd, &local_err);
> +
> +    if (status =3D=3D 0) {
> +        return;
> +    }
> +
> +    if ((status =3D=3D -1) && !local_err) {
> +        error_setg(errp, "the helper program 'systemctl %s' was not
> found",
> +                   systemctl_args[mode]);
> +        return;
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    } else {
> +        error_setg(errp, "the helper program 'systemctl %s' returned an =
"
> +                   "unexpected exit status code (%d)",
> +                   systemctl_args[mode], status);
> +    }
> +}
> +
> +static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    const char *pmutils_args[3] =3D {"--hibernate", "--suspend",
> +                                   "--suspend-hybrid"};
> +    const char *cmd[3] =3D {"pm-is-supported", pmutils_args[mode], NULL}=
;
> +    int status;
> +
> +    status =3D run_process_child(cmd, &local_err);
> +
> +    if (status =3D=3D SUSPEND_SUPPORTED) {
> +        return true;
> +    }
> +
> +    if ((status =3D=3D -1) && !local_err) {
> +        return false;
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    } else {
> +        error_setg(errp,
> +                   "the helper program '%s' returned an unexpected exit"
> +                   " status code (%d)", "pm-is-supported", status);
> +    }
> +
> +    return false;
> +}
> +
> +static void pmutils_suspend(SuspendMode mode, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    const char *pmutils_binaries[3] =3D {"pm-hibernate", "pm-suspend",
> +                                       "pm-suspend-hybrid"};
> +    const char *cmd[2] =3D {pmutils_binaries[mode], NULL};
> +    int status;
> +
> +    status =3D run_process_child(cmd, &local_err);
> +
> +    if (status =3D=3D 0) {
> +        return;
> +    }
> +
> +    if ((status =3D=3D -1) && !local_err) {
> +        error_setg(errp, "the helper program '%s' was not found",
> +                   pmutils_binaries[mode]);
> +        return;
> +    }
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    } else {
> +        error_setg(errp,
> +                   "the helper program '%s' returned an unexpected exit"
> +                   " status code (%d)", pmutils_binaries[mode], status);
> +    }
> +}
> +
> +static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp=
)
> +{
> +    const char *sysfile_strs[3] =3D {"disk", "mem", NULL};
> +    const char *sysfile_str =3D sysfile_strs[mode];
> +    char buf[32]; /* hopefully big enough */
> +    int fd;
> +    ssize_t ret;
> +
> +    if (!sysfile_str) {
> +        error_setg(errp, "unknown guest suspend mode");
> +        return false;
> +    }
> +
> +    fd =3D open(LINUX_SYS_STATE_FILE, O_RDONLY);
> +    if (fd < 0) {
> +        return false;
> +    }
> +
> +    ret =3D read(fd, buf, sizeof(buf) - 1);
> +    close(fd);
> +    if (ret <=3D 0) {
> +        return false;
> +    }
> +    buf[ret] =3D '\0';
> +
> +    if (strstr(buf, sysfile_str)) {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
> +{
> +    g_autoptr(GError) local_gerr =3D NULL;
> +    const char *sysfile_strs[3] =3D {"disk", "mem", NULL};
> +    const char *sysfile_str =3D sysfile_strs[mode];
> +
> +    if (!sysfile_str) {
> +        error_setg(errp, "unknown guest suspend mode");
> +        return;
> +    }
> +
> +    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
> +                             -1, &local_gerr)) {
> +        error_setg(errp, "suspend: cannot write to '%s': %s",
> +                   LINUX_SYS_STATE_FILE, local_gerr->message);
> +        return;
> +    }
> +}
> +
> +static void guest_suspend(SuspendMode mode, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    bool mode_supported =3D false;
> +
> +    if (systemd_supports_mode(mode, &local_err)) {
> +        mode_supported =3D true;
> +        systemd_suspend(mode, &local_err);
> +
> +        if (!local_err) {
> +            return;
> +        }
> +    }
> +
> +    error_free(local_err);
> +    local_err =3D NULL;
> +
> +    if (pmutils_supports_mode(mode, &local_err)) {
> +        mode_supported =3D true;
> +        pmutils_suspend(mode, &local_err);
> +
> +        if (!local_err) {
> +            return;
> +        }
> +    }
> +
> +    error_free(local_err);
> +    local_err =3D NULL;
> +
> +    if (linux_sys_state_supports_mode(mode, &local_err)) {
> +        mode_supported =3D true;
> +        linux_sys_state_suspend(mode, &local_err);
> +    }
> +
> +    if (!mode_supported) {
> +        error_free(local_err);
> +        error_setg(errp,
> +                   "the requested suspend mode is not supported by the
> guest");
> +    } else {
> +        error_propagate(errp, local_err);
> +    }
> +}
> +
> +void qmp_guest_suspend_disk(Error **errp)
> +{
> +    guest_suspend(SUSPEND_MODE_DISK, errp);
> +}
> +
> +void qmp_guest_suspend_ram(Error **errp)
> +{
> +    guest_suspend(SUSPEND_MODE_RAM, errp);
> +}
> +
> +void qmp_guest_suspend_hybrid(Error **errp)
> +{
> +    guest_suspend(SUSPEND_MODE_HYBRID, errp);
> +}
> +
>  /* Transfer online/offline status between @vcpu and the guest system.
>   *
>   * On input either @errp or *@errp must be NULL.
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index a8ef41f175..ef21da63be 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1738,271 +1738,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t
> minimum, Error **errp)
>  }
>  #endif /* CONFIG_FSTRIM */
>
> -
> -#define LINUX_SYS_STATE_FILE "/sys/power/state"
> -#define SUSPEND_SUPPORTED 0
> -#define SUSPEND_NOT_SUPPORTED 1
> -
> -typedef enum {
> -    SUSPEND_MODE_DISK =3D 0,
> -    SUSPEND_MODE_RAM =3D 1,
> -    SUSPEND_MODE_HYBRID =3D 2,
> -} SuspendMode;
> -
> -/*
> - * Executes a command in a child process using g_spawn_sync,
> - * returning an int >=3D 0 representing the exit status of the
> - * process.
> - *
> - * If the program wasn't found in path, returns -1.
> - *
> - * If a problem happened when creating the child process,
> - * returns -1 and errp is set.
> - */
> -static int run_process_child(const char *command[], Error **errp)
> -{
> -    int exit_status, spawn_flag;
> -    GError *g_err =3D NULL;
> -    bool success;
> -
> -    spawn_flag =3D G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_NULL |
> -                 G_SPAWN_STDERR_TO_DEV_NULL;
> -
> -    success =3D  g_spawn_sync(NULL, (char **)command, NULL, spawn_flag,
> -                            NULL, NULL, NULL, NULL,
> -                            &exit_status, &g_err);
> -
> -    if (success) {
> -        return WEXITSTATUS(exit_status);
> -    }
> -
> -    if (g_err && (g_err->code !=3D G_SPAWN_ERROR_NOENT)) {
> -        error_setg(errp, "failed to create child process, error '%s'",
> -                   g_err->message);
> -    }
> -
> -    g_error_free(g_err);
> -    return -1;
> -}
> -
> -static bool systemd_supports_mode(SuspendMode mode, Error **errp)
> -{
> -    const char *systemctl_args[3] =3D {"systemd-hibernate",
> "systemd-suspend",
> -                                     "systemd-hybrid-sleep"};
> -    const char *cmd[4] =3D {"systemctl", "status", systemctl_args[mode],
> NULL};
> -    int status;
> -
> -    status =3D run_process_child(cmd, errp);
> -
> -    /*
> -     * systemctl status uses LSB return codes so we can expect
> -     * status > 0 and be ok. To assert if the guest has support
> -     * for the selected suspend mode, status should be < 4. 4 is
> -     * the code for unknown service status, the return value when
> -     * the service does not exist. A common value is status =3D 3
> -     * (program is not running).
> -     */
> -    if (status > 0 && status < 4) {
> -        return true;
> -    }
> -
> -    return false;
> -}
> -
> -static void systemd_suspend(SuspendMode mode, Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    const char *systemctl_args[3] =3D {"hibernate", "suspend",
> "hybrid-sleep"};
> -    const char *cmd[3] =3D {"systemctl", systemctl_args[mode], NULL};
> -    int status;
> -
> -    status =3D run_process_child(cmd, &local_err);
> -
> -    if (status =3D=3D 0) {
> -        return;
> -    }
> -
> -    if ((status =3D=3D -1) && !local_err) {
> -        error_setg(errp, "the helper program 'systemctl %s' was not
> found",
> -                   systemctl_args[mode]);
> -        return;
> -    }
> -
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -    } else {
> -        error_setg(errp, "the helper program 'systemctl %s' returned an =
"
> -                   "unexpected exit status code (%d)",
> -                   systemctl_args[mode], status);
> -    }
> -}
> -
> -static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    const char *pmutils_args[3] =3D {"--hibernate", "--suspend",
> -                                   "--suspend-hybrid"};
> -    const char *cmd[3] =3D {"pm-is-supported", pmutils_args[mode], NULL}=
;
> -    int status;
> -
> -    status =3D run_process_child(cmd, &local_err);
> -
> -    if (status =3D=3D SUSPEND_SUPPORTED) {
> -        return true;
> -    }
> -
> -    if ((status =3D=3D -1) && !local_err) {
> -        return false;
> -    }
> -
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -    } else {
> -        error_setg(errp,
> -                   "the helper program '%s' returned an unexpected exit"
> -                   " status code (%d)", "pm-is-supported", status);
> -    }
> -
> -    return false;
> -}
> -
> -static void pmutils_suspend(SuspendMode mode, Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    const char *pmutils_binaries[3] =3D {"pm-hibernate", "pm-suspend",
> -                                       "pm-suspend-hybrid"};
> -    const char *cmd[2] =3D {pmutils_binaries[mode], NULL};
> -    int status;
> -
> -    status =3D run_process_child(cmd, &local_err);
> -
> -    if (status =3D=3D 0) {
> -        return;
> -    }
> -
> -    if ((status =3D=3D -1) && !local_err) {
> -        error_setg(errp, "the helper program '%s' was not found",
> -                   pmutils_binaries[mode]);
> -        return;
> -    }
> -
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -    } else {
> -        error_setg(errp,
> -                   "the helper program '%s' returned an unexpected exit"
> -                   " status code (%d)", pmutils_binaries[mode], status);
> -    }
> -}
> -
> -static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp=
)
> -{
> -    const char *sysfile_strs[3] =3D {"disk", "mem", NULL};
> -    const char *sysfile_str =3D sysfile_strs[mode];
> -    char buf[32]; /* hopefully big enough */
> -    int fd;
> -    ssize_t ret;
> -
> -    if (!sysfile_str) {
> -        error_setg(errp, "unknown guest suspend mode");
> -        return false;
> -    }
> -
> -    fd =3D open(LINUX_SYS_STATE_FILE, O_RDONLY);
> -    if (fd < 0) {
> -        return false;
> -    }
> -
> -    ret =3D read(fd, buf, sizeof(buf) - 1);
> -    close(fd);
> -    if (ret <=3D 0) {
> -        return false;
> -    }
> -    buf[ret] =3D '\0';
> -
> -    if (strstr(buf, sysfile_str)) {
> -        return true;
> -    }
> -    return false;
> -}
> -
> -static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
> -{
> -    g_autoptr(GError) local_gerr =3D NULL;
> -    const char *sysfile_strs[3] =3D {"disk", "mem", NULL};
> -    const char *sysfile_str =3D sysfile_strs[mode];
> -
> -    if (!sysfile_str) {
> -        error_setg(errp, "unknown guest suspend mode");
> -        return;
> -    }
> -
> -    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
> -                             -1, &local_gerr)) {
> -        error_setg(errp, "suspend: cannot write to '%s': %s",
> -                   LINUX_SYS_STATE_FILE, local_gerr->message);
> -        return;
> -    }
> -}
> -
> -static void guest_suspend(SuspendMode mode, Error **errp)
> -{
> -    Error *local_err =3D NULL;
> -    bool mode_supported =3D false;
> -
> -    if (systemd_supports_mode(mode, &local_err)) {
> -        mode_supported =3D true;
> -        systemd_suspend(mode, &local_err);
> -
> -        if (!local_err) {
> -            return;
> -        }
> -    }
> -
> -    error_free(local_err);
> -    local_err =3D NULL;
> -
> -    if (pmutils_supports_mode(mode, &local_err)) {
> -        mode_supported =3D true;
> -        pmutils_suspend(mode, &local_err);
> -
> -        if (!local_err) {
> -            return;
> -        }
> -    }
> -
> -    error_free(local_err);
> -    local_err =3D NULL;
> -
> -    if (linux_sys_state_supports_mode(mode, &local_err)) {
> -        mode_supported =3D true;
> -        linux_sys_state_suspend(mode, &local_err);
> -    }
> -
> -    if (!mode_supported) {
> -        error_free(local_err);
> -        error_setg(errp,
> -                   "the requested suspend mode is not supported by the
> guest");
> -    } else {
> -        error_propagate(errp, local_err);
> -    }
> -}
> -
> -void qmp_guest_suspend_disk(Error **errp)
> -{
> -    guest_suspend(SUSPEND_MODE_DISK, errp);
> -}
> -
> -void qmp_guest_suspend_ram(Error **errp)
> -{
> -    guest_suspend(SUSPEND_MODE_RAM, errp);
> -}
> -
> -void qmp_guest_suspend_hybrid(Error **errp)
> -{
> -    guest_suspend(SUSPEND_MODE_HYBRID, errp);
> -}
> -
>  #endif /* __linux__ */
>
>  #if defined(__linux__) || defined(__FreeBSD__)
> --
> 2.45.1
>
>

--000000000000b15ee0061d08af42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:02=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">The qmp_guest_suspend_{disk,ram,hybrid} command impls i=
n<br>
commands-posix.c are surrounded by &#39;#ifdef __linux__&#39; so should<br>
instead live in commands-linux.c<br>
<br>
Reviewed-by: Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@=
linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-linux.c | 265 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-posix.c | 265 ------------------------------------------=
-<br>
=C2=A02 files changed, 265 insertions(+), 265 deletions(-)<br>
<br>
diff --git a/qga/commands-linux.c b/qga/commands-linux.c<br>
index 78580ac39d..3fabf54882 100644<br>
--- a/qga/commands-linux.c<br>
+++ b/qga/commands-linux.c<br>
@@ -286,6 +286,271 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_FSFREEZE */<br>
<br>
+<br>
+#define LINUX_SYS_STATE_FILE &quot;/sys/power/state&quot;<br>
+#define SUSPEND_SUPPORTED 0<br>
+#define SUSPEND_NOT_SUPPORTED 1<br>
+<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 SUSPEND_MODE_DISK =3D 0,<br>
+=C2=A0 =C2=A0 SUSPEND_MODE_RAM =3D 1,<br>
+=C2=A0 =C2=A0 SUSPEND_MODE_HYBRID =3D 2,<br>
+} SuspendMode;<br>
+<br>
+/*<br>
+ * Executes a command in a child process using g_spawn_sync,<br>
+ * returning an int &gt;=3D 0 representing the exit status of the<br>
+ * process.<br>
+ *<br>
+ * If the program wasn&#39;t found in path, returns -1.<br>
+ *<br>
+ * If a problem happened when creating the child process,<br>
+ * returns -1 and errp is set.<br>
+ */<br>
+static int run_process_child(const char *command[], Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 int exit_status, spawn_flag;<br>
+=C2=A0 =C2=A0 GError *g_err =3D NULL;<br>
+=C2=A0 =C2=A0 bool success;<br>
+<br>
+=C2=A0 =C2=A0 spawn_flag =3D G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_N=
ULL |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0G_SPAWN_STDE=
RR_TO_DEV_NULL;<br>
+<br>
+=C2=A0 =C2=A0 success =3D=C2=A0 g_spawn_sync(NULL, (char **)command, NULL,=
 spawn_flag,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;exit_status, &amp;g_err);<br>
+<br>
+=C2=A0 =C2=A0 if (success) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return WEXITSTATUS(exit_status);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (g_err &amp;&amp; (g_err-&gt;code !=3D G_SPAWN_ERROR_NOEN=
T)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to create child =
process, error &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_err=
-&gt;message);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_error_free(g_err);<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
+static bool systemd_supports_mode(SuspendMode mode, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 const char *systemctl_args[3] =3D {&quot;systemd-hibernate&q=
uot;, &quot;systemd-suspend&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;systemd-hy=
brid-sleep&quot;};<br>
+=C2=A0 =C2=A0 const char *cmd[4] =3D {&quot;systemctl&quot;, &quot;status&=
quot;, systemctl_args[mode], NULL};<br>
+=C2=A0 =C2=A0 int status;<br>
+<br>
+=C2=A0 =C2=A0 status =3D run_process_child(cmd, errp);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* systemctl status uses LSB return codes so we can exp=
ect<br>
+=C2=A0 =C2=A0 =C2=A0* status &gt; 0 and be ok. To assert if the guest has =
support<br>
+=C2=A0 =C2=A0 =C2=A0* for the selected suspend mode, status should be &lt;=
 4. 4 is<br>
+=C2=A0 =C2=A0 =C2=A0* the code for unknown service status, the return valu=
e when<br>
+=C2=A0 =C2=A0 =C2=A0* the service does not exist. A common value is status=
 =3D 3<br>
+=C2=A0 =C2=A0 =C2=A0* (program is not running).<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (status &gt; 0 &amp;&amp; status &lt; 4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+static void systemd_suspend(SuspendMode mode, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 const char *systemctl_args[3] =3D {&quot;hibernate&quot;, &q=
uot;suspend&quot;, &quot;hybrid-sleep&quot;};<br>
+=C2=A0 =C2=A0 const char *cmd[3] =3D {&quot;systemctl&quot;, systemctl_arg=
s[mode], NULL};<br>
+=C2=A0 =C2=A0 int status;<br>
+<br>
+=C2=A0 =C2=A0 status =3D run_process_child(cmd, &amp;local_err);<br>
+<br>
+=C2=A0 =C2=A0 if (status =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if ((status =3D=3D -1) &amp;&amp; !local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;the helper program &#39=
;systemctl %s&#39; was not found&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
mctl_args[mode]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;the helper program &#39=
;systemctl %s&#39; returned an &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;unexpected exit status code (%d)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
mctl_args[mode], status);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool pmutils_supports_mode(SuspendMode mode, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 const char *pmutils_args[3] =3D {&quot;--hibernate&quot;, &q=
uot;--suspend&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--suspend-hybrid&=
quot;};<br>
+=C2=A0 =C2=A0 const char *cmd[3] =3D {&quot;pm-is-supported&quot;, pmutils=
_args[mode], NULL};<br>
+=C2=A0 =C2=A0 int status;<br>
+<br>
+=C2=A0 =C2=A0 status =3D run_process_child(cmd, &amp;local_err);<br>
+<br>
+=C2=A0 =C2=A0 if (status =3D=3D SUSPEND_SUPPORTED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if ((status =3D=3D -1) &amp;&amp; !local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the helper program &#39;%s&#39; returned an unexpected exit&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; status code (%d)&quot;, &quot;pm-is-supported&quot;, status);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+static void pmutils_suspend(SuspendMode mode, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 const char *pmutils_binaries[3] =3D {&quot;pm-hibernate&quot=
;, &quot;pm-suspend&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pm-=
suspend-hybrid&quot;};<br>
+=C2=A0 =C2=A0 const char *cmd[2] =3D {pmutils_binaries[mode], NULL};<br>
+=C2=A0 =C2=A0 int status;<br>
+<br>
+=C2=A0 =C2=A0 status =3D run_process_child(cmd, &amp;local_err);<br>
+<br>
+=C2=A0 =C2=A0 if (status =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if ((status =3D=3D -1) &amp;&amp; !local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;the helper program &#39=
;%s&#39; was not found&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmuti=
ls_binaries[mode]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the helper program &#39;%s&#39; returned an unexpected exit&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; status code (%d)&quot;, pmutils_binaries[mode], status);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)<=
br>
+{<br>
+=C2=A0 =C2=A0 const char *sysfile_strs[3] =3D {&quot;disk&quot;, &quot;mem=
&quot;, NULL};<br>
+=C2=A0 =C2=A0 const char *sysfile_str =3D sysfile_strs[mode];<br>
+=C2=A0 =C2=A0 char buf[32]; /* hopefully big enough */<br>
+=C2=A0 =C2=A0 int fd;<br>
+=C2=A0 =C2=A0 ssize_t ret;<br>
+<br>
+=C2=A0 =C2=A0 if (!sysfile_str) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unknown guest suspend m=
ode&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fd =3D open(LINUX_SYS_STATE_FILE, O_RDONLY);<br>
+=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D read(fd, buf, sizeof(buf) - 1);<br>
+=C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 if (ret &lt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 buf[ret] =3D &#39;\0&#39;;<br>
+<br>
+=C2=A0 =C2=A0 if (strstr(buf, sysfile_str)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+static void linux_sys_state_suspend(SuspendMode mode, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autoptr(GError) local_gerr =3D NULL;<br>
+=C2=A0 =C2=A0 const char *sysfile_strs[3] =3D {&quot;disk&quot;, &quot;mem=
&quot;, NULL};<br>
+=C2=A0 =C2=A0 const char *sysfile_str =3D sysfile_strs[mode];<br>
+<br>
+=C2=A0 =C2=A0 if (!sysfile_str) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unknown guest suspend m=
ode&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1, &amp;local_gerr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;suspend: cannot write t=
o &#39;%s&#39;: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LINUX=
_SYS_STATE_FILE, local_gerr-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void guest_suspend(SuspendMode mode, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 bool mode_supported =3D false;<br>
+<br>
+=C2=A0 =C2=A0 if (systemd_supports_mode(mode, &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 systemd_suspend(mode, &amp;local_err);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (pmutils_supports_mode(mode, &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmutils_suspend(mode, &amp;local_err);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (linux_sys_state_supports_mode(mode, &amp;local_err)) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 linux_sys_state_suspend(mode, &amp;local_err);=
<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!mode_supported) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the requested suspend mode is not supported by the guest&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void qmp_guest_suspend_disk(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 guest_suspend(SUSPEND_MODE_DISK, errp);<br>
+}<br>
+<br>
+void qmp_guest_suspend_ram(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 guest_suspend(SUSPEND_MODE_RAM, errp);<br>
+}<br>
+<br>
+void qmp_guest_suspend_hybrid(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 guest_suspend(SUSPEND_MODE_HYBRID, errp);<br>
+}<br>
+<br>
=C2=A0/* Transfer online/offline status between @vcpu and the guest system.=
<br>
=C2=A0 *<br>
=C2=A0 * On input either @errp or *@errp must be NULL.<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index a8ef41f175..ef21da63be 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1738,271 +1738,6 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum,=
 Error **errp)<br>
=C2=A0}<br>
=C2=A0#endif /* CONFIG_FSTRIM */<br>
<br>
-<br>
-#define LINUX_SYS_STATE_FILE &quot;/sys/power/state&quot;<br>
-#define SUSPEND_SUPPORTED 0<br>
-#define SUSPEND_NOT_SUPPORTED 1<br>
-<br>
-typedef enum {<br>
-=C2=A0 =C2=A0 SUSPEND_MODE_DISK =3D 0,<br>
-=C2=A0 =C2=A0 SUSPEND_MODE_RAM =3D 1,<br>
-=C2=A0 =C2=A0 SUSPEND_MODE_HYBRID =3D 2,<br>
-} SuspendMode;<br>
-<br>
-/*<br>
- * Executes a command in a child process using g_spawn_sync,<br>
- * returning an int &gt;=3D 0 representing the exit status of the<br>
- * process.<br>
- *<br>
- * If the program wasn&#39;t found in path, returns -1.<br>
- *<br>
- * If a problem happened when creating the child process,<br>
- * returns -1 and errp is set.<br>
- */<br>
-static int run_process_child(const char *command[], Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 int exit_status, spawn_flag;<br>
-=C2=A0 =C2=A0 GError *g_err =3D NULL;<br>
-=C2=A0 =C2=A0 bool success;<br>
-<br>
-=C2=A0 =C2=A0 spawn_flag =3D G_SPAWN_SEARCH_PATH | G_SPAWN_STDOUT_TO_DEV_N=
ULL |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0G_SPAWN_STDE=
RR_TO_DEV_NULL;<br>
-<br>
-=C2=A0 =C2=A0 success =3D=C2=A0 g_spawn_sync(NULL, (char **)command, NULL,=
 spawn_flag,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, NULL, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;exit_status, &amp;g_err);<br>
-<br>
-=C2=A0 =C2=A0 if (success) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return WEXITSTATUS(exit_status);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (g_err &amp;&amp; (g_err-&gt;code !=3D G_SPAWN_ERROR_NOEN=
T)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to create child =
process, error &#39;%s&#39;&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_err=
-&gt;message);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 g_error_free(g_err);<br>
-=C2=A0 =C2=A0 return -1;<br>
-}<br>
-<br>
-static bool systemd_supports_mode(SuspendMode mode, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 const char *systemctl_args[3] =3D {&quot;systemd-hibernate&q=
uot;, &quot;systemd-suspend&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;systemd-hy=
brid-sleep&quot;};<br>
-=C2=A0 =C2=A0 const char *cmd[4] =3D {&quot;systemctl&quot;, &quot;status&=
quot;, systemctl_args[mode], NULL};<br>
-=C2=A0 =C2=A0 int status;<br>
-<br>
-=C2=A0 =C2=A0 status =3D run_process_child(cmd, errp);<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* systemctl status uses LSB return codes so we can exp=
ect<br>
-=C2=A0 =C2=A0 =C2=A0* status &gt; 0 and be ok. To assert if the guest has =
support<br>
-=C2=A0 =C2=A0 =C2=A0* for the selected suspend mode, status should be &lt;=
 4. 4 is<br>
-=C2=A0 =C2=A0 =C2=A0* the code for unknown service status, the return valu=
e when<br>
-=C2=A0 =C2=A0 =C2=A0* the service does not exist. A common value is status=
 =3D 3<br>
-=C2=A0 =C2=A0 =C2=A0* (program is not running).<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 if (status &gt; 0 &amp;&amp; status &lt; 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return false;<br>
-}<br>
-<br>
-static void systemd_suspend(SuspendMode mode, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 const char *systemctl_args[3] =3D {&quot;hibernate&quot;, &q=
uot;suspend&quot;, &quot;hybrid-sleep&quot;};<br>
-=C2=A0 =C2=A0 const char *cmd[3] =3D {&quot;systemctl&quot;, systemctl_arg=
s[mode], NULL};<br>
-=C2=A0 =C2=A0 int status;<br>
-<br>
-=C2=A0 =C2=A0 status =3D run_process_child(cmd, &amp;local_err);<br>
-<br>
-=C2=A0 =C2=A0 if (status =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if ((status =3D=3D -1) &amp;&amp; !local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;the helper program &#39=
;systemctl %s&#39; was not found&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
mctl_args[mode]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;the helper program &#39=
;systemctl %s&#39; returned an &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;unexpected exit status code (%d)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syste=
mctl_args[mode], status);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static bool pmutils_supports_mode(SuspendMode mode, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 const char *pmutils_args[3] =3D {&quot;--hibernate&quot;, &q=
uot;--suspend&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;--suspend-hybrid&=
quot;};<br>
-=C2=A0 =C2=A0 const char *cmd[3] =3D {&quot;pm-is-supported&quot;, pmutils=
_args[mode], NULL};<br>
-=C2=A0 =C2=A0 int status;<br>
-<br>
-=C2=A0 =C2=A0 status =3D run_process_child(cmd, &amp;local_err);<br>
-<br>
-=C2=A0 =C2=A0 if (status =3D=3D SUSPEND_SUPPORTED) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if ((status =3D=3D -1) &amp;&amp; !local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the helper program &#39;%s&#39; returned an unexpected exit&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; status code (%d)&quot;, &quot;pm-is-supported&quot;, status);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return false;<br>
-}<br>
-<br>
-static void pmutils_suspend(SuspendMode mode, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 const char *pmutils_binaries[3] =3D {&quot;pm-hibernate&quot=
;, &quot;pm-suspend&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;pm-=
suspend-hybrid&quot;};<br>
-=C2=A0 =C2=A0 const char *cmd[2] =3D {pmutils_binaries[mode], NULL};<br>
-=C2=A0 =C2=A0 int status;<br>
-<br>
-=C2=A0 =C2=A0 status =3D run_process_child(cmd, &amp;local_err);<br>
-<br>
-=C2=A0 =C2=A0 if (status =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if ((status =3D=3D -1) &amp;&amp; !local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;the helper program &#39=
;%s&#39; was not found&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pmuti=
ls_binaries[mode]);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the helper program &#39;%s&#39; returned an unexpected exit&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; status code (%d)&quot;, pmutils_binaries[mode], status);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)<=
br>
-{<br>
-=C2=A0 =C2=A0 const char *sysfile_strs[3] =3D {&quot;disk&quot;, &quot;mem=
&quot;, NULL};<br>
-=C2=A0 =C2=A0 const char *sysfile_str =3D sysfile_strs[mode];<br>
-=C2=A0 =C2=A0 char buf[32]; /* hopefully big enough */<br>
-=C2=A0 =C2=A0 int fd;<br>
-=C2=A0 =C2=A0 ssize_t ret;<br>
-<br>
-=C2=A0 =C2=A0 if (!sysfile_str) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unknown guest suspend m=
ode&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 fd =3D open(LINUX_SYS_STATE_FILE, O_RDONLY);<br>
-=C2=A0 =C2=A0 if (fd &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 ret =3D read(fd, buf, sizeof(buf) - 1);<br>
-=C2=A0 =C2=A0 close(fd);<br>
-=C2=A0 =C2=A0 if (ret &lt;=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 buf[ret] =3D &#39;\0&#39;;<br>
-<br>
-=C2=A0 =C2=A0 if (strstr(buf, sysfile_str)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return false;<br>
-}<br>
-<br>
-static void linux_sys_state_suspend(SuspendMode mode, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 g_autoptr(GError) local_gerr =3D NULL;<br>
-=C2=A0 =C2=A0 const char *sysfile_strs[3] =3D {&quot;disk&quot;, &quot;mem=
&quot;, NULL};<br>
-=C2=A0 =C2=A0 const char *sysfile_str =3D sysfile_strs[mode];<br>
-<br>
-=C2=A0 =C2=A0 if (!sysfile_str) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unknown guest suspend m=
ode&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-1, &amp;local_gerr)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;suspend: cannot write t=
o &#39;%s&#39;: %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LINUX=
_SYS_STATE_FILE, local_gerr-&gt;message);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-static void guest_suspend(SuspendMode mode, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-=C2=A0 =C2=A0 bool mode_supported =3D false;<br>
-<br>
-=C2=A0 =C2=A0 if (systemd_supports_mode(mode, &amp;local_err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 systemd_suspend(mode, &amp;local_err);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 error_free(local_err);<br>
-=C2=A0 =C2=A0 local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (pmutils_supports_mode(mode, &amp;local_err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 pmutils_suspend(mode, &amp;local_err);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 error_free(local_err);<br>
-=C2=A0 =C2=A0 local_err =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (linux_sys_state_supports_mode(mode, &amp;local_err)) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 mode_supported =3D true;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 linux_sys_state_suspend(mode, &amp;local_err);=
<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (!mode_supported) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the requested suspend mode is not supported by the guest&quot;);<br>
-=C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
-<br>
-void qmp_guest_suspend_disk(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 guest_suspend(SUSPEND_MODE_DISK, errp);<br>
-}<br>
-<br>
-void qmp_guest_suspend_ram(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 guest_suspend(SUSPEND_MODE_RAM, errp);<br>
-}<br>
-<br>
-void qmp_guest_suspend_hybrid(Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 guest_suspend(SUSPEND_MODE_HYBRID, errp);<br>
-}<br>
-<br>
=C2=A0#endif /* __linux__ */<br>
<br>
=C2=A0#if defined(__linux__) || defined(__FreeBSD__)<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--000000000000b15ee0061d08af42--


