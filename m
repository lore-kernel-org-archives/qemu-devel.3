Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209B9C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 20:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgs6K-00050J-6w; Wed, 21 Aug 2024 16:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgs6I-0004zp-GT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sgs6G-0006Vz-KL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 16:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724272714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4hvQg5GQ4SY+vSlBFOCFQH7UrqNtvEZ298pRAjGJuiY=;
 b=JNj5hQxEE+DVNOM9e3WkmEhp+KLFQUUxoAqoaScWC3C2hYY84kByO5f7k3oz2H6x32SVB6
 XN47hql2uZZ1+/DC9thC1u7nU3CjfwAZZYN5UXJ4dPwDt3W4w4Rf49sFbMOpRh2dGQnQEy
 OJvioJ2MMbQ+2Noyw+5NrLOqVZeHbng=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-EJPegfxiNJueeqJ8592_AA-1; Wed, 21 Aug 2024 16:38:31 -0400
X-MC-Unique: EJPegfxiNJueeqJ8592_AA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7a1dbbe6d6fso14617785a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 13:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724272710; x=1724877510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hvQg5GQ4SY+vSlBFOCFQH7UrqNtvEZ298pRAjGJuiY=;
 b=nTy5gm+hqEFlgbqo9WR0S1iTcpLVJeWXRlSA/ThDemM19C+P4K0IRrbfXDwaU8HWXK
 kxmTFvdYIitB6eVzbUbD3NBUMsybHrwZY/RhRiGFuAB2BCFYPjDWxn/sbGnk4ssiJJWK
 f+M3igZlTgxsErlOyVBnyD0k8qYSEhF2OSXphujypDFZoZJ7KbGlcnqfKPYEExxDTpqh
 h1EJeRiAhlf/NyYmT1ZVBAJfOCFnK/b9BRTHG6iuIVjOWrCPB/aBOc3TVRHVHuUIj1xx
 KTtExe5SCL/N3ADzTCrnu9yUlenrtCxKl17Upwpta/pyV6cht2Kc+OwsXjafBG+YTqx3
 CrMg==
X-Gm-Message-State: AOJu0Yy5Fuvf/AAkhoTGL8w70tZ2Pp3f1LcH6HVP1I/++kTm2neJ6/R3
 ixH0xyYBIgrc4r15yeiXLWe9PswX3TJNRGJfafCCSNeBScrxguUoE6OD7UKzTbR1Bkk5LcVgDAh
 tlqy+ohcEQPsVgUft23nV5cqGX6WvZ5ymSUFoKw/NufiEXAi3mFXOFjbTByOT
X-Received: by 2002:a05:6214:4301:b0:6bf:86d7:3a2d with SMTP id
 6a1803df08f44-6c155d6753emr47685666d6.20.1724272710346; 
 Wed, 21 Aug 2024 13:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc3H4O707r9KM2uBqrDdPUC2xVPQF4KCn1TafEKgZCZedWkcxnRuNwAKTNcOF99UZebjk8kg==
X-Received: by 2002:a05:6214:4301:b0:6bf:86d7:3a2d with SMTP id
 6a1803df08f44-6c155d6753emr47685416d6.20.1724272709905; 
 Wed, 21 Aug 2024 13:38:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d61f0bsm604746d6.57.2024.08.21.13.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 13:38:28 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:38:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 06/14] migration/multifd: Make MultiFDPages_t:offset a
 flexible array member
Message-ID: <ZsZQQjeiBzxmX88z@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801123516.4498-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 01, 2024 at 09:35:08AM -0300, Fabiano Rosas wrote:
> We're about to use MultiFDPages_t from inside the MultiFDSendData
> payload union, which means we cannot have pointers to allocated data
> inside the pages structure, otherwise we'd lose the reference to that
> memory once another payload type touches the union. Move the offset
> array into the end of the structure and turn it into a flexible array
> member, so it is allocated along with the rest of MultiFDSendData in
> the next patches.
> 
> Note that other pointers, such as the ramblock pointer are still fine
> as long as the storage for them is not owned by the migration code and
> can be correctly released at some point.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Two nits below..

> ---
>  migration/multifd.c | 18 ++++++++++++------
>  migration/multifd.h |  4 ++--
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 44d4c3ca11..64503604cf 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -98,6 +98,17 @@ struct {
>      MultiFDMethods *ops;
>  } *multifd_recv_state;
>  
> +static size_t multifd_ram_payload_size(void)
> +{
> +    uint32_t n = multifd_ram_page_count();
> +
> +    /*
> +     * We keep an array of page offsets at the end of MultiFDPages_t,
> +     * add space for it in the allocation.
> +     */
> +    return sizeof(MultiFDPages_t) + n * sizeof(ram_addr_t);
> +}
> +
>  static bool multifd_use_packets(void)
>  {
>      return !migrate_mapped_ram();
> @@ -394,9 +405,7 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>  
>  static MultiFDPages_t *multifd_pages_init(uint32_t n)
>  {
> -    MultiFDPages_t *pages = g_new0(MultiFDPages_t, 1);
> -
> -    pages->offset = g_new0(ram_addr_t, n);
> +    MultiFDPages_t *pages = g_malloc0(multifd_ram_payload_size());
>  
>      return pages;

Can drop the temp var now.

>  }
> @@ -404,8 +413,6 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
>  static void multifd_pages_clear(MultiFDPages_t *pages)
>  {
>      multifd_pages_reset(pages);
> -    g_free(pages->offset);
> -    pages->offset = NULL;
>      g_free(pages);
>  }
>  
> @@ -1185,7 +1192,6 @@ bool multifd_send_setup(void)
>          qemu_sem_init(&p->sem_sync, 0);
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> -

Unneeded removal.

>          if (use_packets) {
>              p->packet_len = sizeof(MultiFDPacket_t)
>                            + sizeof(uint64_t) * page_count;
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 7bb4a2cbc4..a7fdd97f70 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -77,9 +77,9 @@ typedef struct {
>      uint32_t num;
>      /* number of normal pages */
>      uint32_t normal_num;
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


