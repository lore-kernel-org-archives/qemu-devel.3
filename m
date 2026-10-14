Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6285DCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 05:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGrVj-0007CB-Ax; Wed, 14 Oct 2026 01:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGrVh-0007C0-Ke
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:26:41 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGrVf-0002EQ-J4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 01:26:41 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id 020A1EC0121
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 01:26:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 01:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1791955597;
 x=1792041997; bh=IHtv3F9qyu37oIUQ3V85NPZmL/FbaQ5B057np/vvDHI=; b=
 gJqgaDWmBvpb2bMaJ3yanvGp+a7qPLpidSQskgOSTVlIJm5Q2h0cRxO1B2MGhBVV
 PgrKvRQ9NXY4gF5oCCKu9O4gM4WRK9zfvwRVpZSNRVMLDcikEr76zvvRiwHX65K8
 5FK8pofPvheku0l5KgLRph7c3/zL+SGbz3FM1zer6Vd6uOOJ8I2ttEMHio2LRvrQ
 kdDjwcqs+DU9NlO8ax7hLN5Q75cZVCy6nC/Vn0+D92s/HQZ4s/S0N+WEejYRudCv
 Z31tMHehdxvytsE6CgswDO2HM9TS6tRoPnl9pYczlfKDWm8mIk1X6lnd7jX8j4NL
 Bv+tPnYD7wmHKTqsBZrOog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1791955597; x=1792041997; bh=I
 Htv3F9qyu37oIUQ3V85NPZmL/FbaQ5B057np/vvDHI=; b=Axi4sNBqon5R3iiV9
 xR6CHZImwhOz5VsEJgEsgu2bdpScFE1NBMfuUMSZdiJVY5p+YqmHLTtjzjuoq7Xx
 n32FVTEt+0hzs7jj+2/OaQX+UDUhgn0kkTzXOUGC8QMkKa90m5u108qP+GI3gghm
 dBL1L80SwTyd5WWqL0dunLE4htw0tcywBuSk3B9QQ67hBeiobDGSDA5sRzwheMnO
 nK2J7KiiX9gILUmC0dhLxCQ/mHpTaXuw7GMZHHjlBJ4FHqrGl+NrhcC/+O4ZBBHI
 slfyHUPJo98K+MiDb6RQsZ2OfDFHWiPcyAO8o8+W1HJ5xk2NKeJsCb6Nz0/Nchor
 gVAEg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791955597; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:W6+0rYvsQ5GZWIDDJ/gFN+oBZpVyPrDCmvnNXApll90inWn
 rZSWCxXTEBOatSRmTMesxXQZmyXakFgYmczRYC+XdizdY1b4dLzwGRFRNAEajZMS
 4xpcWJTuLbsNOH0/1AxCvmL5bi5XXJ+gqNtrVwBR0Qj08T5GHGYH9msJRzCnxl03
 /qEvuhKqtbRJQrYY7QgshXHF3bstbBSdtDPvgrsmLztxQFE1au3t9MRz9MW4gl6a
 Bc/lPuXhpBMF77rTlLrR4NuL0BU6AvEidYa8GFfdNfKsYJnxvtz2pP/mSpPdlGZa
 nB0YqLKmelYevO3xomiOmCZj+fLoNOvoeT8QfFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:35FUpSDaiHjto/FxNZRRDyd90wy6XNML7maxTVzK3ls=:IHtv3F9qyu37oIUQ3V85NPZmL/FbaQ5B057np/vvDHI=;
X-ME-Sender: <xms:jRLPap_g-0Zjq5Vf-X65yLwt7UItwOVhEhAo1fVOQSJMVwp_DIZOaA>
 <xme:jRLParrGe6EMzyfNTu3tp520EPtlpVJLpp64QpEWzuXGyG3ZPZuM7SQP18z2CKYaR
 5NCMOC1LShhBALZrzjyfZVLJRo--cPzfRI0bOrAFrVMJeff-E8QwQQ>
X-ME-Received: <xmr:jRLPauk2fV87PhpSFjlhTrU1-bqtp1fC4TuBYtoAbryjBc0JDevgCiDxJMPPrA4dLlCbA1G5uo0uhV8TgctdLVX50fM>
X-ME-Proxy-Cause: dmFkZTGSEfvsj1spM10ThNU/RsEizdKeBiszchv9FelREYaNRUl1kQq2NcP9fral6cQnXT
 0wz/x3q1FFETzp5AvnaFGcAYFzfryqSWoaJJjsMzrGmQzV5RAMgpKKvDs3en6x95fXopre
 PGYQSub+tZJOj8JMnRKqhA6mo5+J7QmWS/bhIZPlHtjs41BmPIVsP8Vt581UztKLyfXyIs
 eRWoxnzKkXoJ/OEW+6eG796vSPnEm6hnZQy1K41ss/weB7ddhMNS373auo9pUOGFhOmB34
 jhKPtQlIcUNeEMC74fEnngAxaR80olkhHxllQ15fZ6KJDc0k/xdTwb66QJZf6SYtpTEyrb
 DX3o7E05rK7WKeEgPG999UgTLbxRqn4kCsZRduHumbUcxCngcHr8MiX08R4k9suRNzHLw9
 KD9mXKCFpddvaGPT5e7NOy42zdTnYO5934K8RRelDjgdNFtb14hiUVB2E+VRykGqUU/9T3
 +s5YetcOU0lEg/8WBgZ8FrIG75pN+XBGZuKRhiFTYbxpWNfIcAuQWC64ZBViv167ZBRerF
 0iz3WjywCD0WToBSGa14aa9Nq3jvA1wJ9qzw3eHUVPdhZ927lRZqpaK7Fkr09B/3oMDU/Q
 fgQZiFVmtIrmwds8VA8DeJmDtRE8TZqDs04VO+3u5LOMXhpykJbbX58ylDAQ
X-ME-Proxy: <xmx:jRLPaqKiCXJdiuvXCbQw6JNahIDiFtC-TiAK4aullkCBouYeMpkk1g>
 <xmx:jRLParx9JHtZK0c-aZKPTM_knKWqSyDhcv2r384DvjZ1XiVmQv9n9g>
 <xmx:jRLPaqtootqdESkfZNCOwYE4a5K3-oB8zGJVdIFI7zUVfy8GQnHTSA>
 <xmx:jRLPais7Uv11-u0vfJHyukoseNZjfj29jdDV6McjtPyrXK6YWYuxog>
 <xmx:jRLPaq89FH0XWHvFkf-oe-44piR37oHcT7_Xw3gOqJmcAq2lTC5UKWFu>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 01:26:36 -0400 (EDT)
Message-ID: <e67118790819d6c0a32586da30a36cc9b2904b12.camel@alistair23.me>
Subject: Re: [PATCH v2 4/5] target/riscv: write back fsgnjn.h and fsgnjx.h
 results
From: Alistair <alistair@alistair23.me>
To: wangyang <wangyang25@otcaix.iscas.ac.cn>, qemu-devel@nongnu.org
Date: Wed, 14 Oct 2026 15:26:34 +1000
In-Reply-To: <ebb7f8a1c374783dd585ee838e1d30f4d2bfbccc.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
References: <cover.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
 <ebb7f8a1c374783dd585ee838e1d30f4d2bfbccc.20260904092608.git.wangyang25.otcaix.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.145;
 envelope-from=alistair@alistair23.me; helo=fout-a2-smtp.messagingengine.com
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
> Under Zfinx/Zhinx, trans_fsgnjn_h() and trans_fsgnjx_h() compute
> their results into a temporary but return without calling
> gen_set_fpr_hs(). The instructions consequently retire without
> updating the corresponding integer register. Add the missing
> writeback calls, matching trans_fsgnj_h().

Please wrap commit messages at ~70 charecters.

>=20
> Tested with the 3-case RV32 linux-user witness and control matrix on
> a clean patched QEMU build.

This is not useful information to keep in the commit message

>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4407
>=20
> Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0target/riscv/tcg/insn_trans/trans_rvzfh.c.inc | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> index f36b46c211..fcdc6065a8 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvzfh.c.inc
> @@ -313,6 +313,7 @@ static bool trans_fsgnjn_h(DisasContext *ctx,
> arg_fsgnjn_h *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 if (ctx->cfg_ptr->ext_zfinx) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_ext16s_i64(dest,=
 dest);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 gen_set_fpr_hs(ctx, a->rd, dest);
> =C2=A0=C2=A0=C2=A0=C2=A0 mark_fs_dirty(ctx);
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0}
> @@ -357,6 +358,7 @@ static bool trans_fsgnjx_h(DisasContext *ctx,
> arg_fsgnjx_h *a)
> =C2=A0=C2=A0=C2=A0=C2=A0 if (ctx->cfg_ptr->ext_zfinx) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_ext16s_i64(dest,=
 dest);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 gen_set_fpr_hs(ctx, a->rd, dest);
> =C2=A0=C2=A0=C2=A0=C2=A0 mark_fs_dirty(ctx);
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0}

