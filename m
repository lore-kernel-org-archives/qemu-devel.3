Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E1FD8769
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UMY-0000zY-O3; Tue, 17 Mar 2026 09:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UMV-0000zE-Kf; Tue, 17 Mar 2026 09:21:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UMU-0005Ft-0j; Tue, 17 Mar 2026 09:21:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H84qso1106118; Tue, 17 Mar 2026 13:21:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DwFBgC
 L1VDumzAsXnCO3XVTFKMxJLrJbY0T8Z1BBadA=; b=NIbtIyTsbImZwqJ54bKZhD
 Zayt7r5d0+uZ7gDH2+vhUrlPoagy+yu1WAyWbL9211zvYPTgSxiJKn8XkJ2o8jle
 CDA+s18pt2ivbv4Ar0IK8V2cZyX3UPgfPor5YUgFLDTTPuGDAs0W0ka00KYQmJmU
 gCYkbKuJ1sZuN1Wrsdf+7GV4SnP7w324Ogjaya6UmnjxamuDHYBVQdc6uDTRHPA9
 3m2Lfr1pIX6lpkQL04CfACdMLJ4vk5Gfc5oIfC2ubhi8wqMVNBuXPCdOAytu4X5B
 CJ0KgXf2wmxnHLWATU8tWRyyS/5zlYy0I5w5gwALSVz7vyLQfPQCS7niQYOGZRiw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64my0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:21:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HAwiJU014033;
 Tue, 17 Mar 2026 13:21:22 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy1ckm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:21:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDKxC728901968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:20:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DC8758055;
 Tue, 17 Mar 2026 13:21:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4EA1058043;
 Tue, 17 Mar 2026 13:21:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:21:21 +0000 (GMT)
Message-ID: <1772d0f3-8d70-4898-ad57-3d83428a512c@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:21:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] hw/tpm: Propagate @ppi_enabled to tpm_tis_reset()
 and remove in TPMState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <20260317120241.16320-5-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260317120241.16320-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: HcK19_EUIyy9tVKAyLc0pONlHw75gV4T
X-Proofpoint-GUID: jPagGLtBY0JpXyHZA8np95oXiG_TsD43
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b95554 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=l6Y9YHerYFtNExeiMG0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNyBTYWx0ZWRfX32ExAajzt7lr
 URoME1fahPoLvKADyAb7BIINu0Lc0rw+PYGflq3NyY/GfeJlcKtEExuQnjv+JOHKwayLSp34IQi
 d4aAzUkHnNCWXnicQz/Jrr912cM3mONgBG4hvaT5NfpT67pARiRlpw1RCcAoF4JRqYZHEAsl3pM
 EsWaC/74ef/8dbcbFsuUQYL/S7gnjCf66DkDjp8ITkQg+wUyN9hqcPWh73kIX2VSKkvcRPETw46
 tNbm/75n692EYoRbMWovFC7eH05qjhu5YlcfOplMg/4Wm3NsUrW/cq+va6DRwESDufKHUMWsvyS
 BItMmBTrcfZRvD0zQGxkuyqHr+nHehiNLk6NBMZSZchs6jNbl2K+EjnBypFXMx+nzNIo0d4xO1+
 nMjnmWggnoycCFzS0zwXIeE3LSAnZsOT3PPNFtqCnCX5EAI/kFnHTGp7LbZtB/ejNTVWaeivu4B
 Gwv6zYtu6DP18wsKqIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 3/17/26 8:02 AM, Philippe Mathieu-Daudé wrote:
> Of TMP devices using FIFO mode, only the ISA variant has PPI,

Of the TPM devices ...

> and call tpm_ppi_init() to initialize the PPI state. Propagate

s/call/calls

> @ppi_enabled to tpm_tis_reset() so it only resets the PPI part
> when requested (ISA case) otherwise the PPI is in uninitialized
> state. Remove the now unused TPMState::ppi_enabled field. Set
> the generic TPMIfClass::ppi_enabled so ACPI subsystem can keep
> checking its availability.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/tpm/tpm_tis.h        |  3 +--
>   hw/tpm/tpm_tis_common.c |  4 ++--
>   hw/tpm/tpm_tis_i2c.c    |  2 +-
>   hw/tpm/tpm_tis_isa.c    | 10 ++++------
>   hw/tpm/tpm_tis_sysbus.c |  2 +-
>   5 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index 184632ff66b..1531620bf9d 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -75,7 +75,6 @@ typedef struct TPMState {
>   
>       size_t be_buffer_size;
>   
> -    bool ppi_enabled;
>       TPMPPI ppi;
>   } TPMState;
>   
> @@ -83,7 +82,7 @@ extern const VMStateDescription vmstate_locty;
>   extern const MemoryRegionOps tpm_tis_memory_ops;
>   
>   int tpm_tis_pre_save(TPMState *s);
> -void tpm_tis_reset(TPMState *s);
> +void tpm_tis_reset(TPMState *s, bool ppi_enabled);
>   enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
>   void tpm_tis_request_completed(TPMState *s, int ret);
>   uint32_t tpm_tis_read_data(TPMState *s, hwaddr addr, unsigned size);
> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
> index f594b15b8ab..a134d5c2059 100644
> --- a/hw/tpm/tpm_tis_common.c
> +++ b/hw/tpm/tpm_tis_common.c
> @@ -813,7 +813,7 @@ enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
>    * This function is called when the machine starts, resets or due to
>    * S3 resume.
>    */
> -void tpm_tis_reset(TPMState *s)
> +void tpm_tis_reset(TPMState *s, bool ppi_enabled)
>   {
>       int c;
>   
> @@ -821,7 +821,7 @@ void tpm_tis_reset(TPMState *s)
>       s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
>                               TPM_TIS_BUFFER_MAX);
>   
> -    if (s->ppi_enabled) {
> +    if (ppi_enabled) {
>           tpm_ppi_reset(&s->ppi);
>       }
>       tpm_backend_reset(s->be_driver);
> diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
> index 9f13e0ec120..b4f258c7bcb 100644
> --- a/hw/tpm/tpm_tis_i2c.c
> +++ b/hw/tpm/tpm_tis_i2c.c
> @@ -523,7 +523,7 @@ static void tpm_tis_i2c_reset(DeviceState *dev)
>       i2cst->csum_enable = 0;
>       i2cst->loc_sel = 0x00;
>   
> -    return tpm_tis_reset(s);
> +    return tpm_tis_reset(s, false);
>   }
>   
>   static void tpm_tis_i2c_class_init(ObjectClass *klass, const void *data)
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 61e95434f5b..1ca403241de 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -88,13 +88,12 @@ static void tpm_tis_isa_reset(DeviceState *dev)
>       TPMStateISA *isadev = TPM_TIS_ISA(dev);
>       TPMState *s = &isadev->state;
>   
> -    return tpm_tis_reset(s);
> +    return tpm_tis_reset(s, true);
>   }
>   
>   static const Property tpm_tis_isa_properties[] = {
>       DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
>       DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
> -    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
>   };
>   
>   static void tpm_tis_isa_initfn(Object *obj)
> @@ -132,10 +131,8 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                   TPM_TIS_ADDR_BASE, &s->mmio);
>   
> -    if (s->ppi_enabled) {
> -        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> -                     TPM_PPI_ADDR_BASE, OBJECT(dev));
> -    }
> +    tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> +                 TPM_PPI_ADDR_BASE, OBJECT(dev));
>   }
>   
>   static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> @@ -175,6 +172,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, const void *data)
>       device_class_set_props(dc, tpm_tis_isa_properties);
>       dc->vmsd  = &vmstate_tpm_tis_isa;
>       tc->model = TPM_MODEL_TPM_TIS;
> +    tc->ppi_enabled = true;
>       dc->realize = tpm_tis_isa_realizefn;
>       device_class_set_legacy_reset(dc, tpm_tis_isa_reset);
>       tc->request_completed = tpm_tis_isa_request_completed;
> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> index e9372e73163..dd30344d5ac 100644
> --- a/hw/tpm/tpm_tis_sysbus.c
> +++ b/hw/tpm/tpm_tis_sysbus.c
> @@ -87,7 +87,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
>       TPMState *s = &sbdev->state;
>   
> -    return tpm_tis_reset(s);
> +    return tpm_tis_reset(s, false);
>   }
>   
>   static const Property tpm_tis_sysbus_properties[] = {

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


