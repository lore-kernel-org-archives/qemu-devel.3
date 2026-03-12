Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057331067045
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iFg-0006oa-Q5; Thu, 12 Mar 2026 11:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0iFd-0006oP-PN
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:47:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0iFa-0001cJ-Rv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 11:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773330421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGPmxqYFLEJ3sfC6jnmRM89OlsjoXQLFnNB/jCG+/n0=;
 b=CSlL+dLxSDtK4HRlv/29ox4Rxij1PwNPLUo26EHy2AKWKTMx8c4kT/f6mPdS0vMiP2Tfc4
 U0dV3tcLffE31AvRN7NPxiQsxr+CfmpefekQm2ZgfrkHW5aPyrRK2TLN4ooLVB2AA1i4tZ
 E4dpu1A+S2JiM4W8KsHKRQqiX+ashRc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-VAJR7BSHPym54seS7KyHiQ-1; Thu, 12 Mar 2026 11:46:59 -0400
X-MC-Unique: VAJR7BSHPym54seS7KyHiQ-1
X-Mimecast-MFC-AGG-ID: VAJR7BSHPym54seS7KyHiQ_1773330419
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8cd83cfb36cso813832385a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773330419; x=1773935219; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XGPmxqYFLEJ3sfC6jnmRM89OlsjoXQLFnNB/jCG+/n0=;
 b=T6dVrXbKRkbooHC3YwqyVrH8AviNkpAmHNkSocweOuJuV1t0G2J+KAfvC4F+C1vmBl
 60z0Vaz+6o3rUgzCjZjK6qagL8z3S1pBK7DHI9fprV9DjbxFK3RYAvjU6OF9nW5sLimI
 s9jeZz6BhdzDasU0g/nVza7qx6Y9V4xP5vMqB1g2POBZvcshuG4DBqLNA9mHm4S41VX/
 J2ppAUBIPfjVl+WMfh55+oPfXoJnb3zvqa7JWPxRRutGvMp/5j1vlw8/O5b58C2kFCm6
 rX7F8+JFV4wx1SRnUC0VeACDqv/tJ3UH+G9I2I2ozY9TVc5XaaKuuNkRSEqP7lnTOL3/
 FCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773330419; x=1773935219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGPmxqYFLEJ3sfC6jnmRM89OlsjoXQLFnNB/jCG+/n0=;
 b=bC/qXadIHmpTb8SFm2hw2SdSqbYDtCrFgUkkE1MNdq36MnMYkXke5PUEWbLu2YeiA5
 xoPMBqFF1QnnpOjBNf/amdG3ZIjym4Bx/08z02MlBVPtS01DaCuuJQ+Oli8Lhle7D4xB
 qSCZUl8ZVb0eHZjpJMAzwm3a4fC7bzCrPetd5RDbRu1e/rv8ITOGDCxYQRe51oV6X+pl
 WsG6hAr5c1p5R/f0TidSxihIEehovYyNh2nj29NPnXFqlrdG4wcSmb1TMGNh/sZD3dOR
 BkJvV9W12qA5MHHuqMTyG7lW1OFdu3OL7DfK1Rpre5nQ9AwHzIKX0m8keSg7hCxM66fY
 Wz3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXi5+QoyAzMXTCqFTAsGor8n8X4ghqTkUIt6/swGZePHThJyaylzWoVXOGKKcfW4/TIqV+mJ8EK8zm@nongnu.org
X-Gm-Message-State: AOJu0Yyj+e3rIWM5txtW4CnMBMkwcDON2rdf7BOL6AFz1Ru58PRms4CG
 YQPo0V0bgdnYqOxjmDo1Me0A92hq1utaBzxqSNY7JXkmf51H3vK6B5D0xOrySe23RB07ovNtlBy
 dt0Pdz3T1nBuGQNfmDDprf6qnAhckPj2+AKhAt94eMGEtUwTq/QpRnpRY
X-Gm-Gg: ATEYQzwaKs1a1zfJQmd7+ooteLI07LjVsr3eFzHRxph8SN/FsS27KRAguKy0FnZWVsz
 U6iHzm5fGrI6+lnAShxo++BtYhjxba1srk9Rg9+uvr/LV48yUAIhuhqF+NuS39VIpHCk3IzRbEU
 YHVe02MkOae9RqDhUcyLa7g5+lhN4Zk3ZqoF99LsslyCgK9oJvuiJ7vql321B0pnoCP8R+m2HJ6
 rbPGOLLKV7b9vJ+GhkKG+KqhR1IVyJw7MPzWTI6OWgVOXsQFGoaxGhce36h2DCL1tWJeIlb05s7
 T6UfyUQ4Uttzs+Xv+rVvd4wa21tV17xMRreZzmz7Ei9uD2yfre0LtMa/WS+nvUANX619aA9Bffl
 4x2Ygb8ekBbzjHQ==
X-Received: by 2002:a05:620a:450f:b0:8c5:310d:3b3a with SMTP id
 af79cd13be357-8cdb5bb12c9mr19783185a.70.1773330418761; 
 Thu, 12 Mar 2026 08:46:58 -0700 (PDT)
X-Received: by 2002:a05:620a:450f:b0:8c5:310d:3b3a with SMTP id
 af79cd13be357-8cdb5bb12c9mr19778385a.70.1773330418184; 
 Thu, 12 Mar 2026 08:46:58 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21100adsm380547185a.31.2026.03.12.08.46.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 08:46:57 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:46:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, chenyi.qiang@intel.com,
 Farrah Chen <farrah.chen@intel.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] memory: Set mr->ram before RAM Block allocation
Message-ID: <abLf8EW3M7XCBh2K@x1.local>
References: <20260312063420.973637-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312063420.973637-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 02:34:20PM +0800, Xiaoyao Li wrote:
> Commit 2fb627ef2f48 ("memory: Factor out common ram region initialization")
> introduced a helper function memory_region_set_ram_block(), which causes
> mr->ram to be set to true after the RAM Block allocation by
> qemu_ram_alloc_*().
> 
> It leads to the assertion
> 
>   g_assert(memory_region_is_ram(mr));
> 
> in memory_region_set_ram_discard_manager() being triggered when creating
> RAM Block with the RAM_GUEST_MEMFD flag.
> 
> Fix this by restoring the original behavior of setting mr->ram before
> RAM Block allocation.
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/3330
> Reported-by: Farrah Chen <farrah.chen@intel.com>
> Fixes: 2fb627ef2f48 ("memory: Factor out common ram region initialization")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks for the report.  This is fast..

Almost agreed with the fix, except that it duplicates the lines all over
the places.  Would it be better to introduce memory_region_init_ram()?

> ---
>  system/memory.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 17a7bcd9af7c..56f3225b21ad 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1578,7 +1578,6 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
>  
>  static bool memory_region_set_ram_block(MemoryRegion *mr, RAMBlock *rb)
>  {
> -    mr->ram = true;
>      mr->terminates = true;
>      mr->destructor = memory_region_destructor_ram;
>      mr->ram_block = rb;
> @@ -1597,6 +1596,7 @@ bool memory_region_init_ram_flags_nomigrate(MemoryRegion *mr, Object *owner,
>      RAMBlock *rb;
>  
>      memory_region_init(mr, owner, name, size);
> +    mr->ram = true;
>      rb = qemu_ram_alloc(size, ram_flags, mr, errp);
>      return memory_region_set_ram_block(mr, rb);
>  }
> @@ -1614,6 +1614,7 @@ bool memory_region_init_resizeable_ram(MemoryRegion *mr,
>      RAMBlock *rb;
>  
>      memory_region_init(mr, owner, name, size);
> +    mr->ram = true;
>      rb = qemu_ram_alloc_resizeable(size, max_size, resized, mr, errp);
>      return memory_region_set_ram_block(mr, rb);
>  }
> @@ -1628,6 +1629,7 @@ bool memory_region_init_ram_from_file(MemoryRegion *mr, Object *owner,
>      RAMBlock *rb;
>  
>      memory_region_init(mr, owner, name, size);
> +    mr->ram = true;
>      mr->readonly = !!(ram_flags & RAM_READONLY);
>      mr->align = align;
>      rb = qemu_ram_alloc_from_file(size, mr, ram_flags, path, offset, errp);
> @@ -1642,6 +1644,7 @@ bool memory_region_init_ram_from_fd(MemoryRegion *mr, Object *owner,
>      RAMBlock *rb;
>  
>      memory_region_init(mr, owner, name, size);
> +    mr->ram = true;
>      mr->readonly = !!(ram_flags & RAM_READONLY);
>      rb = qemu_ram_alloc_from_fd(size, size, NULL, mr, ram_flags, fd, offset,
>                                  false, errp);
> @@ -1663,6 +1666,7 @@ void memory_region_init_ram_ptr(MemoryRegion *mr, Object *owner,
>                                  void *ptr)
>  {
>      memory_region_init(mr, owner, name, size);
> +    mr->ram = true;
>      memory_region_set_ram_ptr(mr, size, ptr);
>  }
>  
> @@ -1671,6 +1675,7 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr, Object *owner,
>                                         void *ptr)
>  {
>      memory_region_init_io(mr, owner, &ram_device_mem_ops, mr, name, size);
> +    mr->ram = true;
>      mr->ram_device = true;
>      memory_region_set_ram_ptr(mr, size, ptr);
>  }
> @@ -3699,7 +3704,6 @@ bool memory_region_init_rom_device(MemoryRegion *mr, Object *owner,
>      memory_region_init_io(mr, owner, ops, opaque, name, size);
>      rb = qemu_ram_alloc(size, 0, mr, errp);
>      if (memory_region_set_ram_block(mr, rb)) {
> -        mr->ram = false;
>          mr->rom_device = true;
>          memory_region_register_ram(mr, owner);
>          return true;
> -- 
> 2.43.0
> 

-- 
Peter Xu


