Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1381BC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuuDH-0004YS-5I; Fri, 14 Aug 2026 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuuDG-0004Y4-64; Fri, 14 Aug 2026 11:52:54 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuuDE-0005cs-Cb; Fri, 14 Aug 2026 11:52:53 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 639CCEC01E0;
 Fri, 14 Aug 2026 11:52:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Fri, 14 Aug 2026 11:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786722771; x=1786809171; bh=0gD56VyifDOJoHCk30eX+LSVWg+cTMBD
 QasUEj5XK5A=; b=wq4qrTbLB8m+Ou81SMiQaMMH/N3TS1MZYr9XxaX/nbXSRQHu
 nGYx7ZmFMESgBCFC+43/zQRbqzopvZ+kVoUG4nTkrmpdBbYMLVNjj8vGUFq2t45U
 OIRxjTFbljzCUQXtzR+GKKJLcYLvYS6qrOuAGZu1Nu75Z+BsAvl1JRtdrfEAztqM
 Ydlp602vbiYmhSBqH8KHEFHUFeKH9hlIL3AfpDMVkYn5jSH0kptfneNxWJ+7+pt+
 ZnzERbAwOA3XqxCWXLhCuO+k3qGAZrZfylq7EyF5gyfEDuhBRVUORecgdcl81K5b
 XOS+5vs06seF1xqG2XCWBD2R0Pr1j5FrlKQMRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786722771; x=
 1786809171; bh=0gD56VyifDOJoHCk30eX+LSVWg+cTMBDQasUEj5XK5A=; b=l
 A+3eEf6FOQ/VPNO8SZTmAKOaIOWCGfeEMk12Rapr0dEhTHFrECA/oI+gJcb65nCx
 x5JPfWIsmCN8vShdprcOA1BPegoUZ2c46GjPyBhzNUtmZrQjLL2loMJtiX/ewcrH
 DoJMtoHEZXzn9ZZY1cY6zdwFFL/NmoH8srki1ak4slJDqqDIfphb3NO1clM+cDU0
 lTklQazhCAib/AoAy5YDFrroIpYav4BCXa/dbljzRk7sgpKSpWewt/Mjxwf7SAon
 Gz2CbpGg4ir24zZ4yUct63y7UD/CE7L/kLuUOFMrG2xMkoIpjKs+Jgv8w0YXeuXQ
 PGqK9fMPLTMVl50WopsYg==
X-ME-Sender: <xms:0jl_ahsf8kNBDgkrjnY6OmyYWwoHP8OxL_013NfkM8de-hVFqCFRqw>
 <xme:0jl_agDgoEA0XxsOmuBeBCinADugu5Qtx3hQk5KNUG9fvAMH5uWRonH_P6MQYVIhx
 aaIGCjB717qfqkVi98LgonCQGKDs-kS5Mr_EQtJ402-_C4nhmyJnVE>
X-ME-Received: <xmr:0jl_auXnEKIqTarSv_YNvXMS9IH2m1iV_R2jTnWb30SkNaFThM7yXrusMYrvoN7Iqkc56g>
X-ME-Proxy-Cause: dmFkZTGsvnB7JPB5A/m7+aqgf7QfMAC3iN5dMoLDySJ6UxxAkqDZnHTxEVTOUttVtFfPXU
 +ch5OHok8XRoAOoboU/RePCsQlD4FikdbcdmbETEYvCGYuT3pBGDKr3wTJtRQO6fnx6NTk
 TtKjVzcMZWg3uuiAqP1SXNZWLJw71H6MPQsbaIBoLR5iRxKhJA2kOdSxmQtNGFEzuanzZl
 WCsx4wbkXYyuDra63+6p2py1jLSZtmz+aPL2OtSP3ga1d7OfcMWH0GE4+du0zjg/XL4hNi
 2CSb7e3vDc+wb90qXJF+slMbE/0qQezdUaHilsy6g+X+NW7wj2EhNblUXUsyf3qmzQxHsn
 E5qMjZt/isSy7Bg7T13lWJhLxDsJNyM1dE5o2ArX2vYnRuC1NDZLDj58LzGNdaz3tvL8dr
 OjThMFd4PLgXK7t4jVobObbXIpE9ubfqfM7YqGUKAXBs2YeupK5jqq1Tzmt5+qUC71/2Gk
 dyh2jeJICPN5duZqvlmq/4s2ZKuIrTW4NVvbpq+kE64891G8iIkhqkevRQ3clJXJMYw99s
 yG+304cA7WTVtDBJUz5c+kTJ4VIXTZCUxQuqQ/sr2C5CPqfPctAfxJD6R85BtUo9+aSt1p
 zDbPT/p8RJdPBRwRVKAFSH2YO+K1Nu9XsGP9rlckGv06XrNPRuNQ9N4FhVZw
X-ME-Proxy: <xmx:0jl_apG4LG50LMhN469fha-jyeYYR09wLyLOPEePItkJ0M7c9BWPTw>
 <xmx:0jl_apP3hHDaKyE_s1EEB0MboFSJkXimQ5T6B4ygGPevTRLFESeCDQ>
 <xmx:0jl_alXH9eVBjh8jMhYog6hjY18USl-V0DdAXga8PzRvguHscKw6qg>
 <xmx:0jl_agx7FwMXt1haCVN7Fntndru3AhPhkE__PARhi1_q6GWuTbZMLQ>
 <xmx:0zl_arfybNOc1UwvtEEsWv9DsVh6Cr2C_uPH1XyRIlZR4Xd89vPiGFBL>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 11:52:49 -0400 (EDT)
Message-ID: <068899e5a13d1fc6fab8052736f143dae187dbdc.camel@alistair23.me>
Subject: Re: [PATCH v3 0/3] riscv: Add K230 DW 8250-compatible UART
From: Alistair <alistair@alistair23.me>
To: Bin Meng <bmeng.cn@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc: WX Chen <wxchen0913@gmail.com>, Alistair Francis
 <alistair.francis@wdc.com>,  Kuan-Wei Chiu <visitorckw@gmail.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	 <marcandre.lureau@redhat.com>, Chao
 Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Daniel Henrique Barboza	
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, 	qemu-riscv@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier	 <lvivier@redhat.com>
Date: Sat, 15 Aug 2026 01:52:49 +1000
In-Reply-To: <CAEUhbmWJzY4qZA6DvTKu3gbP=BEe_Byw6+cpiKEruvVCyL-jiw@mail.gmail.com>
References: <20260808-feat-k230-uart-v3-v3-0-d73b31f0034b@gmail.com>
 <CACPK8Xfgj+AUx0h_46f=qG_UEE_o7kTZ0=Buxr7+bdHDODHpgw@mail.gmail.com>
 <CAEUhbmWJzY4qZA6DvTKu3gbP=BEe_Byw6+cpiKEruvVCyL-jiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
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

On Fri, 2026-08-14 at 14:27 +0800, Bin Meng wrote:
> On Thu, Aug 13, 2026 at 6:21=E2=80=AFPM Joel Stanley <joel@jms.id.au> wro=
te:
> >=20
> > On Sat, 8 Aug 2026 at 12:02, WX Chen <wxchen0913@gmail.com> wrote:
> > >=20
> > > This series adds a QEMU model for the K230 SoC DesignWare 8250-
> > > compatible
> > > UART controller, wires it into the K230 SoC, and adds qtest
> > > coverage.
> > >=20
> > > The implementation supports the registers and features required
> > > by the
> > > Linux 8250_dw driver, providing an interactive shell over the
> > > serial port.
> >=20
> > This is a model for the same hardware as this patch:
> >=20
> > https://lore.kernel.org/qemu-riscv/20260616190147.1286316-2-visitorckw@=
gmail.com/
> >=20
> > I'm not fussed which one we end up with in the tree, but it would
> > be
> > good to name it generically so other machines can use it.
> >=20
>=20
> Agree.
>=20
> Hi Alistair,
>=20
> I suggest we drop the series from your riscv-to-apply.next tree and
> ask WX Chen to respin another version.

Done!

Alistair

>=20
> The DesignWare series IP should be modeled separately instead of the
> SoC version to allow other machines to re-use the same DW IP.
>=20
> Regards,
> Bin

