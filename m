Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539CDC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 01:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi07E-0003od-GR; Thu, 09 Jul 2026 21:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wi079-0003oU-1a
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:33:15 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wi077-00052U-E6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 21:33:14 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 422B7EC0188;
 Thu,  9 Jul 2026 21:33:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 21:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1783647191; x=1783733591; bh=86S4t6+522/DdnyEu09ZoYVPduxoftyW
 lFggEHHMJ2A=; b=PpV6FrLoX/eJUdvXz00cBlx+qPcoQGHQ2hTYxLpWkQ+i5atn
 4OSI3Eo2Zne12e0aGNP19Kmt1Y4NI+LCVdoJM/3RrRO/NRmJ8b+LZnyUViCOXYq7
 LMKK6HP1HCIJl++ugr2yeWBVtc08bvaX883jXCf/9kWBOruLgIoNzf/McpdByAr2
 pyFkyGnsDty2gS+qzq5F5eNA/k9bS8A2o180fw19bbLF30byb+G2r5EdtDnCaPaB
 oNdsM01BPA4l2g1aMqQO7ML2LUkk+lVsLTNsROIff3wN3r2ZrITNoSDI0lPSTnwJ
 XFw6PkJbZFqkZRiuJtDdPB+2Hq81rbpibOhFkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783647191; x=
 1783733591; bh=86S4t6+522/DdnyEu09ZoYVPduxoftyWlFggEHHMJ2A=; b=f
 9LisR+1VL470L2HZAaQUay1mHFqwSWvUl/TpjxuZtz2GNINjJbIaTQZg9E4JsHzK
 FcDYn3fRIqIOl6uOPL/qQNzT5WlNQ8QATHE8y39ldcLBRb1zJJ+S1Ma/vb15m26t
 osuR5lxrZX8GnpDdNS3u3U9GZrfkq78n/kOdbZxCr6zghZNz8ISQgR8O0B0fcXgq
 qNI9CqItXfpM6x/ZAtY48vRJxFaPRRaXL4iQZOArYIZe1Kz3NJWi/Ljqh+X6qBSG
 jsTUoXTMh7Y4UPKsq2nPF6uBxxVMWs1zl/LBwNZvM4UfbKOBs3dHA6KW00rsjkQ4
 lbX0ZRA7dX9NPhRPNb8vw==
X-ME-Sender: <xms:1ktQaryDdBwClb3aAR-RZon08L_c_iufqnE2S2wdpZ948SvTThmOyQ>
 <xme:1ktQaqv2GPfEEC2Wi3WFfvaG3TAiJNtWI81CEYVEHDqRCnfmCSD0LvARupyrJ1wxv
 6w9qG8YWpfg7_qbREt5uu_1D4mS-fXDfdDCNGTqv7mX08XgMvO-FpE>
X-ME-Received: <xmr:1ktQaiuxYIfOoGwgRSliUk73LtLP5w3RVV785szqOitOJjn_5FWf1lfpA05t9dIUQzQTZFa9mEUJVSY-P-ABL14PSVQ>
X-ME-Proxy-Cause: dmFkZTGNhAbXhtYZDSBpaaz8kB7oiAZKH/ZB+87yaXBgVbay6+qrT2iVZmHLfCKHxumMTi
 Lrsn4jj8IL9eI3zIoxIO+WhxtWQ6/KFmktUME0kKaQ2B/BVL7pc188na1JLMTEPRxfC54w
 BlfqcN8HCwv/C95+qpXWwJ2Z8yb1MV7MW064uH5hEaIso73+44tBMFsCxBOcKFRBo2cYXt
 AnZkxSh02TxNDZpqpocN+/KDfGOkFQlgvkYN5LuG6k3bm/seDGBzLGmw/rPF22nBDjISMh
 y0cOsIz6T/4YV1HjecoOLnxkWKeUSyG1RO92zLX6UNEUcVEvMk0QjUjXb/JSS0wlf6rEUV
 sSBQfYlS0ssr7qjvR+ykKTebYT/n4ofLMzL96ah3mUuIyvOkkanDE45kw2VosDrv4gWDUB
 2l6nIQzgeOkvChNG9k6VhQz1rg7pWFgEz7sdsjp2nJTO/6QGeSxlIxy9vqY7pgihIGR7kC
 A4OMKSaBIbffBMFiKN4llRu3O7jyd9lAb4pAyr3TkF/QVk6q0G2ydnVrV6UEWDfXe+sQMw
 EQvpKjB0MNMnyABO4CPbbYUwOCVGmN84FF0dh8jwCx8Qv+VjgboRgANJPSimFB3sGOlVw4
 P0q+2N8hauB3RYuqFTgABvIWiLp5cEG7dCtOlV6UMvB/EhwThAnrLsQs5LIg
X-ME-Proxy: <xmx:1ktQavOUxgkClX_yZZLabrMtpyIxx7zcmMNv6QUparTXzJja4jjTxA>
 <xmx:1ktQag05xQfNL_Uc0tdsUCjFYO8BriOKepJ8JRcDmbEy6XlebESc6A>
 <xmx:1ktQarN5yGi2yJLEa6iR2vRvBEaA2hNb9v2CX2qtI5yG2NVob6bNeA>
 <xmx:1ktQag2tiZO26aCLB717yvS7kZwfvUw5Q6HWvIyXsHrPwCfAu9cxfw>
 <xmx:10tQase-MqUJAZYA8XafK5Zj4zaYsyp8JB92qLC3TykpRL1VQ907PWor>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 21:33:09 -0400 (EDT)
Message-ID: <27787ed097efacf163bde4e1c025307f0acd46b3.camel@alistair23.me>
Subject: Re: [PATCH 3/9] mailmap: add fix for Zhongyao Chen
From: Alistair <alistair@alistair23.me>
To: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Cc: chen.zhongyao@zte.com.cn
Date: Fri, 10 Jul 2026 11:32:16 +1000
In-Reply-To: <20260709080040.4157324-4-alex.bennee@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
 <20260709080040.4157324-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=alistair@alistair23.me; helo=fout-a1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Thu, 2026-07-09 at 09:00 +0100, Alex Benn=C3=A9e wrote:
> Fixes: c24f58d5322 (target/riscv: Fix tail handling for vmv.s.x and
> vfmv.s.f)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: <chen.zhongyao@zte.com.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0.mailmap | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/.mailmap b/.mailmap
> index 9ad072234ff..e5dc644623f 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -40,6 +40,7 @@ Ryan Zhang <ryan.zhang@nxp.com> Ryan Zhang <mailto>
> =C2=A0Timoth=C3=A9e Cocault <timothee.cocault@gmail.com>
> timothee.cocault@gmail.com=C2=A0<timothee.cocault@gmail.com>
> =C2=A0Stefan Weil <sw@weilnetz.de> <weil@mail.berlios.de>
> =C2=A0Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@kiwi.(none)>
> +Zhongyao Chen <chen.zhongyao@zte.com.cn>
> chen.zhongyao@zte.com.cn=C2=A0<chen.zhongyao@zte.com.cn>
> =C2=A0
> =C2=A0# There is also a:
> =C2=A0#=C2=A0=C2=A0=C2=A0 (no author) <(no author)@c046a42c-6fe2-441c-8c8=
c-71466251a162>

