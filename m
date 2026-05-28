Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC84ACD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSb1M-0005yh-Th; Thu, 28 May 2026 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wSb1H-0005yH-RJ; Thu, 28 May 2026 09:43:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wSb1E-00010n-MD; Thu, 28 May 2026 09:43:31 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SCbTWE3782443; Thu, 28 May 2026 13:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qZSksn
 cUJR1Ea3dBBzGWpIeJwDLIKr5DS9KVeElNYEY=; b=IVXVFp2E9PpL3Kcvdlbojr
 9VPgg+M7+8M7aejchlbjdk9OQmoYUAnCeYLJBt/n3em3r+lsaXCHjSR2m17r80ov
 4Kf6YqFXVQlknuigUvzrNrJmfxY6sGcMRfgTPB/6zlDeE+dhUmOG0wzDbAyAkCHj
 qaaz35e+at7DcLTO1Fz/P6ZwX8Iwt3CWTMJjxl9Z/O1NTUzEa4wbZsnk+QuHSeOp
 X7SCUH8tLdvE5YqqCLhn9vBPErbTNm6nWnMBZKrnYdIW+9hJLV40ihdPaN5skdRv
 69dknXZYgV/rI06tcyDFiptJFhzSB+RxHTfiTpxYgeXHQ2jA99mwFD1JKr9JzNOw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889b3e2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 13:43:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SDgZ7x018156;
 Thu, 28 May 2026 13:43:21 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8aps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 May 2026 13:43:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64SDhJmn32047760
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 May 2026 13:43:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 496435805A;
 Thu, 28 May 2026 13:43:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 012355805C;
 Thu, 28 May 2026 13:43:18 +0000 (GMT)
Received: from [9.61.124.159] (unknown [9.61.124.159])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 28 May 2026 13:43:17 +0000 (GMT)
Message-ID: <acd41367-f2e8-4eb1-b691-b2182e24048d@linux.ibm.com>
Date: Thu, 28 May 2026 09:43:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 21/32] pc-bios/s390-ccw: Add signature verification
 for secure IPL in audit mode
To: Collin Walling <walling@linux.ibm.com>, Zhuoying Cai
 <zycai@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260505201905.997996-1-zycai@linux.ibm.com>
 <20260505201905.997996-22-zycai@linux.ibm.com>
 <376f419f-764f-48f7-9867-0706ba3f7e62@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <376f419f-764f-48f7-9867-0706ba3f7e62@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ndukPnJ32tEwEqrAz8LnZPRkNw50fk1V
X-Proofpoint-GUID: ndukPnJ32tEwEqrAz8LnZPRkNw50fk1V
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a18467a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NcyW7tLHtu_TpS7YUIQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzOCBTYWx0ZWRfX1rHnfHHHQqyk
 7l21vh3p4fHWy9otEgZhIN8YMunsbRLx4RZ+1BNvha1nIppm5z1s+loAsk/215W9wG48zwsTurU
 fPa6k3r3yEy60tovlbdxaQbvsWss61Y+KG3w5nCxbjwV9LKgdzCmUzU50wt49Jfqb/sjeVZaxdn
 2mORvuUsz5mVnIONyBPl5XH3jKbj/rBaiBAiNnDGADbJueL6bJw84lo2Dsc8EBvwM3C1AJdjtdX
 ziRJWxQ07iBcIvhuMBQ3ZXh9kqAGYE0nVTreayzZ31ShgTjrwflPx0GqvYL5lpqcxm9NPYoDL9Z
 n+4kzPGkTUDRnZyBE1GGJhtOklAwY0uR2q6X8LKw1c4+217sPgNC2ePjxFRItQlfVwhxi3sHe8t
 LshSV+ILtm2SZo5+ciSKfENnNTThLeUoK+iOimxz9yXNebWAeeYtH1Ubr4yhUG0uI41ESR+snMm
 ojPYs9EMSImBtWNK94A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 5/27/26 7:05 PM, Collin Walling wrote:
> On 5/5/26 16:18, Zhuoying Cai wrote:
>> +        } vce;
>> +    } __attribute__((__aligned__(4096))) vcb = { 0 };
>> +
>> +    /* Get Verification Certificate Storage Size block with DIAG320 subcode 1 */
>> +    if (zipl_secure_get_vcssb() == NULL) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Request single entry
>> +     * Fill input fields of single-entry VCB
>> +     *
>> +     * First and last index must be equal because only one
>> +     * VCE per VCB is currently supported
>> +     */
> The last sentence is misleading because it seems like the DIAG 320
> implementation *only* allows for a single VCE to be retrieved, but in
> reality it allows for a range of entries to be retrieved.
Yes, but no.  DIAG320 can, potentially, accept a range of indices and 
return a
remaining verification certificate count (RVCC) if there is not enough 
memory to
store the entire range in one VCB, however the implementation here does not
provide any logic to handle a non-zero RVCC.  As such, only one VCE is 
supported
per VCB in the current implementation.  Either additional logic needs to be
added to support non-zero RVCC or we need this comment to note that only one
VCE per VCB is, currently, supported.

>
>> +    vcb.vcb_hdr.in_len = ROUND_UP(vcssb.max_single_vcb_len, PAGE_SIZE);
>> +    vcb.vcb_hdr.first_vc_index = index;
>> +    vcb.vcb_hdr.last_vc_index = index;
>> +
>> +    if (_diag320(&vcb, DIAG_320_SUBC_STORE_VC) != DIAG_320_RC_OK) {
>> +        return 0;
> Maybe move the puts("Could not get certificate"); to here so it's
> consistent with the other error cases?
>
>> +    }
>> +
>> +    if (vcb.vcb_hdr.out_len == sizeof(VCBlockHeader)) {
>> +        puts("No certificate entry");
>> +        return 0;
>> +    }
>> +
>> +    if (vcb.vcb_hdr.remain_ct != 0) {
>> +        panic("Not enough memory to store all requested certificates");
> Shouldn't this be "to store requested certificate" since this function
> aims to request only one cert?
>
> Also, is there a reason for the panic? Why not just puts and return 0
> like the rest? The program will still terminate, but a little more
> gracefully that way.
I agree that the message itself could be more clear, but the reason this 
is a
panic is because it only triggers if the requested certificate is larger 
than
the MAX_CERT_SIZE, which should never happen at this point (it would be 
caught
earlier in the process when building the cert store I think). There should
always be enough memory to hold at least one certificate, and only one
certificate should ever be requested (due to the restriction above), so, if
DIAG320 returns a non-zero RVCC it would indicate some sort of corruption in
the cert store, which in my opinion should trigger an immediate panic.

Regards,
Jared Rossi

