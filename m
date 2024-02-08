Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B46C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXufP-0003dB-7s; Wed, 07 Feb 2024 22:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXufN-0003cj-Nj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXufI-0003d9-Fy
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W16T7E/Sp7m0u0mJzBIZzC/1ggXDnZUTAvF49M9WktE=;
 b=HksdNPhEXKZLu9fKY06vgZAy2hk+fXDwugcZ2UOqOFUh4JEWheyDgr7t4gw7brda9inyLn
 xn5EJqxI3HcI+XZMmdOLbxqO9InfxGTj0Yv5y0wH9cNiVn1lIiqcnjcQOUYeEBOK/6VgIq
 jyugYcmyjlhul3g0BjMOm+0MewY30qY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-eeQXyx-wN2uUT2kE4B7_pw-1; Wed, 07 Feb 2024 22:01:25 -0500
X-MC-Unique: eeQXyx-wN2uUT2kE4B7_pw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29692c99979so283089a91.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 19:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707361284; x=1707966084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W16T7E/Sp7m0u0mJzBIZzC/1ggXDnZUTAvF49M9WktE=;
 b=FMTB0aeLKGS/aYCbP3e9h3Hp8srswqe9mKyb02riltvaWlkWimJNBwEKum3xMIV0jP
 eCLLimoP7j5U7coECoo7EdJhEwxx+uK9kQIXMkqeOONLPucM+LpS240D6MLZVMxX5DKy
 N32ZGCY6xYoSw9uK0pWe1DhQJjbJ7794cqnvfrYDSAH270dpg/GZ5WIt1u/P5KwrFca2
 bnKGbMPphgUOCA2iG4JJ6WYu9OzN4qygmRRWbB201s0PVmesrKXUUIOLWvaPrQjJKs27
 gIsXWBq2lEZ8f2ffVeqHkMkW2P0QqMlFyT/5bou7edyCrlUe7LENN4++e/3sz+lIMLuU
 Dfvg==
X-Gm-Message-State: AOJu0YwuIT5YJB1ZC5cVK7w74G7qLH4V9bW4sY61WnlUos1CyLig3nhW
 AkIia/91HZko+Its/vwSvWXt4Un8MiEY07RFjb6p2kACi+fszdZKFQbnl/OEmk+SLkVZRWLjKFm
 vlnjFx5+x6K6HIlvHYyXuGZTDILkrQQsusWKi1jEmXwory3n3uDbv8x30bfmAI3A=
X-Received: by 2002:a17:90a:2f42:b0:296:faf0:988c with SMTP id
 s60-20020a17090a2f4200b00296faf0988cmr147072pjd.3.1707361282547; 
 Wed, 07 Feb 2024 19:01:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExnt0XW9qFJgoqekTD1opPvjVZBB0fyg7uqYoZ0YluL8ezzCNvsS+ZwaKJBH9A/bWz+Er4Wg==
X-Received: by 2002:a17:90a:2f42:b0:296:faf0:988c with SMTP id
 s60-20020a17090a2f4200b00296faf0988cmr147049pjd.3.1707361282098; 
 Wed, 07 Feb 2024 19:01:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW2js8d90J5Yd3sxFebwmRS4+/OqQTRyg1GAC604pEo+w0XhK3rOwIFBUi3YgyC91hLdrxayF/K6wePd3PPfwE6zkrRj4dlUnivrEGl7rtD8i0seurVJI0=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s93-20020a17090a2f6600b00296ba96cda9sm227299pjd.55.2024.02.07.19.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 19:01:21 -0800 (PST)
Date: Thu, 8 Feb 2024 11:01:17 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/6] migration/multifd: Fix channel creation vs.
 cleanup races
Message-ID: <ZcRD_R0lR6MwHZe6@x1n>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

On Tue, Feb 06, 2024 at 06:51:12PM -0300, Fabiano Rosas wrote:
> Based-on: 20240202102857.110210-1-peterx@redhat.com
> [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and cleanups
> https://lore.kernel.org/r/20240202102857.110210-1-peterx@redhat.com
> 
> Hi,
> 
> For v3 I fixed the refcounting issue spotted by Avihai. The situation
> there is a bit clunky due to historical reasons. The gist is that we
> have an assumption that channel creation never fails after p->c has
> been set, so when 'p->c == NULL' we have to unref and when 'p->c !=
> NULL' the cleanup code will do the unref.
> 
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/1166889341

Apologize if I queue this too fast, but i'll disappear tomorrow, so I want
to have this thread race fixed soon.  I hope that's already complete from
angle of all race can happen, but if otherwise we work on top.

queued, thanks.

-- 
Peter Xu


