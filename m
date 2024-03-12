Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01CFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9Np-000569-BZ; Tue, 12 Mar 2024 17:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk9Ni-00052R-2F
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rk9Ng-0006UR-Ij
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710277791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2JEL4H2I6w37P8B7PvFNG7lD6vOqc/rB5dLoccRMM3U=;
 b=DSeQSNcWnm4F4zBnrF07RWeZBK/4WHX2zbZH29lxfWpqshEmWMC72RZEX8ax/pCko+V4jM
 Bs54MK7Mu846V3bJKEbkAuthq0rGbiL2glMWN/J3D9rBZnhmRGp+vax/z3cgtqg2TJi/n4
 as0KbqfPL9gb/S/rgfIuNzOZ9at+qNc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-rhwf4q64NL-1C6HdRi6dYQ-1; Tue, 12 Mar 2024 17:09:49 -0400
X-MC-Unique: rhwf4q64NL-1C6HdRi6dYQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-78836fdb440so20402985a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710277789; x=1710882589;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2JEL4H2I6w37P8B7PvFNG7lD6vOqc/rB5dLoccRMM3U=;
 b=APTmqejdD/z8bNHaAXQWkqDP5Hf5IGAkR/zeIU+vsR89Gg6iiREQaIu1pqF7f4wGK5
 Kwv4IIjxbNYV3llKmJ7My/A93b/4aG4Xsc1ge4GJDwfSaScUOTuQQU2yf2zyDw2FETNT
 ykmsz36wd8rOtDZyuNPYGCvBasMVoy05I4XbICk2uNEX8J8YhOIhStWbmArYY3zLrVaP
 f2g1ZrFWYBGESy7+zltnXymx/kCSDwDYlzp0w1ftaK89y3ZpOi2jiFP5fE+QXWm1/D2Z
 nJGXrI4Oh3tD41AIZx321iURkzhnQzY2FxjS7VUmaSbqT2JMkrnAe/htHuLy13rLT6NA
 e0vA==
X-Gm-Message-State: AOJu0YzKFA54QWCWpHQhvlUDa9fKRuWlwMEJoh0nf2/j5N5kj7CVkSBj
 FkgAuJZKo/M92P5X0fRMHMqIoHE1gAEeRnqWG/UcSE8H/IsDZ/5XmHskQsn6LUWDVZ04Rr3ZAkL
 or+1XneH8FsedPDAoKBh22JyB0N592Hv1v2aanIXj8z0Y95y7sSIX
X-Received: by 2002:a05:620a:172b:b0:788:763f:75d7 with SMTP id
 az43-20020a05620a172b00b00788763f75d7mr5021825qkb.4.1710277789442; 
 Tue, 12 Mar 2024 14:09:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEsZ/8dpP8U3iK+cxr9n30gXvBUciPkwqMRjZmlf4kY8DCFpDfBx6iD041nP/7N+vX97Kd0w==
X-Received: by 2002:a05:620a:172b:b0:788:763f:75d7 with SMTP id
 az43-20020a05620a172b00b00788763f75d7mr5021810qkb.4.1710277789087; 
 Tue, 12 Mar 2024 14:09:49 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j2-20020a05620a000200b0078874069a89sm1732344qki.9.2024.03.12.14.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 14:09:48 -0700 (PDT)
Date: Tue, 12 Mar 2024 17:09:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH-for-9.0 v2 0/3] system/physmem: Fix migration dirty
 bitmap coherency with TCG memory access
Message-ID: <ZfDEmtLqviO1vMZk@x1n>
References: <20240312201458.79532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240312201458.79532-1-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 09:14:55PM +0100, Philippe Mathieu-Daudé wrote:
> Respin of Nicholas patch, without introducing
> tcg_cpu_physical_memory_dirty_bits_cleared(),
> and split in more digestible parts.
> 
> Nicholas Piggin (2):
>   physmem: Factor cpu_physical_memory_dirty_bits_cleared() out
>   physmem: Fix migration dirty bitmap coherency with TCG memory access
> 
> Philippe Mathieu-Daudé (1):
>   physmem: Expose tlb_reset_dirty_range_all()
> 
>  include/exec/exec-all.h |  1 +
>  include/exec/ram_addr.h | 12 ++++++++++++
>  system/physmem.c        | 10 ++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)

Yes agree a better split than the single patch.  Tentatively queued while
waiting for any comments.

-- 
Peter Xu


