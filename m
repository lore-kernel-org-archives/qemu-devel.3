Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B02C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCnWd-0002O5-Cq; Thu, 30 May 2024 17:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCnWa-0002NW-74
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCnWY-000118-FW
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717105285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gb8aVDtajLrCq9svl40yQdJy1oB4yTtNxC9F1xXMGZg=;
 b=ZLnxH1zbt7uPi39qbAVMzXC4ELDgahPbAoq14XaxRQXtgV6UTGvHTn+A45+/SbyiQawx42
 VRa3sHehOo2ZnZ4m/Xc93vN+kajB9psG/NuysEZO4/HPPpsUgkmeKgxOO9a1on1kcw7/h0
 J+0VcpT+v7cSNUHcXEIU5WMfkFzzWGA=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-c2_Iw_Y1PBuIxNIfGZ-hBw-1; Thu, 30 May 2024 17:41:23 -0400
X-MC-Unique: c2_Iw_Y1PBuIxNIfGZ-hBw-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5b3332ae946so302700eaf.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717105283; x=1717710083;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gb8aVDtajLrCq9svl40yQdJy1oB4yTtNxC9F1xXMGZg=;
 b=sLTi0ZGpH9HNyAnrH9glwHR85eRq6HqNDI4L94shFGQ0oa/4Nqr4AP76A+8qqCO4zB
 JSmzW8RNWAiG5ABHlCtnxLRZLT3EmWWoe5MtC8Jaj3kaFg9TkTVRMcwuhOKUaaKv/doq
 0L1dIMwOaVBbiYHxITiGio2fAwFsmKMdqFSrFeEUIXpUslMFeIVN46wC5k4ecFngKc0G
 TGapBj6qMJapykDwAWThcNkSr80HJQeZTVUdo+A9iBRjp7xcJSpEat+LeyfNHLU4lwEE
 OMK3RHElYeqDCVYMiqWDRLZuNVIzMPDS4Xn4q4AXacYuHo+X9Pkqv9DiexCuRZ7WG6Xd
 UXQQ==
X-Gm-Message-State: AOJu0YztfGsRyT6QaCddmJzRUGKVTKvI+9R3JBchTUTIjCduVbxSkdHV
 +mJQUYfvSzTsEk97K8FIysUBiXcxjb4if/gu2YzXXJ4g0uCOKz76CIApKqmDIthn00Oi6FjUnKD
 Xby8a0T4SP0XZ4NJAmnEq7h6o82EzauBuosu+uLKQ3WjWDx4oD/ki
X-Received: by 2002:a05:6808:1483:b0:3c8:42f4:91cf with SMTP id
 5614622812f47-3d1e35c2b19mr1251b6e.3.1717105282488; 
 Thu, 30 May 2024 14:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VFZrLO33VcVlz7W29vQLMNfJWjWbVRFTYfaVQktMdUzuXu12OnbBZG+jrcsjlZ2HP28slQ==
X-Received: by 2002:a05:6808:1483:b0:3c8:42f4:91cf with SMTP id
 5614622812f47-3d1e35c2b19mr1236b6e.3.1717105281863; 
 Thu, 30 May 2024 14:41:21 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a74e641sm1875286d6.57.2024.05.30.14.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 14:41:21 -0700 (PDT)
Date: Thu, 30 May 2024 17:41:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 13/18] monitor: fdset: Match against O_DIRECT
Message-ID: <Zljyf28LG1YCw9Al@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-14-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-14-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:43PM -0300, Fabiano Rosas wrote:
> We're about to enable the use of O_DIRECT in the migration code and
> due to the alignment restrictions imposed by filesystems we need to
> make sure the flag is only used when doing aligned IO.
> 
> The migration will do parallel IO to different regions of a file, so
> we need to use more than one file descriptor. Those cannot be obtained
> by duplicating (dup()) since duplicated file descriptors share the
> file status flags, including O_DIRECT. If one migration channel does
> unaligned IO while another sets O_DIRECT to do aligned IO, the
> filesystem would fail the unaligned operation.
> 
> The add-fd QMP command along with the fdset code are specifically
> designed to allow the user to pass a set of file descriptors with
> different access flags into QEMU to be later fetched by code that
> needs to alternate between those flags when doing IO.
> 
> Extend the fdset matching to behave the same with the O_DIRECT flag.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One thing I am confused but totally irrelevant to this specific change.

I wonder why do we need dupfds at all, and why client needs to remove-fd at
all.

It's about what would go wrong if qmp client only add-fd, then if it's
consumed by anything, it gets moved from "fds" list to "dupfds" list.  The
thing is I don't expect the client should pass over any fd that will not be
consumed.  Then if it's always consumed, why bother dup() at all, and why
bother an explicit remove-fd.

-- 
Peter Xu


