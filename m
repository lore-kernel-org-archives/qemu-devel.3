Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C86C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu3EX-0007ni-0U; Wed, 12 Aug 2026 03:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu3ES-0007mY-N8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:18:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu3EQ-0003b2-Q9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:18:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62P392641588
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ktxQXaaZjQ80/lT02yjI8uyS0BSRBPrxGOMiFDg34Qk=; b=ShjNFn0MJeYwvAS2
 tqN0jfW9iXAKoJj7nbXQh0K9hcOtI82jaG7AqSwiYmX0iXpkWAoJZ/7lTB1sXrlM
 gpaxIdQSjuLGZhPkvG9M935hhvHz8hFYqTfTwLyqHmCHtqPnJooVwQqQpht1pG27
 tME0gpqpsBIHrbQ0hTLzlUs+fBhJLR/Ak6njhMEe77oABP10Glu/MovNh76zChSF
 xt51OE2YUNBKEyteRISEcZk/xAjl/Dcw3Cg774r3x/NXK3fMctZrQWckLrUy5trk
 XcBZVl/sONKkCSlWCZkLY1voKiKtnYBWjRC36wQSZhTT1zWWgyhrxh2c5sxkkcuR
 AaHIIg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mkypt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:18:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5283df62d68so4524461cf.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786519112; x=1787123912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ktxQXaaZjQ80/lT02yjI8uyS0BSRBPrxGOMiFDg34Qk=;
 b=Xmy//WY/B1hX4irx6CD85pst9FQ1yFOEDyrTUU/PGBpGQP5pozrx3zluR5ujL7M/rA
 aNElOrETLkM9IsIypdL6/iam8vciYq/i9d3VZwagmkAufW3Q+ujFn144uA9Co+ZLWIKs
 y9y9+ABhHF/H+sIGtfO9O75u+RW4yUHvGeTp/tYxTRCuFkLLr63r+/LV5e3NzmwFgYYD
 LDNrGFbVBEt8XjaNAuizz8GqhutDnRRmUYYTYfcNB421ecH4s4IHKM9LY2NYfcuv0fNn
 CDj5qcDl7k3nTMJfQavixfNYfSAOJpVsAQdXd0dl8kilpfJt+tquYb0LKj8y2BAdNH1e
 1hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786519112; x=1787123912;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ktxQXaaZjQ80/lT02yjI8uyS0BSRBPrxGOMiFDg34Qk=;
 b=NgH4V+FeUG0KYbeGGdpPvlAnOMV2H5MA3DXQloK40YnPDFIhu9amkEUh+E/szBnAxX
 elOxPv49BoYzZnPCr/3ua1bRmnho/Fi+Dtn4iEDC+iGd86YusUvM8zkb9fAH6O068pWe
 Or6euxaRuYlY1tOag3GJ4y/22G/sLeO00SDM/+bPiNO/qsS0sw4D5j2T3sS5toyfVIZ9
 pNUKd0G0hIWpCSoHSyUabR2OSQB+U0zqAAAZRWKfJ9O9pMmLnmUeokXEKaG9P1NWzK5C
 CdRZlvaPTjpSMjiyVEipuR0CuFWzP5EL7ZFsZl5eSbiL9FONIcZ4Wmva0q+IQiouFZy6
 sTLg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqf02J7StW8r1wJNrXl+6i+ryKwvUR2GOXahx1Xljt9je0VOYwd0726B9mjFvpEEcvDRzzl0Cc1zcGt@nongnu.org
X-Gm-Message-State: AOJu0YwmCQDzZMK7amWUqvYR5WO2V6MoK9C1s0YqawGITOKK/SlXxdNk
 50tlRqIei/37/MF0djXFy4oppcnfuC+fGMQpf3jWQGx5kk78+yopYlrA6TzjLhGqwry0dd3q9x+
 3nyTQBV7ANjyQjtWsKyfsg0gcm9/SAW2NT55K6nZcIkModZ7UHBEpZWRwFQ==
X-Gm-Gg: AR+sD10e55tOKjDYJLU7FX76lUo5qp0qLX3FSPWYQfpRNMCe9XOEUGxTk6WAukXUxos
 CBtih6HYieiqrpN5aIOkU8dx1QQ69UfEXr3nxWCRkYHFMwoGzBnbx5Pju3whTAzg/NJC6w+BAYl
 vG7QWnyHN+V2ihQ2T0i3czRO46CLF+EiNlLUl1ivHJgihvK86qJHD3NUI12vQ5BTqwByXyR+Y/T
 DhrUkTn+6O9eO627gS/3FInR4zGnko6mBZF5e70MnBOiXkiy/Vcg2tQRKcnpddhvBjzhOWh0URF
 icAJOjsZxdaH8u0wTdjr1lmC97BuyqdFdQLtevdMuRgCxOlnTR+Af/jdiL3+JCMa4jQqRnasU7a
 FMDXgVLGggWhk8bZGbOFIZoy9oEowfSaVKCg=
X-Received: by 2002:a05:622a:4d43:b0:51b:8539:e8f7 with SMTP id
 d75a77b69052e-52d64865851mr25395821cf.42.1786519112382; 
 Wed, 12 Aug 2026 00:18:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4d43:b0:51b:8539:e8f7 with SMTP id
 d75a77b69052e-52d64865851mr25395641cf.42.1786519111949; 
 Wed, 12 Aug 2026 00:18:31 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997b33e038sm26686875e9.4.2026.08.12.00.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 00:18:31 -0700 (PDT)
Message-ID: <c1d86e93-d571-41e7-894e-988287f92465@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: INDEX_op_mul is commutative
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260811225250.173812-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260811225250.173812-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yOn-X6xijniAY4rf6N85ugtkHVRA5E59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX0AUaCUjBMWtH
 Xue9Md3eKqRF3Thb9XENfictCEz2ZmSpo+slC2qO5sOejPVitkCNtdHiZ1+biZajE67mlPJfynZ
 VKSXb5uuYkrsSRfam5ao+7l7OF+Q7+90rOtupKtKd2GvnUIJwg/XeDKlx4L7zpNDJDNoXNEi7rb
 SpJNlUtW635IZDe4uFUX+A3XmwxC5YbT9jvu0YppyrboIr7frjf96JsIIa0KTEXhaCZuVwQKs74
 mRqGgRGzWdYk+zhEqTrsETc2jL/4pJIyXV34FoqKC3Q6NOmA7RyHkCa77yhrZZB0AXce5eZXUnm
 SFTGonQdtcCl+8A7SC4KZxKqaggqcn3FCY/zOQTDJyVc9Tm8OmWmRFiBH7LcuMiv9j0VWpTvlZd
 g3TVOfZ8D9Zujuc6VNVeq1YUuvw4PUJch90aJCjUevvmQJTNRucFJfIg5fkszJxUfXCTC6VPCbw
 mpaZmePl1Rwxqgb3V/g==
X-Proofpoint-ORIG-GUID: yOn-X6xijniAY4rf6N85ugtkHVRA5E59
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7c1e49 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX4dt9fsAPWJrz
 DdVZlyaHwmTJBdRtjJmgSQ7TDlZDJ06TSDGoLGXYS3Zi5bqvRDXUEUGNJGpXYTqLh4rs0GDf9/V
 LoVj7DVq/SiVlc3KVeHXRlO9iX9SXic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120057
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

On 12/8/26 00:52, Richard Henderson wrote:
> Cc: qemu-stable@nongnu.org
> Fixes: 7a2f7084525 ("tcg/optimize: Sink commutative operand swapping into fold functions")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

