Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6FFCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHlnl-0007s6-Iy; Fri, 16 Oct 2026 13:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHlne-0007re-JU
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:32:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHlnc-0002aR-1M
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 13:32:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GG2rPW2555353
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 urAkt8vhivbyPxcBNlll1PEhOzDLn6GPEzW9Omqgpcw=; b=XKqrqzbE0GWpGjV8
 sVrDRGjPoB/lygSGmsdzXfgRFi9ADn08pGs2S4+8ZNikm1HRsUBD5zDUFfhjTPP0
 RHQMtVfLjAnSOkUFg2LaI4A8HV8zKCRUEf2DI+UjdTtFs2FpHJHloMybV5mSsehz
 egAAjNvnMulB6xIzEOGIhRMIvKS7y4rGFTUqF04fdS9urJR+NYz1SK7lnghviKAB
 dGDetP+2vC+IoYb/DvWcQsdBYZdIpsg6LAhfO45db26nVs3htC7rh6E3N04qASsC
 L/jdjSE/SHs5AblgT8L+P6TG4NG1Zm9epczVZ+KIgunX2LSaLVcpvPe3pwjCS1Wv
 CHeIpA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq2wrj31-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 17:32:52 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4c7f887ac6bso318245b6e.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 10:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792171972; cv=none;
 d=google.com; s=arc-20260327;
 b=MX+Mp94tam7euheIhESarR171BQMPovvQ/ObIbbDpAVx10jqb4VHpqfEADvnzerFI+
 LWwh5+QIJnd4jHH8CW1lyKdADrJMu/0IQB5jtRj9ig+onXG6oSDEnAcYTrAFBic+YXO2
 8kGGKwK6uGez3k997hwP5ev3w3KkRicBet7dq1jdBH1cHSK/XoeqoFbIVQU3KwCjdPqZ
 KwgyZcwjP3FYw6BwKr+hCoNsAAVp9qXQREpdjuiZtRWq7T/dCeA2wX96XuuB7pny26Q/
 tAj8ck1eZa7X8fb3/7l+bMKRSfA/Pc2WpAUikIrVBTAXAGkUaD0aSu7xldX2r7V7QUkc
 6tCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=urAkt8vhivbyPxcBNlll1PEhOzDLn6GPEzW9Omqgpcw=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=TRsQIxEWeiX+yvwepfCX+XmqRgeKhLdP16yDtPWI7tNKdJxoCrUqQ4pM8yODBCUK+E
 MlVJrtNsOYmZXBHzn4EbLEBSEJf+vGM+PP7DD7vKUIid8yqVkQTYWJBJaNitBIThTqvR
 mF6qjYMtRVkRonm2NT/snSkdWb8AppprxRreymMvbgGPK3XB6OArEi9Xq2GPGf7TS+J1
 RKnB9p/Tsvkuk2LCZqzvY/z2VbT8FXzK4i7dzSo9vpcX2uwRNlNdS94Sl0aWdnJK+Dc7
 oXmdLkDPb9moT+VA3zA0Mx6Z68Z38ITxas0zEeEhw1yCJU5dc5fcsGsGKjCwQmQgxHi9
 gWXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792171972; x=1792776772; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=urAkt8vhivbyPxcBNlll1PEhOzDLn6GPEzW9Omqgpcw=;
 b=O2O9li0Mw/zLyJ7J/TCCSGEZAcEArEdqaFI/1gbI3+dNDgzc/gvhV52KFvFXUY++60
 9l4lEjqe/YWiv6UM33wKG5bGSq4jr1bC3EVbQDegbPfylrWdAmx1jKujIJlvP7kidzjC
 JRcp4U/u7LRHjWSkeNynZzGY+yAdTfY4lBl/wFxUGDtiyYHzkboPAYis2F9mxwt6r3Zv
 pM6X3SPUUcNvnqMD0X1DLLPLn66y+WwSJr2jeouPz3BnZfMce9FTmY14fZ5QkFz7ARob
 zrlcLTfhtjlUy2luABso6+YVtSG0Su9CKOipEKt/bkj5aIHup/aNf2KOGaedQv8pzb3H
 5ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792171972; x=1792776772;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=urAkt8vhivbyPxcBNlll1PEhOzDLn6GPEzW9Omqgpcw=;
 b=jXK4JT4vbpnZ/96wobRUBATdxCUydS9hXYt9GXrP8svqK6/ND09YQFFekw0KEe+keU
 U+6QiSE4amTCIa6AFcvx9NIZZuDkYvK78ZvdxPtUYVltqsNSzPf7DA2hY1JUzkqXhwxJ
 XaXaV3ano9MEJkKwpxiv2NTlWvDI8yk+/GY+fivbYYZ5OY3X/L0451wijcjd6oLrqM38
 LI4H2YSsrCq7J5Yc5jhK90wxFl5oJmUh1iKAXtFufKE4SdyHATSiGvcar5awvmzR8WoZ
 0/yCC3XXNP+QOqsC7UZ3DGMYAOzbO5MRfY0mJ2FUABNY+MbktUCR4XLT2wJmoOnXfdya
 cqWg==
X-Gm-Message-State: AFq9FYJbaT+i7b08dd/NkiJnQn5wgDYtCgq1uyHfjDZcPMQDEM5O+4Zk
 Q/T5whFbv5KaZrCYWTvvn1LgRCN+x3tgxQg49MOOc3JwSdK5/yqTR6Qd9gPhba37RfcUstWUHjQ
 k7X+RDIJkl1s7aOe29JoaWiOPBXdF1wyo9ZxSKKk/iAO3fL0Zyvle67y2QWsjkxDpe4+GNYuxhK
 PyASEIw1fSIfPBUWCBQ9UxFpXacdVbetlP
X-Gm-Gg: AYBFou2Ad5SQDU/zzVLEu8Gyg3P1eaNcR3E0tz4Klsp1K1Ah1TTXqMj9LAxXaeqyH52
 JDnFXQcDeNlw0hrc2qBr9UsAs4EhNhDlLHwLZEYpX2sOHgMIJ+LwLr98uP2S0zMAB0MfRr1QV7m
 ncPfJN9t9AnjqXe1NOjpWmorNfKduNjS578PD4dvyqzJt83iQ6lCJNXtNLy6A5Vez0gIOWQ3Ria
 PCY8VhalZqBVrGiAfU=
X-Received: by 2002:a05:6808:4f6b:b0:4f5:1cd4:d2be with SMTP id
 5614622812f47-53cb63c8551mr303477b6e.0.1792171971972; 
 Fri, 16 Oct 2026 10:32:51 -0700 (PDT)
X-Received: by 2002:a05:6808:4f6b:b0:4f5:1cd4:d2be with SMTP id
 5614622812f47-53cb63c8551mr303430b6e.0.1792171971302; Fri, 16 Oct 2026
 10:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-6-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 12:32:40 -0500
X-Gm-Features: AclHuK8Rl_6nDoGhXFc7n3uKUqb5ooVxOcmYEsTb99LiNCf1eLUmb8h42gmQJkI
Message-ID: <CAJ+KCYNetaJV-ZtH+tm7HXdWtkEHEBec=RMcp4_FPY9aW0VzSQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] target/hexagon: add v85 scalar atomics
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=WIHqzXsR c=1 sm=1 tr=0 ts=6ad25fc4 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=Hab1Rms8iICtnJC8O6cA:9
 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: KRce25AJ630W7lpvN_M77GL_F0BmYufy
X-Proofpoint-ORIG-GUID: KRce25AJ630W7lpvN_M77GL_F0BmYufy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OSBTYWx0ZWRfX6Vq7UkJhCLhs
 t0J8uCzC35jSDW3cP6n9AydMZ0p0xcBeFNXhaK5upueUn6jvlpX3+Z4uOMK4DRKnaqPUO/fVOph
 1GTBnGUvz3XsOU5XoDrzd9pbTGRj7rWl+E9+L7NzuDrf1bQ7HeYIAS8KrMc3KpYfoSR6JIwcp3q
 1Vik9gHQ0uu9VwNsuPM36K0pggv0PqaocUF6sXkVvikXEgWuHALKUWQP37m8tTNW2R1F3su+vWo
 8Qzh5Vb3WfQH/2XBxSwQd//u43lX6zvKB3gQSFoD3EH1tLrRqf5uK2FbI9sXf7Jv3XqOFDpeHum
 7bTKxn+F4kRb5JVHM96OlAjLBFno+U8sGfInBSnBZQYbtd3j+iuYseOUZ0AOUcgknuEWdh4bN3k
 SD9I1s7vKq+Zg2roS9yKO5I/eKPMxbmkF9m4No31suofSd5NySvhUNZb3lIyb5umeRek6HUy8Lg
 Dzdud1EYDBnmYWNzTDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OSBTYWx0ZWRfXz0lcy5x8jv6r
 iWbWc2KV6vb5IURv1/o2Akura+Eq1AtxwAMBh8q6Y4OeGWo37GfSKLF8TYPdKuHbqSr531DzkRK
 JtetleYc6W+qJMEjnREn0ebplTfKRkc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160069
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The scalar atomic instructions are able to perform a word or double-word
> read-modify-write atomically.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg.h                | 27 +++++++++++++++++++++
>  target/hexagon/genptr.h                 | 11 +++++++++
>  target/hexagon/attribs_def.h.inc        |  1 +
>  target/hexagon/genptr.c                 | 32 +++++++++++++++++++++++++
>  target/hexagon/tag_rev_info.c.inc       | 15 ++++++++++++
>  target/hexagon/gen_idef_parser_funcs.py |  2 ++
>  target/hexagon/imported/encode_pp.def   | 15 +++++++++++-
>  target/hexagon/imported/ldst.idef       | 15 ++++++++++++
>  target/hexagon/imported/macros.def      | 10 ++++++++
>  target/hexagon/imported/system.idef     |  1 +
>  10 files changed, 128 insertions(+), 1 deletion(-)
>

I wonder if this commit should be split into one for atomics and one
for the dcfetch
instructions? Or maybe just update the commit message to mention
dcfetch as well?

