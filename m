Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE53606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bF8in5pT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N7SSAgux
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZXi-0001cx-M2; Thu, 29 Oct 2026 19:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMZXb-0001c8-4j
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:28:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMZXZ-0006Fx-5b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:28:14 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKSXa1564534
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 viMUgpx6Jw5nzV2K/PmBI9ZNi3yf4bId96RZMnm52kY=; b=bF8in5pTacw7I2cd
 MmWfHynug+5hkbeYd/54zi1xznz/8ofF0mH6MWXmXnaH9TkA5tabtHpGOmM538aw
 c7Gkny9ngYpZUiAioWX/t/HR/AXdCM+F4wZCXVRGpkGeISXiRoHmurAZh67Zuiom
 ArrR5ey7BJKcqn3CjfLTlmfZkrcReUVefrEy8PnVKarsy3meVK/HZg4V3MUTsyLt
 A1Ws/0bbJAieXpffgR2WrE8KqViDpFk9Wa33e1Ek3TdqpQ/gtzRDX1DOo1HEd77M
 UGLNrIbuglLTeApD2+4d0htzoF6gDXHCo+goYDOLa2wqQg0PVEH6GDtIOBq1p1+o
 9Djf6w==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qganp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 23:28:10 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4f4612a1a5cso1583544b6e.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 16:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793316489; cv=none;
 d=google.com; s=arc-20260327;
 b=cXf2fxdTloGwCuwpZjfmuwtPi/xXcpqztaHQxQ+PLnh+TYVEhhOK2QjD2B0FwLdxke
 AT6W2NoXCkda3Zve4DiN/xXEUkEGqyiFXeauGHrEiPe1R5AqZRcnCF1hsESdQ56il4JM
 J+e/ehrLQGnNSpfTwjI80hYUKWyHYX9TzL9NGmp+jRUZQr3c8bBPmlK8oOeuMirXRPIQ
 Nmypq7K0dGLY6u4Jcagqt0xTO8kODPVGfmXtAFgbbohu7S8sNuGPebyiUax1mslLgo98
 eOyNWyBpskD6lNLG+JHbHUze23LueBBJtVLq+uVSRbkXVFOCrCDe3CmXKlGl3AgVA3C+
 LuVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=viMUgpx6Jw5nzV2K/PmBI9ZNi3yf4bId96RZMnm52kY=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=AtXvOtMd/Lx7XLd26GRP8TBvRbtiG3DUbGkhU7decR6P+DaOiobYDQSFcEi4zjFV0h
 NLXLViHcKR2aywNpgpMdJX1v5psiIt2WocdvSTv6RV8fX34XUy3Z4XNmWlbKRlnWCjmn
 OeG7oE6IgIJ3vpQYOoiAqrSMVmZKg1wsk/0VySNth48sipaDimLOPxIHighojDnxreol
 NjPCOrNkGsUAaHXx5wq/UJYQ8Zc1ASuMXDB8c++BcNnAa1D2t+V739CTTIUinHDs8wOx
 MyQCgRiLUxWsGsfsMFDqxTHrUTWxbr06uaqGSVEh18ocjxZiSuWylhS+SPFf07awkdJx
 41+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793316489; x=1793921289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=viMUgpx6Jw5nzV2K/PmBI9ZNi3yf4bId96RZMnm52kY=;
 b=N7SSAguxn3jL8yXTrQrcMwAaL0fMLkXY+DBP5cbYSFCf+RMrkqBw8jrK+A2ofYtlTa
 sTjnWk5Z96hoeLCxLdxjB3g0SsCzFQNR7PY6yKBzMv2UFb806BJmp6Fvpxjqk/EU1Qlb
 WA1EWQDQzzfmIg3YrgOAKpW3dJPYYm7CTTLxY4PVtu6PyPMgOOJjzizCPoD1By3u6CfW
 kcFt43A+KBP24ldpHHbGlMV3a4kBFrE+pLHwajAmSsupmHIVYWbW6+W2jFjCH5Y7gKSC
 3qk08v7T23jGa6yAijAtrlgM2c2Cg5cYcqgM+vZbztZgYoioW61msBVL0mRy+Yz/rZqt
 o+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793316489; x=1793921289;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=viMUgpx6Jw5nzV2K/PmBI9ZNi3yf4bId96RZMnm52kY=;
 b=fr/5n7BvRCgXEZxXMUbagbPwY+9V8xGwh0iz8Zy2iz/Eh3JIDsqUBWzLmnIrq+m3v6
 /CGQvPc3JRSzJOlrnG4IS+ONWOC5IEtTS9dZOL/dLOiBCpDPFegnH7QnjTEMoGrCWB3T
 DGv0FYYSOmsF8AiCJ7QvSrBSTgAT1zgEUcBaiJrRQPkn97tfWlTL7o/1e3Oc0qy08+3m
 RC+4OiUN/UGDS8Ooe3NDTI/YvoD97JHPZ6EW6WlN2uE69Sj07kuXJ9xzcwEut7ACJ7bI
 LIAJ4IfnDnLNMnHtAcsLiu0ml/kBUJWPrOxAlnKBYRfU6pkj7DZv93txpBecWGiEbCu/
 gPmw==
X-Gm-Message-State: AFq9FYIrNN4nwEgCwEoFuKL1PBVzh45ZKMzcQPusuPGsmyy/pM6PRnJe
 98JBABYEUCmX1ZjGV+VsQ0ejrM5PEJjcryTe/CPbWsV5szT5hqsBDSPUbjrhnyJ0cD9vcJ8WqVT
 QlNPPeMh2DxMey12cKydmVVSIliqgi2f+oRaALMS4dVh2iZvlr2SxE7rO/J4bthWy5P/0HmaQxJ
 sb/G7jdk0/0qOKHnOPwRYnSN7FVNQ3VMJ7
X-Gm-Gg: AYBFou1B6nSmKc8p7l4/0vmj2KhZUHyxD/BIdS0dXtRViXBvs3NZpH3Obx5vBhS8gFH
 zce/01aS+C/KmwpP/lCWuReqKR+iN+snpImgsolI3PqlvBF4iV3zi9J4Tg7VoZuHrLKHbwQr7DP
 L5oV6TrjZk0CGuodSyqfhQpjWYrlCLAVEYXrX1RV+VTQEkrKm3eKZ4jQUfG9Lu/M8iPum8aOriG
 LNRH2u96d/dhJ+yuNA=
X-Received: by 2002:a05:6808:518c:b0:55b:e835:67a2 with SMTP id
 5614622812f47-563efb57646mr2409708b6e.34.1793316489460; 
 Thu, 29 Oct 2026 16:28:09 -0700 (PDT)
X-Received: by 2002:a05:6808:518c:b0:55b:e835:67a2 with SMTP id
 5614622812f47-563efb57646mr2409698b6e.34.1793316488978; Thu, 29 Oct 2026
 16:28:08 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-2-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 18:27:58 -0500
X-Gm-Features: AclHuK9KIuATkicZgVHX9MhBuPkZU_ey9HdHBDk-ZhGCZ2g6T0pjcTeON_X2Obg
Message-ID: <CAJ+KCYNKH+ZZ2fg2cwsNcCAqpKRKxhXksONPNvNo7uWra8JMZg@mail.gmail.com>
Subject: Re: [PATCH 1/8] target/hexagon: add HMX attrs, state
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 9X4w5bI9Vi-b1cETHKbjNx80PkicSkfK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA5MiBTYWx0ZWRfXxHF/l5Duyo+W
 7U1BxqzonLaB7axung0I2NJPzKDODdBJL4BLJKKCTWO0U+6eTmQ1idElWPNZ6GEPtN5eYcpGGWY
 qxRh5Q/gsTR9tRN4XclUPhstmP/xQg0=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae3d68a cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: 9X4w5bI9Vi-b1cETHKbjNx80PkicSkfK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA5MiBTYWx0ZWRfX5bGLDX1zbex9
 0Vthqhb0Tw8EQmdtQ8TI9Fu5UlsctVwUc6GB3Fpf2NuaX/I/7j9Z2I8RwgepVxjxhY6HHX2ql40
 9Yf92LGCtUAvkWb3/isVq92TPE5T0Yc8VRTswb18frJIc078r8IvaOCzhkcwTka78pWC3wdo57D
 dzQcpmqNxB0TIet4wBbouDj6f6JE1o3cz4EMX+l7larUQbzBN8hye16fxbLRLgG0rFYb6kn+Z3v
 L9LbpFbO8FxOwWvdICigWzX8OHBLfWyLUDcP/8j+QZLD1jobLlYNvqQOfIDfix+jiq8TEwwIbau
 qct5TSHCEBjFTu0c/KUitLNtQMhYdsxykRndMPSSDxm6ARJyqTsdVA9zc8kkMIVKJr2gEgHiNSr
 kkG175TYvEmPOT1sDvnv4OsXBaJlkWkpGDglFqdEZTg5R0/NQadmMR0SzI6xkOlL4ubk4JVpwUF
 n0BYwElEmU9QdyTuUGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290092
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
> Add inst attributes for HMX and state definition.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hmx_state.h       | 92 ++++++++++++++++++++++++++++++++
>  target/hexagon/attribs_def.h.inc | 13 +++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 target/hexagon/hmx_state.h
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

