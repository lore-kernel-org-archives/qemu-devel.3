Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4859C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lOP-0003VJ-Vf; Thu, 10 Sep 2026 16:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4kvu-0004Um-Ah
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:59:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4kvi-0003WA-F1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:59:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68AIRKdi2607337
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 19:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SrSOllLKt4tQyoJeRMYQEHo8PAnN2Zr5Nqpz+WuLwX4=; b=SvOgWfOnhuRKJJz7
 /XI03diCH6cCubGhpJd0ECyj9rFZC0EfQUogbxNrWsFGoDHu4nNkKewamUZYUpzn
 xorfbMUi3sL9xv2AJRnPZyH/GxZdE4dY6AuwoX0BkgbJEr76sjSilTNptkYR+8nr
 SZA+f+obAnDE8s4zNJ40lXiTSDm7fP6QBc2KgNS9FO5MJDUtbyPc55lUctsx7shK
 4RINstfliWEaIbH0aI+fWICANWYTOS0I6H0Z8myFi7UvOsn3ASKKREcVNMUE3oFN
 JFk0HdmEoR5WaLjpwvIATn++0llU0JLhl5zNq/3NAnieuAB0WfZ50JM9WyNcrZ8F
 pUIVBA==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkxd8sbbn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 19:09:17 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f1da5e5b06so121641a34.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:09:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789067356; cv=none;
 d=google.com; s=arc-20260327;
 b=dMGnyxhc/o2zv3y1QmDk9H1ID9+WdYdKsWQkPL69ZxLN64RAgB+ir/0qzDE/atQahe
 PyGw3St5WA9xkzJTrAmNGuhQsnT+WqLVi9sYW5HGHS1DazlmhCSVWJ8Odn+igOoFXhC+
 lpxC3HxH3ItkmbrSSg6MXQ1swEHZyBTBtOw51hYXA0gg4D1xTMKqrttXsnoZ+EUggJOL
 jQUex8nbfszC5FzpePw+KCvkbzGNlwVzcTakpFc19WaS38Z5H5xMv0Vka4eEgvPJHx0s
 WWp8eRdOwMrvfm2a8V0+V9xCBaibI/LZNsdMySdrv1YOcksZ94tVHuuBaWwOImtWfdny
 7Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SrSOllLKt4tQyoJeRMYQEHo8PAnN2Zr5Nqpz+WuLwX4=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=VlOaCQgYqzxZc1Cx7aR4feZI7ktx6290FgQTAfYADyz15wWSwPL5/V33LvhisD0+WA
 wwhOv1WgvRfE+rJzP2KaVSwrY3ICNseYRiJ0bJqm4r6IqC/4R2vfrGe0ga0NDNbrTg1l
 Tr9KbkdjM9FTb2+9YOk1ooKEBuUN4oGXB0JdMva7sy699GjMGJyy5QpcvdvtL1hkdngQ
 p8XO+s3s+2OR/gF2uxnIftM6g0/2Zi7nPO4dBZnHzMhe58LdOVkVpApdu2i63VnGjkGB
 pPHe+ah2xw3Q1dutJzXTeJW2ojKoN5NcYz46Cep15jfIKxO7gSZ0JfSxDv0JWjSLAf2V
 e6Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789067356; x=1789672156; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SrSOllLKt4tQyoJeRMYQEHo8PAnN2Zr5Nqpz+WuLwX4=;
 b=isa0HR+V0pk6ptjQf3u5VRi+HtUxMwPRlcUbdXoLBrugPidO1U95tmP2jiC1ol4y4S
 GdQe5a2T/r6olfhOb9rkyGSXyS/cj27RicjkwWwB/p6F52s1Dyujj5uloPW+8aPbXvAA
 HPYbBDYcJYSr9IktpHojHIBRza2aOb+u1Ytwox6JcHrmULEv/efeNysZr1Y0Y6wtkcry
 AraerT5a+dnw4oVgn9nTCUMmwiL0TEyQqfLYtfPahfAXDobvkPruUdlxLNCMGgka4baj
 Nx18b0X7TPglMYDvnhx05bHPcDQ8L7ayk0IUpKrb7XH6rOAWpX5c4VVv+bZYmeOcbN83
 Xguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789067356; x=1789672156;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SrSOllLKt4tQyoJeRMYQEHo8PAnN2Zr5Nqpz+WuLwX4=;
 b=ZNm0p5ioDIsaddkm9LYKHjkGfTnpGO3pm7d5qCAIfLh1+/N1eFNDAxzsbBH+sAmSk8
 GFgC65IUuAEtZyViS9tgLs0X3Jl2nejdgEYLXbii9B8aUsymePxBPpACFKZA+aNLEwEm
 l4RBZDf7fcIKEd/jfrUdv1SOPxxxxw94+ALeDeB+sMiwZEGE6y/2AmXA3FZVwhAflt1r
 eElEyh2noEcycRtYSctN/+OrDT9dlO9rSeOC+qVxP1TKvbjDA9vUdrT8BURXwCTj3xDs
 ARQU77X98K2B5zv+vrL/RmFW3Zpn3mWVZD3oqgzBzKUqZQJ2SfM2FxoLSNiy5kdBUuyT
 1V5Q==
X-Gm-Message-State: AFuF++nZ80RHNizlmcgMi49YTTMy4SdW4KoUkr+NyAlgQW4kjxcjxesp
 jdWRlyXUQ9Kggz8VMR/6Zb9+ZWIN1SueALBmFXJo6Yt05N+Ugc2QhskgzDXY4l3GP4J4XpRVUiw
 EvL0yk+kui2etlJY31DsEQIm+e//SHlq2wu3EotWAmvfmTj0cCNXqRGW7ODj/AEWC5S+XGfp8i/
 Dg4cwuUU9xAcLygcp6wmV+KCz5SHzTzdv3
X-Gm-Gg: AYBFou1DF+kO7b/LX2N31EkfLD/FiHypWcFJho4LPRwpxpNKlb32pTuepZlKI15tiKl
 4YwC2uVVySaDCVM1M7T/fcHjOIILaIlkdUuefBMNEgiPWoB7Bg3HLotpR+oA8342QhCI/7uRg+A
 4yT76hCsgiRC6a39cwWTqjXuCgPXkx5ih6UKkOARsjc8MB0a3+FrH98D4w3yE=
X-Received: by 2002:a05:6820:c3d5:b0:6be:354a:1cec with SMTP id
 006d021491bc7-6c0bb3fabe7mr233309eaf.27.1789067356404; 
 Thu, 10 Sep 2026 12:09:16 -0700 (PDT)
X-Received: by 2002:a05:6820:c3d5:b0:6be:354a:1cec with SMTP id
 006d021491bc7-6c0bb3fabe7mr233300eaf.27.1789067355996; Thu, 10 Sep 2026
 12:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-2-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 14:09:03 -0500
X-Gm-Features: AcwNN1W393Bj4BT4PQ8izJXeaf76EddXRrkMRaiRACZif391BvMVBK5TRdsMQv8
Message-ID: <CAJ+KCYO-5+7ziCMbD2ABU0p3wiOG=BAe37X0iovJ_9344M=3mg@mail.gmail.com>
Subject: Re: [PATCH 1/9] tcg: split out _var forms of gvec logical, abs and
 min/max ops
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: glEGI6zVXAWoR4tglSbvKuayrac5hYY9
X-Proofpoint-GUID: glEGI6zVXAWoR4tglSbvKuayrac5hYY9
X-Authority-Analysis: v=2.4 cv=PchqFShd c=1 sm=1 tr=0 ts=6aa3005d cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=LBq9Hmfkbuv0vwSYwCYA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIzNyBTYWx0ZWRfX9R56ZKVYB9aY
 M9WHRjfWxuce+scS2x9foDqiwoUxTGghIs7iysbdCHT0h3GJi7rjnTmACnPDOKA54hKRDC/E+bP
 Wsmg0ItHjEsuoYHh+b5Mn7EnespLO9kJlU4mk+zLfBRW/3TY8H1yVzui18HnN85cz6rV2UuoWPL
 wzWu5l0ycyniRXbO+LYMRZvk9dovDF1QFuT76oXY5HXQ8tN/xyVxVG4LUJ7KHBlnEW8lHbKrUfO
 QyI8nirIDWeuufQFuIW9yvzno5iXJOSLmiGoasbkUfnVTPoMvAhW/i9DnEf4wjWyj6boCKLQT3s
 d9NYY+HSs8xld2l0yIEo2Vccr7kDny43AaYg3iqZO8jlEG1p16Cqdreh0TXTqTMiX9qnV9AbMO8
 yG0WcVXSFU/XRrC3Ha64muBKXwToqm1GzfBxo9w2MLBGkJqy6nhdO/WFiKr9yecsKiKtv4KWh1G
 TLEDeHGOdD3JmE3mnCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIzNyBTYWx0ZWRfX7QNjdjuW6Jx0
 5O3H63InEO+AnYM/pjm6KLOH5j249BS41ouUttbUOmVDh+ujXNWhcJQYKyMfs41E5Zi54fUifde
 +y/LsfWFN+u4FUkKbx5Ll0R0+1dkIrM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_06,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100237
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> target/hexagon is about to address its HVX register file through a
> runtime base pointer rather than a constant offset from env, in order to
> share one register file between several vCPUs.  The gvec ops it needs
> have no base-parameterized form yet.
>
> Split tcg_gen_gvec_{and,or,xor,andc,orc,not,abs,smin,umin,smax,umax}
> the same way tcg_gen_gvec_{add,sub,mov,dup_imm} already are: the work
> moves to a _var function taking a TCGv_ptr base per operand, and the
> existing entry point becomes a wrapper passing tcg_env.
>
> The aofs =3D=3D bofs shortcuts also have to compare the bases, since equa=
l
> offsets into different objects are not the same operand.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/tcg/tcg-op-gvec-common.h |  45 ++++++++
>  tcg/tcg-op-gvec.c                | 184 ++++++++++++++++++++++++-------
>  2 files changed, 189 insertions(+), 40 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

