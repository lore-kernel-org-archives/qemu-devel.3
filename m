Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8B4C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBxv-0002W1-P6; Fri, 12 Jul 2024 04:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBxt-0002Tk-MD
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:49:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sSBxr-0002rv-La
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720774154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10oCWm+fDZssdTuiRuhrhBIn9QJtFXrgNJCILTjYsbM=;
 b=BKoWqz/p75U5BiMRbRru+yW8QpPFQs591/fe9PNhHqx+uBj26EyL4IttnQ6NlDaI1ygWo0
 74gK24jtn1r6uZXoDyxDzL0AvT7uh88Ny/OgwPvTe8jg6zHMEUon6nQsQ/P86au3gHX762
 KTln9PlvVuQmKDXgqxsIfjPbNq5EJb8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-k2NOo030NcmJHo569NKC3Q-1; Fri, 12 Jul 2024 04:46:30 -0400
X-MC-Unique: k2NOo030NcmJHo569NKC3Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-654d96c2bb5so30371447b3.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 01:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773990; x=1721378790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10oCWm+fDZssdTuiRuhrhBIn9QJtFXrgNJCILTjYsbM=;
 b=X7J3f/y7PHcZ7+tB+i0SOkFrDaPonjMZCKna++6mJxKtrLr3y7EGmTylM8xWiBnMik
 Dukw26mjt4rMYWgsVcaM0hU4U1zUJ8GMmwLAl9umpOC1GGe57NA8o8kttzqWYGKiwYZy
 081nnc63e++ssNj/FRz21im0LcZqESAXhsPaDXdnJHJminhFkNXB1lK7oxc6XTRq5gqU
 jQJJNREKqWAIMFlm+vuPHnuGoCMs5Wc8rNIJ3paHda3N1XNnEwooAovXbj0aDPS/Ruh1
 0gkn2K5XV3yCMOFrN4ZV7F1tHtCwmvIxmjA7q/QksdIv3le+Jou5pGbVERTlKAaDyJS7
 08Mg==
X-Gm-Message-State: AOJu0YyIgC5Zx5auldvO167W/Q7WiNbU0jh61Tze9yiyLUlHci22pVWC
 ZW3XdNgwN9mDWG3XCmUzEEgp9Tja3tjz1UaBuvjKBVdzxlff9sFH/PlBHXXalLCYyv5PcZOve6R
 s0rC6du+pEsG0NQgCTSR5MG+urQL1ivvpfnt+F3AwO50WcTsE9TzkX1c9q39KimOGRhj643wjkc
 IfH5FBFwR5Hhjt8F3W3HW+jNC6LiM=
X-Received: by 2002:a05:690c:6d12:b0:650:9c5e:f6ce with SMTP id
 00721157ae682-658ebcad383mr133523227b3.0.1720773990284; 
 Fri, 12 Jul 2024 01:46:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkf9qTpyXbLMn/kW/XNLU9bFSgTxG64geh6pfDA+iAN6kq0so0A+naHVOVfaZc1GWvO35jW3u2tNOdS68wigI=
X-Received: by 2002:a05:690c:6d12:b0:650:9c5e:f6ce with SMTP id
 00721157ae682-658ebcad383mr133523047b3.0.1720773990022; Fri, 12 Jul 2024
 01:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
 <20240613154406.1365469-15-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-15-berrange@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Fri, 12 Jul 2024 11:46:19 +0300
Message-ID: <CAPMcbCq5z7CHRDuewRVP-APXYsMhNV80EYN4tPUQsdjcHcBRvw@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] qga: remove pointless 'blockrpcs_key' variable
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006a145d061d08ea3e"
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

--0000000000006a145d061d08ea3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Thu, Jun 13, 2024 at 6:45=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> This variable was used to support back compat for the old config
> file key name, and became redundant after the following change:
>
>   commit a7a2d636ae4549ef0551134d4bf8e084a14431c4
>   Author: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>   Date:   Thu May 30 08:36:43 2024 +0200
>
>     qga: Remove deprecated 'blacklist' argument / config key
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qga/main.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 647d27037c..6ff022a85d 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1023,7 +1023,6 @@ static void config_load(GAConfig *config)
>      GError *gerr =3D NULL;
>      GKeyFile *keyfile;
>      g_autofree char *conf =3D g_strdup(g_getenv("QGA_CONF")) ?:
> get_relocated_path(QGA_CONF_DEFAULT);
> -    const gchar *blockrpcs_key =3D "block-rpcs";
>
>      /* read system config */
>      keyfile =3D g_key_file_new();
> @@ -1071,9 +1070,9 @@ static void config_load(GAConfig *config)
>              g_key_file_get_boolean(keyfile, "general", "retry-path",
> &gerr);
>      }
>
> -    if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL)) {
> +    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL)) {
>          config->bliststr =3D
> -            g_key_file_get_string(keyfile, "general", blockrpcs_key,
> &gerr);
> +            g_key_file_get_string(keyfile, "general", "block-rpcs",
> &gerr);
>          config->blockedrpcs =3D g_list_concat(config->blockedrpcs,
>                                            split_list(config->bliststr,
> ","));
>      }
> @@ -1084,7 +1083,7 @@ static void config_load(GAConfig *config)
>                                            split_list(config->aliststr,
> ","));
>      }
>
> -    if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL) &&
> +    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL) &&
>          g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
>          g_critical("wrong config, using 'block-rpcs' and 'allow-rpcs'
> keys at"
>                     " the same time is not allowed");
> --
> 2.45.1
>
>

--0000000000006a145d061d08ea3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 6:45=E2=
=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com"=
>berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">This variable was used to support back compat for the o=
ld config<br>
file key name, and became redundant after the following change:<br>
<br>
=C2=A0 commit a7a2d636ae4549ef0551134d4bf8e084a14431c4<br>
=C2=A0 Author: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
=C2=A0 Date:=C2=A0 =C2=A0Thu May 30 08:36:43 2024 +0200<br>
<br>
=C2=A0 =C2=A0 qga: Remove deprecated &#39;blacklist&#39; argument / config =
key<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 647d27037c..6ff022a85d 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1023,7 +1023,6 @@ static void config_load(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0GError *gerr =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0GKeyFile *keyfile;<br>
=C2=A0 =C2=A0 =C2=A0g_autofree char *conf =3D g_strdup(g_getenv(&quot;QGA_C=
ONF&quot;)) ?: get_relocated_path(QGA_CONF_DEFAULT);<br>
-=C2=A0 =C2=A0 const gchar *blockrpcs_key =3D &quot;block-rpcs&quot;;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* read system config */<br>
=C2=A0 =C2=A0 =C2=A0keyfile =3D g_key_file_new();<br>
@@ -1071,9 +1070,9 @@ static void config_load(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_key_file_get_boolean(keyf=
ile, &quot;general&quot;, &quot;retry-path&quot;, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, blockrp=
cs_key, NULL)) {<br>
+=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;b=
lock-rpcs&quot;, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;bliststr =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_get_string(keyfile, &=
quot;general&quot;, blockrpcs_key, &amp;gerr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_key_file_get_string(keyfile, &=
quot;general&quot;, &quot;block-rpcs&quot;, &amp;gerr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0config-&gt;blockedrpcs =3D g_list_concat(=
config-&gt;blockedrpcs,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0split_list(config-&gt;bliststr, &quot;,&quot;));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1084,7 +1083,7 @@ static void config_load(GAConfig *config)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0split_list(config-&gt;aliststr, &quot;,&quot;));<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, blockrp=
cs_key, NULL) &amp;&amp;<br>
+=C2=A0 =C2=A0 if (g_key_file_has_key(keyfile, &quot;general&quot;, &quot;b=
lock-rpcs&quot;, NULL) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_key_file_has_key(keyfile, &quot;general=
&quot;, &quot;allow-rpcs&quot;, NULL)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;wrong config, using &#39=
;block-rpcs&#39; and &#39;allow-rpcs&#39; keys at&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot=
; the same time is not allowed&quot;);<br>
-- <br>
2.45.1<br>
<br>
</blockquote></div>

--0000000000006a145d061d08ea3e--


