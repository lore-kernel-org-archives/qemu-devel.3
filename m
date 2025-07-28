Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB9CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKix-0002xk-KG; Mon, 28 Jul 2025 06:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugKir-0002ly-OG
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugKip-00005I-69
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753697080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrs67qKGX8jIF8McWX3kEVl8ZnxO2su/sCe6LwV9w8I=;
 b=hCvQSHbae5Hh1xMe5cig+5Pnte4feONDHdt6dq1JODwhbJJa/pOyDELML+jyiPkm6g1FZ/
 r0D5d6FGkqFvhhNgCfuAe6325QIOi6Aa6BM4xHtJkhEYFG53rPyNv6SmXQnBcGRk7Pi+hL
 yC2vO40Cq7KkCUZ9jWJusuw2++J2RMY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-NJEzQvYHMzyqM2nfNkCTDw-1; Mon, 28 Jul 2025 06:04:39 -0400
X-MC-Unique: NJEzQvYHMzyqM2nfNkCTDw-1
X-Mimecast-MFC-AGG-ID: NJEzQvYHMzyqM2nfNkCTDw_1753697078
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313fb0ec33bso5228228a91.2
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753697078; x=1754301878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xrs67qKGX8jIF8McWX3kEVl8ZnxO2su/sCe6LwV9w8I=;
 b=d6mbOwCY+rl5x/RLZtioaJBZfaxUvJ9ofI0llT32n3+NGEa8af6SteY4rqDytcIhNs
 rn8l6tyh7Q2cv1+QtgGR17Fqv5FNuS8AwIWTcTgsMRsTv6udH1EU0/dytAA260A78Nzx
 p7oi2rLynQmOkPINlrRpM6vnCxZwEPk94E6e2tvD0Zifga7EA5Z5wVhutnZHOkMDaECk
 ESM65BPB8WqNdSvBcTWmbM0vuqK62Nt/NB9QTC3WugpCN9KwwjG7+U0PDylHyJDYtmEf
 WVmgGVXecl/IAh9P9g/qoVQyGlq0+f8gNll0Tc+P7t67xmMC6sSZJzQUIjmb6NRx89/g
 L6vw==
X-Gm-Message-State: AOJu0Ywm2x7xUlhZDDI3s5Q6hEm6BBylfSrhYaHwENYR3aHxHFd9qoW0
 COi6W9jjpzreOxpV85yVLhPUl+yJwA3vG86y5ZlJGj1GRaDwqNtZaNsMOQkH8jslOxZIctjaGBE
 y5Jxr37qh0RDHEQ9C+GfhvBBD7+KYAosythcswpPYhhmsTRarZHt2QAjDz9y7fCa0ZjWHXRNRcm
 9o3luXSuAysvfzYuIZ3Q7UatawlA68YsI=
X-Gm-Gg: ASbGncss/r2X4fZNsaKMmy5Tx7ma6qWDjYpFfyxfXZTvu/OeO25qSyWsTaohVKr8BQH
 YIV4JzISzb8WZ8vIgjX8f1zygfyzqWOVvdPANx0QE/NMq7NnfRI9ubSCK8J3qzu9QZXd5YUMxb/
 cbVLr18+d7i9L+mEZY2Anfn54JybtSdJVEYZ9GJBUDMvZEs56BLQhPcw==
X-Received: by 2002:a17:90a:d2c5:b0:31e:f397:b5b4 with SMTP id
 98e67ed59e1d1-31ef397b8camr2354155a91.22.1753697077781; 
 Mon, 28 Jul 2025 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExgWUtBN+tmlQix0XYh2h45Zr801MhdT3hATR1tNlCIaXOabWyJzSFNvy+Slnd+oiM8Pv24+kymiIV6bF89DQ=
X-Received: by 2002:a17:90a:d2c5:b0:31e:f397:b5b4 with SMTP id
 98e67ed59e1d1-31ef397b8camr2354120a91.22.1753697077380; Mon, 28 Jul 2025
 03:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-12-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-12-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 14:04:26 +0400
X-Gm-Features: Ac12FXyF8ntbh4oz28o563hlKtfr3d3eZ0FM7aGpoZeKrxEpLLb4ficU79dz_lo
Message-ID: <CAMxuvaxvU6oKp+md-oidSpp29T+pF6OEnRhUpxzsaCnvDhtKYQ@mail.gmail.com>
Subject: Re: [PATCH v7 12/24] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000576568063afa6ba7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000576568063afa6ba7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:20=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that loadvm_postcopy_handle_advise() must report an error
> in errp, in case of failure.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/savevm.c | 40 +++++++++++++++++++---------------------
>  1 file changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 60a055f3e1f248b09e5e5d721f14d2eeafd0a7ad..eb843f4869f7b49a17fe0fb1b0e36db=
993e4024e
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {
>   * quickly.
>   */
>  static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> -                                         uint16_t len)
> +                                         uint16_t len, Error **errp)
>  {
>      PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
>      uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps=
;
>      size_t page_size =3D qemu_target_page_size();
> -    Error *local_err =3D NULL;
>
>      trace_loadvm_postcopy_handle_advise();
>      if (ps !=3D POSTCOPY_INCOMING_NONE) {
> -        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)",
> ps);
> +        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy state
> (%d)",
> +                   ps);
>          return -1;
>      }
>
>      switch (len) {
>      case 0:
>          if (migrate_postcopy_ram()) {
> -            error_report("RAM postcopy is enabled but have 0 byte
> advise");
> +            error_setg(errp, "RAM postcopy is enabled but have 0 byte
> advise");
>              return -EINVAL;
>          }
>          return 0;
>      case 8 + 8:
>          if (!migrate_postcopy_ram()) {
> -            error_report("RAM postcopy is disabled but have 16 byte
> advise");
> +            error_setg(errp,
> +                       "RAM postcopy is disabled but have 16 byte
> advise");
>              return -EINVAL;
>          }
>          break;
>      default:
> -        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> +        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len)=
;
>          return -EINVAL;
>      }
>
> -    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
> -        error_report_err(local_err);
> +    if (!postcopy_ram_supported_by_host(mis, errp)) {
>          postcopy_state_set(POSTCOPY_INCOMING_NONE);
>          return -1;
>      }
> @@ -1967,9 +1967,10 @@ static int
> loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>           *      also fails when passed to an older qemu that doesn't
>           *      do huge pages.
>           */
> -        error_report("Postcopy needs matching RAM page sizes (s=3D%" PRI=
x64
> -                                                             " d=3D%"
> PRIx64 ")",
> -                     remote_pagesize_summary, local_pagesize_summary);
> +        error_setg(errp,
> +                   "Postcopy needs matching RAM page sizes "
> +                   "(s=3D%" PRIx64 " d=3D%" PRIx64 ")",
> +                   remote_pagesize_summary, local_pagesize_summary);
>          return -1;
>      }
>
> @@ -1979,17 +1980,18 @@ static int
> loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>           * Again, some differences could be dealt with, but for now keep
> it
>           * simple.
>           */
> -        error_report("Postcopy needs matching target page sizes (s=3D%d
> d=3D%zd)",
> -                     (int)remote_tps, page_size);
> +        error_setg(errp,
> +                   "Postcopy needs matching target page sizes (s=3D%d
> d=3D%zd)",
> +                   (int)remote_tps, page_size);
>          return -1;
>      }
>
> -    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
> -        error_report_err(local_err);
> +    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
>          return -1;
>      }
>
> -    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
> +    if (ram_postcopy_incoming_init(mis, errp) < 0) {
> +        error_prepend(errp, "Postcopy RAM incoming init failed: ");
>          return -1;
>      }
>
> @@ -2617,11 +2619,7 @@ static int loadvm_process_command(QEMUFile *f,
> Error **errp)
>          return loadvm_handle_cmd_packaged(mis, errp);
>
>      case MIG_CMD_POSTCOPY_ADVISE:
> -        ret =3D loadvm_postcopy_handle_advise(mis, len);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to load device state command: %d",
> ret);
> -        }
> -        return ret;
> +        return loadvm_postcopy_handle_advise(mis, len, errp);
>
>      case MIG_CMD_POSTCOPY_LISTEN:
>          ret =3D loadvm_postcopy_handle_listen(mis);
>
> --
> 2.50.0
>
>

--000000000000576568063afa6ba7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 4:20=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that loadvm_postcopy_handle_advise() must report an error<br>
in errp, in case of failure.<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/savevm.c | 40 +++++++++++++++++++---------------------<br>
=C2=A01 file changed, 19 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 60a055f3e1f248b09e5e5d721f14d2eeafd0a7ad..eb843f4869f7b49a17fe0fb1b0e=
36db993e4024e 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {<br>
=C2=A0 * quickly.<br>
=C2=A0 */<br>
=C2=A0static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt16_t len)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt16_t len, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0PostcopyState ps =3D postcopy_state_set(POSTCOPY_INCOMI=
NG_ADVISE);<br>
=C2=A0 =C2=A0 =C2=A0uint64_t remote_pagesize_summary, local_pagesize_summar=
y, remote_tps;<br>
=C2=A0 =C2=A0 =C2=A0size_t page_size =3D qemu_target_page_size();<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_loadvm_postcopy_handle_advise();<br>
=C2=A0 =C2=A0 =C2=A0if (ps !=3D POSTCOPY_INCOMING_NONE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_ADVISE in wron=
g postcopy state (%d)&quot;, ps);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_POSTCOPY_ADVISE in =
wrong postcopy state (%d)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ps);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (len) {<br>
=C2=A0 =C2=A0 =C2=A0case 0:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (migrate_postcopy_ram()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;RAM postcopy =
is enabled but have 0 byte advise&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;RAM postc=
opy is enabled but have 0 byte advise&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0case 8 + 8:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!migrate_postcopy_ram()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;RAM postcopy =
is disabled but have 16 byte advise&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;RAM postcopy is disabled but have 16 byte advise&quot;);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_POSTCOPY_ADVISE invalid=
 length (%d)&quot;, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;CMD_POSTCOPY_ADVISE inv=
alid length (%d)&quot;, len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!postcopy_ram_supported_by_host(mis, &amp;local_err)) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 if (!postcopy_ram_supported_by_host(mis, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0postcopy_state_set(POSTCOPY_INCOMING_NONE=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1967,9 +1967,10 @@ static int loadvm_postcopy_handle_advise(MigrationIn=
comingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 also fails when pa=
ssed to an older qemu that doesn&#39;t<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=C2=A0 =C2=A0 =C2=A0 do huge pages.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Postcopy needs matching RAM=
 page sizes (s=3D%&quot; PRIx64<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;=
 d=3D%&quot; PRIx64 &quot;)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0remote_pagesize_summary, local_pagesize_summary);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Postcopy needs matching RAM page sizes &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;(s=3D%&quot; PRIx64 &quot; d=3D%&quot; PRIx64 &quot;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remot=
e_pagesize_summary, local_pagesize_summary);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1979,17 +1980,18 @@ static int loadvm_postcopy_handle_advise(MigrationI=
ncomingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Again, some differences could be dealt=
 with, but for now keep it<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * simple.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Postcopy needs matching tar=
get page sizes (s=3D%d d=3D%zd)&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(int)remote_tps, page_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Postcopy needs matching target page sizes (s=3D%d d=3D%zd)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)=
remote_tps, page_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &amp;loc=
al_err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (ram_postcopy_incoming_init(mis, NULL) &lt; 0) {<br>
+=C2=A0 =C2=A0 if (ram_postcopy_incoming_init(mis, errp) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Postcopy RAM incomin=
g init failed: &quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2617,11 +2619,7 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return loadvm_handle_cmd_packaged(mis, er=
rp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_ADVISE:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D loadvm_postcopy_handle_advise(mis, len=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to=
 load device state command: %d&quot;, ret);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_handle_advise(mis, len,=
 errp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_LISTEN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D loadvm_postcopy_handle_listen(mis=
);<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--000000000000576568063afa6ba7--


