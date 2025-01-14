Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A0DE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhaj-0002wr-6O; Tue, 14 Jan 2025 09:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhaT-0002un-RL
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:08:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhaQ-0004VE-6g
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736863684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bq4gpVCuWRxilqmmULIZ76664+bjXBB++jnvhJ0jtQI=;
 b=X2k2fFi0cCaBB3Ylb9jD6fAujgsGZSLs2gjzGX6pUEhsp3HmSLxHVI9P3kHOllIUbZLX5C
 sqpXEwNlsUbI89U5LZjWcqammGooI+fErQDLqAOV4mdlVZ218u1ZqEbHINaHbGwYnvbLG2
 fEN8h92AtFOA5cRzcyjzqSQc69fLKAM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-LaTW-FBjOxKFT4-FeVKuiQ-1; Tue, 14 Jan 2025 09:08:03 -0500
X-MC-Unique: LaTW-FBjOxKFT4-FeVKuiQ-1
X-Mimecast-MFC-AGG-ID: LaTW-FBjOxKFT4-FeVKuiQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d51ba2f5so2772029f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736863682; x=1737468482;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bq4gpVCuWRxilqmmULIZ76664+bjXBB++jnvhJ0jtQI=;
 b=iX28oyfX57FbS6/4XMgqWurZjikiOKdlRAFtVSfXgA2pX44TLq2zFclGqxof/C5uSU
 vYUPG2OZaaG4w+lFaOZA8/pmDipnboudlj7HXXOvgz3jeWjJ4amO+K9m+xsVLuqt+Zbf
 BXsUS2gm/694a4diIsV4Zf7f5PWAb1LuS6Ufz3/Fbs3lbAUz84qUwtO7+2MSThCCDSQk
 qlmxfQ8yrbzwrt7joEdD37zUvL5hQUgnq7a+BIXZts7n4K/5Zav8bHpajB+xYqi0PxVC
 oBE5VPHQPMQc43XU/YYXAkoegGs6dT6fFFFkJbW73MqFECZHYvfjvZsW8py034cgU9Po
 c6zQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB+0Ofw4S/l4x7kuqjxHurnFJ38Er3vosQ+72EiaN5KtwXsVj7YM1ju88j7OzqlvENPn7loepDzBE9@nongnu.org
X-Gm-Message-State: AOJu0YwXm8H7IGG+vchivdW0ek7dRkXioL8EaHGBCkK/vTveu0WkEG5S
 6gIuoPZx/RD+JBPhigVQbgOpzNGI+yYgFwDC/9tSnIZyTzN50mxieRqC9wUvX2pycgC8n+qu4O9
 o/Z0QXOVWXdrcKk7gx+LO4gPqKskaAgTQeJtdQMVkMhGUJnCl9Mbu
X-Gm-Gg: ASbGncsVBFBLLcEY35YXUpZ3gXn8VLn0iJ1UXYUJ6ayudwtBcV3Nmz9ZU4p2xC7oFG8
 /il7dzAFOqeh5EDguFnsUfih7oqekm5imtQPmAzNDygwqDZfW/FoiUeV95+gnMm+m5v54Lxpz2B
 MyPlKgOXzISLCsK7hzWzblO5qWGBsS0QwUTvd+CeJxZPPwDaER3hTLYbQHPw/1NNIRqm2cKsZX9
 UycooypEXaCGQC05w4a1t/ZqNvhMBBC+pHC78Wv8llYFIwAfwcCixdfn/VPbV5hnp+d+8VIqW6m
 CuZbPpOFzAea9FTjXu0EAEIHXpDvB3JeROF0PsdDU59f5Tz/t55aoGw8DzenJrgbs3x6h05iOxx
 rkJOx+ZA6
X-Received: by 2002:a05:6000:1847:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-38a8730a60cmr23977246f8f.25.1736863681037; 
 Tue, 14 Jan 2025 06:08:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9xEqCaeRyof0lCkuoXA1eYcp8T3X9crUx1fpEgL6xbIoMiOieKC/KO01voLoAIbKzCrRj+Q==
X-Received: by 2002:a05:6000:1847:b0:385:f060:b7fc with SMTP id
 ffacd0b85a97d-38a8730a60cmr23977164f8f.25.1736863680366; 
 Tue, 14 Jan 2025 06:08:00 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa?
 (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de.
 [2003:cb:c738:3100:8133:26cf:7877:94aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383dedsm15188834f8f.35.2025.01.14.06.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:07:59 -0800 (PST)
Message-ID: <83c251ff-60b9-4a31-b61f-466942bcf34e@redhat.com>
Date: Tue, 14 Jan 2025 15:07:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] system/physmem: poisoned memory discard on reboot
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
 <20250110211405.2284121-3-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110211405.2284121-3-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.01.25 22:14, “William Roche wrote:
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
> ---
>   system/physmem.c | 57 ++++++++++++++++++++++++++++++------------------
>   1 file changed, 36 insertions(+), 21 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 7a87548f99..ae1caa97d8 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2180,13 +2180,32 @@ void qemu_ram_free(RAMBlock *block)
>   }
>   
>   #ifndef _WIN32
> +/* Simply remap the given VM memory location from start to start+length */
> +static void qemu_ram_remap_mmap(RAMBlock *block, uint64_t start, size_t length)
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
> +    if (area != host_startaddr) {
> +        error_report("Could not remap addr: " RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
> +                     length, start);
> +        exit(1);
> +    }

Can we return an error and have a single error printed in the caller?

return area != host_startaddr ? -errno : 0;

> +}
> +
>   void qemu_ram_remap(ram_addr_t addr)
>   {
>       RAMBlock *block;
>       ram_addr_t offset;
> -    int flags;
> -    void *area, *vaddr;
> -    int prot;
> +    void *vaddr;
>       size_t page_size;
>   
>       RAMBLOCK_FOREACH(block) {
> @@ -2202,24 +2221,20 @@ void qemu_ram_remap(ram_addr_t addr)
>               } else if (xen_enabled()) {
>                   abort();
>               } else {
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
> -                    error_report("Could not remap addr: "
> -                                 RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
> -                                 page_size, addr);
> -                    exit(1);
> +                if (ram_block_discard_range(block, offset, page_size) != 0) {
> +                    /*
> +                     * Fall back to using mmap() only for anonymous mapping,
> +                     * as if a backing file is associated we may not be able
> +                     * to recover the memory in all cases.
> +                     * So don't take the risk of using only mmap and fail now.
> +                     */
> +                    if (block->fd >= 0) {
> +                        error_report("Memory poison recovery failure addr: "
> +                                     RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
> +                                     page_size, addr);

See my error message proposal as reply to v4 patch #1: we should similarly
just print rb->idstr, offset and page_size like ram_block_discard_range() does.

ram_addr_t is weird and not helpful for users.


To have a single error

if (ram_block_discard_range(block, offset, page_size) != 0) {
	/* ...
	if (block->fd >= 0 || qemu_ram_remap_mmap(block, offset, page_size)) {
		error_report() ... // use proposal from my reply to v4 patch #1
		exit(1);
	}
}

-- 
Cheers,

David / dhildenb


