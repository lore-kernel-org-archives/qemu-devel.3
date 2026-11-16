Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15AB606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IO9uYEa4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT1eK-0008VD-Qp; Mon, 16 Nov 2026 13:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT1eJ-0008Uj-35
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:41:51 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT1eG-0007aY-Tc
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 13:41:50 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so42084185e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794854507; x=1795459307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g/FKLq3GFAut/12UiI3qYkPvweKpaUbZMtn7PvpbZnE=;
 b=IO9uYEa4/buofyIjzD3ZIt734jusBU04xhtMAuZ9WsqN59UDRYuvI8W4QFa6/MtPBU
 L4j1r8NN0CHieDhGNhJRlJOAkPp6FW8m0WUtwM9FN5N0DbZT+A+fbpPutSh9OSaSLpXE
 pbCO6evgVkcLw//9FsVsF7JtUd41wuRSkm2RMysTX7O9SLyoTOV//KpMX/yu2rHw8r/B
 e7QaoSq0Vup5+MCd3t7lbW8cY0IwqG9jfLu868dN195+bKRe5F+nESCDHLKf7bsrd2Hw
 hTXdqMpsKGcOefa6OkUmdR9P+GvEtEtJ55kZjy3NywCdpJ7r32NttYCjxRozvyF4dngh
 Mm0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854507; x=1795459307;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g/FKLq3GFAut/12UiI3qYkPvweKpaUbZMtn7PvpbZnE=;
 b=ooiu2pE1A3RmTwCamCScFJGBJFrP4wahGsxmoUB6A9MSdO4NnijSUPvecarNCflSIm
 UmAWNVoHBhtCI2J8y7qGJ0O/zNwE6ofnHFLqrZaXtdm6/W/292mXWDicbthgvF0dmPVB
 piEAkOOas+CcNda/R+dX2FXldL1yn9y+UNqrRRgwsdKrYxFCMVPsegCk4yUCR5eR6pb6
 JWn6nUzVB6+deMXB3/LHYj//g6o7ZQ8F+Mnt+K0dflsED5fzFAL/IdXKfwKvDe7ozZNR
 grjiqzkZetuH/5H9Xef/BHN2Pz0wSs/43Mkcn3W/9a53KQP9nKHU0xdEsSKJwwzIS+HX
 QIrw==
X-Gm-Message-State: APuU4Z9uD6Eo+ptNPmqQMq5XYWyke+2/6uvJJv+1EOX7chrqapYFahUv
 Pb850YmDyCOgkW996z/4aD2FXJXX0y1YDZeoTSsyons3jDcEPBDNpVLOLGTMYKwGX4k=
X-Gm-Gg: AYBFou0tsnepTYsbVkAe/6EIHH2g+fJCgcGaQ7WsCNJA4wYnbgVO0rJKX3q7qcYK3it
 S87VHD6tnJlF6RMM1KJr2o/cSO/MedNxVSqIOuRY4gjR0o2vtM3ACySCQ8KezOswKqhD34gXh23
 9eGNJW17j7LvW3Ut7kPkCKMNe8Z/sJOZdSP8/Ik4yg13fmt9JbdCyk6Aq98nTHzUMGABVDwhslp
 0z5sRPo1bchpsobsyA7Ga8pj+ymw+lhc2nOw4F9fDka1GwvvqJOb/GQij1lE88YyL1HXWx7uJ4F
 cN9lbGIQqkZYX7YR7iCBg5px1yhG84gYs7o2K92N4xwbstTtdXDWop4y6Jx9O/tfScmnjGhSzA+
 DeL9kKjmzhieqaj2kUieLA5Xdsa+uuCz85ORl423CzHNMyuGVmhavmih1NCwGdatLXztGeT7upw
 5sG8BhZFMrJtVejR08WhbtFGhIPNqs0KiXCSDTbVLWLrQTJ3MmGTCzA2aYetpxPOr0plIdZSYrS
 zIwowxR6VGdsPlePpuS3BiZhyAwQuT3czT76qLDV1qgOrSmint7zAvuDYiCW1UCx0rrYZoXFLYP
 d6isEoda8Y7CjxFt4uESkxRTn7Na
X-Received: by 2002:a05:600c:501f:b0:4bb:76f6:d23a with SMTP id
 5b1f17b1804b1-4bb779f5b93mr26225815e9.21.1794854506737; 
 Mon, 16 Nov 2026 10:41:46 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56f97257sm200563315e9.4.2026.11.16.10.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:41:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C356D5F8FE;
 Mon, 16 Nov 2026 18:41:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 palmer@dabbelt.com,  alistair.francis@wdc.com,  liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com,  chao.liu@processmission.com,
 peter.maydell@linaro.org,  richard.henderson@linaro.org
Subject: Re: [PATCH 2/3] target/arm: Fix RCsc ordering of store-release
 instructions
In-Reply-To: <20260821064032.49556-3-zhiwei_liu@linux.alibaba.com> (LIU
 Zhiwei's message of "Fri, 21 Aug 2026 14:40:31 +0800")
References: <20260821064032.49556-1-zhiwei_liu@linux.alibaba.com>
 <20260821064032.49556-3-zhiwei_liu@linux.alibaba.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Mon, 16 Nov 2026 18:41:44 +0000
Message-ID: <87bj7ok49j.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> writes:

> The Armv8 memory model has no RCpc store: every store-release in the
> architecture, including the AArch64 STLR and STLPUR and the A32/T32
> STL, STLB and STLH, carries RCsc semantics (Arm Architecture Reference
> Manual, DDI 0487, section B2.3.8 "Acquire and release semantics").
> The architecture therefore orders a Store-Release tagged RCsc before
> any subsequent Load-Acquire tagged RCsc of the same shareability
> domain, which is what forbids the [0,0] outcome of a Store Buffering
> litmus test that pairs "STLR X=3D1; LDAR Y" on one PE with
> "STLR Y=3D1; LDAR X" on another.
>
> The translators only emit a barrier before the store, which orders the
> memory operations preceding the store before the store itself (release
> semantics).  Nothing prevents the store from being reordered with the
> memory operations that follow it, so under MTTCG the host CPU may
> execute the load-acquire that immediately follows a store-release
> before the store has left its store buffer:
>
>   * on an x86 host (TSO), store-load is the only reordering the
>     hardware may perform, and it is exactly the ordering that is
>     missing here;
>
>   * on an aarch64 host, no dmb follows the store either.
>
> The defect is easily observed with a bare-metal Store Buffering litmus
> test on a 2 vCPU virt guest: "STLR X=3D1; LDAR Y" on CPU 0 and
> "STLR Y=3D1; LDAR X" on CPU 1 produce the architecturally forbidden [0,0]
> result in 6 to 7 out of 100000 iterations, while inserting a DMB ISH
> between the store and the load on each CPU brings the number to 0,
> which validates the harness.
>
> Fix this by emitting a full barrier after the store as well, for
> STLR/STLLR and STLPUR on the AArch64 side and STL/STLB/STLH on the
> A32/T32 side.  The TCG_MO_ST_LD bit included in TCG_MO_ALL makes the
> x86 backend emit a serializing lock-prefixed instruction after the
> store, draining the store buffer before any subsequent load executes,
> and the aarch64 backend emit dmb ish; the store therefore becomes
> globally visible before any subsequent memory operation of the same
> vCPU, and the RCsc store->load ordering is satisfied.  This is
> stronger than the architecture strictly requires, since the barrier
> also orders the store with respect to subsequent RCpc operations such
> as LDAPR, but this matches how QEMU already implements FENCE-like
> ordering and keeps the fix simple.  After the fix the litmus test no
> longer produces the forbidden outcome.
>
> The load-acquire side needs no change: the barrier emitted after an
> RCsc LDAR already orders it with all subsequent memory operations, and
> QEMU deliberately implements the RCpc LDAPR family as full load-acquire.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/arm/tcg/translate-a64.c | 13 +++++++++++++
>  target/arm/tcg/translate.c     |  6 ++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a6=
4.c
> index 4f9a93950b..b5bf977910 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -3672,6 +3672,13 @@ static bool trans_STLR(DisasContext *s, arg_stlr *=
a)
>                                  true, a->rn !=3D 31, memop);
>      do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
>                iss_sf, a->lasr);
> +    /*
> +     * STLR is an RCsc store-release: the Armv8 architecture orders it
> +     * before any subsequent RCsc load-acquire, which is what forbids the
> +     * store-buffering litmus test.  The barrier above only orders
> +     * previous accesses before the store.
> +     */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>      return true;
>  }
>=20=20
> @@ -4415,6 +4422,12 @@ static bool trans_STLR_i(DisasContext *s, arg_ldap=
r_stlr_i *a)
>      /* Store-Release semantics */
>      tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>      do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, mop, true, a->rt, iss_sf=
, true);
> +    /*
> +     * Like STLR, STLPUR is an RCsc store-release and must be ordered
> +     * before any subsequent RCsc load-acquire, so it needs a barrier
> +     * after the store as well.
> +     */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>      return true;
>  }
>=20=20
> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index 1770428d3c..bddac41bf9 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -4259,6 +4259,12 @@ static bool op_stl(DisasContext *s, arg_STL *a, Me=
mOp mop)
>      tmp =3D load_reg(s, a->rt);
>      tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
>      gen_aa32_st_i32(s, tmp, addr, get_mem_index(s), mop | MO_ALIGN);
> +    /*
> +     * STL has the same RCsc store-release semantics as the AArch64 STLR
> +     * and must be ordered before a subsequent RCsc load-acquire (LDA).
> +     * The barrier above only orders previous accesses before the store.
> +     */
> +    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>      disas_set_da_iss(s, mop, a->rt | ISSIsAcqRel | ISSIsWrite);
>=20=20
>      return true;


Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4872

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

