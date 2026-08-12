Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA23AC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8VA-0003us-RA; Wed, 12 Aug 2026 08:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8V9-0003uQ-He; Wed, 12 Aug 2026 08:56:11 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8V2-0002GG-DZ; Wed, 12 Aug 2026 08:56:11 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 4E746140004A;
 Wed, 12 Aug 2026 08:55:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 12 Aug 2026 08:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539352; x=1786625752; bh=vdLeFOFoE359xUy4D8UxENW/u77zb1UT
 K09t6d9WRTs=; b=jlr9PoAAObiiHnYSizXqHDZj4hQmOgIl0bncG9ZSLnWbZlQt
 up5xueUV0vCLXKHR5WBPfPQeim4U1MkDuAnMF+DpZIzYgsF05auXJBfhOomfYmAT
 NdRllkSYDzkRl9W/KT/Jc6Ys+GWVopkOkpL+5CaafX93LQSuBjwbFDexBP76E96T
 pxNvv3eq+88GEYxYwF2fWe8oFYWN/7ZRg29LRIh3o3mVY67PSX077ShClDigPNCh
 BeCiO70chAJioPTVxowCcQq0355yNECMJvMMs0By5FzoxhQ/upiehB5BaCVR4qcx
 Ru1FOHUgs0O2DCeIx/fTeQSEdvo3qM/at5b6CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539352; x=
 1786625752; bh=vdLeFOFoE359xUy4D8UxENW/u77zb1UTK09t6d9WRTs=; b=M
 FkMGqu06ylIJNQEalTsTW17UalUHcKhIO4Yv0Tqt9LJpTRjF1HcMZqUgwsCMqXlY
 z+YnY//Km4PAq1I7QzpBZsQ8kMxwifdCuUm1VKGn2Ko7pRrXPSBvKLkw5UZhGc3Z
 wF8qhg/+amgoEQYFKQvECvuCop52j15ByJs0RHz1rEqyPaa49FJNQPI/fibcX9kH
 aJ0UJZLQcLqUKVmnj9ZukDyk0mrPk1cPEH85ZpokDM7cx4jhHk4aZCs1yHX59HiZ
 7a5f7LjEIEUAK7Sq1YEhHt/TDkdivhoy7nfTE2QsT6RRLo/EsnMPtI9YmR185Csf
 CTrI0/JvYlO3PdqhrN22g==
X-ME-Sender: <xms:WG18apPViDaLQfVVCiX7yKozasBkee_m9bpQVSxk327MSJcLrA87xw>
 <xme:WG18agTtQCOGE57OJbjWlDRGOui9lj8cvDbY-efj4fURcff2RvABB5bgW293xYNoU
 5VbutQGPO8bbfFKdKDsVf_6sBxoNOxSE36qM73Z01CYV3Ufd_hj98Nf>
X-ME-Received: <xmr:WG18anY12yrHzbHWFh4RuQkINp9SiM6LJPdGPXl3qH2M4iIbDJkroOsXwyPcqTM8vTg3ow>
X-ME-Proxy-Cause: dmFkZTFBl8NfP07YVm2uEj56aKFTjJ5PpdZmd1UCTIPFKX5NUa/2gqY4/xBVLKw0nNGzLb
 KjqAAr20ASfj07WNPGAOVDB/bQS3vGh1LEG6Jzfk63lG2qhdTHTFDngWd/WvFd+c4JFxq/
 0hPHgSkFgdDQ6ZUO5wTwyBLrtevOTWi6jdSSiG8IxRz/3xTHjpJ/zei2QEDas+X2tw4SL4
 bbyeIlKQJ01TQTlXyddau2VfhIAVstTMm79qOEyIDNCGYzKdAjdu7q1maKARN2lGu8Qi/V
 E065oEYqd1/GrmZSxyQU4GA90m/qeFg3lFo4yhw4XEgWv9UsYHcZge6g4NNqFJ2Ay7V/JS
 n6PnlzhFC+ohoJDjiQzm2cYRCPsS6SIWhyR/mpviAtGxIRFdoOFD9i7Urrl/jQB54fhPSo
 D1TzjacroKUChmSod/FwexYHo7NflS7FLS0QebzNplx0mTEzJUkwILKIFkfi6tMkMvPFoV
 MBpXZPqJyE771Z/c1ZBwUaUBTfO/GCXrrcZ5v53WQLsvIQrp/3/nCpUgWLRW4J+h1TNPnF
 WNZspaTVM2XUhoKvip0TDkd39m72U1vxbYaVBJpNaZQTMkkYfvTp0lBtrBVDF0Ip1Xjv2z
 /ZfKXDRqnwc5+98Iikd8C2S59vDqt9SxmmtxBA4d67y0TA4jjInP8UUtEF+g
X-ME-Proxy: <xmx:WG18at2-938mpOfC45iNFywQ7i17j0EQ9kLSKVrZGOTXU4z7nFfxag>
 <xmx:WG18anXaMOAWATvUMEd4X3UFuCc3TaYKo5pb3C3L4VNmHHKIvRlIbw>
 <xmx:WG18anWluBtnzTKN3RxwZjI2yqi7KO3vLd9P2txb9ExWQHq5zrhhxA>
 <xmx:WG18amcMgxqnxAIcpOmbLUnMf9RuYpyrFCJVI2Qq20Eu21345LVLGw>
 <xmx:WG18avR8hzWnhrER-BiWLdpRF7G3NhmxCyIConk59rC8kyVbgSdnfuWE>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:55:51 -0400 (EDT)
Message-ID: <91270f7793255f71bb1bdcebb89d616724c848eb.camel@alistair23.me>
Subject: Re: [PATCH 49/56] disas/riscv: Split out riscv-op.c.inc
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:55:51 +1000
In-Reply-To: <20260809223545.730664-50-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-50-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
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
> Move rvi_opcode_data to riscv-op.c.inc and massage
> the lines into OP() form.=C2=A0 Unlike other files, keep
> the enumeration and the table intact for now, but
> build them both from the same source.
>=20
> Adjust the names of rv_*mop to include _op_ to match
> the general pattern.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1931 +---=
------------------------------------
> --
> =C2=A0disas/riscv-op.c.inc |=C2=A0 958 +++++++++++++++++++++
> =C2=A02 files changed, 967 insertions(+), 1922 deletions(-)
> =C2=A0create mode 100644 disas/riscv-op.c.inc
>=20
> diff --git a/disas/riscv.c b/disas/riscv.c
> index f0b3bc6be7..9dad56b486 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -29,964 +29,9 @@
> =C2=A0#include "disas/riscv-xlrbr.h"
> =C2=A0
> =C2=A0typedef enum {
> -=C2=A0=C2=A0=C2=A0 rv_op_illegal =3D 0,
> -=C2=A0=C2=A0=C2=A0 rv_op_lui =3D 1,
> -=C2=A0=C2=A0=C2=A0 rv_op_auipc =3D 2,
> -=C2=A0=C2=A0=C2=A0 rv_op_jal =3D 3,
> -=C2=A0=C2=A0=C2=A0 rv_op_jalr =3D 4,
> -=C2=A0=C2=A0=C2=A0 rv_op_beq =3D 5,
> -=C2=A0=C2=A0=C2=A0 rv_op_bne =3D 6,
> -=C2=A0=C2=A0=C2=A0 rv_op_blt =3D 7,
> -=C2=A0=C2=A0=C2=A0 rv_op_bge =3D 8,
> -=C2=A0=C2=A0=C2=A0 rv_op_bltu =3D 9,
> -=C2=A0=C2=A0=C2=A0 rv_op_bgeu =3D 10,
> -=C2=A0=C2=A0=C2=A0 rv_op_lb =3D 11,
> -=C2=A0=C2=A0=C2=A0 rv_op_lh =3D 12,
> -=C2=A0=C2=A0=C2=A0 rv_op_lw =3D 13,
> -=C2=A0=C2=A0=C2=A0 rv_op_lbu =3D 14,
> -=C2=A0=C2=A0=C2=A0 rv_op_lhu =3D 15,
> -=C2=A0=C2=A0=C2=A0 rv_op_sb =3D 16,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh =3D 17,
> -=C2=A0=C2=A0=C2=A0 rv_op_sw =3D 18,
> -=C2=A0=C2=A0=C2=A0 rv_op_addi =3D 19,
> -=C2=A0=C2=A0=C2=A0 rv_op_slti =3D 20,
> -=C2=A0=C2=A0=C2=A0 rv_op_sltiu =3D 21,
> -=C2=A0=C2=A0=C2=A0 rv_op_xori =3D 22,
> -=C2=A0=C2=A0=C2=A0 rv_op_ori =3D 23,
> -=C2=A0=C2=A0=C2=A0 rv_op_andi =3D 24,
> -=C2=A0=C2=A0=C2=A0 rv_op_slli =3D 25,
> -=C2=A0=C2=A0=C2=A0 rv_op_srli =3D 26,
> -=C2=A0=C2=A0=C2=A0 rv_op_srai =3D 27,
> -=C2=A0=C2=A0=C2=A0 rv_op_add =3D 28,
> -=C2=A0=C2=A0=C2=A0 rv_op_sub =3D 29,
> -=C2=A0=C2=A0=C2=A0 rv_op_sll =3D 30,
> -=C2=A0=C2=A0=C2=A0 rv_op_slt =3D 31,
> -=C2=A0=C2=A0=C2=A0 rv_op_sltu =3D 32,
> -=C2=A0=C2=A0=C2=A0 rv_op_xor =3D 33,
> -=C2=A0=C2=A0=C2=A0 rv_op_srl =3D 34,
> -=C2=A0=C2=A0=C2=A0 rv_op_sra =3D 35,
> -=C2=A0=C2=A0=C2=A0 rv_op_or =3D 36,
> -=C2=A0=C2=A0=C2=A0 rv_op_and =3D 37,
> -=C2=A0=C2=A0=C2=A0 rv_op_fence =3D 38,
> -=C2=A0=C2=A0=C2=A0 rv_op_fence_i =3D 39,
> -=C2=A0=C2=A0=C2=A0 rv_op_lwu =3D 40,
> -=C2=A0=C2=A0=C2=A0 rv_op_ld =3D 41,
> -=C2=A0=C2=A0=C2=A0 rv_op_sd =3D 42,
> -=C2=A0=C2=A0=C2=A0 rv_op_addiw =3D 43,
> -=C2=A0=C2=A0=C2=A0 rv_op_slliw =3D 44,
> -=C2=A0=C2=A0=C2=A0 rv_op_srliw =3D 45,
> -=C2=A0=C2=A0=C2=A0 rv_op_sraiw =3D 46,
> -=C2=A0=C2=A0=C2=A0 rv_op_addw =3D 47,
> -=C2=A0=C2=A0=C2=A0 rv_op_subw =3D 48,
> -=C2=A0=C2=A0=C2=A0 rv_op_sllw =3D 49,
> -=C2=A0=C2=A0=C2=A0 rv_op_srlw =3D 50,
> -=C2=A0=C2=A0=C2=A0 rv_op_sraw =3D 51,
> -=C2=A0=C2=A0=C2=A0 rv_op_ldu =3D 52,
> -=C2=A0=C2=A0=C2=A0 rv_op_lq =3D 53,
> -=C2=A0=C2=A0=C2=A0 rv_op_sq =3D 54,
> -=C2=A0=C2=A0=C2=A0 rv_op_addid =3D 55,
> -=C2=A0=C2=A0=C2=A0 rv_op_sllid =3D 56,
> -=C2=A0=C2=A0=C2=A0 rv_op_srlid =3D 57,
> -=C2=A0=C2=A0=C2=A0 rv_op_sraid =3D 58,
> -=C2=A0=C2=A0=C2=A0 rv_op_addd =3D 59,
> -=C2=A0=C2=A0=C2=A0 rv_op_subd =3D 60,
> -=C2=A0=C2=A0=C2=A0 rv_op_slld =3D 61,
> -=C2=A0=C2=A0=C2=A0 rv_op_srld =3D 62,
> -=C2=A0=C2=A0=C2=A0 rv_op_srad =3D 63,
> -=C2=A0=C2=A0=C2=A0 rv_op_mul =3D 64,
> -=C2=A0=C2=A0=C2=A0 rv_op_mulh =3D 65,
> -=C2=A0=C2=A0=C2=A0 rv_op_mulhsu =3D 66,
> -=C2=A0=C2=A0=C2=A0 rv_op_mulhu =3D 67,
> -=C2=A0=C2=A0=C2=A0 rv_op_div =3D 68,
> -=C2=A0=C2=A0=C2=A0 rv_op_divu =3D 69,
> -=C2=A0=C2=A0=C2=A0 rv_op_rem =3D 70,
> -=C2=A0=C2=A0=C2=A0 rv_op_remu =3D 71,
> -=C2=A0=C2=A0=C2=A0 rv_op_mulw =3D 72,
> -=C2=A0=C2=A0=C2=A0 rv_op_divw =3D 73,
> -=C2=A0=C2=A0=C2=A0 rv_op_divuw =3D 74,
> -=C2=A0=C2=A0=C2=A0 rv_op_remw =3D 75,
> -=C2=A0=C2=A0=C2=A0 rv_op_remuw =3D 76,
> -=C2=A0=C2=A0=C2=A0 rv_op_muld =3D 77,
> -=C2=A0=C2=A0=C2=A0 rv_op_divd =3D 78,
> -=C2=A0=C2=A0=C2=A0 rv_op_divud =3D 79,
> -=C2=A0=C2=A0=C2=A0 rv_op_remd =3D 80,
> -=C2=A0=C2=A0=C2=A0 rv_op_remud =3D 81,
> -=C2=A0=C2=A0=C2=A0 rv_op_lr_w =3D 82,
> -=C2=A0=C2=A0=C2=A0 rv_op_sc_w =3D 83,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoswap_w =3D 84,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoadd_w =3D 85,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoxor_w =3D 86,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoor_w =3D 87,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoand_w =3D 88,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomin_w =3D 89,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomax_w =3D 90,
> -=C2=A0=C2=A0=C2=A0 rv_op_amominu_w =3D 91,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomaxu_w =3D 92,
> -=C2=A0=C2=A0=C2=A0 rv_op_lr_d =3D 93,
> -=C2=A0=C2=A0=C2=A0 rv_op_sc_d =3D 94,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoswap_d =3D 95,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoadd_d =3D 96,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoxor_d =3D 97,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoor_d =3D 98,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoand_d =3D 99,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomin_d =3D 100,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomax_d =3D 101,
> -=C2=A0=C2=A0=C2=A0 rv_op_amominu_d =3D 102,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomaxu_d =3D 103,
> -=C2=A0=C2=A0=C2=A0 rv_op_lr_q =3D 104,
> -=C2=A0=C2=A0=C2=A0 rv_op_sc_q =3D 105,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoswap_q =3D 106,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoadd_q =3D 107,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoxor_q =3D 108,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoor_q =3D 109,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoand_q =3D 110,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomin_q =3D 111,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomax_q =3D 112,
> -=C2=A0=C2=A0=C2=A0 rv_op_amominu_q =3D 113,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomaxu_q =3D 114,
> -=C2=A0=C2=A0=C2=A0 rv_op_ecall =3D 115,
> -=C2=A0=C2=A0=C2=A0 rv_op_ebreak =3D 116,
> -=C2=A0=C2=A0=C2=A0 rv_op_uret =3D 117,
> -=C2=A0=C2=A0=C2=A0 rv_op_sret =3D 118,
> -=C2=A0=C2=A0=C2=A0 rv_op_hret =3D 119,
> -=C2=A0=C2=A0=C2=A0 rv_op_mret =3D 120,
> -=C2=A0=C2=A0=C2=A0 rv_op_dret =3D 121,
> -=C2=A0=C2=A0=C2=A0 rv_op_sfence_vm =3D 122,
> -=C2=A0=C2=A0=C2=A0 rv_op_sfence_vma =3D 123,
> -=C2=A0=C2=A0=C2=A0 rv_op_wfi =3D 124,
> -=C2=A0=C2=A0=C2=A0 rv_op_csrrw =3D 125,
> -=C2=A0=C2=A0=C2=A0 rv_op_csrrs =3D 126,
> -=C2=A0=C2=A0=C2=A0 rv_op_csrrc =3D 127,
> -=C2=A0=C2=A0=C2=A0 rv_op_csrrwi =3D 128,
> -=C2=A0=C2=A0=C2=A0 rv_op_csrrsi =3D 129,
> -=C2=A0=C2=A0=C2=A0 rv_op_csrrci =3D 130,
> -=C2=A0=C2=A0=C2=A0 rv_op_flw =3D 131,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsw =3D 132,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmadd_s =3D 133,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmsub_s =3D 134,
> -=C2=A0=C2=A0=C2=A0 rv_op_fnmsub_s =3D 135,
> -=C2=A0=C2=A0=C2=A0 rv_op_fnmadd_s =3D 136,
> -=C2=A0=C2=A0=C2=A0 rv_op_fadd_s =3D 137,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsub_s =3D 138,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmul_s =3D 139,
> -=C2=A0=C2=A0=C2=A0 rv_op_fdiv_s =3D 140,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnj_s =3D 141,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnjn_s =3D 142,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnjx_s =3D 143,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmin_s =3D 144,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmax_s =3D 145,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsqrt_s =3D 146,
> -=C2=A0=C2=A0=C2=A0 rv_op_fle_s =3D 147,
> -=C2=A0=C2=A0=C2=A0 rv_op_flt_s =3D 148,
> -=C2=A0=C2=A0=C2=A0 rv_op_feq_s =3D 149,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_w_s =3D 150,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_wu_s =3D 151,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_w =3D 152,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_wu =3D 153,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_x_s =3D 154,
> -=C2=A0=C2=A0=C2=A0 rv_op_fclass_s =3D 155,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_s_x =3D 156,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_l_s =3D 157,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_lu_s =3D 158,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_l =3D 159,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_lu =3D 160,
> -=C2=A0=C2=A0=C2=A0 rv_op_fld =3D 161,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsd =3D 162,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmadd_d =3D 163,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmsub_d =3D 164,
> -=C2=A0=C2=A0=C2=A0 rv_op_fnmsub_d =3D 165,
> -=C2=A0=C2=A0=C2=A0 rv_op_fnmadd_d =3D 166,
> -=C2=A0=C2=A0=C2=A0 rv_op_fadd_d =3D 167,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsub_d =3D 168,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmul_d =3D 169,
> -=C2=A0=C2=A0=C2=A0 rv_op_fdiv_d =3D 170,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnj_d =3D 171,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnjn_d =3D 172,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnjx_d =3D 173,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmin_d =3D 174,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmax_d =3D 175,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_d =3D 176,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_d_s =3D 177,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsqrt_d =3D 178,
> -=C2=A0=C2=A0=C2=A0 rv_op_fle_d =3D 179,
> -=C2=A0=C2=A0=C2=A0 rv_op_flt_d =3D 180,
> -=C2=A0=C2=A0=C2=A0 rv_op_feq_d =3D 181,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_w_d =3D 182,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_wu_d =3D 183,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_d_w =3D 184,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_d_wu =3D 185,
> -=C2=A0=C2=A0=C2=A0 rv_op_fclass_d =3D 186,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_l_d =3D 187,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_lu_d =3D 188,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_x_d =3D 189,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_d_l =3D 190,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_d_lu =3D 191,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_d_x =3D 192,
> -=C2=A0=C2=A0=C2=A0 rv_op_flq =3D 193,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsq =3D 194,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmadd_q =3D 195,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmsub_q =3D 196,
> -=C2=A0=C2=A0=C2=A0 rv_op_fnmsub_q =3D 197,
> -=C2=A0=C2=A0=C2=A0 rv_op_fnmadd_q =3D 198,
> -=C2=A0=C2=A0=C2=A0 rv_op_fadd_q =3D 199,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsub_q =3D 200,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmul_q =3D 201,
> -=C2=A0=C2=A0=C2=A0 rv_op_fdiv_q =3D 202,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnj_q =3D 203,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnjn_q =3D 204,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsgnjx_q =3D 205,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmin_q =3D 206,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmax_q =3D 207,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_q =3D 208,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_q_s =3D 209,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_d_q =3D 210,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_q_d =3D 211,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsqrt_q =3D 212,
> -=C2=A0=C2=A0=C2=A0 rv_op_fle_q =3D 213,
> -=C2=A0=C2=A0=C2=A0 rv_op_flt_q =3D 214,
> -=C2=A0=C2=A0=C2=A0 rv_op_feq_q =3D 215,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_w_q =3D 216,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_wu_q =3D 217,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_q_w =3D 218,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_q_wu =3D 219,
> -=C2=A0=C2=A0=C2=A0 rv_op_fclass_q =3D 220,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_l_q =3D 221,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_lu_q =3D 222,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_q_l =3D 223,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_q_lu =3D 224,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_x_q =3D 225,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_q_x =3D 226,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_addi4spn =3D 227,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_fld =3D 228,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lw =3D 229,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_flw =3D 230,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_fsd =3D 231,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sw =3D 232,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_fsw =3D 233,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_addi =3D 235,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_jal =3D 236,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_li =3D 237,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_addi16sp =3D 238,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lui =3D 239,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_srli =3D 240,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_srai =3D 241,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_andi =3D 242,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sub =3D 243,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_xor =3D 244,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_or =3D 245,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_and =3D 246,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_subw =3D 247,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_addw =3D 248,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_j =3D 249,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_beqz =3D 250,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_bnez =3D 251,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_slli =3D 252,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_fldsp =3D 253,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lwsp =3D 254,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_flwsp =3D 255,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_jr =3D 256,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_mv =3D 257,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_ebreak =3D 258,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_jalr =3D 259,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_add =3D 260,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_fsdsp =3D 261,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_swsp =3D 262,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_fswsp =3D 263,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_ld =3D 264,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sd =3D 265,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_addiw =3D 266,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_ldsp =3D 267,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sdsp =3D 268,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lq =3D 269,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sq =3D 270,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lqsp =3D 271,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sqsp =3D 272,
> -=C2=A0=C2=A0=C2=A0 rv_op_nop =3D 273,
> -=C2=A0=C2=A0=C2=A0 rv_op_mv =3D 274,
> -=C2=A0=C2=A0=C2=A0 rv_op_not =3D 275,
> -=C2=A0=C2=A0=C2=A0 rv_op_neg =3D 276,
> -=C2=A0=C2=A0=C2=A0 rv_op_negw =3D 277,
> -=C2=A0=C2=A0=C2=A0 rv_op_sext_w =3D 278,
> -=C2=A0=C2=A0=C2=A0 rv_op_seqz =3D 279,
> -=C2=A0=C2=A0=C2=A0 rv_op_snez =3D 280,
> -=C2=A0=C2=A0=C2=A0 rv_op_sltz =3D 281,
> -=C2=A0=C2=A0=C2=A0 rv_op_sgtz =3D 282,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_s =3D 283,
> -=C2=A0=C2=A0=C2=A0 rv_op_fabs_s =3D 284,
> -=C2=A0=C2=A0=C2=A0 rv_op_fneg_s =3D 285,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_d =3D 286,
> -=C2=A0=C2=A0=C2=A0 rv_op_fabs_d =3D 287,
> -=C2=A0=C2=A0=C2=A0 rv_op_fneg_d =3D 288,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_q =3D 289,
> -=C2=A0=C2=A0=C2=A0 rv_op_fabs_q =3D 290,
> -=C2=A0=C2=A0=C2=A0 rv_op_fneg_q =3D 291,
> -=C2=A0=C2=A0=C2=A0 rv_op_beqz =3D 292,
> -=C2=A0=C2=A0=C2=A0 rv_op_bnez =3D 293,
> -=C2=A0=C2=A0=C2=A0 rv_op_blez =3D 294,
> -=C2=A0=C2=A0=C2=A0 rv_op_bgez =3D 295,
> -=C2=A0=C2=A0=C2=A0 rv_op_bltz =3D 296,
> -=C2=A0=C2=A0=C2=A0 rv_op_bgtz =3D 297,
> -=C2=A0=C2=A0=C2=A0 rv_op_jal_ra =3D 298,
> -=C2=A0=C2=A0=C2=A0 rv_op_jalr_ra =3D 299,
> -=C2=A0=C2=A0=C2=A0 rv_op_j =3D 302,
> -=C2=A0=C2=A0=C2=A0 rv_op_ret =3D 303,
> -=C2=A0=C2=A0=C2=A0 rv_op_jr =3D 304,
> -=C2=A0=C2=A0=C2=A0 rv_op_rdcycle =3D 305,
> -=C2=A0=C2=A0=C2=A0 rv_op_rdtime =3D 306,
> -=C2=A0=C2=A0=C2=A0 rv_op_rdinstret =3D 307,
> -=C2=A0=C2=A0=C2=A0 rv_op_rdcycleh =3D 308,
> -=C2=A0=C2=A0=C2=A0 rv_op_rdtimeh =3D 309,
> -=C2=A0=C2=A0=C2=A0 rv_op_rdinstreth =3D 310,
> -=C2=A0=C2=A0=C2=A0 rv_op_frcsr =3D 311,
> -=C2=A0=C2=A0=C2=A0 rv_op_frrm =3D 312,
> -=C2=A0=C2=A0=C2=A0 rv_op_frflags =3D 313,
> -=C2=A0=C2=A0=C2=A0 rv_op_fscsr =3D 314,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsrm =3D 315,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsflags =3D 316,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsrmi =3D 317,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsflagsi =3D 318,
> -=C2=A0=C2=A0=C2=A0 rv_op_bseti =3D 319,
> -=C2=A0=C2=A0=C2=A0 rv_op_bclri =3D 320,
> -=C2=A0=C2=A0=C2=A0 rv_op_binvi =3D 321,
> -=C2=A0=C2=A0=C2=A0 rv_op_bexti =3D 322,
> -=C2=A0=C2=A0=C2=A0 rv_op_rori =3D 323,
> -=C2=A0=C2=A0=C2=A0 rv_op_clz =3D 324,
> -=C2=A0=C2=A0=C2=A0 rv_op_ctz =3D 325,
> -=C2=A0=C2=A0=C2=A0 rv_op_cpop =3D 326,
> -=C2=A0=C2=A0=C2=A0 rv_op_sext_h =3D 327,
> -=C2=A0=C2=A0=C2=A0 rv_op_sext_b =3D 328,
> -=C2=A0=C2=A0=C2=A0 rv_op_xnor =3D 329,
> -=C2=A0=C2=A0=C2=A0 rv_op_orn =3D 330,
> -=C2=A0=C2=A0=C2=A0 rv_op_andn =3D 331,
> -=C2=A0=C2=A0=C2=A0 rv_op_rol =3D 332,
> -=C2=A0=C2=A0=C2=A0 rv_op_ror =3D 333,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh1add =3D 334,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh2add =3D 335,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh3add =3D 336,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh1add_uw =3D 337,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh2add_uw =3D 338,
> -=C2=A0=C2=A0=C2=A0 rv_op_sh3add_uw =3D 339,
> -=C2=A0=C2=A0=C2=A0 rv_op_clmul =3D 340,
> -=C2=A0=C2=A0=C2=A0 rv_op_clmulr =3D 341,
> -=C2=A0=C2=A0=C2=A0 rv_op_clmulh =3D 342,
> -=C2=A0=C2=A0=C2=A0 rv_op_min =3D 343,
> -=C2=A0=C2=A0=C2=A0 rv_op_minu =3D 344,
> -=C2=A0=C2=A0=C2=A0 rv_op_max =3D 345,
> -=C2=A0=C2=A0=C2=A0 rv_op_maxu =3D 346,
> -=C2=A0=C2=A0=C2=A0 rv_op_clzw =3D 347,
> -=C2=A0=C2=A0=C2=A0 rv_op_ctzw =3D 348,
> -=C2=A0=C2=A0=C2=A0 rv_op_cpopw =3D 349,
> -=C2=A0=C2=A0=C2=A0 rv_op_slli_uw =3D 350,
> -=C2=A0=C2=A0=C2=A0 rv_op_add_uw =3D 351,
> -=C2=A0=C2=A0=C2=A0 rv_op_rolw =3D 352,
> -=C2=A0=C2=A0=C2=A0 rv_op_rorw =3D 353,
> -=C2=A0=C2=A0=C2=A0 rv_op_rev8 =3D 354,
> -=C2=A0=C2=A0=C2=A0 rv_op_zext_h =3D 355,
> -=C2=A0=C2=A0=C2=A0 rv_op_roriw =3D 356,
> -=C2=A0=C2=A0=C2=A0 rv_op_orc_b =3D 357,
> -=C2=A0=C2=A0=C2=A0 rv_op_bset =3D 358,
> -=C2=A0=C2=A0=C2=A0 rv_op_bclr =3D 359,
> -=C2=A0=C2=A0=C2=A0 rv_op_binv =3D 360,
> -=C2=A0=C2=A0=C2=A0 rv_op_bext =3D 361,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes32esmi =3D 362,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes32esi =3D 363,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes32dsmi =3D 364,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes32dsi =3D 365,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64ks1i =3D 366,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64ks2 =3D 367,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64im =3D 368,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64esm =3D 369,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64es =3D 370,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64dsm =3D 371,
> -=C2=A0=C2=A0=C2=A0 rv_op_aes64ds =3D 372,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha256sig0 =3D 373,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha256sig1 =3D 374,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha256sum0 =3D 375,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha256sum1 =3D 376,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sig0 =3D 377,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sig1 =3D 378,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sum0 =3D 379,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sum1 =3D 380,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sum0r =3D 381,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sum1r =3D 382,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sig0l =3D 383,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sig0h =3D 384,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sig1l =3D 385,
> -=C2=A0=C2=A0=C2=A0 rv_op_sha512sig1h =3D 386,
> -=C2=A0=C2=A0=C2=A0 rv_op_sm3p0 =3D 387,
> -=C2=A0=C2=A0=C2=A0 rv_op_sm3p1 =3D 388,
> -=C2=A0=C2=A0=C2=A0 rv_op_sm4ed =3D 389,
> -=C2=A0=C2=A0=C2=A0 rv_op_sm4ks =3D 390,
> -=C2=A0=C2=A0=C2=A0 rv_op_brev8 =3D 391,
> -=C2=A0=C2=A0=C2=A0 rv_op_pack =3D 392,
> -=C2=A0=C2=A0=C2=A0 rv_op_packh =3D 393,
> -=C2=A0=C2=A0=C2=A0 rv_op_packw =3D 394,
> -=C2=A0=C2=A0=C2=A0 rv_op_unzip =3D 395,
> -=C2=A0=C2=A0=C2=A0 rv_op_zip =3D 396,
> -=C2=A0=C2=A0=C2=A0 rv_op_xperm4 =3D 397,
> -=C2=A0=C2=A0=C2=A0 rv_op_xperm8 =3D 398,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle8_v =3D 399,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle16_v =3D 400,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle32_v =3D 401,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle64_v =3D 402,
> -=C2=A0=C2=A0=C2=A0 rv_op_vse8_v =3D 403,
> -=C2=A0=C2=A0=C2=A0 rv_op_vse16_v =3D 404,
> -=C2=A0=C2=A0=C2=A0 rv_op_vse32_v =3D 405,
> -=C2=A0=C2=A0=C2=A0 rv_op_vse64_v =3D 406,
> -=C2=A0=C2=A0=C2=A0 rv_op_vlm_v =3D 407,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsm_v =3D 408,
> -=C2=A0=C2=A0=C2=A0 rv_op_vlse8_v =3D 409,
> -=C2=A0=C2=A0=C2=A0 rv_op_vlse16_v =3D 410,
> -=C2=A0=C2=A0=C2=A0 rv_op_vlse32_v =3D 411,
> -=C2=A0=C2=A0=C2=A0 rv_op_vlse64_v =3D 412,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsse8_v =3D 413,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsse16_v =3D 414,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsse32_v =3D 415,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsse64_v =3D 416,
> -=C2=A0=C2=A0=C2=A0 rv_op_vluxei8_v =3D 417,
> -=C2=A0=C2=A0=C2=A0 rv_op_vluxei16_v =3D 418,
> -=C2=A0=C2=A0=C2=A0 rv_op_vluxei32_v =3D 419,
> -=C2=A0=C2=A0=C2=A0 rv_op_vluxei64_v =3D 420,
> -=C2=A0=C2=A0=C2=A0 rv_op_vloxei8_v =3D 421,
> -=C2=A0=C2=A0=C2=A0 rv_op_vloxei16_v =3D 422,
> -=C2=A0=C2=A0=C2=A0 rv_op_vloxei32_v =3D 423,
> -=C2=A0=C2=A0=C2=A0 rv_op_vloxei64_v =3D 424,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsuxei8_v =3D 425,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsuxei16_v =3D 426,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsuxei32_v =3D 427,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsuxei64_v =3D 428,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsoxei8_v =3D 429,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsoxei16_v =3D 430,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsoxei32_v =3D 431,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsoxei64_v =3D 432,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle8ff_v =3D 433,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle16ff_v =3D 434,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle32ff_v =3D 435,
> -=C2=A0=C2=A0=C2=A0 rv_op_vle64ff_v =3D 436,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl1re8_v =3D 437,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl1re16_v =3D 438,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl1re32_v =3D 439,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl1re64_v =3D 440,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl2re8_v =3D 441,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl2re16_v =3D 442,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl2re32_v =3D 443,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl2re64_v =3D 444,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl4re8_v =3D 445,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl4re16_v =3D 446,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl4re32_v =3D 447,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl4re64_v =3D 448,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl8re8_v =3D 449,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl8re16_v =3D 450,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl8re32_v =3D 451,
> -=C2=A0=C2=A0=C2=A0 rv_op_vl8re64_v =3D 452,
> -=C2=A0=C2=A0=C2=A0 rv_op_vs1r_v =3D 453,
> -=C2=A0=C2=A0=C2=A0 rv_op_vs2r_v =3D 454,
> -=C2=A0=C2=A0=C2=A0 rv_op_vs4r_v =3D 455,
> -=C2=A0=C2=A0=C2=A0 rv_op_vs8r_v =3D 456,
> -=C2=A0=C2=A0=C2=A0 rv_op_vadd_vv =3D 457,
> -=C2=A0=C2=A0=C2=A0 rv_op_vadd_vx =3D 458,
> -=C2=A0=C2=A0=C2=A0 rv_op_vadd_vi =3D 459,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsub_vv =3D 460,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsub_vx =3D 461,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrsub_vx =3D 462,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrsub_vi =3D 463,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwaddu_vv =3D 464,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwaddu_vx =3D 465,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwadd_vv =3D 466,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwadd_vx =3D 467,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsubu_vv =3D 468,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsubu_vx =3D 469,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsub_vv =3D 470,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsub_vx =3D 471,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwaddu_wv =3D 472,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwaddu_wx =3D 473,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwadd_wv =3D 474,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwadd_wx =3D 475,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsubu_wv =3D 476,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsubu_wx =3D 477,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsub_wv =3D 478,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsub_wx =3D 479,
> -=C2=A0=C2=A0=C2=A0 rv_op_vadc_vvm =3D 480,
> -=C2=A0=C2=A0=C2=A0 rv_op_vadc_vxm =3D 481,
> -=C2=A0=C2=A0=C2=A0 rv_op_vadc_vim =3D 482,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmadc_vvm =3D 483,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmadc_vxm =3D 484,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmadc_vim =3D 485,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsbc_vvm =3D 486,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsbc_vxm =3D 487,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsbc_vvm =3D 488,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsbc_vxm =3D 489,
> -=C2=A0=C2=A0=C2=A0 rv_op_vand_vv =3D 490,
> -=C2=A0=C2=A0=C2=A0 rv_op_vand_vx =3D 491,
> -=C2=A0=C2=A0=C2=A0 rv_op_vand_vi =3D 492,
> -=C2=A0=C2=A0=C2=A0 rv_op_vor_vv =3D 493,
> -=C2=A0=C2=A0=C2=A0 rv_op_vor_vx =3D 494,
> -=C2=A0=C2=A0=C2=A0 rv_op_vor_vi =3D 495,
> -=C2=A0=C2=A0=C2=A0 rv_op_vxor_vv =3D 496,
> -=C2=A0=C2=A0=C2=A0 rv_op_vxor_vx =3D 497,
> -=C2=A0=C2=A0=C2=A0 rv_op_vxor_vi =3D 498,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsll_vv =3D 499,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsll_vx =3D 500,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsll_vi =3D 501,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsrl_vv =3D 502,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsrl_vx =3D 503,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsrl_vi =3D 504,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsra_vv =3D 505,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsra_vx =3D 506,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsra_vi =3D 507,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnsrl_wv =3D 508,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnsrl_wx =3D 509,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnsrl_wi =3D 510,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnsra_wv =3D 511,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnsra_wx =3D 512,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnsra_wi =3D 513,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmseq_vv =3D 514,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmseq_vx =3D 515,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmseq_vi =3D 516,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsne_vv =3D 517,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsne_vx =3D 518,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsne_vi =3D 519,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsltu_vv =3D 520,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsltu_vx =3D 521,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmslt_vv =3D 522,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmslt_vx =3D 523,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsleu_vv =3D 524,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsleu_vx =3D 525,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsleu_vi =3D 526,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsle_vv =3D 527,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsle_vx =3D 528,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsle_vi =3D 529,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsgtu_vx =3D 530,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsgtu_vi =3D 531,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsgt_vx =3D 532,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsgt_vi =3D 533,
> -=C2=A0=C2=A0=C2=A0 rv_op_vminu_vv =3D 534,
> -=C2=A0=C2=A0=C2=A0 rv_op_vminu_vx =3D 535,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmin_vv =3D 536,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmin_vx =3D 537,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmaxu_vv =3D 538,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmaxu_vx =3D 539,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmax_vv =3D 540,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmax_vx =3D 541,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmul_vv =3D 542,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmul_vx =3D 543,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmulh_vv =3D 544,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmulh_vx =3D 545,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmulhu_vv =3D 546,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmulhu_vx =3D 547,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmulhsu_vv =3D 548,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmulhsu_vx =3D 549,
> -=C2=A0=C2=A0=C2=A0 rv_op_vdivu_vv =3D 550,
> -=C2=A0=C2=A0=C2=A0 rv_op_vdivu_vx =3D 551,
> -=C2=A0=C2=A0=C2=A0 rv_op_vdiv_vv =3D 552,
> -=C2=A0=C2=A0=C2=A0 rv_op_vdiv_vx =3D 553,
> -=C2=A0=C2=A0=C2=A0 rv_op_vremu_vv =3D 554,
> -=C2=A0=C2=A0=C2=A0 rv_op_vremu_vx =3D 555,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrem_vv =3D 556,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrem_vx =3D 557,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmulu_vv =3D 558,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmulu_vx =3D 559,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmulsu_vv =3D 560,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmulsu_vx =3D 561,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmul_vv =3D 562,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmul_vx =3D 563,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmacc_vv =3D 564,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmacc_vx =3D 565,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnmsac_vv =3D 566,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnmsac_vx =3D 567,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmadd_vv =3D 568,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmadd_vx =3D 569,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnmsub_vv =3D 570,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnmsub_vx =3D 571,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmaccu_vv =3D 572,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmaccu_vx =3D 573,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmacc_vv =3D 574,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmacc_vx =3D 575,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmaccsu_vv =3D 576,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmaccsu_vx =3D 577,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwmaccus_vx =3D 578,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv_v_v =3D 579,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv_v_x =3D 580,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv_v_i =3D 581,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmerge_vvm =3D 582,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmerge_vxm =3D 583,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmerge_vim =3D 584,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsaddu_vv =3D 585,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsaddu_vx =3D 586,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsaddu_vi =3D 587,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsadd_vv =3D 588,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsadd_vx =3D 589,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsadd_vi =3D 590,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssubu_vv =3D 591,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssubu_vx =3D 592,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssub_vv =3D 593,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssub_vx =3D 594,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaadd_vv =3D 595,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaadd_vx =3D 596,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaaddu_vv =3D 597,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaaddu_vx =3D 598,
> -=C2=A0=C2=A0=C2=A0 rv_op_vasub_vv =3D 599,
> -=C2=A0=C2=A0=C2=A0 rv_op_vasub_vx =3D 600,
> -=C2=A0=C2=A0=C2=A0 rv_op_vasubu_vv =3D 601,
> -=C2=A0=C2=A0=C2=A0 rv_op_vasubu_vx =3D 602,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsmul_vv =3D 603,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsmul_vx =3D 604,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssrl_vv =3D 605,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssrl_vx =3D 606,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssrl_vi =3D 607,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssra_vv =3D 608,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssra_vx =3D 609,
> -=C2=A0=C2=A0=C2=A0 rv_op_vssra_vi =3D 610,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnclipu_wv =3D 611,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnclipu_wx =3D 612,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnclipu_wi =3D 613,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnclip_wv =3D 614,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnclip_wx =3D 615,
> -=C2=A0=C2=A0=C2=A0 rv_op_vnclip_wi =3D 616,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfadd_vv =3D 617,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfadd_vf =3D 618,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsub_vv =3D 619,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsub_vf =3D 620,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfrsub_vf =3D 621,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwadd_vv =3D 622,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwadd_vf =3D 623,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwadd_wv =3D 624,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwadd_wf =3D 625,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwsub_vv =3D 626,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwsub_vf =3D 627,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwsub_wv =3D 628,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwsub_wf =3D 629,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmul_vv =3D 630,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmul_vf =3D 631,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfdiv_vv =3D 632,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfdiv_vf =3D 633,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfrdiv_vf =3D 634,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmul_vv =3D 635,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmul_vf =3D 636,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmacc_vv =3D 637,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmacc_vf =3D 638,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmacc_vv =3D 639,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmacc_vf =3D 640,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmsac_vv =3D 641,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmsac_vf =3D 642,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmsac_vv =3D 643,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmsac_vf =3D 644,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmadd_vv =3D 645,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmadd_vf =3D 646,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmadd_vv =3D 647,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmadd_vf =3D 648,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmsub_vv =3D 649,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmsub_vf =3D 650,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmsub_vv =3D 651,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfnmsub_vf =3D 652,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmacc_vv =3D 653,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmacc_vf =3D 654,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwnmacc_vv =3D 655,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwnmacc_vf =3D 656,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmsac_vv =3D 657,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmsac_vf =3D 658,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwnmsac_vv =3D 659,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwnmsac_vf =3D 660,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsqrt_v =3D 661,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfrsqrt7_v =3D 662,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfrec7_v =3D 663,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmin_vv =3D 664,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmin_vf =3D 665,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmax_vv =3D 666,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmax_vf =3D 667,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsgnj_vv =3D 668,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsgnj_vf =3D 669,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsgnjn_vv =3D 670,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsgnjn_vf =3D 671,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsgnjx_vv =3D 672,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfsgnjx_vf =3D 673,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfslide1up_vf =3D 674,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfslide1down_vf =3D 675,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfeq_vv =3D 676,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfeq_vf =3D 677,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfne_vv =3D 678,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfne_vf =3D 679,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmflt_vv =3D 680,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmflt_vf =3D 681,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfle_vv =3D 682,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfle_vf =3D 683,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfgt_vf =3D 684,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmfge_vf =3D 685,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfclass_v =3D 686,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmerge_vfm =3D 687,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmv_v_f =3D 688,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfcvt_xu_f_v =3D 689,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfcvt_x_f_v =3D 690,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfcvt_f_xu_v =3D 691,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfcvt_f_x_v =3D 692,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfcvt_rtz_xu_f_v =3D 693,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfcvt_rtz_x_f_v =3D 694,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_xu_f_v =3D 695,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_x_f_v =3D 696,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_f_xu_v =3D 697,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_f_x_v =3D 698,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_f_f_v =3D 699,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_rtz_xu_f_v =3D 700,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvt_rtz_x_f_v =3D 701,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_xu_f_w =3D 702,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_x_f_w =3D 703,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_f_xu_w =3D 704,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_f_x_w =3D 705,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_f_f_w =3D 706,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_rod_f_f_w =3D 707,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_rtz_xu_f_w =3D 708,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvt_rtz_x_f_w =3D 709,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredsum_vs =3D 710,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredand_vs =3D 711,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredor_vs =3D 712,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredxor_vs =3D 713,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredminu_vs =3D 714,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredmin_vs =3D 715,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredmaxu_vs =3D 716,
> -=C2=A0=C2=A0=C2=A0 rv_op_vredmax_vs =3D 717,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwredsumu_vs =3D 718,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwredsum_vs =3D 719,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfredusum_vs =3D 720,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfredosum_vs =3D 721,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfredmin_vs =3D 722,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfredmax_vs =3D 723,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwredusum_vs =3D 724,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwredosum_vs =3D 725,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmand_mm =3D 726,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmnand_mm =3D 727,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmandn_mm =3D 728,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmxor_mm =3D 729,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmor_mm =3D 730,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmnor_mm =3D 731,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmorn_mm =3D 732,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmxnor_mm =3D 733,
> -=C2=A0=C2=A0=C2=A0 rv_op_vcpop_m =3D 734,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfirst_m =3D 735,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsbf_m =3D 736,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsif_m =3D 737,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmsof_m =3D 738,
> -=C2=A0=C2=A0=C2=A0 rv_op_viota_m =3D 739,
> -=C2=A0=C2=A0=C2=A0 rv_op_vid_v =3D 740,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv_x_s =3D 741,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv_s_x =3D 742,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmv_f_s =3D 743,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfmv_s_f =3D 744,
> -=C2=A0=C2=A0=C2=A0 rv_op_vslideup_vx =3D 745,
> -=C2=A0=C2=A0=C2=A0 rv_op_vslideup_vi =3D 746,
> -=C2=A0=C2=A0=C2=A0 rv_op_vslide1up_vx =3D 747,
> -=C2=A0=C2=A0=C2=A0 rv_op_vslidedown_vx =3D 748,
> -=C2=A0=C2=A0=C2=A0 rv_op_vslidedown_vi =3D 749,
> -=C2=A0=C2=A0=C2=A0 rv_op_vslide1down_vx =3D 750,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrgather_vv =3D 751,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrgatherei16_vv =3D 752,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrgather_vx =3D 753,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrgather_vi =3D 754,
> -=C2=A0=C2=A0=C2=A0 rv_op_vcompress_vm =3D 755,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv1r_v =3D 756,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv2r_v =3D 757,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv4r_v =3D 758,
> -=C2=A0=C2=A0=C2=A0 rv_op_vmv8r_v =3D 759,
> -=C2=A0=C2=A0=C2=A0 rv_op_vzext_vf2 =3D 760,
> -=C2=A0=C2=A0=C2=A0 rv_op_vzext_vf4 =3D 761,
> -=C2=A0=C2=A0=C2=A0 rv_op_vzext_vf8 =3D 762,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsext_vf2 =3D 763,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsext_vf4 =3D 764,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsext_vf8 =3D 765,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsetvli =3D 766,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsetivli =3D 767,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsetvl =3D 768,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_zext_b =3D 769,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sext_b =3D 770,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_zext_h =3D 771,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sext_h =3D 772,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_zext_w =3D 773,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_not =3D 774,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_mul =3D 775,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lbu =3D 776,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lhu =3D 777,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_lh =3D 778,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sb =3D 779,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sh =3D 780,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_push =3D 781,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_pop =3D 782,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_popret =3D 783,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_popretz =3D 784,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_mva01s =3D 785,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_mvsa01 =3D 786,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_jt =3D 787,
> -=C2=A0=C2=A0=C2=A0 rv_op_cm_jalt =3D 788,
> -=C2=A0=C2=A0=C2=A0 rv_op_czero_eqz =3D 789,
> -=C2=A0=C2=A0=C2=A0 rv_op_czero_nez =3D 790,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_bf16_s =3D 791,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvt_s_bf16 =3D 792,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfncvtbf16_f_f_w =3D 793,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwcvtbf16_f_f_v =3D 794,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmaccbf16_vv =3D 795,
> -=C2=A0=C2=A0=C2=A0 rv_op_vfwmaccbf16_vf =3D 796,
> -=C2=A0=C2=A0=C2=A0 rv_op_flh =3D 797,
> -=C2=A0=C2=A0=C2=A0 rv_op_fsh =3D 798,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_h_x =3D 799,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmv_x_h =3D 800,
> -=C2=A0=C2=A0=C2=A0 rv_op_fli_s =3D 801,
> -=C2=A0=C2=A0=C2=A0 rv_op_fli_d =3D 802,
> -=C2=A0=C2=A0=C2=A0 rv_op_fli_q =3D 803,
> -=C2=A0=C2=A0=C2=A0 rv_op_fli_h =3D 804,
> -=C2=A0=C2=A0=C2=A0 rv_op_fminm_s =3D 805,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmaxm_s =3D 806,
> -=C2=A0=C2=A0=C2=A0 rv_op_fminm_d =3D 807,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmaxm_d =3D 808,
> -=C2=A0=C2=A0=C2=A0 rv_op_fminm_q =3D 809,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmaxm_q =3D 810,
> -=C2=A0=C2=A0=C2=A0 rv_op_fminm_h =3D 811,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmaxm_h =3D 812,
> -=C2=A0=C2=A0=C2=A0 rv_op_fround_s =3D 813,
> -=C2=A0=C2=A0=C2=A0 rv_op_froundnx_s =3D 814,
> -=C2=A0=C2=A0=C2=A0 rv_op_fround_d =3D 815,
> -=C2=A0=C2=A0=C2=A0 rv_op_froundnx_d =3D 816,
> -=C2=A0=C2=A0=C2=A0 rv_op_fround_q =3D 817,
> -=C2=A0=C2=A0=C2=A0 rv_op_froundnx_q =3D 818,
> -=C2=A0=C2=A0=C2=A0 rv_op_fround_h =3D 819,
> -=C2=A0=C2=A0=C2=A0 rv_op_froundnx_h =3D 820,
> -=C2=A0=C2=A0=C2=A0 rv_op_fcvtmod_w_d =3D 821,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmvh_x_d =3D 822,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmvp_d_x =3D 823,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmvh_x_q =3D 824,
> -=C2=A0=C2=A0=C2=A0 rv_op_fmvp_q_x =3D 825,
> -=C2=A0=C2=A0=C2=A0 rv_op_fleq_s =3D 826,
> -=C2=A0=C2=A0=C2=A0 rv_op_fltq_s =3D 827,
> -=C2=A0=C2=A0=C2=A0 rv_op_fleq_d =3D 828,
> -=C2=A0=C2=A0=C2=A0 rv_op_fltq_d =3D 829,
> -=C2=A0=C2=A0=C2=A0 rv_op_fleq_q =3D 830,
> -=C2=A0=C2=A0=C2=A0 rv_op_fltq_q =3D 831,
> -=C2=A0=C2=A0=C2=A0 rv_op_fleq_h =3D 832,
> -=C2=A0=C2=A0=C2=A0 rv_op_fltq_h =3D 833,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesdf_vv =3D 834,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesdf_vs =3D 835,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesdm_vv =3D 836,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesdm_vs =3D 837,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesef_vv =3D 838,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesef_vs =3D 839,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesem_vv =3D 840,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesem_vs =3D 841,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaeskf1_vi =3D 842,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaeskf2_vi =3D 843,
> -=C2=A0=C2=A0=C2=A0 rv_op_vaesz_vs =3D 844,
> -=C2=A0=C2=A0=C2=A0 rv_op_vandn_vv =3D 845,
> -=C2=A0=C2=A0=C2=A0 rv_op_vandn_vx =3D 846,
> -=C2=A0=C2=A0=C2=A0 rv_op_vbrev_v =3D 847,
> -=C2=A0=C2=A0=C2=A0 rv_op_vbrev8_v =3D 848,
> -=C2=A0=C2=A0=C2=A0 rv_op_vclmul_vv =3D 849,
> -=C2=A0=C2=A0=C2=A0 rv_op_vclmul_vx =3D 850,
> -=C2=A0=C2=A0=C2=A0 rv_op_vclmulh_vv =3D 851,
> -=C2=A0=C2=A0=C2=A0 rv_op_vclmulh_vx =3D 852,
> -=C2=A0=C2=A0=C2=A0 rv_op_vclz_v =3D 853,
> -=C2=A0=C2=A0=C2=A0 rv_op_vcpop_v =3D 854,
> -=C2=A0=C2=A0=C2=A0 rv_op_vctz_v =3D 855,
> -=C2=A0=C2=A0=C2=A0 rv_op_vghsh_vv =3D 856,
> -=C2=A0=C2=A0=C2=A0 rv_op_vgmul_vv =3D 857,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrev8_v =3D 858,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrol_vv =3D 859,
> -=C2=A0=C2=A0=C2=A0 rv_op_vrol_vx =3D 860,
> -=C2=A0=C2=A0=C2=A0 rv_op_vror_vv =3D 861,
> -=C2=A0=C2=A0=C2=A0 rv_op_vror_vx =3D 862,
> -=C2=A0=C2=A0=C2=A0 rv_op_vror_vi =3D 863,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsha2ch_vv =3D 864,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsha2cl_vv =3D 865,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsha2ms_vv =3D 866,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsm3c_vi =3D 867,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsm3me_vv =3D 868,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsm4k_vi =3D 869,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsm4r_vv =3D 870,
> -=C2=A0=C2=A0=C2=A0 rv_op_vsm4r_vs =3D 871,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsll_vv =3D 872,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsll_vx =3D 873,
> -=C2=A0=C2=A0=C2=A0 rv_op_vwsll_vi =3D 874,
> -=C2=A0=C2=A0=C2=A0 rv_op_amocas_w =3D 875,
> -=C2=A0=C2=A0=C2=A0 rv_op_amocas_d =3D 876,
> -=C2=A0=C2=A0=C2=A0 rv_op_amocas_q =3D 877,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 878,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_1=C2=A0=C2=A0=C2=A0=C2=A0 =3D 879,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_2=C2=A0=C2=A0=C2=A0=C2=A0 =3D 880,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_3=C2=A0=C2=A0=C2=A0=C2=A0 =3D 881,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_4=C2=A0=C2=A0=C2=A0=C2=A0 =3D 882,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_5=C2=A0=C2=A0=C2=A0=C2=A0 =3D 883,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_6=C2=A0=C2=A0=C2=A0=C2=A0 =3D 884,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_7=C2=A0=C2=A0=C2=A0=C2=A0 =3D 885,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_8=C2=A0=C2=A0=C2=A0=C2=A0 =3D 886,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_9=C2=A0=C2=A0=C2=A0=C2=A0 =3D 887,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_10=C2=A0=C2=A0=C2=A0 =3D 888,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_11=C2=A0=C2=A0=C2=A0 =3D 889,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_12=C2=A0=C2=A0=C2=A0 =3D 890,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_13=C2=A0=C2=A0=C2=A0 =3D 891,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_14=C2=A0=C2=A0=C2=A0 =3D 892,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_15=C2=A0=C2=A0=C2=A0 =3D 893,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_16=C2=A0=C2=A0=C2=A0 =3D 894,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_17=C2=A0=C2=A0=C2=A0 =3D 895,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_18=C2=A0=C2=A0=C2=A0 =3D 896,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_19=C2=A0=C2=A0=C2=A0 =3D 897,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_20=C2=A0=C2=A0=C2=A0 =3D 898,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_21=C2=A0=C2=A0=C2=A0 =3D 899,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_22=C2=A0=C2=A0=C2=A0 =3D 900,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_23=C2=A0=C2=A0=C2=A0 =3D 901,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_24=C2=A0=C2=A0=C2=A0 =3D 902,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_25=C2=A0=C2=A0=C2=A0 =3D 903,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_26=C2=A0=C2=A0=C2=A0 =3D 904,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_27=C2=A0=C2=A0=C2=A0 =3D 905,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_28=C2=A0=C2=A0=C2=A0 =3D 906,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_29=C2=A0=C2=A0=C2=A0 =3D 907,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_30=C2=A0=C2=A0=C2=A0 =3D 908,
> -=C2=A0=C2=A0=C2=A0 rv_mop_r_31=C2=A0=C2=A0=C2=A0 =3D 909,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_0=C2=A0=C2=A0=C2=A0 =3D 910,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_1=C2=A0=C2=A0=C2=A0 =3D 911,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_2=C2=A0=C2=A0=C2=A0 =3D 912,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_3=C2=A0=C2=A0=C2=A0 =3D 913,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_4=C2=A0=C2=A0=C2=A0 =3D 914,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_5=C2=A0=C2=A0=C2=A0 =3D 915,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_6=C2=A0=C2=A0=C2=A0 =3D 916,
> -=C2=A0=C2=A0=C2=A0 rv_mop_rr_7=C2=A0=C2=A0=C2=A0 =3D 917,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_1=C2=A0=C2=A0=C2=A0=C2=A0 =3D 918,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_3=C2=A0=C2=A0=C2=A0=C2=A0 =3D 919,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_5=C2=A0=C2=A0=C2=A0=C2=A0 =3D 920,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_7=C2=A0=C2=A0=C2=A0=C2=A0 =3D 921,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_9=C2=A0=C2=A0=C2=A0=C2=A0 =3D 922,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_11=C2=A0=C2=A0=C2=A0 =3D 923,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_13=C2=A0=C2=A0=C2=A0 =3D 924,
> -=C2=A0=C2=A0=C2=A0 rv_c_mop_15=C2=A0=C2=A0=C2=A0 =3D 925,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoswap_b =3D 926,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoadd_b=C2=A0 =3D 927,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoxor_b=C2=A0 =3D 928,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoor_b=C2=A0=C2=A0 =3D 929,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoand_b=C2=A0 =3D 930,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomin_b=C2=A0 =3D 931,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomax_b=C2=A0 =3D 932,
> -=C2=A0=C2=A0=C2=A0 rv_op_amominu_b =3D 933,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomaxu_b =3D 934,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoswap_h =3D 935,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoadd_h=C2=A0 =3D 936,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoxor_h=C2=A0 =3D 937,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoor_h=C2=A0=C2=A0 =3D 938,
> -=C2=A0=C2=A0=C2=A0 rv_op_amoand_h=C2=A0 =3D 939,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomin_h=C2=A0 =3D 940,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomax_h=C2=A0 =3D 941,
> -=C2=A0=C2=A0=C2=A0 rv_op_amominu_h =3D 942,
> -=C2=A0=C2=A0=C2=A0 rv_op_amomaxu_h =3D 943,
> -=C2=A0=C2=A0=C2=A0 rv_op_amocas_b=C2=A0 =3D 944,
> -=C2=A0=C2=A0=C2=A0 rv_op_amocas_h=C2=A0 =3D 945,
> -=C2=A0=C2=A0=C2=A0 rv_op_wrs_sto =3D 946,
> -=C2=A0=C2=A0=C2=A0 rv_op_wrs_nto =3D 947,
> -=C2=A0=C2=A0=C2=A0 rv_op_lpad =3D 948,
> -=C2=A0=C2=A0=C2=A0 rv_op_sspush =3D 949,
> -=C2=A0=C2=A0=C2=A0 rv_op_sspopchk =3D 950,
> -=C2=A0=C2=A0=C2=A0 rv_op_ssrdp =3D 951,
> -=C2=A0=C2=A0=C2=A0 rv_op_ssamoswap_w =3D 952,
> -=C2=A0=C2=A0=C2=A0 rv_op_ssamoswap_d =3D 953,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sspush =3D 954,
> -=C2=A0=C2=A0=C2=A0 rv_op_c_sspopchk =3D 955,
> -=C2=A0=C2=A0=C2=A0 rv_op_cbo_inval =3D 956,
> -=C2=A0=C2=A0=C2=A0 rv_op_cbo_clean =3D 957,
> -=C2=A0=C2=A0=C2=A0 rv_op_cbo_flush =3D 958,
> -=C2=A0=C2=A0=C2=A0 rv_op_cbo_zero =3D 959,
> -=C2=A0=C2=A0=C2=A0 rv_op_mnret =3D 960,
> +#define OP(N, ...) rv_op_##N,
> +#include "riscv-op.c.inc"
> +#undef OP
> =C2=A0} rv_op;
> =C2=A0
> =C2=A0/* register names */
> @@ -1601,967 +646,9 @@ static uint32_t operand_lpl(rv_inst inst)
> =C2=A0/* instruction metadata */
> =C2=A0
> =C2=A0static const rv_opcode_data rvi_opcode_data[] =3D {
> -=C2=A0=C2=A0=C2=A0 { "illegal", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "lui", rv_codec_u, rv_fmt_rd_uimm },
> -=C2=A0=C2=A0=C2=A0 { "auipc", rv_codec_u, rv_fmt_rd_uoffset },
> -=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal },
> -=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr=
 },
> -=C2=A0=C2=A0=C2=A0 { "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq=
 },
> -=C2=A0=C2=A0=C2=A0 { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne=
 },
> -=C2=A0=C2=A0=C2=A0 { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt=
 },
> -=C2=A0=C2=A0=C2=A0 { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge=
 },
> -=C2=A0=C2=A0=C2=A0 { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "lb", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "lh", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "lw", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "lbu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "lhu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sb", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sh", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sw", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "addi", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addi },
> -=C2=A0=C2=A0=C2=A0 { "slti", rv_codec_i, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "sltiu", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_sltiu =
},
> -=C2=A0=C2=A0=C2=A0 { "xori", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_xori },
> -=C2=A0=C2=A0=C2=A0 { "ori", rv_codec_i, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "andi", rv_codec_i, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "slli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "srli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "srai", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sub", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sub },
> -=C2=A0=C2=A0=C2=A0 { "sll", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "slt", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_slt },
> -=C2=A0=C2=A0=C2=A0 { "sltu", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sltu },
> -=C2=A0=C2=A0=C2=A0 { "xor", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "srl", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sra", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "or", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "and", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "fence", rv_codec_r_f, rv_fmt_pred_succ },
> -=C2=A0=C2=A0=C2=A0 { "fence.i", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "lwu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "ld", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sd", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "addiw", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addiw =
},
> -=C2=A0=C2=A0=C2=A0 { "slliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "srliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "sraiw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "addw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "subw", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_subw },
> -=C2=A0=C2=A0=C2=A0 { "sllw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "srlw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sraw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "ldu", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "lq", rv_codec_i, rv_fmt_rd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sq", rv_codec_s, rv_fmt_rs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "addid", rv_codec_i, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "sllid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "srlid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "sraid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "addd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "subd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "slld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "srld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "srad", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mul", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mulh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mulhsu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mulhu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "div", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "divu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "rem", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "remu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mulw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "divw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "divuw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "remw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "remuw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "muld", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "divd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "divud", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "remd", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "remud", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "lr.w", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sc.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amoadd.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoand.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "lr.d", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sc.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amoadd.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoand.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "lr.q", rv_codec_r_l, rv_fmt_aqrl_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sc.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amoadd.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoand.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "ecall", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "ebreak", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "uret", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "sret", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "hret", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "mret", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "dret", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "sfence.vm", rv_codec_r, rv_fmt_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "wfi", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
> -=C2=A0=C2=A0=C2=A0 { "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
> -=C2=A0=C2=A0=C2=A0 { "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm },
> -=C2=A0=C2=A0=C2=A0 { "flw", rv_codec_i, rv_fmt_frd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> -=C2=A0=C2=A0=C2=A0 { "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> -=C2=A0=C2=A0=C2=A0 { "fnmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> -=C2=A0=C2=A0=C2=A0 { "fnmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> -=C2=A0=C2=A0=C2=A0 { "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_s },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_s },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_s },
> -=C2=A0=C2=A0=C2=A0 { "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fclass.s", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fld", rv_codec_i, rv_fmt_frd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> -=C2=A0=C2=A0=C2=A0 { "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> -=C2=A0=C2=A0=C2=A0 { "fnmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> -=C2=A0=C2=A0=C2=A0 { "fnmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> -=C2=A0=C2=A0=C2=A0 { "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_d },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_d },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_d },
> -=C2=A0=C2=A0=C2=A0 { "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fclass.d", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "flq", rv_codec_i, rv_fmt_frd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> -=C2=A0=C2=A0=C2=A0 { "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_f=
rs3 },
> -=C2=A0=C2=A0=C2=A0 { "fnmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> -=C2=A0=C2=A0=C2=A0 { "fnmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_=
frs3 },
> -=C2=A0=C2=A0=C2=A0 { "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_f=
sgnj_q },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjn_q },
> -=C2=A0=C2=A0=C2=A0 { "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2, rvcp_=
fsgnjx_q },
> -=C2=A0=C2=A0=C2=A0 { "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fclass.q", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op=
_addi) },
> -=C2=A0=C2=A0=C2=A0 { "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld) },
> -=C2=A0=C2=A0=C2=A0 { "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw) },
> -=C2=A0=C2=A0=C2=A0 { "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw) },
> -=C2=A0=C2=A0=C2=A0 { "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd) },
> -=C2=A0=C2=A0=C2=A0 { "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw) },
> -=C2=A0=C2=A0=C2=A0 { "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw) },
> -=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi) },
> -=C2=A0=C2=A0=C2=A0 { "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal) }=
,
> -=C2=A0=C2=A0=C2=A0 { "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi) },
> -=C2=A0=C2=A0=C2=A0 { "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_=
addi) },
> -=C2=A0=C2=A0=C2=A0 { "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui) }=
,
> -=C2=A0=C2=A0=C2=A0 { "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli)=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai)=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi)=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub) },
> -=C2=A0=C2=A0=C2=A0 { "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor) },
> -=C2=A0=C2=A0=C2=A0 { "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or) },
> -=C2=A0=C2=A0=C2=A0 { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
> -=C2=A0=C2=A0=C2=A0 { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
> -=C2=A0=C2=A0=C2=A0 { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
> -=C2=A0=C2=A0=C2=A0 { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j) },
> -=C2=A0=C2=A0=C2=A0 { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz) },
> -=C2=A0=C2=A0=C2=A0 { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez) },
> -=C2=A0=C2=A0=C2=A0 { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli)=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld=
) },
> -=C2=A0=C2=A0=C2=A0 { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) =
},
> -=C2=A0=C2=A0=C2=A0 { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw=
) },
> -=C2=A0=C2=A0=C2=A0 { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr) },
> -=C2=A0=C2=A0=C2=A0 { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv) },
> -=C2=A0=C2=A0=C2=A0 { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_eb=
reak) },
> -=C2=A0=C2=A0=C2=A0 { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr=
) },
> -=C2=A0=C2=A0=C2=A0 { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
> -=C2=A0=C2=A0=C2=A0 { "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fs=
d) },
> -=C2=A0=C2=A0=C2=A0 { "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw)=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fs=
w) },
> -=C2=A0=C2=A0=C2=A0 { "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld) },
> -=C2=A0=C2=A0=C2=A0 { "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd) },
> -=C2=A0=C2=A0=C2=A0 { "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw) }=
,
> -=C2=A0=C2=A0=C2=A0 { "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld) =
},
> -=C2=A0=C2=A0=C2=A0 { "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd)=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq) },
> -=C2=A0=C2=A0=C2=A0 { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
> -=C2=A0=C2=A0=C2=A0 { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) =
},
> -=C2=A0=C2=A0=C2=A0 { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq)=
 },
> -=C2=A0=C2=A0=C2=A0 { "nop", rv_codec_illegal, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv },
> -=C2=A0=C2=A0=C2=A0 { "not", rv_codec_illegal, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "neg", rv_codec_illegal, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "negw", rv_codec_illegal, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sext.w", rv_codec_illegal, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "seqz", rv_codec_illegal, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "snez", rv_codec_illegal, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sltz", rv_codec_illegal, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sgtz", rv_codec_illegal, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "beqz", rv_codec_illegal, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bnez", rv_codec_illegal, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "blez", rv_codec_illegal, rv_fmt_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgez", rv_codec_illegal, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bltz", rv_codec_illegal, rv_fmt_rs1_offset },
> -=C2=A0=C2=A0=C2=A0 { "bgtz", rv_codec_illegal, rv_fmt_rs2_offset },
> -=C2=A0=C2=A0=C2=A0 { "jal", rv_codec_illegal, rv_fmt_offset }, /* rv_op_=
jal_ra */
> -=C2=A0=C2=A0=C2=A0 { "jalr", rv_codec_illegal, rv_fmt_rs1 }, /* rv_op_ja=
lr_ra */
> -=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { },
> -=C2=A0=C2=A0=C2=A0 { "j", rv_codec_illegal, rv_fmt_offset },
> -=C2=A0=C2=A0=C2=A0 { "ret", rv_codec_illegal, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr },
> -=C2=A0=C2=A0=C2=A0 { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "rdtime", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "rdcycleh", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "rdtimeh", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "rdinstreth", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "frcsr", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "frrm", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "frflags", rv_codec_i_csr, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "fscsr", rv_codec_i_csr, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsrm", rv_codec_i_csr, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsflags", rv_codec_i_csr, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsrmi", rv_codec_i_csr, rv_fmt_rd_zimm },
> -=C2=A0=C2=A0=C2=A0 { "fsflagsi", rv_codec_i_csr, rv_fmt_rd_zimm },
> -=C2=A0=C2=A0=C2=A0 { "bseti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "bclri", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "binvi", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "bexti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "rori", rv_codec_i_sh7, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "clz", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "ctz", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "cpop", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sext.h", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sext.b", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "xnor", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "orn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "andn", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "rol", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "ror", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sh1add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sh2add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sh3add", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sh1add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sh2add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sh3add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "clmul", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "clmulr", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "clmulh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "min", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "minu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "max", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "maxu", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "clzw", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "ctzw", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "cpopw", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "slli.uw", rv_codec_i_sh6, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "rolw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "rorw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "rev8", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "zext.h", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "roriw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm },
> -=C2=A0=C2=A0=C2=A0 { "orc.b", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "bset", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "bclr", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "binv", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "bext", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "aes32esmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> -=C2=A0=C2=A0=C2=A0 { "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> -=C2=A0=C2=A0=C2=A0 { "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> -=C2=A0=C2=A0=C2=A0 { "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> -=C2=A0=C2=A0=C2=A0 { "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum },
> -=C2=A0=C2=A0=C2=A0 { "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "aes64im", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "aes64es", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "aes64dsm", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "aes64ds", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sig0", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sig1", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sum0", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sha256sum1", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum0r", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sum1r", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig0l", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig0h", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig1l", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sha512sig1h", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sm3p0", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sm3p1", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "sm4ed", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> -=C2=A0=C2=A0=C2=A0 { "sm4ks", rv_codec_k_bs, rv_fmt_rs1_rs2_bs },
> -=C2=A0=C2=A0=C2=A0 { "brev8", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "pack", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "packh", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "packw", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "unzip", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "zip", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "xperm4", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "xperm8", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "vle8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vle16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vle32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vle64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vse8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vse16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vse32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vse64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vlm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vlse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vlse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vlse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vlse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vsse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vsse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vsse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vsse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vluxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vluxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vluxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vluxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vloxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vloxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vloxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vloxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vsuxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vsoxei64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vle8ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vle16ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vle32ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vle64ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vl1re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl1re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vl2re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl2re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vl4re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl4re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vl8re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vl8re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vs1r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vs2r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vs4r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vs8r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vrsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vrsub.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwaddu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwadd.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsubu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsub.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
> -=C2=A0=C2=A0=C2=A0 { "vsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vand.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vand.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vand.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vxor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vxor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsne.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsne.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsltu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsltu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmslt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmslt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsleu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsleu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsleu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsle.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsle.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsgtu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsgtu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsgt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsgt.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vminu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vminu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmin.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmaxu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmaxu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmax.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmulhu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmulhu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmulhsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmulhsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vdiv.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vremu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vremu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vrem.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vrem.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmulu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmulu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmulsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmulsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnmsac.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmadd.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnmsub.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwmaccsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vwmaccsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vwmaccus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vmv.v.v", rv_codec_v_r, rv_fmt_vd_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.v.x", rv_codec_v_r, rv_fmt_vd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.v.i", rv_codec_v_i, rv_fmt_vd_imm },
> -=C2=A0=C2=A0=C2=A0 { "vmerge.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmerge.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl },
> -=C2=A0=C2=A0=C2=A0 { "vmerge.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl },
> -=C2=A0=C2=A0=C2=A0 { "vsaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsaddu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vasub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vasub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vasubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vasubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfrsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwsub.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfwnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfwmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfwnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfsqrt.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vfrsqrt7.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vfmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmin.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmax.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnj.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnj.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjn.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjx.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfsgnjx.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfslide1up.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vfslide1down.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfeq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfeq.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfne.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmflt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmflt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfle.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfgt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmfge.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfmerge.vfm", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vl }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfmv.v.f", rv_codec_v_r, rv_fmt_vd_fs1 },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.rtz.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vfwcvt.rtz.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.f.xu.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.f.x.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.rod.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.rtz.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vfncvt.rtz.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vredor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vredxor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vredminu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwredsumu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vwredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vfwredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vfwredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vmand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmnand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmandn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmxor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmorn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmxnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vcpop.m", rv_codec_v_r, rv_fmt_rd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vfirst.m", rv_codec_v_r, rv_fmt_rd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsbf.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsif.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmsof.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "viota.m", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vid.v", rv_codec_v_r, rv_fmt_vd_vm },
> -=C2=A0=C2=A0=C2=A0 { "vmv.x.s", rv_codec_v_r, rv_fmt_rd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vmv.s.x", rv_codec_v_r, rv_fmt_vd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1 },
> -=C2=A0=C2=A0=C2=A0 { "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vslideup.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vslidedown.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm=
 },
> -=C2=A0=C2=A0=C2=A0 { "vslidedown.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm=
_vm },
> -=C2=A0=C2=A0=C2=A0 { "vslide1down.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vrgatherei16.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_=
vm },
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "vrgather.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vmv4r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vmv8r.v", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vzext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vzext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vzext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli },
> -=C2=A0=C2=A0=C2=A0 { "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli },
> -=C2=A0=C2=A0=C2=A0 { "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "c.zext.b", rv_codec_zcb_ext, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "c.sext.b", rv_codec_zcb_ext, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "c.zext.h", rv_codec_zcb_ext, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "c.sext.h", rv_codec_zcb_ext, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "c.zext.w", rv_codec_zcb_ext, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "c.not", rv_codec_zcb_ext, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "c.mul", rv_codec_zcb_mul, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "c.lbu", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst }=
,
> -=C2=A0=C2=A0=C2=A0 { "c.lhu", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst }=
,
> -=C2=A0=C2=A0=C2=A0 { "c.lh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
> -=C2=A0=C2=A0=C2=A0 { "c.sb", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst },
> -=C2=A0=C2=A0=C2=A0 { "c.sh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst },
> -=C2=A0=C2=A0=C2=A0 { "cm.push", rv_codec_zcmp_cm_pushpop, rv_fmt_push_rl=
ist },
> -=C2=A0=C2=A0=C2=A0 { "cm.pop", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlis=
t },
> -=C2=A0=C2=A0=C2=A0 { "cm.popret", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_r=
list },
> -=C2=A0=C2=A0=C2=A0 { "cm.popretz", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_=
rlist },
> -=C2=A0=C2=A0=C2=A0 { "cm.mva01s", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index },
> -=C2=A0=C2=A0=C2=A0 { "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index },
> -=C2=A0=C2=A0=C2=A0 { "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "vfncvtbf16.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfwcvtbf16.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vfwmaccbf16.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "vfwmaccbf16.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_v=
m },
> -=C2=A0=C2=A0=C2=A0 { "flh", rv_codec_i, rv_fmt_frd_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fli.s", rv_codec_fli, rv_fmt_fli },
> -=C2=A0=C2=A0=C2=A0 { "fli.d", rv_codec_fli, rv_fmt_fli },
> -=C2=A0=C2=A0=C2=A0 { "fli.q", rv_codec_fli, rv_fmt_fli },
> -=C2=A0=C2=A0=C2=A0 { "fli.h", rv_codec_fli, rv_fmt_fli },
> -=C2=A0=C2=A0=C2=A0 { "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1 },
> -=C2=A0=C2=A0=C2=A0 { "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> -=C2=A0=C2=A0=C2=A0 { "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> -=C2=A0=C2=A0=C2=A0 { "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm },
> -=C2=A0=C2=A0=C2=A0 { "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm =
},
> -=C2=A0=C2=A0=C2=A0 { "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> -=C2=A0=C2=A0=C2=A0 { "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1 },
> -=C2=A0=C2=A0=C2=A0 { "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm },
> -=C2=A0=C2=A0=C2=A0 { "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2 },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm },
> -=C2=A0=C2=A0=C2=A0 { "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm }=
,
> -=C2=A0=C2=A0=C2=A0 { "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.0", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.1", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.2", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.3", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.4", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.5", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.6", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.7", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.8", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.9", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.10", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.11", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.12", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.13", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.14", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.15", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.16", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.17", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.18", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.19", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.20", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.21", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.22", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.23", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.24", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.25", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.26", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.27", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.28", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.29", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.30", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.r.31", rv_codec_r, rv_fmt_rd_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.1", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.3", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.5", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.7", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.9", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.11", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.13", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "c.mop.15", rv_codec_ci_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 }=
,
> -=C2=A0=C2=A0=C2=A0 { "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "wrs.sto", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "wrs.nto", rv_codec_none, rv_fmt_none },
> -=C2=A0=C2=A0=C2=A0 { "lpad", rv_codec_lp, rv_fmt_imm },
> -=C2=A0=C2=A0=C2=A0 { "sspush", rv_codec_r, rv_fmt_rs2 },
> -=C2=A0=C2=A0=C2=A0 { "sspopchk", rv_codec_r, rv_fmt_rs1 },
> -=C2=A0=C2=A0=C2=A0 { "ssrdp", rv_codec_r, rv_fmt_rd },
> -=C2=A0=C2=A0=C2=A0 { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1=
 },
> -=C2=A0=C2=A0=C2=A0 { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1=
 },
> -=C2=A0=C2=A0=C2=A0 { "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_ss=
push) },
> -=C2=A0=C2=A0=C2=A0 { "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_=
sspopchk)
> },
> -=C2=A0=C2=A0 { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
> -=C2=A0=C2=A0 { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
> -=C2=A0=C2=A0 { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
> -=C2=A0=C2=A0 { "cbo.zero", rv_codec_r, rv_fmt_rs1 },
> -=C2=A0=C2=A0 { "mnret", rv_codec_none, rv_fmt_none },
> +#define OP(N, ...) { __VA_ARGS__ },
> +#include "riscv-op.c.inc"
> +#undef OP
> =C2=A0};
> =C2=A0
> =C2=A0/* CSR names */
> @@ -2928,7 +1015,7 @@ static const rv_opcode_data
> *decode_inst_opcode(rv_decode *dec, rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((inst >> 11) & 0b11) =3D=
=3D 0b0)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int cmop_code =3D=
 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmop_code =3D ((inst >> 8)=
 & 0b111);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D rv_c_mop_1 + cmop_code;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D rv_op_c_mop_1 + cmop_code=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dec->cfg->ext_zicfiss)=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op=
 =3D (cmop_code =3D=3D 0) ? rv_op_c_sspush : op;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op=
 =3D (cmop_code =3D=3D 2) ? rv_op_c_sspopchk :
> op;
> @@ -4459,7 +2546,7 @@ static const rv_opcode_data
> *decode_inst_opcode(rv_decode *dec, rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2, 2,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> extract32(inst, 26, 2)),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4, 1, extract32(inst,
> 30, 1));
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D r=
v_mop_r_0 + imm_mop5;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D r=
v_op_mop_r_0 + imm_mop5;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 if zicfiss enabled and mop5 is shadow
> stack */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (dec->cfg->ext_zicfiss &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ((imm_mop5 & 0b11100) =3D=3D 0b11100)) {
> @@ -4478,7 +2565,7 @@ static const rv_opcode_data
> *decode_inst_opcode(rv_decode *dec, rv_isa isa)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=3D 0b1000001) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 im=
m_mop3 =3D deposit32(extract32(inst, 26, 2),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2, 1, extract32(inst,
> 30, 1));
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D r=
v_mop_rr_0 + imm_mop3;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D r=
v_op_mop_rr_0 + imm_mop3;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 if zicfiss enabled and mop3 is shadow
> stack */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (dec->cfg->ext_zicfiss &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ((imm_mop3 & 0b111) =3D=3D 0b111)) {
> diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
> new file mode 100644
> index 0000000000..3fe934688e
> --- /dev/null
> +++ b/disas/riscv-op.c.inc
> @@ -0,0 +1,958 @@
> +OP(illegal, "illegal", rv_codec_none, rv_fmt_none)
> +OP(lui, "lui", rv_codec_u, rv_fmt_rd_uimm)
> +OP(auipc, "auipc", rv_codec_u, rv_fmt_rd_uoffset)
> +OP(jal, "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal)
> +OP(jalr, "jalr", rv_codec_i, rv_fmt_rd_rs1_offset, rvcp_jalr)
> +OP(beq, "beq", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_beq)
> +OP(bne, "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne)
> +OP(blt, "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt)
> +OP(bge, "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge)
> +OP(bltu, "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset)
> +OP(bgeu, "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset)
> +OP(lb, "lb", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(lh, "lh", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(lw, "lw", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(lbu, "lbu", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(lhu, "lhu", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(sb, "sb", rv_codec_s, rv_fmt_rs2_offset_rs1)
> +OP(sh, "sh", rv_codec_s, rv_fmt_rs2_offset_rs1)
> +OP(sw, "sw", rv_codec_s, rv_fmt_rs2_offset_rs1)
> +OP(addi, "addi", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addi)
> +OP(slti, "slti", rv_codec_i, rv_fmt_rd_rs1_imm)
> +OP(sltiu, "sltiu", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_sltiu)
> +OP(xori, "xori", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_xori)
> +OP(ori, "ori", rv_codec_i, rv_fmt_rd_rs1_imm)
> +OP(andi, "andi", rv_codec_i, rv_fmt_rd_rs1_imm)
> +OP(slli, "slli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(srli, "srli", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(srai, "srai", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(add, "add", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sub, "sub", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sub)
> +OP(sll, "sll", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(slt, "slt", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_slt)
> +OP(sltu, "sltu", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_sltu)
> +OP(xor, "xor", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(srl, "srl", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sra, "sra", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(or, "or", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(and, "and", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(fence, "fence", rv_codec_r_f, rv_fmt_pred_succ)
> +OP(fence_i, "fence.i", rv_codec_none, rv_fmt_none)
> +OP(lwu, "lwu", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(ld, "ld", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(sd, "sd", rv_codec_s, rv_fmt_rs2_offset_rs1)
> +OP(addiw, "addiw", rv_codec_i, rv_fmt_rd_rs1_imm, rvcp_addiw)
> +OP(slliw, "slliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
> +OP(srliw, "srliw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
> +OP(sraiw, "sraiw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
> +OP(addw, "addw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(subw, "subw", rv_codec_r, rv_fmt_rd_rs1_rs2, rvcp_subw)
> +OP(sllw, "sllw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(srlw, "srlw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sraw, "sraw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(ldu, "ldu", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(lq, "lq", rv_codec_i, rv_fmt_rd_offset_rs1)
> +OP(sq, "sq", rv_codec_s, rv_fmt_rs2_offset_rs1)
> +OP(addid, "addid", rv_codec_i, rv_fmt_rd_rs1_imm)
> +OP(sllid, "sllid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
> +OP(srlid, "srlid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
> +OP(sraid, "sraid", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
> +OP(addd, "addd", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(subd, "subd", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(slld, "slld", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(srld, "srld", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(srad, "srad", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mul, "mul", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mulh, "mulh", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mulhsu, "mulhsu", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mulhu, "mulhu", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(div, "div", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(divu, "divu", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(rem, "rem", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(remu, "remu", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mulw, "mulw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(divw, "divw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(divuw, "divuw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(remw, "remw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(remuw, "remuw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(muld, "muld", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(divd, "divd", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(divud, "divud", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(remd, "remd", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(remud, "remud", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(lr_w, "lr.w", rv_codec_r_l, rv_fmt_aqrl_rd_rs1)
> +OP(sc_w, "sc.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoswap_w, "amoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoadd_w, "amoadd.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoxor_w, "amoxor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoor_w, "amoor.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoand_w, "amoand.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomin_w, "amomin.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomax_w, "amomax.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amominu_w, "amominu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomaxu_w, "amomaxu.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(lr_d, "lr.d", rv_codec_r_l, rv_fmt_aqrl_rd_rs1)
> +OP(sc_d, "sc.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoswap_d, "amoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoadd_d, "amoadd.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoxor_d, "amoxor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoor_d, "amoor.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoand_d, "amoand.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomin_d, "amomin.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomax_d, "amomax.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amominu_d, "amominu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomaxu_d, "amomaxu.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(lr_q, "lr.q", rv_codec_r_l, rv_fmt_aqrl_rd_rs1)
> +OP(sc_q, "sc.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoswap_q, "amoswap.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoadd_q, "amoadd.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoxor_q, "amoxor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoor_q, "amoor.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoand_q, "amoand.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomin_q, "amomin.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomax_q, "amomax.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amominu_q, "amominu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomaxu_q, "amomaxu.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(ecall, "ecall", rv_codec_none, rv_fmt_none)
> +OP(ebreak, "ebreak", rv_codec_none, rv_fmt_none)
> +OP(uret, "uret", rv_codec_none, rv_fmt_none)
> +OP(sret, "sret", rv_codec_none, rv_fmt_none)
> +OP(hret, "hret", rv_codec_none, rv_fmt_none)
> +OP(mret, "mret", rv_codec_none, rv_fmt_none)
> +OP(dret, "dret", rv_codec_none, rv_fmt_none)
> +OP(sfence_vm, "sfence.vm", rv_codec_r, rv_fmt_rs1)
> +OP(sfence_vma, "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2)
> +OP(wfi, "wfi", rv_codec_none, rv_fmt_none)
> +OP(csrrw, "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1)
> +OP(csrrs, "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1)
> +OP(csrrc, "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1)
> +OP(csrrwi, "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm)
> +OP(csrrsi, "csrrsi", rv_codec_i_csr, rv_fmt_rd_csr_zimm)
> +OP(csrrci, "csrrci", rv_codec_i_csr, rv_fmt_rd_csr_zimm)
> +OP(flw, "flw", rv_codec_i, rv_fmt_frd_offset_rs1)
> +OP(fsw, "fsw", rv_codec_s, rv_fmt_frs2_offset_rs1)
> +OP(fmadd_s, "fmadd.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fmsub_s, "fmsub.s", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fnmsub_s, "fnmsub.s", rv_codec_r4_m,
> rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fnmadd_s, "fnmadd.s", rv_codec_r4_m,
> rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fadd_s, "fadd.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fsub_s, "fsub.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fmul_s, "fmul.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fdiv_s, "fdiv.s", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fsgnj_s, "fsgnj.s", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnj_s)
> +OP(fsgnjn_s, "fsgnjn.s", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnjn_s)
> +OP(fsgnjx_s, "fsgnjx.s", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnjx_s)
> +OP(fmin_s, "fmin.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmax_s, "fmax.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fsqrt_s, "fsqrt.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fle_s, "fle.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(flt_s, "flt.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(feq_s, "feq.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fcvt_w_s, "fcvt.w.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_wu_s, "fcvt.wu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_s_w, "fcvt.s.w", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fcvt_s_wu, "fcvt.s.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fmv_x_s, "fmv.x.s", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fclass_s, "fclass.s", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fmv_s_x, "fmv.s.x", rv_codec_r, rv_fmt_frd_rs1)
> +OP(fcvt_l_s, "fcvt.l.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_lu_s, "fcvt.lu.s", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_s_l, "fcvt.s.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fcvt_s_lu, "fcvt.s.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fld, "fld", rv_codec_i, rv_fmt_frd_offset_rs1)
> +OP(fsd, "fsd", rv_codec_s, rv_fmt_frs2_offset_rs1)
> +OP(fmadd_d, "fmadd.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fmsub_d, "fmsub.d", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fnmsub_d, "fnmsub.d", rv_codec_r4_m,
> rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fnmadd_d, "fnmadd.d", rv_codec_r4_m,
> rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fadd_d, "fadd.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fsub_d, "fsub.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fmul_d, "fmul.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fdiv_d, "fdiv.d", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fsgnj_d, "fsgnj.d", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnj_d)
> +OP(fsgnjn_d, "fsgnjn.d", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnjn_d)
> +OP(fsgnjx_d, "fsgnjx.d", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnjx_d)
> +OP(fmin_d, "fmin.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmax_d, "fmax.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fcvt_s_d, "fcvt.s.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fcvt_d_s, "fcvt.d.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fsqrt_d, "fsqrt.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fle_d, "fle.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(flt_d, "flt.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(feq_d, "feq.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fcvt_w_d, "fcvt.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_wu_d, "fcvt.wu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_d_w, "fcvt.d.w", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fcvt_d_wu, "fcvt.d.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fclass_d, "fclass.d", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fcvt_l_d, "fcvt.l.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_lu_d, "fcvt.lu.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fmv_x_d, "fmv.x.d", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fcvt_d_l, "fcvt.d.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fcvt_d_lu, "fcvt.d.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fmv_d_x, "fmv.d.x", rv_codec_r, rv_fmt_frd_rs1)
> +OP(flq, "flq", rv_codec_i, rv_fmt_frd_offset_rs1)
> +OP(fsq, "fsq", rv_codec_s, rv_fmt_frs2_offset_rs1)
> +OP(fmadd_q, "fmadd.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fmsub_q, "fmsub.q", rv_codec_r4_m, rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fnmsub_q, "fnmsub.q", rv_codec_r4_m,
> rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fnmadd_q, "fnmadd.q", rv_codec_r4_m,
> rv_fmt_rm_frd_frs1_frs2_frs3)
> +OP(fadd_q, "fadd.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fsub_q, "fsub.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fmul_q, "fmul.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fdiv_q, "fdiv.q", rv_codec_r_m, rv_fmt_rm_frd_frs1_frs2)
> +OP(fsgnj_q, "fsgnj.q", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnj_q)
> +OP(fsgnjn_q, "fsgnjn.q", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnjn_q)
> +OP(fsgnjx_q, "fsgnjx.q", rv_codec_r, rv_fmt_frd_frs1_frs2,
> rvcp_fsgnjx_q)
> +OP(fmin_q, "fmin.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmax_q, "fmax.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fcvt_s_q, "fcvt.s.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fcvt_q_s, "fcvt.q.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fcvt_d_q, "fcvt.d.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fcvt_q_d, "fcvt.q.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fsqrt_q, "fsqrt.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fle_q, "fle.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(flt_q, "flt.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(feq_q, "feq.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fcvt_w_q, "fcvt.w.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_wu_q, "fcvt.wu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_q_w, "fcvt.q.w", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fcvt_q_wu, "fcvt.q.wu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fclass_q, "fclass.q", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fcvt_l_q, "fcvt.l.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_lu_q, "fcvt.lu.q", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fcvt_q_l, "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fcvt_q_lu, "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
> +OP(fmv_x_q, "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fmv_q_x, "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1)
> +OP(c_addi4spn, "c.addi4spn", rv_codec_ciw_4spn, NULL,
> DECOMP(rv_op_addi))
> +OP(c_fld, "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld))
> +OP(c_lw, "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw))
> +OP(c_flw, "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw))
> +OP(c_fsd, "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd))
> +OP(c_sw, "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw))
> +OP(c_fsw, "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw))
> +OP(c_addi, "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi))
> +OP(c_jal, "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal))
> +OP(c_li, "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi))
> +OP(c_addi16sp, "c.addi16sp", rv_codec_ci_16sp, NULL,
> DECOMP(rv_op_addi))
> +OP(c_lui, "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui))
> +OP(c_srli, "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli))
> +OP(c_srai, "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai))
> +OP(c_andi, "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi))
> +OP(c_sub, "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub))
> +OP(c_xor, "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor))
> +OP(c_or, "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or))
> +OP(c_and, "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and))
> +OP(c_subw, "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw))
> +OP(c_addw, "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw))
> +OP(c_j, "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j))
> +OP(c_beqz, "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz))
> +OP(c_bnez, "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez))
> +OP(c_slli, "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli))
> +OP(c_fldsp, "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld))
> +OP(c_lwsp, "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw))
> +OP(c_flwsp, "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw))
> +OP(c_jr, "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr))
> +OP(c_mv, "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv))
> +OP(c_ebreak, "c.ebreak", rv_codec_ci_none, NULL,
> DECOMP(rv_op_ebreak))
> +OP(c_jalr, "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr))
> +OP(c_add, "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add))
> +OP(c_fsdsp, "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fsd))
> +OP(c_swsp, "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw))
> +OP(c_fswsp, "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fsw))
> +OP(c_ld, "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld))
> +OP(c_sd, "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd))
> +OP(c_addiw, "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw))
> +OP(c_ldsp, "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld))
> +OP(c_sdsp, "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd))
> +OP(c_lq, "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq))
> +OP(c_sq, "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq))
> +OP(c_lqsp, "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq))
> +OP(c_sqsp, "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq))
> +OP(nop, "nop", rv_codec_illegal, rv_fmt_none)
> +OP(mv, "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv)
> +OP(not, "not", rv_codec_illegal, rv_fmt_rd_rs1)
> +OP(neg, "neg", rv_codec_illegal, rv_fmt_rd_rs2)
> +OP(negw, "negw", rv_codec_illegal, rv_fmt_rd_rs2)
> +OP(sext_w, "sext.w", rv_codec_illegal, rv_fmt_rd_rs1)
> +OP(seqz, "seqz", rv_codec_illegal, rv_fmt_rd_rs1)
> +OP(snez, "snez", rv_codec_illegal, rv_fmt_rd_rs2)
> +OP(sltz, "sltz", rv_codec_illegal, rv_fmt_rd_rs1)
> +OP(sgtz, "sgtz", rv_codec_illegal, rv_fmt_rd_rs2)
> +OP(fmv_s, "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fabs_s, "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fneg_s, "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fmv_d, "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fabs_d, "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fneg_d, "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fmv_q, "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fabs_q, "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(fneg_q, "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1)
> +OP(beqz, "beqz", rv_codec_illegal, rv_fmt_rs1_offset)
> +OP(bnez, "bnez", rv_codec_illegal, rv_fmt_rs1_offset)
> +OP(blez, "blez", rv_codec_illegal, rv_fmt_rs2_offset)
> +OP(bgez, "bgez", rv_codec_illegal, rv_fmt_rs1_offset)
> +OP(bltz, "bltz", rv_codec_illegal, rv_fmt_rs1_offset)
> +OP(bgtz, "bgtz", rv_codec_illegal, rv_fmt_rs2_offset)
> +OP(jal_ra, "jal", rv_codec_illegal, rv_fmt_offset)
> +OP(jalr_ra, "jalr", rv_codec_illegal, rv_fmt_rs1)
> +OP(j, "j", rv_codec_illegal, rv_fmt_offset)
> +OP(ret, "ret", rv_codec_illegal, rv_fmt_none)
> +OP(jr, "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr)
> +OP(rdcycle, "rdcycle", rv_codec_i_csr, rv_fmt_rd)
> +OP(rdtime, "rdtime", rv_codec_i_csr, rv_fmt_rd)
> +OP(rdinstret, "rdinstret", rv_codec_i_csr, rv_fmt_rd)
> +OP(rdcycleh, "rdcycleh", rv_codec_i_csr, rv_fmt_rd)
> +OP(rdtimeh, "rdtimeh", rv_codec_i_csr, rv_fmt_rd)
> +OP(rdinstreth, "rdinstreth", rv_codec_i_csr, rv_fmt_rd)
> +OP(frcsr, "frcsr", rv_codec_i_csr, rv_fmt_rd)
> +OP(frrm, "frrm", rv_codec_i_csr, rv_fmt_rd)
> +OP(frflags, "frflags", rv_codec_i_csr, rv_fmt_rd)
> +OP(fscsr, "fscsr", rv_codec_i_csr, rv_fmt_rd_rs1)
> +OP(fsrm, "fsrm", rv_codec_i_csr, rv_fmt_rd_rs1)
> +OP(fsflags, "fsflags", rv_codec_i_csr, rv_fmt_rd_rs1)
> +OP(fsrmi, "fsrmi", rv_codec_i_csr, rv_fmt_rd_zimm)
> +OP(fsflagsi, "fsflagsi", rv_codec_i_csr, rv_fmt_rd_zimm)
> +OP(bseti, "bseti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(bclri, "bclri", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(binvi, "binvi", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(bexti, "bexti", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(rori, "rori", rv_codec_i_sh7, rv_fmt_rd_rs1_imm)
> +OP(clz, "clz", rv_codec_r, rv_fmt_rd_rs1)
> +OP(ctz, "ctz", rv_codec_r, rv_fmt_rd_rs1)
> +OP(cpop, "cpop", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sext_h, "sext.h", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sext_b, "sext.b", rv_codec_r, rv_fmt_rd_rs1)
> +OP(xnor, "xnor", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(orn, "orn", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(andn, "andn", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(rol, "rol", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(ror, "ror", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sh1add, "sh1add", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sh2add, "sh2add", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sh3add, "sh3add", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sh1add_uw, "sh1add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sh2add_uw, "sh2add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sh3add_uw, "sh3add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(clmul, "clmul", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(clmulr, "clmulr", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(clmulh, "clmulh", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(min, "min", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(minu, "minu", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(max, "max", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(maxu, "maxu", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(clzw, "clzw", rv_codec_r, rv_fmt_rd_rs1)
> +OP(ctzw, "ctzw", rv_codec_r, rv_fmt_rd_rs1)
> +OP(cpopw, "cpopw", rv_codec_r, rv_fmt_rd_rs1)
> +OP(slli_uw, "slli.uw", rv_codec_i_sh6, rv_fmt_rd_rs1_imm)
> +OP(add_uw, "add.uw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(rolw, "rolw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(rorw, "rorw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(rev8, "rev8", rv_codec_r, rv_fmt_rd_rs1)
> +OP(zext_h, "zext.h", rv_codec_r, rv_fmt_rd_rs1)
> +OP(roriw, "roriw", rv_codec_i_sh5, rv_fmt_rd_rs1_imm)
> +OP(orc_b, "orc.b", rv_codec_r, rv_fmt_rd_rs1)
> +OP(bset, "bset", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(bclr, "bclr", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(binv, "binv", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(bext, "bext", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(aes32esmi, "aes32esmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
> +OP(aes32esi, "aes32esi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
> +OP(aes32dsmi, "aes32dsmi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
> +OP(aes32dsi, "aes32dsi", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
> +OP(aes64ks1i, "aes64ks1i", rv_codec_k_rnum, rv_fmt_rd_rs1_rnum)
> +OP(aes64ks2, "aes64ks2", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(aes64im, "aes64im", rv_codec_r, rv_fmt_rd_rs1)
> +OP(aes64esm, "aes64esm", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(aes64es, "aes64es", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(aes64dsm, "aes64dsm", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(aes64ds, "aes64ds", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha256sig0, "sha256sig0", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sha256sig1, "sha256sig1", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sha256sum0, "sha256sum0", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sha256sum1, "sha256sum1", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sha512sig0, "sha512sig0", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sig1, "sha512sig1", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sum0, "sha512sum0", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sum1, "sha512sum1", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sum0r, "sha512sum0r", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sum1r, "sha512sum1r", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sig0l, "sha512sig0l", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sig0h, "sha512sig0h", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sig1l, "sha512sig1l", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sha512sig1h, "sha512sig1h", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(sm3p0, "sm3p0", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sm3p1, "sm3p1", rv_codec_r, rv_fmt_rd_rs1)
> +OP(sm4ed, "sm4ed", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
> +OP(sm4ks, "sm4ks", rv_codec_k_bs, rv_fmt_rs1_rs2_bs)
> +OP(brev8, "brev8", rv_codec_r, rv_fmt_rd_rs1)
> +OP(pack, "pack", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(packh, "packh", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(packw, "packw", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(unzip, "unzip", rv_codec_r, rv_fmt_rd_rs1)
> +OP(zip, "zip", rv_codec_r, rv_fmt_rd_rs1)
> +OP(xperm4, "xperm4", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(xperm8, "xperm8", rv_codec_r, rv_fmt_rd_rs1)
> +OP(vle8_v, "vle8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vle16_v, "vle16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vle32_v, "vle32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vle64_v, "vle64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vse8_v, "vse8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vse16_v, "vse16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vse32_v, "vse32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vse64_v, "vse64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vlm_v, "vlm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vsm_v, "vsm.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vlse8_v, "vlse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vlse16_v, "vlse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vlse32_v, "vlse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vlse64_v, "vlse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vsse8_v, "vsse8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vsse16_v, "vsse16.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vsse32_v, "vsse32.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vsse64_v, "vsse64.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_rs2_vm)
> +OP(vluxei8_v, "vluxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vluxei16_v, "vluxei16.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vluxei32_v, "vluxei32.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vluxei64_v, "vluxei64.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vloxei8_v, "vloxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vloxei16_v, "vloxei16.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vloxei32_v, "vloxei32.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vloxei64_v, "vloxei64.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsuxei8_v, "vsuxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsuxei16_v, "vsuxei16.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsuxei32_v, "vsuxei32.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsuxei64_v, "vsuxei64.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsoxei8_v, "vsoxei8.v", rv_codec_v_r, rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsoxei16_v, "vsoxei16.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsoxei32_v, "vsoxei32.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vsoxei64_v, "vsoxei64.v", rv_codec_v_r,
> rv_fmt_ldst_vd_rs1_vs2_vm)
> +OP(vle8ff_v, "vle8ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vle16ff_v, "vle16ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vle32ff_v, "vle32ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vle64ff_v, "vle64ff.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl1re8_v, "vl1re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl1re16_v, "vl1re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl1re32_v, "vl1re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl1re64_v, "vl1re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl2re8_v, "vl2re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl2re16_v, "vl2re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl2re32_v, "vl2re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl2re64_v, "vl2re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl4re8_v, "vl4re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl4re16_v, "vl4re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl4re32_v, "vl4re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl4re64_v, "vl4re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl8re8_v, "vl8re8.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl8re16_v, "vl8re16.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl8re32_v, "vl8re32.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vl8re64_v, "vl8re64.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vs1r_v, "vs1r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vs2r_v, "vs2r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vs4r_v, "vs4r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vs8r_v, "vs8r.v", rv_codec_v_ldst, rv_fmt_ldst_vd_rs1_vm)
> +OP(vadd_vv, "vadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vadd_vx, "vadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vadd_vi, "vadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vsub_vv, "vsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsub_vx, "vsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vrsub_vx, "vrsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vrsub_vi, "vrsub.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vwaddu_vv, "vwaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwaddu_vx, "vwaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwadd_vv, "vwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwadd_vx, "vwadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwsubu_vv, "vwsubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwsubu_vx, "vwsubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwsub_vv, "vwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwsub_vx, "vwsub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwaddu_wv, "vwaddu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwaddu_wx, "vwaddu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwadd_wv, "vwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwadd_wx, "vwadd.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwsubu_wv, "vwsubu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwsubu_wx, "vwsubu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwsub_wv, "vwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwsub_wx, "vwsub.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vadc_vvm, "vadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
> +OP(vadc_vxm, "vadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> +OP(vadc_vim, "vadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
> +OP(vmadc_vvm, "vmadc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
> +OP(vmadc_vxm, "vmadc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> +OP(vmadc_vim, "vmadc.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
> +OP(vsbc_vvm, "vsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
> +OP(vsbc_vxm, "vsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> +OP(vmsbc_vvm, "vmsbc.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
> +OP(vmsbc_vxm, "vmsbc.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> +OP(vand_vv, "vand.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vand_vx, "vand.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vand_vi, "vand.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vor_vv, "vor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vor_vx, "vor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vor_vi, "vor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vxor_vv, "vxor.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vxor_vx, "vxor.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vxor_vi, "vxor.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vsll_vv, "vsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsll_vx, "vsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vsll_vi, "vsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vsrl_vv, "vsrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsrl_vx, "vsrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vsrl_vi, "vsrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vsra_vv, "vsra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsra_vx, "vsra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vsra_vi, "vsra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vnsrl_wv, "vnsrl.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vnsrl_wx, "vnsrl.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vnsrl_wi, "vnsrl.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vnsra_wv, "vnsra.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vnsra_wx, "vnsra.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vnsra_wi, "vnsra.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vmseq_vv, "vmseq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmseq_vx, "vmseq.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmseq_vi, "vmseq.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vmsne_vv, "vmsne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmsne_vx, "vmsne.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmsne_vi, "vmsne.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vmsltu_vv, "vmsltu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmsltu_vx, "vmsltu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmslt_vv, "vmslt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmslt_vx, "vmslt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmsleu_vv, "vmsleu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmsleu_vx, "vmsleu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmsleu_vi, "vmsleu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vmsle_vv, "vmsle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmsle_vx, "vmsle.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmsle_vi, "vmsle.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vmsgtu_vx, "vmsgtu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmsgtu_vi, "vmsgtu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vmsgt_vx, "vmsgt.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmsgt_vi, "vmsgt.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vminu_vv, "vminu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vminu_vx, "vminu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmin_vv, "vmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmin_vx, "vmin.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmaxu_vv, "vmaxu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmaxu_vx, "vmaxu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmax_vv, "vmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmax_vx, "vmax.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmul_vv, "vmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmul_vx, "vmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmulh_vv, "vmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmulh_vx, "vmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmulhu_vv, "vmulhu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmulhu_vx, "vmulhu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmulhsu_vv, "vmulhsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmulhsu_vx, "vmulhsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vdivu_vv, "vdivu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vdivu_vx, "vdivu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vdiv_vv, "vdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vdiv_vx, "vdiv.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vremu_vv, "vremu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vremu_vx, "vremu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vrem_vv, "vrem.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vrem_vx, "vrem.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwmulu_vv, "vwmulu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwmulu_vx, "vwmulu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwmulsu_vv, "vwmulsu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwmulsu_vx, "vwmulsu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwmul_vv, "vwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwmul_vx, "vwmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vmacc_vv, "vmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vmacc_vx, "vmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vnmsac_vv, "vnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vnmsac_vx, "vnmsac.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vmadd_vv, "vmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vmadd_vx, "vmadd.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vnmsub_vv, "vnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vnmsub_vx, "vnmsub.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vwmaccu_vv, "vwmaccu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vwmaccu_vx, "vwmaccu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vwmacc_vv, "vwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vwmacc_vx, "vwmacc.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vwmaccsu_vv, "vwmaccsu.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vwmaccsu_vx, "vwmaccsu.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vwmaccus_vx, "vwmaccus.vx", rv_codec_v_r, rv_fmt_vd_rs1_vs2_vm)
> +OP(vmv_v_v, "vmv.v.v", rv_codec_v_r, rv_fmt_vd_vs1)
> +OP(vmv_v_x, "vmv.v.x", rv_codec_v_r, rv_fmt_vd_rs1)
> +OP(vmv_v_i, "vmv.v.i", rv_codec_v_i, rv_fmt_vd_imm)
> +OP(vmerge_vvm, "vmerge.vvm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vl)
> +OP(vmerge_vxm, "vmerge.vxm", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vl)
> +OP(vmerge_vim, "vmerge.vim", rv_codec_v_i, rv_fmt_vd_vs2_imm_vl)
> +OP(vsaddu_vv, "vsaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsaddu_vx, "vsaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vsaddu_vi, "vsaddu.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vsadd_vv, "vsadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsadd_vx, "vsadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vsadd_vi, "vsadd.vi", rv_codec_v_i, rv_fmt_vd_vs2_imm_vm)
> +OP(vssubu_vv, "vssubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vssubu_vx, "vssubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vssub_vv, "vssub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vssub_vx, "vssub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vaadd_vv, "vaadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vaadd_vx, "vaadd.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vaaddu_vv, "vaaddu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vaaddu_vx, "vaaddu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vasub_vv, "vasub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vasub_vx, "vasub.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vasubu_vv, "vasubu.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vasubu_vx, "vasubu.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vsmul_vv, "vsmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vsmul_vx, "vsmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vssrl_vv, "vssrl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vssrl_vx, "vssrl.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vssrl_vi, "vssrl.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vssra_vv, "vssra.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vssra_vx, "vssra.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vssra_vi, "vssra.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vnclipu_wv, "vnclipu.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vnclipu_wx, "vnclipu.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vnclipu_wi, "vnclipu.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vnclip_wv, "vnclip.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vnclip_wx, "vnclip.wx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vnclip_wi, "vnclip.wi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(vfadd_vv, "vfadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfadd_vf, "vfadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfsub_vv, "vfsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfsub_vf, "vfsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfrsub_vf, "vfrsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfwadd_vv, "vfwadd.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwadd_vf, "vfwadd.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfwadd_wv, "vfwadd.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwadd_wf, "vfwadd.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfwsub_vv, "vfwsub.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwsub_vf, "vfwsub.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfwsub_wv, "vfwsub.wv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwsub_wf, "vfwsub.wf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfmul_vv, "vfmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfmul_vf, "vfmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfdiv_vv, "vfdiv.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfdiv_vf, "vfdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfrdiv_vf, "vfrdiv.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfwmul_vv, "vfwmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwmul_vf, "vfwmul.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfmacc_vv, "vfmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfmacc_vf, "vfmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfnmacc_vv, "vfnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfnmacc_vf, "vfnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfmsac_vv, "vfmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfmsac_vf, "vfmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfnmsac_vv, "vfnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfnmsac_vf, "vfnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfmadd_vv, "vfmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfmadd_vf, "vfmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfnmadd_vv, "vfnmadd.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfnmadd_vf, "vfnmadd.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfmsub_vv, "vfmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfmsub_vf, "vfmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfnmsub_vv, "vfnmsub.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfnmsub_vf, "vfnmsub.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfwmacc_vv, "vfwmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfwmacc_vf, "vfwmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfwnmacc_vv, "vfwnmacc.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfwnmacc_vf, "vfwnmacc.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfwmsac_vv, "vfwmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfwmsac_vf, "vfwmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfwnmsac_vv, "vfwnmsac.vv", rv_codec_v_r, rv_fmt_vd_vs1_vs2_vm)
> +OP(vfwnmsac_vf, "vfwnmsac.vf", rv_codec_v_r, rv_fmt_vd_fs1_vs2_vm)
> +OP(vfsqrt_v, "vfsqrt.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vfrsqrt7_v, "vfrsqrt7.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vfrec7_v, "vfrec7.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vfmin_vv, "vfmin.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfmin_vf, "vfmin.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfmax_vv, "vfmax.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfmax_vf, "vfmax.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfsgnj_vv, "vfsgnj.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfsgnj_vf, "vfsgnj.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfsgnjn_vv, "vfsgnjn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfsgnjn_vf, "vfsgnjn.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfsgnjx_vv, "vfsgnjx.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfsgnjx_vf, "vfsgnjx.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfslide1up_vf, "vfslide1up.vf", rv_codec_v_r,
> rv_fmt_vd_vs2_fs1_vm)
> +OP(vfslide1down_vf, "vfslide1down.vf", rv_codec_v_r,
> rv_fmt_vd_vs2_fs1_vm)
> +OP(vmfeq_vv, "vmfeq.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmfeq_vf, "vmfeq.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vmfne_vv, "vmfne.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmfne_vf, "vmfne.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vmflt_vv, "vmflt.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmflt_vf, "vmflt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vmfle_vv, "vmfle.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmfle_vf, "vmfle.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vmfgt_vf, "vmfgt.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vmfge_vf, "vmfge.vf", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vm)
> +OP(vfclass_v, "vfclass.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfmerge_vfm, "vfmerge.vfm", rv_codec_v_r, rv_fmt_vd_vs2_fs1_vl)
> +OP(vfmv_v_f, "vfmv.v.f", rv_codec_v_r, rv_fmt_vd_fs1)
> +OP(vfcvt_xu_f_v, "vfcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfcvt_x_f_v, "vfcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfcvt_f_xu_v, "vfcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfcvt_f_x_v, "vfcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfcvt_rtz_xu_f_v, "vfcvt.rtz.xu.f.v", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfcvt_rtz_x_f_v, "vfcvt.rtz.x.f.v", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_xu_f_v, "vfwcvt.xu.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_x_f_v, "vfwcvt.x.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_f_xu_v, "vfwcvt.f.xu.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_f_x_v, "vfwcvt.f.x.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_f_f_v, "vfwcvt.f.f.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_rtz_xu_f_v, "vfwcvt.rtz.xu.f.v", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfwcvt_rtz_x_f_v, "vfwcvt.rtz.x.f.v", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfncvt_xu_f_w, "vfncvt.xu.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfncvt_x_f_w, "vfncvt.x.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfncvt_f_xu_w, "vfncvt.f.xu.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfncvt_f_x_w, "vfncvt.f.x.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfncvt_f_f_w, "vfncvt.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vfncvt_rod_f_f_w, "vfncvt.rod.f.f.w", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfncvt_rtz_xu_f_w, "vfncvt.rtz.xu.f.w", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfncvt_rtz_x_f_w, "vfncvt.rtz.x.f.w", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vredsum_vs, "vredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredand_vs, "vredand.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredor_vs, "vredor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredxor_vs, "vredxor.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredminu_vs, "vredminu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredmin_vs, "vredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredmaxu_vs, "vredmaxu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vredmax_vs, "vredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwredsumu_vs, "vwredsumu.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwredsum_vs, "vwredsum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfredusum_vs, "vfredusum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfredosum_vs, "vfredosum.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfredmin_vs, "vfredmin.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfredmax_vs, "vfredmax.vs", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwredusum_vs, "vfwredusum.vs", rv_codec_v_r,
> rv_fmt_vd_vs2_vs1_vm)
> +OP(vfwredosum_vs, "vfwredosum.vs", rv_codec_v_r,
> rv_fmt_vd_vs2_vs1_vm)
> +OP(vmand_mm, "vmand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmnand_mm, "vmnand.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmandn_mm, "vmandn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmxor_mm, "vmxor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmor_mm, "vmor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmnor_mm, "vmnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmorn_mm, "vmorn.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vmxnor_mm, "vmxnor.mm", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vcpop_m, "vcpop.m", rv_codec_v_r, rv_fmt_rd_vs2_vm)
> +OP(vfirst_m, "vfirst.m", rv_codec_v_r, rv_fmt_rd_vs2_vm)
> +OP(vmsbf_m, "vmsbf.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vmsif_m, "vmsif.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vmsof_m, "vmsof.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(viota_m, "viota.m", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vid_v, "vid.v", rv_codec_v_r, rv_fmt_vd_vm)
> +OP(vmv_x_s, "vmv.x.s", rv_codec_v_r, rv_fmt_rd_vs2)
> +OP(vmv_s_x, "vmv.s.x", rv_codec_v_r, rv_fmt_vd_rs1)
> +OP(vfmv_f_s, "vfmv.f.s", rv_codec_v_r, rv_fmt_fd_vs2)
> +OP(vfmv_s_f, "vfmv.s.f", rv_codec_v_r, rv_fmt_vd_fs1)
> +OP(vslideup_vx, "vslideup.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vslideup_vi, "vslideup.vi", rv_codec_v_i_u,
> rv_fmt_vd_vs2_uimm_vm)
> +OP(vslide1up_vx, "vslide1up.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vslidedown_vx, "vslidedown.vx", rv_codec_v_r,
> rv_fmt_vd_vs2_rs1_vm)
> +OP(vslidedown_vi, "vslidedown.vi", rv_codec_v_i_u,
> rv_fmt_vd_vs2_uimm_vm)
> +OP(vslide1down_vx, "vslide1down.vx", rv_codec_v_r,
> rv_fmt_vd_vs2_rs1_vm)
> +OP(vrgather_vv, "vrgather.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vrgatherei16_vv, "vrgatherei16.vv", rv_codec_v_r,
> rv_fmt_vd_vs2_vs1_vm)
> +OP(vrgather_vx, "vrgather.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vrgather_vi, "vrgather.vi", rv_codec_v_i_u,
> rv_fmt_vd_vs2_uimm_vm)
> +OP(vcompress_vm, "vcompress.vm", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
> +OP(vmv1r_v, "vmv1r.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vmv2r_v, "vmv2r.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vmv4r_v, "vmv4r.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vmv8r_v, "vmv8r.v", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vzext_vf2, "vzext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vzext_vf4, "vzext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vzext_vf8, "vzext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vsext_vf2, "vsext.vf2", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vsext_vf4, "vsext.vf4", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vsext_vf8, "vsext.vf8", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vsetvli, "vsetvli", rv_codec_vsetvli, rv_fmt_vsetvli)
> +OP(vsetivli, "vsetivli", rv_codec_vsetivli, rv_fmt_vsetivli)
> +OP(vsetvl, "vsetvl", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(c_zext_b, "c.zext.b", rv_codec_zcb_ext, rv_fmt_rd)
> +OP(c_sext_b, "c.sext.b", rv_codec_zcb_ext, rv_fmt_rd)
> +OP(c_zext_h, "c.zext.h", rv_codec_zcb_ext, rv_fmt_rd)
> +OP(c_sext_h, "c.sext.h", rv_codec_zcb_ext, rv_fmt_rd)
> +OP(c_zext_w, "c.zext.w", rv_codec_zcb_ext, rv_fmt_rd)
> +OP(c_not, "c.not", rv_codec_zcb_ext, rv_fmt_rd)
> +OP(c_mul, "c.mul", rv_codec_zcb_mul, rv_fmt_rd_rs2)
> +OP(c_lbu, "c.lbu", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst)
> +OP(c_lhu, "c.lhu", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst)
> +OP(c_lh, "c.lh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst)
> +OP(c_sb, "c.sb", rv_codec_zcb_lb, rv_fmt_rs1_rs2_zce_ldst)
> +OP(c_sh, "c.sh", rv_codec_zcb_lh, rv_fmt_rs1_rs2_zce_ldst)
> +OP(cm_push, "cm.push", rv_codec_zcmp_cm_pushpop, rv_fmt_push_rlist)
> +OP(cm_pop, "cm.pop", rv_codec_zcmp_cm_pushpop, rv_fmt_pop_rlist)
> +OP(cm_popret, "cm.popret", rv_codec_zcmp_cm_pushpop,
> rv_fmt_pop_rlist)
> +OP(cm_popretz, "cm.popretz", rv_codec_zcmp_cm_pushpop,
> rv_fmt_pop_rlist)
> +OP(cm_mva01s, "cm.mva01s", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2)
> +OP(cm_mvsa01, "cm.mvsa01", rv_codec_zcmp_cm_mv, rv_fmt_rd_rs2)
> +OP(cm_jt, "cm.jt", rv_codec_zcmt_jt, rv_fmt_zcmt_index)
> +OP(cm_jalt, "cm.jalt", rv_codec_zcmt_jt, rv_fmt_zcmt_index)
> +OP(czero_eqz, "czero.eqz", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(czero_nez, "czero.nez", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(fcvt_bf16_s, "fcvt.bf16.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fcvt_s_bf16, "fcvt.s.bf16", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(vfncvtbf16_f_f_w, "vfncvtbf16.f.f.w", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfwcvtbf16_f_f_v, "vfwcvtbf16.f.f.v", rv_codec_v_r,
> rv_fmt_vd_vs2_vm)
> +OP(vfwmaccbf16_vv, "vfwmaccbf16.vv", rv_codec_v_r,
> rv_fmt_vd_vs1_vs2_vm)
> +OP(vfwmaccbf16_vf, "vfwmaccbf16.vf", rv_codec_v_r,
> rv_fmt_vd_fs1_vs2_vm)
> +OP(flh, "flh", rv_codec_i, rv_fmt_frd_offset_rs1)
> +OP(fsh, "fsh", rv_codec_s, rv_fmt_frs2_offset_rs1)
> +OP(fmv_h_x, "fmv.h.x", rv_codec_r, rv_fmt_frd_rs1)
> +OP(fmv_x_h, "fmv.x.h", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fli_s, "fli.s", rv_codec_fli, rv_fmt_fli)
> +OP(fli_d, "fli.d", rv_codec_fli, rv_fmt_fli)
> +OP(fli_q, "fli.q", rv_codec_fli, rv_fmt_fli)
> +OP(fli_h, "fli.h", rv_codec_fli, rv_fmt_fli)
> +OP(fminm_s, "fminm.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmaxm_s, "fmaxm.s", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fminm_d, "fminm.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmaxm_d, "fmaxm.d", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fminm_q, "fminm.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmaxm_q, "fmaxm.q", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fminm_h, "fminm.h", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fmaxm_h, "fmaxm.h", rv_codec_r, rv_fmt_frd_frs1_frs2)
> +OP(fround_s, "fround.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(froundnx_s, "froundnx.s", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fround_d, "fround.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(froundnx_d, "froundnx.d", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fround_q, "fround.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(froundnx_q, "froundnx.q", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fround_h, "fround.h", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(froundnx_h, "froundnx.h", rv_codec_r_m, rv_fmt_rm_frd_frs1)
> +OP(fcvtmod_w_d, "fcvtmod.w.d", rv_codec_r_m, rv_fmt_rm_rd_frs1)
> +OP(fmvh_x_d, "fmvh.x.d", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fmvp_d_x, "fmvp.d.x", rv_codec_r, rv_fmt_frd_rs1_rs2)
> +OP(fmvh_x_q, "fmvh.x.q", rv_codec_r, rv_fmt_rd_frs1)
> +OP(fmvp_q_x, "fmvp.q.x", rv_codec_r, rv_fmt_frd_rs1_rs2)
> +OP(fleq_s, "fleq.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fltq_s, "fltq.s", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fleq_d, "fleq.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fltq_d, "fltq.d", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fleq_q, "fleq.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fltq_q, "fltq.q", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fleq_h, "fleq.h", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(fltq_h, "fltq.h", rv_codec_r, rv_fmt_rd_frs1_frs2)
> +OP(vaesdf_vv, "vaesdf.vv", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesdf_vs, "vaesdf.vs", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesdm_vv, "vaesdm.vv", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesdm_vs, "vaesdm.vs", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesef_vv, "vaesef.vv", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesef_vs, "vaesef.vs", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesem_vv, "vaesem.vv", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaesem_vs, "vaesem.vs", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vaeskf1_vi, "vaeskf1.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
> +OP(vaeskf2_vi, "vaeskf2.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
> +OP(vaesz_vs, "vaesz.vs", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vandn_vv, "vandn.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vandn_vx, "vandn.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vbrev_v, "vbrev.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vbrev8_v, "vbrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vclmul_vv, "vclmul.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vclmul_vx, "vclmul.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vclmulh_vv, "vclmulh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vclmulh_vx, "vclmulh.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vclz_v, "vclz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vcpop_v, "vcpop.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vctz_v, "vctz.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vghsh_vv, "vghsh.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
> +OP(vgmul_vv, "vgmul.vv", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vrev8_v, "vrev8.v", rv_codec_v_r, rv_fmt_vd_vs2_vm)
> +OP(vrol_vv, "vrol.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vrol_vx, "vrol.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vror_vv, "vror.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vror_vx, "vror.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vror_vi, "vror.vi", rv_codec_vror_vi, rv_fmt_vd_vs2_uimm_vm)
> +OP(vsha2ch_vv, "vsha2ch.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
> +OP(vsha2cl_vv, "vsha2cl.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
> +OP(vsha2ms_vv, "vsha2ms.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
> +OP(vsm3c_vi, "vsm3c.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
> +OP(vsm3me_vv, "vsm3me.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1)
> +OP(vsm4k_vi, "vsm4k.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm)
> +OP(vsm4r_vv, "vsm4r.vv", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vsm4r_vs, "vsm4r.vs", rv_codec_v_r, rv_fmt_vd_vs2)
> +OP(vwsll_vv, "vwsll.vv", rv_codec_v_r, rv_fmt_vd_vs2_vs1_vm)
> +OP(vwsll_vx, "vwsll.vx", rv_codec_v_r, rv_fmt_vd_vs2_rs1_vm)
> +OP(vwsll_vi, "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
> +OP(amocas_w, "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(mop_r_0, "mop.r.0", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_1, "mop.r.1", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_2, "mop.r.2", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_3, "mop.r.3", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_4, "mop.r.4", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_5, "mop.r.5", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_6, "mop.r.6", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_7, "mop.r.7", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_8, "mop.r.8", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_9, "mop.r.9", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_10, "mop.r.10", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_11, "mop.r.11", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_12, "mop.r.12", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_13, "mop.r.13", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_14, "mop.r.14", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_15, "mop.r.15", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_16, "mop.r.16", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_17, "mop.r.17", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_18, "mop.r.18", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_19, "mop.r.19", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_20, "mop.r.20", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_21, "mop.r.21", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_22, "mop.r.22", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_23, "mop.r.23", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_24, "mop.r.24", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_25, "mop.r.25", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_26, "mop.r.26", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_27, "mop.r.27", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_28, "mop.r.28", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_29, "mop.r.29", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_30, "mop.r.30", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_r_31, "mop.r.31", rv_codec_r, rv_fmt_rd_rs1)
> +OP(mop_rr_0, "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_1, "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_2, "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_3, "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_4, "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_5, "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_6, "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(mop_rr_7, "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2)
> +OP(c_mop_1, "c.mop.1", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_3, "c.mop.3", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_5, "c.mop.5", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_7, "c.mop.7", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_9, "c.mop.9", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_11, "c.mop.11", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_13, "c.mop.13", rv_codec_ci_none, rv_fmt_none)
> +OP(c_mop_15, "c.mop.15", rv_codec_ci_none, rv_fmt_none)
> +OP(amoswap_b, "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoadd_b, "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoxor_b, "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoor_b, "amoor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoand_b, "amoand.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomin_b, "amomin.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomax_b, "amomax.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amominu_b, "amominu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomaxu_b, "amomaxu.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoswap_h, "amoswap.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoadd_h, "amoadd.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoxor_h, "amoxor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoor_h, "amoor.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amoand_h, "amoand.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomin_h, "amomin.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomax_h, "amomax.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amominu_h, "amominu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amomaxu_h, "amomaxu.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amocas_b, "amocas.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(amocas_h, "amocas.h", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(wrs_sto, "wrs.sto", rv_codec_none, rv_fmt_none)
> +OP(wrs_nto, "wrs.nto", rv_codec_none, rv_fmt_none)
> +OP(lpad, "lpad", rv_codec_lp, rv_fmt_imm)
> +OP(sspush, "sspush", rv_codec_r, rv_fmt_rs2)
> +OP(sspopchk, "sspopchk", rv_codec_r, rv_fmt_rs1)
> +OP(ssrdp, "ssrdp", rv_codec_r, rv_fmt_rd)
> +OP(ssamoswap_w, "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(ssamoswap_d, "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
> +OP(c_sspush, "c.sspush", rv_codec_cmop_ss, NULL,
> DECOMP(rv_op_sspush))
> +OP(c_sspopchk, "c.sspopchk", rv_codec_cmop_ss, NULL,
> DECOMP(rv_op_sspopchk))
> +OP(cbo_inval, "cbo.inval", rv_codec_r, rv_fmt_rs1)
> +OP(cbo_clean, "cbo.clean", rv_codec_r, rv_fmt_rs1)
> +OP(cbo_flush, "cbo.flush", rv_codec_r, rv_fmt_rs1)
> +OP(cbo_zero, "cbo.zero", rv_codec_r, rv_fmt_rs1)
> +OP(mnret, "mnret", rv_codec_none, rv_fmt_none)

