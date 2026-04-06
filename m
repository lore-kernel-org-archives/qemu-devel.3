Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF030F46C62
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 17:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9o8y-0007xC-I2; Mon, 06 Apr 2026 13:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w9o8x-0007x3-50
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 13:53:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w9o8v-0005p6-Ej
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 13:53:46 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636F0nTX582105
 for <qemu-devel@nongnu.org>; Mon, 6 Apr 2026 17:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d2yXEutWXapLufH8DU7D9IZx+MMWyvUTTysBwUwTNv4=; b=DQGgMF2DYF8CRCM5
 6TMJaRP0heyQ4Msc7wELerI7c0UWv56eDHuAwopD5Mm1b8KKbArSOJqxvCwaWPIo
 ywtXXfDxz00Z/u2pIJqJp3MiyVd1ZdVnttlpH7zVO+eyA7QD3MhADc9Q2Zc/iFtJ
 z1l89wt1dKyIZwZItkLjEKlAQFbfwxLKEqhczWgAsvUE7x1UohGegb5bVruzSkCq
 SB7C0CeSPx95+ZPyaC2OqwJgPx4eS/XjohAinXqB/HimSb5liMHOXoI3givEH+/i
 BNiEp2Fl4AikwFfxtFz5G2cQZ7bg5xtnrz/elopVSQwgT5s0ZUeONOpzJC4P8ZvG
 1pmZhA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcf3r0jtu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 17:53:42 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-463c632f9a3so7809243b6e.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 10:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775498022; cv=none;
 d=google.com; s=arc-20240605;
 b=YBr5pIHwo2kF1XYh5gAEMQjhlJvphSvK/p2dvucg53Ydm5SvqU0gJiuBp+lMKiUToF
 s+8UAUMCJcXGhAMv8rX/LdSCh3BGeYSvwtKEC711KGJ3gfaIVLIzVvGGFEu9AvrgFbtW
 uDxnyZg3vhKEFoc80Ia8IsU0DYeWWkjmhWZKstJqCH6oDCJjiIlzdpYUad/knSj+EeV7
 ghXZKs+Pt7vjh+292mfzGMvLOkqj0YDoHG1N3og9vDpT+ITSDJEVHsDTWds2lunnMpDn
 s/qWltFQ9/0FOtxb3WSEkcy/bCSZbAGZjPN4MLvwX1EStB7sOLL5U1irAkG0qYEhYr/l
 UZ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d2yXEutWXapLufH8DU7D9IZx+MMWyvUTTysBwUwTNv4=;
 fh=o3W5rBryHd5xcK8vQ98UvCxdM431zpyrnojV2RHAKf0=;
 b=La6NaZQr1nYHnn0dGtP7RIFXdUDO9cqv8hHl9dTSLrnh4Cl9qRecM11yXIRupixfZZ
 GaEIKar719gogslNn6QzJNfy267783CRfvXfuE3owi8+4WbsxB1L51xRyrt91ElK3grD
 GvoL5Pz3TV+5pUDRlJC7PYhrtWY5HNPrD8PHi8xBIiWSot+GQU0DYCB6cCDWsocTX/BJ
 dwZs/JZOMGlp59VyxdJ7/2cCwd15PltcMCoFlc8rc3rvXp1j4w7LPdLPhAEOgxLbp3uJ
 hAymDbYxYJy005Kx67jewn83YSpW3ti4ETKvx4AMwtiJjaL/D6tMxCx/sGVNiFBmvtn8
 IBNQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775498022; x=1776102822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d2yXEutWXapLufH8DU7D9IZx+MMWyvUTTysBwUwTNv4=;
 b=Rmm9LeX386SCNUFu7mmZ/haVFVmTQe06QjzF43dplJaeocyoq4DuEuf3b9SNyGL0pY
 123AfxcqB100xW4OxEcNIOE6HVuCBpF1WBpsqxhGFZq+OTYCrUn55o5V0CL7Bxz1/VOo
 Ww7eJOwiCckOvhiDJiTCD/EdGBvk6DgGc9qRkaT3GxUznqEqz1rBDzKYmDqzI402pM72
 CiT28NbWCuVsE/npA4INNxP1D17w8BTnSIBPlzUX05RjTTWERFEE4ogwZr/FjCNBn5V7
 L6RWzWzvdovA/LzMXzgnhFkeNRmsAK5KBrdx5uvnJnZn1EnmPlN841gB6kTqEZ4nFFF/
 I9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775498022; x=1776102822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d2yXEutWXapLufH8DU7D9IZx+MMWyvUTTysBwUwTNv4=;
 b=Chsc3766fgeUPJ4zOQcmYiHqiwqudq8WKOrcJXzCzZk3CSBZUNxP69hYv8sckKVvcr
 II6lndkObLZz6LDVcvUNYEtZMZUgnLSOImdKxVpmgWMjqcnbNaYUpOHoDWGi91ipqYP7
 pbexlCYpBCEPzO+WnqahLA+mc9aDwwLNr/aj6krhpkcC62Tp98Trg4JNwbDJD5xkX5+4
 hkrpyTXIXfyulHSHJrdc/c1JOS4UJLBj5OdVnH1jZ0ymFQ+kY//Fqv19MG13kBc4Ph3O
 TJkKtQ3EQjuMiKHEIJssJ/I/A6zl2ITqPhgXoqzE9TZCPvhXAqE3YbpFR6FMiWz5f+eG
 159A==
X-Gm-Message-State: AOJu0YyPVIxxrITo+jdamnoGYBMkjXPtTYlMVxmYXekWSInAnCmcjoTH
 rPnvFtsKMUjM/QVc0WNUPvIdOV7sMxwp0KvCfdZigNqm5ZU+ppWyJ1Aadl+surNxNT5SsaN5DW6
 3fgz6Ij3wxS+O54fSh8XI8Dsod77pVVZ5hEBqEi3AHjeEggWIbrKN0kgnz/Zo/hh7c4q4vS/LjU
 dZdQRPszb82jSKurOb3m660bwIPit+FbEs
X-Gm-Gg: AeBDietFw/+Oe0+wO4Vuisg1zqxK40z/uiOGX3JYzteip+aifo0gFbZqbTmz8lWuDm0
 ekUK27TcsyPMl4GbPokkB3heVrOPcYN9pIWPJ2swdcBnGXzJRq6UjLHJcWOXD3JpHAh+aud1BT7
 7ahrYi3Us0PD1syQxOjjDcLuHwgrMlGRfrCq7nhgBDtKy59QxT/JyKnl0gvgJLfcKnPrTkUk/TX
 7Gd6EPc
X-Received: by 2002:a05:6808:8482:b0:467:de0e:feb6 with SMTP id
 5614622812f47-46ef8d5c14dmr5141693b6e.11.1775498022115; 
 Mon, 06 Apr 2026 10:53:42 -0700 (PDT)
X-Received: by 2002:a05:6808:8482:b0:467:de0e:feb6 with SMTP id
 5614622812f47-46ef8d5c14dmr5141678b6e.11.1775498021647; Mon, 06 Apr 2026
 10:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <453a9e248b8c2af50cf89912121605db07792dd5.1775122853.git.matheus.bernardino@oss.qualcomm.com>
 <76cec745-7b22-425f-a7b1-cf9f7d2786bf@linaro.org>
In-Reply-To: <76cec745-7b22-425f-a7b1-cf9f7d2786bf@linaro.org>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Mon, 6 Apr 2026 14:53:28 -0300
X-Gm-Features: AQROBzAE1C_H4_xhTjRdTqN1W0BMd-ZYbFKcyYjqWsh9r1K3-9vURmosEv96td8
Message-ID: <CABrGZ+G6ZfLR6y2hzyw9y8PW=bafiDHUicZ=QMEzKcBKTY1czw@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] target/hexagon: add v68 HVX IEEE float
 arithmetic insns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pz1uT35_i88woscnACkjaqvcAEVH7No-
X-Authority-Analysis: v=2.4 cv=Us9u9uwB c=1 sm=1 tr=0 ts=69d3f326 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=KKAkSRfTAAAA:8 a=Ety--b6bkOakmggMHLIA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3NSBTYWx0ZWRfX/LU1Ot1/N651
 jnFMgW2kwxsNLOwmb7aOMkSOWMXfuAiETU7c9+gzziALjfU6rmD2ZKdmsu1m5uTLXC0D1PrkCZP
 6wANIcl8EFG0Wchg/u6yhQaqx6xg4Bjqqgcqea2eIzVPOCQGGnWGNSDalFvXn76K5rt57wX3kLw
 5LV/FWBTk0hwt63lrs5orFHdWhp3M4CrwVA3Yhi+IrZ8ACjUqidwOxIOPeymEv0EIxC9C+Qnf9x
 l76JWLr0CPiVAoER66mKNertwju7EiWgHEbxZ5itcaBQQqPBe/5FsA6tysMGVHV1bb7xvuj20bB
 pppei1Q2Kjrx46iYc+5fKTZzERg+DrZUxAjgIw2xPTqEgiL/XoEvnbBwADZduj5GrpAZWp3FX88
 2BCXC+dBqoa1DPrhhcK3KYJ1aPuQyi6wdmLkQUpviRnJUDLxVsqRaWkYgjdajiSSDIJHJfXqEmT
 XWxtY8GEzLWEd06czzg==
X-Proofpoint-GUID: pz1uT35_i88woscnACkjaqvcAEVH7No-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060175
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Fri, Apr 3, 2026 at 6:46=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/2/26 20:47, Matheus Tavares Bernardino wrote:
> > diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> > index d7f4df5f96..d6ca51f175 100644
> > --- a/target/hexagon/cpu.c
> > +++ b/target/hexagon/cpu.c
> > @@ -300,6 +300,9 @@ static void hexagon_cpu_reset_hold(Object *obj, Res=
etType type)
> >       set_float_detect_tininess(float_tininess_before_rounding, &env->f=
p_status);
> >       /* Default NaN value: sign bit set, all frac bits set */
> >       set_float_default_nan_pattern(0b11111111, &env->fp_status);
> > +
> > +    set_default_nan_mode(1, &env->hvx_fp_status);
> > +    set_float_default_nan_pattern(0b01111111, &env->hvx_fp_status);
> >   }
>
> Do you still want to detect tininess before rounding?
> I would find it unusual for two fp units to differ on this...

  HVX IEEE FP operations don't raise floating-point exceptions like
underflow (with HVX we can have 32+ fp operations simultaneously, so
the hardware is simplified not to produce exceptions), thus the
tininess detection mode shouldn't matter for this unit.

