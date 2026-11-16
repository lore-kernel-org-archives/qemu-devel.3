Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07718606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GTebx31m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K8SlsqjT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT0SA-0006i8-BI; Mon, 16 Nov 2026 12:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xT0S8-0006gt-2J
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:25:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xT0S3-0008EK-5y
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:25:11 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGKAY73693035
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xruf0SimTCXDJkMcL8QrA6GYaSKSSMNI6nw1dibwElo=; b=GTebx31m0qSo2ywr
 vJ+gYKBUejKpRDmKHAxl5F683kblHTRm//dU9OXoX1Gk9dwoJOw38zQC8I9OJmeX
 MsIXfzOmpHP9cIFIJdIkUgygxDwTtiyzIl9w6a2LsNNjDp9WIIYeAcacr++/B6Kv
 HKY++OznMckB6EZD2VwH2jwmvhYO99c1vSt4lTbvx/pxOHmKIvsXO1cyoAHg2lrv
 MOH+oQ6CYwxg3LX55zDQhJejhBWSeEJqo0nJCzFIy7NjgPExnEHvvvGrF40aXYL9
 6PO6oWGUFBhDZHxkirgCAf89IaX9FSC3bGaOIHDxHwDg8VBsxbSrVKTPDH7dP9Sa
 iiz7eA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f818fh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:25:02 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91eb3a63064so1515326d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794849902; x=1795454702; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xruf0SimTCXDJkMcL8QrA6GYaSKSSMNI6nw1dibwElo=;
 b=K8SlsqjTxet3XFZ7sPWvgHlsHTU0qNfnrTQlvY/l8PF1gH7QkHRvMDsfV0YsDcq6C8
 7gd+5rsvgZLBbtGwn38Z3ZHidUDqErfWNcqbTX42AiUKW+UDGHimws6BQmgHcwOJWiOp
 AbgTUej/Ao2/4Pk8/7Ivdae1O4yOGkYlpNSZHj3iyZeYxkGQpeXz1xBX+qCmFcaxYp4i
 eWAjruC/QEyJNqJiz0bO+m5B94bFpvovG3VxkS0ZSdfZKOkO1xY4XEw3PORXs7AyHOJm
 TmIHbpztHQaQdWDM2DqX5vHxBh5Id6s3oEkLtn+a/MufbD1+bpplsNigxa2uUe0cF4bN
 OVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794849902; x=1795454702;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xruf0SimTCXDJkMcL8QrA6GYaSKSSMNI6nw1dibwElo=;
 b=IJhoZ7qG1sq/2+0c+cK2saXNdJYp9eu6o8PcAtua2mB1KDDWjUjHHnWlkViCDJPnZv
 wA3L9O6urz5+LPFYY74gDgY2QvUPIpr0CMeFQ8IR3P08cB/hwYEF+S5W9mY96jmv6SBY
 vqyYGXG3qxbWS+FD/NE6+i8fBszSMsWSeHAVapZDCg9RP3sY0tUHx453G7hKT7oFpjZJ
 LaogZ04Biu4YKQ3tpJVMKqqlnbYFxXr97pvhu/iFjGn/Q0lBRyd/gF/eAeED5PrwSAA8
 LbvqjaxpSwYAnzQxz8pBTdZ8U0PpXQUPj0fIi4yf+2KUoPJWOIUk0x65QqHLj0lvdTh3
 F4sA==
X-Forwarded-Encrypted: i=1;
 AL+hErHJXsA2lYZt3/s1e072t6b7sgkFQMUhZlSeSgomiPTYe8kWtpp6JyB5+qRzO9vvZA66I7B18rhbMCIP@nongnu.org
X-Gm-Message-State: APuU4Z9nZ6WI2BHpOpJt6nzZhHwX+EOENfARmQ2oc8bShPsD5vioqpMa
 q2FGIIxhEodB6KYR1BVQes5lfBBkxRZbFIEzuU/FndS2zXTrWtLzYY1+1CRkMwg/0xBuy08Bpzo
 ImknTGO+VQ/ZJKey96sWXNZ0aU9GNjlTUkjwHLoU4IC4kRzy+SKVr5Sga1DC9BPUKrw==
X-Gm-Gg: AZFdTZfHAmv/J1AOy9mH84bjg9ySisNGc7gJiRrfYDUE7JojshmRM2p6kKcXTNJ3qfV
 aj7bAadeTAhhm8Iua/wnhnLQ5gCLvLQ+C/mcky/+oNRRn3LgvUzi2Y8qtwxzr+XSDw3WpFL/qrU
 E8s8Tria1HBqs5xkcWXNIE2xQlsTMMFrZ7NMoPQ1uIAhgsriaDVnxHJObixzKdRBKQxJudqUmjv
 xcFfxP0ei3N8F1cb5lP3u0diQGfcLPwTaIs2lnnLMr1sDVqh8b8GOBSgEpZgY2U6JbkuhVu+Xpm
 zfPnK6zND+XN36jI3L/fHuhtfhgpUJ1YHBRoxQgoPWzDCEOHxQHoycomRye/hzD2466njOkMNti
 1UQmBF2jHzaF7NGfNw7cHqlCycWc4UtsEklkNgBjXz8eFFKQ19ZnNC4XnmJ55ZhBKww32fwG1Iy
 +upnTmf75JPE7dpBb8F/4V8jTOHqCXSVxwatElOg==
X-Received: by 2002:a05:6214:f2b:b0:920:fa91:1778 with SMTP id
 6a1803df08f44-920fcd29161mr3240526d6.17.1794849902265; 
 Mon, 16 Nov 2026 09:25:02 -0800 (PST)
X-Received: by 2002:a05:6214:f2b:b0:920:fa91:1778 with SMTP id
 6a1803df08f44-920fcd29161mr3240016d6.17.1794849901697; 
 Mon, 16 Nov 2026 09:25:01 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f23d453casm90121496d6.10.2026.11.16.09.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 09:25:00 -0800 (PST)
Message-ID: <987426a9-a3cc-43ca-8dff-4e911a253a68@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 11:24:59 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] roms: record the H2 commit in a file
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20261112173901.3748880-1-brian.cain@oss.qualcomm.com>
 <20261112173901.3748880-2-brian.cain@oss.qualcomm.com>
 <e4a7622f-d87c-42c3-9a36-4e461199fd4b@oss.qualcomm.com>
 <0a20e3fe-74d4-46d2-851c-f14cde22c842@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <0a20e3fe-74d4-46d2-851c-f14cde22c842@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX4Nu2SuxYyVcf
 gblSpQ6UZCqSIlAoY30ruHrLiFAFaQPEjRiU6wDTsyUAur4LiYHpX/32nRA9ObQe2Ybv1ZprMN/
 KrXMKWHsfkJXP1Y2ycHyvTNu9kkyHTD06gf80V7QVIFADO7Vww0k+get2UGuh3ouBzGxl+f/874
 Uj39Rhfg76bwzd1eg4Yc8Qkev+HAEzUVnn5sUVoSWsC+ZbF0K7Zy2jC14DqyMUWBcg9s0JjXEQ3
 a9TfAz8R0H11x4aL5SG5Grfpydz00kzZXXe9URQnToBH4LWqeUrwlzIUwiVM+ry0QYqWPdf7CYf
 qHxuLQdjIAMyxotaiojrEHgNtsu75LboGWgJDmeclEn4NzRCCC5Fl23dNtbVcg3EtFMEYJQh7FF
 hLXjHdbKG5R5GKxdTOnhzN7D5OGxKbHZCrvolxcoXDH81jeN8LurHIbObuO6BirQBsaTPc1Rids
 rxFaK9qr0a1F33ZZ1cg==
X-Proofpoint-GUID: kZWt89x3AbTtte_PzcackUH5W2J9wKZ9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX3dOK8XenxMXd
 F6/sC8LVDqnxSyKiO4d847p3+hkEosHIquZYMIaqCSs8WFCwRSsqfYVGXc9TI59JpWFoytuFx5t
 Jb+a50FwxmfO44H9Yhckk8FYQZvJ4Oc=
X-Proofpoint-ORIG-GUID: kZWt89x3AbTtte_PzcackUH5W2J9wKZ9
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb3c6f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=uU8fyrZGgv_c9p3nWBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 11/14/2026 9:00 AM, Pierrick Bouvier wrote:
> On 11/14/26 7:59 AM, Pierrick Bouvier wrote:
>> On 11/12/26 10:39 AM, Brian Cain wrote:
>>> The H2 build ID was derived by running `git rev-parse`, which fails 
>>> when
>>> building from a source tarball.  Leaving H2K_GIT_COMMIT as "0x" does
>>> not compile.
>>>
>>> Instead we'll keep the commit in a tracked file, regenerate it when 
>>> it's
>>> a submodule.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    MAINTAINERS                     |  1 +
>>>    roms/Makefile                   | 13 +++++++++++--
>>>    roms/hexagon-hypervisor-version |  1 +
>>>    3 files changed, 13 insertions(+), 2 deletions(-)
>>>    create mode 100644 roms/hexagon-hypervisor-version
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index fa0c6d0c9bc..df264c30753 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1399,6 +1399,7 @@ F: tests/qtest/qcom-dsp-test.c
>>>    F: docs/devel/hexagon-sys.rst
>>>    F: pc-bios/hexagon*
>>>    F: roms/hexagon-hypervisor
>>> +F: roms/hexagon-hypervisor-version
>>>       LoongArch Machines
>>>    ------------------
>>> diff --git a/roms/Makefile b/roms/Makefile
>>> index bae8f3b766b..2cbab2d1993 100644
>>> --- a/roms/Makefile
>>> +++ b/roms/Makefile
>>> @@ -226,11 +226,20 @@ hexagon_h2_booters := 
>>> hexagon-booter-qcs6490-cdsp \
>>>    hexagon_h2_loadlinux := hexagon-loadlinux-qcs6490-cdsp \
>>>        hexagon-loadlinux-sm8975-nsp hexagon-loadlinux-sa8775p-cdsp \
>>>        hexagon-loadlinux-sc8480xp-nsp0 hexagon-loadlinux-sa8797p-nsp0
>>> +-include hexagon-hypervisor-version
>>> +
>>> +hexagon-hypervisor-version: hexagon-hypervisor
>>> +    if test -e hexagon-hypervisor/.git; then \
>>> +        echo "H2K_COMMIT = $$(git -C hexagon-hypervisor rev-parse 
>>> HEAD)" > $@; \
>>> +    else \
>>> +        touch $@; \
>>> +    fi
>>> +
>>
>> Maybe would be better to always read from the (existing) file, and
>> compare content to give output. With this, we can catch the "updated the
>> submodule but forgot to update the file" situation.
>>
>
> and compare content to *git* output.

Sure - that's fine with me - @Michael do you have a preference?

I just followed what edk2 was doing, assuming it was already 
satisfactory for the packaging/distro usage.


>
>>>    hexagon_h2_common_flags = USE_PKW=0 TARGET=opt NULL_ANGEL_TRAP=1 \
>>>        HMX_HLX_SUPPORT=1 \
>>>        H2K_LOAD_ADDR=0x9b800000 H2K_GUEST_START=0xa2000000 \
>>> -    H2K_GIT_COMMIT=0x$(shell git -C hexagon-hypervisor rev-parse 
>>> --short=8 HEAD) \
>>> -    H2K_GIT_COMMIT_LONG=0x$(shell git -C hexagon-hypervisor 
>>> rev-parse HEAD) \
>>> +    H2K_GIT_COMMIT=0x$(shell echo $(H2K_COMMIT) | cut -c1-8) \
>>> +    H2K_GIT_COMMIT_LONG=0x$(H2K_COMMIT) \
>>>        JFLAG=-j$(shell nproc)
>>>       .PHONY: hexagon-qcs6490-cdsp hexagon-sm8975-nsp \
>>> diff --git a/roms/hexagon-hypervisor-version 
>>> b/roms/hexagon-hypervisor-version
>>> new file mode 100644
>>> index 00000000000..4aeabdc7d0e
>>> --- /dev/null
>>> +++ b/roms/hexagon-hypervisor-version
>>> @@ -0,0 +1 @@
>>> +H2K_COMMIT = 23d5bde4313c1e63ba64dd5d7f542b1055188ef8
>

