Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCFBC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 16:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s803i-0005I5-UB; Fri, 17 May 2024 12:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s803g-0005HH-G6
 for qemu-devel@nongnu.org; Fri, 17 May 2024 12:03:48 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s803e-00016X-6p
 for qemu-devel@nongnu.org; Fri, 17 May 2024 12:03:48 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1ecddf96313so14051965ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 May 2024 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715961824; x=1716566624; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nip+K6lz0QcnDcnFAf1QroLYXPqFj24Z42qKu2dyrSA=;
 b=Srk3asa+WpESAj1eLlyAo5CZy6xPagRp7E9V5PAc5y4hbolPgp6zGLEf24WleDNJQ9
 w3tUmkEiW2EjVNf3UwDxrY8obZxnicTttuHTlvnaOhqrAhG3ye4A7QVP8U7RiEAeNoxW
 T4pA+/A1wM8IJjgIFODj9FX5drwS7NHX3qxQoQOyNb4xCsqSER5DVuNVkVmkrzKHjF9X
 PyaHLJNFhQWqx0V+/T50GmAYb/hgdGd/qkQybuVcamtz/0jMnIZsYCn64aSGqMHthjrZ
 4bs+xV6r7YbukTG5wMDVx/s1jEbayfDRksrWw5wJyZ58jkPW9jlGW0rChEU8PswX6tHf
 +dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715961824; x=1716566624;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nip+K6lz0QcnDcnFAf1QroLYXPqFj24Z42qKu2dyrSA=;
 b=PyIBa0flDQn9oDRqqJuwoLxfz1X8qxtdkci2qebDawQSgdpmdRP9LYmPSVLjr1k2xA
 gAhFt3AhTZO0wa2oX3N82LcvwWApDu8PwFJkUuPfNfcJjC2Xr3yJ0LLJbEVThOAv2ZcH
 FQCTC/cqvdkalQ8TQsFTuVNidXoVcJvvel5Qbno+mzmv1eOQx5y7C5U4/7qGmNpED66G
 BkRYy2QU6yGc6f2gztm+9Y8YtOx4efz7DSrd9da1dNP4L3pfMEnJk9o6Pd3bGHH9GXPG
 o7p2DDclVWddCdWxDyLA1BiKpdVyPcAVK4zlsibAEVpjcn4ohnMs1J/3YwDgk/xZQ/rv
 kp/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3BN1g1B5yFUB3ExwMiyIt/T0EY6OyRINg6BaONsCP8cyy9LOZe9nQ/5tl9znlB6fUKEt3YQQ667gTzU7haHnzqpunH3U=
X-Gm-Message-State: AOJu0YyczrlbgYToTNjqDvPUb2kCTEpzrjVP/1YQZLwwA42Vw5g6Rn6E
 AEtRb1o2D+MvHLe0N8wb3h6ptgu1ONyZs54QZgZGmF/xTkJBllcg
X-Google-Smtp-Source: AGHT+IHfUAZrjImGHWziYopFxbD1rKq0mIN2zT6jOVxG7sCEBDjWvov0GunKKtG9JYS2cLf2c17+Kg==
X-Received: by 2002:a05:6a20:438d:b0:1af:f497:8225 with SMTP id
 adf61e73a8af0-1aff497887amr24846273637.31.1715961822814; 
 Fri, 17 May 2024 09:03:42 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:4ede:fa51:f54a:fe25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f676b08e4esm5114885b3a.79.2024.05.17.09.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 May 2024 09:03:42 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 17 May 2024 09:03:34 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Gregory Price <gregory.price@memverge.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <Zkd_tgVITi7awu3p@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com> <ZkY83c9PXoop_r1A@debian>
 <20240517131852.00006bc7@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240517131852.00006bc7@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, May 17, 2024 at 01:18:52PM +0100, Jonathan Cameron wrote:
> On Thu, 16 May 2024 10:05:33 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> > > On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote:  
> > > > A git tree of this series can be found here (with one extra commit on top
> > > > for printing out accepted/pending extent list): 
> > > > https://github.com/moking/qemu/tree/dcd-v7
> > > > 
> > > > v6->v7:
> > > > 
> > > > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> > > >    Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > > > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > > > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > > > 4. Added "Reviewed-by" tag to Patch 7.
> > > > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> > > >    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
> > > > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> > > >     (Jonathan)
> > > > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > > > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> > > >    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > > > 9. Redesigned the pending list so extents in the same requests are grouped
> > > >     together. A new data structure is introduced to represent "extent group"
> > > >     in pending list.  (Jonathan)
> > > > 10. Added support in QMP interface for "More" flag. 
> > > > 11. Check "Forced removal" flag for release request and not let it pass through.
> > > > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> > > >    to avoid the side effect it may introduce to inject error to DC event log.
> > > >    (Jonathan)
> > > > 13. Hard coded the event log type to dynamic capacity event log in QMP
> > > >     interfaces. (Jonathan)
> > > > 14. Adding space in between "-1]". (Jonathan)
> > > > 15. Some minor comment fixes.
> > > > 
> > > > The code is tested with similar setup and has passed similar tests as listed
> > > > in the cover letter of v5[1] and v6[2].
> > > > Also, the code is tested with the latest DCD kernel patchset[3].
> > > > 
> > > > [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
> > > > [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
> > > > [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3
> > > >  
> > > 
> > > added review to all patches, will hopefully be able to add a Tested-by
> > > tag early next week, along with a v1 RFC for MHD bit-tracking.
> > > 
> > > We've been testing v5/v6 for a bit, so I expect as soon as we get the
> > > MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> > > 
> > > The super-set release will complicate a few things but this doesn't
> > > look like a blocker on our end, just a change to how we track bits in a
> > > shared bit/bytemap.
> > >   
> > 
> > Hi Gregory,
> > I am planning to address all the concerns in this series and send out v8
> > next week. Jonathan mentioned you have few related patches built on top
> > of this series, can you point me to the latest version so I can look
> > into it? Also, would you like me to carry them over to send together
> > with my series in next version? It could be easier for you to avoid the
> > potential rebase needed for your patches?
> 
> I wasn't clear - I meant other way around.
> This series is built on a couple of Gregory's patches.  Gregory can suffer
> the pain of rebasing his stuff ;) (or I'll do it depending on when things
> land).
> 
> hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference 
> https://gitlab.com/jic23/qemu/-/commit/f44ebc5a455ccdd6535879b0c5824e0d76b04da5
> hw/cxl/mailbox: interface to add CCI commands to an existing CCI 
> https://gitlab.com/jic23/qemu/-/commit/00a4dd8b388add03c588298f665ee918626296a5
> 
> I was suggesting your next posting should just include those two with
> your sign-off added. That way if everyone is happy with v8 Michael Tsirkin
> can pick it up directly, saving a step.
> 
> Make sure to add Michael to the to list as well for next version.
> 
> Thanks,
> 
> Jonathan

Oh, I totally mis-understood.

Sure. I will add the two patches with my sign-off to my next post.

Fan
> 
> > 
> > Let me know.
> > 
> > Thanks,
> > Fan
> > 
> > > > 
> > > > Fan Ni (12):
> > > >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> > > >     payload of identify memory device command
> > > >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> > > >     and mailbox command support
> > > >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> > > >     type3 memory devices
> > > >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> > > >     devices
> > > >   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> > > >     size instead of mr as argument
> > > >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> > > >     regions
> > > >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> > > >     list mailbox support
> > > >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> > > >     dynamic capacity response
> > > >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> > > >     extents
> > > >   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
> > > >   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
> > > >   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > > > 
> > > >  hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> > > >  hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
> > > >  hw/mem/cxl_type3_stubs.c    |  20 ++
> > > >  include/hw/cxl/cxl_device.h |  81 ++++-
> > > >  include/hw/cxl/cxl_events.h |  18 +
> > > >  qapi/cxl.json               |  69 ++++
> > > >  6 files changed, 1396 insertions(+), 45 deletions(-)
> > > > 
> > > > -- 
> > > > 2.43.0
> > > >   
> 

