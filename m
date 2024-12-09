Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1A9E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkHa-0003b9-FG; Mon, 09 Dec 2024 15:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tKkHX-0003au-Dv; Mon, 09 Dec 2024 15:23:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tKkHV-0001a0-AI; Mon, 09 Dec 2024 15:23:03 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9JLUmo020932;
 Mon, 9 Dec 2024 20:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=E4reyB
 7EhPMhkHL3N/FQihFhqvY1JY1m59R5yFJC75c=; b=TVo6+F8qEmF4+JNjnSC9uF
 rgqDc7gt4wuA/HZRj76N/22tFwWFrPprBOdNhomJPg0Hjh+8x1ZPT2oYGuPWWpcE
 usjRU6zq74rhjtnN082D7/9a8vT6bY8cWN3gJkbn1kVSmrsmzuOWrFw7RYcA2oLC
 V7rxZM7j5IEHvc8HoystPpqXmLt5S/EQaOKKJNipteiCkVuhX0Uj3nu9OIILWVhg
 Dsm3pfXq1i065lmQOyoDSOnF9S0pZO/RURIgMGdXyjFqMeaQWJR9Q4rC7m6rygEH
 cFjO/h07tl1n2ECn2O9j4OqDH1neIbbidV6HffzDbpnnGlMMsbj/xxhhLpBJdKWQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38kcv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 20:22:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HkQEL016911;
 Mon, 9 Dec 2024 20:22:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y0ef8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Dec 2024 20:22:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4B9KMsoe25690700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Dec 2024 20:22:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47B4158058;
 Mon,  9 Dec 2024 20:22:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BD1E5805D;
 Mon,  9 Dec 2024 20:22:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Dec 2024 20:22:53 +0000 (GMT)
Message-ID: <371a3e10-dfad-4289-aad0-d35e3d6f11a5@linux.ibm.com>
Date: Mon, 9 Dec 2024 15:22:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
 <Z0XREyMovNyB4s6t@redhat.com> <20241126162149.GC956991@myrica>
 <d3d73795-3f59-490c-9e54-c6c358af62d0@linux.ibm.com>
 <20241205123316.GA567753@myrica>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241205123316.GA567753@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v1EZjmhlz7Pbo3zKMS6c1WgMDmzH9DOA
X-Proofpoint-ORIG-GUID: v1EZjmhlz7Pbo3zKMS6c1WgMDmzH9DOA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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



On 12/5/24 7:33 AM, Jean-Philippe Brucker wrote:
> On Mon, Dec 02, 2024 at 10:58:01AM -0500, Stefan Berger wrote:
>>
>>
>> On 11/26/24 11:21 AM, Jean-Philippe Brucker wrote:
>>> On Tue, Nov 26, 2024 at 01:45:55PM +0000, Daniel P. Berrangé wrote:
>>>> On Mon, Nov 25, 2024 at 05:23:44PM -0500, Stefan Berger wrote:
>>>>>
>>>>>
>>>>> On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
>>>>>> Create an event log, in the format defined by Trusted Computing Group
>>>>>> for TPM2. It contains information about the VMM, the Realm parameters,
>>>>>> any data loaded into guest memory before boot and the initial vCPU
>>>>>> state.
>>>>>>
>>>>>> The guest can access this log from RAM and send it to a verifier, to
>>>>>> help the verifier independently compute the Realm Initial Measurement,
>>>>>> and check that the data we load into guest RAM is known-good images.
>>>>>> Without this log, the verifier has to guess where everything is loaded>
>>>>> and in what order.
>>>>>
>>>>> Typically these logs are backed by extensions of TPM PCRs and when you send
>>>>> a log to a verifier you send a TPM quote along with it for the verifer to
>>>>> replay the log and check the TPM quote. Also, early code in the firmware is
>>>>> typically serving as a root of trust that starts the chain of measurements
>>>>> of code and data, first measuring itself and then other parts of the
>>>>> firmware before it jumps into the other parts. Now here you seem to just
>>>>> have a log and no PCR extensions and therefore no quote over PCRs can be
>>>>> used.
>>>
>>> Indeed, in our case it's the trusted hypervisor (RMM) that provides the
>>> equivalent to TPM quote and PCRs. In more details:
>>>
>>> 1. QEMU loads images into guest RAM by calling KVM, which calls RMM.
>>> 2. RMM calculates a hash of the image content, adds it to a rolling hash
>>>      the "Realm Initial Measurement" (RIM), which I believe is equivalent to
>>>      a PCR.
>>
>> I am not familiar with RIM. A link to read more about it would be helpful.
> 
> The "Learn the architecture" documentation might be a good introduction
> https://developer.arm.com/documentation/den0127/0200/Overview
> In particular the part about Realm creation:
> https://developer.arm.com/documentation/den0127/0200/Realm-management/Realm-creation-and-attestation
> 
> The RMM specification describes exactly how the RIM is calculated, but
> is less palatable:
> https://developer.arm.com/documentation/den0137/1-0rel0/?lang=en
> A7.1.1 Realm Initial Measurement
> 
> More specialized resource are the attestation token documentation:
> [1] https://datatracker.ietf.org/doc/html/draft-ffm-rats-cca-token-00
> and CCA Security Model:
> https://developer.arm.com/documentation/DEN0096/latest/

Thanks for the links. I will have a look at them when I have time.

> 
>>
>>> 3. During remote attestation, the guest sends evidence containing this RIM
>>>      signed by the root of trust, along with a signed token identifying the
>>>      platform (hardware, firmware, RMM).
>>
>> Is this a well known manufacturer key that one would expect for signature
>> verification or is it locally created?
> 
> It comes from a well known manufacturer key, although the signing can be
> delegated in some models (like in the current demos):
> 
> The hardware RoT creates a key pair for the RMM, which the RMM uses to
> sign the RIM. The RoT then signs the RMM pubkey, using the well-known key
> (see [1] 4.10 Token Binding).

You should mention in the commit message that the log will be signed and 
user space can get the signature over the log from some filesystem or so.

    Stefan


