Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54346CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtDT-00059u-Oh; Wed, 17 Jun 2026 12:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtDS-00059K-49
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:34:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtDP-00028T-1w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 12:34:13 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpDm43183370
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k0706SQd5qTRM5STp/8Kk2TLK84AbBRHTGXjGFZTXVs=; b=MCPNMYCbYZBhtpXR
 8hRsgu7DW5QYwBUxDKM9SxLTOxvm4zIL/1Q3AcFgdcP3BUvughVOIAAicNrclGou
 Zbv6qXGZIpX6cmRIRoESJn/mzAp5c2rqNJZh1kb1uZZeJgSxG7+btNNlkLkI1ur6
 0FtwIcBDEuWGSIr2GGHRk1uvbRXmitA24Pbz95EkjV3BvZrlx2mOB9ZBjFSP13Lp
 HBnIXTnZkqhQO6QRpieHsIVze2+dr8eokwplYW/8pWlrAlc20EQYXLttkHTqFRwU
 bf3lJ1oSkld8OMG5bsFvBmWEbijIo/EnU9wG8aYhGJTaygXND3w9+i11VsquRdk3
 WfEjhg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesmafw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 16:34:09 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6cfd2a26ab0so2195999137.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781714048; x=1782318848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k0706SQd5qTRM5STp/8Kk2TLK84AbBRHTGXjGFZTXVs=;
 b=ITXkdBxs/n+Gl49aHEpDNiqUAK7GJjj1gmxHHGJaknCJTymOqwkUALkurxcwgWyjH3
 xLIjSdqbZhzhAyeRYv6iJ9Nzj8wE2QFfeI5dIAvh56eJwfBXT8l0DVHJL024ZlcvC4vI
 lkTmVEJ8e7pjKZ5KPTkv3d0TgG82AatjzO/7VNEZAMprfKzX10u72D/rmT3aCogp4VmI
 6wXDbw50yvyDBPohwgXiUu3pbFoLJBEnswEFhP6azizS6sQG3hjsD9H1NyxPkQ0CiPuf
 +CSjIBTz8MoZQRM1s5IyO7g75dwYirbBExq6UREiZ0Do+CgmiQdQnObayYcTq3DMv1+z
 IvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781714048; x=1782318848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k0706SQd5qTRM5STp/8Kk2TLK84AbBRHTGXjGFZTXVs=;
 b=GTje475oYJgaWO9RO39ECkFZsMIy/6zVMsPCxzu3e0zQ5Znds/2gK0VoHpjN5uxHA9
 URlAWS2CSKHT74ohExGMHDUVJH/tQuE5uyc+Z5vmSLLtWoVX7SSCQAHj1EyM9w0WiR51
 PUJJseozh1Y5IiGgvSu+UKCWSKPJIOg/vqjqCkUuAjdunUI8JJ7JQOVWw8IuN7PfNHiN
 GjAgzHYlY3X4sCODXa+Uy6afVMNMPmVFZ/s7eohrV7sY2N318A/kJUuvt8V/Zlk6rvaI
 //5jDFl425O76t9YqhpQTx9pXlqgC6uCiJE1mcRwFZI9Jg/syMdMbHm8UDLJ+9rCoS+0
 DgWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sQgIcwmHgBOzqGJAUjybyJYZAXxm3l9nIoqajIVOKyOpYXfjB23/C0dViTd5LfW9NyrH+vKAFjgvo@nongnu.org
X-Gm-Message-State: AOJu0Yz4CMuOfiqI4d/nRvXJ8SwC3tQAcEHcn/0VFy0t3aI0ENxkHRmZ
 0Er4bH7mHP0D9ppkMT094Pr/mYGn4jjZvASxJ/e5bL00uIo85cQVwzNqL0GAAZPRLs6RbuytMxO
 p4WRht/osXCDNXz4E57+iBlGLWlyb3F31z8dh2CJpXm6LEX9e9DPQP4E1dA==
X-Gm-Gg: AfdE7clvjG1SSnfWMBTnzD/JgqILzkp8FrpivoYojXclThOEueEXZUO6JMvI7JdBxTo
 qpbMl0NDYW6AGGnnb0QWG2MHI0qVXH/M2628VrMiVcBuJ0W6OSxl8vPqqVhFYf43SqB1el9u53V
 ldv+FmjdOs7bE/LFVMf8ndq5809qMMpTYa9vNAIsTfpL4jnP5agqXwWD15UeIshTcitgG14eiR/
 afdU+4NFFxa2MmHScB4LkpjMjfA2XDQQ87JSGA+H2Bd6lN/uJFdY2Y3v5vMNbANoY8rxh7qSsKC
 jzqdxkWD38jWR21W3ShTwX0Je3WqEKpLlKi6QbNnQYyLXWmPRh+Q8dt0rTz8NTnSw8qMkYla4zt
 S8qLfEXlRw5p0ELqtH/3YDFjafKqiaowtgBxwb5371muL2L+o7QEui15eUW7iMw==
X-Received: by 2002:a05:6102:374f:b0:6ef:db57:ed3f with SMTP id
 ada2fe7eead31-727c9de43a7mr201333137.29.1781714048400; 
 Wed, 17 Jun 2026 09:34:08 -0700 (PDT)
X-Received: by 2002:a05:6102:374f:b0:6ef:db57:ed3f with SMTP id
 ada2fe7eead31-727c9de43a7mr201302137.29.1781714047906; 
 Wed, 17 Jun 2026 09:34:07 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4619b9b7750sm27130461f8f.6.2026.06.17.09.34.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 09:34:07 -0700 (PDT)
Message-ID: <f6ace70c-535b-4b6c-81c9-e97a976d6c7b@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 18:34:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x/ipl: Remove TCG dependency in
 handle_diag_308()
Content-Language: en-US
To: Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260616021654.22892-1-philmd@oss.qualcomm.com>
 <df2467a9-d3e1-4547-a01f-03c0170872be@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <df2467a9-d3e1-4547-a01f-03c0170872be@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1OSBTYWx0ZWRfX777ifcB4FaZB
 0VCUMyhE12X5Rq6+f8VptnzoCHDHcE+4eEafu5GZYoUjSlR7vMlBnWGGXIhOdKpB80KjfS42bdV
 HPX2hZCQs9kwfKMocKTDscOco5Cmk13a53S+7kjlTadvItxlxAYb8mZyRXJ2XFA4wEac8+/YAAs
 0o9yRAx1rvAFmuwbsVen635cts6x0SixhMEsYkkzUkW5P3N2POof8rhvu2ZYOYymJ86mgxb5f40
 ApOANPTH1dlYma+qOi0ln0BxZye3GK148osUV1TeN2aIG+ZmTNQs2WVE69B4efm7/kBrVf6Qbm+
 WxhsL6p7B2yah/zijN0zaQR6AKflcBzawT3eFnQxf3ck/FfZdsVRjphW5z29OgvuB8zOXwN5zcC
 X50fgQCsZ1GOHfm5pIYPvMt2Iy394eXJCi/nlaMHbzSVpn/f7Y/r95/WgK9c4dQG/xxaNbrKdol
 rEzAaZrBhWo25OsTVuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1OSBTYWx0ZWRfX8XDyNl8tzs67
 2UcH3hVVemVr2wNWKrlmccy41yRRNSVc7hgGNv7FQvCQJAouF/U/WEfW5X/Sq/qwYF0vSmO7JOB
 sqZ/qCvStEIcmFtxOMUkS1qSolWxcpM=
X-Proofpoint-ORIG-GUID: J2ecfTR5Ybi2mYZ9NTzZi8pV0chI5YdG
X-Proofpoint-GUID: J2ecfTR5Ybi2mYZ9NTzZi8pV0chI5YdG
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a32cc81 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oxhIsTHnUwtUroKYQU8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170159
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

Hi Jared,

On 17/6/26 14:12, Jared Rossi wrote:
> Hi Philippe,
> 
> This patch does not apply for me.  Is there any prerequisite for this?
> 
> On my side it fails to match the existing includes in hw/s390x/ipl.c 
> because
> system/physmem.h is not currently there, but is expected by this patch.
> 
> Also in target/s390x/diag.c the s390_ipl_write() function is not present.
> 
> Taking a quick look, it seems like you added that function in a different
> series, specifically in:
> 
> [PATCH v2 4/6] target/s390x: Factor common s390_ipl_read/write() helpers
> 
> Sorry if I've missed something, but is this meant to be part of a series?

Well my bad, I'm never sure when to repost already reviewed series.
Considering there is now a v3 for this patch, I'll repost as v4
including the reviewed pre-requisites. Thanks for giving it a try!

v3: 
https://lore.kernel.org/qemu-devel/20260616191716.12932-3-philmd@oss.qualcomm.com/

> 
> Thanks,
> Jared Rossi
> 
> On 6/15/26 10:16 PM, Philippe Mathieu-Daudé wrote:
>> Rather than calling a TCG specific method in s390_ipl_reset_request(),
>> have handle_diag_308() return whether a vCPU reset is pending, and use
>> that in the TCG DIAG helper to return to the main loop.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/s390x/s390x-internal.h  |  3 ++-
>>   hw/s390x/ipl.c                 |  5 -----
>>   target/s390x/diag.c            | 30 +++++++++++++++++++-----------
>>   target/s390x/tcg/misc_helper.c |  5 ++++-
>>   4 files changed, 25 insertions(+), 18 deletions(-)


