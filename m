Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E51C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ydb-0006WA-7m; Mon, 31 Aug 2026 05:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x0ydZ-0006Vy-Dg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 05:49:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x0ydX-000883-Q5
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 05:49:09 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V9J1PJ2517051
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eN48iTdEO9eyFztg0WuIybzBtG38C6lTtw9tqNlqPvE=; b=RSTkkhqrOmZEUiP5
 9+G0uUSDl5Biwl05KrO0SMo8eaJPdmAECHk7x8W8H4/7fGpa49UKihzlqE0pM8uO
 ad1ZnyCPtJDw6GaI4e77KmxYzeQM0WwE8FdiP+aVXu+UQ1+jRdSVmP+vUYavgxsb
 ViMOy1vabBO/lKfeXIdz1pdfPlm2Vpe4Ct6QlUshU/pS7RHTYDongFXdFOn2BqCr
 7tPS5gzflCgx95T9yLAzF236Uz6Uhz8T6jvHVJLIHZHu1Z7mOiiX0FoOQEk0o8tV
 +wvfcW8gWN3zVJjIES7zrka+/DW+aknKqewQrKdGxm65OC06uQnedq5FoZrpBWrM
 OKUUiw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6vcr427-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 09:49:06 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52fb8f67542so51385421cf.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 02:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788169745; x=1788774545; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eN48iTdEO9eyFztg0WuIybzBtG38C6lTtw9tqNlqPvE=;
 b=UcKVwZO0GxzQR4QSo1tg37K9GMCWxBUKN29Gw1HBoXjpmq79d7LObHa0u4dEE/hOD5
 9JnGja1v5ZXH4tYLw7z5lRb6BU2xXVHPVV/Bf+Vw/wQN0qwHQfk8xbZLLjaKtDAO8+3B
 W0UDewmnm/S3KHBHsaNiuTMx7JSLNR6ljINJ9DJPvEjM0rFzfoYidoqQXWpkknBvZCcD
 QWvwh0qbR5EWtMlD6I6mOD0izZ891+WPa/qEOXisjy4QryNJM3OZGjG2mRIhJwKnTmoH
 y83aH9O2sx+fll9KydRBlX2mk4MxaHeXft64Zxz2KKOvFkvyaqsN/vmsmYW6kISt5zxx
 tKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788169745; x=1788774545;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eN48iTdEO9eyFztg0WuIybzBtG38C6lTtw9tqNlqPvE=;
 b=MkJfiu3AKTlRj7/wHDLnQth/VAMGCMzFwMG/pb9Y50sZz0utZKfI7vh044wGZ1ks7k
 YVujDnNPbOBkqzvB4jf2azL6qy4z0r1LqknZSrAdK5U7VvQO+Xpn5pOtyaDBo2nvNTKP
 ABdRetopce6xqBozQ3dQt6eB6thMs0xWwQjuOhtVnTGJElg9mApyRUvcZ6A0eZqP8C1v
 ohag1OX85UrLbDUtE4aMektl8kjvoBw7HHJxtW/PAs3XaI04MEO9QpkjHZ0+jmzcEs9k
 lTl2dMsk3LzCKYUX8D1r+UAHbp7rmSXnUU1NAbpXo0Z5ossrAB5T5PyqQI0NsGyHLNTw
 dXgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqg3FC5TahZdQ42aDvrQI1mrWKYDj2f1jtzGXyxFJQqhHAXVkyrou9hDXXU/qdcMVJKkUcD+4zTVOV9@nongnu.org
X-Gm-Message-State: AFuF++mWEL5+vcUpucMtXKgXYnFnktie43sb6rJwCCN54lZGp92VpShg
 BDcXQj3+yblId+BysyRwlU4vg0gOa2yhD0HON2xaO2+ajTnHXylLs1Tj8e5JgHK0dkRE4KtLA+T
 I5wu6vShUNVXm+p+EEpO0t8V0LzHQC/jN1vcPPvBFim6IEbsTCO8D1nWAag==
X-Gm-Gg: AR+sD13Erbw55lkE29s6IvESF7J21RP7Rgok0f9k7U/VPXQJwTlBppEOjl5Z7N8ZqJk
 fJdE2bVIANzMDoV9J5w1mU7OaqRwzAv2p4svvSEeWZmrmcq+8NLABO5kabJ4/63/g7FGT8g8JUJ
 NJt+noSCDclRxRFCBfJu4+yrhTdF9GUg59QAovHSbLz51FrR478Wa71AytX6D8eM4nC5qaeWvX8
 EFbbohbhEgbpIUC2dxfL1a7ZQV/4st0rQhBngPYlaYrCx4UWo9vTSQrV4o0g7uRSi3bHU0uQS2b
 zF2NSv5NSwMHvYUJ4845ev1Ryvk+KNUi7xEhn4jyAaUvomr7XxaKXbCGRz7kyLrEQU8ilG4ops+
 3/IoE5u8SoEuXePCfZFxceGXXQwCEDtTwGkyL
X-Received: by 2002:a05:622a:228a:b0:52f:b1b6:a4aa with SMTP id
 d75a77b69052e-5301b1943d6mr16200461cf.4.1788169745474; 
 Mon, 31 Aug 2026 02:49:05 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:52f:b1b6:a4aa with SMTP id
 d75a77b69052e-5301b1943d6mr16197331cf.4.1788169740261; 
 Mon, 31 Aug 2026 02:49:00 -0700 (PDT)
Received: from [192.168.68.100] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52fbe878f4esm69173531cf.31.2026.08.31.02.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 02:48:59 -0700 (PDT)
Message-ID: <6d3b5400-4f73-4049-97bd-55cff8bcc4ef@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 06:48:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] hw/riscv: Add property to hart to allow private
 memory
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
 <20260826221154.54577-6-joel@jms.id.au>
 <be675569-27ef-46cf-82bf-563852bbe66e@oss.qualcomm.com>
 <CACPK8XczvftDPUVb=2pX9ofRNA31jhLopeFPse-o6s7h27BVuQ@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACPK8XczvftDPUVb=2pX9ofRNA31jhLopeFPse-o6s7h27BVuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4NCBTYWx0ZWRfX7M7J1mwKUEw1
 a5a7k9AcfY5SVp1U/lZ/AZyWbAE67eyLvu8X47n+PrnRmjA/w3BN3+ce9UE/I45N4K2U5Kzidc1
 MCYgPXAWYhzQoBEzw5uIz7UWlK27l3pmaM0Kz5DPNJ0WX60C7HlWUNhJz9LIAfz1pRXK6J1hULC
 zLj82nNKp39plqUCifnGjxatVM6HTWOck+65hyyPmI1dMhfc1qrpDZ/ETIQhrQKKi8foThv2nny
 tUiaOs5eGidULvfLfJtQ6IPF12Rj6dayyljyCr0EoN/zfOm5+34baIF22ruYNFTQbIBrxjVl5sV
 Ec6b/JP48j/AvHkOJw936pPRadjWPKlo3yVvvetbDG5Zpbg/UAk8Xv9z4PHOz6slj1tErX7IF5u
 mZgRW3I+3ig1qk0muI6qScDfZtkcGBFN9gyA6ny3BDPQBy53zxsJSPO8OEXjO8GZW5Jql3icB3O
 k/43MgVaJY1ZlmhzRWQ==
X-Proofpoint-GUID: m6vrfMFdgGOFW4nn2G8dqx9QYzEx3rHb
X-Proofpoint-ORIG-GUID: m6vrfMFdgGOFW4nn2G8dqx9QYzEx3rHb
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a954e12 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=t9496tuAAAAA:8 a=AtdzOuRA7NdErCjRmd4A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4NCBTYWx0ZWRfXzzqGcr4A6ZqM
 z3XwlkFTBZ0WMnJjBdPrsQtx/SaGY5T6y8UFtvrpawHaW87kqGegXosjjnRRHdrZbOyVIgkuKXV
 aXsgUZROhyxfDXBxnbz8lSi2DCkn9Ac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 8/30/2026 10:57 PM, Joel Stanley wrote:
> On Thu, 27 Aug 2026 at 21:48, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>
>> On 8/26/2026 7:11 PM, Joel Stanley wrote:
>>> From: Portia Stephens <portias@oss.tenstorrent.com>
>>>
>>> There are platforms where CPUs have different mapping of system memory.
>>> The global system memory does not allow for this. This adds an optional
>>> property to assign a specific memory region to a hart. This allows for a
>>> machine to alias the hart's memory to system memory while the hart only
>>> views memory from its own memory region.
>>
>> LGTM but please clarify in the commit msg that the memory region is being
>> assigned to the hart array, not "to a hart".
> 
>  From the machine side you're right, but I agree with the commit
> message that the memory region assigned to the hart. The property is
> being set on the individual hart, not on the array:
> 
>      /* Use private memory instead of system_memory if provided */
>      if (s->memory) {
>          object_property_set_link(OBJECT(&s->harts[idx]), "memory",
>                                   OBJECT(s->memory), &error_abort);
>      }
> 
> How about:
> 
> "This adds an optional property on the hart array to assign a specific
> memory region. The array passes the region to each hart it creates,
> so a machine can alias the harts' memory to system memory, while
> the harts view memory from their own memory region."


That works for me. Thx!


Daniel

> 
> 
>>
>> E.g.:
>>
>> "(...) This adds an optional property to assign a specific memory region to the
>>    hart array. This allows for a machine to alias the array's memory to
>>    system memory while the array only views memory from its own memory region."
>>
>>
>> With the commit msg change:
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>


