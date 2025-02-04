Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF4C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 17:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMQq-0006Y8-KY; Tue, 04 Feb 2025 12:09:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMQl-0006Lg-0v
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:09:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfMQi-0007aI-Gd
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 12:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738688983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MixZuTPd0vMsw7h9RgZuz45+Lso91h1jNJV5awYBfHA=;
 b=E+4+eKI6irfissx2BQoOYEaQkdsx1BBSRUEnj2PBhY0M6PXTJKWvIGwMZHQXIf/5ETSEAi
 OKHW2xvBULCIDCsAXuh4dhO1RQZ4kWa7KfkTWkI6RUl6NG3ZYKWY0zX1w3t4nV/KDXysay
 DVNaANkPndX5f/+Uv8N1So/WGhGvHSk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-FnJ4IVrsOUy5epfhGA57jw-1; Tue, 04 Feb 2025 12:09:40 -0500
X-MC-Unique: FnJ4IVrsOUy5epfhGA57jw-1
X-Mimecast-MFC-AGG-ID: FnJ4IVrsOUy5epfhGA57jw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46798d74f0cso114411061cf.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 09:09:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738688979; x=1739293779;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MixZuTPd0vMsw7h9RgZuz45+Lso91h1jNJV5awYBfHA=;
 b=QE+KiWS5JKlDcEHIytBtPa1IOm/ruBVYSBzy1AnUFIDB8h3YiyKizsZ10DHrSYD7aQ
 i3aZrkeU12RCaBME9sw4Q4S/C/Ohv53mJ70AHEblcmuVI3mBggYhyrTej7FbUm5MhOKn
 05ho08N8UjNY/jM5QtvF8/xNM9IDHveFqsHK3rIpIpuGLzXffA6fXwwreJd5Mz4hcC/0
 jR2lLiyCcdNTT9icpln115cpkzI+Ez6zy2c3S4saqQ51lF7afXxy850UGMAGTW6dabLH
 BBbwL25f130U7RsCdM8zDQ6w2zEmRxjJSkLJKJUZwHMbcCkmXu6KlW9ulEzfXSuTKm5T
 ZaaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6ff+A+sFPqGoRjFiJnLJexV8m5lbBvEKwK4fTm09YhJfW05YMotiEQaumH6lEXy2WKvPkzH17QQyf@nongnu.org
X-Gm-Message-State: AOJu0YyRbhBoR1Nezsg20FXlTwkXouy+Fok0xUG7+UzbZpHaE6rX/htr
 CLS2JUj6FJY7NdOrEn0CkUt9bXpKBftXcFPwH1l6TZiULRKTZktwnbvcN7avpqFMfG2MylJ2REK
 ATTYwfshcxh3Zqn6UlYIlvDC1hhrp1Iuub1zIs/pLz/9b8y+Y7+00
X-Gm-Gg: ASbGnctYFhUDNNpzmibgg65AiplotobFkiJwz5QEjeXOrq1ZWRqemD2WxMRWvPGYiGu
 P8i5/nqSdO26SQYPLTShrFTlk5UupMupR89UNLj+ojkazGPfhp0IEcWfjL1vUy5osBtaLXQhht/
 GXvlxJwErxG5SY/obabocPtA8Bj7TSdYL2kvb9kB2koWKYkylGoiYee6OZbJ6xbWjyn9gTZEu0m
 NFiMeXWUOXo7FiblbX+KITxuyqPe8WbJlOtmo34iHwpUuEH1kSVb1I8IVx8c9iAJv9+cwFNpgHg
 tFTUYb6Rd3mmMJS6RjtRVfDVbQQISr5JDPFdJMr6vmymS2xQ
X-Received: by 2002:a05:622a:1e8c:b0:466:a308:292c with SMTP id
 d75a77b69052e-46fd0b6f3dbmr421300271cf.32.1738688979509; 
 Tue, 04 Feb 2025 09:09:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXKpGyny5yszYPGxO1L8KpdaLn3zBgJgFYl9aN2bthczbWuJ+WK9AMia+mq+ibrmkoydDEDA==
X-Received: by 2002:a05:622a:1e8c:b0:466:a308:292c with SMTP id
 d75a77b69052e-46fd0b6f3dbmr421299861cf.32.1738688979137; 
 Tue, 04 Feb 2025 09:09:39 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0a72d4sm60457551cf.13.2025.02.04.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:09:38 -0800 (PST)
Date: Tue, 4 Feb 2025 12:09:37 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc: david@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 2/6] system/physmem: poisoned memory discard on reboot
Message-ID: <Z6JJ0fDjkttUcW7n@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-3-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201095726.3768796-3-william.roche@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Feb 01, 2025 at 09:57:22AM +0000, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Repair poisoned memory location(s), calling ram_block_discard_range():
> punching a hole in the backend file when necessary and regenerating
> a usable memory.
> If the kernel doesn't support the madvise calls used by this function
> and we are dealing with anonymous memory, fall back to remapping the
> location(s).
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  system/physmem.c | 58 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 3dd2adde73..e8ff930bc9 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2167,6 +2167,23 @@ void qemu_ram_free(RAMBlock *block)
>  }
>  
>  #ifndef _WIN32
> +/* Simply remap the given VM memory location from start to start+length */
> +static int qemu_ram_remap_mmap(RAMBlock *block, uint64_t start, size_t length)
> +{
> +    int flags, prot;
> +    void *area;
> +    void *host_startaddr = block->host + start;
> +
> +    assert(block->fd < 0);
> +    flags = MAP_FIXED | MAP_ANONYMOUS;
> +    flags |= block->flags & RAM_SHARED ? MAP_SHARED : MAP_PRIVATE;
> +    flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
> +    prot = PROT_READ;
> +    prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
> +    area = mmap(host_startaddr, length, prot, flags, -1, 0);
> +    return area != host_startaddr ? -errno : 0;
> +}
> +
>  /*
>   * qemu_ram_remap - remap a single RAM page
>   *
> @@ -2184,9 +2201,7 @@ void qemu_ram_remap(ram_addr_t addr)
>  {
>      RAMBlock *block;
>      uint64_t offset;
> -    int flags;
> -    void *area, *vaddr;
> -    int prot;
> +    void *vaddr;
>      size_t page_size;
>  
>      RAMBLOCK_FOREACH(block) {
> @@ -2201,25 +2216,24 @@ void qemu_ram_remap(ram_addr_t addr)
>                  ;
>              } else if (xen_enabled()) {
>                  abort();
> -            } else {

Do we need to keep this line?  Otherwise it looks to me the new code won't
be executed at all in !xen..

> -                flags = MAP_FIXED;
> -                flags |= block->flags & RAM_SHARED ?
> -                         MAP_SHARED : MAP_PRIVATE;
> -                flags |= block->flags & RAM_NORESERVE ? MAP_NORESERVE : 0;
> -                prot = PROT_READ;
> -                prot |= block->flags & RAM_READONLY ? 0 : PROT_WRITE;
> -                if (block->fd >= 0) {
> -                    area = mmap(vaddr, page_size, prot, flags, block->fd,
> -                                offset + block->fd_offset);
> -                } else {
> -                    flags |= MAP_ANONYMOUS;
> -                    area = mmap(vaddr, page_size, prot, flags, -1, 0);
> -                }
> -                if (area != vaddr) {
> -                    error_report("Could not remap RAM %s:%" PRIx64 "+%" PRIx64
> -                                 " +%zx", block->idstr, offset,
> -                                 block->fd_offset, page_size);
> -                    exit(1);
> +                if (ram_block_discard_range(block, offset, page_size) != 0) {
> +                    /*
> +                     * Fall back to using mmap() only for anonymous mapping,
> +                     * as if a backing file is associated we may not be able
> +                     * to recover the memory in all cases.
> +                     * So don't take the risk of using only mmap and fail now.
> +                     */
> +                    if (block->fd >= 0) {
> +                        error_report("Could not remap RAM %s:%" PRIx64 "+%"
> +                                     PRIx64 " +%zx", block->idstr, offset,
> +                                     block->fd_offset, page_size);
> +                        exit(1);
> +                    }
> +                    if (qemu_ram_remap_mmap(block, offset, page_size) != 0) {
> +                        error_report("Could not remap RAM %s:%" PRIx64 " +%zx",
> +                                     block->idstr, offset, page_size);
> +                        exit(1);
> +                    }
>                  }
>                  memory_try_enable_merging(vaddr, page_size);
>                  qemu_ram_setup_dump(vaddr, page_size);
> -- 
> 2.43.5
> 

-- 
Peter Xu


