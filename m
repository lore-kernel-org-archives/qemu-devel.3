Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE7DFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzBf-0002az-Cs; Thu, 23 Apr 2026 14:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wFzBe-0002an-Cx; Thu, 23 Apr 2026 14:54:06 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1wFzBc-0008QY-32; Thu, 23 Apr 2026 14:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1776970442; x=1777575242; i=deller@gmx.de;
 bh=eFgSlvKalDeTkkDZsKFNIZ2eX6GANa3HMRpkEDCsoyA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=SsavlJUk5XTwt+jnA9ddtbl5IsnpdjRfNGLq4/8vuGQLEnA+lDa0zbxnmPYu2aU3
 LfRwJe/UqWaHRQJtV9h0AZY3NVlCC9vTyPof1Wmjm8p2OXXyRv+0iNiSVJKeJ5HaP
 Jff0YuW+IVD1QWrh+sIt1YCU5k0ZTlJgPx/Gh/GUufpjyAOAZXpEAugvW1sRKXKFb
 i4xOTj0bbFtvnakuT9AYpOCGjtYOqyjLpyuVDsGwuW1+kIzNfGvPMH3gu/OHL/q0T
 cF4ewnJzPNE0wv8ghxXsCa0iM/8wgBuHc7ZBaJbJzdVbjrATArNVYA2QvjmQGyFOy
 bYoUV4JD+SrccxZfJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzQkE-1vTfrN3p4a-015nEj; Thu, 23
 Apr 2026 20:54:01 +0200
Message-ID: <9136e278-f553-4ebb-aed0-ce2e0a2e2a4f@gmx.de>
Date: Thu, 23 Apr 2026 20:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0? 0/3] linux-user/arm: Deprecate nwfpe
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260413230251.22537-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260413230251.22537-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YOTJ3fDC4J1wlOiFZJ81OXJ/o60HRzzbvCptalVyACyC3bRx626
 MLfc+lVZpmD/Gd8xCP3HZuLkLCtfSGAncRosb6A7KHd//HL5PSU9mhuoD+VCrh3bkwrKofE
 TJoptfS9GmXV7sMndGgAdsedSXnoP8qIrjstqWbz9XTlZ72SEzd2qdrf+uHWimaidPdJYuA
 nAOvWaVbK0qGUlarkn9Sg==
UI-OutboundReport: notjunk:1;M01:P0:Toe+ByFvfqY=;05C12J0el5B8tqSLUv2yYXJaSux
 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
 x1fqcgefEdWCEeA==
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/14/26 01:02, Richard Henderson wrote:
> Deprecate nwfpe emulation.
> But while it still exists, fix thread safety.
>=20
> r~
>=20
> Richard Henderson (3):
>    docs: Deprecate linux-user/arm/nwfpe
>    linux-user/arm/nwfpe: Replace user_registers with current_cpu
>    linux-user/arm/nwfpe: Use thread-local storage for qemufpa
>=20
>   linux-user/arm/nwfpe/fpa11.h | 25 ++++++++-----------------
>   linux-user/arm/cpu_loop.c    |  2 +-
>   linux-user/arm/nwfpe/fpa11.c | 12 ++----------
>   docs/about/deprecated.rst    | 12 ++++++++++++
>   4 files changed, 23 insertions(+), 28 deletions(-)

I've applied this series to the linux-user for-next git tree:
https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dheads

Thanks!
Helge

