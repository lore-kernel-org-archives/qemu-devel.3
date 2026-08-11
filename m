Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82D6C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsaE-0003cd-Nh; Tue, 11 Aug 2026 15:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsaC-0003by-Hm; Tue, 11 Aug 2026 15:56:20 -0400
Received: from fhigh-a6-smtp.messagingengine.com ([103.168.172.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsaB-00005a-6Z; Tue, 11 Aug 2026 15:56:20 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 678CE1400090;
 Tue, 11 Aug 2026 15:56:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 15:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478177; x=1786564577; bh=cM0If6yg3Qg//yNHoCP7hZK66Ue8V5OR
 pPPVxgyVpeM=; b=ShtbuggCUkaux97KCsgS+Gcg7bN+aNCqOlyl1+AElRl9Litr
 arCowV8Dtaz2ous9yPPUe2vaw/dczuBX9QxDSme97GdTpl5JY3KMs4ocGMxyqd4/
 CZyx3OC0eOFSmU/maZLUfeQw+XH+6qQ09KPPw/3SzYRekObMdPDwgqK860PtVNHR
 1SnznNScgv+8PALxEdpklZ73n9TOrgYPzotk+mUuGFBg37VIDheyPGHpJbWrZ8cD
 /uCxjkps7IOWCD44QZnh6velMMilu4VC7Zps83DoFMkgtOI+XNplmwNHzNcdlSWu
 NJVtzzLrgfK+4hTXfqfyZLKTBNyoLpQPrTaIhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478177; x=
 1786564577; bh=cM0If6yg3Qg//yNHoCP7hZK66Ue8V5ORpPPVxgyVpeM=; b=F
 aagfm3o6LbJ3pKsBS5vk8nJl5obRdIXcT/6MpLF1Xti7+9Z0edPTrQgOQbiyJeJ4
 FesviGqvbgTzvcUqwVrf6ZpYwkrrpZ73Yxz3cfvgZXUNarQWO+T6N+yvvjcukDd8
 lhI2ApInfye7jD7Kcaa7gB5P8gZAkT7fi+tVhqV4MrrgfZgis00cvxL7/P+VfMt/
 tSDzdxMkdhsUmXg6ikWpmeTegeUZ6yo2mLQGWCoKkHHFAZqnB6S68CkD3TP2KJv0
 bqszNxIgxIXtnnBUg+LZIl2DFlm8UqJv+Lz+JgPFVSVLBDPxyQ8D8hvEeQq31nNH
 96E4a9dXdX8Zo6RMKM85Q==
X-ME-Sender: <xms:YX57aihYQKTS8M93oflMYTwbneFpsypByP4hUjhht6aautolSUPtQw>
 <xme:YX57akijGjl33Avd4OZuFHuyxayGyh7VKFWOjmmdsNv2X8UO3K3DguDMDJKTNqAYV
 MG0vQXbje-i4-kPedJdn8mA5EH-zAK9c4QkPHiSpLQRkng6PAxfSs8>
X-ME-Received: <xmr:YX57aqLyf2oQbgnEYloZhOEXXAy_Zw6Fr8L6bSF7v1QZlgt81VC-_9CdMs90FYPHqSD1bQ>
X-ME-Proxy-Cause: dmFkZTGBNhJMEONeF1V7rti1z8/lXN3MKspy3c+ew3Kte/ivpwEKq68c/cZW5HM7DPGp4e
 c5H164NnJLPHewZTW+QmRr4P9vOWCG6Mi1TO8Y3nWxAUvACM0JleLsyKboy1BHQy2BoRr+
 zu+A1iljAQw98JSaI1R1YAgx6ibrg5v7bVN08d9Xo6ac5FRltLEIywCpbHUEA73QKZy+bj
 TXiZA9sHIungXdubfyAzjagCPXVv1FycsMUY82dmon1Txcu42F3qodFdTeqibSHr+vNBSP
 RMiv4XHSCR5gApZp+VazOknQHeSIrxZfz1wEGdrUp97Tty2JnQil3TccE1BCemIoDfoqKW
 BoCDL+gYbutGYvXX3OKRxZFEWSOOGbGc4nBLD0K3TbYUONfcEBX6c9veVnivjO3mCtXo13
 CxAXhz8fdBQDyPM+74dPdVLvhk3ebDlk5r6LsnlQS4WPDmK1yOA6GlENkmDPmOqXrMZiKd
 UW5qNZuu76qj9ULnPYdIpgpBYY3G+gstzRwppRgKyl8a2M6L9jc8bvoNxOkDGLtLI+YvqG
 vLY2UXQ8wLKWSt9YnVWduVOoBfEvF6mFOEwUslySneTYYgMUGraPI5SffKZs8PWCWq7g0T
 7b+YX/OCK6tQXGRepWkoZHlSpHprHdYXLnysI0jERo/Gtn9LgTeEDnuMx4YA
X-ME-Proxy: <xmx:YX57arE0zHm8hauZaJ1Ca0ndjW9bbXlp08AvcFHI6hnfLbMgLzjFXA>
 <xmx:YX57amS9rroXf_veJVc5cmryckKaigDn4EVIwIbbMN9xw8am1lRjkg>
 <xmx:YX57ave8L8I9Mutv88WzYswMTEOA92LUFB-gFIGKTd4-idWyySndqw>
 <xmx:YX57atq5kECUGtP85SplN2FRoe-Qol5cpT6kuBAd60KILbIcSAQJMA>
 <xmx:YX57anzvYiK1LmK15NECTiej_8sPQxaXoKLFX3ekUdnssZjLWVRIv7B0>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:56:16 -0400 (EDT)
Message-ID: <080f0666e61168b9a3f9d7abc3ae75f1eaa0c768.camel@alistair23.me>
Subject: Re: [PATCH 03/56] disas/riscv: Use signed type for vector immediates
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>, LIU
 Zhiwei <zhiwei_liu@linux.alibaba.com>
Date: Wed, 12 Aug 2026 05:56:16 +1000
In-Reply-To: <20260809223545.730664-4-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-a6-smtp.messagingengine.com
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

On Sun, 2026-08-09 at 15:34 -0700, Richard Henderson wrote:
> From: TANG Tiancheng <lyndra@linux.alibaba.com>
>=20
> operand_vimm() sign-extends the 5-bit vector immediate field in bits
> 19:15, but returns uint32_t. This sends negative immediates through
> an
> unsigned type before they are assigned to rv_decode.imm.
>=20
> Return int32_t to match the signed value extracted by the helper.
>=20
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Message-Id:
> <20260703-b4-disas-xthead-fix-riscv-next-v4-3-84c566330bc7@linux.alib
> aba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index fdf75a12ef..967739bdbb 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4487,7 +4487,7 @@ static uint32_t operand_cimmq(rv_inst inst)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((inst << 57) >> 62) << =
6;
> =C2=A0}
> =C2=A0
> -static uint32_t operand_vimm(rv_inst inst)
> +static int32_t operand_vimm(rv_inst inst)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 return (int64_t)(inst << 44) >> 59;
> =C2=A0}

