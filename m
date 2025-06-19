Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E9C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFSF-0004AK-Ji; Thu, 19 Jun 2025 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1uSFRw-00046r-Ql
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:37:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif.lindholm@oss.qualcomm.com>)
 id 1uSFRu-0000Up-Fm
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:37:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J5q6v0029581
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Yw0pCK+yjsFyWICsC6tO8VSFWY/4YZhCmU+/h/OTjc=; b=l2vxXWjh02LBbxtO
 JGjaBro0ebbmcFV2TDr+Os2O1DI6HDj1iul82sq0ngHusUXcLbro/i63M+TSFDlL
 ODsBCXZYPWb/uktjcFyg+E6fAjaDk0IwIcmvb6sTLiyfWE/qMUpPwvFazJNWuQ3z
 HDuvBhi1kybjr1ftV0fdcVU+/15CXpVrpcprFZv12elSazl9qEmzGllv9svX7Zdl
 sUmtb9FF9fR/aTKSpkxjjKmeF+2BD3FkpPf4dHtdFCBetnpm57zR3CcPH5vHwkjW
 7+TR8XLcYsCSJXnehMMPf/l/cxDEqATkOdeWT2pzqdMqyp6mKChOq1WZi0Aw35pA
 kEmafQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791h9g30b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:36:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311d670ad35so744034a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750340216; x=1750945016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Yw0pCK+yjsFyWICsC6tO8VSFWY/4YZhCmU+/h/OTjc=;
 b=Pzxm5CL6KHDtbzA2SO009eH3SeFRM/AWrtU1vpne/YFS4PNJCgmVeY9ovqNautvnh/
 F+HgyxVsqQ6zKoLD1+Jh4XHXmrCUrBhEK1VdwS/D99lAIlVbXjgu25DJnlz/ccArWxRK
 Ux+0FKnDcWI6JsKeH1WC9ijcTV44llxlanzlitBK5C5G96HbtvSOF/hfCpR7Hb9f22nO
 TwGZHSihP/nE5rgyuppxsbOirQQ1CROIm8Ko9hmIaHI8sHbDoY5J44jrRBwfigs58H9+
 57beGkGTR5C/jJecNSaRtYX5gaxFyPzW4+myx8pCB+GUNy9vjopCcu1hr2Rn+cbzsFq1
 WHQQ==
X-Gm-Message-State: AOJu0Yw4yX2MWHzkNA45ZCgfAcQIR9t5k4c3NOrH2DkuX6pRCpR7xMPB
 eIZZOxtiB6d9ocSuxWD9KT91+igU65lt8Z+U2uqLjAvhrJzhWAUCxRtX9O9OMwimfYH8KjGAQKT
 gLtwYJZ+455VeCySCqwGed9xdmJZp32ur7fYH2ts/Cuhi7PNAjYqDAAqsWFHPTMvTT9JFEsCLrp
 KEKWkxeaE8SVfNCOjB9z55jNoEtx0g76Ri
X-Gm-Gg: ASbGncusaJLKQI1ZhQGfriXiLoxmoKDu4ZYGoddQf9veLhths/9VdJHnJl5IGlOofxX
 HBc5WiILgB8Ff+5nWZr1D9jAm4LmlDYBpIRKNOY3Bgt4JUn1xB37G6rvkrpM8WJai2cXvgU9fLV
 4/FhXxrEOAUUUBCyvnbbPUu8XFK3o7c/rJL1pl
X-Received: by 2002:a17:90b:3e43:b0:312:1d2d:18e1 with SMTP id
 98e67ed59e1d1-313f1d52d85mr28143306a91.22.1750340216463; 
 Thu, 19 Jun 2025 06:36:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL1Jhr0ZNa55jblw14p3se0kC8/uXBk2QsW0FG6l0DdQY6qBiOgnrLWDuN9hxt10liUT8ME2NlQ1lfNyomEU4=
X-Received: by 2002:a17:90b:3e43:b0:312:1d2d:18e1 with SMTP id
 98e67ed59e1d1-313f1d52d85mr28143274a91.22.1750340216029; Thu, 19 Jun 2025
 06:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-20-philmd@linaro.org>
In-Reply-To: <20250619131319.47301-20-philmd@linaro.org>
From: Leif Lindholm <leif.lindholm@oss.qualcomm.com>
Date: Thu, 19 Jun 2025 14:36:43 +0100
X-Gm-Features: AX0GCFsnBB6aVSiaBdg8ecDaocgSDD4NQoJgBj-uckYPnF8vAxEIpm4PkwkAxgs
Message-ID: <CAD=n3R2GC0vFxkpzwiieVGSptPYdAEz++d34Z5Qwmn=mKDdwGg@mail.gmail.com>
Subject: Re: [PATCH 19/20] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB
 definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: tPuMs84c3PktAwtkFcdZed6I1BY1NpGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDExMyBTYWx0ZWRfXxXm0DxP7P7eh
 KEWlGTg7suUkDuufBsaG2/Z8ti6SiQOcp67KryRe3ls6K9n9TZ1LnuhnGGNp34fsuZSNRlsTuAc
 /fivmfb5GQbWX8ZLwo5Dtkn6AG/JjD0uxGBN02wA2G93QVFIzjPA0cSXiWRZN13kdFFFkARjjHM
 UdbXAHvWJf4eScJRoJFZqKYmN5IDsKcbkYsEJ1X4tycpvuE9sLKKIqll24O78sD08cdz9xxvm5g
 MueFjH4wiwsmOYYEnSvG8CE8UiLF8iKUWrnGR5eTZiBQOHxrNW3DYa7gsCEM9cA86Fn6Dwcz0LD
 eZYgNEpJHj+UJ1xQdQx0vnyJ+44R4+oiZkt99/w/1etsmzUo9jpjFBPFx2oxL9DkUVSNWd2gbMC
 8Hl+f43/lOivHHG7707m+TSpkv84KLjbV69+VJ5eCuAh53Yy6s+xGypibAMiuLiAKY6wtm6C
X-Authority-Analysis: v=2.4 cv=UL/dHDfy c=1 sm=1 tr=0 ts=68541279 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_k9n5H8yiGyBNqQC-Y4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tPuMs84c3PktAwtkFcdZed6I1BY1NpGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506190113
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=leif.lindholm@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 19 Jun 2025 at 14:15, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Define RAMLIMIT_BYTES using the TiB definition and display
> the error parsed with size_to_str():
>
>   $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
>   qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 TiB of=
 RAM
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Leif Lindholm <leif.lindholm@oss.qualcomm.com>

/
    Leif

> ---
>  hw/arm/sbsa-ref.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index deae5cf9861..3b7d4e7bf1d 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include "qemu/datadir.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -53,8 +54,7 @@
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>
> -#define RAMLIMIT_GB 8192
> -#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> +#define RAMLIMIT_BYTES (8 * TiB)
>
>  #define NUM_IRQS        256
>  #define NUM_SMMU_IRQS   4
> @@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
>      sms->smp_cpus =3D smp_cpus;
>
>      if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
> -        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIM=
IT_GB);
> +        g_autofree char *size_str =3D size_to_str(RAMLIMIT_BYTES);
> +
> +        error_report("sbsa-ref: cannot model more than %s of RAM", size_=
str);
>          exit(1);
>      }
>
> --
> 2.49.0
>

