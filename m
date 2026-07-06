Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60404C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqa8-0007PE-IR; Mon, 06 Jul 2026 17:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgqa0-0007Ok-Is
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:10:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgqZy-00048Y-Vl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:10:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEMsH1613913
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 21:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mzbyYh38z3KgX7TxkdDCYk9q4PQzfV+iYx1BNUL7d48=; b=Ml1YcLr0z2LNVHT3
 PcpNT6MO3QoCY5T6rkZcUZLyywONAiSs7+VoBtX8yBfdzDImS6E4JHiMXPlsB+EX
 R7yQgSzc/707LXxFq471tP7aK0sr9wllI0LJDlEO1QqBDc4fjXoGrSW+kPcNmmZl
 44tMYy+q7/Re3H60QXTqbvL4p+d0VzGaoOosYsJxt8aRIMYDD3wEJlpPe4hNG2Mz
 /0NBNXhkEbbmuPCiuphH7Y0zkkheObvqx5x+qtG+IgrUP5rdUiE5xeA3sZr5yF0X
 pHZWX/iESmmzApmtqRbOh4cUIxdCOEcpmYsgZk36b7mJgF5XSIL1U6NCjkQIOcCM
 JM1kiw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h539wc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:10:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381abcccbf4so2395162a91.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783372212; x=1783977012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mzbyYh38z3KgX7TxkdDCYk9q4PQzfV+iYx1BNUL7d48=;
 b=igdtZYCVPKsA84dZbIWT+YsAu9dhqwkXRF/+8A2B7fERrL61kn1Fy58FIqLWpkBA9t
 KbwIvz2pJQ8N+RzM1MwqVRT8eBNvZ2KbJM0y4EJmlfMcXM7cE+IZnqSAlMQ1yX1mTWq/
 AJVLEOYhlK+1AiJwCXTylJ5Sq/L+EwQQUaRu2A0neSZDcBbGj86T/BmTzDRTwu2/A42M
 p1pjkVVABwYt0XwiwgIgzADHcw0eo2MUMWjhtDNE9qOPHhIQIgPQypjwFdCAVsgJwc7k
 xA0x8LipfDs1Cdpmybpkec1vrDs4fYIqWDHaofBOxLgEByI2MYJiN8GaVzN3YnrqAmTD
 CLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372212; x=1783977012;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mzbyYh38z3KgX7TxkdDCYk9q4PQzfV+iYx1BNUL7d48=;
 b=l/Zix5MWwCyskNeoD2ES8hNMFpknvGc+JnUbJJO7UTuWu49PI3fxsOOkjT/1xaPZiv
 ESRWsYfzaKCSoUuVIoa/4FOKL2mIbXRwtm2IeVRoGrmSQ//PzGhAgewxgKSaDTndEQdg
 3eZyELLV7xTXS+ppRSdCV2p8jxyCFMQSjlIFwF0IObBeAUJN/g3zEWCul1iCwSf/aCW8
 AifJQImzhyzikvX2/q6etHLQFhcM+fi101Q+r8mB5sXlYWln0w0cNKVo+3r/LTlF828Q
 1lLUNEvK4yolaMYtv8h4QaYqE4Z+5Bv7wFygzSH9PwRmz7/I1wyPBbsB5GF32SEZOWnq
 2gmw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpdq13GznnYmAUv8b6B6kkpkWkpvj3KCCJtdT2dv3AE/CD5AEMMuDy9NGTLJza6JCm96DJRZV9q5zE+@nongnu.org
X-Gm-Message-State: AOJu0YzBdPgGiLLNj/xgXewTt5QiSdKvFEXdw5RsSy3a2khkXPtnM68H
 8ithyqYznM2JHGGAhEimCRh/3rBlLtqZKVBopCuYZ2zD5GyypflAZpWdjSxEEHmt1uRgrjxuA37
 aK//hEB7bPuYWmAS3Ydh2sZm9q75nFzZO9K14DHSmo5WS27oGi007b4BQcQ==
X-Gm-Gg: AfdE7clZCQa/gcMXzvBrEvV6n1Rv1i3fCQjLIfI0bE83OtTo/Hxma3qRueX7N3bbRdJ
 Gj55QIip2mluBAAb2gv4b697w4s7JPKmLC53KSDVJQUQX7LCWBQJqGKCqFn5JoaayAy+/+j+S6S
 5X1IpFIZlEfyk3jIftEXgepbpO8B687EY9arwBaxbk+SNqpam/m6/EovzcOpS355aAa+wCkGss+
 KZbI7m7D/rGrYpr5jilK6GY4jCotazfDh/6yPecn5jHadbTJhzqrij/ShScJsJIwvj/laIOGkyi
 Zhbyrclw+a+NSxYbwYHvYJMsC/Qdrttp6kC+lnAxuO0Zel8c6jmPkUFh0SC4grqf4NPpn1WqCaL
 ISYmqbuZ97O2MI1qguxvpNt9bvMtPhZKLne98rlaHL4p/bVO9kakTFfLnV0ekxcHAy3I74IJ+py
 +OEn0=
X-Received: by 2002:a17:90b:2c83:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38755768d58mr2327490a91.12.1783372211913; 
 Mon, 06 Jul 2026 14:10:11 -0700 (PDT)
X-Received: by 2002:a17:90b:2c83:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38755768d58mr2327466a91.12.1783372211395; 
 Mon, 06 Jul 2026 14:10:11 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117462f5c7sm682167eec.0.2026.07.06.14.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:10:10 -0700 (PDT)
Message-ID: <7553a7ca-38c9-4aeb-aaf7-1a1d5c4a7160@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 14:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/9p: prevent potential error in
 do_local_xattr_limit()
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <E1wfg2F-001Sfn-Rr@kylie.crudebyte.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 2bm__t_x8CzwthewQCmfQcIR4oCmgQVO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfX3o5RyNm0Zorj
 u1AA+lg4rJKj7pr/JzIQkX0SJKx4kNgtQAq3SHeYLzFQRIbn4z9hiuRHu5Etg5UGoMP3m7GXQAr
 9urV8Iz8nbzgvEjxKQ5y2+b8x24cXXM=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c19b5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=K92WTf5yAAAA:8 a=EUspDBNiAAAA:8 a=V-XW2VRqSrOYZrSnXtUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=X9ok8FpLfHEzVMsE4qxm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfXwLO0UR9wXWK7
 VFLMTl1+Lg0wWSCGW8mIDxq4i3IEsy0DhlFwLUrBxmnZvOguCODPdMe11SqvJAIt8wO3FRLsT9U
 EZ+XVnWRHBKI1MKwXc0sFCxWzpTr92Y1KG+SSYgGNsejFZQ4agH1qx8o3AxIp4kfvZV+/calxN6
 WwSBZ0hzl3M57yYtqzvErYn4WK7lQREft/gTp4NJr09obfIHI9oXVtrU3m+RcORLCtr5SztHYHR
 Sk9roh//HwQuSlEc2L5AbgDPVH0SQZABqAldfvxvdrbwZsBTMCdt5Sd+rV+C0w2kRpTw9LVE4pU
 zIKsMUH8jmUccrRhcPDphudNczlF1pawpvX7pjc/uApe0dJrPjwFCBZWlOqJ6tzaMRRZ3QCA+Xz
 Axj4yZm4209NaNgmRqPcN6UIe8MKvedA4vlfuLOerNo3ciVpVt6Vtl1iP85Wek4Ls9Q8rey9FpE
 NnOqsMfFpKSveKGXiWA==
X-Proofpoint-ORIG-GUID: 2bm__t_x8CzwthewQCmfQcIR4oCmgQVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060214
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/3/2026 8:38 AM, Christian Schoenebeck wrote:
> The local fs backend driver tests require that a dummy file is
> created on the host side before running the xattr limit tests,
> otherwise the test will fail because the file is expected to exist.
> 
> The original call of g_file_set_contents() didn't check its
> return value, which might cause subsequent test checks to fail,
> making it harder to identify the root cause.
> 
> Fix this by simply wrapping the call into a g_assert().
> 
> Fixes: 04a62cdfe873 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
> CID: 1660926
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

