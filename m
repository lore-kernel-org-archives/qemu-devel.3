Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A6606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BCQU5VY3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CGPUw2Qq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnZd-00030X-GP; Thu, 22 Oct 2026 03:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xJnZb-00030D-U7
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xJnZZ-0002zD-Se
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792655448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wQhCg0sBnlirgH28ycMqH3h0HiKpXPdWK4MrAJfxS8A=;
 b=BCQU5VY3E53d41Yb9a4ht65pob0J3T7eRRDDc/MLDrVm9KPjMC2b92ABq/Lx4ngthhELoL
 ZicUbeBt6ZhvvQH/Q/l96KUMUdnXC6NltU5dFN+wgG69YwTiyxXuNtdpj6PKvOJwZxWsd6
 bwtpBpgF2vzZStkgSZj1Z6Q1yEskFY8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-mx9mXh40Nw29KmOPcHgIMA-1; Thu, 22 Oct 2026 07:50:46 +0000
X-MC-Unique: mx9mXh40Nw29KmOPcHgIMA-1
X-Mimecast-MFC-AGG-ID: mx9mXh40Nw29KmOPcHgIMA_1792655446
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1db220b42so14056125e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792655445; x=1793260245; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wQhCg0sBnlirgH28ycMqH3h0HiKpXPdWK4MrAJfxS8A=;
 b=CGPUw2QqzuUdS93nDptraf0EQeCHzqvrkGgAfokYK9zZTxbdPaFM4+Y56/g6xhmAwq
 h22dvJPpRbolyagwGTnHevz8eRGEKKKL8+7disLty+PQNtBMo+3QXeAwSm8/HzK9eU9T
 C3Gn74d4yPg9w1IGIzx+P/kDiMayxF3aXcYeRKOXVa+bhqLtjl/kX60B1SrnUIpu5IXT
 yjPaBlQtXXFz6lu7Cz0QAuwYuv5h/1TXClyGLdZieAoLF66lXx1lJK03D2Y0XegAPPoX
 fFtwI5QZTIFlyK+6OmJZTACdG0hjJy7QE5/kNrcgu/fH7gENNdTAcCY0ZcRqod/bsTuZ
 Na1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655445; x=1793260245;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wQhCg0sBnlirgH28ycMqH3h0HiKpXPdWK4MrAJfxS8A=;
 b=MwvAA0wVV9clN28mxI5QL/7jYcqjHWMu275jOZPgGu+9WU0Q5gFs/jBxdjv/Y79ZnD
 MHVzfaUOpO50Hk1JuTnwqfhyAWIAwYOSVqOxdsJ0djzH7PvniUTpI5W7L8fegUDyFcfH
 AJKb+8igLRQ1UkXf1pTIZs4edOhb0OyHB8cIvJk74EIMwXPkxQsRA5YATbxzHDRyx7dl
 X4S0DwquUBD6q/cKeUTik8zbveQxa04Uh+MnVoNjEDvLBsTRVTDyIvqWRJbrqc/oo9S9
 Ahcz4NN27KQF13d2GWuGMd9PGYNkGPiCQa6zci+dOQR5pdbrAFp5KZZ86/QG+cTkdwZn
 JZ2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0ycIfg7fgDfBmGS7WvBuyHUvYUGWrDQw8nLoXfA86b6LVHVjNen2a+nT2mdeGanafX3EeeuKXErYh@nongnu.org
X-Gm-Message-State: AFq9FYLM6AuFMIIVGQoV73bwN5Mn5vkL/1N6wlr27gt6WLIrN4SnnD/u
 p04fbo2YzbRyLsO1XxoV8wZpeTA8SHB0rtmkKxGUiq1N8xkb6ZRyEppEiMU9sVl7G8aA8V40T7w
 ViMaFgO+61iqEcvy9YNSp9uNJXVSuhqYLCF/yJJfqZcIqhdftLVQRPao8
X-Gm-Gg: AYBFou0wDGuRkVUqCgkmS7svAGjREgITlUtjKP8yeRq2Y4gr0V9ueEFLHfCzpo5pKFd
 rDmaHkZx7ATRMbvgRvX1bxDU0raNNgcaiS95f92qadrcWyPnzF+jdReLfFlHEKqDhcbsZ6ERFuN
 qaJUyckiM5HZKUcADim3uyLlA+jbDTwayDv7AJzfpKEDjMIWxM9W2hflppNthOfiq9EtEHjwmgi
 yxIeV/+sYb3cYBPsxHcj/msTnm/YVWThvDUPeAFxf4rUz7sBwj1LuiUd5PnGN255teXtpLiUMru
 RCyRDtiaqnXD2KhQeFEqzb6RQOm0kA+8AjGCWsA3edGnmE8z8r9wh3mN31wIYb0i9m4=
X-Received: by 2002:a05:600c:4f91:b0:4a1:e0e3:7fe0 with SMTP id
 5b1f17b1804b1-4a1fdd0fb13mr85818075e9.12.1792655445316; 
 Thu, 22 Oct 2026 00:50:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4f91:b0:4a1:e0e3:7fe0 with SMTP id
 5b1f17b1804b1-4a1fdd0fb13mr85817705e9.12.1792655444832; 
 Thu, 22 Oct 2026 00:50:44 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a207b29276sm51776235e9.6.2026.10.22.00.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:50:44 -0700 (PDT)
Date: Thu, 22 Oct 2026 03:50:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>
Subject: Re: [PATCH v6 00/15] block: fix the zone write granularity and the
 zone append limit
Message-ID: <20261022035033-mutt-send-email-mst@kernel.org>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <asT0jpj6n2tLoHVx@ryzen> <atCCxTq-lClE-SUX@ryzen>
 <atm_hGIVewXV2aNE@ryzen>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atm_hGIVewXV2aNE@ryzen>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 09:47:16AM +0200, Niklas Cassel wrote:
> On Thu, Oct 15, 2026 at 09:37:47AM +0200, Niklas Cassel wrote:
> > On Tue, Oct 06, 2026 at 03:16:04PM +0200, Niklas Cassel wrote:
> > > On Mon, Sep 21, 2026 at 04:28:02PM +0200, Niklas Cassel wrote:
> > > > Hello Stefan, Kevin, and everyone else,
> > > > 
> > > > This series fixes how QEMU reports and enforces the two constraints that a
> > > > zoned device places on a write to a sequential zone: the write granularity,
> > > > and the largest zone append that it accepts. It also fixes two bugs in the
> > > > zone append emulation in file-posix, one of which a guest can reach.
> > > > 
> > > > Most of it is preparation for Sam Li's zoned qcow2 series. The first two
> > > > patches are taken directly from there, as they are unrelated to qcow2.
> > > > 
> > > > Changes since v5:
> > > > -Picked up Stefan's Reviewed-by tags that he gave when reviewing v4.
> > > >  Patches that have changed significantly since v4 have had tags dropped
> > > >  (i.e. they will have neither Damien's nor Stefan's Reviewed-by tags).
> 
> Kevin, Hanna, Stefan, anyone,
> 
> Gentle ping on this series.
> 
> 
> Kind regards,
> Niklas

who's merging this?


