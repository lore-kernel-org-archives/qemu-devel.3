Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDF2CA5FDD
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCnrG-0005Gv-NW; Fri, 02 Oct 2026 20:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xCnrE-0005Gg-Oy; Fri, 02 Oct 2026 20:44:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xCnrD-0003A8-3A; Fri, 02 Oct 2026 20:44:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69305Zah1903045; Sat, 3 Oct 2026 00:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=shGX5Q
 fCoiEbqwlOkTkhd54ZMeNHHYtyNYU5mgK0dIU=; b=mSS1fwjS0WnXXG+NJjjc2H
 jFBiu4RhgxeL1gBgNP5uNzWJ4KD5k0ciYeLak3iFHAxQNrG0iog1HMKkQQOqlDKj
 cw0eIBnaKRQRLNhuZojgD1GPRtQ1PVmKlpp1tX3sli2UEmJEaezCprMDGxAa5rLO
 Zout4+Ms9wUdEL5Yc/LLTwr2+NIWBRbx42kbaP3Q2/7OUNT7V0kO5DyclzWejV/X
 8n8vKSlagOD8Q5qCYenOHSSeh4+9olIQIkxsjLQFcfjC3uHlPR1l0i9jjLhLC/TD
 6fUPe1TEQhaCHa3RuaZO/Hku9Rv5X07bO7XzaCPd1nbCQx8lWpyRSw5r9HKcGeGA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pttp3a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 03 Oct 2026 00:44:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NlhsP3295910; Sat, 3 Oct 2026 00:44:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa8232q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 03 Oct 2026 00:44:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6930hxqs30474792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 3 Oct 2026 00:43:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 604AB58061;
 Sat,  3 Oct 2026 00:43:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8E3358043;
 Sat,  3 Oct 2026 00:43:58 +0000 (GMT)
Received: from [9.61.252.157] (unknown [9.61.252.157])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  3 Oct 2026 00:43:58 +0000 (GMT)
Message-ID: <606b2a78-52b5-40a7-87cc-3f247985aa51@linux.ibm.com>
Date: Fri, 2 Oct 2026 19:43:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-15-kshk@linux.ibm.com>
 <a58ad322-bfb3-4ca6-a9fd-098391da4f3b@linux.ibm.com>
Content-Language: en-US
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <a58ad322-bfb3-4ca6-a9fd-098391da4f3b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UPJCtF9ZmtkLbHXqhzWkrI6hXTiHRnEb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX140HfvAtC63n
 jskv8IB0UQ9vSxpK2lOoCSdKwdAq61+VsMLg9Nv/8U0ZSYyvry4Mznw/uk3BCDhM0DDnTrPwNdk
 8HMxwTZtNhDlaH85ZZIWbcIvCIqCkZ3wKYsDIf05919h+yx4j9Ltryujzmb8gqXQSS8sk6TzM2R
 2ip/g2aOtjiSTKaRC4x1Tc0nAAeMnX7o1YK22iBCXSxQLQrX5B67Z3FZspXp8efdMI4J+ZDH766
 Ij5kIux3lZmdJM7CAd/ACUkzqp7TmAuU2o1dY47b+WWvkq4uL022Y9PK/ZRXyJUD+RHuU5uLA7H
 FdxctCupKm3KXYrKywYFfeVQUoK7SXdOPylatmG+SNxFHmotqHTLYIf/yhEnTtWms+AZnFIPb3X
 1BN3cMeFae8UoXYHWOZyOg8AgjQ+DUWGqPUJqm2dZ78oFT0wOZWprwcNQtvbSvPKDZUl0jyN3CT
 eBY19E9tTWf2QSCcxMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX/eO1606bCo9o
 sCUlRvD996b0xLb8xHQOwbtAyoW2xYJ29hlsd9ESdhUHPQaBz9WTei8blPW4KFZB+dnDX0l13EW
 vcfH81ofp+FaQXZCoDmZDc1PhOxwdf8=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6ac04fd1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=LcbRUWzvCoihoXa6_BIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: UPJCtF9ZmtkLbHXqhzWkrI6hXTiHRnEb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
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

On 261002 13:28, Matthew Rosato wrote:
> 
>> -static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>> -                    uintptr_t ra)
>> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
>> +                             uint64_t pal, uint64_t g_iota, Error **errp)
>>   {
>> -    uint64_t pba = ldq_be_p(&fib.pba);
>> -    uint64_t pal = ldq_be_p(&fib.pal);
>> -    uint64_t g_iota = ldq_be_p(&fib.iota);
>>       uint8_t dt = (g_iota >> 2) & 0x7;
>>       bool t = s390_pci_is_translation_enabled(g_iota);
>>   
>> -    pba &= ~0xfff;
>> -    pal |= 0xfff;
>>       if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
>> -        s390_program_interrupt(env, PGM_OPERAND, ra);
>> -        return -EINVAL;
>> +        return false;
> 
> This will now violate include/qapi/error.h because you're returning
> false but not setting errp:
> 
>   * - On success, the function should not touch *errp.  On failure, it
>   *   should set a new error, e.g. with error_setg(errp, ...), or
>   *   propagate an existing one, e.g. with error_propagate(errp, ...).
> 
> A simple solution would be to add a new message for this case.

But the original reg_ioat() also didn't print any message in this error 
branch. I had to assume it was intentional, and preserved the behavior.

If you believe a new message should be introduced, I can insert a commit 
for that - what would be the explanation?

> 
> [...]
>> +
>> +static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>> +                    uintptr_t ra)
>> +{
>> +    Error *err = NULL;
>> +    uint64_t pba = ldq_be_p(&fib.pba);
>> +    uint64_t pal = ldq_be_p(&fib.pal);
>> +    uint64_t g_iota = ldq_be_p(&fib.iota);
>> +    bool t = s390_pci_is_translation_enabled(g_iota);
>> +
>> +    pba &= ~0xfff;
>> +    pal |= 0xfff;
>> +
>> +    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, &err)) {
>> +        if (err) {
>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s\n", error_get_pretty(err));
>> +            error_free(err);
>> +        }
> 
> With that change, you won't need the if (err) check anymore.
> 
> Thanks,
> Matt


