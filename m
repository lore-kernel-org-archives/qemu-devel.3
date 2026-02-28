Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4461048925
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 02:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw9sL-0001ff-Su; Fri, 27 Feb 2026 21:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vw9sJ-0001f7-Hs; Fri, 27 Feb 2026 21:16:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1vw9sH-0006V2-LA; Fri, 27 Feb 2026 21:16:11 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61S1jCqU1341057; Sat, 28 Feb 2026 02:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cKe5FI
 T3P0W69/7DuYJL2Ck9xoy6NwdG7K9TdPtBdP8=; b=kLNJZaogQBKokpTHabhrGI
 XonJ+mEQ/5mmNsq7l8ngt6HgJrQPPzfC+yHt66dcCiqLdcw/yJL6JTQsQ3ANqlWX
 z6R+moc2z3nUadMeTaFwgONEymsTYpVXIgyvvAJteFtMYRaXKlWx0oFHSCQRln+C
 wWp3dpzqrfqt9I3Ka1BBA6xB5jWD+smC9veGOMLroRwEzfB/ExwzuSWIyB0h0KUR
 vXLNNgrYZwCFQ6hbxqLvYvaOC2KAAIYRlT75axgKKffvLogZRHHSnTQieoyA5azs
 aRlYwu0IUas2e59GCAHRaq0rD3fR/NEWo/sR1XRNYGHgjcIcW2Sn2Tf3aiDPZv5g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4crf8a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 02:16:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61RLnjYu014012;
 Sat, 28 Feb 2026 02:16:03 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdyn4mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Feb 2026 02:16:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61S2G1qT4588102
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Feb 2026 02:16:01 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C880958055;
 Sat, 28 Feb 2026 02:16:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31C845804B;
 Sat, 28 Feb 2026 02:16:00 +0000 (GMT)
Received: from [9.61.45.42] (unknown [9.61.45.42])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Feb 2026 02:16:00 +0000 (GMT)
Message-ID: <bb2c5a86-4efa-4f65-a12e-b4bc92cf9438@linux.ibm.com>
Date: Fri, 27 Feb 2026 21:15:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/30] s390x/diag: Implement DIAG 320 subcode 1
To: Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-8-zycai@linux.ibm.com>
 <35753e04-2b27-4621-8175-802cd81b1950@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <35753e04-2b27-4621-8175-802cd81b1950@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q63kFRq-JbG2X4LJsi9aE4YGMR3QPiNN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAxOCBTYWx0ZWRfX0YC07CeVgkvj
 5ZttVR8ZPBavRULeg6owYsN7LBsisnHxHBw5aQRiW/1hq82dIotZNWT9DOTobSQ/cFEbuwv3UtG
 hOemSftkj7/7xAeS7QBkVIaWo3bp3g2PdfJPs17sn45oCKNLCWMWk2p+6Trj44hjuA5ybXa7wZM
 bYJt6OvRDXG0kGHlqwEDmK0oxAs+UjoMOgpIrMfnogPXQSiOS168ql05cDGODVeWfSPyEKNpERC
 C+kDnEfrbPEuq4NyBc4EmfJ5zlkGN2bSETlobr2rsZlma+xUpsq6Y3Csm1mISSeDImSRZ1Il6pC
 0D+OLWDNTj364NxcUIL8cIeHk/WX59iuA/LrgcWJ7ENyNejNgd2vq074fO+nM4boTjabmaLS0G4
 XQv44pH8il9f69riivXEJtVd+BnZueTLWR/XebFhJpF9rzDQSAihlfamg7jTtNGgAvnE2Di6VpS
 v2JprCchH8Qr+vJKfsg==
X-Proofpoint-GUID: Q63kFRq-JbG2X4LJsi9aE4YGMR3QPiNN
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69a24fe4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=kcdiRMMwfZbRNOjC4EwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602280018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/27/26 7:58 AM, Thomas Huth wrote:
> On 12/02/2026 21.43, Zhuoying Cai wrote:
>> DIAG 320 subcode 1 provides information needed to determine
>> the amount of storage to store one or more certificates from the
>> certificate store.
>>
>> Upon successful completion, this subcode returns information of the current
>> cert store, such as the number of certificates stored and allowed in the cert
>> store, amount of space may need to be allocate to store a certificate,
>> etc for verification-certificate blocks (VCBs).
>>
>> The subcode value is denoted by setting the left-most bit
>> of an 8-byte field.
>>
>> The verification-certificate-storage-size block (VCSSB) contains
>> the output data when the operation completes successfully. A VCSSB
>> length of 4 indicates that no certificate are available in the cert
>> store.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> ---
> ...
>> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
>> index aa04b699c6..6e4779c699 100644
>> --- a/include/hw/s390x/ipl/diag320.h
>> +++ b/include/hw/s390x/ipl/diag320.h
>> @@ -11,10 +11,32 @@
>>   #define S390X_DIAG320_H
>>   
>>   #define DIAG_320_SUBC_QUERY_ISM     0
>> +#define DIAG_320_SUBC_QUERY_VCSI    1
>>   
>>   #define DIAG_320_RC_OK              0x0001
>>   #define DIAG_320_RC_NOT_SUPPORTED   0x0102
>> +#define DIAG_320_RC_INVAL_VCSSB_LEN 0x0202
>>   
>>   #define DIAG_320_ISM_QUERY_SUBCODES 0x80000000
>> +#define DIAG_320_ISM_QUERY_VCSI     0x40000000
>> +
>> +#define VCSSB_NO_VC     4
>> +#define VCSSB_MIN_LEN   128
>> +#define VCE_HEADER_LEN  128
>> +#define VCB_HEADER_LEN  64
>> +
>> +struct VCStorageSizeBlock {
>> +    uint32_t length;
>> +    uint8_t reserved0[3];
>> +    uint8_t version;
>> +    uint32_t reserved1[6];
>> +    uint16_t total_vc_ct;
>> +    uint16_t max_vc_ct;
>> +    uint32_t reserved3[11];
>> +    uint32_t max_single_vcb_len;
>> +    uint32_t total_vcb_len;
>> +    uint32_t reserved4[10];
>> +};
>> +typedef struct VCStorageSizeBlock VCStorageSizeBlock;
> 
> Since this API between QEMU and the guest, maybe add a
> 
> QEMU_BUILD_BUG_ON(sizeof(VCStorageSizeBlock) != ...);
> 
> here to make sure that there is no accidential padding.
> (should not happen since field are naturally aligned, but better be safe 
> than sorry?)
> 

Please correct me if I’m wrong. QEMU_BUILD_BUG_ON() is a QEMU-specific
macro and is not accessible from the guest, so using it here would cause
a compile error. I’m not aware of similar checks being used on the guest
side. Would QEMU_BUILD_BUG_ON() still be appropriate in this case, or is
there a better way to ensure that no unintended padding is introduced?

>>   #endif
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index e867fc2156..3c7e64eb05 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -197,11 +197,54 @@ out:
>>       }
>>   }
>>   
>> +static int handle_diag320_query_vcsi(S390CPU *cpu, uint64_t addr, uint64_t r1,
>> +                                     uintptr_t ra, S390IPLCertificateStore *cs)
>> +{
>> +    g_autofree VCStorageSizeBlock *vcssb = NULL;
>> +
>> +    vcssb = g_new0(VCStorageSizeBlock, 1);
>> +    if (s390_cpu_virt_mem_read(cpu, addr, r1, vcssb, sizeof(*vcssb))) {
>> +        s390_cpu_virt_mem_handle_exc(cpu, ra);
>> +        return -1;
>> +    }
>> +
>> +    if (be32_to_cpu(vcssb->length) > sizeof(*vcssb)) {
>> +        return -1;
>> +    }
> 
> Thanks for adding the check, but I think this should rather be :
> 
>          return DIAG_320_RC_INVAL_VCSSB_LEN;
> 
> since we did not inject an exception in this case?
> 
>> +    if (be32_to_cpu(vcssb->length) < VCSSB_MIN_LEN) {
>> +        return DIAG_320_RC_INVAL_VCSSB_LEN;
>> +    }
> 
> ...
> 
>> +    case DIAG_320_SUBC_QUERY_VCSI:
>> +        if (!diag_parm_addr_valid(addr, sizeof(VCStorageSizeBlock), true)) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        if (addr & 0x7) {
>> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
>> +            return;
>> +        }
>> +
>> +        rc = handle_diag320_query_vcsi(cpu, addr, r1, ra, cs);
>> +        if (rc == -1) {
>> +            return;
> 
> ... otherwise the error will be ignored silently here and the guest will 
> think that the call succeeded.
> 
> Maybe you could also create some kvm-unit-tests for this new diag call that 
> exercises these error scenarios, then you'll easily see whether the diag 
> behaves as expected.
> 
>   Thanks,
>    Thomas
> 
> 

Thanks for the suggestion. I’ll fix the return code and look into adding
kvm‑unit‑tests for this new diag call.

>> +        }
>> +        env->regs[r1 + 1] = rc;
>> +        break;
>>       default:
>>           env->regs[r1 + 1] = DIAG_320_RC_NOT_SUPPORTED;
>>           break;
> 


