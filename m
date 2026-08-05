Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044CEC56205
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrilH-00070C-Rw; Wed, 05 Aug 2026 17:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhrA-0005BQ-Ud
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:04:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhr9-0005Z5-Lq
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:04:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSOQ33890598
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 20:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Dj888ZneQtPFU9JZ9kwe8huCiF3TYAa0iTvN3JHzrkQ=; b=SBnFrWiNU82ZNj2N
 dUuGZuswC2dZvFRPVXz5P1DP5Ir+t0wMadYBhdA6nALXPA3F8va0xToXeNTtQFSo
 i9G+J4SCHrDRyJLO9JOZp+ioL+t70fy1COUdKCMvO5i2So9qRqeD6zgtpRPcVZ5r
 JcbcIKGzkk4gpOP5MUeRdktYULIgNWecYkswNvQv1Ra6s0zT80qNUWLdZSJVhd9L
 rjHYHlxXHJdGvbtqWGIfyVoNXJhOijf6OPCDWgS+kbozKyBAf30BC4oS9anKn2BG
 Eh1PoJOVdBtWhSuU6TKvhNu1zZUrA8epem5Pa0hG16KhRFqcgMiP5WpiIAWgn689
 XJyJ3w==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14wbb3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:04:50 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9dee2f7b5so1873778a34.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785960290; cv=none;
 d=google.com; s=arc-20260327;
 b=e5qNLprKXoeTEzLI84Ir4gQK9jEERkitdQMs1UKBTbE1wHUXUdO8D44NF0vXyhq4Tu
 LYxOd+RHGUK1pvGARW3e9+Z54YLzqAu3fpurYf//+Mdt61tWblfs2WzOPxIoFuDmacZ2
 WWIH+N/uofaiJJ2M4qw3LO1T15P/+eo47A7rZs2Z4W6Me8eO08/m+44ZRzRVYx5z2U/0
 4b07ZgmvtC6pPUOkzytseGnIyUf0oMmf8cfysDYKJwlSQs8qCprR8jCFLp/h0Hoj0Cwy
 TVBkRcMn+99yOv9RTohm5351EX08Y3VCYFeyjDZQqQjY370cbLUv+nEudP+Xv7L5DZGS
 +ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Dj888ZneQtPFU9JZ9kwe8huCiF3TYAa0iTvN3JHzrkQ=;
 fh=Ojiz9TE6n0gwa8Sqy4epYViWg+Us2CPvSyvRXAzRpcM=;
 b=TPAbYozRScssVSz2/q3CjVz3VVMjAdgOqhRnFawD8TZnlIyPE5+EZ/SfMvnNnITFT1
 lj0Cl/r8C1NMwb35xAeksrANM4pAM0wYRabubvMtuvixxLQXI19Rz1zFpp7pBbs9lkhy
 ymibLePl87gDg3HzdCGqEuSuPVT1g4JhyQdsZ+5CHVuvzUWeHIUJxCWEDg55P6CsiN7o
 w5hj89zGinweTou3RdN5Etam85OCdXHKkJ16OlvG/Z8KRwiWWd8N5YcWn1Iq+QeTRhN8
 XRtAnqNmn3nwYYTf1vndIjeuikiorGZx9tMX3v4GeC9lnxuaa/5l3I+muJUsujqXbdHI
 AWMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785960290; x=1786565090; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Dj888ZneQtPFU9JZ9kwe8huCiF3TYAa0iTvN3JHzrkQ=;
 b=WDDf4l2XVKxlymshhxoKLUHRwTHCQZTg3MloUW/vpLRaC+THfxdnJXbbKUkL3VdR32
 0p3cLzIIXrfJk1NOQlbwCppO28MNnH42BTVKfaa7Ub4VPxohbQxxXT7KZ6qESuXtfPjJ
 5CLk46zcxPZC8Ztw5Rc5bgfFx92m9B0iLoTgjP4IfrwWXjRUW06X3YwjlKLecl32e0T6
 b2woMR914y6fUrDkpTdvLzlluX9esgBOUXhx8kSvEot616KEPHF68BB31oceJJTCrd2S
 k39vFHIexL8dD3yg9zo0KBzkZP7ugZWomqv0EjRb3uCGk0vE9i4U2E1KPidbtM9jXeoD
 0yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960290; x=1786565090;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dj888ZneQtPFU9JZ9kwe8huCiF3TYAa0iTvN3JHzrkQ=;
 b=faxYWSsRpWpVyvC+BgXIyEu/xF/VRxFLi3QIvQ4l2Vb+Hb/wUN7pdXnGyJzfaNPUTn
 qxxLIbydXMZVqSbz7xZsbP45dAc7MwzbRplEeT8i1RzxtoQ9A1wxzqsuzQ8fEtWSbIOA
 E0pQWAJaKmoz2ibkx46sjPXllgelci1tfBqvMqBSxJ4OAttG8V2D+PJpOQRXSMv1kLNh
 BZtXihOaelQXJ01FnPOTOdqi/d2dLCu4h/U/HMYHt68xqi8UINowroFYNPE9p/D7kYx5
 TVTXvU1zc64/nEmYcYKJW60Z5LP38zob00milXVXk9AL/TN1oBLqq4+wRwx+Q9iFI+vp
 bqbw==
X-Gm-Message-State: AOJu0YyIdyA7lVdEI8Qa83H/EDMsG29+6utdo9ee8f8p/CXRwHkGPfBe
 747MeldoEEBSw94RBrDoQUMnmLyq2GNl8iW11rcyjINap2BXRd06eL5alooLnUk8KZ5BQ6OXgY8
 LMkKRuLOcR9yULdWgTirlDcuvNSUxGpfkL5Sdh//icGq86Kq0cyCBnAoBL7FZbCmRBnoX+iqM2s
 OzAVNv525muxqYHJ15lvX6p5RvZRHM3GFT
X-Gm-Gg: AR+sD13Uam6jGaOcglRS0qkbMLyYJ3MdvfhAjFwm3+MM8Znu3opRP/Mhm5RCG5xcTxi
 snGxMqg+vtnr9YB00XGeIomEeTNrEY8e0BxzUcWNpH3riGOE37dKUwZ0rGCdu/HM0YAjdxgT4aB
 nBvzES3IBMv6yDfdpMbEC7gWZbqXfiUVrOwOTr1Zvst0+IWIE2MVGcQXNXFMk=
X-Received: by 2002:a05:6820:826:b0:6a3:7af2:90ef with SMTP id
 006d021491bc7-6ae96bafdd0mr4445179eaf.6.1785960290086; 
 Wed, 05 Aug 2026 13:04:50 -0700 (PDT)
X-Received: by 2002:a05:6820:826:b0:6a3:7af2:90ef with SMTP id
 006d021491bc7-6ae96bafdd0mr4445150eaf.6.1785960289657; Wed, 05 Aug 2026
 13:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
 <20260805165225.3117924-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260805165225.3117924-4-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:04:38 -0500
X-Gm-Features: AUfX_mxRpUNIyXhmPUlpzspinyMZCVYDMqkr5Hm0VwwYnFS5tj3_JMoHesEaZs0
Message-ID: <CAJ+KCYM8aCHTN=byQzPoWohV5QL9=u9=OkMwsiZQfuwHp9C-xQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] target/hexagon: add GVec override for HVX vmpyih
 multiply
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX7VX5cqES89zm
 ejBVWxtl3MQ4GADjj2QkD2/9u8D4hz15Gf+P2Y9IuCCxMgMLDiLLiUjBgP/7VvRSN+SN6tszDQI
 LP7GP2607WiIRFWiV3lN9uoFefCiUcY=
X-Proofpoint-ORIG-GUID: D8ibk8ewJrnfV5bwDBJLNYHpm_jQjAg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX9osrAD9gt6Kg
 ntxGRW9ERyy7s7F9LRbE9qMpQxmh/b9XvOCQK4zVYX+Tc5J6vqdZvznsSaxV/IBgtPLtNqVT/J/
 NSbTC7S6QCiqQP0GpVPHzG+u5sKRdURu4d1DddlWC9utPQRBe4yPEHlO3uAxnC4xtzRrQyUvQHM
 WC8kS7Cd3FqUJQKRMaM18TYKlW5I5AqC1vqdX1I7cqHM5qB0zZ0kpCYnnglbyOaV6DkFXtIxvzy
 kTj/LZsVfPPAqb1UWVc4tumCT2O/28NoULiVbkOhPyUvQ7/5kn/eMRcRQe2Cr3LT4b+/iIAs00K
 XPGxUywj249f/BJeUvVv/GsTMBLYq2QIdILLxhLBiNhzFmLIN47gIhM3J/a4D1ksBdJKPt8o+zo
 WsgU7FfgIsr9/XLZAJZzk1O/WsEEBkdlulyj/GncupFsi7Bo80QqWV73Sas692Whp9edeOLQqfc
 zntU4O3juIBuTAdO+cw==
X-Proofpoint-GUID: D8ibk8ewJrnfV5bwDBJLNYHpm_jQjAg2
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a739762 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050164
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
X-Mailman-Approved-At: Wed, 05 Aug 2026 17:02:48 -0400
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

On Wed, Aug 5, 2026 at 11:52=E2=80=AFAM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

