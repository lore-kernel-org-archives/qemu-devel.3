Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1B6C5CFDB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutwt-0002iL-Iv; Fri, 14 Aug 2026 11:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wutws-0002he-0C
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:35:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wutwq-0007em-EW
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:35:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67EDxI0P1770641
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 15:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2nAm6u36aZaVy39N39ejt92IrXMa4WBE+9HSOJnckHM=; b=L2YlvNZ8GI0yVHXv
 5qwcP2iVSmohxADtEx0DYHgs708usOFvJW5WMcn24t0Jz4QlOBm7Btp3jQebeKCq
 u9sZ7+BXCKSGMBRcEuAI19H8959NFc3otGQUTWoxN1K6IP2a+aOC465boapICLFx
 U5g+3rvB28mQSN5ZVzLmXq8ZZYGazRaC4hKyrLIi1mooaMNh991S4mQoh6H4YIpu
 nDqYCwp9Uvr4PQ8hbBNdz8Ro5EpZkRmKbl8NLtbseuHvKW8vlRZQgH5WrB3B/Abk
 FaN+lddgKn4GyVRhUNZT5RZHiVEOGYvHpjFABlV545lt8vRZWC0G2OItZVJs9Rwu
 5WAJYg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g21d9h9bf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 15:35:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848544a8496so1005747b3a.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 08:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786721753; x=1787326553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2nAm6u36aZaVy39N39ejt92IrXMa4WBE+9HSOJnckHM=;
 b=Zh9a11IO0ve3sr4rPwbw7b8+n73tp8s7BkwPAKBAUXrYrOFo6dqJ9VvEMTlbczTWs6
 J0Iz5IaGBBNg8Vl/txemAe8jG/lBFyKrealAaojzwYOlPZsiu5Jwse7c0CIyqFXcIJGi
 8E4c0DnKpfxx/DFCAvXLonu5xWhJvljfs20797jfiKJX5hCmfZWVlOseE3bbfTqnWbWz
 NdYDb2e/Qf8fp7oQ96hdYxoELNjccIQZDAZvRbLP4AuvCmzuY/SiYFqaSdUtWXLzEC/D
 QSzo3IcBPfAOcCHOBFBDB3rKW5PxKSep0lv9zbpj561oFpov6z8tZ4f98YCw5N+08uPg
 Jpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786721753; x=1787326553;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2nAm6u36aZaVy39N39ejt92IrXMa4WBE+9HSOJnckHM=;
 b=PpWVp85yShiVnEnGFHmOBZul5BK8hwW7HiHP2ZRwZz4hjdCpfgUEj9lDGlb+laD42x
 lVI2/x7K743qFJynZeF1bCGD35UlGiKCWJNzGFbhiXoqsovyZOtclJw17wxwlIPuJMjB
 wIGuRJVwurrvrHnYG64t3cbzPXIHdCfQ0AoS9d4Lsv7qyqkAMNL9GykTJwC4akzjWlgM
 MI+ZxSp6+Uyz9fLWUuaLnFXqThwAAAcLSS11mQ7KNyIyA0bb7oR8X0QL8y31f5ZygA9I
 SRgE9CA61nTLgJfBXn5DOL5SZfxx+2ebHG/G5Jo0ISdcZGJlpN1YGnykQjKgnTmITQIw
 ORlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBJMty6aGePKVJX7m/ZQKcUA7AapJbeILOLGuu4GmglSrIDt2EL4KT2EstoPhXb5gXqw2E8ZcBfPuC@nongnu.org
X-Gm-Message-State: AOJu0YwDuHq2kmH0GqxPvoMT6cDpST7llxTd1oxWv/EYNZnWpvNm1y60
 F7e9STKEiM/W33FT9NdyZS4zmuHI16Xstm/E/SlCOs0rkKsXJ+Bv9IvZwSwCR9rqCHH2t9qHVHw
 CnM/E2a99fCdAVrZ3HVwz66pGw+x9cgfthmsVwAJH5bif6LkMqMa8H6Q1ag==
X-Gm-Gg: AR+sD11rwi7WoDNxfbdjOJaWHyHka67mpmkGHbPDQ+Yrw0SQvXX5AyGsiFkbgWnSUCk
 tmoZttFzDocohtU7mP1xmfn7Qo1C3hlWz4smT3jg1toS1hoNa4gUvABx+YJxtOIut5c4DLIJQji
 mwaNKTIEYGbzx1COWoxToUHDQYdR/WDZjtJzE4yX3vd/gGpVETz8K0KZK81HAFXA9goZ0EmonZs
 j6pSnG6rlHG/nNHAwVk64xXpWTXk2cZZTz3zWbyuah5yWWD9zly+5dcYwBdzEd1UuPhFfbaQQg+
 wfxG+yf5Qmt9mkTXMQcwWSOTuYfoKsbXL0ofVPpoKjrBP6vFhXkfLiQUzTzZTBYTWNqloLMfSPa
 dfT0UkFem7AuIp8k8PLzzzGZ+NhrmOP4PNRuISz3vprSzbp0EEyukMc0ti4uqaAB9zKSd
X-Received: by 2002:a05:6300:2289:b0:3cb:e8b4:f03b with SMTP id
 adf61e73a8af0-3cc71ca5ad5mr7859188637.17.1786721753424; 
 Fri, 14 Aug 2026 08:35:53 -0700 (PDT)
X-Received: by 2002:a05:6300:2289:b0:3cb:e8b4:f03b with SMTP id
 adf61e73a8af0-3cc71ca5ad5mr7859122637.17.1786721752876; 
 Fri, 14 Aug 2026 08:35:52 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141387af4adsm9779089c88.1.2026.08.14.08.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 08:35:52 -0700 (PDT)
Message-ID: <3f213c3b-f154-40d2-9791-541cef12def0@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 08:35:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Restrict arm_do_plugin_vcpu_discon_cb() to TCG
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260814080507.23196-1-philmd@oss.qualcomm.com>
 <dec2a5af-dad2-44c6-8eb5-b87ff9595d7e@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dec2a5af-dad2-44c6-8eb5-b87ff9595d7e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExOCBTYWx0ZWRfXwR+SxriiKT7W
 WIMwk14rLLIk06uUsCJiHsG0IPEI4Do3LTl9EED2MTN532ZQ8fULZaNv1nma+VWzDEyJiBW8Kiw
 75GsFDTCJKmScBM5xLSxCDTXTcZODcE=
X-Authority-Analysis: v=2.4 cv=eqzvCIpX c=1 sm=1 tr=0 ts=6a7f35da cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=3ttgggD-EqvnbrFiBS4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: x2uM-fGp6rGEHq1xV9Dxhc7BiCa8RIXa
X-Proofpoint-ORIG-GUID: x2uM-fGp6rGEHq1xV9Dxhc7BiCa8RIXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExOCBTYWx0ZWRfXyGajEukV6+eP
 uzwfb+Tad21XnnUbhqSO0YxlSSGZrRpzA2KkKH1u9vhR7CH9ADM9IwSa5lHN/w0Bea7OF0jEsIq
 mnxVbdlKPg+b4pyTPleI9J4/l1Yc9AaYO3xVdTd2HXQxZnGBIeA5clkpbkTAeSa9DMo0+BP6zeG
 Ju1cnzpsetITygozrC+CvLjOtBGxlBUR3Y57xqZsOPQUHLXK8vTIWmZZXoIgZAPIjw5/SVH8soA
 uCX5YliDjpdmFoqt5daPr7IFlLXMa7ITVLdPTlhjQxfhFZh2MrnAjkpCHyJY6/VMXoclSFjTNTZ
 C8x8qJPVXNDzQfTH0HGBWOkLpDkUHO8EDkZzOspiSKjmFFuk4YPbBVzVUNIdqfSiCiKsiMQ4Osv
 0plIvwMczRqh2YXybII1/Gy7iGaY2X17jc/joOYq5h7V81hUFQeAhKEMdscb1y5FLGed3TX8Dd+
 QriyvesIkZII+pP1ehA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/14/2026 8:35 AM, Pierrick Bouvier wrote:
> On 8/14/2026 1:05 AM, Philippe Mathieu-Daudé wrote:
>> So far TCG plugins can only be used when TCG is available.
>> Move the arm_do_plugin_vcpu_discon_cb() call within the
>> 'if tcg_enabled' block and wrap the definition with #ifdef'ry.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>  target/arm/helper.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

I'll let Peter pull this, even if related to plugins, it belongs to
target/arm.

Regards,
Pierrick

