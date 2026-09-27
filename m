Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5821C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAquc-0005eB-Sv; Sun, 27 Sep 2026 11:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAquU-0005Yk-0e
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:35:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAquS-0002bT-HR
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:35:25 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxYR3091200
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=LwNORrdw3Jru6CqP
 JclZ2YTPCptKHZ1L8rVEHfJXek6K115/r2g0doYuu0hLvyORFVOA/1CerjqKD2s8
 yKQNQcc8ariZrRWa85aRbvmyDAJcOl6svmL3aPLLTu0mHvmzp664DRK2yCzK7rda
 VW10ud3Z8a2W01uZq/tC3+Ht/Jsm5Ut/01xbXTkwB4tbk19UyoexHdVNey1IrLgl
 3iV4sW56HOiI5XPpprLPsl7HUefux2faATMXpo84SPCUz8VVH1ycMluUs2dsdnUb
 wf7qTAWpGgG5c0P07vOCaagPB1NUg/uBJF2bFd7W7gJsFX0GQQQVfh536AWEttW/
 79oEfw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5cgka41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93bfb2da664so691038985a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523323; x=1791128123; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=VmFmKtqr8Q+dnB14dplURwicvn60FXlZcmuGIZ0Ut6GUQkp5o/K+vE1ooWQLG8vlDL
 +6Ay7lBWrifWtJnW9NzyhASOrAG6k9tnYBpEWEif3lw/rlz4ji+xc3F8bDKGeubUDITU
 Jv9+Si7YX63oTFh3Me5CBjbDYKEhfbbgVLkgK3FsKY2ePj0AbknQuQw9wcdNJdA0LQFI
 g8Xfi7HUk2o+fT1a8BfMHCDApn/p6vGNsez91HqQoTSIj1LR05KcueysdPA5n/nfuoB3
 S/3HC4NT6R3a3Cp5t10zgABf2zUw9n3taeWmtLuzN0rI5xd8NhMzFCRmgp3ZJHbKslqi
 iqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523323; x=1791128123;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=uvRYugBjp+ok5hf5XXjOfgaB2taGgPSrxCWo5eJfNbkgMfvroXX7Bin1+wxlOOxXV+
 BT88hfwQzV6rSKV6T4TS2xyPO01CFc5xeTuehEOnH8UO5K/G3ACbb2kkv5JrFP0UO8X2
 mvHrcOAPdTPkodVh3CZEJgMmX/ZZotFKjcirI1Dr7wJd9vPkr74oU2WOVesZSD8vlkth
 k2+pDz7PdAGh6xsjnbfz4RmbbgSQxQ4AbqqaaGm3Kgp/Q0GftzBMp3wad1dVtBn54tp+
 1u33vClI3TNHwpcwACW9UPG9+jB/MTKXI/Zsi3IJ2yJfJKCYe0u0hhWdroZn2AdqQ46w
 ubwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByawggoCzv9JUUmzB5lP23dRHOzirFS+TK5dqtECgFJq85nWxvEwdWClDCiL+wDZQM4gC43p39cE0pt@nongnu.org
X-Gm-Message-State: AFuF++miUf7sBPrcZSvjLFaFQCS3d9J32Kt4G0fW8qJkalKVkiM6geiO
 3EPDby9Pd2kHgIVOrbP3o1SwoLc3Q3vPQP3F7xYhmmUyketzdQdNRUDT31nl0dYGXTNoUqgkwNm
 /LvSuwufjWCCdwWiGVztdkltO0jMNIrIJX2WxXh/0oqizJ5CTAG93N6Oczw==
X-Gm-Gg: AYBFou1a2P4jBHNjQbkZcsl0d6WRfdz+fUmFTk3KmyeZOnH8QUImrAyqpwOBtNkvEz0
 nmxyGkpF79xzRMEJb8c2svQcB6qe+J1uehlNXXH1BMLJmQhfD83onrShNRucBV5uv12GsbEwYC/
 mRw8co/PMPVgUg/e64X8JrSbILj73vv6YjR/kTpzPy7i7YnDklACM6NLgGJPAhBM5hqE+hT+XCt
 4oVY05vYr9XL+j0zslNj2BcSUjCXrOiIdSJGtbx5ZN9H4jtd944QxiTx8MY3hGEGyT7PAl8lU2p
 thNHDMivtoACxuM1GOMSIcOAIF0MlTL+VYY4jWj+uOxa6l19DkfJKsWWi5J8NyI3/Lq6KiHJg84
 7kW74a2Y6ht0yziRLNj1p8/iXvooTkwB+9A==
X-Received: by 2002:a05:620a:a195:10b0:93c:61ec:d17d with SMTP id
 af79cd13be357-93c61ecd8e5mr534645985a.14.1790523322774; 
 Sun, 27 Sep 2026 08:35:22 -0700 (PDT)
X-Received: by 2002:a05:620a:a195:10b0:93c:61ec:d17d with SMTP id
 af79cd13be357-93c61ecd8e5mr534641985a.14.1790523322037; 
 Sun, 27 Sep 2026 08:35:22 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a64f9bcsm21263313f8f.32.2026.09.27.08.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:35:21 -0700 (PDT)
Message-ID: <e8f13687-0f2e-46d8-bd5a-4eb7fa1db18e@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 023/101] tcg: Generic expansion of tcg_gen_sar_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX+SR3SWwq88Tf
 m0fd97Q8eMv6nO4KWcrf3wQFVuvxpcMoc29pAmAzFltn8sZb2d/m4IAUKl0oXzXeCl7D9gw4inl
 jZXEZl0/Bs00eUX3LQuR3OjXM2KvIsCwPzNan4U6icULxYc/3JI3nbokfvHcW27Wius/8iGzuEl
 PfzuFAEF5VC1z6nqoLfNUu1WvT6YtF6k+VoDFV7cFfYJ2ZCJdXRlW0KCLcIoQRE+lhrHsyCbfSu
 l1EY49UzDXDu2ZLcwBy50XT1ZW9vZqKQN7ihK1jyJR2Kh3SYt8kqaYz37eEqNOS9qk2oNQtBk63
 ppxUajQOWSyKYDcafUO0LBZNrhVTJz/WKTpT7tL1Hk+7osuVuctIw5lffaWbI/8eNbzBxH6qxVy
 yPdvWEOvO+nkqlb5k0RovHwc05d0fr1/skrDeHQsZgGtKddd4KfHFHQ5otsvtKrrsa2/ek6cSSu
 dCBkMlb1KFu1JZ+NlAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfXyR0oFlNf0In/
 mViVtTOvOcSZyZ0CSp7Uvi1q6At+A0XsTGmaIZ/SVsQplB8uVk/Q1loKU1fGuMLxGdFVATtvxJF
 mn4M110fz1cZ5+VcjhpoLkcs9cj4oPY=
X-Proofpoint-GUID: -YMo8AamPbvElXa12-sfQIwjzgsjyHQw
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab937bb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: -YMo8AamPbvElXa12-sfQIwjzgsjyHQw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270062
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

