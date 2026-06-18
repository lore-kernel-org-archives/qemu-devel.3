Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474CCCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJU8-0003o4-Cp; Thu, 18 Jun 2026 16:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJU6-0003nW-Vx
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:37:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJU5-0006Mc-9l
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:37:10 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IHrjnm1878939
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qHB2KuHvt6vlOaIaABKJsUhtBUvkySgT5V4y3KoAu5E=; b=Y0C2Vtd9npRhWyRI
 qHdZye/NN0GS1jRogmGBfzaFeMuQBldYefu4mD2AdIbTFgBTZU4+Lfnsg7Z7/Gib
 iMe3pdq3QzNyfN6TcKQ0jBemiom4tmQW7rUDVHdhPpe4vlIZ5rnkqIdXeBI5EElX
 K+YQ8Lhme2ZG/qLBFP/5k7fE/K1zJVbTlBfiQIDS25IBjg5XOnB5kcYvY993BZ+V
 OcpjdHRTcvfg5TTeyh4VyYRwh1OAaPPo9bQpjJPUFyq71so8sObpazHyVK7sqkOA
 fBFvQmqdC42E5Meg6uOP86jl52XEEMo6fovCtKPPw73oUSK+gJ74L1evhA/DPv6K
 Es9hng==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evkvf16ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:37:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915d1d4fc5aso268369285a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781815026; x=1782419826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qHB2KuHvt6vlOaIaABKJsUhtBUvkySgT5V4y3KoAu5E=;
 b=Y3ecSCYkCkNGOG7PohjAY6VzNHxLzgKg1deqPT5LHM91BvFSLw5EFBmhywtmMP2xIj
 1UKQLDBwq8ZP4E1j4x8mAT4rObdMy2MHroalbF4HVZBG304uCSa1aFVLrdloL+/nxg82
 PvrENBy7QYt+mJL6VdWxHVGO+8UrcFFQUhOO5mkNtVk5ixDXuIguHcd6YRVgLo1btZnP
 g45fLYpKHBIoPblmy1U+TXTFY4/JwILFo/TuqeA2EUDTIAxuYiHLIT7BkRvRcvyxcz00
 9sz3r8daTZLR8RW3rncEMZbbGLjlO0J7y6reI6cjuv596R9iXesj7zKfV5BqQmBZejQC
 tB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781815026; x=1782419826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qHB2KuHvt6vlOaIaABKJsUhtBUvkySgT5V4y3KoAu5E=;
 b=oSUPo0fC2VCatMeQ3J/608/qT+9S3uoY3MvEaoKsFYIwL4ENa+gnM7UbXuFPspS0Sw
 Eip1QRKz3+ls/6TEpEru9LJC6FgsmdNGJR3ywcJDpcC2nJe8c1TxvVDh2C6QzYoPN4Hl
 M6kLOLRWWOCmxVmz9BUDMhullJLRlVDBU+DuS8iCHW6Ql1kYuPuNRfTIKbirFMuL+AOy
 FEDPWr/0D+Vpi4UxRXu9p7dAQTp9YCB2/lGYmuynj2glj+vKqtQ3+4U7dtGUGxiDAyeP
 JzRKjgNUhSPS8C3nN3+EQeDsiRw1OY9ff1jC2R54FvPjp+BGaNLdzznRrCpCWT+Ri0ij
 u6JQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hawpbKmwgDT1ebHBKtodOEUCIwkeSJWaiNo3Q/1JLACmC5rBQAZfR6ps5xKRb/qwbFEFYH3aQzS//@nongnu.org
X-Gm-Message-State: AOJu0YyY6F+xedTEya69p3WqlS8sT+w1BDerxlQ9cRm1pCcDaaBoyRoW
 vaEw/ncVodtrtpR0Iw8y5JOTgD0naXwishQaVJDNG23gTeSlaya68wagy6JVcSQ+wHk+bgsbc/q
 MKNRluiUbdcHLH7cN3IQXKhy6Yymi+MhtI7lXMNvmB8EqCrwGIwcAXCI2vg==
X-Gm-Gg: AfdE7cmJ9KdkBH2cvLhJ3ZzYvV/c3T15tiG0NtNU8DqHcrzZEZAIBPsFA49BPlq3+ac
 AKHdhFcfJdayxWvpHsptdMymd0iNifzZFLw/PwP6aKsPdMc71nUwZcWNLCxqmx0PXlSSjagEglz
 uXKWb3THju082rIgtKRHMBghUrIyKRUOKgEPsNPqb9NwonB3iD8C77WmQySR4Bu7VfcX2M+M9C6
 jJkABBhf6xjvAFYdTxAElkDolasBlOhpuiwnwfhryZlZZ5aKdP8mz7ECPeO/YkHx9/LN6Gtp5h4
 ptOzsG7ArCec6oSAbd24WuCduSVug9r0cz/ypvMmzd9iAGN3FqI925vx++Oq4y1aqZotAmLWkr7
 7paORzgP+AyRDMkYyYaHT2ozN1RroMr+UnMmQ9t/qpBea6/IP2XX9kKLByvy5Gw==
X-Received: by 2002:a05:620a:3185:b0:915:8076:9e65 with SMTP id
 af79cd13be357-92093138f6amr100999985a.53.1781815025620; 
 Thu, 18 Jun 2026 13:37:05 -0700 (PDT)
X-Received: by 2002:a05:620a:3185:b0:915:8076:9e65 with SMTP id
 af79cd13be357-92093138f6amr100994185a.53.1781815025180; 
 Thu, 18 Jun 2026 13:37:05 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc422c0sm1434403f8f.26.2026.06.18.13.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 13:37:04 -0700 (PDT)
Message-ID: <386a6b2f-6764-4e9a-b6cd-a19b9b032e66@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:37:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/13] common-user: Implement read_self_maps for FreeBSD
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
References: <20260618195520.589907-1-richard.henderson@linaro.org>
 <20260618195520.589907-11-richard.henderson@linaro.org>
 <768aa959-290f-46c8-aa6f-e724592831c9@oss.qualcomm.com>
 <CANCZdfrT3-C7s4jTDYBircgjiEexRdw4_txGedB9b55G27j90g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CANCZdfrT3-C7s4jTDYBircgjiEexRdw4_txGedB9b55G27j90g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OCBTYWx0ZWRfX7XXtrHXuYrjf
 +3qN4m1UXSNKtvzFzWNtc4GzAKDY1Rt0IM9ItCRSJOGHJQsT3GQgOIUCgNzZnogf07INYBr2rGM
 bHDvMAmcvK7uJ99PJhmNW9FTNcbr8LI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OCBTYWx0ZWRfX3JbIN+wuAgSi
 ihFw9WBjyQq2I8EUyNaNhPbE0XTUvgvP77KfxDAk/4Rt7lfVvW0fOorLk+R3xFZCQ6UPMW54ZNR
 xYjipK5Ck9TMc8OFIARcbIMc8wPKOYdlHaVnIbnPAbSooc5tk4GvR8fELwBG90L2e37pqjmhbgh
 GiLWhi2WNsus6S98DOPe+4ExmdHTUALWl3m0SeNCWsxipDSq/k2i/x2UZDoix24u9Ltkwv/wCjU
 g0P3eG0rN2EIq+h32VlalqNkP8+6Xuf13uIQcpHoWybeeCVxsni+kY8IUUHCXAKNbX1UwdbPKeo
 y2XprbG29OaKGTRSvm/PpAsqKvgdQkenjvUkF36POovnNpEmQlW97Pw3W938LKwhnepKS14bjOR
 KkjZy4iCQRTopNLoS/T1kzoIWjWi+1FT3cjZuQdKIl77u2w7XciqwjuH/pKaBbUZ1NRYBYKLe7j
 FxRAH2mqeldlQXl4cew==
X-Authority-Analysis: v=2.4 cv=H/3rBeYi c=1 sm=1 tr=0 ts=6a3456f2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7Qk2ozbKAAAA:8 a=KKAkSRfTAAAA:8 a=WnmgIi-qiaUKfe5zevQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=1lyxoWkJIXJV6VJUPhuM:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Cc4U6O2nIU6H12UYhcmA5TdDfFAPzp7l
X-Proofpoint-GUID: Cc4U6O2nIU6H12UYhcmA5TdDfFAPzp7l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180188
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/6/26 22:23, Warner Losh wrote:
> On Thu, Jun 18, 2026 at 4:22 PM Philippe Mathieu-Daudé <
> philmd@oss.qualcomm.com> wrote:
> 
>> On 18/6/26 21:55, Richard Henderson wrote:
>>> Reviewed-by: Helge Deller <deller@gmx.de>
>>> Reviewed-by: Warner Losh <imp@bsdimp.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    common-user/selfmap.c   | 41 ++++++++++++++++++++++++++++++++++++++++-
>>>    common-user/meson.build |  5 +++++
>>>    2 files changed, 45 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/common-user/selfmap.c b/common-user/selfmap.c
>>> index a1b88dee66..151d066801 100644
>>> --- a/common-user/selfmap.c
>>> +++ b/common-user/selfmap.c
>>> @@ -9,6 +9,10 @@
>>>    #include "qemu/osdep.h"
>>>    #include "qemu/cutils.h"
>>>    #include "user/selfmap.h"
>>> +#ifdef __FreeBSD__
>>> +#include <libutil.h>
>>
>> Out of curiosity, what is libutil for?
>>
> 
> kinfo_getvmmap

Indeed. I was looking at an outdated manpage.

> 
> My rewrite grabbed the data from the sysctl directly and didn't need this
> wrapper.

Yep, saw in v4 :)

