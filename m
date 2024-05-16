Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5BAC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7eea-0005DD-Cd; Thu, 16 May 2024 13:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eeZ-0005D2-7s
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:12:27 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1s7eeX-0007YT-ET
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:12:27 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-deb99fa47c3so8565174276.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715879544; x=1716484344; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=snPyh1RNmFPpaf4s2wMbMsVnyHhD/A9xFV3JyNxhnhg=;
 b=NlK68Lp2YodbKoEe5ZGbuOqKDSuXfDZ24Nk/8hUJPtyUku1+EEtAonWJPPb6vr239D
 eR2JTnMTzwBLOd5fsk2+A+HoircPXYt+zbFAUQG01mPD5k9XKIgaKOdGUscS+wdoMETO
 2Xs8g8pqD/WNQY3VoVDi3VBrGGC0ht8ppvsRjYIBJvQ0sEUhHn4fMsYZSFb3bHbgV2V9
 OknZowMRZGxVss5tE0A5lYBSBZDlEZQ4nK1c2SebOcOvWeFRD4BY/JCD7VloYLf2lmRf
 hGR4nD5TIxL8u5UiCEyEfNu6/8mG99snusJqAnqqWCWJnDdKTryA2kSr6TqNhqx08cFN
 qclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715879544; x=1716484344;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=snPyh1RNmFPpaf4s2wMbMsVnyHhD/A9xFV3JyNxhnhg=;
 b=jPwaM3VZnxfjltXOgV0hp64zWM6p3aROWF8/rI6i6hn3jsNM4KMKyGgej1Z0UFex0J
 9fEI34usVP7wbzU7/COlty4gBBhi300W0wvOF7tKF9FYjHf9RERWUqCk5kTbZIxS6QVL
 7ctb4wkjOf9EKhbG94VfnHZiRHduhtXRtRKSZsDACEoTC/geqWTaXf2+WTg4fZLLAcE+
 l1jWPswoTz5ti2en4pF5Oyxypxoz4C8CWBgBk9dzzR6ZLOWR1zjf3ipLoVhLlQ5yRimu
 SvNvV/KU6ZhzFQ9srVK6tS9yI4M49Ulw8tVejCdVLGudXwOpHLoFMDOCVTnPTc5YgamL
 KWng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVtTjP+C59tp1SVNZDmP3y8eKNoG+dlNep/7ikohzp6OGAMBvDJLU44OyWNDjJltatobcITZuIof+nph2qVm3v5AyYumY=
X-Gm-Message-State: AOJu0YyC19pLzvyP57Y3I0lwRGsrFtQNj3X4txI1E0UjWZ9pXuupWZWt
 9V5DvYVe4jwufiavDLJexIb3RwCBki/SZVHot4j2x+YE8L7dn+0i
X-Google-Smtp-Source: AGHT+IEWmL1dlJHYMl9hrGJxzFwQWp75Gt/TK3FJTnQhi4RuoY146wK4nRuaqzXyu8ODpPW9uJAdGA==
X-Received: by 2002:a25:2e0c:0:b0:de6:40b:fef2 with SMTP id
 3f1490d57ef6-dee4f2d8e89mr18715674276.18.1715879544040; 
 Thu, 16 May 2024 10:12:24 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-debd34fde87sm3559038276.0.2024.05.16.10.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:12:23 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:12:19 -0700
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 "Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
 "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH v7 00/12] Enabling DCD emulation support in Qemu
Message-ID: <ZkY-c1V-o4100onE@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2c.google.com
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

On Tue, May 14, 2024 at 02:16:51AM +0000, Zhijian Li (Fujitsu) wrote:
> Hi Fan
> 
> 
> Do you have a newer instruction to play with the DCD. It seems that
> the instruction in RFC[0] doesn't work for current code.
> 
> [0] https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@samsung.com/
> 

For the testing, the only thing that has been changed for this series is
the QMP interface for add/release DC extents.

https://lore.kernel.org/linux-cxl/d708f7c8-2598-4a17-9cbb-935c6ae2a2be@fujitsu.com/T/#m05066f0098e976fb1c4b05db5e7ff7ca1bf27b1e

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each 128MiB long)
to region 0 (starting at DPA offset 0) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "hid": 0,
      "selection-policy": 2,
      "region-id": 0,
      "tag": "",
      "extents": [
      {
          "offset": 0,
          "len": 134217728
      },
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MiB from region 0
(DPA offset 128MiB) looks like below:

{ "execute": "cxl-release-dynamic-capacity",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "hid": 0,
      "flags": 1,
      "region-id": 0,
      "tag": "",
      "extents": [
      {
          "offset": 134217728,
          "len": 134217728
      }
      ]
  }
}

btw, I have a wiki page to explain how to test CXL DCD with a tool I
wrote.
https://github.com/moking/moking.github.io/wiki/cxl%E2%80%90test%E2%80%90tool:-A-tool-to-ease-CXL-test-with-QEMU-setup%E2%80%90%E2%80%90Using-DCD-test-as-an-example

Let me know if you need more info for testing.


Fan

> 
> 
> On 19/04/2024 07:10, nifan.cxl@gmail.com wrote:
> > A git tree of this series can be found here (with one extra commit on top
> > for printing out accepted/pending extent list):
> > https://github.com/moking/qemu/tree/dcd-v7
> > 
> > v6->v7:
> > 
> > 1. Fixed the dvsec range register issue mentioned in the the cover letter in v6.
> >     Only relevant bits are set to mark the device ready (Patch 6). (Jonathan)
> > 2. Moved the if statement in cxl_setup_memory from Patch 6 to Patch 4. (Jonathan)
> > 3. Used MIN instead of if statement to get record_count in Patch 7. (Jonathan)
> > 4. Added "Reviewed-by" tag to Patch 7.
> > 5. Modified cxl_dc_extent_release_dry_run so the updated extent list can be
> >     reused in cmd_dcd_release_dyn_cap to simplify the process in Patch 8. (Jørgen)
> > 6. Added comments to indicate further "TODO" items in cmd_dcd_add_dyn_cap_rsp.
> >      (Jonathan)
> > 7. Avoided irrelevant code reformat in Patch 8. (Jonathan)
> > 8. Modified QMP interfaces for adding/releasing DC extents to allow passing
> >     tags, selection policy, flags in the interface. (Jonathan, Gregory)
> > 9. Redesigned the pending list so extents in the same requests are grouped
> >      together. A new data structure is introduced to represent "extent group"
> >      in pending list.  (Jonathan)
> > 10. Added support in QMP interface for "More" flag.
> > 11. Check "Forced removal" flag for release request and not let it pass through.
> > 12. Removed the dynamic capacity log type from CxlEventLog definition in cxl.json
> >     to avoid the side effect it may introduce to inject error to DC event log.
> >     (Jonathan)
> > 13. Hard coded the event log type to dynamic capacity event log in QMP
> >      interfaces. (Jonathan)
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
> > 
> > Fan Ni (12):
> >    hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> >      payload of identify memory device command
> >    hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representative
> >      and mailbox command support
> >    include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> >      type3 memory devices
> >    hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> >      devices
> >    hw/mem/cxl-type3: Refactor ct3_build_cdat_entries_for_mr to take mr
> >      size instead of mr as argument
> >    hw/mem/cxl_type3: Add host backend and address space handling for DC
> >      regions
> >    hw/mem/cxl_type3: Add DC extent list representative and get DC extent
> >      list mailbox support
> >    hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release
> >      dynamic capacity response
> >    hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> >      extents
> >    hw/mem/cxl_type3: Add DPA range validation for accesses to DC regions
> >    hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
> >    hw/mem/cxl_type3: Allow to release extent superset in QMP interface
> > 
> >   hw/cxl/cxl-mailbox-utils.c  | 620 ++++++++++++++++++++++++++++++++++-
> >   hw/mem/cxl_type3.c          | 633 +++++++++++++++++++++++++++++++++---
> >   hw/mem/cxl_type3_stubs.c    |  20 ++
> >   include/hw/cxl/cxl_device.h |  81 ++++-
> >   include/hw/cxl/cxl_events.h |  18 +
> >   qapi/cxl.json               |  69 ++++
> >   6 files changed, 1396 insertions(+), 45 deletions(-)
> > 

