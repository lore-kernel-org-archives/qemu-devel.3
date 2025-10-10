Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDAECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Ivz-0000F0-Tc; Fri, 10 Oct 2025 15:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v7Ivu-0000Dx-Fs; Fri, 10 Oct 2025 15:37:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v7Ivr-0000Nb-Lh; Fri, 10 Oct 2025 15:37:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AIlSvb032381;
 Fri, 10 Oct 2025 19:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jXzxsz
 qWn1QxGXbRLLqujbGjvk3nh6UOjNgOgmsqG98=; b=fHokDyT4pxS0IEjOcG9A4f
 SEkx+C+FQc0bBow9y4rQoe+/jnmvohEGjeGPZ5Z41T1PseF7sqd7blXyLQ8pNOCm
 yMHUWG7J1klMNqShSlDCq5+qGAqbfAOrINXMKmZ+Nn0HCHJm2SLsBQQdxsUNypWN
 b5/op4aP0T4fZKfN1pas4P2aUvFxWTVKp0DVH6f2V9AApHwEpLcMv2QwJ5SP44rN
 O4X6kYOQeQTsplBJUb06MaaxLk0wayfWq/jYZnrvoMmcAoL/P3ba+Rm3wV2Y83N6
 OLBmL778Ao0sDEnNcJZWtsbwu7FXIccmd0Khig84LlhX4GgePaQ0cGyvJJMUlrGg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv82cpma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 19:37:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59AG0CFk022773;
 Fri, 10 Oct 2025 19:37:32 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vked0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 19:37:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59AJbVuT30868114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 19:37:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DA9F58055;
 Fri, 10 Oct 2025 19:37:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA4E358043;
 Fri, 10 Oct 2025 19:37:29 +0000 (GMT)
Received: from [9.61.240.77] (unknown [9.61.240.77])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Oct 2025 19:37:29 +0000 (GMT)
Message-ID: <464a9268-8caa-46e1-8221-5fef87971a84@linux.ibm.com>
Date: Fri, 10 Oct 2025 12:37:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-20-zycai@linux.ibm.com>
 <23e3c4f3-7e8c-4d00-8dee-91bf15261cfb@linux.ibm.com>
 <4b3100eb-2ada-4331-bc3d-f2faeafb1e2a@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <4b3100eb-2ada-4331-bc3d-f2faeafb1e2a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KrpAGGWN c=1 sm=1 tr=0 ts=68e9607e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=HlkOPZcDVwefj8GyqDQA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: oBHBbQn2rG-kDT7BLAXouD0aE91oi6gW
X-Proofpoint-ORIG-GUID: oBHBbQn2rG-kDT7BLAXouD0aE91oi6gW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2vRlDIpoyH1p
 anJFY5O71cq1eT487TNRHVz4SI5PQQjCBrq0ytT1TS07eNCt94CelLRFn2dqYAL/fvVsDOxFjxu
 n6uaJnBTJPeg6YCA+aHAAr3Y0UM2NaMuir2vnLfdSHWh44OVBzsr4zpFdF9xL1VzG+z0CP4NPaD
 A9Bss49bGhoIQOf2PZ3vdcO3yvoOfBFfo/ebEE5l+AC6/opobcHYCm35i1STCHbLypokhN/Albq
 /Ndp03n8J5LB4uhe2hO5JR5psXliysfrRbt4YYXQms9kFxAooFHbwQnrO4TQrUNGDirqugWrqsl
 GF0I1mVQzrBk2cjrunYShQ/yNZ73fe9sUWNadX+7fxdpIFhdSxOSuSmGk6SyHE6JdQEOfyOCO3p
 oVlfXPuCvL0uFwBoKb09EpgMzO2bJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 10/10/2025 11:00 AM, Zhuoying Cai wrote:
>>> +
>>> +static int handle_certificate(int *cert_table, uint8_t **cert,
>>> +                             uint64_t cert_len, uint8_t cert_idx,
>>> +                             IplSignatureCertificateList *certs, int cert_index)
>>> +{
>>> +    bool unused;
>>> +
>>> +    unused = cert_table[cert_idx] == -1;
>>> +    if (unused) {
>>> +        if (request_certificate(*cert, cert_idx)) {
>>> +            cert_list_add(certs, cert_index, *cert, cert_len);
>>> +            cert_table[cert_idx] = cert_index;
>>> +            *cert += cert_len;
>> It's hard to understand why we increment *cert in this function by just
>> looking at the function. But this function is called in the loop in
>> zipl_run_secure, could we move this entire function in zipl_run_secure?
>>
>>
> Thanks for the suggestion.
>
> I'm concerned that moving this function into zipl_run_secure() could
> make it harder to read, since it's already quite large. I'd prefer to
> keep this function separate because it handles all certificate related
> operations here and add comments to clarify why *cert is incremented.
> I'd be happy to hear additional thoughts.

Maybe we could simplify this by at least moving the increment (both 
cert_index and *cert) to zipl_run_secure() if this function succeeds? 
That way it will be easier to follow in the loop itself?

Thanks

Farhan

>>> +        } else {
>>> +            puts("Could not get certificate");
>>> +            return -1;
>>> +        }
>>> +
>>> +        /* increment cert_index for the next cert entry */
>>> +        return ++cert_index;
>>> +    }
>>> +
>>> +    return cert_index;
>>> +}

