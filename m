Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E375606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm2 header.b=k/Vb7gJR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=hk3eso7N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL8dL-0006oW-2t; Sun, 25 Oct 2026 20:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xL8dK-0006oH-1k
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 20:32:14 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xL8dI-00009m-2R
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 20:32:13 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 6410D1D001AB
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 20:32:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Sun, 25 Oct 2026 20:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792974730; x=1793061130; bh=0hhibPHF8Z/EdWwVa0syzx9bdePGcsy/
 Hgz5oL2rWUk=; b=k/Vb7gJRwm9y0BLUGwqony5pMrC9kmL5OWW7hv20m4MN4ohv
 FDo6VZNBhrikbDuEdomEbS/1rQtsuEjlGBiXL5Hvx08aRqTUSHKON1SAKwCkxpCi
 3Z0gIqO8oDTCvwAr87ohPwe2oCgccHxTjZB5X7A39eeWbo1vPEAeC+G0eciRmAnr
 uGRSv1TbkeT2lAI35xxjNdlguWSyJMP+fbQ2yQKNJo2fm9cstEbhDMKZ/VtzyuE5
 VTczX2RsDcejOrtXVr85e6RDtxw8Tv1t3t+ff/88lozoZXji+KrqjQxwDjOUcwPo
 E7SzoKv5aAVjLhHiZeV9ffMNxvAAjmL5wWcJ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792974730; x=
 1793061130; bh=0hhibPHF8Z/EdWwVa0syzx9bdePGcsy/Hgz5oL2rWUk=; b=h
 k3eso7NAl8KSlr65oowyFOYYUN7nBJSnTqNOCdKkfIBsxG/CJ4nFSYOzZSpZCiZK
 fPK903wysHTaKHUCow9dMi6ysr9rrBH0G/dUM7hvKoy7HalLPyB+kUYJ67nnnS0K
 sG+BHg6icRFmEnSeJyvQKvDy5mUKHf1591J8zqw2W90rZHLA32nK62RObWZQckCJ
 rZNdVEduiRhiMj6Jdr0ix/gFK8kQtWOumWJJWxApceCDDmx+LTa2DApSDXAovnsM
 Z2lfo/tpRAIGIWTYhVe8aaIbrRj0kx86wP3PYUTTKjCLHLdaOc1IfDPxfTKLWja+
 zm2hlqDlbD+0J2iPP9c7w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792974730; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:QQI/yERmvTcOdj/uFlxUqlAY72pQNvJPvV/YIX0AE8ooJPb
 KcPZMWrNsxlCGf51fc6GyVvpVuRJ04//XnNy8x3ol8YswSEdqMRufgqQs5dGYKY3
 lp23MOA28C2RO7iVkez6x9blbM5ZD/ThhT6tC5Pv+jgMkx/qv67B/BMfhjrOMxPm
 rWnhN1gP8ljhw/bC9EJVhfSmzGu5Lusjr6s+jVDGuiSy7bQy0Nhf6b5YNi71F5wy
 F6i7JWGzFkqJro0k9xAMzootmYrjeqjPha3KqxK+ulNvzFHBupBzcXIcd07N2ZJ2
 IajJYyzwItR0iKcekEgDja4So5Gyzkxp1dfTEXA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:h+uNlqkNY1P5zdhpkQ9TzjXv60K6Xk8tG+IWdbkSjlk=:0hhibPHF8Z/EdWwVa0syzx9bdePGcsy/Hgz5oL2rWUk=;
X-ME-Sender: <xms:ip_eaoL1orIIRYhR60tkyFrJgD84mqel9M3zJ7xHvRHIb96vkt69WQ>
 <xme:ip_eajmiY9YZds0Sp3jvNeyFRB388OhV5wHkwmbDIaccUARK70fiZTjSEuD1YgwqB
 QT7rfBeuyVu0ybQ8nM7fAviHiqwbotVau2GJN17b6rmftaYRdCz1g>
X-ME-Received: <xmr:ip_easNbok4kCwzAWyNorIDhZi0Mz8aRRKPiQ7iGcwXCRwQ4AOsLxktrsyANvVJy2HEAXDbjHeqqYQbWJDkf0VfJuU0>
X-ME-Proxy-Cause: dmFkZTFcLqegGCuiXInb+NQUmQuccDdevjnPBLB3gQwiaComrP9MoZXpStV6yFwdrDehj6
 w2D8mSWaBlBuMOczv2fxC5eMpUqdFiNSKrJoa8aWDRzHMCQn5jgx5eU+DNSnrOBSIPvIji
 lZW9WUr16RorgNvTbTkriF+eT78aDkiACTMP5g/a/4JVnXM4qzdVatW24XGeFiByDyrIjg
 GnY1ZycAzbqwpQYavrhJ8sMa4XO8gQbx+HCq1mRPFDYQ0ClOfT7zO31RPH9yG5ti4riFqk
 vsosSe7sKMCUtYfUtEIXrDCObtchlrgI0oh2XUx3rVP1YGi6U5EWBhx0ySYimbGekuweos
 vVaMmm90Rho+ET3vTFBB1XoOtJPKz4prz8jYV/sswn8sdn0ooCMEMYkGXa4ZZdSwfBTarH
 Kwu3ReAA4zypDcRA5aPia8fZiXE+ik3VtL1cUSOsFg+T4BRN7k7Y3mPzfcjX0MeVLAWuQz
 qVslEJ7MSEosDo9jCNe/q3toIciJ9S8jQF6Y/PM7yn+uKYp+F7GjxP0LuOOC0d71TycqOb
 0sspvnrN5RfqBYNsGo3WA0M8ViR9dRtELHUeAgtlKV6sXo8pgTSRGKxhhPPL888g8C6ERs
 vribqVJljwlAVxRzdkEaGlfTvISgzTxAmqf2Qlh4q5K2Vyl4y05fQbRTQXsw
X-ME-Proxy: <xmx:ip_eap0qgyZ1ME2LdtafW_HDxS7xnI-qejbS-D42RTCeHr_BdRADdA>
 <xmx:ip_earnF8E8oKFZNtE7zgFAaYD9Rdg3PshJLgRi9MxH0LrZAsq8dsA>
 <xmx:ip_eagWQVZWRcB_v9UQoAr_4l62hH8oD92MvZfehdylVPVsX7mMmow>
 <xmx:ip_eahuNhMRSRzR5wkPS0OpWtIbMGGCk67IYjhGZTnFArp1i6DkovA>
 <xmx:ip_earUozi4ZasQM_AsdQ974brGGHiS58wa93f-KWMCuCFqqY8K6SxZe>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 20:32:08 -0400 (EDT)
Message-ID: <a70ab6209a22343bc2dd24b6a7cb5cca473381d0.camel@alistair23.me>
Subject: Re: [PATCH] hw/net/cadence_gem: Check guest-provided queue numbers
 in screening registers
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang
 <jasowangio@gmail.com>
Date: Mon, 26 Oct 2026 10:32:07 +1000
In-Reply-To: <20261023153106.1710228-1-peter.maydell@linaro.org>
References: <20261023153106.1710228-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.144;
 envelope-from=alistair@alistair23.me; helo=fout-b1-smtp.messagingengine.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-10-23 at 16:31 +0100, Peter Maydell wrote:
> The Cadence GEM allows the guest to program "screening registers"
> which control which queue received network data should be sent to.
> The field for the queue number in these registers is 4 bits, but the
> device might not actually have that many queues.=C2=A0 We weren't checkin=
g
> this, which meant the guest could program a value that caused us to
> index off the end of various arrays.
>=20
> Check against num_priority_queues, and treat out-of-range values
> as if the screen didn't match (i.e. go to queue 0). (This is a
> best guess at reasonable behaviour since I don't have access to
> a datasheet for this device.)
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: e8e4994313b7 ("cadence_gem: Add support for screening")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4363
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0hw/net/cadence_gem.c | 21 +++++++++++++++++----
> =C2=A01 file changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 39e3620ef5b..9a94b3b8ca4 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -854,6 +854,7 @@ static int get_queue_from_screen(CadenceGEMState
> *s, uint8_t *rxbuf_ptr,
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool matched, mismatched;
> =C2=A0=C2=A0=C2=A0=C2=A0 int i, j;
> +=C2=A0=C2=A0=C2=A0 int queue =3D 0; /* default to queue 0 if no match */
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < s->num_type1_screeners; i++) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D s->regs[R_SCREEN=
ING_TYPE1_REG0 + i];
> @@ -881,7 +882,8 @@ static int get_queue_from_screen(CadenceGEMState
> *s, uint8_t *rxbuf_ptr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (matched && !mismatch=
ed) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue=
 =3D FIELD_EX32(reg, SCREENING_TYPE1_REG0,
> QUEUE_NUM);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
out;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> @@ -974,12 +976,23 @@ static int
> get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (matched && !mismatch=
ed) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue=
 =3D FIELD_EX32(reg, SCREENING_TYPE2_REG0,
> QUEUE_NUM);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* We made it here, assume it's queue 0 */
> -=C2=A0=C2=A0=C2=A0 return 0;
> +out:
> +=C2=A0=C2=A0=C2=A0 if (queue >=3D s->num_priority_queues) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_GUEST_ERROR=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Screening register =
selected out of range
> queue %d\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is a best guess =
at reasonable behaviour in the
> absence
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * of a datasheet to con=
firm it.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue =3D 0;
> +=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 return queue;
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t gem_get_queue_base_addr(CadenceGEMState *s, bool tx=
,
> int q)

