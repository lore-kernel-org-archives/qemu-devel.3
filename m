Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D1EC88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x66Hy-0003TW-Lt; Mon, 14 Sep 2026 09:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x66Hw-0003SD-44
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 09:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x66Ht-0002i4-TK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 08:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789390795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPpkNsvDWUIB7LanuQdjox+gYvQlSV/JIDKiDtSsXHQ=;
 b=P2o1nxIoAQhQaxiYJzBngPXXYxhbWmE1qjDYkD3As64lWfeXYOhYM2wrGEjaUcv+IVqG2q
 0lwWUzklkyrOTdQMIYJarI+KdF1CsL80fZy6z/uspMxnEzfSWtg4OA75DntHukhb6NGa1a
 rKb0WyTg0ROMEWCkyboz3iNZpW4ptU4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-V014ZGxSNouMyXobTkaogw-1; Mon, 14 Sep 2026 08:59:54 -0400
X-MC-Unique: V014ZGxSNouMyXobTkaogw-1
X-Mimecast-MFC-AGG-ID: V014ZGxSNouMyXobTkaogw_1789390794
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93918756165so603905885a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789390794; x=1789995594; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cPpkNsvDWUIB7LanuQdjox+gYvQlSV/JIDKiDtSsXHQ=;
 b=t19ZNoZCZp6ld8k8FuhQQFCfc1x3J2RCKBaV0RYZHOJcXpQtoZqs72Nobmd/O9dDWZ
 Wgkw23+GR27C4/ww3Rb0vbKGvi3b2i2JeL0k5E567GgCSMY7XRh2ZUsLyvPRGruxyvvK
 70a8re7UwXbQPV3B9NmkBWQWCbDl/tOBJYpQxoVkMpNiU68L6FscXpWHKBXfAWIHtGyJ
 tnSNyUz2ETvU3jAD7vgEpbB4AucjCCYvKT5PTbtc0v1l7ou+GUZSk5bLDbuwpYI1QZ7X
 ql8QF6KbNxIpusyap0gcQjnynDLLOjeY9MyMywvP01TZAiejfIgOaDN6rl3SHgFBRAwj
 W+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789390794; x=1789995594;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cPpkNsvDWUIB7LanuQdjox+gYvQlSV/JIDKiDtSsXHQ=;
 b=r9sxYvSGLhJXtNXjm8ehPsNic7gM57qfXlKbwRNAfID26DPC7h49S98xKEhv4pDsCp
 MRVI0L0K5UQmIYcvJN5v/fqCirhmXQLxXVTlwE6RTv0wrK/ugEr34FbJiSbkLilxFwO1
 X74TpCLzuyvi8zIlKHm4YTweGUmEhiAVPgwOXGnuL1b/jr17vyFOnzJFoNajmC6H4f4l
 A14iS0R8Vit0fXgoFh54gWTXspd8ar0QFLACm/GkzAYO/RSAokxvuRwPDTbDoyeZvoiK
 QNEeaBz75hGHCY/ln7N3crL3Vk0jFFsEPrH+Kv95rbNdQ5eH5tb3JWjXWI4ybHAeYgJf
 wvrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6Hyo5UYQVZtoFcRchgXQlPqNbDpUm44JkJ4HW9lIEbTD1aItx6eWBuGoLzGwEwNJUE7pnk3whqmhR@nongnu.org
X-Gm-Message-State: AFuF++mt8HRiJf0V5eh2OzuiRd7KLJ3nY89m/CryIf/Fhhsv/jt+6WpM
 7X90HwmCYB4ecDZMHIf71Bg+7iouVeZkvg4BfpRJ1/97gXWmOdbixtf0gU01/KJq+/dxjnh4qUj
 q7bAGeHZPCSlnDp/vaHSLrk0bmwHnpwYRMY+7zZD0GVBMMcY22OTxYLOP
X-Gm-Gg: AYBFou2mSM3B8w8oFYQirVSzAd7XfBVHyXjCvBl7xkLpscIuICPoaYejFziQP6f2Ygk
 MhD1IcBv2C2XamIwBplCu31DX/NO2BmGhOtp+PD7X1Sj65drscgcU8rTQ8A/294md/vlc7b+wOt
 T5q1sfpr1mPGDZB543H4YiMRctf5ZkYqRQuJeeZ/CL6WlmGn/7kIC+F+JUArOs57nfcmVpAp/QN
 d60ToFxgIDtx4zQfS1ZPtPR/U9cG22dT+rXnRUoCOcPpuzg/YHSAmVv3YmW5uluQFXmj0J+AtSi
 Jb55ehtM6KXnDHCjO9a+U4rKfhBWZlqk3c5fbAW4hKBDQ4RRYRrTV2m8kitAupqC37zs1VvVrL4
 E6P8jc0vWwvvP99qk5+cM/SHz4dx8oZHsO2gfYXfFROUAx39lzsvvrQ1oJas=
X-Received: by 2002:a05:620a:269d:b0:939:57ca:7e07 with SMTP id
 af79cd13be357-93a297595aamr360276785a.10.1789390793489; 
 Mon, 14 Sep 2026 05:59:53 -0700 (PDT)
X-Received: by 2002:a05:620a:269d:b0:939:57ca:7e07 with SMTP id
 af79cd13be357-93a297595aamr360271485a.10.1789390792990; 
 Mon, 14 Sep 2026 05:59:52 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939e80471a3sm984923285a.22.2026.09.14.05.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 05:59:52 -0700 (PDT)
Date: Mon, 14 Sep 2026 08:59:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 pankaj.gupta@amd.com, isaku.yamahata@intel.com,
 xiaoyao.li@intel.com, chao.p.peng@linux.intel.com,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <aqfvxkWP_pZUy03K@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
 <eee90083-3962-4bf4-a7be-2e06e02e4e94@kernel.org>
 <g3iq3ku62byofbc4c7m5tzmpcpqrlb4ark7pwvg3fm2jvcbvhg@qi5nnpnulsuk>
 <aqPusIvLVQv9gmPP@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <26dd141c-fed3-4f7e-81db-315e975cdcd7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26dd141c-fed3-4f7e-81db-315e975cdcd7@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 11, 2026 at 06:00:56PM +0200, David Hildenbrand (Arm) wrote:
> On 9/11/26 14:06, Peter Xu wrote:
> > On Thu, Sep 10, 2026 at 06:00:11PM -0500, Michael Roth wrote:
> >> On Thu, Sep 10, 2026 at 10:54:09AM +0200, David Hildenbrand wrote:
> >>>
> >>> [...]
> >>>
> >>>
> >>> There is a lot of uncertainty how guest_memfd would consume huge pages. So best
> >>> to drop the "yet" that implies how it would be consumed (and that it would be
> >>> called "hugetlb").
> >>
> >> Makes sense, will change this as suggested for v6
> > 
> > I'm just curious, any more info on this part?  Any link to existing work
> > would help.
> 
> Ackerley has been mostly busy doing the in-place conversion, the hugetlb-related
> patches he sent are a bit dated.
> 
> He's been recently looking into how to abstract memory providers for
> guest_memfd, I think there were some upstream discussions related to that in
> related context:
> 
> https://lore.kernel.org/r/CAEvNRgHbfx470HUBJhEUVKPKqsV0LnhX+wkD1TE-61fZy3jjUw@mail.gmail.com
> 
> 
> > 
> > At least from our side, we look for hugetlb-alike support on gmem.  I want
> > to make sure what I understand still is valid, and it is still open to
> > solve the postcopy problem.
> 
> Right, something like that will come. And I am not saying that we won't model it
> as "guest memfd hugetlb" support in QEMU, but I wouldn't start documenting that
> it will be modeled like that.
> 
> hugetlb will initially be used as a memory provider for hugetlb to allocate
> larger pages, and guest_memfd will essentially strip these pages from hugetlb
> details, turning them into simple large guest_memfd pages.
> 
> One idea is to support other pools, where also hugetlb could take pages from
> these pools.
> 
> So it's just a matter of "we don't know how we will model it, and we don't know
> whether it will be called hugetlb".

Ok, thanks for the info, as long as the plan keeps working, then I assume
we're good.

In general, it's about the hope that we can rely on this -object to create
1G backends in the future that would support any form of HGM with postcopy,
in that case we will (likely, or say, almost certain..) to reuse "hugetlb"
option.. no matter how Linux kernel will name it.

IMHO having both hugetlbfs and gmem sharing the same huge page pools is
definitely helpful for admins, not only because it helps people move away
from hugetlbfs when required, but also because they're essentially the same
thing fundamentally on raw 1G page managements because it is separate
concept of who is the consumer, so from logical perspective it also makes
sense to do so.

PS: above link doesn't work for me, but I think I get enough info, that's
not a concern.

Thanks,

-- 
Peter Xu


