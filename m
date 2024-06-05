Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ECCC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 09:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEnQB-00083n-Vd; Wed, 05 Jun 2024 05:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEnQA-00083G-Br
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:59:06 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEnQ8-0003Ck-MZ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:59:06 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-440299bcf53so4755011cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 02:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717581544; x=1718186344; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ee1xA4yrwF3o4F6EXUbQgOOc4VoSKuAqm061Wcehss8=;
 b=f7FM3hFboVL3IE1hUItfDrAOeF5zw9YGSKwBVuWLM50P6ZUKvvjcKBEuRSIDMKzchI
 iT2u7hSmUnqqYRgyDrxTccu1lnBNeQ8W2P5zTFO/71K2HnnlZ497uscLxaLCQtL+6GD1
 3xT3lc8jA2ocS78uV5dlEl2jIG22f6hnONHuEBhOxL8b2V5svNqqgDWp9834YW7llPDr
 Tvnw4XyE8ICOdwkjrmTsJ1pxjsTSzOl3+idAK3Izp/uxScNrhpgEfbuadYCJO8K9HY60
 PfPwppfrW7bzwgwszJJRksRDJ8EEi6ZPXkO0thzq39JO1w0ni9ZY5U6C7K63p7bb9eNm
 M1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717581544; x=1718186344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ee1xA4yrwF3o4F6EXUbQgOOc4VoSKuAqm061Wcehss8=;
 b=EMRh6g2vgy1QbDcIgvMDRtkhPOmS25WrjRcroHk8/g+NqQdt6Z1G+Lb3fxI3ihAenV
 BJGBaNwzbTt6vCB9eE52mpjcj5T3hkyHEbZEvBcxJiVH9LpdT5OS+0/wtdiXGrvBfqzX
 RPW3IbXxO//LLDLqm3f8bdrETPyT22z/fEm3gNKLBAgPtlVUS82wQqzyvHcQfFK2ODh9
 Co5q+Zhjt73Uf1Bt/dJZoUaYcYkqdgLJ3bwm78FzXAqk4eitpKs80C5zwjEt5uytyIWI
 VACD39bh14k/DPTh6wSswJj9HGL/kMD1UJqSj26hM1tHg/VAXYjDI3L6uq3jbMJ1RRey
 eQdg==
X-Gm-Message-State: AOJu0YwvQpa9pzCjWtAA3Aw8m3/iTxFKxmlN5x6MhpIJWX6B3pXkxNQC
 8wB51nFIHjjFZQT7h5zQbuNY7e0WZ1Tf8/bbjeyuYvk9QsKMrnQmAl1dti4y0j+I1yMBBOEbFXO
 qytp7gicoeE/yW/oAch2KuCPiQ7M=
X-Google-Smtp-Source: AGHT+IEvP5GA7lJHGK+LltmAZ5AnPv9jbRzS9Fc5m3rXVker5+PktZedLmVfHPWvM8yPm4MGs8pQzhip5TsvYsq5xnQ=
X-Received: by 2002:ac8:7f08:0:b0:440:2214:9232 with SMTP id
 d75a77b69052e-4402b6c5547mr19700741cf.58.1717581543543; Wed, 05 Jun 2024
 02:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-20-berrange@redhat.com>
In-Reply-To: <20240604134933.220112-20-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Jun 2024 13:58:51 +0400
Message-ID: <CAJ+F1CLPVJ_nMjYxVuqwP6FsetKPNGwbHQDvnaKYX4s36yURzg@mail.gmail.com>
Subject: Re: [PATCH 19/20] qga: move declare of QGAConfig struct to top of file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c69c47061a219ddf"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

--000000000000c69c47061a219ddf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 5:51=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> It is referenced byy QGAState already, and it is clearer to declare all
>

minor "byy" typo


> data types at the top of the file, rather than have them mixed with
> code later.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/main.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index bdf5344584..e8f52f0794 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -70,6 +70,28 @@ typedef struct GAPersistentState {
>
>  typedef struct GAConfig GAConfig;
>
> +struct GAConfig {
> +    char *channel_path;
> +    char *method;
> +    char *log_filepath;
> +    char *pid_filepath;
> +#ifdef CONFIG_FSFREEZE
> +    char *fsfreeze_hook;
> +#endif
> +    char *state_dir;
> +#ifdef _WIN32
> +    const char *service;
> +#endif
> +    gchar *bliststr; /* blockedrpcs may point to this string */
> +    gchar *aliststr; /* allowedrpcs may point to this string */
> +    GList *blockedrpcs;
> +    GList *allowedrpcs;
> +    int daemonize;
> +    GLogLevelFlags log_level;
> +    int dumpconf;
> +    bool retry_path;
> +};
> +
>  struct GAState {
>      JSONMessageParser parser;
>      GMainLoop *main_loop;
> @@ -996,28 +1018,6 @@ static GList *split_list(const gchar *str, const
> gchar *delim)
>      return list;
>  }
>
> -struct GAConfig {
> -    char *channel_path;
> -    char *method;
> -    char *log_filepath;
> -    char *pid_filepath;
> -#ifdef CONFIG_FSFREEZE
> -    char *fsfreeze_hook;
> -#endif
> -    char *state_dir;
> -#ifdef _WIN32
> -    const char *service;
> -#endif
> -    gchar *bliststr; /* blockedrpcs may point to this string */
> -    gchar *aliststr; /* allowedrpcs may point to this string */
> -    GList *blockedrpcs;
> -    GList *allowedrpcs;
> -    int daemonize;
> -    GLogLevelFlags log_level;
> -    int dumpconf;
> -    bool retry_path;
> -};
> -
>  static void config_load(GAConfig *config)
>  {
>      GError *gerr =3D NULL;
> --
> 2.45.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c69c47061a219ddf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 4, 2024 at 5:51=E2=80=AFP=
M Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berran=
ge@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">It is referenced byy QGAState already, and it is clearer to de=
clare all<br></blockquote><div><br></div><div>minor &quot;byy&quot; typo</d=
iv><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
data types at the top of the file, rather than have them mixed with<br>
code later.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 44 ++++++++++++++++++++++----------------------<br>
=C2=A01 file changed, 22 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index bdf5344584..e8f52f0794 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -70,6 +70,28 @@ typedef struct GAPersistentState {<br>
<br>
=C2=A0typedef struct GAConfig GAConfig;<br>
<br>
+struct GAConfig {<br>
+=C2=A0 =C2=A0 char *channel_path;<br>
+=C2=A0 =C2=A0 char *method;<br>
+=C2=A0 =C2=A0 char *log_filepath;<br>
+=C2=A0 =C2=A0 char *pid_filepath;<br>
+#ifdef CONFIG_FSFREEZE<br>
+=C2=A0 =C2=A0 char *fsfreeze_hook;<br>
+#endif<br>
+=C2=A0 =C2=A0 char *state_dir;<br>
+#ifdef _WIN32<br>
+=C2=A0 =C2=A0 const char *service;<br>
+#endif<br>
+=C2=A0 =C2=A0 gchar *bliststr; /* blockedrpcs may point to this string */<=
br>
+=C2=A0 =C2=A0 gchar *aliststr; /* allowedrpcs may point to this string */<=
br>
+=C2=A0 =C2=A0 GList *blockedrpcs;<br>
+=C2=A0 =C2=A0 GList *allowedrpcs;<br>
+=C2=A0 =C2=A0 int daemonize;<br>
+=C2=A0 =C2=A0 GLogLevelFlags log_level;<br>
+=C2=A0 =C2=A0 int dumpconf;<br>
+=C2=A0 =C2=A0 bool retry_path;<br>
+};<br>
+<br>
=C2=A0struct GAState {<br>
=C2=A0 =C2=A0 =C2=A0JSONMessageParser parser;<br>
=C2=A0 =C2=A0 =C2=A0GMainLoop *main_loop;<br>
@@ -996,28 +1018,6 @@ static GList *split_list(const gchar *str, const gcha=
r *delim)<br>
=C2=A0 =C2=A0 =C2=A0return list;<br>
=C2=A0}<br>
<br>
-struct GAConfig {<br>
-=C2=A0 =C2=A0 char *channel_path;<br>
-=C2=A0 =C2=A0 char *method;<br>
-=C2=A0 =C2=A0 char *log_filepath;<br>
-=C2=A0 =C2=A0 char *pid_filepath;<br>
-#ifdef CONFIG_FSFREEZE<br>
-=C2=A0 =C2=A0 char *fsfreeze_hook;<br>
-#endif<br>
-=C2=A0 =C2=A0 char *state_dir;<br>
-#ifdef _WIN32<br>
-=C2=A0 =C2=A0 const char *service;<br>
-#endif<br>
-=C2=A0 =C2=A0 gchar *bliststr; /* blockedrpcs may point to this string */<=
br>
-=C2=A0 =C2=A0 gchar *aliststr; /* allowedrpcs may point to this string */<=
br>
-=C2=A0 =C2=A0 GList *blockedrpcs;<br>
-=C2=A0 =C2=A0 GList *allowedrpcs;<br>
-=C2=A0 =C2=A0 int daemonize;<br>
-=C2=A0 =C2=A0 GLogLevelFlags log_level;<br>
-=C2=A0 =C2=A0 int dumpconf;<br>
-=C2=A0 =C2=A0 bool retry_path;<br>
-};<br>
-<br>
=C2=A0static void config_load(GAConfig *config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GError *gerr =3D NULL;<br>
-- <br>
2.45.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000c69c47061a219ddf--

