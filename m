Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8B7CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcvL-0002YT-9i; Sun, 18 Oct 2026 22:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcvH-0002V5-Hg
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:16:24 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIcvG-0000qj-3c
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:16:23 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5D20E7A019F
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:16:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Sun, 18 Oct 2026 22:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792376181; x=1792462581; bh=nWGon3LnozWfgEpVSbyNk6xdR1C0LjUV
 PYR/K46H5Ks=; b=eYNZclLrkLYILEqAl2H2wHueqtbLWNQUXj6FmBoYr0mNTJxO
 fGoa+rMH3G0lKuo14RJWIZYU8mfnqGT3IxEfDb5urQe78HAr4UelXo3+y4eYM4Y3
 2ROf5CPyRy1eH0EIHgLc7qI+gWEzH/Kwz+K0jMvrLkdRKSiFrzVQwUqefbD6xP38
 L3DDDJXnmpf/1Q2hNWcfOEo/TgM2Dney+MkBPydq+M1Vt/Lv1xfSBCvba+ugvnsh
 2NwhE74mgl8iCKIWJw6X4ki3/b7XzRjXnedk+LCrnW9/JO/T0XM4jl5EgKSfqaj3
 5fUVsRAEDQQvmMlCeNBpSLd52x+jQhEX4xq4XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792376181; x=
 1792462581; bh=nWGon3LnozWfgEpVSbyNk6xdR1C0LjUVPYR/K46H5Ks=; b=s
 Lc8nARyD29CzMs41jJxIkPLzPXMmc9qH1lKAmbRKwBAiP+xgk+Xe8KLlRCtHke83
 tttGDab6eqIZLWpj16Nu0RfpwkaQf3GcWirAdDA5WDRpqpSqtA5LotgIBLtKCMOe
 bkosu2Gi60O6QwOs/jkMRPTRjI5GuMTjLJQxi1yUwxLA6Rr54anoUrqLyqZuF+g0
 gkPZKnDKMplI8CB6lhVhotXWCtN2tCrRD9PDgzjaBJZc9JVgJXIk0JrVF1CxBAIk
 kzD3N0OLZ1ZbKX/82CCgPRrDi4db3COzncLtEQtUVSMunQRjeiikZ2bCIsYbtJwS
 QLg/0a+AdOav0+qsJvY+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792376181; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:FK0TbKSluZyApdyY2ZhN56LH/NhN4MDDD4E8eClnTQstr3t
 AE7sTKx+t2mJ50MRJLvITaBBeC+g1x7J1+7ydIyG41+g7/hkR5L5XYZsDkUjJaBQ
 M8wDbu2D1/DJdeaaes0t7Ie5VVslr2rCXGHjXIwAhXugududLRBEbfZE09OuUJ0O
 yjgXBm6K1G5Phx0wNsy22voF9XWaD6CeQygoU5KHTK76v6L2i2Z24HZtvex2l1xi
 pT5TclyAn0t9Fr0kvJni4lc0FB3ChaB8dEP/nzo/FHzy8hNytGjencHES2oQcI7z
 K/fZkscMMqJnVwkThf5hXpF34IRBMtbxwSUgsFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:uf8u4eqgxeUVhk+RSJT/WvP7PHYgiuLoM8assai1tlo=:nWGon3LnozWfgEpVSbyNk6xdR1C0LjUVPYR/K46H5Ks=;
X-ME-Sender: <xms:dH3VashukTmOm7MMLcsWSkpvJ_APLan-7SVzUfC7L6fcAhzoiv-bgQ>
 <xme:dH3Vav_5A0wQ9Da4C_8K22OK_D0f3u6ngY3V9PUR2ZEY1Rn1e_QMnq_FkloEpJrET
 pXGMoZTIXiqrhp89NelX2KFF92AhojSYYXcYW4iJ9Ppg0DDJWqJpi8>
X-ME-Received: <xmr:dH3VajECaZfTZnPYh35NQQFw4WaTbvDaSAaFhRhi8WnreYUOtw4v7Uv6ScCxM24UIEXvvc6NvAvzpEITqX8hSK57St8>
X-ME-Proxy-Cause: dmFkZTEZVE6g1qXALWmt1eo3gbtprdej/ALQ+cmdeCcmrlCycqzqpoxN0kyhzGW5uG1iEV
 LgittEhIRwy127S1qyK0ipmSdfjGK5khq/TlJ5B9yP0f2HCyzlXg5U9AJDM2qn5kXq9Bji
 x1vfB+finpvokVz3r5suwYZB9ODJtuZ8SHsw8iRZ1ilNLAicHHosL/1NQ3TrKsvmRKbeW8
 jIMBQUoB3t98IgHaVQDdLmZdmeBLVRUNG7Dt5JiZLQMFvKw2himSUant/7CNf7MPF/Vu1d
 VmyZ8ks4d/Kpc3YcM8Vv1BNCyiogD9R4Qxmkf7NSjYQqhgQl715lvLgQq6o8auwQ9c4eWx
 tqH7QLaw7xFBo2EHccKAPwVWH1lRbkgFHRcz7M9xzRxrQ2nROd675ggZMi7IjCNU5k9GMP
 39Fy8V6OobhxxgFISXEy3cttU8AYXQK/oIGmCxi7wfJ68SWMjdvYOXoAClZ+nMdXupbaLO
 OfBLKIIRRe/XEwAoE2lOgZOqc8zDUths87A0d57miOVpecEdytMObpRRd0T0wdYZsEV0d4
 3uSefjoXftd2fj15c40HOjV+oMpttX0UNiXQzPnNRO2+BnuOVve7IHhFn/rVP5x/WOjq7p
 lgeyMsAfAbuMr84O3dkyjRKIFq24pR74VZvmL+zgsIASi3x37yMrG0jj4u3A
X-ME-Proxy: <xmx:dH3Vain5p1GXNNoieMEfdD1juRxXmm8Dnjj_rkbHIflHt5Sqrms3Qw>
 <xmx:dH3VanbIb9m6G9TnKC-REzFxeNpTT-50siSIy6vt1MP-vHyiA5jBnQ>
 <xmx:dH3VanHMKbJlx1fIE29uB7vm_4STmaT6aT5pvdoAnIMeIXHcZk30RQ>
 <xmx:dH3VaoJmWifoNvdP7hm9Q1E0X4HHH2U5ZhM32C_s7oqs5klju9-ZAA>
 <xmx:dX3VaqxtbYrgX0YWMesrXZEwcE0G-B2FJVeKOOfEyUM1bV6MasarT9oO>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 22:16:18 -0400 (EDT)
Message-ID: <c4eccfd1ab400b60ca66d859af8b26b75191e13b.camel@alistair23.me>
Subject: Re: [PATCH 27/63] hw/char/cadence_uart: use correct interrupt for
 TX FIFO overflow
From: Alistair <alistair@alistair23.me>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Cc: Pavee Hui <phui@google.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Date: Mon, 19 Oct 2026 12:16:16 +1000
In-Reply-To: <20261004-issue-4560-v1-27-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
 <20261004-issue-4560-v1-27-ccbef537cbeb@redhat.com>
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
> The TX FIFO overflow path was raising UART_INTR_ROVR (RX overflow)
> instead of UART_INTR_TOVR (TX overflow).
>=20
> Fixes: 86baecc3e435 ("char/cadence_uart: Use the TX fifo for
> transmission")
> Reported-by: Pavee Hui <phui@google.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/char/cadence_uart.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
> index ae11caa11b82..c790372e98fb 100644
> --- a/hw/char/cadence_uart.c
> +++ b/hw/char/cadence_uart.c
> @@ -351,7 +351,7 @@ static void uart_write_tx_fifo(CadenceUARTState
> *s, const uint8_t *buf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * us to here.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUEST_=
ERROR, "cadence_uart: TxFIFO
> overflow");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->r[R_CISR] |=3D UART_INTR_R=
OVR;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->r[R_CISR] |=3D UART_INTR_T=
OVR;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 memcpy(s->tx_fifo + s->tx_count, buf, size);

