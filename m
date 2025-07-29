Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E498C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugs0T-0007CL-OE; Tue, 29 Jul 2025 17:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ugpVO-000379-Cl; Tue, 29 Jul 2025 14:57:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ugpVJ-0005f9-Sn; Tue, 29 Jul 2025 14:56:52 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TEN9uU022183;
 Tue, 29 Jul 2025 18:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JQiFm/
 8LkTpCNei36jBcjY0C5iEc1okySF2OeGI3xUE=; b=p70X4xZq07/YwmOxZfSSvK
 f1jEXoFdmz5tF6bdLBPlmQd9a8o/rP2mfNBkylrqJRUVOzcFJB0D5Z3326Y9SPv6
 vWfqC579j+RpTMya4ql7qqW2YQaZrlp1eOrpwd8bMr8/Xuy9jlnjAROD1KUotSlf
 Rh25FLJXrbHyBXXAzkl4Pc6hVCA+wqu6qiAhF30XS2jrautUYKnGAnASckoZ6klu
 a+YF2NVkDTf3K2t9jIJure8A9993N+iPanOx66jlVZcg6480KJW3ZXpQYmN+vrpd
 H54fHi+NSKAh9cpT3DXpAn3yqxeAaA2XerzaUVJ565mUaWGJYA7m9wxZ6+MbhLUw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qemrhdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 18:56:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56TIB62Q006192;
 Tue, 29 Jul 2025 18:56:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm3m3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 18:56:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56TIuhir29295218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jul 2025 18:56:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 355635804B;
 Tue, 29 Jul 2025 18:56:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE43558055;
 Tue, 29 Jul 2025 18:56:41 +0000 (GMT)
Received: from [9.67.142.67] (unknown [9.67.142.67])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 29 Jul 2025 18:56:41 +0000 (GMT)
Message-ID: <2db58bdb-d9a2-4d58-a721-b31774a295d9@linux.ibm.com>
Date: Tue, 29 Jul 2025 14:56:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/28] s390x/diag: Implement DIAG 320 subcode 2
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-10-zycai@linux.ibm.com>
 <ca7e2dc7-d70e-41ab-9f62-a411dce7360e@linux.ibm.com>
 <ce1bc819-59c3-4707-ab18-4853eee990d6@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <ce1bc819-59c3-4707-ab18-4853eee990d6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YZqIDI0MUxFA1NWeU_cx2IX6UMMzL3AB
X-Proofpoint-GUID: YZqIDI0MUxFA1NWeU_cx2IX6UMMzL3AB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE0NCBTYWx0ZWRfX/ganLpS3eCLM
 MqmKscxjCubeHP8a2QtRuG+KBlYpLtOhdiQxvtDz6UOrPhEGlvtDAGNQwYkNjamPGzDkamiPzPO
 Rpi6FBxQy3ESIXybwVkTnLHuapYj1cggIglacXTtyRGjStD6El351zmuf5vP46R9dx1CUIa8KTB
 KxbgY4azYrpqMGMORjxTkKmFkQqdH/RF0GLfS77Tvwt0aMx4ODmc5z1Rmr4CVHLQS8ckpXEB48A
 iSYd5SLofgTtStNGQttdjfkursFIzZO7l6udDO/w5BC9ruMzBVTt0GDvKRKGnIpa7e1ElDSkOrg
 h9bMNOxgBzwHoG6WXYKrrTXiqUmJKIpL1T3tk2kIx1g7QkQuzvvkUtrzXuSbunXfI0u2IcDy9Uh
 y/uRBdrSbuKFqHo70OQ46wGJ4ptySi5TTvjAbltH5+3bWjuABfL1rE3y/D4o/oXUQnfImhix
X-Authority-Analysis: v=2.4 cv=BJOzrEQG c=1 sm=1 tr=0 ts=6889196e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=AgJ6naEEKQXV4QMbf_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_04,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=698 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 7/29/25 14:18, Zhuoying Cai wrote:
> Thank you for the feedback!
> 
> On 7/28/25 4:59 PM, Collin Walling wrote:
>> On 7/11/25 17:10, Zhuoying Cai wrote:
> 
> ...
> 

[...]

>>
>> You need a check somewhere for no certs found in either the specified
>> range or no certs exist in the store at all:
>>  - VCB output len = 64
>>  - stored and remaining count = 0
>>  - response code 0x0001
>>
>>> +    if (in_len % TARGET_PAGE_SIZE != 0) {
>>> +        return DIAG_320_RC_INVAL_VCB_LEN;
>>> +    }
>>> +
>>> +    if (first_vc_index > last_vc_index) {
>>> +        return DIAG_320_RC_BAD_RANGE;
>>> +    }
>>> +
>>> +    if (first_vc_index == 0) {
>>> +        /*
>>> +         * Zero is a valid index for the first and last VC index.
>>> +         * Zero index results in the VCB header and zero certificates returned.
>>> +         */
>>> +        if (last_vc_index == 0) {
>>> +            goto out;
>>> +        }
>>> +
>>> +        /* DIAG320 certificate store remains a one origin for cert entries */
>>> +        vcb->first_vc_index = 1;
>>> +        first_vc_index = 1;
>>> +    }
>>> +
>>> +    vce_offset = VCB_HEADER_LEN;
>>> +    vcb->out_len = VCB_HEADER_LEN;
>>> +    remaining_space = in_len - VCB_HEADER_LEN;
>>> +
> 
> Re: check for no certs found in either the specified range or no certs
> exist.
> 
> This case is already handled.
> 
> vcb->out_len = VCB_HEADER_LEN is set outside the for loop. If the index
> is invalid, the loop won’t execute, and both the stored and remaining VC
> counts remain unchanged at 0.
> 
>>> +    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
>>> +        VCEntry *vce;
>>> +        S390IPLCertificate qcert = qcs->certs[i];
>>> +        /*
>>> +         * Each VCE is word aligned.
>>> +         * Each variable length field within the VCE is also word aligned.
>>> +         */
>>> +        keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
>>> +        hash_buf_size = ROUND_UP(qcert.hash_size, 4);
>>> +        cert_buf_size = ROUND_UP(qcert.der_size, 4);
>>> +        vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;
>>
>> You could define & set the above four lines inside build_vce (or as
>> respective fields in the helper functions mentioned above).
>>
>> The remaining space check could be done after the vce has been built.
>>
>>> +
>>> +        /*
>>> +         * If there is no more space to store the cert,
>>> +         * set the remaining verification cert count and
>>> +         * break early.
>>> +         */
>>> +        if (remaining_space < vce_len) {
>>> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
>>> +            break;
>>> +        }
>>
>> You also need to check somewhere if there is enough space to store *at
>> least* the first cert in the range:
>>  - VCB output len = 64
>>  - stored count = 0
>>  - remaining count = // however are remaining
>>  - response code 0x0001
>>
> 
> This case is also covered by the if statement above:
> 
> 	if (remaining_space < vce_len) {
>             vcb->remain_ct = cpu_to_be16(last_vc_index - i);
>             break;
>         }
> 
> Response code 0x0001 is returned at the end of the function for both cases.
> 

Sorry, I neglected to mentally trace some different loop variables to
see that these cases are indeed handled.  Thanks for clarifying!

[...]

-- 
Regards,
  Collin

