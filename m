Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB92CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 19:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs6Ud-0003lH-R9; Wed, 03 Apr 2024 15:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rs6Uc-0003ku-8s
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 15:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rs6Ua-0006zY-Og
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 15:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712173310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vudUi/68xMtrQZBRWCWpa3fAlec3/3KhJ/rjBG2tcA=;
 b=UOVV1JGySB66z8z8g6cYWkvGYjOYY0TXPCxkkmU1rYwh1XwGFCIEX+ay9Xd656isSmiexo
 kirxVKRRdtq14QsdpAJAE9pnCgshnU8AINRrjk3wa3a9UsG3jFsVk3A/7LbUXIYVv2MgTk
 ETXHzgwpx6Y9IcN6zVbWFn5PMILTxiU=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-ghmYOvJzMwmVFbOO3Nl7UA-1; Wed, 03 Apr 2024 15:41:49 -0400
X-MC-Unique: ghmYOvJzMwmVFbOO3Nl7UA-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-478222c7062so11674137.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 12:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712173309; x=1712778109;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vudUi/68xMtrQZBRWCWpa3fAlec3/3KhJ/rjBG2tcA=;
 b=XFU4XWEooBHb2/mlT8T8jNaycJl9sBmlnFPo1hBJdKJoA9BoYh2tvp3Q7gufXt5dMv
 aIJpxYNh3Y8Uv3bugpRjji+M8s6At1fT33IMZufLbMFHgphmSPVTK5FUGOV3sJ7CQKGV
 Z/M09ZHDAjB9JIb5xY35kIVIbfcum6FmGYojYyR4KK9Cok2tELD8DaRy2f+Z1vxWgv9O
 woFM0g/Ed/sxag+EXcXgDOOG36XInj3788tLrNIQnnXuYJMpbdGgc6N22W96CzOfmGBJ
 y/E/fAyrLR7ikWOb6T9/nyOxs2dhnlcIjVfiVrWvW8T2BtMfT054FZGPQMiEcVkmNZAj
 WYBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXJUKm22bDHNpyR4zPnZ28aERfkoEK10SSTZYCiz2XGJLuqnNrppxoRPjLbIn+hLLWY++XEYi11qzFqyOry+RQn0K4ZlI=
X-Gm-Message-State: AOJu0Ywt8hYG81PrMfvNj8XRxhrOtPXf7LeagIi3RJldLWeMBQKKeA3T
 /7nNlySNZvKpWNMV0VWm3azVE8tMvdPgPdrslDrKz895VjXxZs79THlG8zxAHLVQ8293NqAPK7H
 iK/d3g3F3ITr6rzWKUQ7p5fc11coqZGaV9PEH9oRRFsFc6Zq3eYCr
X-Received: by 2002:a05:6102:2273:b0:478:617e:fc12 with SMTP id
 v19-20020a056102227300b00478617efc12mr356447vsd.0.1712173308507; 
 Wed, 03 Apr 2024 12:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrNjmj1dL+ltFtzyPjH/axu/+hMPq8VF8IQFZBMdQdPkLsnaYD51ypyj+zMjLc19RRvmfQPQ==
X-Received: by 2002:a05:6102:2273:b0:478:617e:fc12 with SMTP id
 v19-20020a056102227300b00478617efc12mr356425vsd.0.1712173307948; 
 Wed, 03 Apr 2024 12:41:47 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c13-20020a056214224d00b006913aa64629sm6705135qvc.22.2024.04.03.12.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 12:41:47 -0700 (PDT)
Date: Wed, 3 Apr 2024 15:41:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>, Yuan Liu <yuan1.liu@intel.com>
Cc: Yuan Liu <yuan1.liu@intel.com>, qemu-devel@nongnu.org,
 hao.xiang@bytedance.com, bryan.zhang@bytedance.com, nanhai.zou@intel.com
Subject: Re: [PATCH 1/1] migration/multifd: solve zero page causing multiple
 page faults
Message-ID: <Zg2w-a0EQF_8yYHx@x1n>
References: <20240401154110.2028453-1-yuan1.liu@intel.com>
 <20240401154110.2028453-2-yuan1.liu@intel.com>
 <874jcjdir6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jcjdir6.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Apr 02, 2024 at 09:57:49AM -0300, Fabiano Rosas wrote:
> Yuan Liu <yuan1.liu@intel.com> writes:
> 
> > Implemented recvbitmap tracking of received pages in multifd.
> >
> > If the zero page appears for the first time in the recvbitmap, this
> > page is not checked and set.
> >
> > If the zero page has already appeared in the recvbitmap, there is no
> > need to check the data but directly set the data to 0, because it is
> > unlikely that the zero page will be migrated multiple times.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> 

I queued it with below squashed to update the comment. I hope it works for
you.  Thanks,

===8<===
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 848915ea5b..7062da380b 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -57,7 +57,7 @@ struct RAMBlock {
     off_t bitmap_offset;
     uint64_t pages_offset;
 
-    /* bitmap of already received pages in postcopy */
+    /* Bitmap of already received pages.  Only used on destination side. */
     unsigned long *receivedmap;
 
     /*
===8<===

-- 
Peter Xu


