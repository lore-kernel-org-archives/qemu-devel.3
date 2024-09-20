Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B540CF9C5F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 18:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srinP-0006dN-Ql; Fri, 20 Sep 2024 14:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1srinN-0006Wu-NF; Fri, 20 Sep 2024 14:55:57 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1srinK-00015o-Oc; Fri, 20 Sep 2024 14:55:56 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a86e9db75b9so333810666b.1; 
 Fri, 20 Sep 2024 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726858552; x=1727463352; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j14y80EvgaH3X0sRzgGq2kIx+5ZX7nubWNfOPxor4J0=;
 b=PADj3hM8TOjyAJW5rQIr3ERzAl3U+awYEkJWVZhR8MEA36kK8dv59GgVqBNy0KgKl9
 wzSUV14eaGwDyTymeoGsw1z7HOWXp+ypBLx8N7oWy9KI5kokn79Dyg4NjUBDvV/vK2S6
 23uDOEfSe1TOBj4+vsQUWnUs5A2hxPFlZAwMtMz0Xe/Mzyd+W9vsTan+JX7uvwn4n1sw
 1izTti22AMaeuPkBfpHSSfKu8jBtBPJFKT//r/XQJgBJ9DUtLgNNloPaCmZYofy2ykA9
 wb4KH882tXXgzYqy8/IvKgN5cDDNJrnAa0oAwvqA6LXC1WNeQT5HNqXxcqpa6J3jsn/P
 x+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726858552; x=1727463352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j14y80EvgaH3X0sRzgGq2kIx+5ZX7nubWNfOPxor4J0=;
 b=gg50FM8ze53NnxNHtS+1r2SXQs+jA4bV8dM6TkZB+TfOTuqOUHdaItqmWv1Wq+AiR7
 jQ5ZFvspYYDPN6lU9LWBWDUhmQwiNZGvqnrtOYdiWoR05K2FsagWMneEbDMZxpzq/blR
 S8VvC0ZOqdtSmiG7cXk+EQY76YraCVADm2P0p9o8lOnMJ1JJCAxuBob0tayGeqonsEnq
 7omMZlXFNsFDUNHDbc1SuG1+IeuExkZhnOXZRdyg9C+KvVHWh5TFooKyuft6qKFPMPo4
 Y1F02guYngYdEIEEvEcKdlfka/jtAXydFVScnYM5UDnnKUtDdQ+oQhUXQcZCwMiODeT4
 lIIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqJ2HEYhzwoBIzr2pkm+s1uMJfV2B2GOrRexN/LXYx/yAidEDfnJabxToFfG/c9EKQzwBUCe5XJEqZag==@nongnu.org
X-Gm-Message-State: AOJu0YyrJ01LZii16t6b65WS34mUjuPOjmlBCeAltIUQrhLgUKA+xMhQ
 KzoDuhpEp3gRmaPma1TcX6LY/uzV/GKAe25qpiNkNGgj95R8nW9twuqgpZIhcRm0+uMHawaps9j
 Lu1afUbPVoCemd3QUdVGx7qg26PQ=
X-Google-Smtp-Source: AGHT+IHT++9r12yWRWTL4guihonBGzeBx/gPhlWzes08h0A2uPZiio3iuSvgJgS2aIyoFUZ41TbnQ0UshJxwwS5gPdI=
X-Received: by 2002:a17:906:fe4a:b0:a86:aa57:57b8 with SMTP id
 a640c23a62f3a-a90d5197d56mr388265866b.63.1726858552159; Fri, 20 Sep 2024
 11:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240913220542.18305-1-farosas@suse.de>
 <20240913220542.18305-3-farosas@suse.de>
In-Reply-To: <20240913220542.18305-3-farosas@suse.de>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Fri, 20 Sep 2024 11:55:30 -0700
Message-ID: <CAEr7rXgZiH-cBaoQEUqFb45Ajn78iMboMxLa1jGQJGTXNvrCGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009433a20622919606"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ufimtseva@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000009433a20622919606
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 3:07=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:

> Fix a segmentation fault in multifd when rb->receivedmap is cleared
> too early.
>
> After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
> multiple page faults"), multifd started using the rb->receivedmap
> bitmap, which belongs to ram.c and is initialized and *freed* from the
> ram SaveVMHandlers.
>
> Multifd threads are live until migration_incoming_state_destroy(),
> which is called after qemu_loadvm_state_cleanup(), leading to a crash
> when accessing rb->receivedmap.
>
> process_incoming_migration_co()        ...
>   qemu_loadvm_state()                  multifd_nocomp_recv()
>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset(=
)
>       rb->receivedmap =3D NULL               set_bit_atomic(...,
> rb->receivedmap)
>   ...
>   migration_incoming_state_destroy()
>     multifd_recv_cleanup()
>       multifd_recv_terminate_threads(NULL)
>
> Move the loadvm cleanup into migration_incoming_state_destroy(), after
> multifd_recv_cleanup() to ensure multifd thread have already exited
> when rb->receivedmap is cleared.
>
> The have_listen_thread logic can now be removed because its purpose
> was to delay cleanup until postcopy_ram_listen_thread() had finished.
>
> CC: qemu-stable@nongnu.org
> Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple
> page faults")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 1 +
>  migration/migration.h | 1 -
>  migration/savevm.c    | 9 ---------
>  3 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d577..b190a574b1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
>      struct MigrationIncomingState *mis =3D migration_incoming_get_curren=
t();
>
>      multifd_recv_cleanup();
> +    qemu_loadvm_state_cleanup();
>
>      if (mis->to_src_file) {
>          /* Tell source that we are done */
> diff --git a/migration/migration.h b/migration/migration.h
> index 38aa1402d5..20b0a5b66e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -101,7 +101,6 @@ struct MigrationIncomingState {
>      /* Set this when we want the fault thread to quit */
>      bool           fault_thread_quit;
>
> -    bool           have_listen_thread;
>      QemuThread     listen_thread;
>
>      /* For the kernel to send us notifications */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d0759694fd..532ee5e4b0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2076,10 +2076,8 @@ static void *postcopy_ram_listen_thread(void
> *opaque)
>       * got a bad migration state).
>       */
>      migration_incoming_state_destroy();
> -    qemu_loadvm_state_cleanup();
>
>      rcu_unregister_thread();
> -    mis->have_listen_thread =3D false;
>      postcopy_state_set(POSTCOPY_INCOMING_END);
>
>      object_unref(OBJECT(migr));
> @@ -2130,7 +2128,6 @@ static int
> loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>          return -1;
>      }
>
> -    mis->have_listen_thread =3D true;
>      postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
>                             postcopy_ram_listen_thread,
> QEMU_THREAD_DETACHED);
>      trace_loadvm_postcopy_handle_listen("return");
> @@ -2978,11 +2975,6 @@ int qemu_loadvm_state(QEMUFile *f)
>
>      trace_qemu_loadvm_state_post_main(ret);
>
> -    if (mis->have_listen_thread) {
> -        /* Listen thread still going, can't clean up yet */
> -        return ret;
> -    }
> -
>      if (ret =3D=3D 0) {
>          ret =3D qemu_file_get_error(f);
>      }
> @@ -3022,7 +3014,6 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
>
> -    qemu_loadvm_state_cleanup();
>      cpu_synchronize_all_post_init();
>


Hi Fabiano

I have a question. By removing  qemu_loadvm_state_cleanup() here, the
failure path that ends up with exit(EXIT_FAILURE)
in process_incoming_migration_co() end up not calling the
qemu_loadvm_state_cleanup(). I am not sure how this is important since
there is exit, but the
vfio, for example, will not call the VF reset.

Another more general question is why destination Qemu has to terminate
there if there was an error detected during live migration?
Could just failing the migration and leave destination running be a more
expected scenario?

Thank you!

     return ret;
> --
> 2.35.3
>
>
>

--=20
Elena

--0000000000009433a20622919606
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 13, 2024 at 3:07=E2=80=AF=
PM Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de">farosas@suse.de</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fix =
a segmentation fault in multifd when rb-&gt;receivedmap is cleared<br>
too early.<br>
<br>
After commit 5ef7e26bdb (&quot;migration/multifd: solve zero page causing<b=
r>
multiple page faults&quot;), multifd started using the rb-&gt;receivedmap<b=
r>
bitmap, which belongs to ram.c and is initialized and *freed* from the<br>
ram SaveVMHandlers.<br>
<br>
Multifd threads are live until migration_incoming_state_destroy(),<br>
which is called after qemu_loadvm_state_cleanup(), leading to a crash<br>
when accessing rb-&gt;receivedmap.<br>
<br>
process_incoming_migration_co()=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 qemu_loadvm_state()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 multifd_nocomp_recv()<br>
=C2=A0 =C2=A0 qemu_loadvm_state_cleanup()=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 ramblock_recv_bitmap_set_offset()<br>
=C2=A0 =C2=A0 =C2=A0 rb-&gt;receivedmap =3D NULL=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0set_bit_atomic(..., rb-&gt;receivedmap)<br>
=C2=A0 ...<br>
=C2=A0 migration_incoming_state_destroy()<br>
=C2=A0 =C2=A0 multifd_recv_cleanup()<br>
=C2=A0 =C2=A0 =C2=A0 multifd_recv_terminate_threads(NULL)<br>
<br>
Move the loadvm cleanup into migration_incoming_state_destroy(), after<br>
multifd_recv_cleanup() to ensure multifd thread have already exited<br>
when rb-&gt;receivedmap is cleared.<br>
<br>
The have_listen_thread logic can now be removed because its purpose<br>
was to delay cleanup until postcopy_ram_listen_thread() had finished.<br>
<br>
CC: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Fixes: 5ef7e26bdb (&quot;migration/multifd: solve zero page causing multipl=
e page faults&quot;)<br>
Signed-off-by: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=
=3D"_blank">farosas@suse.de</a>&gt;<br>
---<br>
=C2=A0migration/migration.c | 1 +<br>
=C2=A0migration/migration.h | 1 -<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 | 9 ---------<br>
=C2=A03 files changed, 1 insertion(+), 10 deletions(-)<br>
<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index 3dea06d577..b190a574b1 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)<br>
=C2=A0 =C2=A0 =C2=A0struct MigrationIncomingState *mis =3D migration_incomi=
ng_get_current();<br>
<br>
=C2=A0 =C2=A0 =C2=A0multifd_recv_cleanup();<br>
+=C2=A0 =C2=A0 qemu_loadvm_state_cleanup();<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (mis-&gt;to_src_file) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Tell source that we are done */<br>
diff --git a/migration/migration.h b/migration/migration.h<br>
index 38aa1402d5..20b0a5b66e 100644<br>
--- a/migration/migration.h<br>
+++ b/migration/migration.h<br>
@@ -101,7 +101,6 @@ struct MigrationIncomingState {<br>
=C2=A0 =C2=A0 =C2=A0/* Set this when we want the fault thread to quit */<br=
>
=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fault_thre=
ad_quit;<br>
<br>
-=C2=A0 =C2=A0 bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0have_listen_thr=
ead;<br>
=C2=A0 =C2=A0 =C2=A0QemuThread=C2=A0 =C2=A0 =C2=A0listen_thread;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* For the kernel to send us notifications */<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index d0759694fd..532ee5e4b0 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -2076,10 +2076,8 @@ static void *postcopy_ram_listen_thread(void *opaque=
)<br>
=C2=A0 =C2=A0 =C2=A0 * got a bad migration state).<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0migration_incoming_state_destroy();<br>
-=C2=A0 =C2=A0 qemu_loadvm_state_cleanup();<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_unregister_thread();<br>
-=C2=A0 =C2=A0 mis-&gt;have_listen_thread =3D false;<br>
=C2=A0 =C2=A0 =C2=A0postcopy_state_set(POSTCOPY_INCOMING_END);<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_unref(OBJECT(migr));<br>
@@ -2130,7 +2128,6 @@ static int loadvm_postcopy_handle_listen(MigrationInc=
omingState *mis)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 mis-&gt;have_listen_thread =3D true;<br>
=C2=A0 =C2=A0 =C2=A0postcopy_thread_create(mis, &amp;mis-&gt;listen_thread,=
 &quot;mig/dst/listen&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);=
<br>
=C2=A0 =C2=A0 =C2=A0trace_loadvm_postcopy_handle_listen(&quot;return&quot;)=
;<br>
@@ -2978,11 +2975,6 @@ int qemu_loadvm_state(QEMUFile *f)<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_qemu_loadvm_state_post_main(ret);<br>
<br>
-=C2=A0 =C2=A0 if (mis-&gt;have_listen_thread) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Listen thread still going, can&#39;t clean =
up yet */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (ret =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_file_get_error(f);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -3022,7 +3014,6 @@ int qemu_loadvm_state(QEMUFile *f)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 qemu_loadvm_state_cleanup();<br>
=C2=A0 =C2=A0 =C2=A0cpu_synchronize_all_post_init();<br>=C2=A0</blockquote>=
<div><br></div><div>Hi Fabiano</div><div><br></div><div>I have a question. =
By removing=C2=A0 qemu_loadvm_state_cleanup() here, the failure path that e=
nds up with exit(EXIT_FAILURE)</div><div>in process_incoming_migration_co()=
 end up not calling the=C2=A0 qemu_loadvm_state_cleanup(). I am not sure ho=
w this is important since there is exit, but the <br></div><div>vfio, for e=
xample, will not call the VF reset.</div><div><br></div><div>Another more g=
eneral question is why destination Qemu has to terminate there if there was=
 an error detected during live migration?</div><div>Could just failing the =
migration and leave destination running be a more expected scenario?</div><=
div><br></div><div>Thank you!<br></div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0return ret;<br>
-- <br>
2.35.3<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Elena</div></=
div>

--0000000000009433a20622919606--

