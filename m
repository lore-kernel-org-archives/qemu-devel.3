Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967F4C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYZD-0004n1-Gt; Wed, 06 Aug 2025 03:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYZC-0004m1-Df
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ujYZA-0004oT-NG
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754465284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5D+1tZScRPoJxPWmAly9QJ5bwcNMmSE7hJk1rmV0FOQ=;
 b=O+ro21lnSf+q8qkKDvBAW6E5wjnE+HIHgagVyo2wluRbJ7Jpk1Gi361UdUVTkZjJRuFBjz
 XVcR7E+lQwo+Kuot1LS14FiAr8gYsrp5aUrLxa3VspSOgzttdvf3IYQkrEUkaY/QKkgOlE
 ULdeuWy54QwPmmylUTCZqabK/Ii1O4s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-fY6oovOYP5i6FtTkgilgRQ-1; Wed, 06 Aug 2025 03:28:02 -0400
X-MC-Unique: fY6oovOYP5i6FtTkgilgRQ-1
X-Mimecast-MFC-AGG-ID: fY6oovOYP5i6FtTkgilgRQ_1754465281
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-315af0857f2so6446933a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754465276; x=1755070076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5D+1tZScRPoJxPWmAly9QJ5bwcNMmSE7hJk1rmV0FOQ=;
 b=TLPmSfle5R7Nq9F7Y50IR48GGyRcth7wVTZz6VqtjDznbRmT3hr24ES8uJbintHjRK
 5SULdnRDlrdwRnjwbv2blZn3HhPZwp7znebCrPT2lpQG/I336sTkd2IFasloTXprabJG
 2LBTPJQGgqJGkGxt8e6OFtNz/2Jn3TCwla8PyR0XzuMAfDkHh4wBAQa7NSUiV8ahAiMO
 J5E2TrEApjK8tKPCtBQ6o/JfRjc6Nw3WQbLCDjHS53lPRiOG/1HzhvDMPaDqiiAllCsx
 bCtnXMjMqy6OGOQwEEWnjbr6pneMoHhQuT1HQHu4oJ4XmFSJqUOGif8j8qZU5xi8tEgo
 1FkA==
X-Gm-Message-State: AOJu0YzPf0/32Gd7UXCDKzpFbTCunQZ//Jp9ZJbO7DL84XNsG+rmOTLT
 2O88CjayIbq12sVougK8o30kOXSGqGbYo/5X1cehM1a/Tl3mchHrxwJdHReWeIUv249+C2iRQEF
 o/QnaKTnYj6e0w5IFzqTS/pg3OwZsQF35cGwpU04lNcJ06i8Ba3Dyp+jHTWqtx1mK0Jjiqh/nHy
 Swjkp3q3+naTmaIpG1vfkSWBLyCcVVIWA=
X-Gm-Gg: ASbGncuuMIFIwMVv1WsRi/e4AsFdVhnz+NhB1hTF35w906E+heXLN2pGL2fajYJgUNe
 QtIIDrzI4TPCEzt+4mxi/WwnMFIxYP513c2R+TZgj97Ztm7XJt6JvD00qqh2mVuFAls+FHB63bB
 8AP7qbf0Ks9bL8g+9BuZYmHXDyji6SdoHpb6zatkpDDEMqLy76U5cwog==
X-Received: by 2002:a17:90b:4b12:b0:31f:150:e02b with SMTP id
 98e67ed59e1d1-32166e27c9amr2255224a91.4.1754465276255; 
 Wed, 06 Aug 2025 00:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwJW28sKOrBVQppBw6RqJe3TyG6hfgTEszt+LzPVtZLCV46l7Vqz2ttU/B/qf0Q6lFL7k2yr62bzu+jIDFqHQ=
X-Received: by 2002:a17:90b:4b12:b0:31f:150:e02b with SMTP id
 98e67ed59e1d1-32166e27c9amr2255195a91.4.1754465275841; Wed, 06 Aug 2025
 00:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
 <20250805-propagate_tpm_error-v9-8-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-8-123450810db7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 6 Aug 2025 11:27:44 +0400
X-Gm-Features: Ac12FXz3yMuB0O3McERGlyJxcv2ZH3FakDMOGwRPZfoaOgXx4zGtZuL50wbfBsY
Message-ID: <CAMxuvax3sUKkHjo0Uw2HQnhOd_yoPJqia7xF=5+DynXEhVOskw@mail.gmail.com>
Subject: Re: [PATCH v9 08/27] migration: push Error **errp into
 qemu_load_device_state()
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
Content-Type: multipart/alternative; boundary="00000000000089b16c063bad470e"
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

--00000000000089b16c063bad470e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 10:29=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that qemu_load_device_state() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/colo.c   | 4 ++--
>  migration/savevm.c | 5 +++--
>  migration/savevm.h | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index
> e0f713c837f5da25d67afbd02ceb6c54024ca3af..0ba22ee76a13e313793f653f43a728e=
3c433bbc1
> 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -729,9 +729,9 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      bql_lock();
>      vmstate_loading =3D true;
>      colo_flush_ram_cache();
> -    ret =3D qemu_load_device_state(fb);
> +    ret =3D qemu_load_device_state(fb, errp);
>      if (ret < 0) {
> -        error_setg(errp, "COLO: load device state failed");
> +        error_prepend(errp, "COLO: load device state failed: ");
>          vmstate_loading =3D false;
>          bql_unlock();
>          return;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> ca166ebd397ad80836ed2f9cb20a92f704fd4ed5..f3b91c8ae0eee6078406081f0bd7f68=
6fed28601
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3253,15 +3253,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
>      return ret;
>  }
>
> -int qemu_load_device_state(QEMUFile *f)
> +int qemu_load_device_state(QEMUFile *f, Error **errp)
>  {
> +    ERRP_GUARD();
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      int ret;
>
>      /* Load QEMU_VM_SECTION_FULL section */
>      ret =3D qemu_loadvm_state_main(f, mis);
>      if (ret < 0) {
> -        error_report("Failed to load device state: %d", ret);
> +        error_setg(errp, "Failed to load device state: %d", ret);
>          return ret;
>      }
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index
> b80770b7461a60e2ad6ba5e24a7baeae73d90955..b12681839f0b1afa3255e45215d99c1=
3a224b19f
> 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> -int qemu_load_device_state(QEMUFile *f);
> +int qemu_load_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>          bool in_postcopy);
>
> --
> 2.50.1
>
>

--00000000000089b16c063bad470e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 5, =
2025 at 10:29=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.co=
m">armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">This is an incremental step in converting vmstate load=
ing<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
It is ensured that qemu_load_device_state() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/colo.c=C2=A0 =C2=A0| 4 ++--<br>
=C2=A0migration/savevm.c | 5 +++--<br>
=C2=A0migration/savevm.h | 2 +-<br>
=C2=A03 files changed, 6 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/migration/colo.c b/migration/colo.c<br>
index e0f713c837f5da25d67afbd02ceb6c54024ca3af..0ba22ee76a13e313793f653f43a=
728e3c433bbc1 100644<br>
--- a/migration/colo.c<br>
+++ b/migration/colo.c<br>
@@ -729,9 +729,9 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
=C2=A0 =C2=A0 =C2=A0vmstate_loading =3D true;<br>
=C2=A0 =C2=A0 =C2=A0colo_flush_ram_cache();<br>
-=C2=A0 =C2=A0 ret =3D qemu_load_device_state(fb);<br>
+=C2=A0 =C2=A0 ret =3D qemu_load_device_state(fb, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;COLO: load device state=
 failed&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_prepend(errp, &quot;COLO: load device st=
ate failed: &quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_loading =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index ca166ebd397ad80836ed2f9cb20a92f704fd4ed5..f3b91c8ae0eee6078406081f0bd=
7f686fed28601 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -3253,15 +3253,16 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)<br=
>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-int qemu_load_device_state(QEMUFile *f)<br>
+int qemu_load_device_state(QEMUFile *f, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0MigrationIncomingState *mis =3D migration_incoming_get_=
current();<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load QEMU_VM_SECTION_FULL section */<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qemu_loadvm_state_main(f, mis);<br>
=C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Failed to load device state=
: %d&quot;, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to load device s=
tate: %d&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
diff --git a/migration/savevm.h b/migration/savevm.h<br>
index b80770b7461a60e2ad6ba5e24a7baeae73d90955..b12681839f0b1afa3255e45215d=
99c13a224b19f 100644<br>
--- a/migration/savevm.h<br>
+++ b/migration/savevm.h<br>
@@ -67,7 +67,7 @@ int qemu_save_device_state(QEMUFile *f);<br>
=C2=A0int qemu_loadvm_state(QEMUFile *f, Error **errp);<br>
=C2=A0void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);<br>
=C2=A0int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);=
<br>
-int qemu_load_device_state(QEMUFile *f);<br>
+int qemu_load_device_state(QEMUFile *f, Error **errp);<br>
=C2=A0int qemu_loadvm_approve_switchover(void);<br>
=C2=A0int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool in_postcopy);<br>
<br>
-- <br>
2.50.1<br>
<br>
</blockquote></div></div>

--00000000000089b16c063bad470e--


