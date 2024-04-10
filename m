Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DA5CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 18:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rud82-0005DA-6G; Wed, 10 Apr 2024 14:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rud81-0005D2-71
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:57:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rud7z-0005Nn-AV
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 14:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712775418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exl5ipGlLlrZYQCIi5yXFy4XxLFK1yrCYzRNbyHOKmM=;
 b=Qg9jMk1KQnGC2vlKTtwa5bpm92CFRF24nqAhlQoK+BpFUi4US1RiXf2y+fSaIbkpFG/Oi+
 UTSw5RaDINdY/DkPaIXK+xgEM1XBgaWg/dmpWLM+kyvM1P6aX1gF+/gUlEw7WiCiCqgkbm
 Lb9dgvkxg1GGn8PZesMR4nJMz976DNQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-om-wwhSeORuTpOPQHV0eYQ-1; Wed, 10 Apr 2024 14:56:56 -0400
X-MC-Unique: om-wwhSeORuTpOPQHV0eYQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-611018baafaso21325577b3.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 11:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712775416; x=1713380216;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exl5ipGlLlrZYQCIi5yXFy4XxLFK1yrCYzRNbyHOKmM=;
 b=ll6dezkMsC4lqgBLxYfViSRaJR7lcVWpJMmebVsABnTIQ+IUPy3w4PZ5s172t3LpQj
 cqpVnIB+ogHM7EuLaUEODtgsBcR9I6efX3TPiJlAXwM58w16efmIJ1CVKC3K11kN9v+H
 uOU1+HqZZ5tWb+B5WDhUqdCY7jMCj+rKunj3c3YImKhduNgE4Vt7tJET0pNjLocynLZ6
 GIjL2Q5F4dZ3HXqtckFmwZDnpwRyQdzRo8GJOdEEC8CdYtNKZvxxVyPLnRn87wN1lqGt
 9ljF+cmeV4sBXwz5+tzPmhavILcUh2Eq8AP963901cILvtRmAUiS6YE/PZ8c3E0HQsWU
 +DaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8k4j7nIRYIWhxIgIhLiBprugzAmp1QMNFvuPDqhcnf5VYrkd3I3mEqcM0tr21IVhBQLCG/x6/pnjkFIM+WuOiYiXribI=
X-Gm-Message-State: AOJu0YyrttWMG2vVSDaA/PQPCg0MZDQXVxYcrnvss7XbO8jF7YquFGjY
 Ueo10Ub7xC1dgs8yjm5bwAhjlBvd3BBs7ydy8pPvdPQqjVKwfv008JbTvAMJ9eKRMh/OrSieJLp
 J86kpTHEyIC6x3zvLVZmBNnvkEW4nWSxvGWTXb47ckELM5v3pLqLZ
X-Received: by 2002:a25:ea4c:0:b0:dcd:1cd7:f6aa with SMTP id
 o12-20020a25ea4c000000b00dcd1cd7f6aamr2901300ybe.2.1712775415948; 
 Wed, 10 Apr 2024 11:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxh2N/y5AztnaPzBRNWgOvjbQZkHZeNjP1opModc0ZFMkMpPHtne5lC8XV9ik78lGzVthIsg==
X-Received: by 2002:a25:ea4c:0:b0:dcd:1cd7:f6aa with SMTP id
 o12-20020a25ea4c000000b00dcd1cd7f6aamr2901270ybe.2.1712775415137; 
 Wed, 10 Apr 2024 11:56:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 f28-20020ad4559c000000b006993ddfcfc0sm5404501qvx.38.2024.04.10.11.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 11:56:54 -0700 (PDT)
Date: Wed, 10 Apr 2024 14:56:53 -0400
From: Peter Xu <peterx@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, sstabellini@kernel.org,
 vikram.garhwal@amd.com, jgross@suse.com
Subject: Re: [QEMU][PATCH v3 5/7] memory: add MemoryRegion map and unmap
 callbacks
Message-ID: <Zhbg9alYH1-J9poU@x1n>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-6-vikram.garhwal@amd.com>
 <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJy5ezpCWkOqthGR1c5Nsfyi_W_yGL_d17Jcp0VckaCEwx9z3Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 10, 2024 at 06:44:38PM +0200, Edgar E. Iglesias wrote:
> On Tue, Feb 27, 2024 at 11:37 PM Vikram Garhwal <vikram.garhwal@amd.com>
> wrote:
> 
> > From: Juergen Gross <jgross@suse.com>
> >
> > In order to support mapping and unmapping guest memory dynamically to
> > and from qemu during address_space_[un]map() operations add the map()
> > and unmap() callbacks to MemoryRegionOps.
> >
> > Those will be used e.g. for Xen grant mappings when performing guest
> > I/Os.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> >
> 
> 
> Paolo, Peter, David, Phiippe, do you guys have any concerns with this patch?

This introduces a 3rd memory type afaict, neither direct nor !direct.

What happens if someone does address_space_write() to it?  I didn't see it
covered here..

OTOH, the cover letter didn't mention too much either on the big picture:

https://lore.kernel.org/all/20240227223501.28475-1-vikram.garhwal@amd.com/

I want to have a quick grasp on whether it's justified worthwhile we should
introduce this complexity to qemu memory core.

Could I request a better cover letter when repost?  It'll be great to
mention things like:

  - what is grant mapping, why it needs to be used, when it can be used (is
    it only relevant to vIOMMU=on)?  Some more information on the high
    level design using this type or MR would be great.

  - why a 3rd memory type is required?  Do we have other alternatives?

    So it's all based on my very limited understanding of reading this:
    https://xenbits.xenproject.org/docs/4.3-testing/misc/grant-tables.txt

    If it's about cross-vm sharing memory, does it mean that in reality
    there are RAMs allocated, but it's only about permission management?
    In that case, is there any option we implement it with direct access
    mode (however with some extra dynamic permissions applied on top using
    some mechanism)?

  - perhaps sold old links would be great too so people can read about the
    context when it's not obvious, without a need to copy-paste.

Thanks,

-- 
Peter Xu


