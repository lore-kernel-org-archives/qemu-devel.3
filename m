Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A3C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUNw-0008Nj-Aq; Mon, 29 Jan 2024 11:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUUNu-0008My-2U
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rUUNs-0005eR-Hq
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706545279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDNpTPCR/Ru3oG8eNQtPHYTcUcgNic0TXdQV0cOk8eY=;
 b=QZ09gskIOf+fiJ6xMtfligO0JZc9I3DQmrU3htkr7bMzVhnfBZmCjA8UQL64h1RMnxY0Kb
 qOnJMu+94ZeZbfQLcHpqovcfM9wF/19T4/2olMDWsrYECyKz3bvD7hu9T7LjqhWkpl5xMn
 swu2/+O+JFQdFJJgnLlzOikR8fvmXIo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-N9oLYHBNMDiMTCCsac3-Pw-1; Mon, 29 Jan 2024 11:21:17 -0500
X-MC-Unique: N9oLYHBNMDiMTCCsac3-Pw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5110fdc81e0so1096060e87.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706545276; x=1707150076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nDNpTPCR/Ru3oG8eNQtPHYTcUcgNic0TXdQV0cOk8eY=;
 b=F6J6xQdbuv45VmF7rYrkkDimDejsLO6PR9IsfuImeMixqOihPYromm2EYVehfsaKWs
 fhDagXQfVCo9o9Xq5QcXJy03VJCpUF88C/EMRAE/24QSdUWC/YxYaPoL4aAjm2NXic3+
 ZK6CYstYk4UDrVxJVr3VYmA6aclJdpeDPHlOxVkv0iunUG8WBhXhCb9p/dkeyb1gH2uu
 9s0ZkpdEp4h2skmDfKp+iIc+DjTTpcId/i+T4jYlD9AZ0y9iikvf8lP4BDzF7KvH3XsR
 c23WRHgJhxRSZDv1YwFmdvXBJRXlgZ3iK1Y6N6aKwU81O7OcdNcKJ6lTLwDSt4sMJTRx
 Rorw==
X-Gm-Message-State: AOJu0Ywyubp+opBZWYkRXI5CaRF4mHTab9SZYilIFysnhFOceECV6u5e
 WuxoMIlJWr7izuLVLu5BPwTEXd0p8jlbdndSkEp52SkPJbaHUI+mWdj0lTvrabz96d0Llgq08FU
 xPItX/576aon9lCdqA1hyi942g3DLeqgRAngd/flt2TcxNBz8SjP0alCKo+11QyUPRGhlOgjaMA
 0SLWfhFQrG0rNvpDNSPC8X/XK/dSU=
X-Received: by 2002:ac2:4556:0:b0:510:1723:3d2b with SMTP id
 j22-20020ac24556000000b0051017233d2bmr3756991lfm.36.1706545276328; 
 Mon, 29 Jan 2024 08:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Q7/DUWNfA3rilvY+WSRAhsEL2yRZ/y6ZGfDIBIJ/xDmcheI+xsbEv2a++AAu1sR++J9/+zO5TN/iiF1QdJM=
X-Received: by 2002:ac2:4556:0:b0:510:1723:3d2b with SMTP id
 j22-20020ac24556000000b0051017233d2bmr3756986lfm.36.1706545276061; Mon, 29
 Jan 2024 08:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20240129115008.674248-1-armbru@redhat.com>
 <20240129115008.674248-5-armbru@redhat.com>
In-Reply-To: <20240129115008.674248-5-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 29 Jan 2024 18:21:04 +0200
Message-ID: <CAPMcbCr2OW7eQpogFCHx+N5+X4ckFdGkocNOcd5uY2w2zeiUOg@mail.gmail.com>
Subject: Re: [PATCH 4/5] qga: Move type description right after type name
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, 
 hreitz@redhat.com, michael.roth@amd.com, qemu-block@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f91fc10610180803"
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

--000000000000f91fc10610180803
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Mon, Jan 29, 2024 at 1:50=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Documentation of type BlockdevOptionsIscsi describes the type's
> purpose after its members.  Everywhere else, we do it the other way
> round.  Move it for consistency.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 530c4af50f..781c9bd03e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4070,6 +4070,8 @@
>  ##
>  # @BlockdevOptionsIscsi:
>  #
> +# Driver specific block device options for iscsi
> +#
>  # @transport: The iscsi transport type
>  #
>  # @portal: The address of the iscsi portal
> @@ -4094,8 +4096,6 @@
>  # @timeout: Timeout in seconds after which a request will timeout.  0
>  #     means no timeout and is the default.
>  #
> -# Driver specific block device options for iscsi
> -#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsIscsi',
> --
> 2.43.0
>
>

--000000000000f91fc10610180803
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 2=
9, 2024 at 1:50=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Documentation of type BlockdevOptionsIscsi desc=
ribes the type&#39;s<br>
purpose after its members.=C2=A0 Everywhere else, we do it the other way<br=
>
round.=C2=A0 Move it for consistency.<br>
<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" t=
arget=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0qapi/block-core.json | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
index 530c4af50f..781c9bd03e 100644<br>
--- a/qapi/block-core.json<br>
+++ b/qapi/block-core.json<br>
@@ -4070,6 +4070,8 @@<br>
=C2=A0##<br>
=C2=A0# @BlockdevOptionsIscsi:<br>
=C2=A0#<br>
+# Driver specific block device options for iscsi<br>
+#<br>
=C2=A0# @transport: The iscsi transport type<br>
=C2=A0#<br>
=C2=A0# @portal: The address of the iscsi portal<br>
@@ -4094,8 +4096,6 @@<br>
=C2=A0# @timeout: Timeout in seconds after which a request will timeout.=C2=
=A0 0<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0means no timeout and is the default.<br>
=C2=A0#<br>
-# Driver specific block device options for iscsi<br>
-#<br>
=C2=A0# Since: 2.9<br>
=C2=A0##<br>
=C2=A0{ &#39;struct&#39;: &#39;BlockdevOptionsIscsi&#39;,<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000f91fc10610180803--


