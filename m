Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1A0C54E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 23:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riNG2-0000s9-KU; Thu, 07 Mar 2024 18:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1riNG1-0000s1-Dl
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 18:34:37 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1riNFz-0004kI-UG
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 18:34:37 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6e4e9cdb604so685904a34.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 15:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709854474; x=1710459274; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TvtzYXlBxDIQHvkk7OR+1bPqq72EzlsJeV1HC/bhQGk=;
 b=g769FRuibgPng2yU8BXliGLov5qgtZdcpD2polXs/vN1zKbkuxR7AyB6PFoOGn9A4b
 L+QD+dXpPY3l5iqOa+7YJ422+KGUovOSigNIPE3OoavyIdgS6CsfUcHSRu7QvSZHJwRc
 Jcht6YnvjCmGUMr7n+RjqlcJ7AIFvr6zoM+BzZZpMe2un95d69qWeoRgfoRElgKNp4rA
 C1OhW+gRIOWxbSXGWqe10VzAt6FLl8wr7ZmTKWhZ75ARKml1p2bWYbgHeecGk6rQHRqy
 neavoX4QahKm6Q7qYY5Aw4q4rJE9FAtzHwv5cT0a4nvkhHs4PZGQMkjywx/3Jkv2xcyE
 od0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709854474; x=1710459274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvtzYXlBxDIQHvkk7OR+1bPqq72EzlsJeV1HC/bhQGk=;
 b=BwY8VmVl/yWLy9JFaenR73Frf00R+me0nfvSegby95OKxWJDrEmp888J7p2YpWbxWK
 oK2KQFhmRrSkIPNXUgQ94Qfa7ZOzJOSka3+BC/IssyrZOKXjI7SwOeW9JYWO7YJqizzL
 nDWSLzvgLRr+3o44YCgZRb4eRde005NwAzq3lmouWjYy3PqOXlQRSaG4x3ST5vU24+7m
 yU8JUPItSlZMO2F/prxqK3l8reTd9CgzBoa0zBJg0aXWkUg0esgv4alt/YHvX5Afi23Z
 Fj/PwT03k81RE7WRF9FsOS2b2sATyuFGM5gyoH6VxHp9sJnEcvkC/P9ulzhsjWl1iM/Q
 liLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkAGjRbviqs4etMtCIDq7Fc1eKkN0YYU4YojEHs+WZ6WrSNgqHSjLDgwwNKGcb+g4V0X95piR2zQlBAKp+/lgyXY6iceQ=
X-Gm-Message-State: AOJu0Yy4NELWIshv1+lFhRYWxaYuUSK5oWFY7Ui1cisjQ67wJeao478B
 IES/o5qrnF8pfksa2qQpJv3K/0tZUEvqGfv71fFfTFOKZngI6lIa
X-Google-Smtp-Source: AGHT+IH3n+2HDtXDeYfwWqHEIFObS9DfRE9bAsUrfAaSVz9lXI49vjH9TOCljpp7WUM5ovliUJEAHg==
X-Received: by 2002:a05:6830:1db5:b0:6e4:74e9:ece1 with SMTP id
 z21-20020a0568301db500b006e474e9ece1mr10323287oti.23.1709854474261; 
 Thu, 07 Mar 2024 15:34:34 -0800 (PST)
Received: from debian ([2601:641:300:14de:a807:195f:7661:96fe])
 by smtp.gmail.com with ESMTPSA id
 p28-20020a631e5c000000b005d6a0b2efb3sm13021593pgm.21.2024.03.07.15.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 15:34:33 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 7 Mar 2024 15:34:18 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Jorgen.Hansen@wdc.com, wj28.lee@gmail.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZepO-qfbXX7yOeIK@debian>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-7-nifan.cxl@gmail.com>
 <20240306162816.00002e0e@Huawei.com> <ZejAh2O7fDBCcG-N@debian>
 <20240307121605.00002d7f@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307121605.00002d7f@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-ot1-x32f.google.com
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

On Thu, Mar 07, 2024 at 12:16:05PM +0000, Jonathan Cameron wrote:
> > > > @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> > > >                                         AddressSpace **as,
> > > >                                         uint64_t *dpa_offset)
> > > >  {
> > > > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > > > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > > > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> > > >  
> > > >      if (ct3d->hostvmem) {
> > > >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > > > +        vmr_size = memory_region_size(vmr);
> > > >      }
> > > >      if (ct3d->hostpmem) {
> > > >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > > > +        pmr_size = memory_region_size(pmr);
> > > > +    }
> > > > +    if (ct3d->dc.host_dc) {
> > > > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > > > +        /* Do we want dc_size to be dc_mr->size or not?? */  
> > > 
> > > Maybe - definitely don't want to leave this comment here
> > > unanswered and I think you enforce it above anyway.
> > > 
> > > So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
> > > As such we could just not stash total_capacity at all?  
> > 
> > I cannot identify a case where these two will be different. But
> > total_capacity is referenced at quite some places, it may be nice to have
> > it so we do not need to call the function to get the value every time?
> 
> I kind of like having it via one path so that there is no confusion
> for the reader, but up to you on this one.  The function called is trivial
> (other than some magic to handle very large memory regions) so
> this is just a readability question, not a perf one.
> 
> Whatever, don't leave the question behind.  Find to have something
> that says they are always the same size if you don't get rid
> of the total_capacity representation.
> 
I will fix it.

For static capability, we have a variable static_mem_size, although we
can calculate it from volatile and non-volatile memory region size.
There are quite some places need to get the dynamic capacity, it is much
more convenient to have a variable ready to use, I will keep it for
now.

Fan
> 
> Jonathan

