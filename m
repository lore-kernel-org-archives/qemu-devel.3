Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B76C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgp0t-0000gt-TA; Mon, 06 Jul 2026 15:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgp0s-0000gj-MM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgp0r-0006uD-0r
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 15:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783366191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mXlYjUzgj0fHVEy7jhJq8F2muQXWUgs9LV72MMLnjK0=;
 b=EK8K9OTdvFDeoRZBB79ffQmEN+oEiFuDL7kb+qoaFkTc1xk6zhJVYhIU8hm2vHMXb0J1YT
 oxPn6pQCAhS+PZPjhDjaQxGmUh91uPXQo+nmUquq2T7dVQ0cB/7wa2xPImUMah+5B4aOFi
 VbeOtkVVbH+RPI6C5NbBN85SgA/Gbxc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-pwckdFtINFSADzRbwG3MGw-1; Mon, 06 Jul 2026 15:29:49 -0400
X-MC-Unique: pwckdFtINFSADzRbwG3MGw-1
X-Mimecast-MFC-AGG-ID: pwckdFtINFSADzRbwG3MGw_1783366189
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0ab07320so30848511cf.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783366189; x=1783970989; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mXlYjUzgj0fHVEy7jhJq8F2muQXWUgs9LV72MMLnjK0=;
 b=DjGWkyIj4S8nspCdmBMNih2ifwFFSWUl8tp1WNrn0LOfOItYHJyo5QGRM7OJLDzU71
 inooSt6+A//yWQM0iMi+1vZGZZRO/u6asEKu4hu1v0dEySNAAvq92TznW9z8VMo/1IPF
 ehUaKIx6ShUTlSpEHotGIxgGVx6+5zSlQCppv4eZph4wxasQUDYQRVBDzfMib08owkEo
 D0eesxlISqZtnlCiZ3CwLCMJVJkdcd8BGNjXuZ3WPMCGTTWaqbQrDxbbyhxSOnAbC4mb
 yBKS0sZ06kTZKscBNjtHdwenpgxSYLU28gox9FqnqvKi0wqs8D0Ce41L76gYCNoqiaZr
 7iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783366189; x=1783970989;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mXlYjUzgj0fHVEy7jhJq8F2muQXWUgs9LV72MMLnjK0=;
 b=mc4HABR2URvN5tRCvX7FcmX22EeK9mVzagqpKQvDkIvk7jVLjVBlctRj6M8/XeVUkr
 vZ9WYDmFFIflAEM4ZLQQw3k56iazaZMPBgmYbGpBXxNlQqzisXsM3O4Z8z2RiBSfX/j1
 Hvu9qq5dXWFSbruaebQHTNYgBYLTiPZ7Xf+G1ZeXxSJ9LJVgsE3IRa8HHZcQKnUZyp5F
 OrWk+tdg5e4Sii5RzG+VpxCm6ZRs3NhTiBr+gi//I/4aVfV0loA9N2BtYkdTLZyrkNks
 cvHhGv8KQ/EdLL4+Vxh4guID+6LrZnqYuMw62TqYIpD33zgPGAeQvNicraMhVNVJbPq5
 OvTA==
X-Gm-Message-State: AOJu0Yz/sCqxvjaivl5jfZCp+N1aVg6saEzAVdj62x61Y4yiuawU6wBP
 dnDozv89NOWtBfuzd0CpPHGARNoFwM2UFFA6+ZsOhf30nqIivd7oOZ9wac8vF+d67LjTF1x9JPe
 DnGOM5DT8i6x3Vh2GSVtCxwWPsVd6eASlukuppQQWW0Lt0EhbqEAIOOA0
X-Gm-Gg: AfdE7cn+aTfuXOZ13VA2bI75JgVSRSSHkt59H33kiJ6qMjwcTjpYpbcRSJxIccFLwkh
 aqyt+P3K3HjVS9yTma96cg1wkuYX8YdjyXBWB47mQw0y9uyX7WCao4t6W9mHYArrWRYl2iljUsR
 fj+O6hdJ/Mk7ldJOdv4GLh01F3FqXxt/Vvb/6+Yj4OVkWrqHItb5kyfQCBDp3LIfyZxPlS5KJkO
 JG31b+rsnN/okszM6/WdYzURv+PZ5auJHy18xINILV4taRoFT9Cl/vb54DHQPApEnV/kiD//lmx
 pEZxD5d+LtnSgYa51wOCnK449sv57fnkZUyl7CzMihqR7x+CgrBggq1TUX/FadOp8mM8XqbbQeK
 U71xnb837IUtYNGb9g0Xsl6eK/j2jEhqwZj3ocYwumVHn1tpFUjkjqbWFVCu/A1XqKthWMg==
X-Received: by 2002:ac8:594b:0:b0:51c:1daf:1978 with SMTP id
 d75a77b69052e-51c74853490mr24420191cf.54.1783366189021; 
 Mon, 06 Jul 2026 12:29:49 -0700 (PDT)
X-Received: by 2002:ac8:594b:0:b0:51c:1daf:1978 with SMTP id
 d75a77b69052e-51c74853490mr24419751cf.54.1783366188441; 
 Mon, 06 Jul 2026 12:29:48 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c41d2ac6esm96990571cf.19.2026.07.06.12.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 12:29:47 -0700 (PDT)
Date: Mon, 6 Jul 2026 15:29:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 3/7] migration: Use file_bmap for RAMBlock during
 incoming file load
Message-ID: <akwCJYxBS113ZKvH@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-4-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-4-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 30, 2026 at 01:49:36PM +0530, Aadeshveer Singh wrote:
> Replace the temporary bitmap with the existing file_bmap attribute of
> the RAMBlock. This acts as a preparatory change for the upcoming fast
> snapshot load feature.
> 
> Reusing this bitmap allows the destination to track page types during
> a postcopy load, enabling faster, direct placement of zero pages.
> 
> Since file_bmap is currently only utilized during the migration save
> phase, it can be safely repurposed during the load phase without
> introducing conflicts.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/ram.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index fc38ffbf8a..4728f14d73 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -252,6 +252,17 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
>      return ret;
>  }
>  
> +static void ramblock_file_bmap_init(void)
> +{
> +    RAMBlock *rb;
> +
> +    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> +        assert(!rb->file_bmap);
> +        size_t size = rb->max_length >> qemu_target_page_bits();

Hmm, I just notice mapped-ram always use guest psize for its bitmap.. even
for huge pages.  In that case this is correct.

> +        rb->file_bmap = bitmap_new(size);
> +    }
> +}
> +
>  static void ramblock_recv_map_init(void)
>  {
>      RAMBlock *rb;
> @@ -3749,6 +3760,9 @@ static int ram_load_setup(QEMUFile *f, void *opaque, Error **errp)
>  {
>      xbzrle_load_setup();
>      ramblock_recv_map_init();
> +    if (migrate_mapped_ram()) {
> +        ramblock_file_bmap_init();
> +    }
>  
>      return 0;
>  }
> @@ -3766,8 +3780,8 @@ static int ram_load_cleanup(void *opaque)
>      xbzrle_load_cleanup();
>  
>      RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
> -        g_free(rb->receivedmap);
> -        rb->receivedmap = NULL;
> +        g_clear_pointer(&rb->receivedmap, g_free);
> +        g_clear_pointer(&rb->file_bmap, g_free);
>      }
>  
>      return 0;
> @@ -4142,11 +4156,18 @@ err:
>  static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>                                        ram_addr_t length, Error **errp)
>  {
> -    g_autofree unsigned long *bitmap = NULL;
>      MappedRamHeader header;
>      size_t bitmap_size;
>      long num_pages;
>  
> +    if (length > block->max_length) {
> +        error_setg(errp,
> +                   "mapped-ram header length %" PRIu64 " exceeds "
> +                   "RAMBlock(\"%s\") max_length %" PRIu64,
> +                   (uint64_t)length, block->idstr, (uint64_t)block->max_length);
> +        return;
> +    }
> +
>      if (!mapped_ram_read_header(f, &header, errp)) {
>          return;
>      }
> @@ -4174,14 +4195,14 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
>      num_pages = length / header.page_size;
>      bitmap_size = BITS_TO_LONGS(num_pages) * sizeof(unsigned long);

Here I think it would still be good to check the page_size is the same as
what was expected (in this case, guest page size), otherwise we should fail
because then the bitmap_size may still be unpredictable and it can cause
illegal access (beyond the size of bitmap allocated) in worst case.

Now I start to wonder when you're working on huge pages with the feature,
did you stick with the bmap having guest page size, or did you modify it to
be host page size?

Thanks,

>  
> -    bitmap = g_malloc0(bitmap_size);
> -    if (qemu_get_buffer_at(f, (uint8_t *)bitmap, bitmap_size,
> +    if (qemu_get_buffer_at(f, (uint8_t *)block->file_bmap, bitmap_size,
>                             header.bitmap_offset) != bitmap_size) {
>          error_setg(errp, "Error reading dirty bitmap");
>          return;
>      }
>  
> -    if (!read_ramblock_mapped_ram(f, block, num_pages, bitmap, errp)) {
> +    if (!read_ramblock_mapped_ram(f, block, num_pages, block->file_bmap,
> +                                  errp)) {
>          return;
>      }
>  
> -- 
> 2.54.0
> 

-- 
Peter Xu


