Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1185EC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXd0z-0005Dy-0H; Wed, 07 Feb 2024 03:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXd0w-0005Dm-SW
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXd0v-0004Vs-7X
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707293436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+/+j52CiNK5jx8h1ObyvtFEaOy+/yC9B7u3lllHSTE=;
 b=Kfoibt2wUpCFCJjuRXVY/ZuwR2NEbvtm/Jjf2JpuGQmX49zutnLKVr/Es4rJimPvlKloEm
 of1zaugTjh8EP8SI/Ru60RTgn/o6mlaQyrsQYBw9lmLWUNs9UY1pEtc0dCZvikuMYGZi+O
 MrIu5IWWKwvm7IB8R/Bc2HFjX9iHtEU=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-AmTPBJYtO765ehmjKb2Aiw-1; Wed, 07 Feb 2024 03:10:34 -0500
X-MC-Unique: AmTPBJYtO765ehmjKb2Aiw-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3be33c7f1c7so179450b6e.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 00:10:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707293434; x=1707898234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+/+j52CiNK5jx8h1ObyvtFEaOy+/yC9B7u3lllHSTE=;
 b=nmxx+BEz+HDP1w9dqbGQ3YpLioi487Bo6L2wnFAEgtExnpqYdahPLkWWslyRJqM4pT
 ghrzAzCz2zcNWXwpQxIsSuH9YRUU1ZMj1aCNytYZtqswg/jOtRRjIcGB/+qn6hK7q0r8
 3QTC8nJ8tVr/3Cn+YtnS2xWD9jDgqV4J9+nCs/9sNKows+Qn67xZ6R5Sv2zsH4IAxut7
 y7Qy1KTYkxzENZWGaBNl875jLYsEhYMslLwYibl3b3wBdiRVqCNjSx8aXmOeiCzLV/6M
 Sa8qjFq11M8KUU2onxTA6s6Q1peX7yk0FAPrvdmE3Ch84cG2iqeejGHE3iFBOwnSNFix
 JrMg==
X-Gm-Message-State: AOJu0YzyYYQSHZmqD10+vIxfvMJsI1noA4qrldydb+uN1CfH8+W7Gb7G
 Ygj0KoxZTEJp8VRqce9NXNhbSe5DsbOYlppAUk6erboRiLEaeRGqAKGPi06yBiJ8yDKVrv5OvxL
 Iu+vmoub4Xc7UBV8x8yY5As7AkxHJCFDq5PWlKckZ50GKfdr7GBa9
X-Received: by 2002:a05:6358:7e14:b0:176:6149:5558 with SMTP id
 o20-20020a0563587e1400b0017661495558mr5750690rwm.1.1707293434071; 
 Wed, 07 Feb 2024 00:10:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvgay62wbuqqD/fG8R2mfiOfbVpsP+i2TQs6SZOeK/VhMxgIk5CrNNi3MAiDqfYuYAAt7srQ==
X-Received: by 2002:a05:6358:7e14:b0:176:6149:5558 with SMTP id
 o20-20020a0563587e1400b0017661495558mr5750671rwm.1.1707293433669; 
 Wed, 07 Feb 2024 00:10:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWTXLqH6DOmgGnDJihb+GgbsRiK0KoE6elrx5RyMkXh5NPKTEngU6ktuAjGI7aYEJd92nU8bqloiEuNpJJhvywfUwOXJpwiD5f286eRbxP/ULafBZ2HSUXnYULq+mtLcU6I7kw5nZlCGE1Zo6Rvh/AHMqqf
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ca17-20020a056a02069100b005cd821a01d4sm751254pgb.28.2024.02.07.00.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 00:10:33 -0800 (PST)
Date: Wed, 7 Feb 2024 16:10:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Bryan Zhang <bryan.zhang@bytedance.com>,
 Hao Xiang <hao.xiang@bytedance.com>, Yuan Liu <yuan1.liu@intel.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Subject: Regarding to the recent Intel IAA/DSA/QAT support on migration
Message-ID: <ZcM68L8PaoD6qtLp@x1n>
References: <ZcM6TIWkyCRsk6wn@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZcM6TIWkyCRsk6wn@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Copy qemu-devel.

On Wed, Feb 07, 2024 at 04:07:40PM +0800, Peter Xu wrote:
> Hi,
> 
> I'm sending this email just to leave a generic comment to the recent
> migration efforts to enable these new Intel technologies.
> 
> The relevant patchsets (latest version so far) we're discussing are:
> 
>   [PATCH v3 0/4] Live Migration Acceleration with IAA Compression
>   https://lore.kernel.org/r/20240103112851.908082-1-yuan1.liu@intel.com
>   
>   [PATCH v3 00/20] Use Intel DSA accelerator to offload zero page checking in multifd live migration.
>   https://lore.kernel.org/r/20240104004452.324068-1-hao.xiang@bytedance.com
>   
>   [PATCH 0/5] *** Implement using Intel QAT to offload ZLIB
>   https://lore.kernel.org/r/20231231205804.2366509-1-bryan.zhang@bytedance.com
> 
> I want to comment in a generic way since this should apply to all these
> series:
> 
>   - A heads-up that multifd code is rapidly changing recently, I apologize
>     that you'll need a rebase.  It's just that it's probably much better to
>     do this before anything lands there.
> 
>     IIUC the good thing is we found that send_prepare() doesn't need to be
>     changed that much, however there's still some change; please refer to
>     the new code (I'll prepare a pull tomorrow to include most of the
>     changes, and we should have a major thread race fixed too with Fabiano
>     & Avihai's help). I hope this will also provide some kind of isolation
>     to e.g. other works that may touch other areas.  E.g., I hope fixed-ram
>     won't need to conflict much with any of the above series now.
> 
>   - When posting the new patchset (if there is a plan..), please make sure
>     we have:
> 
>     - Proper unit tests for the new code (probably mostly software
>       fallbacks to be tested on the new libraries being introduced; just to
>       make sure the new library code paths can get some torture please).
> 
>     - Proper documentation for the new code.  Please feel free to start
>       creating your own .rst file under docs/devel/migration/, we can try
>       to merge them later.  It should help avoid conflictions.  Please also
>       link the new file into index.rst there.
> 
>       IMHO the document can contain many things, the important ones could
>       start from: who should enable such feature; what one can get from
>       having it enabled; what is the HW requirement to enable it; how
>       should one tune the new parameters, and so on... some links to the
>       technology behinds it would be nice too to be referenced.
> 
>     - Try to add new code (especially HW/library based) into new file.
>       I see that QPL & QAT already proposed its own files (multifd-pql.c,
>       multifd-qatzip.c) which is great.
> 
>       Xiang, please also consider doing so for the DSA based zero page
>       detection.  It can be called multifd-zero-page.c, for example, and
>       you can create it when working on the
>       offload-zero-page-detect-to-multifd patchset already.
> 
>     - Please provide someone who can potentially maintain this code if ever
>       possible.  Pushing these code upstream is great, but maintaining will
>       also take effort.  It might be impractical this keeps growing for
>       migration maintainers (currently Fabiano and myself), so we may like
>       to have people covering these areas, especially when the new codes
>       are not directly relevant to migration framework.
> 
>       I'd suggest for each of the project we can add an entry in
>       MAINTAINERS below "Migration" section, adding relevant files (and
>       these files should exist in both the new section and "Migration").  I
>       am not sure whether Bytedance would be able to cover this, or we
>       should try to find someone from Intel?  If you're willing to add
>       yourself to maintain such codes, please attach the maintainers file
>       change together with the series.  It will be very much appreciated.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


