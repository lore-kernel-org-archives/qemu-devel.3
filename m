Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F51C87FD1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJed-00077a-Kw; Mon, 28 Jul 2025 04:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugJVo-00005y-Sm
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:47:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugJVm-0004g3-VW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 04:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753692429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3vjnJrJsO62f6CBgZP8z7tUo0Q0l8ayLXDAFMNyrbg=;
 b=Ajv5tmiqNiKbe2uDcsf2nKlEWN5roXC8JHs6C4hBoEmOY72Uc5vwgwXJxzeLjnMKVMOCEc
 mmALTJQ/BudBfx1qcJzO3wGYjKbMoy6QzdCi3j2Sn6DgEbLfauZUpsattBd86LyRM0zmCa
 IyLgUpLK4BUHMnDLsp7gGJSzc8yogDc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-dqEa3W8gPNerrqZXb0N_BQ-1; Mon, 28 Jul 2025 04:47:07 -0400
X-MC-Unique: dqEa3W8gPNerrqZXb0N_BQ-1
X-Mimecast-MFC-AGG-ID: dqEa3W8gPNerrqZXb0N_BQ_1753692426
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24004ac2ecdso16528035ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 01:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753692421; x=1754297221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3vjnJrJsO62f6CBgZP8z7tUo0Q0l8ayLXDAFMNyrbg=;
 b=QFSaCnV5VJ3LCAYWT+mTlBGoUltzWgh9UprNansI5pEH3ElwiIDn2ze6Ru9dry9ovW
 UPvPYAFlLa8ODI8+W9bSf2QYQDWDp1BozJVLMnJyW56NRtzCNIWTuihVlZKxqHXd0cAy
 2TYhvZbEAIfX3FQEILPL11AzkGyIhOFl0AUyUanGqATYxbQKnbgW4yUA81AbNqvhksW9
 YWcEWg+EacMgbgoinBuY9S05Bk03OGNmtwxY7v0BvLf/WFD40UPjK6vn3TYU6J9oHntm
 KZ0LggZfAuVsrA0s+xey+5ns8kChtPuPZ8d9QjqbxorRNJoZ1gu88Nykm0H/ybaqKORD
 G27A==
X-Gm-Message-State: AOJu0Yx78XonBTlbGJG/a59CO7d2NK8Iz03+VyxhvhsNsVHnVgwbXd3N
 nO9COU01fAgcwDOD2Dns07J4eFC1EamCEkNZnvrdF6K4H6XHZGRcHeSirpE40yJ/wvRYiLbK1XJ
 YxuI/NM35xiQFNMiU86AVW308t9UR+iUcbwS/lbuWmuzHsqPxzk5O87KJ+nGb1FBacPcRBW8tsD
 elrzsyUqskdgdlZtsBDmZw4YEIat37nCk=
X-Gm-Gg: ASbGncuRQSF/r/LfJVj3axZ06TEF/aWZl7gIuvC4puSY2m+xzlpUgEPUFcPDM86J2kv
 HhMR5gj0ORPqrgwW+GJ6Q1uz1jnxPjqAX1I/D3Agv/m/kC0hk9UeYPUVs4XgIEFau8IOewVCEAs
 4TOxnLhjNaIY0o/CNrFIT8M4oz/K7jvhgi9Hp8NvKYZkXAFdAHwhG3lA==
X-Received: by 2002:a17:902:cf12:b0:235:ecf2:393 with SMTP id
 d9443c01a7336-23fb313a940mr156287955ad.53.1753692420992; 
 Mon, 28 Jul 2025 01:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO3NwiWfrW09YNKIBSCthJXMadKXgopH/2rIAK+xcRgtZVDlGrmzWVhCwQLXpJdV7ZSUL6xUJPfPI4LtMRcKs=
X-Received: by 2002:a17:902:cf12:b0:235:ecf2:393 with SMTP id
 d9443c01a7336-23fb313a940mr156287715ad.53.1753692420629; Mon, 28 Jul 2025
 01:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-7-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-7-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 12:46:49 +0400
X-Gm-Features: Ac12FXxb4R4KVA254lesh5NiBT9IwAKYf4wEVNOu3Pl3WH6EcYviUSG6LJ4981M
Message-ID: <CAMxuvawQAKuKd1eLrj2WTP8f3xPS3m5ddYKs=WuJZ9YaPA=How@mail.gmail.com>
Subject: Re: [PATCH v7 07/24] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
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
Content-Type: multipart/alternative; boundary="000000000000c6fdd2063af9559f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000c6fdd2063af9559f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:20=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> The documentation of qemu_file_get_return_path() states that it can
> return NULL on failure. However, a review of the current implementation
> reveals that it is guaranteed that it will always succeed and will never
> return NULL.
>
> As a result, the NULL checks post calling the function become redundant.
> This commit updates the documentation for the function and removes all
> NULL checks throughout the migration code.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/colo.c      |  4 ----
>  migration/migration.c | 12 ++----------
>  migration/qemu-file.c |  1 -
>  migration/savevm.c    |  4 ----
>  4 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index
> e0f713c837f5da25d67afbd02ceb6c54024ca3af..981bd4bf9ced8b45b4c5d494acae119=
a174ee974
> 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -849,10 +849,6 @@ static void *colo_process_incoming_thread(void
> *opaque)
>      failover_init_state();
>
>      mis->to_src_file =3D qemu_file_get_return_path(mis->from_src_file);
> -    if (!mis->to_src_file) {
> -        error_report("COLO incoming thread: Open QEMUFile to_src_file
> failed");
> -        goto out;
> -    }
>      /*
>       * Note: the communication between Primary side and Secondary side
>       * should be sequential, we set the fd to unblocked in migration
> incoming
> diff --git a/migration/migration.c b/migration/migration.c
> index
> 10c216d25dec01f206eacad2edd24d21f00e614c..b3bccaeaee806abd01595863f647505=
7049b0688
> 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2646,12 +2646,9 @@ out:
>      return NULL;
>  }
>
> -static int open_return_path_on_source(MigrationState *ms)
> +static void open_return_path_on_source(MigrationState *ms)
>  {
>      ms->rp_state.from_dst_file =3D
> qemu_file_get_return_path(ms->to_dst_file);
> -    if (!ms->rp_state.from_dst_file) {
> -        return -1;
> -    }
>
>      trace_open_return_path_on_source();
>
> @@ -2660,8 +2657,6 @@ static int open_return_path_on_source(MigrationStat=
e
> *ms)
>      ms->rp_state.rp_thread_created =3D true;
>
>      trace_open_return_path_on_source_continue();
> -
> -    return 0;
>  }
>
>  /* Return true if error detected, or false otherwise */
> @@ -4010,10 +4005,7 @@ void migration_connect(MigrationState *s, Error
> *error_in)
>       * QEMU uses the return path.
>       */
>      if (migrate_postcopy_ram() || migrate_return_path()) {
> -        if (open_return_path_on_source(s)) {
> -            error_setg(&local_err, "Unable to open return-path for
> postcopy");
> -            goto fail;
> -        }
> +        open_return_path_on_source(s);
>      }
>
>      /*
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index
> b6ac190034f777dbde0da1598483a892089d7538..f9ccee9a1091ecbd37e6b7d2081a444=
6442b544d
> 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc,
> bool is_writable)
>
>  /*
>   * Result: QEMUFile* for a 'return path' for comms in the opposite
> direction
> - *         NULL if not available
>   */
>  QEMUFile *qemu_file_get_return_path(QEMUFile *f)
>  {
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 21899e6beee3d2661c9a694379039e82cefbee4f..d8f5f1966fda831899596173f20fbef=
25d78829d
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2583,10 +2583,6 @@ static int loadvm_process_command(QEMUFile *f)
>              return 0;
>          }
>          mis->to_src_file =3D qemu_file_get_return_path(f);
> -        if (!mis->to_src_file) {
> -            error_report("CMD_OPEN_RETURN_PATH failed");
> -            return -1;
> -        }
>
>          /*
>           * Switchover ack is enabled but no device uses it, so send an
> ACK to
>
> --
> 2.50.0
>
>

--000000000000c6fdd2063af9559f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25,=
 2025 at 4:20=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">The documentation of qemu_file_get_return_path() state=
s that it can<br>
return NULL on failure. However, a review of the current implementation<br>
reveals that it is guaranteed that it will always succeed and will never<br=
>
return NULL.<br>
<br>
As a result, the NULL checks post calling the function become redundant.<br=
>
This commit updates the documentation for the function and removes all<br>
NULL checks throughout the migration code.<br>
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
=C2=A0migration/colo.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ----<br>
=C2=A0migration/migration.c | 12 ++----------<br>
=C2=A0migration/qemu-file.c |=C2=A0 1 -<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 |=C2=A0 4 ----<br>
=C2=A04 files changed, 2 insertions(+), 19 deletions(-)<br>
<br>
diff --git a/migration/colo.c b/migration/colo.c<br>
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..981bd4bf9ced8b45b4c5d494aca=
e119a174ee974 100644<br>
--- a/migration/colo.c<br>
+++ b/migration/colo.c<br>
@@ -849,10 +849,6 @@ static void *colo_process_incoming_thread(void *opaque=
)<br>
=C2=A0 =C2=A0 =C2=A0failover_init_state();<br>
<br>
=C2=A0 =C2=A0 =C2=A0mis-&gt;to_src_file =3D qemu_file_get_return_path(mis-&=
gt;from_src_file);<br>
-=C2=A0 =C2=A0 if (!mis-&gt;to_src_file) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;COLO incoming thread: Open =
QEMUFile to_src_file failed&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
-=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Note: the communication between Primary side and Sec=
ondary side<br>
=C2=A0 =C2=A0 =C2=A0 * should be sequential, we set the fd to unblocked in =
migration incoming<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 10c216d25dec01f206eacad2edd24d21f00e614c..b3bccaeaee806abd01595863f64=
75057049b0688 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -2646,12 +2646,9 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
-static int open_return_path_on_source(MigrationState *ms)<br>
+static void open_return_path_on_source(MigrationState *ms)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0ms-&gt;rp_state.from_dst_file =3D qemu_file_get_return_=
path(ms-&gt;to_dst_file);<br>
-=C2=A0 =C2=A0 if (!ms-&gt;rp_state.from_dst_file) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_open_return_path_on_source();<br>
<br>
@@ -2660,8 +2657,6 @@ static int open_return_path_on_source(MigrationState =
*ms)<br>
=C2=A0 =C2=A0 =C2=A0ms-&gt;rp_state.rp_thread_created =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_open_return_path_on_source_continue();<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/* Return true if error detected, or false otherwise */<br>
@@ -4010,10 +4005,7 @@ void migration_connect(MigrationState *s, Error *err=
or_in)<br>
=C2=A0 =C2=A0 =C2=A0 * QEMU uses the return path.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (migrate_postcopy_ram() || migrate_return_path()) {<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (open_return_path_on_source(s)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;local_err, &quot=
;Unable to open return-path for postcopy&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 open_return_path_on_source(s);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
diff --git a/migration/qemu-file.c b/migration/qemu-file.c<br>
index b6ac190034f777dbde0da1598483a892089d7538..f9ccee9a1091ecbd37e6b7d2081=
a4446442b544d 100644<br>
--- a/migration/qemu-file.c<br>
+++ b/migration/qemu-file.c<br>
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bo=
ol is_writable)<br>
<br>
=C2=A0/*<br>
=C2=A0 * Result: QEMUFile* for a &#39;return path&#39; for comms in the opp=
osite direction<br>
- *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL if not available<br>
=C2=A0 */<br>
=C2=A0QEMUFile *qemu_file_get_return_path(QEMUFile *f)<br>
=C2=A0{<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 21899e6beee3d2661c9a694379039e82cefbee4f..d8f5f1966fda831899596173f20=
fbef25d78829d 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2583,10 +2583,6 @@ static int loadvm_process_command(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mis-&gt;to_src_file =3D qemu_file_get_ret=
urn_path(f);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mis-&gt;to_src_file) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;CMD_OPEN_RETU=
RN_PATH failed&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Switchover ack is enabled but no devic=
e uses it, so send an ACK to<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--000000000000c6fdd2063af9559f--


