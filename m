Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C2AC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 17:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4izJ-0007Qu-1u; Thu, 10 Sep 2026 13:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4izH-0007Qm-5R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:55:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4izF-0000qg-2D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 13:55:02 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AF4Rm6622828
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 17:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=/mDZBvXvykmhltlu0NWFmAan
 DzWojHVF4t6BGg1IxCc=; b=V8UWY8HYm3WPGmtzn3qDy1p9dFTQ/dxJOIaIOGBA
 jUFg4YX7GsBqD7aaO4lBV2Bs8mRZdt3/JKQunEjhUmw3WrXbcGJFZTntZU8d4KoQ
 byLBbWmVO9rWLIdIZ1GoZpnhYp7fst87VpIcIy+7haxrzLYJoigEzPH7dXVhArPr
 YCTOH84hGsNenoZed+IOt/aLwLmPS/8mvSPik247FFoKCGd69X6IPt1nip394tcH
 I4IiYHh7vL42ftVFRyDHXmi2GHV3xpUqFE/ilzIhvxcY5RdeSMGTdA4OevdjePOK
 HWBhNX+guvx6aCF3LNm5L3YUkFK/OaDG5fIW2jSsEkRAPw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrdnan99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 17:54:57 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-845f687dfa2so137343507b3.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 10:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789062897; cv=none;
 d=google.com; s=arc-20260327;
 b=dr3g3cwUNetb0Ge74tMuO+DGUSNkfjPw5gq+Ex6B7+c2t7T8JghkD7P6+Y+quMT3M9
 jVrQoWeqF6GSsq+FEfQrVvXnHBOLyv3uxMP5bRWgwtUgN0YA1Zx3XpodQs/rKsuj5pdI
 ThBsuRL4uDgoTvHFSA9SbN5UqHgReEYvNXhJHS227rBtmkLzIyrcLafGsL/GqZO6nfl0
 mL4PEUF5kzQEJ9+TN/FMVok8hvmAW/Uk97/Vegu1dl1FrBd0aTs5uOtbfBBjv4NhXIqE
 hLE7KLXUtb1+fwXRDB0A8UuYbamfFIU6YpbPDaoXBXn8aOWHIIuAq+zWuZYBgJLrOIL1
 G7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/mDZBvXvykmhltlu0NWFmAanDzWojHVF4t6BGg1IxCc=;
 fh=+NGiuCaJkBcMFhTaOsG/B5aXYeWujaYLuYLP/6yolpU=;
 b=iZxHzIJ+xwyhCSbfm0/1ytc6yCc3LwKAw/kw8dVELDedHIV1rQGeGdT1NNLbIV355n
 l7OqRv7qC5abvlAqmA0u+ojNRR5f78raQXG14uaZ1G5yWZ6+L5X6YGNT1WUaBMG+Kkqc
 jHTIlv1Jyk0sUjX8CVHzIuMvxz7ng6VGn+4SyZXrVJMnIQe2UZuPSZKHUCw9M5V/veE0
 4qrSV5cnMX/rLoNeyRO8ByFs5KhOagx/lI/Io3c4SyaAOZMGplCgFoHPKwsnV74T3njY
 O3q18x2pKgCIMVHQdpjW199PlyQDoTzz3NNRP6YKX8zbxLs/SS2QN8GKzuzh/hxzdmmB
 BByQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789062897; x=1789667697; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/mDZBvXvykmhltlu0NWFmAanDzWojHVF4t6BGg1IxCc=;
 b=HefOd/xChL39T41VpMsa+fphuWvyqwotUe8Ejv06F73va+FAxGZv/gxdInt4Bms6Pm
 ZT9uesqGZLy7byxeC7YpzyXWOevsBPV3QGGSuTgXjhf18g4uPXyWZmhKMNmA6HQpsPwg
 DLxtGZObk1cQOHFJ2UPC7n7p66MaTvGnC/pmkm9cwoFTqBW+2uUhScLUKd8VZA6GdVaY
 MDtmqTM5kG8wLK12YBTb5Gcv00HTxv3IjSKCNwIJX9Nc2KZUx6H7OO8OhrXdZDEO2dBD
 qCQiyoItr1qK1/sCzeFb6Dq9zS/OWvB1FcJVGX2MTm6JvTlBP1D6lTYkDQTvuf+qV/4C
 MuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789062897; x=1789667697;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/mDZBvXvykmhltlu0NWFmAanDzWojHVF4t6BGg1IxCc=;
 b=F8FMQWsEAcVRphM+gwjP7GTD/Qu+R4dMN+KVq9S4tf2gdhWAWBW/lJwu1MbI9VWt7r
 NgeIFeCp141zOSfmYwjReCNo1VyIR0qV8hyzyiVmPdXWStXse+BPxDkyxOqR/QVJioJM
 MprcldUBJAH5opyj/AJhMMDNrJL020jAnFN04c6SgKGRzSSNm2BKw8IcHcqlwucKTEGm
 qWHqQvbZk8i2mlrEVU/QgH9tpHJ6FM3OJNNgGzMRGglsX9lM/B/zL7MaQ9Ra76g0lrNH
 r/742fLq7HOLjLjFM3h+hkWjUcJKjSYYi3M3mk0FfNxmQ8OBkFq/Y8nXX4BvtYeaKovn
 8CXw==
X-Gm-Message-State: AFuF++ni3knemn6F9uDN2cohug4p8hA75ZAQSy/A/qe60Sj/ftAGxCkB
 F++GXUE5hhc7hVTvT6lEgx3yaWeatbpmckK6mCF5IJSEZDDpS6FDQifI7nZRqI02jQlaMtoGp7J
 mCjlwryEB9UIP2Yo5ndYcBvK1aGTTF5HroK3zdeC1Cde2sPqDv6cl9+91c/RqYUvo5qACBOsNyu
 5etnrLYuUxY0x8sJHB+qUgA+qQEBik44GR
X-Gm-Gg: AYBFou3lqmcxrvOB437RCU08FdsLTGRaQNomXOWyUTUtwCMQ08eEhDOT4UDMW4C2pei
 b+9BJL9mFt4wAtkZuIni/mYEoy58pnIC7h5Q26Bml3+n6X/6///W+Ggg11kYQ7qV5HbeHHEZbTl
 rfq+HAnhM/oJqrbuRlb3d26U0f/B6bUctEmPez7mtluD1yWvwiZyxdA06zgA8=
X-Received: by 2002:a05:690c:c513:b0:836:ec4d:bb29 with SMTP id
 00721157ae682-884b1842ed9mr3125097b3.34.1789062896785; 
 Thu, 10 Sep 2026 10:54:56 -0700 (PDT)
X-Received: by 2002:a05:690c:c513:b0:836:ec4d:bb29 with SMTP id
 00721157ae682-884b1842ed9mr3124767b3.34.1789062896323; Thu, 10 Sep 2026
 10:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905180949.1852673-8-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 12:54:45 -0500
X-Gm-Features: AcwNN1WCCAgyvpkvb8iVSTDCbSvq2NP8AK__ZppjUJoyfILX2uaRW43MmlaOJNw
Message-ID: <CAJpW4SX5Pd7=+EGxa3jjsdQtqhvR-8GQu5czK4ghLm4KOv-edw@mail.gmail.com>
Subject: Re: [PATCH 07/17] tests/tcg/hexagon: add bit interleave and
 convergent rounding tests
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000006aa653065b24aa38"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxOSBTYWx0ZWRfX88qSocuGXiC5
 ziS89DkaUYpQLdyHHDuWhxvElTviQHMArVGglPBkRpKnlomWsL/RaNQ6IkdvCaMmTGXnFxJO23t
 EkH03tdBsCppMxbhmSFDnG4ciNOLDl9Nj1p1hM3qXKxTYLjXaslSGHkuk5PCP9Dmx1xRk3FLm6L
 xZrvsq11J/qCbv/5d+rdLEDKUvdQeiiBAmm7TPju2kTJS3jtHw07LJD0YgHdDLy8YfxUByhzChW
 2+b9YbtKrpwi+5HsABVbZMJrQd1tZ/lWFv33nBDQx3Usbw4Q7MDZj+MmjP3TgHi2fea6jybvG3a
 hYlpCqmvPBfNBvDLsVOT6Xrsq9BwzDvgHUR/k1cm0hFlVVuiEWzBsDwyXPulVUeEX8czLNM+iIm
 4e7o4OWGPgk32hhrJal7AOeblJUS5hgOhMJBEQzoq4RSKiXz7Qku717XTjRIjqZtNAzcpRJAktp
 gaDjKQF3G4LvQo/ELLQ==
X-Proofpoint-GUID: bGxzIABNlymNP9vDiVexgEr0J5RHx6Sa
X-Proofpoint-ORIG-GUID: bGxzIABNlymNP9vDiVexgEr0J5RHx6Sa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxOSBTYWx0ZWRfXwyoleaBjGZGx
 qDiW0veCUiwngUMq07IOLoETtQtvSi/Dt6TZ/AkUiMmvmXYLA1tUJZ747d47SS/ltonNtvXPm6Y
 /LNPxjfiOwGtrVDy/zDr3pVWnaglYXU=
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6aa2eef1 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=7q6KQSPDHR0pADrafH8A:9 a=QEXdDO2ut3YA:10
 a=PAHJ7KC0YmXpdB5SwGgA:9 a=1icb1Uu_pDD4K4jU:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sid.manning@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

--0000000000006aa653065b24aa38
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM
Reviewed-by:Sid Manning <sid.manning@oss.qualcomm.com>

On Sat, Sep 5, 2026 at 1:10=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Test the interleave/deinterleave 64-bit bit-manipulation instructions
> and the cround instruction.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/test_bitops.c | 98 +++++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build   |  1 +
>  2 files changed, 99 insertions(+)
>  create mode 100644 tests/tcg/hexagon/test_bitops.c
>
> diff --git a/tests/tcg/hexagon/test_bitops.c
> b/tests/tcg/hexagon/test_bitops.c
> new file mode 100644
> index 00000000000..3e9274ddddd
> --- /dev/null
> +++ b/tests/tcg/hexagon/test_bitops.c
> @@ -0,0 +1,98 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * Test bit interleave/deinterleave and convergent rounding.
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <hexagon_protos.h>
> +
> +int err;
> +
> +#include "hex_test.h"
> +
> +static void check_interleave(void)
> +{
> +    uint64_t input;
> +    uint64_t inter;
> +    uint64_t deinter;
> +
> +    /*
> +     * interleave takes the 32 even bits and 32 odd bits of Rss and
> +     * interleaves them: even[0] goes to bit 0, odd[0] to bit 1,
> +     * even[1] to bit 2, odd[1] to bit 3, etc.
> +     *
> +     * Input:  low 32 bits (even half), high 32 bits (odd half)
> +     * If low =3D 0xFFFFFFFF, high =3D 0x00000000:
> +     *   result has every even bit set, every odd bit clear
> +     *   =3D 0x5555555555555555
> +     */
> +    input =3D 0x00000000FFFFFFFFULL;
> +    inter =3D Q6_P_interleave_P(input);
> +    check64(inter, 0x5555555555555555ULL);
> +
> +    /* All ones should stay all ones */
> +    input =3D 0xFFFFFFFFFFFFFFFFULL;
> +    inter =3D Q6_P_interleave_P(input);
> +    check64(inter, 0xFFFFFFFFFFFFFFFFULL);
> +
> +    /* All zeros should stay all zeros */
> +    input =3D 0x0000000000000000ULL;
> +    inter =3D Q6_P_interleave_P(input);
> +    check64(inter, 0x0000000000000000ULL);
> +
> +    /*
> +     * deinterleave is the inverse of interleave.
> +     * deinterleave(interleave(x)) should equal x.
> +     */
> +    input =3D 0xDEADBEEFCAFEBABEULL;
> +    inter =3D Q6_P_interleave_P(input);
> +    deinter =3D Q6_P_deinterleave_P(inter);
> +    check64(deinter, input);
> +
> +    /* deinterleave of 0x5555...5555 -> low half all 1s, high half all 0=
s
> */
> +    deinter =3D Q6_P_deinterleave_P(0x5555555555555555ULL);
> +    check64(deinter, 0x00000000FFFFFFFFULL);
> +}
> +
> +static void check_cround(void)
> +{
> +    /*
> +     * cround(0x300, #8) -> 3 (exact shift, no rounding needed).
> +     * 0x300 >> 8 =3D 3
> +     */
> +    check32(Q6_R_cround_RI(0x300, 8), 3);
> +
> +    /*
> +     * cround(0x380, #8) -> 4 (0x380 >> 8 =3D 3.5, rounds to even =3D 4)
> +     */
> +    check32(Q6_R_cround_RI(0x380, 8), 4);
> +
> +    /*
> +     * cround(0x280, #8) -> 2 (0x280 >> 8 =3D 2.5, rounds to even =3D 2)
> +     */
> +    check32(Q6_R_cround_RI(0x280, 8), 2);
> +
> +    /*
> +     * cround(0x3C0, #8) -> 4 (0x3C0 >> 8 =3D 3.75, rounds up to 4)
> +     */
> +    check32(Q6_R_cround_RI(0x3C0, 8), 4);
> +
> +    /*
> +     * Shift by 0 -> return the input unchanged.
> +     */
> +    check32(Q6_R_cround_RI(42, 0), 42);
> +}
> +
> +int main(void)
> +{
> +    check_interleave();
> +    check_cround();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.buil=
d
> index 4a2826c4276..6c8e26876af 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -69,6 +69,7 @@ tests +=3D {
>    'test_abs.S': {'cflags': asmflags},
>    'test_bitcnt.S': {'cflags': asmflags},
>    'test_bitsplit.S': {'cflags': asmflags},
> +  'test_bitops.c': {'cflags': cflags},
>    'test_call.S': {'cflags': asmflags},
>    'test_clobber.S': {'cflags': asmflags},
>    'test_cmp.S': {'cflags': asmflags},
> --
> 2.34.1
>
>

--0000000000006aa653065b24aa38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>LGTM</div>Reviewed-by:Sid Manning &lt;<a href=3D"mail=
to:sid.manning@oss.qualcomm.com" target=3D"_blank">sid.manning@oss.qualcomm=
.com</a>&gt;</div><br><div class=3D"gmail_quote gmail_quote_container"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2026 at 1:10=E2=80=AFPM Br=
ian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.=
qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Test the interleave/deinterleave 64-bit bit-manipulation instru=
ctions<br>
and the cround instruction.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/test_bitops.c | 98 ++++++++++++++++++++++++++++++++=
+<br>
=C2=A0tests/tcg/hexagon/meson.build=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A02 files changed, 99 insertions(+)<br>
=C2=A0create mode 100644 tests/tcg/hexagon/test_bitops.c<br>
<br>
diff --git a/tests/tcg/hexagon/test_bitops.c b/tests/tcg/hexagon/test_bitop=
s.c<br>
new file mode 100644<br>
index 00000000000..3e9274ddddd<br>
--- /dev/null<br>
+++ b/tests/tcg/hexagon/test_bitops.c<br>
@@ -0,0 +1,98 @@<br>
+/*<br>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.<br>
+ * SPDX-License-Identifier: GPL-2.0-or-later<br>
+ */<br>
+<br>
+/*<br>
+ * Test bit interleave/deinterleave and convergent rounding.<br>
+ */<br>
+<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdint.h&gt;<br>
+#include &lt;hexagon_protos.h&gt;<br>
+<br>
+int err;<br>
+<br>
+#include &quot;hex_test.h&quot;<br>
+<br>
+static void check_interleave(void)<br>
+{<br>
+=C2=A0 =C2=A0 uint64_t input;<br>
+=C2=A0 =C2=A0 uint64_t inter;<br>
+=C2=A0 =C2=A0 uint64_t deinter;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* interleave takes the 32 even bits and 32 odd bits of=
 Rss and<br>
+=C2=A0 =C2=A0 =C2=A0* interleaves them: even[0] goes to bit 0, odd[0] to b=
it 1,<br>
+=C2=A0 =C2=A0 =C2=A0* even[1] to bit 2, odd[1] to bit 3, etc.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Input:=C2=A0 low 32 bits (even half), high 32 bits (=
odd half)<br>
+=C2=A0 =C2=A0 =C2=A0* If low =3D 0xFFFFFFFF, high =3D 0x00000000:<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0result has every even bit set, every odd=
 bit clear<br>
+=C2=A0 =C2=A0 =C2=A0*=C2=A0 =C2=A0=3D 0x5555555555555555<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 input =3D 0x00000000FFFFFFFFULL;<br>
+=C2=A0 =C2=A0 inter =3D Q6_P_interleave_P(input);<br>
+=C2=A0 =C2=A0 check64(inter, 0x5555555555555555ULL);<br>
+<br>
+=C2=A0 =C2=A0 /* All ones should stay all ones */<br>
+=C2=A0 =C2=A0 input =3D 0xFFFFFFFFFFFFFFFFULL;<br>
+=C2=A0 =C2=A0 inter =3D Q6_P_interleave_P(input);<br>
+=C2=A0 =C2=A0 check64(inter, 0xFFFFFFFFFFFFFFFFULL);<br>
+<br>
+=C2=A0 =C2=A0 /* All zeros should stay all zeros */<br>
+=C2=A0 =C2=A0 input =3D 0x0000000000000000ULL;<br>
+=C2=A0 =C2=A0 inter =3D Q6_P_interleave_P(input);<br>
+=C2=A0 =C2=A0 check64(inter, 0x0000000000000000ULL);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* deinterleave is the inverse of interleave.<br>
+=C2=A0 =C2=A0 =C2=A0* deinterleave(interleave(x)) should equal x.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 input =3D 0xDEADBEEFCAFEBABEULL;<br>
+=C2=A0 =C2=A0 inter =3D Q6_P_interleave_P(input);<br>
+=C2=A0 =C2=A0 deinter =3D Q6_P_deinterleave_P(inter);<br>
+=C2=A0 =C2=A0 check64(deinter, input);<br>
+<br>
+=C2=A0 =C2=A0 /* deinterleave of 0x5555...5555 -&gt; low half all 1s, high=
 half all 0s */<br>
+=C2=A0 =C2=A0 deinter =3D Q6_P_deinterleave_P(0x5555555555555555ULL);<br>
+=C2=A0 =C2=A0 check64(deinter, 0x00000000FFFFFFFFULL);<br>
+}<br>
+<br>
+static void check_cround(void)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* cround(0x300, #8) -&gt; 3 (exact shift, no rounding =
needed).<br>
+=C2=A0 =C2=A0 =C2=A0* 0x300 &gt;&gt; 8 =3D 3<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 check32(Q6_R_cround_RI(0x300, 8), 3);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* cround(0x380, #8) -&gt; 4 (0x380 &gt;&gt; 8 =3D 3.5,=
 rounds to even =3D 4)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 check32(Q6_R_cround_RI(0x380, 8), 4);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* cround(0x280, #8) -&gt; 2 (0x280 &gt;&gt; 8 =3D 2.5,=
 rounds to even =3D 2)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 check32(Q6_R_cround_RI(0x280, 8), 2);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* cround(0x3C0, #8) -&gt; 4 (0x3C0 &gt;&gt; 8 =3D 3.75=
, rounds up to 4)<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 check32(Q6_R_cround_RI(0x3C0, 8), 4);<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Shift by 0 -&gt; return the input unchanged.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 check32(Q6_R_cround_RI(42, 0), 42);<br>
+}<br>
+<br>
+int main(void)<br>
+{<br>
+=C2=A0 =C2=A0 check_interleave();<br>
+=C2=A0 =C2=A0 check_cround();<br>
+<br>
+=C2=A0 =C2=A0 puts(err ? &quot;FAIL&quot; : &quot;PASS&quot;);<br>
+=C2=A0 =C2=A0 return err ? 1 : 0;<br>
+}<br>
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build<=
br>
index 4a2826c4276..6c8e26876af 100644<br>
--- a/tests/tcg/hexagon/meson.build<br>
+++ b/tests/tcg/hexagon/meson.build<br>
@@ -69,6 +69,7 @@ tests +=3D {<br>
=C2=A0 =C2=A0&#39;test_abs.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_bitcnt.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_bitsplit.S&#39;: {&#39;cflags&#39;: asmflags},<br>
+=C2=A0 &#39;test_bitops.c&#39;: {&#39;cflags&#39;: cflags},<br>
=C2=A0 =C2=A0&#39;test_call.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_clobber.S&#39;: {&#39;cflags&#39;: asmflags},<br>
=C2=A0 =C2=A0&#39;test_cmp.S&#39;: {&#39;cflags&#39;: asmflags},<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000006aa653065b24aa38--

