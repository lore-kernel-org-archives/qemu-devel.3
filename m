Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103BD606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zTPapeXn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMKTj-0005G2-Lb; Thu, 29 Oct 2026 03:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xMKTf-0005Ff-Eq
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:23:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gessingate@gmail.com>)
 id 1xMKTd-0000P5-Ax
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 03:23:11 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so18244945e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793258587; x=1793863387; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jZAFTthNhoufn3UF/BJMq8cQ8lVVnd0qTh1IEOPGtZQ=;
 b=zTPapeXnFtPgWVbzmZ/ys4ZDSqBYlmFfZaGONbUuaSAoobRQLhYN6U9YgeGa9JdbVk
 CKK6AuI9Y0UjI6bmWcpFS6Fch1NP3vrC9fqW9oVvQNXTj+qNXyzTe7cCdnZJac4dTRfi
 q5fvTw003FZxAUa04/f035zSCzFpuNjIfwVqZPGKdo3yb4Txx3mg31RN7YwFj1Q/liDd
 7epKUHf3B18CXY2K799OurP43YQx2SrwzO3imQA6tyHhbtc/xA45jLz7uOK5xE4tiiKN
 evbe6fus/LG8nDDzPJZv5pOx9+4/6nOaqLtMGmjZsVGEMGv01+VEABUWQ1JfE9g86oOk
 hvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793258587; x=1793863387;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jZAFTthNhoufn3UF/BJMq8cQ8lVVnd0qTh1IEOPGtZQ=;
 b=1r5OE+EPyJ9OP/+xOS9y4O5jDiLpsK8Drs1A6x73tF6hHFRWQ9xoQbvQOLpZfPqVo1
 vwn9RzhwTZgXEmcgUepc3ME/m5lZaoViXmj8yhhknLEDGotUNq8Db6WpANqwuwI//KmE
 b6OKHTmlz59W68Fizg3SZtQ6VZ+vd6NhRYaUkgtt3mTLicq+WzBnV0vANHqWPYLgBnKw
 tfeIWoGTskBYk4zyeMGbJqUovAc3ar2nAgCG7TFyEbgqQC7eHkLsO89unol3zTf443YY
 DxbZjfYCoVVMRcnX0RIw/JhZt3EIs0Y2qiOhETiy5mHweG/lrwZ2akUx+uovv5Djl7ja
 B1hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmFLnrJb071A94PtAJaokCU7sYoBs+p0Zfb0BTRO+eKhFF8LYVT3Gb2cLXJyMa8IbJYDB578RP48kp@nongnu.org
X-Gm-Message-State: AFq9FYKlesdJzxNVO2zqT3MFsD0kowbOyTBSrexZF4Bb0bLiu8E0qBfq
 C0HlJKFCq7lmshl85BY0i3S3c4U6Qetad7lP30b5tCf7fSjrInUIzym0
X-Gm-Gg: AYBFou1deKrIwGOyQVwoB/g1PSFUlVLfNto78dLZioUWzMsm7X/baOYP2LvJcqhs2OJ
 UL61KFSt1Q6flWpeojRZIPdZYkKGYsRMcldPxXAuXxy29ME2ehZYiQn63DkT8K0sWd9AjP7DEe5
 d2wjUZUD2nxRiUe3SPKgrduai21Fq4aUSei3jro1r/4kRC9k9lECE9aTfw+xe4c2OiUABrYAZua
 oogzJYYnsmy9V9jmxt19PA3ci7UcxFWbSj7XB0atO48GG/DP5sT6JdiwOsmHNQUFjtkrAyUWapy
 1DhkNjFsqfygeCL0di6LaV2EPhceHeYDPxTclxF33A6aDfnm3/IZhqJ5KjRgc6oatLWGFYh+R2i
 TtY+qX0MrTQOQRuG22uKTyCN5zdprt7rxG9Ci543otXZAlpCOArd4SwBDb12xW4DRJCau4jYhdd
 nauFgotjVIGdf8s3hxiMbIja9isMbsH+T6cNx+MzcDSkqYVFlEIkBdqR8+m6gAdLfF5x5GZFolC
 p6+rXhKkVXVaNJhWlFzm0SWalxIOxjHNkbOeVAzuy9UlEhgBbx+x7vUeEkP7iOA4rrelvxYfs3N
 U+ycNUzOXOxZ8YWNivmGfCih6vMXa1MYOpay95PJt31sn51eqhHr8bQ4BDBLOPJ4IP0=
X-Received: by 2002:a05:600c:1987:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4a965dd31e3mr94194945e9.7.1793258587392; 
 Thu, 29 Oct 2026 00:23:07 -0700 (PDT)
Received: from [192.168.1.89] (95-24-99-141.broadband.corbina.ru.
 [95.24.99.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a966a56abesm67839885e9.0.2026.10.29.00.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 00:23:06 -0700 (PDT)
Message-ID: <15aa908814cfe5e3fd3d0ac4c7b3bd043b28df36.camel@gmail.com>
Subject: Re: [PATCH v2 4/6] hw/i2c/aspeed: fix buffer transfer in non-packet
 mode
From: Timur Maksimov <gessingate@gmail.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Kane Chen
 <kane_chen@aspeedtech.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Date: Thu, 29 Oct 2026 10:23:03 +0300
In-Reply-To: <SEZPR06MB736293095EFE3149F167A71DFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-4-07deed1dff60@gmail.com>
 <SEZPR06MB736293095EFE3149F167A71DFC6E2@SEZPR06MB7362.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=gessingate@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jamin, you are right;  no driver uses those modes, and I can't
verify their work at the moment.
Do you suppose, that they don't work? Are there issues with them?
We can exclude them from tests, but  buffer mode is important for old
chips like AST2500.

On Thu, 2026-10-29 at 06:33 +0000, Jamin Lin wrote:
> Hi Timur,
>=20
> As far as I can see, no ASPEED Linux driver uses non-packet buffer or
> DMA mode for master transfers:
> - i2c-aspeed.c (old register mode) only uses byte mode; the address
> =C2=A0 is always written to the byte buffer register before START.
> - i2c-ast2600.c in the ASPEED SDK kernel (new register mode) sets
> =C2=A0 PKT_EN for every master transfer, and the address comes from
> =C2=A0 PKT_ADDR.
>=20
> Have you verified this behavior on real hardware? Which firmware are
> you running that uses non-packet buffer/DMA mode?
>=20
> Thanks,
> Jamin
>=20
> > Subject: [PATCH v2 4/6] hw/i2c/aspeed: fix buffer transfer in non-
> > packet mode
> >=20
> > In non-packet mode, the first byte of the tx buffer pool contains a
> > device
> > address, so avoid sending it as a data byte.
> >=20
> > Fixes: 961faf3ddbd8 ("hw/i2c/aspeed: Fix TXBUF transmission start
> > position
> > error")
> > Signed-off-by: Timur Maksimov <gessingate@gmail.com>
> > ---
> > =C2=A0hw/i2c/aspeed_i2c.c | 11 +++++++----
> > =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c index
> > ff6ef6d23a..510758fb7a 100644
> > --- a/hw/i2c/aspeed_i2c.c
> > +++ b/hw/i2c/aspeed_i2c.c
> > @@ -382,7 +382,7 @@ static void
> > aspeed_i2c_bus_recv_dma_pool(AspeedI2CBus *bus)
> > =C2=A0=C2=A0=C2=A0=C2=A0 SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX=
_DMA_EN, 0);=C2=A0 }
> >=20
> > -static int aspeed_i2c_bus_send(AspeedI2CBus *bus)
> > +static int aspeed_i2c_bus_send(AspeedI2CBus *bus, bool send_addr)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0 AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(b=
us->controller);
> > =C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -1;
> > @@ -391,11 +391,12 @@ static int aspeed_i2c_bus_send(AspeedI2CBus
> > *bus)
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg_pool_ctrl =3D aspeed_i2c_bus_pool=
_ctrl_offset(bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg_byte_buf =3D aspeed_i2c_bus_byte_=
buf_offset(bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg_dma_len =3D aspeed_i2c_bus_dma_le=
n_offset(bus);
> > +=C2=A0=C2=A0=C2=A0 uint8_t pool_offset =3D send_addr ? 1 : 0;
> > =C2=A0=C2=A0=C2=A0=C2=A0 int pool_tx_count =3D SHARED_ARRAY_FIELD_EX32(=
bus->regs,
> > reg_pool_ctrl,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX_CO=
UNT) + 1;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd=
, TX_BUFF_EN)) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < pool_tx_c=
ount; i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D pool_offset; i <=
 pool_tx_count; i++) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint8_t *pool_base =3D aic->bus_pool_base(bus);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trace_aspeed_i2c_bus_send("BUF", i + 1, pool_tx_count,
> > @@
> > -633,6 +634,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus
> > *bus, uint64_t value)
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg_intr_sts =3D aspeed_i2c_bus_intr_=
sts_offset(bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg_cmd =3D aspeed_i2c_bus_cmd_offset=
(bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg_dma_len =3D aspeed_i2c_bus_dma_le=
n_offset(bus);
> > +=C2=A0=C2=A0=C2=A0 bool start_cmd =3D SHARED_ARRAY_FIELD_EX32(bus->reg=
s, reg_cmd,
> > + M_START_CMD);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (!aspeed_i2c_check_sram(bus)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> > @@ -642,7 +644,7 @@ static void
> > aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_i2c_bus_cmd_dum=
p(bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0 if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, M_S=
TART_CMD))
> > {
> > +=C2=A0=C2=A0=C2=A0 if (start_cmd) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t state =3D aspe=
ed_i2c_get_state(bus) & I2CD_MACTIVE ?
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 I2CD_MSTARTR : I2CD_MSTART;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t addr;
> > @@ -686,7 +688,8 @@ static void
> > aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd=
, M_TX_CMD)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aspeed_i2c_set_state(b=
us, I2CD_MTXD);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (aspeed_i2c_bus_send(bus=
)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (aspeed_i2c_bus_send(bus=
, start_cmd &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !a=
speed_i2c_bus_pkt_mode_en
> > (bus)))
> > + {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 SHARED_ARRAY_FIELD_DP32(bus->regs, reg_intr_sts,
> > TX_NAK,
> > 1);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 i2c_end_transfer(bus->bus);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >=20
> > --
> > 2.53.0

