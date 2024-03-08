Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19FE6C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVCU-000385-RG; Fri, 08 Mar 2024 03:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVCS-00037b-Ft
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVCQ-00041i-Na
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lO2i7dT5FQfnWoP1fNGgXZsJc3HU7xp+EBhJmlj2m+g=;
 b=Wn22XEkFwgpxtgNCUdnEnf1i0aOTqYn0zTjS2gyiPMUAsDs4ELftMIA8tvbsR5E7U/1J1i
 BNKpywCxt8apMRZaRlQqgFnw5EOJN6baEpo8aM3GNV8jwqH828MUPmbRWbtD2STlCqT+8E
 4PqIBZ5dxaIoQj8NwLcqO57CmQ6W29Y=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-IHC8IcKNN9CcZjfiHuL5tQ-1; Fri, 08 Mar 2024 03:03:22 -0500
X-MC-Unique: IHC8IcKNN9CcZjfiHuL5tQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dd63773cf9so2850925ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:03:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885002; x=1710489802;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lO2i7dT5FQfnWoP1fNGgXZsJc3HU7xp+EBhJmlj2m+g=;
 b=T6SDdbhrV61Jdklttn5Ms031Iw38W+9GFnh1qqTUMBWvsyBb+YjbErkLvKBuvFzVum
 s5WD4eGLN0x5uHE+FWZQB2RhWxGD9w0LqBcn1+9KwtJtG4AIuDYDUVfORqMH9SV34b9X
 bu4duqjG5TFZDrINm7xoAQXbqx0f0X0jOggmP1v4DjK8NpItQQQNM7mA9pIVjVS1FR1P
 Pf/iyjESX/OnnIrGkbT2q8YR+/Jp0NhjHNCh0uu9bgxicr4z5QJ1KG04fA/d/stzPoZp
 p9/qxFZ8zRiojKijXIkcHWO1l78SDcsqpN/v7XcNpj10Pqy58f1oQvYvMpUaJrLZ1whO
 bLJQ==
X-Gm-Message-State: AOJu0YyZJ21E80tn22+3FjH4wj/jj9/vGgiiEuDS6HjLjAeeHVXCMb3U
 8niaw9AqRmfLdwMPeZjfTD9rZYZHEyd1zPsJiXMMjsklY/VQF4QeYhVYysgBdGXG8KpKyqstyl5
 qz7YjIAjukUH2ncBmqGN6I1U6O/SIKBYjOek/68TYpb74DkvZvsaD
X-Received: by 2002:a17:902:ee53:b0:1dc:3c:fb67 with SMTP id
 19-20020a170902ee5300b001dc003cfb67mr1430700plo.5.1709885001729; 
 Fri, 08 Mar 2024 00:03:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHARz7UrPxh34B3xVaSCGc1ropmxAvX/NEjIyysQp4LrwvvjRbTgCKub5Fv/i4pyTNySBFzAg==
X-Received: by 2002:a17:902:ee53:b0:1dc:3c:fb67 with SMTP id
 19-20020a170902ee5300b001dc003cfb67mr1430669plo.5.1709885001327; 
 Fri, 08 Mar 2024 00:03:21 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m10-20020a170902f20a00b001dd597d93casm2257766plc.130.2024.03.08.00.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:03:20 -0800 (PST)
Date: Fri, 8 Mar 2024 16:03:07 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 2/5] docs: include ramblock.h in the memory API docs
Message-ID: <ZerGO8Fq_sgSrun4@x1n>
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307181105.4081793-3-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 07, 2024 at 06:11:02PM +0000, Alex Bennée wrote:
> The RAMBlock concept is fairly central to RAM-like MemoryRegions so
> lets update the structure documentation and include in the docs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  docs/devel/memory.rst   |  1 +
>  include/exec/ramblock.h | 76 +++++++++++++++++++++++++++--------------
>  2 files changed, 52 insertions(+), 25 deletions(-)
> 
> diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
> index 69c5e3f914a..ed24708fce3 100644
> --- a/docs/devel/memory.rst
> +++ b/docs/devel/memory.rst
> @@ -369,4 +369,5 @@ callbacks are called:
>  API Reference
>  -------------
>  
> +.. kernel-doc:: include/exec/ramblock.h
>  .. kernel-doc:: include/exec/memory.h
> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 848915ea5bf..eb2416b6f66 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -24,68 +24,94 @@
>  #include "qemu/rcu.h"
>  #include "exec/ramlist.h"
>  
> +/**
> + * struct RAMBlock - represents a chunk of RAM
> + *
> + * RAMBlocks can be backed by allocated RAM or a file-descriptor. See
> + * @flags for the details. For the purposes of migration various book
> + * keeping and dirty state tracking elements are also tracked in this
> + * structure.
> + */
>  struct RAMBlock {
> +    /** @rcu: used for lazy free under RCU */
>      struct rcu_head rcu;
> +    /** @mr: parent MemoryRegion the block belongs to */
>      struct MemoryRegion *mr;
> +    /** @host: pointer to host address of RAM */
>      uint8_t *host;
> -    uint8_t *colo_cache; /* For colo, VM's ram cache */
> +    /** @colo_cache: For colo, VM's ram cache */
> +    uint8_t *colo_cache;
> +    /** @offset: offset into host backing store??? or guest address space? */

I think it's the first, or to be explicit, "ram_addr_t address space"?

>      ram_addr_t offset;
> +    /** @used_length: amount of store used */
>      ram_addr_t used_length;
> +    /** @max_length: for blocks that can be resized the max possible */
>      ram_addr_t max_length;
> +    /** @resized: callback notifier when block resized  */
>      void (*resized)(const char*, uint64_t length, void *host);
> +    /** @flags: see RAM_* flags in memory.h  */
>      uint32_t flags;
> -    /* Protected by the BQL.  */
> +    /** @idstr: Protected by the BQL.  */

Hmm, I think RCU should be enough to read an idstr?  Maybe as simple as:

@idstr: Name of the ramblock

?

>      char idstr[256];
> -    /* RCU-enabled, writes protected by the ramlist lock */
> +    /**
> +     * @next: next RAMBlock, RCU-enabled, writes protected by the
> +     * ramlist lock
> +     */
>      QLIST_ENTRY(RAMBlock) next;
> +    /** @ramblock_notifiers: list of RAMBlockNotifier notifiers */
>      QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
> +    /** @fd: fd of backing store if used */

Can also add: "For anonymous RAMBlocks, it's always -1".

>      int fd;
> +    /** @fd_offset: offset into the fd based backing store */
>      uint64_t fd_offset;
> +    /** @page_size: ideal page size of backing store*/

"ideal" might be a bit ambiguous.  How about "backend page size"?

For anon, it's always PAGE_SIZE, for file, it's the one reported in
fstatfs().  But this might be too verbose.

>      size_t page_size;
> -    /* dirty bitmap used during migration */
> +    /** @bmap:  dirty bitmap used during migration */
>      unsigned long *bmap;
>  
>      /*
>       * Below fields are only used by mapped-ram migration
>       */
> -    /* bitmap of pages present in the migration file */
> +
> +    /** @file_bmap: bitmap of pages present in the migration file  */

Can append "(only used in mapped-ram migrations)".  This may also apply to
below two fields.

>      unsigned long *file_bmap;
> -    /*
> -     * offset in the file pages belonging to this ramblock are saved,
> -     * used only during migration to a file.
> -     */
> +    /** @bitmap_offset: offset in the migration file of the bitmaps */

s/bitmaps/bitmap/, as there's only one for each rb.

>      off_t bitmap_offset;
> +    /** @pages_offset: offset in the migration file of the pages */
>      uint64_t pages_offset;
>  
> -    /* bitmap of already received pages in postcopy */
> +    /** @receivedmap: bitmap of already received pages in postcopy */
>      unsigned long *receivedmap;
>  
> -    /*
> -     * bitmap to track already cleared dirty bitmap.  When the bit is
> -     * set, it means the corresponding memory chunk needs a log-clear.
> -     * Set this up to non-NULL to enable the capability to postpone
> -     * and split clearing of dirty bitmap on the remote node (e.g.,
> -     * KVM).  The bitmap will be set only when doing global sync.
> +    /**
> +     * @clear_bmap: bitmap to track already cleared dirty bitmap. When
> +     * the bit is set, it means the corresponding memory chunk needs a
> +     * log-clear. Set this up to non-NULL to enable the capability to
> +     * postpone and split clearing of dirty bitmap on the remote node
> +     * (e.g., KVM). The bitmap will be set only when doing global
> +     * sync.
>       *
>       * It is only used during src side of ram migration, and it is
>       * protected by the global ram_state.bitmap_mutex.
>       *
>       * NOTE: this bitmap is different comparing to the other bitmaps
>       * in that one bit can represent multiple guest pages (which is
> -     * decided by the `clear_bmap_shift' variable below).  On
> +     * decided by the @clear_bmap_shift variable below).  On
>       * destination side, this should always be NULL, and the variable
> -     * `clear_bmap_shift' is meaningless.
> +     * @clear_bmap_shift is meaningless.
>       */
>      unsigned long *clear_bmap;
> +    /** @clear_bmap_shift: number pages each @clear_bmap bit represents */
>      uint8_t clear_bmap_shift;
>  
> -    /*
> -     * RAM block length that corresponds to the used_length on the migration
> -     * source (after RAM block sizes were synchronized). Especially, after
> -     * starting to run the guest, used_length and postcopy_length can differ.
> -     * Used to register/unregister uffd handlers and as the size of the received
> -     * bitmap. Receiving any page beyond this length will bail out, as it
> -     * could not have been valid on the source.
> +    /**
> +     * @postcopy_length: RAM block length that corresponds to the
> +     * @used_length on the migration source (after RAM block sizes
> +     * were synchronized). Especially, after starting to run the
> +     * guest, @used_length and @postcopy_length can differ. Used to
> +     * register/unregister uffd handlers and as the size of the
> +     * received bitmap. Receiving any page beyond this length will
> +     * bail out, as it could not have been valid on the source.
>       */
>      ram_addr_t postcopy_length;
>  };
> -- 
> 2.39.2
> 

-- 
Peter Xu


