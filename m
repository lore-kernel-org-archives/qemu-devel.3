Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C61CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN4P-00048m-8P; Wed, 07 Oct 2026 04:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHqY-00075a-Ds
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:57:44 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xEHqV-0005WI-10
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:57:33 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id B4E531D0010D
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 11:57:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 06 Oct 2026 11:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1791302231; x=1791388631; bh=VAQKuFpY6oO0Iqg60XoTwhg73sSAjs5k
 VFpg3qCzTV8=; b=sKBTNlzBu54IZ/P/1wPT74Dw/ZQVqtR7UVjS2qknDVIWN8rH
 IirtIQKsxyWDsW3OOVwhF2peysrfANyaP/J8bpAYVjj/vheeMmvMytDR7e8IPQI+
 yRlECONPLgk3MlpDljtYa7SWU61GQNrPXhAQIi2NuRM37N/3Wam/ZFjh7YSbq2FT
 /pYi9PNUPfmamvIKXFGYHOS5fJkDJUSlGgLsvhFbfGwxOr2SpAJSx8Fa2qNMppnk
 aJLbsSxONpPjaJ3B6PPveuG4TLkKPn2oz2mmU5093pZPBU5KOj8XQPw6jH5YMJBH
 boekAXEi4fAt/cOiycjibKy9hvZc6pYxtIgbOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791302231; x=
 1791388631; bh=VAQKuFpY6oO0Iqg60XoTwhg73sSAjs5kVFpg3qCzTV8=; b=n
 z5xEhQvz+vajoFXzOpEFDondfh2otTGXdKmfQINazIPALLmBcdrr8fSi12httxXU
 D1ij1DiAT78iQMo3WUrU02xRI9Xowmil1aozFz6D36Wlq1LjjLlMkvkIsfcAOG4Y
 IWNX4iaWM03u+PtgdvA4EDrMbSMvNhtUVUCD3feN2MYOMkDRhKJDu/wQUtNjVD2i
 L9Cgjf2Rc4ZuNuqjNJe1gBYzMkIPTPbbrdotOz74Ij1wA+Tl4JcEjuRP0vF2tsXW
 TBjp5SuzyD54oZ2KzI8t+k6P7X2nUAyeH4hP2zKrpc5JMaqDJUd1PtkH4J9Xjp4y
 vkwu0pAtL2WbY1Fszc8lQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791302231; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:m0b0m3NMWlqufP94jLmWaFsDVQEv1vWnRHCvZfNSiPj5tWp
 E4THNMJvdfaJw/PqAIucV+w7ffJGk/y5M+O5SoypO4ooDdW0YwEgFd8qQxvz6hNT
 uNbOwGcSxk+f/AM94llVyLrqtrA7c1JWUyKQFBRSu2y+cXpNsmxTXsCfcXl+3HOh
 qC3tr8YH3tGUpMW6hBJcxxdVuu/qte6zl+v5X0mB77hAmUH6BDfHSpJyCdMVmw3r
 B6YeKjNJdrFeNR2DN4ZrzkM4UBDzwpFV9Knl/62JoyWhnTbh/azoiQfxmGOYrJef
 HUrQ0rKr9wC9epafjdcZktlWHNA6M30af/pz5fw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:JOb6urwcj7olowNaYcmjoSv7VecnBzcXoTYG+JCwkOM=:VAQKuFpY6oO0Iqg60XoTwhg73sSAjs5kVFpg3qCzTV8=;
X-ME-Sender: <xms:VxrFahEFS_OXimBmIFYLcvtgVXjcscLVszDpLtm54ZJw2R-E4_KlKA>
 <xme:VxrFaqpZwgSwFXpfauyi7ItuaxEqL3_hS2qDJVFudQIlntnvkHyuZSsOdGH0B_bRA
 mVqWADa9YhtIv1hpitk2EC14i8mAzshlvHwyCEE4Z85raF0vp0OhebEew>
X-ME-Received: <xmr:VxrFaiScm5MycKhvG6bQ-N4SjB7xd7UrteFXXBkvFEEJtPjtwkopi-FvuXwr7YNoR7TXVNZhskCsZlqGv4WPhy8>
X-ME-Proxy-Cause: dmFkZTGVRV+e63PprtD5vpKHwuHKu7EnoZFcSlhExN//humW2afUyP5AbamrI+szzDDVJj
 nPgoDEi2iF7ZTgV8TpGLfK9Q/g6U2fx0D4s2iFPKhZ66XGTJEfAOJQLXniJunukRaSIsYe
 wOS1Gz0Wt17777ulV5ww9KgKxnSVoVIoZ8UGuhxbng0y88PBq8f98+n0e7Ilia6VT6lKSb
 pCNNfCI4NkxsxuHujMUnIynP2CAq9DPw5v2ouKTvFPVFo49KUhub0p0OSX7gToEDReP97N
 NhQ1uE1IiXGB/NL3c82XCHeW2F9LoNo7reXLmtWYGcT9rLJTlDz1+yXW+TjB1Q22uupmXK
 RFI4L6AO20YYLrZU7/iUuzU6YWnCnSFsTbGKq68era/mLSTI6pQTzi7GJZyLc89Wn741pE
 ORAP+FZb+/usS2Ix9Tz9z8G9sYBwqHyh/efQDaKpTDyMBv3XfIIWya34bC0p2XmCJJ1188
 MaNF1rQ48sm/Fd02mW8zQOg3hHeAuoO6tfdizHeJBH7FlpqUo1kzOL0JSI1xuO6qQyjrpg
 HFTbyGx2O/+/igq98GpeL0XyYDm1oAClSsUsM1huvfpPzvTm8b+YeLEfR+uC2kr66q2WZB
 6DtF+KsrihJ8tFZ7wBKU5T9aKq0Pv/LerRz6jjawSk5/jaGT4UOvyqM4bQxQ
X-ME-Proxy: <xmx:VxrFavPKi4JcGbF_AvAICHNS5EuNdGte6SyW8B8v10j-92yJ3E3EUQ>
 <xmx:VxrFatPDXTRFYq6f8DccRf5uGBb-bD5IiCtjT_FDh9U8MZMDut445A>
 <xmx:VxrFant2KvOGe-fdtMchc6dVt2gSauxukMXB4BaMCtPVKP7mwD0jeQ>
 <xmx:VxrFavVvTP0sFowjKyOmzRBQ8tb0m95rwjcBJYCZgjwetuiUK0YaOw>
 <xmx:VxrFamraMzHul4J9_3CsxEUShP6mXxkis8m2A_KXORQtTQlQeQuUQmYj>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Oct 2026 11:57:10 -0400 (EDT)
Message-ID: <09ebf5e24a2b910e70b9906564861fc121c32503.camel@alistair23.me>
Subject: Re: [PATCH v2 13/23] target/riscv: Remove unused VDATA,WD
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 07 Oct 2026 01:57:09 +1000
In-Reply-To: <20260821040404.268123-14-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
 <20260821040404.268123-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.146;
 envelope-from=alistair@alistair23.me; helo=fout-b3-smtp.messagingengine.com
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

On Thu, 2026-08-20 at 21:03 -0700, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0target/riscv/internals.h | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 5d84e4de96..9e4da39ea0 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -94,7 +94,6 @@ FIELD(VDATA, VTA, 4, 1)
> =C2=A0FIELD(VDATA, VTA_ALL_1S, 5, 1)
> =C2=A0FIELD(VDATA, VMA, 6, 1)
> =C2=A0FIELD(VDATA, NF, 7, 4)
> -FIELD(VDATA, WD, 7, 1)
> =C2=A0
> =C2=A0/* float point classify helpers */
> =C2=A0target_ulong fclass_h_bf16(uint64_t frs1);

