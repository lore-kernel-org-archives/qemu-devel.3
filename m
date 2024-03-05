Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C53C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 02:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhK6y-0004KS-T0; Mon, 04 Mar 2024 21:00:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rhK6t-0004K3-IL
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 21:00:53 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rhK6q-0000IA-0T
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 21:00:51 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so4577976a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 17:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1709603924; x=1710208724;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZNLz+dK8IGg+jX1DCRAwUdi5mlqUOLSPK68cPSrWVE=;
 b=beDXWDsPTq1hNFSZr8dhzFVF84vZ9zBHKk/YP5XTDbbxFzKKTaCMcv4FK+0feCAN5W
 5rhom5XTXxDdD7o1f0wCK9rbCbSpTS4k5SONKHyVfQtQU6onC+JSZZO+KttkHtML1nml
 h1n3dWlfXqk0tJ4eun//p596ctkm2bv0sYvnl4dqhdUxMcdgjjtwEfLFr36KUoI2c7cg
 ng9xATeIpAt6aheFfutzaGCo13XdAKrlzZrTS2FMQLKlKbpqoQuPZ0Qqd+t44xE6CmPf
 jw8+g2czM53yC8nVB9WkOWwgw+8oq775f5MmSBETRNBXCUKMVrmchyi1NpHmVqYSnoZE
 MYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709603924; x=1710208724;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZNLz+dK8IGg+jX1DCRAwUdi5mlqUOLSPK68cPSrWVE=;
 b=GyMqm6hC3USYSUnyY2zJ63S8inLnK3PL1O09653e89CUoCqUjmWz3clkJgruLNZzCu
 bwaB1wX8SiSdE70IX6PIm45BhZxUiPgBlYlzW0ceq76/0ntdG4zVmEIKfLoHbjQw74sz
 /WXuM9hSPMzgf5eG6VI/x8/TxwJu401Hxd7d7qcSkKJDXE/uUQfFxAy5KQCowTIqprm1
 olUOfAdtXIJThmk/SpfNe0OyQ959+fi06ii69iTidMjpB2YxqoLX2wYDTIyJpd3Oi2LS
 1U4uDUxb+0zI7QwIvvfr+/cRVFuOq/1G0+3ANZmgPrSFMAbD1S+yCBJ/Pq6C9TZSyZMN
 0mtw==
X-Gm-Message-State: AOJu0YxvBvsxdg+lJNRSdmNbhIed1L0jemvEGe5qEk6hUOytPCpZGS+p
 y6nriYQFxC6ktptZ1oYHesdGF+y91o1ZSQMjSYp3xrEq9aMc1i2m8sC1ME5DRvrcdYUX858rdwu
 Y1JiEsouRYl0P+jZnnoZVc2FjiXn8pDxmoQh8/3Ej0k/kGo7gL+hMCQ==
X-Google-Smtp-Source: AGHT+IFMTavbpQJhfB+v6dbPIVZXSnKKhbsnKvNAf87CB6qXaZ+JQbuyURyZXOY84QG1X/wfuqhrWoKnKX/GTqDXt3k=
X-Received: by 2002:a05:6a20:b90a:b0:1a1:4d43:f15c with SMTP id
 fe10-20020a056a20b90a00b001a14d43f15cmr358000pzb.47.1709603921910; Mon, 04
 Mar 2024 17:58:41 -0800 (PST)
MIME-Version: 1.0
References: <20240304122844.1888308-1-clg@redhat.com>
 <20240304122844.1888308-16-clg@redhat.com>
In-Reply-To: <20240304122844.1888308-16-clg@redhat.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 5 Mar 2024 09:58:25 +0800
Message-ID: <CAK9dgmZ8sr6WJ4_BN7=jANbA969dd+=5abibxm5CbmU8FvbuKQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/26] memory: Add Error** argument to the
 global_dirty_log routines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex.williamson@redhat.com>, 
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000078fdb10612e02ea2"
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52f.google.com
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

--00000000000078fdb10612e02ea2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 8:29=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:

> Now that the log_global*() handlers take an Error** parameter and
> return a bool, do the same for memory_global_dirty_log_start() and
> memory_global_dirty_log_stop(). The error is reported in the callers
> for now and it will be propagated in the call stack in the next
> changes.
>
> To be noted a functional change in ram_init_bitmaps(), if the dirty
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
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/exec/memory.h | 10 ++++++++--
>  hw/i386/xen/xen-hvm.c |  4 ++--
>  migration/dirtyrate.c | 21 +++++++++++++++++----
>  migration/ram.c       | 34 ++++++++++++++++++++++++++++++----
>  system/memory.c       | 30 ++++++++++++------------------
>  5 files changed, 69 insertions(+), 30 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index
> 4bc146c5ebdd377cd14a4e462f32cc945db5a0a8..8b019465ab13ce85c03075c80865a08=
65ea1feed
> 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2576,15 +2576,21 @@ void memory_listener_unregister(MemoryListener
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
>   *
>   * @flags: purpose of stopping dirty log, migration or dirty rate
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Return: true on success, else false setting @errp with error.
>   */
> -void memory_global_dirty_log_stop(unsigned int flags);
> +bool memory_global_dirty_log_stop(unsigned int flags, Error **errp);
>
>  void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool
> disabled);
>
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index
> 925a207b494b4eed52d5f360b554f18ac8a9806d..286269b47572d90e57df5ff44835bb5=
f8e16c7ad
> 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -655,9 +655,9 @@ void xen_hvm_modified_memory(ram_addr_t start,
> ram_addr_t length)
>  void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
>  {
>      if (enable) {
> -        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
> +        memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>      } else {
> -        memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
> +        memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION, errp);
>      }
>  }
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index
> 1d2e85746fb7b10eb7f149976970f9a92125af8a..34f6d803ff5f4e6ccf2e06aaaed65a3=
36c4be469
> 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -90,11 +90,17 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord
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
>      } else {
> -        memory_global_dirty_log_stop(flag);
> +        ret =3D memory_global_dirty_log_stop(flag, &local_err);
> +    }
> +    if (!ret) {
> +        error_report_err(local_err);
>      }
>      bql_unlock();
>  }
> @@ -106,10 +112,14 @@ void global_dirty_log_change(unsigned int flag, boo=
l
> start)
>   */
>  static void global_dirty_log_sync(unsigned int flag, bool one_shot)
>  {
> +    Error *local_err =3D NULL;
> +
>      bql_lock();
>      memory_global_dirty_log_sync(false);
>      if (one_shot) {
> -        memory_global_dirty_log_stop(flag);
> +        if (!memory_global_dirty_log_stop(flag, &local_err)) {
> +            error_report_err(local_err);
> +        }
>      }
>      bql_unlock();
>  }
> @@ -608,9 +618,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct
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
> 20c6ad9e759b2b8ec7ae26b7ca72d5cbd20d481f..3d9c08cfae8a59031a7c1b3c70721c2=
a90daceba
> 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2390,6 +2390,7 @@ static void ram_save_cleanup(void *opaque)
>  {
>      RAMState **rsp =3D opaque;
>      RAMBlock *block;
> +    Error *local_err =3D NULL;
>
>      /* We don't use dirty log with background snapshots */
>      if (!migrate_background_snapshot()) {
> @@ -2402,7 +2403,10 @@ static void ram_save_cleanup(void *opaque)
>               * memory_global_dirty_log_stop will assert that
>               * memory_global_dirty_log_start/stop used in pairs
>               */
> -            memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
> +            if (!memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION,
> +                                              &local_err)) {
> +                error_report_err(local_err);
> +            }
>          }
>      }
>
> @@ -2799,18 +2803,31 @@ static void
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
> @@ -3459,6 +3476,8 @@ int colo_init_ram_cache(void)
>  void colo_incoming_start_dirty_log(void)
>  {
>      RAMBlock *block =3D NULL;
> +    Error *local_err =3D NULL;
> +
>      /* For memory_global_dirty_log_start below. */
>      bql_lock();
>      qemu_mutex_lock_ramlist();
> @@ -3470,7 +3489,10 @@ void colo_incoming_start_dirty_log(void)
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
> @@ -3481,8 +3503,12 @@ void colo_incoming_start_dirty_log(void)
>  void colo_release_ram_cache(void)
>  {
>      RAMBlock *block;
> +    Error *local_err =3D NULL;
> +
> +    if (!memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION,
> &local_err)) {
> +        error_report_err(local_err);
> +    }
>
> -    memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);
>      RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>          g_free(block->bmap);
>          block->bmap =3D NULL;
> diff --git a/system/memory.c b/system/memory.c
> index
> af06157ead5b1272548e87f79ab9fb3036055328..48aed0f8ece1c731849636c442b8ab8=
e5d7ff6a5
> 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2949,25 +2949,24 @@ static unsigned int postponed_stop_flags;
>  static VMChangeStateEntry *vmstate_change;
>  static bool memory_global_dirty_log_stop_postponed_run(Error **errp);
>
> -void memory_global_dirty_log_start(unsigned int flags)
> +bool memory_global_dirty_log_start(unsigned int flags, Error **errp)
>  {
> +    ERRP_GUARD();
>      unsigned int old_flags;
> -    Error *local_err =3D NULL;
>
>      assert(flags && !(flags & (~GLOBAL_DIRTY_MASK)));
>
>      if (vmstate_change) {
>          /* If there is postponed stop(), operate on it first */
>          postponed_stop_flags &=3D ~flags;
> -        if (!memory_global_dirty_log_stop_postponed_run(&local_err)) {
> -            error_report_err(local_err);
> -            return;
> +        if (!memory_global_dirty_log_stop_postponed_run(errp)) {
> +            return false;
>          }
>      }
>
>      flags &=3D ~global_dirty_tracking;
>      if (!flags) {
> -        return;
> +        return true;
>      }
>
>      old_flags =3D global_dirty_tracking;
> @@ -2975,16 +2974,15 @@ void memory_global_dirty_log_start(unsigned int
> flags)
>      trace_global_dirty_changed(global_dirty_tracking);
>
>      if (!old_flags) {
> -        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward,
> -                                        &local_err);
> -        if (local_err) {
> -            error_report_err(local_err);
> -            return;
> +        MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_start, Forward, errp)=
;
> +        if (*errp) {
> +            return false;
>          }
>          memory_region_transaction_begin();
>          memory_region_update_pending =3D true;
>          memory_region_transaction_commit();
>      }
> +    return true;
>  }
>
>  static bool memory_global_dirty_log_do_stop(unsigned int flags, Error
> **errp)
> @@ -3040,10 +3038,8 @@ static void memory_vm_change_state_handler(void
> *opaque, bool running,
>      }
>  }
>
> -void memory_global_dirty_log_stop(unsigned int flags)
> +bool memory_global_dirty_log_stop(unsigned int flags, Error **errp)
>  {
> -    Error *local_err =3D NULL;
> -
>      if (!runstate_is_running()) {
>          /* Postpone the dirty log stop, e.g., to when VM starts again */
>          if (vmstate_change) {
> @@ -3054,12 +3050,10 @@ void memory_global_dirty_log_stop(unsigned int
> flags)
>              vmstate_change =3D qemu_add_vm_change_state_handler(
>                  memory_vm_change_state_handler, NULL);
>          }
> -        return;
> +        return true;
>      }
>
> -    if (!memory_global_dirty_log_do_stop(flags, &local_err)) {
> -        error_report_err(local_err);
> -    }
> +    return memory_global_dirty_log_do_stop(flags, errp);
>  }
>
>  static void listener_add_address_space(MemoryListener *listener,
> --
> 2.44.0
>
>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>

--=20
Best regards

--00000000000078fdb10612e02ea2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 4, 202=
4 at 8:29=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat=
.com">clg@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Now that the =
log_global*() handlers take an Error** parameter and<br>
return a bool, do the same for memory_global_dirty_log_start() and<br>
memory_global_dirty_log_stop(). The error is reported in the callers<br>
for now and it will be propagated in the call stack in the next<br>
changes.<br>
<br>
To be noted a functional change in ram_init_bitmaps(), if the dirty<br>
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
Signed-off-by: C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@redhat.com" =
target=3D"_blank">clg@redhat.com</a>&gt;<br>
---<br>
=C2=A0include/exec/memory.h | 10 ++++++++--<br>
=C2=A0hw/i386/xen/xen-hvm.c |=C2=A0 4 ++--<br>
=C2=A0migration/dirtyrate.c | 21 +++++++++++++++++----<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 34 ++++++++++++++++++++++=
++++++++----<br>
=C2=A0system/memory.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++++++++++----------=
--------<br>
=C2=A05 files changed, 69 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/include/exec/memory.h b/include/exec/memory.h<br>
index 4bc146c5ebdd377cd14a4e462f32cc945db5a0a8..8b019465ab13ce85c03075c8086=
5a0865ea1feed 100644<br>
--- a/include/exec/memory.h<br>
+++ b/include/exec/memory.h<br>
@@ -2576,15 +2576,21 @@ void memory_listener_unregister(MemoryListener *lis=
tener);<br>
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
=C2=A0 *<br>
=C2=A0 * @flags: purpose of stopping dirty log, migration or dirty rate<br>
+ * @errp: pointer to Error*, to store an error if it happens.<br>
+ *<br>
+ * Return: true on success, else false setting @errp with error.<br>
=C2=A0 */<br>
-void memory_global_dirty_log_stop(unsigned int flags);<br>
+bool memory_global_dirty_log_stop(unsigned int flags, Error **errp);<br>
<br>
=C2=A0void mtree_info(bool flatview, bool dispatch_tree, bool owner, bool d=
isabled);<br>
<br>
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c<br>
index 925a207b494b4eed52d5f360b554f18ac8a9806d..286269b47572d90e57df5ff4483=
5bb5f8e16c7ad 100644<br>
--- a/hw/i386/xen/xen-hvm.c<br>
+++ b/hw/i386/xen/xen-hvm.c<br>
@@ -655,9 +655,9 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr=
_t length)<br>
=C2=A0void qmp_xen_set_global_dirty_log(bool enable, Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (enable) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(GLOBAL_DIRTY_MIG=
RATION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_start(GLOBAL_DIRTY_MIG=
RATION, errp);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGR=
ATION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGR=
ATION, errp);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c<br>
index 1d2e85746fb7b10eb7f149976970f9a92125af8a..34f6d803ff5f4e6ccf2e06aaaed=
65a336c4be469 100644<br>
--- a/migration/dirtyrate.c<br>
+++ b/migration/dirtyrate.c<br>
@@ -90,11 +90,17 @@ static int64_t do_calculate_dirtyrate(DirtyPageRecord d=
irty_pages,<br>
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
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_stop(flag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D memory_global_dirty_log_stop(flag, &am=
p;local_err);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
=C2=A0}<br>
@@ -106,10 +112,14 @@ void global_dirty_log_change(unsigned int flag, bool =
start)<br>
=C2=A0 */<br>
=C2=A0static void global_dirty_log_sync(unsigned int flag, bool one_shot)<b=
r>
=C2=A0{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
=C2=A0 =C2=A0 =C2=A0memory_global_dirty_log_sync(false);<br>
=C2=A0 =C2=A0 =C2=A0if (one_shot) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_stop(flag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!memory_global_dirty_log_stop(flag, &amp;l=
ocal_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0bql_unlock();<br>
=C2=A0}<br>
@@ -608,9 +618,12 @@ static void calculate_dirtyrate_dirty_bitmap(struct Di=
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
index 20c6ad9e759b2b8ec7ae26b7ca72d5cbd20d481f..3d9c08cfae8a59031a7c1b3c707=
21c2a90daceba 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -2390,6 +2390,7 @@ static void ram_save_cleanup(void *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0RAMState **rsp =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* We don&#39;t use dirty log with background snapshots=
 */<br>
=C2=A0 =C2=A0 =C2=A0if (!migrate_background_snapshot()) {<br>
@@ -2402,7 +2403,10 @@ static void ram_save_cleanup(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * memory_global_dirty_log_=
stop will assert that<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * memory_global_dirty_log_=
start/stop used in pairs<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_global_dirty_log_stop(GLO=
BAL_DIRTY_MIGRATION);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!memory_global_dirty_log_sto=
p(GLOBAL_DIRTY_MIGRATION,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 &amp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(l=
ocal_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2799,18 +2803,31 @@ static void migration_bitmap_clear_discarded_pages(=
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
@@ -3459,6 +3476,8 @@ int colo_init_ram_cache(void)<br>
=C2=A0void colo_incoming_start_dirty_log(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block =3D NULL;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* For memory_global_dirty_log_start below. */<br>
=C2=A0 =C2=A0 =C2=A0bql_lock();<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock_ramlist();<br>
@@ -3470,7 +3489,10 @@ void colo_incoming_start_dirty_log(void)<br>
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
@@ -3481,8 +3503,12 @@ void colo_incoming_start_dirty_log(void)<br>
=C2=A0void colo_release_ram_cache(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (!memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION, &a=
mp;local_err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
+=C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 memory_global_dirty_log_stop(GLOBAL_DIRTY_MIGRATION);<br>
=C2=A0 =C2=A0 =C2=A0RAMBLOCK_FOREACH_NOT_IGNORED(block) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(block-&gt;bmap);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0block-&gt;bmap =3D NULL;<br>
diff --git a/system/memory.c b/system/memory.c<br>
index af06157ead5b1272548e87f79ab9fb3036055328..48aed0f8ece1c731849636c442b=
8ab8e5d7ff6a5 100644<br>
--- a/system/memory.c<br>
+++ b/system/memory.c<br>
@@ -2949,25 +2949,24 @@ static unsigned int postponed_stop_flags;<br>
=C2=A0static VMChangeStateEntry *vmstate_change;<br>
=C2=A0static bool memory_global_dirty_log_stop_postponed_run(Error **errp);=
<br>
<br>
-void memory_global_dirty_log_start(unsigned int flags)<br>
+bool memory_global_dirty_log_start(unsigned int flags, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 ERRP_GUARD();<br>
=C2=A0 =C2=A0 =C2=A0unsigned int old_flags;<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0assert(flags &amp;&amp; !(flags &amp; (~GLOBAL_DIRTY_MA=
SK)));<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (vmstate_change) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* If there is postponed stop(), operate =
on it first */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0postponed_stop_flags &amp;=3D ~flags;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!memory_global_dirty_log_stop_postponed_ru=
n(&amp;local_err)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!memory_global_dirty_log_stop_postponed_ru=
n(errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0flags &amp;=3D ~global_dirty_tracking;<br>
=C2=A0 =C2=A0 =C2=A0if (!flags) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0old_flags =3D global_dirty_tracking;<br>
@@ -2975,16 +2974,15 @@ void memory_global_dirty_log_start(unsigned int fla=
gs)<br>
=C2=A0 =C2=A0 =C2=A0trace_global_dirty_changed(global_dirty_tracking);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!old_flags) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_sta=
rt, Forward,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;loc=
al_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (local_err) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MEMORY_LISTENER_CALL_LOG_GLOBAL(log_global_sta=
rt, Forward, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*errp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_begin();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_update_pending =3D true;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_transaction_commit();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 return true;<br>
=C2=A0}<br>
<br>
=C2=A0static bool memory_global_dirty_log_do_stop(unsigned int flags, Error=
 **errp)<br>
@@ -3040,10 +3038,8 @@ static void memory_vm_change_state_handler(void *opa=
que, bool running,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void memory_global_dirty_log_stop(unsigned int flags)<br>
+bool memory_global_dirty_log_stop(unsigned int flags, Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0if (!runstate_is_running()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Postpone the dirty log stop, e.g., to =
when VM starts again */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vmstate_change) {<br>
@@ -3054,12 +3050,10 @@ void memory_global_dirty_log_stop(unsigned int flag=
s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vmstate_change =3D qemu_add=
_vm_change_state_handler(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_vm_cha=
nge_state_handler, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (!memory_global_dirty_log_do_stop(flags, &amp;local_err))=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(local_err);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return memory_global_dirty_log_do_stop(flags, errp);<br>
=C2=A0}<br>
<br>
=C2=A0static void listener_add_address_space(MemoryListener *listener,<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div><br clear=3D"all"><div><div class=3D"gmail_default"><spa=
n style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Reviewed-by:</=
span><font face=3D"comic sans ms, sans-serif">=C2=A0Hyman Huang &lt;<a href=
=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.com</a>&gt;</font></div=
></div><div><br></div><span class=3D"gmail_signature_prefix">-- </span><br>=
<div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"c=
omic sans ms, sans-serif">Best regards</font></div></div></div>

--00000000000078fdb10612e02ea2--

