Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFB0C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 20:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtWQc-0001do-E6; Mon, 10 Aug 2026 16:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtWQU-0001d8-K6
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 16:16:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtWQT-00077S-7y
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 16:16:50 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AJmDJt2602697
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 20:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xn1FUV8qy48mFSMnA6Z2W+e2LphneltPqYtP4AOcLdY=; b=oJfmmB4hnxAwFM8p
 LportiS0uebtn8c53Nlyp7y9T7AwCmKUUoeEAC1B/xOkzRAKpuh80iiTPzeBu/Ao
 Pdgn8Ys8I/H2OW+r/h2ziWTp5sjr0wY9K7zStct/48btryCpP5P6rngOSVxaSrU/
 0gD/IAyY7YCw/koqa/CUxsQkQ73bcElL3dBdx3Yo8xnwmue9Vlx8G/Jahxdx2Nxe
 o47ez4Ir1heFbaSWopxfwT/t7K4mvQn6lwig4dNfHe7EnH5pHZYoGEU6rQ2rZCb+
 EFXQdPW0rmar/iCt5YI6Ga9mgtQhAqedzJy6UUVw/196kAxwjSb6RikUNQPYCPTL
 AGya1g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjyf0qpk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 20:16:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5174a236220so1558141cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 13:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786393006; x=1786997806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xn1FUV8qy48mFSMnA6Z2W+e2LphneltPqYtP4AOcLdY=;
 b=fCPwbVnMqOC6+yTuDXYGCXWNFiMK/oAukEkdoM6YqZ+UvFwaJ2/YDPpRC1IaMw8d9n
 8WXp4jM4+jZNmn4XY06R0bChNKbGwdHpKCzgOJu7TP3mI5UfKgjoOWMJ1bDRoJRZAX2s
 Tjht3wrrDS6cJOZgK78qlXb6K+rufwuDRfWhr6WXV89RJjjby7x8qeBBj3U71bPgtlDQ
 hR2pJ2S+77KYCRC3PrHdjvnXgQ+AxOkkWiCDA5VbgwGamio89ENMu6g3FPaCD14XItFo
 C87rvmVU1CdjaESWu7BEOdojkg+IDHiokCRu9FN27LtKv4Q5Dj1mesr2cPCJ5R7ydlHb
 ItOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786393006; x=1786997806;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xn1FUV8qy48mFSMnA6Z2W+e2LphneltPqYtP4AOcLdY=;
 b=Iscorj9J+T3Hr6q+fWl5kEhrjuHJy4IaB9x9aPMdXwXmvzSZMkUJOOACFMvYcWasTQ
 WVQnW7Df0G5sJvYGIFjX98H8kAyOWCO289W3GdQMJkzn4P2EoRlnPFF+QKO44YxBhF5H
 fzNYM+dfAa/KREkRvsaDDV1Lkfm+K4mC0emPz1C2mbC6zg6SkecU0TnUzszJrTOWSgnQ
 4awyguGXqTPMTSJ8vRD8chkgl/Ge684VmdqbZxv+VnXmVDcwNnJJloNpa3O6Y0r5yiJ7
 hgJMksOJnuzD50pLqY66FH4nvUCV3o71FPMx87zMLG0T1pTcEulFuoG8eF88nGDHoG7x
 JfUA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNwDpe6YhbcuPNvBMjQznNJTL2TeynfH1Y7kasqvDFQRBElwJQcGsM4xb72BvbLASOjGJ9RroB2xPU@nongnu.org
X-Gm-Message-State: AOJu0YxMuI5HJnpLQyL7JxZEWcIz2Ijo7zR+8tU7GHKTOIsIDQeqbIKx
 d2BwuriDGVd0LPT0yChgQ/trniGT/1FtHBZ0c2o7IFaW8SqZsDkcsOUbaQl6OotFkVi3lh5H4EB
 NJVjz1enfhQzpliYjzg03F+n51WDMEqMc2RREZgyHUB8pLCynPN77RLTGDw==
X-Gm-Gg: AR+sD13l9AUloo75fj47awFXtHYwEJdvzpJBxJ73aBXDYdvuad9KygLuHjVZxeCz7df
 LOkuNA1k5OPE7RbCZRX/NbFkTPnxXYXi2aiudG7cgmWgaeDt137g2SeHKfvzol/mIDPMjuKPkc3
 cYTFzWEzZotBJ8Hp2OgxuSK751oufqGkxL/Sj3RKkC6B1gHwktH+fiFu2pLkLS5JQZtuOthWrvB
 75n4yFaYYFr7cHcMCEolCmTeXNEkHvRLwsr6NorrvpbXFxm/TuuN3rxkaiKvYfv1URsAMzuDu8/
 RfEkpbGaby14zoH7s2LRkK2z2Q4MsSDoO1HMxtUlL+2v/m63f42+pnaG9Pz7Zhq4h8JYvVzPo6K
 Fb99TWMNaRDyBhyuGsoTgLrNiCpOh46Nez1g=
X-Received: by 2002:a05:622a:9008:b0:52d:f7d:804a with SMTP id
 d75a77b69052e-52d0f7d8697mr323464001cf.10.1786393006524; 
 Mon, 10 Aug 2026 13:16:46 -0700 (PDT)
X-Received: by 2002:a05:622a:9008:b0:52d:f7d:804a with SMTP id
 d75a77b69052e-52d0f7d8697mr323463461cf.10.1786393006039; 
 Mon, 10 Aug 2026 13:16:46 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002150952sm33013079f8f.15.2026.08.10.13.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2026 13:16:45 -0700 (PDT)
Message-ID: <686270c6-99d6-4dac-9a63-d47c477a01bb@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 22:16:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/39] target/i386: return an error for invalid CPU in
 hmp_mce()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-5-8af31bc54c61@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-5-8af31bc54c61@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HBCwm0P9CD-laFUTiS8Fr3tRVUmrZnLf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE3MiBTYWx0ZWRfX1ZdGQQAVPFRX
 NoNO/g+EqXIOp3unl31lkINWcVlfomiLl36kd+3d9GYfpFRwQ6B5/C5KkfrgYN5n7qysm2wSgwU
 QsKppHH9IAMCHSuev/r+xFk+ZAQMsTI=
X-Proofpoint-GUID: HBCwm0P9CD-laFUTiS8Fr3tRVUmrZnLf
X-Authority-Analysis: v=2.4 cv=NqnhtcdJ c=1 sm=1 tr=0 ts=6a7a31af cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=pyZv4lzt5f8x-vXTrdYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE3MiBTYWx0ZWRfX53EsaRikt8d7
 qSYvINeKKyiyHCeW+tzIfJS0a4H2T8YHvu72anbOdjmHrNITZ7T4wK33H8S3qso74tiY2dSS4Y0
 /QCufA/7sOcDr1JFX3H+laTwUzAhS73QIefqZhGNMNz6EmQYgT65kkFt6xHbKt+AgGMESS+yH4a
 ErJxyhmCFNrdgydSOrbvW0mLjObTnn+UfM9Bye8g449gex6flP0drvELlLXUOlsdb8w004d3TwS
 +SU9P9HNvKL33Ul/VIqhbH54lvaUJ7radEm1ojYcNYHpTkgxQX4WCcuY0K929j1Cr63DwIxY3hP
 OAPuLRsdV4C7FNN1TR6JhD+eZMoBaOovl1w89upUSlxYRm4ZpRAQpeLeqkyqPG74Oc6s2q3wbUs
 IorssWKGCIW0/smi/fVvjJmqqeuivrdZjiaBb0V8v0ZEAlldWkzj/WVctf3mpuDAotcq6Kwt7uf
 iovr8LF4bDLBpqlItMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100172
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

On 25/6/26 23:19, Marc-AndrÃ© Lureau wrote:
> Rather than silently doing nothing.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   target/i386/monitor.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

