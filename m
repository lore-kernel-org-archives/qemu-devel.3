Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E12CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMWTf-0007gJ-IP; Mon, 11 May 2026 15:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMWSX-0006Yd-Ja
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:38:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMWSV-00035f-8H
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:38:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BEpmUB1513254
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XK3vWY7GrBfYPa31b45aR/f5spKKvGWnk1OJA9MiH8s=; b=Km5KcIY46kXqF7uV
 lMPOnPWfD3Qu5pSN9KWTQVPcgzBXrsxrECRR8tzvtUdmoxaDdW3CDvJ8nhcYDZSM
 J/LGeAEx7cZlOn9aS9dJZgEOKEWrOaXo7gSINAAAUg6AfgLKCIaSYfj1i+qqYq53
 ff4GrpnagOwUir5BeVeux5H2hh8jTvO0LJsNh17uV/lf4GTMfcl+E4Nx0/1nl48Z
 rd1vZYSPW6LSQyMGWLlK1KA4Wy1OOhPig/O8yicoZ/OmKg0Hq++RmaVNxla7AYMH
 099I60cSsJh/ruEGB7C8a6NPgn8Fg9oZ5eDVH/w7ZGMRkGJ1bhtmME8loeGkPV8R
 oAWSAw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3h8g96u9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 19:38:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee1da7a13fso6264522eec.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778528308; x=1779133108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XK3vWY7GrBfYPa31b45aR/f5spKKvGWnk1OJA9MiH8s=;
 b=UkGf/MTnmaCtwXELwkd6o7mhu4FCwn6nLALq2zbpeivyukvRSM0TKzdcbSb8/ev94g
 QvAOShJ+Ca2VtMSA/L1A9Z+p2d3MLzMiH+0GlJyL+lkYOD/mPDvlnWuLHpb8DYmoYRwW
 9/GJqQlIUkMlTs/CABxJZPzjJlhDbeDcQs5r3EKXqtzdfqCMcpvOXi3Vu9/boEmAS4jG
 zXrchjhmZqQVEURAXdQ0FchGHy7zi5jSTdOqzUCaZrNMnWFO9rJkfRns/tB2HF8KtJeM
 4M/ofUhZOaq0vk8DtQJjwCnYH0J24AEIhy6Kf5TKFDkn6huL6tPmIpgdWR+K/kalo8TE
 4ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778528308; x=1779133108;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XK3vWY7GrBfYPa31b45aR/f5spKKvGWnk1OJA9MiH8s=;
 b=OwGcZM9mln5dwzWlyNytD4Mef31x6ezoe6pU/IwFG57aM9R+a5DakYG9VzwpwGiuJT
 Zcb7O5gMxexAJV03kaikjFvOuPEAh9Ol2w5fB9cSyt57E7mo6AdeTVQqu9QTa7kdcFJS
 tp8RHbTJuhpY4coXDmcI2JgcCZ5KMICspydrxopqC0a+HeyCbtGLNh01r8qT8OfeA+gX
 Taseu/7VNj65IRj5u+2fsWBti8+jYHYAKv9ufJFkwXzRCTbMZ8UA3qE7lpVWmnEiiARr
 H+lh6z9e4Ag9AYOqU8bGc3Alsrt9jMXO3HVVQjV2+Kq2kVGgbCezxLMewwqINXem0NJ1
 UJ/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DJPVDrszUE9PS+JHFCKdoNW0zGr0IAHqb0MajmcAuJMGgGmgG5fE4pMC/yQ44tXh50+yXzbxbJNyy@nongnu.org
X-Gm-Message-State: AOJu0YxNY/Dv6Rhe/AO+5O2oJM74QIYLKnIEOEjy9UtDIedv6A30OSgf
 IOYBqzGlBnl56GXuj9kUPrWhzfn6ait3wkrmfZn+ldp4p4rnU8HUdvk3zp/3qCsIpxOSfYJpFPQ
 bjpdXab5m8mpKxNuuNiKwFxqmSUqJYstI4CRJOjn+1zyzFa9eNk9x9OpocQ==
X-Gm-Gg: Acq92OGhgZr1qps1iV79nPfAuyO0ECMChKyg38GgJArKc+B75Rs1lUF3G7RDPtaJ8/Y
 i9EOEPry3Qux3GQ+Lw4AqNraaceupeMHvUmVLcvzEFH9rnbyP5Kd2Geg0rNR3eD/zbq2dlb5s5l
 JwLdjcfWUouzzfz9aXChITi3dgDpF/K/QRN0EgVjBoIhfJf53tkd3R5+jfXTay1oBVmUyIBbrJV
 t4dRw5GwnMwXfysUjngNQWhbuAeJ0DqKRQq0SAgUU6Qc1pOIICPQAGAyv1Ogh0pvSXHUzpssKx3
 I/J3sDLfXfppnz95/F3JnjRA02NiqtzKMxyVPVgFaOgn1DpyqSFAEb8foeDpuINyZCGdRzd95fA
 9AC6VSezbmEk6rchM4YtBV5NT3VDdWX3bJ8gjE+TcJhp0iVTSXqre1WuVz8gwqShFaSD0rI4Yyh
 70GpF33eWr3RUljw==
X-Received: by 2002:a05:7300:a984:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-2f55034e59emr11568833eec.23.1778528308062; 
 Mon, 11 May 2026 12:38:28 -0700 (PDT)
X-Received: by 2002:a05:7300:a984:b0:2d8:df01:d9f6 with SMTP id
 5a478bee46e88-2f55034e59emr11568814eec.23.1778528307515; 
 Mon, 11 May 2026 12:38:27 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88847506fsm18056034eec.18.2026.05.11.12.38.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 12:38:26 -0700 (PDT)
Message-ID: <1b05886e-e193-404d-ba78-d342147daece@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:38:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] meson: Build target-info-qom.c with -fno-lto
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20260511190634.472174-1-richard.henderson@linaro.org>
 <20260511190634.472174-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511190634.472174-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIwOCBTYWx0ZWRfX5fS5TtlOBds1
 8KG6LtwdQZUkxJi5dItUrrNnioXV6XyzeFcOgZvRYmYgFS+HvsR8sE7ZkuSui5xl/DIaVclsoxb
 mtegpq4kbViZ0L6tAeTRk02OyfypHVNj8oyRqkkRqtfUrl7ON2wJlaGw9l5Dndr6G2b1UgZ79/I
 bPZd1Gs0gjbTWTYME1MGEpVUBMbY4FPammCvrrcbLG9nmXM5JNG8UDb4b9MJije8mgKe91zAgTv
 c899kKLx2huFYq4PulNyvG4ZOqqOrwe0gYlU8tkA3tI9Y7ztSSIuzRgmDXaJC92oz+TklrLt8K/
 xvntkbUBRmSb8VfY36pd7KH8uDk+1zTJ10cCqhZmGr3JRPNSFIsteC8xD0n+dpuQFwyzqXvVdud
 91Vw1l3/aFnQY7XutE6MqFo/1LYptI08LscF1l+SzyC/JyXhhSwtZkuHcEgcIjCsgeYhse6uNTm
 oU8upDS6WzlxMpQHZXg==
X-Proofpoint-GUID: Av7qSHvCDLbJDOgJMR8cCjeAMfEkVh8O
X-Proofpoint-ORIG-GUID: Av7qSHvCDLbJDOgJMR8cCjeAMfEkVh8O
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=6a023034 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=xm5hNnOssjAkdZ9UmqkA:9 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10
 a=VxAk22fqlfwA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110208
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/11/2026 12:06 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  meson.build | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Why?
Does LTO breaks anything in this case?

