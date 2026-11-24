Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E48606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tq/56pZY;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HxDV5p5n
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVx0k-00018B-D8; Tue, 24 Nov 2026 15:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVx0h-00017l-R4
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xVx0f-0005On-Rh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 15:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795551659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaulq4y3ELiEFgVuqEHf0lQSRwxHx4J3Ck4C/YJtzd8=;
 b=Tq/56pZYvoxak+CHUcwuy+PFRwe5Ccqw/RY1iIBXivIFuXOLJ1y7azBCXHtHb7vQomeax7
 bRtorFfkjsJB/DMMFc7Gm/1jvRyGUucNLD93WpA2/X6rgXnW8+72NFT797Spe4gJJk4f3N
 zJZx/B3/o5iwDNIeQhLQoo5BCKWfGjg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-7JCs1dnSMZqfYp9nGSvMAw-1; Tue, 24 Nov 2026 20:20:57 +0000
X-MC-Unique: 7JCs1dnSMZqfYp9nGSvMAw-1
X-Mimecast-MFC-AGG-ID: 7JCs1dnSMZqfYp9nGSvMAw_1795551657
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9213730b07eso84653806d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795551657; x=1796156457; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yaulq4y3ELiEFgVuqEHf0lQSRwxHx4J3Ck4C/YJtzd8=;
 b=HxDV5p5n0954WdaBayPj/Jtx/UKa3eIUEVPsj+nLvTj1kY7B1N5C7v3n4TKwG8xcif
 CZBR9fofH6h71NBHk2D0PID8f9mCJuyl1x3eaWahOtG91i1dPn93KvYE96lKzRdhxWGF
 2A22pGDqDdHq2I5dJStQbZc6HAbwZWq9mrkZFEreKZzsWqOZ4ahLUPJy3OIgW2Au4ya/
 gR0RgyzMG5ASOc1ERQFmiCGlDBJiUlzk9myAK9vI99E3gheb1g79q2luyIoPrqJfHkOT
 IHumzmCv8pX+ZApf7XivTxFZs35fTokl8ENuxZpalM67fSBvoMduRlFDMfGxKDx/c2Jw
 9m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795551657; x=1796156457;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yaulq4y3ELiEFgVuqEHf0lQSRwxHx4J3Ck4C/YJtzd8=;
 b=lr1fQU/e2GIE6xN0uqEvQZzhRZBi12FeDsof+EsqLe++mYsbQ5RBd7sYq6ID9GA+lD
 p+G+f2K8TGx2NP3OVQsxGtNfLil2F42IRtywqH8C4MBOSXuIjcK6ATHDh3vI5JbSJwtM
 pjW6JhKcPY+j1k+psjFiG+LL8YmtIThjnjfiAVyCTkXKlT8wQWIcEW92/8tGXn33STpA
 yEsua5e5NMK73is7fg6griydY8Bhzh5QV5otEYj2kmhVJVpqk7epKnNz7LhUZtdpa5zP
 Ry98zK1SI+zk18y1h6sewbpwKlAzdqULd7Mr2ycVIzea69N0EboMqiRemP/JGTTWFxVC
 Q0oA==
X-Gm-Message-State: APuU4Z+rcJ6NIoVq7T8L7WlZyu7Liue3DK+0LIUQWbMIDrb/z0+1KOtF
 DTHDSR+s/zTyRYvbx3/O3RhZuxtOV1L5deF8/UwDSeAT0s7OJN+ccbBpqwcSpw6RDZ/XQz7raKj
 Ya/f7fIspyFPEQy5aW1LjCHS7vBt0jReA9n66ivKb06BVihX4llkxS6RL
X-Gm-Gg: AZFdTZfpHjflvi8/mWhFZ0cWaD8TNkpUGoaNtCgJcJ00Lu6jn7MclGGEkI4M5x0mhPv
 20dTjGUu8Df1tyZj3779tjvq+QYylET2p5NgHjtvfHorT3Bo0d3Lz7DU4B4fbaLmTkcTad4o1wY
 YA5VeT+81purMWKS59cfS084/WXxdZ3NyIXrvFMCH7nk/Qjcts9K23MdREns3mnj0qq8HCgSRI+
 ZjDEmMiHN/In9x0MGE/mTHcGEAJJgq0cAOXCVNLZ/ZGQ0ucgwdP0rqwuUAPYdoFFA1x68FuS91p
 hszzwH4R6wquQ5M8/3AJuEpy4i38co72o4x5oCFUVGjtHGMqtXYFscmQDXhh60eQfQI/DxXxe3P
 POYzdbD881QQ9MoedDh6hMa4iZGgwt+DxOdAltqy1ycsF
X-Received: by 2002:a05:6214:124e:b0:921:2a6:c6d9 with SMTP id
 6a1803df08f44-92134ade7cbmr297400246d6.51.1795551656688; 
 Tue, 24 Nov 2026 12:20:56 -0800 (PST)
X-Received: by 2002:a05:6214:124e:b0:921:2a6:c6d9 with SMTP id
 6a1803df08f44-92134ade7cbmr297399656d6.51.1795551656164; 
 Tue, 24 Nov 2026 12:20:56 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921347a0b79sm142821446d6.5.2026.11.24.12.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 12:20:55 -0800 (PST)
Date: Tue, 24 Nov 2026 15:20:54 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org, Elliot Berman <eberman@anduril.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH-for-11.2?] system/memory: Invalidate TBs on ROM device
 mode switch
Message-ID: <awXxps0Z4PjS85DT@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124182722.78535-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124182722.78535-1-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 07:27:22PM +0100, Philippe Mathieu-Daudé wrote:
> A ROM device changes its contents with direct stores while in MMIO
> mode. TCG does not see these stores, so translated blocks built from
> the old contents survive the switch back to ROMD mode and the guest
> executes stale code.
> 
> Make memory_region_rom_device_set_romd() drop the TBs of the whole
> region on both transitions: before leaving ROMD mode (if currently
> in it), and after entering ROMD mode, for TBs another vCPU built
> before its TLB was flushed.

Pure question: should we flush once, but only when ROMD->MMIO?  Said that,
IIUC we need to flush after switching to MMIO to avoid the race you
mentioned, that is something like:

  if (mr_is_romd(mr) && romd_mode) {
      set_romd(false);
      flush();
  }

It's based on my limited understanding / assumption that during MMIO state
TCG won't be able to cache invalid TB on these regions.

So when switching ROMD->MMIO, invalidated TBs can exist, hence flush only
once, after updating romd=false.  When switching back from MMIO->ROMD, no
chance caching anything wrong.

Thanks,

> 
> Measured with a guest that repeatedly leaves and re-enters read-array
> mode on a pflash, once with no code cached from the flash, and once
> with a function in the flash called after every read-array transition.
> The flush is almost free where code isn't cached in flash, and costs
> about one retranslation per cycle when it is.
> 
> The pflash models are the only callers of this function. Other ROM
> devices (nrf51_nvm, amigaone) flush from their own write callbacks.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Elliot Berman <eberman@anduril.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4490
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/system/memory.h |  3 +++
>  system/memory.c         | 14 +++++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 027ca81bd2e1..8dbe37e60ad5 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -1959,6 +1959,9 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
>   * device is mapped to guest memory and satisfies read access directly.
>   * When in MMIO mode, reads are forwarded to the #MemoryRegion.read function.
>   * Writes are always handled by the #MemoryRegion.write function.
> + * Switching to MMIO mode when currently in ROMD mode, and switching to ROMD
> + * mode, both drop the translated blocks of the whole region, so the device
> + * may modify its contents while in MMIO mode.
>   *
>   * @mr: the memory region to be updated
>   * @romd_mode: %true to put the region into ROMD mode
> diff --git a/system/memory.c b/system/memory.c
> index 56c5dd6c8abd..f01470993914 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2249,7 +2249,8 @@ void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile)
>      }
>  }
>  
> -void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
> +static void memory_region_rom_device_set_romd_mode(MemoryRegion *mr,
> +                                                   bool romd_mode)
>  {
>      if (mr->romd_mode != romd_mode) {
>          memory_region_transaction_begin();
> @@ -2259,6 +2260,17 @@ void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
>      }
>  }
>  
> +void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
> +{
> +    if (romd_mode) {
> +        memory_region_rom_device_set_romd_mode(mr, true);
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +    } else if (memory_region_is_romd(mr)) {
> +        memory_region_flush_rom_device(mr, 0, memory_region_size(mr));
> +        memory_region_rom_device_set_romd_mode(mr, false);
> +    }
> +}
> +
>  void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
>                                 hwaddr size, unsigned client)
>  {
> -- 
> 2.55.0
> 

-- 
Peter Xu


