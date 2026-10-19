Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C274CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcvl-0002xH-9X; Sun, 18 Oct 2026 22:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcvf-0002lM-K9
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:16:48 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcvd-0000s9-Se
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:16:47 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 3F9DC7A0189
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:16:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Sun, 18 Oct 2026 22:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792376204; x=1792462604; bh=9noX4PRyMyLjEqjeY2SWhk05KtF3dz8T
 1wMGQ8M4y/4=; b=sLvmqhrNdR66xalam4X2Uac4aNqdq4fJqCxVY5nQn3yUaX1y
 5OFp4zIQsJhjtK8JIFhlvVrtWCMAyCF8qJw8bJlG9bUTupFGHkbSa3SwTxuGbu8W
 aFcq7ZDwJWffqx9A2sNMXCuqyqaWJoP2UQHlh6cTmSKvTWo+8Cz2ganrntt+xNJp
 WeYLxhJ3jX8/9t2tmtTdUhG+1FtAGCAXFKGJtYyp8jm5YQjy9gXxNmQJySXf2up2
 TtEuCVpeH5diHEJEE0Ud/P9AHwKionkGNN0wbYZt7OrrCNH5WA/3MydhqlPIGCB+
 1R+UEsm+TMvmfsMbmBJkQGf/pU7BbCq57dS5Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792376204; x=
 1792462604; bh=9noX4PRyMyLjEqjeY2SWhk05KtF3dz8T1wMGQ8M4y/4=; b=s
 IaF3GKm7CMv79MVPjyvBLVdXLIxT+ND3Aeje2aHPhRLVFH3JW7+LT/YNmUpSm/zP
 GA3YMIu+B9YQeceGBLL1UZ68xt3RKhYWKp8EbkxDBn4gwSqGf92nv7EUQ8+YRE7Q
 PzgteroCXkN0+AInXCXO44ONkp5VUWCcjLGHABnjB/ppnyJ3MxZL1uiNvnvgva5/
 Z0/f2YPHpkBqqJSFY8bV/syGpN94e08f3J7lLwUYPXDp/nfQ8BsjbYPXw6YARCaR
 9l9cOvCNBY6v+QUcNYzB1wHqjEsYh/hSiQCWoTgTUlykGX0M1D8Inn5p5zV3gvLk
 2s4KF6LpywyRd3iqRKcCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792376204; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:XJGt1Yh4qk2ZeGDmn0vWpWEpQn0foyZ7ujcJ0fkpFNEKQBN
 NvbbdQa/JtLQnZa2VXR582JWnv7NUN38yheMezESdkMo5Gs3vvHv072Bg8ySSN+C
 ByoVzG41pgZ+VSj9zl0z5+CAD8Q+mr5WgH+3Ud1ENxHLIjiKq+o99P3MIMOu1wIX
 c6IBp6yRxs8ByFJGBJodYcaXW8VKJ4P/mqs7bKAX2uiNJkuM6avK0U/VHXnFgmvV
 ecfbZZlqi2eWtCvop5Cva7VVvMzmoDxoANqyG7YYpYV/b7/A+9pjQ22I5w3xg2ep
 q23lkUnF/6fLFxnwUkBGGe7R8Xs24xdhOT6GwBg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:qpSKc8u0CiWazQp38spRtCe+qo5Pb41goKNvzliN0lQ=:9noX4PRyMyLjEqjeY2SWhk05KtF3dz8T1wMGQ8M4y/4=;
X-ME-Sender: <xms:jH3VaicGMaOkM3k8NXtRdvgzDoK4NwcoE3WukSsrB5Of9aiAMRDyDg>
 <xme:jH3VanLHipSY2jvyL1C_MdeQEcb7V_r7gshr_6Gr8ZEUNEuc6dBRgVypMZ5JLDgZa
 97DRTzyVT5ctRNYdn9RkDkMXFMml7k2NLQLgvg39sbOWMZsOX6PbC1l>
X-ME-Received: <xmr:jH3VaijOZ7WPR9gkx9f4NkcGrInH89vfEPznzgRDr5Lm74u3gRZRQSvIo_u7Hclk1ZwnyIT-hMemGWMnL2CMyx5EMI0>
X-ME-Proxy-Cause: dmFkZTEZVE6g1qXALWmt1eo3gbtprdej/ALQ+cmdeCcmrlCycqzqpoxN0kyhzGW5uG1iEV
 LgittEhIRwy127S1qyK0ipmSdfjGK5khq/TlJ5B9yP0f2HCyzlXg5U9AJDM2qn5kXq9Bji
 x1vfB+finpvokVz3r5suwYZB9ODJtuZ8SHsw8iRZ1ilNLAicHHosL/1NQ3TrKsvmRKbeW8
 jIMBQUoB3t98IgHaVQDdLmZdmeBLVRUNG7Dt5JiZLQMFvKw2himSUant/7CNf7MPF/Vu1d
 VmyZ8ks4d/Kpc3YcM8Vv1BNCyiogD9R4Qxmkf7NSjYQqhgQl715lvLgQq6o8auwQ9c4eOm
 YQDvRt5Gjjo9xotWMlsTlv8HkyFVgeELRvPXHYrKO+9OztmIqy/Lc9k4s/jyzP/0AHLbXx
 e/1LE/2F3/Kut9mIs+ZhX4Y/OTUMCavkwmWBOc3KOBWZlJMj4CHH5Vo1GX6voDQqisxgI2
 AKqaHLnv0IbHuUpTOrZjIi15u0Dqdvi/iEJ+e3pVG6qBPuPd5CSmlStONg8Xsg2kqA5hoV
 jIyL/aVDBNiEh06hTHYXn6gwuCC2ViXNDlHhVMG7gwoxmmb0FxdtXtURUfGA3reMIHaUCl
 h096papFvNuEB+anbqadXBloWK6xekYz8IbsiCmhtFlM1DV/0ea7uxqdnCfA
X-ME-Proxy: <xmx:jH3ValS7GDzlYwQEJKmPfxhbrOvBKwwZVr8-OBEIejylBOqQeRyiHA>
 <xmx:jH3VasUWiUOhh-dWArcfMXPaEOB7r5X4NwnApvu03aDVgAi7srv2RQ>
 <xmx:jH3VahQeH04ycl4n2rpwNxwYwlpbYmYICXcFm0a3mOz_tlbxjxTz2g>
 <xmx:jH3VaumaapJ6wzMsYl1TtCvv3tnqbLjQ5Mjtd9yQuyDzVMZl_tZ_GQ>
 <xmx:jH3Vaq-mb9dgMEKMgf2HSDlx3msqKkU_k8eFjqiQOErQuwaeyFpVBZ_8>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 22:16:42 -0400 (EDT)
Message-ID: <48fa35f6c80061ec9058c4768d7c314a378898ca.camel@alistair23.me>
Subject: Re: [PATCH 28/63] hw/char/cadence_uart: validate FIFO indices in
 post_load
From: Alistair <alistair@alistair23.me>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Pavee Hui <phui@google.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Date: Mon, 19 Oct 2026 12:16:40 +1000
In-Reply-To: <20261004-issue-4560-v1-28-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-28-ccbef537cbeb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.158;
 envelope-from=alistair@alistair23.me; helo=fhigh-b7-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Sun, 2026-10-04 at 14:23 +0400, Marc-Andr=C3=A9 Lureau wrote:
> Check that tx_count, rx_count, and rx_wpos are within valid bounds
> after migration to prevent out-of-bounds memory access from a
> corrupted or malicious migration stream.
>=20
> Reported-by: Pavee Hui <phui@google.com>
> Fixes: 35548b06cf55 ("cadence_uart: initial version of device model")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/char/cadence_uart.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index c790372e98fb..1a065e2429eb 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -586,6 +586,11 @@ static int cadence_uart_post_load(void *opaque,
> int version_id)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 CadenceUARTState *s =3D opaque;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 if (s->tx_count > CADENCE_UART_TX_FIFO_SIZE ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rx_count > CADENCE_UART_RX=
_FIFO_SIZE ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rx_wpos >=3D CADENCE_UART_=
RX_FIFO_SIZE) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Ensure these two aren't invalid numbers */
> =C2=A0=C2=A0=C2=A0=C2=A0 if (s->r[R_BRGR] < 1 || s->r[R_BRGR] & ~0xFFFF |=
|
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->r[R_BDIV] <=3D 3 || s=
->r[R_BDIV] & ~0xFF) {

