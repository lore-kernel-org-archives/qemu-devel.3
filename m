Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADD4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 17:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwQGa-0003zi-4W; Mon, 15 Apr 2024 13:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rwQGW-0003zU-IU
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:37:12 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rwQGT-0004bD-Tu
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 13:37:11 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dd14d8e7026so3268646276.2
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713202628; x=1713807428; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W50oYQbiNq8ZCtSTF/Gma3PcpD6n9++jBPNY2gg7KvU=;
 b=fkKZVoeR2S41ERLDRI1iI/5rS4M58cUTZDTGD8I4z5YywyLOjC3XvivOSbBMDk7DtP
 76nIep9G0zM8Mb4TO+OkO49eztUnWRSktDPug99km7VqUVnA+DQNSsPvRcQkfk1PN9qK
 8wQE2qhkBQ2WaWYEfGte3Lxixoj4l6qKfC5fOb0HaGpy7fRVur3mtut6VLwlYM79He8T
 kPI69pKzf/deaR2vboGGPeUmdojoT8aa1pzjWHAWb7uUQFj+gtE5r7MA9awSEpOSc2Lv
 6Lo+Q3TRGrOAm4Ytd8kowiDab7Zj0LN2DqnTaDlybPh4x6WVpVCGRq0HZirKa/FMH8B5
 HLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713202628; x=1713807428;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W50oYQbiNq8ZCtSTF/Gma3PcpD6n9++jBPNY2gg7KvU=;
 b=BRE8gcxsUCopOBkesvStSr7sedWjV9wmRQxeq78KDFo3i9DresovLnBY3pQ0KmrNQ1
 k95Omx8bsWlFBJbgfc58Vq6U9v1rbOBt8AvnVoqW4eRBobqTqScH1lp1FnQyGreVZat/
 dRz5dvTQnYivdVDuPRL1LUpJL0GG5p1xqQN2QJfiPlD/ccnSgVSTVlUAV2XGRE8ZKoqL
 l2JYzCnw51KE62QrUV2sTc9dFc9KMabPefxFxZWkhEL8L7jMvx6HfdDR+TvV2Tesgi2w
 h2nAZ6M1y5vxDu+VAKkIdVTKvcrcj5FfU39br187loVfAxJiR7f4WiDUQACeGhONnuuY
 IaWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCWirgV0WgzqGbMvnI61RSwxdBZzyUqcXRuNkZ3y1ZZmMRxHmUFlnLQYCcsQd/byqJDmwCkD9oHi2Cvq68BiLtUNmRWXI=
X-Gm-Message-State: AOJu0YwIXaP+5lhC97Ta9fWHot9s27kbhMkLnjLHBm17VhJIRMnRrCnZ
 GcMClIAJnBAZFO74OwkuStGG1WVZ1mst4KMAuNwQT58vVPeWJIv3
X-Google-Smtp-Source: AGHT+IHfOxIGU2OZGmtfCwLzNI4tVwvrHx+GkMPYInQfI0DJDIof/Knu9yFKEXhH2fTMMRoc3RK2xA==
X-Received: by 2002:a25:c142:0:b0:d80:68d1:b826 with SMTP id
 r63-20020a25c142000000b00d8068d1b826mr9871785ybf.6.1713202627699; 
 Mon, 15 Apr 2024 10:37:07 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 k12-20020a5b0a0c000000b00dcdba3056e9sm2039499ybq.25.2024.04.15.10.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 10:37:07 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 15 Apr 2024 10:37:00 -0700
To: Gregory Price <gregory.price@memverge.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <Zh1lk8FWmf0oI7RM@debian>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhm7ssKVGdGlR9Iq@memverge.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb34.google.com
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

On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > All dpa ranges in the DC regions are invalid to access until an extent
> > covering the range has been added. Add a bitmap for each region to
> > record whether a DC block in the region has been backed by DC extent.
> > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > extent is added, all the bits of the blocks in the extent will be set,
> > which will be cleared when the extent is released.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h |  7 ++++
> >  3 files changed, 89 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 7094e007b9..a0d2239176 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> >  
> >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> >          ct3d->dc.total_extent_count += 1;
> > +        ct3_set_region_block_backed(ct3d, dpa, len);
> >  
> >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);
> 
> while looking at the MHD code, we had decided to "reserve" the blocks in
> the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> prevent a potential double-allocation (basically we need to sanity check
> that two hosts aren't reserving the region PRIOR to the host being
> notified).
> 
> I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> to prevent pending extents from being double-allocated.  Is this an
> explicit choice?
> 
> I can see, for example, why you may want to allow the following in the
> pending list: [Add X, Remove X, Add X].  I just want to know if this is
> intentional or not. If not, you may consider adding a pending check
> during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> 
> ~Gregory

First, for remove request, pending list is not involved. See cxl r3.1,
9.13.3.3. Pending basically means "pending to add". 
So for the above example, in the pending list, you can see [Add x, add x] if the
event is not processed in time.
Second, from the spec, I cannot find any text saying we cannot issue
another add extent X if it is still pending.
From the kernel side, if the first one is accepted, the second one will
get rejected, and there is no issue there.
If the first is reject for some reason, the second one can get
accepted or rejected and do not need to worry about the first one.


Fan


