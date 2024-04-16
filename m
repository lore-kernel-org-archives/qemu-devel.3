Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6E3C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 16:37:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwloI-0005kF-HH; Tue, 16 Apr 2024 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rwlo5-0005jr-91
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:37:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rwlo3-0005cV-Aa
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 12:37:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3e84a302eso31390795ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713285433; x=1713890233; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tNkzCRV02na/4jpDqu06Tw7UMHfd7rDdiAUaQoNz8M8=;
 b=DcI/pZwnPpb6VbcZn66xyv4k9O2E2LmNwOAEAL4J4YYXngLfuNtt5VMlu3zpv4jY4D
 RuneheNUE4EVIAK6JZjqdd3a0tjPUowzBLaN+oRIdx9Y3dEdzb/IZWljpZJVExkj9+EK
 Me0fGTlY8gx7V/RpiI+SSlqJfD/0+U9+ZzEiBrqY4zoCJvHNVNB9YPIa+C+AuxPra+CL
 S3WM0/sBgHCtFPCEzbYBcaIHVdcA/pe4nIJV5QZIvLOLyXRwPoBqJODfjiBUAMEolRdi
 JMLY+y+hSLburridYEwvM/Chw6nH+6nXqUcuopBAxCnEHbZarE0za0eLOK58Hle0kQVj
 IT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713285433; x=1713890233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tNkzCRV02na/4jpDqu06Tw7UMHfd7rDdiAUaQoNz8M8=;
 b=WKxcCNludjphwe05FrO4p1vOdFLRUcPerfJKQJmsLzD/OzI/Qhf7XECtetkxS84Z8e
 CkhDt0Q6Uxl+2/UriweIVaXqDfh+CPSPkK3ZdcRb9TyBVEj5jdj++Gi6qzjhDEqkBIh8
 dOX3Xli1vD5OkJZ+5GXo/2xC4Om8nwt6Um1ztvptbPquPYOJcUbhvZo0BzPew4BTLsux
 /SGhdGZKQWI4DflQtMpLE0SlnWOPlwZC5dZz0v5Xg93PlDQg89UUevQQsaRcjdA/hVtA
 /7CreoQ+Nr2/LBo9QhMEwZ/UI6mBCVXrB3UnX/jU/O3TQoH/ieAHpQDupe3C/RVL6KZb
 OHKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWSaUSUWLJyRrt8ZUCKS5S/bMfqEu8eDTS9oqjR5NMY6nYQmY7eh2/1ur9DoxkuPk5CWGvLoOBaWsSMIiyjmB2WXiQCBA=
X-Gm-Message-State: AOJu0YzipwEHauzmGhJxhidHCy6RXoMrQlh7Sp/00v+gmPvtA01jBoix
 YE8iC3zI8OBbRem9/kVqK6yxQmpg/VnavIgXl4PHaEIZy9TD1rba
X-Google-Smtp-Source: AGHT+IE6czJgFucFxlf98LtQLm/wnevBndiZG+W6ku5aN3q6n//IjyvcR38HWN26CadSJffuQxJZPw==
X-Received: by 2002:a17:902:650a:b0:1e4:360:d926 with SMTP id
 b10-20020a170902650a00b001e40360d926mr10848241plk.5.1713285433106; 
 Tue, 16 Apr 2024 09:37:13 -0700 (PDT)
Received: from debian ([2601:641:300:14de:b278:701:b83f:cdc])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170902654700b001e20afa1038sm10207300pln.8.2024.04.16.09.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 09:37:12 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 16 Apr 2024 09:37:09 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, Gregory Price <gregory.price@memverge.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <Zh6pNVIZFMQadmOm@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com> <Zh1lk8FWmf0oI7RM@debian>
 <20240416160056.0000325c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416160056.0000325c@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62c.google.com
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

On Tue, Apr 16, 2024 at 04:00:56PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Apr 2024 10:37:00 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> > > On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:  
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > > 
> > > > All dpa ranges in the DC regions are invalid to access until an extent
> > > > covering the range has been added. Add a bitmap for each region to
> > > > record whether a DC block in the region has been backed by DC extent.
> > > > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > > > extent is added, all the bits of the blocks in the extent will be set,
> > > > which will be cleared when the extent is released.
> > > > 
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > > ---
> > > >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> > > >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> > > >  include/hw/cxl/cxl_device.h |  7 ++++
> > > >  3 files changed, 89 insertions(+)
> > > > 
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index 7094e007b9..a0d2239176 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > > >  
> > > >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > > >          ct3d->dc.total_extent_count += 1;
> > > > +        ct3_set_region_block_backed(ct3d, dpa, len);
> > > >  
> > > >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > > >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);  
> > > 
> > > while looking at the MHD code, we had decided to "reserve" the blocks in
> > > the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> > > prevent a potential double-allocation (basically we need to sanity check
> > > that two hosts aren't reserving the region PRIOR to the host being
> > > notified).
> > > 
> > > I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> > > to prevent pending extents from being double-allocated.  Is this an
> > > explicit choice?
> > > 
> > > I can see, for example, why you may want to allow the following in the
> > > pending list: [Add X, Remove X, Add X].  I just want to know if this is
> > > intentional or not. If not, you may consider adding a pending check
> > > during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> > > 
> > > ~Gregory  
> > 
> > First, for remove request, pending list is not involved. See cxl r3.1,
> > 9.13.3.3. Pending basically means "pending to add". 
> > So for the above example, in the pending list, you can see [Add x, add x] if the
> > event is not processed in time.
> > Second, from the spec, I cannot find any text saying we cannot issue
> > another add extent X if it is still pending.
> 
> I think there is text saying that the capacity is not released for reuse
> by the device until it receives a response from the host.   Whilst
> it's not explicit on offers to the same host, I'm not sure that matters.
> So I don't think it is suppose to queue multiple extents...

Are you suggesting we add a check here to reject the second add when the
first one is still pending?

Currently, we do not allow releasing an extent when it is still pending,
which aligns with the case you mentioned above "not release for reuse", I
think.
Can the second add mean a retry instead of reuse? 

Fan

> 
> 
> > From the kernel side, if the first one is accepted, the second one will
> > get rejected, and there is no issue there.
> > If the first is reject for some reason, the second one can get
> > accepted or rejected and do not need to worry about the first one.
> > 
> > 
> > Fan
> > 
> 

