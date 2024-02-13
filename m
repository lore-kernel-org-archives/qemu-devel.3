Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79412C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxMb-00014v-H5; Tue, 13 Feb 2024 13:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rZxMZ-00014c-0H
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:18:35 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rZxMU-000854-Vz
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:18:33 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7354ba334so39423455ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707848309; x=1708453109; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dw1mjwm2smp4j4HULN2r42PjqzSt3X4acORkoaFVbpE=;
 b=cn7YgQ1v09cdb5MDoNXSBt4t1bqyNP1qxX4rVUDRJCEK5PmEwLUcil5MAs2PEdMduU
 IQh/Wtr2SnQTha8O8S1ytZ79nLr10sUGk2idV64EVJQXym70pTY66LJm7w22Hi67pziC
 BzNNVNqhs/9YWZJjpUmLIfYdrz25XN0CLG08ckDWLC3mj3yq/rniq1T4h7jJ4/v6yOne
 6TFWp8aarw9lvsdokvIy50+8OprXXha2nErwDaF9yR8qACNswbIow8oAkgvfXtqLHQ44
 oykISCw9s356LOEPAaTCZ796k6+kHmQhaLzXJp0Rgc9t2Iuiy0348V7sjQTwzKZ8ZSE/
 VRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707848309; x=1708453109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dw1mjwm2smp4j4HULN2r42PjqzSt3X4acORkoaFVbpE=;
 b=ZNnZxDkihkOZO37wUM7d8Acl1YjUk69vypzYynXuKIWVMVNqZfdiBOBewX/WoGQ06G
 JgKECBDkTlTf4a8xzxx1hihIpK8Zr0aMCgRiH35NVkI+DX7EWASD0E0cLzCjrA3/+kNC
 WFnZxsRiWWo34dzp6acH1y4QEFaHDvSs5YtqTAZCoTpz/lGm/1UtGDAzJoZVTlta+xyk
 q/cP6J70PqtV9b75hmBhqQnMafqHTeVeDCpZycxVWi+uol1toxh1zWadX4eEPI/PA+vv
 tCmUYKSwvGvm5I4uDUgqGHyFEDMxA2/6ZP/k6n+WCwOjOyV14jlBzh2TeGfOEG0Bj6+g
 mtBw==
X-Gm-Message-State: AOJu0YwA4meCyXnd7Ttfp3sOPvhQsja6YE0VFMt36C9o7GiVUhTsACP5
 Gmo9OuOyQI+Ifx8vbfKFZ9CnzvEIB0zHFpIh0X9m5vTT1vw/6aXu
X-Google-Smtp-Source: AGHT+IG9/kMEFLB0OUl6JspBcOGju3LDNSCg476qjmKrKGdhfHdQGnW3U53QHES9vNaZkZHc/xtTGg==
X-Received: by 2002:a17:902:fc50:b0:1d6:c8e3:c3dd with SMTP id
 me16-20020a170902fc5000b001d6c8e3c3ddmr378651plb.54.1707848308714; 
 Tue, 13 Feb 2024 10:18:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUpQWl787Jfsk2qDxgtPYf1bjzf748qAygyucoz2GVmA8PIeHvTTXpRQOz0daglx3MQjHvwvMkOkL+INMqYz1A2BXCgHOeNjcy8IKpHDGJseDwQEYC+X651eVL3DN5ZUKV5U6w4Bc03AGWrXH1Y/rOzXZ9OlVhBvrhmQVMRVNoYZS/gN4bD3VT57hDUkm2TRqzSbYHoZWuAMHEvuPOkOpY+xGt74GSHPkalroeRJkU9Y+k0x+bdpW0kZVbXnkG6wTj/7N5dC6+0LVy+ae4kv5gMd9x005v4S2MEbbnUw4UISzDF1Pb0vaabSjWtDVDtpMd4poL2mrxfOolObcBy5ywMVouaFPQ5Sak=
Received: from debian ([2601:641:300:14de:a8fd:e6e0:547f:c54a])
 by smtp.gmail.com with ESMTPSA id
 mm3-20020a1709030a0300b001d944b3c5f1sm2377828plb.178.2024.02.13.10.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 10:18:28 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 13 Feb 2024 10:18:15 -0800
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com
Subject: Re: [PATCH v3 0/9] Enabling DCD emulation support in Qemu
Message-ID: <ZcuyZ0Nwq31z8YIr@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107180907.553451-1-nifan.cxl@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62c.google.com
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

On Tue, Nov 07, 2023 at 10:07:04AM -0800, nifan.cxl@gmail.com wrote:
> From: Fan Ni <nifan.cxl@gmail.com>
> 
> 
> The patch series are based on Jonathan's branch cxl-2023-09-26.
> 
> The main changes include,
> 1. Update cxl_find_dc_region to detect the case the range of the extent cross
>     multiple DC regions.
> 2. Add comments to explain the checks performed in function
>     cxl_detect_malformed_extent_list. (Jonathan)
> 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> 4. Update total_extent_count in add/release dynamic capacity response function.
>     (Ira and Jorgen Hansen).
> 5. Fix the logic issue in test_bits and renamed it to
>     test_any_bits_set to clear its function.
> 6. Add pending extent list for dc extent add event.
> 7. When add extent response is received, use the pending-to-add list to
>     verify the extents are valid.
> 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
>     cxl_device.h so it can be used in different files.
> 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event
>     log type.
> 10. Extract the functionality to delete extent from extent list to a helper
>     function.
> 11. Move the update of the bitmap which reflects which blocks are backed with
> dc extents from the moment when a dc extent is offered to the moment when it
> is accepted from the host.
> 12. Free dc_name after calling address_space_init to avoid memory leak when
>     returning early. (Nathan)
> 13. Add code to detect and reject QMP requests without any extents. (Jonathan)
> 14. Add code to detect and reject QMP requests where the extent len is 0.
> 15. Change the QMP interface and move the region-id out of extents and now
>     each command only takes care of extent add/release request in a single
>     region. (Jonathan)
> 16. Change the region bitmap length from decode_len to len.
> 17. Rename "dpa" to "offset" in the add/release dc extent qmp interface.
>     (Jonathan)
> 18. Block any dc extent release command if the exact extent is not already in
>     the extent list of the device.
> 
> The code is tested together with Ira's kernel DCD support:
> https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
> 
> Cover letter from v2 is here:
> https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com/T/#m63039621087023691c9749a0af1212deb5549ddf
> 
> Last version (v2) is here:
> https://lore.kernel.org/linux-cxl/20230725183939.2741025-1-fan.ni@samsung.com/
> 
> More DCD related discussions are here:
> https://lore.kernel.org/linux-cxl/650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch/
> 
> 
> 
> Fan Ni (9):
>   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
>     payload of identify memory device command
>   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
>     and mailbox command support
>   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
>     type3 memory devices
>   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
>     devices
>   hw/mem/cxl_type3: Add host backend and address space handling for DC
>     regions
>   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
>     list mailbox support
>   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
>     dynamic capacity response
>   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
>     extents
>   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
> 
>  hw/cxl/cxl-mailbox-utils.c  | 469 +++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          | 548 +++++++++++++++++++++++++++++++++---
>  hw/mem/cxl_type3_stubs.c    |  14 +
>  include/hw/cxl/cxl_device.h |  64 ++++-
>  include/hw/cxl/cxl_events.h |  15 +
>  qapi/cxl.json               |  60 +++-
>  6 files changed, 1123 insertions(+), 47 deletions(-)
> 
> -- 
> 2.42.0
> 

Hi Jonathan,

I have updated the patch set based on your feedback and aligned the code
to cxl spec r3.1.

Here is the new code:
https://github.com/moking/qemu/tree/dcd-v4

I plan to send it out for review early next week to see if there is any kernel
side update for dcd this week so I can test more.

If the plan needs to be adjusted to align with the merge window, please
let me know.

v3[1]->v4: 

The code is rebased on mainstream QEMU with the following patch series:

[PATCH 00/12 qemu] CXL emulation fixes and minor cleanup.
[PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference
hw/cxl/mailbox: interface to add CCI commands to an existing CCI

Main changes include:

1. Updated the specification references to align with cxl spec r3.1.
2. Add extra elements to get dc region configuration output payload and
procecced accordingly in mailbox command 4800h.
3. Removed the unwanted space.
4. Refactored ct3_build_cdat_entries_for_mr and extract it as a separate patch.
5. Updated cxl_create_dc_regions function to derive region len from host
backend size.
6. Changed the logic for creating DC regions when host backend and address
space processing is introduced, now cxl_create_dc_regions is called only
when host backend exists.
7. Updated the name of the definitions related to DC extents for consistency.
7. Updated dynamic capacity event record definition to align with spec r3.1.
9. Changed the dynamic capacity request process logic, for release request,
extra checks are done against the pending list to remove the extent yet added.
10. Changed the return value of cxl_create_dc_regions so the return can be used
to remove the extent for the list if needed.
11. Offset and size in the qmp interface are changed to be byte-wise while the
original is MiB-wise.
12. Fixed bugs in handling bitmap for dpa range existence.
13. NOTE: in previous version DC is set to non-volatile, while in this version
we change it to volatile per Jonathan's suggestion.
14. Updated the doc in qapi/cxl.json.

Thank Jonathan for the detailed review of the last version[1].

The code is tested with Ira's last kernel DCD patch set [2] with some minor
bug fixes[3]. Tested operations include:
1. create DC region;
2. Add/release DC extents;
3. convert DC capacity into system RAM;


v3: 
[1] https://lore.kernel.org/linux-cxl/20231107180907.553451-1-nifan.cxl@gmail.com/T/#t
[2] https://github.com/weiny2/linux-kernel/tree/dcd-v3-2023-10-30
[3] https://github.com/moking/linux-dcd/commit/9d24fa6e5d39f934623220953caecc080f93e964

