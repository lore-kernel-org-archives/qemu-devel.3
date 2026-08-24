Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74358C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOZE-0007Q1-8L; Mon, 24 Aug 2026 02:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyOZC-0007PC-BH
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:53:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wyOZA-0003QE-7q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:53:57 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5RE3b2602040
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OM6ZGxnbuqYlaYrEd4dwo65wF8sU2kEjfJi3gWt3VNc=; b=aiY3P6zYCl/EVreS
 /L+ojio56/EPkfbOB+dbTS5eI1TlhmizzttnNHfh1Q38PQPldViWDgKaR06koUHJ
 1omyA6hW9pPayluqua5oIiDM+Y8EIpAZ7Zr1/EwINUMAn7DzygfXVAot4K32ZpuV
 20r2fW5lZKsEQgo8JAM27lp0zNpCCb00ugFbaEYwRMT3Hvy2yaPdJEYP0gHcNZLr
 GTzW/B8TLF4V9mQ3OEqDEad7MqGr6BWDAE0toRZB2yHG7R0LmedU6E+R4d3TSFfj
 /LQXUX1x7dd1wyqBGgujPVCBPtj+Q7zmRzkiKpjGaHI4WvZM2QBsTsmNzL5Q4C3u
 rPQ+1Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g744wwj7p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:53:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso2735117a12.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787554431; x=1788159231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OM6ZGxnbuqYlaYrEd4dwo65wF8sU2kEjfJi3gWt3VNc=;
 b=WzwIzTDYX+7Mtaoh/XT8PDaiH0VaInJe+mGeaoX8zfYTrVAdh5F+1XUc0JDGclYcg3
 eDqBa7dDO9TUVRdErhCuQcZehytL137IRHgf+b4RP3Uvn2ui+iKXiUL907IDDC/++wCH
 eXZ97Jsk3cfQ93yv0lIQ1bVdbZLn3Dw6CVN4jMwnHA66XbsPaGLG3+eoTcR5oM3Kv7lG
 8W+83UScVcW5YjWNhqz+uLp3tsYSvqsfIUokV01+LIX0z3KNc8WaiwhwJGbtIGSB6sek
 Our1DwXBBYjoxRIiTjZPrqwD9970/DWhtlm5fu5+EJ6m6TOas1vw1brxbVhLVCwiZi9Y
 R6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787554431; x=1788159231;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OM6ZGxnbuqYlaYrEd4dwo65wF8sU2kEjfJi3gWt3VNc=;
 b=ceOx8S1NKO7ofRKhQtbtHRF2iYuHPNAsVAbXUHXRPiz+ITyYWMOwtGP6xSwEgEndpw
 E8aWCPBjj3NsZc/WFu5atn9PaodLPlK5HRXC3XBeTasYVz+rEGVW83nP1XFEldYhuber
 o/yV5WgVDl/KNFPQMtY+WK1dXhYo5pGpov9z26qiWa9qIZBa/gF16GAWo1zUCRwhBHVg
 ybHk0Ew0kHuT1s6J4MVEQ5UugzDWxXt9fB7ZtPlHge120WBJSSjPGaQDU3NTQph2n2f8
 nrqqpang+FadEa5Wr1aF5rS+BkpahKrpM5ZfkhSsPkqr8+IfGzW3dHa0TQcRLfLbOXqB
 3qMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQIR9opRrx/lQ4pnpvFS5dtOsmaGexxxasezFh1cn+tBuZmO6mzHmlnMEofkMODlIhanh0gHHFxYkE@nongnu.org
X-Gm-Message-State: AFuF++kOyZjTaAeeclEbnfxKSnsVl+Sp02N4nXDRQgZHaCfRwzfUlgFv
 odAK+byOOZWhvB8jU8ZawhvFym4GeiyU+a4lnb+czcVrp/o30S77XzjYQCfwZp6izAQGmLsrfcs
 rAR3+tgPtafT3J/Kwd6pZZvNMW9iMkIJPccUi/Kt7a2ON+yadnDtjU7k9Xg==
X-Gm-Gg: AR+sD138QET6eAvafaKfhNeYSq3SWerld37T9Puljzr0us5d5ZJJA5f2zE3JTzyz70R
 XWwxziYiFHtUKgQ4smnp3nc8r6ii7N/E1wtrTOLWM5oHriQclpXcLki06+UpvJ6LfLIOOtbegby
 hWhPTwUOxJ/0q9m4w7R9CIdDAHb3JN13BtGnyKLZKOJ0s/ZqKsJigNQfJivMHvUpo9l+zJO+Eih
 fnw+J4z0VZbFdJLyOwcpGa/dO+WQxMofrHwSrOnU5kt0jQlF18MLmmQEGMCiRstFkK2tDVXQyGf
 OByBmc+swbwJwGrRgJ2TufyJKC1Q0iVBr41W1LVNR7hlVX7ThJIx6LAIBZRTMpCdI6iRm/Z4fV4
 T0wbqOMqOGkDl5f0Rkh/5OgbWsl/Lbcyic0IetMgMfLRDKpE/hPQY8uzgW3x+B//z6jiI
X-Received: by 2002:a17:90b:3812:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-395c3a09bfemr39414174a91.13.1787554403395; 
 Sun, 23 Aug 2026 23:53:23 -0700 (PDT)
X-Received: by 2002:a17:90b:3812:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-395c3a09bfemr39414117a91.13.1787554402966; 
 Sun, 23 Aug 2026 23:53:22 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9209fafsm39560461eec.23.2026.08.23.23.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 23:53:22 -0700 (PDT)
Message-ID: <6daaa4b7-4f84-44f3-9cc7-a70935da11b2@oss.qualcomm.com>
Date: Sun, 23 Aug 2026 23:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
 <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
 <230c2fe0-94f8-46e7-a574-9d036ced67b8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <230c2fe0-94f8-46e7-a574-9d036ced67b8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _ZMq26b_2HcjC34WwYauGEo4665z3Iyl
X-Proofpoint-GUID: _ZMq26b_2HcjC34WwYauGEo4665z3Iyl
X-Authority-Analysis: v=2.4 cv=KuF9H2WN c=1 sm=1 tr=0 ts=6a8bea7f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=fEMbGzrvap5Fj4s1y-kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1OSBTYWx0ZWRfX9rKiX+HoPWSF
 HxSnWspJqiDlMYY8eRW8u9snjE7KLzboWj0+71Vx1WJGWSvy35JS+qVojlcfYFIW6XJGpSRb7Kk
 RdkwEcGrmnlwPh98c3ISlsZ0UtKJoLlDiVoJSkMH7adIw1oBRvcUZ2J4PIapuYtM6Rubl+MFUgT
 7xXB+VusrXnJDuWt6vDWo7peeIMq+e3OTQEnyGZ1ZImiyjcGW8VZsyx5kdPj5K4WCthIcX97PSo
 Cb4yMrDQqvePq1EQMI+fBjEMBcanW1sRWe/O3evmiWD1GoXxa1D410kYlPamL4bSPhteJaRF03H
 pmy6+7rOCg9gtfvN2vFng6bnAyKaXz5dEf1QrbCdV7tmqzj1CUKfDgQs4q0TbU9LOG2j9EWai5J
 G9Ixov4RPHiU9x9KuVQvBjweE3REYvOEd67y4JnzKqmmB+QEUkg/skMLOMGiD3Pi9DC9fQYjxaR
 jruNvGk46YlUhE70qRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1OSBTYWx0ZWRfX1OUPpQAOlFl2
 WAo0RHfv+wsTu268zX83QYb1AOpY2CcrZ24xjEtCyOHyjwFTdYC+MffW1vrzFhTyQ9MhMcS0E6s
 zL1+nT5QnlSZDdMNta1Mlf7TSQVfAmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240059
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

On 8/22/2026 7:23 AM, Richard Henderson wrote:
> On 8/21/26 16:51, Pierrick Bouvier wrote:
>> With the single-binary, we start mixing types for different targets,
>> that may or may not be available for current one.
>>
>> Previously, we implemented an approach based on interfaces, but it
>> proved to be too limited. It requires duplication between
>> machines/cpus/devices, and does not handle specific cases where a type
>> should be available based on a target configuration (Kconfig).
>>
>> To solve this, we add a new field, available_if, to TypeInfo.
>> It is an array containing a list of requirements for type to be
>> available.
>>
>> For now, we have only targets as requirements, but later we'll add
>> specific target config entries also.
>>
>> We also add a TARGET_REQS macro, to declare a list of requirements. For
>> sanity sake, we don't use a complex variadic macro prefixing each
>> parameter. It requires a lot of macro boilerplate in C, and prevent
>> readers to jump easily to definition for each parameter.
>>
>> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/qemu/target-info.h | 11 +++++++++++
>>   include/qom/object.h       |  5 +++++
>>   qom/object.c               | 10 ++++++++++
>>   rust/qom/src/qom.rs        |  1 +
>>   stubs/meson.build          |  1 +
>>   stubs/target-info.c        | 11 +++++++++++
>>   target-info.c              | 13 +++++++++++++
>>   7 files changed, 52 insertions(+)
>>   create mode 100644 stubs/target-info.c
>>
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 6c5b714288e..6379e65bbcf 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -50,6 +50,17 @@ const char *target_cpu_type(void);
>>    */
>>   bool target_big_endian(void);
>>   +typedef enum TargetReq {
>> +    /* 0 is reserved for end of array */
>> +    TARGET_REQ_BASE_ARM = 1,
>> +    TARGET_REQ_AARCH64,
>> +    TARGET_REQ_ARM,
>> +} TargetReq;
>> +
> 
> Is there a reason you're inventing Yet Another Enum, especially when
> target_base_arm etc are based on SysEmuTarget, which itself is used to
> create bitmasks of targets?
>

Mostly because we'll have to add CONFIG as TARGET_REQ. (CONFIG_NITRO for
instance, please see v1), in additions to targets.
My original implementation was using an interface with a callback, and I
offered to have this callback as part of TypeInfo. Daniel insisted on
having a list of constraints for (future) introspection purpose. I think
it's solving a problem we don't have yet, but need to move on on this
series, and happy to implement anything that satisfy the community.

In all cases, I'm open to other ideas if you have something to suggest,
which can represent both target and config knobs, with a simple and
concise solution. Enum was the best compromise for me, price being
duplication with existing SysEmuTarget.

> 
> r~
> 


