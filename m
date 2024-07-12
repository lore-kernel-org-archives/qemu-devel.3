Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69259C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCDl-0001Sa-0B; Fri, 12 Jul 2024 05:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSCDj-0001Rs-93
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSCDh-000051-7A
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720775136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TCUWiY72l7VTq5YKqiEYlFkArO2MZrG0OcL2eQPfMVg=;
 b=VNeYBDfXt+gdSbWqUY9Ku3dfVab2kxeo2RwBormqjdC21kLA3PfPNmX9t17iKDURRpEiPL
 xDv32dfKuKIEV7geFSp6g0QajK3Sx51a/AE/po7UaGRBKGZUolnFjM+zKwy6agG3CmY0hl
 TX4y46pvLhfqolxAzroJ13wCwPsB2d4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-uvIDM4pNOneJiXjJF2ehAw-1; Fri, 12 Jul 2024 05:05:34 -0400
X-MC-Unique: uvIDM4pNOneJiXjJF2ehAw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-651a0aa7463so30440877b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:05:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775134; x=1721379934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCUWiY72l7VTq5YKqiEYlFkArO2MZrG0OcL2eQPfMVg=;
 b=CPl4Fxr3s0VBdYnR9DhZtUhrFblYa0XBK0MHwR2Mv1Cjxyj7bT01yIGBOxRjxllwAg
 aFLCjn1UGHYy7v67zjqdVrdq70XiSsHVNP35HEWswKVS7da48iG52SzFSEG0i3zRiyDM
 fYAy/GtHFidkzO9E318W7P5cCDGin1NdLJw3CitiHkcRvYuvNu3IgKv8iAd8O2f7z0mM
 o7yZapXmJhaTeEuYBgeJY63jbNrS3LQpyyjTh7fRXWHqyn4+GiUusiQ4n6aXl53M1y51
 z4gJQcyUlbQfMjQy/GYpAHUKgAZ0HXRS7wXTu1PucpoE3uvK1sbC6qxSISYAuJzTMNMo
 5dnw==
X-Gm-Message-State: AOJu0Yxcifw/G9i4l61ThuP6ulylhldOP1sN6MOxZWieo6/mbBR9L9Yx
 sCcAWo1YnOZgpxGFSO8TYPMnIE8aJ75adRli8Ryp2YlOEeGoI+8TXi1jPlUi24c0HY1FjA32ycK
 Ot3AdPDmzbPWl5WXvHclLzmUS/uvCKbxwg71lEgXlImhwUo/NNTBe8HUMMmxsjYOck3Wh+y9fy0
 14wtbmMz8WdZUTxvdwCstoTJCfIqk=
X-Received: by 2002:a81:e241:0:b0:64a:91b7:e8da with SMTP id
 00721157ae682-658f02f4a5bmr104780577b3.35.1720775134212; 
 Fri, 12 Jul 2024 02:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs6ZkYgySnBKNDgDvK1MjTb6jcxHuCtJfy112ApZhzgFAHzrF677cA7ZXyyQ/HdjzS3kYkh8DEAS+xEalpBgs=
X-Received: by 2002:a81:e241:0:b0:64a:91b7:e8da with SMTP id
 00721157ae682-658f02f4a5bmr104780407b3.35.1720775133944; Fri, 12 Jul 2024
 02:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-16-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-16-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 12:05:23 +0300
Message-ID: <CAPMcbCo7CY1VJ+J8Zft7i5cG+1yDMKQa1hzmCNWxkin9G4cVTA@mail.gmail.com>
Subject: Re: [PATCH v2 21/22] qga: allow configuration file path via the cli
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000098f2c9061d092e38"
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

--00000000000098f2c9061d092e38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 6:45=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Allowing the user to set the QGA_CONF environment variable to change
> the default configuration file path is very unusual practice, made
> more obscure since this ability is not documented.
>
> This introduces the more normal '-c PATH'  / '--config=3DPATH' command
> line argument approach. This requires that we parse the comamnd line
> twice, since we want the command line arguments to take priority over
> the configuration file settings in general.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/interop/qemu-ga.rst |  5 +++++
>  qga/main.c               | 35 +++++++++++++++++++++++++++--------
>  2 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst
> index 72fb75a6f5..e42b370319 100644
> --- a/docs/interop/qemu-ga.rst
> +++ b/docs/interop/qemu-ga.rst
> @@ -33,6 +33,11 @@ Options
>
>  .. program:: qemu-ga
>
> +.. option:: -c, --config=3DPATH
> +
> +  Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf``,
> +  unless overriden by the QGA_CONF environment variable)
> +
>  .. option:: -m, --method=3DMETHOD
>

Please also update qga/main.c static void usage(const char *cmd)


>
>    Transport method: one of ``unix-listen``, ``virtio-serial``, or
> diff --git a/qga/main.c b/qga/main.c
> index 6ff022a85d..f68a32bf7b 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1018,15 +1018,14 @@ static GList *split_list(const gchar *str, const
> gchar *delim)
>      return list;
>  }
>
> -static void config_load(GAConfig *config)
> +static void config_load(GAConfig *config, const char *confpath, bool
> required)
>  {
>      GError *gerr =3D NULL;
>      GKeyFile *keyfile;
> -    g_autofree char *conf =3D g_strdup(g_getenv("QGA_CONF")) ?:
> get_relocated_path(QGA_CONF_DEFAULT);
>
>      /* read system config */
>      keyfile =3D g_key_file_new();
> -    if (!g_key_file_load_from_file(keyfile, conf, 0, &gerr)) {
> +    if (!g_key_file_load_from_file(keyfile, confpath, 0, &gerr)) {
>          goto end;
>      }
>      if (g_key_file_has_key(keyfile, "general", "daemon", NULL)) {
> @@ -1092,10 +1091,10 @@ static void config_load(GAConfig *config)
>
>  end:
>      g_key_file_free(keyfile);
> -    if (gerr &&
> -        !(gerr->domain =3D=3D G_FILE_ERROR && gerr->code =3D=3D
> G_FILE_ERROR_NOENT)) {
> +    if (gerr && (required ||
> +                 !(gerr->domain =3D=3D G_FILE_ERROR && gerr->code =3D=3D
> G_FILE_ERROR_NOENT))) {
>          g_critical("error loading configuration from path: %s, %s",
> -                   conf, gerr->message);
> +                   confpath, gerr->message);
>          exit(EXIT_FAILURE);
>      }
>      g_clear_error(&gerr);
> @@ -1167,12 +1166,13 @@ static void config_dump(GAConfig *config)
>
>  static void config_parse(GAConfig *config, int argc, char **argv)
>  {
> -    const char *sopt =3D "hVvdm:p:l:f:F::b:a:s:t:Dr";
> +    const char *sopt =3D "hVvdc:m:p:l:f:F::b:a:s:t:Dr";
>      int opt_ind =3D 0, ch;
>      bool block_rpcs =3D false, allow_rpcs =3D false;
>      const struct option lopt[] =3D {
>          { "help", 0, NULL, 'h' },
>          { "version", 0, NULL, 'V' },
> +        { "config", 1, NULL, 'c' },
>          { "dump-conf", 0, NULL, 'D' },
>          { "logfile", 1, NULL, 'l' },
>          { "pidfile", 1, NULL, 'f' },
> @@ -1192,6 +1192,26 @@ static void config_parse(GAConfig *config, int
> argc, char **argv)
>          { "retry-path", 0, NULL, 'r' },
>          { NULL, 0, NULL, 0 }
>      };
> +    g_autofree char *confpath =3D g_strdup(g_getenv("QGA_CONF")) ?:
> +        get_relocated_path(QGA_CONF_DEFAULT);
> +    bool confrequired =3D false;
> +
> +    while ((ch =3D getopt_long(argc, argv, sopt, lopt, NULL)) !=3D -1) {
> +        switch (ch) {
> +        case 'c':
> +            g_free(confpath);
> +            confpath =3D g_strdup(optarg);
> +            confrequired =3D true;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    config_load(config, confpath, confrequired);
> +
> +    /* Reset for second pass */
> +    optind =3D 1;
>
>      while ((ch =3D getopt_long(argc, argv, sopt, lopt, &opt_ind)) !=3D -=
1) {
>          switch (ch) {
> @@ -1582,7 +1602,6 @@ int main(int argc, char **argv)
>      qga_qmp_init_marshal(&ga_commands);
>
>      init_dfl_pathnames();
> -    config_load(config);
>      config_parse(config, argc, argv);
>
>      if (config->pid_filepath =3D=3D NULL) {
> --
> 2.45.1
>
>

--00000000000098f2c9061d092e38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:45=E2=80=AF=
PM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berra=
nge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Allowing the user to set the QGA_CONF environment variable to=
 change<br>
the default configuration file path is very unusual practice, made<br>
more obscure since this ability is not documented.<br>
<br>
This introduces the more normal &#39;-c PATH&#39;=C2=A0 / &#39;--config=3DP=
ATH&#39; command<br>
line argument approach. This requires that we parse the comamnd line<br>
twice, since we want the command line arguments to take priority over<br>
the configuration file settings in general.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/qemu-ga.rst |=C2=A0 5 +++++<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 35=
 +++++++++++++++++++++++++++--------<br>
=C2=A02 files changed, 32 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/docs/interop/qemu-ga.rst b/docs/interop/qemu-ga.rst<br>
index 72fb75a6f5..e42b370319 100644<br>
--- a/docs/interop/qemu-ga.rst<br>
+++ b/docs/interop/qemu-ga.rst<br>
@@ -33,6 +33,11 @@ Options<br>
<br>
=C2=A0.. program:: qemu-ga<br>
<br>
+.. option:: -c, --config=3DPATH<br>
+<br>
+=C2=A0 Configuration file path (the default is |CONFDIR|\ ``/qemu-ga.conf`=
`,<br>
+=C2=A0 unless overriden by the QGA_CONF environment variable)<br>
+<br>
=C2=A0.. option:: -m, --method=3DMETHOD<br></blockquote><div><br></div><div=
>Please also update qga/main.c static void usage(const char *cmd) <br></div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0Transport method: one of ``unix-listen``, ``virtio-serial``, o=
r<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 6ff022a85d..f68a32bf7b 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1018,15 +1018,14 @@ static GList *split_list(const gchar *str, const gc=
har *delim)<br>
=C2=A0 =C2=A0 =C2=A0return list;<br>
=C2=A0}<br>
<br>
-static void config_load(GAConfig *config)<br>
+static void config_load(GAConfig *config, const char *confpath, bool requi=
red)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GError *gerr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0GKeyFile *keyfile;<br>
-=C2=A0 =C2=A0 g_autofree char *conf =3D g_strdup(g_getenv(&quot;QGA_CONF&q=
uot;)) ?: get_relocated_path(QGA_CONF_DEFAULT);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* read system config */<br>
=C2=A0 =C2=A0 =C2=A0keyfile =3D g_key_file_new();<br>
-=C2=A0 =C2=A0 if (!g_key_file_load_from_file(keyfile, conf, 0, &amp;gerr))=
 {<br>
+=C2=A0 =C2=A0 if (!g_key_file_load_from_file(keyfile, confpath, 0, &amp;ge=
rr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (g_key_file_has_key(keyfile, &quot;general&quot;, &q=
uot;daemon&quot;, NULL)) {<br>
@@ -1092,10 +1091,10 @@ static void config_load(GAConfig *config)<br>
<br>
=C2=A0end:<br>
=C2=A0 =C2=A0 =C2=A0g_key_file_free(keyfile);<br>
-=C2=A0 =C2=A0 if (gerr &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(gerr-&gt;domain =3D=3D G_FILE_ERROR &amp;&am=
p; gerr-&gt;code =3D=3D G_FILE_ERROR_NOENT)) {<br>
+=C2=A0 =C2=A0 if (gerr &amp;&amp; (required ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(gerr-&gt;d=
omain =3D=3D G_FILE_ERROR &amp;&amp; gerr-&gt;code =3D=3D G_FILE_ERROR_NOEN=
T))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;error loading configurat=
ion from path: %s, %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conf,=
 gerr-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0confp=
ath, gerr-&gt;message);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(EXIT_FAILURE);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0g_clear_error(&amp;gerr);<br>
@@ -1167,12 +1166,13 @@ static void config_dump(GAConfig *config)<br>
<br>
=C2=A0static void config_parse(GAConfig *config, int argc, char **argv)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdm:p:l:f:F::b:a:s:t:Dr&quot;;<=
br>
+=C2=A0 =C2=A0 const char *sopt =3D &quot;hVvdc:m:p:l:f:F::b:a:s:t:Dr&quot;=
;<br>
=C2=A0 =C2=A0 =C2=A0int opt_ind =3D 0, ch;<br>
=C2=A0 =C2=A0 =C2=A0bool block_rpcs =3D false, allow_rpcs =3D false;<br>
=C2=A0 =C2=A0 =C2=A0const struct option lopt[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;help&quot;, 0, NULL, &#39;h&#39; =
},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;version&quot;, 0, NULL, &#39;V&#3=
9; },<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 { &quot;config&quot;, 1, NULL, &#39;c&#39; },<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;dump-conf&quot;, 0, NULL, &#39;D&=
#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;logfile&quot;, 1, NULL, &#39;l&#3=
9; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;pidfile&quot;, 1, NULL, &#39;f&#3=
9; },<br>
@@ -1192,6 +1192,26 @@ static void config_parse(GAConfig *config, int argc,=
 char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &quot;retry-path&quot;, 0, NULL, &#39;r=
&#39; },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ NULL, 0, NULL, 0 }<br>
=C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 g_autofree char *confpath =3D g_strdup(g_getenv(&quot;QGA_CO=
NF&quot;)) ?:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 get_relocated_path(QGA_CONF_DEFAULT);<br>
+=C2=A0 =C2=A0 bool confrequired =3D false;<br>
+<br>
+=C2=A0 =C2=A0 while ((ch =3D getopt_long(argc, argv, sopt, lopt, NULL)) !=
=3D -1) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (ch) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;c&#39;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(confpath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confpath =3D g_strdup(optarg);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 confrequired =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 config_load(config, confpath, confrequired);<br>
+<br>
+=C2=A0 =C2=A0 /* Reset for second pass */<br>
+=C2=A0 =C2=A0 optind =3D 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0while ((ch =3D getopt_long(argc, argv, sopt, lopt, &amp=
;opt_ind)) !=3D -1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (ch) {<br>
@@ -1582,7 +1602,6 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0qga_qmp_init_marshal(&amp;ga_commands);<br>
<br>
=C2=A0 =C2=A0 =C2=A0init_dfl_pathnames();<br>
-=C2=A0 =C2=A0 config_load(config);<br>
=C2=A0 =C2=A0 =C2=A0config_parse(config, argc, argv);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (config-&gt;pid_filepath =3D=3D NULL) {<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div></div>

--00000000000098f2c9061d092e38--


