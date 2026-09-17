Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31617C982CD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x76Al-0001vA-K2; Thu, 17 Sep 2026 03:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1x76Ak-0001uo-5N
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:04:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mayuresh.chitale@oss.qualcomm.com>)
 id 1x76Ai-00008A-7D
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 03:04:41 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61X6u133564
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 07:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V7kZEOGBMQR5JvaOy/ogdet/5X1WVzC2Ma3X9O7fsHY=; b=kykVkSCezAct+vAH
 lc6Nfz1iDnJGAAFuZVpyPjTRtqQ93Dw+bxvtqF3VAUlaIoBpsTkk+SbRaUtUs1rY
 z6Non2kFxNnbD2e8rj5w7nhaYctGewL3agAH5xmvAJmQQ7p1wlZ24gn0KyZ/6YeS
 fvPcRUk8Z3tAxyM24yUs5U6Bqhr2cdwmk9mqf9gqmQ0/uphT8PtmsP38ODI54Qp1
 E6oqbQhF9Q/blIyqGHZaARpyZwDZMsrr453y6FYh6e+pSidANwLfGOSmlxqeemub
 2NftBq04XKizn8k8ffjULb2PGnBCuR/x+0p+OfcOuBCie4zSh0dRXhZd1gEIlNxU
 6Ht/Ag==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqtn5497j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 07:04:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8632fdf67dfso719495b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 00:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789628676; cv=none;
 d=google.com; s=arc-20260327;
 b=irHUmFpEYOBGaXKzOnJDKdOTZFmg1XPGVXDKGUbjbN9lzhQ/ZrYsaDTfINeNgNj+rQ
 Sg+2sX5P/cZ4QNI4z5qE3ACQ5jFpN7U0pGrw2GjAxUkROPOLG+bja12OVPpPXj9+CLBF
 EA5BPE9j9UuLXNVP2vfUP1q7HM9mvNupDoleL+MSmzQB+fMTcUvvAAt27o7VAdXgPO8v
 8D7qFR/rnbgnPRE3Ea99xE6MjP3+x6ydfRBiMCprzHBxIZXgA0qkC4hTAlcIQzgKf4Ii
 PxgGOkq46RWj5hJNDNvHgrDK/J+V/eZA82HH9zn31auFgis6ogENRF8o8eAnW9Rq8tLT
 2JJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V7kZEOGBMQR5JvaOy/ogdet/5X1WVzC2Ma3X9O7fsHY=;
 fh=Ivr5vUoB16NT8sTT/5QRVjq6UisZuxOt1hnk+Alb0QM=;
 b=OKDWGXqHEMg2YuzeeOZ7jeVZ6sIIIlmwJs4vQTShet3GHtZBDt7lIjUV02J4tZuRaE
 6SHEGzqp+AP9eV/rbkQmWaY74wGSnWNwdiiEQCTbTZ+UJUXiwQDR0gECNhQsFV9JMJ0o
 iI/ldkVKhfX4fB9koi/+/zfRyqfbIW2Ged0+SYnDa1KbHgVadSUHUL7G0YG1g3XGCcHB
 uyI1gN6kADxA8AbdCfvmfLWUiYG+4wWV4kUSndkJK2H73mENFjn0komLU/7pveGOdFbe
 i+ytm2NRdFEWaJvwalS/3sgYS7hyy72ZqeLRMOnOdBz3KRPKTEV/a4+BG8bMmI4iLsrF
 vO9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789628676; x=1790233476; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V7kZEOGBMQR5JvaOy/ogdet/5X1WVzC2Ma3X9O7fsHY=;
 b=ioGnxPb8penFbmxUpUeZwmXr3S19yI/MuAexYgNJ3/hPa4DpjnTRi91CUEow4TFVnV
 N3KrT4ZQcR2K2Yj1v+Nmbuu9WqpCsjpwzZji5T2EkGggVDRBsCtkXTZ2aF+/59+XJhK7
 cAvdOGlPRlGQiy5W4WbhJvom/DgaC9pmWgNiggnexboKSINyC3NlZ/GOx242RjxssQxV
 YcLDtn+M7TU/1S89opaSU7M5T9Og+X9kefeyQuuGswJEaYPmjqpuYxGdcv/LRDURJ5ai
 Pyw0dG19zwHdEqeVnN66B8WNQ71B4p8kUZalNKhEIzigBfRp31AmtMgwJOUkQy9OnqVF
 3SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628676; x=1790233476;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V7kZEOGBMQR5JvaOy/ogdet/5X1WVzC2Ma3X9O7fsHY=;
 b=D82thuQp3KuDViUiBtPmo8JHLtTQfYnBHZwnBt/AgCBMtHTCf4NKMq/DEd1DstKwTB
 Ijcm5CBnVaw7T0B80sBXXUJHse30l6MxXrOjwi4POLwZrNBnnwDGqK5UmmUIBXHudQKo
 BAnzNYfBf9ENds/KENqFSElTPj1o2dYhUSb69U75D9r+zukO1dctsg5r5meHGtI7Up8A
 iMvMPo5iCQ8cAbmXEeY6d3D5mJQfHukCxWUPirAYZsCZPdwYr8f2YjSs0xaqRwDET0Ay
 mgVrRyWPndOmgOw/9+EQUiWHMX6wGD3e33fyRecVfB+3WLEeFrUgvl3qBm2PfXwR6sos
 +YXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTFh7b2Dh6SeCOxi8ZwxhLT8gQgDDYxgPdbkUTrR1+qrFKjpukhYXOgEw9LP4FeVEBLoxhqH0PMbVk@nongnu.org
X-Gm-Message-State: AFuF++lntFZHNW2dwiPR5zoMlRYx6OfY7yHMCEav8FM8hKCjy1aln9ys
 0T31E84I8TnFE8KRKyaNB9QqmsRr0Inec7MLtRjbQ94TVObmo8VzXQ2O7Jrkzws5RHiGmWUf2IG
 KrNj3rJ+EaT0AHBgEPkU9j+rwKNpSo2029qRSzVsw+IpZBY1Z88O2BlhMWeWRBFzjMjSHXMiRqv
 9xaW27XspPHBd3gdO0ON9drs4I+2qQT1PN
X-Gm-Gg: AYBFou1tpkWWf3jXEkeUay1O/eh5Vv5GCeABjksG7tzoYZHUhhFpD8VKg/FaaFt+QOJ
 GeTvq+IcMSgevtCqaJZRCh4co2j67toxZvMZ+VIOV36EdBFNkRNKip4JtDwaGJ64a+6y2Zvg6uO
 X8YqWglrz1mF52iethHt8kHSA7c7EEIeVkevLJPL29aW4R3182LupJSMJ2y9o=
X-Received: by 2002:a05:6a00:a20b:b0:861:295:2d78 with SMTP id
 d2e1a72fcca58-87340f89b5fmr3538546b3a.3.1789628675446; 
 Thu, 17 Sep 2026 00:04:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:a20b:b0:861:295:2d78 with SMTP id
 d2e1a72fcca58-87340f89b5fmr3538501b3a.3.1789628674952; Thu, 17 Sep 2026
 00:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260907065112.2287127-1-mayuresh.chitale@oss.qualcomm.com>
 <57ee549f-9ffa-426a-abd8-95c9f8cbcc31@oss.qualcomm.com>
In-Reply-To: <57ee549f-9ffa-426a-abd8-95c9f8cbcc31@oss.qualcomm.com>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 12:34:23 +0530
X-Gm-Features: AcwNN1XczJdH5ZJSIPg09_edZ6Yp_CP7Kb9T7V95v_cH3MjdKaqCIFNJs82u4pI
Message-ID: <CAHuiULDH5=uH7ynsTT1pL_aOzo0CjU3UkMJ+yi0AKmrV+-Wtbg@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Fix LCOFI interrupt masking in
 sie/sip/mvip
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Gong Shuai <gsh517025@gmail.com>,
 TianCheng TANG <lyndra@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX/Vpkiu9hZLIC
 pLw64hgE6XC5ifOwgGpPIy2Fy0bQREgk3QQ/h3ChhVYrM4RDpkSS4tJgKcXrAgHGGOU4zy/vloL
 6HOH3WrnImHPsYe8yJ5CapUFeqkTDMG2RD40rEqGrSd7oF9b0CQlziLmfEtGRGWjw+diVbI0CeG
 ATSlxTTU2FxeX0mvAz4btRr1GmqP75MYq2IKdFTZM70AQVONPlQP2AwCmvxWdilldnzUzXtjrVg
 KmB7ZOlv8idAtj+GWZJSmpEm81p61W9U811LPbvPraMsF+S4CXEF+DzTueomA4pEFOcIWE8ecd9
 BJdTQHohH3LJRS/gowxwnNMvgH7Uv41lM5r2OEpDQZWNM1uu4JJ841hWcHEqZ5JVJsMzCG7QVuH
 UY3HtK7oNq27r3JgSr3P8yoKIOiTYM1sCWSJI8K7IikqGieg0aS/1lDfz89h7BgB9keLhp3dhkT
 omYX8BDurC6E73dgHkA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5NCBTYWx0ZWRfX+f63EEfclL1t
 f9vxU4WKeQIuFVp+LIcgQJdskwKojTNl2OYriJsVm9K0CEiK4J/1fyWS63DQIAncadNPWU8+Z1U
 I4m3BzM3Kd8p0lLkiCMXK7z/3r1k7UU=
X-Proofpoint-ORIG-GUID: m_OqAc78_W3jhpRCkcMlGgZOesg9N-mJ
X-Authority-Analysis: v=2.4 cv=K7O3jCWI c=1 sm=1 tr=0 ts=6aab9104 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=SRrdq9N9AAAA:8
 a=VGmdbzv3HwwXL7g1r8IA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: m_OqAc78_W3jhpRCkcMlGgZOesg9N-mJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mayuresh.chitale@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Wed, Sep 9, 2026 at 7:12=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 9/7/2026 3:51 AM, Mayuresh Chitale wrote:
> > Commit 27f9566dcd98 dropped bit 13 (MIP_LCOFIP) from the LOCAL_INTERRUP=
TS
> > macro and hence also from individual masks such as all_ints,
> > sip_writable_mask etc.
> >
> > As a result, with Sscofpmf enabled and LCOFIP delegated to S-mode, the
> > overflow interrupt was raised in mip but was not visible in sip and it
> > never got delivered to the PMU driver. For the same reason, sie.LCOFIE
> > also became read-only 0.
> >
> > Add back bit 13 in the affected masks, but gate it on Sscofpmf being
> > implemented. In addition, for the virtual interrupt path, mvip/mvien
> > LCOFI also requires Smcdeleg and Smaia to be implemented. Also make
> > LCOFI delegable only if Sscofpmf is implemented.
> >
> > Fixes: 27f9566dcd98 ("target/riscv: Update the local interrupt mask")
> > Suggested-by: Gong Shuai <gsh517025@gmail.com>
> > Suggested-by: TianCheng TANG <lyndra@linux.alibaba.com>
> > Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> > ---
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Thanks Daniel. I am working on v3 that will also fix the broken kernel
sbi pmu selftest. I will add your RB in v3.
>
> > v2:
> > - Fix the sip.LCOFIP read-back mask in rmw_sip64() so that it matches
> >    the write path.
> > - Gate LCOFI on the Sscofpmf, Smcdeleg and Smaia extensions, depending
> >    on the register being accessed and on whether it is the virtual
> >    interrupt path.
> >
> >   target/riscv/tcg/csr.c | 59 +++++++++++++++++++++++++++++++++++------=
-
> >   1 file changed, 50 insertions(+), 9 deletions(-)
> >
> > diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> > index 002f7e69c1..966a0897bb 100644
> > --- a/target/riscv/tcg/csr.c
> > +++ b/target/riscv/tcg/csr.c
> > @@ -1812,7 +1812,7 @@ static RISCVException write_stimecmph(CPURISCVSta=
te *env, int csrno,
> >   #define LOCAL_INTERRUPTS   (~0xFFFFULL)
> >
> >   static const uint64_t delegable_ints =3D
> > -    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
> > +    S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS;
> >   static const uint64_t vs_delegable_ints =3D
> >       (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
> >   static const uint64_t all_ints =3D M_MODE_INTERRUPTS | S_MODE_INTERRU=
PTS |
> > @@ -1874,6 +1874,25 @@ static const uint64_t hvien_writable_mask =3D LO=
CAL_INTERRUPTS;
> >
> >   static const uint64_t vsip_writable_mask =3D MIP_VSSIP | LOCAL_INTERR=
UPTS;
> >
> > +static bool lcofi_present(CPURISCVState *env, bool virt_int)
> > +{
> > +    const RISCVCPUConfig *cfg =3D riscv_cpu_cfg(env);
> > +
> > +    if (!cfg->ext_sscofpmf) {
> > +        return false;
> > +    }
> > +
> > +    /*
> > +     * For the virtual interrupts path, we also need to check if smcde=
leg and
> > +     * smaia are both implemented.
> > +     */
> > +    if (virt_int && !(cfg->ext_smcdeleg && cfg->ext_smaia)) {
> > +        return false;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >   /* Machine Information Registers */
> >   static RISCVException read_zero(CPURISCVState *env, int csrno,
> >                                   target_ulong *val)
> > @@ -2248,6 +2267,10 @@ static RISCVException rmw_mideleg64(CPURISCVStat=
e *env, int csrno,
> >   {
> >       uint64_t mask =3D wr_mask & delegable_ints;
> >
> > +    if (lcofi_present(env, false)) {
> > +        mask |=3D wr_mask & MIP_LCOFIP;
> > +    }
> > +
> >       if (ret_val) {
> >           *ret_val =3D env->mideleg;
> >       }
> > @@ -2299,6 +2322,10 @@ static RISCVException rmw_mie64(CPURISCVState *e=
nv, int csrno,
> >   {
> >       uint64_t mask =3D wr_mask & all_ints;
> >
> > +    if (lcofi_present(env, false)) {
> > +        mask |=3D wr_mask & MIP_LCOFIP;
> > +    }
> > +
> >       if (ret_val) {
> >           *ret_val =3D env->mie;
> >       }
> > @@ -2349,6 +2376,10 @@ static RISCVException rmw_mvien64(CPURISCVState =
*env, int csrno,
> >   {
> >       uint64_t mask =3D wr_mask & mvien_writable_mask;
> >
> > +    if (lcofi_present(env, true)) {
> > +        mask |=3D wr_mask & MIP_LCOFIP;
> > +    }
> > +
> >       if (ret_val) {
> >           *ret_val =3D env->mvien;
> >       }
> > @@ -3784,6 +3815,10 @@ static RISCVException rmw_mip64(CPURISCVState *e=
nv, int csrno,
> >       uint64_t old_mip, mask =3D wr_mask & delegable_ints;
> >       uint32_t gin;
> >
> > +    if (lcofi_present(env, false)) {
> > +        mask |=3D wr_mask & MIP_LCOFIP;
> > +    }
> > +
> >       /*
> >        * When mvien[9]=3D1, mip.SEIP is read-only and reflects only
> >        * the external interrupt signal from the interrupt controller.
> > @@ -3897,9 +3932,11 @@ static RISCVException rmw_mvip64(CPURISCVState *=
env, int csrno,
> >        *  alias_mask denotes the bits that come from mip nalias_mask de=
notes bits
> >        *  that come from hvip.
> >        */
> > -    uint64_t alias_mask =3D ((S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> > +    bool virt_int =3D (csrno =3D=3D CSR_MVIP) || (csrno =3D=3D CSR_MVI=
PH);
> > +    uint64_t lcofi_mask =3D lcofi_present(env, virt_int) ? MIP_LCOFIP =
: 0;
> > +    uint64_t alias_mask =3D ((S_MODE_INTERRUPTS | lcofi_mask | LOCAL_I=
NTERRUPTS) &
> >           (env->mideleg | ~env->mvien)) | MIP_STIP;
> > -    uint64_t nalias_mask =3D (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> > +    uint64_t nalias_mask =3D (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_I=
NTERRUPTS) &
> >           (~env->mideleg & env->mvien);
> >       uint64_t wr_mask_mvip;
> >       uint64_t wr_mask_mip;
> > @@ -3928,8 +3965,8 @@ static RISCVException rmw_mvip64(CPURISCVState *e=
nv, int csrno,
> >           alias_mask &=3D ~MIP_STIP;
> >       }
> >
> > -    wr_mask_mip =3D wr_mask & alias_mask & mvip_writable_mask;
> > -    wr_mask_mvip =3D wr_mask & nalias_mask & mvip_writable_mask;
> > +    wr_mask_mip =3D wr_mask & alias_mask & (mvip_writable_mask | lcofi=
_mask);
> > +    wr_mask_mvip =3D wr_mask & nalias_mask & (mvip_writable_mask | lco=
fi_mask);
> >
> >       /*
> >        * For bits set in alias_mask, mvip needs to be alias of mip, so =
forward
> > @@ -4132,9 +4169,11 @@ static RISCVException rmw_sie64(CPURISCVState *e=
nv, int csrno,
> >                                   uint64_t *ret_val,
> >                                   uint64_t new_val, uint64_t wr_mask)
> >   {
> > -    uint64_t nalias_mask =3D (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) &
> > +    uint64_t lcofi_mask =3D lcofi_present(env, false) ? MIP_LCOFIP : 0=
;
> > +    uint64_t nalias_mask =3D (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_I=
NTERRUPTS) &
> >           (~env->mideleg & env->mvien);
> > -    uint64_t alias_mask =3D (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & e=
nv->mideleg;
> > +    uint64_t alias_mask =3D (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_IN=
TERRUPTS) &
> > +        env->mideleg;
> >       uint64_t sie_mask =3D wr_mask & nalias_mask;
> >       RISCVException ret;
> >
> > @@ -4379,7 +4418,9 @@ static RISCVException rmw_sip64(CPURISCVState *en=
v, int csrno,
> >                                   uint64_t new_val, uint64_t wr_mask)
> >   {
> >       RISCVException ret;
> > -    uint64_t mask =3D (env->mideleg | env->mvien) & sip_writable_mask;
> > +    uint64_t lcofi_mask =3D lcofi_present(env, false) ? MIP_LCOFIP : 0=
;
> > +    uint64_t mask =3D (env->mideleg | env->mvien) &
> > +                    (sip_writable_mask | lcofi_mask);
> >
> >       if (env->virt_enabled) {
> >           if (env->hvictl & HVICTL_VTI) {
> > @@ -4392,7 +4433,7 @@ static RISCVException rmw_sip64(CPURISCVState *en=
v, int csrno,
> >
> >       if (ret_val) {
> >           *ret_val &=3D (env->mideleg | env->mvien) &
> > -            (S_MODE_INTERRUPTS | LOCAL_INTERRUPTS);
> > +            (S_MODE_INTERRUPTS | lcofi_mask | LOCAL_INTERRUPTS);
> >       }
> >
> >       return ret;
> >
> > base-commit: a925240509d1b4b656cc480f1cc79ba4d7c8bc08
>

