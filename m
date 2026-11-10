Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDFB606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=GoeaVioW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TR6l56sz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQZMQ-0000Jd-Dt; Mon, 09 Nov 2026 19:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQZMM-0000Ii-Nv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 19:05:10 -0500
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xQZMJ-0004fB-RL
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 19:05:10 -0500
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 088FB14001CA
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2026 19:05:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 19:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794269107; x=1794355507; bh=UM/DSR/8Cg1wJ8kbD0HwUDspzf2g5AQ/
 zNQR9/e1w+8=; b=GoeaVioWctrkVwjMev4kdkqwThcfsWGX+hFfzq/E2Ve1dNkl
 RERQnl39uKSOXKZRbFsZWXii3bVH4mU67KRPVdVjh2l4oN3sxwVBxamTiVCookhX
 xH7LE1JDehCgZhZK1x5Bi4yhD2ONndFb+T1Z1wm5meODLTQytlhxtXTk9XXw/Qgk
 HmzQog1v0kbl+XvGxJcz3oMlZziSBaifPLNXDgBSO20FUJXScgOzFSUsq7+wTo0n
 Z3rFM6/DLkZl1+sUUlFK4cCrf38qyqo8EzxWOoGHvWsordn/wnek1ywig6OSZaL3
 2vHl2xUP72s3Bnw2CgzC5/AAhJeSQeyWwgM0xQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794269107; x=
 1794355507; bh=UM/DSR/8Cg1wJ8kbD0HwUDspzf2g5AQ/zNQR9/e1w+8=; b=T
 R6l56szUKSwpHCvSmL6ZPiCMb7+qedXhNCGokMD3Ec++h0CleGLY901/xODrAhsY
 X7Dj4aXfrXrfEXgxlcIuxyjzzKG9CmdYVFohAPzM/wubC9GpHEbDj7xaYakSPIPc
 1KM2lVoFHQh8sWh+KDI5zWp7uQ0vJioFwK/U57mVF8r/hN1mYGVn/a/TuCx51npo
 kcgf5d1bqsLNGRw4udxYPEgtzg0xNBOcE/q5JvJwYre1yrHs9EtMvmXhiYE/nEln
 TwwsJL/lZOboveIvxBc6WqQN17iAQmXjlfmgxdnSB4cIZVayZYMR/fLi9+wdI961
 r8TeFCFAIzQM2cwjrWywg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794269107; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:L1eI2gxuGFTG+hsYfBGEamERqBAdxgzgvMc4/vOkCAb0U6x
 Ysd7lKW+IvronpZhpp6W/z19VUiRPIMBBwRskc56a1UOylVlPaqvqCyxPb59hB3F
 9/f7xVKC1iSMvlMrcnBBm2zhbPhpM9+UDu1U6No5zsJjZorUGQC4Z0wexzKIBJxT
 1vPS8xQu2FlstiSzUPapYaC2FBtCovdvPM3oem/F6jyjWj7wDMHPzU3pyU/vecWa
 2JjnX21UG202Yblep5VEgPrwWldfPggvlnece//yhl9TYFa57ykdbmqK3U+bcVPY
 b6OMWm3aE8sOhyvj7Wp5kALMNYDc1a5XlDVHzLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:kQEkx5frAXRuXICeRqQPs8aW+U4bMb14Hru8wsvCrkE=:UM/DSR/8Cg1wJ8kbD0HwUDspzf2g5AQ/zNQR9/e1w+8=;
X-ME-Sender: <xms:sl_yapdqUys64jEUt56y1gnFMCnQH82Y_7MwakwLf1L4FpFkNHHmuw>
 <xme:sl_yanrCHatQz96Xef7uP4rKbmMICUoyQQHGZnGb5G1X_d5KM_KCd4m2OyTxLVPsM
 AWa9wmiQsEBrciFqdWUutdMEvSdOoxbH75pyXXbTf7ByteR1AcpErE2mg>
X-ME-Received: <xmr:sl_yajNm5HU0UzRoGURK-Dwz8bGANNdpRGZhaOmV7iWO5Si1AeRBRsrImJlXT62VV3-elwZBrpi9NqFOTOptS6f4F3g>
X-ME-Proxy-Cause: dmFkZTFN5Jh44tnMMokq7e7/hocnKEeNXC+BJSuGtz7oLYtq0jnmHS7E0fWvpJfNSgkSQu
 eGDIiQDIcrVhnwZd2BsAbnFGOrPNowNey1so3aOZ4M4sFu0YrZHVtukV08IbBq9HadYoqt
 3MFeHZ5ehnKajIbG2xtOvUt7XK2bPdklrvD+CHHDWi1GhY4S23Z5ug9QhiMQjBDnPDX3sN
 FfT8+By2PhBSihjf2KeZhazxjKGfYqsry6gcDWrJG5UkwVx2Xd42Jtfz3mvNS6SVcV9eRv
 vzyyfNdgH/g0MiGB9wmZItwCkIbHQpVXgsCy7tbRKlhNi3GRI88J1WVJkbjH/iSyz+fgYh
 kWp5ArBK520d/Ab+hOLKDv8WuWveLYR4fEMxFmepS8xXPDoI0ulDuZyr/sufcXT9x3PtfH
 /5ScpW+k4AOQjv2j2fENUgGnYLi8MghLIFzwSTDyjk3/6t/2Rv31mGaMFclf49VH09jkEQ
 L8azoq650iBVhgEyqR/hv80e2CWAneRzo95a+Pi0YnIqY4BN2sCNzADnsU8K0DXRfdGaMN
 zJJtSqv0bgGsTgtP/j+ghUEXANGWF4J3Jn6MGKCwc/vBhbrb9IAwKp9Da4/V8Tci0vB90M
 ehNSemDmNu3bXkR6zaCe6FQ51RADTiFf54NdvaQb/JdHMTdkE/yJDdnwEZ6g
X-ME-Proxy: <xmx:sl_yaqg84U4t5sbJfFHvaaM1EZCxqZeuipakHAv7vwtwPbfnklp4lg>
 <xmx:sl_yamv86wAFpKXbDVrNRFxwk6dxtPnu1rhcKtjBj2KYTn8kgydiGQ>
 <xmx:sl_yauicWxYbwzuH-CCOLQgxWxIttDdWcGyiT9yx3VVGvgEZ__X0zw>
 <xmx:sl_yasYW-AWP6ZCD7b4QKhZGmIhtonTNkUjsfZAXbVZrqSYgEGlLYw>
 <xmx:s1_yamXsJ-ubRQfXP2IHaqvdD1TJg_AD8dphlXOX7p4A9aLhDDJkOJIK>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 19:05:03 -0500 (EST)
Message-ID: <6c66fa550ffedfa79856d17252b02b7b49f36680.camel@alistair23.me>
Subject: Re: [PATCH v2 for-11.2 1/2] hw/watchdog/wdt_imx2: Set vmstate
 minimum_version_id to 1
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Chao Liu <chao.liu@processmission.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Bernhard Beschow <shentey@gmail.com>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Date: Tue, 10 Nov 2026 10:05:00 +1000
In-Reply-To: <20261106163657.3825938-2-peter.maydell@linaro.org>
References: <20261106163657.3825938-1-peter.maydell@linaro.org>
 <20261106163657.3825938-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 16:36 +0000, Peter Maydell wrote:
> In commit d9abd0253be90 we made a non-compatible migration state
> change, and set version_id to 1.=C2=A0 However we forgot to also set
> minimum_version_id to 1, so the state struct now incorrectly claims
> it can accept migrations from the old version 0 format.
>=20
> Bump minimum_version_id also to 1, so that attempted migrations from
> the old QEMU fail cleanly.
>=20
> Fixes: d9abd0253be90280 ("hw/watchdog/wdt_imx2: Remove redundant
> attributes")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/watchdog/wdt_imx2.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
> index f8129625e58..abb8edfae25 100644
> --- a/hw/watchdog/wdt_imx2.c
> +++ b/hw/watchdog/wdt_imx2.c
> @@ -224,6 +224,7 @@ static const MemoryRegionOps imx2_wdt_ops =3D {
> =C2=A0static const VMStateDescription vmstate_imx2_wdt =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "imx2.wdt",
> =C2=A0=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
> +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0 .fields =3D (const VMStateField[]) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_PTIMER(timer, IM=
X2WdtState),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_PTIMER(itimer, I=
MX2WdtState),

