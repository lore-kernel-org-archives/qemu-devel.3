Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7EBC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLbK-0003IH-KB; Mon, 28 Jul 2025 07:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugL3B-0001tk-V4
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugL39-0003Yf-53
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753698340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOVYNQxYnFewKqtvS3z8sG4MerVrXAyGCxW0sm36iZ4=;
 b=i4MBmuqU5GfsrCVe5TWVOSx4gFbSoe+cpxYmVGm4yEpd6fXYFatQiQQ891F5HI4i736o27
 8S0fnxDjr1cPeKg1Ey4H7Ox6Mt8cZB72yqnhu4sioN/vyt6jcxP6AWPyY/wLj/rBLlHKv9
 tsALPAleh+WAafrbXP2/D7aT+PvWS0k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-_cbl4ruNN2OnWpGlYj0szQ-1; Mon, 28 Jul 2025 06:25:39 -0400
X-MC-Unique: _cbl4ruNN2OnWpGlYj0szQ-1
X-Mimecast-MFC-AGG-ID: _cbl4ruNN2OnWpGlYj0szQ_1753698338
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31ed4a4a05bso1282052a91.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753698338; x=1754303138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOVYNQxYnFewKqtvS3z8sG4MerVrXAyGCxW0sm36iZ4=;
 b=u8xp4QixuIWHmyI6Q2vPjIMDxWoVySdtuuQvx6ijnYuRhAtTtXUPdPeK62kGaDChoT
 xbyH0RCziTRY1Xre0uIeQ+3pFrYTFl5sTV8/CJaNqGmFBLFW/PZCAIY6o7Q0VbtB2+qT
 Y7cLa/pq/qgTbbGHJF0gHYdRR/hX1i5FvB/Dp2d/j9VYJ9GQ1zR3PCenKwCnOyI8EFmP
 t1NAQNKWd2pcoR2US0dojzDhzx92zP56mnov0iNAoOqm25CAamZBVmyxKMWBnOt9vsGf
 kW7ut+7wxvJhZSJwn1EuJBIYR+Pw3dcuo5fVfxjpz8W/no0kBn8VJlqvy7K4mVHnRygr
 ENUA==
X-Gm-Message-State: AOJu0YxS3TG7Ald06Q1DFdskfTol47aJrWupWRFnqfMeIKIREG/S/2d0
 0g0AyISLHUCRbln/OnOBEQLccm3rtrxJ2dVbfge9cUMKE7UzEHAcIVBv2eIgs0eHsgGfQy2/hbN
 BFPPZ76FVF88sqPqi+mQpTCQVr0BunFemn+tGpeRf0a2GeMrnYMZagRzzF/37TRZLVKeRFTO6ag
 MBn+hPlliaVvVpsrxZWU4zxFQA3vIQKSI=
X-Gm-Gg: ASbGncuviovcJJ1EO4yDz7fDYtkvYep7tAyFV/eg2aV7tFR3oHROjuSr2Rxg8a1bQzB
 ikZCHzgF+AZonOpU662AnUhVSI0NkJLHopoLJLH9tpWrTyZa3vHtWAp+n37AK6ZOBCGF0pABYb+
 V8GtVLu1uQjRGGtectOLcWjgh+4cb3Ca7FjKY/Y5d+UMeZYWqo3VulGw==
X-Received: by 2002:a17:90b:4a81:b0:31e:f30f:6d3b with SMTP id
 98e67ed59e1d1-31ef30f715bmr4521843a91.2.1753698337716; 
 Mon, 28 Jul 2025 03:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVU+LWnQWNMaFuWPjr2CwHMl0HqGHc/wbWHdM6jp+RAlL4/qMMYR4xEXPiJUWkkEIoT2Uhb7F1AV/NrNPFoAQ=
X-Received: by 2002:a17:90b:4a81:b0:31e:f30f:6d3b with SMTP id
 98e67ed59e1d1-31ef30f715bmr4521778a91.2.1753698337214; Mon, 28 Jul 2025
 03:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-8-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-8-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 14:25:26 +0400
X-Gm-Features: Ac12FXxfcFucPQ3mpVjtNvLBHeBW8mVhR1Gjqglda8jWQrBMeNlK7JekesC3dII
Message-ID: <CAMxuvazur4y2svycNvEYe35nH1CSOvLR7EJAm_tADssacTM_SA@mail.gmail.com>
Subject: Re: [PATCH v7 08/24] migration: make loadvm_postcopy_handle_resume()
 void
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
Content-Type: multipart/alternative; boundary="0000000000006ee936063afab62d"
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

--0000000000006ee936063afab62d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 25, 2025 at 4:20=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>  migration/savevm.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> d8f5f1966fda831899596173f20fbef25d78829d..ad96da3651b89023e4b70ffeecab46d=
176bae6f5
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2334,12 +2334,12 @@ static void
> migrate_send_rp_req_pages_pending(MigrationIncomingState *mis)
>      }
>  }
>
> -static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
> +static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>  {
>      if (mis->state !=3D MIGRATION_STATUS_POSTCOPY_RECOVER) {
> -        error_report("%s: illegal resume received", __func__);
> +        warn_report("%s: illegal resume received", __func__);
>

Could you add a comment to the commit message to explain why this somewhat
unrelated change? thanks


>          /* Don't fail the load, only for this. */
> -        return 0;
> +        return;
>      }
>
>      /*
> @@ -2391,8 +2391,6 @@ static int
> loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>          /* Kick the fast ram load thread too */
>          qemu_sem_post(&mis->postcopy_pause_sem_fast_load);
>      }
> -
> -    return 0;
>  }
>
>  /**
> @@ -2627,7 +2625,8 @@ static int loadvm_process_command(QEMUFile *f)
>          return loadvm_postcopy_ram_handle_discard(mis, len);
>
>      case MIG_CMD_POSTCOPY_RESUME:
> -        return loadvm_postcopy_handle_resume(mis);
> +        loadvm_postcopy_handle_resume(mis);
> +        return 0;
>
>      case MIG_CMD_RECV_BITMAP:
>          return loadvm_handle_recv_bitmap(mis, len);
>
> --
> 2.50.0
>
>

--0000000000006ee936063afab62d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi</div><br><div class=3D"gmail_quote gma=
il_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 25, 2=
025 at 4:20=E2=80=AFPM Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com"=
>armenon@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">This is an incremental step in converting vmstate loadin=
g<br>
code to report error via Error objects instead of directly<br>
printing it to console/monitor.<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br>
---<br>
=C2=A0migration/savevm.c | 11 +++++------<br>
=C2=A01 file changed, 5 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index d8f5f1966fda831899596173f20fbef25d78829d..ad96da3651b89023e4b70ffeeca=
b46d176bae6f5 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2334,12 +2334,12 @@ static void migrate_send_rp_req_pages_pending(Migra=
tionIncomingState *mis)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)<br>
+static void loadvm_postcopy_handle_resume(MigrationIncomingState *mis)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (mis-&gt;state !=3D MIGRATION_STATUS_POSTCOPY_RECOVE=
R) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s: illegal resume received=
&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 warn_report(&quot;%s: illegal resume received&=
quot;, __func__);<br></blockquote><div><br></div><div>Could you add a comme=
nt to the commit message to explain why this somewhat unrelated change? tha=
nks</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Don&#39;t fail the load, only for this=
. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
@@ -2391,8 +2391,6 @@ static int loadvm_postcopy_handle_resume(MigrationInc=
omingState *mis)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Kick the fast ram load thread too */<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_sem_post(&amp;mis-&gt;postcopy_pause=
_sem_fast_load);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-<br>
-=C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
@@ -2627,7 +2625,8 @@ static int loadvm_process_command(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return loadvm_postcopy_ram_handle_discard=
(mis, len);<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_POSTCOPY_RESUME:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return loadvm_postcopy_handle_resume(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loadvm_postcopy_handle_resume(mis);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0case MIG_CMD_RECV_BITMAP:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return loadvm_handle_recv_bitmap(mis, len=
);<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--0000000000006ee936063afab62d--


