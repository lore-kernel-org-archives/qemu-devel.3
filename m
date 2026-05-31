Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA370CD6E57
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTo31-0003ug-Ty; Sun, 31 May 2026 17:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTo2y-0003uS-SQ
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:50:16 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wTo2x-0001ko-Bq
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1780264213; x=1780869013; i=deller@gmx.de;
 bh=cWzV3i2AcI8gEEUbgNGJ/fti4SFr4WM4MxHUHWVAAQ0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jZwS5rBauVGlmuPB5k1TDB1S8PBNYp7NNwaVMYPrsI92F9VMPkF2P/LP9MhO31UU
 HjMwow6W5fb4Txvk7nSHBCbSwO5/XzVjEvVXTw3PYs4XEXfgMQaFSbohAL0mLm+6e
 h6aE4rGCBVT2P+FIMBSPsRc//UHPQP9CsjkGafalzI+GTWYI0NzabxPPvvNNsHAop
 26OfWLxP+KSV8fUlNRO4kZMWeUe5KLS9JPfgKMuV+ScFvSZ/vHKuhEG/T0p2MxWrD
 /ey7t0a6fkVil303xCZquvYXZpVO2NBSJxrdoVxD3uZQBIeZdAufF+oU5kHQmISkP
 Afj6CYJxqY0ZFy2Sdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1wneFo3z6e-00TmYG; Sun, 31
 May 2026 23:50:13 +0200
Message-ID: <430726c4-999f-487b-b94a-f3e254187c5a@gmx.de>
Date: Sun, 31 May 2026 23:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] linux-user: Use PGBRange in load_elf_image
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20260530211248.375318-1-richard.henderson@linaro.org>
 <20260530211248.375318-3-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260530211248.375318-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2eXyJ+zo8G7pEMCYOhRPa+iu2AIrckzYm5tHnW3o52Ecd33KNcL
 W+r3wYpz6MWW30Cy9PJHwCXb4k6HGSKG6d3HUE9H1o2+zDI64Kijo3RPH6NSTqrsgQxRIeX
 aReYHfelev/Escld1yj4ohZv99kkJ6Tj9D9TApI7SCol1rlU7J37k92l7P4MkkA5i4wvP2m
 dKTcW5WHxl0SDemDjgb+A==
UI-OutboundReport: notjunk:1;M01:P0:ilasn5hfBlI=;GeweHuCfBKse0SeVZ3tsdYy8KnW
 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
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/30/26 23:12, Richard Henderson wrote:
> Collect into range instead of loaddr+hiaddr.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)


Reviewed-by: Helge Deller <deller@gmx.de>

