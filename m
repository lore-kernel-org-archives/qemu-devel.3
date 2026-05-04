Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8430EFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 18:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJyNk-0002t5-Jh; Mon, 04 May 2026 14:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJyNd-0002pk-UB
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:50:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wJyNa-00037g-43
 for qemu-devel@nongnu.org; Mon, 04 May 2026 14:50:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644EcnJY2822130; Mon, 4 May 2026 18:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=prb3qB
 5qBPMPGeKenofKV3JCZyQk2RKWrStDhCVFsoo=; b=KRGmhXvqMjIVMZDlAT/Bws
 LLjKPgeSLtBbhS68yrYjQET7aYCjLv+SA+s4JCsQhR2dKs9XtPim8kBIpdFP4ZQW
 gyqfzwimIzsUTm8QilpDXesRyuoKws1yFDN6KR5CQn/2vP5bqDtJqXSRZPkVTJGz
 2uLiq+m5vlG6Fwz76zRis0Yyf1Pn0u0C9yVsacRfvtqt2R1M3ckqYg5G6Q2vbAqX
 J8H1J+Nle38AMHqaL20oNMM+XsWv2MBsVH5ovgJybuEMpJkUgr5KCIGp96ZhbHul
 UfV+f4Odlrtrt1acF9CGDyNdSjWWFNbWw4TeyN6mRH9uuQ3oACFC/XZ4nCVIyFNg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4g98g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 18:50:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644IdX44020943;
 Mon, 4 May 2026 18:50:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtg68y3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 18:50:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 644IohXP30015984
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 4 May 2026 18:50:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B66558053;
 Mon,  4 May 2026 18:50:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 675C858043;
 Mon,  4 May 2026 18:50:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  4 May 2026 18:50:42 +0000 (GMT)
Message-ID: <25fe5a1d-4963-464b-b49a-1cc5552b27ae@linux.ibm.com>
Date: Mon, 4 May 2026 14:50:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] hw/tpm: Add support for VM migration with TPM CRB
 chunking
To: Arun Menon <armenon@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 marcandre.lureau@redhat.com, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
 <20260504174234.13556-7-armenon@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260504174234.13556-7-armenon@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3MCBTYWx0ZWRfX+QGXdVntSVPA
 PW8KmAsraJ3RcAh5j5booWOhYxsDlqbjCPjHdDO1DOHr2vwNXL+U3RlNnOmCZzyy3coejfHqt+6
 zDBDI6Y0O3lO/P9tgcCS9WId6C0L4B/hjej74t3WGWE5CGl24YONjoyOMrbbUZ8jy7/bUPYlz4D
 creVXL+AHoXPTKpMhxf27422bjnDEeVbW8QbpfFCMZOD3E9T5/PJ06Hh8Xoq9aRrtvl6bzE/bGD
 7Z1/zYqtrxV6aSvgG1Urg+WWlZAfNT3AOxL8O/WWbRmZ48lkSsK8q3AVtP/AmiyQiZGFtTwSi6L
 o8lFgl/r/oaselnSupR+sgajaF5GBXUD1WtZb3gBTfsJeABAdUKcykiom4wDYCtdW+IKofmo4cI
 ecWylBLV95ef3Z55l2nf96xSAuf7pEw6gsSz18G3bwT/xysscXDNyLU8gsiXnoJiP589MA6Rl2P
 Kqd1+uUVVCAFgY1fDQg==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69f8ea85 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=3xw4kwFLrFTyH_d8cREA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dVDGC3vfQXFxM_COLcTBJ1LDOvRIiuWp
X-Proofpoint-ORIG-GUID: jtlLSBPq4RZzvshkFgHhAkytSg4dRCse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040170
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

On 5/4/26 1:42 PM, Arun Menon wrote:
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
>   hw/tpm/tpm_crb.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 69 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 4e0a93e231..30464b21ac 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
>   
>   GlobalProperty hw_compat_11_0[] = {
>       { "tpm-crb", "cap-chunk", "off" },
> +    { "tpm-crb", "x-allow-chunk-migration", "off" },
>   };
>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>   
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 5572d89268..98feb734d5 100644
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
> @@ -50,6 +51,8 @@ struct CRBState {
>       TPMPPI ppi;
>   
>       bool cap_chunk;
> +    bool allow_chunk_migration;
> +    Error *migration_blocker;
>   };
>   typedef struct CRBState CRBState;
>   
> @@ -352,18 +355,68 @@ static int tpm_crb_pre_save(void *opaque)
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
> +    /*
> +     * The external TPM emulator (example swtpm) determines the backend
> +     * buffer capacity (s->be_bufer_size). This check ensures that if we
> +     * migrate from a source with a PQC-enabled emulator that supports
> +     * larger buffers to a destination with a non-PQC emulator, the
> +     * migrated data does not exceed the destination's capacity.
> +     */
> +    if (s->response_buffer->len > s->be_buffer_size ||
> +        s->command_buffer->len > s->be_buffer_size) {
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
>   static const Property tpm_crb_properties[] = {
>       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>       DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
> +    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
> +                     allow_chunk_migration, true),
>   };
>   
>   static void tpm_crb_reset(void *dev)
> @@ -418,6 +471,7 @@ static void tpm_crb_reset(void *dev)
>   static void tpm_crb_realize(DeviceState *dev, Error **errp)
>   {
>       CRBState *s = CRB(dev);
> +    int ret;
>   
>       if (!tpm_find()) {
>           error_setg(errp, "at most one TPM device is permitted");
> @@ -427,6 +481,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
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
> @@ -457,6 +520,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
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


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


