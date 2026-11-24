Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A85E606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=m8ZZZvGA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVhjE-0003m7-63; Mon, 23 Nov 2026 23:02:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xVhjC-0003lp-0c; Mon, 23 Nov 2026 23:01:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xVhjA-0006Ch-6s; Mon, 23 Nov 2026 23:01:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO351bW002308; Tue, 24 Nov 2026 04:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ZY4PBZ
 6ykCpsAVAVGPjZOx689nMoHnkilKWYDroZ2Ck=; b=m8ZZZvGAKHo5phZBTF0Ngr
 uTt3HsNMD/YLz2muOL0hJSmrqnYCcAe+fSXTtonBOqCFlLfSFEI4E8tBiAJtNANq
 Bvo6hmUrlxOpo2vozwJE2fvH/u8fEBXmF1GkRuUs3yvf713qvMIaXEJpYQCfI00p
 NoF43QOaTO9kWl9FV+4zb6kaQcl37DJjjoaMVS6XvLE2uhHu/WtKCCW6RWwe66Ka
 +h9EUjhvXNRZmZvD+xNSRsJ5z4/uiqLaZGZ/RWX/8fqOJgGuiyKF1VHFd3LnQ5+f
 UqdR/nb50dEVxk1HJ2Ks/z6DhQFLKl1yYmD9LAMdarXPnR36clPbdW0l7CPZz/qQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4dgud-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 04:01:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2nIc31669379; Tue, 24 Nov 2026 04:01:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufs1g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 04:01:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AO41jGh21496322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 04:01:45 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AB7758059;
 Tue, 24 Nov 2026 04:01:45 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA4215804B;
 Tue, 24 Nov 2026 04:01:41 +0000 (GMT)
Received: from [9.111.85.66] (unknown [9.111.85.66])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 04:01:41 +0000 (GMT)
Message-ID: <6610492a-2b92-40fe-9575-bdfa15a909d8@linux.ibm.com>
Date: Tue, 24 Nov 2026 09:31:39 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, fam@euphon.net,
 pbonzini@redhat.com, amachhiw@linux.ibm.com,
 qemu-block <qemu-block@nongnu.org>
References: <20260819095855.115823-1-rathc@linux.ibm.com>
 <bf24f1a1-c795-4a40-bf3c-f684fb28353e@oss.qualcomm.com>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <bf24f1a1-c795-4a40-bf3c-f684fb28353e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxNCBTYWx0ZWRfX7hCaRkO6LtH3
 6oWhgI+CvyOCIKotIAu6QtFn9YiAnBJchaQyPjhJAFCI2UVuXq1tkit1c8b4s9JUH7Jf2if9XzO
 0sRYbpJeklpYCLYW30kpM5vwCG+P9Cc=
X-Proofpoint-GUID: XeQkJlshgwTyqrjcu5z4vVm0bdTaK64A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxNCBTYWx0ZWRfX6lX8c2OtLNi0
 aDJ45Mdqnv75D0T8oLzbZ+olAt6eQINlghKtf/YThUYPmfYz5uzx7IM6YEzLcooA5QHIvBGYqSS
 8t1BLQ2VR4pwbyNFELQpzb1VmGTyx8KKS7PcheVc38kDzhyfiQL8N+0KrgJoWvRRa5dEv0HbdfA
 dvNT6khSraADJTOB9WN9kUPTKeGPe8U24jU7klJiBGKwzrrR+M+vi2oekQ2XTeMTXDA/Pge641+
 KtkDe1/eFX1BE6DSEm1ThsFBrrZfYTI5SpYdA8Rc5nJvEXtew1MAJbzhaNPWN3AvI2NtOaVY4ZY
 u28lSoXhgqCbZfi5ohN3epRBh2zUO7J2KDYKV7E0ryf7JBxpajiWMDjhvGTJf5UtXfxCKzEMn8U
 25Rdvm2NaRCxQfX0Dp64u550kpHse1aQSD0fu3qoCmEbztaQNHTaFuQ2Scf6WMMLVlkfD5W1uQQ
 QUX3rTUYjikqKuIEeCg==
X-Proofpoint-ORIG-GUID: Tst251gw1mXqHKYikxGXZQLoFfx0iqn5
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b050c2c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=klN1eePW5anbe4zvP0QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe,

On 11/19/26 23:28, Philippe Mathieu-Daudé wrote:
> Hi Chinmay,
>
> On 19/8/26 11:58, Chinmay Rath wrote:
>> cdb_offset and local_desc values are dependent on the guest. If the 
>> value
>> is large enough, it can lead to an out-of-bounds read in 
>> vscsi_fetch_desc().
>>
>> Add an 'avail' constant in vscsi_preprocess_desc() representing the 
>> number of
>> bytes available in srp_cmd.add_data[] and use it to prevent 
>> out-of-bound reads.
>>
>> Make all callers of vscsi_preprocess_desc() check its return value and
>> handle failure accordingly.
>>
>> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
>> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
>> ---
>>   hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 38 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
>> index b4c8f94d22..9fef224727 100644
>> --- a/hw/scsi/spapr_vscsi.c
>> +++ b/hw/scsi/spapr_vscsi.c
>> @@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
>>   static int vscsi_preprocess_desc(vscsi_req *req)
>>   {
>>       struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
>> +    /* bytes available for descriptors behind srp_cmd.add_data */
>> +    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, 
>> add_data);
>>         req->cdb_offset = cmd->add_cdb_len & ~3;
>>   @@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
>>       case SRP_NO_DATA_DESC:
>>           break;
>>       case SRP_DATA_DESC_DIRECT:
>> +        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
>> +            fprintf(stderr,
>> +                    "vscsi_preprocess_desc: direct desc out of 
>> bounds\n");
>
> Please replace fprintf() by qemu_log...(GUEST_ERRORS, ...).
Sure. I stuck to fprintf(), cause this has been used throughout this 
file (about 25 instances).

I shall post a patch replacing all of the applicable ones with qemu_log.


<snip>

>> @@ -823,7 +853,10 @@ static int vscsi_queue_cmd(VSCSIState *s, 
>> vscsi_req *req)
>>           req->writing = (n < 1);
>>             /* Preprocess RDMA descriptors */
>> -        vscsi_preprocess_desc(req);
>> +        if (vscsi_preprocess_desc(req) < 0) {
>
> scsi_req_cancel() does not send an SRP response by itself,
> so now guest waits until timeout... (That makes me wonder
> how this patch was tested). In order to return a proper error
> to the guest, please add:
>
>                req->dma_error = true;
Thanks for catching this ! I missed setting this. Apologies for the 
overlook.
vscsi_request_cancelled() would skip the CHECK_CONDITION response, 
causing guest to hang until timeout.
Shall post the fix.

Thanks,
Chinmay
>
>> + scsi_req_cancel(req->sreq);
>> +            return 1;
>> +        }
>>             /* Get transfer direction and initiate transfer */
>>           if (n > 0) {
>

