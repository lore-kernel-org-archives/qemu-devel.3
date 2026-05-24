Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04150CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 13:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8by-0005I1-Nd; Sun, 24 May 2026 09:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wR8bw-0005DW-K3
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:11:20 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wR8bu-0002xI-Gp
 for qemu-devel@nongnu.org; Sun, 24 May 2026 09:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779628272; x=1780233072; i=deller@gmx.de;
 bh=NfkLNjkYbFNbXAzlhXqqKIToW4H597yZRW12kyYjHtM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k4RtO0F3nUSWLT2b8WSkPW2utD6ISqLm+Xa9TZelDVH3RIcHqbGiZzMyTPN1iasq
 abu70i1HVOxnbjls36Ce44nKfTIQ7WsnLa5x66dMMCULaCrmrce0vAKu0plO98vMo
 ergnkgeb0ITG9u3BUaMqET3Ac6AsmbiGd9Hy9Z/9PnQr8Jbg4ZDr6jJvrEEPS2Pa6
 /v3M20q5y5pnlMQZlC+S1qe6cdhZJVUYGryGct/AfgMShyWTf3H5lEj7eK300MFV6
 yS/CdW4wJt1pvxg7eiwfrGn57nNnL5jhOxtBWfBlTCNCMaR9n7vJMGsN+6kyNNhri
 Wfv9WFHIWTGk4bY18Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mxm3K-1xG3fa0bYE-00spX6; Sun, 24
 May 2026 15:11:12 +0200
Message-ID: <6ebbb129-7aaf-4ed9-8ad3-4e2dc08fe545@gmx.de>
Date: Sun, 24 May 2026 15:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: add VDSO support for sh4 and sh4eb
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260523114128.2468754-1-mattst88@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260523114128.2468754-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kI6QxZI6sDPZ7QIzHKlmXuwAHhmny+GKLLLO4n4E7XmoyS9SPwC
 RsBl6vi/KAIaGTkocllcf2EqJCaEqEV7XfkQu/g76vScd896fLjDVgsntkiuEZh+Wx68Hif
 C1mU0hVMzQAG1YCrotslESTIVNhxoHihOvKwnxeG37OniyEkfQOsDzC7AM0kE8s6BQXtwaD
 /CRPAXBNyWE5/mNmWk1EQ==
UI-OutboundReport: notjunk:1;M01:P0:xt19q9FMusU=;Bjw2zx939TEl/l//wzbKERD93Uo
 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
 gmHWGRcoxlzoplbruAsrLBd9AwQ=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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

On 5/23/26 13:41, Matt Turner wrote:
> Provides replacement VDSO with sigreturn trampolines
> (__kernel_sigreturn, __kernel_rt_sigreturn) and syscall stubs
> (clock_gettime, clock_gettime64, clock_getres, gettimeofday).
>=20
> Both LE and BE blobs are committed and selected at compile time via
> TARGET_BIG_ENDIAN. The BE variant requires an sh4eb-unknown-linux-gnu
> toolchain; sh4-unknown-linux-gnu does not support -mb.
>=20
> CFI register numbers follow GCC's SH_DEBUGGER_REGNO:
> PR=3D17, GBR=3D18, MACH=3D20, MACL=3D21, FPUL=3D23, FPSCR=3D24, FR0-15=
=3D25-40.
> ---
>   linux-user/sh4/Makefile.vdso    |  18 ++++
>   linux-user/sh4/elfload.c        |  14 ++++
>   linux-user/sh4/meson.build      |  12 +++
>   linux-user/sh4/target_elf.h     |   1 +
>   linux-user/sh4/vdso-asmoffset.h |  45 ++++++++++
>   linux-user/sh4/vdso-be.so       | Bin 0 -> 2704 bytes
>   linux-user/sh4/vdso-le.so       | Bin 0 -> 2704 bytes
>   linux-user/sh4/vdso.S           | 142 ++++++++++++++++++++++++++++++++
>   linux-user/sh4/vdso.ld          |  67 +++++++++++++++
>   9 files changed, 299 insertions(+)
>   create mode 100644 linux-user/sh4/Makefile.vdso
>   create mode 100644 linux-user/sh4/vdso-asmoffset.h
>   create mode 100755 linux-user/sh4/vdso-be.so
>   create mode 100755 linux-user/sh4/vdso-le.so
>   create mode 100644 linux-user/sh4/vdso.S
>   create mode 100644 linux-user/sh4/vdso.ld

I added the missing
Signed-off-by: Matt Turner <mattst88@gmail.com>

and added the patch to linux-user-next git tree.

Thanks!
Helge

