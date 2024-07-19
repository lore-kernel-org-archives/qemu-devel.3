Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF11C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 07:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiAT-0004PW-Pp; Fri, 19 Jul 2024 03:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUiAS-0004HS-Eh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sUiAP-0000Q6-In
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 03:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721374596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t7rxHyyzTYlcJzLED36vPZ+oxEpQA8aNM9S33cZwSaM=;
 b=AzXTcpL/PUwwZtOdoX3AqY3O8Z/vkvqu3U34gpT+8BJt5pACqSyjmjGai28uIqB2sjyTJT
 bPSxO9piJZzchRSfbbTmbxnfTF9AzQ+FSUpIVMgspCmYexB4C8DDWAIrICkpnxMjAE6fAp
 I5L96/kFiN/yV38qSsrcyI4NPpZneJo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-i6GmpPMWPQueuWxpYZD8yw-1; Fri, 19 Jul 2024 03:36:34 -0400
X-MC-Unique: i6GmpPMWPQueuWxpYZD8yw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6698f11853aso9260447b3.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 00:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721374594; x=1721979394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7rxHyyzTYlcJzLED36vPZ+oxEpQA8aNM9S33cZwSaM=;
 b=i/EWKuW2aReM8onrtT0/rvbrUNCwIBJO59Rk+lOzvlQITia59gSyrFNbiWRSU6ORpH
 RbLk2jE0FixQpfQwbcQYOO+NNi+XMbY6gVFyz5hw8sVc+48VHP/cX/D5aqQh2VJUDGhm
 vpNMALI0V0voNciBgsIIakSaa14P3CGHYC3zm5dgwPTn/Tag8GDpu+WBRx8ttX6grHMp
 q0DBImf2WGxlCpm9Capvy7KL9rsfaQznwqfr6Qas08Lw3faOpxyfF/t7iPSdeFw4qk1d
 lVe7xrVQUiAvQ1qNVaw2YVx2qs5MWEwiiqT6i0IIuiSHwYj1NQnRQOf7OVwGkBYj1nEN
 Irlw==
X-Gm-Message-State: AOJu0Ywrct+mUCUTyQ6cCy9mEF+dWMxwZ8hsazFmS+RX4ex5pKIuAZt/
 alvtr83v/jAhdzOXRJymsW3eN5ATuY5xYUNA4ooOt5jVdRvNUA3ilwez92DoFTZQGvdzJ7YgmqU
 lgoneyeMRxz8QPg8RfL/3VAjjny7wUe/dhF4m/w4FHPUtexG9WxZexlkv1cDh54ReeNqiPal9FX
 XoDXgSF3zuoAj6edy7BE2PGY4yWSyxeZP7xttoCQ==
X-Received: by 2002:a81:91c7:0:b0:650:a1cb:b122 with SMTP id
 00721157ae682-664fed0c8cdmr86252147b3.27.1721374594292; 
 Fri, 19 Jul 2024 00:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE81CtSmClB2SkXe3Ezf7LWK3ao817s7uNKssSDEUc+c4ddGe22NA9hrE6PB1SAPLmD8cqufC0DflueMmkQfKM=
X-Received: by 2002:a81:91c7:0:b0:650:a1cb:b122 with SMTP id
 00721157ae682-664fed0c8cdmr86252087b3.27.1721374594015; Fri, 19 Jul 2024
 00:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240712132459.3974109-1-berrange@redhat.com>
 <20240712132459.3974109-23-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-23-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 19 Jul 2024 10:36:23 +0300
Message-ID: <CAPMcbCpLcOnyyQApmR17W0w4AQGraYzQZCu=uktwFoE=NNwcvg@mail.gmail.com>
Subject: Re: [PATCH v3 22/22] qga: centralize logic for disabling/enabling
 commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000033b823061d94c115"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--00000000000033b823061d94c115
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Fri, Jul 12, 2024 at 4:26=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> It is confusing having many different pieces of code enabling and
> disabling commands, and it is not clear that they all have the same
> semantics, especially wrt prioritization of the block/allow lists.
> The code attempted to prevent the user from setting both the block
> and allow lists concurrently, however, the logic was flawed as it
> checked settings in the configuration file  separately from the
> command line arguments. Thus it was possible to set a block list
> in the config file and an allow list via a command line argument.
> The --dump-conf option also creates a configuration file with both
> keys present, even if unset, which means it is creating a config
> that cannot actually be loaded again.
>
> Centralizing the code in a single method "ga_apply_command_filters"
> will provide a strong guarantee of consistency and clarify the
> intended behaviour. With this there is no compelling technical
> reason to prevent concurrent setting of both the allow and block
> lists, so this flawed restriction is removed.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/interop/qemu-ga.rst |  14 +++++
>  qga/commands-posix.c     |   6 --
>  qga/commands-win32.c     |   6 --
>  qga/main.c               | 128 +++++++++++++++++----------------------
>  4 files changed, 70 insertions(+), 84 deletions(-)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index e42b370319..fb75cfd8d4 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -28,6 +28,20 @@ configuration options on the command line. For the sam=
e
> key, the last
>  option wins, but the lists accumulate (see below for configuration
>  file format).
>
> +If an allowed RPCs list is defined in the configuration, then all
> +RPCs will be blocked by default, except for the allowed list.
> +
> +If a blocked RPCs list is defined in the configuration, then all
> +RPCs will be allowed by default, except for the blocked list.
> +
> +If both allowed and blocked RPCs lists are defined in the configuration,
> +then all RPCs will be blocked by default, then the allowed list will
> +be applied, followed by the blocked list.
> +
> +While filesystems are frozen, all except for a designated safe set
> +of RPCs will blocked, regardless of what the general configuration
> +declares.
> +
>  Options
>  -------
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index f4104f2760..578d29f228 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -1136,12 +1136,6 @@ error:
>
>  #endif /* HAVE_GETIFADDRS */
>
> -/* add unsupported commands to the list of blocked RPCs */
> -GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> -{
> -    return blockedrpcs;
> -}
> -
>  /* register init/cleanup routines for stateful command groups */
>  void ga_command_state_init(GAState *s, GACommandState *cs)
>  {
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 5866cc2e3c..61b36da469 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1958,12 +1958,6 @@ done:
>      g_free(rawpasswddata);
>  }
>
> -/* add unsupported commands to the list of blocked RPCs */
> -GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> -{
> -    return blockedrpcs;
> -}
> -
>  /* register init/cleanup routines for stateful command groups */
>  void ga_command_state_init(GAState *s, GACommandState *cs)
>  {
> diff --git a/qga/main.c b/qga/main.c
> index 6ae911eb15..b8f7b1e4a3 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -423,60 +423,79 @@ static gint ga_strcmp(gconstpointer str1,
> gconstpointer str2)
>      return strcmp(str1, str2);
>  }
>
> -/* disable commands that aren't safe for fsfreeze */
> -static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void
> *opaque)
> +static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)
>  {
> -    bool allowed =3D false;
>      int i =3D 0;
> +    GAConfig *config =3D state->config;
>      const char *name =3D qmp_command_name(cmd);
> +    /* Fallback policy is allow everything */
> +    bool allowed =3D true;
>
> -    while (ga_freeze_allowlist[i] !=3D NULL) {
> -        if (strcmp(name, ga_freeze_allowlist[i]) =3D=3D 0) {
> +    if (config->allowedrpcs) {
> +        /*
> +         * If an allow-list is given, this changes the fallback
> +         * policy to deny everything
> +         */
> +        allowed =3D false;
> +
> +        if (g_list_find_custom(config->allowedrpcs, name, ga_strcmp) !=
=3D
> NULL) {
>              allowed =3D true;
>          }
> -        i++;
>      }
> -    if (!allowed) {
> -        g_debug("disabling command: %s", name);
> -        qmp_disable_command(&ga_commands, name, "the agent is in frozen
> state");
> -    }
> -}
>
> -/* [re-]enable all commands, except those explicitly blocked by user */
> -static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
> -{
> -    GAState *s =3D opaque;
> -    GList *blockedrpcs =3D s->blockedrpcs;
> -    GList *allowedrpcs =3D s->allowedrpcs;
> -    const char *name =3D qmp_command_name(cmd);
> -
> -    if (g_list_find_custom(blockedrpcs, name, ga_strcmp) =3D=3D NULL) {
> -        if (qmp_command_is_enabled(cmd)) {
> -            return;
> +    /*
> +     * If both allowedrpcs and blockedrpcs are set, the blocked
> +     * list will take priority
> +     */
> +    if (config->blockedrpcs) {
> +        if (g_list_find_custom(config->blockedrpcs, name, ga_strcmp) !=
=3D
> NULL) {
> +            allowed =3D false;
>          }
> +    }
>
> -        if (allowedrpcs &&
> -            g_list_find_custom(allowedrpcs, name, ga_strcmp) =3D=3D NULL=
) {
> -            return;
> -        }
> +    /*
> +     * If frozen, this filtering must take priority over
> +     * absolutely everything
> +     */
> +    if (state->frozen) {
> +        allowed =3D false;
>
> -        g_debug("enabling command: %s", name);
> -        qmp_enable_command(&ga_commands, name);
> +        while (ga_freeze_allowlist[i] !=3D NULL) {
> +            if (strcmp(name, ga_freeze_allowlist[i]) =3D=3D 0) {
> +                allowed =3D true;
> +            }
> +            i++;
> +        }
>      }
> +
> +    return allowed;
>  }
>
> -/* disable commands that aren't allowed */
> -static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
> +static void ga_apply_command_filters_iter(const QmpCommand *cmd, void
> *opaque)
>  {
> -    GList *allowedrpcs =3D opaque;
> +    GAState *state =3D opaque;
> +    bool want =3D ga_command_is_allowed(cmd, state);
> +    bool have =3D qmp_command_is_enabled(cmd);
>      const char *name =3D qmp_command_name(cmd);
>
> -    if (g_list_find_custom(allowedrpcs, name, ga_strcmp) =3D=3D NULL) {
> +    if (want =3D=3D have) {
> +        return;
> +    }
> +
> +    if (have) {
>          g_debug("disabling command: %s", name);
>          qmp_disable_command(&ga_commands, name, "the command is not
> allowed");
> +    } else {
> +        g_debug("enabling command: %s", name);
> +        qmp_enable_command(&ga_commands, name);
>      }
>  }
>
> +static void ga_apply_command_filters(GAState *state)
> +{
> +    qmp_for_each_command(&ga_commands, ga_apply_command_filters_iter,
> state);
> +}
> +
>  static bool ga_create_file(const char *path)
>  {
>      int fd =3D open(path, O_CREAT | O_WRONLY, S_IWUSR | S_IRUSR);
> @@ -509,15 +528,14 @@ void ga_set_frozen(GAState *s)
>      if (ga_is_frozen(s)) {
>          return;
>      }
> -    /* disable all forbidden (for frozen state) commands */
> -    qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze,
> NULL);
>      g_warning("disabling logging due to filesystem freeze");
> -    ga_disable_logging(s);
>      s->frozen =3D true;
>      if (!ga_create_file(s->state_filepath_isfrozen)) {
>          g_warning("unable to create %s, fsfreeze may not function
> properly",
>                    s->state_filepath_isfrozen);
>      }
> +    ga_apply_command_filters(s);
> +    ga_disable_logging(s);
>  }
>
>  void ga_unset_frozen(GAState *s)
> @@ -549,12 +567,12 @@ void ga_unset_frozen(GAState *s)
>      }
>
>      /* enable all disabled, non-blocked and allowed commands */
> -    qmp_for_each_command(&ga_commands, ga_enable_non_blocked, s);
>      s->frozen =3D false;
>      if (!ga_delete_file(s->state_filepath_isfrozen)) {
>          g_warning("unable to delete %s, fsfreeze may not function
> properly",
>                    s->state_filepath_isfrozen);
>      }
> +    ga_apply_command_filters(s);
>  }
>
>  #ifdef CONFIG_FSFREEZE
> @@ -1086,13 +1104,6 @@ static void config_load(GAConfig *config, const
> char *confpath, bool required)
>                                            split_list(config->aliststr,
> ","));
>      }
>
> -    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL) &&
> -        g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
> -        g_critical("wrong config, using 'block-rpcs' and 'allow-rpcs'
> keys at"
> -                   " the same time is not allowed");
> -        exit(EXIT_FAILURE);
> -    }
> -
>  end:
>      g_key_file_free(keyfile);
>      if (gerr && (required ||
> @@ -1172,7 +1183,6 @@ static void config_parse(GAConfig *config, int argc=
,
> char **argv)
>  {
>      const char *sopt =3D "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
>      int opt_ind =3D 0, ch;
> -    bool block_rpcs =3D false, allow_rpcs =3D false;
>      const struct option lopt[] =3D {
>          { "help", 0, NULL, 'h' },
>          { "version", 0, NULL, 'V' },
> @@ -1268,7 +1278,6 @@ static void config_parse(GAConfig *config, int argc=
,
> char **argv)
>              }
>              config->blockedrpcs =3D g_list_concat(config->blockedrpcs,
>                                                  split_list(optarg, ","))=
;
> -            block_rpcs =3D true;
>              break;
>          }
>          case 'a': {
> @@ -1278,7 +1287,6 @@ static void config_parse(GAConfig *config, int argc=
,
> char **argv)
>              }
>              config->allowedrpcs =3D g_list_concat(config->allowedrpcs,
>                                                  split_list(optarg, ","))=
;
> -            allow_rpcs =3D true;
>              break;
>          }
>  #ifdef _WIN32
> @@ -1319,12 +1327,6 @@ static void config_parse(GAConfig *config, int
> argc, char **argv)
>              exit(EXIT_FAILURE);
>          }
>      }
> -
> -    if (block_rpcs && allow_rpcs) {
> -        g_critical("wrong commandline, using --block-rpcs and
> --allow-rpcs at the"
> -                   " same time is not allowed");
> -        exit(EXIT_FAILURE);
> -    }
>  }
>
>  static void config_free(GAConfig *config)
> @@ -1435,7 +1437,6 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>              s->deferred_options.log_filepath =3D config->log_filepath;
>          }
>          ga_disable_logging(s);
> -        qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze=
,
> NULL);
>      } else {
>          if (config->daemonize) {
>              become_daemon(config->pid_filepath);
> @@ -1459,25 +1460,6 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>          return NULL;
>      }
>
> -    if (config->allowedrpcs) {
> -        qmp_for_each_command(&ga_commands, ga_disable_not_allowed,
> config->allowedrpcs);
> -        s->allowedrpcs =3D config->allowedrpcs;
> -    }
> -
> -    /*
> -     * Some commands can be blocked due to system limitation.
> -     * Initialize blockedrpcs list even if allowedrpcs specified.
> -     */
> -    config->blockedrpcs =3D
> ga_command_init_blockedrpcs(config->blockedrpcs);
> -    if (config->blockedrpcs) {
> -        GList *l =3D config->blockedrpcs;
> -        s->blockedrpcs =3D config->blockedrpcs;
> -        do {
> -            g_debug("disabling command: %s", (char *)l->data);
> -            qmp_disable_command(&ga_commands, l->data, NULL);
> -            l =3D g_list_next(l);
> -        } while (l);
> -    }
>      s->command_state =3D ga_command_state_new();
>      ga_command_state_init(s, s->command_state);
>      ga_command_state_init_all(s->command_state);
> @@ -1503,6 +1485,8 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>      }
>  #endif
>
> +    ga_apply_command_filters(s);
> +
>      ga_state =3D s;
>      return s;
>  }
> --
> 2.45.1
>
>

--00000000000033b823061d94c115
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 12, 2024 at 4:26=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">It is confusing having many different pieces of code en=
abling and<br>
disabling commands, and it is not clear that they all have the same<br>
semantics, especially wrt prioritization of the block/allow lists.<br>
The code attempted to prevent the user from setting both the block<br>
and allow lists concurrently, however, the logic was flawed as it<br>
checked settings in the configuration file=C2=A0 separately from the<br>
command line arguments. Thus it was possible to set a block list<br>
in the config file and an allow list via a command line argument.<br>
The --dump-conf option also creates a configuration file with both<br>
keys present, even if unset, which means it is creating a config<br>
that cannot actually be loaded again.<br>
<br>
Centralizing the code in a single method &quot;ga_apply_command_filters&quo=
t;<br>
will provide a strong guarantee of consistency and clarify the<br>
intended behaviour. With this there is no compelling technical<br>
reason to prevent concurrent setting of both the allow and block<br>
lists, so this flawed restriction is removed.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/qemu-ga.rst |=C2=A0 14 +++++<br>
=C2=A0qga/commands-posix.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 --<br>
=C2=A0qga/commands-win32.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 --<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12=
8 +++++++++++++++++----------------------<br>
=C2=A04 files changed, 70 insertions(+), 84 deletions(-)<br>
<br>
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst<br>
index e42b370319..fb75cfd8d4 100644<br>
--- a/docs/interop/qemu-ga.rst<br>
+++ b/docs/interop/qemu-ga.rst<br>
@@ -28,6 +28,20 @@ configuration options on the command line. For the same =
key, the last<br>
=C2=A0option wins, but the lists accumulate (see below for configuration<br=
>
=C2=A0file format).<br>
<br>
+If an allowed RPCs list is defined in the configuration, then all<br>
+RPCs will be blocked by default, except for the allowed list.<br>
+<br>
+If a blocked RPCs list is defined in the configuration, then all<br>
+RPCs will be allowed by default, except for the blocked list.<br>
+<br>
+If both allowed and blocked RPCs lists are defined in the configuration,<b=
r>
+then all RPCs will be blocked by default, then the allowed list will<br>
+be applied, followed by the blocked list.<br>
+<br>
+While filesystems are frozen, all except for a designated safe set<br>
+of RPCs will blocked, regardless of what the general configuration<br>
+declares.<br>
+<br>
=C2=A0Options<br>
=C2=A0-------<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index f4104f2760..578d29f228 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -1136,12 +1136,6 @@ error:<br>
<br>
=C2=A0#endif /* HAVE_GETIFADDRS */<br>
<br>
-/* add unsupported commands to the list of blocked RPCs */<br>
-GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
-{<br>
-=C2=A0 =C2=A0 return blockedrpcs;<br>
-}<br>
-<br>
=C2=A0/* register init/cleanup routines for stateful command groups */<br>
=C2=A0void ga_command_state_init(GAState *s, GACommandState *cs)<br>
=C2=A0{<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 5866cc2e3c..61b36da469 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1958,12 +1958,6 @@ done:<br>
=C2=A0 =C2=A0 =C2=A0g_free(rawpasswddata);<br>
=C2=A0}<br>
<br>
-/* add unsupported commands to the list of blocked RPCs */<br>
-GList *ga_command_init_blockedrpcs(GList *blockedrpcs)<br>
-{<br>
-=C2=A0 =C2=A0 return blockedrpcs;<br>
-}<br>
-<br>
=C2=A0/* register init/cleanup routines for stateful command groups */<br>
=C2=A0void ga_command_state_init(GAState *s, GACommandState *cs)<br>
=C2=A0{<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 6ae911eb15..b8f7b1e4a3 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -423,60 +423,79 @@ static gint ga_strcmp(gconstpointer str1, gconstpoint=
er str2)<br>
=C2=A0 =C2=A0 =C2=A0return strcmp(str1, str2);<br>
=C2=A0}<br>
<br>
-/* disable commands that aren&#39;t safe for fsfreeze */<br>
-static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opa=
que)<br>
+static bool ga_command_is_allowed(const QmpCommand *cmd, GAState *state)<b=
r>
=C2=A0{<br>
-=C2=A0 =C2=A0 bool allowed =3D false;<br>
=C2=A0 =C2=A0 =C2=A0int i =3D 0;<br>
+=C2=A0 =C2=A0 GAConfig *config =3D state-&gt;config;<br>
=C2=A0 =C2=A0 =C2=A0const char *name =3D qmp_command_name(cmd);<br>
+=C2=A0 =C2=A0 /* Fallback policy is allow everything */<br>
+=C2=A0 =C2=A0 bool allowed =3D true;<br>
<br>
-=C2=A0 =C2=A0 while (ga_freeze_allowlist[i] !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(name, ga_freeze_allowlist[i]) =3D=
=3D 0) {<br>
+=C2=A0 =C2=A0 if (config-&gt;allowedrpcs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If an allow-list is given, this change=
s the fallback<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* policy to deny everything<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 allowed =3D false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_list_find_custom(config-&gt;allowedrpcs,=
 name, ga_strcmp) !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allowed =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 if (!allowed) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;disabling command: %s&quot;, nam=
e);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_disable_command(&amp;ga_commands, name, &q=
uot;the agent is in frozen state&quot;);<br>
-=C2=A0 =C2=A0 }<br>
-}<br>
<br>
-/* [re-]enable all commands, except those explicitly blocked by user */<br=
>
-static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)<br>
-{<br>
-=C2=A0 =C2=A0 GAState *s =3D opaque;<br>
-=C2=A0 =C2=A0 GList *blockedrpcs =3D s-&gt;blockedrpcs;<br>
-=C2=A0 =C2=A0 GList *allowedrpcs =3D s-&gt;allowedrpcs;<br>
-=C2=A0 =C2=A0 const char *name =3D qmp_command_name(cmd);<br>
-<br>
-=C2=A0 =C2=A0 if (g_list_find_custom(blockedrpcs, name, ga_strcmp) =3D=3D =
NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qmp_command_is_enabled(cmd)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If both allowedrpcs and blockedrpcs are set, the blo=
cked<br>
+=C2=A0 =C2=A0 =C2=A0* list will take priority<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (config-&gt;blockedrpcs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_list_find_custom(config-&gt;blockedrpcs,=
 name, ga_strcmp) !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allowed =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (allowedrpcs &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_list_find_custom(allowedrpcs, =
name, ga_strcmp) =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If frozen, this filtering must take priority over<br=
>
+=C2=A0 =C2=A0 =C2=A0* absolutely everything<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (state-&gt;frozen) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 allowed =3D false;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;enabling command: %s&quot;, name=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_enable_command(&amp;ga_commands, name);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (ga_freeze_allowlist[i] !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(name, ga_freeze_allow=
list[i]) =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allowed =3D true;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 return allowed;<br>
=C2=A0}<br>
<br>
-/* disable commands that aren&#39;t allowed */<br>
-static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)<br=
>
+static void ga_apply_command_filters_iter(const QmpCommand *cmd, void *opa=
que)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 GList *allowedrpcs =3D opaque;<br>
+=C2=A0 =C2=A0 GAState *state =3D opaque;<br>
+=C2=A0 =C2=A0 bool want =3D ga_command_is_allowed(cmd, state);<br>
+=C2=A0 =C2=A0 bool have =3D qmp_command_is_enabled(cmd);<br>
=C2=A0 =C2=A0 =C2=A0const char *name =3D qmp_command_name(cmd);<br>
<br>
-=C2=A0 =C2=A0 if (g_list_find_custom(allowedrpcs, name, ga_strcmp) =3D=3D =
NULL) {<br>
+=C2=A0 =C2=A0 if (want =3D=3D have) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (have) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_debug(&quot;disabling command: %s&quot;=
, name);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qmp_disable_command(&amp;ga_commands, nam=
e, &quot;the command is not allowed&quot;);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;enabling command: %s&quot;, name=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_enable_command(&amp;ga_commands, name);<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void ga_apply_command_filters(GAState *state)<br>
+{<br>
+=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_apply_command_filt=
ers_iter, state);<br>
+}<br>
+<br>
=C2=A0static bool ga_create_file(const char *path)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int fd =3D open(path, O_CREAT | O_WRONLY, S_IWUSR | S_I=
RUSR);<br>
@@ -509,15 +528,14 @@ void ga_set_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0if (ga_is_frozen(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 /* disable all forbidden (for frozen state) commands */<br>
-=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disable_not_allowe=
d_freeze, NULL);<br>
=C2=A0 =C2=A0 =C2=A0g_warning(&quot;disabling logging due to filesystem fre=
eze&quot;);<br>
-=C2=A0 =C2=A0 ga_disable_logging(s);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;frozen =3D true;<br>
=C2=A0 =C2=A0 =C2=A0if (!ga_create_file(s-&gt;state_filepath_isfrozen)) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;unable to create %s, fsfr=
eeze may not function properly&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
state_filepath_isfrozen);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 ga_apply_command_filters(s);<br>
+=C2=A0 =C2=A0 ga_disable_logging(s);<br>
=C2=A0}<br>
<br>
=C2=A0void ga_unset_frozen(GAState *s)<br>
@@ -549,12 +567,12 @@ void ga_unset_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* enable all disabled, non-blocked and allowed command=
s */<br>
-=C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_enable_non_blocked=
, s);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;frozen =3D false;<br>
=C2=A0 =C2=A0 =C2=A0if (!ga_delete_file(s-&gt;state_filepath_isfrozen)) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;unable to delete %s, fsfr=
eeze may not function properly&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
state_filepath_isfrozen);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 ga_apply_command_filters(s);<br>
=C2=A0}<br>
<br>
=C2=A0#ifdef CONFIG_FSFREEZE<br>
@@ -1086,13 +1104,6 @@ static void config_load(GAConfig *config, const char=
 *confpath, bool required)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0split_list(config-&gt;aliststr, &quot;,&quot;));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;b=
lock-rpcs&quot;, NULL) &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_has_key(keyfile, &quot;general&quot=
;, &quot;allow-rpcs&quot;, NULL)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;wrong config, using &#39;bloc=
k-rpcs&#39; and &#39;allow-rpcs&#39; keys at&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; the same time is not allowed&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0end:<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_free(keyfile);<br>
=C2=A0 =C2=A0 =C2=A0if (gerr &amp;&amp; (required ||<br>
@@ -1172,7 +1183,6 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0const char *sopt =3D &quot;hVvdc:m:p:l:f:F::b:a:s:t:Dr&=
quot;;<br>
=C2=A0 =C2=A0 =C2=A0int opt_ind =3D 0, ch;<br>
-=C2=A0 =C2=A0 bool block_rpcs =3D false, allow_rpcs =3D false;<br>
=C2=A0 =C2=A0 =C2=A0const struct option lopt[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;help&quot;, 0, NULL, &#39;h&#39; =
},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;version&quot;, 0, NULL, &#39;V&#3=
9; },<br>
@@ -1268,7 +1278,6 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;blockedrpcs =3D =
g_list_concat(config-&gt;blockedrpcs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(optarg, &quot;,&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 block_rpcs =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;a&#39;: {<br>
@@ -1278,7 +1287,6 @@ static void config_parse(GAConfig *config, int argc, =
char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;allowedrpcs =3D =
g_list_concat(config-&gt;allowedrpcs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0split_list(optarg, &quot;,&quot;));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 allow_rpcs =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#ifdef _WIN32<br>
@@ -1319,12 +1327,6 @@ static void config_parse(GAConfig *config, int argc,=
 char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 if (block_rpcs &amp;&amp; allow_rpcs) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;wrong commandline, using --bl=
ock-rpcs and --allow-rpcs at the&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; same time is not allowed&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void config_free(GAConfig *config)<br>
@@ -1435,7 +1437,6 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;deferred_options.log_=
filepath =3D config-&gt;log_filepath;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_disable_logging(s);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disa=
ble_not_allowed_freeze, NULL);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (config-&gt;daemonize) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0become_daemon(config-&gt;pi=
d_filepath);<br>
@@ -1459,25 +1460,6 @@ static GAState *initialize_agent(GAConfig *config, i=
nt socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (config-&gt;allowedrpcs) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_for_each_command(&amp;ga_commands, ga_disa=
ble_not_allowed, config-&gt;allowedrpcs);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;allowedrpcs =3D config-&gt;allowedrpcs;<=
br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /*<br>
-=C2=A0 =C2=A0 =C2=A0* Some commands can be blocked due to system limitatio=
n.<br>
-=C2=A0 =C2=A0 =C2=A0* Initialize blockedrpcs list even if allowedrpcs spec=
ified.<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 config-&gt;blockedrpcs =3D ga_command_init_blockedrpcs(confi=
g-&gt;blockedrpcs);<br>
-=C2=A0 =C2=A0 if (config-&gt;blockedrpcs) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 GList *l =3D config-&gt;blockedrpcs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;blockedrpcs =3D config-&gt;blockedrpcs;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;disabling command:=
 %s&quot;, (char *)l-&gt;data);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_disable_command(&amp;ga_comm=
ands, l-&gt;data, NULL);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l =3D g_list_next(l);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (l);<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;command_state =3D ga_command_state_new();<br>
=C2=A0 =C2=A0 =C2=A0ga_command_state_init(s, s-&gt;command_state);<br>
=C2=A0 =C2=A0 =C2=A0ga_command_state_init_all(s-&gt;command_state);<br>
@@ -1503,6 +1485,8 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 ga_apply_command_filters(s);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ga_state =3D s;<br>
=C2=A0 =C2=A0 =C2=A0return s;<br>
=C2=A0}<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--00000000000033b823061d94c115--


