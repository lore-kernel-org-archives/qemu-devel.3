Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F21606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AFy448cf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CNGLQOPQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMpSc-00062x-To; Fri, 30 Oct 2026 12:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMpSZ-00062c-5h
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:28:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMpSX-0008Rr-1c
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 12:28:06 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER3Ar377953
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 POkNZy+RXRrFTgKPTYxztw44SeZP1JTpkaZndfi7BfU=; b=AFy448cfRXUjIUyW
 WEYOxi6JsCtvpAbcoAMwtQEFAEUJIMvIyb2SlKGkTqsewEI17BazLg9djx9WIi4J
 mOkiGhMDSCEP67N2t78QXnY6SL7acnWibeRHbcaXZInCoXuWILEFG8SuX7+yI3eH
 LbbJylyErLjQPLT37DXBDFHMENlYl6kuYvwHOj6pZVp4I7wOwDJ9bjHUW3Azwgzr
 sUVg8h0x2DM6G8OFkzWCkPE8WfPEM6xN8l+e+3zcIVwPY08vtCuBF1vDrAL6DL62
 xjg3cAcgzCghGxBnnrJOt/SEXA7O2PFDfWQPESZS+vKLeVm/og4Jr3g5Jplsjhmy
 JG4kow==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme753yqy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 16:28:02 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4c734afb8deso1083139b6e.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 09:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793377681; cv=none;
 d=google.com; s=arc-20260327;
 b=cjk9C1pUoAs0NznH/bmDJL8XFz68I0UypB63GaV3y+R3VSKKKpkeZmiO5D3jydTZW7
 oiiROArVhilKlxKYqsMOnpcMdNh/F3laJoxu7zvfmSygC6XWsARA01ArTTwJ+xLrjLkv
 0fuAuTnzczu9WYnvpY+1NwQw/xuR0MLYrhG7f58pEB0EOj+HmJQIfIc8ZlWMCaAruNvy
 RvgnZaq4zYu16cFRu8XuwbA4+3WE7CiCNhNMkcDvP18fIz/hLgCUfYGRSlfGeDz1H0TS
 yAMnLTN0872o0ypLd4/ErlHZ2e1+m4AxkbKxNGlT+qBX0ugZNeyu/lAzqJJAT1zqVFYC
 cxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=POkNZy+RXRrFTgKPTYxztw44SeZP1JTpkaZndfi7BfU=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=E1MXHldOJzssQ4RoMDpQCB6zqxrNrtbzcYHReyfbQ/mBvZihzOY95On41rJoU96d2F
 sXv/UOSp6ga4eCbH1lUJIMRtIfTx4W7JLx91RiGTJPoOehi/k6NQqyc+ran3F+vgske2
 JTMg23CNXa5q8j/9aCnwggUM2HUxL7fdeAg7JVtOYn9yqC6hV8CEyNCri9W7W0IIBtzQ
 TgpXrzUUjkgDUawcNSxuN7XVonRXTiBlACHdU76DEOZdDDUTi/XY8nFV23vzx/lm5BY0
 R0lFHFZwaGTmdKUBuMGQUXOrCosegxZMcDc7iAHzWTVCGi+RTWF34t+Y4h4vt/c8pFrY
 4+BQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793377681; x=1793982481; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=POkNZy+RXRrFTgKPTYxztw44SeZP1JTpkaZndfi7BfU=;
 b=CNGLQOPQoxV1JOJpR2SxoH4R6iPhqIqvYy0UYI4sniFMfGYdQI/X+c0AzoBnQFYFNu
 H15j8ZsOpcGnAzaa/5+UbLe/ossl4SBRkxkKlqTPCRjoBRbRYuy4WwEKUeCwfzEjSxkI
 tM2qOgx9EakA+UWwe+bYhjQ+zs9cRzW8+jiW/f8ZvOu3MI1IOwH79aSKwi8J4TWmNcAI
 CU5EwazJ5nx94FC5Sl4s0L3/2RKwRCWY7ZLctVYFFY9RUzM/hYS92fUkgxTplWTlTAE/
 19noZBXSTPXjvCPbb/dEd/LcYb9OGyx0N3mvfqzxbmSNl6/gvgNFvdGhul0tBPZVG7qZ
 Lkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377681; x=1793982481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=POkNZy+RXRrFTgKPTYxztw44SeZP1JTpkaZndfi7BfU=;
 b=InhhvfpkA5fZmPjIPJ9w34mRfVClSnLgXYHI59XjVwd9DuL751l5Ce0unSdonuUm0o
 VQmnWdvLGdt+T8ldzmbA5qOj+08mTU6Eb9ps7/fhfA1LSN4MfFExCyf7Jb9KYE+9+Rip
 /BPnthVG5HObhO8qOfOb6srl86tdDZuvlOZJ5ASw3npFAmVm0txbm5Ik/HH3umLfLy1U
 IXOilF+6CFHHRMBAHoxbZb9FC/tY8zt0uE/LvNWHf+diAcNvI4M//700F8o0dcp3c2st
 BDcy8vDvRBIeX1YIALkY+rG1gAlKq5yAijIh+Pf308GY9n1CO7rGUeQxRWD3v2HurvPA
 AdMg==
X-Gm-Message-State: AFq9FYIIdOmYQEQUkCznSsyJVXXZ2pLfYx27aaPrGRxzHoe5Rvaz7kiy
 MxDSkYv5E+nJ7zUMLhKqhzQqL6edGV8K2oWH5+UTbZPQUY7LII+03FnPTObPSi/iQGXFVaSDxls
 PQ1Mxhjy4tB0bM4LxoOTEIQY6/wenUXlRbyC6SVyEuMnln5gx/PrdgXcDwzyIcC+whvOeVyG/zD
 Rz6vjsCG6ssrSqi3yImbnQm54gr6Ff1Jp2
X-Gm-Gg: AYBFou3Y+Yihjq3ea+45y+GuRDBjyDdvWuqJmNDt+J+v6cOMpNQeIVfMcBCob3LhMSE
 qbvnjlVQ9zZxXivaFvgOBR+YB6Gb9yVLdRXhLbD5Vk7HOroKXILuZH5a7+aSehJMonZdWFnKW0D
 By6Nb0Vzh1Hq5btkEdWkNmOZrjI9tp29j6FdYmsdXI4r0LRICWfshljtgzR2ILUkHO5S9dPl1s6
 kXw1Tj4coInR2yHzHk=
X-Received: by 2002:a05:6808:6f87:b0:55c:859:adc with SMTP id
 5614622812f47-5640def4593mr1954912b6e.55.1793377681337; 
 Fri, 30 Oct 2026 09:28:01 -0700 (PDT)
X-Received: by 2002:a05:6808:6f87:b0:55c:859:adc with SMTP id
 5614622812f47-5640def4593mr1954895b6e.55.1793377680791; Fri, 30 Oct 2026
 09:28:00 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030034928.2135408-1-brian.cain@oss.qualcomm.com>
 <20261030034928.2135408-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261030034928.2135408-3-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 11:27:49 -0500
X-Gm-Features: AclHuK9Uis23VvdC2tZPqz1YQAL_30LyvFc2KP7yoAdwhuiQhJrUgHP2T-TjY1U
Message-ID: <CAJ+KCYNXqw2ucaJp4nzytfbo+0e2mkQ6TyKoXHs+pZJy+j7MpQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/hexagon: add v79 HVX FP8 instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 0wNNdQPJPDsB26susXbL5PhW748IXl-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2NSBTYWx0ZWRfXzIVShXrSAHtg
 cbpWoT57BXWmhbORDi1Velf630ZZdQ8hSAauh5GY4Yd8KRB4TPxX7IXdMoADLiyY3CesTWP8XNF
 +sfi/7rMVFtXvsizU8zhLMbeCQLdZZvngcoKswNOS0vpifck/AmQGUADmZ9a6TkJB5OMm2qCcLc
 7AQxgvhSt0myTX5Dh490xGLcu1m51VjE0rMVx4ex/504awtLstfgkmYaftNbMIHBEM5i3QqS84W
 9U6wrG0nNyQmAzTebH6wW0bnu6DUyUq3xyA/4Tditz2dkObZoS+9vb10dEOlre1AnZTkVqM7/Wz
 Pd6G7IWsttUqYVposASe0Fh9epkXLKFrhL3e9KtuRWnP+6MZxyigapRX8waTjhDGDOohAiRtTlo
 2p6/P4+gG9xW1fNqFMDaf18m//BEgD0LfM0aj/I/m+hM5UAqRdXpETwrXTA1IfA/8Jp+lvxM2vt
 L42lwZFw54oq85vN9nw==
X-Proofpoint-ORIG-GUID: 0wNNdQPJPDsB26susXbL5PhW748IXl-Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2NSBTYWx0ZWRfXwn6iPF6GQXjA
 wOeOP1Xh/HpE4ejRJW6bBx0cus8y8WnwvCetUFDuTSEnCdO/sy6WGc91aONNAQKqKKnVDimgi9I
 yO7C4pOyXtVsIgnF+Cr1F8hhfYsMTkM=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae4c592 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=T7xJW_fcNYO1eY9vRTUA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300065
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 10:49=E2=80=AFPM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Add the E4M3FNUZ FP8 add, sub, mpy, convert, neg, abs, min and max
> instructions, and the USR.FPSAT bit that controls saturation.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/hvx_ieee_fp.h           |  27 ++
>  target/hexagon/mmvec/mmvec.h                 |   1 +
>  target/hexagon/attribs_def.h.inc             |   1 +
>  target/hexagon/reg_fields_def.h.inc          |   1 +
>  target/hexagon/genptr.c                      |   7 +-
>  target/hexagon/mmvec/hvx_ieee_fp.c           | 125 ++++++-
>  tests/tcg/hexagon/check_rev_gating.c         |  18 +
>  tests/tcg/hexagon/fp_hvx_v79.c               | 361 ++++++++++++++++++-
>  target/hexagon/tag_rev_info.c.inc            |  12 +
>  target/hexagon/imported/mmvec/encode_ext.def |  12 +
>  target/hexagon/imported/mmvec/ext.idef       |  78 ++++
>  11 files changed, 623 insertions(+), 20 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com

