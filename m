Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20DFC87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYWR-00021B-Qm; Wed, 06 Aug 2025 03:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYWP-0001zQ-Lm
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYWL-0003nj-Vt
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754465105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BxJyUwIiYYVgl/lOwzh8jGwTTS/tk8kzjo7q6JOk3k=;
 b=NIFM1t6/Pk3426N3Cv6pP4x2JCMeD4e/7pHgZyHPcx3sv/s/ZbW6rhmo5M1/C5d/Qvbgx1
 Km5UujE3UB312EepMMzmJNKH++JZfKBVXu+oG2HUzhG1P0vs8RrUxnZlyNUGLe4eloIj54
 QrVaYx8rtnocOcOKPx7wQSm8pG/R15o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-uOh-quE_NPKMPv-kkIxoyQ-1; Wed, 06 Aug 2025 03:25:04 -0400
X-MC-Unique: uOh-quE_NPKMPv-kkIxoyQ-1
X-Mimecast-MFC-AGG-ID: uOh-quE_NPKMPv-kkIxoyQ_1754465103
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31ed4a4a05bso794917a91.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754465103; x=1755069903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7BxJyUwIiYYVgl/lOwzh8jGwTTS/tk8kzjo7q6JOk3k=;
 b=OgLvFRRvjYbhMla8YyX8UkYZBpRU6blhDQBR8zlygDUHxl0ll0ArAvYZBAfzpEseF2
 SNR7MPyBoReYF1X+LP6U9pFSMQPEoghRPO+wvgB5lC2EBPsJkdO4cQs3DBacHLqlmzJB
 9ku0UP/ywxo4rs/c7Iz28zLFuXcxZLCOYvTMreOKtIE5EfBDuqsjzmKvsZQrmopz552g
 EDLkkBN3lcMj0yW9Rt5gCswmniNJWrXarlOolpwiV1ofbivbujMMt9hz36Hq5DueP0Vw
 JbChU70swFjN1lH274JwvHiGC9U8/X0llfLAtA54IdEQRZfAa6qhrz6ReSIGAk2rj7A4
 ZOWw==
X-Gm-Message-State: AOJu0YxZnbGUCsauzDkoFUPJg6GA44tDpCYuFU2tTDqb4Mi4OvL/S5Dz
 5/YjTx6Cmfr7RGtpiGti9V47y+UzmajgKimnWZEYLS6se6roSY13thVHGwCIeMqDzyp5Doipybi
 gh9a24Az5abf2e9cq4r9YKYOBrUJDl0YcJ0uf6QpoU1kjHYQ2pIXi6Rzw+ken0dhaEs3Eo92tob
 5C/6jPqT/Ql5NMy+A9FGy15Utx7hHYoZc=
X-Gm-Gg: ASbGncvEHNr/8OrYFrD5lSXcj7A+NlAxjhinei3BDUzI3u+Tl/JZH3Oi0SyaDbfS7PY
 jHZBlpQQq7PNIIubuc4+dWTjnbZvbN2HoRhME5ikgRRmS2YraBz7LA/UC82YnlPXw3qQxWTSfcZ
 s4y3oZWUDz1v4Ujpbc5srQTvAC9rGdU2NrBmycX2mCtFpmx6kHZkBgpA==
X-Received: by 2002:a17:90b:350d:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-3216697eb4cmr2584008a91.8.1754465103076; 
 Wed, 06 Aug 2025 00:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgVhK8uQSWJEKShrm8MpjcFRR3ZvbIEQlcMNeGsCpoVLD2fwWoufL/0PGkyZVCZBBXS5bPPhRzKX12wW8pkhQ=
X-Received: by 2002:a17:90b:350d:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-3216697eb4cmr2583964a91.8.1754465102619; Wed, 06 Aug 2025
 00:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-7-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-7-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 11:24:51 +0400
X-Gm-Features: Ac12FXxnnhRiCoOYaEaW1iUxlbWrYGuh08Yp_2LvMoCsaJnt6r7PoTuEirV9e9Q
Message-ID: <CAMxuvayMp8MMvHXFMqAtZi5Cfk1PG8ozHXrd9BxM8BpHG=OmkA@mail.gmail.com>
Subject: Re: [PATCH v9 07/27] migration: push Error **errp into
 qemu_loadvm_state()
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000368a1b063bad3d57"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000368a1b063bad3d57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:28=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_loadvm_state() must report an error
> in errp, in case of failure.
>
> When postcopy live migration runs, the device states are loaded by
> both the qemu coroutine process_incoming_migration_co() and the
> postcopy_ram_listen_thread(). Therefore, it is important that the
> coroutine also reports the error in case of failure, with
> error_report_err(). Otherwise, the source qemu will not display
> any errors before going into the postcopy pause state.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/migration.c |  7 ++++---
>  migration/savevm.c    | 31 +++++++++++++++++++------------
>  migration/savevm.h    |  2 +-
>  3 files changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index
> 10c216d25dec01f206eacad2edd24d21f00e614c..bb7d5e1dee52692cbea1d2c8fdca541=
e6a75bedb
> 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)
>                        MIGRATION_STATUS_ACTIVE);
>
>      mis->loadvm_co =3D qemu_coroutine_self();
> -    ret =3D qemu_loadvm_state(mis->from_src_file);
> +    ret =3D qemu_loadvm_state(mis->from_src_file, &local_err);
>      mis->loadvm_co =3D NULL;
>
>      trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> @@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)
>      }
>
>      if (ret < 0) {
> -        error_setg(&local_err, "load of migration failed: %s",
> strerror(-ret));
> +        error_prepend(&local_err, "load of migration failed: %s: ",
> +                      strerror(-ret));
>          goto fail;
>      }
>
> @@ -924,7 +925,7 @@ fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      migrate_set_error(s, local_err);
> -    error_free(local_err);
> +    error_report_err(local_err);
>
>      migration_incoming_state_destroy();
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 1bd27efe437d4d911728d776e995490d0a45dcf5..ca166ebd397ad80836ed2f9cb20a92f=
704fd4ed5
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3149,28 +3149,24 @@ out:
>      return ret;
>  }
>
> -int qemu_loadvm_state(QEMUFile *f)
> +int qemu_loadvm_state(QEMUFile *f, Error **errp)
>  {
>      MigrationState *s =3D migrate_get_current();
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
> -    Error *local_err =3D NULL;
>      int ret;
>
> -    if (qemu_savevm_state_blocked(&local_err)) {
> -        error_report_err(local_err);
> +    if (qemu_savevm_state_blocked(errp)) {
>          return -EINVAL;
>      }
>
>      qemu_loadvm_thread_pool_create(mis);
>
> -    ret =3D qemu_loadvm_state_header(f, &local_err);
> +    ret =3D qemu_loadvm_state_header(f, errp);
>      if (ret) {
> -        error_report_err(local_err);
>          return ret;
>      }
>
> -    if (qemu_loadvm_state_setup(f, &local_err) !=3D 0) {
> -        error_report_err(local_err);
> +    if (qemu_loadvm_state_setup(f, errp) !=3D 0) {
>          return -EINVAL;
>      }
>
> @@ -3181,6 +3177,9 @@ int qemu_loadvm_state(QEMUFile *f)
>      cpu_synchronize_all_pre_loadvm();
>
>      ret =3D qemu_loadvm_state_main(f, mis);
> +    if (ret < 0) {
> +        error_setg(errp, "Load VM state failed: %d", ret);
> +    }
>      qemu_event_set(&mis->main_thread_load_event);
>
>      trace_qemu_loadvm_state_post_main(ret);
> @@ -3198,8 +3197,14 @@ int qemu_loadvm_state(QEMUFile *f)
>          if (migrate_has_error(migrate_get_current()) ||
>              !qemu_loadvm_thread_pool_wait(s, mis)) {
>              ret =3D -EINVAL;
> +            error_setg(errp,
> +                       "Error while loading VM state: "
> +                       "Migration stream has error");
>          } else {
>              ret =3D qemu_file_get_error(f);
> +            if (ret < 0) {
> +                error_setg(errp, "Error while loading vmstate : %d", ret=
);
> +            }
>          }
>      }
>      /*
> @@ -3464,6 +3469,7 @@ void qmp_xen_save_devices_state(const char
> *filename, bool has_live, bool live,
>
>  void qmp_xen_load_devices_state(const char *filename, Error **errp)
>  {
> +    ERRP_GUARD();
>      QEMUFile *f;
>      QIOChannelFile *ioc;
>      int ret;
> @@ -3485,10 +3491,10 @@ void qmp_xen_load_devices_state(const char
> *filename, Error **errp)
>      f =3D qemu_file_new_input(QIO_CHANNEL(ioc));
>      object_unref(OBJECT(ioc));
>
> -    ret =3D qemu_loadvm_state(f);
> +    ret =3D qemu_loadvm_state(f, errp);
>      qemu_fclose(f);
>      if (ret < 0) {
> -        error_setg(errp, "loading Xen device state failed");
> +        error_prepend(errp, "loading Xen device state failed: ");
>      }
>      migration_incoming_state_destroy();
>  }
> @@ -3496,6 +3502,7 @@ void qmp_xen_load_devices_state(const char
> *filename, Error **errp)
>  bool load_snapshot(const char *name, const char *vmstate,
>                     bool has_devices, strList *devices, Error **errp)
>  {
> +    ERRP_GUARD();
>      BlockDriverState *bs_vm_state;
>      QEMUSnapshotInfo sn;
>      QEMUFile *f;
> @@ -3559,13 +3566,13 @@ bool load_snapshot(const char *name, const char
> *vmstate,
>          ret =3D -EINVAL;
>          goto err_drain;
>      }
> -    ret =3D qemu_loadvm_state(f);
> +    ret =3D qemu_loadvm_state(f, errp);
>      migration_incoming_state_destroy();
>
>      bdrv_drain_all_end();
>
>      if (ret < 0) {
> -        error_setg(errp, "Error %d while loading VM state", ret);
> +        error_prepend(errp, "Error %d while loading VM state: ", ret);
>          return false;
>      }
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index
> 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7baea=
e73d90955
> 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
>  void qemu_savevm_live_state(QEMUFile *f);
>  int qemu_save_device_state(QEMUFile *f);
>
> -int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  int qemu_load_device_state(QEMUFile *f);
>
> --
> 2.50.1
>
>

--000000000000368a1b063bad3d57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, =
2025 at 10:28=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that qemu_loadvm_state() must report an error<br>
in errp, in case of failure.<br>
<br>
When postcopy live migration runs, the device states are loaded by<br>
both the qemu coroutine process_incoming_migration_co() and the<br>
postcopy_ram_listen_thread(). Therefore, it is important that the<br>
coroutine also reports the error in case of failure, with<br>
error_report_err(). Otherwise, the source qemu will not display<br>
any errors before going into the postcopy pause state.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/migration.c |=C2=A0 7 ++++---<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 | 31 +++++++++++++++++++------------<=
br>
=C2=A0migration/savevm.h=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A03 files changed, 24 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 10c216d25dec01f206eacad2edd24d21f00e614c..bb7d5e1dee52692cbea1d2c8fdc=
a541e6a75bedb 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -881,7 +881,7 @@ process_incoming_migration_co(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIGRATION_STATUS_ACTIVE);<br>
<br>
=C2=A0 =C2=A0 =C2=A0mis-&gt;loadvm_co =3D qemu_coroutine_self();<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state(mis-&gt;from_src_file);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state(mis-&gt;from_src_file, &amp;local_=
err);<br>
=C2=A0 =C2=A0 =C2=A0mis-&gt;loadvm_co =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_vmstate_downtime_checkpoint(&quot;dst-precopy-loa=
dvm-completed&quot;);<br>
@@ -908,7 +908,8 @@ process_incoming_migration_co(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;local_err, &quot;load of migra=
tion failed: %s&quot;, strerror(-ret));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(&amp;local_err, &quot;load of mi=
gration failed: %s: &quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strerror(-ret));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -924,7 +925,7 @@ fail:<br>
=C2=A0 =C2=A0 =C2=A0migrate_set_state(&amp;mis-&gt;state, MIGRATION_STATUS_=
ACTIVE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIGRATION_STATUS_FAILED);<br>
=C2=A0 =C2=A0 =C2=A0migrate_set_error(s, local_err);<br>
-=C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 error_report_err(local_err);<br>
<br>
=C2=A0 =C2=A0 =C2=A0migration_incoming_state_destroy();<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 1bd27efe437d4d911728d776e995490d0a45dcf5..ca166ebd397ad80836ed2f9cb20=
a92f704fd4ed5 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -3149,28 +3149,24 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-int qemu_loadvm_state(QEMUFile *f)<br>
+int qemu_loadvm_state(QEMUFile *f, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MigrationState *s =3D migrate_get_current();<br>
=C2=A0 =C2=A0 =C2=A0MigrationIncomingState *mis =3D migration_incoming_get_=
current();<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
-=C2=A0 =C2=A0 if (qemu_savevm_state_blocked(&amp;local_err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 if (qemu_savevm_state_blocked(errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0qemu_loadvm_thread_pool_create(mis);<br>
<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_header(f, &amp;local_err);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state_header(f, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (qemu_loadvm_state_setup(f, &amp;local_err) !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 if (qemu_loadvm_state_setup(f, errp) !=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -3181,6 +3177,9 @@ int qemu_loadvm_state(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0cpu_synchronize_all_pre_loadvm();<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qemu_loadvm_state_main(f, mis);<br>
+=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Load VM state failed: %=
d&quot;, ret);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0qemu_event_set(&amp;mis-&gt;main_thread_load_event);<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qemu_loadvm_state_post_main(ret);<br>
@@ -3198,8 +3197,14 @@ int qemu_loadvm_state(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (migrate_has_error(migrate_get_current=
()) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!qemu_loadvm_thread_pool_wa=
it(s, mis)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Error while loading VM state: &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Migration stream has error&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_file_get_error=
(f);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &=
quot;Error while loading vmstate : %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -3464,6 +3469,7 @@ void qmp_xen_save_devices_state(const char *filename,=
 bool has_live, bool live,<br>
<br>
=C2=A0void qmp_xen_load_devices_state(const char *filename, Error **errp)<b=
r>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *f;<br>
=C2=A0 =C2=A0 =C2=A0QIOChannelFile *ioc;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
@@ -3485,10 +3491,10 @@ void qmp_xen_load_devices_state(const char *filenam=
e, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0f =3D qemu_file_new_input(QIO_CHANNEL(ioc));<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(ioc));<br>
<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state(f);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state(f, errp);<br>
=C2=A0 =C2=A0 =C2=A0qemu_fclose(f);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;loading Xen device stat=
e failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;loading Xen device s=
tate failed: &quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0migration_incoming_state_destroy();<br>
=C2=A0}<br>
@@ -3496,6 +3502,7 @@ void qmp_xen_load_devices_state(const char *filename,=
 Error **errp)<br>
=C2=A0bool load_snapshot(const char *name, const char *vmstate,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool =
has_devices, strList *devices, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0BlockDriverState *bs_vm_state;<br>
=C2=A0 =C2=A0 =C2=A0QEMUSnapshotInfo sn;<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *f;<br>
@@ -3559,13 +3566,13 @@ bool load_snapshot(const char *name, const char *vm=
state,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_drain;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 ret =3D qemu_loadvm_state(f);<br>
+=C2=A0 =C2=A0 ret =3D qemu_loadvm_state(f, errp);<br>
=C2=A0 =C2=A0 =C2=A0migration_incoming_state_destroy();<br>
<br>
=C2=A0 =C2=A0 =C2=A0bdrv_drain_all_end();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Error %d while loading =
VM state&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;Error %d while loadi=
ng VM state: &quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/migration/savevm.h b/migration/savevm.h<br>
index 2d5e9c716686f06720325e82fe90c75335ced1de..b80770b7461a60e2ad6ba5e24a7=
baeae73d90955 100644<br>
--- a/migration/savevm.h<br>
+++ b/migration/savevm.h<br>
@@ -64,7 +64,7 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);<br>
=C2=A0void qemu_savevm_live_state(QEMUFile *f);<br>
=C2=A0int qemu_save_device_state(QEMUFile *f);<br>
<br>
-int qemu_loadvm_state(QEMUFile *f);<br>
+int qemu_loadvm_state(QEMUFile *f, Error **errp);<br>
=C2=A0void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);<br>
=C2=A0int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);=
<br>
=C2=A0int qemu_load_device_state(QEMUFile *f);<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--000000000000368a1b063bad3d57--


