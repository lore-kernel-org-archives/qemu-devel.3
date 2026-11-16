Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35439606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=mTw70aCT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BaYa06ap
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSo40-0001K0-Ts; Sun, 15 Nov 2026 23:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xSo3v-0001Jc-7F
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 23:11:23 -0500
Received: from flow-a5-smtp.messagingengine.com ([103.168.172.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xSo3t-0002SW-3j
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 23:11:22 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.phl.internal (Postfix) with ESMTP id 9F6071381C95
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 23:11:18 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 15 Nov 2026 23:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794802278; x=1794809478; bh=+HJ1y6Olmcya8nQTGGJPNnVqUC2o8XkQ
 gl+8pDdKB68=; b=mTw70aCT35yuOvJsMmDgBorOZPe79uSyWr2df8/eh6kaSTwT
 vQoOGFM3LVXrzRior1F+OoMJiSg9kXSaNbGfzO6IbnxlxCGtabQ6+OvbR3Ig7UUq
 kLkFUvFnZj9v78amGF4TdY87sQS1jHL3rJqqGCygwS4gOCnhAcbUjn1TsKHGCmbH
 5BK7i1AxuMUJWUYNvH7dGhfCVEJlAkzsxZqkJLjaB3aIzs9HasnEr+DwaHEXQ2Dl
 ZfIhUZzKy6X1gnSJfIwXfovSPdCXwhBfZ8qOsGsdX6WaQUwV5dkrzh87i5nwpj3F
 Uf1vzWcuCQvXN+aSpfNePpuTN+kWqZTGhyIVnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794802278; x=
 1794809478; bh=+HJ1y6Olmcya8nQTGGJPNnVqUC2o8XkQgl+8pDdKB68=; b=B
 aYa06apJsgAztCJAKNrW01V1Gqn/Y9rew2+3IZ9lbz1Egk7I5SEUvc40ha3Vjsxz
 p4pBMVsbge4T+xka5hoZ89RxCjSpK+hFHe6odPOGgunKi/z1fVUKylWJjRMIyO1w
 M42xhhOfKkmF3SYsjZkEV/BrcZnp63G/hNXD26uA9M1elv/ZOz6S8TZhopENzqwi
 ZPBPGwFwVnrsbd8ITUcPTxrlRm6t/UEbUhS1As0gBslKee+BoCxjdFrOqShFbYmb
 hOyyUBWMSOA0eO8axXn8k3oV3Z9etVe7+0mtoNhKoZxmNaJ6/iKXdnVYdgoz/Hml
 Lchf4cx5jCpQ9uq2zyyhg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794802278; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:bZIptQJqLFLupaw6tdh8GSl8i9Z69lSaAiv2YF+NBkcXUcW
 YYyv6qn/NjMFuwVeyAQR6T2J1GI5svI9zipr2em/jQsPtQ65UFo1DrQJA09W++4J
 8KWMt35yPzh67M364waVuUQv/zrkbCYJyOPEUpMQ4fhmLgcDH5wORuS/pTwtErj5
 SoNIykP1DdhEaSUliG+eNkBV24Dh89BgdfoDYUIin9w/ey7TZ5XSowtyZRZbljsS
 vKRfavDlGQxAbLeBfiUfU4OUDtkew5NEcHYLbauKzeecTV/HKdZrAjSZ9xpjTjM7
 5t8HOozHFuVOT52R30r/nmYdsan+8WT4ULqBT9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:uT6fc7tnUnLA9xXuki+S7XUUHalYRe7+tX2Jo0EULP8=:+HJ1y6Olmcya8nQTGGJPNnVqUC2o8XkQgl+8pDdKB68=;
X-ME-Sender: <xms:ZoL6ajYm992oVVRwsJaWYYiyDYxZj8sthhqu8iCb5RLoQjyqVKFsRg>
 <xme:ZoL6akrNJZs-Ka43lfOUPxntayyVzX8KinJNQmJx35QYMTPnvFoOrRnPb8EI80q2i
 38Nb9U_yrM1EBQuVdZhday7tiyNYRr2oE7Vv023llyYpAekMmiXByLZ>
X-ME-Received: <xmr:ZoL6aoPABF2rZMDHdK4BUAS0QIMhq-Xgsm38Xa3rFMOOOPVZ_Czj1LBSvROdN-jKeAGs7QKimdmRVy20dLatTJ8ViRY>
X-ME-Proxy-Cause: dmFkZTF6BUTvC0bQwO1FTr2RifSNU8vOFv/2aYdOYYT1y1rdrB07Bd6skE9AqS3ni7dti6
 vj8y68PfW/IZFYEuOkY6c1acwujQRK41X19CL0YiFtVsIIgWzs6XoYWg6By/rMrC5dKl42
 j1xg1StTqAGzCp/WWPBYKruP5uFKXUMcQSKt54Jlu+yvilAKCsS6woyOibrrPFYAob1BDH
 QcoRZ7hmoXriVaQankXK7q4owhhEPp6byht8hNXw2x0nLp/GrbdrTMmnXRI/99rEADutRq
 xcoPYt3UsnoFUp7VzRdm9aE1uvTbh+Iz8dsyvp5AAq4uUgnuG95qAEqycpRcQHGNRPvQjQ
 LiUK9SImxtadlf4wjGyKSmdQAWMTeSDNUoAWGQT9avrrgET1zCz+CnaLBT1FZnnYxynHFh
 HlJgRi6cMyzt96nfvHrzw+igMli9rNutHNws0zFgfUvHfZ3w0Te4SpVKjdsKWx5WibbE/i
 LRWlHYOcH98dqdy8xS5P8ruJAWJZSisPhtmUcyKLRZPIfHXeL6MokjjHWP3I9Y02UyuFqj
 sISdwnmMl0uCWjUz3fTLBQbWLr9tyGe6g5RAqe/AAW+XNuLqZqWTO+/nHFL2qkNvaVFHcr
 4Kd6us7RZd3ir8XCRQ4Ed5wMK/hKaAanBvHx5BMOsk7MhHdXRfzmwSJ6tYGQ
X-ME-Proxy: <xmx:ZoL6avoXb4GqyQAeQWGzlXNrc8MFhXxaBZ8QZHcY5SrYj-vXprrreQ>
 <xmx:ZoL6atelBBrQaNGINRzMQieBvC_MuDp9EotctHcdd8adBVnEdT9BGA>
 <xmx:ZoL6alQme-cviIblXYEDwn7DqV7Ok0uskSRdcmwWOwhgM9TFr_4UYA>
 <xmx:ZoL6amYlKdVDL3SuU_S6ASH6zbwbmuIxGg94cc-tYJrm0V9f54JS5g>
 <xmx:ZoL6aoAhhxImtvJgMuB4QVRT9IPgNo1gJA_dWua38XKxt-vVVBsT1l89>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Nov 2026 23:11:15 -0500 (EST)
Message-ID: <7f1575516a34fa20a587727add826566ddda5c8d.camel@alistair23.me>
Subject: Re: [PATCH v3] hw/net: cadence: Honor subword lanes in the GEM
 registers
From: Alistair <alistair@alistair23.me>
To: Peter Maydell <peter.maydell@linaro.org>, Bin Meng
 <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@oss.qualcomm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org
Date: Mon, 16 Nov 2026 14:11:13 +1000
In-Reply-To: <CAFEAcA-yqrPWXngq-pR5F2Eg9qSN=7f+AJThw9SzFtCF-pj7+w@mail.gmail.com>
References: <20261109143410.3279305-1-bin.meng@processmission.com>
 <CAFEAcA-yqrPWXngq-pR5F2Eg9qSN=7f+AJThw9SzFtCF-pj7+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.140;
 envelope-from=alistair@alistair23.me; helo=flow-a5-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-13 at 10:00 +0000, Peter Maydell wrote:
> On Mon, 9 Nov 2026 at 14:34, Bin Meng <bin.meng@processmission.com>
> wrote:
> >=20
> > The GEM MMIO callbacks ignored the low address bits and access
> > size.
> > Byte reads therefore always returned lane zero, causing guest
> > driver
> > that reads the station address byte by byte to turn four unique MAC
> > addresses into the same value. Partial writes had the corresponding
> > lane-selection problem.
> >=20
> > Extract the requested little-endian read lane and merge partial
> > writes
> > with the current register value. Preserve the existing read-clear
> > and
> > write-clear behavior and dynamic queue pointer readback.
> >=20
> > With this change, reset the TX queue pointers only when a write
> > covers
> > TX-enable and leaves it clear, and only start a PHY operation when
> > a
> > write covers the OP/ST fields in the PHY maintenance register.
> >=20
> > Fixes: e9f186e514a7 ("cadence_gem: initial version of device
> > model")
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>=20
> This device is used by both arm and riscv machines. Alistair,
> do you plan to take it via the riscv queue?

I just sent a PR for 11.2, so I'm happy for this to go via the ARM tree

Alistair

>=20
> thanks
> -- PMM

