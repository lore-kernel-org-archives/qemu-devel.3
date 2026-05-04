Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00DDFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuN5-0003Wf-MW; Mon, 04 May 2026 10:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJuMx-0003W0-4J
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:33:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJuMv-00013s-0B
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:33:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 643Ke6tS2807042; Mon, 4 May 2026 14:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=doiZ7o
 L2Z8/RvOpD8ZpyR+O4sxmhIgVSWZaK36z+mXE=; b=l6DeMNI43L55OPe9gjEK3I
 iy/0NTT5Bv1E5qCP4RVoU+SSgwU5y2CZcwG3sw+/sCjcdph36LwAQ4E9vLEQiJ0T
 6BvZNbauwV+CIQq7HNoxpAJH9PoxQqjnceHEu/eMeLPS+pz9FpMGLmGd3nxfnXw7
 M0WES0a9V6HiY8JtZhikv32KnwvtWfZmDFKDCNKex+CUX9iRE8NxmDGWeYK9wxsn
 v5Atfis7z0ekTmg1dQKAcmMBikOEZQA6cw1Cvbx1cvJFLrGWPrl7G/hkWMLEbV8i
 r3eDR3TrwU1ZsNMiZ+OHxak+8wgErjicNklNzBWzW38fKuzxPlbDAYrv9GwABLQg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v77ewg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 14:33:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644EONRc028829;
 Mon, 4 May 2026 14:33:40 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y584h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 14:33:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644EXeQd65339710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 14:33:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D0E35805C;
 Mon,  4 May 2026 14:33:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0417B5805B;
 Mon,  4 May 2026 14:33:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 14:33:38 +0000 (GMT)
Message-ID: <caf85297-8277-44b2-82ca-aee6cd8770ce@linux.ibm.com>
Date: Mon, 4 May 2026 10:33:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
 <ef476984-6a55-4654-89e3-2703d8baca25@linux.ibm.com>
 <afLkebmMTFPEyAuK@fedora>
 <56667f7a-71c9-4280-90ab-1b356741d803@linux.ibm.com>
 <afhGxAEyDWtofq_L@fedora>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afhGxAEyDWtofq_L@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NyBTYWx0ZWRfX3WEpB1nwTywN
 fw/mLrA0QgscI7NlUUqGyJwjzZgUZsClr+sMLPPusNjJfcOKTmzInXoaBXqwgHkKIz9sxnbM9jM
 Io3Wyt6W+keRjqp4CAefLLYqHlutLfcYU5r8FXjZ8/sCB0HiC+9VqucV4eAf7RXiOPCUUH0A9vo
 NAEc2/ariy7C1E6wSn98kX4ELa0+KRM+vCIAMWzH81wKiw+fCUzztxeUXejD4jSJRXGxnxznAfy
 s947dLWD+9J8rZ9b3YqlI6zBEtoALY8aNTfruYnsiCPs755FvHBFTRmj/nlxaFtX/t38SVfMmVM
 ZS4EPkhhLDYsGVxTKVzz0n+uDtGjcQ1JZ0o8zldF9rujC28xsbcy2oj1LjgK6rVYODjHiGD9ckI
 Q3SdCz6u9n1lVyRY+CujCEiu23TidjEU3x0RJ0XEsODY9x3FvT0xcbxFt8c9qxOIdzkWYQBbMx+
 tWWKfjH+iSaYhe4Ulhw==
X-Proofpoint-GUID: kAaldl-nmL36rrqn2ivISKwfB2obUzTK
X-Proofpoint-ORIG-GUID: gpmkbtHVf7nOCACriVlTL2XbML3KZ0je
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f8ae46 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=mSQoX_iHuy6Mfxy5AJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040147
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 5/4/26 3:12 AM, Arun Menon wrote:
> On Thu, Apr 30, 2026 at 07:46:33AM -0400, Stefan Berger wrote:
>>
>>
>> On 4/30/26 1:11 AM, Arun Menon wrote:
>>> On Wed, Apr 29, 2026 at 07:14:38PM -0400, Stefan Berger wrote:
>>>>
>>>>
>>>> On 4/22/26 6:30 AM, Arun Menon wrote:
>>>>> From: Arun Menon <armenon@redhat.com>
>>>>>
>>>>> - Add subsection in VMState for TPM CRB with the newly introduced
>>>>>      command and response buffer GByteArrays, along with a needed callback,
>>>>>      so that newer QEMU only sends the buffers if it is necessary.
>>>>> - Implement a migration blocker to prevent migration of the VM if the
>>>>>      user manually enables chunking capability, cap-chunk, but the machine
>>>>>      type does not support it, using a new hw_compat property called
>>>>>      allow_chunk_migration.
>>>>> - Add a post_load_errp hook so that during a migration, the buffers are
>>>>>      validated before destination VM is started.
>>>>>
>>>>> Signed-off-by: Arun Menon <armenon@redhat.com>
>>>>> ---
>>>>>     hw/core/machine.c |  1 +
>>>>>     hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>>     2 files changed, 72 insertions(+)
>>>>>
>>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>>> index 6d27cf69a2..b590af0125 100644
>>>>> --- a/hw/core/machine.c
>>>>> +++ b/hw/core/machine.c
>>>>> @@ -40,6 +40,7 @@
>>>>>
>>>>>     GlobalProperty hw_compat_11_0[] = {
>>>>>         { "tpm-crb", "cap-chunk", "off"},
>>>>> +    { "tpm-crb", "x-allow-chunk-migration", "off"},
>>>>>     };
>>>>>     const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>>>>>
>>>>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>>>>> index 29370d6f49..23e6948aee 100644
>>>>> --- a/hw/tpm/tpm_crb.c
>>>>> +++ b/hw/tpm/tpm_crb.c
>>>>> @@ -24,6 +24,7 @@
>>>>>     #include "hw/pci/pci_ids.h"
>>>>>     #include "hw/acpi/tpm.h"
>>>>>     #include "migration/vmstate.h"
>>>>> +#include "migration/blocker.h"
>>>>>     #include "system/tpm_backend.h"
>>>>>     #include "system/tpm_util.h"
>>>>>     #include "system/reset.h"
>>>>> @@ -51,6 +52,8 @@ struct CRBState {
>>>>>         TPMPPI ppi;
>>>>>
>>>>>         bool cap_chunk;
>>>>> +    bool allow_chunk_migration;
>>>>> +    Error *migration_blocker;
>>>>>     };
>>>>>     typedef struct CRBState CRBState;
>>>>>
>>>>> @@ -353,12 +356,63 @@ static int tpm_crb_pre_save(void *opaque)
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> +static bool tpm_crb_chunk_needed(void *opaque)
>>>>> +{
>>>>> +    CRBState *s = opaque;
>>>>> +
>>>>> +    if (!s->allow_chunk_migration) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>>> +    return ((s->command_buffer && s->command_buffer->len > 0) ||
>>>>> +            (s->response_buffer && s->response_buffer->len > 0));
>>>>> +}
>>>>> +
>>>>> +static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
>>>>> +{
>>>>> +    CRBState *s = opaque;
>>>>> +
>>>>> +    if (!s->response_buffer || !s->command_buffer) {
>>>>> +        error_setg(errp, "tpm-crb: Internal buffers are not allocated");
>>>>
>>>> Could this happen that this state type is resumed but the buffers are not
>>>> allocated?
>>>
>>> Yes, this is not required. Its just a defense. The tpm_realize()
>>> function should allocate the command and response buffers.
>>>
>>>>
>>>>> +        return false;
>>>>> +    }
>>>>> +    if (s->response_offset > s->response_buffer->len) {
>>>>> +        error_setg(errp, "tpm-crb: Invalid response "
>>>>> +                   "offset %" PRIu32 " in migration stream",
>>>>> +                   s->response_offset);
>>>>> +        return false;
>>>>> +    }
>>>>
>>>> The check is correct but can this particular case occur other than through
>>>> crafted input?
>>>
>>> Not that I can think of. The check is indeed added to address malicious
>>> migration stream / crafted input.
>>
>> I think that devices are assuming trusted input for all devices resumed from
>> their previously stored state...
> 
> I see. Shall I remove these two checks at the beginning and keep only
> the last one?

I think so. For the last one I think you should write a description what 
role the external emulator can play here.


> 
>>
>>>
>>>>
>>>>> +    if (s->response_buffer->len > s->be_buffer_size ||
>>>>> +        s->command_buffer->len > s->be_buffer_size) {
>>>>
>>>> I suppose this could happen if I was running with a PQC-enable swtpm/libtpms
>>>> and suspended at the right moment that when a chunked command or response
>>>> was in the buffer and now I am trying to resume with a non-PQC-enabled swtpm
>>>> that only has 4kb buffer, while the newer PQC one had 8kb buffer.
>>>>
>>>
>>> Yes. This check is for safety. We do not want to migrate to a VM that
>>> has a tpm backend that does not support big buffers.
>>>
>>>>> +        error_setg(errp, "tpm-crb: Buffer sizes exceed backend capacity");
>>>>> +        return false;
>>>>> +    }
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>> +static const VMStateDescription vmstate_tpm_crb_chunk = {
>>>>> +    .name = "tpm-crb/chunk",
>>>>> +    .version_id = 0,
>>>>> +    .needed = tpm_crb_chunk_needed,
>>>>> +    .post_load_errp = tpm_crb_chunk_post_load,
>>>>> +    .fields = (const VMStateField[]) {
>>>>> +        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
>>>>> +        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
>>>>> +        VMSTATE_UINT32(response_offset, CRBState),
>>>>> +        VMSTATE_END_OF_LIST()
>>>>> +    }
>>>>> +};
>>>>> +
>>>>>     static const VMStateDescription vmstate_tpm_crb = {
>>>>>         .name = "tpm-crb",
>>>>>         .pre_save = tpm_crb_pre_save,
>>>>>         .fields = (const VMStateField[]) {
>>>>>             VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
>>>>>             VMSTATE_END_OF_LIST(),
>>>>> +    },
>>>>> +    .subsections = (const VMStateDescription * const []) {
>>>>> +        &vmstate_tpm_crb_chunk,
>>>>> +        NULL,
>>>>>         }
>>>>>     };
>>>>>
>>>>> @@ -366,6 +420,8 @@ static const Property tpm_crb_properties[] = {
>>>>>         DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>>>>>         DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>>>>>         DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
>>>>> +    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
>>>>> +                     allow_chunk_migration, true),
>>>>>     };
>>>>>
>>>>>     static void tpm_crb_reset(void *dev)
>>>>> @@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
>>>>>     static void tpm_crb_realize(DeviceState *dev, Error **errp)
>>>>>     {
>>>>>         CRBState *s = CRB(dev);
>>>>> +    int ret;
>>>>>
>>>>>         if (!tpm_find()) {
>>>>>             error_setg(errp, "at most one TPM device is permitted");
>>>>> @@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>>>>>             error_setg(errp, "'tpmdev' property is required");
>>>>>             return;
>>>>>         }
>>>>> +    if (s->cap_chunk && !s->allow_chunk_migration) {
>>>>> +        error_setg(&s->migration_blocker,
>>>>> +                   "The tpm-crb device does not support chunk migration with "
>>>>> +                   "machine version less than 11.1");
>>>>> +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
>>>>> +        if (ret < 0) {
>>>>> +            return;
>>>>> +        }
>>>>> +    }
>>>>>
>>>>>         memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
>>>>>             "tpm-crb-mmio", sizeof(s->regs));
>>>>> @@ -463,6 +529,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
>>>>>
>>>>>         g_clear_pointer(&s->command_buffer, g_byte_array_unref);
>>>>>         g_clear_pointer(&s->response_buffer, g_byte_array_unref);
>>>>> +
>>>>> +    if (s->migration_blocker) {
>>>>> +        migrate_del_blocker(&s->migration_blocker);
>>>>> +        error_free(s->migration_blocker);
>>>>> +    }
>>>>>     }
>>>>>
>>>>>     static void tpm_crb_class_init(ObjectClass *klass, const void *data)
>>>>
>>>
>>> Regards,
>>> Arun Menon
>>>
>>
> 
> Regards,
> Arun Menon
> 


