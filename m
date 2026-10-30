Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D9606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 00:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a2up8ObH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cG3EgTb7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMasR-0000Qe-MK; Thu, 29 Oct 2026 20:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMasQ-0000QK-Fk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:53:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMasO-00057j-Qg
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 20:53:50 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNLK4h2154207
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ITxEj1nLlTQBsUhOdRss/gQD3pr2J3Wev3Vt67s14i4=; b=a2up8ObH+JUpSgyN
 ER2P8Gsc008v0IYjdlJbc5ZNbZhDsrTxvskPOjCHMqaDuhTQi4DBif2pOdhtwbnZ
 YNmWnIGr1L508yP9nPnMTeC4UWXyc2C6Djm1nnuhB0Ay+8diEXXRRD9tciflPP89
 ZPm0IHDAZOwGzZCz90gm9hbRRm6H3rK6BsOVHYPj8mYZq2tORQa2xTdUqDZWmCjV
 Mapx+hhKHg//awg1IM/Hv6uRsCh4no7bwINgLqLK/eLjdaT3fd/Ew5g7A7HGymal
 1/gmThFx2DwsK7mskebOUI+1l8gsm05nm/vzKIX1wc8SIN+ItuiUN+9AuV0Nrx1M
 WkI+SQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qrh9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 00:53:46 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4f2040e10d8so139931b6e.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793321626; cv=none;
 d=google.com; s=arc-20260327;
 b=f/URgCIBI/e0ZMHVKeq8KU3UyF5pAT+37sHjuqnvPqn/Q8byufP0/Cxnd8cvBH5/XD
 XHq+Y4nmrkBKi6hcrYzLFOjkLQtbbJDcjbKNXyuBTLnygQHQw00BFtlq4GPL7WifdB2a
 6uGoEmG8xWDvV2V3S2r79K/fxbWWAjz5nbbDjCdA/eRxqHke/x2S3SAXfG+ESq44L/Yl
 lpW23kbxa7mBeKOonUznQ+G6Wktg0CjxyC5TR2JJ3XSg/lS1rXWG2e/P2PqmdxK1npu5
 P2Syd2SVmE3wporWtyRXj+nv5h50noA9yvQzwe3hzrg6+ZtbbCjNcVdBiVvK6avCvZEE
 jN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ITxEj1nLlTQBsUhOdRss/gQD3pr2J3Wev3Vt67s14i4=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=qW3JpHGUjSz1EmqSzgsszW6cdTbOhyzygZXbkVREYNNoyFjZajhXzDc5bEFtjbD20F
 ikQPt2Y1eVrmlY/Jii7aestileLsg6CZSUOzH2qeqKSC8wVZI49z5GUQlqSx1z6pAqyq
 8vUxKQ81Z4nV0yCn1wNLG9GddVqmi70g8OEz2dwW1Z5tTr2PQfxzVVBOHiLd/RIBpsZz
 a4jhYp3FjkQieHGf/YzVTi6crDXKIx8DrJg8R7NI8F44Hs7nfKXHqpl7ueu1cME1y04q
 cbJAkr+4bN3PNevmhPMfSnFJ7m5YKw4OgMep5/B5UIxxnB+BHl8gGo/eN8lxAoQdYJdl
 Ez0Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793321626; x=1793926426; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ITxEj1nLlTQBsUhOdRss/gQD3pr2J3Wev3Vt67s14i4=;
 b=cG3EgTb76uQcfa13hfjWcB2JKhcEi9VnYUJNcmkf5voGq+JfXj6i+fyPdKWdZhhB2c
 NnlEggyvFOKPe2cw3g7JOEaqzMKpR2H70XCQy7uxedGlm+DQICc+MpmZg50zx6G7q8e3
 uzcx5hfXOvMcwhwY02TXs2t09r/NZb+Jrgr+uLnQryXngrE+oD7dA0KfH/+KS6x7An+N
 JruT6i0VWb0rJ+dysYtvaTEdgyO9Ir9yfddTQophw1qKmpvMaAWlaOudi/U9YYiWOp/d
 qcSOqUbKZCU1MAN/EG7mtdVnn9VKYmXuC7p7AlZQZObvoDg1kgn4QYQgEM6AkbEnYQBS
 mwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793321626; x=1793926426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ITxEj1nLlTQBsUhOdRss/gQD3pr2J3Wev3Vt67s14i4=;
 b=kph/bhhwlfDuThAyv5OKrDudeM0o2eLi+OdXM+sXyYm5cXkEJHcUbHhGmjBjlNOomp
 N8smwr9EuFqir+Wn1sc8HuKOApB7ty7JSBlE/nXefXcLLrdfOVkN9yUYwwBPl4dyAOjC
 TuaYVLzAhTixE78SL1obcsOfSSGDL6Byp/QvG/w0JM/+YX5DickT2mmQ6l16TblgBdyh
 OuzG1Unsj1J/ItJD9Ce0cxPY+wZh6xGMNA9M1fOLQpEjfa1YCasCHmFDVuHnIefV+nVh
 AhSubZM37ubnoHHFAFsyeRYuePEsgWeCKkY17sX56OtQiGQ1PjyXm9+5TGoZTabcdlQR
 yunw==
X-Gm-Message-State: AFq9FYKHv2oizlzbnetnRkFwMTtOi0Jmas54/8dBRxqUed3FmgK1tSGQ
 tb8cm0IgEJkUTeX3qvcYguyQKZjZoG1IpNzXmz+fGalS+SdJeuK2UEmREM+PBhSe32YtfZlBo6P
 x3fN+9He9OULOiZVDYmd8ASjg7C4Xsmbdc2xIKVC2EIEnAKXC3ljUkUmjfIBZkieJnrJ3jggGkC
 ci38oqpbMvDXH7CH+17eqOkjh+Je4Omedf
X-Gm-Gg: AYBFou3rvbDbICHgyFSU98nIhSQGoUGkEpewJTiX6RAM26hqHtGZYzdarpmWa3dcoAh
 nw0cIwGRvTbw72Ve/+y10/+iibnsQsLdTMM4b51ZUlUVAk0g4TtfY+tIpFz7OmTxhr6RLoHArkS
 8ePLztaKUBpcxSivWbCigXqq/bNK4CL39Hj5Rtbhf6mdyJuBLsobBM+1N8TFUI1J+fgMZgGodbZ
 yNkdcQetE1XOmKEotg=
X-Received: by 2002:a05:6808:181f:b0:4d6:90f3:74ad with SMTP id
 5614622812f47-5640de1db36mr630155b6e.45.1793321625663; 
 Thu, 29 Oct 2026 17:53:45 -0700 (PDT)
X-Received: by 2002:a05:6808:181f:b0:4d6:90f3:74ad with SMTP id
 5614622812f47-5640de1db36mr630145b6e.45.1793321625178; Thu, 29 Oct 2026
 17:53:45 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-3-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 19:53:33 -0500
X-Gm-Features: AclHuK-QMLkKP2HRsiw1XTo18R9k76LZsX40SeIQ1BNXZB9xbpbAIcsBTlcHYkM
Message-ID: <CAJ+KCYMFGtfn9pgQircHK1R41-GvazXyNp9xkwvd_HMjeugFUA@mail.gmail.com>
Subject: Re: [PATCH 2/8] hw/hexagon: add the HMX context device
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WkQfz6yMk9-0lVbYP_tjt41eidS9LAsM
X-Proofpoint-ORIG-GUID: WkQfz6yMk9-0lVbYP_tjt41eidS9LAsM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwMyBTYWx0ZWRfXy3UrfKofdGFO
 U5Z6J7b6H0+/g9WoBTHUjREPh82BuoUZYGPNZ0PatMRtv4hOsNOIE1jBk++oRrwN6K1HpIPIcI6
 MvHJlU0rrCqLOPH1cC2ah/nQfYXVm0LalpgxTPxDC6jd4v2UCrgSuVpGcx12kDk6Yx6gtOkzGfm
 DpZVDQaL5fxvdtHsHBi4rge1dOaHTxfTpS1lkCgskSE7a1NeuEb5RQTGMApI7QmXWZ3ud5mPiEU
 8e4b99enZMwJMWMxldbzuf5HMrsfzhaKji+Rc/U6zPO6iBkFGuArusvn4c3zm3BRRwYPLxib8c9
 AdfCPPlW9Tx/Fon/Vuk4hiBta9Xd/+v5agWdzRRFQhaUag2Anv2wcXHV1OusGWWRCTygCjfdryi
 Fii0T/IN2sQETZzE8/0UhgrMfGw3Wge35wnwFIg7RXJwREBy716HFogmaXB4QvrzLlAbHEjlY2Y
 D+FjH/TiuS/ALhbElGw==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae3ea9a cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=UfFlBaG_IQf0mCqESwMA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwMyBTYWx0ZWRfX2LpM9wDfXkJv
 2edWi/BcgBeihN9f1U6q12PWnOIumSeXuOmAVFjm6AwZByFPNWKScXOFrcg/V9eJj8t6flOJsNG
 HFXO1Af9MMTuIQkLGpVE2DJ7QQ4BGLk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300003
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On Thu, Oct 29, 2026 at 6:03=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Add a sysbus device that owns the HMX state.  A core has one HMX unit
> shared by all its threads.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h             |  5 +++
>  include/hw/hexagon/hexagon_hmx_context.h | 24 ++++++++++++++
>  hw/hexagon/hex-subsys.c                  | 16 ++++++++++
>  hw/hexagon/hexagon_hmx_context.c         | 40 ++++++++++++++++++++++++
>  hw/hexagon/meson.build                   |  1 +
>  5 files changed, 86 insertions(+)
>  create mode 100644 include/hw/hexagon/hexagon_hmx_context.h
>  create mode 100644 hw/hexagon/hexagon_hmx_context.c
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

