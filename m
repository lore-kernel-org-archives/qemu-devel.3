Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94D8C54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 01:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQ3L-0000BJ-Vp; Sun, 25 Feb 2024 20:45:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQ3K-0000AX-3H
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 20:45:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQ3I-0002Cc-I5
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 20:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708911907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a1VhnoLCMemHs6lfdBZ29uWXYdEOb2Wxi3dP89IofvQ=;
 b=AAZM5kpNkaArlPqqPcIXGYEUTRHp9C3M/klFmDidYPTJlP+I8xoqbGBVqT61YLH6RJOKmp
 y+uqJ8hmE75b6mKTHJobKlLWCcapu0PrHcNlv6DIAr6bT7WU0dVv1SP1tM5to6Us508f+D
 jzA7sZT8mRmQNgQsuG8lE16tyoiHwT4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-AN00ZD4JMKaWSwurM2-jWQ-1; Sun, 25 Feb 2024 20:45:06 -0500
X-MC-Unique: AN00ZD4JMKaWSwurM2-jWQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29a0b097af4so169904a91.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 17:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708911905; x=1709516705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a1VhnoLCMemHs6lfdBZ29uWXYdEOb2Wxi3dP89IofvQ=;
 b=WDbWGaJHBXXdY2wMx+7J6swDrufoqaGAPkR7p6BynvbpqSluKMBP9utuk6NGV1IjZf
 ti1bM9ZsvUh6NkdE2soEDM98Vy9LuWI7DbU2TmLmnZhC25W1YhE0E/LY0zrAm0SggtBz
 JyhKYSxnuKRnDiN3/PmsFAb204t3Up5rJP1v70JGD4zSzgipW+V6/ocjXxNszwFMBgoP
 ojKvZp/ckt8BzrrtBe9oquAjScmlt+j8x214+jU9nALzOuo22MXJbj0aSuSgHD7IuGVs
 mmd4kX1L4OgwUxQ71fuGl8Y7EmnOSzRdwV8qG0cjAgaL6vdolE4ZHRwDyfsrSIC95FR7
 hmAg==
X-Gm-Message-State: AOJu0YyYVT9JbYJ2fsXOCYwfTxf2Ji2UZRbG4BnK0+j2drtt8TNc7zX/
 0Ui/ijXJP729OBdCJxJdobj3Zw5AjUDMW6i0yH+kHltPNinC1AXndKIN5AFg4bzOLh7FBwy8jcl
 5gumTRjkqa23kjkxfS5ZE+b80AuHeIVDWnhJLbGzAaFI1b6HNM/bQ
X-Received: by 2002:a17:902:e98b:b0:1dc:82bc:c072 with SMTP id
 f11-20020a170902e98b00b001dc82bcc072mr5552610plb.1.1708911905255; 
 Sun, 25 Feb 2024 17:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2NgzwbmN1681utHs6HTi4LnhM9mg/StedaAQMuUYdicm73lJjQy9k3fS1AHLo1nfG+Ygqgg==
X-Received: by 2002:a17:902:e98b:b0:1dc:82bc:c072 with SMTP id
 f11-20020a170902e98b00b001dc82bcc072mr5552604plb.1.1708911904964; 
 Sun, 25 Feb 2024 17:45:04 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s10-20020a170902ea0a00b001dc1ef0d42bsm2779430plg.25.2024.02.25.17.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 17:45:04 -0800 (PST)
Date: Mon, 26 Feb 2024 09:44:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: Fix qmp_query_migrate mbps value
Message-ID: <ZdvtGqj6qmwDhHeN@x1n>
References: <20240219194457.26923-1-farosas@suse.de> <ZdVlUsTDJA4hdNhg@x1n>
 <87y1beascb.fsf@suse.de> <ZdcWmVffLWhNB-Q8@x1n>
 <ZddMRroqCeuRWGFA@x1n> <87ttm0a9t3.fsf@suse.de>
 <Zdfh7oOARA6p-Iob@x1n> <87frxj9wy7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frxj9wy7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 23, 2024 at 09:39:12AM -0300, Fabiano Rosas wrote:
> I've been planning to merge migration_completion() and
> migration_iteration_finish(). It's too unintuitive to do the completion
> routine deep inside migration_iteration_run(). AFAICS those are all tail
> calls, so we could bring migration_completion() up into the
> migration_thread top level.
> 
> So if you'll allow me I think I'll refrain from moving the state into
> migration_calculate_complete() for now.

Yep go ahead, I'll read the patches.

-- 
Peter Xu


