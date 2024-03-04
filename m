Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31928C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3eN-0001oi-3v; Mon, 04 Mar 2024 03:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3eL-0001oE-Np
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3eB-0004Lz-L3
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:26:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709540763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5JWkWJQlIPLTEL3TlwaergdV7vE3AGIgoM/aQ3gO1iY=;
 b=UPv4yw4oXUnKEbVDuGNLQhAqjhJTpyKXUHXkYbdz3PI22VezZ8MmO9mhP12n/4DHF6dSyh
 6IvSgyBjGndTtwKSB4QfF/VN1fXOAsD2IpBSEVP1uLBeG63sY8LbdF4uWapG+S9drNAtF3
 GYWIZht4oVJ7KToxU1Nwj82thOrPaHg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-kz6pI6sANgC91c0N4AzsAQ-1; Mon, 04 Mar 2024 03:25:59 -0500
X-MC-Unique: kz6pI6sANgC91c0N4AzsAQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5131796a4b7so3835819e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 00:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709540758; x=1710145558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5JWkWJQlIPLTEL3TlwaergdV7vE3AGIgoM/aQ3gO1iY=;
 b=CoEs6blI464gkF/r6Vl8jzy3jo1puy/uu7IPeW01jBAGSm5OvKskU211HsK4pN/Tq0
 XfExm126Q1moMR0NUNtrOSCxkqD+b2hTPr8WYXYtIrf01FagTg1ScmON5ITRqSxfnB2T
 5q1F8Y415GRlwE6LTBO7ToAmEK8UoKcr/F/9CXovolkAbppHUigVIsthPFS2IQK3xA8c
 P7K6ZTutp38NFAhBCk6K4+17SO1JcANiwQHGm0L0sMeb3jb2OFRSUYROpCE7gKjwaz9I
 /j36/ooiU8eTbmal1ooDhXrIDlQNrbAXEdA5DC2aPmVJrlMqSmL9CShM1VXYhwp4pJ8X
 W62Q==
X-Gm-Message-State: AOJu0YwsNaYXQRmbrJCyvvqumOYMkUmkLGZLkQpDdDgrt7b15h5soWCv
 Z2WP4pWGkwn0Y82KUnKtV1Flw19udUelckeN2LOY2q3quoKnRDAgke9xZYGUWUl3QhMU6LgW58k
 6gk8iE5N5o1RWLeUjJeZHMkOY+MZaYfAOq262UqIYDbZNEWW94eaQkWbngNveLzGIaOIn9Y7/n2
 mZzWdJJTjlCH4YZHoRH84VcE5HCWI=
X-Received: by 2002:ac2:4102:0:b0:512:a943:a0c3 with SMTP id
 b2-20020ac24102000000b00512a943a0c3mr4653641lfi.57.1709540758078; 
 Mon, 04 Mar 2024 00:25:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa2dHyJ0kjeOWK08lVbhQtL4h1LAaj2EqqCJq7y7gjIIDlmS41KWwLHYkP7zlXtFy2Somtnpxy9huRpTeUVTA=
X-Received: by 2002:ac2:4102:0:b0:512:a943:a0c3 with SMTP id
 b2-20020ac24102000000b00512a943a0c3mr4653637lfi.57.1709540757788; Mon, 04 Mar
 2024 00:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20240227113921.236097-1-armbru@redhat.com>
 <20240227113921.236097-10-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-10-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Mar 2024 10:25:46 +0200
Message-ID: <CAPMcbCq-cwYqBpNP3=MvHiijWb0DUiFY_OrpqqkHQhrB2LJ-rA@mail.gmail.com>
Subject: Re: [PATCH 09/13] qga/qapi-schema: Delete useless "Returns" sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 eblake@redhat.com
Content-Type: multipart/alternative; boundary="00000000000098f1b70612d17950"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000098f1b70612d17950
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Feb 27, 2024 at 1:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c5f2ac8f59..636c2c5697 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -153,8 +153,6 @@
>  # @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in
>  #     UTC.
>  #
> -# Returns: Nothing on success.
> -#
>  # Since: 1.5
>  ##
>  { 'command': 'guest-set-time',
> @@ -245,8 +243,6 @@
>  #
>  # @handle: filehandle returned by guest-file-open
>  #
> -# Returns: Nothing on success.
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-file-close',
> @@ -399,8 +395,6 @@
>  #
>  # @handle: filehandle returned by guest-file-open
>  #
> -# Returns: Nothing on success.
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-file-flush',
> @@ -1077,8 +1071,6 @@
>  # transmission, even if already crypt()d, to ensure it is 8-bit safe
>  # when passed as JSON.
>  #
> -# Returns: Nothing on success.
> -#
>  # Since: 2.3
>  ##
>  { 'command': 'guest-set-user-password',
> @@ -1602,8 +1594,6 @@
>  #
>  # @reset: ignore the existing content, set it with the given keys only
>  #
> -# Returns: Nothing on success.
> -#
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-add-authorized-keys',
> @@ -1622,8 +1612,6 @@
>  # @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys
>  #     format)
>  #
> -# Returns: Nothing on success.
> -#
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-remove-authorized-keys',
> --
> 2.43.0
>
>

--00000000000098f1b70612d17950
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
=C2=A0qga/qapi-schema.json | 12 ------------<br>
=C2=A01 file changed, 12 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c5f2ac8f59..636c2c5697 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -153,8 +153,6 @@<br>
=C2=A0# @time: time of nanoseconds, relative to the Epoch of 1970-01-01 in<=
br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0UTC.<br>
=C2=A0#<br>
-# Returns: Nothing on success.<br>
-#<br>
=C2=A0# Since: 1.5<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-time&#39;,<br>
@@ -245,8 +243,6 @@<br>
=C2=A0#<br>
=C2=A0# @handle: filehandle returned by guest-file-open<br>
=C2=A0#<br>
-# Returns: Nothing on success.<br>
-#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-file-close&#39;,<br>
@@ -399,8 +395,6 @@<br>
=C2=A0#<br>
=C2=A0# @handle: filehandle returned by guest-file-open<br>
=C2=A0#<br>
-# Returns: Nothing on success.<br>
-#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-file-flush&#39;,<br>
@@ -1077,8 +1071,6 @@<br>
=C2=A0# transmission, even if already crypt()d, to ensure it is 8-bit safe<=
br>
=C2=A0# when passed as JSON.<br>
=C2=A0#<br>
-# Returns: Nothing on success.<br>
-#<br>
=C2=A0# Since: 2.3<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-set-user-password&#39;,<br>
@@ -1602,8 +1594,6 @@<br>
=C2=A0#<br>
=C2=A0# @reset: ignore the existing content, set it with the given keys onl=
y<br>
=C2=A0#<br>
-# Returns: Nothing on success.<br>
-#<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-add-authorized-keys&#39;,<br>
@@ -1622,8 +1612,6 @@<br>
=C2=A0# @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_key=
s<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0format)<br>
=C2=A0#<br>
-# Returns: Nothing on success.<br>
-#<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-remove-authorized-keys&#39;,<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--00000000000098f1b70612d17950--


