Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8BCCCD18A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 21:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6yO8-00079F-DS; Thu, 09 Oct 2025 17:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1v6yO2-00075T-1L
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:41:22 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1v6yO0-0007uH-7O
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 17:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1760046075; x=1760650875; i=deller@gmx.de;
 bh=c1nWhtUfQGodwy3uGETzyENqy922kM5wcnlEsT3k7J0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sP4OiDyP1dkmRNqwdWJs1FNsGAeLWyaX6fMfMRo5mzcBfEoKeM7Vu+C2PzBF1/nZ
 KkIPMI4APpKXtvTPbASXpYuwQefEmpzERk8Vt+s0mW41WXjHxHNcaoRk3p2jVZVSn
 Y0bGnRjjNmsNBeitr4zKziRvXF4r88OEEQZshCjwL6oecEscIpDT0lB65ztS79F4y
 JwNMYkS6RgMua02hvkLX5OdcYXGfp/rneBFu8MhBy725HmUHW32dywLUOkFdag3SL
 a1gddlbdxCYp3eYQmjfx2XSunPp/JNSwfpPx67uVL3pWatKnxx9xm+ap6bw9E/FaP
 A002j7EryGzTCAR5vQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.206]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1ucbRS2qv3-00lsSc; Thu, 09
 Oct 2025 23:41:15 +0200
Message-ID: <01596a84-80e2-40ae-a305-28e4ec6fc40a@gmx.de>
Date: Thu, 9 Oct 2025 23:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: correct size bit parity for fmpyadd
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Andreas_H=C3=BCttel?= <andreas.huettel@ur.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
 <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <b5e928a2-f4ae-4b24-a2c0-2f67442dff2e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kn5Dql34+nAvU1rx8JgsRCXCMqFwp0HzwxJWJq+LY7ENKZZ5cCp
 M7v3l/ugOq6ATqsUYC4kxMmKXvfqv5o+IK9B4hiE4FCP95lSEhUEHBLPmwqytrLRPQ6i+2i
 TvqKnv9g5RgDE02J/d1is/fs/M4o+BlyxP2s3xhw+Jj9XhEe5acEYH7zV9SKBWKAnArQF4X
 LwWdafebVoXVA+gLWaKzQ==
UI-OutboundReport: notjunk:1;M01:P0:E+CozVtuS5g=;aSBu4EzsQmMIpyB5DcReKeiXJxJ
 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
 4J0GfBg4kLuNwX5la/9ReqhNgE0dVjfvnNI=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/9/25 23:23, Richard Henderson wrote:
> On 10/9/25 13:51, Gabriel Brookman wrote:
>> For the fmpyadd instruction on the hppa architecture, there is a bit
>> used to specify whether the instruction is operating on a 32 bit or 64
>> bit floating point register. For most instructions, such a bit is 0 whe=
n
>> operating on the smaller register and 1 when operating on the larger
>> register. However, according to page 6-57 of the PA-RISC 1.1 Architectu=
re
>> and Instruction Set Reference Manual,=20
>=20
> Annoyingly, page 6-57 doesn't actually mention the interpretation of the=
 f bit at all. However, I can see how the H specifier is processed in gas,=
 and the confirmation of glibc fixes is nice.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Helge Deller <deller@gmx.de>

Nice catch!
Thanks!
Helge

