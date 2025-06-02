Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F192C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 17:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM9Fn-00053H-3k; Mon, 02 Jun 2025 13:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uM9FZ-0004yr-Ao
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:47:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uM9FW-0008E4-7q
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 13:47:05 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-742af848148so3071828b3a.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748886420; x=1749491220; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lXOxmjxJTW7vpVDwTCYY+gUTdvFyCG/DWn1e8gUxoXc=;
 b=JxKbfzsM2M+zul2Mycira/RdBumuLNm1JYkvzoAPFtX6zRnKISc8finDz8sAMrWD/K
 cgLjElOcrh/CfRb75JaV/4XjOojSrQijO+fmotLkgliJwHa8SQk/tcwNgazBOaSwQAcM
 j18e41Zgo/OeYPJ/r8coYVntQ14MqZ0UDO5H8c0HFq3yTWdEBBUwu/V/VjoaU44i8nDa
 EZONDfoZ3hOH6bTHjt3elzWVNAaLaNjf9SQ768WccQyauIMsPCZXO9RMk7rchV3M2EHn
 6qMdSxqJuF/c4KCQ694mbhgaVyDSE8ysLLccDx7ipMtJSEGIhJISx23GlwmrTwlwDa+U
 eXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748886420; x=1749491220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXOxmjxJTW7vpVDwTCYY+gUTdvFyCG/DWn1e8gUxoXc=;
 b=RpCjCG+SeilO2H/Nq70jAl1DH9MCpWWCvGd5Zl0oQ0Ph7qmUT7tq1gyOpWH2jmdX8p
 DfkXoWmTgZMMZqJCEdeOSE0cEkWbeD33UUHYAE2IX5Q8B7Sx19TOcoWxWGcny4KqlSgr
 QHo2/+95nLF4xgIX9HsMJd7Sjow4C92yuEQEQdUmxIyBuD9rnIASESaXvT3WPcj/jilx
 p0U9plF7Sf9IPEV+N7mrt7db2m/1FgKeQB6RNl2unR2ULMB6XcEJIvnBjfT7oOv5yM/v
 I9zKCJmxy11QX/PqcdKT4eJhoTSFEexts5hzEXV3IWaLVkiMZOq+Mlugu9w9NTt4TXou
 NxYw==
X-Gm-Message-State: AOJu0YwXrPG7WXz2JOzLpf+2i4/+dCUmHqCfdhS0c3Di7x636oAk8UbP
 zv9E4QxaTw12pwV5+tcxR+mxtiyubqdC5Hq9OAj1Jl2qZIfbULl9a46D
X-Gm-Gg: ASbGnctvuwBpQu/5tpAuSEBsPp3WbPte6sW8b1bqgyVG0CqZtwbR5pyL1Q0u+Zch10+
 +vVVwVKhP/ZlMZ7SL2LzXczxJbwjtYcHirv1BZGKQ6tXQEahyK4gOvJw0fG8R93XSwan/SEUItT
 JR/NuaE1Swc+dAeld2JKDhjvUjYiJbjG188LQznkXrbmCjLigFJ2dxpD+mfg/HtGx8O4cgQm9aa
 YozrQRIEP2YivbyeiFs6Y0Tc/A/U6+srmwCldL36G4sNScRtJuB+0D97dwZnRteDQMM9488JMse
 DSUPshQjjOlLwNWUSYZp+OO/uqkQIXVc/bWFg1cInQlWaSlkvfkgxHiOddihKBo7KcPaY1HeBtv
 wsg==
X-Google-Smtp-Source: AGHT+IGwTXr02neCGnVcFeoVH37rrSREjgCOPvTOpyw3Wo4CW4jsOWStJ26+hgejI175AltkHOrL8Q==
X-Received: by 2002:a05:6a00:10c8:b0:747:cffb:bb37 with SMTP id
 d2e1a72fcca58-747d1833514mr11642565b3a.10.1748886419565; 
 Mon, 02 Jun 2025 10:46:59 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afeab75csm8138278b3a.52.2025.06.02.10.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 10:46:59 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 2 Jun 2025 17:46:57 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron via <qemu-devel@nongnu.org>, anisa.su887@gmail.com,
 nifan.cxl@gmail.com, dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 00/10] CXL: FMAPI DCD Management Commands 0x5600-0x5605
Message-ID: <aD3jkRBHmbdc9QmD@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250520143947.00000337@huawei.com>
 <20250530152655.00007132@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530152655.00007132@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, May 30, 2025 at 03:26:55PM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 14:39:47 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > On Thu,  8 May 2025 00:00:56 +0000
> > anisa.su887@gmail.com wrote:
> > 
> > > From: Anisa Su <anisa.su@samsung.com>
> > > 
> > > This patchset adds support for 6 FM API DCD Management commands (0x5600-0x5605)
> > > according to the CXL r3.2 Spec. It is based on the following branch:
> > > https://gitlab.com/jic23/qemu/-/tree/cxl-2025-02-20.  
> > 
> > Nice work - this is very clean and well presented.
> > 
> > I would like Fan to take a look an provide some tags as DCD modeling in
> > QEMU is more in his area of expertise than mine!
> > 
> > I think this series is much more ready for upstream than much of
> > my staging cxl tree so I'll rebase it to go near the front.
> > 
> > Today I'm focused on getting test cases to Richard for the TCG issues but
> > after that I'll spin a new tree (probably pushed out under a name
> > that makes it clear there is a known nasty problem though!)
> 
> Anisa,
> 
> Ideally I'd like to get the majority of this upstream once you post
> a v3.  To do that I'd like to break the dependence on mctp_i2c in patch 2.
> These commands are equally valid via a switch-cci (and that path to the
> fm owned ld_mctpcci is already upstream).
> 
> If you could send it as two series. One of which sits on upstream and
> doesn't include the i2c_mctp part and the other of which is applied once
> that support is available in my tree that would be great. I'll squash
> the i2c_mctp part into the patch that adds support for that in the
> first place.
> 
> I'll deal with rebasing needed for other command introductions etc.
> 
> There are just enough open questions in this series that I haven't done
> this rework directly (though I did start doing it - hence the missing
> include note in one of the patches).
> 
> Thanks,
> 
Sounds good, will do :)

Thanks,
Anisa
> Jonathan
> > 
> > Jonathan
> > 
> > 
> > > 
> > > The code was tested with libcxlmi, which runs in the QEMU VM and sends 56xxh
> > > commands to the device (QEMU emulated) through MCTP messages over I2C
> > > bus. To perform end-to-end tests, both MCTP and DCD support are needed
> > > for the kernel, so the needed MCTP patches are applied on top of Ira's DCD
> > > branch https://github.com/weiny2/linux-kernel/tree/dcd-v4-2024-12-11.
> > > 
> > > For the tests of commands 0x5600 (Get DCD Info), 0x5601 (Get Host DC Region
> > > Config), and 0x5603 (Get DC Region Extent Lists), DCD kernel code is not involved.
> > > The libcxlmi test program is used to send the command to the device and results
> > > are collected and verified.
> > > 
> > > For command 0x5602 (Set DC Region Config): device creates an event record with type
> > > DC_EVENT_REGION_CONFIG_UPDATED and triggers an interrupt to the host
> > > if the configuration changes as a result of the command. Currently, the kernel
> > > version used to test this only supports Add/Release type events. Thus, this
> > > request essentially gets ignored but did not cause problems besides the host
> > > not knowing about the configuration change when tested.
> > > 
> > > For the command 0x5604 (Initiate DC Add) and 0x5605 (Initiate DC Release), the
> > > tests involve libcxlmi test program (acting as the FM), kernel DCD
> > > code (host) and QEMU device. The test workflow follows that in cxl r3.2 section
> > > 7.6.7.6.5 and 7.6.7.6.6. More specifically, the tests involve following
> > > steps,
> > > 1. Start a VM with CXL topology: https://github.com/moking/cxl-test-tool/blob/main/utils/cxl.py#L54.
> > > 2. Load the CXL related drivers in the VM;
> > > 3. Create a DC region for the DCD device attached.
> > > 4. add/release DC extents by sending 0x5604 and 0x5605 respectively through
> > > the out-of-tree libcxlmi test program
> > > (https://github.com/anisa-su993/libcxlmi/blob/dcd_management_cmds/tests/test-fmapi.c).
> > > 5. Check and verify the extents by retrieving the extents list through
> > > command 0x5603 in the test program.
> > > 
> > > The remaining 3 commands in this series (0x5606-0x5608) are related to tags
> > > and sharing, thus have not been implemented.
> > > 
> > > Changes
> > > ================================================================================
> > > v1 -> v2:
> > > 1. Feedback from Jonathan Cameron on v1
> > > Addressed general style concerns (newlines/spacing, minor refactoring, etc.)
> > > 1.1. Changes Related to 0x5600 - FMAPI Get DCD Info
> > >     - Squashed prepatory patch adding supported_blk_sizes_bitmask
> > >     - Added new prepatory patch moving opcodes enum from cxl-mailbox-utils.c to
> > >     new header file opcodes.h
> > >     Needed for the check in i2c_mctp_cxl.c to ensure the FMAPI Commands
> > >     (0x51 - 0x59) are bound with MCTP_MT_CXL_FMAPI. By moving the enum,
> > >     the hardcoded values (0x51, 0x59) can be replaced with their
> > >     enumerators.
> > >     - Bug fix to return Add/Release Extent Selection Policy bitmasks
> > >       correctly
> > > 1.2. Changes Related to 0x5601 - FMAPI Get Host Region Config
> > >     - Prepatory patch to add dsmas_flags to CXLDCRegion struct was modified to
> > >     store the booleans dsmas_flags is made up of instead of copying it from the
> > >     CDAT for that region. Values hardcoded for unsupported flags.
> > >     - Build the returned dsmas_flags from the new booleans.
> > > 1.3. Changes Related to 0x5602 - FMAPI Set DC Region Config
> > >     - Added locking for CXLDCRegion bitmap for the case that extents are being
> > >     added/released via a different CCI than that of the FM-enabled CCI.
> > >     - Prepatory patch created for the above (quite short, can be squashed if
> > >     preferred)
> > >     - Added a check to verify that the requested block_size is supported by the
> > >     region by looking at region->supported_blk_sizes_bitmask
> > >     - Instead of event_record validity flag being cleared, set to 1
> > >     - Fixed bug of forgetting to update region->block_size
> > > 1.4. Changes Related to 0x5603 - FMAPI Get DC Region Extents
> > >     - Minor refactoring of loop filling in response payload extents
> > > 
> > > 2. Feedback from Fan Ni and Jonathan Cameron on v1
> > > 2.1. Changes Related to 0x5604 - FMAPI Initiate DC Add
> > >     - Remove redundant storage of extents in event_rec_exts
> > >     - Refactor event record creation into helper function for re-use by release
> > >     - Return event_record.available_extents
> > >     (total_extents_available - num_pending - num_accepted) instead of
> > >     leaving it blank
> > > 2.2. Changes Related to 0x5605 - FMAPI Initiate DC Release
> > >     - Remove redundant storage of extents in event_rec_exts/redundant 2nd loop
> > >     - Add #define for removal_policy_bitmask instead of hardcoding 0x7
> > > 
> > > Anisa Su (10):
> > >   cxl-mailbox-utils: Move opcodes enum to new header file
> > >   cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
> > >   cxl/type3: Add dsmas_flags to CXLDCRegion struct
> > >   cxl-mailbox-utils: 0x5601 - FMAPI Get Host Region Config
> > >   cxl_events.h: Move definition for dynamic_capacity_uuid and enum for
> > >     DC event types
> > >   hw/cxl_type3: Add DC Region bitmap lock
> > >   cxl-mailbox-utils: 0x5602 - FMAPI Set DC Region Config
> > >   cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent Lists
> > >   cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
> > >   cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
> > > 
> > >  hw/cxl/cxl-mailbox-utils.c   | 649 +++++++++++++++++++++++++++++++----
> > >  hw/cxl/i2c_mctp_cxl.c        |   6 +-
> > >  hw/mem/cxl_type3.c           |  41 ++-
> > >  include/hw/cxl/cxl_device.h  |  24 ++
> > >  include/hw/cxl/cxl_events.h  |  15 +
> > >  include/hw/cxl/cxl_mailbox.h |   6 +
> > >  include/hw/cxl/cxl_opcodes.h |  72 ++++
> > >  7 files changed, 724 insertions(+), 89 deletions(-)
> > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > >   
> > 
> > 
> 

