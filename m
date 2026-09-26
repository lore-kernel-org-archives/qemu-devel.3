Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2A2C98318
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2026 09:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAOe0-00030D-O3; Sat, 26 Sep 2026 05:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOdz-000305-7q
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:24:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAOdx-0006Su-Jx
 for qemu-devel@nongnu.org; Sat, 26 Sep 2026 05:24:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6ObSi3135838
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IOZlYGurHVmezRRTeN8lsKEE+QWm9IwKXrSGmPm6lXo=; b=Ny37L3519rKnPm2K
 v2TJQM6ZCFvi0nSiiFVlLLwewtFwHHOubm7lqMIcB8Om82Zt6QXHDNasMXe1QaWb
 sdvh2aSgXbvz4+Pc9k2eRExdOmefK13r64z+wrSoURqZHgeNmVn/YCUBBD83vJAN
 G78ETiRkSX1MAW68B3uSKoy5QL5K4ubGNBIz85x+z56H236Ap2AkEDAIYioH8cn9
 Oda9hJhJHFwEYzm6ckvON3k4TARiFJmaLZXtFwHZwp3oHqKXRsDw4+HfQbNVpqdi
 wD+4r0boLdjJN8kEFTWzpkw/pKvfXkw7EQv0cC9RKqzrYFW1gEI/kTTnmt9ZAMJM
 mdeVDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5cggn06-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 09:24:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ae8e7e546so335543685a.1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2026 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790414666; x=1791019466; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IOZlYGurHVmezRRTeN8lsKEE+QWm9IwKXrSGmPm6lXo=;
 b=RNHIcapnE2QOmIFdV2H1YZA5SpqLbYqZY6G+QGo/QNWajmo5U2K4CLkrDrXjcEIY7i
 XsY5A1qi7CbKcN/wfRS9UmNuXbaVU5z28oSfpaP1wAIPUNVJV/K7y33fZ6qYgIswwqEr
 QS2HgFATEhHD8mJgVLFTul3bVL/GPaLXlPUGygxYfQyhyms3IbYvqM6Qfa/gGFkJzdux
 GdCcvkn05QPF9J6/8Zb0599y6scOGNnnTWrNYxHk8+IixxMpgBRhUPTLGJzBf4eOsq9h
 iXBTRO0rCTHluYqYndbinD0sat80xnGOnEIFAZJrQ4K31gmcKS2vNiMxNItOUK13mrEP
 ywew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790414666; x=1791019466;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IOZlYGurHVmezRRTeN8lsKEE+QWm9IwKXrSGmPm6lXo=;
 b=qu7zZz6MzlMMaIWanQrTPhIca1NsmUM7BQurKU56rSW3EPLYUnA+3CV8HjfUCpu5kf
 D9AbVbYE1CM+kOCOy+9TOx5RzGe/nrxlho8uhKMcfURUHsnm1hqTGkemEvI30T6o0isT
 1NAuAi9ZvZ0Hf66J8ypAV01fAocnupEaf0B9FDeotTkXNuUz2Cz57/pC24z4akD+JL0c
 /oIfPGj8uOB/XmdinbzdshSjAUqg0Q20zfY8/dbwiPbAgDbPJhoAwHIVDwji9GXSY05q
 9LLiE5k12Op+QlDgfM62/yd6H7Vj9I0BXPzdt0q1lW53AYnk0IEgDI1Egk2PvWUH99UH
 g6Zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7erPZhWYf2M9A6lz1ZPloUSW39T+lacmTFET1fk9LaCczgw56FL+vmzEW+vN2yvXLeQX6L+IJsjur@nongnu.org
X-Gm-Message-State: AFuF++kEUXryvn7A26Z57r/PPkfx0ShUI8wbpCeUfIiVgM16/Rvz6Vfc
 v/EoGDduxEt2Nb77jsjRlvF3swo55WrIMThLHKPJQNbCYy2XfTo8rNrSXKDho7oqRAaDxVnSo6F
 BNSehT7rCqetrZHPpkXx9tPkkQ0amWx0FN1VuP0IHAbUvl7sN8c8SEIvVgg==
X-Gm-Gg: AYBFou0G8KDgwUYUWPCLDkd09fdnfiOwWt33jolSXnFKefJS3KtV2IYtBSLz1yi3ELj
 tHKFgUFvR+BYU4SJPGXUMQvsd64eZIzV9bJDem61Rwhgci7kP1/ecCpLdaNFXxzmBktt8Vu+Dpw
 0/p/ezvFiXl8dPk4BsYzMtykk0TmfFLGdGihmZ1b3bGQj9LO7CAUS6SJ7FnqFmNk7B1FfDklSYO
 xG8brd/CYc9jtmuQMM5UyH1bnTax4CF1QQ/AxoC6kRyh+HWM+C7VWxRkGSzd1BnDuCggw8u1B7x
 gCUSWkXv5mxvyGYsNDkDLfZxaJpytU9+Mlv8t2c/wJ3OWQbK0aL8aaMPaLZarF+bCqvJJNKL2+P
 2/iIyb6X5KqET6Z2+DotjgrpfTJ+yVlbTYw==
X-Received: by 2002:a05:620a:438f:b0:93c:635e:6f3e with SMTP id
 af79cd13be357-93c635e76a0mr63533185a.35.1790414666302; 
 Sat, 26 Sep 2026 02:24:26 -0700 (PDT)
X-Received: by 2002:a05:620a:438f:b0:93c:635e:6f3e with SMTP id
 af79cd13be357-93c635e76a0mr63530985a.35.1790414665799; 
 Sat, 26 Sep 2026 02:24:25 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcc4sm13463438f8f.1.2026.09.26.02.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2026 02:24:25 -0700 (PDT)
Message-ID: <b2508146-1158-45c9-82f5-d1d7c43c0263@oss.qualcomm.com>
Date: Sat, 26 Sep 2026 11:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c: fix
 compilation warning
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260926010053.2840-1-pierrick.bouvier@oss.qualcomm.com>
 <20260926010053.2840-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260926010053.2840-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAzNyBTYWx0ZWRfXzT4rqM28adSw
 NpS6Ae4u2SMFFtyPxD9dlP/N1qGTotCMlE0DBmFilZ8iu6lhHa8DYn4QYvF+KgKd06YPkTdn6pe
 3kakI2XL5q3SWApILIn2UvWcPRb9Xcfw3I9c6xrKFlTxQtJ52km2swn0pcXfqgSuqLjCv7006KV
 F27H22rTTdK/a64iQWqt9M0FjBdsLBemKg9vNhd+d+Y96Mp7F+ZNd98Y/UebffcceJHn8XfSVt0
 QPKi5JrWxLOWnZhX+Gzmt3gcBukv9lN7yhy9/IgEfVsxksMDAPgEMOtKmoDxQrN1RaBChTSkV2h
 wBTbaSp+kEzDgGT+DTrFRpVWJHOJNHjgVVa4FCWkHt0gjn3PoVRyFDnjn/GBP73dH/i3qXsho3v
 hiGEGFStdKvZMMjTlvOBo0sEiliWbtztgwZmeHLWdwHQSYyNJwSACPpwD2T5fMl5nfDYThSkBNf
 3vPMEe7MUo6Mlv8xxlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAzNyBTYWx0ZWRfX1T5LUMkexnJ0
 LLT+xS5WLFJ62gMdbFcNBiF90aBFTRi2UhDvDfbqb7uQzrJhPXpuR6UD6Jtxb+ijWerr71aSFzh
 i0XNPjklgIPMLnmvvchVs0Sl3MODMnE=
X-Proofpoint-GUID: svCI5GVJQ-ssZr58cfnJGasqqoVqvbvE
X-Authority-Analysis: v=2.4 cv=QvLLTlyd c=1 sm=1 tr=0 ts=6ab78f4a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: svCI5GVJQ-ssZr58cfnJGasqqoVqvbvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260037
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

On 26/9/26 03:00, Pierrick Bouvier wrote:
> ../tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c:13:5: error: ‘dsp’ is used uninitialized [-Werror=uninitialized]
>     13 |     __asm
>        |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mipsel/test_dsp_r1_extrv_rs_w.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

