Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E29CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPn1w-0007lt-1s; Wed, 20 May 2026 15:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPn1t-0007lW-LF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPn1r-0004ks-Hl
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779306989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2HPDMK2Wp21J6IbfS3+r2Dzl+Vkqrs+GG/iAThAO6HQ=;
 b=SKTEykEzM+EjGNjqO5m7oAkyfxFVh+TSjPoB7btGIFcxF2D5CEHFpq5p6DZOuniankKAvl
 h54J0uIjmyYGOh71uj8WiZlJHOGtHEQ89lQ0FFe36v1S0GNxTm4bRwJo9z2O5FpypC/Pck
 DK1JZLUnu8JO9HcnePWULnMIg3eJV5c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-I0SNMyOgNv-T3bzINZUqBg-1; Wed, 20 May 2026 15:56:23 -0400
X-MC-Unique: I0SNMyOgNv-T3bzINZUqBg-1
X-Mimecast-MFC-AGG-ID: I0SNMyOgNv-T3bzINZUqBg_1779306979
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5162ee45a77so137895121cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779306979; x=1779911779; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2HPDMK2Wp21J6IbfS3+r2Dzl+Vkqrs+GG/iAThAO6HQ=;
 b=dbmHDN6epXvsENZtFYwdXDvyudcnY3XuA9tC6WGr7DbnytBwmhz3RYLvpbhlqEOzv+
 PKqUKeb7M1h6gdZzUiiWb+2Dow2Funu462Mr3bZX8F5iGQs+goQvpihIRsOKsp0wcthC
 Sp44fHC6004d883O2stGonds057tyyPMtbgVk5Ey3uYSllOQ0b/q7EGCGe9CDdXwokYm
 zlo//LLnpD5Odh5uOfmwpRKbnpjJfF4Y9MxRn5mAxsWL/iV9dAM88iomJ1pT6oIpqCtQ
 DNaezUEKWUpN0xlSiAzjuYmdA+H9V8Hb0AQejkbDKY9vvgvwU1zTi/ShVYUKyZMgnsW/
 RWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779306979; x=1779911779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HPDMK2Wp21J6IbfS3+r2Dzl+Vkqrs+GG/iAThAO6HQ=;
 b=IeJE3itrrrVxhtd1KNAeTiV9szO9rEdIYJwKiUiQ1A9XCm6IXotxb3gnOzYpV962z3
 n8RCVh8rDDL2lrG2YuOu6VjLh9t+Dn/3n9ATVgqxOoQD+Upy5bt+0fGdP7qIjGuhs3ZA
 tYktx2HbZwRnSXykfuVlySfV6D+nrHg+SvAxYxsGM19Q8JJUoNPrD4nBaJUwGhJ/T+Wm
 Y017W6sDEs8SUDoNGzKEctCgEZI7B1q/nO23xJ0qqO1RW2XlrQy30sBaXKAB1kbDf25T
 W+vr1hk8GXXizLgHIWF88IV+/mYOuLRCNyCmt7eqaz3x6XK1laecbMdl91h4nJkdtKKt
 Eh9Q==
X-Gm-Message-State: AOJu0YxpzI+5hzUfoYEwPFrTHFI+UbeJchoEinbUKlc7RqVi68r8bD5O
 kYHGUWggm3NW8srQ7C99I7l3mGOdeBAfsxGszoXkydPr+QNBByQtAdn7ztMiUfoDfwIXHdq2j+N
 KAsBR1IfOmrLpPRB2J5lqcdSRy/Ir2yDHBfxgwLplSIAEn3jn+5fk5N4+
X-Gm-Gg: Acq92OF6LB8ydaNWpDkrSQHEjCvnI6Y5IkWrn1CPi++zryJoEuz2xt6ro4n5g6oP7hP
 FAosOmnnV165RLBQfV1uFUbNxEldAC6JeKOcgQtfYHQc+IhDRpVhpjsSH1mo0WKpivryjN87pZU
 SNWmw2DJetxd/1c3cIvQaaOkO9fv85NOCQDYAHn/qjinyK9w/AKbjYFRTZ6u1aQFVQXaw5J4RtD
 3QY9Feflk3cQdpOa2/wO4gtRt14icke27xyI1alO4p633hHpSPPR7m6HZUYuFyVOAikk5Q9et8r
 JA2SZqkzx5nHTvrM/LoJ8T6uPy3dYBTXVZ5XhegBtAf07G73S8CSYtv34+lkNstmb7LpC6+r4yz
 5L9f9p9FkAn4TcmVamSQegW7aCh7g08W51pfazzOSBIkpl48=
X-Received: by 2002:a05:622a:428d:b0:50f:783f:31a8 with SMTP id
 d75a77b69052e-5165a1d9f1fmr320049131cf.28.1779306977603; 
 Wed, 20 May 2026 12:56:17 -0700 (PDT)
X-Received: by 2002:a05:622a:428d:b0:50f:783f:31a8 with SMTP id
 d75a77b69052e-5165a1d9f1fmr320048391cf.28.1779306976818; 
 Wed, 20 May 2026 12:56:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516456c0a42sm208556591cf.10.2026.05.20.12.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 12:56:16 -0700 (PDT)
Date: Wed, 20 May 2026 15:56:14 -0400
From: Peter Xu <peterx@redhat.com>
To: hongmianquan <hongmianquan@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH v3] migration/cpr: use hashtable for cpr fds
Message-ID: <ag4R3ooYIrarSqD0@x1.local>
References: <20260519134315.27997-1-hongmianquan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519134315.27997-1-hongmianquan@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 19, 2026 at 09:43:15PM +0800, hongmianquan wrote:
> Use a GHashTable to store cpr fds to reduce the time
> consumption of `cpr_find_fd` in scenarios with a large
> number of fds. The time complexity for `cpr_find_fd` is
> reduced from O(N) to O(1).
> Keep cpr fds lookups in a GHashTable during normal runtime
> while preserving the existing QLIST migration ABI. Build a
> temporary QLIST from the hash table in pre_save and rebuild
> the hash table from the loaded QLIST in post_load.
> 
> To demonstrate the performance improvement, we tested the total time
> consumed by `cpr_find_fd` (called N times for N fds) under our real-world
> business scenarios with different numbers of file descriptors. The results
> are measured in nanoseconds:
> 
> | Number of FDs | Total time with QLIST (ns) | Total time with GHashTable (ns) |
> |---------------|----------------------------|---------------------------------|
> | 540           | 936,753                    | 393,358                         |
> | 2,870         | 24,102,342                 | 2,212,113                       |
> | 7,530         | 152,715,916                | 5,474,310                       |
> 
> As shown in the data, the lookup time grows exponentially with the QLIST
> as the number of fds increases. With the GHashTable, the time consumption
> remains linear (O(1) per lookup), significantly reducing the downtime during
> the CPR process.

Queued, thanks.  Copy Maciej in case there's comments.

> 
> Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
> ---
>  migration/cpr.c | 116 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 98 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/cpr.c b/migration/cpr.c
> index a0b37007f5..ffd1e5af7b 100644
> --- a/migration/cpr.c
> +++ b/migration/cpr.c
> @@ -24,6 +24,7 @@
>  /* cpr state container for all information to be saved. */
>  
>  CprState cpr_state;
> +static GHashTable *cpr_fds_hash;
>  
>  /****************************************************************************/
>  
> @@ -48,6 +49,84 @@ static const VMStateDescription vmstate_cpr_fd = {
>      }
>  };
>  
> +static guint cpr_fd_hash(gconstpointer v)
> +{
> +    const CprFd *elem = v;
> +
> +    return g_str_hash(elem->name) ^ elem->id;
> +}
> +
> +static gboolean cpr_fd_equal(gconstpointer a, gconstpointer b)
> +{
> +    const CprFd *elem_a = a;
> +    const CprFd *elem_b = b;
> +
> +    return !strcmp(elem_a->name, elem_b->name) && elem_a->id == elem_b->id;
> +}
> +
> +static void cpr_fd_destroy(gpointer data)
> +{
> +    CprFd *elem = data;
> +
> +    g_free(elem->name);
> +    g_free(elem);
> +}
> +
> +static GHashTable *get_cpr_fds_hash(void)
> +{
> +    if (!cpr_fds_hash) {
> +        cpr_fds_hash = g_hash_table_new_full(cpr_fd_hash, cpr_fd_equal,
> +                                             cpr_fd_destroy, NULL);
> +    }
> +
> +    return cpr_fds_hash;
> +}
> +
> +static void cpr_fd_hash_insert(CprFd *elem)
> +{
> +    /* Use the same CprFd as key and value. */
> +    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
> +}
> +
> +static int cpr_fd_pre_save(void *opaque)
> +{
> +    CprState *state = (CprState *)opaque;
> +    GHashTableIter iter;
> +    CprFd *elem;
> +
> +    QLIST_INIT(&state->fds);
> +
> +    g_hash_table_iter_init(&iter, get_cpr_fds_hash());
> +    while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
> +        QLIST_INSERT_HEAD(&state->fds, elem, next);
> +    }
> +
> +    return 0;
> +}
> +
> +static int cpr_fd_post_load(void *opaque, int version_id)
> +{
> +    CprState *state = (CprState *)opaque;
> +    CprFd *elem;
> +
> +    while ((elem = QLIST_FIRST(&state->fds))) {
> +        QLIST_REMOVE(elem, next);
> +
> +        /*
> +         * Preserve legacy QLIST lookup semantics if duplicate keys exist in
> +         * the incoming stream: the first matching entry wins.
> +         */
> +        if (g_hash_table_contains(get_cpr_fds_hash(), elem)) {
> +            cpr_fd_destroy(elem);
> +            continue;
> +        }
> +
> +        cpr_fd_hash_insert(elem);
> +    }
> +
> +    return 0;
> +}
> +
>  void cpr_save_fd(const char *name, int id, int fd)
>  {
>      CprFd *elem = g_new0(CprFd, 1);
> @@ -57,37 +136,34 @@ void cpr_save_fd(const char *name, int id, int fd)
>      elem->namelen = strlen(name) + 1;
>      elem->id = id;
>      elem->fd = fd;
> -    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
> +    cpr_fd_hash_insert(elem);
>  }
>  
> -static CprFd *find_fd(CprFdList *head, const char *name, int id)
> +static CprFd *find_fd(const char *name, int id)
>  {
> -    CprFd *elem;
> +    CprFd key = {
> +        .name = (char *)name,
> +        .id = id,
> +    };
>  
> -    QLIST_FOREACH(elem, head, next) {
> -        if (!strcmp(elem->name, name) && elem->id == id) {
> -            return elem;
> -        }
> -    }
> -    return NULL;
> +    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
>  }
>  
>  void cpr_delete_fd(const char *name, int id)
>  {
> -    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> +    CprFd key = {
> +        .name = (char *)name,
> +        .id = id,
> +    };
>  
> -    if (elem) {
> -        QLIST_REMOVE(elem, next);
> -        g_free(elem->name);
> -        g_free(elem);
> -    }
> +    g_hash_table_remove(get_cpr_fds_hash(), &key);
>  
>      trace_cpr_delete_fd(name, id);
>  }
>  
>  int cpr_find_fd(const char *name, int id)
>  {
> -    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> +    CprFd *elem = find_fd(name, id);
>      int fd = elem ? elem->fd : -1;
>  
>      trace_cpr_find_fd(name, id, fd);
> @@ -96,7 +172,7 @@ int cpr_find_fd(const char *name, int id)
>  
>  void cpr_resave_fd(const char *name, int id, int fd)
>  {
> -    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> +    CprFd *elem = find_fd(name, id);
>      int old_fd = elem ? elem->fd : -1;
>  
>      if (old_fd < 0) {
> @@ -125,9 +201,11 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
>  
>  bool cpr_walk_fd(cpr_walk_fd_cb cb)
>  {
> +    GHashTableIter iter;
>      CprFd *elem;
>  
> -    QLIST_FOREACH(elem, &cpr_state.fds, next) {
> +    g_hash_table_iter_init(&iter, get_cpr_fds_hash());
> +    while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
>          g_assert(elem->fd >= 0);
>          if (!cb(elem->fd)) {
>              return false;
> @@ -141,6 +219,8 @@ static const VMStateDescription vmstate_cpr_state = {
>      .name = CPR_STATE,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_save = cpr_fd_pre_save,
> +    .post_load = cpr_fd_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>          VMSTATE_END_OF_LIST()
> -- 
> 2.32.1 (Apple Git-133)
> 

-- 
Peter Xu


