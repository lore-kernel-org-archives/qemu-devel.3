Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fuI2Tb70;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=JOAw9uIb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOxM-0005WX-Fl; Mon, 26 Oct 2026 13:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLOxH-0005W9-04
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLOxF-0003YO-AQ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793037469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBQf+SBN2CWeMAzI4vgYq77Vzz0sNlR2HiwJYjxfcTI=;
 b=fuI2Tb70Qt1vki5eMS1f/VshHZymY9AKu0WsWqs15+ttSTQjuo4ObWLHQGATxMixVGNIUJ
 agmWAilN4knqk5S4YE3I3dcgyleXJW/Kh5sPkk6FcJrrhHgz5ffZd0uFPLP3VC1m3sdhlW
 +fr0QGBay9qKLboL7Qiir5Pm04oxvBE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-FFoOoHODPqWNLsJihUzfQg-1; Mon, 26 Oct 2026 13:57:46 -0400
X-MC-Unique: FFoOoHODPqWNLsJihUzfQg-1
X-Mimecast-MFC-AGG-ID: FFoOoHODPqWNLsJihUzfQg_1793037465
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f322ef7d3so731836985a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793037465; x=1793642265; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hBQf+SBN2CWeMAzI4vgYq77Vzz0sNlR2HiwJYjxfcTI=;
 b=JOAw9uIbR3w73U4iPPNZVkwSfG8rtikhNTD0t+0PmyVOW9i6qVYt5dEhYwXCp503YU
 kQJmyb3HQ/tCOTdAl1jv+EV/Cga+ihULuf3kNaWGnry0cGysrTecsp4Q/pSbTmnMEZZh
 1FRh5unmKuJ0NXsJQHYt82T7nUMF9bXgEePm8wKFTdxhOcH5uAb+Y/vk4mJCHkmCR1FI
 l825EY/khTUCkFCdhL/57/zI2Oz46jee4olXn7zdx8rrqY8fkBURhfd/6yA4r5v5eqka
 OZEkUJAEgO5TWWXksN553LznA4WC/Lx+3PyIdd5cQsoFqhQmeQzBqr2QET6qOVYCxuCW
 perQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793037465; x=1793642265;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hBQf+SBN2CWeMAzI4vgYq77Vzz0sNlR2HiwJYjxfcTI=;
 b=gNGaZNSRwBiiPYU32dCjt8BnE2kuq09qgopUYSucrb6Zjpt/PwpqiblgwZmqIWUD5G
 ldJx6MUI+Fc6H40Znbrg1XvoNeOOmBqOBBzxoGGBSz5lZVDR4eMRMf6b79L9tD/64v2e
 lqAyOIPObslYUuQIg3QsFOZ+cfuF1aYCAaREriYx36gv1qU/PL7daBPArd2fi8Ze/UQT
 9CnqPiYFxF0DlYbsWsvhXirXr+x18VJQGOh147NNVL8CocZxAJluYWhmxi3GVbrhLzni
 sFn/g3e35RbBfy8ulUXLHAUamTtDKdUW7IdgqlFKRQrDOVXiFOn3gZpnKfX8CE93zpMW
 7uqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6e21wu0ia1kcZqdJXR3x54N5xgmPmuQFxC3+0Ozw1Hfh7tY07UrZ26rkn54lbTlcTsDYM6yfIn2ht@nongnu.org
X-Gm-Message-State: AFq9FYJUNBow56oL9P+uvjY+aNHmoJDvZ0GOCtPPhtdeVcrqhbefiEqK
 qeiaJSb3hcFjJ4M/fF9kdDK/LH3gza21ZI0OIxRrCp2ovIY/ygzUNGGa/kir+NhfQeQCNaH5m3C
 SQlDRcUj1qv9u8YsC1gewtLBUnHribHvkoXO1Df2cfj8bJb3NeniEU+HF
X-Gm-Gg: AYBFou03e0NgglpJd+AbPxc9Ezj/r3j6ZZz0+4tWqsq6AVpCWwP9gIIol3UJX67V6lj
 0F7OOAy4OQOKdtyRGTgPOQy4R4N9IAPP5Fy3oJ8CTyZPcMIxhJMyEd76EohfP9A1ShLN2knIdoT
 pexWD5You1ZL8DUfC8ri5sXF9hx11N/E6GIdGUefxzhA7Zg26TTSbbMjn5QjWUCirz6hUhNhe0I
 0mVX3wVmE94TsYJG9LtQCkvSY8ya4Ld48DfAKtPpKt2nP/s68MEcWRuvxCih2S4USS7fIy+URMH
 XCflZKCl4XOAtQ3R0J8qJ08Iu1IzZJE1aS3b56WEiVmwwgKIp+hLBX8Gvd7+7Dama4Kd4bE=
X-Received: by 2002:a05:622a:1f86:b0:536:6047:5223 with SMTP id
 d75a77b69052e-5383b57287emr125526231cf.49.1793037465152; 
 Mon, 26 Oct 2026 10:57:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1f86:b0:536:6047:5223 with SMTP id
 d75a77b69052e-5383b57287emr125525431cf.49.1793037464533; 
 Mon, 26 Oct 2026 10:57:44 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-538397405e1sm59699711cf.25.2026.10.26.10.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:57:43 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:57:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
Subject: Re: [PATCH RESEND v3 0/7] hw/nvme: lift IOV_MAX limit in DMA path
Message-ID: <at-UlkpzVjYpu5hO@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <at9AJGxUZvRoBrBw@AALNPWKJENSEN.aal.scsc.local>
 <85edb886-aa9a-4fab-a60f-ba73e00f7d25@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85edb886-aa9a-4fab-a60f-ba73e00f7d25@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 01:39:58PM +0100, Daniel Gomez wrote:
> On 26/10/2026 13.03, Klaus Jensen wrote:
> > On Oct 26 11:11, Daniel Gomez wrote:
> > 
> > I've been holding out on this because I'd really like an Acked-by from a
> > Memory API maintainer (system/dma-helpers.c).
> 
> Paolo, Peter, Philippe,
> 
> Can you take a look? FYI, patches have already been reviewed by Keith
> and Jesper early last month.

Sorry for being late, and sorry in advance if I won't follow up this email
as fast.. due to other things occupied.

Personally I have some uneasy feeling on some changes. It involves
DMAAIOCB, which is not part of what I familiar with QEMU at least before I
read more code.. so please bare with me if I will say something naive.

It seems to me patch 1/2 tries to fix an issue specific with
qemu_iovec_discard_back(), which I would raise a few questions unanswered
myself:

  - the existing qemu_iovec_discard_back() was introduced back in 2014 in
    commit 58f423fbd5, with a mention of fixing
    /x86_64/ide/bmdma/short_prdt.  Then if patch 1 fixed it up due to some
    regression, first question I have is why it wasn't spot by unit test.
    Maybe we missed some test?  Or others?

  - qemu_iovec_discard_back() alone seems risky on its own, which is the
    fundation of this whole series: it directly drop some ranges that we
    mapped, which can be bounce buffer.  Now, we only fetch bounce buffer
    from the raw HVA pointer, which seems fine if we only drop partial and
    end of some bounce buffer.  But could we drop the whole buffer (causing
    bounce buffer leak)?  It just seems slightly tricky, after all, the iov
    is the only thing dma_blk_unmap() later relies on releasing these
    buffers.  So if we want to fix this path, I wonder if we can do it even
    safer (doesn't mean these patches are bad, so really pure question).

  - for patch 2, it seems to me it's only fixing the case when discard
    worked in the middle not at the end.  Then IMHO it's a bad idea
    splitting two logics: can we somehow put this together with the discard
    logic?  Would that be cleaner and easier maintainable?

I added Stefan and Kevin, as this is very block relevant.

Thanks,

-- 
Peter Xu


