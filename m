Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ig1MoscI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UHXn7cYd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqiM-0001JT-6v; Fri, 30 Oct 2026 13:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMqhx-0001HZ-3p
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:48:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMqhv-0007NI-Fa
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:48:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERGkx2495218
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 he3DBMm8ok0IWRi0d6IpNl6DTtZRsRqw+DHt8JPc/QY=; b=ig1MoscIb+MdCQ9C
 dm4hcwgt/K3ZvV9mvxfS3nKOl9uHYJsmL/oxxKRy0Ci7gaGNDLBpEW3Qa5I9TdLx
 3MSEw4b0p2kpKN20lOeQvPqGF3L9jGkzaRbPe85gfezw0FMVJ/5jBFECNxTWnnRt
 KlWcYefphB3vhJnTTJDCXS8VpDQk867p3/9nwpKRMSsPbhOFUpZbccMsEXCH3DqC
 GayGP2G5jsg2oYO7+vGckSoaR8OJAvAZNlOkEczIZHddFIZ5WUTyliBh86og64Zt
 LPJkz9hcXlo6EnIn0DoI61dpq4x0UgvCim2K3CRJ9qh5VfdrJQMv45RaWth/Ymnf
 OyLr9g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p4b1b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:48:01 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4cc89e86e9eso1218477b6e.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793382481; cv=none;
 d=google.com; s=arc-20260327;
 b=Ql75ugInK8e6P0+j4V1P5duX+dxj85jYOdqV7MAtU+CdEz5TZ8R+Q2RXZgKVnhyuZO
 GkNpAKOxCFWsDrCJX/LjkuVaSMbpydL0oMPAPH+qgMM+QqBcor8KHlj8ixciyslFvFzA
 ORyktZb6PKsHOqYM4lZJjGmfDcjGO1lf38TNDW+GZ2yAMYGbA2hKuYSDAl/0dw2D/18Y
 NYOsUepqZQigKg92xN+3rwRn4pPBOIjK7e4giLqlM7kFhGC+NTPW3krZGbOF/7hVsuV2
 hn9ndlMdqLC6NoiC7f7PtHq8fmQ+VveSyZ+bL6A2kfLzbvK792NEzWBDBoNp/+nEKyVc
 60Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=he3DBMm8ok0IWRi0d6IpNl6DTtZRsRqw+DHt8JPc/QY=;
 fh=Xy6+9SnBPIbeeLHzdlckXW1U1F26D2M8s7PO8hcj5vE=;
 b=jwnC9Fep7gEcUhKJhY6OE2wCzwlvYxoqPeS33x7b8VWMpsHGW+ywuMs/nYBVrXHyNj
 gSm4XBtl+oNbwW/hBX4sglw03X/bVe+BCvlaArLaipliBmRHhK3i3uRC4Bm5TlCLs5b5
 6Px702h25qdE3DIVMA5ad27lbcWLT84uMfqt+/sZkWWerRIaBXtl/Onc2w8VDjW10T9u
 bFM8rsdSspaPdHoimeJcKCbrHdGpViczL1syJXBpQMvi5cRRM4t5OrnxDk90YN4InPlc
 gPY8MAy6nBiLwRzyOE7pIjfFp2ett1GI3lHT9oxGdlHZRmFznMug3VYL1Huwr39PTmpO
 YT8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382481; x=1793987281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=he3DBMm8ok0IWRi0d6IpNl6DTtZRsRqw+DHt8JPc/QY=;
 b=UHXn7cYdPwEiZG7ugaFlMRXOLyOn8s0yLsVSJRXz07QmmhvNDFJCbdrmPDtezmv3HR
 GlGBBp6J0FhzuGkD64Q4O+UWP6NUobdG8TLKBcOUZgvXNDhgKSFj3XNXwYj+0c7m4TWI
 1fBSJFBSVyN4pzxyKPsR8jtr1IwCEyQo1+QUj6wH03I9Y2N2NldoogqHgvMXXwDCkdx2
 GN4vt+9mMwJ4BtBLplRbjonpm0FOoyppb6KNLC0Y94lRRhndiMnRFNe4BlkQp0qn8lso
 1ySTQhGFlMhBO/y7AwInqmq+D/phWjLTcv1oO7VyeW/H5Z9oL95OENexIugJcJj7ryo3
 48Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382481; x=1793987281;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=he3DBMm8ok0IWRi0d6IpNl6DTtZRsRqw+DHt8JPc/QY=;
 b=EXEDD0vOavZ7cVTOIwPcG24d8wrhlVeaqxyDGzTzSm00CMO24espoi3w0LYMJ0Y0Ig
 Wjt5ufOQ/OiOdJyQSp7r9lMcoRtdMIhtTfqlg5ZZNnzqfSUm0zuHYdy9k4VC7k8vZNK6
 v+b0/0jxfHW5XJhPCycOpRQNBBKOdpkUzov9uJwUejV0fKENs/dXMMjMOSQnq6C5p/q1
 nzFtEzkb819eMHh6/+DPQZjJ39zj/RMElpa6ALF9xGrl0doChy0TBFvUG1TvwFzEWQ5Z
 caMfxdqQA8HVHTd3udog0pWGichLzEF4l5XJDxTCcQmLYI0IQUUnEAxEqCeCTzObJCdQ
 YJKA==
X-Gm-Message-State: AFq9FYIkLN4bIoVyTfVBOovPoJ91kS/kCjvJvvboP5A91m3XbNIn6ERb
 u4Ns2M4b8gP7rnB4QEgLZ4SqSVwwuOKJBtWhoPmFpfMSJC2RTEy2QZPzwYTm/6DatKNZsqCSRHf
 hkw0qA0BoIMc6fdXbTTI+6+DaUyfGxPln1xmi0pEy1DaX5wmgn8EwnrK3jpFLMKqJfdHH3/u8RA
 uA5niNb+iZi1H9xBB9NnBIPwiwBKygtp/2
X-Gm-Gg: AYBFou3f7nWCAPh9idFvl3ifhcw6S2s5tESrRcO+OZOel0dfHR+DuNoJM5iI0oTp+Bk
 /OGDENGQX+aSdjXDBa8qNbs73HMKpSUyvwUHOwOP+srxEjuUfxCM01e/0hGNSA6icBzTy03U5Cu
 R7avAvH1b4SvcIpKD9DeXisOsfca2HxpKAF8SO/7E4PVQRCfT3bOcPofcL3+OmGWuGa2gwtq85I
 HZYgqqZdIyfp0W538g=
X-Received: by 2002:a05:6808:1b06:b0:4f8:4a95:9969 with SMTP id
 5614622812f47-5640ddb2dc9mr2140136b6e.15.1793382480828; 
 Fri, 30 Oct 2026 10:48:00 -0700 (PDT)
X-Received: by 2002:a05:6808:1b06:b0:4f8:4a95:9969 with SMTP id
 5614622812f47-5640ddb2dc9mr2140014b6e.15.1793382476773; Fri, 30 Oct 2026
 10:47:56 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030024110.1986536-1-brian.cain@oss.qualcomm.com>
 <20261030024110.1986536-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261030024110.1986536-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:47:45 -0500
X-Gm-Features: AclHuK8UIqy_WB4rjxI5SvwtuFRZsCkcPk2GSyWFwXWgKlCcrM75op8x-l0N_Ls
Message-ID: <CAJ+KCYMZ2m7W8_xvOvA=uwUSt7AvaaSgD5Ngc-PF+ZWJFbWDEA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] target/hexagon: implement mxclracc
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfXwqZdHpMNEe3X
 K+v8ij+GbZueuKrtrG7ZQSxGOUDjXD1eAKbL97/kk9E1e8TfXGN5KYzQJNkg5cRgg/muYBbH2mE
 yIWatZQ47XaDgwxRVcc3MwVYzrcIgqEV5dkGi0GvWn6tGciuv//8VQ5vW00AwmuMlNNGvmsdwJX
 d2Ij5PAgJmja4duYklV1NPRYnNbF5qsaiffWIBnqcTMKO6/I2r9rW+Y8EV8LVVh6S+lcY4+AK7W
 WoYWM8PREjSpcVQDXnTfK2R55sbWaJ/kNqTLAozM5PYrb4Mnunz5ET7sgmgRBlPVcw+uf4J3yBT
 Y6wUATGCf1XuCpLub63rUh+eSesyoBxlFZM21cNS8KoMMKtX+w1058ywPBvLupFSaXm0QXNEZ/D
 QKBIhz9fmZm/sAgWdQ6g8SdR/FpPBEh735f85y66XD4bEtSxzmOCcrO8/IaLtODa8u6ur2/uO6t
 b53szz6FwXBVo5q95PQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MCBTYWx0ZWRfX6VTZsj8ixrCS
 BblMUBMYX42dyD4nYGmXhPRCM269jWsoiC4BNkzhMikNbY2xOGB3d4Pl78DyAjh6Y6Wjvk0kLh4
 ppkcIh4xn54OoroiH5I9XtALgddO+4E=
X-Proofpoint-ORIG-GUID: PYFyb4M0eKXL9dQlBcumC3IDfXQWy54U
X-Proofpoint-GUID: PYFyb4M0eKXL9dQlBcumC3IDfXQWy54U
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4d851 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=vgQPtmQrSs8_Jl8J1gIA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300070
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

On Thu, Oct 29, 2026 at 9:41=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Implement an HMX accumulator clear instruction - mxclracc.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hmx.h            | 13 +++++++++++++
>  target/hexagon/helper.h                 |  2 ++
>  target/hexagon/genptr.c                 |  1 +
>  target/hexagon/op_helper.c              | 10 ++++++++++
>  target/hexagon/translate.c              |  3 ++-
>  target/hexagon/gen_idef_parser_funcs.py |  6 ++++++
>  target/hexagon/hex_common.py            |  2 ++
>  target/hexagon/meson.build              | 17 +++++++++--------
>  8 files changed, 45 insertions(+), 9 deletions(-)
>  create mode 100644 target/hexagon/gen_tcg_hmx.h
>
> +void HELPER(mxclracc)(CPUHexagonState *env)
> +{
> +    HmxState *hmx =3D env->hmx_state;
> +    int i;
> +
> +    for (i =3D 0; i < HMX_NUM_ACC_SETS; i++) {
> +        memset(&hmx->acc[i].fxp_primary, 0, sizeof(hmx->acc[i].fxp_prima=
ry));
> +    }
> +}

The helper clears live state before packet commit. A store fault in the sam=
e
packet can leave the accumulators cleared without a commit.

It also dereferences hmx_state without checking that an HMX context exists.
env->hmx_state can be NULL here, because gen_start_packet() only checks
XE2.

