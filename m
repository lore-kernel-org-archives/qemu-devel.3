Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1C9C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoIW-0000Iv-Ex; Wed, 01 Jul 2026 02:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoIV-0000Hr-Eu
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:19:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoIS-0007La-Kd
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:19:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lWlW066035
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 unj+myK7kWvzNi+xjrja/5YPEXPwzazrjsdj5mHR4ds=; b=RkflwARdVyxQrKpU
 xlUgR7WCZ2E04vrFKIJKCG4HMIR/O8CiMSARBIjjKpTKTN8avtSmhYguYxGDK0kL
 IJCJuaO5+5nTfTPY1JTtFch7yZ3N/C6zrf1DrcnrSkkKPE0JOev9SqzCgqorGhEb
 c4S1+SntNqnYYnb/6c2rNNccvWfkmFYIbPgZGzVzYUG8yWha6HxRnbu09D1HA/x8
 ulZrmQ3snBRLYHAeR6li3gqA6WlrZyZT1ICMzBT+Tr/v1z2gNITpnshDaNmC7UOY
 Jd+WZ2tNrxbmaC6XmyagFSe05/8OUGRVMxumlV/tjWOsZTGeY9+KxDuaEQateO1j
 s7GtJA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqjj7j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:19:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915f6ff639aso63584185a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782886782; x=1783491582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=unj+myK7kWvzNi+xjrja/5YPEXPwzazrjsdj5mHR4ds=;
 b=hNEq6PFc5J8fBq8y9Ysh19YSdSJrSwm2J/VCGabGf8cUqdH3ZxL77CObXG7naGlDm9
 mxg1o6001D0UfUg2mziOTiHqm2BDPgok5MeThuZm9QhoIisPnapiUnpvVIx+MA/ZTvDZ
 kHNqWkxp2on/v7GMypeNR2s0l7ngVTFP/GK5d5PrEdC4EBzdSHy/JBv4DlzVJm3N0uqo
 QQanLCQ2Sc9eQstdJ3/0xqLC+GvW6IVj/XsGYdk7RYkuz0VuizWoe9Q4d/OzlpeIUgaF
 mP9qleu245QyoFDayS8KYzR9JWEQYO5misSs4K8BwVQU0H+Q937HbVROe+CSki6Z8QrN
 6uCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782886782; x=1783491582;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=unj+myK7kWvzNi+xjrja/5YPEXPwzazrjsdj5mHR4ds=;
 b=dM1FonWxJo+atfrVKR6EJNIMNr2F+V0BJvpdZl59pC/ZhoNdYsiDooZFbPSgu0oFPN
 CqAJfw2TLv9N3UhXHa8pkN90qZexMh82D2aLVgGCrONWhTfnfNrVGkRoAjLn5ggBRPdk
 QKdqpRMGL39NkIIJlIM/4JQfNr3sPBKFDvTRMf5Fm1YZOVbB/jmd2GnWhwHZXG6T7vQR
 g6ekAaaAFf92Lkmh9uwea0wn7JweNAzJBzEaGCmpd1dniFIVxSFHxLGHg1Oiwl38iAor
 sPx7agSFNt2jFujXEuDuEzlKlBIPuV36UIr9tTLyib05PsIFHj1664MiPZ2WdC4MpOco
 SjPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JEsTOwoKmir4Vful9mvjkYqEDqZmk31x9fSfmAobxzDv+KVQoe5oyvq6FEETHmxOViEtdm+Tk35EP@nongnu.org
X-Gm-Message-State: AOJu0Yw9TjyyegYn+b20IyMiRPLI9FNeqzi7hrY/NEPpEum/uJLLK6Sh
 o9qBeUwuL5q+wCgJ2FdK3762FVHAphQVvAY5MRhR5pDcJXLnntsIkRJ5R4grFbdWNHj0vYq+K//
 Ng4O2dtvCUtENQAlB3OFwMy8xmlqDS5lXPwvUvqvH7LqEJKmMan/Tpss04w==
X-Gm-Gg: AfdE7cnZYQzXU2pcyodNedk6/7o5hmdffW9XdluNvMe9pdKNAMzmts6sNszH6NrSg5y
 8bQojp15/mEpjtAe8+zDXw3ARWZ51fz2CatVwltENBYe/pPDR1W5Lod/Iqhb8gNe4w2KSs20TX4
 xkQM0UrAeaMJEbiLmdtZiO8F4GIWCVJSrFYKFitOGt851TaJ+yynvSpX2pNjHXQOp+GpIHDfBW0
 NajiteyappnUyY+Xppbj0k6wrqqriesxX12OYjyu0XNztDtRBtrEvfwBbqLl7f24ZTgukCnu6J9
 5Y3tX7dPwisBgTArfHgPhsw7KzYW26qwIvNGJgpjYlTg1FWpc0Kb8ifckHWpxffS3s+FA09WKxs
 vRbLH3EisEzUgisWDK9C9xXIFtUFPAAt9mkqga7qs5OEZHCj9fOHzSoLVVg3naA==
X-Received: by 2002:a05:620a:404b:b0:915:efa6:d718 with SMTP id
 af79cd13be357-92e784cc16dmr43873185a.47.1782886781977; 
 Tue, 30 Jun 2026 23:19:41 -0700 (PDT)
X-Received: by 2002:a05:620a:404b:b0:915:efa6:d718 with SMTP id
 af79cd13be357-92e784cc16dmr43869485a.47.1782886781138; 
 Tue, 30 Jun 2026 23:19:41 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm89069585e9.12.2026.06.30.23.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:19:40 -0700 (PDT)
Message-ID: <6d52bca8-c748-4b27-a46d-a9de9dc2b782@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] exec/breakpoint: Introduce BP_CPU_ID_SHIFT
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-9-richard.henderson@linaro.org>
 <a5d3aa14-4b74-4e0a-a514-a8dc23890813@oss.qualcomm.com>
In-Reply-To: <a5d3aa14-4b74-4e0a-a514-a8dc23890813@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: eKdtG_GGAV5hepUBdJNAfXR2b8rVEtRL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2MyBTYWx0ZWRfX+HjwLW0PaWiJ
 41x7uYxj4xyz4DYEwCssc96OBBZ0Ky7aCkDrx8ghqqQKfijoQnAnpiiMQYj3e/LGT7xPwYe1k2g
 hO/dVlmamcmHnenekBkKBPzPOFxRh/NpNKL1xy72hOK56pX7L1orWY/HKpS7ZuH+spt9hszzxHn
 y06oueyDG5bMbG4AR+5KP05FbBcFVk8ioZ/A3F5JookBPrEiBOdWHWC+RMU9ySDxz6cLcjkdhHA
 7bdqZiAGaUst0Vm8uLwP7zcL9MEO/1PKIpevCW87SidxdCwykiBVyH+1Ug9KJd3Psdkfp1ZxcnJ
 IQmRzoD/gGlgIQkWbNK1WOneu+uZDftB/UdylXpHDfoFxXHQQ+rJivp67EB3ZXWEPqmVwaGZyC5
 qkuUbqS9sgs5K8aL/vdlMlvgM23nkkjZ1DpTt6RG4KcC3wi5d4vksHaQUTP+RYVuzu1J0Ew5a0h
 GN5Al4xOKv37hRYOsUQ==
X-Proofpoint-GUID: eKdtG_GGAV5hepUBdJNAfXR2b8rVEtRL
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44b17f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uRcIMZw2FUk9YvzEzAQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2MyBTYWx0ZWRfX1P9LXzzzAFgl
 T2CGNcPFKLnBm7FIbSvF7gucFh9l9woivuk3G4bXa9RoR0+GehVgc3cifa/ih1BvH6oS1J8+Dzz
 KwWhlQDx94c2sk2xHcAjbY1e5Wuto2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Richard,

On 1/7/26 08:10, Philippe Mathieu-DaudÃ© wrote:
> On 1/7/26 05:04, Richard Henderson wrote:
>> Allow the target to store an identifier with
>> breakpoints and watchpoints.  Change "flags" to
>> use uint32_t instead of "int".
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/exec/breakpoint.h | 10 ++++++----
>>   cpu-common.c              |  4 ++--
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
>> index fc91343875..93876f3304 100644
>> --- a/include/exec/breakpoint.h
>> +++ b/include/exec/breakpoint.h
>> @@ -25,10 +25,12 @@
>>   #define BP_WATCHPOINT_HIT_READ  (BP_MEM_READ << BP_HIT_SHIFT)
>>   #define BP_WATCHPOINT_HIT_WRITE (BP_MEM_WRITE << BP_HIT_SHIFT)
>>   #define BP_WATCHPOINT_HIT       (BP_MEM_ACCESS << BP_HIT_SHIFT)
>> +/* Bits [31:16] are reserved as an identifier for BP_CPU. */
>> +#define BP_CPU_ID_SHIFT       16

While I understand the benefits of storing the ID in the structure,
I'm not keen in having it packed with the BP flags, it hinders the
code logic. Since there is no point in optimizing this, lets simply
add an index field. And convert the API introducing _by_index()
helpers. I suppose you plan to remove cpu_breakpoint_remove_by_ref()
at the end.

>>   struct CPUBreakpoint {
>>       vaddr pc;
>> -    int flags; /* BP_* */
>> +    uint32_t flags; /* BP_* */
>>       QTAILQ_ENTRY(CPUBreakpoint) entry;
>>   };
>> @@ -37,13 +39,13 @@ struct CPUWatchpoint {
>>       vaddr len;
>>       vaddr hitaddr;
>>       MemTxAttrs hitattrs;
>> -    int flags; /* BP_* */
>> +    uint32_t flags; /* BP_* */
>>       QTAILQ_ENTRY(CPUWatchpoint) entry;
>>   };
> 
> See https://lore.kernel.org/qemu-devel/20260630220100.1289-19- 
> philmd@oss.qualcomm.com/ ;)
> 
> 


