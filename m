Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92858606A335
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K1w7c7UY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DH9C3Iqj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1Y0-0003f8-3p; Thu, 05 Nov 2026 12:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xP1Xr-0003db-Gp
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:46:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xP1Xp-0001ry-Uq
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:46:39 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeNcP526165
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 17:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /et3qqKlLkCLA20qGU4p+MtNFoCwtL/r8cXHM7n//DU=; b=K1w7c7UYh6NHpCQD
 KLPpX+jUjWXfwdfSuQ/um9F6QteE9vrtW8JiyF/wntbvdEyoppokviKcz+MFir+b
 h1W6fo05ekTeUjRE5YE9gsd4S/oMYl0PbFuBBli+96gtFuY6fZfCNJLqSpLHK/5g
 69DkYvsxfz17HdkmXa6673q/yyRDmVsgNB8aKXnowTm+3/XhpClm2KyO+Drx39FV
 iB6V5CEemdqhagTbV79QMcocHTcaDtnMYV8D9duhZ0QIdx9z0OsVDWSULOd2HTRM
 EBsMcCp+7VK5f72TJ3MG/Q53czcZV6HlG0moC+vfB9ZtmP63B1w30uGdnEA2jK97
 J07fGw==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43kfyj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 17:46:35 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4b37620eb73so3438979b6e.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:46:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793900795; cv=none;
 d=google.com; s=arc-20260327;
 b=V+ndYw31MDRqyHY97lbuPNXxL8ixHMy43ahPlYnTO7cLrYcg3/xkgBwl3xNJ0+N3KW
 +NFZhkj1ALoh6HJtrZ03seoSAzKjHZnr9hf1CGvkIT41i5g8QwVTWPdJdY1oyxzVIU7J
 JsajL0Q0RbfqBuLM7LUTFTOtq37zDBOc7h0/nCgF9lVHP57YxKMD543binMGWIvKMpLI
 nEWVy3lqBKcpcv/nOFHQxRSJggbBv94xtAKo8jFBYGKebhvW3V4cBXrbtFCvvDFEgZZX
 vH05+4kh1c46cAZMkLuCEsXiAbV7Oh1f/TTu8SNiUS/HamqCiLRrf7pSFrTEkOroVSNe
 Jb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/et3qqKlLkCLA20qGU4p+MtNFoCwtL/r8cXHM7n//DU=;
 fh=/1lq0lfR1GnA6ZK1FUVPbYmtvfdWCEexdPZ27kjzpc8=;
 b=NLPP8xy162qrCDsG3LbJ8TTRJp9q9gnG8X15cALNqmpDJjecMvJn7ufj8nn+YV4ZgG
 3hHHzDfLrsY9CJSFO5W+se/2yprC82XAYBapSPrGTMs6La/63DXCvYsMgNMY59/mYDpa
 zeh3r3YYIpGX8DlQRA5mYMfrmFPN7KwUq2d2T24OkQndF2hIE4Fhd5dDDpbUff9i6ruk
 SinmB7MWEY/+BjFAo5XhIrIZKLRRbVcS90PlxWkVkRMswLLmsHik6D5fspaHNu04FrJp
 JUImSmKwRvHMODWNTkULOPM2XEmxAA35cmRBGFGlFfpng0ES8ky00sZtwXwVKdo8BY+y
 OY6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793900795; x=1794505595; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/et3qqKlLkCLA20qGU4p+MtNFoCwtL/r8cXHM7n//DU=;
 b=DH9C3Iqjr8nmy4n7++LH/bA6aDqh84dzVmt0ujY8E3CIVB4tAAiJEHKc2Mgwa+dRYS
 NAQzjqKLPCrXbIJ1ocoo2UgRqaZQuN9w4dVXy70L0XwfYiI8Ivb78Rh9g/l71gZ/rTyQ
 5WmULaQ9/oBOepTQy1GcAvSqXphRnOxWm2jFSQsmBDm3DFAf+mUWO6MRfF3ij/i5n36G
 hzwNRLqMGO21JJHSwvkdu8a0m8DwW0bXCMqsCUAkLNaoCDAKoAAmQX0p0jYyfNSgHQL8
 J0VHGCaqq6RDT9UYP8b0oQGQdoZIzVLzCAZElrbqKM1CudtJuK8LHqQviMaBXiWCGWRj
 7ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793900795; x=1794505595;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/et3qqKlLkCLA20qGU4p+MtNFoCwtL/r8cXHM7n//DU=;
 b=HmFCN4qlLP+75i4YI758WG80rZ6pqAJgHoxDFfT3Bq3W7tJ6xFskwR+GzVjlS5iabb
 Sr/2jIovPb4LFpZJoDYddcoHLryeKQbgE2YxMWP/rAfgj4HdiHrb7AKzzGGs412DKN4o
 iY6oRsn0n3Fnwz5G7EufvkuccZYCFivoYShX7ckye0Y2HoD+en7ZM/A9lAo+Z5zxuqG8
 3iPjqSu2cTgPD5gIiljtnzuo3P+kkD6dOzpFuoODF84iscQCnlzPzcmeo/CpiDOzJUuS
 jwl5by8L7vHbrHOrY+fPOI8EWon5KVxbmQo1a3tHCTx1CJWB1046v8YhjY2v414qAlql
 cIEw==
X-Gm-Message-State: APuU4Z+0MzMgP9vgqJ+yhv3+0LnItZB9xONVANKYUqU2gcgNIIqPSX05
 0edNL6HQdgoFDADdSlEX6ssIrqtHk2+9VOnyZbe324CBhMMUAbRPjM5RqqyBk4YyEfiIcZenbqE
 p5ApM7B5c46K3tjsQ2C5LTke5S/hX2hrDmZimVekEzg6rJ8YaFCTFiY/oxKItvXtf5OiWKQx2Zj
 IQO70KH/lsoQw5hjEt48Gl+5u4rdnMMMs7
X-Gm-Gg: AYBFou3EFUEYO/vS18CsiJ9MFXQ/WYAFJ69EAp+yKp4GI1TdZdsvCx4XMOXfv6ywApr
 3o6MWEoPFzXjVyuc+B5UROF3qEqJNgWmb9ge6ArjCYMfIW5RlKTMM3k/hcTd6TtrV9V0M5ztbeI
 d0SXeGfB9AfcgUboTQGAg0THzlTQ9xu9HvJXm/PBZM3e95fLK/xykyBPuyuQe3+IvC6H1QlHAxz
 u8xdAdtqJzVbH9o8SE=
X-Received: by 2002:a05:6808:13d2:b0:55b:fcf7:61f8 with SMTP id
 5614622812f47-5640dde876dmr14431308b6e.40.1793900795158; 
 Thu, 05 Nov 2026 09:46:35 -0800 (PST)
X-Received: by 2002:a05:6808:13d2:b0:55b:fcf7:61f8 with SMTP id
 5614622812f47-5640dde876dmr14431283b6e.40.1793900794608; Thu, 05 Nov 2026
 09:46:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105114633.597-1-anjo@rev.ng>
 <20261105114633.597-4-anjo@rev.ng>
In-Reply-To: <20261105114633.597-4-anjo@rev.ng>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 11:46:22 -0600
X-Gm-Features: AclHuK-pA13L8ym1nYz2MvzW2hN3_3w-np_PWEov-BXjZ5LsHnnBeYdDz3sOUOs
Message-ID: <CAJ+KCYNVLMbyDH_ceXQaHNwk12-mot_5STAroxAV=wv-_C0WyQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] target/hexagon: Forward return address to HLX
 load/store helpers
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, ale@rev.ng, brian.cain@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: SdJTmJRtH89LB_-3QVmHjpT2vFUCMlVd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MCBTYWx0ZWRfXydLLqR9Ryd8Q
 uLQ0604LsWRMlWzQeG+bb8ZpxdlqNXw47QbLFq8CIDl2AEbfc4lrqV8HqecGJ3I52V/XXK5Ye77
 bZDtjnOAWLHPCWpUHFnDyjM8lPddI4b/quK8CzNrDzS6zieKOc/Bl9gx4NRpulLHDRnsEmmZ82F
 n7yCvATZN63vB3j7tTpGO08sHz9IxWA2xge7v0GHsqFWRqPaStfWD8jsxfzaALfX1pPjAPJ7VaO
 gQGhWZK3avC96fTT0fdcZFNdvARvkurB/kXU9k6NyLRCrK0/Aj7v/Gunn72IkCx1tZ6CrOe0qrU
 YJvKmqdpggHpjGTvqVr4QEGx90dbCcxt2O0TZpsoFn7GO7Ngjuotz5MYtYmEzv4asBqOe65lQAS
 lHYtNqFAgwFUEwXk/iZiulzZ/DFQZndG8l9N1lTVwX7SLujKWmE1cyFw/8G1c7Jpb7oB8b3sGfW
 xJWEmzB6UTY1Dra+6Yw==
X-Proofpoint-GUID: SdJTmJRtH89LB_-3QVmHjpT2vFUCMlVd
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aecc0fb cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MCBTYWx0ZWRfX0f7RDLghPjIS
 +n8ihVH8dOWZg9p6jU/wV5OH4Dt0r3YcKB7S7JXcvhW+z85D62LRGW+1CZQEi+JceyFDCQK6LXG
 /EYA+eddgNX34/k+W7tQPCp2nOcuIr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050070
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

On Thu, Nov 5, 2026 at 5:41=E2=80=AFAM Anton Johansson <anjo@rev.ng> wrote:
>
> Fixes: 2db29a3615a5ad2a3 ("target/hexagon: add HLX helper support")
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/hexagon/hlx_helper.h | 19 +++++++++++++++++++
>  target/hexagon/macros.h     | 13 +++++++++----
>  target/hexagon/hlx_helper.c | 31 ++++++++++++++++++++++---------
>  3 files changed, 50 insertions(+), 13 deletions(-)
>  create mode 100644 target/hexagon/hlx_helper.h
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

