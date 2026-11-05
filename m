Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD9606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gH7Tj5I5;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aqCJNljL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1XQ-0003IR-Qb; Thu, 05 Nov 2026 12:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xP1XF-0003EG-A5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:46:01 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xP1XC-0001pe-LM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:46:01 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeXGe373882
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 17:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 knzVCE8dibirisJtz2Cf7IgLaTc1dDpziB8ZlktcXEE=; b=gH7Tj5I5MwmGtSs5
 2vzBBY2GpzMfF7+irxLfpmHzgSRdxPSJKgr0PZSpXRF9X3V/D2/OuCJM/yN9Dqj7
 F3G4IbvuIewRY5JCeWz2QLcotT/55BcIkV2Gf6qGUP3MRd4MVWfgsRRFBnDRhPQw
 2d//YYSYbRkT/bCX+UFHFIsKvh/j2kjUyRQ7oBtr4yZmtFiRCG8YrzYL6tPLH5XX
 zaqTp9ElUNyqVbpxoyLefyOuXEguSsX8RIgxzv/UsQKSBPY/hyu6qyMyFIU7HRZz
 SuvYO3PwsVOJHh2Iwk1LzrAwbTN9bGtp7VONshmpPfSHwpLg/mxRwiHMax5bFeGS
 y3C25g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrksqb1ve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 17:45:55 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-540537f959fso2783046b6e.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:45:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793900755; cv=none;
 d=google.com; s=arc-20260327;
 b=e/QNmu2/xPBRBrGl+5N5tMnwNZEaJV10MhFr2+uJqWRJXH0e8lragEHuxIga75PWgZ
 g743Ckxbot+PLqJn6bsE0RoAiERJSIP2CpLdoWe7lljnu82aLLttPJ+oc01dIpYcAzc6
 NUnFufgM3YyRohfdBgd/szj6qJ61Xnor+36T+TvTLkKEPnvQqsz+SzztHAlVC5IA/GhZ
 PI8SWtwSdwUnn7FuGvGkKkR5BcDq0pVnf9QnCkwE9627nqWi6c0WcOA2aOZYsq0oytIj
 pAoGFIS7yf+AcZZKthwdzFlXpmG2FEJKCPIHaY5/tgnSoVuI0roj+Jwq72r2y8jpOvTY
 V41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=knzVCE8dibirisJtz2Cf7IgLaTc1dDpziB8ZlktcXEE=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=JJMYeq7YxXbS+ISOcPCktNLEL852k3qJZbNU5z+GS/Lp7PWEO/p3KUOw6X5anc9HTp
 PIG6QsfLvQyIyUgwCPdwOBFmZTSJdy5/E9hxDLAoohu4GVK7o/rXUxmnjQBJWotaybR/
 Lk2itX6JfPrfoHYgD1aPrd7SLX9W5sdhnVhEVb/0vXDO4VJOHYJpSgbWmFILgaOigGOk
 pJno3uJ6ZhyASyqZKk1msFYHlFt7Y2fXsU2Zz2AE3A4PDoRQXto2pXbUwuE6TLqYeKRN
 HjaXV0N8UJqh13JE1oLGuzC5f8ns6mvjZq4x91ESDwIZnoO0i87We7RwBfDcZsDVVPqO
 szoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793900755; x=1794505555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=knzVCE8dibirisJtz2Cf7IgLaTc1dDpziB8ZlktcXEE=;
 b=aqCJNljLUdlGRluIgkTo2Stid+bxstZbR0pnIgcY3mhE9EGfSBgVYuiKkRIlljAxcd
 ZALBhD2XuLyDBJrJoYJAvoHbGJwfa3R9GdYMTwvTFg5OWLSZR0b2dy4l0e2Eu07+1kKj
 sAUE7XYu8xzUxzfxFEJtPhXF+EgLWJlkK4CLEFPhp+Tx3zLCRKre+xdjjEPa8eDQ5VZZ
 oRC6z3bmrKsCIA3ctvFRcypkzhTxofqSpuW5H0m+99vs9XURXGV15pc3Qzhv/kqE5LIm
 ZB3Us4poDd5x2PlgrBeFk/Aha14whLZX9qv3hBy4JNf62PzO9sc2Bqtd2l/OJppRsPNi
 uK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793900755; x=1794505555;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=knzVCE8dibirisJtz2Cf7IgLaTc1dDpziB8ZlktcXEE=;
 b=lVOT2qi9nfwzeFtcvwhw0KdVpflWDjZdTwviWMH6r8RaoL04ULid0qg8p9k099SF2u
 Zltq0N99Ha86BQ8Y7lngtpMe7p7DPUIKOZIVvok+nuSDqapirRKkr4+8tGxLW//0S+Sc
 s+Q3Dqk5XLam1a7FQbHqGzOEiAN3quH0xRKij4pDLEdn/1Vbsm4DlSvoqDuBuVPRSzco
 CXRrtjAwnEZ/MUT/WBPqW5ZoZ7C/86/VGuAe7UbWnYlXoXHnOAuE2pZmh0S0ebqDY3po
 qZxhQ4JpS01HfudWwHxFVQ+4pG5hHbPXKDyHR+7EYVRR35djScZShHL0xvnZh1ymzdMn
 NePw==
X-Gm-Message-State: APuU4Z8e/vNqP0WWx65w57wLql0RNl+u9c4qJcYvtAVssm8PtfCV9LRp
 Z6Xclh6i0uXAXG6G5Suv9Pe2u4JpCqm4o9zeHwG5L5wr/K7v/xsMPbHYa+wOE23VBII5un5IT6F
 8/gMCDwMTrqD6T9Z0itBFlOZ2kC2X4NCE+w2vfTtKyGjC0D7vryFDx0fHLDHNzRguyhqxoVjpp7
 OMdUarcTIAvFT3nhd82RhsRQC7pqiKPdPn
X-Gm-Gg: AYBFou1pqOywustW5gFNY22lTiljkpwk/AjeO984FqP7mcrIxujBAeB7gdKDn3OXR+C
 KExW3QWaxLegH//JlAD3pGP8bnvIWpPNrB9fj+jsudR+z56aiG5CpTUNKsXWnCGwgN9B2F5SSWN
 0h4+OfR6vH2mvmmuSHzo69WuAA87qvoHHLVuDg8Mr+RVQSkzNLvnolL7U1JILrwGyqUw7gPAizU
 QatKlkIP/I5eGe/g9M=
X-Received: by 2002:a05:6808:11c7:b0:4c4:d8a0:2773 with SMTP id
 5614622812f47-5640dcbfefemr14536439b6e.32.1793900754931; 
 Thu, 05 Nov 2026 09:45:54 -0800 (PST)
X-Received: by 2002:a05:6808:11c7:b0:4c4:d8a0:2773 with SMTP id
 5614622812f47-5640dcbfefemr14536410b6e.32.1793900754450; Thu, 05 Nov 2026
 09:45:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105114633.597-1-anjo@rev.ng>
 <20261105114633.597-2-anjo@rev.ng>
In-Reply-To: <20261105114633.597-2-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:45:43 -0600
X-Gm-Features: AclHuK8Ay19B-xIki_7Zghj_3bOqrxzuJvhxU4GzDm_P7gqUjtuV7aZYPv-9khQ
Message-ID: <CAJ+KCYPc33y5NgrzgUw+tQ2Rt4p4qMNK8Mz079HSSGCunNKCdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] target/hexagon: HLX,
 preserve scalar :mem_noshuf ordering
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MCBTYWx0ZWRfX/+Bsp5afiMgJ
 wSUs3+Hy0aVVNIa0H1WEBTNs2QtxwrBztJyMEYZAGSojth8l3OUAAVyUZtHWrH50Y4ANTQmZkpA
 wkfxVAB7rihKdPFNp1AYu9s6aYaiXcgFDgunhS7nCeZbD0q3yFn8PsKLLJEsgYpiorfLHVP8QwA
 SHm/3llsGYgD51V+93enMDMEonoGv85e9jTkiak0cSWTUaECV1TlRCqW0CdRti5M0s5qq1+A4jk
 BSA5nKiz0BQ7a6l6e5znjGTlS99VE77iIHLQF7BrhmZu6B26tkNGP9EDhNjnE5NvtUy4HNXfytI
 tu8SZHPwnHOZ+jbZKH9ws1iC0J4moC3BmPPomwvmSR0Zgpz9kjXR321teIWzXqgVzIbwZOKl9XP
 dNf1bQLVy1YUSoGJtX4aeRj9O6nTxUgeaKuEO3LfXGvtTzpQJeQGlsPjwyt3e3fU6LlummukYzE
 UUhygXn32mF2Ki4iv8Q==
X-Proofpoint-ORIG-GUID: s3s897XMq7Sz5YL4KV-MvQdrfOxPDAsm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MCBTYWx0ZWRfX0eZvrm65ndfo
 JnGG6S5+AFXVxlJWOQHvPtj0ph/tx5a74mFeiE82IpDaPM1jnorKFWGY9Ghbr+xxHamg2sAww0F
 1x3MkMh+Ez4yWN0NWKbzL0yq98zKpXk=
X-Authority-Analysis: v=2.4 cv=CIe/zhrD c=1 sm=1 tr=0 ts=6aecc0d3 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=jYwdBdnoqkFvpO92Ef0A:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: s3s897XMq7Sz5YL4KV-MvQdrfOxPDAsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050070
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

On Thu, Nov 5, 2026 at 5:41=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote:
>
> A packet containing HLX instructions currently defers all stores to the
> end of the packet, this breaks scalar :mem_noshuf ordering.  Only
> reorder HLX stores.
>
> Fixes: a6fae6da070d66b9 ("target/hexagon: translate packets with HLX inst=
ructions")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/translate.c  |  7 ++++---
>  tests/tcg/hexagon/hlx_mem.c | 22 ++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 3 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

