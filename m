Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB89C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugKhb-0001gx-Tr; Mon, 28 Jul 2025 06:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugKf8-00085H-6K
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1ugKf4-0007mI-Gw
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753696849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EvRSsivZalZdaGsKVBYAx5mU/9wdB2nLBk2Ud6QIkYM=;
 b=AIOBWujGBjLTZRsuMj85Roy7WG9m3rtRwjvY7gdWXUYPAT4daYF76r6+oStG9yUuXHfJ9h
 bhrRji/0tCKnOdN8PZHRUMbp+5DldpFUzlcjM3Yq+bNrj5bNIAiQV2x6ux99fcd210TeQs
 3fpxDoxwZXsAvQXYyJ6HrtymGPhlfuk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-2o7B6DvaPHSwXg7oXqzYMg-1; Mon, 28 Jul 2025 06:00:45 -0400
X-MC-Unique: 2o7B6DvaPHSwXg7oXqzYMg-1
X-Mimecast-MFC-AGG-ID: 2o7B6DvaPHSwXg7oXqzYMg_1753696844
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31ec78f183eso1747298a91.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753696844; x=1754301644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EvRSsivZalZdaGsKVBYAx5mU/9wdB2nLBk2Ud6QIkYM=;
 b=DJcw/+knuzFxgC9WI/iUMWnjsQe6p9GolQBxnAIWrW+Ym178YL3QByaM+Vz8m1KBc4
 PugQg/+xEhaLr8hXZC0qkJcvkqC4lanVo75v0W2ZFkrl3jBsX1CTSaBpKA0MbXwrdO/4
 rIMkJ/4AWdnzjwsjWvQg5xmR2GtmpI76kEDLMZxXEre2zP5aqG8cFXYeBkhsoETTGpX6
 Pe0YV1GuNRzdcnltbB5jru214lCrSfhF3o8UM80yQzYDErm+Fa0rTISm8KojPLNc7xWl
 uCYDdlt0Uwhz5bnD28rrHmXPI9MVKj+7Js7RXyTiWfWi5mrps8CEBi0s175r+hTQ1Rd0
 vDTA==
X-Gm-Message-State: AOJu0YyKTyI3xNAaTHnsF4BX0UV0uxZV8XUcdDbWroeLDMCoT0/HBe2v
 L6vfTUpPJRObUST+5sS4qDzhliJAXxbZ+dSJmk/3CG+/lblfH8w14wde/OXxt/e75M16+8N7aeL
 3vll+bpU47sQUiLiI0E9wKQCxV7GtOzd17TWEn4sUuqoBOaEAYbCZX8D10BHjEES11uvwHxBW5B
 Yki656OZbhRbmOTzu3VMKvcbBNtO9Ons0=
X-Gm-Gg: ASbGnct2IQQvcGo30y6HehJlD75dxENO41Fj9fVExNkjnjIY47X6b2b0SIeQLtl9t4R
 vKQogRMExOZhWA9BwqEAOM4gjrgVHjYNDkN3KkYXMyh+LoZkImTtWnsFapgENItWn88UpDK+DSU
 epo9bl9TGsPa73NMAEdPe+GPYQIynecfQm7896Be0jELUhwJsh4p7whA==
X-Received: by 2002:a17:90a:f943:b0:31e:998f:7b75 with SMTP id
 98e67ed59e1d1-31e998f7d70mr7161187a91.9.1753696843877; 
 Mon, 28 Jul 2025 03:00:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXlM6aYTgXdEPtL4QW46U0RCOZsXhefTb/LAd/nw5fwuBVP3mAO1DpTERC2yC7kpPPsryjm/cf/Sqz1W1g2dQ=
X-Received: by 2002:a17:90a:f943:b0:31e:998f:7b75 with SMTP id
 98e67ed59e1d1-31e998f7d70mr7161144a91.9.1753696843399; Mon, 28 Jul 2025
 03:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-11-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-11-d52704443975@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 28 Jul 2025 14:00:31 +0400
X-Gm-Features: Ac12FXwIeuGlXhNi0AB2tk4FKjI5Ccaaex6OFcvX5dIxhDuqudm1fGsb1DuBPkY
Message-ID: <CAMxuvaw7-SgXHeDqbrvdhdq4Y3r49w-1XGHqHpFVwTySj-49Fg@mail.gmail.com>
Subject: Re: [PATCH v7 11/24] migration: push Error **errp into
 ram_postcopy_incoming_init()
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
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000651ea6063afa5d98"
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

--000000000000651ea6063afa5d98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:20=E2=80=AFPM Arun Menon <armenon@redhat.com> wro=
te:

> This is an incremental step in converting vmstate loading
> code to report error via Error objects instead of directly
> printing it to console/monitor.
> It is ensured that ram_postcopy_incoming_init() must report an error
> in errp, in case of failure.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/postcopy-ram.c | 9 ++++++---
>  migration/postcopy-ram.h | 2 +-
>  migration/ram.c          | 4 ++--
>  migration/ram.h          | 2 +-
>  migration/savevm.c       | 2 +-
>  5 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index
> 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f7d9a=
316baf1e4
> 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -681,6 +681,7 @@ out:
>   */
>  static int init_range(RAMBlock *rb, void *opaque)
>  {
> +    Error **errp =3D opaque;
>      const char *block_name =3D qemu_ram_get_idstr(rb);
>      void *host_addr =3D qemu_ram_get_host_addr(rb);
>      ram_addr_t offset =3D qemu_ram_get_offset(rb);
> @@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)
>       * (Precopy will just overwrite this data, so doesn't need the
> discard)
>       */
>      if (ram_discard_range(block_name, 0, length)) {
> +        error_setg(errp, "failed to discard RAM block %s len=3D%zu",
> +                   block_name, length);
>          return -1;
>      }
>
> @@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
>   * postcopy later; must be called prior to any precopy.
>   * called from arch_init's similarly named ram_postcopy_incoming_init
>   */
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp=
)
>  {
> -    if (foreach_not_ignored_block(init_range, NULL)) {
> +    if (foreach_not_ignored_block(init_range, errp)) {
>          return -1;
>      }
>
> @@ -1703,7 +1706,7 @@ bool
> postcopy_ram_supported_by_host(MigrationIncomingState *mis, Error **errp)
>      return false;
>  }
>
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis)
> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp=
)
>  {
>      error_report("postcopy_ram_incoming_init: No OS support");
>      return -1;
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index
> 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb442c=
58a9a4f48
> 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState
> *mis);
>   * postcopy later; must be called prior to any precopy.
>   * called from ram.c's similarly named ram_postcopy_incoming_init
>   */
> -int postcopy_ram_incoming_init(MigrationIncomingState *mis);
> +int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp=
);
>
>  /*
>   * At the end of a migration where postcopy_ram_incoming_init was called=
.
> diff --git a/migration/ram.c b/migration/ram.c
> index
> 7208bc114fb5c366740db380ee6956a91b3871a0..6a0dcc04f436524a37672c41c38f201=
f06773374
> 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)
>   * postcopy-ram. postcopy-ram's similarly names
>   * postcopy_ram_incoming_init does the work.
>   */
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis)
> +int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp=
)
>  {
> -    return postcopy_ram_incoming_init(mis);
> +    return postcopy_ram_incoming_init(mis, errp);
>  }
>
>  /**
> diff --git a/migration/ram.h b/migration/ram.h
> index
> 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05281e=
c268ba0db
> 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationStat=
e
> *ms);
>  void ram_postcopy_send_discard_bitmap(MigrationState *ms);
>  /* For incoming postcopy discard */
>  int ram_discard_range(const char *block_name, uint64_t start, size_t
> length);
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> +int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp=
);
>  int ram_load_postcopy(QEMUFile *f, int channel);
>
>  void ram_handle_zero(void *host, uint64_t size);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index
> 63cf488d9f411c0fb8d5f1bc8a719aa575bbabdc..60a055f3e1f248b09e5e5d721f14d2e=
eafd0a7ad
> 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1989,7 +1989,7 @@ static int
> loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>          return -1;
>      }
>
> -    if (ram_postcopy_incoming_init(mis)) {
> +    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
>          return -1;
>      }
>
>
> --
> 2.50.0
>
>

--000000000000651ea6063afa5d98
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
It is ensured that ram_postcopy_incoming_init() must report an error<br>
in errp, in case of failure.<br>
<br>
Signed-off-by: Arun Menon &lt;<a href=3D"mailto:armenon@redhat.com" target=
=3D"_blank">armenon@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@=
redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0migration/postcopy-ram.c | 9 ++++++---<br>
=C2=A0migration/postcopy-ram.h | 2 +-<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++--<br>
=C2=A0migration/ram.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0migration/savevm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A05 files changed, 11 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c<br>
index 45af9a361e8eacaad0fb217a5da2c5004416c1da..05617e5fbcad62226a54fe17d9f=
7d9a316baf1e4 100644<br>
--- a/migration/postcopy-ram.c<br>
+++ b/migration/postcopy-ram.c<br>
@@ -681,6 +681,7 @@ out:<br>
=C2=A0 */<br>
=C2=A0static int init_range(RAMBlock *rb, void *opaque)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 Error **errp =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0const char *block_name =3D qemu_ram_get_idstr(rb);<br>
=C2=A0 =C2=A0 =C2=A0void *host_addr =3D qemu_ram_get_host_addr(rb);<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t offset =3D qemu_ram_get_offset(rb);<br>
@@ -701,6 +702,8 @@ static int init_range(RAMBlock *rb, void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 * (Precopy will just overwrite this data, so doesn&#39=
;t need the discard)<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (ram_discard_range(block_name, 0, length)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to discard RAM b=
lock %s len=3D%zu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block=
_name, length);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -749,9 +752,9 @@ static int cleanup_range(RAMBlock *rb, void *opaque)<br=
>
=C2=A0 * postcopy later; must be called prior to any precopy.<br>
=C2=A0 * called from arch_init&#39;s similarly named ram_postcopy_incoming_=
init<br>
=C2=A0 */<br>
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)<br>
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)<=
br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (foreach_not_ignored_block(init_range, NULL)) {<br>
+=C2=A0 =C2=A0 if (foreach_not_ignored_block(init_range, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1703,7 +1706,7 @@ bool postcopy_ram_supported_by_host(MigrationIncoming=
State *mis, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
-int postcopy_ram_incoming_init(MigrationIncomingState *mis)<br>
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0error_report(&quot;postcopy_ram_incoming_init: No OS su=
pport&quot;);<br>
=C2=A0 =C2=A0 =C2=A0return -1;<br>
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h<br>
index 3852141d7e37ab18bada4b46c137fef0969d0070..ca19433b246893fa5105bcebffb=
442c58a9a4f48 100644<br>
--- a/migration/postcopy-ram.h<br>
+++ b/migration/postcopy-ram.h<br>
@@ -30,7 +30,7 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *m=
is);<br>
=C2=A0 * postcopy later; must be called prior to any precopy.<br>
=C2=A0 * called from ram.c&#39;s similarly named ram_postcopy_incoming_init=
<br>
=C2=A0 */<br>
-int postcopy_ram_incoming_init(MigrationIncomingState *mis);<br>
+int postcopy_ram_incoming_init(MigrationIncomingState *mis, Error **errp);=
<br>
<br>
=C2=A0/*<br>
=C2=A0 * At the end of a migration where postcopy_ram_incoming_init was cal=
led.<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 7208bc114fb5c366740db380ee6956a91b3871a0..6a0dcc04f436524a37672c41c38=
f201f06773374 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -3716,9 +3716,9 @@ static int ram_load_cleanup(void *opaque)<br>
=C2=A0 * postcopy-ram. postcopy-ram&#39;s similarly names<br>
=C2=A0 * postcopy_ram_incoming_init does the work.<br>
=C2=A0 */<br>
-int ram_postcopy_incoming_init(MigrationIncomingState *mis)<br>
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp)<=
br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return postcopy_ram_incoming_init(mis);<br>
+=C2=A0 =C2=A0 return postcopy_ram_incoming_init(mis, errp);<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
diff --git a/migration/ram.h b/migration/ram.h<br>
index 921c39a2c5c45bc2344be80854c46e4c10c09aeb..275709a99187f9429ccb4111e05=
281ec268ba0db 100644<br>
--- a/migration/ram.h<br>
+++ b/migration/ram.h<br>
@@ -86,7 +86,7 @@ void ram_postcopy_migrated_memory_release(MigrationState =
*ms);<br>
=C2=A0void ram_postcopy_send_discard_bitmap(MigrationState *ms);<br>
=C2=A0/* For incoming postcopy discard */<br>
=C2=A0int ram_discard_range(const char *block_name, uint64_t start, size_t =
length);<br>
-int ram_postcopy_incoming_init(MigrationIncomingState *mis);<br>
+int ram_postcopy_incoming_init(MigrationIncomingState *mis, Error **errp);=
<br>
=C2=A0int ram_load_postcopy(QEMUFile *f, int channel);<br>
<br>
=C2=A0void ram_handle_zero(void *host, uint64_t size);<br>
diff --git a/migration/savevm.c b/migration/savevm.c<br>
index 63cf488d9f411c0fb8d5f1bc8a719aa575bbabdc..60a055f3e1f248b09e5e5d721f1=
4d2eeafd0a7ad 100644<br>
--- a/migration/savevm.c<br>
+++ b/migration/savevm.c<br>
@@ -1989,7 +1989,7 @@ static int loadvm_postcopy_handle_advise(MigrationInc=
omingState *mis,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (ram_postcopy_incoming_init(mis)) {<br>
+=C2=A0 =C2=A0 if (ram_postcopy_incoming_init(mis, NULL) &lt; 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div>

--000000000000651ea6063afa5d98--


