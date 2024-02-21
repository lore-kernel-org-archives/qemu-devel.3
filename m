Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06D5C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcofL-00069x-S2; Wed, 21 Feb 2024 10:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcofJ-000605-12
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:37:45 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ufimtseva@gmail.com>)
 id 1rcofF-0007sw-MF
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:37:44 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-512b3b04995so870980e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708529859; x=1709134659; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZyUVsJMmD3ivvvohLpVWgF0AgfSaRcST8FspTfqqBvs=;
 b=kBo836a1CApe+dCNiA8QM9OOAVWud3BKN0pIaJWmsztr9IENB0opyEd6RShvsotsXd
 KkIaYbqgpjcgKorcLfFvrP4hRsAREdo3oRwfvQgnWjfY8KCVmccNIPiPAZ5ntYpKs7Yv
 jh0H/QHJSKpXMSMXYn2rTD4B9uFWy7EIhFpCwzu3f6FZWRZ7CuQ2EHFY2VGfh/6TzCBL
 Fm9IxF2eMyCNM111J3lYtD+6XffXOjrD8sdKVVVEWixRGNbwWmUQExAn914p8jF+7TwM
 isHeqcJckXC5AIkCgnNw/PaoAbiI9TpBssVpJ8ofCtI/EGdDCEbDFPVQ6C8sGx8Paa5/
 cgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708529859; x=1709134659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZyUVsJMmD3ivvvohLpVWgF0AgfSaRcST8FspTfqqBvs=;
 b=PCf6rxYp0alqhXPQ+bZ74KkhsbUROUD/OIXrPu22Yr6hrL5nR9b/LYti1mRnJahGwh
 MkCazgEc/InbqV7OkqjDTLrYhSOqphhLaYaUJ+DFlJrNnQ2hKjW9yowIRYi22/pgWV6U
 XYgZwDY03G3pPfdSgAfV/KAAMfDxD5Dr8Y9v63VMDsOprW773w0/N++A5hp1aJEPDrWC
 5yH4V+B4ZAEp+xbVBBQsXDyF5S+Jt4eyvQmq2USDqr01KMvo4uaU82H0hzou7UdniZ7i
 iI1XTCZC9VbPGVwT0TsCEA+oxJmpJk1HM+P9iefKKhiMmv09Cj+t+So+uXs0Pbg1rRjS
 ugeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu4O8F+LwYyU//LnPlzLr8Fc9xaHppCxSSvi1jrINGsGhsAi4UmDswMeRxvf7ed1cC+KeHheQNEAfrPKyqRnyGT09t8mo=
X-Gm-Message-State: AOJu0YyOUZoMN1T+E6weo1Jq/REKvQg2OreddDKPCy+oIzzmpC31YgWV
 TWY7M9Y6zYa8Mvw7EdpOjwKeV5mxTt54EFh2pHZFZj+oT816qPnxWRUFUaXWgtlq1WiONKCphED
 mh5OML18zqWDKZbzMfrzaeSMnlHY=
X-Google-Smtp-Source: AGHT+IGCo2asB2tmsa7/i4xKwrLDnYODM8oXGJbSGHTVESENRpCHKsL2Zf0dsBrgBT8rlXZzvcFdc+Qbgq4ot/r/rv8=
X-Received: by 2002:ac2:5e6f:0:b0:512:b297:286f with SMTP id
 a15-20020ac25e6f000000b00512b297286fmr5521600lfr.52.1708529859207; Wed, 21
 Feb 2024 07:37:39 -0800 (PST)
MIME-Version: 1.0
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
 <20240216224002.1476890-3-hao.xiang@bytedance.com>
In-Reply-To: <20240216224002.1476890-3-hao.xiang@bytedance.com>
From: Elena Ufimtseva <ufimtseva@gmail.com>
Date: Wed, 21 Feb 2024 07:37:27 -0800
Message-ID: <CAEr7rXjCqe0j8HgVz_Jg3mUasipdz3RXvrkf7p1KZMCMLdCzxw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] migration/multifd: Support for zero pages
 transmission in multifd format.
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, 
 jdenemar@redhat.com
Content-Type: multipart/alternative; boundary="00000000000058a7fe0611e61bd8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=ufimtseva@gmail.com; helo=mail-lf1-x136.google.com
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

--00000000000058a7fe0611e61bd8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 2:41=E2=80=AFPM Hao Xiang <hao.xiang@bytedance.com>=
 wrote:

> This change adds zero page counters and updates multifd send/receive
> tracing format to track the newly added counters.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  migration/multifd.c    | 43 ++++++++++++++++++++++++++++++++++--------
>  migration/multifd.h    | 21 ++++++++++++++++++++-
>  migration/ram.c        |  1 -
>  migration/trace-events |  8 ++++----
>  4 files changed, 59 insertions(+), 14 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index adfe8c9a0a..a33dba40d9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -236,6 +236,8 @@ static void multifd_pages_reset(MultiFDPages_t *pages=
)
>       * overwritten later when reused.
>       */
>      pages->num =3D 0;
> +    pages->normal_num =3D 0;
> +    pages->zero_num =3D 0;
>      pages->block =3D NULL;
>  }
>

> @@ -309,6 +311,8 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>
>      pages->allocated =3D n;
>      pages->offset =3D g_new0(ram_addr_t, n);
> +    pages->normal =3D g_new0(ram_addr_t, n);
> +    pages->zero =3D g_new0(ram_addr_t, n);
>
>
     return pages;
>  }
> @@ -319,6 +323,10 @@ static void multifd_pages_clear(MultiFDPages_t *page=
s)
>      pages->allocated =3D 0;
>      g_free(pages->offset);
>      pages->offset =3D NULL;
> +    g_free(pages->normal);
> +    pages->normal =3D NULL;
> +    g_free(pages->zero);
> +    pages->zero =3D NULL;
>      g_free(pages);
>  }
>
> @@ -332,6 +340,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>      packet->flags =3D cpu_to_be32(p->flags);
>      packet->pages_alloc =3D cpu_to_be32(p->pages->allocated);
>      packet->normal_pages =3D cpu_to_be32(pages->num);
> +    packet->zero_pages =3D cpu_to_be32(pages->zero_num);
>      packet->next_packet_size =3D cpu_to_be32(p->next_packet_size);
>
>      packet_num =3D qatomic_fetch_inc(&multifd_send_state->packet_num);
> @@ -350,9 +359,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>
>      p->packets_sent++;
>      p->total_normal_pages +=3D pages->num;
> +    p->total_zero_pages +=3D pages->zero_num;
>
> -    trace_multifd_send(p->id, packet_num, pages->num, p->flags,
> -                       p->next_packet_size);
> +    trace_multifd_send(p->id, packet_num, pages->num, pages->zero_num,
> +                       p->flags, p->next_packet_size);
>  }
>
>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp=
)
> @@ -393,20 +403,29 @@ static int
> multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      p->normal_num =3D be32_to_cpu(packet->normal_pages);
>      if (p->normal_num > packet->pages_alloc) {
>          error_setg(errp, "multifd: received packet "
> -                   "with %u pages and expected maximum pages are %u",
> +                   "with %u normal pages and expected maximum pages are
> %u",
>                     p->normal_num, packet->pages_alloc) ;
>          return -1;
>      }
>
> +    p->zero_num =3D be32_to_cpu(packet->zero_pages);
> +    if (p->zero_num > packet->pages_alloc - p->normal_num) {
> +        error_setg(errp, "multifd: received packet "
> +                   "with %u zero pages and expected maximum zero pages
> are %u",
> +                   p->zero_num, packet->pages_alloc - p->normal_num) ;
> +        return -1;
> +    }


You could probably combine this check with normal_num against pages_alloc.

> +
>      p->next_packet_size =3D be32_to_cpu(packet->next_packet_size);
>      p->packet_num =3D be64_to_cpu(packet->packet_num);
>      p->packets_recved++;
>      p->total_normal_pages +=3D p->normal_num;
> +    p->total_zero_pages +=3D p->zero_num;
>
> -    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->flags,
> -                       p->next_packet_size);
> +    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
> +                       p->flags, p->next_packet_size);
>
> -    if (p->normal_num =3D=3D 0) {
> +    if (p->normal_num =3D=3D 0 && p->zero_num =3D=3D 0) {
>          return 0;
>      }
>
> @@ -823,6 +842,8 @@ static void *multifd_send_thread(void *opaque)
>
>              stat64_add(&mig_stats.multifd_bytes,
>                         p->next_packet_size + p->packet_len);
> +            stat64_add(&mig_stats.normal_pages, pages->num);
>

That seems wrong. pages->num is the number of pages total in the packet.
But next patch changes it, so I suggest or change it here and not in 3/7.

+            stat64_add(&mig_stats.zero_pages, pages->zero_num);
>
>              multifd_pages_reset(p->pages);
>              p->next_packet_size =3D 0;
> @@ -866,7 +887,8 @@ out:
>
>      rcu_unregister_thread();
>      migration_threads_remove(thread);
> -    trace_multifd_send_thread_end(p->id, p->packets_sent,
> p->total_normal_pages);
> +    trace_multifd_send_thread_end(p->id, p->packets_sent,
> p->total_normal_pages,
> +                                  p->total_zero_pages);
>
>      return NULL;
>  }
> @@ -1132,6 +1154,8 @@ static void
> multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>      p->iov =3D NULL;
>      g_free(p->normal);
>      p->normal =3D NULL;
> +    g_free(p->zero);
> +    p->zero =3D NULL;
>      multifd_recv_state->ops->recv_cleanup(p);
>  }
>
> @@ -1251,7 +1275,9 @@ static void *multifd_recv_thread(void *opaque)
>      }
>
>      rcu_unregister_thread();
> -    trace_multifd_recv_thread_end(p->id, p->packets_recved,
> p->total_normal_pages);
> +    trace_multifd_recv_thread_end(p->id, p->packets_recved,
> +                                  p->total_normal_pages,
> +                                  p->total_zero_pages);
>
>      return NULL;
>  }
> @@ -1290,6 +1316,7 @@ int multifd_recv_setup(Error **errp)
>          p->name =3D g_strdup_printf("multifdrecv_%d", i);
>          p->iov =3D g_new0(struct iovec, page_count);
>          p->normal =3D g_new0(ram_addr_t, page_count);
> +        p->zero =3D g_new0(ram_addr_t, page_count);
>          p->page_count =3D page_count;
>          p->page_size =3D qemu_target_page_size();
>      }
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 8a1cad0996..9822ff298a 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -48,7 +48,10 @@ typedef struct {
>      /* size of the next packet that contains pages */
>      uint32_t next_packet_size;
>      uint64_t packet_num;
> -    uint64_t unused[4];    /* Reserved for future use */
> +    /* zero pages */
> +    uint32_t zero_pages;
> +    uint32_t unused32[1];    /* Reserved for future use */
> +    uint64_t unused64[3];    /* Reserved for future use */
>      char ramblock[256];
>      uint64_t offset[];
>  } __attribute__((packed)) MultiFDPacket_t;
> @@ -56,10 +59,18 @@ typedef struct {
>  typedef struct {
>      /* number of used pages */
>      uint32_t num;
> +    /* number of normal pages */
> +    uint32_t normal_num;
> +    /* number of zero pages */
> +    uint32_t zero_num;
>      /* number of allocated pages */
>      uint32_t allocated;
>      /* offset of each page */
>      ram_addr_t *offset;
> +    /* offset of normal page */
> +    ram_addr_t *normal;
> +    /* offset of zero page */
> +    ram_addr_t *zero;
>      RAMBlock *block;
>  } MultiFDPages_t;
>
> @@ -124,6 +135,8 @@ typedef struct {
>      uint64_t packets_sent;
>      /* non zero pages sent through this channel */
>      uint64_t total_normal_pages;
> +    /* zero pages sent through this channel */
> +    uint64_t total_zero_pages;
>

Can we initialize these to zero when threads are being set up?
Also, I have a strong desire to rename these.. later.


>      /* buffers to send */
>      struct iovec *iov;
>      /* number of iovs used */
> @@ -178,12 +191,18 @@ typedef struct {
>      uint8_t *host;
>      /* non zero pages recv through this channel */
>      uint64_t total_normal_pages;
> +    /* zero pages recv through this channel */
> +    uint64_t total_zero_pages;
>      /* buffers to recv */
>      struct iovec *iov;
>      /* Pages that are not zero */
>      ram_addr_t *normal;
>      /* num of non zero pages */
>      uint32_t normal_num;
> +    /* Pages that are zero */
> +    ram_addr_t *zero;
> +    /* num of zero pages */
> +    uint32_t zero_num;
>      /* used for de-compression methods */
>      void *data;
>  } MultiFDRecvParams;
> diff --git a/migration/ram.c b/migration/ram.c
> index 556725c30f..5ece9f042e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1259,7 +1259,6 @@ static int ram_save_multifd_page(RAMBlock *block,
> ram_addr_t offset)
>      if (!multifd_queue_page(block, offset)) {
>          return -1;
>      }
> -    stat64_add(&mig_stats.normal_pages, 1);
>
>      return 1;
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index 298ad2b0dd..9f1d7ae71a 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -128,21 +128,21 @@ postcopy_preempt_reset_channel(void) ""
>  # multifd.c
>  multifd_new_send_channel_async(uint8_t id) "channel %u"
>  multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=3D%=
u
> err=3D%p"
> -multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t
> flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " page=
s
> %u flags 0x%x next packet size %u"
> +multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t
> zero, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %=
"
> PRIu64 " normal pages %u zero pages %u flags 0x%x next packet size %u"
>  multifd_recv_new_channel(uint8_t id) "channel %u"
>  multifd_recv_sync_main(long packet_num) "packet num %ld"
>  multifd_recv_sync_main_signal(uint8_t id) "channel %u"
>  multifd_recv_sync_main_wait(uint8_t id) "channel %u"
>  multifd_recv_terminate_threads(bool error) "error %d"
> -multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages)
> "channel %u packets %" PRIu64 " pages %" PRIu64
> +multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t
> normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal
> pages %" PRIu64 " zero pages %" PRIu64
>  multifd_recv_thread_start(uint8_t id) "%u"
> -multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t
> flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " norm=
al
> pages %u flags 0x%x next packet size %u"
> +multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages,
> uint32_t zero_pages, uint32_t flags, uint32_t next_packet_size) "channel =
%u
> packet_num %" PRIu64 " normal pages %u zero pages %u flags 0x%x next pack=
et
> size %u"
>  multifd_send_error(uint8_t id) "channel %u"
>  multifd_send_sync_main(long packet_num) "packet num %ld"
>  multifd_send_sync_main_signal(uint8_t id) "channel %u"
>  multifd_send_sync_main_wait(uint8_t id) "channel %u"
>  multifd_send_terminate_threads(void) ""
> -multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t
> normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
> +multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t
> normal_pages, uint64_t zero_pages) "channel %u packets %" PRIu64 " normal
> pages %"  PRIu64 " zero pages %"  PRIu64
>  multifd_send_thread_start(uint8_t id) "%u"
>  multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char
> *hostname) "ioc=3D%p tioc=3D%p hostname=3D%s"
>  multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=3D=
%p
> err=3D%s"
> --
> 2.30.2
>
>
>

--=20
Elena

--00000000000058a7fe0611e61bd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 16, 2024 at 2:41=E2=80=AF=
PM Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com" target=3D"_blan=
k">hao.xiang@bytedance.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">This change adds zero page counters and updates m=
ultifd send/receive<br>
tracing format to track the newly added counters.<br>
<br>
Signed-off-by: Hao Xiang &lt;<a href=3D"mailto:hao.xiang@bytedance.com" tar=
get=3D"_blank">hao.xiang@bytedance.com</a>&gt;<br>
---<br>
=C2=A0migration/multifd.c=C2=A0 =C2=A0 | 43 +++++++++++++++++++++++++++++++=
+++--------<br>
=C2=A0migration/multifd.h=C2=A0 =C2=A0 | 21 ++++++++++++++++++++-<br>
=C2=A0migration/ram.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 -<br>
=C2=A0migration/trace-events |=C2=A0 8 ++++----<br>
=C2=A04 files changed, 59 insertions(+), 14 deletions(-)<br>
<br>
diff --git a/migration/multifd.c b/migration/multifd.c<br>
index adfe8c9a0a..a33dba40d9 100644<br>
--- a/migration/multifd.c<br>
+++ b/migration/multifd.c<br>
@@ -236,6 +236,8 @@ static void multifd_pages_reset(MultiFDPages_t *pages)<=
br>
=C2=A0 =C2=A0 =C2=A0 * overwritten later when reused.<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0pages-&gt;num =3D 0;<br>
+=C2=A0 =C2=A0 pages-&gt;normal_num =3D 0;<br>
+=C2=A0 =C2=A0 pages-&gt;zero_num =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0pages-&gt;block =3D NULL;<br>
=C2=A0}<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
@@ -309,6 +311,8 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0pages-&gt;allocated =3D n;<br>
=C2=A0 =C2=A0 =C2=A0pages-&gt;offset =3D g_new0(ram_addr_t, n);<br>
+=C2=A0 =C2=A0 pages-&gt;normal =3D g_new0(ram_addr_t, n);<br>
+=C2=A0 =C2=A0 pages-&gt;zero =3D g_new0(ram_addr_t, n);<br>=C2=A0 <br></bl=
ockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
=C2=A0 =C2=A0 =C2=A0return pages;<br>
=C2=A0}<br>
@@ -319,6 +323,10 @@ static void multifd_pages_clear(MultiFDPages_t *pages)=
<br>
=C2=A0 =C2=A0 =C2=A0pages-&gt;allocated =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0g_free(pages-&gt;offset);<br>
=C2=A0 =C2=A0 =C2=A0pages-&gt;offset =3D NULL;<br>
+=C2=A0 =C2=A0 g_free(pages-&gt;normal);<br>
+=C2=A0 =C2=A0 pages-&gt;normal =3D NULL;<br>
+=C2=A0 =C2=A0 g_free(pages-&gt;zero);<br>
+=C2=A0 =C2=A0 pages-&gt;zero =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_free(pages);<br>
=C2=A0}<br>
<br>
@@ -332,6 +340,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;flags =3D cpu_to_be32(p-&gt;flags);<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;pages_alloc =3D cpu_to_be32(p-&gt;pages-&gt;=
allocated);<br>
=C2=A0 =C2=A0 =C2=A0packet-&gt;normal_pages =3D cpu_to_be32(pages-&gt;num);=
<br>
+=C2=A0 =C2=A0 packet-&gt;zero_pages =3D cpu_to_be32(pages-&gt;zero_num);<b=
r>
=C2=A0 =C2=A0 =C2=A0packet-&gt;next_packet_size =3D cpu_to_be32(p-&gt;next_=
packet_size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0packet_num =3D qatomic_fetch_inc(&amp;multifd_send_stat=
e-&gt;packet_num);<br>
@@ -350,9 +359,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;packets_sent++;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;total_normal_pages +=3D pages-&gt;num;<br>
+=C2=A0 =C2=A0 p-&gt;total_zero_pages +=3D pages-&gt;zero_num;<br>
<br>
-=C2=A0 =C2=A0 trace_multifd_send(p-&gt;id, packet_num, pages-&gt;num, p-&g=
t;flags,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p-&gt;next_packet_size);<br>
+=C2=A0 =C2=A0 trace_multifd_send(p-&gt;id, packet_num, pages-&gt;num, page=
s-&gt;zero_num,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p-&gt;flags, p-&gt;next_packet_size);<br>
=C2=A0}<br>
<br>
=C2=A0static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **e=
rrp)<br>
@@ -393,20 +403,29 @@ static int multifd_recv_unfill_packet(MultiFDRecvPara=
ms *p, Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;normal_num =3D be32_to_cpu(packet-&gt;normal_page=
s);<br>
=C2=A0 =C2=A0 =C2=A0if (p-&gt;normal_num &gt; packet-&gt;pages_alloc) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;multifd: received =
packet &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;with %u pages and expected maximum pages are %u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;with %u normal pages and expected maximum pages are %u&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt=
;normal_num, packet-&gt;pages_alloc) ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 p-&gt;zero_num =3D be32_to_cpu(packet-&gt;zero_pages);<br>
+=C2=A0 =C2=A0 if (p-&gt;zero_num &gt; packet-&gt;pages_alloc - p-&gt;norma=
l_num) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;multifd: received packe=
t &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;with %u zero pages and expected maximum zero pages are %u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt=
;zero_num, packet-&gt;pages_alloc - p-&gt;normal_num) ;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br></div>
+=C2=A0 =C2=A0 }</blockquote><div><br></div><div>You could probably combine=
 this check with normal_num against pages_alloc. <br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div>
+<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;next_packet_size =3D be32_to_cpu(packet-&gt;next_=
packet_size);<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;packet_num =3D be64_to_cpu(packet-&gt;packet_num)=
;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;packets_recved++;<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;total_normal_pages +=3D p-&gt;normal_num;<br>
+=C2=A0 =C2=A0 p-&gt;total_zero_pages +=3D p-&gt;zero_num;<br>
<br>
-=C2=A0 =C2=A0 trace_multifd_recv(p-&gt;id, p-&gt;packet_num, p-&gt;normal_=
num, p-&gt;flags,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p-&gt;next_packet_size);<br>
+=C2=A0 =C2=A0 trace_multifd_recv(p-&gt;id, p-&gt;packet_num, p-&gt;normal_=
num, p-&gt;zero_num,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0p-&gt;flags, p-&gt;next_packet_size);<br>
<br>
-=C2=A0 =C2=A0 if (p-&gt;normal_num =3D=3D 0) {<br>
+=C2=A0 =C2=A0 if (p-&gt;normal_num =3D=3D 0 &amp;&amp; p-&gt;zero_num =3D=
=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -823,6 +842,8 @@ static void *multifd_send_thread(void *opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat64_add(&amp;mig_stats.m=
ultifd_bytes,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 p-&gt;next_packet_size + p-&gt;packet_len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_add(&amp;mig_stats.normal=
_pages, pages-&gt;num);<br></div></blockquote><div>=C2=A0</div><div>That se=
ems wrong. pages-&gt;num is the number of pages total in the packet.</div><=
div>But next patch changes it, so I suggest or change it here and not in 3/=
7.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stat64_add(&amp;mig_stats.zero_p=
ages, pages-&gt;zero_num);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0multifd_pages_reset(p-&gt;p=
ages);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;next_packet_size =3D =
0;<br>
@@ -866,7 +887,8 @@ out:<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_unregister_thread();<br>
=C2=A0 =C2=A0 =C2=A0migration_threads_remove(thread);<br>
-=C2=A0 =C2=A0 trace_multifd_send_thread_end(p-&gt;id, p-&gt;packets_sent, =
p-&gt;total_normal_pages);<br>
+=C2=A0 =C2=A0 trace_multifd_send_thread_end(p-&gt;id, p-&gt;packets_sent, =
p-&gt;total_normal_pages,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;total_zero_pages);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
@@ -1132,6 +1154,8 @@ static void multifd_recv_cleanup_channel(MultiFDRecvP=
arams *p)<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;iov =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0g_free(p-&gt;normal);<br>
=C2=A0 =C2=A0 =C2=A0p-&gt;normal =3D NULL;<br>
+=C2=A0 =C2=A0 g_free(p-&gt;zero);<br>
+=C2=A0 =C2=A0 p-&gt;zero =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0multifd_recv_state-&gt;ops-&gt;recv_cleanup(p);<br>
=C2=A0}<br>
<br>
@@ -1251,7 +1275,9 @@ static void *multifd_recv_thread(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0rcu_unregister_thread();<br>
-=C2=A0 =C2=A0 trace_multifd_recv_thread_end(p-&gt;id, p-&gt;packets_recved=
, p-&gt;total_normal_pages);<br>
+=C2=A0 =C2=A0 trace_multifd_recv_thread_end(p-&gt;id, p-&gt;packets_recved=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;total_normal_pages,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;total_zero_pages);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
@@ -1290,6 +1316,7 @@ int multifd_recv_setup(Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;name =3D g_strdup_printf(&quot;mult=
ifdrecv_%d&quot;, i);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;iov =3D g_new0(struct iovec, page_c=
ount);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;normal =3D g_new0(ram_addr_t, page_=
count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p-&gt;zero =3D g_new0(ram_addr_t, page_count);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;page_count =3D page_count;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p-&gt;page_size =3D qemu_target_page_size=
();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
diff --git a/migration/multifd.h b/migration/multifd.h<br>
index 8a1cad0996..9822ff298a 100644<br>
--- a/migration/multifd.h<br>
+++ b/migration/multifd.h<br>
@@ -48,7 +48,10 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0/* size of the next packet that contains pages */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t next_packet_size;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t packet_num;<br>
-=C2=A0 =C2=A0 uint64_t unused[4];=C2=A0 =C2=A0 /* Reserved for future use =
*/<br>
+=C2=A0 =C2=A0 /* zero pages */<br>
+=C2=A0 =C2=A0 uint32_t zero_pages;<br>
+=C2=A0 =C2=A0 uint32_t unused32[1];=C2=A0 =C2=A0 /* Reserved for future us=
e */<br>
+=C2=A0 =C2=A0 uint64_t unused64[3];=C2=A0 =C2=A0 /* Reserved for future us=
e */<br>
=C2=A0 =C2=A0 =C2=A0char ramblock[256];<br>
=C2=A0 =C2=A0 =C2=A0uint64_t offset[];<br>
=C2=A0} __attribute__((packed)) MultiFDPacket_t;<br>
@@ -56,10 +59,18 @@ typedef struct {<br>
=C2=A0typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0/* number of used pages */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t num;<br>
+=C2=A0 =C2=A0 /* number of normal pages */<br>
+=C2=A0 =C2=A0 uint32_t normal_num;<br>
+=C2=A0 =C2=A0 /* number of zero pages */<br>
+=C2=A0 =C2=A0 uint32_t zero_num;<br>
=C2=A0 =C2=A0 =C2=A0/* number of allocated pages */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t allocated;<br>
=C2=A0 =C2=A0 =C2=A0/* offset of each page */<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t *offset;<br>
+=C2=A0 =C2=A0 /* offset of normal page */<br>
+=C2=A0 =C2=A0 ram_addr_t *normal;<br>
+=C2=A0 =C2=A0 /* offset of zero page */<br>
+=C2=A0 =C2=A0 ram_addr_t *zero;<br>
=C2=A0 =C2=A0 =C2=A0RAMBlock *block;<br>
=C2=A0} MultiFDPages_t;<br>
<br>
@@ -124,6 +135,8 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0uint64_t packets_sent;<br>
=C2=A0 =C2=A0 =C2=A0/* non zero pages sent through this channel */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t total_normal_pages;<br>
+=C2=A0 =C2=A0 /* zero pages sent through this channel */<br>
+=C2=A0 =C2=A0 uint64_t total_zero_pages;<br></div></blockquote><div><br></=
div><div>Can we initialize these to zero when threads are being set up?</di=
v><div>Also, I have a strong desire to rename these.. later.</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div>
=C2=A0 =C2=A0 =C2=A0/* buffers to send */<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *iov;<br>
=C2=A0 =C2=A0 =C2=A0/* number of iovs used */<br>
@@ -178,12 +191,18 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0uint8_t *host;<br>
=C2=A0 =C2=A0 =C2=A0/* non zero pages recv through this channel */<br>
=C2=A0 =C2=A0 =C2=A0uint64_t total_normal_pages;<br>
+=C2=A0 =C2=A0 /* zero pages recv through this channel */<br>
+=C2=A0 =C2=A0 uint64_t total_zero_pages;<br>
=C2=A0 =C2=A0 =C2=A0/* buffers to recv */<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *iov;<br>
=C2=A0 =C2=A0 =C2=A0/* Pages that are not zero */<br>
=C2=A0 =C2=A0 =C2=A0ram_addr_t *normal;<br>
=C2=A0 =C2=A0 =C2=A0/* num of non zero pages */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t normal_num;<br>
+=C2=A0 =C2=A0 /* Pages that are zero */<br>
+=C2=A0 =C2=A0 ram_addr_t *zero;<br>
+=C2=A0 =C2=A0 /* num of zero pages */<br>
+=C2=A0 =C2=A0 uint32_t zero_num;<br>
=C2=A0 =C2=A0 =C2=A0/* used for de-compression methods */<br>
=C2=A0 =C2=A0 =C2=A0void *data;<br>
=C2=A0} MultiFDRecvParams;<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 556725c30f..5ece9f042e 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -1259,7 +1259,6 @@ static int ram_save_multifd_page(RAMBlock *block, ram=
_addr_t offset)<br>
=C2=A0 =C2=A0 =C2=A0if (!multifd_queue_page(block, offset)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 stat64_add(&amp;mig_stats.normal_pages, 1);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return 1;<br>
=C2=A0}<br>
diff --git a/migration/trace-events b/migration/trace-events<br>
index 298ad2b0dd..9f1d7ae71a 100644<br>
--- a/migration/trace-events<br>
+++ b/migration/trace-events<br>
@@ -128,21 +128,21 @@ postcopy_preempt_reset_channel(void) &quot;&quot;<br>
=C2=A0# multifd.c<br>
=C2=A0multifd_new_send_channel_async(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_new_send_channel_async_error(uint8_t id, void *err) &quot;cha=
nnel=3D%u err=3D%p&quot;<br>
-multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flag=
s, uint32_t next_packet_size) &quot;channel %u packet_num %&quot; PRIu64 &q=
uot; pages %u flags 0x%x next packet size %u&quot;<br>
+multifd_recv(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t ze=
ro, uint32_t flags, uint32_t next_packet_size) &quot;channel %u packet_num =
%&quot; PRIu64 &quot; normal pages %u zero pages %u flags 0x%x next packet =
size %u&quot;<br>
=C2=A0multifd_recv_new_channel(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_recv_sync_main(long packet_num) &quot;packet num %ld&quot;<br=
>
=C2=A0multifd_recv_sync_main_signal(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_recv_sync_main_wait(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_recv_terminate_threads(bool error) &quot;error %d&quot;<br>
-multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) &quo=
t;channel %u packets %&quot; PRIu64 &quot; pages %&quot; PRIu64<br>
+multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t normal_page=
s, uint64_t zero_pages) &quot;channel %u packets %&quot; PRIu64 &quot; norm=
al pages %&quot; PRIu64 &quot; zero pages %&quot; PRIu64<br>
=C2=A0multifd_recv_thread_start(uint8_t id) &quot;%u&quot;<br>
-multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal, uint32_t fl=
ags, uint32_t next_packet_size) &quot;channel %u packet_num %&quot; PRIu64 =
&quot; normal pages %u flags 0x%x next packet size %u&quot;<br>
+multifd_send(uint8_t id, uint64_t packet_num, uint32_t normal_pages, uint3=
2_t zero_pages, uint32_t flags, uint32_t next_packet_size) &quot;channel %u=
 packet_num %&quot; PRIu64 &quot; normal pages %u zero pages %u flags 0x%x =
next packet size %u&quot;<br>
=C2=A0multifd_send_error(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_send_sync_main(long packet_num) &quot;packet num %ld&quot;<br=
>
=C2=A0multifd_send_sync_main_signal(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_send_sync_main_wait(uint8_t id) &quot;channel %u&quot;<br>
=C2=A0multifd_send_terminate_threads(void) &quot;&quot;<br>
-multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_page=
s) &quot;channel %u packets %&quot; PRIu64 &quot; normal pages %&quot;=C2=
=A0 PRIu64<br>
+multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_page=
s, uint64_t zero_pages) &quot;channel %u packets %&quot; PRIu64 &quot; norm=
al pages %&quot;=C2=A0 PRIu64 &quot; zero pages %&quot;=C2=A0 PRIu64<br>
=C2=A0multifd_send_thread_start(uint8_t id) &quot;%u&quot;<br>
=C2=A0multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const cha=
r *hostname) &quot;ioc=3D%p tioc=3D%p hostname=3D%s&quot;<br>
=C2=A0multifd_tls_outgoing_handshake_error(void *ioc, const char *err) &quo=
t;ioc=3D%p err=3D%s&quot;<br>
-- <br>
2.30.2<br>
<br>
<br>
</div></blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signatu=
re_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Elena</=
div></div>

--00000000000058a7fe0611e61bd8--

