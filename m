Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6599C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 18:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6B67-0002gB-GN; Mon, 14 Sep 2026 14:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6B61-0002fh-TK
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:08:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6B60-0003aF-6k
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 14:08:01 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0UmD3588147
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZnUXLiVd5LtZlauIVNzM1gnZ0Q4sItPgDeDiwMCg07Q=; b=Gw8pQJoxAOuaLImH
 IbrPLHQbfCpStUK2RuCq6diE8jf1iKamXgcrOktOdKgLK0ZWMIK1rFBpJRFIO/ip
 3fnYOSkYGhhZ+gGZQifGFUydhukErRn1iWXrXu+e6vFH4sYMk+FYOF6WwDC/6X0z
 o2D/Hyrpwu6ImAAc1AhCfqUXrhoAZYTvTeU4HjPF++OSepUVt7Ges+AChyzJdyPC
 IlNU5V92fs6DfSEwCpHb6MQQM0kvRRr1Tg4Vt+Irt6vlAib9JCU8R63opVoDYIsM
 y1dDYK1EaoErC9gX84YtmYebGDUDNdW3YvMWr6oua1r58L3mgqfl5Gvx7xfrldmw
 haHiXw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gperga10t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 18:07:57 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b98ca6c270so127925b6e.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 11:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789409277; cv=none;
 d=google.com; s=arc-20260327;
 b=ZLMX6XDdZSQ2sPPVnR4P/cWuJJWC5m7jj5OVlNzW2kBPiLn/Fo3qbZqCBf3TTzwuuy
 MWzswBUIBiVeS/PT/1M9Lfsn0Z0jglAAtxBf3Bz9GDET9BNmfvqYj88PwJg8e4Cl4ZdC
 9nj59sZelAVoRV29oyuIhNzB7MCJMbSp7oPI410VE2uAnvDO+Sy1GKZZIGRM/KFdvDkn
 rVls1OnOxHcuVW6W/dRviZ+b9Q/soQK32wCWDyepbs211TQ4QrX0Z8JIRAy216P2yl1C
 EHPRuTnhyxdsJtAvOFVsRNIIU2OaBXd/5kwdSNRl2+WMBb2QO0c3q3YWVzlb9qWrGskX
 Z9VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZnUXLiVd5LtZlauIVNzM1gnZ0Q4sItPgDeDiwMCg07Q=;
 fh=6jUfHqFrODk4HdxGf84lWJ9phsue9KjqaKfyDiwbgA4=;
 b=kC8nhv4p5XiZO2KJNus69gRc4uXVKSldzhdMLUGCRX9YpWmlBe/42lpBNLrb/55btA
 51fY1BzGinPVplif6RW6vGoEm8fJCW/rx3hhFdqOXtaGS+BDXFBGxeOsavZV28oY+eII
 tcZbGDxc5/oDW8vXzEFqzl+E3cNngWf2cd24tLV3B7gFnuACU7t7O32Tm1jCh5hjE9YI
 4aVCmHFEPtjLw+crkQRDaf8CBPisd3PJTQCrFTUuw7Y459gZ3Ovm8HwjlvLcdNBo1ZsO
 voOXzxyrQ6/D7bxr23Mkjf3AVDcS5iKVuW+r6GM+xaOGnCQXF3MaIEhf8SMBGECeOmbZ
 BsVg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789409277; x=1790014077; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZnUXLiVd5LtZlauIVNzM1gnZ0Q4sItPgDeDiwMCg07Q=;
 b=aMx3p+ydm5guI5L65UphC3J40aQomr3WcjwCJsZddgeo/AiHJb9Oac03n++X+s+wtn
 ivw0zJ7urIBPYoh1x+pRLPfTfuns/junWFEyoGItvN0RhfBzdOy+vdVdVo/WrfQsD+vg
 QuIBr5oeCFnHVfufqukf4iv2iHTEose/QH4J6wO4tHe8mSXFXn5OlKDmDnJ7Ao+jCBpL
 P5uaaWuLAzabyiapsvXM5IX1w8YevWQIcdRYn1y9Gm78RvwSHey/ObGt4CUmnaEZ9Epx
 V1LbRCjqzVEzmFFL9S2rAqYrKKjWG0zjDTJmHFVnL22Jv8OZNjScaFvoH5zoh5zBoYrG
 jwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789409277; x=1790014077;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZnUXLiVd5LtZlauIVNzM1gnZ0Q4sItPgDeDiwMCg07Q=;
 b=oR4+uQK1K+Jfrkciel8sMHKCRIIVmJhPXlRasLJW2J3L4Va15ocqbc3WTnbO33lkA3
 +PDmNxRroqEyPOAO0NKLLsQg1oK7XHdybIM9rmi7N6guyXHnYMb+KP+rcnAiKbkqf81P
 +oV5dePLJU2KoJFDdhKoM6lIx/Q5LT4RmLbsQ5iLyvWXarsIUKlyNclNeMHzI+Redv0I
 9Rzqsf9iyhZe3f/uUQ5QywjAWKdq7iAeVwleQAWSMmOXjBmFKSJ8k9vuRIoi1/9gQPY7
 aknyj4MJBh+GLk2BI7YTbyaRjFkZt2dGEf89581pNQFqokh1ztzvF9bwmKFda0YnmwBh
 mHIA==
X-Forwarded-Encrypted: i=1;
 AKwUvByu6IFXaDlxoXRMAdQnbrdT9fFlt/f6XWkc+A9Z8F3H7HP3yHd+qMiI/17fLKpXQgW/CY4XLOUg7r7h@nongnu.org
X-Gm-Message-State: AFuF++nb+365aE/07UHoJ3tXozp+4AxQCfEY3z1GOzN6EMy+suCLNTqf
 H1z7RqlA9oS9Bhw+hARIhhrYwa6oRt5kWfgaSb1gKpRXJRg9GJ3v4XXbzk0bE8hOv+VI8IS+t+n
 Y6HekJ/BCj7ok7nRyZHtiHHwwIhN+XQvvlgrYO5NXdkh+UhNmTzRKYUWd5YWHsD3rxqyHyysds/
 kBkBYIhlzbccv93wmjlIlWcPzjnn708G29
X-Gm-Gg: AYBFou2DFhKuMtBlTyMwHrR5L2GehlGe166XD8yCKEAVok2VR5meT2bMZGuJraEzrfK
 4W8JRTSB54w2TYnmMbQiSF5QF1wMv+rluGV9VJTkfkduw1Qg7Fb3iTtVzK/kUKSTnKAhLMplliI
 UJEJwvX/L2aTKKqYpadU3Y4OwDVf27i726uWrrxxL5SxcPbP1/yM007XS38hmnvWnQpx92OGlNx
 oxSccuqzn2pJ27ALQ==
X-Received: by 2002:a05:6820:4c0a:b0:6be:137b:3f96 with SMTP id
 006d021491bc7-6c63939d369mr284648eaf.20.1789409277108; 
 Mon, 14 Sep 2026 11:07:57 -0700 (PDT)
X-Received: by 2002:a05:6820:4c0a:b0:6be:137b:3f96 with SMTP id
 006d021491bc7-6c63939d369mr284623eaf.20.1789409276656; Mon, 14 Sep 2026
 11:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-4-ltaylorsimpson@gmail.com>
 <9e5c2555-71a0-47e7-b89c-045115477f8f@oss.qualcomm.com>
In-Reply-To: <9e5c2555-71a0-47e7-b89c-045115477f8f@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 13:07:44 -0500
X-Gm-Features: AcwNN1UN22mGc7H2wrJ7sKk9j5tbH7DvfuP5eo-11Mztfa-XW6S_Qd6oVTeHClw
Message-ID: <CAJ+KCYM8TWcQYWpG2rLzLq__ORo4jLz+wmHzCWL2mRv+xTjA5g@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] Hexagon (tests/tcg/hexagon) Add tests for
 multi-destination instructions
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=QK/91QLL c=1 sm=1 tr=0 ts=6aa837fd cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=LvpTVT36VLQA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: UmNAmMxMMwf9tfQKUiAQnf5ygD6t1DRb
X-Proofpoint-ORIG-GUID: UmNAmMxMMwf9tfQKUiAQnf5ygD6t1DRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI1NyBTYWx0ZWRfX3iIXCe0rLBge
 cfYjkCyy3jEdscyUGixyUd5/WV4u+MWFnJJWShcFNV/+Hr6Ipp5NqYTq+9tP/VD4HZReJQIOw3k
 TMWJXbTfZFnkUqVXK2rYFyEpCUYWtxDTedWmtHH+7Cf3lFd/IiQeqcqQTfpyHbxfe+J/3B2kLX2
 GjcSCgGiy+FR33pUyngt+E1fMO/Xhqhcyz/e4rZmkGRaC4UxpRA5Cenr0+EHXLasiW8FxPODlK5
 Ikp0KFTY39eK502RMjyvQE0eMS5H5fOHu52qeNePy/PTPhKptbYyuHdBKL9xI6DkbEnpfktL9Ix
 YlTZZ738sAcb+d0P2AQBfDTo0h85WdH+F2OV5dLVUuKohbtRig+MX/QpJpAQrvTzxET+J0uyS3K
 FF+Sv8KmydD+XVhEILsuGypnhwMExqNSFEsbaLBEeTiCcOXfmO5do717N/oJT9yvqgbApRHngUm
 PJwnolmf3trQ+/XZs4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI1NyBTYWx0ZWRfX+HWwbDO4jb6I
 iVYATgs11BMlmx3q6R3hscdVmr4RGPpN11hdX0kXTaGhOEJgUG03A4eknrDoZXRUF8uNUnAWgjm
 DNMNigAn+CkTBwLChLUFJwrHdkw87lA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140257
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Instructions such as post-increment loads define multiple destinations
> These make it harder to detect multi-write conflicts
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  tests/tcg/hexagon/multiple-writes.c | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

