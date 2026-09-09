Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0ECC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 15:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4K4q-0003z9-BV; Wed, 09 Sep 2026 11:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4K4j-0003yf-He
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:19:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4K4h-0004cL-Rt
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 11:19:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689DIRxv2080978
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 15:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aSZ8z+4dWTg3Rjk8/aame/l0uaKJkv5kmAFSENqC/eI=; b=SP80ZdZ/KfyVqai1
 E2PphYOju3sGDLlNOSSaBt5CBy9v2HRrMBChSS0JoCOkfEfytR8tAwDxP6sc0QbU
 /4Z9e/q9SI7J8qXM4TEDpd37Dqb1cFaKmHccLVjKq2IUrsqbeBJBf80vq1f4kAZt
 EiADF6+10+57PgTtExPm7i1u3ZjPpVLwgliR4/8uSYBCvTTHOcwU+4TB9jSBA+Kl
 bv9rkNA8c6WgcKbNH7WmmDjKCJzxL9wisWweGmyOx4Qp9WM0ohYSbg+p9OEqnxwE
 OldbXoerTFm6cn1lwLjwlZD+hgjZoXKLWRT06VNvEAagLY4a3JtJoVCOb7CKUTbi
 0gJCGw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk87r0kk1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 15:18:58 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6a313ec13ceso7252396eaf.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 08:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788967137; cv=none;
 d=google.com; s=arc-20260327;
 b=fiE2a2QWzccpS9WPD8woiwx4XmxVkW9/i30qvquEW6xKVD78j7GwW5uPCHARaLxV4o
 prRq1dVKigDRNjaZ8ESV+26F54CsJvYNUbZwprAf5Ew8uM9ndY9x3C8uPYvPeoypQahW
 5HVaxed4Ss8geQPqKSfvJc9/OWEnm4x6WDdCRO/D0hZaBnWiwc1G5Y7VZ6CNypVIpOb+
 wYby8nCFLaWEAL51PgDnSjcn9IwVSYRdgCT7iybnwdP7+0gZL9mWC0we2EMNkdVrjBWm
 9uHAwr5jPEmmd85sJ57q8w6xugGpN3WO5exTaKcjgq+vZXQMAk+xGwk1suLZHADyupZG
 yiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aSZ8z+4dWTg3Rjk8/aame/l0uaKJkv5kmAFSENqC/eI=;
 fh=JS/OgZbRfXQVDoN5rCEv3BGagEhB1TLJSS5HOGFUyfE=;
 b=DGtJSHlBOcV3DHl4kUh3Fc76UxCDVaKhFlhIDlouqrKjrR2E7CSML6fBGL6K97h4Rm
 fB0idPyQx+mh4uRfLoAZK84Rf4rGiwa6NXHsPRxH20Vc851fgShP1se8fTJYBs2XDAaK
 tC+EjIUNZvHTzOVxaMtaH3FIl5lyY62EADWfr0yZf0MQCO1wiBIGcLEq9EGyHlzuun3Z
 RFi7H64JVLo9HudFhmj3KmOtL8WuSWFzm3mbDbIn8dWjIceDjBvxG2ygS2pD5WQrNlSq
 Odt0zoA0184aiaFQnFqZHEV9qWUJRAJ82eu6qHbbmG9REJ6/ZgJzrGIVTo3QGtL3vZAu
 DSzg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788967137; x=1789571937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aSZ8z+4dWTg3Rjk8/aame/l0uaKJkv5kmAFSENqC/eI=;
 b=OotAVfYBVf/XyzCR1i0aV6VjxdSSHJErOqUvi+xKECOzORnnUkfvuASB+uMGeL+hsz
 XB09TkU7fB718wWkGVE3vtXR7ZwIA1C8agg4WDXQjtWE75dqfaR9qbyHuT4CMDn1Yejf
 alREcDP7aZsl3+PnrTuWKMpLbcokpo86zXbvmgkaPWknJGqpuuUAmkrtPijq1BUor1E5
 ML1NnFyhYmMDYNoIiTjqyFV+w1FEf6Ggts574fbRODfcz/w+eHBCrILwGYKg7t0ZaRWx
 kNf4ADkAxvkSqvGCmmsnqD48US9AQoSTvauf/BPSkRtV+LA5hDkIEXofws0kf/QbQamH
 8VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788967137; x=1789571937;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aSZ8z+4dWTg3Rjk8/aame/l0uaKJkv5kmAFSENqC/eI=;
 b=SKJ6Hl7hEGKeoX8tVTrkWSB8i4FykcDizQEKZjp56ahkNeiyDFAwgfyFEA5wX3cQYC
 XLjz7vlo4jvyw4SQKMAQeXg+FkgNi98eSBQU7zr+g2kmCTAQFRiqF//uXFNY7jXXyRD1
 f9yBwRLj0HdDxCnmPyry7JiCkJT9lJhXWPyyB0yqTYZcB6HWL41aGd/1O+eHm4ScyZ6F
 iJis9F/sy/gO+8voiMEdOAmtJOpgI0AFnobrkWUNb1rs+RTla6YKZR4FhHerKkl2IdmK
 5lIsfWemHCWTPHBAQiGSLQooYLFmeLLkX+YQYhPgGzfF0aefLISwt0Sfff6tQ3xQf14p
 BGug==
X-Gm-Message-State: AFuF++mjJePIvd77w9Uvm6p5P4Pj5wXIUwOtSywUuY793LNTtFKnFN1y
 BMfizWoTO/WdBmT6H7XpywATxvmLsvyJN379zESIreUqGvsDpbvnUepqC1dCMJdbYNW11/tcVt9
 G4/eljrljr/d8G8+ovehUv/ZJkWAANl3MleA3zkJncut6M+YT4tGNl497kXDD+uRGPVi2EzgO2B
 tnCGexbkEvWkLzlOAmD6BD58H9/Zlb7c3/
X-Gm-Gg: AYBFou2WL/6WtRvXBiRFJoRalrB08PdvdyDTSs1G0VR1ZINhjjMHbXYdMk/FhoN55n9
 z2zSZKdnr9LxT801MGdHDz038ufXpyIDQMgfLv/qX+9iauLAhd9XE8I+OEfRBDKgHqFO0kziW3S
 66FkBGauqim6BzcGGBPyq3HrHLWX2oMbS+xSbBc87LZxpX21Oq8WBO4JpWQ/0=
X-Received: by 2002:a05:6820:3106:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6bee53998d1mr1737452eaf.24.1788967137288; 
 Wed, 09 Sep 2026 08:18:57 -0700 (PDT)
X-Received: by 2002:a05:6820:3106:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6bee53998d1mr1737403eaf.24.1788967136856; Wed, 09 Sep 2026
 08:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260909040137.3414132-1-brian.cain@oss.qualcomm.com>
 <20260909040137.3414132-8-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260909040137.3414132-8-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 10:18:44 -0500
X-Gm-Features: AcwNN1U__unf9WrFi8JlsdZJXqJ0jWs-jETnWJq_fW5pGnUy1ez6QQ7Pqm6rVOY
Message-ID: <CAJ+KCYPGUcv3z8=dqZf4OjARWzn5sS3JvCFpY3HMA9J3t6Z+9w@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] target/hexagon: widen v81 CPU masks
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AImJJIpd c=1 sm=1 tr=0 ts=6aa178e2 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MCBTYWx0ZWRfX3j6oeFzxDJqM
 GU9bT8frs6cbqb6ZDJA2cXnAFrAXzYRE4JYcZZUqhaml0Eh6vm8ut933BlrnHVxOKrXg1FbgZJ3
 V4B6Ue3+twPn54r9GKqjB4C8aD/6a/QMgFsR8IZAK7J5HUt+x3+Uszp8Nz3N934tXVlA2g8H6Tp
 OgX5533+0wd1yRt/g3lJH2FXCKVxTLzzfhiwffEOt2imF72zVqxCfIl7+RO0Aj7pE92Yni/LRuv
 w4rsDrEcE6BVsZ4d/yISu17R/uhYS0XiXHyggutRh+iAOjgxm4y1mV75aBUr67DKdF+U844E0fJ
 iwJBHHlYDioIX734yDX+G1GgNMI1XT3p0onPhslCczYUYIyiJ/WwwGI5KJwTyH+MyjKAnxIWWHF
 K65uoceAzwQ1qf+y3yMqRUBRK1xUR3aRxIe3i89mDsBeHM0w7rIrawLCweRsfDP4v/xTtTwmeQm
 FXNFXUR9gWOl1EAOy0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MCBTYWx0ZWRfX5Ohm9sv9YDJD
 9bCjqkMqi2REZcoapJTh8a2IcdG1qUtP5EaFKidwnW+to46of3VMQe7smMJ4MilvYGSD1YYJVUG
 FMHDeenYph73XItSXMEKyhdxjlFWF1M=
X-Proofpoint-ORIG-GUID: A92TvGTqR6MVvImchbVYRZzk6QriwsVp
X-Proofpoint-GUID: A92TvGTqR6MVvImchbVYRZzk6QriwsVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090170
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

On Tue, Sep 8, 2026 at 11:01=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/reg_fields_def.h.inc | 9 ++++-----
>  target/hexagon/genptr.c             | 8 ++++++--
>  2 files changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

