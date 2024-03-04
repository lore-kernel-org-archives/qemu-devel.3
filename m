Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B63AC54E49
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3Zu-0007CT-VY; Mon, 04 Mar 2024 03:21:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3Zo-0007BY-B1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3Zm-0003OA-MU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709540492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pX+UiUFNg9ssn8alfoAA0EIlF720P4RAN8LE3ETNpS4=;
 b=dFDOD1vCJzGHpdGFYO9OQbNfha0pmkmNUM7MQCclmsIfpfkQZwUbkFb6Ysi1o2gotuDy4m
 Fjljnizio49+fTIOq+YXmeYK1ZFOFMkCEZND6a2eBx4i6VnhovbV6TVgB2Pnv1HVMsJChV
 J9HmIZsU08dUCdEpwgb6eCYdp3i+Nsk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-BuqZbn_uPyy5BigH09e1tw-1; Mon, 04 Mar 2024 03:21:31 -0500
X-MC-Unique: BuqZbn_uPyy5BigH09e1tw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d2a43ca538so23512091fa.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 00:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709540490; x=1710145290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pX+UiUFNg9ssn8alfoAA0EIlF720P4RAN8LE3ETNpS4=;
 b=C0+E3I2PBVjpuil4kx1lKi1dvrrjsT9B7yjkBi7SSg5i70ovuq1xi/15tSQMIgv+69
 o6JcSmdUCKoUWE91yB7y9c00kMlh7CmuqMqySyw94OIO0TQZfuma0qmz1BRZoafT3vVC
 TsIaH4sHvxm30Am8NwFjunjvgmLieln+tia5AZNKQYGUd4xo+oYFGWzQ3BEPiXGJ5sxJ
 dvcZ4TzukYwnA+fjnw+nUJlRvOBVUn0zE9uzTDCHwGoT+XRWilJHfV+h4hHbhQQdGHEu
 CNQK1fRT/XPI84HnlEI9ErNyPpuO/T2dH8jo6hOmukbgIm20Oe/ruwd6ZWrBEnB/H6Ei
 xogA==
X-Gm-Message-State: AOJu0YwyzwVwFCaVhjcC9nI76LFRtvxY+q/mK6JV02cmXlbaxugg28J6
 wcFlwf3wq/qWXpBSJT5fa1I9c3BazzT7dRFJ/lauhVakq4Po8s0AkFw1fdggv29FSZReQLYmcpW
 tWtrtRo5MNLIM3n+9+d80R4oLTdzf+g9BAiWifPXQh9BlhIRoUDs3JMsg6kBuFtDJq6wTrk8Skg
 Brv4NV+rEPnmY5a9D+sDuzBUfOvAg=
X-Received: by 2002:a05:651c:198d:b0:2d2:846b:8c4e with SMTP id
 bx13-20020a05651c198d00b002d2846b8c4emr4600572ljb.4.1709540490035; 
 Mon, 04 Mar 2024 00:21:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe9enyD3osQ/eeIgmznxUOMzdqiO5JQ73qfYoTStR9cIT8k7OU6p1K52lzz7wv8iUxnQm7sTS9Up388pb/tzI=
X-Received: by 2002:a05:651c:198d:b0:2d2:846b:8c4e with SMTP id
 bx13-20020a05651c198d00b002d2846b8c4emr4600561ljb.4.1709540489722; Mon, 04
 Mar 2024 00:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20240227113921.236097-1-armbru@redhat.com>
 <20240227113921.236097-12-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-12-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Mar 2024 10:21:18 +0200
Message-ID: <CAPMcbCqY+C+Qi5t2j6yQe9TkZ-AZNdNCzAZ0cByF-O7oR64Qvw@mail.gmail.com>
Subject: Re: [PATCH 11/13] qga/qapi-schema: Tweak documentation of fsfreeze
 commands
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 eblake@redhat.com
Content-Type: multipart/alternative; boundary="0000000000009e8f740612d16940"
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

--0000000000009e8f740612d16940
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Feb 27, 2024 at 1:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> "Returns:" sections of guest-fsfreeze-freeze and
> guest-fsfreeze-freeze-list describe both command behavior and success
> response.  Move behavior out, so "Returns:" is only about success
> response.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 326d324901..2ea1022092 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -437,15 +437,16 @@
>  # command succeeded, you may call @guest-fsfreeze-thaw later to
>  # unfreeze.
>  #
> +# On error, all filesystems will be thawed.  If no filesystems are
> +# frozen as a result of this call, then @guest-fsfreeze-status will
> +# remain "thawed" and calling @guest-fsfreeze-thaw is not necessary.
> +#
> +# Returns: Number of file systems currently frozen.
> +#
>  # Note: On Windows, the command is implemented with the help of a
>  #     Volume Shadow-copy Service DLL helper.  The frozen state is
>  #     limited for up to 10 seconds by VSS.
>  #
> -# Returns: Number of file systems currently frozen.  On error, all
> -#     filesystems will be thawed.  If no filesystems are frozen as a
> -#     result of this call, then @guest-fsfreeze-status will remain
> -#     "thawed" and calling @guest-fsfreeze-thaw is not necessary.
> -#
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-fsfreeze-freeze',
> @@ -457,12 +458,13 @@
>  # Sync and freeze specified guest filesystems.  See also
>  # @guest-fsfreeze-freeze.
>  #
> +# On error, all filesystems will be thawed.
> +#
>  # @mountpoints: an array of mountpoints of filesystems to be frozen.
>  #     If omitted, every mounted filesystem is frozen.  Invalid mount
>  #     points are ignored.
>  #
> -# Returns: Number of file systems currently frozen.  On error, all
> -#     filesystems will be thawed.
> +# Returns: Number of file systems currently frozen.
>  #
>  # Since: 2.2
>  ##
> --
> 2.43.0
>
>

--0000000000009e8f740612d16940
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 2=
7, 2024 at 1:39=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">&quot;Returns:&quot; sections of guest-fsfreeze=
-freeze and<br>
guest-fsfreeze-freeze-list describe both command behavior and success<br>
response.=C2=A0 Move behavior out, so &quot;Returns:&quot; is only about su=
ccess<br>
response.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 16 +++++++++-------<br>
=C2=A01 file changed, 9 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 326d324901..2ea1022092 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -437,15 +437,16 @@<br>
=C2=A0# command succeeded, you may call @guest-fsfreeze-thaw later to<br>
=C2=A0# unfreeze.<br>
=C2=A0#<br>
+# On error, all filesystems will be thawed.=C2=A0 If no filesystems are<br=
>
+# frozen as a result of this call, then @guest-fsfreeze-status will<br>
+# remain &quot;thawed&quot; and calling @guest-fsfreeze-thaw is not necess=
ary.<br>
+#<br>
+# Returns: Number of file systems currently frozen.<br>
+#<br>
=C2=A0# Note: On Windows, the command is implemented with the help of a<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Volume Shadow-copy Service DLL helper.=C2=A0 The=
 frozen state is<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0limited for up to 10 seconds by VSS.<br>
=C2=A0#<br>
-# Returns: Number of file systems currently frozen.=C2=A0 On error, all<br=
>
-#=C2=A0 =C2=A0 =C2=A0filesystems will be thawed.=C2=A0 If no filesystems a=
re frozen as a<br>
-#=C2=A0 =C2=A0 =C2=A0result of this call, then @guest-fsfreeze-status will=
 remain<br>
-#=C2=A0 =C2=A0 =C2=A0&quot;thawed&quot; and calling @guest-fsfreeze-thaw i=
s not necessary.<br>
-#<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-freeze&#39;,<br>
@@ -457,12 +458,13 @@<br>
=C2=A0# Sync and freeze specified guest filesystems.=C2=A0 See also<br>
=C2=A0# @guest-fsfreeze-freeze.<br>
=C2=A0#<br>
+# On error, all filesystems will be thawed.<br>
+#<br>
=C2=A0# @mountpoints: an array of mountpoints of filesystems to be frozen.<=
br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0If omitted, every mounted filesystem is frozen.=
=C2=A0 Invalid mount<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0points are ignored.<br>
=C2=A0#<br>
-# Returns: Number of file systems currently frozen.=C2=A0 On error, all<br=
>
-#=C2=A0 =C2=A0 =C2=A0filesystems will be thawed.<br>
+# Returns: Number of file systems currently frozen.<br>
=C2=A0#<br>
=C2=A0# Since: 2.2<br>
=C2=A0##<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--0000000000009e8f740612d16940--


