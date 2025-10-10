Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D943CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7G8Q-0002se-Lu; Fri, 10 Oct 2025 12:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v7G8O-0002ql-8w; Fri, 10 Oct 2025 12:38:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v7G8E-0001pc-4L; Fri, 10 Oct 2025 12:38:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A9gYWI031146;
 Fri, 10 Oct 2025 16:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7sPDJm
 siV4b7dxgH72UO9PRA0SHd1rKNB7Fm8YquCJE=; b=tpiH4TweZ+vSZ2p77PLq0e
 CSuAdUdw2ZD44d+Ire0Oe0MPLntUeW/66nRHl0Kn/WYKqbysPNCwuuWZ/C64T+ZB
 GOdv7d+w3fhGVhiOWrE4hUhlamo/XIz2sWa95Ux4h/PWIPaVLVtVR+u3sKGpG3Tl
 FC7h6AjuhH5xVJt4GW7IDFAWV4UaFzuZ8YaghHCq0Gr0OLA4RQ4JpN2yITajWzk0
 ofZWag5C66l3678R10o0bmbLJn6TOXgLH3mY0EhzOERMDoR1GSkZ8LWXNA15HLXx
 gtWm/z+Amz8RpuLCCJYoK1mS0PsU7cmm99iax2FlC6Na/EfU2fgVLJ6Tr0OlYR8A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81umv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 16:37:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59AG0CTN022773;
 Fri, 10 Oct 2025 16:37:57 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv8vjrpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 16:37:57 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59AGbu4B27984638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 16:37:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF82458056;
 Fri, 10 Oct 2025 16:37:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E633858052;
 Fri, 10 Oct 2025 16:37:54 +0000 (GMT)
Received: from [9.61.95.157] (unknown [9.61.95.157])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 10 Oct 2025 16:37:54 +0000 (GMT)
Message-ID: <4a05dabf-44cc-43f4-979c-82f6f554cfb5@linux.ibm.com>
Date: Fri, 10 Oct 2025 12:37:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/28] s390x/diag: Implement DIAG 508 subcode 1 for
 signature verification
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-13-zycai@linux.ibm.com>
 <9acf7d52-0dc9-4c07-9d74-758682a5c62e@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <9acf7d52-0dc9-4c07-9d74-758682a5c62e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zbn3ErMHn2dYUA61C0I31oXm9Ps4Do-H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX1+Qr4T7xBISx
 yra9ILxJzJk7gGgCt0k6qCa2bJK9cXxrouN2P55CZRv9yQDkYKENF9J73KMVPl7Von+UbYgZ1m6
 dFdRfi1smi5J3MoEKg5R1VMad8bOqCmDiDyGCXfky5+B2yWaF2yiDmd+MDHnHDaMxfFN/Iwx6yg
 TJn+zjSfsqlXM2oZcIXOc4DVkbNIWT6S+2lBMk8CKYK8JMwgY75UmS3djDU5F89Hx7mQgkJZTRV
 rA9T6z7MUXRszG/j759gr9DXd7za42vdHnwlzLaZbLXA9C0kq8O6b6BT33Kc/I3ATWobiA0ZyVP
 sPq7H5sitYBxVOGCEVm+4JKO3F/WM+ET5XK+on5T9Srvp9t6Jk75qoopgc1J0lrQCSyl5E5hdmY
 i9dN6+QAY57mGHTCnDZCwW+lmG6mnw==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e93666 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=mDV3o1hIAAAA:8 a=VnNF1IyMAAAA:8
 a=q3pf7pJw0Im37hG0fjQA:9 a=QEXdDO2ut3YA:10 a=ZuZp5r4odJYA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Zbn3ErMHn2dYUA61C0I31oXm9Ps4Do-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
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

On 10/7/25 6:27 AM, Thomas Huth wrote:
> On 18/09/2025 01.21, Zhuoying Cai wrote:
>> From: Collin Walling <walling@linux.ibm.com>
>>
>> DIAG 508 subcode 1 performs signature-verification on signed components.
>> A signed component may be a Linux kernel image, or any other signed
>> binary. **Verification of initrd is not supported.**
>>
>> The instruction call expects two item-pairs: an address of a device
>> component, an address of the analogous signature file (in PKCS#7 DER format),
>> and their respective lengths. All of this data should be encapsulated
>> within a Diag508SigVerifBlock.
>>
>> The DIAG handler will read from the provided addresses
>> to retrieve the necessary data, parse the signature file, then
>> perform the signature-verification. Because there is no way to
>> correlate a specific certificate to a component, each certificate
>> in the store is tried until either verification succeeds, or all
>> certs have been exhausted.
>>
>> The subcode value is denoted by setting the second-to-left-most bit of
>> a 2-byte field.
>>
>> A return code of 1 indicates success, and the index and length of the
>> corresponding certificate will be set in the Diag508SigVerifBlock.
>> The following values indicate failure:
>>
>> 	0x0102: certificate not available
>> 	0x0202: component data is invalid
>> 	0x0302: signature is not in PKCS#7 format
>> 	0x0402: signature-verification failed
>> 	0x0502: length of Diag508SigVerifBlock is invalid
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

[...]

>> +
>> +static int handle_diag508_sig_verif(uint64_t addr, size_t svb_size,
>> +                                    S390IPLCertificateStore *qcs)
>> +{
>> +    int rc;
>> +    int verified;
>> +    uint32_t svb_len;
>> +    uint64_t comp_len, comp_addr;
>> +    uint64_t sig_len, sig_addr;
>> +    g_autofree uint8_t *svb_comp = NULL;
>> +    g_autofree uint8_t *svb_sig = NULL;
>> +    g_autofree Diag508SigVerifBlock *svb = NULL;
>> +
>> +    if (!qcs || !qcs->count) {
>> +        return DIAG_508_RC_NO_CERTS;
>> +    }
>> +
>> +    svb = g_new0(Diag508SigVerifBlock, 1);
>> +    cpu_physical_memory_read(addr, svb, svb_size);
>> +
>> +    svb_len = be32_to_cpu(svb->length);
>> +    if (svb_len != svb_size) {
>> +        return DIAG_508_RC_INVAL_LEN;
>> +    }
>> +
>> +    comp_len = be64_to_cpu(svb->comp_len);
>> +    comp_addr = be64_to_cpu(svb->comp_addr);
>> +    sig_len = be64_to_cpu(svb->sig_len);
>> +    sig_addr = be64_to_cpu(svb->sig_addr);
>> +
>> +    if (!comp_len || !comp_addr) {
>> +        return DIAG_508_RC_INVAL_COMP_DATA;
>> +    }
>> +
>> +    if (!sig_len || !sig_addr) {
>> +        return DIAG_508_RC_INVAL_PKCS7_SIG;
>> +    }
> 
> I think there should also be something like an upper limit for comp_len and 
> sign_len here. Otherwise a malicious guest could force QEMU into allocating 
> giga- or terabytes of memory here to cause out-of-memory situations in the host.
> 

Thank you for the suggestion. I agree that setting an upper limit would
help prevent unreasonable memory requests. I think it makes sense to
choose a reasonable value so we don't have to adjust it too often, but
I'm not entirely sure how to determine an appropriate upper bound.

Re: sig_len - the signature length can vary depending on the
cryptographic algorithm, and I don't believe there's a strict limit.
(FYI, in a somewhat similar situation, we haven't enforced a maximum
size on certificate files when loading them into memory, since they're
assumed to be trusted, as Daniel previously suggested -
https://lists.gnu.org/archive/html/qemu-s390x/2025-06/msg00049.html).

If we'd like to set an upper limit for sig_len, the largest signature
I've tested is 1165 bytes, signed with an RSA certificate using an
8192-bit key. Would 4096 be a reasonable upper bound?

Re: comp_len - the size of the guest kernel I'm currently using is
14,184,448 (0xD87000). When I built a kernel with make allyesconfig, the
size can reach 261,005,383 (0xF8EA047). Based on this value, would
262,000,000 (0xF9DCD80) an appropriate upper limit?

>> +    svb_comp = g_malloc0(comp_len);
>> +    cpu_physical_memory_read(comp_addr, svb_comp, comp_len);
>> +
>> +    svb_sig = g_malloc0(sig_len);
>> +    cpu_physical_memory_read(sig_addr, svb_sig, sig_len);
>> +
>> +    rc = DIAG_508_RC_FAIL_VERIF;
>> +    /*
>> +     * It is uncertain which certificate contains
>> +     * the analogous key to verify the signed data
>> +     *
>> +     * Ignore errors from signature format convertion and verification,
>> +     * because currently in the certificate lookup process.
> 
> The second half of above sentence looks incomplete?
> 
>> +     *
>> +     * Any error is treated as a verification failure,
>> +     * and the final result (verified or not) will be reported later.
>> +     */
>> +    for (int i = 0; i < qcs->count; i++) {
>> +        verified = diag_508_verify_sig(qcs->certs[i].raw,
>> +                                       qcs->certs[i].size,
>> +                                       svb_comp, comp_len,
>> +                                       svb_sig, sig_len);
>> +        if (verified == 0) {
>> +            svb->cert_store_index = i;
>> +            svb->cert_len = cpu_to_be64(qcs->certs[i].der_size);
>> +            cpu_physical_memory_write(addr, svb, be32_to_cpu(svb_size));
>> +            rc = DIAG_508_RC_OK;
>> +            break;
>> +       }
>> +    }
>> +
>> +    return rc;
>> +}
> 
>   Thomas
> 


