Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA0CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTo6z-0005o4-LW; Sun, 31 May 2026 17:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTo6q-0005np-V7
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:54:17 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTo6p-0002z6-AE
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780264453; x=1780869253; i=deller@gmx.de;
 bh=PyGQKu8m0wDB6rBLiZi6+uPBk1lmFR9FaaiAWJsVeo0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=eAJzDhlxWPTcxMqx9OZKXn/pKdAJEe43VJGb4VoMTKcjw1UKaNf6z+DL8/hoEQaI
 rV82D6Rs0rbvCQiObtzAnWjSpoQnr1yPBfw0WDy/MQca9Q1RWjzMqhHXC8wnutlh/
 5mvEWtkeIt7vIXWXvOChOGe8SQor9oxqCtbPXlJkk+x5zhRsykn+PGb9DWmXGkWfZ
 jQL2laJETXXPlFEi0vTLpBjr4BNjyVSOlnoYNWCz+yp083Tn7v9DTG8Qfujq/y+Yr
 efMjdr6lNIAiOLtLVvG+lvHFKvsW58pl4QQXmZxrvb61pB+je2ldg6QWxzrPCtvrm
 Y+Ovw7XKgDljljMYbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1wYjnr1vHu-003b2V; Sun, 31
 May 2026 23:54:13 +0200
Message-ID: <17639256-c615-40c1-b735-fe3066138209@gmx.de>
Date: Sun, 31 May 2026 23:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] linux-user: Drop hiaddr out-of-range check in
 probe_guest_base
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-4-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260530211248.375318-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:faF4AobuhtAHJdcbFFM1mxXJf5YPB47Hn/wh0Ri+uFSHRz4KXcL
 1nTKnGpxA9MunaI975v03Ojm3jo5hdLm2ZF/xNzWLp5nUTH44grlJPWxMW8Rk06D5ATRpRV
 naCmFsmli5uQ1SsfZeX5SDT5y8tcGNiMfOjjZGd+leb4ziiMnIkHsyEY54Md6Xvs0tDGIfs
 vWeLT9mFbps30aAry2aRg==
UI-OutboundReport: notjunk:1;M01:P0:7tE/HwZG7Iw=;aOpUj1xRcsV1EsEgqLoZg5c/Kjq
 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
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 5/30/26 23:12, Richard Henderson wrote:
> Since dropping 32-bit host support, a guest address cannot
> overflow a host pointer.  This means guest_hiaddr is unused
> for relocatable images, so don't pass guest_hiaddr as size.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c  | 26 +++++++-------------------
>   linux-user/flatload.c |  3 +--
>   2 files changed, 8 insertions(+), 21 deletions(-)


Reviewed-by: Helge Deller <deller@gmx.de>

