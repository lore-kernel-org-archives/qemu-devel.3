Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51BFE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 16:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM8t0-00006q-F2; Fri, 13 Dec 2024 11:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tM8sy-000067-NR; Fri, 13 Dec 2024 11:51:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tM8sv-00008b-2c; Fri, 13 Dec 2024 11:51:28 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfFZj020141;
 Fri, 13 Dec 2024 16:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lhGqYS
 s0x4CeJOfelf5CriOHlhkfnfE4pNVxN1JNKrk=; b=P1A8awGrjTawJdCkKJf7u4
 sEXKBKihV9Hm4kFV33/wHAJQTZ94tpyColoXVhuVhZChaz7kxUU94tIK1ZeFuo2g
 OGMLvCz/xmx5mVL82+/jwtNmqTpJTeR5qGqKvuT/gwvau5UyMmTj+x0EkaB9H78s
 3uY0Mvh1bKouBLCw9qs4ApOMviUQnaVl2wReB33N7mXXy91mXRCR+mV3FJXL+F8h
 Fo7JuDSqhQsIrngEwagyJFF6xMY6ThhhI0Be4dzMUpxcOC+P1KL5lOoM6Ocip7nS
 xShvn4VoFWxlzpp14I/z4I/iT606bTLrNln7S3XZhAf93r6u5i9ipahD6gAp+SLg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddbuj99-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 16:51:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEKbXQ018595;
 Fri, 13 Dec 2024 16:51:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26kxpja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 16:51:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BDGpH7225166394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 16:51:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 138F458056;
 Fri, 13 Dec 2024 16:51:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A06AC58065;
 Fri, 13 Dec 2024 16:51:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2024 16:51:16 +0000 (GMT)
Message-ID: <6dcdf339-a9f8-4bd9-8c5a-2cf9033d1ae1@linux.ibm.com>
Date: Fri, 13 Dec 2024 11:51:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, philmd@linaro.org, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
 <bf154441-1e0a-4029-946a-727621395e25@linux.ibm.com>
 <20241213142133.GC2962236@myrica>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241213142133.GC2962236@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nESk5Cbhay93XcgjiJQrs3otAeJ3wy3W
X-Proofpoint-GUID: nESk5Cbhay93XcgjiJQrs3otAeJ3wy3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130116
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



On 12/13/24 9:21 AM, Jean-Philippe Brucker wrote:
> On Mon, Dec 09, 2024 at 05:08:37PM -0500, Stefan Berger wrote:
>>>    typedef struct {
>>>        hwaddr base;
>>>        hwaddr size;
>>> +    uint8_t *data;
>>> +    RmeLogFiletype *filetype;
>>>    } RmeRamRegion;
>>> +typedef struct {
>>> +    char        signature[16];
>>> +    char        name[32];
>>> +    char        version[40];
>>> +    uint64_t    ram_size;
>>> +    uint32_t    num_cpus;
>>> +    uint64_t    flags;
>>> +} EventLogVmmVersion;
>>> +
>>> +typedef struct {
>>> +    uint32_t    id;
>>> +    uint32_t    data_size;
>>> +    uint8_t     data[];
>>> +} EventLogTagged;
>>> +
>>
>>
>>> +#define EVENT_LOG_TAG_REALM_CREATE  1
>>> +#define EVENT_LOG_TAG_INIT_RIPAS    2
>>> +#define EVENT_LOG_TAG_REC_CREATE    3
>>> +
>> If these are ARM-related structures and constants from a document you may
>> want to mention the document you got them from.
> 
> Agreed. At the moment they're just numbers and structures I made up [1].

I looked through old TCG specs (likely there are newer ones that mention 
this as well, but don't currently know) that have some definitions for 
EV_EVENT_TAG with a specific structure for logging the event. You seem 
to use the same structure:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientImplementation_1-21_1_00.pdf


11.3.2.1:

typedef struct tdTCG_PCClientTaggedEventStruct {
UINT32 EventID;
UINT32 EventDataSize;
BYTE[EventDataSize] EventData;
} TCG_PCClientTaggedEventStruct;

This seems to be your EventLogTagged.

EV_EVENT_TAG has tags defined for x86_64 defined in 11.3.2.3.{1 .. 13} 
in that spec with numbers 0 .. 0xe. You would be clashing with those 
numbers but otoh the are platform-specific.

> I'm not certain in which standard they should go. TCG would seem
> appropriate, or IETF is also used for protocols related to confidential

The log is from TCG, so it would probably have to go into some sort of 
TCG registry.

> computing attestation. Or maybe it could live in the reference verifier
> documentation. QEMU docs wouldn't be the best place because VMMs might
> been reluctant to adopt it because they don't consider it a standard (like
> cloud-hv and fw_cfg)
> 
> When researching this I found TCG event types and payloads that only seem
> to be documented in their respective project:
> * efistub [2] with
>    * EV_EVENT_TAG, id=0x8F3B22EC, data="Linux initrd",
>    * EV_EVENT_TAG, id=0x8F3B22ED, data="LOADED_IMAGE::LoadOptions"

Maybe the first id is just a random number or in a vendor-specific space 
that I don't know about. My guess is they likely try to avoid clashes 
with existing numbers.


> * grub [3] with a few EV_IPL
> * systemd [4] with various EV_EVENT_TAG and EV_IPL
> 
> I'm wondering if we could create a common registry somewhere for these,
> like IANA or somewhere informal.
 > >
> [1] https://github.com/veraison/cca-realm-measurements/blob/main/docs/measurement-log.md#rim-log
> [2] https://lore.kernel.org/all/20211119114745.1560453-1-ilias.apalodimas@linaro.org/
> [3] https://www.gnu.org/software/grub/manual/grub/html_node/Measured-Boot.html
> [4] https://systemd.io/TPM2_PCR_MEASUREMENTS/
> 
> 
>>> +/* Log VM type and Realm Descriptor create */
>>> +static int rme_log_realm_create(Error **errp)
>>> +{
>>> +    int ret;
>>> +    ARMCPU *cpu;
>>> +    EventLogVmmVersion vmm_version = {
>>> +        .signature = "VM VERSION",
>>> +        .name = "QEMU",
>>> +        .version = "9.1", /* TODO: dynamic */
>>
>> $ grep -r QEMU_VERSION_M build/
>> build/config-host.h:#define QEMU_VERSION_MAJOR 9
>> build/config-host.h:#define QEMU_VERSION_MICRO 93
>> build/config-host.h:#define QEMU_VERSION_MINOR 1
>>
>> $ cat VERSION
>> 9.1.93
> 
> Ah yes that would work, thank you
> 
>>> +static int rme_log_rec(uint64_t flags, uint64_t pc, uint64_t gprs[8], Error **errp)
>>> +{
>>
>> $ ./scripts/checkpatch.pl ./tmp/*.patch
>> [...]
>> Checking ./tmp/0002-target-arm-kvm-rme-Add-measurement-log.patch...
>> WARNING: line over 80 characters
>> #353: FILE: target/arm/kvm-rme.c:303:
>> +static int rme_log_rec(uint64_t flags, uint64_t pc, uint64_t gprs[8], Error
>> **errp)
>>
>> May want to run this on all patches.
>>
>> Rest LGTM.
> 
> Thank you!
> 
> Jean
> 


