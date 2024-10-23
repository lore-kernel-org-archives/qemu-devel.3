Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB727CFA45D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fyy-0008Dm-FS; Wed, 23 Oct 2024 14:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t3fyw-0008DP-Qn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t3fyu-0006kn-9j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729707672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrX4l1+IzJtrYQlBMvB1b9jz8jXk0UjhyvitdTYiy4A=;
 b=cxd81vUuPbpCNjNHbeterjbfsHqFU8KUqarswYQ/sAiP7JVLykus0/KVi6APQmdmhHSd2F
 XkgaotxvBgeaDlRH9zvfDHn1RIh5hENu0SL0F6Cv9YjTmdXLbR3MER/1QIpYtgGTzuHnmW
 hQIKRDNyzYIb+ZI1Piyc8Kwr80+sdlA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-_W8is7G8MhWd42ciImeXAA-1; Wed, 23 Oct 2024 14:20:04 -0400
X-MC-Unique: _W8is7G8MhWd42ciImeXAA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-71e71425193so185538b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729707602; x=1730312402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IrX4l1+IzJtrYQlBMvB1b9jz8jXk0UjhyvitdTYiy4A=;
 b=q0bnb2xNEE3Z0zu/9B0J8+tHlvks4FylNq7e5cVuyufyi63narxGutOpULfwF71PNN
 ybee2LCxQHEoVe5848wtSzAmlhQ1aAc9QGwrAog1AiX2Aym8etAM6m5UD8rRn+32zI+z
 2LUl2CoiXrfAkr3PgFLeHc0hC8aOAajGRTuTA3LHDtEHbKyx7GsjHSJjJJgci5WDXTkF
 WU/z9U3MZXAcmRKNOpt4mdV+Ze9E7M3InB8WHMdKn8dAJF0Ou5B16pze3pLOEgtYG2aW
 NOPoPsmWajIYaqXQtve8yCQEkncRGdIAYKh617zWuSGUmJ5JyeYx5dI26vrhuZIXT0Ax
 o+ig==
X-Gm-Message-State: AOJu0YxtHnjRl6fcoRB0a4pukfXvvxBaYxJ6zbiADL8GoHqRk/gXkM7V
 MqzldjZSECo3ybGTwnuOnB/lf74/YpFvyMD6+TNs3oWjlRd1n8B+sdkSAA1bLmzJuHZ8riz7lQp
 oBn9gvI1K4VMjrKIVHQWxU8hmkMNwCZxtP73PHXhoFZxMi6+WTjfl4/g9VjohHWT++m2cTyfK5j
 0yp7B6SgKAtY7OmKp6VXLe7t0jhAJyX8BOpNU=
X-Received: by 2002:a05:6a00:4b10:b0:71e:5d1d:1aa7 with SMTP id
 d2e1a72fcca58-72030b936e6mr4746359b3a.17.1729707602143; 
 Wed, 23 Oct 2024 11:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR7feLLDbd7CSt4ixWoDvHiOTI4KfBIZWf27rEHcp6+zAY9FNO+Rdb1QsHmqx5KaB0OcbQLmKFQY0nhi7OuY0=
X-Received: by 2002:a05:6a00:4b10:b0:71e:5d1d:1aa7 with SMTP id
 d2e1a72fcca58-72030b936e6mr4746316b3a.17.1729707601608; Wed, 23 Oct 2024
 11:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241023180216.1072575-1-peterx@redhat.com>
 <20241023180216.1072575-5-peterx@redhat.com>
In-Reply-To: <20241023180216.1072575-5-peterx@redhat.com>
From: Peter Xu <peterx@redhat.com>
Date: Wed, 23 Oct 2024 14:19:48 -0400
Message-ID: <CADLectmmnEj9e0OrFECkP2bTCcwJU_c9MKpzDYJ+qcwyz4xAZQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] migration: Make all helpers in misc.h safe to use
 without migration
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Content-Type: multipart/alternative; boundary="00000000000028dffd062528ef93"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

--00000000000028dffd062528ef93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024, 2:02=E2=80=AFp.m. Peter Xu <peterx@redhat.com> wrote:

> Migration object can be freed (e.g. after migration_shutdown()) before so=
me
> other device codes can still run, while we do have a bunch of migration
> helpers exported in migration/misc.h that logically can be invoked at any
> time of QEMU, even during destruction of a VM.
>
> Make all these functions safe to be called, especially, not crashing afte=
r
> the migration object is unreferenced from the main context.
>
> To achieve it, only reference global_migration variable in the exported
> functions.  The variable is only reset with BQL, so it's safe to access.
>
> Add a comment in the header explaining how to guarantee thread safe on
> using these functions, and we choose BQL because fundamentally that's how
> it's working now.  We can move to other things (e.g. RCU) whenever
> necessary in the future but it's an overkill if we have BQL anyway in
> most/all existing callers.
>
> When at it, update some comments, e.g. migrate_announce_params() is
> exported from options.c now.
>

Err I wrongly fetched the list email then lost my local English fix with
s/when/while/.  I'll make sure it's fixed ultimately when repost.


> Cc: C=C3=A9dric Le Goater <clg@redhat.com>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/misc.h | 26 +++++++++++++++++++++-----
>  migration/migration.c    | 32 ++++++++++++++++++++++++++------
>  2 files changed, 47 insertions(+), 11 deletions(-)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index df57be6b5e..48892f9672 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -19,8 +19,19 @@
>  #include "qapi/qapi-types-net.h"
>  #include "migration/client-options.h"
>
> -/* migration/ram.c */
> +/*
> + * Misc migration functions exported to be used in QEMU generic system
> + * code outside migration/.
> + *
> + * By default, BQL is recommended before using below functions to avoid
> + * race conditions (concurrent updates to global_migration variable).
> It's
> + * caller's responsibility to make sure it's thread safe otherwise when
> + * below helpers are used without BQL held.  When unsure, take BQL alway=
s.
> + */
>
> +/*
> + * migration/ram.c
> + */
>  typedef enum PrecopyNotifyReason {
>      PRECOPY_NOTIFY_SETUP =3D 0,
>      PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC =3D 1,
> @@ -43,14 +54,19 @@ void ram_mig_init(void);
>  void qemu_guest_free_page_hint(void *addr, size_t len);
>  bool migrate_ram_is_ignored(RAMBlock *block);
>
> -/* migration/block.c */
> -
> +/*
> + * migration/options.c
> + */
>  AnnounceParameters *migrate_announce_params(void);
> -/* migration/savevm.c */
>
> +/*
> + * migration/savevm.c
> + */
>  void dump_vmstate_json_to_file(FILE *out_fp);
>
> -/* migration/migration.c */
> +/*
> + * migration/migration.c
> + */
>  void migration_object_init(void);
>  void migration_shutdown(void);
>  bool migration_is_idle(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index c4adad7972..667816cc65 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1157,7 +1157,11 @@ void
> migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
>   */
>  bool migration_is_setup_or_active(void)
>  {
> -    MigrationState *s =3D current_migration;
> +    MigrationState *s =3D global_migration;
> +
> +    if (!s) {
> +        return false;
> +    }
>
>      switch (s->state) {
>      case MIGRATION_STATUS_ACTIVE:
> @@ -1174,7 +1178,6 @@ bool migration_is_setup_or_active(void)
>
>      default:
>          return false;
> -
>      }
>  }
>
> @@ -1721,7 +1724,11 @@ bool migration_is_idle(void)
>
>  bool migration_is_active(void)
>  {
> -    MigrationState *s =3D current_migration;
> +    MigrationState *s =3D global_migration;
> +
> +    if (!s) {
> +        return false;
> +    }
>
>      return (s->state =3D=3D MIGRATION_STATUS_ACTIVE ||
>              s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
> @@ -1729,14 +1736,23 @@ bool migration_is_active(void)
>
>  bool migration_is_device(void)
>  {
> -    MigrationState *s =3D current_migration;
> +    MigrationState *s =3D global_migration;
> +
> +    if (!s) {
> +        return false;
> +    }
>
>      return s->state =3D=3D MIGRATION_STATUS_DEVICE;
>  }
>
>  bool migration_thread_is_self(void)
>  {
> -    MigrationState *s =3D current_migration;
> +    MigrationState *s =3D global_migration;
> +
> +    /* If no migration object, must not be the migration thread */
> +    if (!s) {
> +        return false;
> +    }
>
>      return qemu_thread_is_self(&s->thread);
>  }
> @@ -3113,7 +3129,11 @@ static MigThrError postcopy_pause(MigrationState *=
s)
>
>  void migration_file_set_error(int ret, Error *err)
>  {
> -    MigrationState *s =3D current_migration;
> +    MigrationState *s =3D global_migration;
> +
> +    if (!s) {
> +        return;
> +    }
>
>      WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>          if (s->to_dst_file) {
> --
> 2.45.0
>
>

--00000000000028dffd062528ef93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 23, 2024, 2:02=E2=80=AFp.m. Peter Xu &lt;<=
a href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Migration object can be freed (e.g. after=
 migration_shutdown()) before some<br>
other device codes can still run, while we do have a bunch of migration<br>
helpers exported in migration/misc.h that logically can be invoked at any<b=
r>
time of QEMU, even during destruction of a VM.<br>
<br>
Make all these functions safe to be called, especially, not crashing after<=
br>
the migration object is unreferenced from the main context.<br>
<br>
To achieve it, only reference global_migration variable in the exported<br>
functions.=C2=A0 The variable is only reset with BQL, so it&#39;s safe to a=
ccess.<br>
<br>
Add a comment in the header explaining how to guarantee thread safe on<br>
using these functions, and we choose BQL because fundamentally that&#39;s h=
ow<br>
it&#39;s working now.=C2=A0 We can move to other things (e.g. RCU) whenever=
<br>
necessary in the future but it&#39;s an overkill if we have BQL anyway in<b=
r>
most/all existing callers.<br>
<br>
When at it, update some comments, e.g. migrate_announce_params() is<br>
exported from options.c now.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Err I wrongly fetched the list email then lost =
my local English fix with s/when/while/.=C2=A0 I&#39;ll make sure it&#39;s =
fixed ultimately when repost.=C2=A0</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Cc: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat.com" target=3D"_=
blank" rel=3D"noreferrer">clg@redhat.com</a>&gt;<br>
Cc: Avihai Horon &lt;<a href=3D"mailto:avihaih@nvidia.com" target=3D"_blank=
" rel=3D"noreferrer">avihaih@nvidia.com</a>&gt;<br>
Cc: Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D"_blank" =
rel=3D"noreferrer">farosas@suse.de</a>&gt;<br>
Cc: Dr. David Alan Gilbert &lt;<a href=3D"mailto:dave@treblig.org" target=
=3D"_blank" rel=3D"noreferrer">dave@treblig.org</a>&gt;<br>
Signed-off-by: Peter Xu &lt;<a href=3D"mailto:peterx@redhat.com" target=3D"=
_blank" rel=3D"noreferrer">peterx@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/migration/misc.h | 26 +++++++++++++++++++++-----<br>
=C2=A0migration/migration.c=C2=A0 =C2=A0 | 32 ++++++++++++++++++++++++++---=
---<br>
=C2=A02 files changed, 47 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/include/migration/misc.h b/include/migration/misc.h<br>
index df57be6b5e..48892f9672 100644<br>
--- a/include/migration/misc.h<br>
+++ b/include/migration/misc.h<br>
@@ -19,8 +19,19 @@<br>
=C2=A0#include &quot;qapi/qapi-types-net.h&quot;<br>
=C2=A0#include &quot;migration/client-options.h&quot;<br>
<br>
-/* migration/ram.c */<br>
+/*<br>
+ * Misc migration functions exported to be used in QEMU generic system<br>
+ * code outside migration/.<br>
+ *<br>
+ * By default, BQL is recommended before using below functions to avoid<br=
>
+ * race conditions (concurrent updates to global_migration variable).=C2=
=A0 It&#39;s<br>
+ * caller&#39;s responsibility to make sure it&#39;s thread safe otherwise=
 when<br>
+ * below helpers are used without BQL held.=C2=A0 When unsure, take BQL al=
ways.<br>
+ */<br>
<br>
+/*<br>
+ * migration/ram.c<br>
+ */<br>
=C2=A0typedef enum PrecopyNotifyReason {<br>
=C2=A0 =C2=A0 =C2=A0PRECOPY_NOTIFY_SETUP =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC =3D 1,<br>
@@ -43,14 +54,19 @@ void ram_mig_init(void);<br>
=C2=A0void qemu_guest_free_page_hint(void *addr, size_t len);<br>
=C2=A0bool migrate_ram_is_ignored(RAMBlock *block);<br>
<br>
-/* migration/block.c */<br>
-<br>
+/*<br>
+ * migration/options.c<br>
+ */<br>
=C2=A0AnnounceParameters *migrate_announce_params(void);<br>
-/* migration/savevm.c */<br>
<br>
+/*<br>
+ * migration/savevm.c<br>
+ */<br>
=C2=A0void dump_vmstate_json_to_file(FILE *out_fp);<br>
<br>
-/* migration/migration.c */<br>
+/*<br>
+ * migration/migration.c<br>
+ */<br>
=C2=A0void migration_object_init(void);<br>
=C2=A0void migration_shutdown(void);<br>
=C2=A0bool migration_is_idle(void);<br>
diff --git a/migration/migration.c b/migration/migration.c<br>
index c4adad7972..667816cc65 100644<br>
--- a/migration/migration.c<br>
+++ b/migration/migration.c<br>
@@ -1157,7 +1157,11 @@ void migrate_send_rp_resume_ack(MigrationIncomingSta=
te *mis, uint32_t value)<br>
=C2=A0 */<br>
=C2=A0bool migration_is_setup_or_active(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 MigrationState *s =3D current_migration;<br>
+=C2=A0 =C2=A0 MigrationState *s =3D global_migration;<br>
+<br>
+=C2=A0 =C2=A0 if (!s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (s-&gt;state) {<br>
=C2=A0 =C2=A0 =C2=A0case MIGRATION_STATUS_ACTIVE:<br>
@@ -1174,7 +1178,6 @@ bool migration_is_setup_or_active(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -1721,7 +1724,11 @@ bool migration_is_idle(void)<br>
<br>
=C2=A0bool migration_is_active(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 MigrationState *s =3D current_migration;<br>
+=C2=A0 =C2=A0 MigrationState *s =3D global_migration;<br>
+<br>
+=C2=A0 =C2=A0 if (!s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return (s-&gt;state =3D=3D MIGRATION_STATUS_ACTIVE ||<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;state =3D=3D MIGRATIO=
N_STATUS_POSTCOPY_ACTIVE);<br>
@@ -1729,14 +1736,23 @@ bool migration_is_active(void)<br>
<br>
=C2=A0bool migration_is_device(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 MigrationState *s =3D current_migration;<br>
+=C2=A0 =C2=A0 MigrationState *s =3D global_migration;<br>
+<br>
+=C2=A0 =C2=A0 if (!s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return s-&gt;state =3D=3D MIGRATION_STATUS_DEVICE;<br>
=C2=A0}<br>
<br>
=C2=A0bool migration_thread_is_self(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 MigrationState *s =3D current_migration;<br>
+=C2=A0 =C2=A0 MigrationState *s =3D global_migration;<br>
+<br>
+=C2=A0 =C2=A0 /* If no migration object, must not be the migration thread =
*/<br>
+=C2=A0 =C2=A0 if (!s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0return qemu_thread_is_self(&amp;s-&gt;thread);<br>
=C2=A0}<br>
@@ -3113,7 +3129,11 @@ static MigThrError postcopy_pause(MigrationState *s)=
<br>
<br>
=C2=A0void migration_file_set_error(int ret, Error *err)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 MigrationState *s =3D current_migration;<br>
+=C2=A0 =C2=A0 MigrationState *s =3D global_migration;<br>
+<br>
+=C2=A0 =C2=A0 if (!s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0WITH_QEMU_LOCK_GUARD(&amp;s-&gt;qemu_file_lock) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;to_dst_file) {<br>
-- <br>
2.45.0<br>
<br>
</blockquote></div></div></div>

--00000000000028dffd062528ef93--


