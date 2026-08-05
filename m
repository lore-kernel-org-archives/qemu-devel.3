Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF83C56207
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrilG-0006zo-Df; Wed, 05 Aug 2026 17:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhrf-0005QI-Sq
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:05:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1wrhrc-0005ft-6B
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 16:05:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSCTX3327145
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 20:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CF/5siN2wInOqXXWq8cV1lFbWyknA6g6CRVYxIbYoDs=; b=CnhhKdJX8IMvLgF0
 QufnhE+Z/gstplNrNRqS0Hpx2z8mDVtn7gBj+9RmMnEJWt7HEijfpRTlPrGweObY
 E15z9PqDjsPMBgWvZvyczAVeIhOFkAoSSIPSRe10Z7P5iHZN0jsN3ytqvMNC/L1m
 gZqhdCGh26gewJX7il7p8wXh1qZ0XVsOoQXN5GuYapc+lBn47V5F3U/u9cflsXln
 HtilNr/rSDsVE65lihYAOwEvxa5JUDlSq15h65wicsjQVUBzr3i3f6jw6PMzlrKi
 UemKKd1WLCy41w7XTXvWU4E4bBsu5N1HQte7rXrpmyFQ0yTBsyUJ2VmVtBbiEepZ
 kotaaQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv1qgb1qk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:05:17 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4959c49e054so901273b6e.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 13:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785960316; cv=none;
 d=google.com; s=arc-20260327;
 b=h1HXhjQofVzaS5YeSXm/TylAYQOeEwT8dMhHWyb/yazrOcaQna2DESRObniwxyJBfZ
 STqmksmOy4uKfSqSjeZJwY93IXy6Fd/Fn0kzT9STOgO4QtVfLISNi61tqa/aY4fFFYzc
 MTZPK3eN+fnNS9pghHEYjfyo8fMM0z47CzgRixzTqfx8lQ7NVc26GTmpxzF70PaQpcsP
 jOPZaguYhtABZHJRsqmvz14ebhBkzuT1feYDps2TDz1v+oLREpYU2F1koayTT0AJsl5t
 HhnVUMKtYAdWq7zNSARipNdIQqv9hqlXKkH3w+n5rziALPUeZ0tLVfcfNOAd8YDobkcq
 jYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CF/5siN2wInOqXXWq8cV1lFbWyknA6g6CRVYxIbYoDs=;
 fh=Ojiz9TE6n0gwa8Sqy4epYViWg+Us2CPvSyvRXAzRpcM=;
 b=Z5Rgc3n+FFKR5UQOOv3JsKvseo329o2XOhulX94sZ2vIRI4R0ckoQU2fO7OL1Jyoy2
 v4ccFX3yg3xWawB32zudEKtzQO9Irae1Oi187tpe3hG4QVada/SLrOkjjy30gQDwuMeT
 HZy1EEn3PoPN98l1erMC/01DUH8dS6ej1ikbRP0EOTY3dhYAww5TDH3gup/MrPWaL3bR
 8P2JcUl5L4oRM2dQJs1zVY+H9gqj1psClFIcP+H8acIUcaxjYGj4ztzjUXaO7/BThHYh
 dGtHd3yfz4saCqNhm1ZDVWXfNDxaAtehK2m8TGsrM2yUil5cRmEvZbYOKL2FVBN2a0cy
 EyYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785960316; x=1786565116; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CF/5siN2wInOqXXWq8cV1lFbWyknA6g6CRVYxIbYoDs=;
 b=aczGw47keh7rs8GQ8lB39dpqE9yot0KViCcCvAHnLJ/pNUvBtZQoRupSuHLNYtmEw3
 KIFQ0tY4ewCvb0M2GWV5VNWL0opidGkan3eTUNwgzkxAcdLjc63Y32gquiPMB9PxaRbn
 OFPzl4wSS6raSt6qme2nhVjzb2UCQvCkur7saBpR/nW8oOJzcOCRCD7jUjD6xaY1/Stg
 vD0MZ5QHk20Xreyoyitavy/8DXWoJi2ADmtgtqv013oEh6T1r3l+4VNFDp5lDalLrLbU
 ygosNnTOMNslbK48bBm/Sf9v++riVGptS0Tvo5Q4dUMUGe6KRLS193UxDoHOMozbP2IN
 dfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785960316; x=1786565116;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CF/5siN2wInOqXXWq8cV1lFbWyknA6g6CRVYxIbYoDs=;
 b=iHM34eockatdrrgvRhCGH0zLSCy8338l1FaYTdLhd8xbOcvrXJ7fIQ56GiYqnQKIbx
 KVp9uRGjFe22MGEYD968HSmBZPWW5G4QuUxnr8+lmROMEp3Fh6rT5cgeAGNkVMZ9E0xe
 /cxyIbfC3nDjcUk7hPSmIawcwlNENYDedl8ShaIcRMcx4q+FM+BgsDIPRpuuQD8HnaNW
 oD+WB4gzSBDIhgGvNgp51fPv38HkuXKwOG2IBYd/I/xvf21ihYQPt+0nqJcBaSi/JbA7
 u5EyzJFekTXeLmxuk3XZOCv7B6zcp/9YfbtByzWUZ1iwh0dnn4nT6D6s63x9yAUMg8t0
 CZoA==
X-Gm-Message-State: AOJu0YxQ3p4DygOeR8Gf4eAYC5zkVN2ujmgqixTC6GZBnG+A0k5cqVZJ
 7eveFXswbwomifWbGFa7DOFkvGiGaJ9h5mqhzq2h8Rx0uNpEWBvf4rxdw3OGT8SfgTAOvEzMVyx
 bQzJWcq8jCOC80C3TYlCYcGBYKozrypMExoOvRW9ULkKvf0nJKv31KZSCz7PXuQoZt1iRb/y/yl
 mlPrP80kMfj0ia8Y5oQcv+I7aNwFy6v0uF
X-Gm-Gg: AR+sD11cteLaRbY9+W2xf9P7soWTQrzKL+8O/W8zTGHfBvnyMTih4oKlmG+lQeTzg71
 T+aksCxpRv3FcYNmuBA/7JGn1pMJf36/J41e5+KZ+NDenscbjOkT+OyBD4Y6u6+p1ew691pL6Lp
 GjlsIbqErhBWrGR+OdRPi2NmYGFL7cuG17NVMDeP2TOrIyj9HBqCiaVl8ohDI=
X-Received: by 2002:a05:6820:208c:b0:69e:3e6b:c07 with SMTP id
 006d021491bc7-6ae96c1edb3mr4671312eaf.5.1785960316247; 
 Wed, 05 Aug 2026 13:05:16 -0700 (PDT)
X-Received: by 2002:a05:6820:208c:b0:69e:3e6b:c07 with SMTP id
 006d021491bc7-6ae96c1edb3mr4671262eaf.5.1785960315778; Wed, 05 Aug 2026
 13:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
 <20260805165225.3117924-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260805165225.3117924-5-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:05:04 -0500
X-Gm-Features: AUfX_mwjlacB0FQxz6I8CRMijfsRXMa6LiOgZM2iOsodM44yjJx_fkyrR-a1k5o
Message-ID: <CAJ+KCYMXkQVEmzWjozpUOaVqzh01zzwqyGmRPto0QXQ7hfwEDw@mail.gmail.com>
Subject: Re: [PATCH 4/6] target/hexagon: add GVec overrides for HVX absolute
 difference
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=I+hVgtgg c=1 sm=1 tr=0 ts=6a73977d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: GS7chfE9fRMeUMeULS8Wknn2xUwXZsmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfXwZf6wNxqLqYz
 dElV0h2HX04ORuVRTbuWirPZm2XgIAEbGj5Nq3Fqkg9Q328dTqVW8LgEu2f5KQaqWL//Xg4uiTR
 44ZDnkEzpRzGlUvLyWoovelwUPiRVU3Av3vhw7A8xul4O0fXA3+gvfCqeZmqvCdnOEu/9EMMCLS
 lSbz45md7iqsdjsNpEsm6xfzZRaViart5hvbAi07gwNYKODGd9k4JKJOEt26gWc2WT3fA5hkFRK
 7ssp0U9MLVk2Gxm+fIhztEhCg6xRWIeL7l5z+sc7GuWbsC9uYVkqdhl937r26EcI+d9qSuDbe0e
 RLWUaN0X6N9iGontNAhQrl79OjSa2rCmPw6faDYb5r2BL/d/3IOhbVL7jnoGsu9p1BxtXMrT9X2
 tHH/1OORNHZCgKHdv+RUktM5FYv/WMWpcqFKWzASohw5Ff03/gV0/8Y9hP82VqAYyf9aIJENIwP
 N0Egm4XD/YjJwhNv8qg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE2NCBTYWx0ZWRfX2vi6yzZJlDJN
 efy1ZlvzV+6nG7CjbypRsWxZ050GLp76si4KPdHk9eU7lOsGCy7h+33TfVmem05826VrgErd7yB
 jpXsFpQgc0+xAnTAJFEBA7U64/eeO5s=
X-Proofpoint-GUID: GS7chfE9fRMeUMeULS8Wknn2xUwXZsmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050164
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
>  target/hexagon/gen_tcg_hvx.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

