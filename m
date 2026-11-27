Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19341606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FRXdjq6z;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Ij7nMogj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwGS-0006Hk-IS; Fri, 27 Nov 2026 08:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWwGI-0006FB-4m
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:45:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWwGF-0003vC-Ac
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795787108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GAS/GcAbOo4YNthvBet/JufLuKlNF/Pkk/CUec2b66E=;
 b=FRXdjq6z3naHKM8+H5aBDbZ/IPS1eSiXjJcBp/ER70f87j+cO6INqb2orkYaH0ztkKE/Um
 JXO+QqvzLmT2kIhhTflFL/VkuRatsYNR0Aj89hZsvUptn/YBlrfVThl2DU2bRTOkI+US9N
 5mNClUnMZFq6LCon5VuVsDfQH7Ktr5M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-bcZj9OGhMLCTQxYWr-VtBA-1; Fri, 27 Nov 2026 13:45:06 +0000
X-MC-Unique: bcZj9OGhMLCTQxYWr-VtBA-1
X-Mimecast-MFC-AGG-ID: bcZj9OGhMLCTQxYWr-VtBA_1795787106
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9211f05706bso86056376d6.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 05:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795787106; x=1796391906; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GAS/GcAbOo4YNthvBet/JufLuKlNF/Pkk/CUec2b66E=;
 b=Ij7nMogj5tNov9lJKGzQ/aUwPIu65QcxoR80lE3YwvqBIymWiS888zi2/vZ6yn2Yec
 gmKVRBg8eic3EvvA8oYHU4RF+U0uXS93s69U5HTmmsAfTpAuXOgOFvlIRSe8z4+otck0
 gcJcCMpS6TJU04XPC9AayOS5ah0yHPtm/h2Oge+6znLv/jezBskSOKAxH6Fb6mesTT9k
 tO/WAdGFiTk3q6ddrnaODquG1RAO6ytvINY5MHKpSoQlGiDoAzqGBfpqV+O/XkmG+pUk
 2z/zLGSGXU7zfPyV+8o0UoDPQS8ceJOqdtemd8c5Y5gURu7tytY5ZdzshQ/Ja0CY/xBq
 NB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795787106; x=1796391906;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GAS/GcAbOo4YNthvBet/JufLuKlNF/Pkk/CUec2b66E=;
 b=U3N8LKg0Qm6wDWH5FnmoSrQAJkjR0HMftVooqU6zjhSvFG9so9mL6rMHkkaTGFdPba
 Panb6cCK3HHjlFdHC8MdyKi/FKmuY5/8oqx9cbShgkmgfVxjIfBJNoUI9iq0E8YRGL0b
 GoVH02ccIcK3Yebrw9lddeJbu7a7dRV3ciYWwnOi0rT3dIw4Cj+cwqgpECHBQNI+XjTe
 S4FZcgZw17tpbb0iBzDyr++s8myPPZZJfDKSOMWoumrq6p6+em2DiQ5+lydLH/3JGLhQ
 Zduol3QQS2+RQHXdrEbsZp9LWpp510UmK7d5ES9uE/XNznvsRG8pwtiPQ3GIzqP5WTTX
 zYtw==
X-Gm-Message-State: APuU4Z+Uh0nikdATIkM+4lioCUBO0lwwO1cWqvWPnS8kbW111nPB/yz4
 CqLX1O3eNlNZEMeyhE1CX+Y9wqMHYd+i8gXKXXcPw9qI326hGh/gr0TgrO2g4aaROaEGSTPMt+G
 63JpfKuo3AtRKyJ+ws8bVluwArewq/sxQ6vKm749YAbbQZ1KAi2sjD3oy
X-Gm-Gg: AZFdTZeq0bApS/8AxL09V7YZ8qpaACZCD7kHfi0g6G5tZTdB6LgBYXY/m01OD9C6CtN
 4M/6eCKHqhgNylWV0zwFKZ+X7E2WzHGu6gHVeWm2PR7oE26h0R60f+gp9RotoyNopyaiGt45o++
 Onv5qHfBqsVN6KfP9s4qwE19leZzpyBhjfbTyWtYlDOFhdBN/Xc+iB+qv+/xGQl5cYf2MY8MfMC
 apCxZntB9z2hTgigbwsMyVUa3Aa5/hVxe675u3YEjP07SEWubJdhyGdfQeJzVkO+y1Se23HgTG5
 RrcNjVscbA2XXGVyvb4P2pgwcCe6aNIFdgRljOJp01G9w2Ckb496CHdz+b7TsrucEqLMBuReW4R
 Ux3/UdI3sxTEq4A9dvjrmFuhgRcCsofA4/hB3uDtLK1Uh
X-Received: by 2002:a05:620a:6487:b0:949:3066:5563 with SMTP id
 af79cd13be357-949bac7846dmr3861513885a.74.1795787106216; 
 Fri, 27 Nov 2026 05:45:06 -0800 (PST)
X-Received: by 2002:a05:620a:6487:b0:949:3066:5563 with SMTP id
 af79cd13be357-949bac7846dmr3861505385a.74.1795787105639; 
 Fri, 27 Nov 2026 05:45:05 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb0315f4sm1810732785a.3.2026.11.27.05.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:45:05 -0800 (PST)
Date: Fri, 27 Nov 2026 08:45:04 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] migration-test: Support running a real kernel
Message-ID: <awmJYLLhnMxlWhQP@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261126214704.3108327-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261126214704.3108327-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 06:46:59PM -0300, Fabiano Rosas wrote:
> There's a class of migration performance bugs that are very specific
> to the internals of QEMU and most likely require work on our side, but
> are currently invisible to our testing because migration-test runs a
> simple guest workload (not even that, really). The more important ones
> are BQL contention issues that result in vcpu starvation.
> 
> My plan is to incrementally add some pieces to migration-test to
> reduce that testing gap.
> 
> The first piece is adding support for running a kernel + initrd inside
> the guest which gives us an easy way to start exercising migration of
> a more loaded guest that can already cause VM exits.
> 
> This series adds support for -kernel and -initrd arguments to
> migration-test and runs the same set of tests we currently have, but
> with the kernel instead of the custom loop. By default it uses the
> initrd from tests/migration-stress/ which runs a read-write loop over
> all memory and has customizable vcpu and memory size.

The whole thing sounds useful, I'll read into details after I flush more of
the older patches.. which will take some time (it also depends on if next
week I got some more urgent task "injected"..).

One high level question: this will grow qtest closer to what the functional
test is doing.  Have you thought of the relationship between the two, after
we move qtest more over there?  I assumed not, based on what you mentioned
in the rest part of cover letter that you planned to have it only for dev
debug purpose.  But still, we'll start to ask the question to ourselves at
some point, IIUC.  So I ask first. :)

-- 
Peter Xu


