Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2B1606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D0TecW/y;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TL+P+in0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMbV4-0001Sm-9O; Thu, 29 Oct 2026 21:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbV0-0001Se-Uk
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:33:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xMbUz-0008Sk-Gu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 21:33:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TNKKca2586099
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vd89vHclIETA3vcViu05nDKlgu0GJNlBXcamOvodw04=; b=D0TecW/ySUgMuZeF
 5KT3aMA2c04jAm/caPC8Pin989NGMfbe3JXUe0i+qkZ4swwPOgC/QziL8mWOXTpX
 ibdDzrAmv6197ZKZmojmXdYFS3e5WZCYAWRauy+32fYVVZkBkgcUqsOY+VlpmOUd
 nZXZPtnPNCxmW/i93T7X8hRxeMXN0OQFrFgYOjqIKoYHqiOJJUqPD2RVygN1Zm23
 jV/2it9g0LTDv5Y/fIsEiGM7FKXXSaUlLx2O2wbW+ph6ldPVOdlKCUUbyycs/DEm
 +LDRcGn1yte6BMi4n/MebpCbSqKme30+Q7YaR8TYwddDLfgNuhY8aQI3dQnRZPmb
 OOif8Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme750m71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:33:39 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4f4612a1a5cso1672346b6e.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 18:33:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793324019; cv=none;
 d=google.com; s=arc-20260327;
 b=JLvgcWEyjz1ej+vRRHy+H9xGv1D7UeQ9Lh2LigqPCV5YwL1ZcmnYIH6D+aetJXs198
 6/w1gyAcDUovB7F4hdANbn7aMfqbjOx3pNPwpLBUFx7/lslTEak91pMSvE3SR9XiQ+wA
 XuKSjfzTtcCJpzvdgTK/1PHWs/0mVnz+x/niEmhAK1x8QPKKVkpgHvOCK3bjof+mPh1f
 /L90PnP80tTGUVei6tHQcu5BgJRsh4BA1cCikqX6oqSzXazNzuHzv/dz0gN3O338t3aD
 TBnfnMmEpVLwQf6HCxn/7LFmhKGl2SuHyzWRLEvNPk0NbE46eY5zbfpLcHoKXMlxhzZ+
 uXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vd89vHclIETA3vcViu05nDKlgu0GJNlBXcamOvodw04=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=LCcQZzDy0WaLNwf7GYJyrrbVU/0uIcJ6ltmTY38tSu1mLahWqPpqwwa826mhHJQSq9
 AHWoDHxhGIGad483PNT2fgqY9JX4G2D1BwKtnmPh8wOmu46RbPhXv61jsf7+cFw+C2OJ
 0ZoxIAVSLAf/zCPIvIo/q2jlbMGuZrGOZt5acFYhtmP3Da76q1UrHmEMyfwznonNuKfJ
 e6r8edNGVsQsGOUXmj2iv5IptZXa9aPnHtrfwlO0m1/jBT3BLwmC1sNFwDViALyci4Kj
 cknROUgrzeExH4kAiYlGtdUSN7+Y2GKMBekzdanvmYLQwqmoim0ApdlSpUrJJexA0f24
 KhSA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793324019; x=1793928819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vd89vHclIETA3vcViu05nDKlgu0GJNlBXcamOvodw04=;
 b=TL+P+in0PjiTIVBJYfmQcCjq3dTcStvGCzRWGoS9orFQfAyOk+jPydOU1Y1pH/UuqK
 BBSolmqtYj87nISa59zrFQ7J1pnKj3oIg9YSK/9jrzRAXXQYBQw5I4v4Wb/9SaXPlxXa
 cbC/qgwEm4kiplgfvLoosfa2zYE2DMcEKmfm+Fzc7vSDmIt/p4fk+/7zsSwANL/4+2QL
 Ftn1hcKI0iLeyaLJXh4/prAgKCLOCdH8wyanCKMPoA+kka46WEb9aoter9TtzB9Vwqpc
 I4DxKXjGx/MuIdD+/1YcCL1tbP3oEagIvaH3RFS0XdFr5t086t8R0Iu5M54drkiiVBPS
 MDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793324019; x=1793928819;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vd89vHclIETA3vcViu05nDKlgu0GJNlBXcamOvodw04=;
 b=ha2q67zhzj5O7Ubfmg38c5OLhFoLNfQnFW/rmr6fhAfEIv1FZT/al4S4Yf59/HpDu0
 PGm921sYa2UhoavLtfmUGm3u4XuQj7X3rIp8WyHieTJGmj+0vXcfE3mowhOMxZH4ZTBt
 9eHO3PMlDNWJX0u5tXDEde0pW1klqj7zbgYxNS9xQ4WlYpJ5q3/xg6imGicukpWb5Het
 LPnoON/sptcJ1XbnYIyAIfB47c9wjT/RWczeM3HB1D6z8xFQIE1uoSrpGKFKUDMt2wmZ
 u9ZSoBi/hmNxKL0CMnClfkGQkcSJu5EAB0jao2IJ1q97cJGY+ZOGRddx/ze6AxjMBLyr
 4A4A==
X-Gm-Message-State: AFq9FYLwFRXzOXqJAylWyjYwGrXx6mSeRFuSR/1piwUyyHsNUzpZVFEt
 RFSxz7jA5XeiEUOBYFNZn74CDNlyXqqtls572M2wPfHPlvQLjRYnlnoLjoZsajBJd2NdzUERlcL
 8OHKs+hj4NFlzpWg7LSSt5JjYaAquDNXxTeUD0lNxkwkKN9zSAyl5nl8ryEWCgMCzSX5BuRgul+
 Qu/TFXVhTUZ+x9n0e40r84A3ty0GyMVFlaLqQVUKWc5s0=
X-Gm-Gg: AYBFou1ahEW2Xl/lmI72ov/ZHyoEXmlei29TI1368PjQ6mN8jIvQ8wGkN+gbaZ0Z+ty
 OqTnzoiJdOvTC+i1MBFFZPtc1GD2fi4KicC5l/NSDmzJgCH2RK/Kh6friEIZIbIWo6iSVF+TYiK
 CMwsJpWVUC9s1dCHPkjHNdBABPUEuTs4QxXRRqLPhXQWpSprdlCz8Mop1vPiqD0XbAhtJ5e9GKu
 OAXXNUQRcE3y3PWMoQ=
X-Received: by 2002:a05:6808:bca:b0:4b8:4703:db97 with SMTP id
 5614622812f47-563efb4d666mr2404693b6e.32.1793324018874; 
 Thu, 29 Oct 2026 18:33:38 -0700 (PDT)
X-Received: by 2002:a05:6808:bca:b0:4b8:4703:db97 with SMTP id
 5614622812f47-563efb4d666mr2404680b6e.32.1793324018224; Thu, 29 Oct 2026
 18:33:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029230310.1632334-1-brian.cain@oss.qualcomm.com>
 <20261029230310.1632334-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029230310.1632334-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 20:33:26 -0500
X-Gm-Features: AclHuK99pUAWv1MtSYyZUbwAswE-OcrMtXrtZSP1kP-EDJSYItLH5FGnn2pBSqU
Message-ID: <CAJ+KCYPnuZ6AsVzqtJDOHMbVnk5LtKxgHWLPee_-xsZYHcdujQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] target/hexagon: gate HMX exec on SSR:XE2
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: OXr887tRyCKG8bq2iAvtEZjxvSN5tAdZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAwNSBTYWx0ZWRfX6pytEJ4niiQF
 0ywRDGs7K0OrSQmavyaJH4MJYfeBpZ3EVI7TwApqqyS8UkU/3miPLHKC1ZNeIhBJtdqLuOhCHyf
 G057f4DidT6+/WlGSwVSsrAm9N8InuDRF+gNS7zdmK41it0cnywLbSL8FujVT3hJmEjn6ncNZfO
 YwlDszPiHlym5TXy3qeb7gyvmT9imQmFGCkhkKz8vW+8uVcQbD8eXvfChBg0NLehnuIgy0CLYTx
 wHXw/OiF4jJ+/HI4xppth/DI9EKXdb/2Ho/nH+BWMWOL98PRZxM+iep+boDNgMnWs6QGbzIRKg+
 /1xhnVCvYI7PbRgSv/a8R1yRqEEumi+oXS7AsiJ/PIN5EB0jkm5gq7/BSVzfam3NOwt4RTX+ep3
 WEokaRm3W3zTPfKxuyLr2y/QqwDVfgTwXQLckHqsRn9Vc/fcwx5sDU++hQrStWqnHPIq84NsXpp
 vU8Cq6SBrfZtPjir3sA==
X-Proofpoint-ORIG-GUID: OXr887tRyCKG8bq2iAvtEZjxvSN5tAdZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAwNSBTYWx0ZWRfX3u+lBKHvF0jW
 KixzqXbMfX0Hc2BHWw3WvpHHqyVR9cFd6ltMTs7DoIcEcxQ1BnITr2r1xX8roLckhLu7nhUaQMU
 9GUU7H7ZUL7AoXQi22iBWinsMNFvsDU=
X-Authority-Analysis: v=2.4 cv=KdtHIgYD c=1 sm=1 tr=0 ts=6ae3f3f3 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=Kp0rOEhd_mCZagt_z8gA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300005
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> Executing an HMX instruction with SSR:XE2 clear raises a NO_COPROC2_ENABL=
E
> exception.
>
> Log packets one as LOG_UNIMP for now.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h                      |  1 +
>  target/hexagon/insn.h                     |  1 +
>  target/hexagon/translate.h                |  2 ++
>  target/hexagon/cpu.c                      |  2 ++
>  target/hexagon/decode.c                   |  3 +++
>  target/hexagon/translate.c                | 21 +++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  3 +++
>  7 files changed, 33 insertions(+)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

