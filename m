Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3D8C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAH4-0003cK-Gy; Wed, 12 Aug 2026 10:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAGx-0003Ya-0Y; Wed, 12 Aug 2026 10:49:40 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuAGu-0006Ev-1S; Wed, 12 Aug 2026 10:49:38 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id AD7ECEC01FC;
 Wed, 12 Aug 2026 10:49:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786546173; x=1786632573; bh=Bp0u/J1HPcsfCo+dtDZmi9uDiU9rSRDM
 JMKmBOzB0UA=; b=VGtyTqfHnMhQwlOU2AAb75rW7VHyxFl0UQvVGtGbOSM2Hrw9
 tjRQ9Xdnzn80XHmRAHsFslWSFwHz2e/4MVnfk/JnvsPWT0DSBFB+xsHRoz6VOI16
 nTK/FQuMZpGywsNxbzhq9eXMp7P5RFHmBHBYEFcdci8vrRNdTgdwBf9bZWi4aW7J
 vzFZfj2Acu2fhiFmRh+B9ok26mvMSyHryWSpgnmr+jzTgrWAG2n5qlxAfRveyRw2
 /Uc/OLBmaEvdkWzNlkFR6rDrXDT7OhwoECpXn+Tpf7X3UAEkpy2/9+NviFaLETO/
 iTdss+xDrJC72NxKAm+wjyQV6mXCrzB7QCksjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786546173; x=
 1786632573; bh=Bp0u/J1HPcsfCo+dtDZmi9uDiU9rSRDMJMKmBOzB0UA=; b=Z
 i/f9KpTtbTcurquEwsgnw0NRoXtaLOWrtK02j5RMVrMso/ilAwkDeoH+Fxv2LDus
 HUaXeUx666K9txlXeyHWLTO7NUMkhiIs1aW746/KoHDP8zvql6qvcUHdXiTY8wOw
 LLprm8mE6WzDraZVsuPZW/zf4kFBXDGFZFsy7PcPKWNhScgAYtv66QHlBUnfhxRn
 l/tVmauWNX9hVt9cDAXTTP0T8WVxWHwXpp15s8jcFQ/8PRbdFCWXHvNva9EaGZ6j
 0kD21/RGtZfZNCjX7hl3zmFxbS2WaL7MiWMJhW2Y52boFAppg4q4IipK/8h0sTGS
 XpBg4M2ylBMR/eFxwZSNQ==
X-ME-Sender: <xms:_Yd8ar2XBbGdc6KtgZ-XLiwrEWW5POswQhFxNl4ofbJ8KKXz9lFZcw>
 <xme:_Yd8alCIIb1ezAp6JBCuMugIHKvcjHsNXdYW7nsDlrVTLbiKhTQ5mWXXwCaeWC-bG
 amdO2TLMJW1uY91yEtFMStO6uBxVbmg8mfFqSGjaNtcuspquLXls20a>
X-ME-Received: <xmr:_Yd8aq5gh7_EfG03jYltXGLNkpc9w66fc4nB9pzb0kBF0kG4DaW5ur-cQgcRiLkmGDRzZA>
X-ME-Proxy-Cause: dmFkZTEdCXacn7VNZfGMe+3gLNJXPW7rof2QxL+Af6CpHOxePYAI07EgJfkE42XyIIMYIV
 lRMF1NgKUOuWgci452MlUOXt5bbcWC5Jl95cVAkCgempXszDwr3DYc9JGrRUbUmLCxFxge
 FpWhCu5Y07oNP9z1nYYwf66AD1fkEhTV4SRZGBEah0R1WSzgRt5m9MhzKDRTqkoZZwpofl
 sP+UksXWNYg3TcSk2eyKA+aGNiBk55SLMMbWB0XW56lCMB9sy9gJmbNVvfG69zI06HwxAt
 cW7TTZdEl2Sdbl9zO2sN7LazJeR+32FIb+kGQseAm2lKnWCuVC3ulVsIHfeyAcHfV/LKYw
 UcdFZAlZ3Fb2XpMGir2W0F6aVmJAuR1FrBm6r0QxAIh6C57WlNfo7D4USGbd+cFUPfrTp3
 WVoGWVF/KuP/jyc6WePT1RIOCfbVKheCGNtqqEXH0hBd+Wj88B5fKRwcwpQbLgLQY2K6Jk
 RS3KiQxox3bXv96TFq4kkcjfNFVQ9mz2DicM/XAmtGWYvq5aJvPKKnv2y5POuv06BQ9PP0
 yz8W9w3Gjrt7V7u+WcOn3TPBKb22vrPKl1Mr/cowUkcpQncXQ1vcRSy4ceQtrIJ8v4mm9T
 I+iKcvxuBeqGP2fgthGgPGgjmg4ar0hiMDReZ7B1aNq1MmyaXSQwmukGIo2w
X-ME-Proxy: <xmx:_Yd8amKCtjAhNgEOOP-mdi0DMTNqvOB3ZIGRxXoVxdkhfDb_qdm5pA>
 <xmx:_Yd8artrddBxzOq139QuDMit8A8qyR4wjY9I9FUYQ1jVyq0OOeMj8g>
 <xmx:_Yd8atJO3Elov9wvEp8CW3__trjS_cXUcp6ItZ6HqQV1p8GC_mNfqg>
 <xmx:_Yd8as8P624SaCzvjQKxeIW2PW9yRCmQ2NoxcXKcWgcw6V3eC1m0pA>
 <xmx:_Yd8av4Hpv353RU2DCpG2SiM21EJkPwzjrIioZV7_ECjV749W83mwruN>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:49:32 -0400 (EDT)
Message-ID: <4efadb34d8e21daf0c3897d82d7afd0d73b4ae79.camel@alistair23.me>
Subject: Re: [PATCH 0/2] target/riscv: Fix seed CSR sign extension
From: Alistair <alistair@alistair23.me>
To: Ivan Efremov <nendensu@ispras.ru>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, palmer@dabbelt.com, 
 farosas@suse.de, lvivier@redhat.com
Date: Thu, 13 Aug 2026 00:49:32 +1000
In-Reply-To: <20260802113130.7818-1-nendensu@ispras.ru>
References: <20260802113130.7818-1-nendensu@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
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

On Sun, 2026-08-02 at 14:31 +0300, Ivan Efremov wrote:
> The seed CSR value on RV64 was sign extended while converting to
> target_ulong.
>=20
> The first patch makes SEED_OPST_* unsigned.
> The second patch adds qtest to check that upper 32 bits are zero.
>=20
> Tests ran:
> - riscv-csr-test
> - make check: 324 passed, 11 skipped
> - RISC-V Zkr-00 architectural test

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>=20
> Ivan Efremov (2):
> =C2=A0 target/riscv: Fix seed CSR sign extension
> =C2=A0 tests/qtest: Add seed CSR zero extension test
>=20
> =C2=A0target/riscv/cpu_bits.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 +++++---=
--
> =C2=A0tests/qtest/riscv-csr-test.c | 26 ++++++++++++++++++++++++++
> =C2=A02 files changed, 31 insertions(+), 5 deletions(-)

