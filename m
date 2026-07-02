Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60A9C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJJK-0006Xb-KN; Thu, 02 Jul 2026 11:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfJJJ-0006Wo-1D; Thu, 02 Jul 2026 11:26:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wfJJD-0004py-GK; Thu, 02 Jul 2026 11:26:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EIG704014003; Thu, 2 Jul 2026 15:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AsOZH5
 Pi1FfsbkS93g7L2g/g51ub5tMvr+38ZPBLXFE=; b=lA+c5BJdVIPDGM4bi8Crab
 F4pjeKCesXuakOmEBNARu33FQ6EbN7b5kmW9+lTIXxqrsmrmI2WbFkAiE8CyReQA
 Ipoz/2Z5NTKnBpFS6466wZqlv38K4xEqUcp77zxqhbZ5HzdRd6PNOkgR3WtlML+i
 XCqDsJBqPBsPPg57NMmyibEVG8ZUHUI6RuAUIzksYRotvHOP9Tq8lYmDe6vqXrrp
 s+T3E+2nOSVvbf4q7YVLLPC5Vd7rD99gLWb2ar/zlDFo/YHxoEVTpQWg4yzUX+je
 FDBnRzT9Ht0D6Exr2sF2b6BffmTSKvBDI4A6EVxWavvjs3jqEMeyVkd2xUYHin6Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rfa5gg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 15:26:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJggl011168;
 Thu, 2 Jul 2026 15:26:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wcnwg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 15:26:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662FQSav25559704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 15:26:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9982958062;
 Thu,  2 Jul 2026 15:26:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFFA058052;
 Thu,  2 Jul 2026 15:26:26 +0000 (GMT)
Received: from [9.61.151.121] (unknown [9.61.151.121])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 15:26:26 +0000 (GMT)
Message-ID: <8c406a31-8c43-4d6a-a729-d3568b515fce@linux.ibm.com>
Date: Thu, 2 Jul 2026 11:26:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 23/35] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Jared Rossi <jrossi@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-24-zycai@linux.ibm.com>
 <d8fb862c-1e18-4989-b16f-4fb33330e5d1@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <d8fb862c-1e18-4989-b16f-4fb33330e5d1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a468326 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=-LUQR4hlprS3t3Nb9HsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mHzrBV5z6c3wRgAsIBeq4-XZT3M6Zggf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX0eRHcxMfNYVU
 yx2g5OuGc99trkcqce9wpVT1iC6PyAVzcaPV3BW0U0wMo8I7jziQOgYodomfPGUetc/6eFB6Eih
 f78uWhZmMj1fjfaNdC+tN0efsPxsbEviStthcsSFAfN/xNOgGYWf5AQYD99x1xYytp8sC2uvrOS
 RhB1XbiLWiPJVwQUbFahS2CglG9fxWdbDbQSt1MWBZZcyzsNA8yxgaUrkhSyekBW60ybTP9jWE1
 fjEdHj/4c1U94hAbmhN6KYiHdxaQObNyOPebCRyR7crdRfXrNbfDrMiGcSiml0rFjU1WPSrFRyk
 5JGmQchWsU3FSzm67ZuqdH68AkPjLYSJc233CX//L6bHqv96g2frex+Z0QS14Zxs+J9m1jZcNun
 fywjMJJYgioQ49/kbkoCQGUf0K93CMWSfVVzSGXoN3ff8BSBRGWg9XEvXQKxWzqxLJK2J50nXVi
 AJGExuqo3Waj14wsgxA==
X-Proofpoint-GUID: mHzrBV5z6c3wRgAsIBeq4-XZT3M6Zggf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX/41EMl6buLeW
 Wj6IKtPK13aXEXCTnNHTUUfprPOj5aExoZZGNk38t1xNeYQtDlFUppF8OF26nO9glaqLOXni2jZ
 3Ef8IKZsCGe8iLMaosWPJnE5WdjPfwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Thanks for the feedback!

On 7/2/26 10:13 AM, Jared Rossi wrote:
> 
> 
> On 7/1/26 4:49 PM, Zhuoying Cai wrote:
>> Enable secure IPL in audit mode, which performs signature verification,
>> but any error does not terminate the boot process. Only warnings will be
>> logged to the console instead.
>>
>> Secure IPL in audit mode requires at least one certificate provided in
>> the key store along with necessary facilities (Secure IPL Facility,
>> Certificate Store Facility and secure IPL extension support).
>>
>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>> virtio-blk/virtio-scsi devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   docs/system/s390x/secure-ipl.rst |  15 ++
>>   pc-bios/s390-ccw/Makefile        |   2 +-
>>   pc-bios/s390-ccw/bootmap.c       |  27 +++
>>   pc-bios/s390-ccw/bootmap.h       |   9 +
>>   pc-bios/s390-ccw/jump2ipl.c      |   7 +
>>   pc-bios/s390-ccw/main.c          |  18 +-
>>   pc-bios/s390-ccw/s390-ccw.h      |  20 ++
>>   pc-bios/s390-ccw/sclp.c          |  27 +++
>>   pc-bios/s390-ccw/sclp.h          |   6 +
>>   pc-bios/s390-ccw/secure-ipl.c    | 362 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/secure-ipl.h    | 116 ++++++++++
>>   11 files changed, 607 insertions(+), 2 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>   create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>
> [...]
>> +
>> +void update_cert_list(IplSignatureCertificateList *cert_list)
>> +{
>> +    IplSignatureCertificateEntry *cert_entry;
>> +    uint8_t *cert_buf;
>> +
>> +    cert_buf = (uint8_t *)qipl.ipl_data;
>> +
>> +    for_each_rb_entry(cert_entry, cert_list) {
>> +        memcpy(cert_buf, (uint8_t *)cert_entry->addr, cert_entry->len);
>> +        cert_entry->addr = (uint64_t)cert_buf;
>> +        cert_buf += cert_entry->len;
>> +    }
>> +}
> 
> This looks like the correct idea but I think it needs additional 
> validation.  Firstly, as Eric mentioned, there is no check that the size 
> of our cert entries don't exceed the qipl.ipl_data space.  I know there 
> are implicit factors such as maximum certificate size and such that 
> limit it in a way that it shouldn't be possible, but we should still check.
> 

At the beginning of zipl_run_secure(), I added a check to ensure that
there is enough space to store the certificates required for the current
IPL. We store the certificates directly in the qipl.ipl_data area rather
than storing cert entries (IplSignatureCertificateEntry) in qipl.ipl_data.

As discussed previously and documented here
(<https://www.ibm.com/docs/en/linux-on-systems?topic=keys-required-signatures>),
an IPL requires at most two, and possibly three, signed components,
meaning that at most three certificates are needed. Based on that, I
check that MAX_SIGNED_COMP * CERT_BUF_MAX_LEN does not exceed
CERT_BUF_SIZE, ensuring there is sufficient space for the certificates
used by the current IPL. Please let me know if you think any additional
validation is needed.

> Secondly and more critically, you need to reset the qipl.ipl_data 
> address to it's initial value before reusing it.  I don't think I saw 
> that done anywhere.  The address is incremented after each IPLB is 
> loaded from the chain (see the load_next_iplb() function in iplb.h), so 
> if we in theory had started with 7 IPLBs in the chain and loaded all of 
> them, and if we then copied the maximum allowed size of certificate 
> entry data, we would exceed the qipl.ipl_data upper limit and probably 
> clobber the kernel.
> 
> I think the easiest way to restore the qipl.ipl_data address to its 
> initial value is to track how many IPLBs we've used, multiply that by 
> the size of the IPLB, and then move the address back by that amount.
> 

Thanks for pointing this out. I missed resetting the qipl.ipl_data
address before reusing it. I'll restore it to its initial value before
copying the certificate data. Thanks!

> Regards,
> Jared Rossi


