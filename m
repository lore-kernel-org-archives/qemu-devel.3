Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3D4107BCE2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 21:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w19iI-0007cv-34; Fri, 13 Mar 2026 17:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w19iD-0007cb-0Y
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 17:06:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w19iA-0000qQ-4r
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 17:06:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DIdGSB2307239; Fri, 13 Mar 2026 21:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NCo1k/
 y+6FD/AZk6AZMeUEX2lrJ0h1LUMtXyKsxKT1A=; b=Gtp29rq8uEKlUJvFrpRHW5
 c5KGjZYK1qJSyCGx2Ffm0Fm0k86k1OdFxZteksLn+nTz8dUIe0Ir4S3BYW0+DfVK
 oQSZa5VD2MkzKgLJtD7SGDuuVVHO/KL61FZjrNi4G0BO8CkQqUFIwNR+tiE6Fuv2
 kzEtQC7qyhDMwVru5/2XTqMxqRnGKIemELtSsR5VPnM5lp2kjrjjW0g/sOg82omi
 uPfswS+d7VPDKNUYNzqPDv4o8UMxRc+2EEs/2sJ2oN1Tyx8Zh9vQttHViOPm/ORc
 4Uxbl/WeJkoimqKBHpKs58DzpTHe08fT4g/C4U53ccl7fm2ZF2Pw1qKvjiVfBZrA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96hepp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 21:06:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJXpO7025681;
 Fri, 13 Mar 2026 21:06:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha8ga9u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 21:06:19 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DL6Ier26935958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 21:06:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A45255804E;
 Fri, 13 Mar 2026 21:06:18 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CB015803F;
 Fri, 13 Mar 2026 21:06:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 21:06:17 +0000 (GMT)
Message-ID: <7f46fd67-c5c0-43ab-9872-f9b83b47cdca@linux.ibm.com>
Date: Fri, 13 Mar 2026 17:06:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] hw/tpm: CRB chunking capability to handle PQC
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
 <c4ccc082-2c52-4698-9538-cbf4fffa9318@linux.ibm.com>
 <abRnHkaXQT-o8y3d@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <abRnHkaXQT-o8y3d@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE2OCBTYWx0ZWRfX8oyEJLbBBRdz
 Pv54T9nUnvLA5nWTKkPJhoyaY4BsD5qSD4ovlWr81pxzl5mI6TdYrHLgOVLWLx8KwnkwD1e8ldE
 XbyeaveJ94nCWclvS8axDYmHDpD90a/ZPbvcC3dbaprUHnshryIMBdynD6I2D+jVcYyFH1VDQcZ
 PT4FrvBNXrgXM+ByMToA+nGRBLWfBzSbf391caEPWP5k4dWu8W+B9Z0ejUKaf1tUpJbDFLI94gD
 EJLs7gpvTH1PZKTmsvqWNuBeSZbe2TzSr4xm0OAVe8HQzjpbCCLNvIcByu/f/nr92/eYshRmrn0
 WeztUOvEkC0FiiwZS9ST0rHWJO3eFAfejFpnSphyo7mWXBtw/NmtIDw3Wte3YsAkDHZ12sUrsFS
 OR306g8mejPmPPbRl6FkArMmtUWgS5pzVsgep7bkwMUofd1htCeAmdaCQlKUHyO49I+T+VNNLX2
 X6xvt7yUCjxiuXQ8Sdg==
X-Proofpoint-ORIG-GUID: F7A-aaSsIunogckk4obSnAHsc7Wo9jVc
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b47c4c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=xt6ew7UTAAAA:8 a=aM7tdThuUdoggR3dhAMA:9 a=QEXdDO2ut3YA:10
 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-GUID: F7A-aaSsIunogckk4obSnAHsc7Wo9jVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_04,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130168
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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



On 3/13/26 3:35 PM, Arun Menon wrote:
> Hi Stefan,
> Thank you for taking a look into this.
> 
> On Thu, Mar 12, 2026 at 10:36:29AM -0400, Stefan Berger wrote:
>>
>>
>> On 3/12/26 12:16 AM, Arun Menon wrote:
>>> The move to Post Quantum Cryptography (PQC) changes how we manage
>>> memory buffers. Unlike classic crypto algorithms like RSA or ECC which
>>> used small keys and signatures, PQC algorithms require larger buffers.
>>>
>>> The new version of TCG TPM v185 (currently under review [1]) supports
>>> sending data/commands in chunks for the CRB (Command Response Buffer)
>>> interface. This is in line with the initiative to support PQC algorithms.
>>>
>>> This series implements the logic to send and receive data from the
>>> linux guest to the TPM backend in chunks, thereby allowing the
>>> guest to send larger data buffers. We introduce 2 new control registers
>>> called nextChunk and crbRspRetry that will control the START. We also
>>> add the CRB Interface Identifier called CapCRBChunk that is set to 1
>>> indicating that the device supports chunking. The default maximum
>>> chunk/buffer size is 3968 (4096 - 128) bytes.
>>>
>>> During a send operation, the guest driver places data in the CRB buffer
>>> and signals nextChunk for each segment until the final chunk is reached.
>>> Upon receiving the START signal, QEMU appends the final chunk to its
>>> internal buffer and dispatches the complete command to the TPM backend.
>>>
>>> For responses, the backend's output is buffered. The guest consumes the
>>> first chunk once the START bit is cleared. Subsequent chunks are
>>> retrieved by the guest toggling the nextChunk bit, which advances the
>>> internal buffer offset and populates the CRB data window.
>>>
>>> For this to work, the linux guest tpm driver will also have to
>>> a) probe if CRB chunking is supported
>>> b) send data in chunks if the command length exceeds the chunk size.
>>> c) receive data in chunks by sending a nextChunk signal and accumulate.
>>>> At present, VM live migration during a tpm command execution in chunks
>>> is not supported. We intend to add support for TIS interface in
>>
>> .. and also VM suspend/resume. Do you intend to support these? The problem
>> will be state incompatibility with previous QEMU versions then since we now
>> need to save the additional (bytes in the new) byte buffer(s) and possibly
>> the new control registers' contents.
> 
> Yes I would like to support suspend/resume along with migration.
> And yes, I will start by saving those buffer information in the VMstate
> subsection.

If we bump up the version from state v0 to v1, can v0 capable devices 
still read the state and discard data that are for v1?

I am not sure whether the following is possible - the is maintaining 
backwards compatibility as much as possible:
- if the CRB OS driver never touched the chunking during the 
transaction, write v0 state
- if the CRB OS driver touched the chunking feature during the 
transaction, write v1 state

I was looking whether we can still use qemu_put_byte() etc. but was 
missing the .save interface from DeviceClass for example.

> 
> Also, I am working on the linux driver part. The logic is more
> or less the same; 2 buffers, accumulating data, and send/receive based
> on the new register bit.
> 
>>
>> Thanks for also thinking of the TIS support. I guess we will have the same
>> issue there then with state incompatibilities even though with the TIS it
>> should just be a matter of just using a bigger buffer. Theoretically we
>> could write a 4096 byte buffer to the state if up to 4kb are held there and
>> switch to a .version_id = 1 state for bigger buffer size, but then we could
>> migrate to an older version of QEMU and find that it cannot do PQC
>> transactions (anymore) due to older version of TIS there (I guess migration
>> between major versions of QEMU is supported with all kinds of machines).
>> Also, nothing will prevent one from running a PQC-enabled swtpm+libtpms with
>> an older version of QEMU but one will find out if transactions don't succeed
>> (assuming Linux TPM driver can handle it) because the QEMU TIS buffer is too
>> small.
> 
> Yes the same issue will come with TIS. Although changing the buffer size
> TPM_TIS_BUFFER_MAX to 8192 (for now) would be a one liner change, but
> handling the state, for migration and other cases will be tricky like
> you mentioned for both crb and tis. If I understand correctly,
> We need to know whether
>      a) swtpm OR the TPM backend supports chunking

I am collecting these buffer-related issue here considering combinations 
of different versions of libtpms, swtpm, and QEMU (not considering Linux 
driver). The table is probably the best for now to see the problematic 
combinations on the lower layers:

https://github.com/stefanberger/swtpm/issues/1076

>      b) does the underlying machine type of qemu suport chunking.
> 
> I am not sure if swtpm can set a capability bit if chunking is
> supported. If we can do that, then QEMU can probe the backend and get

swtpm (v0.11 and via backport also v0.10.x) will simply work with a 8kb 
buffer once libtpms (v0.11) tells it that it can support up to 8 kb buffers.

> that information. But that will not be sufficient. To decide whether
> chunking is actually allowed based on the underlying machine type we
> might have to add a prop bool for the specific machine type.
> 

Are you referring the CRB capability bit that advertises the chunking 
capability? I think a good sign that chunking should be supported by CRB 
(set the chunking-supported bit CapCRBChunk) is that the buffer queried 
for from swtpm indicates > 4kb (s->be_buffer_size = 
tpm_backend_get_buffer_size(s->tpmbe) ). If the buffer size is still 4kb 
it probably should not advertise the chunking capability -- hadn't 
thought of this while reviewing the patches, but ... you may want to add 
this in the code.

> If both of them (a and b) are true, only the linux probing will return
> true for chunking. Thus linux will not send the huge buffers in the
> first place, or even try to copy data in the subsections during
> migration with the .needed function.
> 
> Please correct me if I am wrong.

I am not sure about all the details yet, either.

> 
> 
>>
>>> the future.
>>>
>>> The included test demonstrates functional correctness for standard
>>> buffer sizes. However, validation of PQC-sized payloads was performed
>>> via manual buffer-size overrides.
>>>> [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
>>>
>>> Arun Menon (5):
>>>     hw/tpm: Add TPM CRB chunking fields
>>>     hw/tpm: Refactor CRB_CTRL_START register access
>>>     hw/tpm: Add internal buffer state for chunking
>>>     hw/tpm: Implement TPM CRB chunking logic
>>>     test/qtest: Add test for tpm crb chunking
>>>
>>>    hw/tpm/tpm_crb.c                 | 167 +++++++++++++++++++++++++++----
>>>    include/hw/acpi/tpm.h            |   5 +-
>>>    tests/qtest/tpm-crb-swtpm-test.c |  10 ++
>>>    tests/qtest/tpm-util.c           | 106 +++++++++++++++++---
>>>    tests/qtest/tpm-util.h           |   5 +
>>>    5 files changed, 256 insertions(+), 37 deletions(-)
>>>
>>
>>
> 
> Regards,
> Arun Menon
> 


