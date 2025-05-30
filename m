Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7CEC5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 11:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKy7h-0006Sf-In; Fri, 30 May 2025 07:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKy7f-0006SF-7c
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uKy7c-0002H6-K4
 for qemu-devel@nongnu.org; Fri, 30 May 2025 07:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748605319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EoeRAQSF8pxyrayXzHUwAlAgnQD0tGiWqg2jxNw5Dao=;
 b=L5wojCYcn7SNFAyZSvX2m6XsH87YXAuBsaAIiKzMSnOYNkFtfw4AN4DO5CJZEHcZr+k2Yd
 7bX7ifIZOVbs6X0l112RTCanumdMFk5qLccBOl5MvYTZALhVdKTJuaWUcNVv3FMXML7jfh
 UY/1Bf86g58PaKE4D7+3s4JafurbAUo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-0x4SVshdPNa5fDGDrTc4IQ-1; Fri, 30 May 2025 07:41:58 -0400
X-MC-Unique: 0x4SVshdPNa5fDGDrTc4IQ-1
X-Mimecast-MFC-AGG-ID: 0x4SVshdPNa5fDGDrTc4IQ_1748605317
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442cdf07ad9so7980085e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 04:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748605317; x=1749210117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EoeRAQSF8pxyrayXzHUwAlAgnQD0tGiWqg2jxNw5Dao=;
 b=AxNEcvX+dc9DRNOcUCkftlaEKigCETi2Mk9s0t9z4SUZ3u1NXI4xPS1gqD/VJjsIdb
 ndcudEY77x3jCPC6/lOl9OU0IjgpqhJJYKCAf8oPPElJp300vFbaL+VCbw999y2z14EW
 l6H36LBx+MjzC8I193mu68lDoqtfUS6qak5p3coOBC2z8RXPMvYaym5D6SyNbNNkPN5J
 2BlRqjWDxRDU5gjtjE+B55mjj/6Frpw18nYGu8yVr2N3inntEosysewILclUoBa6dPBY
 ru+L9rEoLSniibupTOqmAuo0B7U++dxNQrJedkoQXc5rcWnr7wgQ7qQvz4o9VCgbufZD
 sQCw==
X-Gm-Message-State: AOJu0YxWbmBpNSpy1p2FuSdJrjMkuismcRE2uyoA1/U2SD3O2FZ4sPjZ
 lLxE/Jxozx/q5N3V+NjlIsno0TDktL2pvqw+l/sN+vAIYNNGkC2ZIxUBXMkSpoQB/nZDR/aHEhM
 PIbEQqcw7ZypEXlqdTqJRoupWTHk6OvpUFvfvPtCUdBH57lVlQb9qwlqB
X-Gm-Gg: ASbGnctMAVoTByQw4/HJdpyk+p2GJLZ3pNjPWfdFwbQlQfCqwYEUBQ0zXX96GKI7jMa
 V5c6CbnTE5ADGTX+Ex4pw6zqikl98ScEt4tKFs134CEem+nuufq37vdLOlOTy82p+pQRX9mwNXV
 9QaO6GaJGkqmEEE2udKIdeC4GqO/9lUKVzq8RMjcGGiBjPApdo3jMtcxlJR6HF3zPfnY97KaIcR
 T3XQQy7oFepzV/ru4UCpNco1K26iF37REOcJ/XIs73dxdrmZ1RiOnAbMUvvZrZESXJ5+44AyPsB
 eNOhvA==
X-Received: by 2002:a05:600c:45cc:b0:450:cc3d:6a03 with SMTP id
 5b1f17b1804b1-450d880abffmr15853575e9.7.1748605316775; 
 Fri, 30 May 2025 04:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjgSjpGVoxs29PyIsqGE7wXlr3eNDKMR9CH7HDu64jM5uBjCxxPEVqY+yK17dkv0ZsY57rlw==
X-Received: by 2002:a05:600c:45cc:b0:450:cc3d:6a03 with SMTP id
 5b1f17b1804b1-450d880abffmr15853235e9.7.1748605316358; 
 Fri, 30 May 2025 04:41:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d8012b09sm15648245e9.37.2025.05.30.04.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 04:41:55 -0700 (PDT)
Date: Fri, 30 May 2025 07:41:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v2 00/20] AMD vIOMMU: DMA remapping support for VFIO
 devices
Message-ID: <20250530074128-mutt-send-email-mst@kernel.org>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, May 02, 2025 at 02:15:45AM +0000, Alejandro Jimenez wrote:
> This series adds support for guests using the AMD vIOMMU to enable DMA
> remapping for VFIO devices. In addition to the currently supported
> passthrough (PT) mode, guest kernels are now able to to provide DMA
> address translation and access permission checking to VFs attached to
> paging domains, using the AMD v1 I/O page table format.
> 
> Please see v1[0] cover letter for additional details such as example
> QEMU command line parameters used in testing.

are you working on v3? there was a bug you wanted to fix.

> Changes since v1[0]:
> - Added documentation entry for '-device amd-iommu'
> - Code movement with no functional changes to avoid use of forward
>   declarations in later patches [Sairaj, mst]
> - Moved addr_translation and dma-remap property to separate commits.
>   The dma-remap feature is only available for users to enable after
>   all required functionality is implemented [Sairaj]
> - Explicit initialization of significant fields like addr_translation
>   and notifier_flags [Sairaj]
> - Fixed bug in decoding of invalidation size [Sairaj]
> - Changed fetch_pte() to use an out parameter for pte, and be able to
>   check for error conditions via negative return value [Clement]
> - Removed UNMAP-only notifier optimization, leaving vhost support for
>   later series [Sairaj]
> - Fixed ordering between address space unmap and memory region activation
>   on devtab invalidation [Sairaj]
> - Fixed commit message with "V=1, TV=0" [Sairaj]
> - Dropped patch removing the page_fault event. That area is better
>   addressed in separate series.
> - Independent testing by Sairaj (thank you!)
> 
> Thank you,
> Alejandro
> 
> [0] https://lore.kernel.org/all/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/
> 
> Alejandro Jimenez (20):
>   memory: Adjust event ranges to fit within notifier boundaries
>   amd_iommu: Document '-device amd-iommu' common options
>   amd_iommu: Reorder device and page table helpers
>   amd_iommu: Helper to decode size of page invalidation command
>   amd_iommu: Add helper function to extract the DTE
>   amd_iommu: Return an error when unable to read PTE from guest memory
>   amd_iommu: Add helpers to walk AMD v1 Page Table format
>   amd_iommu: Add a page walker to sync shadow page tables on
>     invalidation
>   amd_iommu: Add basic structure to support IOMMU notifier updates
>   amd_iommu: Sync shadow page tables on page invalidation
>   amd_iommu: Use iova_tree records to determine large page size on UNMAP
>   amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>   amd_iommu: Add replay callback
>   amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>   amd_iommu: Toggle memory regions based on address translation mode
>   amd_iommu: Set all address spaces to default translation mode on reset
>   amd_iommu: Add dma-remap property to AMD vIOMMU device
>   amd_iommu: Toggle address translation mode on devtab entry
>     invalidation
>   amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>   amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
> 
>  hw/i386/amd_iommu.c | 1005 ++++++++++++++++++++++++++++++++++++-------
>  hw/i386/amd_iommu.h |   52 +++
>  qemu-options.hx     |   23 +
>  system/memory.c     |   10 +-
>  4 files changed, 934 insertions(+), 156 deletions(-)
> 
> 
> base-commit: 5134cf9b5d3aee4475fe7e1c1c11b093731073cf
> -- 
> 2.43.5


