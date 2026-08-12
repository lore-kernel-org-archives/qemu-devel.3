Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA6C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCtj-0000TQ-NB; Wed, 12 Aug 2026 13:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCti-0000T8-6F; Wed, 12 Aug 2026 13:37:50 -0400
Received: from fout-a1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wuCtg-0006Qn-AE; Wed, 12 Aug 2026 13:37:49 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id E81FBEC0170;
 Wed, 12 Aug 2026 13:37:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 13:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786556266; x=1786642666; bh=AOcm0FA18uFAtdomKC5lHbPW8CBRWX/P
 PTDoSG+Qcl4=; b=U6b7P58WQvgOn6iu97Aa/FCYriZ2+33dcg3Fga9N2Nu8F2qp
 AKSK3TXKnER4gkomunjWDQbVI257ciD1DMbXYno6tFwIFJ5Mynwlst54dRJa2ZST
 GtI2FBMV5/akQo07KQFDeAIDYrNfNvpCH5/yF14ULZbv1ktiki9oYquxdwLxRN34
 w15iraZBZR+OA8fLv4ZR7/sDbsdp7gHLN3VFp2yxotu72yFPEaa1wKnWZVcLk+6b
 a0s6AcoCUrHg/82zSt+k+3ZrYnRnUMB1vtPbqcc4SapNEZqIOCVemJI4s7bIRgN3
 Or6URUWFRAkygJYIZk7XQyHoXXMzmvGqN54Gng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786556266; x=
 1786642666; bh=AOcm0FA18uFAtdomKC5lHbPW8CBRWX/PPTDoSG+Qcl4=; b=L
 l6CQ2htNfwyoq06pEZgjiUtjPYSr938xwQKYC2mziMJKyJVL9bxmnfvDTaTvKKlQ
 hVmrud2ElJKfh39pzt8u2BLiwOwNmCN+XOXJ0g8OsfwKuGnLsVhA4CYxvzLZXtXB
 7LZtg9ajJXGxf8qDHQXWu0RFjzGWn4ZptDfTdoCF3JR205V5ncheuLTyp8QhzT3N
 d+jU9IzskuT3TQ2WBGZL4OdVsjOiJ3LT1plcmjSb5InYJwA4cjSTknwu4XchnMol
 hX9bPfozZML8SgYrpZ9wv9OQ+DsU81Tx+FUStceUhcE6PrG0vq4M9YOStZqCB+6A
 QQRodq32N81IqiY2UaSdQ==
X-ME-Sender: <xms:aq98atMCqfwYMnHQFfkHx-pngw_x2gVc0evK11iGTTDYSZLygaVEGg>
 <xme:aq98ak57kA4MBpVt2IZBCKnD7aJ5Mw3b3db7I8868_PnM30nUlG1SqYEarErb7gYX
 qEHu2LFcYYKiDvmIngDl7loVjWQGnKR3v5BXVoaxrhtEdPr95-5y7I>
X-ME-Received: <xmr:aq98agjEtNMCPuovb9_ZpraJ7AngeEgzSTsRC8d5ZFmVM5F03G8Y7WBO4lsD6zcCfFPLeQ>
X-ME-Proxy-Cause: dmFkZTEpdxtlJcH8y629L9HlOpJV3z1Q+DidclQA9PPPEyQFDKPm7mcd8PRFlqK//p0tEQ
 nvab63FA5QZyFk+GI+1OBa4/JoFXEjlUM1f3I3roLaRutzbpe56vHzVe8uBu5L33oo6ApI
 MkAAtSyz4OEs6NclByyXbBfcn/EglJYWuioRUCvFPkYaG9U5PTy/R2Ga4gqO701alneZtB
 KTrUpjijUcfjvs0UPP7NiO41tvf63HOUahJiDDzMe+wpSG5xiWkIppobYJ1tkO78mqK/qN
 wodmEB4pn531L1Dl/eWpXiO/0Wszb9PTtsjd24ex94Zm0xKkvZmdXW3UQokoGx4AmpLklV
 kee1PGRRnJ59O/h0/p7YHJGQJZJls5+Qi5XzwE3pGW6LdkHKZzHkCcLJwlgH89uGgKnnXq
 E+YknDQHRyGKZCoIs1NfMVbFS0JyQSdj/ZxxTxEX369JOSZ18TdR1la1iyreFyunmRfLm8
 IL/YVDoxaZDshf/3hccTGFe8nRJ9TK4fFgPEEWkwBqpuJc1DXfA8XqZO1gbC/l5zzMX1bt
 yk0hMnlb3QS7oBo/6NJWGbbr3lVw2WOQ3tNS5V681vJpwpmvL1QymWhN6OI16mDFgFIP/m
 SlGQJkZEcKwc7YQKf3CeydasQ5bJljPutyZ6fp3TEbTh35ZnTGwYSMwApNgw
X-ME-Proxy: <xmx:aq98apddGEXu7nScxQg9JfHY8e9r_A4rO8QyY7yC2BjavHL7BdrGWg>
 <xmx:aq98aox_sFFtAY0miwSBaYEmecOWTTqclre2hXvW3ZKd5ETPKU71KQ>
 <xmx:aq98ao39mc_OwYBLbSEx5HAv7UrwYvg9htB2Ohvd-2WANQO6G-EAJQ>
 <xmx:aq98auzb_zXu4p5aehMCbg6TtLOkdFPTR-1Fl-31UlLOiuJJjlG0lw>
 <xmx:aq98amCVRqsdPkUc5hSsmUWD7S_QyeIEpZK1arAMOVs0S7HQ6rdT7wdP>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 13:37:45 -0400 (EDT)
Message-ID: <7158fba9335dcac98b289b8f6b4a3e4c26aa2432.camel@alistair23.me>
Subject: Re: [PATCH 1/2] riscv: csr: do not drop C bit on misa write
From: Alistair <alistair@alistair23.me>
To: Vladimir Isaev <vvisaev@gmail.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, qemu-riscv@nongnu.org
Date: Thu, 13 Aug 2026 03:37:45 +1000
In-Reply-To: <20260806133755.45924-1-vvisaev@gmail.com>
References: <20260806133755.45924-1-vvisaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.144;
 envelope-from=alistair@alistair23.me; helo=fout-a1-smtp.messagingengine.com
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

On Thu, 2026-08-06 at 16:37 +0300, Vladimir Isaev wrote:
> According to spec:
> > Writing misa may increase IALIGN, e.g., by disabling the "C"
> > extension.
> > If an instruction that would write misa increases IALIGN, and the
> > subsequent instruction=E2=80=99s address is not IALIGN-bit aligned, the
> > write to misa is suppressed, leaving misa unchanged.
>=20
> So attempt to disable C extension if next instruction is not aligned
> should not
> change the misa.
>=20
> Signed-off-by: Vladimir Isaev <vvisaev@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for the patches.

Can you please re-send the series with a cover-letter. All multi-patch
series should have a cover letter

Alistair

> ---
> =C2=A0target/riscv/tcg/csr.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 36f2004bc5..58c206c1fa 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2182,9 +2182,10 @@ static RISCVException write_misa(CPURISCVState
> *env, int csrno,
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Mask extensions that are not supported by thi=
s hart */
> =C2=A0=C2=A0=C2=A0=C2=A0 val &=3D env->misa_ext_mask;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* Suppress 'C' if next instruction is not aligned. *=
/
> -=C2=A0=C2=A0=C2=A0 if ((val & RVC) && (get_next_pc(env, ra) & 3) !=3D 0)=
 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val &=3D ~RVC;
> +=C2=A0=C2=A0=C2=A0 /* drop write if RVC is cleared and next instruction =
is not
> aligned */
> +=C2=A0=C2=A0=C2=A0 if ((env->misa_ext & RVC) && !(val & RVC) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (get_next_pc(env, ra) &=
 3) !=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return RISCV_EXCP_NONE;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /* Disable RVG if any of its dependencies are di=
sabled */

