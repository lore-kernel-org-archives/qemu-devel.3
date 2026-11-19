Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6FF606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g6Tdsqd+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O8R4wZI9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0j8-0004ak-0G; Thu, 19 Nov 2026 06:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0j4-0004a3-7r
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:54:50 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xU0j1-0002jJ-4G
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:54:49 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBkVFn085331
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6DrLXJY3WP7dMXxe0pWo15AFIPi7stWi+gzRqpoyvGE=; b=g6Tdsqd+e5hTrxvu
 6JlsSPAtyAcjl/92xB0sb1Zc6T3fsjfgELPpjt8e6X9GJWIM8r0uLlcI54qwYImh
 UTs6p4sjRTpnwBrM9JT/9RiOn2PE1/ziOjho5kWFchOZFzihhMXQhAo0/Acnevho
 itSPDvkBTn87u2Dpq2034eWHTNAbmo7k7IKarVPsKGwZUn/9GJdXMhfZSy8E0hi1
 tXYRRuR3gWP8+AaEeRFviwwakEvWNmNe8a+0AzIrzOU//i+CxfgvwjMJaP3HHrgw
 WONaVDVeDuBRzIRBIdUpJ0qh86570c5lHC4DtJ8hfURfb2184Ni/KDniZwetiqOy
 BR3Pqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1vv2s3vx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:54:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so456578585a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 03:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795089285; x=1795694085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6DrLXJY3WP7dMXxe0pWo15AFIPi7stWi+gzRqpoyvGE=;
 b=O8R4wZI9jx4KsT4waJheWI5jkTmvp+4yih93AEgkUfMSA8i1ceUySFB/IFYx880O2H
 1cnBIBjjKg5mv4dsL8om2BJODjQyzCc9c156iBPfE4clzqUz4ugcVExceqg3aJkjBY6i
 LkS8QJdL6HrbBmQhECotzKMgiaUT/31mFGjGx/BS/2csK03IQAE5vR2ADeYSpLSyaDYW
 3OetEUTZh3Kmf74euiDgXZDriRVN3aLUyZr/c9IkUuhwXFG6G9wdxaAAoXemVVj6uTf/
 VoM3hOiKI1g3ed+KAzDvEvRpTIl+oOix66CzqQAwABYDsul6o+oERHW5913Oi7dW0E3I
 RUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795089285; x=1795694085;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6DrLXJY3WP7dMXxe0pWo15AFIPi7stWi+gzRqpoyvGE=;
 b=WkTVVvQ13OrqyONMt1kL1XYlEk7MI+DP8cV1qeL7+kEmo23knqdC4QFb7NuDZzWNF5
 l4YuGzZj/77V37skurr3/AWsSLoSUgj3bOpw5RIQUN3A9zFX+eoa+cJw40nqVDTAoEKJ
 8ZlpFIreWT9IvwPnz5Na/rGQoEmWaHzo+qkY5Tnj5XBCCL6m7k8O0L9ztnSHwc9PEJTz
 MWiIyEaE1CRe8vgiN/Hv3ll6RhGaXqE9KezOUAVMpmY14GrFfpfF7p3OQjafdaxSuMau
 3ErmGXmpKFaMoq6GnRy7rBQ5KNyiVN4ZR8P4PD3XoOiKO5Ij8hO2rzbEx5vWrsag7pJ/
 EGUA==
X-Forwarded-Encrypted: i=1;
 AL+hErH/ACOP1tCi7b7L03p/xJ8Ze9GeXlYuwpXBZzgTAEH89NEIrRafHoePygzeF2JM7vTJHglMA6ZA9siS@nongnu.org
X-Gm-Message-State: APuU4Z/kwZOw/xDc34ponib9ONtvT1Fp5/SllYbFSWtWwInoYBu0DSY1
 2tzLcgc5tuYqKVv/RElMHIl4Vy6bIaMRAZJvmjgRP1EghvRTCgAVZGe1pqH3hOHsZFUFYg9iboQ
 FYZ2fpa5DBK5xkqr7LjEOBlwtUNrNvNCA1VXH68yxWBpwaKWPu4KIrH+1jA==
X-Gm-Gg: AYBFou3QKo4tFPi1J/PhucmfF5/SyZuXaKX/2LPR1P3JusLv+ZdbiGMC/ytdJJt2c9K
 k7S4fFNibst9cXXE2uaDN0yWsombb+Nsg6ReNrXzfjnxORsEUxMO6WI+71hemt5CH/daxdkQ/4p
 ojEeuIFVAnyiog+fwCrbjVkOY2ySNan6l1SaxCo9sv4+b1LprN+zVd5RKoBw5+sPbYPsS2eiiAI
 pDzFwi9Y4dy0aNz2lxJ4Cf0AUYc/NUqD+hPeFS/ht+A1f18rCZHf41M8+SavYcTNKis4LYF+jMQ
 06LXFN8ZBf+12ieBSbAT/HXf5pysXmawpSoBEM5vfzYlbCVBoEUznzV5Xq1sEdOEYdzyGNFj5TP
 CZBQi+RMx3vEIvPii5CAWXLT2FzFIA03wjHv6afGiCVT1DXugISZH80TPyLp4HwL+TsaY
X-Received: by 2002:a05:620a:4802:b0:949:7c43:d54b with SMTP id
 af79cd13be357-949995a08ffmr1024542585a.30.1795089284635; 
 Thu, 19 Nov 2026 03:54:44 -0800 (PST)
X-Received: by 2002:a05:620a:4802:b0:949:7c43:d54b with SMTP id
 af79cd13be357-949995a08ffmr1024539185a.30.1795089284177; 
 Thu, 19 Nov 2026 03:54:44 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm30843445e9.5.2026.11.19.03.54.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 03:54:43 -0800 (PST)
Message-ID: <eda18b65-ad5e-4985-843a-bbadc5e7f390@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 12:54:41 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-11.2] hostmem: allow building without KVM support
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 Peter Xu <peterx@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20261119113309.1205353-1-mjt@tls.msk.ru>
 <18e8c852-9870-4232-aae7-66db4672fdd9@oss.qualcomm.com>
 <2fc4fb7c-7d8b-4af9-8ab2-6ce3682acd13@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <2fc4fb7c-7d8b-4af9-8ab2-6ce3682acd13@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6eq9ar4pCMh9jxwfooiOTB_rddmRVl_X
X-Proofpoint-ORIG-GUID: 6eq9ar4pCMh9jxwfooiOTB_rddmRVl_X
X-Authority-Analysis: v=2.4 cv=ZZWIpcVA c=1 sm=1 tr=0 ts=6afee385 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dMDxPF1GtEdq01UuaR/ERg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=HJvTdP9fkNgUw0tOALIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfXxuL24IkcjDi2
 0TP4nDAK5FPdQFV7w/O0pxdfUaGSW2KjX3+qel5/DDoXfa+NaI2lDsb05EvWlJHJnG/TvHIz0gD
 M+X/nJdH4MnqcFnnk8MRDuwLFIrnbCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NyBTYWx0ZWRfX84VZ+OLcxUwi
 ZBYWtdoEER+UH4+GEHIBP3tvWvFFn/Q1vSAIdS98ABAtbCskIHcegdrESUUuiHS2AUow5aDPHwm
 0H6nYADqYXQSfPFYOwWa/Cbgip38gZK3m31PZ+ArMAeln0YQHiOecsS93U8uA+AHmh0MUS27FhJ
 VRLAsPwkUPtL+oHv3fu2eBYseAW5HQTuO9rQiiTJlXmQJjPxDjDyzOWa9sAlNxgeXkN1n7GVI26
 gFrWYuI6/OIsCYHqr2SoXwOVm2wEHLU911iBV8Sj0hHnqdMBzrqvg758Osa+SRGmWdqP5phevIL
 DDsikEAdu5SNJBctAbwAk7AYFChKJ11DbWwBiXVLUKrFD1KMPZIcpyiZGT/7Ox6zRZgXHfpEViS
 GhN0OanD3OIF7S7bwnUIHKCHF7zRx4QrilElsKpfneaqK1+GY9DRwNGDw7zCbd9GrzDEBh+7aW3
 ux+KQN1PEKPfeORRWRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190047
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-19 12:46, Michael Tokarev wrote:
> On 11/19/26 14:42, Philippe Mathieu-Daudé wrote:
>> On 2026-11-19 12:33, Michael Tokarev wrote:
> ...
>> We prefer using runtime check (probably providing a stub):
>>
>> -- >8 --
>> diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
> 
>> +        if (!kvm_enabled()) {
>> +            error_setg(errp, "guest-memfd=on requires KVM which is 
>> not enabled");
>> +            return false;
>> +        } else if (!backend->share) {
> 
>>>           fd = kvm_create_guest_memfd(backend->size,
>>>                                       GUEST_MEMFD_FLAG_MMAP |
>>>                                       GUEST_MEMFD_FLAG_INIT_SHARED,
>>>                                       errp);
> 
> This will fail the same way because GUEST_MEMFD_FLAG_MMAP is still not 
> defined.
> This is why I especially made this #ifdef the way I did.
> 
> Sure I can add
> 
> #ifndef GUEST_MEMFD_FLAG_MMAP  (if you prefer not to use #ifndef 
> CONFIG_KVM)
> # define GUEST_MEMFD_FLAG_MMAP 0
> # define GUEST_MEMFD_FLAG_INIT_SHARED 0
> #endif
> 
> but it much uglier and less understandable than #ifndef CONFIG_KVM.

As you prefer. That would be the first accelerator check in backends/,
I'm not sure we want it (then they are hard to remove):

$ git grep CONFIG_KVM backends/
$

> 
> Thanks,
> 
> /mjt


