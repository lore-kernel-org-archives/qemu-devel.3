Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108EFC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eY4-0007Jx-S2; Thu, 16 May 2024 13:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eY1-0007AV-BB
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:05:41 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eXy-0005Us-Cn
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:05:41 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-de462f3d992so8722851276.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715879137; x=1716483937; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=svnRaxp+qCp2pAr6pMbLzaQmbhTIyubR1YovLRC4saY=;
 b=gIxSfvjVpccroOJ8KKvNli/G3tE+zphZv/wnZsEi3DipIBMrm0TbJMao2kOQi9rJco
 aL+smF2FBnvGDEv3t7nxn60GS6qlwpEYefOumTcZmiWHQyvev7PxbFNC7oa2LzNM45Qj
 u9xLV8l/YQfsLFCwQzm+9vwm92mGrFIZaoErWQWK5f7bkr1CMKY0n6tthNwmKa2URAG6
 Y2zk/oY7naZbXhBbPjBjCSnr4PG3ciUFR0Au5fECQNDL2DUSIi2GDQ1dhUp7z9jX04DF
 JdHXjSHlTapB+BLrwM6LyWq+WyWPhot5TR536GqSjmmn/Nvu0wOyIb2q3dkpyS4Kpoh2
 IxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715879137; x=1716483937;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svnRaxp+qCp2pAr6pMbLzaQmbhTIyubR1YovLRC4saY=;
 b=vqjxm87TVSsjR5KVVw7ME5DJykkNZU/qs5Wstf1ZmUiRnpBdgqX2tKtu0ntl62k6B3
 UibFEiT//DofhnSw/iMuu4pQwoOVSgxyqvXXDW2fH4T1hpg51XiHo2siiAh+XeabPIlG
 gFpg8ngWGSB5f5BFk0yEpiCDEOFXJ8Zhm1xkj/eE+k9nbxVQ9Yd3rI4cGT6TbfVAed1f
 MblpDcF5Lohc3pSo/9po2Xdl+iOSjsnBXh7JJp5h5aUrXpX3oThunzygmm8Kjxv1BRpp
 0a8rGsoZOh10MoW19IeC5Qfpricdzx6oH3PkNatuQFp5Ps91ywVzB+pmk5yXHMDehicc
 ilxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+tXwFeMMTgp04Zz00b1ESMhqSu0h/Sx8awuvO0bswyCzoKH4qY+YHbmiWdtgr4k02LVjHmKtB03wcTDJ/OPQnepDXGC8=
X-Gm-Message-State: AOJu0YwDImYWmpt6clpNutQciS8pHtwDLELDUUniT8NJYtAtOxPCabtK
 Bjwzf5ddk9cDd3UXfzOAXHPhJYXFHQDT2qYxl+RZd8DXg4pEl5ze
X-Google-Smtp-Source: AGHT+IE2RR+DAaC1q8ZIc/X2VU9lfjSHeBKCNRpKBlWm9zEWrGg9+a0nR1xLQb1psmgPdXiB357Fdg==
X-Received: by 2002:a25:a322:0:b0:de1:2843:9465 with SMTP id
 3f1490d57ef6-dee4f3089e4mr18532854276.30.1715879136944; 
 Thu, 16 May 2024 10:05:36 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-debd38293bfsm3515687276.52.2024.05.16.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:05:36 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:05:33 -0700
To: Gregory Price <gregory.price@memverge.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZkY83c9PXoop_r1A@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiK25Log7LmtBffa@memverge.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2d.google.com
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

On Fri, Apr 19, 2024 at 02:24:36PM -0400, Gregory Price wrote:
> On Thu, Apr 18, 2024 at 04:10:51PM -0700, nifan.cxl@gmail.com wrote:
> > A git tree of this series can be found here (with one extra commit on top
> > for printing out accepted/pending extent list): 
> > https://github.com/moking/qemu/tree/dcd-v7
> > 
> > v6->v7:
> > 
> > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> >    Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > 4. Added "Reviewed-by" tag to Patch 7.
> > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> >    reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen) 
> > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> >     (Jonathan)
> > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> >    tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > 9. Redesigned the pending list so extents in the same requests are grouped
> >     together. A new data structure is introduced to represent "extent group"
> >     in pending list.  (Jonathan)
> > 10. Added support in QMP interface for "More" flag. 
> > 11. Check "Forced removal" flag for release request and not let it pass through.
> > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> >    to avoid the side effect it may introduce to inject error to DC event log.
> >    (Jonathan)
> > 13. Hard coded the event log type to dynamic capacity event log in QMP
> >     interfaces. (Jonathan)
> > 14. Adding space in between "-1]". (Jonathan)
> > 15. Some minor comment fixes.
> > 
> > The code is tested with similar setup and has passed similar tests as listed
> > in the cover letter of v5[1] and v6[2].
> > Also, the code is tested with the latest DCD kernel patchset[3].
> > 
> > [1] Qemu DCD patchset v5: https://lore.kernel.org/linux-cxl/20240304194331.1586191-1-nifan.cxl@gmail.com/T/#t
> > [2] Qemu DCD patchset v6: https://lore.kernel.org/linux-cxl/20240325190339.696686-1-nifan.cxl@gmail.com/T/#t
> > [3] DCD kernel patches: https://lore.kernel.org/linux-cxl/20240324-dcd-type2-upstream-v1-0-b7b00d623625@intel.com/T/#m11c571e21c4fe17c7d04ec5c2c7bc7cbf2cd07e3
> >
> 
> added review to all patches, will hopefully be able to add a Tested-by
> tag early next week, along with a v1 RFC for MHD bit-tracking.
> 
> We've been testing v5/v6 for a bit, so I expect as soon as we get the
> MHD code ported over to v7 i'll ship a tested-by tag pretty quick.
> 
> The super-set release will complicate a few things but this doesn't
> look like a blocker on our end, just a change to how we track bits in a
> shared bit/bytemap.
> 

Hi Gregory,
I am planning to address all the concerns in this series and send out v8
next week. Jonathan mentioned you have few related patches built on top
of this series, can you point me to the latest version so I can look
into it? Also, would you like me to carry them over to send together
with my series in next version? It could be easier for you to avoid the
potential rebase needed for your patches?

Let me know.

Thanks,
Fan

> > 
> > Fan Ni (12):
> >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >     payload of identify memory device command
> >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >     and mailbox command support
> >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >     type3 memory devices
> >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >     devices
> >   hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> >     size instead of mr as argument
> >   hw/mem/cxl_type3: Add host backend and address space handling for DC
> >     regions
> >   hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >     list mailbox support
> >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >     dynamic capacity response
> >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >     extents
> >   hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
> >   hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
> >   hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > 
> >  hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> >  hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
> >  hw/mem/cxl_type3_stubs.c    |  20 ++
> >  include/hw/cxl/cxl_device.h |  81 ++++-
> >  include/hw/cxl/cxl_events.h |  18 +
> >  qapi/cxl.json               |  69 ++++
> >  6 files changed, 1396 insertions(+), 45 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 

