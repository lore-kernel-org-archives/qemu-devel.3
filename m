Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A73CC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBu4-0006rF-UE; Fri, 12 Jul 2024 04:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBu3-0006n1-LS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBty-0002GX-MZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UsiVTJIKF+e0Hz1prbhG5bp8Ua/Qma0Ee3fNWwjhVfg=;
 b=bVcK6KwxW5xLiomdqC3sEabeLtXbfZlmPIyFN3xa6pg+Gko4OyZNNJJk20pVGM6CY4ODar
 YRgPK8dy/CfR2d/16kQFpQuA1W63SEcy/hlr13JTkDfsqVq1uXrX1zHN1/bmrrP+HdzR94
 LyQcrvUUrxW3cI29Mx9YtouTlxuqGPY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-RQU0Gix1OHWxv4uaT1G_hQ-1; Fri, 12 Jul 2024 04:45:10 -0400
X-MC-Unique: RQU0Gix1OHWxv4uaT1G_hQ-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-e037c3d20a6so3150983276.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773909; x=1721378709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UsiVTJIKF+e0Hz1prbhG5bp8Ua/Qma0Ee3fNWwjhVfg=;
 b=vU0odflEyWbUmH/ucStwrx7Ns957cVTijohPJtENdSQcx3blRKTWmqI24sDEhtOmOn
 poeitCbzUM7WQCGwD0I3iQxlzmZ00w50mTBN/R8rMvUIbqDjkysncWkBymqiLv8FVM8u
 lJXQPUKE4EuUpQuOYTEL7Lw4pH8T/yvIhM/+IKsLll/4jcz9nukKao4V96VrCntpRn93
 aR8ijTlWZk+a6CDN0wpNktmAJEjKZZL0AvTV5Fi45bhyCnMpoWqw+FX6bz439sAcwnzH
 zx6SeRgZ8pyGD6HO2l9eYftEnbP3NfFypv+AGm12UvqaYp5jcckMds6YBqd4lr6g1mwz
 zglQ==
X-Gm-Message-State: AOJu0YxggIBjsN3bz12Rpn4gKEhchVXI3/WDOks+eQxxHRoJCXgpg5o0
 Sf9t9XxcKNUZWlJq0AlVm8Zrxm6vnR+XcAcB+XNuPQkYX4uJ0nQ2reEegUL0MGUGTq7HRd0XvwV
 HbeN3BXolUhrenupmjQ4oaKYO2RS1mjmTmfYTXs5bjmt8XcfYNpZvDpGKINSlRW0Rr8RaxlEGrb
 sSa56SQpeaS9rs/M4iSnuKtDYNt/A=
X-Received: by 2002:a25:f503:0:b0:dfd:b613:cd5f with SMTP id
 3f1490d57ef6-e041b07042cmr12512362276.5.1720773909417; 
 Fri, 12 Jul 2024 01:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtnjK9tS0qYJAevC8nlg3GXAw1i7O13CMf8SbyIW/pMaqM5gqt3xbOGL1rK80/yKyVGjSZziG8jHcj95JWGlk=
X-Received: by 2002:a25:f503:0:b0:dfd:b613:cd5f with SMTP id
 3f1490d57ef6-e041b07042cmr12512351276.5.1720773909178; Fri, 12 Jul 2024
 01:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-14-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-14-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:44:58 +0300
Message-ID: <CAPMcbCpTqGrDABgOtZXpjFLnqksZq1565io1yTs6pS01=Aeh+Q@mail.gmail.com>
Subject: Re: [PATCH v2 19/22] qga: move declare of QGAConfig struct to top of
 file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000098863e061d08e5b4"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000098863e061d08e5b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:44=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> It is referenced by QGAState already, and it is clearer to declare all
> data types at the top of the file, rather than have them mixed with
> code later.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/main.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 17b6ce18ac..647d27037c 100644
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

--00000000000098863e061d08e5b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:44=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">It is referenced by QGAState already, and it is clearer=
 to declare all<br>
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
index 17b6ce18ac..647d27037c 100644<br>
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
</blockquote></div>

--00000000000098863e061d08e5b4--


