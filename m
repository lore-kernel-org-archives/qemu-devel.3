Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7971CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgW4-00028d-B1; Fri, 02 Oct 2026 12:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgVw-00026Q-JG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:53:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xCgVt-0000PH-AK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 12:53:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692GjaQZ2310785
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 16:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lCN6ixjfwQ45y/plFk39Bf800b3JtBnlCVOty16R1Oo=; b=ALIneGh7YkOnHl2c
 pwlIOxKcPJbj9vzXxrqudVYJ5tR+toP1ijqk0+P3GB5i3mmchg1Vui5vBmnilgoM
 yPzk3Ri3MVUlg1D7YaOPq0ZFQuehodzhwK44z8pokMPAhCcjFJ7hQfLeGXiMLkhK
 0EfpTqzFIMnX5d3jcYYM5XcdWrM75hmt1I+vzmfdPVAbU3OnWGbaAFQHCb5XcOia
 iQMOywDkjKMh++vEPGImms9ktVirAxNAiZSywJDaL9tfFKJ3tzE5TKGkkIZ4fDj3
 iuAxgpQzrStao3igMceogf0pyhaMIKp4XPziWt3VhgQWmvCb39A6qG/cEeK8dkzj
 autxVQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh3893-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 16:53:34 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b2d1eb484aso12379279b6e.2
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 09:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960014; cv=none;
 d=google.com; s=arc-20260327;
 b=lPfjACjX/FjGGIKOF3SQL+9+SOaZNMJk5lAyuxI31s71lT6PiuNYC7KG7CxRzCkUjJ
 q0i6z2sIlOBXXFTvt8Pbza+Iuy2Z15VkNJYFAxeBKC5j2yQt/OXz4Wcnd1lnY12vb0Qc
 Dib7tka0l3/3aUrN1UKn9Nfjq+shvAfIHg1UE8fjSMp/5L+RS1ULphEYK1JUBA/4UTG5
 wPGtff6fy0g5rvXRybBj185u9Gq6HBpqMiAWJBC6UjIcwwXePIVkBrzkZhnIts/QTLBa
 K9yzf56QQLSopMMtKZDqvwN77LC4KWPlUwWzDQlIgHhcpTIYmc9621lwdYUHIBGsB3C3
 7nMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lCN6ixjfwQ45y/plFk39Bf800b3JtBnlCVOty16R1Oo=;
 fh=11nfX6Do8EaL1FMi+r6eKWxDDoA7QEpVbFRn3KjheFE=;
 b=OyuZ5c5r0qkaM/a+Xl9qDsShGtTnLwOmF28VuMSuRcjvQwwNaiT+zHRhPct6eanIBT
 9GzPdbCeIx+6A9/AuqvmJP0AyxuPamS2MV4C9IRRPV2vCEdHTEnn12GU7gHxs67Aexj5
 kpUxHdKjAJs4wRQEOzs5EPC9Rdpttq1dmDiQCMEUGSdx6Idtk11hTRqNMrwUfxNHuE7G
 e2pO956wOp1h2rdfaahq562RocxSFn0aMuQ1p/ojXRnaUyMsMM/ISwRmj9w3HSdIxCe8
 zWuh+V1To2a+wXOR9RaaPPyG4nExWoMK3fwVWPRoam+6vJXufRd8Xb7e2pxFnKfzmMJ4
 af3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790960014; x=1791564814; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lCN6ixjfwQ45y/plFk39Bf800b3JtBnlCVOty16R1Oo=;
 b=TTHc49e/6I00Z2YLxMBNvLFRIsoaGOhokRD0wEajNWL1boFNaibDzTd3FLEH4iiABv
 dIcWNlNA2L74KaZUpxOUwZJ+I4rP4y9UFLPfqSpqtHx/O5tCLMahe1aJrjwoT+hejGVf
 Ucqj/NhgvolJ3ZfrMDevm5oUcXaEGK2by7NPOgjg/Dk3bly0FnpYprRMNWKhWn0GWOfA
 RyXNh/Ngy0wxMe9e3cYkwwlehTfpLU8fTncOwhiAkMLg1lJ4QAXgTIGYvAwulAeD2SeJ
 JRoGiMJc792t3tj7StQKT6zF3XbQqNSX53azGe1gxIQ3SfRc5HgLvPw9w/kbvg+Yk3dw
 BCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960014; x=1791564814;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lCN6ixjfwQ45y/plFk39Bf800b3JtBnlCVOty16R1Oo=;
 b=J7zGyywNc1NIwov95/mGnskZyfDg47K+ziPHtrMmKTmhrpWG/Wgfl5b/RgfKDZyXYz
 3q+z7uxiPfEdMfexL2HzSf173NnRUY844eYQhsCyZimaK7BMAK2Jp2v5AkrSdY/6xdkr
 Mt2ypHJuqiCEvHnd3spGcEhJml78/tfOV6Bsjl7GESgubUpd4M4LJ34BJwWmat4Y2dwQ
 pPkWWrl5pPW2hFFwdGjY6tEqB3PhMhJCY+EQNRpIGlHPl7t2yrMQBa0yMNkLuk2p0FZz
 coo6u0qMeaK+OToBxA8UO+vZmJ7Cps9sHQGhs0jPBQ/2BkwmKsRB/QvFOoHGJ442mPGE
 R5UQ==
X-Gm-Message-State: AFuF++kKuEJ7j+t+UM8wzWsCqeZKjk3J6A2renCUwm6hldLBvdo2MiJy
 Ow5/kIKRCNQ3KhdN0F8QcNDj2C7ykJSwht1NBDXYNj+k22esSITZAG9LZEM0Dtw3va7Soydrrn3
 sFFyyiAun3VLbetPR7L5tFchPQiTRW9LEP1+MYXl9fAf4duDT/QpobAj9leQJABzRGv6ZyOiQ3d
 Vk+KOObmOuE6dbdz+RUB38h8dZ/t13CiJJ
X-Gm-Gg: AYBFou1qK3c5oGhBXlkGmkxH9DdkSDCQW7YJXSAtgYvtuyHhjyKbKtQGkGwbeujnwEf
 iFDwuim1FDX+R/DODIdxiV+bHiCApDvaBEBFL2Kki0Z4Hcyc3arnpjsngFws61V7/MuTv/cV1/0
 ca4PTGlN68igpgVDX0l5BxiDjOp4N1XCGUuEEHIZHlTsq4pma/H+5InN4hE5oPS1vRkiNUt96S5
 +ot22m9+SIuxxRuVQ==
X-Received: by 2002:a05:6808:67c6:b0:4e6:9390:e153 with SMTP id
 5614622812f47-4f67a50bc0amr29608b6e.24.1790960013497; 
 Fri, 02 Oct 2026 09:53:33 -0700 (PDT)
X-Received: by 2002:a05:6808:67c6:b0:4e6:9390:e153 with SMTP id
 5614622812f47-4f67a50bc0amr29589b6e.24.1790960012968; Fri, 02 Oct 2026
 09:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260926192338.2702952-1-brian.cain@oss.qualcomm.com>
 <20260926192338.2702952-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260926192338.2702952-8-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 11:53:22 -0500
X-Gm-Features: AclHuK_dG-mDAQ0CStJqMVHRUIcuZcHXJ_v6nS9D7VxerWo_jI1PhSIhFTtpANY
Message-ID: <CAJ+KCYNyo0YNPD=o3GqS4=V9R8Feogf1rfcGjjxPTRYUT9EPRw@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/hexagon: add the QFloat logic
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX8o9kx65KCLjY
 tqNRh6DlUeyoMnLK7fHNPWu+Q3CpmUwGBhc68/s/iuKlRhYoem4oldatgCF3W3z+0fU6kyATmKn
 wreUbzElWFDBdAzts5a06pN++PbcDCM=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abfe18e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NyBTYWx0ZWRfX+273cxQAZZR0
 o0tBXa5GPpVDiTzUlngcq6FOMunM6LLf6uNWZvaoFaVVbCE4mkEzEfRJmtOkXxJmZEnfliHEsqr
 ZztzR9AMELTvE08JTdBWhjhymMTU9ErSsNL4k/leW3zMI6OTqQZlxO7aihrCVlgXPE5+xrI4pKD
 HyGG6cx9I1v2aUHPi9h9mn1jvI1l2JaDFlV4vg0N/fN/wuYpAivGh09OhK3IlRKuveFqDEu88NB
 SmoIw0VLHFQgNAIPR8H9EHXDKKv7kDJMKLCjkUjrx5Ilq4ukTSmApkumMmMRwXclc2EupuEI+R2
 pcCu9Ty7jvFaVP5Z0KXsCeWl2uDaqs6NaZOY1DmpMFDVhWeQIFwXgi29U6OyyJx6RzbMoBof7vY
 SxxeNcfa3AiWmw+bQQQmx8bY4vob75YeHerizBp1M7fAxd0wP+PkrYKl3BYr6S+wYIbMXwIBdLi
 Tm8KEWCtl463LGz4+lw==
X-Proofpoint-GUID: 2YVTlEPUi-djyj2Rf3p23_QaXTqwsRXQ
X-Proofpoint-ORIG-GUID: 2YVTlEPUi-djyj2Rf3p23_QaXTqwsRXQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020067
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Sat, Sep 26, 2026 at 2:23=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add routines to handle QFloat/HVX floating point values.
>
> Also: add documentation to describe the feature.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  docs/system/hexagon/emulation.rst   |   8 +-
>  target/hexagon/mmvec/mmvec_qfloat.h | 133 +++++
>  target/hexagon/reg_fields_def.h.inc |   2 +
>  target/hexagon/mmvec/hvx_qfloat.c   | 831 ++++++++++++++++++++++++++++
>  target/hexagon/meson.build          |   1 +
>  5 files changed, 972 insertions(+), 3 deletions(-)
>  create mode 100644 target/hexagon/mmvec/mmvec_qfloat.h
>  create mode 100644 target/hexagon/mmvec/hvx_qfloat.c

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

