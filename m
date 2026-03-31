Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDB2109B491
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7b9Q-0007jE-FG; Tue, 31 Mar 2026 11:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w7b94-0007KI-On; Tue, 31 Mar 2026 11:36:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1w7b8y-0006xU-PH; Tue, 31 Mar 2026 11:36:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VE0AQ62608700; Tue, 31 Mar 2026 15:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=e1I+76
 /99W/aawjCntd1SQKWywJPn/7dtnRE+KKVpHo=; b=b6t8WcdAKxi1gX4vhpe6pp
 zqSYhgIeaIJtHdNyS2eP0kzuh7K/c4hhh6MWP3DWnvdwT3331jTU5C9Q/8mhGY+S
 8d+vWOurOLb5PWmVhXnyxO36nICeIi3Hc1KOrB1VL4PJMcp3WMsn4ofdNMHd6vTA
 LDe+BhpMJ6GPZQfTnhb84PxFw9Jlkrl3K5ROx2fpWEKcgKVTB1HC6ExvB0w+JQ6b
 11mbNsjnZcB7NsK13q6octp2PtMndEYpL3XSuax97K1RbMIaoMKz395x3HBEXSU8
 /dEUxpPrMDvijV3ZS4ODFLEN3aTNwTj/prSyKytIHswm26dmTmQY8FY3MUCJEcPg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1v447-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 15:36:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VCU5MU030990;
 Tue, 31 Mar 2026 15:36:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjsjek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Mar 2026 15:36:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62VFaULg22544920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Mar 2026 15:36:31 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B073E58050;
 Tue, 31 Mar 2026 15:36:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA25758045;
 Tue, 31 Mar 2026 15:36:28 +0000 (GMT)
Received: from [9.12.68.85] (unknown [9.12.68.85])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 31 Mar 2026 15:36:28 +0000 (GMT)
Message-ID: <1a166486-d6e8-4197-9df9-db5708e4d316@linux.ibm.com>
Date: Tue, 31 Mar 2026 11:36:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/30] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pierrick.bouvier@linaro.org,
 david@kernel.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 jdaley@linux.ibm.com
References: <20260305224146.664053-1-zycai@linux.ibm.com>
 <20260305224146.664053-20-zycai@linux.ibm.com>
 <c062e73a-660d-4c92-9c84-937cb10d944d@linux.ibm.com>
 <ef08f0ad-b516-4713-b7b0-c3a37772090d@linux.ibm.com>
Content-Language: en-US
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <ef08f0ad-b516-4713-b7b0-c3a37772090d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cbea00 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=iG4b76s7l3w_BbMgGokA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lVJsJlieHVL4tL6DIcWW1b9kE3OVZXPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0OCBTYWx0ZWRfXz6+q5EiXpJm0
 v05o0AU6yx2cvvJZTeJf3ywJFTMey5/+Rv8+v/SicAULYuTMSqwA0tQxSGDYr/90J28t/UWPTxL
 yeKOpaUkUxflCO05v0KQbFQLovDESWdK0Xco8865KNMGyTNkz1zagZf6y0MjPOyHx8lSYL/mpuW
 /AwKBJljN2JOdwejIPZ01KXJO+WYlBPy7g47GmYRWl2voODY1OqYI6zTnTRotndVZptzNgmVIVW
 lHmG6mtHM5TcB96EPe68eBuxgjUFqGzylkRY1T9EOxTte5RNM59xpWVGHgCU9sNGBTkWtazr7zx
 59re7VaMqYmKTi/o1xNkr6nwwadIxVciuOODwdNFI2mdL3hoNWUrNPNSFZ90IU0KTSFkLUtOEJs
 JgBYzpNYFnBHpRX0h9vk+5A1wns0//rQduxU9/wvAFEyTDQW6r0W281WjTbQsmFNCgsw4YSf785
 w1Z7Y9L8HJ3GnsZAwOA==
X-Proofpoint-GUID: lVJsJlieHVL4tL6DIcWW1b9kE3OVZXPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310148
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

On 3/25/26 15:11, Zhuoying Cai wrote:
> On 3/16/26 11:41 PM, Collin Walling wrote:
>> On 3/5/26 17:41, Zhuoying Cai wrote:
>>> Enable secure IPL in audit mode, which performs signature verification,
>>> but any error does not terminate the boot process. Only warnings will be
>>> logged to the console instead.
>>>
>>> Add a comp_len variable to store the length of a segment in
>>> zipl_load_segment. comp_len variable is necessary to store the
>>> calculated segment length and is used during signature verification.
>>> Return the length on success, or a negative return code on failure.
>>>
>>> Secure IPL in audit mode requires at least one certificate provided in
>>> the key store along with necessary facilities (Secure IPL Facility,
>>> Certificate Store Facility and secure IPL extension support).
>>>
>>> Note: Secure IPL in audit mode is implemented for the SCSI scheme of
>>> virtio-blk/virtio-scsi devices.
>>>
>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>> ---
>>>  docs/system/s390x/secure-ipl.rst |  35 +++
>>>  pc-bios/s390-ccw/Makefile        |   3 +-
>>>  pc-bios/s390-ccw/bootmap.c       |  36 +++-
>>>  pc-bios/s390-ccw/bootmap.h       |  11 +
>>>  pc-bios/s390-ccw/main.c          |   6 +
>>>  pc-bios/s390-ccw/s390-ccw.h      |  27 +++
>>>  pc-bios/s390-ccw/sclp.c          |  38 ++++
>>>  pc-bios/s390-ccw/sclp.h          |   6 +
>>>  pc-bios/s390-ccw/secure-ipl.c    | 357 +++++++++++++++++++++++++++++++
>>>  pc-bios/s390-ccw/secure-ipl.h    | 102 +++++++++
>>>  10 files changed, 618 insertions(+), 3 deletions(-)
>>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.c
>>>  create mode 100644 pc-bios/s390-ccw/secure-ipl.h
>>>
> 
> [...]
> 

[...]

>>> +
>>> +            if (verified) {
>>> +                if (cert_list_table[cert_table_idx] == -1) {
>>> +                    if (!request_certificate(cert_addr, cert_table_idx)) {
>>> +                        puts("Could not get certificate");
>>> +                        goto out;
>>> +                    }
>>> +
>>> +                    cert_list_table[cert_table_idx] = cert_entry_idx;
>>> +                    cert_list_add(&cert_list, cert_entry_idx, cert_addr, cert_len);
>>
>> ...then the malloc'd cert is added to the cert list (and this list later
>> gets appended to the IIRB).
>>
>> Once IPL starts, the data at this address will eventually be
>> lost/overwritten. The certificate address needs to point to either:
>>  - somewhere on the disk
>>  - some dedicated memory space (likely designated by QEMU)
>>
>> Though that begs the question: who/what makes use of the IIRB?  It seems
>> this information gets lost?
>>
> 
> Thanks for raising the concern. I looked into this further.
> 
> The IIRB is actively consumed by the kernel, and its contents are
> preserved until they are explicitly copied.
> 
> It is used for:
> * Boot logging: log_component_list() reports what was loaded and verified.
> * kexec operations: kexec_file_add_ipl_report() builds the next kernel’s
> IPL report from the existing one.
> * Keying: load_ipl_certs() installs IPL certificates into the platform
> trusted keyring.
> 
> In addition, the IPL report block data is not lost during boot (see
> arch/s390/boot/ipl_report.c).
> 
> Early during boot, read_ipl_report() reserves the entire IPL report
> memory region, including the IPL parameter block and the IPL report
> itself. Certificate entries reference the actual certificate data via
> physical addresses, and all subsequent physical memory allocations are
> checked for overlap using ipl_report_certs_intersects(). This ensures
> that no allocation can overwrite certificate data before it is saved.
> 
> Later, save_ipl_cert_comp_list() allocates permanent storage and copies
> the actual certificate data. As a result, the IIRB data is both used and
> protected throughout early boot and is not lost.
> 
> I also verified, from both the BIOS and the guest kernel, that the
> certificate addresses, lengths, and contents are correctly preserved.
> For example:
> 
> BIOS debug log:
> cert_entries = {{addr = 0x3fd6e98c, len = 0x3e7},
>                 {addr = 0x3fd6ed73, len = 0x3e7}, ...}
> 
> Guest kernel debug log:
> [    0.060583] boot: copy_certificates_bootdata()
> [    0.060584] boot: Certificate data at 0x3fd6e98c (len=0x3e7):
> ...
> [    0.060588] boot: Certificate data at 0x3fd6ed73 (len=0x3e7):
> ...
> 

Thanks for thoroughly looking into this.  I've added a comment to patch
13 to add to the IIRB documentation.

[...]

-- 
Regards,
  Collin

