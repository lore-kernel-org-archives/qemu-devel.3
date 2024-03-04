Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6770C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 03:08:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgygS-0002Kg-8H; Sun, 03 Mar 2024 22:08:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rgygP-0002K8-FC
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 22:08:06 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rgygN-0000rS-W9
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 22:08:05 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e5e4b1d1f1so947381b3a.1
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 19:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709521682; x=1710126482; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09c5Ld8ZWpizXtKH4r3UpdHmyvyQCrCH0kV5BMr3LS0=;
 b=aNzzPhezS1t0/moWXRG+H+THxSPtOTmMq014zWqtPpJTzS9EBVNdVz3LvThYZ1KsX8
 dNLzlG8rDnmen18xCShxbzVoycqVqEOejn+v8Z7bHy6A2ZoeVQqQM91jH5CrSvyKsF60
 Aysi6nbpOU+elVG95FKEBxfqjC6L/bQnPkNg/g3bP0sjsepb8UEJ3+NpKMRBk70huNfb
 OhOMKhdlM0qknBP/EaG3C+zV2vgeosjNG7aYYvNlR0XWa3vlgPuat7uVGfeSeImg93hX
 yiaNWQo+H3+lhF3T+Vs5Aof9T4uvhVOcJOckB5mtD1MZChpvwifOKQDPg2aDIXTyJpz6
 /XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709521682; x=1710126482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09c5Ld8ZWpizXtKH4r3UpdHmyvyQCrCH0kV5BMr3LS0=;
 b=NsGdPU/jfDXdKElK7Zx/KODNaMtvJFs4HovNaeN8/VkNblkSbutjjVnTC5OtdFsHdl
 iMGsr0q+Wm8fEhXWlRQPCjZVIrDVNZYWemaDDsJIbOrxHQD5JepVm3J+a8MXbWNfAnYE
 Rz2yt/J9k9m9g7eivqLS0DULv13jS/zRGpsXdEjSGKxqkPvAVO6yC+cUd0j3O9HlOFU5
 oa/tnronKcEup4qwDNl2Vs8A3KGcYTgGH20Urv/9K3C5diCAY91MBMlSmad/H6xED6G6
 bXd290y5w4cWM+1EwXlRS44P/RYj/s0b4Hrntb0RU06GguEK+odHHpUPXb890PKskriX
 EDnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4eqtgCfBloyECD8LvjCz55pUYkXQLx/wr6dv6PVOMM6Glb8MUK/flGGHboXcANuRq639W+CAYe1xvH2yZIFMGqQwMfMw=
X-Gm-Message-State: AOJu0Yw66/NAPN6sNXUseGXf5mdUaJmqO91+CSkmLV7gxKJrnsHGTHhR
 w2XdUjiDMKAANZrkfS3+2JUDbnTZDVU2Vj2gDfFYz39sRVj6PsRi
X-Google-Smtp-Source: AGHT+IG2uYM8bLWoyeF3gdZVlOJfprj9tSG/wxizpVtatiHSeXDThSwnJefuUnh4WouBjPO9U9WXKA==
X-Received: by 2002:a05:6a20:8f29:b0:1a1:461a:3691 with SMTP id
 b41-20020a056a208f2900b001a1461a3691mr6916853pzk.15.1709521682220; 
 Sun, 03 Mar 2024 19:08:02 -0800 (PST)
Received: from debian ([2601:641:300:14de:bae0:aa65:8bdd:7233])
 by smtp.gmail.com with ESMTPSA id
 a3-20020aa78643000000b006e0debc1b75sm6348979pfo.90.2024.03.03.19.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 19:08:01 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Sun, 3 Mar 2024 19:07:40 -0800
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Gregory Price <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org,
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>,
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huang Ying <ying.huang@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/1] Improved Memory Tier Creation for CPUless NUMA
 Nodes
Message-ID: <ZeU6_BnXIUs6pCym@debian>
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301082248.3456086-1-horenchuang@bytedance.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Mar 01, 2024 at 08:22:44AM +0000, Ho-Ren (Jack) Chuang wrote:
> The memory tiering component in the kernel is functionally useless for
> CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the nodes
> are lumped together in the DRAM tier.
> https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

Is this the right patchset you want to refer to? It is about node
migration between tiers, how is it related to the context here?

Fan

> 
> This patchset automatically resolves the issues. It delays the initialization
> of memory tiers for CPUless NUMA nodes until they obtain HMAT information
> at boot time, eliminating the need for user intervention.
> If no HMAT specified, it falls back to using `default_dram_type`.
> 
> Example usecase:
> We have CXL memory on the host, and we create VMs with a new system memory
> device backed by host CXL memory. We inject CXL memory performance attributes
> through QEMU, and the guest now sees memory nodes with performance attributes
> in HMAT. With this change, we enable the guest kernel to construct
> the correct memory tiering for the memory nodes.
> 
> Ho-Ren (Jack) Chuang (1):
>   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
>     HMAT info
> 
>  drivers/acpi/numa/hmat.c     |  3 ++
>  include/linux/memory-tiers.h |  6 +++
>  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>  3 files changed, 77 insertions(+), 8 deletions(-)
> 
> -- 
> Hao Xiang and Ho-Ren (Jack) Chuang
> 

