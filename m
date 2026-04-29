Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E517DFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIE7Y-0001nR-MB; Wed, 29 Apr 2026 19:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIE7P-0001l4-Ox
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:15:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wIE7K-0006OH-SB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:14:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63THvfWK2549507; Wed, 29 Apr 2026 23:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=A84zd0
 pzrIndViCyPOAccukZOLjQRm6QOqLr4B3NEUs=; b=FQqteY8GHxMW1yNR1vOzji
 3tcfN5WH7OAwDNWUcJ8Bh84xuwtVTTqgEGw72YPRyUPi3yYbV+7rgOvqNVEMKKwK
 XWGIDm43sr8+MDANTVawTd652HagsMGKbgcDB6c74gYN7ZNYcb3zKmXsfhOFN8f6
 z2Ybs0bvVmL6a4hiNSZT/MFZNX5yHTYwX/oYUjumf6sOljUBBn4CHak/M1DaTFC8
 8Jvx0nhZux1SCs+DIDVh4gr8sJKUIyRVxEOTRnEtmGoMtXTmMmUucPurdIcANfcU
 t6cxz1vYpJ0acFoUkhF/JTi4rY6uTjAIIQm2OZ3iwzjYcqpIj1XA6CQgTpn0JNog
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1junkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 23:14:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TN8pVL011166;
 Wed, 29 Apr 2026 23:14:43 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehgeet-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 23:14:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TNEgu829557488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 23:14:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96DBD58052;
 Wed, 29 Apr 2026 23:14:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B037158056;
 Wed, 29 Apr 2026 23:14:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 23:14:41 +0000 (GMT)
Message-ID: <ef476984-6a55-4654-89e3-2703d8baca25@linux.ibm.com>
Date: Wed, 29 Apr 2026 19:14:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260422103018.123608-7-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIyOSBTYWx0ZWRfXxzzbNiAhUiO1
 lnTd4P4BaBeUnrPyXx/q0lOnNBwXnH9RuukKuYAJ7CGjdTuV0dANRcNLauyvCHfZqqIq9BqrtU1
 oZ47D2uJrAXe/kSeAa7fK4SdIbtd7vnSj5KPif6AdZyTOUcUT2vA41AIKvLK9RjnVP6HXB0ljKo
 Mzg8PRRwkEyVW2h3kzpyZZ7wY1SJHjDxH86LtWy5NYKcIx2U9VxJGRJezP9cVhwv1oQlWblrkJv
 b+A1ZLQl9cizC6rtin6tZEhzLNjukgwlfAVfmeVGMV0j7/vFHPqcATKHN1fTlenUuWiag8C0j+O
 AiCidnWdWA46Ea2g774RcoHnNYIRJC0O3sl0qWead/Rf5+s6gtlHDxK1Wqo2URgMSGTsrrm7zsi
 1ReK6bb6eulvvAqYBZcCXOwCkFdzitFbMcTQ1f6lY2fNANtAvmOHNw4lZGDAqWRb0qmx6VYGLKp
 NgUL0+0Zxnqjaldd7rw==
X-Proofpoint-GUID: Z-YOg1uTUeyvmvzIRdWj9i-JRpzSmI2o
X-Proofpoint-ORIG-GUID: 40-2R6sWTWzuytwYaySWt4SlRi156Uiy
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69f290e4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=BroNgU71l7yOo7XZS_gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290229
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 4/22/26 6:30 AM, Arun Menon wrote:
> From: Arun Menon <armenon@redhat.com>
> 
> - Add subsection in VMState for TPM CRB with the newly introduced
>    command and response buffer GByteArrays, along with a needed callback,
>    so that newer QEMU only sends the buffers if it is necessary.
> - Implement a migration blocker to prevent migration of the VM if the
>    user manually enables chunking capability, cap-chunk, but the machine
>    type does not support it, using a new hw_compat property called
>    allow_chunk_migration.
> - Add a post_load_errp hook so that during a migration, the buffers are
>    validated before destination VM is started.
> 
> Signed-off-by: Arun Menon <armenon@redhat.com>
> ---
>   hw/core/machine.c |  1 +
>   hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 72 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6d27cf69a2..b590af0125 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@
> 
>   GlobalProperty hw_compat_11_0[] = {
>       { "tpm-crb", "cap-chunk", "off"},
> +    { "tpm-crb", "x-allow-chunk-migration", "off"},
>   };
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 29370d6f49..23e6948aee 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -24,6 +24,7 @@
>   #include "hw/pci/pci_ids.h"
>   #include "hw/acpi/tpm.h"
>   #include "migration/vmstate.h"
> +#include "migration/blocker.h"
>   #include "system/tpm_backend.h"
>   #include "system/tpm_util.h"
>   #include "system/reset.h"
> @@ -51,6 +52,8 @@ struct CRBState {
>       TPMPPI ppi;
> 
>       bool cap_chunk;
> +    bool allow_chunk_migration;
> +    Error *migration_blocker;
>   };
>   typedef struct CRBState CRBState;
> 
> @@ -353,12 +356,63 @@ static int tpm_crb_pre_save(void *opaque)
>       return 0;
>   }
> 
> +static bool tpm_crb_chunk_needed(void *opaque)
> +{
> +    CRBState *s = opaque;
> +
> +    if (!s->allow_chunk_migration) {
> +        return false;
> +    }
> +
> +    return ((s->command_buffer && s->command_buffer->len > 0) ||
> +            (s->response_buffer && s->response_buffer->len > 0));
> +}
> +
> +static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
> +{
> +    CRBState *s = opaque;
> +
> +    if (!s->response_buffer || !s->command_buffer) {
> +        error_setg(errp, "tpm-crb: Internal buffers are not allocated");

Could this happen that this state type is resumed but the buffers are 
not allocated?

> +        return false;
> +    }
> +    if (s->response_offset > s->response_buffer->len) {
> +        error_setg(errp, "tpm-crb: Invalid response "
> +                   "offset %" PRIu32 " in migration stream",
> +                   s->response_offset);
> +        return false;
> +    }

The check is correct but can this particular case occur other than 
through crafted input?

> +    if (s->response_buffer->len > s->be_buffer_size ||
> +        s->command_buffer->len > s->be_buffer_size) {

I suppose this could happen if I was running with a PQC-enable 
swtpm/libtpms and suspended at the right moment that when a chunked 
command or response was in the buffer and now I am trying to resume with 
a non-PQC-enabled swtpm that only has 4kb buffer, while the newer PQC 
one had 8kb buffer.

> +        error_setg(errp, "tpm-crb: Buffer sizes exceed backend capacity");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static const VMStateDescription vmstate_tpm_crb_chunk = {
> +    .name = "tpm-crb/chunk",
> +    .version_id = 0,
> +    .needed = tpm_crb_chunk_needed,
> +    .post_load_errp = tpm_crb_chunk_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
> +        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
> +        VMSTATE_UINT32(response_offset, CRBState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_tpm_crb = {
>       .name = "tpm-crb",
>       .pre_save = tpm_crb_pre_save,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
>           VMSTATE_END_OF_LIST(),
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_tpm_crb_chunk,
> +        NULL,
>       }
>   };
> 
> @@ -366,6 +420,8 @@ static const Property tpm_crb_properties[] = {
>       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>       DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>       DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
> +    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
> +                     allow_chunk_migration, true),
>   };
> 
>   static void tpm_crb_reset(void *dev)
> @@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
>   static void tpm_crb_realize(DeviceState *dev, Error **errp)
>   {
>       CRBState *s = CRB(dev);
> +    int ret;
> 
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");
> @@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>           error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> +    if (s->cap_chunk && !s->allow_chunk_migration) {
> +        error_setg(&s->migration_blocker,
> +                   "The tpm-crb device does not support chunk migration with "
> +                   "machine version less than 11.1");
> +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
> +        if (ret < 0) {
> +            return;
> +        }
> +    }
> 
>       memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
>           "tpm-crb-mmio", sizeof(s->regs));
> @@ -463,6 +529,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
> 
>       g_clear_pointer(&s->command_buffer, g_byte_array_unref);
>       g_clear_pointer(&s->response_buffer, g_byte_array_unref);
> +
> +    if (s->migration_blocker) {
> +        migrate_del_blocker(&s->migration_blocker);
> +        error_free(s->migration_blocker);
> +    }
>   }
> 
>   static void tpm_crb_class_init(ObjectClass *klass, const void *data)


