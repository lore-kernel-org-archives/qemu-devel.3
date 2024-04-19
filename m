Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5DBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxtD5-0006lp-Ne; Fri, 19 Apr 2024 14:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxtD3-0006k4-Bp
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:43:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rxtD1-0000Dr-FX
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:43:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so2432939b3a.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 11:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713552217; x=1714157017; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y3SGJdTiCbneZQ9xF1P/4L3glY2bSj97aScmfRfKL+g=;
 b=drWq6KajwKu2xvgDhJhsk822jmZT8bGCd/BUwuR+1VDBuoFOr2r+35sNImOju4gIos
 SgJxSvCYzk+rd5K2lcCI3CVQ8MNL/dkPqXg+WHFcO8jPHV6DSkM4wfnl0fJQmLnrfFA2
 u3+N+FZtEkieWeOfMZEKzEt6WIy8rnIHisxm8ZjYO14cd3LvbVQEFsCX6u+DF4ma8YWn
 EyrylH9Z+sTeWO0cEmaiJ92B+pjHG+b7Z987FoPsOGAw18/8LlNeHVsTNhIZ7Qs3b645
 3D2iPrjJboQ6Xsgpbd7BT131Pr0YPtLpmO9Nl2tzk71pM3lz2+iHgJTAefL2Io4GauH+
 /SuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713552217; x=1714157017;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3SGJdTiCbneZQ9xF1P/4L3glY2bSj97aScmfRfKL+g=;
 b=sQNeEy4cgWJfVQpOkmoQ/V9S033k1/saSEPOwsyRB3zvin8eKDkv86LzTiL4Y2Fg5a
 Acq2HLSTAo1ExdzNT6L5oMxf3rqjLjFyLOZus7jihdQoHPLGr75C2ZxQ5z+YYMq5F78z
 2EEHHUUQnaagZq683TPyzXSiD1z4WDVfATC+PmGLQYTsWgJwMn0A2VNbRBjgWxIBFsDK
 iPW8GiQ5kjFh9cu5rBXRho2O9CgZEA/9DFan4PYq38Fij7zoFFBRN8Flyh9/Dq6UL79c
 AdIyK5rVlnZ5jVTHsZekZ97Ht5YYkW5S/TqQFj56YVKsjwNinYGfzLmF7XSIMiqe/Kjp
 11sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnUb9Uv3CIgTWiUyX8/b6kGyFZ0tcNm7Z/WsR/QRRSMDX4ukbBIHmiP8oK1npgJLGbhjLKIyGhJE6kCAy9DcsXIAVaOy4=
X-Gm-Message-State: AOJu0YxqkLEL10VRiOVcwlWvcBMoIxXt1dWoPvXLcDDfAkpkpt3pK0X8
 vJ3Uj+xcyIjgoCsmqdB/rV9nwPflfCk5Dl31jYrV/VeLVoGp51jd
X-Google-Smtp-Source: AGHT+IEt0rYHHfLtoYwUigOXzCd9ynf0M/YgxLHlr/sd4dfyIGeWRMQ4jzueIoH7XMv3/wp0wSy0og==
X-Received: by 2002:a05:6a20:551a:b0:1a7:7d2f:6c01 with SMTP id
 ko26-20020a056a20551a00b001a77d2f6c01mr2992182pzb.48.1713552217279; 
 Fri, 19 Apr 2024 11:43:37 -0700 (PDT)
Received: from debian ([2601:641:300:14de:df9a:a0db:2922:7fe6])
 by smtp.gmail.com with ESMTPSA id
 n56-20020a056a000d7800b006e6b7124b33sm3551497pfv.209.2024.04.19.11.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 11:43:36 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 19 Apr 2024 11:43:14 -0700
To: Gregory Price <gregory.price@memverge.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 fan.ni@samsung.com
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZiK7QtVxutwDys4K@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <ZiK25Log7LmtBffa@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiK25Log7LmtBffa@memverge.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42d.google.com
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
Thanks for reviewing the patches so quickly. 

No pressure, but look forward to your MHD work. :)

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

