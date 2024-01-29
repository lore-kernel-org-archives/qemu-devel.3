Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE31C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 04:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUJ5Z-0002Ja-Pn; Sun, 28 Jan 2024 23:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUJ5X-0002JP-SL
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 23:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUJ5W-00072Z-4P
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 23:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706501857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JTMV91v9LkcgRcFdl8lxDs8wyJTP2kqgnxaBBDnuxzE=;
 b=W7klD9r7uZaY+22CAMxN+5tZb8J6MQnlGy2uwd4AlUYH41CPx0LEXFnuE8D6eUNfs+qQBu
 h4508/1PLsOvU9ehCU+fBnSJJeUxS0gRO4BgdOUGBxy1aoG01Kw2qwfdrNzuFWHfp8vHTC
 I5abCs2zDQBZHpAmFzwGyPRCIt12/00=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-NoKFWcXbN_iaNNuZKXNpnw-1; Sun, 28 Jan 2024 23:17:35 -0500
X-MC-Unique: NoKFWcXbN_iaNNuZKXNpnw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so717002b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 20:17:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706501854; x=1707106654;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTMV91v9LkcgRcFdl8lxDs8wyJTP2kqgnxaBBDnuxzE=;
 b=JbUnQM39pPB2iB66HjOod2hs2/HM+Zye1h6tpktP93AO2LilaEIqZwGLM+mzdOi/vs
 ps5O09KSvGsZB2KtX0I2fJrGf0JbilaJ3fc+ltMk66r1GUyIHiby8zpNYH51W0RQPuWV
 eT9zyqCFmPfA2Sal1iWI8ZEntI3OyiWelOv+XtbHtii3NWyatPHcJ5ai2jLIP/TYDF0q
 DMlte25GQm/zhdsnQC+e/UFoB00zEoK7jq0lv3cVqgwduLO8mt7gSAmVuCEW3/6kv47m
 9J7uPTmrXcBeR7b4suB5h880T7jX+eYlk3U2OTGi5kL8tzzSazG3GlHOFYn8ZJ6MWeKD
 A4sg==
X-Gm-Message-State: AOJu0YzjhRVcpk00iWYwIQZ3gd+KGxqqMB9z0ScV/WgJbKBwCHCfEF/8
 uewsa3IM4JIjdEXqa+Z4H6hJ6OMdO8Xs5FW4MfXTNRZc5EB9UIMje7Rha+5bG8mW94SsGsn9OmG
 cIKYu/Es5rGvs0RVlxQRqhAhzUDKw/lR7BzVLdYm/V/zAOwnwfydi7fDFCpqIQNg=
X-Received: by 2002:a05:6a20:a10f:b0:19c:b055:b2b with SMTP id
 q15-20020a056a20a10f00b0019cb0550b2bmr834521pzk.0.1706501854355; 
 Sun, 28 Jan 2024 20:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv0uUatopXb++43OOgFCN1MdTeWl4vKSZpFxMvhL1IstxJ/Jx/QyJm6XM9nhR12Oz8oKKl5g==
X-Received: by 2002:a05:6a20:a10f:b0:19c:b055:b2b with SMTP id
 q15-20020a056a20a10f00b0019cb0550b2bmr834516pzk.0.1706501854023; 
 Sun, 28 Jan 2024 20:17:34 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 pl14-20020a17090b268e00b002906a444b2esm5123300pjb.7.2024.01.28.20.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 20:17:33 -0800 (PST)
Date: Mon, 29 Jan 2024 12:17:26 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 04/17] migration/multifd: Set p->running = true in the
 right place
Message-ID: <Zbcm1nXzQ_r0eGG0@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-5-avihaih@nvidia.com> <87a5otw2ps.fsf@suse.de>
 <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <78fa90f7-d062-4f23-8035-841a0ffef8af@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jan 28, 2024 at 05:43:52PM +0200, Avihai Horon wrote:
> 
> On 25/01/2024 22:57, Fabiano Rosas wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Avihai Horon <avihaih@nvidia.com> writes:
> > 
> > > The commit in the fixes line moved multifd thread creation to a
> > > different location, but forgot to move the p->running = true assignment
> > > as well. Thus, p->running is set to true before multifd thread is
> > > actually created.
> > > 
> > > p->running is used in multifd_save_cleanup() to decide whether to join
> > > the multifd thread or not.
> > > 
> > > With TLS, an error in multifd_tls_channel_connect() can lead to a
> > > segmentation fault because p->running is true but p->thread is never
> > > initialized, so multifd_save_cleanup() tries to join an uninitialized
> > > thread.
> > > 
> > > Fix it by moving p->running = true assignment right after multifd thread
> > > creation. Also move qio_channel_set_delay() to there, as this is where
> > > it used to be originally.
> > > 
> > > Fixes: 29647140157a ("migration/tls: add support for multifd tls-handshake")
> > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > Just for context, I haven't looked at this patch yet, but we were
> > planning to remove p->running altogether:
> > 
> > https://lore.kernel.org/r/20231110200241.20679-1-farosas@suse.de
> 
> Thanks for putting me in the picture.
> I see that there has been a discussion about the multifd creation/treadown
> flow.
> In light of this discussion, I can already see a few problems in my series
> that I didn't notice before (such as the TLS handshake thread leak).
> The thread you mentioned here and some of my patches point out some problems
> in multifd creation/treardown. I guess we can discuss it and see what's the
> best way to solve them.
> 
> Regarding this patch, your solution indeed solves the bug that this patch
> addresses, so maybe this could be dropped (or only noted in your patch).
> 
> Maybe I should also put you (and Peter) in context for this whole series --
> I am writing it as preparation for adding a separate migration channel for
> VFIO device migration, so VFIO devices could be migrated in parallel.
> So this series tries to lay down some foundations to facilitate it.

Avihai, is the throughput the only reason that VFIO would like to have a
separate channel?

I'm wondering if we can also use multifd threads to send vfio data at some
point.  Now multifd indeed is closely bound to ram pages but maybe it'll
change in the near future to take any load?

Multifd is for solving the throughput issue already. If vfio has the same
goal, IMHO it'll be good to keep them using the same thread model, instead
of managing different threads in different places.  With that, any user
setting (for example, multifd-n-threads) will naturally apply to all
components, rather than relying on yet-another vfio-migration-threads-num
parameter.

-- 
Peter Xu


