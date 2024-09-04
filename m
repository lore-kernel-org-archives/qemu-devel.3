Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C553BCD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sltDb-0005zm-7h; Wed, 04 Sep 2024 12:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sltDQ-0005yP-Ci
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:50:47 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1sltDO-0006Xt-Mk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:50:44 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6c91f9fb0d7so10563347b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725468641; x=1726073441; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HU7OztcxC4dGOh1jD0or8NoLTJ47z4j1W9gRHRA+RV4=;
 b=gZnehKP++a+EneEzHPujOuIMtMXg1ApjvFzxNOTTYBmHTAXKg4lAOseQgSEN+WIH9N
 B/vrjFB10b0CGspgsD22014vCL/WGrNIcj+jsBm6950UwQ2S0dLwdQ3U+atN33pMPCp0
 hGpNJfg/BWMiGNxWGzeI3EYAUHWxLRD0Le5vl1kgz7wCnZanDXQ9OpKR7sdO0x7fWwlq
 j90lSLbmEG74oMWUvV8wjbIu+ODa3kicOsPZevqm1sjPlydRg55ddKzm0+LqM/tD1+NO
 et9UlwNCGdDjRptGGW48iuzYo/rQkoUFAI6hxtOPXjlyOUhHWghSvirQAjd3rMjMjn5c
 PGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725468641; x=1726073441;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU7OztcxC4dGOh1jD0or8NoLTJ47z4j1W9gRHRA+RV4=;
 b=G8yyEF8YpAlBk2vRYHC3EsMOiiBlZtEs+B2h5v8QWIjk1pHOPimqepKtv8I3JoW/KI
 iqYeI/QUtsQV6gpX3oKjYzgmjBwzwqYS1GCmAmfo7cEhGkUIcoP37iO2ivleh+kBex79
 kSCBESaV4wqYC0naWkPq8YywrY5Sznnji3gixx1oqOPK7bjzmtCJ/7qXZHOb33stamax
 ftTTahX5KRnxVu5+hC7X2DRKbLcmCy0nfY9siHg1QAUx0xX/KqLvy/PTftPtugpngVfh
 mK2z1SbDF2dpeF/wIm1ejHOMa8P9ew4gItMpMXJw7tKIdF/xLLOKlPPWU+II6clOVVJ5
 ZAwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBT3fz4f4VB/KKMphUe5fO6YeWLpXe5UMGN7cNIYmkt2V2KrN48892AYmeMmClru/67QFl/luPf1Dy@nongnu.org
X-Gm-Message-State: AOJu0Yw0dwBfdHbZOxbYYhHkWzAJEv5109KOBIAI3jQOPIWljEkNnyky
 6VUBNy+sUnOCG7vi2fvTBCCrjgTaBB7fKbKXZ+bTJGCDZVraA+eW
X-Google-Smtp-Source: AGHT+IHuJimfGTXEpdqlFDSiMK+DYE/CcnQ1wPzFxlkDDkQ6qmhmI6vJl7XI3nPcT888+1D4k/M/7A==
X-Received: by 2002:a05:690c:82:b0:6b0:3303:803b with SMTP id
 00721157ae682-6db236c88f4mr41479387b3.23.1725468641082; 
 Wed, 04 Sep 2024 09:50:41 -0700 (PDT)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6d5a267d5basm16086937b3.15.2024.09.04.09.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:50:40 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 4 Sep 2024 09:50:15 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, nifan.cxl@gmail.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: [PATCH 2/2] hw/cxl/cxl_event: Fix interrupt triggering for
 dynamic capacity events grouped via More flag
Message-ID: <ZtiPxyDYatbP8p98@fan>
References: <20240827164304.88876-1-nifan.cxl@gmail.com>
 <20240827164304.88876-3-nifan.cxl@gmail.com>
 <20240828123919.00005b5f@Huawei.com>
 <66d88ccd15efb_1e915829439@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d88ccd15efb_1e915829439@iweiny-mobl.notmuch>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x1129.google.com
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

On Wed, Sep 04, 2024 at 11:37:33AM -0500, Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Tue, 27 Aug 2024 09:40:05 -0700
> > nifan.cxl@gmail.com wrote:
> > 
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > When inserting multiple dynamic capacity event records grouped via More flag,
> > > we should only trigger interrupt after the last record is inserted into the
> > > event log. Achieving the goal by letting cxl_event_insert return true only
> > > for the insertion of the last dynamic capacity event record in the sequence.
> > 
> > I'm not sure this one is accurate.  We might well have a slow
> > system provisioning capacity one extent at time (and interrupting).
> > 
> > The event buffer might also not be large enough to hold all records so
> > the device might 'wait' before figuring out the next extent for there
> > to be somewhere to put the record.
> > 
> > Overall I think we can interrupt on each one and it should 'work'
> > as should interrupt only once there are lots of them or
> > every (n).
> 
> Indeed I think it should work.  But you won't see any extents as they will
> be pending in the memdev.
> 
> Did this fail in some way?  I'm sorry I did not try and use qemu to test
> the more bit.  Rather I used cxl_test for that.
> 
> Ira

It works with or without this fix in my test. Until the last extent is
notified to the OS, the extents will be pending as you mentioned. 

Fan

> 
> > 
> > Interrupt only fires on a 0 to >= 1 transition anyway, not
> > on repeats after that unless the log has been cleared.
> > It's up to OS to keep clearing records until it at least
> > momentarily hits 0 if it wants to get any more interrupts.
> > 
> > Jonathan
> > 
> > 
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > ---
> > >  hw/cxl/cxl-events.c         | 8 ++++++++
> > >  include/hw/cxl/cxl_events.h | 1 +
> > >  2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> > > index 12dee2e467..90536c0e68 100644
> > > --- a/hw/cxl/cxl-events.c
> > > +++ b/hw/cxl/cxl-events.c
> > > @@ -135,6 +135,14 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
> > >      QSIMPLEQ_INSERT_TAIL(&log->events, entry, node);
> > >      cxl_event_set_status(cxlds, log_type, true);
> > >  
> > > +    /*
> > > +     * For dynamic capacity event records grouped via More flag,
> > > +     * Only raise interrupt after inserting the last record in the log.
> > > +     */
> > > +    if (log_type == CXL_EVENT_TYPE_DYNAMIC_CAP) {
> > > +        CXLEventDynamicCapacity *dCap = (CXLEventDynamicCapacity *)event;
> > > +        return (dCap->flags & MORE_FLAG) ? false : true;
> > > +    }
> > >      /* Count went from 0 to 1 */
> > >      return cxl_event_count(log) == 1;
> > 
> > If there are multiple this will fail I think as cxl_event_count(log) will go from 0
> > to X not 1.
> > 
> > >  }
> > > diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> > > index 38cadaa0f3..b0e5cc89c0 100644
> > > --- a/include/hw/cxl/cxl_events.h
> > > +++ b/include/hw/cxl/cxl_events.h
> > > @@ -170,6 +170,7 @@ typedef struct CXLEventMemoryModule {
> > >   * CXL r3.1 section Table 8-50: Dynamic Capacity Event Record
> > >   * All fields little endian.
> > >   */
> > > +#define MORE_FLAG BIT_MASK(0)
> > >  typedef struct CXLEventDynamicCapacity {
> > >      CXLEventRecordHdr hdr;
> > >      uint8_t type;
> > 
> 
> 

-- 
Fan Ni

