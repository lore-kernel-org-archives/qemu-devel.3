Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8979DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhvW-0000lu-3A; Thu, 29 Feb 2024 10:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rfhvQ-0000ky-5Q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:02:21 -0500
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rfhvM-0006xS-OZ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1709218930; x=1709823730; i=deller@gmx.de;
 bh=oIxtWKgHew4g8Wu27W9dB3ENWzFCgL3RwzSHeRfRXOM=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=tlJwGMG39GyWTuUhMS01GlmiA25ZTnri5PE+G8Xdh+DkjEhNwF0N8iVip0weAHks
 UHIOccuePtB+vVcsiWVr3+S9G3BWMLjiaRVZpoQlDj5QUArQi8cluuHI0h6PDxvnt
 WAoEHMPleVfqicBunLvklOpIScJrIi0/X4Bf5/I7bOdlnVlGo+3YugoYubz71GkNZ
 t+vkMpGJ6b0KbRMI5nvxiCSgLqHN+E5xjras0/1ez+34bNPIz2zPyOpCwIN5bHxxA
 dZ9ZWaZ6GnxxDKEYWIfRRbfKC2mwdNH7fCnxSsslDQhjzYzjzz1ezkuJy2YmoMIhA
 FU3gsl6c5xpArXSNYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTzay-1rFxpI2K4g-00QxUK; Thu, 29
 Feb 2024 16:02:10 +0100
Message-ID: <83e2986e-3c80-4cf3-93ae-5e578051c98b@gmx.de>
Date: Thu, 29 Feb 2024 16:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] disas/hppa: drop raw opcode dump
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240229140557.1749767-1-alex.bennee@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240229140557.1749767-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+e0Uw+aWflVIqNlSTgzqNY2uQyMlDWDReWczqxcAIUKXybO+wp1
 hB5Jx4AqJULTtuK1SOz7nzRqt8d7kIVoCFj0fJF/GINNS0LZv4cwBI5Sg321rRryyuGhKjJ
 3NW+gnxpWQtpheuyq5fSCZCY5yGeNLeuOE4FudkheM2XY5U4zkUf+tvfhR+IdX0QKJmkT+i
 Y7eTl3b8jmt8m64PnZrUw==
UI-OutboundReport: notjunk:1;M01:P0:wnlMUdD2H24=;bMveiKYzLO7JCgLq+kTweks2q5j
 CYe19W2j4PeSTJt+w+PXY5d+17s9qrMcTFJSq5LyBQU2R2OmkmG1P8KLm2+aFkhY8ajJ50+rH
 ud5hxj33ibIs+++Rqx9Sfv33+UJzXTAHSgXjgI94w5MAaAYs8Cl0/i2L2iRt6ar2WtipehUkc
 r30G+x/WLunm1K1n/rteAjgh3UOXMfeb7yrWRsumG514MYZH99O//DPyk5IukkRvfOogSctm0
 rGv8o0vRhHjMO2ARL42UlPWharIdBRAYpFq8zo1M381WkEEPUJX65aGea8LGtnKH0jrPErwpY
 Sec/Pun5W9ZHHel0bAZXHgPCYk6PfVhBn/tqDFDvWFYqXEfV5le7dzqq80yXWcYjD+UnrvSMh
 YeUWb5/4V2jZ9NRuTy4BgF+6hAxvpr676QgoPFiE1vkVYXX8q5z4rwqVdTjyn+ooKrxHtI25f
 vhm1yimZAr0+zXwEvwJElH5ftlHmTFyZiGBtFx/s39/yPjrusBN6NNogOGv2/7EXA8nMIRxdm
 O/X6sEhuwU0WrTltHRbwGbXhmij2aGGMGFf/mSQITSP5cbe6RbBjXghtH62WufzSrH/N2yc6E
 UxrBNY8wX8ENonWBRd4QIH0HXfM8sjHTFs0RiCjVyg63cmv8ewkKGIa8IoVk5X97csNLI80d0
 NIVnc3T3bCVV9jUt0sHQ1aG+Ip7O1i9elsTc4NQaPC/6H2KSMM+3te1n4Ei4XCxhWJS02z9SE
 5Nv/5IDJSsxBV8NXZgMklHUAcbykBxR9/d5uECylD/ezoHm+crdTcfge2bek0juDiyW0/pYgi
 EEfnToZAPpaY/J1vB6mMkpE2wKHeu3ny4Wm8sdeaEIzMw=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/29/24 15:05, Alex Benn=C3=A9e wrote:
> The hppa disassembly is different from the others due to leading with
> the raw opcode data. This confuses plugins looking for instruction
> prefixes to match instructions. For plugins like execlog there is
> another mechanism for getting the instruction byte data.
>
> For the sake of consistently just present the instruction assembly
> code.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

This effectively reverts commit 2f926bfd5b79e6219ae65a1e530b38f37d62b384
("disas/hppa: Show hexcode of instruction along with disassembly").

Sad, but Ok.

Acked-by: Helge Deller <deller@gmx.de>


> ---
>   disas/hppa.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/disas/hppa.c b/disas/hppa.c
> index 22dce9b41bb..dd34cce211b 100644
> --- a/disas/hppa.c
> +++ b/disas/hppa.c
> @@ -1972,10 +1972,6 @@ print_insn_hppa (bfd_vma memaddr, disassemble_inf=
o *info)
>
>     insn =3D bfd_getb32 (buffer);
>
> -  info->fprintf_func(info->stream, " %02x %02x %02x %02x   ",
> -                (insn >> 24) & 0xff, (insn >> 16) & 0xff,
> -                (insn >>  8) & 0xff, insn & 0xff);
> -
>     for (i =3D 0; i < NUMOPCODES; ++i)
>       {
>         const struct pa_opcode *opcode =3D &pa_opcodes[i];


