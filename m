Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F6606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hrToyROl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AQlkUOyR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFXx-0003UC-OH; Tue, 20 Oct 2026 15:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFXr-0003Tm-8U
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:30:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFXo-0008IW-C9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:30:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGtlSW2278776
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDYpZW6vAvDRoWFWDVBh4MdS5XaNHFAlSEbMIyznYOc=; b=hrToyROlfA0/GOHX
 yxCnhcU6wkn1Z/w2zPu/fZZTmMsUmwfTeEj0wf75fv5K1xrTjMlvqXg0Ki0c3wL0
 k3qqSt1zMf3Er+aG18IumG8wJ3fcHRPeXlnRLalSRNQE0p+iziU1Pp5+BM0WVHK8
 LEi3EsWEFsKdmjHEo+nxSnVafp6lkZtSQg70Kyva374wzHIb9lv76x2WLVon4AfQ
 8O8CGFsPsKJRtlRPAi10wRyKFtULVMaYBAzsGMnRUX+reuCvEtv3Clte4w6xYBHP
 zrQbHEICJqYEl7yro3wQG3ApH/mPIaenfpZoVWdJVWVPQVpIstLBxbtIbKxytapF
 9I0UeQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h29v32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:30:41 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c046843f1so989536d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792524641; x=1793129441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDYpZW6vAvDRoWFWDVBh4MdS5XaNHFAlSEbMIyznYOc=;
 b=AQlkUOyRbzgCztPn+zfBQZORRQbGYF7zWuGa9I9J6HsEpZkpeLSsgn//EBqMuFVDo/
 nRFmyNpGH5Qbp4K9Opa2PyepcAzDMhvtdmiliEFSaG4oC4QQcjqpHN6/J3fOeRE7KEx3
 q8ntRNPMJQjM3JYPy1tNQ2cd6aSFt7vOsUQHZXpiZODiaG0eJ7dwY6h4VJIdXtGkNxgf
 EkUdnfFEs4TIX+TNaIv4v0W/u8xJMgobYknIzMrMUfRp4JoNvNtZhORf5SJDrYVIY8v5
 M+JjO8o1vgA9JBJQWCWBdTRQK6F957NRup/TicEAezscIq5WmLZOMymmVa7KUBaeAaAC
 luuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524641; x=1793129441;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gDYpZW6vAvDRoWFWDVBh4MdS5XaNHFAlSEbMIyznYOc=;
 b=0+9Lbdb7ZMJrWqw7hg0SFxlj4kyC4hibDb+5KHbb/L8uHIONHjL++Unmg5kj964KZ4
 zhaPt/+YceMdsYeFuyGyRIwaXy34+9ljzQ5q7LNov1bQsoZ6fg4d/QZBXeczxoc7uFLB
 8s07kVNMAvoIuppWnXTWYPkOMr5Vg65ahrPLKrgKBXLLV5c4aUzVdK6h9I5tXIiLQ4tZ
 aHZadkVQceMZvhAC0Yg1zYGQ6Da8zwwDYn1bbD/vWBcxKWqeaJ9g2/bXhMH+v4uH+ER4
 jCN4XDaufUelqNOYgrmiA14PViISXHS5YQXGQcvV5OuUNTiicWz+wWSEbjpYl7P1GSNm
 5fTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY30igwHDmRhiB86g3whgFTn7h+mMjiwvdwAUEBi4s+b4P3/2u2KAsDy0Xh/S71IFRjk4nUi04f08+@nongnu.org
X-Gm-Message-State: AFq9FYKaVtfiTBSo4yJxf5NpFEGgSC3iaJW8+1tzRDQlTJuQ/zEeCEw8
 AoG2U/W+IOmi9kTJKt1RT6kxXi/n3tOerv0PPGs2KeQj5pZbvTeGy0LDw8kDxP5V7obIvgjvzRy
 aLBNnohF7cDo6sMPhRBynnAcXOsd7RhF33fWd9yHrQY/5fw/PAbeIbmk0DQ==
X-Gm-Gg: AYBFou008/unO2jwPf/JSt4slKbnEZ9c7sIImUuCO4cu8N6ZEMgo0wsfok0XQBlg6Kr
 yDQV1z44mxID6GTkyqAY8NqRArh5p1b5ASkiu6lcMGMBoDFz0Y9T4GOxWbQAtgW9/Ny9wrRdsde
 OMhM6eUlN+bmXBTPYpQ7VMFWFWEhm0yM2q/c1w6SzRgpIQ8ED3DG2NX1nLyWMfreHV5GqjHUaSz
 vKSCgy6BUph4GY5hVDRaylp7bwW0f+XWsYreYyB9Pnu06R2IN2d0TvquHW+RSuVHFtMRTlgDdQA
 PROBiTrZxSHLFLlXuhDwnYdyddzD/U0yfXiwRGPbjjgyhUyGtIvRp4B9QJbE70AvrKQFO7xsn8a
 mW5h93b48Tp3wHa3eRgkov4vdGbu7Q5N+uA==
X-Received: by 2002:a05:620a:1990:b0:93e:7944:b869 with SMTP id
 af79cd13be357-93f57f1cf0emr45346285a.42.1792524640730; 
 Tue, 20 Oct 2026 12:30:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:93e:7944:b869 with SMTP id
 af79cd13be357-93f57f1cf0emr45341585a.42.1792524640249; 
 Tue, 20 Oct 2026 12:30:40 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254efbeasm532160f8f.5.2026.10.20.12.30.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:30:39 -0700 (PDT)
Message-ID: <e6017bc0-22b7-4caf-932b-f9bc64687b78@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 21:30:38 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/sparc: Add the eight AES round instructions
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-4-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020145530.3385376-4-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HM5sojVUXaY_Fs0F3dBPQTc_uBFOb8tj
X-Proofpoint-ORIG-GUID: HM5sojVUXaY_Fs0F3dBPQTc_uBFOb8tj
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad7c161 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=9WaOFrF7CRZ4OQDaCeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NyBTYWx0ZWRfX7swrtV2x3OW+
 +t7y+14c/+D+H0MGH725K0tdbauOwvCQ9upHbb9Fue3eEA9FISf+Q1HRxHVZEcVZISTpXdceKUE
 7KMVUUZHdmQ8xxQtwaq71VitM1Tcf74=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NyBTYWx0ZWRfX4YZ+5g8OU1UG
 eeK10JlLA1+cYVFXNx88RmDf3KrLdOIRUkfimiKUPy7k5F8ONAvHog9P6cacBD6QzPVIbl9Yd9Y
 ++2bijtoDwkmyN4k+cUHkKIbzomnz1EdVIbRDHf5pPM2vd/FB5c8nkeCCIZiWU0LQR4J1+AnJa1
 mkVPWJBJqHk17ozx34Y8tGVLv6DDn4TztXiUKQbT8wzvLtVfbLMC8MkMzoXgsWrCcM522+zhnwU
 Ok8/CKnKjcgWwGrbsKLhChKEBDU6JEvEbOQDAXpZ/SsIkJiGOBCaUSq4Qeysqa8bCfo4OBkxKRu
 F3ApWjv3pJZwcVcAxc/kUWfxZvE8vPPlB++1W9jDv85p5N7DvtxpILE0PA9dufkWH2pLB8ER0QZ
 8jqDG6ABXsGCKDB9iRJY+6wri1ALkDf+7ImAOHwqO1uwHPWTf62jvhpUzAiJoHaslGS0e2/7Rgd
 LU+nBEN7xy6ZJNhCaWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/10/26 16:55, Stian Halseth wrote:
> Implement the eight AES round instructions by using QEMU's shared
> crypto/aes-round.h, gated behind the crypto CPU feature:
> - AES_EROUND01/23 and last variants
> - AES_DROUND01/23 and last variants
> 
> Based on OSA (Oracle SPARC Architecture) 2011, section 7.3:
> AES Cryptographic Operations (4 operand)
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 85 ++++++++++++++++++++++++++++++++++++
>   target/sparc/helper.h        |  8 ++++
>   target/sparc/insns.decode    |  9 ++++
>   target/sparc/meson.build     |  2 +-
>   target/sparc/translate.c     | 16 +++++++
>   5 files changed, 119 insertions(+), 1 deletion(-)
>   create mode 100644 target/sparc/crypto_helper.c

Could we add tests (in tests/tcg, following commit 57b484e2d23
"target/riscv: fix RV32 fixed counter accesses" which uses the
debian-all-test-cross image -- where gcc-sparc64-linux-gnu is
available)? Actually we could put them in tests/tcg/multiarch/
as generic AES tests.

> 
> diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
> new file mode 100644
> index 0000000000..87cc19b930
> --- /dev/null
> +++ b/target/sparc/crypto_helper.c
> @@ -0,0 +1,85 @@
> +/*
> + * SPARC crypto instructions for QEMU
> + *
> + * Based on Oracle SPARC Architecture 2011
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/helper-proto.h"
> +#include "crypto/aes-round.h"
> +
> +/*
> + * SPARC four-operand AES round (Section 7.3).
> + * s2:s3 holds the state in big-endian order; half selects output columns
> + * 0-1 or 2-3, and key supplies their round key.  dec selects decryption;
> + * last omits MixColumns/InvMixColumns.  Return the selected 64-bit half.

Please document the non-obvious invariant:

  * Note all 64-bit values (state and key) hold AES bytes in big-endian
  * order, i.e. the most significant byte is the first state byte.

> + */
> +static uint64_t aes_round(uint64_t key, uint64_t s2, uint64_t s3,
> +                          int half, bool dec, bool last)
> +{
> +    AESState st, rk = { 0 }, r;
> +    const unsigned first = HOST_BIG_ENDIAN ? 0 : 1;
> +    const unsigned out = first ^ half;
> +
> +    st.d[first] = s2;       /* columns 0-1 */
> +    st.d[first ^ 1] = s3;   /* columns 2-3 */
> +    rk.d[out] = key;

Nitpicking, maybe zero the other half explicitly here instead of { 0 }:

        rk.d[out ^ 1] = 0;

> +
> +    if (dec) {
> +        if (last) {
> +            aesdec_ISB_ISR_AK(&r, &st, &rk, true);
> +        } else {
> +            aesdec_ISB_ISR_AK_IMC(&r, &st, &rk, true);
> +        }
> +    } else {
> +        if (last) {
> +            aesenc_SB_SR_AK(&r, &st, &rk, true);
> +        } else {
> +            aesenc_SB_SR_MC_AK(&r, &st, &rk, true);
> +        }
> +    }
> +
> +    return r.d[out];
> +}
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

