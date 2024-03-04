Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2CAC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 13:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh8CL-0000RA-VS; Mon, 04 Mar 2024 08:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh8CJ-0000Qy-2z
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh8CG-0004RE-Th
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 08:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709558252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1dPlt+VnCpcEOsgoh7qeSYDmELU+5cLAxrM5ua3Oaw=;
 b=PP0e5A1i3xuq4xWz8oQFSj/e101RE38bzeiSF6M1kWO2wFdbA675Wt++k+L1YJqbwCHPBC
 /pCkruvdrdr+ylN2LuXBdRD4wBI4b6AhEzsj6ZtAXAVWKPgHt8hyYw6BstGaGhnAcg9bK3
 krBDwZ6y9XIoKvkNZpLemyZJrtJo9c4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-oot5KAEhO_G37NJu5nFefQ-1; Mon, 04 Mar 2024 08:17:31 -0500
X-MC-Unique: oot5KAEhO_G37NJu5nFefQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29a6fc39c7eso237160a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 05:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709558250; x=1710163050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1dPlt+VnCpcEOsgoh7qeSYDmELU+5cLAxrM5ua3Oaw=;
 b=gFh0zaYk2gbxnzjQxuEOyuDNKrD2Zur1VE4+56kjAEAXXYctZQwse0yHWKFdZKfKSa
 jrfChQHExR5XWXBMXCNNlfzkQY1j0YZ+R/iZLPEN7G1xLD/mwRLmAJ6FKKyTnquQa9ap
 FtywiFnAxGufYvMbJyZo0gnXCfKOikB/Oc+2LanRwVUgpkQag8JfJFIKGgTVACR3FFO+
 zAws0oZGQAZx8otBARWQ6GN0Wxzd6SD4brtLLYBC3sv0yF6AJQbvTaq2Th0AbDbHXsaq
 9S80P0UQ3HyiuYC+qZRIeCEgwy4/Z1E3sszDeWkkguJ5lDdtQ5/xFjByWCYwKbtnYss3
 z4BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUUmSu5edzC/rCYGup0DMIL3l50iLsgsP7PbWBdfw5P6DTDvUtSkLAYl3xq9s3Si1ZHDRbAJShFbzVuZs7GFiSUTa0tGA=
X-Gm-Message-State: AOJu0YzqmsE2UpNKki6C/XsLNOK4sMFEwZ6anIx09mZCxJMGQgmePzxG
 pXGcIcnv8dICHnWeAi4A5UlFeefIr4TIat7B6+494bik+ZLLmMBKIyobih9ui+0dWLov5XQx2A4
 PqmwFwIAcWYpOjJ5f1oHOtXHM0CkY5NW33k8ncR+D3QGC1637EMUo
X-Received: by 2002:a17:90a:db81:b0:299:c3d:c00e with SMTP id
 h1-20020a17090adb8100b002990c3dc00emr7191101pjv.3.1709558250696; 
 Mon, 04 Mar 2024 05:17:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGCweczouJUnnw2M9NwAAYPI0IK0Sng9hVeXDzfcrUnDOXanVXx9oKNTesnXoY+jfQsnePUQ==
X-Received: by 2002:a17:90a:db81:b0:299:c3d:c00e with SMTP id
 h1-20020a17090adb8100b002990c3dc00emr7191079pjv.3.1709558250352; 
 Mon, 04 Mar 2024 05:17:30 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 gb2-20020a17090b060200b0029acce2420asm7688077pjb.10.2024.03.04.05.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:17:30 -0800 (PST)
Date: Mon, 4 Mar 2024 21:17:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeXJ4VvX6RvSHKk-@x1n>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com> <87bk7unny2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bk7unny2.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
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

On Mon, Mar 04, 2024 at 10:09:25AM -0300, Fabiano Rosas wrote:
> Perhaps if we move the fsync to the same spot as the multifd thread sync
> instead of having a big one at the end? Not sure how that looks with
> concurrency in the mix.

Can try, but I think the bottleneck should normally be on the block
backend, in which case I won't be surprised concurrency on flushing won't
help then.

Please see my other proposal on removing fdatasync() from qemu; I could
overlook some reason to have it, though..

-- 
Peter Xu


