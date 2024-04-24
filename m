Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008FEC07E8E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYvN-0001dx-NM; Wed, 24 Apr 2024 05:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzYvL-0001cN-MU
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzYvJ-00032N-HE
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713950896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ux+8tfBogwa1NWMLUfSSfaiUAgizw5omcHn1f6A2P/w=;
 b=Y5WiSmyziLc1S7ozqf03FFX7JnFncNDugRen0WKZwnxwhqMorcjzM9BcZOe2kMZD/Yylqg
 +S8+Y4CB8zJWzlTqoW+zRo+KGMqLn2vSNaO8tRcmDK6HXOY04p1/whwPl7ui/wcC2bWkj+
 tmqnBYDvkVwrbgmZr+7XRd3godDGNQY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-K47evspIOxuX1RQJoMQLqg-1; Wed, 24 Apr 2024 05:28:14 -0400
X-MC-Unique: K47evspIOxuX1RQJoMQLqg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-61510f72bb3so141777277b3.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713950894; x=1714555694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ux+8tfBogwa1NWMLUfSSfaiUAgizw5omcHn1f6A2P/w=;
 b=L3c26Uocjm/Rl1mkR/prIMSQpEAnjUlM1LWHKAt75pM7iwP8SZcSMVr63DbKpgwVPw
 aU+L+ZVoBqne5nvbcICXgzdCdIuF31dWYv9b8H3qqH5TB0EX6DhG2OfNznuO2ApXdDnu
 /9ik8XWhN3xIOKtrFWCFkKrl5FDNkxrOXLiN09TcnriT8immGqS73tGYbPnr1sIZatpn
 hxwvPjFQhlDCwyggiKNNYiCO1CyqsvX7XdQO984dYeypwzrs5TYxmxWsCFQG+GNsBXn4
 Ush+v/HZUVFR4cQ5/F5+oS4UmPMq7Huxuo9YC8yD8H0qYkcip++BLIIzsqq0cnpF9xj2
 +NXQ==
X-Gm-Message-State: AOJu0YzL0D6WSlkT4vz7WP9mcGJvP9BqCXJ176UpHPyyVxhgYSqg6qP/
 kbNlF0xhgSSMZkH8bpSKT2MCMEtjV8+aaK1ZaPDK5NB9/4ZfM2m7dda/Q6SvHEAbAAGHFFb9gko
 qXfOasxsPpzbDAfeRq5/oepF5Yi2oXDULrRvsav9zwoKNbhIPqZERDlzWfVUfBtIYIfdM37u3dc
 UyZdUB1XoIHPdPmemK3X1+udfRo20=
X-Received: by 2002:a05:690c:6304:b0:615:41a4:1a8a with SMTP id
 ho4-20020a05690c630400b0061541a41a8amr1951493ywb.25.1713950893851; 
 Wed, 24 Apr 2024 02:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeXPVgpa4J8Xo7Ii9gzkOPZRLLtU7mdK6GJE+uo0/V75Qbrxl5HcVkHFIcXDTucgeMKFThfs+PNSh4w3AGXA8=
X-Received: by 2002:a05:690c:6304:b0:615:41a4:1a8a with SMTP id
 ho4-20020a05690c630400b0061541a41a8amr1951483ywb.25.1713950893537; Wed, 24
 Apr 2024 02:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240423150005.48175-1-aidan_leuck@selinc.com>
 <20240423150005.48175-2-aidan_leuck@selinc.com>
In-Reply-To: <20240423150005.48175-2-aidan_leuck@selinc.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 24 Apr 2024 12:28:02 +0300
Message-ID: <CAPMcbCoGTfd__9RUJXxWbT5Hz64KBTtpQLBz1xaTwx9Gyb-1sw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] Refactor common functions between POSIX and
 Windows implementation
To: aidan_leuck@selinc.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002c14f60616d44a5b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

--0000000000002c14f60616d44a5b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 6:01=E2=80=AFPM <aidan_leuck@selinc.com> wrote:

> From: aidaleuc <aidan_leuck@selinc.com>
>
> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
>

Please resend with the real name in Signed-off-by

Assuming this changes:
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>


> ---
>  qga/commands-common-ssh.c | 50 +++++++++++++++++++++++++++++++++++++++
>  qga/commands-common-ssh.h | 10 ++++++++
>  qga/commands-posix-ssh.c  | 47 +-----------------------------------
>  qga/meson.build           |  1 +
>  4 files changed, 62 insertions(+), 46 deletions(-)
>  create mode 100644 qga/commands-common-ssh.c
>  create mode 100644 qga/commands-common-ssh.h
>
> diff --git a/qga/commands-common-ssh.c b/qga/commands-common-ssh.c
> new file mode 100644
> index 0000000000..537869fb98
> --- /dev/null
> +++ b/qga/commands-common-ssh.c
> @@ -0,0 +1,50 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "commands-common-ssh.h"
> +
> +GStrv read_authkeys(const char *path, Error **errp)
> +{
> +    g_autoptr(GError) err =3D NULL;
> +    g_autofree char *contents =3D NULL;
> +
> +    if (!g_file_get_contents(path, &contents, NULL, &err)) {
> +        error_setg(errp, "failed to read '%s': %s", path, err->message);
> +        return NULL;
> +    }
> +
> +    return g_strsplit(contents, "\n", -1);
> +}
> +
> +bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
> +{
> +    size_t n =3D 0;
> +    strList *k;
> +
> +    for (k =3D keys; k !=3D NULL; k =3D k->next) {
> +        if (!check_openssh_pub_key(k->value, errp)) {
> +            return false;
> +        }
> +        n++;
> +    }
> +
> +    if (nkeys) {
> +        *nkeys =3D n;
> +    }
> +    return true;
> +}
> +
> +bool check_openssh_pub_key(const char *key, Error **errp)
> +{
> +    /* simple sanity-check, we may want more? */
> +    if (!key || key[0] =3D=3D '#' || strchr(key, '\n')) {
> +        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
> +        return false;
> +    }
> +
> +    return true;
> +}
> diff --git a/qga/commands-common-ssh.h b/qga/commands-common-ssh.h
> new file mode 100644
> index 0000000000..14d955fa84
> --- /dev/null
> +++ b/qga/commands-common-ssh.h
> @@ -0,0 +1,10 @@
> +/*
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qapi/qapi-builtin-types.h"
> +
> +GStrv read_authkeys(const char *path, Error **errp);
> +bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
> +bool check_openssh_pub_key(const char *key, Error **errp);
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 236f80de44..dd2ecb453a 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -9,6 +9,7 @@
>  #include <locale.h>
>  #include <pwd.h>
>
> +#include "commands-common-ssh.h"
>  #include "qapi/error.h"
>  #include "qga-qapi-commands.h"
>
> @@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *=
p,
>      return true;
>  }
>
> -static bool
> -check_openssh_pub_key(const char *key, Error **errp)
> -{
> -    /* simple sanity-check, we may want more? */
> -    if (!key || key[0] =3D=3D '#' || strchr(key, '\n')) {
> -        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -static bool
> -check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
> -{
> -    size_t n =3D 0;
> -    strList *k;
> -
> -    for (k =3D keys; k !=3D NULL; k =3D k->next) {
> -        if (!check_openssh_pub_key(k->value, errp)) {
> -            return false;
> -        }
> -        n++;
> -    }
> -
> -    if (nkeys) {
> -        *nkeys =3D n;
> -    }
> -    return true;
> -}
> -
>  static bool
>  write_authkeys(const char *path, const GStrv keys,
>                 const struct passwd *p, Error **errp)
> @@ -139,21 +109,6 @@ write_authkeys(const char *path, const GStrv keys,
>      return true;
>  }
>
> -static GStrv
> -read_authkeys(const char *path, Error **errp)
> -{
> -    g_autoptr(GError) err =3D NULL;
> -    g_autofree char *contents =3D NULL;
> -
> -    if (!g_file_get_contents(path, &contents, NULL, &err)) {
> -        error_setg(errp, "failed to read '%s': %s", path, err->message);
> -        return NULL;
> -    }
> -
> -    return g_strsplit(contents, "\n", -1);
> -
> -}
> -
>  void
>  qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>                                    bool has_reset, bool reset,
> diff --git a/qga/meson.build b/qga/meson.build
> index 1c3d2a3d1b..4c3899751b 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -66,6 +66,7 @@ qga_ss.add(files(
>    'guest-agent-command-state.c',
>    'main.c',
>    'cutils.c',
> +  'commands-common-ssh.c'
>  ))
>  if host_os =3D=3D 'windows'
>    qga_ss.add(files(
> --
> 2.34.1
>
>

--0000000000002c14f60616d44a5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Tue, Apr 23, 2024 at 6:01=E2=80=AFPM &lt;<a href=3D"mailto:ai=
dan_leuck@selinc.com">aidan_leuck@selinc.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">From: aidaleuc &lt;<a href=3D"m=
ailto:aidan_leuck@selinc.com" target=3D"_blank">aidan_leuck@selinc.com</a>&=
gt;<br>
<br>
Signed-off-by: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" targe=
t=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br></blockquote><div>=C2=A0</di=
v><div><div>Please resend with the real name in Signed-off-by</div><div><br=
></div><div>Assuming this changes:</div>Reviewed-by: Konstantin Kostiuk &lt=
;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.c=
om</a>&gt;</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
---<br>
=C2=A0qga/commands-common-ssh.c | 50 ++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-common-ssh.h | 10 ++++++++<br>
=C2=A0qga/commands-posix-ssh.c=C2=A0 | 47 +--------------------------------=
---<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<b=
r>
=C2=A04 files changed, 62 insertions(+), 46 deletions(-)<br>
=C2=A0create mode 100644 qga/commands-common-ssh.c<br>
=C2=A0create mode 100644 qga/commands-common-ssh.h<br>
<br>
diff --git a/qga/commands-common-ssh.c b/qga/commands-common-ssh.c<br>
new file mode 100644<br>
index 0000000000..537869fb98<br>
--- /dev/null<br>
+++ b/qga/commands-common-ssh.c<br>
@@ -0,0 +1,50 @@<br>
+/*<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;commands-common-ssh.h&quot;<br>
+<br>
+GStrv read_authkeys(const char *path, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *contents =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (!g_file_get_contents(path, &amp;contents, NULL, &amp;err=
)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to read &#39;%s&=
#39;: %s&quot;, path, err-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return g_strsplit(contents, &quot;\n&quot;, -1);<br>
+}<br>
+<br>
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)<br=
>
+{<br>
+=C2=A0 =C2=A0 size_t n =3D 0;<br>
+=C2=A0 =C2=A0 strList *k;<br>
+<br>
+=C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_openssh_pub_key(k-&gt;value, errp))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (nkeys) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *nkeys =3D n;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+bool check_openssh_pub_key(const char *key, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 /* simple sanity-check, we may want more? */<br>
+=C2=A0 =C2=A0 if (!key || key[0] =3D=3D &#39;#&#39; || strchr(key, &#39;\n=
&#39;)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;invalid OpenSSH public =
key: &#39;%s&#39;&quot;, key);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
diff --git a/qga/commands-common-ssh.h b/qga/commands-common-ssh.h<br>
new file mode 100644<br>
index 0000000000..14d955fa84<br>
--- /dev/null<br>
+++ b/qga/commands-common-ssh.h<br>
@@ -0,0 +1,10 @@<br>
+/*<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;qapi/qapi-builtin-types.h&quot;<br>
+<br>
+GStrv read_authkeys(const char *path, Error **errp);<br>
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);<b=
r>
+bool check_openssh_pub_key(const char *key, Error **errp);<br>
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c<br>
index 236f80de44..dd2ecb453a 100644<br>
--- a/qga/commands-posix-ssh.c<br>
+++ b/qga/commands-posix-ssh.c<br>
@@ -9,6 +9,7 @@<br>
=C2=A0#include &lt;locale.h&gt;<br>
=C2=A0#include &lt;pwd.h&gt;<br>
<br>
+#include &quot;commands-common-ssh.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qga-qapi-commands.h&quot;<br>
<br>
@@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *p,=
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-static bool<br>
-check_openssh_pub_key(const char *key, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 /* simple sanity-check, we may want more? */<br>
-=C2=A0 =C2=A0 if (!key || key[0] =3D=3D &#39;#&#39; || strchr(key, &#39;\n=
&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;invalid OpenSSH public =
key: &#39;%s&#39;&quot;, key);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
-static bool<br>
-check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 size_t n =3D 0;<br>
-=C2=A0 =C2=A0 strList *k;<br>
-<br>
-=C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_openssh_pub_key(k-&gt;value, errp))=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (nkeys) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *nkeys =3D n;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
=C2=A0static bool<br>
=C2=A0write_authkeys(const char *path, const GStrv keys,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct passwd=
 *p, Error **errp)<br>
@@ -139,21 +109,6 @@ write_authkeys(const char *path, const GStrv keys,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-static GStrv<br>
-read_authkeys(const char *path, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
-=C2=A0 =C2=A0 g_autofree char *contents =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (!g_file_get_contents(path, &amp;contents, NULL, &amp;err=
)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to read &#39;%s&=
#39;: %s&quot;, path, err-&gt;message);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return g_strsplit(contents, &quot;\n&quot;, -1);<br>
-<br>
-}<br>
-<br>
=C2=A0void<br>
=C2=A0qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_reset, bool re=
set,<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 1c3d2a3d1b..4c3899751b 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -66,6 +66,7 @@ qga_ss.add(files(<br>
=C2=A0 =C2=A0&#39;guest-agent-command-state.c&#39;,<br>
=C2=A0 =C2=A0&#39;main.c&#39;,<br>
=C2=A0 =C2=A0&#39;cutils.c&#39;,<br>
+=C2=A0 &#39;commands-common-ssh.c&#39;<br>
=C2=A0))<br>
=C2=A0if host_os =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0qga_ss.add(files(<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--0000000000002c14f60616d44a5b--


