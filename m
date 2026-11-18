Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608A660A2625
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UDuXhIA2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FhUexrQd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgS0-0002FZ-5F; Wed, 18 Nov 2026 09:15:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1xTgRn-0002A6-UL
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:15:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1xTgRj-00034t-ED
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 09:15:38 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIDQGGm2226352
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5k/duKR+6LJ2BpSZiLTaidBrk2eDLUtm+ZDrSdMYO5A=; b=UDuXhIA2chJjBIua
 THtQFms7pplJgaj60yU+MtTul8Yry24+4NL+8wLkLNFsDor0tmY/SHdV/ntxnV7O
 u+Wzv3Ip46FPUIeGBpRQUxTm7iakSJPCyirYiIh7qlURZ3fNjSZu/QrwDWO/I4et
 IDWzCmctiAwKCHkOlM76J0iweqLmRRG8ZgjMOSzPPbxAkuQHBjJ60FhSOA16uYJq
 G+ZOnXok2HmjBaHPFpOHGa+OFPIWWpp8WtfPgIKGbt0m9rgnj/3/SNsuq/egw9v3
 PwTOia+7HPuZKP+pqBQTP4lU59zIZ249jn3t2eGUcp6pB+0X3zS3NS4BocXoyFLv
 bvj45A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvbbb99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 14:15:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8b930598cf0so1468076b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 06:15:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795011329; cv=none;
 d=google.com; s=arc-20260327;
 b=qEzs007yS9ZrLZDmd9yyZfJTEZFG9BpEZZKcYRJBiV8F44D7HIvRLhHsbVhpavLP4t
 hxQ548Qv3Fym2jWmYzlARCjR8ciKtqz0KZgLoeMcG0Pe1tn2CoMWZlhM1SwC4/mTEa8W
 fc2GP0YvO8zW7/11Qc2M2Eib8UHsPcl1OKBBllR0P1UBPVlorDcz5L5rsPxxnWhgfEgU
 dhDW/NCpvpLYML99wGhXy0po4Z3dJ5udDHmM77fhdn5hMQTGhx3PtfZ/janyxEhBroeq
 w8i9fFF39fITuNoQRrZT0+jegRyK6gP1cwU9NemTDmdhiw6oWXMctti+ZvNFgTm0Jww3
 Qldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5k/duKR+6LJ2BpSZiLTaidBrk2eDLUtm+ZDrSdMYO5A=;
 fh=dubqAeLjtRPjNPOp1YH6cLCCbknWE8d3yBA8jS6hFOk=;
 b=P/Ga7qfSsYZolDWrhpU4NFqCAryTFd4K//uUdnjcPyfSAqTa5oP6ZwkM4CDm5tB662
 12YP6CFfzK6vX21qNVVBnVIuvtBgX0ss06Sq/1ODomwbo3Lh6Hiyl/2j/jAgzORCdmoh
 WNAjS0igYSvUbgn8nW3WR8F0w9e9EiHBf4fiP/6W/4Ibv/t+6yomH/pDS0P3xHmKuk/b
 q+CyMT59imp0qnWXuIHwLSZWeA+GfmtBOHVZbnF8vTLtkabzLa0RfdnW5A415ErC4G7X
 +RAmHAzDPYy3phdbYeRyLQLMRp/zGloiQRRqUPkZ+3QX4tNfp+FA1i8x07uaM7b7h5jJ
 JBqg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795011329; x=1795616129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5k/duKR+6LJ2BpSZiLTaidBrk2eDLUtm+ZDrSdMYO5A=;
 b=FhUexrQdaZ8eRz8kytIh2sdHbaFFY5RiP0C2vIrGsCH1P0Nn4PrkHXtYGCtP/rj0g2
 pTXCBsyEQTb/1S9kemwwG11alRlIS6sx+w+bqqZ2bsVx/PyBTpVoyVjYn4L3WKz/OWx2
 qUa+DgO+0ThYwuLwYuQWhetaLFkXpW0T0ol67OSfHm9KscUvp2BSwRRnpOgIgwYe0PsJ
 ES3kZCQR2b4tuq5/Diw9OIK6xfHs/eFyP9jfW9W1KTEHbZH1sdiZV+xxq8PHQ1vO+AM1
 OE8HZvS0aVygOJjC4fnOb6YPbplO5VW/ZQ+GqwgrAzC6xi7gsWy4YFellKkWapbOAAP/
 vMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795011329; x=1795616129;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5k/duKR+6LJ2BpSZiLTaidBrk2eDLUtm+ZDrSdMYO5A=;
 b=rsMtlZGtUvCh+jNbUxUcdwfx9+sANT8xIomtxNn74nLVV6HezMQi79DF9JRHIoShGH
 iLO9QMDZeWH5+QRkTGJTh00GH8wTy0Iuy/h1CWu+/Nseb9iEgSeaWA9lCBgKobvx2zEL
 /8cuez1oI1SHHcUjltDEFFmbuNFffbHKMYUAvoKccTmua4W5ZD1H2XUU7Kh6NHeTGOaE
 Z0G1iahkNoTqR1rMDX8dgaICftNHSWKJmz4ogwX6hWPaSWjTAYsemK6IBwlvJEOOnjG4
 AeWUiEYLIM/XM4jBL8TLnRpSIl4478ye1VqlvNFyKjisxbX2sazmW2LjqeHCsR6urML5
 A3iQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHKxrHoMFg7FVfONP7x6ZufJUPzuYyYMI7FrcUWqMofYagyv1xEAx6tzbKp9DmRGdDxiE9YdpJxK8pS@nongnu.org
X-Gm-Message-State: APuU4Z/p4MzxDJWgotYIlH7LuELf3jPJ44/pCuB1D+1a8GPIQ5IsPyQE
 0a/yBVhztdhWXG0FCBHIj7SPm8IY8mkoO46E8codi49xWmiyDNpTjOIpnb3N5Me68hBjpnko6pB
 G4jzobkhSGhjTLaymtuW1OmNTdpLmOjcKXj7xep/m5PFuUcHCRSbxJuhGa3VEMkYCtCE6lrUTB8
 BSrc0aCoN/pUmgfDLhbxS6QHDn6NCimuA1
X-Gm-Gg: AYBFou0MBnVcC4UneNo/baH4xRBtdd9MF2HtBP7KwOBHPknBvIEF/kbj4/b6KBgteob
 fXlpzAsQFchiCT5opfnzXKx/zak67P46EfbR70TWqXQIRGO/leH4CWu7sBYHZ8BOjT46q7enw1v
 zwzwY2vVkiVzDNcqmKUMESWQRAAQ0w/S8LgXNVaKMflPA28kvRFTxPhETHtUk=
X-Received: by 2002:a05:6a00:1c91:b0:882:7bed:3b3b with SMTP id
 d2e1a72fcca58-8c5d43e76cbmr2429700b3a.36.1795011329515; 
 Wed, 18 Nov 2026 06:15:29 -0800 (PST)
X-Received: by 2002:a05:6a00:1c91:b0:882:7bed:3b3b with SMTP id
 d2e1a72fcca58-8c5d43e76cbmr2429670b3a.36.1795011328993; Wed, 18 Nov 2026
 06:15:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029131011.3715081-1-mayuresh.chitale@oss.qualcomm.com>
 <20261029131011.3715081-3-mayuresh.chitale@oss.qualcomm.com>
 <3f8c0c2c-208a-405e-9c7d-8a9fc90f9cfd@oss.qualcomm.com>
In-Reply-To: <3f8c0c2c-208a-405e-9c7d-8a9fc90f9cfd@oss.qualcomm.com>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 19:45:16 +0530
X-Gm-Features: AclHuK-1P_bNWYzcdet415ZVYjRqzTICUKIRuiAxj-c0Tk4W01R7O3fC0kNVq7g
Message-ID: <CAHuiULB7pidLYmO=QrbzYjPYnr4DZrdr1JoVsC5-_MAsosejNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] target/riscv: Capture Sspesa sample PC and
 counter ID on overflow
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: gsHXGWd2DpqzoT1Cc2GCkEU8lvDM-w8p
X-Proofpoint-ORIG-GUID: gsHXGWd2DpqzoT1Cc2GCkEU8lvDM-w8p
X-Authority-Analysis: v=2.4 cv=YfgodARf c=1 sm=1 tr=0 ts=6afdb302 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=vmqqakdy-xN5SajVPjAA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NiBTYWx0ZWRfX8oGHXPs0AK8V
 7oE+CfPPgQM61+CHLqyXlXIzU4DkbtXwlCvQlLKHkLjzHdf+53G+R5cufNCUzVX/MjcGDNa5Lea
 UkUKQAyWZzy4gmqxuUb0aJOosY0Ttqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NiBTYWx0ZWRfX2Y7+tF78T1I5
 wP0jIWL0GeE89IpZYnIuOXfu4MiqBlteFYDmOEjma9j8Z1LPBt0ZR2PEdd8udfx6kuPkN0XmFDB
 u+1Dw6HaZZkXHsCWpFgmAiT/sM8WaL/nSB2/qbFDawAAw9Z4b/3u6myqcfofDoy335NI4srQ7jZ
 DFDYRf/qBakhUz5i0x6BaIAFIS/5Oilm+COYDxOvUTQbbbyv7SjC2N3drOwHC4EIB+KlA7lUmw8
 EJTVvzTQoWecTyPRi9T0tKsqwNHcP//rbQ6yBxN6YX08aCpbWG4d7taj0Ka/4XIQwrTHxzy/rt9
 ihfC0SpVe8ONood4bGtVvjpoGxnUPkiWLBU9RUj4geghIOp3g6Sf5hhTewoG+pLlSbGFqaSB7Kx
 dpvcqAdqHqvYTAGb4IpEfpec2pODUz5HBFloDHnD6OXFNZA5jCFdRxBg+yT1IyFwgwe9oqD6HAs
 6Y+HZzFd5Izl2XzmM0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180056
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 7, 2026 at 2:39=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 10/29/2026 10:10 AM, Mayuresh Chitale wrote:
> > Capture shpmspc and shpmsdata just before updating mip.LCOFIP.
> > As required by the spec, record the current PC, counter ID and effectiv=
e
> > privilege mode. When supervisor counter delegation is enabled,
> > only overflows of delegated counters update the sample CSRs.
> >
> > Preserve shpmspc and shpmsdata while LCOFIP remains pending so later
> > overflows do not replace the pending sample. Currently, cntrid is not
> > updated if two counters overflow simultaneously.
> >
> > The captured PC is QEMU's current env->pc, so it provides best-effort
> > attribution rather than guaranteed precise attribution.
> >
> > Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> > ---
> >   target/riscv/cpu_bits.h |  3 +--
> >   target/riscv/tcg/pmu.c  | 39 +++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 61258ce6e1..e99da434d5 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -642,9 +642,8 @@
> >   #define SHPMSDATA_CNTRID    0x1f
> >   #define SHPMSDATA_MODE      0x60
> >   #define SHPMSDATA_V         0x80
> > -#define SHPMSDATA_MODE_U    0x00
> > -#define SHPMSDATA_MODE_S    0x20
>
> These 2 macros were added in patch 1, never used there, and are now being=
 removed
> here.  Let's remove them in patch 1 instead (i.e. never add them in the f=
irst
> place).
>
>
>
> >   #define SHPMSDATA_VALID_MASK (SHPMSDATA_CNTRID | SHPMSDATA_MODE | SHP=
MSDATA_V)
> > +#define SHPMSDATA_MODE_SHIFT 5
> >
> >   /* Crypto Extension */
> >   #define CSR_SEED            0x015
> > diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> > index 1a4658319b..31edd31117 100644
> > --- a/target/riscv/tcg/pmu.c
> > +++ b/target/riscv/tcg/pmu.c
> > @@ -178,6 +178,43 @@ void riscv_pmu_decr_instret(CPURISCVState *env)
> >       env->pmu_ctrs[2].mhpmcounter_prev++;
> >   }
> >
> > +static void riscv_pmu_sspesa_capture(CPURISCVState *env, uint32_t ctr_=
idx)
> > +{
> > +    RISCVCPU *cpu =3D env_archcpu(env);
>
> I believe this is something we should document somewhere, but env_archcpu=
() is a
> not the nicest call to make and we would like to avoid it every time we c=
an.  One
> of its main usages back in 2023 was to access the cpu->cfg pointer to che=
ck if a
> given extension is available.  We ended up creating an inline called risc=
v_cpu_cfg()
> to allow access to the CFG struct without having to call env_archcpu().
>
> So, if the code doesn't do anything else with the RISCVCPU pointer aside =
from reading
> cpu->cfg, we recommend using riscv_cpu_cfg() instead.
>
> For this code I suggest not using env_archcpu() and:
>
> > +    target_ulong sdata;
> > +    bool cde, ctr_enabled;
> > +
> > +    if (!cpu->cfg.ext_sspesa) {
>
>      if (!riscv_cpu_cfg(env)->ext_sspesa) {
>         return;
>      }
>
Thanks Daniel, I will fix these in the next version.
>
> Thanks,
> Daniel
>
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * When supervisor counter delegation is enabled only overflows of
> > +     * delegated counters update the sample CSRs.
> > +     */
> > +    cde =3D get_field(env->menvcfg, MENVCFG_CDE);
> > +    ctr_enabled =3D get_field(env->mcounteren, BIT(ctr_idx));
> > +    if (cde && !ctr_enabled) {
> > +        return;
> > +    }
> > +
> > +    sdata =3D ctr_idx;
> > +    sdata |=3D env->priv << SHPMSDATA_MODE_SHIFT;
> > +    if (env->virt_enabled) {
> > +        sdata |=3D SHPMSDATA_V;
> > +    }
> > +
> > +    /*
> > +     * Only the first overflow that raises LCOFIP updates the sample P=
C and
> > +     * metadata.  Currently updating CNTRID on simultaneous overflows =
is
> > +     * not supported.
> > +     */
> > +    if (!(env->mip & MIP_LCOFIP)) {
> > +        env->shpmspc =3D env->pc;
> > +        env->shpmsdata =3D sdata;
> > +    }
> > +}
> > +
> >   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_=
idx)
> >   {
> >       uint32_t ctr_idx;
> > @@ -211,6 +248,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pm=
u_event_idx event_idx)
> >           /* Generate interrupt only if OF bit is clear */
> >           if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> >               env->mhpmevent_val[ctr_idx] |=3D MHPMEVENT_BIT_OF;
> > +            riscv_pmu_sspesa_capture(env, ctr_idx);
> >               riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> >           }
> >       } else {
> > @@ -403,6 +441,7 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> >
> >       if (cpu->pmu_avail_ctrs & BIT(ctr_idx)) {
> >           if (pmu_hpmevent_set_of_if_clear(env, ctr_idx)) {
> > +            riscv_pmu_sspesa_capture(env, ctr_idx);
> >               riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> >           }
> >       }
>

