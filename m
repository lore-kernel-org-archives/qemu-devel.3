Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D7CC54E41
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 08:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh3VS-0005GF-CC; Mon, 04 Mar 2024 03:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3V7-0005DV-AG
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rh3V4-00026h-Vr
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 03:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709540201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WoGqHANOUOGSRCApX8d5K4pwVyQaDJR8e+pWBWyDMeI=;
 b=Z1gxFPgjgWubtR0JLRvkbOgq41BZ8XX71wYyNutWx2eW/6IpEQnXEiWykCV53ZqMiaryCz
 8EBrxvpaaAzXgx2/t14VCPty9STDTHw6ag6XPZoIZy9KWEKtdBK5q29ca74MQcWLZYsdHG
 YNemDG940SDoMiXcsc0P8IgiT1NZN6M=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Ihnzg8zvPkS0Inp9KrXJkw-1; Mon, 04 Mar 2024 03:16:39 -0500
X-MC-Unique: Ihnzg8zvPkS0Inp9KrXJkw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513210b2c7aso2208370e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 00:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709540198; x=1710144998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoGqHANOUOGSRCApX8d5K4pwVyQaDJR8e+pWBWyDMeI=;
 b=vqMOzyngnIO+sr2dVD4oFlhcDsgqMbAGkehY0zASF7BjpdrU3DbTuO6cLhZA1B+GIl
 jf2/AftO0SrZipNyBTUlSCOReYlxh6OflwpPkg11L0t3DrD4YgUpw8S4FeOPtS5d/VbV
 5vaQO9LvUM0X0kFnBDZ+VCRGcN6f7ZsG+ol26rOGqNMyiEXtrOH45o1iIh9pdDspDCvx
 BAwA2H8QunW4W1EpFKOJFrTpBmYYprvFDY/DbQsLLrbZmACKdspYiYhtCnLKWRBFHHRQ
 K+EyLMRsT8tDyWXsZLJoJhsbNmBUXxshm5/64ozSuleyY5eVF5XoeyDdQPChN9i2/Slt
 TyvQ==
X-Gm-Message-State: AOJu0Yy3/bgt9B2tju1lwCP61itzkzWz6bXuujtQYL+Z4D6PKM7lBbwM
 fv87Ln0yfvtIUoHAS6pH+gpkiOXIBNFlAc3QSZiqv3bjSjrQ0gaev3Axc8dHtS6EfOc6vSKDBo7
 tkpXxeZbZLC5K8rVUwkRx6j+oiZSPnaxoo//lx3Q/6ySa+pGrtMaLpXTgq0yawf2Q8e74Jf0hOX
 2qyn+av7GTnVrErFt14RpSM9MbsMSuWF+eBsFmcQ==
X-Received: by 2002:ac2:51b5:0:b0:513:411e:e6d7 with SMTP id
 f21-20020ac251b5000000b00513411ee6d7mr1134652lfk.0.1709540197955; 
 Mon, 04 Mar 2024 00:16:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWPQ9/4DmKd6Sv9M3vak6Ce/3xvc5I5u3g837qtNpv6OjdjsbNVjCiUFAE0hFgPLqhBdsRlS5/UIhPNWOxhuM=
X-Received: by 2002:ac2:51b5:0:b0:513:411e:e6d7 with SMTP id
 f21-20020ac251b5000000b00513411ee6d7mr1134649lfk.0.1709540197640; Mon, 04 Mar
 2024 00:16:37 -0800 (PST)
MIME-Version: 1.0
References: <20240227113921.236097-1-armbru@redhat.com>
 <20240227113921.236097-13-armbru@redhat.com>
In-Reply-To: <20240227113921.236097-13-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Mar 2024 10:16:26 +0200
Message-ID: <CAPMcbCpaR2OAxdQs+sFWLLyF7SDeT6EWK3BYt6tSWJVK6bR+rw@mail.gmail.com>
Subject: Re: [PATCH 12/13] qga/qapi-schema: Fix guest-set-memory-blocks
 documentation
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com, 
 eblake@redhat.com
Content-Type: multipart/alternative; boundary="00000000000035c0c10612d15819"
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

--00000000000035c0c10612d15819
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Feb 27, 2024 at 1:39=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Documentation claims the command can "return NULL".  "NULL" doesn't
> exist in JSON.  "null" does, but the command returns lists, and null
> isn't.  Correct documentation to "return an empty list".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qga/qapi-schema.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 2ea1022092..9554b566a7 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1176,9 +1176,9 @@
>  #     @GuestMemoryBlockResponse, which is corresponding to the input
>  #     list.
>  #
> -#     Note: it will return NULL if the @mem-blks list was empty on
> -#     input, or there is an error, and in this case, guest state will
> -#     not be changed.
> +#     Note: it will return an empty list if the @mem-blks list was
> +#     empty on input, or there is an error, and in this case, guest
> +#     state will not be changed.
>  #
>  # Since: 2.3
>  ##
> --
> 2.43.0
>
>

--00000000000035c0c10612d15819
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 2=
7, 2024 at 1:39=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Documentation claims the command can &quot;retu=
rn NULL&quot;.=C2=A0 &quot;NULL&quot; doesn&#39;t<br>
exist in JSON.=C2=A0 &quot;null&quot; does, but the command returns lists, =
and null<br>
isn&#39;t.=C2=A0 Correct documentation to &quot;return an empty list&quot;.=
<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/qapi-schema.json | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 2ea1022092..9554b566a7 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1176,9 +1176,9 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0@GuestMemoryBlockResponse, which is correspondin=
g to the input<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0list.<br>
=C2=A0#<br>
-#=C2=A0 =C2=A0 =C2=A0Note: it will return NULL if the @mem-blks list was e=
mpty on<br>
-#=C2=A0 =C2=A0 =C2=A0input, or there is an error, and in this case, guest =
state will<br>
-#=C2=A0 =C2=A0 =C2=A0not be changed.<br>
+#=C2=A0 =C2=A0 =C2=A0Note: it will return an empty list if the @mem-blks l=
ist was<br>
+#=C2=A0 =C2=A0 =C2=A0empty on input, or there is an error, and in this cas=
e, guest<br>
+#=C2=A0 =C2=A0 =C2=A0state will not be changed.<br>
=C2=A0#<br>
=C2=A0# Since: 2.3<br>
=C2=A0##<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--00000000000035c0c10612d15819--


