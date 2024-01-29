Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4B0C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUNi-0008JJ-56; Mon, 29 Jan 2024 11:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUUNf-0008Gv-Iv
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUUNd-0005U7-Lt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706545264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Gue4fwWNdyGHyICD4MMWGmgA8ROK5Px0XEwhrlRARY=;
 b=RUVV9ebspomjbSz828Lj+J1CwkxFi2DMQkkD4GTX8fA2p4pj1M162fDFKxefxXmGA+EcNC
 KY5PehTZ+k/a35oczHMiM4CBLMEV/QRmXqYF8za75vBUxrVWdBWpBPDLtUCtDWqpxZfJbd
 TWyF3XBUpGVW3CrZlDHv9w90wMU8Xb4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Qeu_AkErOc6jpM8AJF3axA-1; Mon, 29 Jan 2024 11:21:01 -0500
X-MC-Unique: Qeu_AkErOc6jpM8AJF3axA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5101cd9c910so1975982e87.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706545260; x=1707150060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Gue4fwWNdyGHyICD4MMWGmgA8ROK5Px0XEwhrlRARY=;
 b=jftL/jjkeTQXtUu0+KK3qvjCo06UrMqLb0bIdoiWE9XVHATeD7U4ATX/c1ZT/Jqd0X
 2JHxGUeb1skkHHcgDOzw8xI75lzX+CktJyG091JhuyxD7yJFMCK+/PQa2MddI3kcuhtY
 qEyMUHHVr3FSwCOPyucL/l7cPp7ZTI04azi3z/ORPFo/zNwvoVbD/Fi6nY6u70YeLpLb
 vrvQ7USa20OxdHj1vWIKQLU9mLmZnGeHN7CaYxU5o+ohdb2AXSdRhEDndAjpRwb99iBJ
 62OsGX6WR14MHEaRjWObu2FseZnoG8wIHZu/aIqvDKiUH4XypAa7O5/sC0AsyiFW+yUX
 Gm8Q==
X-Gm-Message-State: AOJu0YyrjRuQWqpd6O8JAPtGdruvduTsjUhG8gCzM1h1KCwOkb6qbVmq
 ulaGQt890VRz9pDNDhcOONWPGt2r9Wr+HslEYm4SgjIU/VLxm6rA6gqppqjtCtRrmG+IsYhAzQm
 yoyjSogeCcTJdXShlr0ccnvjN/tTtmwwmV9ko1I2LcQklPc4g/m4AkZ+Pfpiw8mxdzIPDFQqqpU
 kC9fjT1QOfQPl4UvL4JPlFacQ4J2k=
X-Received: by 2002:a05:6512:33ca:b0:510:e815:7bec with SMTP id
 d10-20020a05651233ca00b00510e8157becmr4092219lfg.27.1706545259920; 
 Mon, 29 Jan 2024 08:20:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCuPEaFCiAq85+o7YB6ubu/OU0nzaNc00wOcn7LsyEEKQIz6ZqUPLMXqX/cqmkYMRZTT0nJKAn+564NH1ZcJc=
X-Received: by 2002:a05:6512:33ca:b0:510:e815:7bec with SMTP id
 d10-20020a05651233ca00b00510e8157becmr4092191lfg.27.1706545259604; Mon, 29
 Jan 2024 08:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20240129115008.674248-1-armbru@redhat.com>
 <20240129115008.674248-6-armbru@redhat.com>
In-Reply-To: <20240129115008.674248-6-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 29 Jan 2024 18:20:48 +0200
Message-ID: <CAPMcbCrWmFvZV6Dshrq2DdWHYOkVSHoLO3FyVu=vEU_Urc7nHA@mail.gmail.com>
Subject: Re: [PATCH 5/5] qga/qapi-schema: Move command description right after
 command name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, 
 hreitz@redhat.com, michael.roth@amd.com, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fdfdc206101807a7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000fdfdc206101807a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Jan 29, 2024 at 1:50=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Documentation of commands guest-ssh-get-authorized-keys,
> guest-ssh-add-authorized-keys, and guest-ssh-remove-authorized-keys
> describes the command's purpose after its arguments.  Everywhere else,
> we do it the other way round.  Move it for consistency.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 876e2a8ea8..50b0a558c7 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1565,11 +1565,11 @@
>  ##
>  # @guest-ssh-get-authorized-keys:
>  #
> -# @username: the user account to add the authorized keys
> -#
>  # Return the public keys from user .ssh/authorized_keys on Unix
>  # systems (not implemented for other systems).
>  #
> +# @username: the user account to add the authorized keys
> +#
>  # Returns: @GuestAuthorizedKeys
>  #
>  # Since: 5.2
> @@ -1582,6 +1582,9 @@
>  ##
>  # @guest-ssh-add-authorized-keys:
>  #
> +# Append public keys to user .ssh/authorized_keys on Unix systems (not
> +# implemented for other systems).
> +#
>  # @username: the user account to add the authorized keys
>  #
>  # @keys: the public keys to add (in OpenSSH/sshd(8) authorized_keys
> @@ -1589,9 +1592,6 @@
>  #
>  # @reset: ignore the existing content, set it with the given keys only
>  #
> -# Append public keys to user .ssh/authorized_keys on Unix systems (not
> -# implemented for other systems).
> -#
>  # Returns: Nothing on success.
>  #
>  # Since: 5.2
> @@ -1603,15 +1603,15 @@
>  ##
>  # @guest-ssh-remove-authorized-keys:
>  #
> +# Remove public keys from the user .ssh/authorized_keys on Unix
> +# systems (not implemented for other systems). It's not an error if
> +# the key is already missing.
> +#
>  # @username: the user account to remove the authorized keys
>  #
>  # @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys
>  #     format)
>  #
> -# Remove public keys from the user .ssh/authorized_keys on Unix
> -# systems (not implemented for other systems). It's not an error if
> -# the key is already missing.
> -#
>  # Returns: Nothing on success.
>  #
>  # Since: 5.2
> --
> 2.43.0
>
>

--000000000000fdfdc206101807a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 2=
9, 2024 at 1:50=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Documentation of commands guest-ssh-get-authori=
zed-keys,<br>
guest-ssh-add-authorized-keys, and guest-ssh-remove-authorized-keys<br>
describes the command&#39;s purpose after its arguments.=C2=A0 Everywhere e=
lse,<br>
we do it the other way round.=C2=A0 Move it for consistency.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 18 +++++++++---------<br>
=C2=A01 file changed, 9 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 876e2a8ea8..50b0a558c7 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1565,11 +1565,11 @@<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-get-authorized-keys:<br>
=C2=A0#<br>
-# @username: the user account to add the authorized keys<br>
-#<br>
=C2=A0# Return the public keys from user .ssh/authorized_keys on Unix<br>
=C2=A0# systems (not implemented for other systems).<br>
=C2=A0#<br>
+# @username: the user account to add the authorized keys<br>
+#<br>
=C2=A0# Returns: @GuestAuthorizedKeys<br>
=C2=A0#<br>
=C2=A0# Since: 5.2<br>
@@ -1582,6 +1582,9 @@<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-add-authorized-keys:<br>
=C2=A0#<br>
+# Append public keys to user .ssh/authorized_keys on Unix systems (not<br>
+# implemented for other systems).<br>
+#<br>
=C2=A0# @username: the user account to add the authorized keys<br>
=C2=A0#<br>
=C2=A0# @keys: the public keys to add (in OpenSSH/sshd(8) authorized_keys<b=
r>
@@ -1589,9 +1592,6 @@<br>
=C2=A0#<br>
=C2=A0# @reset: ignore the existing content, set it with the given keys onl=
y<br>
=C2=A0#<br>
-# Append public keys to user .ssh/authorized_keys on Unix systems (not<br>
-# implemented for other systems).<br>
-#<br>
=C2=A0# Returns: Nothing on success.<br>
=C2=A0#<br>
=C2=A0# Since: 5.2<br>
@@ -1603,15 +1603,15 @@<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-remove-authorized-keys:<br>
=C2=A0#<br>
+# Remove public keys from the user .ssh/authorized_keys on Unix<br>
+# systems (not implemented for other systems). It&#39;s not an error if<br=
>
+# the key is already missing.<br>
+#<br>
=C2=A0# @username: the user account to remove the authorized keys<br>
=C2=A0#<br>
=C2=A0# @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_key=
s<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0format)<br>
=C2=A0#<br>
-# Remove public keys from the user .ssh/authorized_keys on Unix<br>
-# systems (not implemented for other systems). It&#39;s not an error if<br=
>
-# the key is already missing.<br>
-#<br>
=C2=A0# Returns: Nothing on success.<br>
=C2=A0#<br>
=C2=A0# Since: 5.2<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000fdfdc206101807a7--


