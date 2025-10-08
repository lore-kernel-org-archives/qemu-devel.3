Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6EACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6YIo-0003MY-6C; Wed, 08 Oct 2025 13:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v6YIh-0003Iq-Qp; Wed, 08 Oct 2025 13:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1v6YIa-0005n5-5v; Wed, 08 Oct 2025 13:50:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HI0cv012476;
 Wed, 8 Oct 2025 17:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Kn7oiR
 l7QPYo8V3k/X9Frs5X0gUBeUNrhY4wfWAuCxQ=; b=sOOGD9qbWvng5k/FHW5frW
 06FyjkMn9phRnBuK1SYyY0j+mDPXRpHVDtQljms+X56V2OVBdWfgS0IKJ2tVfput
 yPtP5vgcwpdihBtQbUB+NtGqcBF/5xzSxnG1WydjA182FMn7d897Yhay17QnJ6HU
 hEEYW+wxktIthDzAwdAEPdINHGZyC8B76CqyArlR6UnRwwR5brWEHFe8hPFQyc+J
 w1PbDL0b4LTjls1nIHFEPF7IBNB0uy9yJJeZFYzdyMjZwJdTHrn+hJ47pm8eULTm
 KfhWQThFQ/UL0qGUIKMNhrNXA4NJ3YSZy21QCexbUYSibnjdM5GZntSdhZHxJrsg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv7y8458-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 17:49:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598HLQHh020988;
 Wed, 8 Oct 2025 17:49:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9mr38g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 17:49:44 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 598HngP331981944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Oct 2025 17:49:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4856958055;
 Wed,  8 Oct 2025 17:49:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52CF858043;
 Wed,  8 Oct 2025 17:49:41 +0000 (GMT)
Received: from [9.61.152.204] (unknown [9.61.152.204])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  8 Oct 2025 17:49:41 +0000 (GMT)
Message-ID: <f8a0290f-fe32-433b-a4c7-5d0129ddc410@linux.ibm.com>
Date: Wed, 8 Oct 2025 13:49:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] Add boot-certs to s390-ccw-virtio machine type
 option
To: Collin Walling <walling@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com,
 eblake@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-2-zycai@linux.ibm.com> <87ldmcz1so.fsf@pond.sub.org>
 <aMvE7Phd7sLvgj-J@redhat.com>
 <9db0e68d-b54f-49d2-b598-f8e2f69e853b@linux.ibm.com>
 <b093c8f4-e701-4c26-9185-e3d2add92bd7@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <b093c8f4-e701-4c26-9185-e3d2add92bd7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FH-zn_-kDyknXg8IlwOtMXkGmrvPLUh9
X-Proofpoint-ORIG-GUID: FH-zn_-kDyknXg8IlwOtMXkGmrvPLUh9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX40b08kejlhOF
 f51kgtaTYancWKNSae+jWE1vfZ3ocViRx0sS2u/sKoZ1BnwPHNpcBb6TSGnzy6eo7er0LC9mJxg
 6b8dInkozlblDDuupWD2XXGpG3V1zb3JSaym9MIFqgJACczCGgRzXwrQEQ/2MOGQLHqjyxXs00c
 EWemWWgRhR++oDUOmiTdyWlwPSRo+GDcH9UOFl8NYxwTU8WSlAvwnJbfEOyo5t0yn1y8zj6iUPU
 8B19YOpq3fQjqUA9ep8gvWO2iQa+08t2Tcklcd1b1bsQe1Mx720WqZFQmwSTn5ZSdeH6z5Ys9vO
 +eOmddYn+tfuWY5PbQ90wLQTEbmcdzTil6+Ml3yqmX/p+Roll0ce/wd8RTrUGrXSZOzTMUlz1Aq
 bcv312KP6/FBF7hvVNyTa17b0kDGSQ==
X-Authority-Analysis: v=2.4 cv=FtwIPmrq c=1 sm=1 tr=0 ts=68e6a439 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=SqMvC5kiAAAA:8 a=fAMlN4cALHmXJZVwSREA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3GzNa28zmJEA:10
 a=_o8VnCo6Hb5Oqlm6Mk7M:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/29/25 2:29 PM, Collin Walling wrote:
> On 9/22/25 19:48, Zhuoying Cai wrote:
>> On 9/18/25 4:38 AM, Daniel P. Berrangé wrote:
> 
> [...]
> 
>>
>> Thank you for the comments.
>>
>> Since Secure IPL on s390x is supported in QEMU, I would like to begin
>> drafting the corresponding Libvirt interface and seek feedback before
>> proceeding with the implementation.
>>
>> While Libvirt already provides a secure boot interface
>> (https://libvirt.org/kbase/secureboot.html), it appears to be primarily
>> intended for x86 systems, where secure boot is configured using the
>> <firmware>, <loader>, and <nvram> tags.
>>
>> 	<os firmware='efi'>
>>       	    <firmware>
>> 		<feature enabled='yes' name='enrolled-keys'/>
>> 		<feature enabled='yes' name='secure-boot'/>
>> 	    </firmware>
>> 	    <loader secure='yes' type='pflash'>...</loader>
>> 	    <nvram template='...'>...</nvram>
>> 	</os>
>>
>> For s390x, some of these existing tags may be reused, but additional
>> elements will be needed.
>>
>> Below is my initial proposal for the secure boot interface in Libvirt:
>>
>>  	<!-- New s390-ccw-bios firmware value -->
>> 	<os firmware='s390-ccw-bios'>
>> 	    <type arch='s390x' machine='s390-ccw-virtio-9.2'>hvm</type>
>> 	    <firmware>
>>                 <!-- To enable secure boot -->
>> 		<feature enabled='yes' name='secure-boot'/>
>> 	    </firmware>
>>             <!-- To provide boot certificates for secure boot -->
>> 	    <boot-certs path='/path/to/cert.pem' />
>>             <boot-certs path='/path/to/cert-dir' />
>> 	    <boot dev='hd'/>
>> 	</os>
>>
>> I would be greatly appreciate any suggestions or feedback on this
>> proposal, and I am open to refining the design to better align with
>> existing Libvirt structures.
>>
>> Best regards,
>> Joy
>>
> 
> You should post an RFC to the libvirt list -- no code needed.  I suggest
> posting what you wrote above while also giving an example of the QEMU
> commandline.  Lastly, give a short background of what you've been
> working on and provide a link to these patches for a more detail.
> 
> CC those who have been involved in review as well as Boris, please.  Thanks!
> 

Thank you for the suggestion!

I posted an RFC to the libvirt list
(https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/DWCOPLUGJKYZ6BOCX3JWU2FJGFLG7DUF/).

> [...]
> 


