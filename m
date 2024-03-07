Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1BCC54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 20:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riKYX-00032a-J7; Thu, 07 Mar 2024 15:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKYW-00032A-Ij
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:41:32 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1riKYU-0001go-W1
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 15:41:32 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dbae7b8ff2so11443215ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709844089; x=1710448889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHAR0e6dARjvh6LKsJ+nKdTHFX+sMTEm5DbrspikR+g=;
 b=GBBmCYf/WFPZr76HqoxeuJz2MA1f+KMMugad/H+cl6swt8d0JDzXi3ZC6mJXM2aEDU
 G8P2K7praQYz77A4NuGFbIuNAzz19NP4SdRxQyYqD2OXInwZ0W99R1ri2jIIBPG7S5QH
 Z/+6aDbH8XlwyaErh974STO5Fc3mHT/h3H1pQtlCUlUnbthBwFc84/Nr+iu7i/rbZ6xL
 i9HObZ/bosq2ike47IXlzeird8B/7JmFJQqtDPvF97n2As5WKWkfMabcWce2vSB1959Q
 E53+1taETvTrSbsVcwUIeqnc+LDi9amUPT76iNB6oJFIs1MRdSjbwwHmPD9OVqLGf72S
 F0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709844089; x=1710448889;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHAR0e6dARjvh6LKsJ+nKdTHFX+sMTEm5DbrspikR+g=;
 b=oJRnncThr4v4CaY1yUIkckOZ6M1LbQw+bXiVN2lAj0V6SCZK0tMTy67KGcybJdE0Xp
 jYSomD/nHaWOeDn3ASMo9PGijMH4baDs4quXzTNh5TSr5RVDZS4dlTx44e2JEXpmPbNw
 6c1hrUVwcqkmwQ41e+Blme7LzafPuVmauXdZ8zyWHoE+0nXOdzOu10O8eRxXVNwZao5j
 ct1HVkBF7Wg0viQPb5+N1pnBSN8nD33M+N1iRCbLxYhCzJSgDJouxFf0lnP7OsYDqn0S
 0zkKlS5ADyqJIe+3yizNLY5VvhZRnZnthfLXmlOWKbYsAXXGDxcuytIo3RyXfwBMlOwn
 A5aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDJlVug1gcLgT/STt/JIXiUo8k+vnsC0gOSjOh368HH+fSmJM2C9yewXjeJkJyKJimJtpOtbjg4eIzJEvqnr80ro0/8BE=
X-Gm-Message-State: AOJu0Yz6+sQHEbiBg5LbXdBiHfrLuS53JeBwbxmcXVLBuM6fvdIE/FC7
 DizwqB0PspgJ7qoTd7QMvmwM6jK+y+wIEHTspnoCmie2A86uGIYM3T1eT7ic7I9c5WW9GL0zLF0
 m
X-Google-Smtp-Source: AGHT+IE3xl/BcwT6RFMov65u+N02oL6bXPKyk+mZd3xCgsIqGthqrXZ2kI3tOkBnuf8vcYgvsFzo7w==
X-Received: by 2002:a17:902:c94d:b0:1dd:54a6:63e5 with SMTP id
 i13-20020a170902c94d00b001dd54a663e5mr3325737pla.14.1709844089484; 
 Thu, 07 Mar 2024 12:41:29 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 w7-20020a170902e88700b001dba739d15bsm15109796plg.76.2024.03.07.12.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 12:41:29 -0800 (PST)
Message-ID: <ee463c40-8134-4eb7-91ef-23b5f428bb3d@linaro.org>
Date: Thu, 7 Mar 2024 10:41:27 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] include/exec: annotate all the MemoryRegion fields
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240307181105.4081793-1-alex.bennee@linaro.org>
 <20240307181105.4081793-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240307181105.4081793-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/7/24 08:11, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/exec/memory.h | 47 +++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 17b741bc4f5..312ed564dbe 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -778,9 +778,48 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>   
> -/** MemoryRegion:
> - *
> - * A struct representing a memory region.
> +/**
> + * struct MemoryRegion - represents a memory region
> + * @parent_obj: parent QOM object for the region
> + * @romd_mode: if true ROM devices accessed directly rather than with @ops
> + * @ram: true if a RAM-type device with a @ram_block
> + * @subpage: true if region covers a subpage
> + * @readonly: true for RAM-type devices that are readonly
> + * @nonvolatile: true for nonvolatile RAM-type devices (e.g. NVDIMM)
> + * @rom_device: true for a ROM device, see also @romd_mode
> + * @flush_coalesced_mmio: true to flush any queued coalesced MMIO
> + * operations before access
> + * @unmergeable: this section should not get merged with adjacent
> + * sections
> + * @dirty_log_mask: dirty events region cares about (see DIRTY_ flags)
> + * @is_iommu: true if part of an IOMMU device
> + * @ram_block: backing @RamBlock if @ram is true
> + * @owner: base QOM object that owns this region
> + * @dev: base Device that owns this region
> + * @ops: access operations for MMIO or @romd_mode devices
> + * @opaque: @dev specific data, passed with @ops
> + * @container: parent `MemoryRegion`
> + * @mapped_via_alias: number of times mapped via @alias, container
> + * might be NULL
> + * @size: size of @MemoryRegion
> + * @addr: physical hwaddr of @MemoryRegion
> + * @destructor: cleanup function when @MemoryRegion finalized
> + * @align: alignment requirements for any physical backing store
> + * @terminates: true if this @MemoryRegion is a leaf node
> + * @ram_device: true if @ram device should use @ops to access
> + * @enabled: true once initialised, false once finalized
> + * @vga_logging_count: count of memory logging clients
> + * @alias: link to aliased @MemoryRegion
> + * @alias_offset: offset into aliased region
> + * @priority: priority when resolving overlapping regions
> + * @subregions: list of subregions in this region
> + * @subregions_link: next subregion in the chain
> + * @coalesced: list of coalesced memory ranges
> + * @name: name of memory region
> + * @ioeventfd_nb: count of @ioeventfds for region
> + * @ioeventfds: ioevent notifiers for region
> + * @rdm: if exists see #RamDiscardManager
> + * @disable_reentrancy_guard: if true don't error if device accesses itself
>    */

Why as one big block rather than line by line?
The block is less likely to be properly kept up-to-date and is much harder to read.


r~


