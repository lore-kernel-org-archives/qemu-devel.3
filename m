Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605D6C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3bf-0000KJ-VH; Mon, 04 Mar 2024 03:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3bd-0000J1-Sy
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3bc-0003dH-73
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709540607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWSbj/48wKuJrDLBpxDgSoQ5SgacQBpTe47mkcNqAsI=;
 b=dw9+XNa47LGde2zwjBkYDgxnbS3aesnpO383ELgSWDi8gwAjqjwSgMj3dmi4xK+T+T4L0K
 laxrZftHP5VtEYsN4lznF9np/cj/Tqyg3qCCMuxQ9nkOuojgBgYD8p+ZMiaIVLCISpWSf8
 C9Ql6TkW+OaaHTcfjAK60AJvcFl0r/E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-9QpnPGffOduuyalLgBl-kQ-1; Mon, 04 Mar 2024 03:23:25 -0500
X-MC-Unique: 9QpnPGffOduuyalLgBl-kQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513297a755dso5214172e87.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 00:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709540603; x=1710145403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWSbj/48wKuJrDLBpxDgSoQ5SgacQBpTe47mkcNqAsI=;
 b=il6aR/2MSTuQmh6HOeETpg6FMYqAnjcP1QfUtLTdCaGr13ffJ8AkAC2IR4XumWqi/N
 oqZQDbHHTt7mibWvHC9bPqaysJ6SwysGFrPTAhoSSIWfb8Dfk5P7dl5LgBEtBEDcQ6nv
 VTNebJvXHtX90MyefAkhrzimcxoONsxqJxbZ5lmt6Lv00xgiGIrl9Vt9c0Z//tTZ2aFy
 sc/bhdNu6/F/4GO7M+/HobUhjH5XPLJayyKhDhtL7GN6ut3r7PXuDu/ZYyaeNEkZgcQP
 mjd4E+eJafnp79PFQ+ow8jEhvlMwf3gGPw3ZFND3dJz9RHVyfGFeoY4bdQ6i1KpVfY6I
 7rVw==
X-Gm-Message-State: AOJu0YyF6SEQ6esvVChY42NjTbWYh4l1uxLn1cXaVpTgQJGiLstuumUi
 CwIrf7aaaJ3pEeCr2KH1XUHhlf3atUs73Xofr2woi/Be9GZEF1N6tWvRaXLCbckQfgGZYv1FrfN
 a5ou8SVFTxnO3Jf/RT31BWCNe4fxdt3DSCdahuitvRsdsXqc/zXUAy20VUwwPCdb7gWNlI7Fgoa
 ryp5glYbrBz8bur7vC+n+EXrAllOaJ2cLB80MbBA==
X-Received: by 2002:a05:6512:1589:b0:513:45ca:5410 with SMTP id
 bp9-20020a056512158900b0051345ca5410mr2231157lfb.68.1709540603728; 
 Mon, 04 Mar 2024 00:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy/f1cpsgYGfi7wlK8cwFaHpQFQYrpgA1r//qpUoNNsVvNwiaxzrDndU+jpPW3jNWrTkkLX0cCNbxuzP5ykH4=
X-Received: by 2002:a05:6512:1589:b0:513:45ca:5410 with SMTP id
 bp9-20020a056512158900b0051345ca5410mr2231143lfb.68.1709540603403; Mon, 04
 Mar 2024 00:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20240227113921.236097-1-armbru@redhat.com>
 <20240227113921.236097-9-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-9-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Mar 2024 10:23:12 +0200
Message-ID: <CAPMcbCohWkdYhVM3tCEwQAJbBzQcGHCaPyf_dyn_3knEeY1WRQ@mail.gmail.com>
Subject: Re: [PATCH 08/13] qga/qapi-schema: Move error documentation to new
 "Errors" sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 eblake@redhat.com
Content-Type: multipart/alternative; boundary="00000000000065314d0612d17073"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--00000000000065314d0612d17073
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Feb 27, 2024 at 1:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b8efe31897..c5f2ac8f59 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -561,9 +561,8 @@
>  # could also exit (or set its status to "shutdown") due to other
>  # reasons.
>  #
> -# The following errors may be returned:
> -#
> -# - If suspend to disk is not supported, Unsupported
> +# Errors:
> +#     - If suspend to disk is not supported, Unsupported
>  #
>  # Notes: It's strongly recommended to issue the guest-sync command
>  #     before sending commands when the guest resumes
> @@ -598,9 +597,8 @@
>  # 2. Issue the query-status QMP command to confirm the VM status is
>  #    "suspended"
>  #
> -# The following errors may be returned:
> -#
> -# - If suspend to ram is not supported, Unsupported
> +# Errors:
> +#     - If suspend to ram is not supported, Unsupported
>  #
>  # Notes: It's strongly recommended to issue the guest-sync command
>  #     before sending commands when the guest resumes
> @@ -634,9 +632,8 @@
>  # 2. Issue the query-status QMP command to confirm the VM status is
>  #    "suspended"
>  #
> -# The following errors may be returned:
> -#
> -# - If hybrid suspend is not supported, Unsupported
> +# Errors:
> +#     - If hybrid suspend is not supported, Unsupported
>  #
>  # Notes: It's strongly recommended to issue the guest-sync command
>  #     before sending commands when the guest resumes
> @@ -796,9 +793,6 @@
>  #     - 0:
>  #       if the @vcpus list was empty on input.  Guest state has not
>  #       been changed.  Otherwise,
> -#     - Error:
> -#       processing the first node of @vcpus failed for the reason
> -#       returned.  Guest state has not been changed.  Otherwise,
>  #     - < length(@vcpus):
>  #       more than zero initial nodes have been processed, but not the
>  #       entire @vcpus list.  Guest state has changed accordingly.  To
> @@ -808,6 +802,10 @@
>  #     - length(@vcpus):
>  #       call successful.
>  #
> +# Errors:
> +#     - If the reconfiguration of the first node in @vcpus failed.
> +#       Guest state has not been changed.
> +#
>  # Since: 1.5
>  ##
>  { 'command': 'guest-set-vcpus',
> --
> 2.43.0
>
>

--00000000000065314d0612d17073
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 2=
7, 2024 at 1:39=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Signed-off-by: Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 22 ++++++++++------------<br>
=C2=A01 file changed, 10 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index b8efe31897..c5f2ac8f59 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -561,9 +561,8 @@<br>
=C2=A0# could also exit (or set its status to &quot;shutdown&quot;) due to =
other<br>
=C2=A0# reasons.<br>
=C2=A0#<br>
-# The following errors may be returned:<br>
-#<br>
-# - If suspend to disk is not supported, Unsupported<br>
+# Errors:<br>
+#=C2=A0 =C2=A0 =C2=A0- If suspend to disk is not supported, Unsupported<br=
>
=C2=A0#<br>
=C2=A0# Notes: It&#39;s strongly recommended to issue the guest-sync comman=
d<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resumes<b=
r>
@@ -598,9 +597,8 @@<br>
=C2=A0# 2. Issue the query-status QMP command to confirm the VM status is<b=
r>
=C2=A0#=C2=A0 =C2=A0 &quot;suspended&quot;<br>
=C2=A0#<br>
-# The following errors may be returned:<br>
-#<br>
-# - If suspend to ram is not supported, Unsupported<br>
+# Errors:<br>
+#=C2=A0 =C2=A0 =C2=A0- If suspend to ram is not supported, Unsupported<br>
=C2=A0#<br>
=C2=A0# Notes: It&#39;s strongly recommended to issue the guest-sync comman=
d<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resumes<b=
r>
@@ -634,9 +632,8 @@<br>
=C2=A0# 2. Issue the query-status QMP command to confirm the VM status is<b=
r>
=C2=A0#=C2=A0 =C2=A0 &quot;suspended&quot;<br>
=C2=A0#<br>
-# The following errors may be returned:<br>
-#<br>
-# - If hybrid suspend is not supported, Unsupported<br>
+# Errors:<br>
+#=C2=A0 =C2=A0 =C2=A0- If hybrid suspend is not supported, Unsupported<br>
=C2=A0#<br>
=C2=A0# Notes: It&#39;s strongly recommended to issue the guest-sync comman=
d<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0before sending commands when the guest resumes<b=
r>
@@ -796,9 +793,6 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- 0:<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0if the @vcpus list was empty on input.=C2=
=A0 Guest state has not<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0been changed.=C2=A0 Otherwise,<br>
-#=C2=A0 =C2=A0 =C2=A0- Error:<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0processing the first node of @vcpus failed for=
 the reason<br>
-#=C2=A0 =C2=A0 =C2=A0 =C2=A0returned.=C2=A0 Guest state has not been chang=
ed.=C2=A0 Otherwise,<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- &lt; length(@vcpus):<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0more than zero initial nodes have been pr=
ocessed, but not the<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0entire @vcpus list.=C2=A0 Guest state has=
 changed accordingly.=C2=A0 To<br>
@@ -808,6 +802,10 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0- length(@vcpus):<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0 =C2=A0call successful.<br>
=C2=A0#<br>
+# Errors:<br>
+#=C2=A0 =C2=A0 =C2=A0- If the reconfiguration of the first node in @vcpus =
failed.<br>
+#=C2=A0 =C2=A0 =C2=A0 =C2=A0Guest state has not been changed.<br>
+#<br>
=C2=A0# Since: 1.5<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-vcpus&#39;,<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--00000000000065314d0612d17073--


