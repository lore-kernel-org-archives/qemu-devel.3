Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C7606A695
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H3w4Yd76;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZUk0Mj8z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWRf-0000BV-BH; Fri, 20 Nov 2026 16:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUWRb-0000Ah-DK
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUWRZ-00050v-HA
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795211212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zAQhrz6OmD79icoD8jWObu4yTfg/NVSUFc54Y+xMqg8=;
 b=H3w4Yd76VL6+CC8OcLzcjgX3DxlIucWVhEd6HkCmkotrqZMpPtfQxUX5tUKdxRSnKM6Uic
 N/ovFuReu9C7EhU1u1KGsXLezm1zfGaCJd+ureBvVyXNDTYnuaalWEp2mBdkTdt8psTpg2
 lzIKFw3GTrFqsyaTSHbYivhJx0woark=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-BTvnB9A9NMemeT8NDL1XPA-1; Fri, 20 Nov 2026 21:46:50 +0000
X-MC-Unique: BTvnB9A9NMemeT8NDL1XPA-1
X-Mimecast-MFC-AGG-ID: BTvnB9A9NMemeT8NDL1XPA_1795211210
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-55d7544d113so30138951cf.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 13:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795211210; x=1795816010; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zAQhrz6OmD79icoD8jWObu4yTfg/NVSUFc54Y+xMqg8=;
 b=ZUk0Mj8zcZtXSDv1cxtUnYJ60nSHKOFbWq/xzDfozan5fCWt2oABsjBC4hQzi0wsY4
 Mf/pNQvNMZcW9drMNJig4OKKcrcIm8L57h+huLF2HlkeXBujxo8g/gm9s0kjAMSXpTNJ
 rmT6qxhTUIxfna1d3BpuQ5+GaCqPZwW8CLtUc/pWk/Mvrq9CI/Y6NNY7OOIyAXg8dhsM
 0v0m7hrLSzciihFoseZhNkrHdUwWL6OeFxshYOzcdnoT1Fl2S4r6Fxf2XLKGnXKMYrJe
 Tq06GnKtMTxL144dYi/CF7yc6bcQj3rSYLzoGyyYHMOPJYT7K5clWVjajZUdAKjyfOj+
 PUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211210; x=1795816010;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zAQhrz6OmD79icoD8jWObu4yTfg/NVSUFc54Y+xMqg8=;
 b=fQx9LvV6fGWK4Rl4DIQk88QzL90BuuGc4crrQBsUJ2h5obmL67G8gCj+4BqnD5k3ZL
 TojL/NC+opiNkShmP4XPVP4mz42nMDEtg64dEpu+90sfcMJOR1ZzAni5PGR0qpfn7wiN
 62NA9Zt1W0vee2NVpLGrTrMksStkxS7SFeR54WytwJc0lmbxnkCAyuueUMs6xCn39VBD
 wo1UzsgteKqA/SU3LuJvKZ3nYi/9HfAyHQO91KzrHYv5+eybp/eavWbMcew9hHJzXg4X
 kKAFM8e5JLQa43OznJHRlwIri4MX8EKWuz9mpd6spd8uDHivSVvTMlR2E95Yor4BGSxC
 Mgzg==
X-Gm-Message-State: APuU4Z+zpWhCzf0VQsIIVbVV1DmdZdxtf+q0Q6THBcnFZ2PIk6t/4563
 1HfsvZmseDyxsNu+/5MtCQU2Hpcr9UAn5ZRPMyJ4PaDSq0QTb9rKMJIwjA347QVSJtt6btZQjuQ
 6HrcEsXQ3iNzGTZ5WD98iYuOdx9pITgGcRhpmrfQNGpZYNsNnAiblTGcy
X-Gm-Gg: AYBFou0FxavLiOXEClKJgLTe6zAMYWxOsQ5XaDnxIahVMvAKCzHKRX891nf/tP13+oz
 4UPCtTHvCuSmdlAhAveYyGbFIKLW4b/aMAJhFEFV+UAzJ1Dc4GrY8evl9np0hmZNlbJ4wC3TIne
 iXFlM7++45D20aDPtkbCTEADscJTpVKk0ZACDbLPJqu1fx5eR7f5FPCLoPZwiAC7Hw5tVh+uTP2
 3G4ZLnYKyz7d1mgNy5qTPOCJasBYI3Xdp2nMQTseIIGf9IJ1WyeoZuD0hM895NBIfTRSuEygPcC
 JDLogLmsEjFsHZUj+iiZW+LVVIdGyLZpjVEsZy0wzwZXcWWTpGJM+VFbOVAWO9X59jiiY4E2x3q
 vWudU4X9W0MA8fATg0lfetueedGPGK6TLq9DgK/Iu7tKL
X-Received: by 2002:a05:622a:64f:b0:537:5488:a633 with SMTP id
 d75a77b69052e-55d76aec896mr77754641cf.70.1795211209772; 
 Fri, 20 Nov 2026 13:46:49 -0800 (PST)
X-Received: by 2002:a05:622a:64f:b0:537:5488:a633 with SMTP id
 d75a77b69052e-55d76aec896mr77754371cf.70.1795211209302; 
 Fri, 20 Nov 2026 13:46:49 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d7888fb27sm32585641cf.25.2026.11.20.13.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:46:48 -0800 (PST)
Date: Fri, 20 Nov 2026 16:46:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <awC_yIo72p5CfjSV@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261119145311.1144878-1-peterx@redhat.com>
 <awB9TbgTzxvPBeVk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awB9TbgTzxvPBeVk@redhat.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:03:09PM +0100, Kevin Wolf wrote:
> Am 19.11.2026 um 15:53 hat Peter Xu geschrieben:
> > Hongyan reported a possible use-after-free of RDMA migration code:
> > 
> > https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> > 
> > The issue seems real, while this patch is a proposal to fix it in a simpler
> > way, meanwhile it should be a problem to the yield_until_fd_readable()
> > helper in general, so it should make more sense to be fixed there too.
> > 
> > The problem is about the use of the stack allocated FDYieldUntilData where
> > we must make sure after yield_until_fd_readable() returns it's not used
> > anywhere.  If the coroutine yielded can be entered from outside of this
> > helper (fd_coroutine_enter()), then the aio handler might be installed even
> > after yield_until_fd_readable() returns, and that makes the stack variable
> > accessible by aio codd, even if stack gone.
> > 
> > Fix it by moving the aio handler removal outside the handler.
> > 
> > Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > Cc: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> The fix looks right to me, however now FDYieldUntilData has two unused
> fields. I suppose you could get rid of it entirely now and pass the
> coroutine pointer as opaque.

Indeed, I'll respin, thanks both for reviewing!

-- 
Peter Xu


