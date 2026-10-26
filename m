Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A688606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JW3NYg2z;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tWg/GPCB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLOyZ-0005xk-Vn; Mon, 26 Oct 2026 13:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLOyU-0005wX-8t
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xLOyS-0003cx-KH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 13:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793037547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zJ5rprRLDqINN5NDBqG3azDXo/BcTvq7GIzsj8nA0U=;
 b=JW3NYg2zY55FErKyiMKK4cDfc2E9h7fIIUSma9LLdjWBM0c7BArHl0hG+5K+RE/PoEAohR
 jpXwgFJgsuqcQ94rK0OcAR2YHy0f3z9A2CWNuHNU7NqfqMPelVL2tx7IFKQzkoVi01Sm5c
 LWhGTA4w5ms9Pl/jTBe268mdBkjfxzM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-9sErcuiiOzKJK-MF8DRGKQ-1; Mon, 26 Oct 2026 13:59:06 -0400
X-MC-Unique: 9sErcuiiOzKJK-MF8DRGKQ-1
X-Mimecast-MFC-AGG-ID: 9sErcuiiOzKJK-MF8DRGKQ_1793037546
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso116966566d6.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793037546; x=1793642346; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9zJ5rprRLDqINN5NDBqG3azDXo/BcTvq7GIzsj8nA0U=;
 b=tWg/GPCBneRmcAMARcrYGBJPC0qiJUQPLQE/D3E+hUFTaeB6ou/sgXT9yylwtwrzgm
 8nf+mxZXTvogAl+9asIQzfpEeoBUIpw7q4PvPxuEA9edzQpYn2VOeIr3kYyXiEN3Hlp4
 oxkf2KWrH1gd+Pz/zkk5Jj3M+y4cDMEFYcsLXnJ2SGv582nmZOMoe0PlIEqHAWmYQCdJ
 e1AdBNHz67vtYCpeXcEKCocdI6nsFyD3WtJqO2tQm3ScftXGo1K2hskOqeTaD6l5QjaF
 Wu9/Hsxdo3AvWeteq4Akhc6n0n0eB2ZZP+O/+b/rKKmySujIQxdjK1T/i5gmkaEIjdLH
 GEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793037546; x=1793642346;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9zJ5rprRLDqINN5NDBqG3azDXo/BcTvq7GIzsj8nA0U=;
 b=1q7eJWo+mVQCm5aA8LyZoCJXhVCBk7jcp9m3WYkBgNmJnrblXj+rsasI01uvFEuyUc
 qspf5X7E1XBFrP65VQfQRLs8uUtUKc1QiUwXAlJMhsbkBW7GTAw0wLgYXl/q6EscPFUV
 vKAd+8wNYLRAjivwQ5TYKXfmJPjZ0Clg6+/yJrQ47ZlR+3wO4WvTEBHgQWEPSFo1SjAN
 P0WbGnXQw+XiqWsias+K13b+QbsESqi+8/QFlXcX7O9sJ0Qf856vnrNEiF03rivEk6ka
 CPwDGerDkz31EQBL9YhSxYbIcyVk5YgKiA4JMGg4IgFlgFVyaKZqwjHY9MNlmM1dHvra
 toyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiCGNFYUSnRawJhshiRqHzzQp9iX6dWn+RNMr+y9N2uuCewTZ7laCLqvAURpua3h08uVnrSwfkN1FI@nongnu.org
X-Gm-Message-State: AFq9FYL0PQhhMFqfHUwELXElvIrQQ0IzZVQKadWHtUKtGr3RcgiZSUVG
 oqMW8w9HXdxo2df2ZRcuKzMUUARik5WHE0dtH8aFzddZR+ATa/V8tzTrzGt2yCZKe04f5q3qqdD
 WDWzcYOjD1yVx12tFmmlg0/g3lS1THr9chp2x0NKhpLwGcmyRWJGeIatJ
X-Gm-Gg: AYBFou1/BlkLnOqxYL8cXUEx/ZPFWIPzNznkgASmYbJVvOgqWxM8TgweCpwN422F5O6
 2IXGD0W4vg/BSte4ZKwddIaZ1n0YX6Ka4BYFmBQGS3OqK3DoKbwe1sLgEa3GGo+CRwMSZLcsjph
 1EO7cKyjjY5P+i0SuT6wkGVTRqvE/VZKqR5YiYo/y3kys/ZLZHmRj0JLQ0AtqcR+f9IBoWXwFPd
 OrtlESFX1KpMQHqaOGs7bNLfxwya8yDs4Gd3FjLLyS8Fwh5zj2Gfwag8vtP8moBinY2uJloadVA
 LLEgXcAgfKkvRMbs80aQQK8r583Op/3U1Vh0XThLOpuONBfg2pmSk1foN8zR74CaOud+tsI=
X-Received: by 2002:ac8:5750:0:b0:535:7b01:1ac7 with SMTP id
 d75a77b69052e-5383b35036amr125684751cf.6.1793037545608; 
 Mon, 26 Oct 2026 10:59:05 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:535:7b01:1ac7 with SMTP id
 d75a77b69052e-5383b35036amr125684141cf.6.1793037545010; 
 Mon, 26 Oct 2026 10:59:05 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-538394f82cfsm60335581cf.13.2026.10.26.10.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 10:59:04 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:59:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH RESEND v3 0/7] hw/nvme: lift IOV_MAX limit in DMA path
Message-ID: <at-U5wQHWpZTamYy@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261026-align-nvme-mdts-with-linux-v3-0-a33bd7c32df9@samsung.com>
 <at9AJGxUZvRoBrBw@AALNPWKJENSEN.aal.scsc.local>
 <85edb886-aa9a-4fab-a60f-ba73e00f7d25@kernel.org>
 <at-UlkpzVjYpu5hO@zhexu-thinkpadt14gen5.rmtcaon.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <at-UlkpzVjYpu5hO@zhexu-thinkpadt14gen5.rmtcaon.csb>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Cc Stefan & Kevin, for real.

On Mon, Oct 26, 2026 at 01:57:42PM -0400, Peter Xu wrote:
> On Mon, Oct 26, 2026 at 01:39:58PM +0100, Daniel Gomez wrote:
> > On 26/10/2026 13.03, Klaus Jensen wrote:
> > > On Oct 26 11:11, Daniel Gomez wrote:
> > > 
> > > I've been holding out on this because I'd really like an Acked-by from a
> > > Memory API maintainer (system/dma-helpers.c).
> > 
> > Paolo, Peter, Philippe,
> > 
> > Can you take a look? FYI, patches have already been reviewed by Keith
> > and Jesper early last month.
> 
> Sorry for being late, and sorry in advance if I won't follow up this email
> as fast.. due to other things occupied.
> 
> Personally I have some uneasy feeling on some changes. It involves
> DMAAIOCB, which is not part of what I familiar with QEMU at least before I
> read more code.. so please bare with me if I will say something naive.
> 
> It seems to me patch 1/2 tries to fix an issue specific with
> qemu_iovec_discard_back(), which I would raise a few questions unanswered
> myself:
> 
>   - the existing qemu_iovec_discard_back() was introduced back in 2014 in
>     commit 58f423fbd5, with a mention of fixing
>     /x86_64/ide/bmdma/short_prdt.  Then if patch 1 fixed it up due to some
>     regression, first question I have is why it wasn't spot by unit test.
>     Maybe we missed some test?  Or others?
> 
>   - qemu_iovec_discard_back() alone seems risky on its own, which is the
>     fundation of this whole series: it directly drop some ranges that we
>     mapped, which can be bounce buffer.  Now, we only fetch bounce buffer
>     from the raw HVA pointer, which seems fine if we only drop partial and
>     end of some bounce buffer.  But could we drop the whole buffer (causing
>     bounce buffer leak)?  It just seems slightly tricky, after all, the iov
>     is the only thing dma_blk_unmap() later relies on releasing these
>     buffers.  So if we want to fix this path, I wonder if we can do it even
>     safer (doesn't mean these patches are bad, so really pure question).
> 
>   - for patch 2, it seems to me it's only fixing the case when discard
>     worked in the middle not at the end.  Then IMHO it's a bad idea
>     splitting two logics: can we somehow put this together with the discard
>     logic?  Would that be cleaner and easier maintainable?
> 
> I added Stefan and Kevin, as this is very block relevant.
> 
> Thanks,
> 
> -- 
> Peter Xu

-- 
Peter Xu


