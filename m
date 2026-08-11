Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB9CC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 20:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtt41-0005Fz-6t; Tue, 11 Aug 2026 16:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt3Z-0005EF-E4; Tue, 11 Aug 2026 16:26:43 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtt3X-0004aP-Td; Tue, 11 Aug 2026 16:26:41 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id 32A21EC0143;
 Tue, 11 Aug 2026 16:26:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 11 Aug 2026 16:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786479999; x=1786566399; bh=UBH/BdgCLWH4fqWJCs7Sg54aMjzFlFvB
 0zMT4OYuEic=; b=SIQ/KFqnJqc0zRbDlS9TBd7dcnczIoOJOiBnv0dzmPA1qIrW
 xQuN543Ha9C2H/aW41maQQzhUvhIqNp0SQpj1FcpX9KjBLYFNeTYL/J7WDJkt0z/
 5wZHZxbnCW2HTrft3qMo18fIsY4kA7jgUHMjXauCQdoKYyBrTjJ7SC4EQxtnBqha
 YOA+VdQ5joSpztcaO8eyGj0qKMVg8cXScmCmCESvsZ68+gjx0sOqqcJrcvHTZbL/
 LcLPE7JF6ZTqsnQFl231CQORLXR0P1UaEY6/MMiMEx7LbRfZdn4UyAfMZiyjHV/q
 KKvDJjrJmT8R/CVP2GXUJdkHWRnEZwyiK2XjxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786479999; x=
 1786566399; bh=UBH/BdgCLWH4fqWJCs7Sg54aMjzFlFvB0zMT4OYuEic=; b=A
 jydT9faAHDBuAPnn/p7x2ztFW20SNPWc8mp2y1vLCTfQCk1yZELXz/AzzD0JCxcT
 /QDKVsN/pAQxH9VCI47z5+ZmTgCEWuKlL4Q/f5wSHJbs8kkyyC1KtV2L4boqdgNb
 9sE/U0s2xKxK7Zlwth3Mc/EvbLVD59perhF218/p4CQf7/XvGgX18RMBPMK76Sx1
 d4MuBj38He1C4TiG8c6e9iMmqb3JqiSkuO1dMJad7e8vi4un4f9YogSllE7oI1+X
 tYfGoXuUfd9ToGvfvWCBPK9L1UVWBltGJEr9HtwCG/4xcJsEI98fMEnrKzRzFom+
 XVPkVmJ/76yrDe6QJHfmg==
X-ME-Sender: <xms:f4V7alC9DlHSHlZRi8zyZ1bq8UOEHeK4OZH1vJsD0ajaFRics54u8w>
 <xme:f4V7an1mtESrVl9QLFaeCjsdL92figV99c6Seyndw2MHCp1g_A-qiWufPRgrohTJz
 BsyxJdXYWQTFih8rG4kARxexFzVDpRvlfriucOJdx54OevsBJNPGQ>
X-ME-Received: <xmr:f4V7avujtBGkkdyMRO5B2meijPZPQS5d0GMUlTKTghZV6dt3HtPDDRaQXFDj6x8vrlDmIw>
X-ME-Proxy-Cause: dmFkZTGjUGzLRt9YOoIfVi9vPX4yoGfoQnYyxR7IFQ4SHcUvWhFxNxXT+GkVoSD19/bXmw
 5O0Dyhzj2TyuOUX2bOaNZB7fqiHT0plD60kpacmEnpmm5gjeTuCdiB89Yazs98ranQOjBt
 U4o8Tp5bbODctlmHPXYLemU9KRN/H6Li7+dPxsfPbEiBrAz9mA4XvNPpGZ9No+DagwB+N1
 YzKMKPzFso3cdSigp6m6M9+1vJYtDqlQXrH5OHR/CQAzCe2merT6sXC9xj72kULZACCp3C
 G9L6chff/RsqzyCr6zon9p1XbCcRVNTGOc+FJvUgzFUv+iha+vYj5IAeOLh1NzQB62UCNU
 hcWp3DufSvJHTxj/v691NHRVmctD5ZVukHBvEQPuCqXlh9gweigUK8lwQlurDZDiXYM7P9
 dbdmJQw3qYULYFFA4lM6Smngy56s1nEJiMCRnLQAq2/MWVIVn43snbIeVJbpDV9mHW0v9m
 a1YwXRKwoI8NA3RRU8/WdRj/HpWtoT+G0L+6MaKe8nAiB17i1r9uge+/y/3tKyy7h+PZi8
 GJ1t2ZrZYVa1nC4iV61pk3RfWtJP/Em9oqUnaoCDLV9ZBtlQzM6iPsq4pGJ8SyEBdmrq4e
 h+xQa4kfDn524umDLc9CzxrIYM8/PYx2ueaaJQyrVt2WdlENeA1lS9lxP5RQ
X-ME-Proxy: <xmx:f4V7an5Lc1y-oy5gsDSbAzjqRCVXutksoT2NULff5Gqblv8r-aLUpQ>
 <xmx:f4V7agJhkAO1-OQ_8RPPWc7mI24xoM7NLJEqR7SaSb2WceIbqz8c-Q>
 <xmx:f4V7an6dQ04hJZ6uxr7QAxkBTooU8bOwaqxhvKfsOB-cJs2FWVinwg>
 <xmx:f4V7ajy-0vDGaFfFhUP8TaSWNTyuPdxZ0_0dfB4DwpGRZ6tDGImRyA>
 <xmx:f4V7aqUrm8dswDXlz6x6n_D2viasiI7VUTelbqwK2-vcUGDq2hZLCham>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 16:26:38 -0400 (EDT)
Message-ID: <abadbe6dff78cc672607ed2a097f0a0e7b1df992.camel@alistair23.me>
Subject: Re: [PATCH 35/56] disas/riscv: Chain "ret" pseudo off "jr" pseudo
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 06:26:38 +1000
In-Reply-To: <20260809223545.730664-36-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=alistair@alistair23.me; helo=fout-a6-smtp.messagingengine.com
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> "jr" has already checked two conditions that apply to "ret".
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index bb4779614b..2fec135b5f 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -1061,8 +1061,7 @@ static const rvc_constraint rvcc_bgez[] =3D {
> rvc_rs2_eq_x0, rvc_end };
> =C2=A0static const rvc_constraint rvcc_bltz[] =3D { rvc_rs2_eq_x0, rvc_en=
d
> };
> =C2=A0static const rvc_constraint rvcc_bgtz[] =3D { rvc_rs1_eq_x0, rvc_en=
d
> };
> =C2=A0static const rvc_constraint rvcc_j[] =3D { rvc_rd_eq_x0, rvc_end };
> -static const rvc_constraint rvcc_ret[] =3D { rvc_rd_eq_x0,
> rvc_rs1_eq_ra,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> +static const rvc_constraint rvcc_ret[] =3D { rvc_rs1_eq_ra, rvc_end };
> =C2=A0static const rvc_constraint rvcc_jr[] =3D { rvc_rd_eq_x0,
> rvc_imm_eq_zero,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rvc_end };
> =C2=A0static const rvc_constraint rvcc_true[] =3D { rvc_end };
> @@ -1076,12 +1075,16 @@ static const rv_comp_data rvcp_jal[] =3D {
> =C2=A0};
> =C2=A0
> =C2=A0static const rv_comp_data rvcp_jalr[] =3D {
> -=C2=A0=C2=A0=C2=A0 { rv_op_ret, rvcc_ret },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_jr, rvcc_jr },
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_jalr_ra, rvcc_jalr_ra },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0};
> =C2=A0
> +static const rv_comp_data rvcp_jr[] =3D {
> +=C2=A0=C2=A0=C2=A0 { rv_op_ret, rvcc_ret },
> +=C2=A0=C2=A0=C2=A0 { },
> +};
> +
> =C2=A0static const rv_comp_data rvcp_beq[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0 { rv_op_beqz, rvcc_beqz },
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> @@ -1896,7 +1899,7 @@ static const rv_opcode_data rvi_opcode_data[] =3D
> {
> =C2=A0=C2=A0=C2=A0=C2=A0 { },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "j", rv_codec_uj, rv_fmt_offset },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_i, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_i, rv_fmt_rs1 },
> +=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "rdtime", rv_codec_i_csr, rv_fmt_rd },
> =C2=A0=C2=A0=C2=A0=C2=A0 { "rdinstret", rv_codec_i_csr, rv_fmt_rd },

