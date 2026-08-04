Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02500C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrD3l-0006pv-EO; Tue, 04 Aug 2026 07:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrD3M-0006p7-DS
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:11:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrD3K-0001gT-Mn
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:11:24 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6748CLdD3217735
 for <qemu-devel@nongnu.org>; Tue, 4 Aug 2026 11:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oix+o/KmgAiCVWBq/Xy8oWrnYAn+E1J5kLfkCsItdjA=; b=GyxoVibSiyZjgbFP
 h+LCmeRqohi43hVGr6U/i59srw9W1WAQ2IUQjxsfsWG6+A3PwOTc2XnAe5iumcg1
 mYn4PhedJRD9Htv+GfcUH/JZc8x1OAOjzfZyvKEEtf1DLa5M4SelH4382zT+t0k3
 11OAQY/toYzcbmHy+bKyX//k7tEWkj3mVdAZnZ1l9aAK43jVRsOAh+KBAH87Ra3T
 yHT+JycsMqGek1GVnrJGQFdC3HZ3i7t/qCYwaMzG0HgVyJIYGquikvQqIgKZl3dd
 G+yjsUyOFKdKqCwzUZdIQGATTcQS0Rzc2TyzSC8CY60sKXQn0bfSEKYHo2z7fH40
 0wXQEA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fty5sbvsj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 11:11:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso68761101cf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 04:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785841863; x=1786446663; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oix+o/KmgAiCVWBq/Xy8oWrnYAn+E1J5kLfkCsItdjA=;
 b=FEZVVqBod3lbCA4VlmFWi9bRFskDM58b883umjt7RUCyi1KRJuEQO2PgblRzESEV3X
 PUV4KJO6kdU6HcBkQYNnAdkPghWERBSGnhBqPVc0dpOUnB49l3Gpg6IbFYRP1G2sxiS/
 ft0XCIpcpp0jlenwz38moy5+OGrFLt93oOTh0fqe0r8RC+oth/P6TyXSAp6Mm8sBwnaz
 zWvUNeUpmsUmKryGbBntDSGen+CRk4OPnFwYFHgymSeD3bEZn6iQxGmYt5b29C/aweqY
 XiKLsue8d1fuAu9EWMwULhvymelXmvtFw7HHakenmKzNBCRrbCfLxsTaAT+/rxZmiXLO
 EMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785841863; x=1786446663;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oix+o/KmgAiCVWBq/Xy8oWrnYAn+E1J5kLfkCsItdjA=;
 b=reaR7HA7wDka2ur7o1DNRq6LY+LW+6juWaE7zfWL3rzRXBYyRdPICpso9p7cUUwbWG
 2ZVtm4btZdjb+0zoHrzByxtvanJl5sWHoZSzmZFZMCAt6qT3zAGfFSlCbVU/kBCo3Xkr
 1g2LfIUMNkwM3gC1eqhOMKyLjZxUqRdTdmMBNCHLtz1rYzAed1DNiFoN0HE+L9HvZIbk
 3L/ttjzWYnDmLW/4vuzhjYej74NQGiCLSCMMul+NQ2R0R8nzHIhJFKUTpa74YmlkuzVR
 Z7OQkb/d6jCN3oIWzF8gC3wL8vn1xNV4GcQFrXW33axQsx9GwPrp4/Qv4UpQ39Kx6xA7
 dVow==
X-Forwarded-Encrypted: i=1;
 AHgh+RpdOkqv2hR06ZiolQXHBRKKbaXqL+8TU4Yi2m0uoXQ7/VySnaFJcUlK4cZX3tFqoxROKXQT3DAp4pfX@nongnu.org
X-Gm-Message-State: AOJu0Yy5rubp4x99AkVPx1c3wGhoJQiKB+6nmof+/mOg5ziJyHQCaAQ7
 nWhz5aYuh1+WsQAGXU7IMfxFsD0NW8WI7A8zp8NMvR1LHXCn/5pPZssPeaY/VjIvVHNacmv5dum
 J83LfvLR+Ht5+PDr1hZvPMW1q5hKmICUuR3fZAEIh7OH9nCsb6rayILmHOQ==
X-Gm-Gg: AR+sD12APIy09rwPnflGKLZvCkjqh/8fPYq53XnqU1K70Ag2x2aSqJiCvKoi9MTV1rq
 67xtzFLiTO6wzIT4fsSTXe9OxubiPuHaOq6EGWR3UyRNttD1WUhxgxFmxmdImsDG8OUpS34Wk/Q
 1/1INHVWfsxDLU3HpqH69ZSAOinsr9d/zkysle+wNQNpW8IbmHI0j4l1dJ8xfab/AnERzuwY+eO
 XWK/d6t1HA+arV8uztPW0DrXwOe6DT0TYaYE765nskUlcRCjo9/FEAYvyAPJ8/+QOwHT0ySPvra
 OWbo4N4h5EpKHtygkOXnO4RN0B9K6jhBfs1xh32/crKIS1tr5OMs3+tEVkKMZJmC18zIAVv1Eh0
 Ux0K7EK0lM/gij+BfHZ2a5Va5BOqtiMCA5Vk=
X-Received: by 2002:a05:622a:480b:b0:527:7d0f:709c with SMTP id
 d75a77b69052e-52b567d0f3emr270854031cf.42.1785841862768; 
 Tue, 04 Aug 2026 04:11:02 -0700 (PDT)
X-Received: by 2002:a05:622a:480b:b0:527:7d0f:709c with SMTP id
 d75a77b69052e-52b567d0f3emr270853091cf.42.1785841862110; 
 Tue, 04 Aug 2026 04:11:02 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b05fsm44355840f8f.28.2026.08.04.04.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:11:01 -0700 (PDT)
Message-ID: <6ea5fa0c-6ea1-4f33-b9c4-694636f7b620@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 13:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: use stable URLs for zlib tarballs
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260803180700.367388-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260803180700.367388-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SPJykuvH c=1 sm=1 tr=0 ts=6a71c8c7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=fXms6y0vAAAA:8 a=9qUTvQc-AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=3q1FPIo8JGfx5WVhvewA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=c6Zb8eaUoX5VaqycxFvw:22 a=axOgMmt4Ejcwn1cqzmsR:22
X-Proofpoint-ORIG-GUID: gDtLgkbfc-SmeRHJHS-i0mapiy9cAZ9i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4OCBTYWx0ZWRfX0NSaNIrqeSxq
 BYICHvhLXPQK4TFnPvaFhzZdMjwn/HndDD891r5ZnOE5R5I7H1IWp4SkFEBr5QyYEJUZkByqlh5
 u0oDCYs3QE63usvbjbjxkTEocM3HB3bIRuCEl3lDUyqreDQRwy9CYa+NKw39wqSGRvBRuAAy6Y9
 Zd/Jj2CyADdWSK4F/5rsMqWRn3U/lwHKp7tpXB6eD/+eFCRCfzzeBUxYmFKn1pcfLjtZiK00fK4
 hTtQEs7bwr+4lukNrfMNFqXDujiOaohnkEiNpR4pI3GgQqKl/0oG09QN6Qzw91mduidCmcsjCVS
 oZ0iEiV78jbcELR63jLKzZbsORIcbsGCGd0EKdkfYQv9BtYMsyuyX2cbzTmKwQDx12Xhgg5I6Ml
 10qQ5R+xgsIyX6wptVqlrGm73qBjy/cU62xY94QnOtD6pWeCe2TLiXKWNhvPylwnhftKBlXxLTU
 oN2xqpoWOdFLh4M1esg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4OCBTYWx0ZWRfXwdYQVisRaFdF
 9qRhmERhm/RLvfKWV1+xiFmDfIIXkuD05+bGLria5Uil1f/ADTFY5YxlcVDLCHz7510sKyKXGsf
 AhwVd8sNd2e+ouD7yBx/83VRX9ZC0fY=
X-Proofpoint-GUID: gDtLgkbfc-SmeRHJHS-i0mapiy9cAZ9i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040088
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

On 3/8/26 20:07, Stefan Hajnoczi wrote:
> The tarballs at https://zlib.net/zlib-X.Y.Z.tar.xz become unavailable
> when a new release is made. This breaks the emsdk-wasm64-cross.docker
> file that fetches the tarball and builds zlib from source.
> 
> There is actually an archive available with a stable URL. Use that
> instead. This does require switching from xz to gzip since xz tarballs
> are not available in the archive.
> 
> The upshot is that the emsdk-wasm64-cross Docker image build will
> continue working into the future without causing CI breakage when the
> zlib project makes a new release.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
> - Fix "bzip2 to gzip since bzip2" typo. It should have been xz instead
>    of bzip2. [danpb]
> 
>   tests/docker/dockerfiles/emsdk-wasm64-cross.docker | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> index c04a741b0e5..4f26ce7a269 100644
> --- a/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> +++ b/tests/docker/dockerfiles/emsdk-wasm64-cross.docker
> @@ -56,8 +56,8 @@ EOF
>   FROM build-base AS zlib-dev
>   ARG ZLIB_VERSION

Even safer would be to have a ZLIB_SHA and assert it is correct.

Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>   RUN mkdir -p /zlib
> -RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz | \
> -    tar xJC /zlib --strip-components=1
> +RUN curl -Ls https://zlib.net/fossils/zlib-$ZLIB_VERSION.tar.gz | \
> +    tar xzC /zlib --strip-components=1
>   WORKDIR /zlib
>   RUN emconfigure ./configure --prefix=$TARGET --static
>   RUN emmake make install -j$(nproc)


