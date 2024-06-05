Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B138DC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo1Z-0005C7-Em; Wed, 05 Jun 2024 06:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEo1V-0005Bd-Ie
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:37:42 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEo1S-0005WY-Hw
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:37:41 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43fe3505abbso5453051cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717583856; x=1718188656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bKcjpT9Vs5WG3N9OWisD0KwfNHgKMzx1tW8Kh4rDUHU=;
 b=DSVbg3r9KOZyZT8RfWb9U/wHgXYvwNOs7brDTkx18J8E6xpf1FDTQsUnj7M0C7JqD8
 YIKuNd5A8dv7HTGEkx/fgycFbclsL017QN6cvXlEUWxYu2zur2UeNJTqmejBEndPM5Jf
 gx90gz5Wev9ONlyDFI8YT30fWNhwOz+133f+lRUmX2+lZxdj1AuCrHAUCfHVw6JLDzO6
 hW/zoAwqg7Oxphp9RloEcotB9bA98NJuQ5N67a55q6fZmi9+3Sh6qdG8MILBG2MbhGkJ
 Z+ujqNM/OfeL3GylZqJDe1WwZ64G/0Sll+gMaSEg84YsAycJTTItfDdoDmz6//IShUTi
 e2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717583856; x=1718188656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKcjpT9Vs5WG3N9OWisD0KwfNHgKMzx1tW8Kh4rDUHU=;
 b=hgFAXj3KgeTApqF6+OBNZwErkhs+c5E9BqUKo/zZbCwXxz66BWKb+JmhqCetM35r/a
 TSlct0EOpNk8NPhPjmq/7NPtDKseybBsB5oRFLqu44lagWKW2tC6HoKb6E+FtkkR1Fxw
 FSVzh9N7nY06+Z9oSuCccXGoSq/kLe+LoW3LtcmVSAtYwK+aqa1v6pGrhpxYiriJC/GU
 n85dyTEpZ8EoL7PcQA7kl5IxJE0poGEVagUiNxjWFvuyvr1b9V9vda0qp7k2J2NzzgkE
 MyCFTR5n3dnmJtT2txOhinMkmwcYJO2K89BmM3B39/7f6wRBQ2aj8W0MeoAKSZwk6abo
 nNqA==
X-Gm-Message-State: AOJu0YxRyrit5Q3qgxLV33H3E3JitBZDOJe227WYmmo1h4x35DovQKuD
 k/EX/7lVxr22tsiTHDKKECqwuBuE3bgI13kqJwpuDRu0pE1ygYC+KeMhJ6eY3TkSR/rzZnPFoAf
 /Mw5/EXC/2GtN8K8LQ5r9ogVrPu4=
X-Google-Smtp-Source: AGHT+IG2gaSjgry4Wx0aGHHay6LTrsStsYX5Ey1cmYAxmJPZ2GSgGMTEwzxlct7zEj4f13WkHbxpyr4ILXnsnCLbz9w=
X-Received: by 2002:a05:622a:1a17:b0:43a:b8e2:5870 with SMTP id
 d75a77b69052e-44029e3a5e8mr37714321cf.3.1717583856104; Wed, 05 Jun 2024
 03:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-21-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-21-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 14:37:24 +0400
Message-ID: <CAJ+F1CKE412ZvLJQRSfvO_gV1irUyQxP0xZ+Ejfuqf=QxeS+Tg@mail.gmail.com>
Subject: Re: [PATCH 20/20] qga: centralize logic for disabling/enabling
 commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009d7afd061a2227bf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000009d7afd061a2227bf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jun 4, 2024 at 5:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> It is confusing having many different pieces of code enabling and
> disabling commands, and it is not clear that they all have the same
> semantics, especially wrt prioritization of the block/allow lists.
>
> Centralizing the code in a single method "ga_apply_command_filters"
> will provide a strong guarantee of consistency and clarify the
> intended behaviour.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

The clean up is very much welcome and looks correct, but it crashes:

Thread 1 "qemu-ga" received signal SIGSEGV, Segmentation fault.
0x000055555557db4f in ga_command_is_allowed (cmd=3D0x555555632800,
state=3D0x555555633710) at ../qga/main.c:430
430    if (config->allowedrpcs) {
(gdb) bt
#0  0x000055555557db4f in ga_command_is_allowed (cmd=3D0x555555632800,
state=3D0x555555633710) at ../qga/main.c:430
#1  ga_apply_command_filters_iter (cmd=3D0x555555632800,
opaque=3D0x555555633710) at ../qga/main.c:473
#2  0x000055555559ef81 in qmp_for_each_command (cmds=3Dcmds@entry=3D0x55555=
562c2b0
<ga_commands>, fn=3Dfn@entry=3D0x55555557db30 <ga_apply_command_filters_ite=
r>,
opaque=3Dopaque@entry=3D0x555555633710)
    at ../qapi/qmp-registry.c:93
#3  0x0000555555571436 in ga_apply_command_filters (state=3D0x555555633710)
at ../qga/main.c:492
#4  initialize_agent (config=3D0x555555632760, socket_activation=3D0) at
../qga/main.c:1452
#5  main (argc=3D<optimized out>, argv=3D<optimized out>) at ../qga/main.c:=
1646
(gdb) p state.config
$1 =3D (GAConfig *) 0x0

(meson test fails too)

I wonder why s->config is set so late in initialize_agent(). Moving it
earlier seems to solve the issue, but reviewing all code paths is tedious..


---
>  qga/main.c | 110 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index e8f52f0794..c7b7b0a9bc 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -419,60 +419,79 @@ static gint ga_strcmp(gconstpointer str1,
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
> -    }
> -    if (!allowed) {
> -        g_debug("disabling command: %s", name);
> -        qmp_disable_command(&ga_commands, name, "the agent is in frozen
> state");
>      }
> -}
> -
> -/* [re-]enable all commands, except those explicitly blocked by user */
> -static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)
> -{
> -    GAState *s =3D opaque;
> -    GList *blockedrpcs =3D s->blockedrpcs;
> -    GList *allowedrpcs =3D s->allowedrpcs;
> -    const char *name =3D qmp_command_name(cmd);
>
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
> +    if (qmp_command_is_enabled(cmd)) {
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
> @@ -505,15 +524,14 @@ void ga_set_frozen(GAState *s)
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
> @@ -545,12 +563,12 @@ void ga_unset_frozen(GAState *s)
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
> @@ -1414,7 +1432,6 @@ static GAState *initialize_agent(GAConfig *config,
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
> @@ -1438,25 +1455,8 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>          return NULL;
>      }
>
> -    if (config->allowedrpcs) {
> -        qmp_for_each_command(&ga_commands, ga_disable_not_allowed,
> config->allowedrpcs);
> -        s->allowedrpcs =3D config->allowedrpcs;
> -    }
> +    ga_apply_command_filters(s);
>
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
> --
> 2.45.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000009d7afd061a2227bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 5:51=E2=80=
=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">be=
rrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">It is confusing having many different pieces of code enabl=
ing and<br>
disabling commands, and it is not clear that they all have the same<br>
semantics, especially wrt prioritization of the block/allow lists.<br>
<br>
Centralizing the code in a single method &quot;ga_apply_command_filters&quo=
t;<br>
will provide a strong guarantee of consistency and clarify the<br>
intended behaviour.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>The clean up is very much welcome and looks correct, but it c=
rashes:</div><div><br></div><div>Thread 1 &quot;qemu-ga&quot; received sign=
al SIGSEGV, Segmentation fault.<br>0x000055555557db4f in ga_command_is_allo=
wed (cmd=3D0x555555632800, state=3D0x555555633710) at ../qga/main.c:430<br>=
430	 =C2=A0 =C2=A0if (config-&gt;allowedrpcs) {<br>(gdb) bt<br>#0 =C2=A00x0=
00055555557db4f in ga_command_is_allowed (cmd=3D0x555555632800, state=3D0x5=
55555633710) at ../qga/main.c:430<br>#1 =C2=A0ga_apply_command_filters_iter=
 (cmd=3D0x555555632800, opaque=3D0x555555633710) at ../qga/main.c:473<br>#2=
 =C2=A00x000055555559ef81 in qmp_for_each_command (cmds=3Dcmds@entry=3D0x55=
555562c2b0 &lt;ga_commands&gt;, fn=3Dfn@entry=3D0x55555557db30 &lt;ga_apply=
_command_filters_iter&gt;, opaque=3Dopaque@entry=3D0x555555633710)<br>=C2=
=A0 =C2=A0 at ../qapi/qmp-registry.c:93<br>#3 =C2=A00x0000555555571436 in g=
a_apply_command_filters (state=3D0x555555633710) at ../qga/main.c:492<br>#4=
 =C2=A0initialize_agent (config=3D0x555555632760, socket_activation=3D0) at=
 ../qga/main.c:1452<br>#5 =C2=A0main (argc=3D&lt;optimized out&gt;, argv=3D=
&lt;optimized out&gt;) at ../qga/main.c:1646<br>(gdb) p state.config<br>$1 =
=3D (GAConfig *) 0x0</div><div><br></div><div><div>(meson test fails too)</=
div><div><br></div>I wonder why s-&gt;config is set so late in initialize_a=
gent(). Moving it earlier seems to solve the issue, but reviewing all code =
paths is tedious..<br></div><div><br></div><br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
---<br>
=C2=A0qga/main.c | 110 ++++++++++++++++++++++++++--------------------------=
-<br>
=C2=A01 file changed, 55 insertions(+), 55 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index e8f52f0794..c7b7b0a9bc 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -419,60 +419,79 @@ static gint ga_strcmp(gconstpointer str1, gconstpoint=
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
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (!allowed) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;disabling command: %s&quot;, nam=
e);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_disable_command(&amp;ga_commands, name, &q=
uot;the agent is in frozen state&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
-/* [re-]enable all commands, except those explicitly blocked by user */<br=
>
-static void ga_enable_non_blocked(const QmpCommand *cmd, void *opaque)<br>
-{<br>
-=C2=A0 =C2=A0 GAState *s =3D opaque;<br>
-=C2=A0 =C2=A0 GList *blockedrpcs =3D s-&gt;blockedrpcs;<br>
-=C2=A0 =C2=A0 GList *allowedrpcs =3D s-&gt;allowedrpcs;<br>
-=C2=A0 =C2=A0 const char *name =3D qmp_command_name(cmd);<br>
<br>
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
+=C2=A0 =C2=A0 if (qmp_command_is_enabled(cmd)) {<br>
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
@@ -505,15 +524,14 @@ void ga_set_frozen(GAState *s)<br>
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
@@ -545,12 +563,12 @@ void ga_unset_frozen(GAState *s)<br>
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
@@ -1414,7 +1432,6 @@ static GAState *initialize_agent(GAConfig *config, in=
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
@@ -1438,25 +1455,8 @@ static GAState *initialize_agent(GAConfig *config, i=
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
+=C2=A0 =C2=A0 ga_apply_command_filters(s);<br>
<br>
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
-- <br>
2.45.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000009d7afd061a2227bf--

