Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DF5C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 19:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVyaj-00052J-AR; Mon, 22 Jul 2024 15:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVyab-00050v-Vu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sVyaY-0002FJ-J0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 15:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721676046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e/TlYlFT8xm8GieNvajJ4Ef+s3Au0OCYnUDjMN/sZ5A=;
 b=HDSgNtW7HjHEJ+d5bCHTMghMcTR5NzBX0FI1nnk4mtvrcGLMs+DM6e56bI81RpA3Qn2dW9
 86YkHAuZJpf4d5jEL4KKn/L6IrloL0C1mt7OsTV4woOI6eeNSKGRmoTkH+2pE1IDXv8r1n
 JJ4/peYYx8aBcbxoGo2BHZSb/5SPX8Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-KCd_q_yVODyQR80-QkYdNA-1; Mon, 22 Jul 2024 15:20:45 -0400
X-MC-Unique: KCd_q_yVODyQR80-QkYdNA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b7a0e7b823so14368046d6.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 12:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721676044; x=1722280844;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/TlYlFT8xm8GieNvajJ4Ef+s3Au0OCYnUDjMN/sZ5A=;
 b=QTDB6BRQT6Ae1SArOm70XhUjtY1bjmbBYt5hB35TbcI1Sd9OBc5ZkfxGlgX1mYLlIh
 waLMpM50d+mqLdJXEqzX8cdDkIkvqt6D9NW769TLu/qACP9U3lNzEUH9htzcU/6jlDnq
 RCstyRfDUCVb+wrwJJl0U1NDj8kYbGMRVwKGlc9BuZhOyvk3U0JDBfUl8jNX4gzjedw6
 9+Z5SSskH3Av7/Jvhm38Co0XGMXltASxU6sANNAr+/8owZXyGZPlvRpiGBvXLloNkMjK
 KcyLZdSHmjKcIkCeolRwsxWBiZpLYazXiq1rOcm+lGDEp1rY/UrHuCwOauSkZH4Av5dC
 UskQ==
X-Gm-Message-State: AOJu0YyF4x+u0RLKinvfk9B89QvAQBISBXqi5CvbQYQt0fJn5/2wFaYr
 apxor4LOpxVI8FNFqOrAZWqYZTf013A5btOJSVbxoQxdNLJRBnAJ6niu7J+07HN1ZwKcuEN0lr0
 iXjeVsJv3IBZhJj8OMacKT5WAm4NH1Yg/Rzu13j6x+VAu9CRidXxZ
X-Received: by 2002:a05:620a:d85:b0:79f:190a:8ad0 with SMTP id
 af79cd13be357-7a1a1334f8amr716732185a.3.1721676044395; 
 Mon, 22 Jul 2024 12:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVVy5VjEZ0gdSI3cRnA/u7KT7kjPtnjuU0lk4Hl4ruqTSb/LPB9dFPUKDtkKaZ5sHAX0TnMg==
X-Received: by 2002:a05:620a:d85:b0:79f:190a:8ad0 with SMTP id
 af79cd13be357-7a1a1334f8amr716731085a.3.1721676044020; 
 Mon, 22 Jul 2024 12:20:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198fbfec8sm386084085a.54.2024.07.22.12.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 12:20:43 -0700 (PDT)
Date: Mon, 22 Jul 2024 15:20:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 4/9] migration/multifd: Make MultiFDPages_t:offset
 a flexible array member
Message-ID: <Zp6xCcenvrQfqDOn@x1n>
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240722175914.24022-5-farosas@suse.de>
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

On Mon, Jul 22, 2024 at 02:59:09PM -0300, Fabiano Rosas wrote:
> We're about to use MultiFDPages_t from inside the MultiFDSendData
> payload union, which means we cannot have pointers to allocated data
> inside the pages structure, otherwise we'd lose the reference to that
> memory once another payload type touches the union. Move the offset
> array into the end of the structure and turn it into a flexible array
> member, so it is allocated along with the rest of MultiFDSendData in
> the next patches.
> 
> Note that the ramblock pointer is still fine because the storage for
> it is not owned by the migration code.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/multifd.c | 21 ++++++---------------
>  migration/multifd.h |  4 ++--
>  2 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 20a767157e..440319b361 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -389,22 +389,10 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>      return msg.id;
>  }
>  
> -static MultiFDPages_t *multifd_pages_init(uint32_t n)
> -{
> -    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
> -
> -    pages->allocated = n;
> -    pages->offset = g_new0(ram_addr_t, n);
> -
> -    return pages;
> -}

Considering this is the tricky object to allocate here, shall we keep the
function just for readability (and already dedups below two callers)?  With
it, someone else will notice g_new0() stops working for MultiFDPages_t.
Some verbose comment would be nice too.

Maybe we can also move multifd_ram_payload_size() from the next patch to
here.

> -
>  static void multifd_pages_clear(MultiFDPages_t *pages)
>  {
>      multifd_pages_reset(pages);
>      pages->allocated = 0;
> -    g_free(pages->offset);
> -    pages->offset = NULL;
>      g_free(pages);
>  }
>  
> @@ -1169,7 +1157,9 @@ bool multifd_send_setup(void)
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> -    multifd_send_state->pages = multifd_pages_init(page_count);
> +    multifd_send_state->pages = g_malloc0(sizeof(MultiFDPages_t) +
> +                                          page_count * sizeof(ram_addr_t));
> +    multifd_send_state->pages->allocated = page_count;
>      qemu_sem_init(&multifd_send_state->channels_created, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);
>      qatomic_set(&multifd_send_state->exiting, 0);
> @@ -1181,8 +1171,9 @@ bool multifd_send_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
> -        p->pages = multifd_pages_init(page_count);
> -
> +        p->pages = g_malloc0(sizeof(MultiFDPages_t) +
> +                             page_count * sizeof(ram_addr_t));
> +        p->pages->allocated = page_count;
>          if (use_packets) {
>              p->packet_len = sizeof(MultiFDPacket_t)
>                            + sizeof(uint64_t) * page_count;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index c7b1ebe099..12d4247e23 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -78,9 +78,9 @@ typedef struct {
>      uint32_t normal_num;
>      /* number of allocated pages */
>      uint32_t allocated;
> +    RAMBlock *block;
>      /* offset of each page */
> -    ram_addr_t *offset;
> -    RAMBlock *block;
> +    ram_addr_t offset[];
>  } MultiFDPages_t;
>  
>  struct MultiFDRecvData {
> -- 
> 2.35.3
> 

-- 
Peter Xu


