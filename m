Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22396D30019
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1p1e-0000f8-3P; Fri, 18 Oct 2024 11:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t1p1b-0000eW-IY
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:36:23 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t1p1Z-0000QK-OH
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:36:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b5affde14so16102605ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729265780; x=1729870580; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jTlUoKlg4r25iHgIu+jKaR0sgzj787sAcjBNi0pT5bo=;
 b=X1G2f34TjHcwow9X866nev7abG1fPd9xtoSpNz1w4hhESjWJKKZMyORqyn/MD7ho0O
 7LfDBnKeBtPb0t7XvGqXJeY7QJpGvqcazL2jZpC9Ts1xbVmkpuIef74wsqr19ISKCLFe
 iBTZQKoJVqvvwU1mwdhzYrQx6x3Y7BXCc2frEsUel7KdH0ZbZCI1Op3ek3Z9eIY87iVD
 BKj1/WHYewjXgBgzGsAxRwaTTc76NNbV4nVr0ED+85Cj/sNq5yXaY3vVlN4zcn8Oq5Nd
 c984/cH3Wjz+yYdEFfpDpalKYMxu+ihXUQKjZyj9vtqKYbNNgeEKEWZxfcmTW/0x67QD
 CVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729265780; x=1729870580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTlUoKlg4r25iHgIu+jKaR0sgzj787sAcjBNi0pT5bo=;
 b=OLPLrbJPnekug+rdOid9QxJ3FL/UlTw3pqfBO5l6SOzpHRcYJ2Dp2gX7YG7IyQ1HnH
 r7nGi4PMzclO+L/76HjfFMmTN0zYARsbwlR5Sn/9Tw9SlrdU5oenV3NfvnjjMoNHuQUx
 jz+NM+39pKPYxsFQe3BjzyJBTQEciBJmcs3RcyBPEPhRSPIqeUblTQBsBdiaF5m9IY87
 CoJlTah2nux7c2SgDW2NcHsWu8uk9LEnEHtGFQBKyOhwY080jB3RIpYhcVrzYD40Za1k
 9bgdFMy7Zzw0aNJcLt5grGbVLYMRpirMckvjk2f/auqITtmhfws53nm9uUsteveIxXrU
 RGiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb6KwrJNy05ZTB/9WMxfTsnGB6ppObAKJ5v6fsAthvZj8Tf4qRMcZLueqaJrflpryE+HqZgG0OKgpC@nongnu.org
X-Gm-Message-State: AOJu0YxMYEedUfLvqHxjet6q6TX8CSfVftr7UGmDWiHQQQL0KFyTi2dE
 wgpRTXl9KVcaEPaiiAU8bXta6J7ZAP5f4TOXadzEV+qWpHET9Bt1
X-Google-Smtp-Source: AGHT+IFM9wMUoV2RnUxgeeSL5PIjuz3bCo1cgk8ZhHffUBSTBvQojN4p121NHi1hkCVWB5hXY+Y6Sw==
X-Received: by 2002:a17:902:ea0e:b0:20c:7c09:b2ac with SMTP id
 d9443c01a7336-20e5a93a6fdmr31900095ad.52.1729265779922; 
 Fri, 18 Oct 2024 08:36:19 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:a6cf:738d:e6be:c278])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8d6768sm14052785ad.161.2024.10.18.08.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 08:36:19 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 18 Oct 2024 08:35:56 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: [QEMU RFC] hw/mem/cxl_type3: add guard to avoid event log
 overflow during a DC extent add/release request
Message-ID: <ZxKAXPGHDxlr0U9q@fan>
References: <20241011202929.11611-2-nifan.cxl@gmail.com>
 <20241014122322.00001ad4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014122322.00001ad4@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
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

On Mon, Oct 14, 2024 at 12:23:22PM +0100, Jonathan Cameron wrote:
> On Fri, 11 Oct 2024 13:24:50 -0700
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > One DC extent add/release request can take multiple DC extents.
> > For each extent in the request, one DC event record will be generated and
> > isnerted into the event log. All the event records for the request will be
> > grouped with the More flag (see CXL spec r3.1, Table 8-168 and 8-170).
> > If an overflow happens during the process, the yet-to-insert records will
> > get lost, leaving the device in a situation where it notifies the host
> > only part of the extents involved, and the host never surfacing the
> > extents received and waiting for the remaining extents.
> 
> Interesting corner.  For other 'events' an overflow is natural because
> they can be out of the control of the device. This artificial limit
> was to trigger the overflow handling in those cases. For this one I'd expect
> the device to push back on the fabric management commands, or handle the
> event log filling so overflow doesn't happen.
> 
> > 
> > Add a check in qmp_cxl_process_dynamic_capacity_prescriptive and ensure
> > the event log does not overflow during the process.
> > 
> > Currently we check the number of extents involved with the event
> > overflow threshold, do we need to tight the check and compare with
> > the remaining spot available in the event log?
> 
> Yes. I think we need to prevent other outstanding events causing us trouble.
> 
> Is it useful to support the case where we have more than one
> group of extents outstanding?  If not we could simply fail the add whenever
> that happens.  Maybe that is a reasonable stop gap until we have a reason
> to care about that case. We probably care when we have FM-API hooked up
> to this and want to test more advanced fabric management stuff, or poke
> a corner of the kernel code perhaps?
As long as the last record with More flag cleared put in the log, the
kernel is able to handle it and clear the log after finishing
processing. The only issue I can see now is the last event cannot be
inserted into the log due to overflow, so i think as long as we have
enough space to hold all the records of a request in the log, it would
be enough, no matter the log already has some outstanding extents or
not.
> 
> I guess from a 'would it be right if a device did this' the answer may be
> yes, but that doesn't mean Linux is going to support such a device
> (at least not until we know they really exist).  Ira, what do you think
> about this corner case?  Maybe detect and scream if we aren't already?

Any thought, Ira?

Fan
> 
> Jonathan
> 
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-events.c         | 2 --
> >  hw/mem/cxl_type3.c          | 7 +++++++
> >  include/hw/cxl/cxl_events.h | 3 +++
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > index 12dee2e467..05d8aae627 100644
> > --- a/hw/cxl/cxl-events.c
> > +++ b/hw/cxl/cxl-events.c
> > @@ -16,8 +16,6 @@
> >  #include "hw/cxl/cxl.h"
> >  #include "hw/cxl/cxl_events.h"
> >  
> > -/* Artificial limit on the number of events a log can hold */
> > -#define CXL_TEST_EVENT_OVERFLOW 8
> >  
> >  static void reset_overflow(CXLEventLog *log)
> >  {
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 3d7289fa84..32668df365 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -2015,6 +2015,13 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
> >          num_extents++;
> >      }
> >  
> > +    if (num_extents > CXL_TEST_EVENT_OVERFLOW) {
> > +        error_setg(errp,
> > +                   "at most %d extents allowed in one add/release request",
> > +                   CXL_TEST_EVENT_OVERFLOW);
> > +       return;
> > +    }
> > +
> >      /* Create extent list for event being passed to host */
> >      i = 0;
> >      list = records;
> > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > index 38cadaa0f3..2a6b57e3e6 100644
> > --- a/include/hw/cxl/cxl_events.h
> > +++ b/include/hw/cxl/cxl_events.h
> > @@ -12,6 +12,9 @@
> >  
> >  #include "qemu/uuid.h"
> >  
> > +/* Artificial limit on the number of events a log can hold */
> > +#define CXL_TEST_EVENT_OVERFLOW 8
> > +
> >  /*
> >   * CXL r3.1 section 8.2.9.2.2: Get Event Records (Opcode 0100h); Table 8-52
> >   *
> 

-- 
Fan Ni

