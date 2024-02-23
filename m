Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EB1C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rda4r-0002Hy-PP; Fri, 23 Feb 2024 13:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdZva-00059L-3d
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:05:42 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdZvX-0008Qp-IT
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:05:41 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc1ff697f9so9660305ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708711538; x=1709316338; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eQu9k1UzQBTg1+2+F/9lTUaNsdI0drlaEmh//0+Ixko=;
 b=U4CPkAd8a+H3yPhpwQ7IPdnfjeNk6os8PxNuj3sZ9yDI08uxzJKXb+3WgxOGK2XJQ7
 n/686wHOaqDkXA+r7X+ePJu35ih4akGZR/zxxJr1qYfaZEIwLoyBV8AAuj3nHfPT6/4u
 dSd4jJqqosPJAoSij716lvxdZ7UCVXyCMSdY/7jhRq9d8uIOKp2d4zwD5VK4HMCAgfqy
 WTV+6Rthtl4VLdEZhNNThRzZj5p2HRrxLTgIojtVuVYxf252fqENqG/0cEDYRV9HKb4y
 Vh1Ap3nPSxoZr7jqYGX7Oo8XKmtSuVEa+IKu+igtVGNGUHGPotQQOo5tQKDAkpIKSo/W
 5/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708711538; x=1709316338;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eQu9k1UzQBTg1+2+F/9lTUaNsdI0drlaEmh//0+Ixko=;
 b=srJaNWnVKqE33RJcXQhOk0krZZu+WTZDEsH5RIDAhf7doiIlvaq7qsJrPvhgZDPpOv
 2QpKPbH/o3V78mpHS7yHgDaNSJ8o/ef4Fg9NkAU/INFbVRmAQSj4DSgRGfhs2D9vrxAv
 IcyMtjbbDPrhgEbHHGIivE0JRAS6IfTDfC1Tg3vNoWyWp9gJwTViannEQMpKHsupONyK
 rgtPVJoAOYOxhQT8ghOspaqlQXURXxSf3CrZqaUUqwBbyMDKWnL6HrhzwXTpXuv9Kqob
 oOl41l7WF+EzgXlTDLe2lEwOi8FqDvgMVSuJw29iJZ9WLq3JZ/HL5KquwPqSLUg5eXkO
 bDFQ==
X-Gm-Message-State: AOJu0YyvxapOmJZtcx6uQEv1oKGcf6UXWmiCKaxR4o3bS7TbXLWNUhwt
 e7VrPx3X0NPZ0phgV6lB2C5oFZsclp3XH/hV322/5U264PjZxkiL
X-Google-Smtp-Source: AGHT+IFn0SQfg5gTo1ErHfP8GnU4kmfGB6tPgeGrlP76MP0bAlBtL9Xi9l8o2ieIevSa0Qktl39emw==
X-Received: by 2002:a17:903:449:b0:1da:2c01:fef5 with SMTP id
 iw9-20020a170903044900b001da2c01fef5mr544455plb.56.1708711537268; 
 Fri, 23 Feb 2024 10:05:37 -0800 (PST)
Received: from debian ([2601:641:300:14de:2595:938c:d7c1:5827])
 by smtp.gmail.com with ESMTPSA id
 jc13-20020a17090325cd00b001db6de983d3sm11947607plb.85.2024.02.23.10.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 10:05:36 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 23 Feb 2024 10:05:20 -0800
To: nifan.cxl@gmail.com, wj28.lee@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 00/10] Enabling DCD emulation support in Qemu
Message-ID: <ZdjeYMqmik0nszR5@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221182020.1086096-1-nifan.cxl@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Feb 21, 2024 at 10:15:53AM -0800, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> v3[1]->v4: 
> 
> The code is rebased on mainstream QEMU with the following patch series:
> 
> hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
> hw/cxl/mailbox: interface to add CCI commands to an existing CCI
> 
> Main changes include:
> 
> 1. Updated the specification references to align with cxl spec r3.1.
> 2. Add extra elements to get dc region configuration output payload and
> procecced accordingly in mailbox command 4800h.
> 3. Removed the unwanted space.
> 4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
> 5. Updated cxl_create_dc_regions function to derive region len from host
> backend size.
> 6. Changed the logic for creating DC regions when host backend and address
> space processing is introduced, now cxl_create_dc_regions is called only
> when host backend exists.
> 7. Updated the name of the definitions related to DC extents for consistency.
> 7. Updated dynamic capacity event record definition to align with spec r3.1.
> 9. Changed the dynamic capacity request process logic, for release request,
> extra checks are done against the pending list to remove the extent yet added.
> 10. Changed the return value of cxl_create_dc_regions so the return can be used
> to Remove the extent for the list if needed.
> 11. offset and size in the qmp interface are changed to be byte-wise while the
> original is MiB-wise.
> 12. Fixed bugs in handling bitmap for dpa range existence.
> 13. NOTE: in previous version DC is set to non-volatile, while in this version
> we change it to volatile per Jonathan's suggestion.
> 14. Updated the doc in qapi/cxl.json.
> 
> Thank Jonathan for the detailed review of the last version[1].
> 
> The code is tested with Ira's last kernel DCD patch set [2] with some minor
> bug fixes[3]. Tested operations include:
> 1. create DC region;
> 2. Add/release DC extents;
> 3. convert DC capacity into system RAM (no real read/write to DCD tested);
> 
> 
> v3: 
> [1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
> [2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> [3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964
> 
> Fan Ni (10):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
>     size insead of mr as argument
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to DC regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 507 +++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 559 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |  14 +
>  include/hw/cxl/cxl_device.h |  61 +++-
>  include/hw/cxl/cxl_events.h |  18 ++
>  qapi/cxl.json               |  61 +++-
>  6 files changed, 1174 insertions(+), 46 deletions(-)
> 
> -- 
> 2.43.0
> 

Hi,

I fixed some issues mentioned by Wonjae Lee (wj28.lee@gmail.com) in his
review comments and pushed the changes to my local tree:
https://github.com/moking/qemu/tree/dcd-v4

This is no functional changes to the code, mainly fixes include:
1. Did spell check for the patchset and fixed 2 typos;
2. Fixed a misuse of stq_le_p and replaced it with stl_le_p in
cmd_dcd_get_dyn_cap_config;
3. Removed unnecessary switch case in patch 9;
4. Capitalized ""opcode" to "Opcode" in two code comments;
5. Updated one reference text to the spec;
6. Minor text change in qapi/cxl.json.

Thanks Wonjae for the careful review.


I will wait until next week to send out v5 to see if there are further
comments to come in.

Fan


