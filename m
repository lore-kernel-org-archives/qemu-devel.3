Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03718C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVyqn-0007IQ-SE; Mon, 22 Jul 2024 15:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVyqm-0007Hs-AH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVyqj-000566-Pa
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721677052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=viImwbxbeJY95dRZrMD60BMt8N8hWxJU6DgbK6LJfFE=;
 b=Ssagy0LLWiySflAADjhKtw1OQcrF3tDo+JsCIPvHnj1K6IVR0JVWQMCSKzd7wpIvsVBJ26
 WeiEoxrCyRI0ZmxKAWI4iUZI3LYYjMUyyCcSl4ax5W7IAfMSaCQWYeCUepnObJC26rIN9q
 JRVDAegH6D+DH4v10fTdAqgF1/tS7XQ=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-rz6z3jyHMMWJ-s-HHf8GoQ-1; Mon, 22 Jul 2024 15:37:30 -0400
X-MC-Unique: rz6z3jyHMMWJ-s-HHf8GoQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4929d50431bso67764137.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721677049; x=1722281849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viImwbxbeJY95dRZrMD60BMt8N8hWxJU6DgbK6LJfFE=;
 b=Mwj3sX1X9/8L1b5hU49+gdn+GwKRMfoZmXNuxkwVJoe5AKMxi96P6KJW3+73EDWAHm
 biCu+mX2lNlTjbqwatSOm3PWxcsBmqeRn2Ge972RrnkoFxuxrubx1HUWW0da92TJ73+F
 UTr5yjiUoPexvRdJf6yc5b8MyP01j85zM2dYPZqpMizZnITlrjM8dPcJFV0KxST6Gcwc
 oG2I4qdB85txl+jnK90yJXK8wtEKCtcf1gY5TtcIKqGob/dvkl3ZW6UkbLViQFWFvGax
 W9XEg0aSoqbu7eTpHToDcaxdHFR8oNJ9yBGnS82piHqtQ70+Xy8OeKUHrG1TRHqiyYQM
 bDcQ==
X-Gm-Message-State: AOJu0Yx1xhLm6xnWHTpVRpYE8c4uhzg9UE4d8GB3Jfef3OWg8tiUot4D
 o2p+1O0AE31Q0vQCtyKzktYQ3pNSQhAjZfIspn8jy2QLPHLQPob5nwm1DS4mKtsaUjojO7ZBD+e
 A/lo5Vvkx5MQrIZjT18I89sjTwLue5GAFBLcAqOCOPFwnBZDlJ5L6
X-Received: by 2002:a05:6122:2003:b0:4f5:1978:d23f with SMTP id
 71dfb90a1353d-4f51978d8c7mr2713686e0c.1.1721677049434; 
 Mon, 22 Jul 2024 12:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfhVapC3O6IUgREPYytUlttdl2oXouPsVgrCmaw/t29fX0I4VqxHdAS2bPmFo3tFY22LOL2w==
X-Received: by 2002:a05:6122:2003:b0:4f5:1978:d23f with SMTP id
 71dfb90a1353d-4f51978d8c7mr2713643e0c.1.1721677047438; 
 Mon, 22 Jul 2024 12:37:27 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a19905ebf1sm393585485a.77.2024.07.22.12.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:37:26 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:37:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 7/9] migration/multifd: Isolate ram pages packet
 data
Message-ID: <Zp6089I1ozCg1Eaq@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 22, 2024 at 02:59:12PM -0300, Fabiano Rosas wrote:
> While we cannot yet disentangle the multifd packet from page data, we
> can make the code a bit cleaner by setting the page-related fields in
> a separate function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 97 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 61 insertions(+), 36 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index fcdb12e04f..d25b8658b2 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -409,65 +409,62 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>      return msg.id;
>  }
>  
> -void multifd_send_fill_packet(MultiFDSendParams *p)
> +static void multifd_ram_fill_packet(MultiFDSendParams *p)
>  {
>      MultiFDPacket_t *packet = p->packet;
>      MultiFDPages_t *pages = &p->data->u.ram;
> -    uint64_t packet_num;
>      uint32_t zero_num = pages->num - pages->normal_num;
> -    int i;
>  
> -    packet->flags = cpu_to_be32(p->flags);
>      packet->pages_alloc = cpu_to_be32(pages->allocated);
>      packet->normal_pages = cpu_to_be32(pages->normal_num);
>      packet->zero_pages = cpu_to_be32(zero_num);
> -    packet->next_packet_size = cpu_to_be32(p->next_packet_size);

Definitely good intention, but I had a feeling that this will need to be
reorganized again when Maciej reworks on top, due to the fact that
next_packet_size will be ram-private field, simply because it's defined
after pages_alloc and normal_pages...

E.g., see:

https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com

Where the new MultiFDPacketHdr_t cannot include next_packet_size (even if
VFIO will need that too..).

typedef struct {
    uint32_t magic;
    uint32_t version;
    uint32_t flags;
} __attribute__((packed)) MultiFDPacketHdr_t;

So _maybe_ it's easier we drop this patch and leave that part to Maciej to
identify which is common and which is arm/vfio specific.  No strong
opinions here.

> -
> -    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
> -    packet->packet_num = cpu_to_be64(packet_num);
>  
>      if (pages->block) {
>          strncpy(packet->ramblock, pages->block->idstr, 256);
>      }
>  
> -    for (i = 0; i < pages->num; i++) {
> +    for (int i = 0; i < pages->num; i++) {
>          /* there are architectures where ram_addr_t is 32 bit */
>          uint64_t temp = pages->offset[i];
>  
>          packet->offset[i] = cpu_to_be64(temp);
>      }
>  
> -    p->packets_sent++;
>      p->total_normal_pages += pages->normal_num;
>      p->total_zero_pages += zero_num;
> +}
>  
> -    trace_multifd_send(p->id, packet_num, pages->normal_num, zero_num,
> +void multifd_send_fill_packet(MultiFDSendParams *p)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    uint64_t packet_num;
> +
> +    memset(packet, 0, p->packet_len);
> +
> +    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> +    packet->version = cpu_to_be32(MULTIFD_VERSION);
> +
> +    packet->flags = cpu_to_be32(p->flags);
> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> +
> +    packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
> +    packet->packet_num = cpu_to_be64(packet_num);
> +
> +    p->packets_sent++;
> +
> +    multifd_ram_fill_packet(p);
> +
> +    trace_multifd_send(p->id, packet_num,
> +                       be32_to_cpu(packet->normal_pages),
> +                       be32_to_cpu(packet->zero_pages),
>                         p->flags, p->next_packet_size);
>  }
>  
> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +static int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp)
>  {
>      MultiFDPacket_t *packet = p->packet;
>      int i;
>  
> -    packet->magic = be32_to_cpu(packet->magic);
> -    if (packet->magic != MULTIFD_MAGIC) {
> -        error_setg(errp, "multifd: received packet "
> -                   "magic %x and expected magic %x",
> -                   packet->magic, MULTIFD_MAGIC);
> -        return -1;
> -    }
> -
> -    packet->version = be32_to_cpu(packet->version);
> -    if (packet->version != MULTIFD_VERSION) {
> -        error_setg(errp, "multifd: received packet "
> -                   "version %u and expected version %u",
> -                   packet->version, MULTIFD_VERSION);
> -        return -1;
> -    }
> -
> -    p->flags = be32_to_cpu(packet->flags);
> -
>      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
>      /*
>       * If we received a packet that is 100 times bigger than expected
> @@ -496,15 +493,9 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          return -1;
>      }
>  
> -    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> -    p->packet_num = be64_to_cpu(packet->packet_num);
> -    p->packets_recved++;
>      p->total_normal_pages += p->normal_num;
>      p->total_zero_pages += p->zero_num;
>  
> -    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
> -                       p->flags, p->next_packet_size);
> -
>      if (p->normal_num == 0 && p->zero_num == 0) {
>          return 0;
>      }
> @@ -546,6 +537,40 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      return 0;
>  }
>  
> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    int ret = 0;
> +
> +    packet->magic = be32_to_cpu(packet->magic);
> +    if (packet->magic != MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: received packet "
> +                   "magic %x and expected magic %x",
> +                   packet->magic, MULTIFD_MAGIC);
> +        return -1;
> +    }
> +
> +    packet->version = be32_to_cpu(packet->version);
> +    if (packet->version != MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: received packet "
> +                   "version %u and expected version %u",
> +                   packet->version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    p->flags = be32_to_cpu(packet->flags);
> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> +    p->packet_num = be64_to_cpu(packet->packet_num);
> +    p->packets_recved++;
> +
> +    ret = multifd_ram_unfill_packet(p, errp);
> +
> +    trace_multifd_recv(p->id, p->packet_num, p->normal_num, p->zero_num,
> +                       p->flags, p->next_packet_size);
> +
> +    return ret;
> +}
> +
>  static bool multifd_send_should_exit(void)
>  {
>      return qatomic_read(&multifd_send_state->exiting);
> -- 
> 2.35.3
> 

-- 
Peter Xu


