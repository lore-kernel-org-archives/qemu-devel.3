Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F52ECC6B20
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGqb2-0000st-6v; Wed, 14 Oct 2026 00:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGqaz-0000sN-KZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:28:05 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xGqax-0005ya-GN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 00:28:05 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 0E6DBEC00C1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:28:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 14 Oct 2026 00:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791952083; x=1792038483; bh=nNrFgYs6Tj4vS2Ti17G6dvbR9TxTsUtZ
 agc3NsPkUI4=; b=hpxJDz12LTADV+UTDbTpXCjF26Mh2m6oqxHi0EnSiKJW+O0d
 eAAHohd08hYGcVd6nP77hE7fYVAXoTfOLbNYyNDVBnbRT99yVD7gmzz0YpgnEpvD
 KzxiRk0nV/7lHL6BmFSt6rtXeBREHXG4RFjV+IjVPH2WqPYDVq64K0ro5x2RdZK+
 21CHx6Hl/mHRgWXSBuwwujELlXQ0d+XFBLETO9Vh+Qh14tpBf4yaczY2vlWG+hiW
 Rs+XMVOtEoIhjJPJqMU2MrLhxi/bWNNrq6h06Knfl4EOTv9ZaEHSUWi8wzv8pAGc
 Ym9cPA9c1peRwxROKHB57EqWVgLIlUdxJF74nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791952083; x=
 1792038483; bh=nNrFgYs6Tj4vS2Ti17G6dvbR9TxTsUtZagc3NsPkUI4=; b=Z
 j3DoEUbX+T8tITu8kyxn1p+aEgJNp16zOU71nTuofimXFso0y0hTW5DQY02AZmxu
 3Ph6tohTnR5f0Bot81j5hnyiwx5IMEZc/EOEFnShsB4IX6EWabnEa5o+0WmEXBW0
 qbq7mY849l9vdrpL+JAo6CuG+SIZjWORqXDVAQldGgBMJ1y0FPa+JlW4s5IYD3AP
 puo+faVF7L3EtT3Frqyf3IrdQIhaxP73Q3UD6stkZFbkExDVaMl0DjP0N1CXncQ1
 MjZQRERfMXeHw+GK4pZZVCwgrCioUHCnXTS6kX+Dde5cOrASOY8RKeRItZdnz3XV
 brVcp7k7RDTJxjeMHrJRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791952083; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:OaJh2GzFZuQBJuJWk4FWrkFHicjmfOqMpBgOmu9zkvG7f2K
 1cSsQT+VlG6Aft1Qs3toz/vuz6PX4ib5Hyy9RdUvifOmR9kDXS6dDvavwbIbfbRw
 d8LnwMt3qwSz0Ra3c+macIXPNotR/7hbf4AksOcpvr0KSI4DAeb9+wW0EBW2b6Ee
 J0kQfpjYDpzrEjvVOzaM08NJ2+3WQahbwvk0YAs/eADN5CVU5db30Ak18ugXAw10
 dhXKBACQYA/ABBJB0jqfvtoEp29mduH2/hXVfGAxdh33ympldoBKFaUBoeP42WCK
 0iohLtWA+XJVI5YBKbAQ/ObYjKIUUffuMthk67w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:miF3MDnCvBoZGiHN1bNTs/vjVHehRcB9t3kpgrW0rrE=:nNrFgYs6Tj4vS2Ti17G6dvbR9TxTsUtZagc3NsPkUI4=;
X-ME-Sender: <xms:0wTPanKDuoJ3Z74M_7ZkOqiyhcjsvYy-eo8KZwCvuJV9MIDibRnBVg>
 <xme:0wTPavdOMuL8gCggrqIT6LMzwHuzmySGvDPO2quEBRoqF4EgkYvPRJiiy2oIFrGxp
 nk2V0DINcdYiE7iNsFLpvKVxUBulXGzfm6b2ueNmakqHF3Xc4TAAV-2>
X-ME-Received: <xmr:0wTPau07plvHus026ejUcRjN6uuH3nDFmH_CH5vS4w2qWBGGaejFxWiAvtFwGw8G7nKXsltmpRUVFxjjhOho8lzYr64>
X-ME-Proxy-Cause: dmFkZTGXwy3PD/pSXw5muzO+5ZK3ax58O9IODEptBYhSjJ9BrilKcbkSWOqcErsMvZSexc
 T3U7Hp4U16rQ8sPGovtOmlnwsEuQxII9KuhlFNNmG8XlmKgewnBqsO9yx/WOCwhCdG8Al8
 DmMpBoeQDFch3COh3cjoqEbr9x+4Y1pu8zMn4DB1MSrNNhPZsYUIB6+ogmD+0MqHRylkVn
 iYa6PEonN+rE1+dKwR/MaRE5HMztBVs+1uUju6d8h81Ur8sYNwpVVqlyKJmHomi2EcuJJg
 sL2t9+oMu3t+dr5uesLFU/KzpDi5CEL8VLJunoORLyzRezzhjhxSGaXFH2FRjx1hLlX+GE
 PAb9jJqvGhYBBzUzD/R/w3z/ffI9eFF8tcYWAJXkXCBLx6aH3waOSajMoEhS13m8vfkY8E
 Ewy4X76lhcR0GpILAQsAfG1dnuLH3FXY3uu3rsp5K8nOrY7NZ5l+GOr7ABVGcr9kmsLnzW
 qALjLBtbClZI+Y7sFkCSTwDkscRfgK8LOD6/Po8F3AC2GDwSmyalkjVBDXB2LdYrina1l7
 qGTgKx/c/PulqzQcchXnHmx59XVWFkUakp35Vb6Jp6qp7HDqFdXY4mOs/fJzW2lokSs21z
 sDjp1EWlZFuZtQPWMXLDZtMc9JqXQej1uhAFopcEhEg9B5NyYKC+88f9KOOg
X-ME-Proxy: <xmx:0wTPaohp7NXt1whe2QdejFW0DGhrVW210Uc7zuCgHffSXFIbx_h_IQ>
 <xmx:0wTPakQnV-r_j5KiQeJMehs2za1stP9VuJ1x6WeaOkEiF0QOncW6bw>
 <xmx:0wTPaphT3SckpnG1IXG3KH64U4gZ8OrPOh8NgGH3HXFiM5fRi9ViRw>
 <xmx:0wTPak6j2BzA5bTAZgWCEwlYmr0_XiuEjluScOYDBd0SOYfStlJNOQ>
 <xmx:0wTPak-aSfDtQLjvqZyUCSKtpKqDR4ZB3thJyZ6nrlvWn9ikmreO5FjM>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 00:28:01 -0400 (EDT)
Message-ID: <5966e420c23219afc5a3177168f22b186dd50feb.camel@alistair23.me>
Subject: Re: [PATCH v2 21/23] target/riscv: Drop v0 argument from
 gen_helper_ldst_index
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 14 Oct 2026 14:27:59 +1000
In-Reply-To: <20260821040404.268123-22-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-22-richard.henderson@linaro.org>
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

On Thu, 2026-08-20 at 21:04 -0700, Richard Henderson wrote:
> Since we're also passing env, v0 is always env->vreg.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0target/riscv/helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 64 ++++++++++---------
> --
> =C2=A0target/riscv/tcg/vector_helper.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++---
> =C2=A0target/riscv/tcg/insn_trans/trans_rvv.c.inc | 17 ++----
> =C2=A03 files changed, 46 insertions(+), 50 deletions(-)
>=20
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 3ef352898b..bf49a793d5 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -187,38 +187,38 @@ DEF_HELPER_5(vsse8_v, void, ptr, tl, tl, env,
> i32)
> =C2=A0DEF_HELPER_5(vsse16_v, void, ptr, tl, tl, env, i32)
> =C2=A0DEF_HELPER_5(vsse32_v, void, ptr, tl, tl, env, i32)
> =C2=A0DEF_HELPER_5(vsse64_v, void, ptr, tl, tl, env, i32)
> -DEF_HELPER_6(vlxei8_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei8_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei16_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei16_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei32_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei32_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vlxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei8_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei8_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei8_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei8_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei16_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei16_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei16_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei16_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei32_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei32_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei32_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei32_64_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei64_8_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei64_16_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei64_32_v, void, ptr, ptr, tl, ptr, env, i32)
> -DEF_HELPER_6(vsxei64_64_v, void, ptr, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei8_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei8_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei8_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei8_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei16_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei16_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei16_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei16_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei32_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei32_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei32_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei32_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei64_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei64_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei64_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vlxei64_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei8_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei8_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei8_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei8_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei16_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei16_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei16_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei16_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei32_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei32_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei32_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei32_64_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei64_8_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei64_16_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei64_32_v, void, ptr, tl, ptr, env, i32)
> +DEF_HELPER_5(vsxei64_64_v, void, ptr, tl, ptr, env, i32)
> =C2=A0DEF_HELPER_4(vle8ff_v, void, ptr, tl, env, i32)
> =C2=A0DEF_HELPER_4(vle16ff_v, void, ptr, tl, env, i32)
> =C2=A0DEF_HELPER_4(vle32ff_v, void, ptr, tl, env, i32)
> diff --git a/target/riscv/tcg/vector_helper.c
> b/target/riscv/tcg/vector_helper.c
> index 15c1281538..d46fd5c9c4 100644
> --- a/target/riscv/tcg/vector_helper.c
> +++ b/target/riscv/tcg/vector_helper.c
> @@ -598,12 +598,13 @@ GEN_VEXT_GET_INDEX_ADDR(idx_w, uint32_t, H4)
> =C2=A0GEN_VEXT_GET_INDEX_ADDR(idx_d, uint64_t, H8)
> =C2=A0
> =C2=A0static void
> -vext_ldst_index(void *vd, void *v0, target_ulong base,
> +vext_ldst_index(void *vd, target_ulong base,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 void *vs2, CPURISCVState *env, uint32_t desc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vext_get_index_addr get_index_addr,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 vext_ldst_elem_fn_tlb *ldst_elem,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t log2_esz, uintptr_t ra)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 void *v0 =3D env->vreg;
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nf =3D vext_nf(desc);
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t vm =3D vext_vm(desc);
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t max_elems =3D vext_max_elems(desc, log2=
_esz);
> @@ -633,10 +634,10 @@ vext_ldst_index(void *vd, void *v0,
> target_ulong base,
> =C2=A0}
> =C2=A0
> =C2=A0#define GEN_VEXT_LD_INDEX(NAME, ETYPE, INDEX_FN,
> LOAD_FN)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> -QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong
> base,=C2=A0=C2=A0 \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *vs2, CPURISCVState *env,
> uint32_t desc) \
> +QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base, void
> *vs2,=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env, uint32_t
> desc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0 \
> -=C2=A0=C2=A0=C2=A0 vext_ldst_index(vd, v0, base, vs2, env, desc,
> INDEX_FN,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 vext_ldst_index(vd, base, vs2, env, desc,
> INDEX_FN,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 LOAD_FN, ctzl(sizeof(ETYPE=
)),
> GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> =C2=A0}
> =C2=A0
> @@ -658,10 +659,10 @@ GEN_VEXT_LD_INDEX(vlxei64_32_v, int32_t, idx_d,
> lde_w_tlb)
> =C2=A0GEN_VEXT_LD_INDEX(vlxei64_64_v, int64_t, idx_d, lde_d_tlb)
> =C2=A0
> =C2=A0#define GEN_VEXT_ST_INDEX(NAME, ETYPE, INDEX_FN,
> STORE_FN)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
> -QEMU_FLATTEN void HELPER(NAME)(void *vd, void *v0, target_ulong
> base,=C2=A0=C2=A0 \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *vs2, CPURISCVState *env,
> uint32_t desc) \
> +QEMU_FLATTEN void HELPER(NAME)(void *vd, target_ulong base, void
> *vs2,=C2=A0 \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPURISCVState *env, uint32_t
> desc)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0{=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> =C2=A0=C2=A0=C2=A0 \
> -=C2=A0=C2=A0=C2=A0 vext_ldst_index(vd, v0, base, vs2, env, desc,
> INDEX_FN,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 \
> +=C2=A0=C2=A0=C2=A0 vext_ldst_index(vd, base, vs2, env, desc,
> INDEX_FN,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 STORE_FN, ctzl(sizeof(ETYP=
E)),
> GETPC());=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> =C2=A0}
> =C2=A0
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index 5e352dbf41..4556c644cc 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -975,33 +975,28 @@ GEN_VEXT_TRANS(vsse64_v, MO_64, rnfvm,
> st_stride_op, st_stride_check)
> =C2=A0/*
> =C2=A0 *** index load and store
> =C2=A0 */
> -typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCGv_ptr, TCGv_en=
v, TCGv_i32);
> +typedef void gen_helper_ldst_index(TCGv_ptr, TCGv, TCGv_ptr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCGv_env, TCGv_i3=
2);
> =C2=A0
> =C2=A0static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t
> vs2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t data, gen_helper_ldst_index
> *fn,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 DisasContext *s)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 TCGv_ptr dest, mask, index;
> -=C2=A0=C2=A0=C2=A0 TCGv base;
> +=C2=A0=C2=A0=C2=A0 TCGv_ptr dest =3D tcg_temp_new_ptr();
> +=C2=A0=C2=A0=C2=A0 TCGv_ptr index =3D tcg_temp_new_ptr();
> +=C2=A0=C2=A0=C2=A0 TCGv base =3D get_gpr(s, rs1, EXT_NONE);
> =C2=A0=C2=A0=C2=A0=C2=A0 TCGv_i32 desc;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 dest =3D tcg_temp_new_ptr();
> -=C2=A0=C2=A0=C2=A0 mask =3D tcg_temp_new_ptr();
> -=C2=A0=C2=A0=C2=A0 index =3D tcg_temp_new_ptr();
> -=C2=A0=C2=A0=C2=A0 base =3D get_gpr(s, rs1, EXT_NONE);
> -
> =C2=A0=C2=A0=C2=A0=C2=A0 data =3D vdata_add_memopidx(s, data);
> =C2=A0=C2=A0=C2=A0=C2=A0 desc =3D tcg_constant_i32(simd_desc(s->cfg_ptr->=
vlenb,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 s->cfg_ptr->vlenb, data));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd))=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 tcg_gen_addi_ptr(index, tcg_env, vreg_ofs(s, vs2=
));
> -=C2=A0=C2=A0=C2=A0 tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 mark_vs_dirty(s);
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 fn(dest, mask, base, index, tcg_env, desc);
> +=C2=A0=C2=A0=C2=A0 fn(dest, base, index, tcg_env, desc);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 finalize_rvv_inst(s);
> =C2=A0=C2=A0=C2=A0=C2=A0 return true;

