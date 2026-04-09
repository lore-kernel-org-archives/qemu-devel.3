Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C07F364C8
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 22:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAxhK-0006XL-7P; Thu, 09 Apr 2026 18:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxhI-0006Sk-Kj
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:18:00 -0400
Received: from p-east2-cluster6-host3-snip4-3.eps.apple.com ([57.103.76.134]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wAxhG-0002yK-Qi
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 18:18:00 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPS id
 18CEE180042A; Thu, 09 Apr 2026 22:17:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775773077; x=1778365077;
 bh=MzVrR2lSZzcy1VD9wZcr9Q46aOPo2W0oXZL6j0IEOGY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=A4kxSLvUByhF3fjJbudXPU1MGs1oNKWw9X8H5Dxv6CB6PwlBwypxvyWfw4O6XcVCXPx/I2KFNLsovus8ohVL4xAuwJsasvxh8/sdEBfH9AcIivkNYJ2buH081KNXdkcKKzV1z9qBkg9Iw+/4ezDTtOOt8aPZGRykBwnW58ElUjSgocsyWly/9AhL9yaAm9jDqAQlqAA954dlDEIZt+kJK9nGNUBcVtdWaH8VYfjBh8/Ttn8pC3Rq8/Za8cgA6EEmjMfk117jeAEYZEkB0HkXQbbP82N5WoE4ffFJfNatehh4ZNNuJA2vt/JMRhRLPYynlBhJ9+YhgmDWsPgyOeAZzg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-9 (Postfix) with ESMTPSA id
 35C0C1800148; Thu, 09 Apr 2026 22:17:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 4/6] target/arm/emulate: add load/store exclusive
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260409220614.65558-5-lucaaamaral@gmail.com>
Date: Fri, 10 Apr 2026 00:17:41 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8F0D843-720B-4D09-BA15-770709E8F3D0@unpredictable.fr>
References: <20260409220614.65558-1-lucaaamaral@gmail.com>
 <20260409220614.65558-5-lucaaamaral@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: foU_E7xso2OI9eVx3X647nuia1j_juMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNiBTYWx0ZWRfX39Ozt3SCAgOi
 QxTT/KIdlBML8pPRSdbBUcvt4liEgad6+acRVzouOZwnwrI+7R8CS4mDP2P7XFdQKkTTV3UNNE1
 qxuwsBJ40c2bv0TV9snhw4VgITdEVVQ4tjkZrmK5YmRjx9NcaSefU3XHEFenS2vezCc+h+pxAaA
 xL8Jpu69hcm/8AJRgWwflamaNW2UVQPyJ9OC1ULbOgi+7QcCI8Uh7UkoPRxnCTzHEfyOFKaLDqo
 d9OcTTVomSVMmkPyFKRekZUmdwmYyTy9H233sWWxVomElXtUEO6KEQQtFxtwEkN+ojVnaCpcgQK
 mghLjS4ZVK/p6boqWSsUYZvss4LQylKcGQFF6YGC9pGJ5uc2fV4FCQvrT7gUe0=
X-Proofpoint-ORIG-GUID: foU_E7xso2OI9eVx3X647nuia1j_juMA
X-Authority-Info-Out: v=2.4 cv=YdWwJgRf c=1 sm=1 tr=0 ts=69d82594
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=3IhpsqR_k5r1Whet_bcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 clxscore=1030 suspectscore=0 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090206
Received-SPF: pass client-ip=57.103.76.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10. Apr 2026, at 00:06, Lucas Amaral <lucaaamaral@gmail.com> wrote:
>=20
> Add emulation for load/store exclusive instructions (DDI 0487 C3.3.6).
> Exclusive monitors have no meaning on emulated MMIO accesses, so STXR
> always reports success (Rs=3D0) and LDXR does not set a monitor.

Do people actually use those?

And if so I wonder if that=E2=80=99s an application bug=E2=80=A6

If needed to get apps running,

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

As we do similar things for x86 anyhow...

>=20
> Instruction coverage:
>  - STXR/STLXR: exclusive store, 8/16/32/64-bit
>  - LDXR/LDAXR: exclusive load, 8/16/32/64-bit
>  - STXP/STLXP: exclusive store pair, 32/64-bit
>  - LDXP/LDAXP: exclusive load pair, 32/64-bit
>=20
> STXP/LDXP use two explicit decode patterns (sz=3D2, sz=3D3) for the
> 32/64-bit size variants.
>=20
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
> target/arm/emulate/a64-ldst.decode | 22 ++++++++++
> target/arm/emulate/arm_emulate.c   | 70 ++++++++++++++++++++++++++++++
> 2 files changed, 92 insertions(+)
>=20
> diff --git a/target/arm/emulate/a64-ldst.decode =
b/target/arm/emulate/a64-ldst.decode
> index f3de3f86..fadf6fd2 100644
> --- a/target/arm/emulate/a64-ldst.decode
> +++ b/target/arm/emulate/a64-ldst.decode
> @@ -10,6 +10,9 @@
> # 'u' flag: 0 =3D 9-bit signed immediate (byte offset), 1 =3D 12-bit =
unsigned (needs << sz)
> &ldst_imm       rt rn imm sz sign w p unpriv ext u
>=20
> +# Load/store exclusive
> +&stxr           rn rt rt2 rs sz lasr
> +
> # Load/store pair (GPR and SIMD/FP)
> &ldstpair       rt2 rt rn imm sz sign w p
>=20
> @@ -18,6 +21,9 @@
>=20
> ### Format templates
>=20
> +# Exclusives
> +@stxr           sz:2 ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5   &stxr
> +
> # Load/store immediate (9-bit signed)
> @ldst_imm       .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=3D0 =
unpriv=3D0 p=3D0 w=3D0
> @ldst_imm_pre   .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=3D0 =
unpriv=3D0 p=3D0 w=3D1
> @@ -134,6 +140,22 @@ STR_v_i         00 111 1 01 10 ............ ..... =
.....         @ldst_uimm sign=3D
> LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       =
@ldst_uimm sign=3D0 ext=3D0
> LDR_v_i         00 111 1 01 11 ............ ..... .....         =
@ldst_uimm sign=3D0 ext=3D0 sz=3D4
>=20
> +### Load/store exclusive
> +
> +# STXR / STLXR  (sz encodes 8/16/32/64-bit)
> +STXR            .. 001000 000 ..... . ..... ..... .....         @stxr
> +
> +# LDXR / LDAXR
> +LDXR            .. 001000 010 ..... . ..... ..... .....         @stxr
> +
> +# STXP / STLXP  (bit[31]=3D1, bit[30]=3Dsf =E2=86=92 sz=3D2 for =
32-bit, sz=3D3 for 64-bit)
> +STXP            10 001000 001 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr =
sz=3D2
> +STXP            11 001000 001 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr =
sz=3D3
> +
> +# LDXP / LDAXP
> +LDXP            10 001000 011 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr =
sz=3D2
> +LDXP            11 001000 011 rs:5 lasr:1 rt2:5 rn:5 rt:5      &stxr =
sz=3D3
> +
> ### Load/store pair =E2=80=94 non-temporal (STNP/LDNP)
>=20
> # STNP/LDNP: offset only, no writeback.  Non-temporal hint ignored.
> diff --git a/target/arm/emulate/arm_emulate.c =
b/target/arm/emulate/arm_emulate.c
> index 2d86b90f..7f876355 100644
> --- a/target/arm/emulate/arm_emulate.c
> +++ b/target/arm/emulate/arm_emulate.c
> @@ -477,6 +477,76 @@ static bool trans_LDR_v(DisasContext *ctx, =
arg_ldst *a)
>     return true;
> }
>=20
> +/*
> + * Load/store exclusive: STXR, LDXR, STXP, LDXP
> + * (DDI 0487 C3.3.6)
> + *
> + * Exclusive monitors have no meaning on MMIO.  STXR always reports
> + * success (Rs=3D0) and LDXR does not set an exclusive monitor.
> + */
> +
> +static bool trans_STXR(DisasContext *ctx, arg_stxr *a)
> +{
> +    int esize =3D 1 << a->sz;
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[8];
> +
> +    mem_st(ctx, buf, esize, gpr_read(ctx, a->rt));
> +    if (mem_write(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    /* Report success -- no exclusive monitor on emulated access */
> +    gpr_write(ctx, a->rs, 0);
> +    return true;
> +}
> +
> +static bool trans_LDXR(DisasContext *ctx, arg_stxr *a)
> +{
> +    int esize =3D 1 << a->sz;
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[8];
> +
> +    if (mem_read(ctx, va, buf, esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    gpr_write(ctx, a->rt, mem_ld(ctx, buf, esize));
> +    return true;
> +}
> +
> +static bool trans_STXP(DisasContext *ctx, arg_stxr *a)
> +{
> +    int esize =3D 1 << a->sz;                   /* sz=3D2->4, sz=3D3->8=
 */
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[16];
> +
> +    mem_st(ctx, buf, esize, gpr_read(ctx, a->rt));
> +    mem_st(ctx, buf + esize, esize, gpr_read(ctx, a->rt2));
> +
> +    if (mem_write(ctx, va, buf, 2 * esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    gpr_write(ctx, a->rs, 0);  /* success */
> +    return true;
> +}
> +
> +static bool trans_LDXP(DisasContext *ctx, arg_stxr *a)
> +{
> +    int esize =3D 1 << a->sz;
> +    uint64_t va =3D base_read(ctx, a->rn);
> +    uint8_t buf[16];
> +
> +    if (mem_read(ctx, va, buf, 2 * esize) !=3D 0) {
> +        return true;
> +    }
> +
> +    gpr_write(ctx, a->rt, mem_ld(ctx, buf, esize));
> +    gpr_write(ctx, a->rt2, mem_ld(ctx, buf + esize, esize));
> +    return true;
> +}
> +
> /* PRFM, DC cache maintenance -- treated as NOP */
> static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
> {
> --=20
> 2.52.0
>=20
>=20


