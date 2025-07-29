Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D249C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 21:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugrcH-0001r2-3t; Tue, 29 Jul 2025 17:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ugoua-0003v6-60; Tue, 29 Jul 2025 14:19:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1ugouW-0000cB-Hl; Tue, 29 Jul 2025 14:18:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TEHuiv023244;
 Tue, 29 Jul 2025 18:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0GwaD5
 jo1Y51AAv6/6CgBIUxf7RSPLce4bQCsA+/HMc=; b=QXkFmAebRSRu706Rz1BX1s
 QuhRjCamd2U4BcdYvCR3QZMA7cm+hl/IESUEYCREcXsYt0Mvpq9fWdd2T4qRPlW4
 TlZ6qEBuQR6N1GIpS9cPofTlxFq2KxxuZcVn+Nw7woLckxySbyhMPH/ivJzDZMqN
 epvy5kseZfuYC2uUPIVRCbtCJDNRUpfxgt8V4RUeU1weqqvD88p9WGnG8CpBw5yx
 Uy2gidG/YO2ZP9yyVPD9erVVUs7mL/Kbv076ZevcM3AvqqKsptki1/CP2IUZoEOM
 zwdVlU2cm5qWgpvG9+EUrZah2Sgr+M3N0mkZf4vj4BeBFEHXWUig8pn9wM9I7rjw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qd5gdfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 18:18:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56TIB6r6006192;
 Tue, 29 Jul 2025 18:18:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjm3fj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 18:18:43 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56TIIgq519005958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Jul 2025 18:18:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EB005805D;
 Tue, 29 Jul 2025 18:18:42 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72BA958057;
 Tue, 29 Jul 2025 18:18:41 +0000 (GMT)
Received: from [9.61.1.221] (unknown [9.61.1.221])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 29 Jul 2025 18:18:41 +0000 (GMT)
Message-ID: <ce1bc819-59c3-4707-ab18-4853eee990d6@linux.ibm.com>
Date: Tue, 29 Jul 2025 14:18:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/28] s390x/diag: Implement DIAG 320 subcode 2
To: Collin Walling <walling@linux.ibm.com>, thuth@redhat.com,
 berrange@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-10-zycai@linux.ibm.com>
 <ca7e2dc7-d70e-41ab-9f62-a411dce7360e@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <ca7e2dc7-d70e-41ab-9f62-a411dce7360e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDE0MCBTYWx0ZWRfX/0C47onGwVg4
 T/iQjXGxQeb8Wcz1YmzwOujuBpCyyXBIF8mQ2gdTKdfX9H9SOF45jLvPpXisC2sGoGuKoaN4LAW
 BSfaCYIDWsbfmFYrEJHW7l/EsuSc9Emnt9LfGq4GUZQ0v9cpALqV5Lo2+/qClN27Kmr9bM7cNxG
 AmpvVDXsnSSvYlK8v54pqOuxoHDwq5ozLxyJWRcW1A+2PbIMiQm5kRsBZhULtM8PneP0a/UEjSh
 I0qPPAd79nyWjLJuCTqsM+nvpzaZbSpQAOC7M9109GJRG8jdjAjy9MPje3OE/ISpu669lWAgYJL
 vsNN2lhbpV5BN/ekQ+nxa8owWlXlKGBLg6qBqY8b2rNSFs6GD/gRE3TBNnV5wIwWJ2hu8OF68t2
 NjJ0R9mycnRPCe6dRkM5FL/fu/9n/lSa6cMltp8dD+2F1P4AorgApF47xA0b+impfT0Sk1PZ
X-Proofpoint-ORIG-GUID: L1-IC2eIaH8qTglFJfg7E4v3qwJIoaNS
X-Authority-Analysis: v=2.4 cv=B9q50PtM c=1 sm=1 tr=0 ts=68891084 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0YD7pcYbvtPctfnijQMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: L1-IC2eIaH8qTglFJfg7E4v3qwJIoaNS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=537
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Thank you for the feedback!

On 7/28/25 4:59 PM, Collin Walling wrote:
> On 7/11/25 17:10, Zhuoying Cai wrote:

...

>> +static int handle_diag320_store_vc(S390CPU *cpu, uint64_t addr, uint64_t r1, uintptr_t ra,
>> +                                   S390IPLCertificateStore *qcs)
>> +{
>> +    g_autofree VCBlock *vcb = NULL;
>> +    size_t vce_offset;
>> +    size_t remaining_space;
>> +    size_t keyid_buf_size;
>> +    size_t hash_buf_size;
>> +    size_t cert_buf_size;
> 
> The above three fields can go into the respective helper functions that
> I mentioned earlier and reduce some of the bloat here.
> 
>> +    uint32_t vce_len;
>> +    uint16_t first_vc_index;
>> +    uint16_t last_vc_index;
>> +    uint32_t in_len;
>> +
>> +    vcb = g_new0(VCBlock, 1);
>> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcb, sizeof(*vcb))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    in_len = be32_to_cpu(vcb->in_len);
>> +    first_vc_index = be16_to_cpu(vcb->first_vc_index);
>> +    last_vc_index = be16_to_cpu(vcb->last_vc_index);
>> +
> 
> You need a check somewhere for no certs found in either the specified
> range or no certs exist in the store at all:
>  - VCB output len = 64
>  - stored and remaining count = 0
>  - response code 0x0001
>
>> +    if (in_len % TARGET_PAGE_SIZE != 0) {
>> +        return DIAG_320_RC_INVAL_VCB_LEN;
>> +    }
>> +
>> +    if (first_vc_index > last_vc_index) {
>> +        return DIAG_320_RC_BAD_RANGE;
>> +    }
>> +
>> +    if (first_vc_index == 0) {
>> +        /*
>> +         * Zero is a valid index for the first and last VC index.
>> +         * Zero index results in the VCB header and zero certificates returned.
>> +         */
>> +        if (last_vc_index == 0) {
>> +            goto out;
>> +        }
>> +
>> +        /* DIAG320 certificate store remains a one origin for cert entries */
>> +        vcb->first_vc_index = 1;
>> +        first_vc_index = 1;
>> +    }
>> +
>> +    vce_offset = VCB_HEADER_LEN;
>> +    vcb->out_len = VCB_HEADER_LEN;
>> +    remaining_space = in_len - VCB_HEADER_LEN;
>> +

Re: check for no certs found in either the specified range or no certs
exist.

This case is already handled.

vcb->out_len = VCB_HEADER_LEN is set outside the for loop. If the index
is invalid, the loop won’t execute, and both the stored and remaining VC
counts remain unchanged at 0.

>> +    for (int i = first_vc_index - 1; i < last_vc_index && i < qcs->count; i++) {
>> +        VCEntry *vce;
>> +        S390IPLCertificate qcert = qcs->certs[i];
>> +        /*
>> +         * Each VCE is word aligned.
>> +         * Each variable length field within the VCE is also word aligned.
>> +         */
>> +        keyid_buf_size = ROUND_UP(qcert.key_id_size, 4);
>> +        hash_buf_size = ROUND_UP(qcert.hash_size, 4);
>> +        cert_buf_size = ROUND_UP(qcert.der_size, 4);
>> +        vce_len = VCE_HEADER_LEN + cert_buf_size + keyid_buf_size + hash_buf_size;
> 
> You could define & set the above four lines inside build_vce (or as
> respective fields in the helper functions mentioned above).
> 
> The remaining space check could be done after the vce has been built.
> 
>> +
>> +        /*
>> +         * If there is no more space to store the cert,
>> +         * set the remaining verification cert count and
>> +         * break early.
>> +         */
>> +        if (remaining_space < vce_len) {
>> +            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
>> +            break;
>> +        }
> 
> You also need to check somewhere if there is enough space to store *at
> least* the first cert in the range:
>  - VCB output len = 64
>  - stored count = 0
>  - remaining count = // however are remaining
>  - response code 0x0001
> 

This case is also covered by the if statement above:

	if (remaining_space < vce_len) {
            vcb->remain_ct = cpu_to_be16(last_vc_index - i);
            break;
        }

Response code 0x0001 is returned at the end of the function for both cases.

>> +
>> +        vce = build_vce(qcert, vce_len, i, keyid_buf_size, hash_buf_size);
>> +        if (vce == NULL) {
>> +            continue;
>> +        }
> 
> See above, there shouldn't be a NULL case.
> 
>> +
>> +        /* Write VCE */
>> +        if (s390_cpu_virt_mem_write(cpu, addr + vce_offset, r1, vce, vce_len)) {
>> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +            return -1;
>> +        }> +
>> +        vce_offset += vce_len;
>> +        vcb->out_len += vce_len;
>> +        remaining_space -= vce_len;
>> +        vcb->stored_ct++;
>> +
>> +        g_free(vce);
>> +    }
>> +
>> +    vcb->out_len = cpu_to_be32(vcb->out_len);
>> +    vcb->stored_ct = cpu_to_be16(vcb->stored_ct);
>> +
>> +out:
>> +    /*
>> +     * Write VCB header
>> +     * All VCEs have been populated with the latest information
>> +     * and write VCB header last.
>> +     */
>> +    if (s390_cpu_virt_mem_write(cpu, addr, r1, vcb, VCB_HEADER_LEN)) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    return DIAG_320_RC_OK;
>> +}

...



