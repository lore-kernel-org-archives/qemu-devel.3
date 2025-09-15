Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07513CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBrS-0004lu-2y; Mon, 15 Sep 2025 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uyBrJ-0004dN-Jn; Mon, 15 Sep 2025 12:15:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uyBr7-0003m7-5A; Mon, 15 Sep 2025 12:15:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDY8mP023436;
 Mon, 15 Sep 2025 16:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=92r4wp
 2QLBVqdCo+uvp++2zIYUSsic+q3lhg6KcVKa8=; b=NRGDhXMqmqyYB71gnrMD3n
 chjwEzlIRKx/IR6LVCRT34vLntvtLBxJXBu23tYOMS+XTz/EfghRb0WIbyYjNHMS
 ncwAlpcs5xW9mdA490ROmtqGqFK8Ckt+Plk83q5Psd4HAhYhuWH5GTVIYvMcS9YN
 teSpdoaxKPtc7S8pF8JB8hRIp+0VbOKQL6HfsgcpVGt2QS1/sfO9wCz0Ys2SqXjL
 LNj4mqlgKocJvJMW5ZpZY0kVDcL/1qo6vxou1ja8qLswWT7dqzht/FKKYyKVFzJc
 b91YWYg/9YR/zSP5sJ1GEky7CqLuABbR1pyAFmZrHwRwTJQkKRVlaKPxgAaA6GVw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 496avnkr17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:14:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FFAAu7022316;
 Mon, 15 Sep 2025 16:14:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxpfahk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Sep 2025 16:14:54 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58FGEqBf20775442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Sep 2025 16:14:53 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92B2458052;
 Mon, 15 Sep 2025 16:14:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A17F058067;
 Mon, 15 Sep 2025 16:14:51 +0000 (GMT)
Received: from [9.61.159.211] (unknown [9.61.159.211])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Sep 2025 16:14:51 +0000 (GMT)
Message-ID: <14c613b1-d595-4cf1-b26e-5d87965a2c98@linux.ibm.com>
Date: Mon, 15 Sep 2025 12:14:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/29] Add boot-certs to s390-ccw-virtio machine type
 option
To: Markus Armbruster <armbru@redhat.com>
Cc: thuth@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@redhat.com, jrossi@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 alifm@linux.ibm.com
References: <20250818214323.529501-1-zycai@linux.ibm.com>
 <20250818214323.529501-2-zycai@linux.ibm.com> <87v7lpjvsw.fsf@pond.sub.org>
 <ffb4d32b-d2bc-45f0-91ce-6472d64c02bb@linux.ibm.com>
 <87wm64b29p.fsf@pond.sub.org>
 <3d930413-d809-4650-b1d8-446eb4ee7daa@linux.ibm.com>
 <87tt14z03x.fsf@pond.sub.org>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <87tt14z03x.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QopDzXQNEwSa_OgT8h9gVPDtD0IRNGNC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAyOCBTYWx0ZWRfX265Ch1q5TIaE
 nEGrLge7JJS0CZM0eZjLBtMpWZpdHZ5XoeNVSBYZkjNqoQvqfFtMEp3PBNb63V11dcfVQZvwtVr
 0gvnq87rPTaYiZXXfB0rGCXoFfbFETdedVjHknfs6dZMRUOj2z+eFRRQc2stG7xiCuW8AV9vsIM
 CAi62649vXw4NITNKOJXvBDOsHl1aHJcaIghsH89p9gbWnBV/uISmzggAg8M3/vltuj5mxpZ8PY
 0ojr5ilF2YrOKZQd4lClhlE9w5ZvYB5Ek8GAzvC0eghuIrM5ROd9J2oa5A+NtY/eeramRkfDoWR
 INTenrZ7h+CGMIviItyC0amW0J9VSwKEQ5a6VcJ+eo6ng/94iEiW8XcP1D6XthGPTpQJre7OpLb
 oEi4CYDH
X-Authority-Analysis: v=2.4 cv=HecUTjE8 c=1 sm=1 tr=0 ts=68c83b7f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=dtGe38LnIEzO8XVZHQwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QopDzXQNEwSa_OgT8h9gVPDtD0IRNGNC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150028
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/25 2:44 AM, Markus Armbruster wrote:
> Zhuoying Cai <zycai@linux.ibm.com> writes:
> 
>> On 9/12/25 2:42 AM, Markus Armbruster wrote:
>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>>
>>>> Thanks for the feedback.
>>>>
>>>> On 9/11/25 3:24 AM, Markus Armbruster wrote:
>>>>> Zhuoying Cai <zycai@linux.ibm.com> writes:
>>>>>
>>>>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>>>>> machine. This allows users to specify one or more certificate file paths
>>>>>> or directories to be used during secure boot.
>>>>>>
>>>>>> Each entry is specified using the syntax:
>>>>>> 	boot-certs.<index>.path=/path/to/cert.pem
>>>>>>
>>>>>> Multiple paths can be specify using array properties:
>>>>>> 	boot-certs.0.path=/path/to/cert.pem,
>>>>>> 	boot-certs.1.path=/path/to/cert-dir,
>>>>>> 	boot-certs.2.path=/path/to/another-dir...
>>>>>>
>>>>>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>>>>>> ---
>>>>>>  docs/system/s390x/secure-ipl.rst   | 20 ++++++++++++++++++++
>>>>>>  hw/s390x/s390-virtio-ccw.c         | 30 ++++++++++++++++++++++++++++++
>>>>>>  include/hw/s390x/s390-virtio-ccw.h |  2 ++
>>>>>>  qapi/machine-s390x.json            | 24 ++++++++++++++++++++++++
>>>>>>  qemu-options.hx                    |  6 +++++-
>>>>>>  5 files changed, 81 insertions(+), 1 deletion(-)
>>>>>>  create mode 100644 docs/system/s390x/secure-ipl.rst
>>>>>>
>>>>>> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
>>>>>> new file mode 100644
>>>>>> index 0000000000..9b3fd25cc4
>>>>>> --- /dev/null
>>>>>> +++ b/docs/system/s390x/secure-ipl.rst
>>>>>> @@ -0,0 +1,20 @@
>>>>>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> +
>>>>>> +Secure IPL Command Line Options
>>>>>> +===============================
>>>>>> +
>>>>>> +New parameters have been introduced to s390-ccw-virtio machine type option
>>>>>> +to support secure IPL. These parameters allow users to provide certificates
>>>>>> +and enable secure IPL directly via the command line.
>>>>>
>>>>> All too soon these parameters will no longer be new.  Consider something
>>>>> like "The s390-ccw-virtio machine type supports secure TPL.  To enable
>>>>> it, you need to provide certificates."
>>>>>
>>>>>> +
>>>>>> +Providing Certificates
>>>>>> +----------------------
>>>>>> +
>>>>>> +The certificate store can be populated by supplying a list of certificate file
>>>>>> +paths or directories on the command-line:
>>>>>
>>>>> File is clear enough (use the certificate found in the file).  What does
>>>>> directory do?
>>>>
>>>> A directory contains a list of certificate files, and allowing both
>>>> files and directories could make the CLI more flexible.
>>>
>>> I figure when @path names a file, it's an error when the file doesn't
>>> contain a valid cetificate.
>>>
>>> What is @path names a directory, and one of the directory's files
>>> doesn't contain a valid certificate?
>>>
>>> Can a single file contain multiple certificates?
>>
>> A certificate file path is expected to contain exactly one certificate.
>>
>> Certificates provided through the CLI, whether as individual files or
>> within a directory, are validated before use. If a certificate is
>> invalid (e.g., unsupported format), it will be skipped and not added to
>> the S390 certificate store.
> 
> Hmm.  What exactly happens when I configure a certificate file like
> 
>     -machine s390-ccw-virtio,boot-certs.0.path=/dev/null
> 
> or some other file that doesn't contain a valud certificate?  Is it
> silently ignored, or is it an error?
> 
>> When iterating through the provided paths, the program will terminate on
>> fatal configuration errors, such as when a specified path is neither a
>> file nor a directory.
> 

If /dev/null is provided, the program will report an error and terminates.

   qemu-system-s390x: Path '/dev/null' is neither a file nor a directory

If a file exists but doesn't contain a valid certificate, the program
will report the error but continues validating other remaining
certificates. For example, providing a certificate in DER format
(cert.pem) is not supported; only PEM format certificates are accepted:

   -machine s390-ccw-virtio,boot-certs.0.path=/root/cert.pem, \
                            boot-certs.1.path=/root/pem-test/rsa.pem, \
                            boot-certs.2.path=/root/pem-test/rsa-oaep.pem

   qemu-system-s390x: Failed to initialize certificate: /root/cert.pem:
Failed to import certificate: Base64 unexpected header error.
Using virtio-blk.
SCSI boot device supports secure boot.
LOADPARM=[        ]

Using virtio-blk.
Using SCSI scheme.
....Verified component
...Verified component
...

In summary, QEMU first collects a list of .pem files from the CLI, and
then validate each certificate in that list.

More specifically, QEMU first checks and normalizes the certificate
paths - each path must be a non-empty string, must exist, and must be
either a regular file or a directory. An invalid path will be reported
and cause the program to terminate. Regular files with a .pem suffix, as
well as .pem files inside directories, are added to the list.

Once the list is built, QEMU attempts to read and parse each
certificate. Errors at this stage (such as an invalid certificate
format) are reported, but the program continues validating the rest of
certificate in the list.

(Further implementation details are provided in [PATCH v5 04/29]
hw/s390x/ipl: Create certificate store.)

> [...]
> 


