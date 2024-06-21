Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A860C2BA18
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 00:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKRxv-0006BW-NP; Thu, 20 Jun 2024 20:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sKRxu-0006BH-2h; Thu, 20 Jun 2024 20:17:18 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sKRxq-0002iS-Ib; Thu, 20 Jun 2024 20:17:17 -0400
Received: from [192.168.68.112]
 (ppp118-210-79-194.adl-adc-lon-bras32.tpg.internode.on.net [118.210.79.194])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C7CBA200DD;
 Fri, 21 Jun 2024 08:17:00 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1718929023;
 bh=8xdua9NJKnabCVQLyXKwp7FRMc4pNCd8IydECavlhh0=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=FQL2H0bEA5HeIuobAvzwTp4V0jspWN2kgGQsxyDIHomX60pmhJhfov9SfaLbLw0+G
 F0WKr/Z4BJ2u+E4rKpgIDC2i8vo73YZq5dUrhpz2MTiUfcVhejbFxU+w/0i+8NoZGB
 +Lgc0PMb8P5cVopBi06SkG2y3a4ZSR7WzBmFXXOimXut14PzeUVWvoJQ/x3R6nm/nj
 X8+lw9vwK8dOOP8vcdI8dZEgAg4fu0z3WeF4CxyPCNxhAuJXWoJtbX4065BUEnhkL4
 UMjG/YhUav5uo1k7SLonRLB2TAOsxwGRqrI41nb8nMHwpse04HfiGjliqqc9zo35Kb
 ZvJOKzpL9/2aA==
Message-ID: <ff5e7487c71ff6e07e89ac2a53e8b62463703a14.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4] hw/gpio/aspeed: Add reg_table_count to AspeedGPIOClass
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Zheyu Ma <zheyuma97@gmail.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley
 <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Date: Fri, 21 Jun 2024 09:46:58 +0930
In-Reply-To: <20240620140239.375338-1-zheyuma97@gmail.com>
References: <20240620140239.375338-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 2024-06-20 at 16:02 +0200, Zheyu Ma wrote:
> ASan detected a global-buffer-overflow error in the aspeed_gpio_read()
> function. This issue occurred when reading beyond the bounds of the
> reg_table.
>=20
> To enhance the safety and maintainability of the Aspeed GPIO code, this c=
ommit
> introduces a reg_table_count member to the AspeedGPIOClass structure. Thi=
s
> change ensures that the size of the GPIO register table is explicitly tra=
cked
> and initialized, reducing the risk of errors if new register tables are
> introduced in the future.
>=20
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=3Dqtest, -m 512M -machine ast1030-evb -qtest stdio
> readq 0x7e780272
> EOF
>=20
> ASAN log indicating the issue:
> =3D=3D2602930=3D=3DERROR: AddressSanitizer: global-buffer-overflow on add=
ress 0x55a5da29e128 at pc 0x55a5d700dc62 bp 0x7fff096c4e90 sp 0x7fff096c4e8=
8
> READ of size 2 at 0x55a5da29e128 thread T0
>     #0 0x55a5d700dc61 in aspeed_gpio_read hw/gpio/aspeed_gpio.c:564:14
>     #1 0x55a5d933f3ab in memory_region_read_accessor system/memory.c:445:=
11
>     #2 0x55a5d92fba40 in access_with_adjusted_size system/memory.c:573:18
>     #3 0x55a5d92f842c in memory_region_dispatch_read1 system/memory.c:142=
6:16
>     #4 0x55a5d92f7b68 in memory_region_dispatch_read system/memory.c:1459=
:9
>     #5 0x55a5d9376ad1 in flatview_read_continue_step system/physmem.c:283=
6:18
>     #6 0x55a5d9376399 in flatview_read_continue system/physmem.c:2877:19
>     #7 0x55a5d93775b8 in flatview_read system/physmem.c:2907:12
>=20
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

