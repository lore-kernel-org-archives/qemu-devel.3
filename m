Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C89C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 23:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlx8E-0004UA-Ab; Mon, 20 Jul 2026 19:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wlx8C-0004TL-VS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:10:41 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wlx8A-0002OS-VD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 19:10:40 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id A9F0F1D000E1;
 Mon, 20 Jul 2026 19:10:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 20 Jul 2026 19:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784589034;
 x=1784675434; bh=KTaAJhWi7Q9Nk6wASCtu744XKidiR8U0DC0k8LyAb1E=; b=
 Hu2aKyudPWNNDbY4oVsX8NUp5MHZBweNCDR7hkrjW1lGZMhQw+GzJl12TU/GXtYV
 GEV3EoU+GG2egouIuwVZ8s9DNLu++QFfjKsTylGGqJzKCC0ixHlTZzYg4wTQd8TG
 2ANbEMNNvj3G8tgtiNk7G/btlcvOVleFlDjwm9NbtlQneiP6XN0rVRqskYzGLHZC
 lU5+I1To8+t1X8cDkUI5nJzldEaDKnX+gnpQJl9GvaLdcryN6eprHS5914S5Xbcz
 Yq2GxZQaLo3MwZtWFC7zV2I7ppjdxSdHQAickKBgdtHDS6/TfRPrf2o0nlbb3xpH
 2OCjXQbMDyaldsmW3h332g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784589034; x=
 1784675434; bh=KTaAJhWi7Q9Nk6wASCtu744XKidiR8U0DC0k8LyAb1E=; b=X
 0R6iZou5tXR66F2c9WnRWzUwqUv6FOV488j+0T1kRNjUQI7CdF17ht2Ejj8PYbZY
 y61y8pVUMWDlTCYYz60dO0mTOxRc/EVChu2pHcZroJu1i0cn4eG7HBK/O835dpII
 8H3EkgZdFEA7f0skgTYXDRPt7cn1ozcD+ArUlOkx5HbEcQW88LQaEA4PmNrvDl+3
 bIxOkoeYnj8vTY9cYCOozPfAf3B9D5TQsdvY/hn1nknw5XA4fpvN9Hvn2mnxGGCz
 CkWUQnawjF7cs+i21TK4ORsu19FPiLwT6NpjLWdPXzBNxi12q9NlWBLSkaLpDG2o
 91BfqB6s2WuOm9YYoDuug==
X-ME-Sender: <xms:6apeagkjUrKVJ2C-co9LsJIzwvp36TZCVEQRyVUP3F5NUfZBhiP4ow>
 <xme:6apeaky2S-C86xoze9Y9DiNi-kGvubw8wA5hJ8LFdtSuPe2NWzxjxeR8jFJwPHglj
 pE0Ddy_dsfEc0oo5xw4h3ulBxTtoHhTT3QEPTLk3mhgHeZzxPmKfg>
X-ME-Received: <xmr:6apeai4Wlf0qtChfh7-7Xl_oFVsJIfP_IFg3sFkYgJoUatD_xyskS2EcH40>
X-ME-Proxy-Cause: dmFkZTE0FmQyjGWuj5X1bj6AfZ51WYSRjUzVtmN0JYqFINX2lfF96p8DOnBcjl6eVVvBHy
 Hn7abI8zetQ6YvIc5DZJj5jCCCVadTun2QeafP90/U99+UjvpzC8daMlXobRLChO3uQv93
 CoYUClxOwurrSTxU7eY1XH9nCGIoe/mv3t3loEirZ/yQMXOrMjSOMQLykxzvoJ81sQbXzq
 sCBb/YZ+IuJGjz0NG0iw7RWxhaqD9DX8vly2/UIcauLmq+rmceYReEYI7+gEHx7CTUywUu
 fpupq2KLuEuTJqI1+noGNEoC4rUlBZSfoCsS0I/wjJH2A1Ep2j4DuvymjdbAhzr5AedvA+
 wd8eH/X+d85/Eu2pOOTqQLoDuZGTg4estNkf0UntNiAGhK0O/+YWEHiF2unhP23ZJtbiG5
 krfDbj1WLmXc+J8gB4o+dvOIoGJLRls1W50CTfzOM9icz7rmJKfurLt1NyAL+FP5BdSfMQ
 bVgtAs7f8Mh0wPOGmyODKsGdP7aeXgYxfXGVOAsZUOy9YYQQ2WMZx/CwwZ7/RYiMK8UWoR
 II9p6QlWZzn3328fWEgyTZN2NsL85B1mB4YtNuLKGTrGHlGtiL3s4fFJuF5JmEyB6qn0XA
 KUxGTL08xp2I0yvYxORnyi25eUcp7vwacoArDc2CYLNJ+7gr3ULCtqwTCn7Q
X-ME-Proxy: <xmx:6apeasV7cVJUjMIWeceLZoUIguNGCbW8oDks0tEnjwaTobLbDk4EVw>
 <xmx:6apeaiKtJ8hOzpIjJFsLJn-cjwNvj4EaoyRc6iyNxb8iGvlY9CZ56A>
 <xmx:6apeamsqlW0axGKzS765LWwhZI7Z589BIoleT205QLCOhTEG8rLKRQ>
 <xmx:6apeanJq6QT-PpBLruVxilIR3Xk_eN5j6JvTCRQkh0LO1KpvFwPbCw>
 <xmx:6qpearrOCvYD97ZvyZPkN9Ov8PQmLHDcXshwi0_vYZorZHWnMgmuuUcj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 19:10:32 -0400 (EDT)
Date: Mon, 20 Jul 2026 17:10:31 -0600
From: Alex Williamson <alex@shazbot.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, "Daniel P. =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 alex@shazbot.org
Subject: Re: [PATCH 0/2] build: fix sparc64 host
Message-ID: <20260720171031.259f590e@shazbot.org>
In-Reply-To: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260720221715.27108-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=alex@shazbot.org;
 helo=fout-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 20 Jul 2026 22:17:13 +0000
Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:

> It was reported that build on sparc64 host is currently broken, due to inclusion
> of asm/kvm.h, which is not present on this platform:
> https://lore.kernel.org/qemu-devel/c3a7cd83-7666-40c5-9baa-ebe64edacab6@tls.msk.ru/

Isn't is sufficient just to remove the stale <linux/kvm.h> include?

I don't know of a case that fails, platforms that support vfio might
actually be a sub-set of those that support KVM, but being dependent on
a KVM supported host has no technical basis.  KVM and VFIO are
independent features where neither should have a hard dependency on the
other.  Thanks,

Alex

> Problem is that we assumed in Kconfig that VFIO is available for all linux
> hosts, which is wrong. It is limited to linux hosts having kvm support.
> Since we already have a meson.build section identifying those hosts, just define
> a new CONFIG_KVM_HOST in host configuration.
> 
> Pierrick Bouvier (2):
>   meson.build: define CONFIG_KVM_HOST
>   hw/vfio: restrict to kvm hosts
> 
>  Kconfig.host    | 3 +++
>  hw/vfio/Kconfig | 8 ++++----
>  meson.build     | 4 ++++
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 


