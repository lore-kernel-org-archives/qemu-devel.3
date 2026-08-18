Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7164DC5DF84
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJRe-0005IB-CX; Tue, 18 Aug 2026 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwJRd-0005I3-Ms
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwJRc-0003Oc-16
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787058089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m4SZw3Ax8GvyzVw8jCVvtD9wvdck5zknYigtMdDIGeA=;
 b=dpR2Eo6sW4H1a2xgtCxt0phg8qqw9gBEkFOZlI5t98kJxW9ipT/VRPV8LpHODWnEhmEs9M
 pq1hbX6QXfbLKYI41soY5f62s4cMYhw5lENgKafulRB2QOmJHVZF8uAMAmDqTNB37pRAqm
 zBU9l3WuJtdKLHrgR9BSGJs02Y7Y2nk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-bd50TXTLPUiP6avGX6WjZw-1; Tue, 18 Aug 2026 09:01:28 -0400
X-MC-Unique: bd50TXTLPUiP6avGX6WjZw-1
X-Mimecast-MFC-AGG-ID: bd50TXTLPUiP6avGX6WjZw_1787058087
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso48342706d6.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787058087; x=1787662887; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=m4SZw3Ax8GvyzVw8jCVvtD9wvdck5zknYigtMdDIGeA=;
 b=Otzhbj9lI6SmZ/XYCucVXLQpjt8uBaLoKplfHyQyHn0RWROfZRcEkuJngSrbUf2qdT
 TKUX64gobOVdvX+HBq5TXqxD99bn7ZHnfscUDQcXu7siJsnIBpKSjqNVFvGwYAxbxRJA
 VpxAuK0uivtAKYxvq7T2/HwSXXg8nSIUz6PTg+ubFPR0VX9giU+lywUisKwRWWK1syEV
 /jFQxfUIEDtQU0bRlWk4QFTfvMbCRMLMqLGDV0Xw6zJCw3i2QeL7PNpjPGGkpwO6FhnB
 J5E3oFVk4ChDUSUKt7Hqyd0bRWqybXhk1VBTH/nHoR7+N4viaik6EgaaMfVlWE2j/xEn
 wS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787058087; x=1787662887;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m4SZw3Ax8GvyzVw8jCVvtD9wvdck5zknYigtMdDIGeA=;
 b=Egv5F9TGdkqvhHvdyvyMG3+S7FgMXJABEKWH1jFCVYd5ztS0z7zGr3WvGJOFScWein
 iUNBVEwnz21JdFzO0Ud9YieLmn6WtSW+L1zI9BdvI2UHmJCuRiQ0E7pEMPsx9ordrHjG
 sAoR9QMngnpYeAqNTNqNskOZjNC7Keq58yC9cGbrMKniDxuHBZDGl2/r24cSGEXOQchp
 GkTAPVJ7Dd8mSFU8BlGI4vhcI6PBglCv3INmcOziyzcFr/34QBmK0Xt5lD/TXWA7S8xG
 oKleZf9E45V5b+sJomVnDNGMfZ1b1dGqDttP08KVfP4NDAGEvbANcc5y6TG33XxHrDJs
 YGQw==
X-Gm-Message-State: AOJu0YynERs2jmRRz0yZttQ5DqfB9866lXLF6J6TTBMXyWY/dGNY8Drn
 WAuaCsW7ZoGiH3y84A/sKCV5nDL3EZxdQMACwKcVoSz3SGYL9ZPlk7AidRWy91PdSkSraYpNuvL
 CTSse1u5e2v4GG4WSpTizrtEyemZS0IJsJqnHysmTGDwTv1eBjbIojyaT
X-Gm-Gg: AR+sD11QRrmCEaIisbH1SDHaUZ16w1KwpNbJuRYQPxNt6b/LTMQC30MRePCHXWdMR5A
 GP7oOcm0w+yvCiJfvEL38o7QtSFnAGrbpoW3NbX84C+GTT5cni0z8VwR9GxEB23628vTyhZtrHo
 K0741pnub7o8Q03jyaebWjSHaN6Hd7lVLR3enQXSHJcC2fBu8WPdMlWGBwSQNw2DTtMLXuYywsH
 oiF8I1k3klT0kF1426NQtBN2O5VcmDaCnXfpabU9B0vojs+jV52dO13DNvk7zYdC9Ree21Yd3dk
 HogJa74ufrIMcwL1Mjnkx1fmUhRaSLhlCrFng8bWYcozzXZp0fXvBTVfLFNni5/3eLmD
X-Received: by 2002:a05:6214:c23:b0:90a:6c34:f8aa with SMTP id
 6a1803df08f44-90a91dbc17amr379857866d6.27.1787058086311; 
 Tue, 18 Aug 2026 06:01:26 -0700 (PDT)
X-Received: by 2002:a05:6214:c23:b0:90a:6c34:f8aa with SMTP id
 6a1803df08f44-90a91dbc17amr379845826d6.27.1787058079558; 
 Tue, 18 Aug 2026 06:01:19 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4580f90csm31587356d6.9.2026.08.18.06.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:01:19 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:01:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <isyanfei.xu@gmail.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Samuel Zhang <guoqing.zhang@amd.com>,
 Fabiano Rosas <farosas@suse.de>, Jack Wang <jinpu.wang@ionos.com>,
 Juraj Marcin <jmarcin@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Subject: Re: [PATCH 02/10] migration/rdma: Remove unregister code
Message-ID: <aoRXk0H1muF_gZJP@x1.local>
References: <20260817202424.2901438-1-peterx@redhat.com>
 <20260817202424.2901438-3-peterx@redhat.com>
 <4d0d08d3-ad6e-4de3-85b8-587b70286b04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d0d08d3-ad6e-4de3-85b8-587b70286b04@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Aug 18, 2026 at 07:57:06PM +0800, Yanfei Xu wrote:
> Hi Peter,

Hi, Yanfei,

> 
> No objection to removing the dead code — it clearly never worked
> 
> I do have one question about the direction, though. The removed logic
> was the only in-tree attempt at MR unregistration for the non-pin-all
> path. Without it, registered MRs grow monotonically over a migration,
> and with large, widely-spread dirty memory over chunks the accumulated
> MR metadata (user + kernel) can cost more than pin-all and even perform
> worse — which rather defeats the purpose of not pinning everything.
> 
> do we still intend to keep and improve the non-pin-all path going
> forward? If so, some form of dynamic MR unregistration will eventually
> be needed and it might be worth keeping this code，or at least leaving
> a TODO to mark the gap?

Thanks for taking a look.  This is a valid question to ask.

Though it was there for 13 years without being "enhanced", it means the
possibility we leverage it in the next couple of years is low.

You also discussed the other side of things: I am not a frequent RDMA user,
but my understanding is frequent MR reg operations already slow down
migration quite a bit.  It means dynamic management including unregisters
will be even worse.  AFAICT, it'll be a challenging task if we want to keep
the performance in bar and add a hard throttle to pinned memory.

Obviously, RDMA migration users care a bunch on performance.

So I see no good reason to not drop it.  Even if someone will work out that
problem, it's still not much code to add, and it'll likely be easier we
design it from scratch with the demand, and without worry of breaking
anyone.

When that happens (if it ever will..), someone should also send an update
to MAINTAINER file on RDMA migration to change it out of Odd Fixes stage..

Thanks,

-- 
Peter Xu


