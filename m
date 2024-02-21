Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B4DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpBr-0005BH-55; Wed, 21 Feb 2024 11:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcpBn-00055I-PJ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:11:20 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcpBk-00027W-4U
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:11:19 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5112bd13a4fso8472657e87.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708531872; x=1709136672; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zMN+oUOOLZhM+tSS+L6arYfZ96GxryJlDKBVdt9sbOw=;
 b=Tv0L3zcYDZ/FdT4rNQFKeDpYhgZFKg5kxmP/DoXjkPmBjVw1pkehKsByQh+IWxOTeo
 Qp5OM4wp2MCgHUgCLp2dk9c6HaFku14PRu78xsC+FUSOXAY35aRVn8A6qSEFT4LIwOTd
 iRPKdCDGGlxXWq+bc+iAAR41gPnCdpvMGFj9Ok9vB2X1P8mFnrZ6HCHW8g7A8L2YX5tP
 op/VU+P7Am1UxeuTEeH+HZzIzMeP3d3t2Y+FNk1L3oiKN/4IpQq/xwEdep1DlpNEb9BW
 jhZ16qi2p4F2S+8Chyl7UTiwThP2j+VU95C1RiBlRusxAVEcTc5OGUVRCcSKnCFWIXsp
 ne7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531872; x=1709136672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zMN+oUOOLZhM+tSS+L6arYfZ96GxryJlDKBVdt9sbOw=;
 b=G28JMFWyMvs4bKVmZ5SOyars7Uly1sM/hp5Zwu6UaXGGLIKsxfjyQ4HqcNlI5rHG57
 U+ieGS7ISR87X9Wi1TzROW3y+oYLLYRy/F63LxBv1g/CYvd0NcQ4Rzmqj2NWW1gQsGbb
 /GeUIrIaR/aCBgrc+n5xaJX5Rn02md0hhAvf+M51y5/ao+kuX+fJlhZ/poLEkFxcvQu5
 BIA3TgZtn/EwfplYgqglrx5PAg8cNk01kkSarZxdDFAOJ1WGD5W91OiXewn7GXMoqCsx
 kWswm/n/mKJnxoPFeZ6u4KL/Go+8u8CMKFCrXJHXtYwwI8Gk9/nLYXKFmkU/fx7vCxa5
 FsAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZqIJ0pxCkg1A0l7xIdvLNo3ZWnH/95X6GIALuSUQJvMZ1sRyACCIeprurobT6hYrkWTTFdgKP2zE1XGcCWhWzJdc9i4U=
X-Gm-Message-State: AOJu0YyQju6z8nG9GXNjhx0N6dI/saPGFLNTZNWdYYpYMd+Jt/RVJsS/
 modacBrfp8I32mfUHVF15XtHygJUmsk6dz2ZlYaOC1oIRFyDEek5Fx+RsqjoIsT6DX8ldFwf5Ja
 Mdj7t4No0ulS+fZRTQRI4DzT3D0M=
X-Google-Smtp-Source: AGHT+IG2izzYio5yT2y9m3HH9fvkP7FM8IyoXWSMGrmMyiyPWW+V/+8aOIVkObZtzy72F6fXOu10cKDwCCDGLYwT85w=
X-Received: by 2002:ac2:446d:0:b0:512:bf09:9316 with SMTP id
 y13-20020ac2446d000000b00512bf099316mr2203485lfl.8.1708531872270; Wed, 21 Feb
 2024 08:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-5-hao.xiang@bytedance.com>
In-Reply-To: <20240216224002.1476890-5-hao.xiang@bytedance.com>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Wed, 21 Feb 2024 08:11:00 -0800
Message-ID: <CAEr7rXg5kZsUnDd8tcLu7Y4NmLrhWmu5bjh8KtAYnYubbHqbJA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] migration/multifd: Enable zero page checking from
 multifd threads.
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005590170611e693a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=ufimtseva@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000005590170611e693a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:42=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:

> This change adds a dedicated handler for
> MigrationOps::ram_save_target_page in
> multifd live migration. Now zero page checking can be done in the multifd
> threads
> and this becomes the default configuration. We still provide backward
> compatibility
> where zero page checking is done from the migration main thread.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/multifd.c |  1 +
>  migration/options.c |  2 +-
>  migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 42 insertions(+), 14 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index fbb40ea10b..ef5dad1019 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "qemu/rcu.h"
> +#include "qemu/cutils.h"
>  #include "exec/target_page.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/ramblock.h"
> diff --git a/migration/options.c b/migration/options.c
> index 3c603391b0..3c79b6ccd4 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -181,7 +181,7 @@ Property migration_properties[] =3D {
>                        MIG_MODE_NORMAL),
>      DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationStat=
e,
>                         parameters.zero_page_detection,
> -                       ZERO_PAGE_DETECTION_LEGACY),
> +                       ZERO_PAGE_DETECTION_MULTIFD),
>
>      /* Migration capabilities */
>      DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
> diff --git a/migration/ram.c b/migration/ram.c
> index 5ece9f042e..b088c5a98c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs,
> PageSearchStatus *pss,
>      QEMUFile *file =3D pss->pss_channel;
>      int len =3D 0;
>
> -    if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_LEGACY) {
> -        return 0;
> -    }
> -
>      if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
>          return 0;
>      }
> @@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs,
> PageSearchStatus *pss)
>
>  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>  {
> +    assert(migrate_multifd());
>
We only call ram_save_multifd_page() if:
 if (migrate_multifd()) {
        migration_ops->ram_save_target_page =3D ram_save_target_page_multif=
d;
So this assert is not needed.

+    assert(!migrate_compress());
>
+    assert(!migration_in_postcopy());
>
These two are redundant and done before we call in here.

+
>      if (!multifd_queue_page(block, offset)) {
>          return -1;
>      }
> @@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs,
> PageSearchStatus *pss,
>   */
>  static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus
> *pss)
>  {
> -    RAMBlock *block =3D pss->block;
>      ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>      int res;
>
> @@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState
> *rs, PageSearchStatus *pss)
>          return 1;
>      }
>
> +    return ram_save_page(rs, pss);
> +}
> +
> +/**
> + * ram_save_target_page_multifd: save one target page
> + *
> + * Returns the number of pages written
> + *
> + * @rs: current RAM state
> + * @pss: data about the page we want to send
> + */
> +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus
> *pss)
> +{
> +    RAMBlock *block =3D pss->block;
> +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> +
> +    /* Multifd is not compatible with old compression. */
> +    assert(!migrate_compress());
>
Do we need to check this for every page?


> +    /* Multifd is not compabible with postcopy. */
> +    assert(!migration_in_postcopy());
> +
>      /*
> -     * Do not use multifd in postcopy as one whole host page should be
> -     * placed.  Meanwhile postcopy requires atomic update of pages, so
> even
> -     * if host page size =3D=3D guest page size the dest guest during ru=
n may
> -     * still see partially copied pages which is data corruption.
> +     * Backward compatibility support. While using multifd live
> +     * migration, we still need to handle zero page checking on the
> +     * migration main thread.
>       */
> -    if (migrate_multifd() && !migration_in_postcopy()) {
> -        return ram_save_multifd_page(block, offset);
> +    if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION_LEGACY)=
 {
> +        if (save_zero_page(rs, pss, offset)) {
> +            return 1;
> +        }
>      }
>
> -    return ram_save_page(rs, pss);
> +    return ram_save_multifd_page(block, offset);
>  }
>
>  /* Should be called before sending a host page */
> @@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
>      }
>
>      migration_ops =3D g_malloc0(sizeof(MigrationOps));
> -    migration_ops->ram_save_target_page =3D ram_save_target_page_legacy;
> +
> +    if (migrate_multifd()) {
> +        migration_ops->ram_save_target_page =3D
> ram_save_target_page_multifd;
> +    } else {
> +        migration_ops->ram_save_target_page =3D ram_save_target_page_leg=
acy;
> +    }
>
>      bql_unlock();
>      ret =3D multifd_send_sync_main();
> --
> 2.30.2
>
>
>

--=20
Elena

--0000000000005590170611e693a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 16, 2024 at 2:42=E2=80=AF=
PM Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com">hao.xiang@byted=
ance.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">This change adds a dedicated handler for MigrationOps::ram_save_tar=
get_page in<br>
multifd live migration. Now zero page checking can be done in the multifd t=
hreads<br>
and this becomes the default configuration. We still provide backward compa=
tibility<br>
where zero page checking is done from the migration main thread.<br>
<br>
Signed-off-by: Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com" tar=
get=3D"_blank">hao.xiang@bytedance.com</a>&gt;<br>
---<br>
=C2=A0migration/multifd.c |=C2=A0 1 +<br>
=C2=A0migration/options.c |=C2=A0 2 +-<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0| 53 +++++++++++++++++++++++++++++=
+++++-----------<br>
=C2=A03 files changed, 42 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/migration/multifd.c b/migration/multifd.c<br>
index fbb40ea10b..ef5dad1019 100644<br>
--- a/migration/multifd.c<br>
+++ b/migration/multifd.c<br>
@@ -13,6 +13,7 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;qemu/rcu.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
=C2=A0#include &quot;exec/target_page.h&quot;<br>
=C2=A0#include &quot;sysemu/sysemu.h&quot;<br>
=C2=A0#include &quot;exec/ramblock.h&quot;<br>
diff --git a/migration/options.c b/migration/options.c<br>
index 3c603391b0..3c79b6ccd4 100644<br>
--- a/migration/options.c<br>
+++ b/migration/options.c<br>
@@ -181,7 +181,7 @@ Property migration_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIG_MODE_NORMAL),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_ZERO_PAGE_DETECTION(&quot;zero-page-detecti=
on&quot;, MigrationState,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 parameters.zero_page_detection,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ZERO_PAGE_DETECTION_LEGACY),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ZERO_PAGE_DETECTION_MULTIFD),<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Migration capabilities */<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_MIG_CAP(&quot;x-xbzrle&quot;, MIGRATION_CAP=
ABILITY_XBZRLE),<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 5ece9f042e..b088c5a98c 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSearchSt=
atus *pss,<br>
=C2=A0 =C2=A0 =C2=A0QEMUFile *file =3D pss-&gt;pss_channel;<br>
=C2=A0 =C2=A0 =C2=A0int len =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (migrate_zero_page_detection() !=3D ZERO_PAGE_DETECTION_L=
EGACY) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearchSta=
tus *pss)<br>
<br>
=C2=A0static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)<=
br>
=C2=A0{<br>
+=C2=A0 =C2=A0 assert(migrate_multifd());<br></blockquote><div>We only call=
 ram_save_multifd_page() if:</div><div>=C2=A0if (migrate_multifd()) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_ops-&gt;ram_save_target_page =3D ram_=
save_target_page_multifd;</div><div>So this assert is not needed.<br></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 assert(!migrate_compress());<br></blockquote><div></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 assert(!migration_in_postcopy());<br></blockquote><div>These=
 two are redundant and done before we call in here. <br></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0if (!multifd_queue_page(block, offset)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, PageSear=
chStatus *pss,<br>
=C2=A0 */<br>
=C2=A0static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus=
 *pss)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 RAMBlock *block =3D pss-&gt;block;<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t offset =3D ((ram_addr_t)pss-&gt;page) &lt;&l=
t; TARGET_PAGE_BITS;<br>
=C2=A0 =C2=A0 =C2=A0int res;<br>
<br>
@@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState *rs=
, PageSearchStatus *pss)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 return ram_save_page(rs, pss);<br>
+}<br>
+<br>
+/**<br>
+ * ram_save_target_page_multifd: save one target page<br>
+ *<br>
+ * Returns the number of pages written<br>
+ *<br>
+ * @rs: current RAM state<br>
+ * @pss: data about the page we want to send<br>
+ */<br>
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *ps=
s)<br>
+{<br>
+=C2=A0 =C2=A0 RAMBlock *block =3D pss-&gt;block;<br>
+=C2=A0 =C2=A0 ram_addr_t offset =3D ((ram_addr_t)pss-&gt;page) &lt;&lt; TA=
RGET_PAGE_BITS;<br>
+<br>
+=C2=A0 =C2=A0 /* Multifd is not compatible with old compression. */<br>
+=C2=A0 =C2=A0 assert(!migrate_compress());<br></blockquote><div></div><div=
>Do we need to check this for every page? <br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 /* Multifd is not compabible with postcopy. */<br>
+=C2=A0 =C2=A0 assert(!migration_in_postcopy());<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0* Do not use multifd in postcopy as one whole host pag=
e should be<br>
-=C2=A0 =C2=A0 =C2=A0* placed.=C2=A0 Meanwhile postcopy requires atomic upd=
ate of pages, so even<br>
-=C2=A0 =C2=A0 =C2=A0* if host page size =3D=3D guest page size the dest gu=
est during run may<br>
-=C2=A0 =C2=A0 =C2=A0* still see partially copied pages which is data corru=
ption.<br>
+=C2=A0 =C2=A0 =C2=A0* Backward compatibility support. While using multifd =
live<br>
+=C2=A0 =C2=A0 =C2=A0* migration, we still need to handle zero page checkin=
g on the<br>
+=C2=A0 =C2=A0 =C2=A0* migration main thread.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if (migrate_multifd() &amp;&amp; !migration_in_postcopy()) {=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ram_save_multifd_page(block, offset);<b=
r>
+=C2=A0 =C2=A0 if (migrate_zero_page_detection() =3D=3D ZERO_PAGE_DETECTION=
_LEGACY) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (save_zero_page(rs, pss, offset)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 return ram_save_page(rs, pss);<br>
+=C2=A0 =C2=A0 return ram_save_multifd_page(block, offset);<br>
=C2=A0}<br>
<br>
=C2=A0/* Should be called before sending a host page */<br>
@@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0migration_ops =3D g_malloc0(sizeof(MigrationOps));<br>
-=C2=A0 =C2=A0 migration_ops-&gt;ram_save_target_page =3D ram_save_target_p=
age_legacy;<br>
+<br>
+=C2=A0 =C2=A0 if (migrate_multifd()) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_ops-&gt;ram_save_target_page =3D ram=
_save_target_page_multifd;<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 migration_ops-&gt;ram_save_target_page =3D ram=
_save_target_page_legacy;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
=C2=A0 =C2=A0 =C2=A0ret =3D multifd_send_sync_main();<br>
-- <br>
2.30.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Elena</div></=
div>

--0000000000005590170611e693a0--

