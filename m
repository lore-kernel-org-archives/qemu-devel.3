Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D3C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PyC-0000p1-OS; Mon, 13 May 2024 03:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s6Py0-0000ne-BA; Mon, 13 May 2024 03:19:25 -0400
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyy@cyyself.name>)
 id 1s6Pxw-0004Kg-Mx; Mon, 13 May 2024 03:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1715584747; bh=vSwRwYi9hyFCPmc9BLgEb7dYEu0fWGRRNdozl5bWeAA=;
 h=Subject:From:In-Reply-To:Date:Cc:References:To;
 b=pHsgVAOz7uj5sPLBsiHWo0qTwAT4KsGoO43P8Ya0lbMG3QwMnJ3l3Nnn7JCmAEFal
 v7S48wDe/pFc3PgYKO9TiF/MevFmP5l3kS2vCYrZwahKaQd44MpxkGnhDCkMta6P9s
 XNYB7S2GhjggklkKhR7nP9DZ/MFIgryClfBsE0s0=
Received: from smtpclient.apple ([2408:8207:18a0:630f:e955:424f:3708:4c53])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 4C3B489F; Mon, 13 May 2024 15:19:03 +0800
X-QQ-mid: xmsmtpt1715584743th0ggrn96
Message-ID: <tencent_8C6C872035C2F071090E689F3ADAE1E2C50A@qq.com>
X-QQ-XMAILINFO: Od++Svt5p/Cha+L0C1WMxGJt5YQ1q2I5mbTnpBoCLeEm0IC2SOY3vlsg3Lnvdp
 vM4sz8XVl0sOox8IZEN1qE/AfsK57glw3FhhRGciH4Y8OFFYo8LRPjPqUoY0ObdSu4Cb6t9koKDJ
 7ntdPl3wV6nkMo1VuVVMfOOOkOucvEbSVOBS3Ybio71Azn18SvByFjIThg6SdUacZvpF+6sFR9a4
 2QHDVvds8CztpsbtGT5RzBx8ZXuLJV0VxvtAWxtPB2t01HI5/oRQ526hUfBNm8VGaqUGJoXzw39w
 5huxXaYbfVlNUOShpKKy3c7bxvibjUMacnqxLh5lqbtCIKk9PrLvAKYJFBUZVCIDWXCv+bNKAFeq
 vsXp26NN78MN4O7sP16P8+/rK2VTRokPAFJPix5roAV9XHjWQZo6dhUzjM60zeI3KMwx5EdGWHGA
 qF5oaDwI2VHwQyqIxxa00vIQoviPt9S0KuLsJeYrnPMGzD72JfyMs7DG/aV2b6ZhzFYBvshOji14
 T7S7kaC9uiRZgHBGfKoGNkkbU5TW4xU8MgyQ+q3MfvwBZjxW3PskyVNkglGQTvuSn7p1B7FmfdaQ
 l41XepB/briC1CnKMtuw/4GmyVS6Cd0AdNt9yMCjqhgRTYEgoKx2ZEwrlCq1gGEiHgJh3ujtPW5/
 ezc5wcRKiQ8uF4+y066rDf6v8Dx5UXI2BvWEr8GMxAV8zdtOqGr0hB2Zr6LM5x0EtsgHfhC7mm/m
 ye8EJtmBQoLj6XYlvsTApFEOf9ujNucP5bWir0gR6kv5bLKyymBL3mxIRCy/dnYrDOwaMrRHDgqX
 MdOG2ZlmsPlJoijC8yAzep/Q19hhYrQoYt0JwyG36C1urlzPVKs+Mlzic6f6JKqhlF8PsssaE5qW
 dDd1hrBU49U/nSaKfgv+sqCaGL7A3ojv+5Iyg7mAwk5xFtmmhZ8RmyKdkE7/HslI53uwcD6B89N/
 Uusp/RdtTqONEGLWb0Zu3ipSXonWDqgeLjpEzCGL4Df61BJ0SbvuA8yKzBSO231VDcbYoAeaEXkO
 UV5kRhZCbFc/XqBJ16TqbVju575qE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH RESEND] target/riscv/cpu.c: fix Zvkb extension config
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
Date: Mon, 13 May 2024 15:18:53 +0800
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 qemu-stable@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <2998C42A-B80C-4B11-86EC-27F6AE2466A9@cyyself.name>
References: <tencent_7E34EEF0F90B9A68BF38BEE09EC6D4877C0A@qq.com>
To: qemu-riscv@nongnu.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)
Received-SPF: none client-ip=162.62.58.211; envelope-from=cyy@cyyself.name;
 helo=out162-62-58-211.mail.qq.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

I think this patch also needs to back-port to stable-8.2.

I added qemu-stable@nongnu.org to cc.

> On May 11, 2024, at 19:26, Yangyu Chen <cyy@cyyself.name> wrote:
>=20
> This code has a typo that writes zvkb to zvkg, causing users can't
> enable zvkb through the config. This patch gets this fixed.
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> Fixes: ea61ef7097d0 ("target/riscv: Move vector crypto extensions to =
riscv_cpu_extensions")
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
> target/riscv/cpu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..13cd34adbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig =
riscv_cpu_extensions[] =3D {
>     /* Vector cryptography extensions */
>     MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
>     MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
>     MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
>     MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
>     MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),
> --=20
> 2.43.0
>=20


