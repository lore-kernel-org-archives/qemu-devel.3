Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D14BC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 21:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x430v-0001pe-Pa; Tue, 08 Sep 2026 17:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x430l-0001p0-Vg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 17:05:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x430g-0000rH-0I
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 17:05:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688HLWfg2966666
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 21:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NbPHv64PTdWcDee1hdY7fYBXFD1ZsqtS7RZenoop4/w=; b=P5OE/MtGJ9cMW4BZ
 VIljHOZ9QcvdSsFKCiU3jk+ugk9AkeiFUbzXWGeKAPwQFeIfTTsuv9ftCEUYhW9m
 RWXTMVzXrhd7Z1mUoejDa0+Z+WmJFErSED6PLbIRKRBM/+bYgAPV+vuHt7zmLqfa
 Odf5cdrAXp+xNb4SY8BYUTsrbXWnUkpGFzqE0JOolvMzOK6QtLTic8lCta+V463r
 u0+lXkuSXUbNSWptXtqcwI6ry2zNWuqSxG1lxy3SWq+LNoBFuB8RdpKdxxnb/Kzr
 C19AHCCBcF4Zwy6j9OQLirr/M6TRBK6unX80LESkFBiv/08oBS3TA3EwXQXn/B96
 rtCmDw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjppp11b2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 21:05:39 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-49aa4525b82so6065667b6e.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 14:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788901538; cv=none;
 d=google.com; s=arc-20260327;
 b=c2WRo6HEVQyI0NcBEUEz4aP5YmFP/NBpmvIYwJuhr2MxjSjHLJzCT2AvUl/w2fhpts
 yfFNU79XERSQ5kBoauvPDX3Qt/1xCy/Svntfn/hgQOcl1mpuXRZitXl86SrHHilvmkZO
 oeOqhae+VLd0WgaLqqSslweyMxL+cR85MFBzKz7UZCCZPlllBIP5rd4o5c6TZHJEn9AC
 BCxGttyvVcyw9+8YkkkCJQXcRAX21PFnMCAm7sCuvQCKHBMlgLDxDtUpc3jPhEUvAlGh
 DXbc+nH/xqIK43X20tteCI/bYViBmJ/rGDBNEK6YC4SUydO5uToXG1mOT6kpJ3N5QQmo
 X2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NbPHv64PTdWcDee1hdY7fYBXFD1ZsqtS7RZenoop4/w=;
 fh=LfxqVHs7iB+giXalVcz/pbqkbOXeZSBmGzkNDoDAtdQ=;
 b=ZD+OY8XhjAIpnoRWiR41w/j6hO4l4J/QofeWYW8ugc5r1rjPdpoRTu9/uTh0IqmXN0
 wawht248Wc35WAwnv9JqDiL4gSHXmtNORwB8LBFcvCE+tauI8ADqFmpfLBAlAqek6yYe
 iVs0ZEdgbqpwypHN70JvlPELtf/W0Ej+1NA7NDpPVQ9wrpVXC/T0bSd0rzuAQZodvOg9
 IhRRNOhYdeYewMoA6tp/uzzgRcyU5kbw9kTe8r2jiPUJl5mWgUWx18xO2MKaqjyxuFD7
 2iIsxqdkhgn/md+tqipgkZK2zKZiFXlkJ0o0E98+MGuDy6zRPhUR8H3n6u9F0iziAV7s
 EKSg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788901538; x=1789506338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NbPHv64PTdWcDee1hdY7fYBXFD1ZsqtS7RZenoop4/w=;
 b=WO+Cem0qUWv9BrgBkPCuN/krl/kSnN4CWp9weeHarKToKq9bva/5dTNoSJ06YxZQS+
 i68rknGBgtaLwX5z+ei4ptzI9XkrAukUEoHkfsp7chSQHialUwabCvRMVyQ6F2d490e+
 hfAfsdBsOBfM+dfF101p27uCTahO6JjRiOSmyrtfb0OoD+5kQlh7XTrntbYHycicjEiQ
 6z8RZHUkw7RgYirB+9sXqqxU5isN44jX43iVLT++CT0qko4i2rFhLJxFR/4ybf8sobft
 UAmZRIjgsSubB4JmygpcQwEGVfQ+c8dbYZWR9A1DPW01BqArnid40Fqf/pVk12SDukJK
 DJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788901538; x=1789506338;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NbPHv64PTdWcDee1hdY7fYBXFD1ZsqtS7RZenoop4/w=;
 b=pcuFo0UQVtuSmn+xD/gITpTlKvrd/+pvNc52lgCPNHdc99TuycNDWuDzO1X71zxnun
 YsIULNIFllhJdifHQWC3F6CSIbCv7vw9u1saNfuVHoYYrHmqNQJffuke/tAEGpsYmEXj
 cZV+kzXCEM+SHW8veNCuk69+XovHfPwPfBi3KafIemYhFvz1XFuqj47U4FnVozo0oL/o
 ZWKuQGHO5FjfMQKYBcGMPirBvXXrpIS5D64UOuO5k7U/9sP3RrIJs7W+JDoW4DBlm6Cn
 tisayFH5IkrLdhpuBkVFnSCLJcoEf9B69CFNxM/0NbYF9ZuMxyZtGK3UlXPrc2C4LfBc
 fwnA==
X-Gm-Message-State: AFuF++lj6SbXtlihHnvd89Pg6jrV5IomT3OiQKCF2Xh5u2aJUu29wynJ
 8qCJ+pXbX3oTX7vOtS4QqfdL8HacQmO6ZAhBqg+/OC9rxEJHPgGz472rvVMMa7/Jm1yUDPSssFS
 DwOGL7NzMSZMH7mBN7upK2JsusUtKq4/XSM6j4MZzEkG+If0fP0DzU8Y3jTZYzChCAmckf08Vr6
 xDtHlQP3OLCu8oCdgd2w1qj+MYnf7vKcpT
X-Gm-Gg: AYBFou3B2NGef3eL20PKIlcpNZYH/rYK3yo+GeAWardKcov9udNEzS4/1lU9LSD5cVr
 WUDdRYrARPK08BxROUjev3xKYB157887JcSl4wWN6ea5v647rJINaH0VT3PqGg7+wfQI3Irczz5
 +/VwEmYvadKqq25bLpPiwhpDqIWT22uM0BDRTeP2fg2FrWLSLarllBpa+bjA==
X-Received: by 2002:a05:6820:4c81:b0:6b3:26b8:424 with SMTP id
 006d021491bc7-6b6fd3d69d1mr17103995eaf.26.1788901538458; 
 Tue, 08 Sep 2026 14:05:38 -0700 (PDT)
X-Received: by 2002:a05:6820:4c81:b0:6b3:26b8:424 with SMTP id
 006d021491bc7-6b6fd3d69d1mr17103969eaf.26.1788901537944; Tue, 08 Sep 2026
 14:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260908133512.2353957-1-brian.cain@oss.qualcomm.com>
 <20260908133512.2353957-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260908133512.2353957-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 16:05:26 -0500
X-Gm-Features: AcwNN1V9PRvQki63CDxex-dd98HpALIpQRzmBA9zmzr4ntx9lGixhSxUv1w8qU0
Message-ID: <CAJ+KCYNWJEOL+Qg7gBLrMj6J25A_F4ArjJ0vOM44LNCB92O6UQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/hexagon: add the V81DGB_1 and V81QA_1 machines
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: F1acYMzipbZChm2ZiJCdKlqAf-E390bT
X-Proofpoint-ORIG-GUID: F1acYMzipbZChm2ZiJCdKlqAf-E390bT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIzMCBTYWx0ZWRfX/zcHlCEUskON
 P954zH/iP+2KtqlzhjRuvgfvRz2xBnb+bDLDewqF8ozk/145TwSUnQUC/QZM8Naqpl8QdgbSSOp
 SnxjY7qPbywtON3gnccA+3w8HOLUzYCgDT97JVbqBooaRztfjR26emXvuYyE1+mhDP4eQPbtsGJ
 DuRqBiMPxaTV4XjZPSaMa8TWI4vsb0EAIOJ3fCv8MMfK10XXKU4VC4W4pbvlZsLBVp4ipqLXgPf
 ZlzlIoKlMh5b2tanz1YDWIweH2hi8OnTnIEUh5IFfd8AcMFFEvgsXgl2JMBTd52fcLXr/m7Kkcr
 6pnlean4QwtcXlp8JfOB3i8Tx6vFlrxSU4j31m/gHGfaYgwz/1x3HVP1BBffs8zWTdW0b4wgKS7
 f6f0VNbMrgJ4G/OPrSswE8+9l5IcQ0rNTINHUyDsskT2ajuobS9JgGLTn7jEuV5nP63kVbqljmT
 X17JwsoLrKCjnW2n/mg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIzMCBTYWx0ZWRfX6oFEoG1rxyPi
 mi0BtZvrNDh5+PEgz48Kxv4bgWHk8FTmC352WTh0W4SzSaWAfzNxS5YGr4j2co3Z2/Oec56EkYt
 Jd+TGrA5lIDTnbCEBu2/rRtB9rC+g8w=
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=6aa078a3 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pvcLrITkmtuZ_-2EOG4A:9
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080230
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Tue, Sep 8, 2026 at 8:35=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm.=
com> wrote:
>
> Add these new machines that correspond to the hexagon-sim machine types.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h          | 11 ++++
>  target/hexagon/cpu.h                  |  2 +-
>  hw/hexagon/machine_cfg_v81dgb_1.h.inc | 73 +++++++++++++++++++++++++++
>  hw/hexagon/machine_cfg_v81qa_1.h.inc  | 73 +++++++++++++++++++++++++++
>  hw/hexagon/hexagon_dsp.c              | 46 +++++++++++++++++
>  5 files changed, 204 insertions(+), 1 deletion(-)
>  create mode 100644 hw/hexagon/machine_cfg_v81dgb_1.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v81qa_1.h.inc
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 8a4a81dc26c..719979d6c31 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -50,7 +50,7 @@ typedef struct HexagonGlobalRegState HexagonGlobalRegSt=
ate;
>  #define PRED_WRITES_MAX 5                   /* 4 insns + endloop */
>  #define VSTORES_MAX 2
>  #define MAX_TLB_ENTRIES 1024
> -#define THREADS_MAX 8
> +#define THREADS_MAX 16

MODECTL_E\W and SCHECFG_INTNO need updates to handle the increased
number of threads too.

