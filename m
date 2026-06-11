Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BF2CD98D6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXe8k-00016n-1H; Thu, 11 Jun 2026 08:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXe8i-00016D-7Y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:04:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXe8g-0005ub-Ik
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:04:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA1SJM168109
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EwFOXqeGjSKblpF/kyuw6m1BTKw8ZYmbGGLlgvNDhcI=; b=NKQpQ2kAOMRdVBvd
 cxS6QG60A5n2qUp0sevOSQKh0/KtMYqyU71AEOX4/s0KBUItBm8w05Z8ifQTpyae
 GtimNVzAdUYUbxE4/wmHYarHZy2FyGl55hrOwGxyEfUVQ38ID09YFTsJRHPy8+Gp
 8WtTdzntyAUmO6VRFg74Btru4oqv3VVUc22lpMEtYVD4whQnIXKTdZSmiiTKukdz
 JKKT10BmsM1v8TTESe4mT2LP1xBCQnYPBucHgcChpVakYKvwn2B/ZkNFAwu8cKF/
 zLVBrXrSo8pyFH7IDXeOA72yNp5dVLLNITeAjDdGMUNDTFoevqgiPfIx1ZzxiQ15
 1PfrjQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ub9bt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 12:03:58 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-69e3464b1afso10423616eaf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781179438; x=1781784238; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EwFOXqeGjSKblpF/kyuw6m1BTKw8ZYmbGGLlgvNDhcI=;
 b=e53xkqPPPyWuER+pwRl4b3FEcnlRYHcBNJO5txRZbAZM/SPf1GcvwRICXT5CYYQdsn
 9yF8adENstyWdSYl1QoVYM2J9x3m5XuDhY2vi6CuBhy0derqJQ27Srxo1ej4g4NWY1rf
 NE5En/OsHxKd4T8edsPza5xBAjvHIjLLwBUUdCe3x2/2S/sG98f9J1kF+IaA+8LEJysK
 7Z7zap4hhk7gTtqHUE2hzmhUKOvdL/mHp+JGeZuP2jtSfWzsY/SUZmyLZyo/J0beYzyt
 05r7hgfM8t9o5pmlwbB/FgY3tyhVwC9hspBiNvSIjLd/gq8j5Kc9payVTqj++4xGRSp1
 kx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781179438; x=1781784238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EwFOXqeGjSKblpF/kyuw6m1BTKw8ZYmbGGLlgvNDhcI=;
 b=tU1X3CNKeZreDq4xMbn3ccHHRjkRdEk7FfKSFDsnpAEnQE1tVUvVOdh4ECjmyWANtT
 FO6DYURxuCkMaDEao6485B+T/4Qkfk9hb73jhGxr73csUb/jtk1VoBtZTOov1Z6p8S0q
 FJZ46oXkZDTKX6gCiItUgzcNObZF+zibnf8dnpXXzZAN8DnbLwa6AUVXGhGRoW4uJrqK
 mYcFSzOoTljavdL/GT7c4Iscb6bulrc6GTSSIJVgZVOiTVRayPBIJEKBa54HbVZ+5m5g
 TC95KAQvrxUdQKZ+s/2F5p80gEgbeCh35emofQFmCRt5qpWzt0YA0kypz4ALQ/GB/wGV
 /B+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W/zYl7WGh2UQSs+3/lkOJTG8P55ojgLn7nYS60OR/oysQmpFylTpXNQ2SIMegkCAalQN2CjFneIDP@nongnu.org
X-Gm-Message-State: AOJu0Yzio4zbbU0lkb4Qx83AzNsncQuxpqknj3jAUX654L+sOSd/e/c8
 FNphjjMfvU3Tt+xT4w2EMzS2j/5lUMtil5Dle1eO8AW1gA5w8yFNFGaYSk/2IedrwoDjGSpxmeH
 pwQpen7qqk3M9y3iJWxAC9HNXJxaVYOhbpDb5Nb6zqU1XwqTdd2F0Vq2/CA==
X-Gm-Gg: Acq92OF3ZO4tYLoFmcMgvqrR25vBfM9Du8lNhlovjyvNk5rBjL9+ldgdEaimKxnNI+m
 o+9QdAHSTHN9zUuNVcMWzYk9MNGkVNIZhxK0Nkkjv4ua6pDT6vsXR7wY4TdiJhGygm5HZIW6MGb
 3LhGFypZraAzn3AGMa9oI0gBd3BKYOHb5Bn1oFI55bUG800TEBxSjrIk9Fb4jmZYDIgporD1rqx
 GUhlojsRFtfsXW2urNfzZzT1XUaz3oKdu1CiRDrS6ECKS9V6mvlN09MyjJoK1J0fNDnBhMbWZeD
 nfMB/T/xGrGUJum/RcHsrzOclMfolqT5YnoxpYZIfBw60lymq40SoFl9qgQzpqdkr1mEHdGBgD9
 NFwPF3VmojQwHffksptdPnOkas4XZbFGNcwtuMWY/3DNvVPmF8/BsmWuUwbwvMYkbpr12LIyhtZ
 UqSrOtjXg=
X-Received: by 2002:a05:6820:2917:b0:69e:424a:8df1 with SMTP id
 006d021491bc7-69ecae16727mr2021277eaf.19.1781179438248; 
 Thu, 11 Jun 2026 05:03:58 -0700 (PDT)
X-Received: by 2002:a05:6820:2917:b0:69e:424a:8df1 with SMTP id
 006d021491bc7-69ecae16727mr2021253eaf.19.1781179437795; 
 Thu, 11 Jun 2026 05:03:57 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb5abeed8sm56379366b.45.2026.06.11.05.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:03:56 -0700 (PDT)
Message-ID: <60908171-fd6f-482b-aa0d-72e694c277a1@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/pixman: fix zero rowstride in
 qemu_pixman_image_new_shareable()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260611113614.1935094-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260611113614.1935094-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfX04BXQXJAWYQE
 fAxQqzPBaOXkq2jLKAoYINKftbMkiFW5pupS13YBkFcUlEckAEbcto6Zz39agL62msEsAreHhPY
 pB/Q0W1faOANrbQFCerpgtSO1U9pJyc=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2aa42e cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyMSBTYWx0ZWRfXykIZO7ffLwar
 lAo+d7VM/B9nKsOPgyOVeZRqkT5vIyftFs96NcslekyYO5OOAEmtkCuDh1FQy5v+iwwfyceQdQl
 5DoAVrZDaACPBYKTwfbw4UOFOKzv9qGRrvCVBL2+xM4+SnlA7onOHMdKoGjXZzDTulPxzInhBef
 lQOnU+ayhlT05MU1oS91XQVwUCKw8PBxhFuj9aMnNGYqcY2W4113RGYr+kI2fd9sWYQL7v3nFzO
 FYg5jrjddSXEks2YeSyrvxUGiEGw/sIjAKgehafh1SjmMRIqM87DbiyT9bMIxqy42V9KHYL7eeG
 q1U9JkjVndolaBq5S7QhXaWJQe7ZALkcUkenBnLm5xyCYh5InsJ8gXMUHEjafcL6iqp5/M0eLSL
 WaHEo7zrdOtrHts+k95A1evnJtWr9rkP1AirsSc19HEyQ5XmjJIS0cWGiyXGdNP/8Vvbft3WIxb
 qkPR7j7nhJ6z50oc/2Q==
X-Proofpoint-GUID: fc1K1xCReLMtnmwZ0qU0bqaGPwZQcCBF
X-Proofpoint-ORIG-GUID: fc1K1xCReLMtnmwZ0qU0bqaGPwZQcCBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110121
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

On 11/6/26 13:36, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> qemu_create_displaysurface_from() callers such as xlnx_dp.c pass
> linesize=0 with data=NULL, relying on pixman to compute the stride.
> Since 1ff788db978 ("ui: use a shareable type"), the data=NULL path
> goes through qemu_pixman_image_new_shareable() which computes
> size = height * rowstride_bytes, resulting in a zero-size allocation
> and an abort in qemu_memfd_alloc().
> 
> Introduce qemu-pixman-helpers.h with overflow-safe stride and buffer
> size computation (matching pixman's create_bits() formula), and use it
> from both qemu_pixman_image_new_shareable() and pixman-minimal's
> create_bits().
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 1ff788db9781 ("ui: use a shareable type")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/pixman-minimal.h      | 25 +++-------------
>   include/ui/qemu-pixman-helpers.h | 49 ++++++++++++++++++++++++++++++++
>   include/ui/qemu-pixman.h         |  1 +
>   ui/qemu-pixman.c                 |  8 +++++-
>   4 files changed, 61 insertions(+), 22 deletions(-)
>   create mode 100644 include/ui/qemu-pixman-helpers.h

Nice.
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


