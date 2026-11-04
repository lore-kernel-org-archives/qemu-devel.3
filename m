Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A960C29BE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isS1opFv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aXYFbjvP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOj2E-00054p-Cy; Wed, 04 Nov 2026 17:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOj27-0004zk-LJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:00:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xOj1v-0007Vc-6R
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 17:00:28 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4GUgnQ763994
 for <qemu-devel@nongnu.org>; Wed, 4 Nov 2026 22:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s0TnJD+NIHSR/0qsgymbqYrEBKcKk/GbEMmR/6QegYI=; b=isS1opFvMP7gApbV
 lzxON8uny/bT2aIkZN5PQyH8aaSfyG6MFZZMU8pIMCEbIiu+OVac0ffdyNlfqo/V
 sj54Wn4YWxe6cSrZJMQDBeUxeVkPQjZyBS/B7l5P3V98a6Qm7lnEy3l4w7Kg/Ghb
 9wvgURk2x04NPSZpCPQRBPJmNVX5M5pDWscXE0v3+AbePtnWTdiwVawakG9CEczS
 ONeGR8IBrnifxpfDt3RrtwqE3wG/tSb7UBTYrvR4mcdBx8R2+z5N01D699YlcQTr
 2K6bvRi+LfheFUicYmLDdLvu0RPAMmKWelh1qeWNX2AhK6S+t7xw5VCbC4JmRBGC
 S8PZsg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89ssbt0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 22:00:24 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4c467e19391so1836445b6e.3
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2026 14:00:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793829623; cv=none;
 d=google.com; s=arc-20260327;
 b=pFfG+9SobrZdCnnYk45dI/qfgAXGT3d+15nJMENToapeywAc6Xu5hO3ilXJ8eaIAjS
 B75czXmAvZPwR5S1nSkIj5ZTz3GGSWNuYLutkVd0sx54oolqb+sLIAFT9HtaMXXNqpz0
 uNQAfoXOhLqnhuYRiHahSuTZwbiANhobbNWp0YsWdmNtIZ3zDZrY/tmOFJpHI78w8f7O
 BPZNG0qYqwNkKvUJhb+ok2hbsPUAM3nMsXSAKObKlvUCycardQh9ArLzrS2WiLUXp/He
 V4pXsNo5251LrZP96PMfpNF9hchDw4u886XX1LenZSNPaTLTtOllkE/XS+S70JXnzjeD
 YyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s0TnJD+NIHSR/0qsgymbqYrEBKcKk/GbEMmR/6QegYI=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=cyfUuPhuO3rC1Du8dGtkF7VcZ76lZdrz4D1/SwRp5eDciRFEAWx7YU/Hbr1LCSeB8l
 uycOtii6lkm0T4rqb3GvkL5rxZAU0hRcIvDkwyjW4QIwVrn0LETE0BDFrA4uovLxyK52
 TZeNmKyzh2q8kv+3rWZN1QoEvvudSxx9UV4ZX+YCJ0/2aNNlll2UwgINseTmMUFBDUmP
 6Xq+BodOv4oO00fPECXaoZq/asU1UMKFSl10v+QYZ7ib8cqgsC0I+vgVqZLl93y6LRGQ
 ij+NCQWvObh/MQ0up3q2YN3wgAh8ktH3rS9yC6gAzInJz98jCBFY5VZNv0YyhW7rV2U+
 1srQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793829623; x=1794434423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s0TnJD+NIHSR/0qsgymbqYrEBKcKk/GbEMmR/6QegYI=;
 b=aXYFbjvPkY4FEF6+XT+aCkRtF7l1sKouI/UAkOXNVZMtR2iOLNtZra+H/TkGgJRRaG
 RH6xli1tmK0vpbKY3iFiEjzBh/zjiebGeEJXlLw2gqsKG0Ni4ixMven85by3didbNkNw
 pSnunNXKpYTiP140O2vlLgLuCmePhFwnTtpSVP3dxvTNMbmD5J6OHmTC9b8pAr8WXFlx
 GNeAUG3ZSBtkDbJmRJklyXsgioZftWcFBWdcxgf910tc+fIcj3a9HE8qRBaw02IKlZa4
 JfhF19Xc18NqzmU+v0IVvWjeeYra8/cJGhPPhZFJDuS3ni7KRiMYgZkYgjcWsckdlJUh
 PCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793829623; x=1794434423;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s0TnJD+NIHSR/0qsgymbqYrEBKcKk/GbEMmR/6QegYI=;
 b=Toir9RGJiBDRg8k6LhR2t1SkMbJtqbjzLQq3mUcPHJPcsPl8y3AsinzXnfSxNrz+BV
 s35WaCFi9udatYltaotGM53IBGV3VT6tG/1LcoFd7ny6RNiRRJrkMxM96EKJr4Wf7uGn
 baU235J5SbyqfF4IkcISfq/B3FSKxMm3av/aJ4BMM75jPM4LT+r0zvx3dH/YqjEMia6A
 +asbS25BmTvHu4Jn0HGK8uBch/n0JSx8BQ0ThH45PMmh77uNd4KyRsqwas9FG1Oc0Q9t
 V87FhYZ2H8FE/5+Imq7QRUoItXSaVfMaoVoayOApEp82lMaAPZZiVe8u+bOd0TgpeQ4N
 qwkg==
X-Gm-Message-State: APuU4Z9Yxe6gCMwXNi6QHCqXxr0wJ91Egy7vyTUhgaJBHnV89tBNWcl0
 JfvPPJpaq0i8Cwz9gLnH/14qrGHtvFDwIXt7R27Ksx/uI8cB/o2dn/+d0mmMgHx/d8dXJcXFYYI
 2+Swyvm+Gm8qUZYOkf2Hxp5V38OnUSVpJsIKZ1UPWxNJUTeHmpCS9WRYVCiLVAospvQ2Dd58k87
 QB548t1JhKMEdbU03+rWM4aR7RZ/JAYNLD
X-Gm-Gg: AYBFou1D0yVbHcS7eT0VFp4WM+U+l7+so6e5BI0NMh6M1Zf/yAHvp5GFWIvQhf/ze4Y
 cTv1KtlcRl2EAQjQDCsgUhMuvKi4VPCVFyXe+PSnqULV5y/Y0NcdVtMBb4ZIxym8s4fjkAlBoMf
 yLEgXc044muMflfbGB94m3bfaqh2/Hg7HVUjx8LojKUlN0iCteJM2lHaDOZj0dAMG1rV0kyJ7h1
 YeGd7mqT1xlMcjNhg==
X-Received: by 2002:a05:6808:198e:b0:4d6:9293:9b56 with SMTP id
 5614622812f47-5640de2e892mr13346001b6e.62.1793829623242; 
 Wed, 04 Nov 2026 14:00:23 -0800 (PST)
X-Received: by 2002:a05:6808:198e:b0:4d6:9293:9b56 with SMTP id
 5614622812f47-5640de2e892mr13345970b6e.62.1793829622542; Wed, 04 Nov 2026
 14:00:22 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103192358.28589-1-anjo@rev.ng>
In-Reply-To: <20261103192358.28589-1-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 16:00:11 -0600
X-Gm-Features: AclHuK9ZFmouvhx2GQR1hkziitw2nEq9mZXbYoGm07lekxV19EMkKL2PIERSBGY
Message-ID: <CAJ+KCYPaeruULiu8Y+bNYQvZosN1N98SntmF6vphF8tQSvV3hQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] target/hexagon: Misc HLX fixes
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: BW7kMRMmg7OMvHZmIsdKHLP035G1vD2E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4NyBTYWx0ZWRfX94az7Ftj6ayN
 ckEj9F0cN/CveYkfvMWLJWPgvy7epBAQJQiNml9CSRNIe5jxU0aUZ+GAB0yU6wLnxPnpgf5aDiw
 E6E2jLU8I/Dw9x3rqFqfEwNA0Yf+c8D8XIS5IRHeY1CrqIWdwsBlhy+qbPAW6npz6TXnX3sHble
 bIOtRnsGuvMvyftTonHf1zSd/H851jryTuA1ROzj+QwtZpZKgJt9BxUY27U3isDQzCBTAKm2Xne
 W/VC57BkTsApYUIdP2+zKjxbU5oBnH991iyG5KiHXczB4kawMVjAb9FthMz/KirhdnV7BC380v2
 k4RUjlKox6vPHQNwv47cYfG93JY+Hb4Q5T+N40VN57IzEZKFg5ZeutgBCK7o3wEhEP+sDW/X+3I
 aWFRxnyA8zQ1z0yrN3zVVcPwIFZ4weJN0Y8XEWvBDol8muVToh4ydkd/2Yo+++Jn2qC/ZIw8P6O
 /NHnip9trg/C85WevAQ==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aebaaf8 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=LDbF7akihFi_dpaRVr8A:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: BW7kMRMmg7OMvHZmIsdKHLP035G1vD2E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4NyBTYWx0ZWRfX8tyKh81sUw+o
 GLxqG/hasmHUcbr4+0vrl4vmPKOGmpojj8l8Z8v9HavwZMT3TlAdQoPLuvMkZ9n2aYO3WFgYTXb
 VLABS7PyAUyhw35nhfYc/6ioanESVlQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040087
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 1:18=E2=80=AFPM Anton Johansson <anjo@rev.ng> wrote:
>
> Hi,
>
> I was too slow on the review before the series got PRd, so I'll
> submit these preliminary fixes instead.  Not included here is a
> fix for --disable-hexagon-idef-parser being broken with the new
> stub HMX helpers.
>
>
> Anton Johansson (6):
>   target/hexagon: HLX, preserve scalar :mem_noshuf ordering
>   target/hexagon: HLX, search for .new values in pair high register
>   target/hexagon: Forward return address to HLX load/store helpers
>   linux-user/hexagon: Reset hlx_ctx pointer on cpu clone
>   tests/tcg/hexagon: test HLX scalar :mem_noshuf ordering
>   tests/tcg/hexagon: HLX, test .new on pair high register
>
>  linux-user/hexagon/target_cpu.h     |  1 +
>  target/hexagon/macros.h             | 13 +++++++----
>  target/hexagon/decode.c             | 20 +++++++++++++++--
>  target/hexagon/hlx_helper.c         | 31 +++++++++++++++++--------
>  target/hexagon/translate.c          |  7 +++---
>  tests/tcg/hexagon/hlx_assign_conv.c | 35 +++++++++++++++++++++++++++++
>  tests/tcg/hexagon/hlx_mem.c         | 22 ++++++++++++++++++
>  7 files changed, 111 insertions(+), 18 deletions(-)
>
> --
> 2.52.0
>

General note: I think combining patch 1+5 and 2+6 would make sense,
because then it's easier to reason about them and give feedback,
since they belong together.

