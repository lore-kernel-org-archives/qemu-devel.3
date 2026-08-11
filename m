Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCAFC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 19:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtsZW-00035O-1O; Tue, 11 Aug 2026 15:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsZU-00033f-4z; Tue, 11 Aug 2026 15:55:36 -0400
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wtsZS-0008TJ-O8; Tue, 11 Aug 2026 15:55:35 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 5CD13EC018C;
 Tue, 11 Aug 2026 15:55:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 15:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786478133; x=1786564533; bh=Sbs5iSfOvhLuW1aXdsBamoGvFfIN0n2K
 endZL8W5cdU=; b=Smg0NrRgNFBRYZErcq3OSRo05uMzjZWhqDNmDgxaHceXwfC6
 PdDgk2Bpq1aPuwAlGGmFWKdgkUz3knV2Ooybcie2G6DaDgndN92HOynys+/bmPd8
 Vc4n7JyueOEAWEpfZu1Ynz51nbbCETJWO+0ZYfR9AARKqRomOxAUUe6OAEahsHyw
 Y70iG3DYVRLzL233IcF8/HHT8HFRMdqs4XtTrlSqPhIbckZ7NwsBsQAGcnEZyb0S
 SiHvYBvorvU3vNoOjHru5AxfElkFWQ5MDYL9X/SYVnBlTdl7TZHZ/EiJLyKJ+GM4
 z55IZNwyDOLeCzH4k/89xOkUFo8Z5k1AKu3EjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786478133; x=
 1786564533; bh=Sbs5iSfOvhLuW1aXdsBamoGvFfIN0n2KendZL8W5cdU=; b=G
 iEMG+9RTLtmbuwJwYSNt7ChEOCDi9PBtjpmNQ7ecHLXl5i0D6lt6WTIR0Wn1Eile
 cSa45QVZW6JAUOYx5MwypQmBAdguadD29nHyi4dFapg2oB+0MVR6De0ywHB8Z3/I
 gpxyLK8ylQDg5GJnGvcD0rOlfG7X7VhccJ4Ggvo2ZqceZ40odK0xRESD86ey1Cpe
 kFCqwnRgvDOGt1WdT3Lf7qk+OfDazZhTbpU1/zTyFfu++8vTriKlDR2/VoNBHfdB
 lCtjpXGk1c14Q94D365EdlM0BdM3K3L/9Kf8lygHTpQOErds6U+Z2kCPFSXVJlp8
 jXcA7Vy5dN2z1xOsKi9UQ==
X-ME-Sender: <xms:NX57ans2LC9TZ7KxfVcG9hs-V0-_aqr9A32nlauRHaH_y9oEd7B4sw>
 <xme:NX57aigUdwSOiPlYus0kZqpfhv95QF6izC_vjVo7OlxVsKCg6RMMX9VLp9uoi3rG0
 X2If9x6FJ55X4iP53enUOsNIDM5VSJYFaiiqmItFnydfKW-DvUj0PI>
X-ME-Received: <xmr:NX57aqrgiZsodh4IcMoP6su1UFBvsHe4pvTb8y0LISgo4_t5EE_7yL_rluqBlkrBZgfX0w>
X-ME-Proxy-Cause: dmFkZTEB4uVtOxVe4d9WBsZvAXvDQ0lWasxeAp8qgXwRxNQKWNSEE/pEDDvZrXP2l+MI8W
 NMOflSCe4kstXPSM9r9vWBLjSt1tlaHH450BatbM9FtZMGB5GT0z9M/Gg30M+QTDdooYa+
 8ZGtv9b1YcioS+4KeJlbl7GCIA7D8uWUqo4iESl5xISWijXhsDUr7DVLiN1gb7twR4kzpv
 i9ZJciJyR3sSlNQ+36DJO5L6KsOOPydMifMMftR5AXQ864HZW2RsY12xFkDoglCiVnjdog
 RGUEfgO6RVBI0Xzvt7E1GiHnrXcL527QLKAHkMBylLX7yRCGXdezXw7/DVnemhoWC6oiK/
 9Pj/5oA+aN58sM5uFRIixrWTaWHCZ/PxsJSK+KigyCJyobw8txG9i85UH4UArdm/V4syU2
 DYdi8aqehckCCxcVUVJKtehOORflHeXa/mNW/sQWOfsaScw0vV3PHONJUQlzE7pih2zjAT
 Lc0MD6CTJvih8V705wI6VRSmmbQcY6lvCmfEZwNMsjE+0I5rJpue+Unr6LBNXNiPNO+HJZ
 SgPR+awrPuLfzFzgpvICyI2Z7DPZMPzEztb3jsx2PxAB5DihifpdGOUs1WLIomP1xwafiV
 aE0Dk9R0P+jkD2nL2iyIX09BYRmBy+sQVs2qYc04bG99fth4kIO6LOndXFIg
X-ME-Proxy: <xmx:NX57antfrjDFuvg2n28kPOJu0EI3-YcKNJKrCjgS0LH8Xht5b2sIfQ>
 <xmx:NX57albn96ZupWXGv82wa0I_-acMPnzUPSki8q4FHpdf1ctTGRHBAg>
 <xmx:NX57ambhlR27SiLCWlnvxO31eiLjcQSkZXytpO1xBXTbV0ULuLhUiw>
 <xmx:NX57aukqmafVSFXuw3P9VcRHU2w8KKgyH8aW-iGeDgTJvp9iyWM00A>
 <xmx:NX57apkN8Q0EU_ehG4edwCkHWF7rOqX_JkhPMVNfRMUWCU9XacYqNK6M>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 15:55:32 -0400 (EDT)
Message-ID: <a693fc0a74bc2065f62617e571370810f3f4fccc.camel@alistair23.me>
Subject: Re: [PATCH 02/56] disas/riscv: Fix 6-bit immediate extraction
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>, Alex
 =?ISO-8859-1?Q?Benn=E9e?=	 <alex.bennee@linaro.org>, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 05:55:32 +1000
In-Reply-To: <20260809223545.730664-3-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=alistair@alistair23.me; helo=fout-a7-smtp.messagingengine.com
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

On Sun, 2026-08-09 at 15:34 -0700, Richard Henderson wrote:
> From: TANG Tiancheng <lyndra@linux.alibaba.com>
>=20
> rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
> immediate field is encoded in bits 25:20. The old expression
> left-shifted by 38 and then right-shifted by 60, so it kept only
> bits 25:22.
>=20
> Use extract32() to decode bits 25:20 directly. This fixes the
> immediate printed for th.srri and th.tst.
>=20
> Fixes: 318df7238b9f ("disas/riscv: Add support for XThead*
> instructions")
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com>
> Message-Id:
> <20260703-b4-disas-xthead-fix-riscv-next-v4-2-84c566330bc7@linux.alib
> aba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 7f1b262773..fdf75a12ef 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst
> inst)
> =C2=A0
> =C2=A0static uint32_t operand_imm6(rv_inst inst)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 return (inst << 38) >> 60;
> +=C2=A0=C2=A0=C2=A0 return extract32(inst, 20, 6);
> =C2=A0}
> =C2=A0
> =C2=A0static uint32_t operand_imm2(rv_inst inst)

