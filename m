Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9778C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEBVL-0003BT-W6; Sun, 11 May 2025 14:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBV8-0003B9-KS
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEBV5-00049A-Jx
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746988450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4E1UId8moaWgPmnOJNNd+j+os0vx82yepzlWomnq/MY=;
 b=ceyMpcFI6Str3gL3v4xtXZszTMk0WhWlQ5WfA73vcP6fTT+1iAiDD4C5Fndeocm2qJ37Zf
 vxDbRPfwiRaWuv8dN9UNp7yRdTUWgAyVg5Q6c0BIRXf055x3WGIc4PZjEENp5tlPxkLPuL
 D3eBO96bDBT0+M3B68XG/OSW9raH5pI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-gbbkvfCtO1aHE3qS8qC39A-1; Sun, 11 May 2025 14:34:09 -0400
X-MC-Unique: gbbkvfCtO1aHE3qS8qC39A-1
X-Mimecast-MFC-AGG-ID: gbbkvfCtO1aHE3qS8qC39A_1746988448
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b2e56da1so1350645f8f.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746988448; x=1747593248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4E1UId8moaWgPmnOJNNd+j+os0vx82yepzlWomnq/MY=;
 b=vq6l9MIDh9sWw6xYPaI4L1igRyFFU3wk+08oNF8kE2BXh/m9ASRfaE8898wahwApXH
 BcWXwzbBcPmpuQYGRabmGy/6Xl3swkkTGdg7OkcTtWI1hMKsFz1KuucqDav4fMh3+K/D
 HxCL0qJrcbZmQw3grXeqsMeHKQSardD/ZwDoWQMPe5dRGi/UZHPLpaAKA0eXqafR3YAw
 On45MZYnazIRWqnXZ6jn1TtAA5Pq7tKUOwnL91/5nunyQ/uIJnd/ZTs0OQlHmwVk6Tv/
 Z3aeFJAYkKTrEF47Njo0sBcY2BfDeiB1IvoVtCeR0HVMbMGMtYOOZdEVb+JnRo5A+blO
 81yA==
X-Gm-Message-State: AOJu0YyyVxHfDyKzFAWYmi6o8k/KuHRdNviK0tSIkj1mpU+cNxIy2Tz4
 qqUa2YdvQT55v3pxxm+Bo3dVhZojC6tO780xxGNxMRTkjhONT2rkdXQL1mu+KJhwZLJxnAopFTG
 hEJ8MPXJQzinpoeAjWwZDWHym2J9ZiVlUbQxjlyFqrpxchnTRHft5
X-Gm-Gg: ASbGncvxtkGwWG3q4Sna+V6njJZc/c61R/MCMsm/JXVS3CqxC9iDYntKl7ffQAQcvgN
 /Xg1HMvBneMFZdK2GSwX5ZLYsYMrotEurfoC2XWoSJA2WjmLbUW/kUsQZqT1iVymnjtpyaaFQQY
 c3X4mocpY7qkGeb1B4qJcwTW3PGGs/sc3rXPmNkDcxqLfSIecQqBDrn2IpEW+bs37YpnMFy6fAE
 8/BLZ21YCttmPyrfCgnKo6vUh5aJjrDRdpSFCW7mVk7tYoxopiDh4CHEgvc2c44HNIPqeKUu0q5
 HL1O4A==
X-Received: by 2002:a05:6000:40ce:b0:3a1:fffe:6b6c with SMTP id
 ffacd0b85a97d-3a1fffe704amr4607622f8f.34.1746988447913; 
 Sun, 11 May 2025 11:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHp6Eu+hozl7cUS1E3GgtT8fKgohK9QU7n0tkvS0CraHwvfPPtfVO3GaUfEk3cICtpykeeyA==
X-Received: by 2002:a05:6000:40ce:b0:3a1:fffe:6b6c with SMTP id
 ffacd0b85a97d-3a1fffe704amr4607596f8f.34.1746988447512; 
 Sun, 11 May 2025 11:34:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf38sm9912820f8f.77.2025.05.11.11.34.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:34:06 -0700 (PDT)
Date: Sun, 11 May 2025 14:34:03 -0400
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
Message-ID: <20250511143327-mutt-send-email-mst@kernel.org>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Suravee you are active there, maybe you can take a look at AMD bits, too?


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


