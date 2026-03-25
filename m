Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EC4109E521
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5W6Z-00083T-90; Wed, 25 Mar 2026 17:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5W6X-00082R-E0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5W6W-0002I8-2D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774475371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yPymySHSDc57pYf4VlH0Mh284WvwJPgHlUYtYnHwF5Q=;
 b=ISvRo+8U17lXHmWJzdlD1hf/M5NReC8tn8RDUI4hficwPYjtfQVkdLeq22G/k8Qcz84Xsp
 39ZTQWFuMgGlFHsVaw7+icNnNXFftul5Y603WFQ+hHkC064dByFo5aAuBLSdxY881QsjKJ
 jzjIg2Pbbs/AeOVk/UZNib9l0nyxMe4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-F2Z3rSkPOxCrAJVY9DL9yw-1; Wed, 25 Mar 2026 17:49:29 -0400
X-MC-Unique: F2Z3rSkPOxCrAJVY9DL9yw-1
X-Mimecast-MFC-AGG-ID: F2Z3rSkPOxCrAJVY9DL9yw_1774475369
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfcebeb1f3so160082685a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774475369; x=1775080169; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yPymySHSDc57pYf4VlH0Mh284WvwJPgHlUYtYnHwF5Q=;
 b=IMQQa5xeuaeUWWJo+zLqGF0G+4sUVHalgqUtEuBb2VnLrVmPsqSOZ6KOrdbkHzZaUL
 HsGCHLGPvL5DiAkjPiXwBdC9JkLdSFu0/XV2DpJcFSP6MF5XAyFM3j2mPv9llrn6CKte
 Bv2qGSLogT3I0T5pxvIr9UzHHc8DqQqU4zvNbo1o+IvGF7/vjiqzpBkRb1Qbnknw+ukM
 URYlIKLiwt6J5ByAAT0jxBUJYIbjoTIlQ9xqbaLzTjwahSBcIUySbVrB5ImDThSM3K7b
 avH/ou9KujSblJfvlCipkiBjkl7Q4+PFQaAKC46/D28+nN/tgy1DxrsrvGyPypA14DH5
 VrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774475369; x=1775080169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPymySHSDc57pYf4VlH0Mh284WvwJPgHlUYtYnHwF5Q=;
 b=qKrCVlpTf4uDomuB/q2MZYPSngATRspjl4JrxZrMOKKx4c9MImSq2hLyWCsFmyL3T7
 w/C4IZD9uoYva4oukZlJfE8Q8UFmplFsgSG4OXCjUgcv62i0N8nO4HMoXiD6csze5HYM
 G/Q4ml3AxxGTzMb20Y6h5plm88MhO5A0gMnL7PWPwajWrKRw1MJRzssbZkz9ZzM7Stv1
 HOxaDCls+gn1daYhdSJicSzBrbPt6DKy3M+YCgbbGO4J4S4OotrUfI0yiVaARiyTZRC/
 DQ/xnAWshZUJKYXmy0Org7CPIc8nY7dfi/S/WCVz+55/YRlpUl9eCWrsTapbfAyDEcFn
 ndXA==
X-Gm-Message-State: AOJu0Ywz74PKyaHXp8xv79DPzYLLz3q9n+QjtrWHPY7ScoBY5jW5Nha3
 a9QlOc27gQIlGgrnKmhKlWd9F+b0bikLW9KdEddI/iU14Y+piLwaBayC7vsj5+jWRfIixgH0ZFk
 d3ptDHFF7YGEVNbHu+cx3zQv7aiyH+Sf1euNF7+zHu2p6mgwYQ65NGcQJ
X-Gm-Gg: ATEYQzw2Krd06xJLELbpAxd6iGjyCxm8wYJS2r4i451Zkjgtm04aEL9BPwvp47lmGyx
 w64iPISSz063H684t2V8E3CJtVuKZZ8/AtrPF3wjkvc+ffB1cLO+QFgCyjgWV9sywBIRVEPcoJ0
 eTNY1TLwaZZ/M55leduZ8AX81CZaI/X4Nl/SzaE1ErlqNwQjXZWAId8mxM/xeO0PjEGeJmbU6iJ
 5UzFr2XN2l6ghbFRi51W0I3e1+F9dQce7jTCA3ZF/8MkiRwx3h4AVdK2eDwhfm0kYnT47a3RRki
 IgOgBIQmfiCDRESpjysRI8WnwcO+yBZ7EGHkI+kJLbbW8ml/DJeURpkywhHke97zTRYYq51M6w7
 dm53K5yhcsnMHYA==
X-Received: by 2002:a05:620a:4009:b0:8c3:7f27:a65d with SMTP id
 af79cd13be357-8d000f7e172mr809847285a.28.1774475369028; 
 Wed, 25 Mar 2026 14:49:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4009:b0:8c3:7f27:a65d with SMTP id
 af79cd13be357-8d000f7e172mr809841585a.28.1774475368354; 
 Wed, 25 Mar 2026 14:49:28 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39f1d6sm82279085a.10.2026.03.25.14.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 14:49:27 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:49:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 13/17] vmstate: Drop VMS_ARRAY_OF_POINTER_AUTO_ALLOC
Message-ID: <acRYZoq3ydLFKs_q@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-14-farosas@suse.de>
 <acQ3fae3pdLagfwV@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <acQ3fae3pdLagfwV@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Mar 25, 2026 at 03:29:01PM -0400, Peter Xu wrote:
> On Tue, Mar 24, 2026 at 04:43:28PM -0300, Fabiano Rosas wrote:
> > The semantics of the VMS_ARRAY_OF_POINTER_AUTO_ALLOC of allocating
> > memory dynamically for an array of pointers could be thought to be the
> > same as the currently non-existent combination of VMS_ARRAY_OF_POINTER
> > | VMS_ALLOC. The code is now able to handle such invalid combination,
> > so drop the new flag and enable the VMS_ARRAY_OF_POINTER | VMS_ALLOC
> > combo.
> 
> I was intentionally leaving VMS_ALLOC only for the top layer vmsd field,
> but then.. I think you're right, there's no way the driver code can offload
> the allocation of top layer vmsd field, while without offloading together
> the pointer allocations inside the array altogether when it's
> VMS_ARRAY_OF_POINTERS.
> 
> Let me see how I can incorporate this change, unless extremely awkward to
> rearrange, otherwise I'll make it not introduce this flag when repost.

Hmm, I forgot one thing, which is when the array doesn't need allocation
but the field does.  In that case VMS_ALLOC mustn't be set, but we still
need another flag to say "we need allocation for the elements in the array".

So maybe we still need a flag.

-- 
Peter Xu


