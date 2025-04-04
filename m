Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACF7C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 13:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0hBT-0000ZQ-N8; Fri, 04 Apr 2025 09:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0hBQ-0000Y2-W3
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:34:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u0hBO-0008PZ-Gn
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 09:34:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534899EP006483
 for <qemu-devel@nongnu.org>; Fri, 4 Apr 2025 13:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSrs90+dbGeVXwtoRu+wVayI6xNrjNLn/Ow05ZVxcmk=; b=ma3zgp/QQUhtMYBc
 TH1NBW7Sld7hj01J9HtcI76396KdjsWfQKUMqZdZ61LjhA+l1rvO9dPMmTN+es/c
 snnSqsfR+0QKcKyH2VFxhwK0Bv2I4xEmoGecIQ6yxQpJ+8WYI+/lubw1/nmnrFun
 khmzilf9WivHe9FJ8GntVcrsWI4/wgIXIspu2UGNxFwdiTPB0WKnod9gxxyJPJdQ
 K6EP7UuaCcxzodsxoF02m80AY4QRxykl2Wc3sjRH9BJyRv6o5mkj6P9ZM9yXt5yB
 44e90u6sIMkQ0WaE8S1h6Z0K3Ag1UnNG922P1R/BJLSsQ1hnlxqnLczFIXPck6Sr
 9fq7Sg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45tbnkrsmc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 13:34:04 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-73691c75863so2581525b3a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 06:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743773643; x=1744378443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kSrs90+dbGeVXwtoRu+wVayI6xNrjNLn/Ow05ZVxcmk=;
 b=qregEWFfPtTh1jBZc1dooM9kR2VDvkJ1jRG3X2AIm4V6vXGBcs24H1g8NjusZ85lbV
 5HwAZJPexxDu7+fI75fgMWqIThHKd24kz1f/QFlm6scqynnT2gSptZPIdKYk5Avelnkw
 dyDFpo1ZhaAyj80bjQrKGL9aVlFyXBqZLaVvdNu2wl+r4hVpjhbz4i18mYzDqQ9CuK1t
 3BL3pUSv4WzXSHxRgEyVZZZH3UTwQ+1iaZ0z9IQa3gOidL8ad3nY+8vZZyUOV//eNI+Q
 xl1pLcmRYJG01FK4SRUicWANDVW7rQ+M+mIkr/lhTB1JaiCOuOB0oHKuR7Jd2jRhT7EG
 2J+Q==
X-Gm-Message-State: AOJu0YyXmShJXeuJkOhcKhtWtjHsLFMgmALoBIQyw7LnsEA8QIITJTQ1
 NDqBw9CV9WosewH8MpD/cvVup49nFRJdlixXGzSrfVVLM3GbGtEAaR5FFegQekTW+wuVxLDYqy8
 4OMaD3o2q6tCbL3ZN2XZchXTrtLGwE6r5tPR7u5bdvvemlmm9L3Zh8w==
X-Gm-Gg: ASbGncvyPWJBDRuJP0eRUQAdgkRL84paFuujGTGkK/Am9rz73qiS150618U01+SE0o3
 ZOKKNwD01561KOTM1R5QAyQL9HUjcEIf/4azYUMXIMHd8Mmcst48E4fhlkp0nzw2+0i/2GXpyW8
 2k7lJ2tvyz6E6PPhZSjurC3v1q1zJOy6qOw0nd0pddgvQrUdHB5WShOcNsZHZ9TUKNWatIa1QW7
 JXdN7GjqBDNiIlFI/RbaYzIX451T8j9LZUsYXAtMjlkVGbnT0+Adi3zI1jsW7qArvvjzWDUCt93
 plxrrQvAMk/JwpVxvNVam7vmKlOxHO+79YCv1cXagDANhJON2yFWyfQD3TJ5X+nD+fySQbKe4Kz
 4Cby/88ESXe7Ed9Lv
X-Received: by 2002:a05:6a20:6f96:b0:1f5:8eb1:d5d2 with SMTP id
 adf61e73a8af0-20107ef74f7mr4348806637.13.1743773643161; 
 Fri, 04 Apr 2025 06:34:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZhM1whU1ZxNkhas/+qvvQV+J/yNQTwULt9FgBovFcqKHL58wPMItceWL8npcco7rlJN5E6g==
X-Received: by 2002:a05:6a20:6f96:b0:1f5:8eb1:d5d2 with SMTP id
 adf61e73a8af0-20107ef74f7mr4348755637.13.1743773642688; 
 Fri, 04 Apr 2025 06:34:02 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d188dsm3331785b3a.7.2025.04.04.06.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 06:34:02 -0700 (PDT)
Message-ID: <ba70f317-36db-400a-a528-00320f478c08@oss.qualcomm.com>
Date: Fri, 4 Apr 2025 08:34:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/hexagon: handle .new values
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sidneym@quicinc.com, bcain@quicinc.com
References: <20250404025203.335025-2-brian.cain@oss.qualcomm.com>
 <20250404132551.3677006-1-matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20250404132551.3677006-1-matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3op-omrCld-tj4gGwmxAxjssas9XGgEw
X-Proofpoint-GUID: 3op-omrCld-tj4gGwmxAxjssas9XGgEw
X-Authority-Analysis: v=2.4 cv=X9xSKHTe c=1 sm=1 tr=0 ts=67efdfcc cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=dl8oikHrIOYbeGwnjpUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_05,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=635 impostorscore=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504040094
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/4/2025 8:25 AM, Matheus Tavares Bernardino wrote:
> On Thu,  3 Apr 2025 19:51:58 -0700 Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> From: Brian Cain <bcain@quicinc.com>
> Perhaps it would be best to reset the autorship here to
> brian.cain@oss.qualcomm.com?


Good catch -- will do.


>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/hex_common.py | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
>> index 758e5fd12d..242dee3731 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -349,6 +349,12 @@ def helper_arg(self):
>>               self.reg_tcg(),
>>               f"{self.helper_arg_type()} {self.helper_arg_name()}"
>>           )
>> +    def from_subtype(self, subtype):
>> +        if subtype == "":
>> +            return self
>> +        raise Exception(
>> +            f"unknown subtype '{subtype}' on generic Register class")
>> +
> We use this method for other reg types downstream (HVX). Since, in this patch
> series, we are not really using from_subtype (get_register is always called
> with subtype == ""), I think we could either exclude it from this series or
> evaluate how to also upstream its use for HVX.

