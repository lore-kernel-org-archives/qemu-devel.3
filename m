Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BEAC88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Xly-0003VJ-T3; Tue, 15 Sep 2026 14:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Xlg-0003MY-D0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:20:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Xla-0000lK-1e
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:20:29 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FHobY9229806
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 18:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lG9Tegn9NIZ6/X2FNYpUxQ9rsNcaQASrDEs2UmJJbx4=; b=CSq5TJNu+zra778L
 LyqOQgDCc0ztvfzK4rkAn6WodZDNDrRkYDHQuJ2R9CXorFInvLLb+aQDFtbHiegr
 64BQToqzTm9PDpVq4SwCyOHdlNsP0hSWPC+9Vc3IxB3kpzBXOmK0/aS28QLAHdPG
 US6VnAV4OvTJTENo+9fe/PqoZxonlyPXJWabr5yrjDm6hJG6bKgLnrGCb6hKOEHc
 QCXuEM2PiFTmURL1Pr3sHbBGWCvEcqMu5EgKaTkDrHrYs3fYndPDO1jsqLl+cn+b
 tfumWeSxi4as4KZI+wgTPTjLjZmRsBvTLyFRJ8QDouEnx9XUq6jaF+02Xc1i+qVU
 R7A1kg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqah9r7yj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 18:20:22 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4b2fb8f0df0so5812880b6e.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 11:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789496422; cv=none;
 d=google.com; s=arc-20260327;
 b=dW8VRF5y9gh4uyu1K8JbKcYiqRd0hNc+Sqq0t+tWcDkQt/LPtZGJD7JX8H0SUrIfzg
 La2ctXunLq0nrZTQYmelM7fbKYxe/jvqk2PueFxbZt1AWdOj3pByMkmoRo+mBan6kkl/
 1wyRn0CMs95/NafGjZjg55tK3DnNNivlBXlu/l87D/69bQAl3fs4eK1Vl4ImIytHoYTb
 irmWoCxlD2GjEiNWb4QiDZ1FcEgF0C+cIgzA5pybZnJecQdAS1VZ84ZiZq3SsFQFM/gE
 orKhcv7RXAWCdraUnurTs4GgVucjYf1qAdx7sMSTsvo0VxsOdeFQI5e+wcU2hDbsuQEL
 gUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lG9Tegn9NIZ6/X2FNYpUxQ9rsNcaQASrDEs2UmJJbx4=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=QJgzwRiwU0LscbkTJbw2rh7QqabVDTYUCFtk8sxguLao6l35+dPTuoAgK5dd1Xlg+k
 9RyaXCs2OFJHKtM0mUASKnk6oECpjloRzFUydl9F9RvpLo8fvekkZr/ada1MFUauf/jU
 yaP5tsHyobCMFgnFSlMYTUgCiVaxqzE9OX8eISHhgclUdG7oYpU5sbse/5deqB+2022h
 ZV9mkfNabA9qPvDa/VTTP2tKd+zjyCaLFM7exN0XvmViFEvov3nreT0FJnY1If4eAqDU
 bd6VZrw5WS76vUmkDB+L++sRAKQSZhDjkB3vynmx5ll7g80ZhNWGCo4aC463AAaDFiuO
 773A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789496422; x=1790101222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lG9Tegn9NIZ6/X2FNYpUxQ9rsNcaQASrDEs2UmJJbx4=;
 b=TgXTiAAxaWmqjk/fgcn8B3ClYGl0cCOvE+gtqarFGfDFTOxnU+fGO+odPxIJBTI/kk
 bYWZTLCwlMhOY4twlfp1WzPlq+k50P7slN262n+CzAWl2a2yo+JfTcCIAnMgVJ6MyahV
 JMwiAnADpR1r2+zLUA1tyqfXA2uXWPrSAL9pmQ0Aog0KU8klstZ+LLvrRotx0FQhKjhV
 UKn+x2zg0JNFqPw3lhUnUR51u4B0Sjf3ZMz3Xo00+G3X7UfZs4j3KnIBBaPTtcfnwPX/
 Be7hNGYsaU85N2BDJ11W8XrKiP2IAhNUNof0EgJfb7fMDqp4IYlSXztE3NsnKRH6dqON
 CU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789496422; x=1790101222;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lG9Tegn9NIZ6/X2FNYpUxQ9rsNcaQASrDEs2UmJJbx4=;
 b=ZmgMXC1rOBLkmd1AiqcxZGG28tMbQCPYcoGWoncoFuHEsgyBYmh2/8tEn0svfPcrA2
 tctfp/aPPqRLbxAVqxXmYU/jEmkf27i3BfGNN/hQUnnsfC27OeDpn9797yxCm4f8Tq9T
 NxAotgZffavg20jhkbxWZ31xM1aq+pMyeljO6U2D5NrV1cPh+rneD0xrOekgwo3i7YW/
 zyMzFFn7qb+q05/pMC2XJpQYgWtGxdfxLsUselYoI7ErATMzumau5YE1R3guRJJcQ7hm
 Xo8vIx22KjbW3naKU0m+eVbOSkgNf8B1P7sfi/PRe/Q5WKMG5kFuxcb3RWEXkg0ICmWy
 6IuQ==
X-Gm-Message-State: AFuF++myzXUBSrGR46AOR9601oIA13gZlJ8cWVtgBa/KpgEbUztGpopD
 m2GHHuuvs7OjdRQTC2FClAGwoSVQoiQtC3e/eFFxkHlJjEA9F+LXRlKnVqixvXP91tqpgk+S9+w
 8ap8S8aOlPyARILACqYUhkx95wo3wn/cfMsm6WaNCSUGiiigZjK7rKNFK4q1C+bnkNsmEHSpAQs
 joPMep3pmVJWDADdqnu1ore/Sujn2LPpKl
X-Gm-Gg: AYBFou2N6h+/AsCZyyNEdVLqvaAtuEV6HwC45dJLlnHgF1KdZzzAQBMmNBNudE95zYO
 g/DoZMdpBn1sDwisyTlHq1AxgEqhp3xPhKl1KUu6g+VuaLEd2rBX0nCNuUBYFegjNp3n29TjDj3
 u/2ih/o6r0qccirgQ9l/mRLEB+2pu2zyZIryl9q/+3RdFCy0AhSlP4HUtXNVh6R/kqGwurO3EjG
 Zu5i1goLMm2SLXu9rE=
X-Received: by 2002:a05:6820:290c:b0:6bd:a88f:c8c7 with SMTP id
 006d021491bc7-6c7392a8f82mr1718531eaf.45.1789496422111; 
 Tue, 15 Sep 2026 11:20:22 -0700 (PDT)
X-Received: by 2002:a05:6820:290c:b0:6bd:a88f:c8c7 with SMTP id
 006d021491bc7-6c7392a8f82mr1718494eaf.45.1789496421651; Tue, 15 Sep 2026
 11:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-6-ltaylorsimpson@gmail.com>
In-Reply-To: <20260914215037.157879-6-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 13:20:10 -0500
X-Gm-Features: AcwNN1WiymiD9Xd1najyyQ-x5VgMLb2sxElKbV_z31o76L5mBa2bFeJZjNgAWrA
Message-ID: <CAJ+KCYPYjeh32YLYvcJ3meBuAVhf0=ANeSzuoT9p99Xcfju0TA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] Hexagon (tests/tcg/hexagon) Add tests for vreg
 multiple writes
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BtkIUoX5 c=1 sm=1 tr=0 ts=6aa98c66 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=oiUj86p4EGMqR00RCskA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: S0nRllArdkRKhQoz1rjtDdCgiktEL6gI
X-Proofpoint-GUID: S0nRllArdkRKhQoz1rjtDdCgiktEL6gI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2NyBTYWx0ZWRfX5IO+xgKrEFrE
 ARfO/KV8YP2A6ck3JF9W0OIPpDLGTJq2GVCctTdsgV8GzIYU7272y/0zWIop2o2sq9KsZTPu8Pb
 VZfUTkWIjNWLlOZQROZBNvG+d6kteCV3BX7BVzjeCiha/HtcQUv+FSsZESaHJULeZcCLmOsuRjZ
 fweCnN/cC7THdZ6Fb1SjlIopf5dvGBDOaKueSbkZrq/TbvJi/jXMixSrbeehoYzMtxHcom4ozAN
 VPTtTzkR7UVHRNTUpu++JU/WwbLnOfRy67F2wIUo62jVqzxgIqljDGwux/FfGps5e+Zh5Tlm/ne
 Yvd7TNjl0LNQhwvAHgKjkiAoE2MVRc+EtXjeMjadOtRhd6As08KiD3g+mcHsr5e7IM+O2RlJstk
 2MyKTxc0apLQxtAHaZneXbhQtXVl8z13ARnuiCbnfdW+QBfxvCV0nSOPIaRuoAyS2NMhMdph7+r
 LBm5BwVWbfkXncJy+Tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2NyBTYWx0ZWRfX0vbpx5w2ZJhD
 EOcB9OvI2PtDIo+Op/AZu7toQp0/uqz7oDTKrVz+WdJJR+byhfzHrOPj70r66674oPQ7qyEfPBi
 XYdT2iBZ+1o+yEKatHk1jVWXJcXebSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150267
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

On Mon, Sep 14, 2026 at 4:50=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  tests/tcg/hexagon/multiple-writes.c | 66 +++++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build       |  2 +-
>  2 files changed, 67 insertions(+), 1 deletion(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

