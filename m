Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CCCC79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIo-0003wk-Ub; Thu, 10 Sep 2026 14:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4jIn-0003vX-MI
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4jIk-00072e-Lo
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIDPsQ2084127
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 18:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=w/SM0seQA9zOCCjrRRIV4k4M
 y6IxhP84NqMrZElFpbY=; b=fPRdQqFTqI7p/366QrevGH7ksU66O2ClLinSDzLx
 MQk698HQ2NQAfMBaC5Ma2dVS5qrYe+o/GkILaBsA2qqy6yfdaMcCNVbA1Rm2iXel
 Kem5zrEr5Zr3HXUZNTN5XSX+bng2HbNvsgjNmUC6T2YkheqnQbB4Xy6HKq6AvPYn
 cisaGHmPjRbJFr2xgvgjYeIvh8YbGttjQiM3L0PU4WCOXeESGq+xVr4bHvZF8kvf
 XSXn7NnesBmmbvra7gqRhl5rlwvyem4DD36KBhijRXrMJza19EM84R6BIVU/RUyS
 hQiw4ew1zSdOszWMiMO9xsoSpOGhanxh7X4jCgLnsEy8Og==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrcjtyhg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 18:15:08 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8789206f693so89654397b3.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789064108; cv=none;
 d=google.com; s=arc-20260327;
 b=jO9sMHCzpt3Vx0RcX/oUENvmdly+8sGzVUcpgAFU6X4C1Yhj1xLoyUyPL6qu2Obgpr
 0FxS3MRexCuI/GJVtJBLyZKNd3c67LGq3RbHIM6Aay31NnUfKHwiEsSN2bb6D9OIneng
 HYXIjDEnAOsasF+QbepBhVvUCtRfb0C/7GE6n/IqmkxbtVEU1eTmxEHBXT17sP+TNIsP
 PW+3e2b01NCcCNK4OqpWU0vyYztoFShuTHMI4FxfTuhrEj8IQ1aVGsni1cEjlgSl+vVJ
 CytoeXcl72eJR9RDELCD/Qdwr0amRpnboU+LdcCWEf4tXlGkCNOUcGq5HxLJtKTttV+q
 s9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=w/SM0seQA9zOCCjrRRIV4k4My6IxhP84NqMrZElFpbY=;
 fh=+NGiuCaJkBcMFhTaOsG/B5aXYeWujaYLuYLP/6yolpU=;
 b=JBTq/7cHtwmto+NUhUvDursrOTQraf1m7OsMtIG3zfRwX/HaaxN9+GmDWzNCxbtwE3
 Suhs6pBp/v9J+Dh7+2h4QVS3KceWWR31Lsfvkb9nsCarrG7kyOKyOc1iaBHADFv7OlVg
 4RNp9r5KLtZRaUV7+hW4YSc0E+qE3pFTDyrHy01+9fbCSlp450s7fHM65+26sUDKWJVK
 T7WZWpxOF2ShtDX6ixztYsvlH4n9eYPqLK12MAJ6JEtIJmkmi9clCrL7YonGUgzhLkEL
 0fatXw2YlYfpm5LLrZYm/3Z7TXTGen0R+jQ1St5LIAvaXpjkgu44wSbod43odTsyXidQ
 jqQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789064108; x=1789668908; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w/SM0seQA9zOCCjrRRIV4k4My6IxhP84NqMrZElFpbY=;
 b=dKRCX2Cx+dXXZ3yM8trSwi/+/m5zps0xXE6hfneNnCSCkBt4XCuCfy84pGHycwV8xz
 3C0wTDGxk/BP3ixo4AXB3iWUjvHu/gUH7YN5U0TbDCiaENHz/sV5j1ysIiSaNNOuVSiu
 puMT0eYno5LJVOceIZgAl4vGBv3pNCBGLSoCHgtjXkIvNNTi/Rny3S+dygBxyd8Nyi5O
 8ayoVdJE+Po9HNu8XvBGMHzXdo3SXQjZw1lkYr2KZxFKVsD+CAJESTjyHas7jnpyUGuh
 Onkq/yr5iPRb+bGFwwpj4VmcYUlr54uZJQLgHHwSUskEjY+UGzXTzmtYPAW7WMuamJMo
 tgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064108; x=1789668908;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w/SM0seQA9zOCCjrRRIV4k4My6IxhP84NqMrZElFpbY=;
 b=WCsGLCWk2bAdXI9PLhPY/wIXRfMEqOCQpvz2PprmnSp1RMxnl/j9rw0UnRI9GAYJtR
 zjtZgSm+9EzkPEhuIS6Vau4rSGYUqi4GeuIdW1Z+8dKyESyJNC/Q9Sjsl5BMhV8gsDGo
 HUEM+Rvk6lZK68izN9I1dvNBCNgqh/AFgEWOqPmzR0WEdKjRcOKhI5LGUgwD1iZ0LwaO
 EPWGNjS79muEvVY2kSw8NWR+rIvFMRlKjVeheBXUWzAENDf81LyjOW2KFluprIrf1jfi
 eIj/p+aDVApdtGUDSyr+weiTJXzZT4+jeJUqnOf0DhiIhnvLmFucbe2Pn7x3mkm6Kd8o
 Li7A==
X-Gm-Message-State: AFuF++l9gSX3//3pPk2+weymahTr5uBH2bBn3ZjjlgKpDiOBsdlao98e
 3rtUe8O4ksxiP13DPtQSdJspqTiNgpFKkncLEjuk3VRAa9EuGwICskKgFxrq9b7qEpX12mbgf4j
 ffz/cq1f7DgQsym1J2SR++bWvhPspiqpIIDGwm3c0QoeT7B0gB0oFbxA2R2JQkh/HjiGEtm1O8G
 SrzDK6gqTmhkUfmMTicL83bC8gJWNlDPaX
X-Gm-Gg: AYBFou16kkeUD2ZvPtQwq8y1xEtyIkpoqUxO0oQacmYymp1l3wByYwbPlKp8FEEIAjL
 it3Csh2bqMeS0uxlpX9ibyGtFR6kcBriHNYCYdrW6wkjlP4wGlM/M+tSHqp+LPOXytACrNoQFOO
 rEILJ4B5QhHPzw//WvagMP9736JgSgjRc2WE4TpqXoygwDPkcwrjvUg9wcd38=
X-Received: by 2002:a05:690c:dc4:b0:873:5ddf:d866 with SMTP id
 00721157ae682-884b3f4eb9emr3404967b3.49.1789064107770; 
 Thu, 10 Sep 2026 11:15:07 -0700 (PDT)
X-Received: by 2002:a05:690c:dc4:b0:873:5ddf:d866 with SMTP id
 00721157ae682-884b3f4eb9emr3404507b3.49.1789064106877; Thu, 10 Sep 2026
 11:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905180949.1852673-10-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 13:14:55 -0500
X-Gm-Features: AcwNN1WZ2-94WLEpD3PlvOjx6FdUVKcToh--ZHDNP7p3QUk7cIYDbfVwBFm-9JQ
Message-ID: <CAJpW4SWQuJYAg91hw8LJ7Typ-o58ju_Z6sC4P_bA8L69FEKhYA@mail.gmail.com>
Subject: Re: [PATCH 09/17] tests/tcg/hexagon: add dczeroa cache line zero test
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000923d2c065b24f253"
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIyNCBTYWx0ZWRfX4b5v0HtTgo26
 xzcQzlWQtzc+R+WfkZ7sVh/gqJwRyANmLpXOA3M5AvipgJ6ESmFqydCMAqI/OqBLed/bvfDcmzz
 Ix0K5EW//dHEBWpffV7BXasFYKD41No=
X-Proofpoint-GUID: qBlGIP5FCMKsmkEYrApk4omj3NmDoJA6
X-Authority-Analysis: v=2.4 cv=aef0Dhot c=1 sm=1 tr=0 ts=6aa2f3ac cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Ig8onDUQYv1dlAjHv1YA:9 a=QEXdDO2ut3YA:10
 a=vmnuKRyZPrrNjO9JjgoA:9 a=k1Y_Smve49sFrKH0:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIyNCBTYWx0ZWRfXyO/wSS67/j7f
 CBoxg5MvZblGRzZWWdZHpnv0OT6dEuWR3UT89Yc8qxlbmMQwF3TIAUQy7teDZtfzB7jd0kmYby7
 u3MiaIHm/QP+Q1wWIB4Z8yPv7dxupGEwyOBIdrjQS7vd76iO3UN/54ts7fzRV9teXa/aICLMzfs
 WiwWxX3B+r8T9pyEMCnv9SmPT6c3Acy3wf1fQdvw8lVqyKdjdJ+UrWaMEVEi2XGhSdwwTl6bdXV
 NsnjzsedO4nexNaohohnEtCh5yu2kRl2sMuY9zS1GUPwXzHCPVeKgsHkBWXa8tJiB1JGfhn7p7d
 ry2OyjxgWILYedAi1QO6FnOCO8yvsIj2vJ8SaQ9gLeTSuelCdphxqEruLuYpuNxT4D7lK/IQwM3
 Q4VktUahk52ADR0TO3RRuLBDPw6Anq2qkWe2VBseZPneJOIf9EqIUHZgdxVdirrjLCibXB3mgfb
 r52ETmII7FLUFxaUSzg==
X-Proofpoint-ORIG-GUID: qBlGIP5FCMKsmkEYrApk4omj3NmDoJA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100224
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sid.manning@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000923d2c065b24f253
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by:Sid Manning <sid.manning@oss.qualcomm.com>

On Sat, Sep 5, 2026 at 1:10=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Test the dczeroa instruction which zeroes a cache line.  Verifies aligned=
,
> unaligned, and buffer-start addresses.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/test_dczeroa.c | 88 ++++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build    |  1 +
>  2 files changed, 89 insertions(+)
>  create mode 100644 tests/tcg/hexagon/test_dczeroa.c
>
> diff --git a/tests/tcg/hexagon/test_dczeroa.c
> b/tests/tcg/hexagon/test_dczeroa.c
> new file mode 100644
> index 00000000000..8cdcdd6a3b5
> --- /dev/null
> +++ b/tests/tcg/hexagon/test_dczeroa.c
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * Test the dczeroa instruction, which zeroes a 32-byte cache line.
> + * The address is rounded down to a 32-byte boundary: (addr & ~0x1f).
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <hexagon_protos.h>
> +
> +int err;
> +
> +#include "hex_test.h"
> +
> +static uint8_t buf[128] __attribute__((aligned(32)));
> +
> +/* dczeroa with an aligned address */
> +static void test_dczeroa_aligned(void)
> +{
> +    int i;
> +
> +    memset(buf, 0xff, sizeof(buf));
> +
> +    Q6_dczeroa_A(&buf[32]);
> +
> +    for (i =3D 0; i < 32; i++) {
> +        check32(buf[i], 0xff);
> +    }
> +    for (i =3D 32; i < 64; i++) {
> +        check32(buf[i], 0x00);
> +    }
> +    for (i =3D 64; i < 96; i++) {
> +        check32(buf[i], 0xff);
> +    }
> +}
> +
> +/* dczeroa with an unaligned address (should round down) */
> +static void test_dczeroa_unaligned(void)
> +{
> +    int i;
> +
> +    memset(buf, 0xff, sizeof(buf));
> +
> +    /* Address buf+40 rounds down to buf+32 */
> +    Q6_dczeroa_A(&buf[40]);
> +
> +    for (i =3D 0; i < 32; i++) {
> +        check32(buf[i], 0xff);
> +    }
> +    for (i =3D 32; i < 64; i++) {
> +        check32(buf[i], 0x00);
> +    }
> +    for (i =3D 64; i < 96; i++) {
> +        check32(buf[i], 0xff);
> +    }
> +}
> +
> +/* dczeroa at the start of the buffer */
> +static void test_dczeroa_start(void)
> +{
> +    int i;
> +
> +    memset(buf, 0xff, sizeof(buf));
> +
> +    Q6_dczeroa_A(&buf[0]);
> +
> +    for (i =3D 0; i < 32; i++) {
> +        check32(buf[i], 0x00);
> +    }
> +    for (i =3D 32; i < 64; i++) {
> +        check32(buf[i], 0xff);
> +    }
> +}
> +
> +int main(void)
> +{
> +    test_dczeroa_aligned();
> +    test_dczeroa_unaligned();
> +    test_dczeroa_start();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.buil=
d
> index aa176e56883..fcf0bd38f26 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -74,6 +74,7 @@ tests +=3D {
>    'test_clobber.S': {'cflags': asmflags},
>    'test_cmp.S': {'cflags': asmflags},
>    'test_cond_branch.c': {'cflags': cflags},
> +  'test_dczeroa.c': {'cflags': cflags},
>    'test_dotnew.S': {'cflags': asmflags},
>    'test_ext.S': {'cflags': asmflags},
>    'test_fibonacci.S': {'cflags': asmflags},
> --
> 2.34.1
>
>

--000000000000923d2c065b24f253
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by:Sid Manning &lt;<a href=3D"mailto:sid.manning@=
oss.qualcomm.com" target=3D"_blank">sid.manning@oss.qualcomm.com</a>&gt;</d=
iv><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Sat, Sep 5, 2026 at 1:10=E2=80=AFPM Brian Cain &lt;<a=
 href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Tes=
t the dczeroa instruction which zeroes a cache line.=C2=A0 Verifies aligned=
,<br>
unaligned, and buffer-start addresses.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/test_dczeroa.c | 88 +++++++++++++++++++++++++++++++=
+<br>
=C2=A0tests/tcg/hexagon/meson.build=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A02 files changed, 89 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/test_dczeroa.c<br>
<br>
diff --git a/tests/tcg/hexagon/test_dczeroa.c b/tests/tcg/hexagon/test_dcze=
roa.c<br>
new file mode 100644<br>
index 00000000000..8cdcdd6a3b5<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/test_dczeroa.c<br>
@@ -0,0 +1,88 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+/*<br>
+ * Test the dczeroa instruction, which zeroes a 32-byte cache line.<br>
+ * The address is rounded down to a 32-byte boundary: (addr &amp; ~0x1f).<=
br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;hexagon_protos.h&gt;<br>
+<br>
+int err;<br>
+<br>
+#include &quot;hex_test.h&quot;<br>
+<br>
+static uint8_t buf[128] __attribute__((aligned(32)));<br>
+<br>
+/* dczeroa with an aligned address */<br>
+static void test_dczeroa_aligned(void)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 memset(buf, 0xff, sizeof(buf));<br>
+<br>
+=C2=A0 =C2=A0 Q6_dczeroa_A(&amp;buf[32]);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 32; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0xff);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 32; i &lt; 64; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0x00);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 64; i &lt; 96; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0xff);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/* dczeroa with an unaligned address (should round down) */<br>
+static void test_dczeroa_unaligned(void)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 memset(buf, 0xff, sizeof(buf));<br>
+<br>
+=C2=A0 =C2=A0 /* Address buf+40 rounds down to buf+32 */<br>
+=C2=A0 =C2=A0 Q6_dczeroa_A(&amp;buf[40]);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 32; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0xff);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 32; i &lt; 64; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0x00);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 64; i &lt; 96; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0xff);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/* dczeroa at the start of the buffer */<br>
+static void test_dczeroa_start(void)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 memset(buf, 0xff, sizeof(buf));<br>
+<br>
+=C2=A0 =C2=A0 Q6_dczeroa_A(&amp;buf[0]);<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 32; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0x00);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 32; i &lt; 64; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 check32(buf[i], 0xff);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 test_dczeroa_aligned();<br>
+=C2=A0 =C2=A0 test_dczeroa_unaligned();<br>
+=C2=A0 =C2=A0 test_dczeroa_start();<br>
+<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br>
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build<=
br>
index aa176e56883..fcf0bd38f26 100644<br>
--- a/tests/tcg/hexagon/meson.build<br>
+++ b/tests/tcg/hexagon/meson.build<br>
@@ -74,6 +74,7 @@ tests +=3D {<br>
=C2=A0 =C2=A0&#39;test_clobber.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_cmp.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_cond_branch.c&#39;: {&#39;cflags&#39;: cflags},<br>
+=C2=A0 &#39;test_dczeroa.c&#39;: {&#39;cflags&#39;: cflags},<br>
=C2=A0 =C2=A0&#39;test_dotnew.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_ext.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_fibonacci.S&#39;: {&#39;cflags&#39;: asmflags},<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000923d2c065b24f253--

