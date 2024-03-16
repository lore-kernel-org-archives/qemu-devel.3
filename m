Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CD1C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 02:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlK1q-0005TD-6U; Fri, 15 Mar 2024 22:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rlK1m-0005Sq-UG
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 22:44:06 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rlK1j-0007RH-SQ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 22:44:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-29c16b324ecso2021594a91.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 19:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1710556919; x=1711161719;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YOcKztEoxB/B0JNCPgwBpmHvR7ZZL/kCEfSzQdhWoqc=;
 b=FTQdgU0Xt0XHa45/dekSob6XoRD6OUiXwlBYjzmFG9Ezw2+Zmksbu2zzB1BTSW2jlw
 N/L3A3pDq/ZJ444SAl+qgIGFBIFXYFBpCnfvZ8PRKX62BCYS1z/7OnrYILSea98vUPrg
 vsUYmAZKjpXdIkymLWr6Owu5O4zz3xpEVY5S8ZKpkvB8h4byviPuY/7hn/IwyravhIx6
 EJP/drb48EYtVxffc27rgwi/aNe7NYcQXkxy7rr3A2xuNhPjXKs2d80OEBBarn1CWZJ1
 bqckRvqjDC8/z3/fywnipWJ1BKSfnsihDO1RjsTZ3R34QdE5yq+nF8qUDB4JZ5BfyJR8
 ENVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710556919; x=1711161719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YOcKztEoxB/B0JNCPgwBpmHvR7ZZL/kCEfSzQdhWoqc=;
 b=PBodyMdRnXdwnQTlUKwxi1welfuJYDgTYpLNb5GkaS4fLNK6emERHGzXnPgCZPH//3
 dShqZTuo7nFRP8jqE/6VvnUj3fIHpFXUtNXWCIPGSQpZHjpD9KVNNdEXI121KJvY4pdz
 TUBFDeZEMpP/FuZlS7y/lslr5PXZk6/Han5TP4oPnXfGrlRU7/DOLQZF8ntFpuvCeKLL
 bWljoVHPRDQFaZEcndG62Di3xYKPj6wBEcWSa77+RUUN5XvK2FYTDwD7f87tgTu4KfGN
 pYyKxjc57+pRM6PA4A/aInvnLBKTi8XEk0KZnoNQTvcm87DZHHbzq8iLlVLCi/edyXVR
 0VjA==
X-Gm-Message-State: AOJu0Yye0Pr7DV+7zGegMlpE46tqM9F4rNWz0nBQFztnL0TsTmM7752G
 lFrJOGBYYNHkxL8v0xOJ4pXjEtm9szfEoymklAVfsh5YzTG5hOrJO2Iga+uU/hScFjqJIzLzrPf
 oODdlBr4gCMUCwV9dM57qfs4+CJHcy6Nhh2SyVA==
X-Google-Smtp-Source: AGHT+IFuCbC3e6v9P5wj1wE8a+emwp2vaGYdjKE0wSj4x8UEqf60jS7Kws0qKbfUqE9H2Z8lkxx3OTUJDeqWUtay9PM=
X-Received: by 2002:a17:90a:fb50:b0:29e:d30:5b2c with SMTP id
 iq16-20020a17090afb5000b0029e0d305b2cmr1550291pjb.18.1710556918719; Fri, 15
 Mar 2024 19:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-15-clg@redhat.com>
In-Reply-To: <20240306133441.2351700-15-clg@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Sat, 16 Mar 2024 10:41:42 +0800
Message-ID: <CAK9dgmb4fMb8VJ+ERenMrP_PbgjxxApzGfjJfkmE6w1aN2Y+gw@mail.gmail.com>
Subject: Re: [PATCH v4 14/25] memory: Add Error** argument to the
 global_dirty_log routines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008240d60613be1186"
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008240d60613be1186
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 9:35=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:

> Now that the log_global*() handlers take an Error** parameter and
> return a bool, do the same for memory_global_dirty_log_start() and
> memory_global_dirty_log_stop(). The error is reported in the callers
> for now and it will be propagated in the call stack in the next
> changes.


> To be noted a functional change in ram_init_bitmaps(), if the dirty
>
Hi, C=C3=A9dric Le Goater. Could the functional modification be made
separately from the patch? And my "Reviewed-by" is attached
to the first patch that refines memory_global_dirty_log_start's
function declaration.


> pages logger fails to start, there is no need to synchronize the dirty
> pages bitmaps. colo_incoming_start_dirty_log() could be modified in a
> similar way.
>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Hyman Huang <yong.huang@smartx.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>
>  Changes in v4:
>
>  - Dropped log_global_stop() and log_global_sync() changes
>
>  include/exec/memory.h |  5 ++++-
>  hw/i386/xen/xen-hvm.c |  2 +-
>  migration/dirtyrate.c | 13 +++++++++++--
>  migration/ram.c       | 22 ++++++++++++++++++++--
>  system/memory.c       | 11 +++++------
>  5 files changed, 41 insertions(+), 12 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index
> 5555567bc4c9fdb53e8f63487f1400980275687d..c129ee6db7162504bd72d4cfc69b5af=
fb2cd87e8
> 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2570,8 +2570,11 @@ void memory_listener_unregister(MemoryListener
> *listener);
>   * memory_global_dirty_log_start: begin dirty logging for all regions
>   *
>   * @flags: purpose of starting dirty log, migration or dirty rate
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Return: true on success, else false setting @errp with error.
>   */
> -void memory_global_dirty_log_start(unsigned int flags);
> +bool memory_global_dirty_log_start(unsigned int flags, Error **errp);
>
>  /**
>   * memory_global_dirty_log_stop: end dirty logging for all regions
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index
> 0608ca99f5166fd6379ee674442484e805eff9c0..57cb7df50788a6c31eff68c95e8eaa8=
56fdebede
> 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -654,7 +654,7 @@ void xen_hvm_modified_memory(ram_addr_t start,
> ram_addr_t length)
>  void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>  {
>      if (enable) {
> -        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>      } else {
>          memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
>      }
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index
> 1d2e85746fb7b10eb7f149976970f9a92125af8a..d02d70b7b4b86a29d4d5540ded41654=
3536d8f98
> 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -90,9 +90,15 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord
> dirty_pages,
>
>  void global_dirty_log_change(unsigned int flag, bool start)
>  {
> +    Error *local_err =3D NULL;
> +    bool ret;
> +
>      bql_lock();
>      if (start) {
> -        memory_global_dirty_log_start(flag);
> +        ret =3D memory_global_dirty_log_start(flag, &local_err);
> +        if (!ret) {
> +            error_report_err(local_err);
> +        }
>      } else {
>          memory_global_dirty_log_stop(flag);
>      }
> @@ -608,9 +614,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct
> DirtyRateConfig config)
>  {
>      int64_t start_time;
>      DirtyPageRecord dirty_pages;
> +    Error *local_err =3D NULL;
>
>      bql_lock();
> -    memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);
> +    if (!memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE,
> &local_err)) {
> +        error_report_err(local_err);
> +    }
>
>      /*
>       * 1'round of log sync may return all 1 bits with
> diff --git a/migration/ram.c b/migration/ram.c
> index
> c5149b7d717aefad7f590422af0ea4a40e7507be..397b4c0f218a66d194e44f9c5f9fe8e=
9885c48b6
> 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2836,18 +2836,31 @@ static void
> migration_bitmap_clear_discarded_pages(RAMState *rs)
>
>  static void ram_init_bitmaps(RAMState *rs)
>  {
> +    Error *local_err =3D NULL;
> +    bool ret =3D true;
> +
>      qemu_mutex_lock_ramlist();
>
>      WITH_RCU_READ_LOCK_GUARD() {
>          ram_list_init_bitmaps();
>          /* We don't use dirty log with background snapshots */
>          if (!migrate_background_snapshot()) {
> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +            ret =3D memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION=
,
> +                                                &local_err);
> +            if (!ret) {
> +                error_report_err(local_err);
> +                goto out_unlock;
> +            }
>              migration_bitmap_sync_precopy(rs, false);
>          }
>      }
> +out_unlock:
>      qemu_mutex_unlock_ramlist();
>
> +    if (!ret) {
> +        return;
> +    }
> +
>      /*
>       * After an eventual first bitmap sync, fixup the initial bitmap
>       * containing all 1s to exclude any discarded pages from migration.
> @@ -3631,6 +3644,8 @@ int colo_init_ram_cache(void)
>  void colo_incoming_start_dirty_log(void)
>  {
>      RAMBlock *block =3D NULL;
> +    Error *local_err =3D NULL;
> +
>      /* For memory_global_dirty_log_start below. */
>      bql_lock();
>      qemu_mutex_lock_ramlist();
> @@ -3642,7 +3657,10 @@ void colo_incoming_start_dirty_log(void)
>              /* Discard this dirty bitmap record */
>              bitmap_zero(block->bmap, block->max_length >>
> TARGET_PAGE_BITS);
>          }
> -        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +        if (!memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
> +                                           &local_err)) {
> +            error_report_err(local_err);
> +        }
>      }
>      ram_state->migration_dirty_pages =3D 0;
>      qemu_mutex_unlock_ramlist();
> diff --git a/system/memory.c b/system/memory.c
> index
> 3600e716149407c10a1f6bf8f0a81c2611cf15ba..cbc098216b789f50460f1d1bc7ec122=
030693d9e
> 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2931,10 +2931,9 @@ static void
> memory_global_dirty_log_rollback(MemoryListener *listener,
>      }
>  }
>
> -void memory_global_dirty_log_start(unsigned int flags)
> +bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
>  {
>      unsigned int old_flags;
> -    Error *local_err =3D NULL;
>
>      assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>
> @@ -2946,7 +2945,7 @@ void memory_global_dirty_log_start(unsigned int
> flags)
>
>      flags &=3D ~global_dirty_tracking;
>      if (!flags) {
> -        return;
> +        return true;
>      }
>
>      old_flags =3D global_dirty_tracking;
> @@ -2959,7 +2958,7 @@ void memory_global_dirty_log_start(unsigned int
> flags)
>
>          QTAILQ_FOREACH(listener, &memory_listeners, link) {
>              if (listener->log_global_start) {
> -                ret =3D listener->log_global_start(listener, &local_err)=
;
> +                ret =3D listener->log_global_start(listener, errp);
>                  if (!ret) {
>                      break;
>                  }
> @@ -2969,14 +2968,14 @@ void memory_global_dirty_log_start(unsigned int
> flags)
>          if (!ret) {
>              memory_global_dirty_log_rollback(QTAILQ_PREV(listener, link)=
,
>                                               flags);
> -            error_report_err(local_err);
> -            return;
> +            return false;
>          }
>
>          memory_region_transaction_begin();
>          memory_region_update_pending =3D true;
>          memory_region_transaction_commit();
>      }
> +    return true;
>  }
>
>  static void memory_global_dirty_log_do_stop(unsigned int flags)
> --
> 2.44.0
>
>

--=20
Best regards

--0000000000008240d60613be1186
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 6, 202=
4 at 9:35=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat=
.com">clg@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Now that the =
log_global*() handlers take an Error** parameter and<br>
return a bool, do the same for memory_global_dirty_log_start() and<br>
memory_global_dirty_log_stop(). The error is reported in the callers<br>
for now and it will be propagated in the call stack in the next<br>
changes.=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-le=
ft-color:rgb(204,204,204);padding-left:1ex">
<br>
To be noted a functional change in ram_init_bitmaps(), if the dirty<br></bl=
ockquote><div><font face=3D"comic sans ms, sans-serif">Hi,=C2=A0C=C3=A9dric=
 Le Goater. Could the functional modification be made=C2=A0</font></div><di=
v><font face=3D"comic sans ms, sans-serif">separately from the patch? <span=
 class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">And</span>=C2=A0my &quot;Reviewed-by&quot; is attached=C2=A0</font=
></div><div><font face=3D"comic sans ms, sans-serif">to the first patch tha=
t <span class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&qu=
ot;,sans-serif"></span>r<span class=3D"gmail_default" style=3D"font-family:=
&quot;comic sans ms&quot;,sans-serif">efines</span>=C2=A0memory_global_dirt=
y_log_start&#39;s=C2=A0</font></div><div><font face=3D"comic sans ms, sans-=
serif">function declaration.</font></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
pages logger fails to start, there is no need to synchronize the dirty<br>
pages bitmaps. colo_incoming_start_dirty_log() could be modified in a<br>
similar way.<br>
<br>
Cc: Stefano Stabellini &lt;<a href=3D"mailto:sstabellini@kernel.org" target=
=3D"_blank">sstabellini@kernel.org</a>&gt;<br>
Cc: Anthony Perard &lt;<a href=3D"mailto:anthony.perard@citrix.com" target=
=3D"_blank">anthony.perard@citrix.com</a>&gt;<br>
Cc: Paul Durrant &lt;<a href=3D"mailto:paul@xen.org" target=3D"_blank">paul=
@xen.org</a>&gt;<br>
Cc: &quot;Michael S. Tsirkin&quot; &lt;<a href=3D"mailto:mst@redhat.com" ta=
rget=3D"_blank">mst@redhat.com</a>&gt;<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: David Hildenbrand &lt;<a href=3D"mailto:david@redhat.com" target=3D"_bl=
ank">david@redhat.com</a>&gt;<br>
Cc: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_bla=
nk">yong.huang@smartx.com</a>&gt;<br>
Reviewed-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" targe=
t=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat.com" =
target=3D"_blank">clg@redhat.com</a>&gt;<br>
---<br>
<br>
=C2=A0Changes in v4:<br>
<br>
=C2=A0- Dropped log_global_stop() and log_global_sync() changes<br>
<br>
=C2=A0include/exec/memory.h |=C2=A0 5 ++++-<br>
=C2=A0hw/i386/xen/xen-hvm.c |=C2=A0 2 +-<br>
=C2=A0migration/dirtyrate.c | 13 +++++++++++--<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 22 ++++++++++++++++++++--=
<br>
=C2=A0system/memory.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++------<br>
=C2=A05 files changed, 41 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/include/exec/memory.h b/include/exec/memory.h<br>
index 5555567bc4c9fdb53e8f63487f1400980275687d..c129ee6db7162504bd72d4cfc69=
b5affb2cd87e8 100644<br>
--- a/include/exec/memory.h<br>
+++ b/include/exec/memory.h<br>
@@ -2570,8 +2570,11 @@ void memory_listener_unregister(MemoryListener *list=
ener);<br>
=C2=A0 * memory_global_dirty_log_start: begin dirty logging for all regions=
<br>
=C2=A0 *<br>
=C2=A0 * @flags: purpose of starting dirty log, migration or dirty rate<br>
+ * @errp: pointer to Error*, to store an error if it happens.<br>
+ *<br>
+ * Return: true on success, else false setting @errp with error.<br>
=C2=A0 */<br>
-void memory_global_dirty_log_start(unsigned int flags);<br>
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp);<br>
<br>
=C2=A0/**<br>
=C2=A0 * memory_global_dirty_log_stop: end dirty logging for all regions<br=
>
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c<br>
index 0608ca99f5166fd6379ee674442484e805eff9c0..57cb7df50788a6c31eff68c95e8=
eaa856fdebede 100644<br>
--- a/hw/i386/xen/xen-hvm.c<br>
+++ b/hw/i386/xen/xen-hvm.c<br>
@@ -654,7 +654,7 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr=
_t length)<br>
=C2=A0void qmp_xen_set_global_dirty_log(bool enable, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (enable) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(GLOBAL_DIRTY_MIG=
RATION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(GLOBAL_DIRTY_MIG=
RATION, errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_global_dirty_log_stop(GLOBAL_DIRTY=
_MIGRATION);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index 1d2e85746fb7b10eb7f149976970f9a92125af8a..d02d70b7b4b86a29d4d5540ded4=
16543536d8f98 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -90,9 +90,15 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord di=
rty_pages,<br>
<br>
=C2=A0void global_dirty_log_change(unsigned int flag, bool start)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 bool ret;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
=C2=A0 =C2=A0 =C2=A0if (start) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(flag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D memory_global_dirty_log_start(flag, &a=
mp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_global_dirty_log_stop(flag);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -608,9 +614,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct Di=
rtyRateConfig config)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t start_time;<br>
=C2=A0 =C2=A0 =C2=A0DirtyPageRecord dirty_pages;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
-=C2=A0 =C2=A0 memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE);<br>
+=C2=A0 =C2=A0 if (!memory_global_dirty_log_start(GLOBAL_DIRTY_DIRTY_RATE, =
&amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * 1&#39;round of log sync may return all 1 bits with<b=
r>
diff --git a/migration/ram.c b/migration/ram.c<br>
index c5149b7d717aefad7f590422af0ea4a40e7507be..397b4c0f218a66d194e44f9c5f9=
fe8e9885c48b6 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -2836,18 +2836,31 @@ static void migration_bitmap_clear_discarded_pages(=
RAMState *rs)<br>
<br>
=C2=A0static void ram_init_bitmaps(RAMState *rs)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 bool ret =3D true;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock_ramlist();<br>
<br>
=C2=A0 =C2=A0 =C2=A0WITH_RCU_READ_LOCK_GUARD() {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_list_init_bitmaps();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We don&#39;t use dirty log with backgr=
ound snapshots */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!migrate_background_snapshot()) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(GL=
OBAL_DIRTY_MIGRATION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D memory_global_dirty_log_=
start(GLOBAL_DIRTY_MIGRATION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(l=
ocal_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_unlock;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0migration_bitmap_sync_preco=
py(rs, false);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+out_unlock:<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock_ramlist();<br>
<br>
+=C2=A0 =C2=A0 if (!ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * After an eventual first bitmap sync, fixup the initi=
al bitmap<br>
=C2=A0 =C2=A0 =C2=A0 * containing all 1s to exclude any discarded pages fro=
m migration.<br>
@@ -3631,6 +3644,8 @@ int colo_init_ram_cache(void)<br>
=C2=A0void colo_incoming_start_dirty_log(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block =3D NULL;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* For memory_global_dirty_log_start below. */<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock_ramlist();<br>
@@ -3642,7 +3657,10 @@ void colo_incoming_start_dirty_log(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Discard this dirty bitma=
p record */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bitmap_zero(block-&gt;bmap,=
 block-&gt;max_length &gt;&gt; TARGET_PAGE_BITS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(GLOBAL_DIRTY_MIG=
RATION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!memory_global_dirty_log_start(GLOBAL_DIRT=
Y_MIGRATION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0ram_state-&gt;migration_dirty_pages =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock_ramlist();<br>
diff --git a/system/memory.c b/system/memory.c<br>
index 3600e716149407c10a1f6bf8f0a81c2611cf15ba..cbc098216b789f50460f1d1bc7e=
c122030693d9e 100644<br>
--- a/system/memory.c<br>
+++ b/system/memory.c<br>
@@ -2931,10 +2931,9 @@ static void memory_global_dirty_log_rollback(MemoryL=
istener *listener,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void memory_global_dirty_log_start(unsigned int flags)<br>
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0unsigned int old_flags;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(flags &amp;&amp; !(flags &amp; (~GLOBAL_DIRTY_MA=
SK)));<br>
<br>
@@ -2946,7 +2945,7 @@ void memory_global_dirty_log_start(unsigned int flags=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0flags &amp;=3D ~global_dirty_tracking;<br>
=C2=A0 =C2=A0 =C2=A0if (!flags) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0old_flags =3D global_dirty_tracking;<br>
@@ -2959,7 +2958,7 @@ void memory_global_dirty_log_start(unsigned int flags=
)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0QTAILQ_FOREACH(listener, &amp;memory_list=
eners, link) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (listener-&gt;log_global=
_start) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D listener-&=
gt;log_global_start(listener, &amp;local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D listener-&=
gt;log_global_start(listener, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -2969,14 +2968,14 @@ void memory_global_dirty_log_start(unsigned int fla=
gs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_global_dirty_log_rol=
lback(QTAILQ_PREV(listener, link),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_begin();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_update_pending =3D true;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_commit();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static void memory_global_dirty_log_do_stop(unsigned int flags)<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--0000000000008240d60613be1186--

