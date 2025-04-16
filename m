Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A793C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 19:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u58fI-0003xM-5y; Wed, 16 Apr 2025 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u58fG-0003wr-Lx
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:43:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u58fE-00025p-Ay
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 15:43:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9n3r8008012
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 19:43:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pQ8eFYR4AKQWYQkygxr6h/lXX5xQa7RFQ3jDNcRmm9c=; b=Lh7e7k4yySJXMPh7
 Dej8f2KqlNuTydAqnQtJPMu2t2qMYwlGkMejzCQIC67FbT5LWrTKVSoEd6e9E+xU
 nsvQa9GGRpf9Dtq8tXq3Y5wDQaZkeLAe1OUZQJUcNuto749p+PObiHMPMr2WL43E
 vYIhmueU8+ebnT5nLXHoUsacpPu1fDNHmVGnFmFzO97wek7H/5KnrEBuMuDBXI4a
 6NsgSiPt0Hy8hnISxnfApgG5/j9yDDj4VL/A7NRlnEC4l2mOXa7Lvcbn1egxU7D0
 unv/6LpxYO+VJrWjIZj2s/JXaEX5/VqbyRtvU5RQeydTZePggVMICecAO71im+Q8
 TmqUrg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6mr65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 19:43:12 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-896c1845cb9so45263a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 12:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744832592; x=1745437392;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pQ8eFYR4AKQWYQkygxr6h/lXX5xQa7RFQ3jDNcRmm9c=;
 b=vcnzZOBlNz5IjwVJCstfc1tXRFB29MeoXE7vTebqR20uNqGjihrigLy7Ap0VsCwKU6
 xTtNYIDbqdcPxVD3eNs7JMto0WxBU7Qz4NjE4PUST9oMO9XfqFEygf/IiCBqi72UVwG2
 Isib/a78vqGFl9frOH15bP4tR9l1q9wBZtlzyGaAbro+KSvdZXl1akiFG8bn/tdNNq5Y
 2YLFCOS/iOiqQ/JGV632TvERgnLUwjUILf/QvJ+H6ArffNGYy1fXgFnTyfKPZwxDgzZY
 r7Ti48CCbwRuiAeG8auC/0olQCC2W/ddJzyP4T0yCX2qhuys9Ii0x096LQdiZceQGO//
 himg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5oF2eJLXxRNisrIr5+HNl4462YmHrYZNPb/Ty5sfhFYhvFQbpkGkFwJfdzX6jyyJtkHMFgOuvFJ1q@nongnu.org
X-Gm-Message-State: AOJu0Yz4bOPg65793cwf7ZQRV51ybnw7a3cL2qGnrfyt96P3v34Bf4C0
 iHlbOkwO5wNvm+D+/1xVg8aZw5hr+DHex49URTz4Mp2AYCQGYjm9jCt/jV5KFo8aUD5Fu15ouvw
 WiiamXFBnuvtEOqBoO1JDuWMwjRcLQRsueanm4BSEDibJ1/2hZ04aKA==
X-Gm-Gg: ASbGncvPjkEBVuguzSJE2DtezOMMdZnHXRTfJnYGeptP5u56fIpeSfyHFd0IlFne5Nu
 FKIb2kSvyjnFiM/uol9ARtsFDrauMONHlWInJ/QL+TbFATCgxPBjjBsVDxeAVESNZzqii/XFiua
 s/Nn6kigxFrAKRSiqetroZhyOu5vJ4uhuc2PN7FVrfWZ/+gKKr0VOk3JncUpixge+XkYKLZ0RFQ
 8ejZnNn0UigJuy7dl964rTwNN+7qe0/XsXX+zZWzeNMyZdqeb4AK3h1V7CVxGOCfNMMXt90lgRQ
 KlF9lR6EZjrLCUIrEyO6N2jOE4TDuSnsCQ1SIYhlAKnIM1yqVz9R9AWKbkeJBr/HfiZ9QzF4Xkt
 FP/67wNcYCv7A
X-Received: by 2002:a05:6a20:12d5:b0:1ee:45a4:eb3a with SMTP id
 adf61e73a8af0-203bdc09e8cmr230482637.3.1744832591522; 
 Wed, 16 Apr 2025 12:43:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIGTtyQQG14ZuvkAWtCdVWgcVYxmWaY1SxEi3vu6Iq1OgtNN+QuuPlchgalKf9GKEBOdm+jA==
X-Received: by 2002:a05:6a20:12d5:b0:1ee:45a4:eb3a with SMTP id
 adf61e73a8af0-203bdc09e8cmr230446637.3.1744832591106; 
 Wed, 16 Apr 2025 12:43:11 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0b220c217dsm1681634a12.18.2025.04.16.12.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 12:43:10 -0700 (PDT)
Message-ID: <d9b21bcf-cf13-4a4e-b942-2a61f71bbdad@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 14:43:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/38] target/hexagon: Add System/Guest register
 definitions
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, quic_mathbern@quicinc.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 'Brian Cain' <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-4-brian.cain@oss.qualcomm.com>
 <079301dbaef8$91e8ff10$b5bafd30$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <079301dbaef8$91e8ff10$b5bafd30$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cfjoz1pM1DnE-KfYfNh4V8D7neFSogdT
X-Proofpoint-GUID: cfjoz1pM1DnE-KfYfNh4V8D7neFSogdT
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=68000850 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=qxlKCiWka6-DMCtsa5kA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160161
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 4/16/2025 12:54 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Friday, February 28, 2025 10:26 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
>> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
>> Subject: [PATCH 03/38] target/hexagon: Add System/Guest register
>> definitions
>>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/gen_analyze_funcs.py |  21 +++-
>>   target/hexagon/hex_common.py        | 163
>> ++++++++++++++++++++++++++++
>>   2 files changed, 181 insertions(+), 3 deletions(-)
>> diff --git a/target/hexagon/hex_common.py
>> b/target/hexagon/hex_common.py index 758e5fd12d..db50defeb6 100755
>> --- a/target/hexagon/hex_common.py
>> +++ b/target/hexagon/hex_common.py
>> @@ -33,6 +33,41 @@
>>   overrides = {}  # tags with helper overrides  idef_parser_enabled = {}  # tags
>> enabled for idef-parser
>>
>> +
>> +def is_sysemu_tag(tag):
>> +    return "A_PRIV" in attribdict[tag] or "A_GUEST" in attribdict[tag]
>> +
>> +
>> +def tag_ignore(tag):
>> +    tag_skips = (
>> +        "Y6_diag",
>> +        "Y6_diag0",
>> +        "Y6_diag1",
>> +    )
>> +    attr_skips = (
>> +        "A_FAKEINSN",
>> +        "A_MAPPING",
> Add A_CONDMAPPING to this list.


Will do.


>> +    )
>> +    return tag in tag_skips or \
>> +        any(attr in attribdict[tag] for attr in attr_skips)
>
>

