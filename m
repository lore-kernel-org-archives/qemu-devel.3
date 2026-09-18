Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF74C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 05:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7R7e-0001m9-1b; Fri, 18 Sep 2026 01:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7R7c-0001lu-FX; Fri, 18 Sep 2026 01:26:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7R7Z-0002Tf-VS; Fri, 18 Sep 2026 01:26:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2Vhdi2364941; Fri, 18 Sep 2026 05:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QAlmgp
 3b0Scy6XZ4n20psc9RKoO1U230j9cdzcj3DAY=; b=XemuCu2y4tXd9zBqH4vffs
 xKafW9Ip40+tkSPVTcTW46yUqqOIfFTN3dd7RotvAkqsea4ULilp9Bc+IKfp5mqg
 TU7c+OpsAiN5unqTkGSMMOzDjfZ/3eIIBM0pNyQ70C8hJBsKBd2XJr+imKs1Viol
 GDNN2NjqrQLjzVkKuvmoTK2c8FRdhkIfIsAcIxaLWDge29Cd+UfY25S4Eocw75Fo
 F7/5jpZQKs5vYOeJfbe2pC+BoccQwi0HQPrEQ3YxSMlVRWntHT/w5c5gUur/RwN2
 0QkQ5b0/MkzwIWZv1HJ2+Qzo/02mNsr809fwaZK/djc4nuOG+WYsjkJuvnbvRPDg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqpbwv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:26:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2Z61X918852; Fri, 18 Sep 2026 05:26:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7geng8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 05:26:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68I5QdVP33358220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 05:26:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FCCD20043;
 Fri, 18 Sep 2026 05:26:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2353A20040;
 Fri, 18 Sep 2026 05:26:36 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Sep 2026 05:26:35 +0000 (GMT)
Message-ID: <26eadc61-98c1-4e5b-b842-9db88ccbb53e@linux.ibm.com>
Date: Fri, 18 Sep 2026 10:56:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Narayana Murty N <nnmlinux@linux.ibm.com>
Subject: Re: [RFC PATCH 8/8] ppc/spapr: implement vscsi-report-luns
 call-method for PAPR vSCSI
To: uverma@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, avnish@linux.ibm.com
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-9-uverma@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260817102733.605346-9-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX9JjiRYOLRQIK
 glLs78vTGrI6ROkcp7V6GLlrMvAaWSz+tU/KUU1Yk5Ja1VyiW3eSf2vqdq7g5DvaLcYeM2i2kpw
 AYYeJmSm6pTIIG9GaWo865xKOcf6tOJHiMawNkyPtGDqTE3GI4hHG2MC6mPAKK9tGkm9506tg0+
 E9cEM/sy1Rl1wJxyyheSkLZE5y/4ZhnoMkVJlyc+gyEONMpZ8Wa+mIMJMbemm4QHxaBZ8i2tBTV
 JQGN7mgUXiDw89E5GAjuGxMOjrUyGbSOBriS7QL2atkSB01NOlKE/fKdhmsPCq5UxBr9Hci1TKb
 OTys1C7/X4C7/N8OwDBeVB8eX9NtIb07LNNG4CFzr9Vga898wD/U8PQrDaj0KVPvblt5PWglBEr
 Hl1jH3U2W1cO5F6f05Ehr14wbCS4CiULvelWXCJ+omqKj2Ib329t5HUHhInbM1nQqxmyk3vQE1c
 1KqZxbh/8OvZRneaBFw==
X-Proofpoint-GUID: B7BGCkp9Tjd0tq___0lG75uuHDPX64G4
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aaccb95 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=0uGozwGDtrGqEDujfecA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LMwyl4hkqaVF8TJJK4BO6tX3b_oCAYUz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2NCBTYWx0ZWRfX5kfSFh8YC4m4
 m+m7ZurAAl3iOXBUQeufh2hG/TEQJJdX7MicmXLxGugnw65YdcBV5Enh90qxzD4WO25X6ArTttm
 mPoWVl2Ovq+nzwsRA43eaxaQYM3Yzas=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Utkarsh,

On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> GRUB (grub-core/disk/ieee1275/ofdisk.c) calls "vscsi-report-luns" on
> any PAPR virtual SCSI controller ihandle to enumerate attached LUNs
> before attempting to boot from disk. Without this method VOF returns
> PROM_ERROR and GRUB cannot find vSCSI disks.
> 
> Add vof_find_vscsi_bus() to locate the SCSIBus from a v-scsi@<reg>
> instance path, and vof_vscsi_report_luns() to build the response table
> in the VOF firmware region (0..fw_size), which GRUB never claims.
> 
> The table layout and SRP LUN encoding follow SLOF (vio-vscsi.fs
> dev-generate-srplun) each entry is an 8-byte big-endian cell whose
> low 4 bytes hold a guest pointer to a null-terminated list of SRP LUNs
> for that target; GRUB reads the pointer at offset table + 4 + 8*i.
> 
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>   hw/ppc/vof.c | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 212 insertions(+)
> 
> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
> index d3b0df30e4..b1bf5b1af0 100644
> --- a/hw/ppc/vof.c
> +++ b/hw/ppc/vof.c
> @@ -991,6 +991,198 @@ static void vof_instantiate_rtas(Error **errp)
>       error_setg(errp, "The firmware should have instantiated RTAS");
>   }
>   
> +#ifdef CONFIG_PSERIES
> +/* Combined (channel<<6)|id index space, matches SLOF dev-max-target. */
> +#define VSCSI_MAX_TARGETS 512
> +
> +/*
> + * Build the vscsi-report-luns response in guest memory.
> + *
> + * Returns catch_result (0 = success).  On success, *nentries_out and
> + * *table_addr_out describe the result table written into the VOF firmware
> + * region (0..fw_size), which GRUB never claims.
> + *
> + * Table layout (big-endian, 8 bytes per entry):
> + *   [table_addr + 8*i + 0..3] : 0x00000000
> + *   [table_addr + 8*i + 4..7] : guest pointer to null-terminated SRP LUN list
> + *
> + * GRUB reads each pointer as: *(uint32_t *)(table + 4 + 8 * i)
> + *
> + * SRP LUN encoding (SLOF dev-generate-srplun):
> + *   srplun = (0x8000 | bus | target | lun) << 48
> + *   where bus    = (combined_target >> 1) & 0x70
> + *         target = (combined_target & 0x3f) << 8
> + *         combined_target = (channel << 6) | id
> + */
> +static uint32_t vof_vscsi_report_luns(Vof *vof,
> +                                       SCSIBus *sbus,
> +                                       uint32_t *nentries_out,
> +                                       uint32_t *table_addr_out)
> +{
> +    uint64_t *lun_lists[VSCSI_MAX_TARGETS];
> +    int lun_counts[VSCSI_MAX_TARGETS];
> +    uint32_t ptr_table_size;
> +    uint32_t lun_data_size;
> +    uint32_t total_size;
> +    uint32_t base_addr;
> +    uint32_t lun_data_base;
> +    uint32_t lun_data_off;
> +    uint32_t table_idx;
> +    uint32_t table_addr;
> +    BusChild *kid;
> +    int nentries = 0;
> +    int t;
> +
> +    memset(lun_lists, 0, sizeof(lun_lists));
> +    memset(lun_counts, 0, sizeof(lun_counts));
> +
> +    QTAILQ_FOREACH(kid, &sbus->qbus.children, sibling) {
> +        SCSIDevice *dev = SCSI_DEVICE(kid->child);
> +        int combined_target;
> +        uint64_t bus_field;
> +        uint64_t target_field;
> +        uint64_t lun_field;
> +        uint64_t srplun;
> +        int cnt;
> +
> +        /* combined_target = (channel << 6) | id, matching SLOF bus+target */
> +        combined_target = ((dev->channel & 0x7) << 6) | (dev->id & 0x3f);
> +        if (combined_target >= VSCSI_MAX_TARGETS) {
> +            continue;
> +        }
> +
> +        bus_field    = ((uint64_t)combined_target >> 1) & 0x70ULL;
> +        target_field = ((uint64_t)combined_target & 0x3fULL) << 8;
> +        lun_field    = (uint64_t)(dev->lun & 0x1f);
> +        srplun = (0x8000ULL | bus_field | target_field | lun_field) << 48;
> +
> +        cnt = lun_counts[combined_target];
> +        lun_lists[combined_target] = g_realloc(lun_lists[combined_target],
> +                                               (cnt + 2) * sizeof(uint64_t));
> +        lun_lists[combined_target][cnt]     = cpu_to_be64(srplun);
> +        lun_lists[combined_target][cnt + 1] = 0;
> +        lun_counts[combined_target]++;
> +        if (cnt == 0) {
> +            nentries++;
> +        }
> +    }
> +
> +    if (nentries == 0) {
> +        *nentries_out   = 0;
> +        *table_addr_out = 0;
> +        return 0;
> +    }
> +
> +    ptr_table_size = nentries * sizeof(uint64_t);
> +    lun_data_size  = 0;
> +    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
> +        if (lun_lists[t]) {
> +            lun_data_size += (lun_counts[t] + 1) * sizeof(uint64_t);
> +        }
> +    }
> +    total_size = ptr_table_size + lun_data_size;
> +
> +    /*
> +     * Place the table in the VOF firmware region (0..fw_size), which GRUB
> +     * never claims.  Fit into the top of the first 4 KB page, 8-byte aligned.
> +     */
> +    if (total_size <= 0x1000 - (uint32_t)vof->fw_size) {
> +        base_addr = (0x1000 - total_size) & ~7U;
> +    } else {
> +        base_addr = 0x800;
> +    }
> +
I don't think the fallback to 0x800 is safe.

The VOF allocation map documented in spapr_vof_reset() currently has the 
initial firmware at approximately:

0 .. 0xc38

so 0x800 lies inside that firmware image.

For a sufficiently large LUN report, this branch therefore appears to 
write the table over active firmware memory.
> +    table_addr    = base_addr;
> +    lun_data_base = base_addr + ptr_table_size;
> +    lun_data_off  = 0;
> +    table_idx     = 0;
> +
> +    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
> +        uint32_t lun_buf_size;
> +        uint32_t lun_buf_addr;
> +        uint64_t cell_be64;
> +
> +        if (!lun_lists[t]) {
> +            continue;
> +        }
> +
> +        lun_buf_size = (lun_counts[t] + 1) * sizeof(uint64_t);
> +        lun_buf_addr = lun_data_base + lun_data_off;
> +
> +        if (VOF_MEM_WRITE(lun_buf_addr, lun_lists[t], lun_buf_size)
> +                != MEMTX_OK) {
> +            goto write_err;
> +        }
> +
> +        cell_be64 = cpu_to_be64((uint64_t)lun_buf_addr);
> +        if (VOF_MEM_WRITE(table_addr + table_idx * sizeof(uint64_t),
> +                          &cell_be64, sizeof(cell_be64)) != MEMTX_OK) {
> +            goto write_err;
> +        }
> +
> +        lun_data_off += lun_buf_size;
> +        table_idx++;
> +    }
> +
> +    *nentries_out   = table_idx;
> +    *table_addr_out = table_addr;
> +
> +    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
> +        g_free(lun_lists[t]);
> +    }
> +    return 0;
> +
> +write_err:
> +    for (t = 0; t < VSCSI_MAX_TARGETS; t++) {
> +        g_free(lun_lists[t]);
> +    }
> +    return PROM_ERROR;
> +}
> +
> +/*
> + * Return the SCSIBus for a v-scsi@<reg> path, or NULL if not found.
> + * Handles both "/vdevice/v-scsi@<reg>" and ".../v-scsi@<reg>/disk@..." paths.
> + */
> +static SCSIBus *vof_find_vscsi_bus(MachineState *ms, const char *path)
> +{
> +    SpaprMachineState *spapr = SPAPR_MACHINE(ms);
> +    const char *at;
> +    const char *endptr;
> +    unsigned long reg;
> +    SpaprVioDevice *vdev;
> +    BusState *bus;
> +
> +    if (!spapr || !spapr->vio_bus) {
> +        return NULL;
> +    }
> +
> +    at = strstr(path, "v-scsi@");
> +    if (!at) {
> +        return NULL;
> +    }
> +    at = strchr(at, '@');
> +    if (!at) {
> +        return NULL;
> +    }
> +
> +    if (qemu_strtoul(at + 1, &endptr, 16, &reg) || endptr == at + 1) {
> +        return NULL;
> +    }
> +
> +    vdev = spapr_vio_find_by_reg(spapr->vio_bus, (uint32_t)reg);
> +    if (!vdev) {
> +        return NULL;
> +    }
> +
> +    QLIST_FOREACH(bus, &vdev->qdev.child_bus, sibling) {
> +        if (object_dynamic_cast(OBJECT(bus), TYPE_SCSI_BUS)) {
> +            return SCSI_BUS(bus);
> +        }
> +    }
> +    return NULL;
> +}
> +#endif /* CONFIG_PSERIES */
> +
>   static uint32_t vof_call_method(MachineState *ms, Vof *vof, uint32_t methodaddr,
>                                   uint32_t ihandle, uint32_t param1,
>                                   uint32_t param2, uint32_t param3,
> @@ -1014,6 +1206,26 @@ static uint32_t vof_call_method(MachineState *ms, Vof *vof, uint32_t methodaddr,
>           goto trace_exit;
>       }
>   
> +#ifdef CONFIG_PSERIES
> +    /* vscsi-report-luns: enumerate LUNs for GRUB */
> +    if (strcmp(method, "vscsi-report-luns") == 0) {
> +        SCSIBus *sbus = vof_find_vscsi_bus(ms, inst->path);
> +
> +        if (sbus) {
> +            uint32_t nentries = 0, table_addr = 0;
> +            ret = vof_vscsi_report_luns(vof, sbus, &nentries, &table_addr);
> +            ret2[0] = nentries;
> +            ret2[1] = table_addr;
> +        } else {
> +            ret = 1;
> +            ret2[0] = 0;
> +            ret2[1] = 0;
> +        }
> +        trace_vof_method(ihandle, method, param1, ret, ret2[0]);
> +        goto trace_exit;
> +    }
> +#endif /* CONFIG_PSERIES */
> +
>       if (strcmp(inst->path, "/") == 0) {
>           if (strcmp(method, "ibm,client-architecture-support") == 0) {
>               Object *vmo = object_dynamic_cast(OBJECT(ms), TYPE_VOF_MACHINE_IF);


