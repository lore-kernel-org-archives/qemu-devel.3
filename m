Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF47C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6w8k-00039I-3s; Tue, 14 May 2024 13:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s6w8E-0002ze-Eh
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1s6w8C-0004AI-9y
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715708402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NNWU/nuW8PRM7pBaZDIwCzldDRVEBVkqHR5gRPpLoVA=;
 b=MzJYmc3Kfj/yk87ML5N1VptpW3BfxmziJudrmuiG+oUe4/cjSyplTakf5fbAwxbDTtTg3b
 uwon/AKr2ThF5360BojLDmNNqz4Jp+JRAaVKxkxDKoxYqP84j0+VOi5zq9IRNYcJMrFeDH
 BZEi6JAgAVyvAeRrrcVc0d97Tpe4tDY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-8gvyT4SuPx2p0L89UPAqgQ-1; Tue, 14 May 2024 13:39:50 -0400
X-MC-Unique: 8gvyT4SuPx2p0L89UPAqgQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-de59ff8af0bso8825518276.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708390; x=1716313190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NNWU/nuW8PRM7pBaZDIwCzldDRVEBVkqHR5gRPpLoVA=;
 b=cXPRy70oPdJ0i7SV04s07ZciWiLoheORZITBJLH/6pxsV1QzqJbCmHH1zL0fbz+pRL
 ROhPJQemUtQmEapqmVEpSHjhtvvUTmr3be//setLvJBd7ZfVnRhMiHdDPClSnf6Ev9Dc
 aiZ2iUhlmIJEc0jpsFL3Oht71sIAiwF9s/QbNY24p+i/9vdy+sv28l23Tomfv6CfaLiP
 VJzIazaDvEVDUcoW4f4Onk8kykqvhu0pgzg+BivLQl+zyFlr0Q5XQ8LxOeh6QXhka1Qd
 kyyShz3xHE0z7+yDYCAXpmpKM/KNc9SNag82npfBSPuCACMICuXRpCxbwwotNyyJBnH9
 6Keg==
X-Gm-Message-State: AOJu0YylUqifcU4o7FTfxYYfuSQ4NePSujS+Gu+lfJdPkDof8ST2+3zo
 wxlUtSiwn6xBKIayWCunUYZN1UPAHtpvRZphr6l2pBhdetUyqITUkamhjSKlqsSOLw00XIhJpuP
 cXIhTNtmGIxfL3wp1QFNnYycKGlNAHIhBm8cXj+r70Z8mCJ7JSduGYzuVNuD6kIxA+YnLOV36Go
 Aa9afEaGacWCZrHJ5J101BhMGWTlk=
X-Received: by 2002:a25:adda:0:b0:dda:e401:df8c with SMTP id
 3f1490d57ef6-dee4f314501mr12229259276.48.1715708390294; 
 Tue, 14 May 2024 10:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7n6O+bru8rcq2kHo/Md1Kv3m5Sm4Z0MG7WqLGV8Thrbhgsd6amrUZGRQHuZVl8FdMUzSmImPjQh+2uWLzk1c=
X-Received: by 2002:a25:adda:0:b0:dda:e401:df8c with SMTP id
 3f1490d57ef6-dee4f314501mr12229247276.48.1715708390019; Tue, 14 May 2024
 10:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-4-armbru@redhat.com>
In-Reply-To: <20240514105829.729342-4-armbru@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Tue, 14 May 2024 20:39:39 +0300
Message-ID: <CAPMcbCoaK=YwWFTzvw3Ao99SA54csAr7w+iSaC-_Xx6ExKBnBA@mail.gmail.com>
Subject: Re: [PATCH 3/3] qerror: QERR_QGA_COMMAND_FAILED is no longer used,
 drop
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000002031bc06186d7dd4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

--0000000000002031bc06186d7dd4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, May 14, 2024 at 1:58=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/qerror.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index 00b18e9082..390590bb81 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -29,9 +29,6 @@
>  #define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
>      "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 "=
,
> maximum: %" PRId64 ")"
>
> -#define QERR_QGA_COMMAND_FAILED \
> -    "Guest agent command failed, error was '%s'"
> -
>  #define QERR_UNSUPPORTED \
>      "this feature or command is not currently supported"
>
> --
> 2.45.0
>
>

--0000000000002031bc06186d7dd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 1=
4, 2024 at 1:58=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@r=
edhat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Signed-off-by: Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/qapi/qmp/qerror.h | 3 ---<br>
=C2=A01 file changed, 3 deletions(-)<br>
<br>
diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h<br>
index 00b18e9082..390590bb81 100644<br>
--- a/include/qapi/qmp/qerror.h<br>
+++ b/include/qapi/qmp/qerror.h<br>
@@ -29,9 +29,6 @@<br>
=C2=A0#define QERR_PROPERTY_VALUE_OUT_OF_RANGE \<br>
=C2=A0 =C2=A0 =C2=A0&quot;Property %s.%s doesn&#39;t take value %&quot; PRI=
d64 &quot; (minimum: %&quot; PRId64 &quot;, maximum: %&quot; PRId64 &quot;)=
&quot;<br>
<br>
-#define QERR_QGA_COMMAND_FAILED \<br>
-=C2=A0 =C2=A0 &quot;Guest agent command failed, error was &#39;%s&#39;&quo=
t;<br>
-<br>
=C2=A0#define QERR_UNSUPPORTED \<br>
=C2=A0 =C2=A0 =C2=A0&quot;this feature or command is not currently supporte=
d&quot;<br>
<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div>

--0000000000002031bc06186d7dd4--


