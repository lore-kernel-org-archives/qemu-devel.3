Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E2CC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVjN-00049u-Df; Tue, 02 Jul 2024 01:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sOVjI-00049I-HX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:07:01 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1sOVjG-0008La-5w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:07:00 -0400
Received: from [192.168.68.112]
 (ppp118-210-145-155.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.145.155])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5A8D8200E0;
 Tue,  2 Jul 2024 13:06:43 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1719896806;
 bh=vp1vPVlgMDoCsZFCuTMnRqrO6bQcj4VVYAccejlXyoI=;
 h=Subject:From:To:Date:In-Reply-To:References;
 b=HKQ4hNNBQ2Vuq8EIN/O8OazlDvWeC5gDJFnWyo46euHeSH4mZBuSH1ykaaqYixgG2
 18qcTbN5tdhbJjiL4hsfZkG23lNgcTy5diaJAx7Sbt1eKkeG7QEhDoFEOK8bfvuO8v
 rn8T6kiGp2s/rUOYKY4e2ShN7TNjBvCotFTHfpedrgS+XNf4ei9Kq6Hn9x4ABa+yfD
 sZZ6pIt3ZUO0HscsEhzI0CGozSZzJkVZqvxsWOXoOMcA3ksCRWSxoZnCl71UD0+IqA
 ZYDnZbTRBdjcXx8cdGD5/v/LdHuIgEqXCvL7t7JFMmdWpU0pk7jAA6XzSvGy4385bZ
 sOi0tOgMI7g/w==
Message-ID: <e1a6b93038e67271fc0bd9efcc7d40802cbbede7.camel@codeconstruct.com.au>
Subject: Re: [SPAM] [RFC PATCH v42 90/98] hw/sd/sdcard: Add experimental
 'x-aspeed-emmc-kludge' property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,  Jamin Lin
 <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Date: Tue, 02 Jul 2024 14:36:42 +0930
In-Reply-To: <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-91-philmd@linaro.org>
 <4b55f817-0e29-45c0-8f56-f997f34e0e97@kaod.org>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2024-06-28 at 11:16 +0200, C=C3=A9dric Le Goater wrote:
> On 6/28/24 9:02 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > When booting U-boot/Linux on Aspeed boards via eMMC,
> > some commands don't behave as expected from the spec.
> >=20
> > Add the 'x-aspeed-emmc-kludge' property to allow non
> > standard uses until we figure out the reasons.
>=20
> I am not aware of any singularity in the eMMC logic provided by Aspeed.
> U-Boot and Linux drivers seem very generic. May be others can tell.

I'm not aware of any command kludges. The main problem I had when I
wrote the Linux driver for the Aspeed controller was the phase tuning,
but that doesn't sound related.

Andrew

