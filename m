Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3C9FD8769
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UL3-0000B6-PG; Tue, 17 Mar 2026 09:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UL1-0000A6-JP; Tue, 17 Mar 2026 09:19:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UL0-0003YS-1v; Tue, 17 Mar 2026 09:19:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H6dOAM231841; Tue, 17 Mar 2026 13:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ghFTSc
 vQMXBuexcOc5T/h0Hghl2X3xZwLOdPjmUW80U=; b=r85qW7H67wzZJD6Om4WkP0
 pTEj3lOocBGCvep/Jbk43W4Dr9WwGDb8on7FDdj0rrhmWIxlYd0nPHj0K5YBDPM+
 PdLi0e1hbHLSX/MvBcaXcBat/YElkvfj1OZmQdySSPK4Fr89Qm2OmSOy+YuKnPDu
 MBsd+tYnN38FNR0RVwnzibZK/NnxiT4qg0jmMLBmdtF3rfYAX1oSaenYUdx+9Laz
 WILyrxeWpBylClsNCksn+oNoEYvrO2dmHJmvNn8OtAiE1ykvOTOYEmSEajs1nmnZ
 Dd0fFLUdSY1vjzqQgUoLJD4La3egjpkLlxh+NhTextNYUrBXf3TfsaOLTTSqSGjg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs4vfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:19:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HB2pJj015648;
 Tue, 17 Mar 2026 13:19:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n99ru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:19:50 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDJnjc16712360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:19:50 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C842C58054;
 Tue, 17 Mar 2026 13:19:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6A1358045;
 Tue, 17 Mar 2026 13:19:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:19:48 +0000 (GMT)
Message-ID: <abdffb51-a16e-42e6-81b2-ef07b42afaa7@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:19:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] hw/tpm: Remove CRBState::ppi_enabled field
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
 <20260317120241.16320-4-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260317120241.16320-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b954f8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=6EHarLFNaIoC1fKc9dIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: FTZnA7-aLoDLSTYtYqBDwOBq00DLvnKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNyBTYWx0ZWRfX4Qsia1vdph+G
 P4+pbo3fYvO/H7aGefssONtp/llp7/r0DmdtC6nS4kmIhCU3BaPz8fa3HVBmiX55xLMqGf3Mcg+
 fH6FIH5XrEkao0sISyLWSp02GUkWbulsYmidXuip8+jr3LRQQZaKoUMGwqPd4vX8+kwBMNQ4h7P
 Qt1nqflblgPnmq5FDHVJfs5eDecddnolypt/J9WVGYxCi7g0/ifZAGXXQI1DD5ZFLqZhn9UnRaW
 GF0QADoSdqv05O0u7hNSXia+bWIuMenvzrYOZZ2DCMHW159VhBoNhG32jRVJKefcX5YWbbL2C5c
 JuYF7CE3yGjozxlUdGv5xkV+mfTrlhTmEyGrMCwO+AOMUgXHLHFprFmLHrtDYelTF1HUY3035IS
 PMxLIjHOIrV7iECSPDy2TQ7vZ+0famWbEI9eQ0JW2ojYcj9M7sHYvxcrG0dqf6590s1/lkb1so2
 hPYedKbZHfiBV1rCaMg==
X-Proofpoint-GUID: x5wsr42XCDwDRtUj_mydoyv3GRN-Zyft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170117
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
> The CRBState::ppi_enabled boolean was only set in the
> hw_compat_3_1[] array, via the 'ppi=false' property.
> We removed all machines using that array, and the array
> itself in commit a861ffef237 ("hw/core/machine: Remove
> the hw_compat_3_1[] array"). We can safely remove the
> now unused property. Since CRB devices always use PPI,

s/use/uses

> simplify removing the CRBState::ppi_enabled field.
> Set the generic TPMIfClass::ppi_enabled so ACPI subsystem
> can keep checking its availability.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/tpm/tpm_crb.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 8723536f931..02701ab9480 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -43,7 +43,6 @@ struct CRBState {
> 
>       size_t be_buffer_size;
> 
> -    bool ppi_enabled;
>       TPMPPI ppi;
>   };
>   typedef struct CRBState CRBState;
> @@ -228,16 +227,13 @@ static const VMStateDescription vmstate_tpm_crb = {
> 
>   static const Property tpm_crb_properties[] = {
>       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> -    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
>   };
> 
>   static void tpm_crb_reset(void *dev)
>   {
>       CRBState *s = CRB(dev);
> 
> -    if (s->ppi_enabled) {
> -        tpm_ppi_reset(&s->ppi);
> -    }
> +    tpm_ppi_reset(&s->ppi);
>       tpm_backend_reset(s->tpmbe);
> 
>       memset(s->regs, 0, sizeof(s->regs));
> @@ -303,10 +299,8 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>       memory_region_add_subregion(get_system_memory(),
>           TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> 
> -    if (s->ppi_enabled) {
> -        tpm_ppi_init(&s->ppi, get_system_memory(),
> -                     TPM_PPI_ADDR_BASE, OBJECT(s));
> -    }
> +    tpm_ppi_init(&s->ppi, get_system_memory(),
> +                 TPM_PPI_ADDR_BASE, OBJECT(s));
> 
>       if (xen_enabled()) {
>           tpm_crb_reset(dev);
> @@ -325,6 +319,7 @@ static void tpm_crb_class_init(ObjectClass *klass, const void *data)
>       dc->vmsd  = &vmstate_tpm_crb;
>       dc->user_creatable = true;
>       tc->model = TPM_MODEL_TPM_CRB;
> +    tc->ppi_enabled = true;
>       tc->get_version = tpm_crb_get_version;
>       tc->request_completed = tpm_crb_request_completed;
> 

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



