Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF62CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGrWw-0007Rt-8t; Wed, 14 Oct 2026 01:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGrWl-0007Ps-8k
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:27:49 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGrWj-0002GI-Lr
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:27:47 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id BEEB21400104
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:27:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 01:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791955664;
 x=1792042064; bh=ouLXcgIknEZmBUdOfz/Jry2CyboN0ERsz6YQfTsfXEk=; b=
 bHUaRrF0K/PTYQdA+HAiRmsgtJmRObuL5IuicAtIKmJfhPrXFaSzl+Mo6We+rdc4
 6bvkH21zJvPyWsPNQc53i4CpOUS6ApBPG5vynyeZgJJV58+fJAlWU6lqeZYRgNKl
 3RlWbVCADVa7gLLbQ4kaK8C7tIGMngz2P4YubwlfWtCP/t+5RaPn2hv3KqGWRmGb
 39mdtyJpZpmFT4hAmW7MF52SOggc19UXyaJ9clueYtg8On/QG4V9nkXO1LCjtk0m
 WJy9Kq9T6NwHqe2YqogrMWE2PWCs0AT9DAGPk6faFOezq0/Y2ZAoxjGOW3TiEawx
 oVvyl2iCNR+3+xrI1KQ2iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791955664; x=1792042064; bh=o
 uLXcgIknEZmBUdOfz/Jry2CyboN0ERsz6YQfTsfXEk=; b=hJsLi786n08L7eraa
 CUMbHs9noo5lAsrFuWkPLT4TfOhqAW8gAJLXrogNyHZaBJCyfLKrqgJBFRrpTboe
 L6CpGHUBTTJI2uBHrOp4veG/4Z8lNV1kN30fbZ3oqdDMVJtYMI7wF5R1WyKbG6yz
 42N8r+J4tFmGDZ0qIoRW+UAAhBT0CuQg2jTQCXCIYUPq0T0Ag04YsavnRRjmlYZx
 bD5UPxEYGCAMBPcfza+jnN4cfCcrkiASFSsrBhLPLuo4Qy4+dYTLb++Y3081sKPD
 vRiRiWWtBtKqc9sXfpzqena8vl0z08GXWYPm/0eJF4wVOsOLzQPUZ6heQb5CFU3c
 tMOWQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791955664; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:ikIJqZlo56//RkHdVQ3HLKwUYkbnucyJj6eIr1HpLndW8Os
 uEJE3D8ClSly6cnZnzP4ASvJJYtNgpmIM8atFmN/a3D+mC/qN41iY5Ym3jrJFf5n
 laM7q4HBU4miSPwb7ecdneUm6UuIDH23SZDRbaJY/eowVA5LL2T589EUt3YDbmLK
 2v/V01lxxZUebkrWjhu7kkwCm3YgAkGe0C9D+xllmkhZ2RFslCHhklVFlGJrD82S
 ln8u7NyUHFJTYjTCMApMmHlZlssbV6KxFJ3wvYTzS+8HMcl9CrU0YckuEzcrxXtQ
 Wd7PG3xepRoiHpcjqbsm9QadzjptewJqFuVgv9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:pvt31YMAqF2a1qLPUb0imJeDxz55KW0Bbavdt/hGpq0=:ouLXcgIknEZmBUdOfz/Jry2CyboN0ERsz6YQfTsfXEk=;
X-ME-Sender: <xms:0BLPaoVhT99FSNgB7_joBe8yZTrAhvVGUXrdXa4Y9mT4OuJsdRmx1w>
 <xme:0BLPaqhM4MrQrQrljsz5-3-E-yMq34EDqiHIA61zP30SCFKwwL-xJF9OTXAuOQQNe
 dniNTG5FfAVO_oxJ0-4reNLpzTxX07LfIMcvlEb9SfHk2Qd6KusRdp-2g>
X-ME-Received: <xmr:0BLPaj8RBiuJyAfTTPksQ9m0aQoAxwKx0CFcvNg7qCNag7I42spU6p3iTmva6BUleFL86DWAu4lCB4-eQS4xlgmbW-E>
X-ME-Proxy-Cause: dmFkZTGSEfvsj1spM10ThNU/RsEizdKeBiszchv9FelREYaNRUl1kQq2NcP9fral6cQnXT
 0wz/x3q1FFETzp5AvnaFGcAYFzfryqSWoaJJjsMzrGmQzV5RAMgpKKvDs3en6x95fXopre
 PGYQSub+tZJOj8JMnRKqhA6mo5+J7QmWS/bhIZPlHtjs41BmPIVsP8Vt581UztKLyfXyIs
 eRWoxnzKkXoJ/OEW+6eG796vSPnEm6hnZQy1K41ss/weB7ddhMNS373auo9pUOGFhOmB34
 jhKPtQlIcUNeEMC74fEnngAxaR80olkhHxllQ15fZ6KJDc0k/xdTwb66QJZf6SYtpTEyqk
 sJ2QzOUtZypcnFG3FJsr0dZ+bo+PCUZKqgI1LdY12mo9l2mAfqjHgK+T4pZYoyfvheuyuO
 C/OMv4JNDh6JMpUeKPewg5ZSTXoMJH3wrEKdBzBGgCnWk70zbA6FU4dQFoatpSTeW9qH6l
 WorrTLcJJveFaJGwlMZG/wUfka+KlG+HUUy0vOAsjsjyNuJWAqElzAueoo66k4D1oNXfgt
 kmXp4cF/gGX7BicY5arCWSZfEBAPjV1MzPn2/OcgatcURV9zbaBZwvC3f0MbF0LlcF+WVK
 n+n/puZf9dYx2/EwALE4pMgblTSckyOIMHV1hnPbgaDXbAlCM6TpqKc2U0Aw
X-ME-Proxy: <xmx:0BLPakDdv-qqXNgne3PWqMjfq2HLsvrqT_xnXG8a4_d1q9GU_rswBw>
 <xmx:0BLPagJnDacf_syAHdrrRE55Cg4Ndh93NbijgD3tGjJIWCK25rhGwA>
 <xmx:0BLPanmf6o7vJr2H0k1SNP8r_tO2ywrlU5ImeuK9E8JB26rqMJxZaQ>
 <xmx:0BLPauGkNstX_me0KoGtLfJ7zLqzz35G8oV8H64pGjqfBDFdDBuvoA>
 <xmx:0BLPatXqadTNmI48SPCU4lsI1Ozb888JWaiML2m-gFv7lDN4V21i4-4n>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 01:27:43 -0400 (EDT)
Message-ID: <f977eea5aaf6b9943b0a18833d141d76c271b7f8.camel@alistair23.me>
Subject: Re: [PATCH v2 5/5] target/riscv: normalize Zcmt jvt.mode on writes
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Date: Wed, 14 Oct 2026 15:27:41 +1000
In-Reply-To: <a64897d07c6b0c61451cd5382afafcd27201367d.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
References: <cover.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
 <a64897d07c6b0c61451cd5382afafcd27201367d.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.158;
 envelope-from=alistair@alistair23.me; helo=fhigh-a7-smtp.messagingengine.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2026-09-04 at 09:26 +0800, wangyang wrote:
> Only jvt.mode=3D0 is implemented by QEMU. write_jvt() currently retains
> reserved mode bits, so a legal WARL write of base|1 is read back
> unchanged and causes a subsequent cm.jt to trap. Mask the write with
> JVT_BASE to normalize the unsupported mode.
>=20
> Tested with the 4-case RV32 linux-user witness and control matrix on
> a clean patched QEMU build.

Can you please include the tests as unit tests in that case

>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4408
>=20
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0target/riscv/tcg/csr.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..9affee0375 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -5883,7 +5883,7 @@ static RISCVException read_jvt(CPURISCVState
> *env, int csrno,
> =C2=A0static RISCVException write_jvt(CPURISCVState *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target_ulong val, uintptr_t r=
a)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 env->jvt =3D val;
> +=C2=A0=C2=A0=C2=A0 env->jvt =3D val & JVT_BASE;
> =C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
> =C2=A0}
> =C2=A0

