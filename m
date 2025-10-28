Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4C9CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDn0q-0007Ax-Cd; Tue, 28 Oct 2025 12:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1vDn0M-00077L-P6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:57:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1vDn0I-0007En-RQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:57:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7a26b04bfc8so6896325b3a.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761670614; x=1762275414; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G/brO/u0paEEgtwhQ2JCt2rt+Ab6UtFNYPmhMQx742E=;
 b=QWSMvQguptCsIB8LZ3BtEeI5P/euijlmgV0CZ8z4xAdsk/j0mbW4W4qCGg1aTZE4m1
 1EnRVx7LHEECVjWDT/eIULu7wk3Rl4GwsSsof2uHfGf11H9Ofu6oIrT2JckwLcY8DyvM
 rjSwkBlEmEIlmZyM9u9pBhBXxrFGwPxbtNHAJwh6V8HbfvfV47Ggmf5FRG5chT9MfsCK
 Hfiytvn0aYVJ18iS2Gicju3xNe2PTpFU2tlE4hNeS9ws14YkVKb7dtKHZcqd4myzVDvO
 m+lKEPE3Vxf1H2CV/hjWBwWBB7RnJ5QAd0bZHd0oVmixaoHM3GW1l4ZM6AYey2Uh8QpS
 dLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761670614; x=1762275414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/brO/u0paEEgtwhQ2JCt2rt+Ab6UtFNYPmhMQx742E=;
 b=qCMXut2ME4kQkd7PgzTwNUfh8nLZXCH26kknx+1dMydDT++G+cFyLsYs/8NrwtDJae
 76vfxlWhivBJXc2Cr9YuPztk2BT5wBl3H0omk83wwh7J3CMur8AgVPsTEHqrSsuf9eq4
 ULb8cjSjeTNo6kfh7Mq5Pgf1Y7fH8e6e0Zye4lwLIzZF6xSOgelmfDzETGlwgXlv7DZQ
 Zn+c6vykVU2I4bklcUsOYHkwPU+Y3YmIqmXkvY3s0PCav/NG4E+ozHxUeF2bWjKZydre
 JsrD5uQT/5+3kefN9lyd/EfNE+K3pgC8Y9tDbTNNg8IMEOzrEi4gfOlLEM0rFnGahzzt
 hzBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO+49acSP0WOx1xbUfvjKT3xAVqUoi0/hF8MN9QovjXM6pJNh9V20mW3DOhEUF6zXEwirU/YVBKVph@nongnu.org
X-Gm-Message-State: AOJu0Yy5nSyd14xTQPdMtqIe27C+OFDm48kkcbvoj0bH+1Qxlfc2ZE/g
 g61LalgwtKBq4Q6fz7daaiZ2w7U2N308/YrbaZQgYDAp61kAa1Qgodeu
X-Gm-Gg: ASbGnctFqprq7xLTLu4wdBNxFLg/qlr/R2flOasw4jMkMqCZ3e5zLQffQ59zYKk/izo
 8V09KFHxrWhlmi/Bqw8hXPAsbpzxuUQuV11R6lGZxtodw9sC31K5m+WefDg1NSE5iXDU32Lmz2f
 047MTl1i2KvIswpOgfirhZDWSFZJxuhRn4aLoCh4UQil8pijn3xeIRufXzdFdB/DHySl0eJbh0h
 gvO+BmfIqm3IOOaDLbqYdGqzD5pbvsH004hiMh81aqqiLhCO0cD5WCd5VlFDmMgJgMLpBEh06dF
 teNgmOTiM4v4rP/8UJwg3If1HiyFhez0wloJNbab6MNumxhKeFi+76LLfzIztbqvcV7LK79ygk+
 EF/b1u7iRj7a/nEfwmkZbG/YpK98HW7Uujou7GjxMieSNCfrDBzOz+xVQMI4t47lS6Nh3twozbL
 IQ0b2Wh6Glon2aa/brmdPU5vI9JoE=
X-Google-Smtp-Source: AGHT+IH1316jgmDw/P6TmIjlAoCZxaS24hOy4JenP51pdc4qOgp5Ssym99QR7z2RJBGuEPDuPXxvZg==
X-Received: by 2002:a17:903:38c8:b0:25c:982e:2b1d with SMTP id
 d9443c01a7336-294cb54018emr68148255ad.59.1761670613785; 
 Tue, 28 Oct 2025 09:56:53 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d27541sm121925925ad.61.2025.10.28.09.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:56:53 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 28 Oct 2025 16:56:51 +0000
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, dave@stgolabs.net,
 linux-cxl@vger.kernel.org
Subject: Re: [QEMU PATCH 1/1] hw/cxl/cxl-mailbox-utils: Enable FMAPI Initiate
 Add for MHSLD
Message-ID: <aQD10zBfV2RUXD4n@deb-101020-bm01.eng.stellus.in>
References: <20250927002125.860668-1-anisa.su887@gmail.com>
 <20250927002125.860668-2-anisa.su887@gmail.com>
 <20251028162100.00006fa8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028162100.00006fa8@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42c.google.com
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

> Tue, Oct 28, 2025 at 04:21:00PM +0000, Jonathan Cameron wrote:
> On Sat, 27 Sep 2025 00:18:07 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Call mhd_reserve_extents in FMAPI Init Add (5604h)to enable sending
> > FMAPI Add command to MHSLD.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Hi Anisa,
> 
> I've not been quick on this one partly because it sits on top of the MHSLD
> work that I think needs a proper revisit to establish what is an up streamable
> path, but I haven't had time to do that :(
> 
> Anyhow in meantime I'll take a look.  I suppose nothing stops me carrying
> this on top.
> 
> Just one minor comment inline.
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c5177dfd92..9ac60db4e1 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -24,6 +24,7 @@
> >  #include "system/hostmem.h"
> >  #include "qemu/range.h"
> >  #include "qapi/qapi-types-cxl.h"
> > +#include "hw/cxl/mhsld/mhsld.h"
> >  
> >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  #define CXL_DC_EVENT_LOG_SIZE 8
> > @@ -4163,6 +4164,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >          CXLDCExtentRaw extents[];
> >      } QEMU_PACKED *in = (void *)payload_in;
> >      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> > +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_num];
> >      int i, rc;
> >  
> >      switch (in->selection_policy) {
> > @@ -4201,6 +4204,28 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
> >                  return rc;
> >              }
> >  
> > +            /* If this is an MHD, attempt to reserve the extents */
> > +            if (cvc->mhd_reserve_extents) {
> > +                g_autofree CxlDynamicCapacityExtentList *records =
> > +                    g_malloc0(in->ext_count * sizeof(*records));
> 
> I think it makes sense to use g_malloc0_n for these
> 
> I changed this whilst applying it locally so it'll be there next time
> I push out a tree.
> 
> Thanks,
> 
> Jonathan
> 
Gotcha, thanks Jonathan :D

- Anisa
> 
> > +                g_autofree CxlDynamicCapacityExtent *dc_exts =
> > +                    g_malloc0(in->ext_count * sizeof(*dc_exts));
> > +
> > +                for (i = 0; i < in->ext_count; i++) {
> > +                    CxlDynamicCapacityExtent *value = &dc_exts[i];
> > +                    value->offset =
> > +                        in->extents[i].start_dpa - region->base;
> > +                    value->len = in->extents[i].len;
> > +
> > +                    records[i].value = value;
> > +                    records[i].next = &records[i + 1];
> > +                }
> > +                records[in->ext_count - 1].next = NULL;
> > +                if (!cvc->mhd_reserve_extents(&ct3d->parent_obj, records, in->reg_num)) {
> > +                    return CXL_MBOX_INVALID_INPUT;
> > +                }
> > +            }
> > +
> >              CXLDCExtentGroup *group = NULL;
> >              for (i = 0; i < in->ext_count; i++) {
> >                  CXLDCExtentRaw *ext = &in->extents[i];
> 

