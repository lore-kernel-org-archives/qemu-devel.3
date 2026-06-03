Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D16CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUm92-0004iy-Rs; Wed, 03 Jun 2026 10:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wUm8y-0004Zt-S9
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:00:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wUm8x-000521-5z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:00:28 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65395rwi780725
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 14:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8bnmGZyWJ0KwfaHPl6kROxzZYUn/dytGYxQqo+Z7O4Q=; b=CFMd00czIOBgVFPJ
 NSwPH85RRsGo7RVCCW7uNrCzefh56QQIuoBBS6W0rfLkGF01o4EsI1csLS07QPoU
 G8cRwVfirzhbatdaNVmo6rs0AgnUKLolXoCxMMYhzqJuWMOUlVwYg//gCb92LFqE
 Z1afC/deREaL5reC+iWgY+mopeyYW2H38sMaHBWjO3zIks+kVXcuALbrOo+GIP97
 bz5PsBSioTrINV41g2OuaTABi03pWFnNGJSV5zo9ZBADFuYVOOlSJmLWW5DwdPP5
 PQsG6lCJKeny6bD0ODbhxdbDPW6sNjZL3otlIzhNkmmtOeVYcETLYuezBJobW3Bz
 AhN4yw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb13g4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 14:00:24 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-135916eefa0so25154174c88.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780495224; cv=none;
 d=google.com; s=arc-20240605;
 b=bJbuCqU4KHBmFzkHubIyrRj3YGSMaW/5rEJBJTASqMksX+zj/ozvbyOT5kHN7r3lrA
 shYkqiVPDnsp4s2Iz/yvOoqkjylaH/WvjZ4mj1ziVp1MzaDkp/xRzCTQ1YLZEqU7qxiP
 Gy5pZzUL97ckOwxepxjh8qUXFjyviTI/Dv3C7A8rPgYz+M8yM24JVt/BRbJvc3iKAgdr
 JHKN4k8I19nNu8v0EEbfVoJ928BiEDPdRhpTJrrDFWZn5iB/AT1ZBnFR56gHBEPIdbKd
 74GHvZmxuCESOHd6+FZkwLDchslcqa1IxsAbBN74IyA7hW4RwLqdwggWrPtTp1e2cKV2
 4I1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8bnmGZyWJ0KwfaHPl6kROxzZYUn/dytGYxQqo+Z7O4Q=;
 fh=0ypY2+DMo+Tn9hZjyTqCFH3+Pqo5vdiQUJhoWYhFOwc=;
 b=SUlT+0RWWPw7adC/muao6ijdFBBs9CQudz7fpy6PO0uKOD2TYziUw9A+DsvbXFovWz
 hCYwxeK9xv/90CR+KIT/Le0Q3x+N+1W8XC3sgyE7LqNHWOhmoK7gxFV+JCLnoHE8UlWx
 M14GepduqT6qWaxFYZ0dBg1Ucl/sYQx3CfCofjgfX3N1PiXikmprhwp+LSad++8Sy4Fk
 Lb+ACdvCmwmfG8ytaGWgl5CpUZCytLTy1BX5vHnRhKNvdxOLTU1osalMen1zmiDx8EqE
 29ccpVFnu2QbBbSYlPeXeFM9+r/euyQ44iC4qkPBwbjSgF7Fn6CvA5011FrOtV3Ocd8p
 0Kcg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780495224; x=1781100024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bnmGZyWJ0KwfaHPl6kROxzZYUn/dytGYxQqo+Z7O4Q=;
 b=C+yNg9yPHg/yxChU9O5XaNhZn+mgsJIBfwPtVpiJ4TKE9gSzgLu88L79mzPEA2Fjdu
 Ku1jaFzBQlyexea/sW1EpXd5/kDy8R5B/34+QItrlAg1T0VKoQyM6XqXTjynHLcGMhVR
 qLOWX6zASzdrjz4T88YkAy8KPFWNsQMsQFU62sxwuTlo0uk07sL/YMrKgx61xgiJqHBo
 fgpBGcRWVINZ22HXx664oRvX5WxrlfJ4ZZtmEg6j9xcCsPeALgyBEg46DhgC9PULZpuv
 yylTaEdnqMKr04G6hp+GbKRJBa1OPK3edYFOyUp5KTL4Wue/JFMG8tAVmIDvGQPr3Cxk
 cMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780495224; x=1781100024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8bnmGZyWJ0KwfaHPl6kROxzZYUn/dytGYxQqo+Z7O4Q=;
 b=RUjU5mvG3nahi8kkGHU8U6oYljUAJcHagLJaxepcTmsqXuLkvqJMlN2N6v11UFOdrm
 WqSA9VSZZGJlb+hg11+Ox/2jrgciApVEtoGhecKTGvwsayiMhzGwy2yv0GYwaFErL9CH
 vPeMGjBOy+2sqgkkv0vZ4jhPiSid/neANzbJSQMcohmTvR95GznClckIraH/ImZdCSSz
 mQrMgCjBolW/LL6d3W9rDyyBcLRIswFxcEOsbNIg2aVHCJa7ZLhFwUPzlCiavK9xNu0v
 TwHGTAOE3b0lYw+EW8pODYmZNNYmtqhzv7d7i8grt9Z37UgwHPkv1c/GdS9bffR+qp4m
 y3ZA==
X-Gm-Message-State: AOJu0YwgTnEaEToaelvD/z/1M1dB1LPQ03D5sfqbxjQlM2Fr9S1g+tHb
 nDpHgCu2Z6txKjJv7kpw2INUhTf0sWL+lvJKGLozotiaPa3PivbWGDMpiUP3W+Egmbw/rTKLMEa
 LN/92w6s2g1iiLMdJ8Fq2X+zpWugQ7RYi5H0XIoZTfdHCO4lc0cF7aOSqOOOb500t6cfzJmxUu2
 rovvedAhTxfG1FTLGVIMZc25QwzVSun5+T
X-Gm-Gg: Acq92OE5e6QUCzrcymahlALdsGkovCwQ6d9qm8UGYCD/KDgefwWnBmRtJrbIMMxLkXr
 1+aqD3OfjKfkmPl7slKAihwbl4L33Y16BimGX0t9Qfj6e1b3jojuUt30WhInSo7nelzv3h4g6iX
 g2aulpFWwxs1k5zZJPgOlrPnWNI3oj67VYbhZeYCzNPduntcpVspnn3CtVCzSBtc3NU8v+Z5UQr
 e+VR9Cab1fsCkLUOw==
X-Received: by 2002:a05:701b:2706:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-137f694475dmr848738c88.2.1780495223718; 
 Wed, 03 Jun 2026 07:00:23 -0700 (PDT)
X-Received: by 2002:a05:701b:2706:b0:128:ce44:be8f with SMTP id
 a92af1059eb24-137f694475dmr848703c88.2.1780495222461; Wed, 03 Jun 2026
 07:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-39-brian.cain@oss.qualcomm.com>
 <c71f8159-5c3d-4e02-aa08-7d979f5454ab@linaro.org>
In-Reply-To: <c71f8159-5c3d-4e02-aa08-7d979f5454ab@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 09:00:05 -0500
X-Gm-Features: AVHnY4K9gXMuMsZNcOT8mugm6MjB34A_EVImdYKu4FqgyONgZToAftFjIRJdeL4
Message-ID: <CAEqNhNaJx6_KPW8dxsoN3WdoVLAxhVQKKD=2S92ya9KONMdboA@mail.gmail.com>
Subject: Re: [PATCH v7 38/38] target/hexagon: Add hex_interrupts support
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 Brian Cain <bcain@quicinc.com>, Sid Manning <sidneym@quicinc.com>,
 Michael Lambert <mlambert@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: PfAA7uam_BLsQc2y75qVit2aJmAzf-Gt
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a203378 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Jk1Mq3RG9Jm1FU1F0FcA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: PfAA7uam_BLsQc2y75qVit2aJmAzf-Gt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNCBTYWx0ZWRfX2imOArqZH5z4
 dkbxblq9+FTIV6pFOk4XOrblV3y2e/NaxBFssaBDzKUVLEuYA7hgd6KJV9vze3jEojJA6CalPr1
 yJPO/LI1iEmD3lFu75nnf8RwGB49oAri5OAlZM6Q7rgO7QWl+k4+iHjNv2JBtBEFAiA8PpODmYq
 WeA0FnXUQWshr5R/v2thMvxCZ+IjD7Pn0kYiG1jSa1YT4gt65wNtcAyTxw/eMkpDTWOOFumyGKM
 fG3X7kXRMKZrE0p8+4DSwom+S8/LMRCLNHPlbnheWZI/L8j+0nX4JMWMJajEGwsG0XYPgjzV3+m
 OSjfNqldRAPypLx8Xwehp30El0nIGvokMza0/X8miczSV5R/MB/raLRKGNMQ1JiX9WUKHYdZg/C
 xTcHJYEEPlnwn9+M99aYQpHF2ROR4JTqxIfckqoVVVaCoyhmIi7Ul9T5/mfOlw/uemqOu9BYl5q
 nZquii1utPVvbqiCp9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Sun, May 31, 2026 at 4:31=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 29/5/26 23:55, Brian Cain wrote:
> > From: Brian Cain <bcain@quicinc.com>
> >
> > Co-authored-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> > Co-authored-by: Sid Manning <sidneym@quicinc.com>
> > Co-authored-by: Michael Lambert <mlambert@quicinc.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   target/hexagon/cpu.h            |   2 +
> >   target/hexagon/hex_interrupts.h |  15 ++
> >   target/hexagon/cpu.c            |   4 +
> >   target/hexagon/hex_interrupts.c | 371 +++++++++++++++++++++++++++++++=
+
> >   4 files changed, 392 insertions(+)
> >   create mode 100644 target/hexagon/hex_interrupts.h
> >   create mode 100644 target/hexagon/hex_interrupts.c
>
> Patch #28 mentions NMI, how is it handled?

In these three patchsets, the nmi remains unimplemented.  Would you
prefer I include the nmi implementation?

