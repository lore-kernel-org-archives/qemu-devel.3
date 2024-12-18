Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57331E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsoa-0004nc-Ge; Wed, 18 Dec 2024 07:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsoY-0004mu-SR
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNsoW-0007Bi-7b
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734523563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMLH0VaYNuMD5PJw7eJMAF0I3QJlSCbn9pQCltkD+3g=;
 b=eunoX121mJm9K5+eBb8aTjsNZODR2PHKvy8bqL+hHsbqQG0Gj3NSz1vi+DtQGwDfkzKwj9
 dRbvZPLM+kv7AsGKIDWom7dNL6pBjBx9vn2s/LNAdG+DnUhGGjlu492wbtwtRt5R1DPQQV
 GHuPYwU83uLArLBgUSEUeBPp+KJmSDE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-HWeqt9kVNuuR3WwyRbs7-A-1; Wed, 18 Dec 2024 07:06:02 -0500
X-MC-Unique: HWeqt9kVNuuR3WwyRbs7-A-1
X-Mimecast-MFC-AGG-ID: HWeqt9kVNuuR3WwyRbs7-A
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-46799aa9755so32660031cf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 04:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734523559; x=1735128359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GMLH0VaYNuMD5PJw7eJMAF0I3QJlSCbn9pQCltkD+3g=;
 b=I+k2xw/LwYBfudKOkoXioNZFu8N0C9sb9PnS52YrC9UitPVkAlmkXTbCbNEnxu1Ywg
 AYyI/wOm6+moDSxFFrx4Jm2N+q5O8vl3amqjpfxOmWeG7y4oXMKacjpT84VCcrYsMxDK
 R3T7wRkJ9uBMvLLhK9K6NQ4LviUdW3wP1XPrk0cpMyypBbPoyhKKnI8epoOd9LSv1qzB
 Qj89NdNgm0BTrRDYyJlSkYD8QYVNdgksFoaDVVNpDnvBnACAzU30gSLJXKQgk31e8KBL
 pv4DAXLAGyPDinBjStvzFxIkeNaIzo31rJV4ieT8NATjxncxYBmrOM6ncMiU3xUY80Em
 WC0Q==
X-Gm-Message-State: AOJu0YxFXVeH44L7Zxe6+DLjkTp6IN/Gw6+T6vxuqWaQHNrc91xYFDXg
 zp2pmcpIXK1Nz6GIqmkJLAraQbi8ladsLseqD/QoYMZ9vYDsMhGIJmqIDIlbw4C9LfZ9/hXcrEm
 iBfhLWdWsBihFVNTrl3NfTcCe1OWz0t6DlOPdxV+qp8iUyIAoDEVodxNw7Bb7gSYkDh7l4vkIEp
 Ds5UOQc/vai5Bv6UtKlCxURokCkok=
X-Gm-Gg: ASbGncvWhpX6aCmWoE/+ikn0xp5xNXnwAU+kjUdzjxcFJz9jXLTvm2nNMGuzqf79Dfz
 WWie4DPxnvZyM0WAEbduumEgnEtIj/oyDK+SGjKqF
X-Received: by 2002:a05:6214:483:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6dd090aaaa7mr42747406d6.0.1734523559606; 
 Wed, 18 Dec 2024 04:05:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsn19YZEsKAadmW3QbLQ59L5h0nlmsUMZunVz/SeqhQQdZ0f40aqfk8IFbBnLRaCMZZxCgds0B0HYarSLmKnw=
X-Received: by 2002:a05:6214:483:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6dd090aaaa7mr42747236d6.0.1734523559411; Wed, 18 Dec 2024
 04:05:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733414906.git.mprivozn@redhat.com>
 <8ae7f5d5032b14a5b956fe8aaf47bae5ca401699.1733414906.git.mprivozn@redhat.com>
In-Reply-To: <8ae7f5d5032b14a5b956fe8aaf47bae5ca401699.1733414906.git.mprivozn@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 18 Dec 2024 14:05:48 +0200
Message-ID: <CAPMcbCoJh9u17Cv=v=bvWcY=Rv+HYH4HEG1wdW+87E=rzy87Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] qga: Don't access global variable in
 run_agent_once()
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jtomko@redhat.com
Content-Type: multipart/alternative; boundary="0000000000009d14c606298a3c13"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009d14c606298a3c13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

The PULL with this patch was sent. Skip it in the next version of this
series.

Best Regards,
Konstantin Kostiuk.


On Thu, Dec 5, 2024 at 6:19=E2=80=AFPM Michal Privoznik <mprivozn@redhat.co=
m> wrote:

> The run_agent_once() function is already given GAState via an
> argument. There's no need to access the global ga_state variable
> which points to the argument anyways (thanks to
> initialize_agent()). Worse, some parts of the function use the
> argument and the other use the global variable.  Stick with the
> function argument.
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
> Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> ---
>  qga/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 50186760bf..4a695235f0 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1519,7 +1519,7 @@ static int run_agent_once(GAState *s)
>          return EXIT_FAILURE;
>      }
>
> -    g_main_loop_run(ga_state->main_loop);
> +    g_main_loop_run(s->main_loop);
>
>      if (s->channel) {
>          ga_channel_free(s->channel);
> --
> 2.45.2
>
>

--0000000000009d14c606298a3c13
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michal,</div><div><br></div><div>The PULL with thi=
s patch was sent. Skip it in the next version of this series. <br></div><di=
v><br clear=3D"all"></div><div><div dir=3D"ltr" class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div>=
<div>Konstantin Kostiuk.</div></div></div></div><br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Thu, Dec 5, 2024 at 6:19=E2=80=AFPM Michal Privoznik &lt;<a href=3D"mailt=
o:mprivozn@redhat.com">mprivozn@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">The run_agent_once() function is =
already given GAState via an<br>
argument. There&#39;s no need to access the global ga_state variable<br>
which points to the argument anyways (thanks to<br>
initialize_agent()). Worse, some parts of the function use the<br>
argument and the other use the global variable.=C2=A0 Stick with the<br>
function argument.<br>
<br>
Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com" =
target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
Reviewed-by: J=C3=A1n Tomko &lt;<a href=3D"mailto:jtomko@redhat.com" target=
=3D"_blank">jtomko@redhat.com</a>&gt;<br>
Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" =
target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 50186760bf..4a695235f0 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1519,7 +1519,7 @@ static int run_agent_once(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 g_main_loop_run(ga_state-&gt;main_loop);<br>
+=C2=A0 =C2=A0 g_main_loop_run(s-&gt;main_loop);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;channel) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_channel_free(s-&gt;channel);<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--0000000000009d14c606298a3c13--


