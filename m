Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2190606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LUY/yxY7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQfl7-0005wQ-3d; Tue, 10 Nov 2026 01:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xQfkw-0005ry-4K; Tue, 10 Nov 2026 01:54:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xQfku-0002N3-EV; Tue, 10 Nov 2026 01:54:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA51pfV219399; Tue, 10 Nov 2026 06:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0V/REK
 Tqhb8FuImRh08GImQe38OqphsykYriHAoFiqY=; b=LUY/yxY7pTxcSQAYBL/nS+
 yVgW9c+Re/G+QdTLV6egHQAwVgeqgb3h0mCYNt1poaho7gnx9ozN1d6muR7i6pYF
 ITusFTW0vS+Tfu906CR0hBeEQSdBOwYcWHdGmB6IBYCRBCEsfetC560tGiq9CU5e
 7IeZ5OhYpthde3ifLRZ/7m3tQ2O1PirQZ5UvT5fZjNsp6tL36iDdXbDyi/HQEW44
 TnYmzPM0lz2ngm5uNUSoQgIJPO5tNkkzwFgH+QXXjeQrqlCYjgLtgf7IfquvvHm3
 080ZZfCjhHANytQUCNXPYzZN5q/EpgNLaQ4jFo0767Tyo2LMiDAGmuKOXi2mrzgg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg36j4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2026 06:54:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4Z1AD1270107; Tue, 10 Nov 2026 06:54:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvwmmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Nov 2026 06:54:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AA6slPr16319012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Nov 2026 06:54:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 477E658065;
 Tue, 10 Nov 2026 06:54:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4806C58052;
 Tue, 10 Nov 2026 06:54:45 +0000 (GMT)
Received: from [9.123.11.20] (unknown [9.123.11.20])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Nov 2026 06:54:44 +0000 (GMT)
Message-ID: <e2e9c608-f139-447f-887f-8fb4909470a3@linux.ibm.com>
Date: Tue, 10 Nov 2026 12:24:43 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] spapr-vscsi: clamp adapter info DMA write length to
 struct size
To: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
 <20261028052024.38377-7-harshpb@linux.ibm.com>
 <CAFEAcA-CML7CFxn7WC0d2uuE6cHJbM2-p2Lv-wcAXWU9kpsRWw@mail.gmail.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CAFEAcA-CML7CFxn7WC0d2uuE6cHJbM2-p2Lv-wcAXWU9kpsRWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af2bfb9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=miANpqmMrLJ29yjBrAMA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfXw9k1zArW96o6
 bK76C1EwWdnvqzxyuTzt70WD8a7c1r88hnnFMto1sbYcRyn6N54kO/h5TDhBcyHlQ31bGdBuQ7C
 PRb+rP6k+Wpywm/PNNniaWVt76j/rYRG+GSXEf7nfFAaWk+PBC6z+oeII9Mws8C8iiKx46vPh2E
 Ccr+eeg15hY7FLIwd3T1obcj8P8J7M6ZneqR7B4uc1hUOW8UACysqKQ63uKg+k25JWc2X0qucb6
 RdmTt0dis6SWE0hsE0DaeEgZEcSiFJuJYSays3nX29shVnTf1K0osNM83IkrJIQ1i6ya/Tqbc3s
 gHJkv1O0+4nEzp441kWBr2W9mAUe0QssfTMM3bNzj54ncCDd/SzYPS0t5HPZAIoMqBfMfSbK65j
 uW/i04cxRTH0PCnyN4a+kpW0PkU6yH/qkC8updJKeW/vMZM+LlFvmOKOawLr9E+jujbUUmuXavR
 ZgwwJIFQfYerRvPZvSQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfXyK+HPHjREgpj
 sPNRroWYr+3ecW0lYlkJ+CUcslUQpPcArj0CTod+sLA7kdMy83BOaChBNntz5rL1RgHtt2JWQRF
 nLHpPwbXe0lK46AXIzvWBq9p2ZFHhHw=
X-Proofpoint-GUID: QIUt_NijTB_oMbGi8hDqWSdmuTgNjkKa
X-Proofpoint-ORIG-GUID: QIUt_NijTB_oMbGi8hDqWSdmuTgNjkKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100026
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+ qemu-stable

Hi Peter,

On 05/11/26 8:57 pm, Peter Maydell wrote:
> On Wed, 28 Oct 2026 at 05:21, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>>
>> From: Chinmay Rath <rathc@linux.ibm.com>
>>
>> vscsi_send_adapter_info() used the guest-supplied common.length
>> field directly as the size argument to spapr_vio_dma_write().
>> Since common.length is controlled by the guest, a value larger
>> than sizeof(struct mad_adapter_info_data) (148 bytes) caused
>> dma_memory_write() to read past the end of the stack-allocated info
>> struct, leaking arbitrary host stack contents into guest memory.
>>
>> Fix this by clamping the write length to sizeof(info), then using
>> spapr_vio_dma_set() to zero-fill any remaining bytes the guest
>> requested beyond that size. This mirrors the existing pattern in
>> vscsi_send_capabilities().
>>
>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
>> Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
>> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
>> Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1-rathc@linux.ibm.com
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> Shouldn't this be Cc: qemu-stable@nongnu.org ?

Yes, should have been marked for stable. I have CCed it now though.>
> Given that spapr-vscsi is supposed to be covered by the "virtualization
> use case", have we deliberately decided we didn't want to give this
> a CVE, or did that step in the process get missed ?

I think it got missed, can we still request for a CVE to be assigned on 
the gitlab issue?

regards,
Harsh

> 
> thanks
> -- PMM


