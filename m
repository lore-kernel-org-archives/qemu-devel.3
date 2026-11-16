Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B567606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PNH5YTbN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d5UgMAuF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4aW-0008HI-BM; Mon, 16 Nov 2026 16:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4aT-0008Bv-Jp
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:05 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4aR-0003TO-SK
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:50:05 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfG9R2247144
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qCEu+jXXxMBsVU1iz/Np5kaZoVjfKPzRDm3nJKe3cfE=; b=PNH5YTbNmYRUQRqQ
 7vgrg5wjZ5iKXgHRvBn3XFQeojN861cpKnywFDyDl12tGhCvrNBHzHEHkTO/sfZi
 5RQ+UZ0RU6W++wTcZrN17cquQe9NmHPa93iomcR60SU/Fi2W5Wx2Sud8zFDTjtSY
 rvtABjt/rtLfZCqSO7UjL4CoB6Ed02u178UDYDda18MdJDSst/807mDFqsgYkeIc
 cxtZEPOUy/s659ZcbyRqsjYeZDDNAsWg7p8l6gwAxKr6iauM9BaRJQHpaDMp+/Eq
 Ez/ctiSPfiqBGC+Snl4CUaaxJdLS1qP9QX134AZBDonEClhW+ry+9Rx5rOlpQ0wi
 CcedaQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqyaqwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:50:02 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3583727eec.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865802; x=1795470602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qCEu+jXXxMBsVU1iz/Np5kaZoVjfKPzRDm3nJKe3cfE=;
 b=d5UgMAuFIVD9bWWCrm+yzkQGI8r0gTKX38VLW1THCdWWk7jBL6pinQ3mca/UOAUoaY
 ordCp1aM2AwJQOcy0yX6hspxMzIwGSXPkt1szSa6EMJG3yf2wn5OSXPWqTK7KsZ1+Ui+
 wp/lUUoKsxiHeR4ao897dkMHl+5IXb1CcP1yd3M6TDlCHXk+vpkzjreVDftETlJKCH62
 Gv0+tOlEYW0quWwRag4JFU9MSXR69MsrFd6YxC/OI4rz77SKN4NL1xN3Y2HAQSMfHhwK
 lR1xM2jFAc8ftjRsrz7bl6rZOjrHtkJe8cDAkQ2wZtvX//94ny6pFMJw7UE8aT0y9G9F
 Okbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865802; x=1795470602;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qCEu+jXXxMBsVU1iz/Np5kaZoVjfKPzRDm3nJKe3cfE=;
 b=q+eZkMlB+/EOYtE6iP4Rdh/1p5iKUuhjiBzS8JYO8mRPwIRrzo5vtqgGigPEJQPOa8
 Z6AMZwLgXS6YlNp3qxRAI+x1jDxCb/S0ftCAgear7ZuyiVMlP1FOCSj/Q2qFpGiwNh9S
 zgfLad5QfUeXC2ecsWrDwHvbjyBFzOPEKkrso8rBGxEl7H9fDhqghKCy0oth2zYYsber
 ujf/WVYBcySyx0g25Ibdgeq9asxofHoPCh5J3I6wF7egAJPylFQmmBgVKW5uya3hZPE+
 9i3Dmt1ppbRyUbReOtz4cvsTgn8bsupv+a5+PaD9w9CnOEDkKUab62xuPY8yJfEwpRNa
 MegQ==
X-Gm-Message-State: APuU4Z8EEFaouT1zNRCWPf9+qgMsK3L5gaBLtAv9BWgTCfH1WV+QYRHn
 3MGNmVVjrP2TrKcg7ku2IwZUbHrPs+bGwrP68dNpjpfS+bS4eYjBpOIXi0K+iJNwsv0LOfEjkQ/
 7y5agr+XVMADOzvgajEw8VsbINc4MuOSCa/YRCjU4iujHzSJ9TmH6BHn4pA==
X-Gm-Gg: AYBFou3ag4MmVIg89vkZ1tsLNLRy9gDgm9XMOcEKr6b2DsgYu7AgehatmTbYWBJ9rYc
 Ugqx1uxgKkOEq9UHD/HD3mPOW+UCzfgPp5801SE0GUqCM2jvE3rnpt9AZEqFCeNTGzF8+Psvcj5
 UHYcLc3uaC+9N045LXWBtpL1KbOd5gy0xbMgg7Z9TNNni2FF9VRyfQT8IKXmIfJCtVcOCgR0OSX
 ba8jWRAPlvqQ6prtCGs5UuDDSeY85Ya53vRKICwqF9KPN10+fEHo1dENZ2bQ91VkTu4DGx7yfSs
 qL3eBQiC7Rs5/T0Sehc1M9QFiP4LquIviR/0u7CunVbJt1K2WFM7uUqRTek7mrQOl6Xj5/5J9vC
 WmVWsQzRo731NKFpTRTmjN+9pWsC/xYHtE0tDPwKFJKcKXu3LkcFJdosd0OCf+DGksJWx4Z6V/7
 PJvIAJHTvvJy+q1ehSCnNCW8laaf6/1BQfs5/QGK2+Ers=
X-Received: by 2002:a05:7300:81:b0:378:2e89:3958 with SMTP id
 5a478bee46e88-379676fc09cmr12109723eec.19.1794865801630; 
 Mon, 16 Nov 2026 13:50:01 -0800 (PST)
X-Received: by 2002:a05:7300:81:b0:378:2e89:3958 with SMTP id
 5a478bee46e88-379676fc09cmr12109694eec.19.1794865801056; 
 Mon, 16 Nov 2026 13:50:01 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-380e031f3e5sm4167309eec.12.2026.11.16.13.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:50:00 -0800 (PST)
Message-ID: <c70bccd3-5a14-4a8a-9ab6-84e764a2a88a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:49:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/48] hw/core: implement TYPE_ALIASED interface in
 machines
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-7-berrange@redhat.com>
 <cb7bad9f-96d9-4a7f-ad40-ed19e14f83bb@oss.qualcomm.com>
 <avt4aNmLorhgCvh_@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <avt4aNmLorhgCvh_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX3DgYGw5Lq51t
 sXtTBSrs8zV9Ep+QbWqUwLT19OJQkaFCKH9eqYPJBW7Vn3C6ZIkGlkeyEENLEODHdow7nqYmwR/
 8ZTcT09S7ldJkB5Sn6Fu8FjXhQ3BlOw=
X-Proofpoint-GUID: QEzIXWoU7Q-x7tFrQU7uCvPpB_wBpPni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfXwMiJgmVlsrtz
 1ELZ8goRXxnHwVmcE1z8fzS8xbuoaQ//Bf6jpIe+MOzJYogT+T7onBMW+KIQCRzP7gqPFv/vpuD
 rbQn5X1ybvwQ+j4FrR0Lp7fOvWvZMhMmDOsQZ9DrEZoIVWK+XDMlawTlz1IpDj7Cl48q5KzqJ56
 eK4VyoK8ZZD2vjmvdaGAB9E5VnoyMxHYiQ7dcuuuZBUIFCBv3AGj7iLICDd0spg0w9BD6qKA2z0
 nPn4Hd7I91btZIYR+h+xecWQDNP4BiC7EIrPPyMya/O+EhJVYiuEzjyQoMlIwwM7LAM0GSv2CsP
 3sgTAT5EzSN/XUMb4ExGwinJhhQikMSjz+p5Ib81dUoPUYVqDBn33+4hKi66VGzBgzRAO6IF8Eh
 cBAyj9+QOHaoI3hWVxj00QUXUR/ocDYl8np5CS7/Cgl4ItN5K+QWp6csHQNwZXbqdwLFJj1LR8/
 xKaExZ18HDkpPDYI9SA==
X-Proofpoint-ORIG-GUID: QEzIXWoU7Q-x7tFrQU7uCvPpB_wBpPni
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afb7a8a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=JMrKL6tA5vKXgQWL8zYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/2026 1:40 PM, Daniel P. Berrangé wrote:
> On Mon, Nov 16, 2026 at 12:48:47PM -0800, Pierrick Bouvier wrote:
>> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
>>> Make the TYPE_MACHINE class implement the TYPE_ALIASED
>>> interface which will replace use of the 'alias' parameter
>>> in MachineClass. The current 'alias' records the user
>>> facing machine name, while 'aliases' in TYPE_ALIASED
>>> will report an internal type name alias.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  hw/core/machine.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index ed9bf8f5008..f7406537aa7 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -1802,6 +1802,10 @@ static const TypeInfo machine_info = {
>>>      .instance_size = sizeof(MachineState),
>>>      .instance_init = machine_initfn,
>>>      .instance_finalize = machine_finalize,
>>> +    .interfaces = (const InterfaceInfo[]) {
>>> +        { TYPE_ALIASED },
>>> +        { }
>>> +    }
>>>  };
>>>  
>>>  static void machine_register_types(void)
>>
>> Since very few machines require this alias mechanism, would that be
>> better to be add it where it's needed?
> 
> Unconditionally adding it is a simplication for other code in
> the series. By doing this we can use the normal QOM cast
> "ALIASED_CLASS(mc)" from the machine to the interface which
> asserts on failure.
> 
> If we only did add the interface for a subset of machines, we have
> to remember to use (AliasedClass*)object_class_dynamic_cast(OBJECT(mc))
> and check the return value for NULL, which is both more verbose
> and error prone.
> 
> So I thought the overhead of adding the interface to the Machine base
> class was probably a reasonable tradeoff.
>

After reviewing the whole series, it's acceptable indeed.

>>
>> Not a strong opinion though:
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Regards,
>> Pierrick
>>
> 
> With regards,
> Daniel


