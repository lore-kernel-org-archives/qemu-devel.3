Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A26CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDsj-0006cY-II; Mon, 28 Sep 2026 12:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDsb-0006QX-4m
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:07:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDsY-0007JL-G5
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:06:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEeD0m1499324
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5BE53WHQvP/Zi9yiECqunMJsXfjGLDhCocsY/vJ9EQ8=; b=Z99Onrckm3ZLEDaf
 olrsVve6oMoqhgnoKSCGLBqIp6MK/OGLaJ6yIyVB0fwgWECi8esDzeYVwvL5ixYY
 g4Fu8ehltgtsHbqXSnOGC18oaLvoILaRzIA5yvejvIG8jhANzahJYuSXxqNyQWM6
 nF51i/EK33phT6DRPjnLQ42/XmGQqwsPmjE81MUvbLRMKRYrIQgQ7t1FgaOh70Wy
 I4aSUIdtG3FGvVBckD4dAr2RsvfJ9lebVMECkj7bLM5yoH610nfdz/+gqN9viQHl
 vDEth6Rhff29iXyC3gNVCWXo1KqjAuSDZBu5cFfgThThIQlun2LiNk7S/Yu/n6Dx
 FYhO1w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mt65t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:06:56 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-988a73af58eso47820241.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790611616; x=1791216416; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5BE53WHQvP/Zi9yiECqunMJsXfjGLDhCocsY/vJ9EQ8=;
 b=X3n0p7oG4yNPP3H4vS+lSs9vgbzfYigDCyXcd6nT/wo+YTTD22oquWcqE3SqY+BqfL
 wrJWiiaQqntgxGQWQuR0XaEzbf28J0/Fp8M173vSCiiA/RsHaj6sO0PDmdAw9MnQR1Z0
 P6+gaFYSuzZUTxE+5AG/SuLvJPWpYoD7bYgea+QscTXOFuB1S15mXd2wqdDUwsaA5ysI
 2hziH3oEaG23P90O5/P9UYkbNoH7ePaBADHQXk4VfDykGTRYCKBXesI1o+aQme2YfrDs
 UnjyxIdmUxug9lFOvRGoYUeyLpzS7BVMzoGC8EOD4YqrtePloq9vpqEtHUs2C9g9zq1l
 fDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790611616; x=1791216416;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5BE53WHQvP/Zi9yiECqunMJsXfjGLDhCocsY/vJ9EQ8=;
 b=nX/2vqCAQv4li0eFxILX5G+UGDcfYiI/m+F0PhtSSFZpp9TypArAKgfrqqMFdkzkXl
 WYg50AXmeYNhhIY4RX+71N4NW8Zzs1SL6i1dHTmuFoMsIZ6hunF5B1t94WUf8nKGA8nE
 8yTXY97Zj885SmcvWpUl61bIJgO7bJjMemlQd8R2hmayaVW3so4lJUEGLIFRbWS5A98J
 TkcxX0Kolz49EqKZhRDeOHEkG8HgtEBtBZ0ftBOyZyVO6mWKOtM749EDfEDUU6/vQn4W
 1OF3eughXJupjSIki48xXIheWhEBX5My5ORPxumlSHYOKSYk3tMC3eBJ9FVS97B7Kh0u
 L+lA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaXcPsCDLTYwQV02mBdX+bl7iWuBeMfVJH/kE03evTimY3utgfMJeeWaMCHR2Gqx68Iq0jZn3dbO+O@nongnu.org
X-Gm-Message-State: AFq9FYJpKLWJEHP9BfwHG7XaZhVSHLZXg2/KsqtGvN1Fa7NZeEoP5zv4
 o7wf+hwbCKyEsqU4rcXdslOO7m+3FBr7++mwFfk4+gD6YgOAkp2I3p1pfnSFZJhiOfRyMgeTDsP
 OOkMWbqeTtHYHAqwcJlG6ald277epL8m7roGSerj02LaaRjbY89bS8ollUA==
X-Gm-Gg: AYBFou0YC8b1Kqdfb+NkstzUmg55NoGOaAM4bcurcJYXHk1Jf1Fs3vHST29JSejQ9Vm
 scbtpCpMzqIZZgMaT4Ifn9ipebLfJ8rQci3uLyAwFkRgMux6Y6whDZyvL49ivKqr+rYUVAwTbNS
 NCecejeCTBMfmAQku7WzT8HuNDCVfkUHDupamdHDvg5T8biL7Yl60kHK6G4ixnrKpbs8x4+3g64
 vPhKscck6B2o0mY2SSWWZgN8SxPLYLq1ROmY7FMd5Qy/3NbE5f/Z+uYRuvdYmxQv0e8FIuGqgEn
 k8E6mq2JOkKOlav/U/UDYYCIrgcoRSUplQgScDHOemXpRhkYDb2T+TvTGGToadcyCdHIP5XTUwc
 t6qoPiPSMzrHGw+IqvzeROmjXxMc41ZxM2w==
X-Received: by 2002:a05:6102:1620:b0:7b4:6d48:d8b7 with SMTP id
 ada2fe7eead31-7b46d48dd14mr1116358137.28.1790611615574; 
 Mon, 28 Sep 2026 09:06:55 -0700 (PDT)
X-Received: by 2002:a05:6102:1620:b0:7b4:6d48:d8b7 with SMTP id
 ada2fe7eead31-7b46d48dd14mr1116349137.28.1790611615108; 
 Mon, 28 Sep 2026 09:06:55 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a648895sm28557885f8f.28.2026.09.28.09.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:06:54 -0700 (PDT)
Message-ID: <bd42cd00-a151-41d6-80bb-b80701606950@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:06:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 048/101] tcg: Generic expansion of tcg_gen_negsetcondi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-49-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yr8P-629OfLydYSR8GjKq-OXJt-4_JEl
X-Proofpoint-GUID: yr8P-629OfLydYSR8GjKq-OXJt-4_JEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX1t0CcZlCH6xE
 SBQ+ZRnLs5pUo+7FWM6FfdImGdJ5Uq4Vl/g0QYYMl3fBVmC1m7mjv4Zt5zea87uBBOAeT81+Y3C
 dvft6+91H0Muw/UJIDk7qtO8R7s2CI5LWyNI5BQNrEZQcgI0KzV3EPZHaH2Er4sDkLBdPpBsTeO
 6kMYjAZqLSonOnv+BOpFEY4cI6XwFqrIUEVVvshX1rqiLTY5BJdbgktGq3MKrin3ablrVu0xILW
 zDSxgBAT1nfdpDBfWXzv9pxbaY25+8vde+rp7fJK/0MKE0Q+X6BE0A++u7fFjdVtNm4S1sGwGW2
 Pb5+ox3RWy+kWfmFwZALnUXJpHCoI86Rme0Nrnns3bXiiEfK1Dd/gv9Hoao41VcntXmqfb8m/KA
 m9JvsEovCylnCMMgzNH6R1tfQK7SkrJ3T8y8YL5/uGnVz5A6z6IYv5VOA0MM/OtcQo3Qw9n6Ihw
 RQCStmF/sz+etow2kjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NCBTYWx0ZWRfX+TOP62sp0s0j
 kEO9SCPrE0LZ92DNcjCAVPT9aND64AXImDqZYnqp3YedDj+LWluzQV8B3fhAyCLAGXluiRBM9eH
 zYtA8G/TCl7TFmwrvgjBNZmDQPWkc0A=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba90a0 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 27/9/26 10:59, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  4 ----
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 19 +++++++------------
>   3 files changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

