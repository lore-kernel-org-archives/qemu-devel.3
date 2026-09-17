Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8046FC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FhS-0002ry-2i; Thu, 17 Sep 2026 13:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7FhE-0002pu-7u; Thu, 17 Sep 2026 13:14:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x7FhC-0003y1-3t; Thu, 17 Sep 2026 13:14:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HE1UmH1536242; Thu, 17 Sep 2026 17:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=m1yBLV
 HckyGCJWyUYHrOAJXVzQfiaywqr7xwH/UHK5U=; b=pX16eKfARbNQGfXsnMj2ws
 VT/khf6wUBDZCQQIAUxRz4WVjk5w5j/epe5gmGR1CtP0eG/b4GPAXPq9Wlkhx9NU
 qvne0vSdglK9GSXHhi217c0kzjr5H9eTdWIxvLFfY5itG+/atEF5pkx7AATIHAaY
 wiyZeFuJJ2x8fGa0KnBRzD9JqoTLN8gcGYTCywMVXnkVItdYMWV5EueKwHJraqnu
 38JIdJJFg7Jik1RiAfUr8KUNkBsD5O39BBylAFrKZKeRBrvTpk8hg2MQ0DMPIqRn
 g7QWsvMIykfQCml8MTi4/0I+bZaO9UfyC3XtDJoMbLWrNBUlbO9xQRL0rix+Me/Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5ebbfg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:14:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH8wql3546797; Thu, 17 Sep 2026 17:14:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5ffbf6a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:14:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HHEWSN40174030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 17:14:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5CCD20049;
 Thu, 17 Sep 2026 17:14:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 358EF2004B;
 Thu, 17 Sep 2026 17:14:29 +0000 (GMT)
Received: from [9.39.22.229] (unknown [9.39.22.229])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 17:14:28 +0000 (GMT)
Message-ID: <85471317-0434-46bc-8c44-d899a3bcd177@linux.ibm.com>
Date: Thu, 17 Sep 2026 22:44:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] ppc/spapr: add PReP boot partition detection
To: uverma@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-2-uverma@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260817102733.605346-2-uverma@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfX/aCwfUTL4udU
 qdmnpl2xEu6FH8/HMR38AsTDWhu607a4qp4kpjRDlh/RmFBPbFWiU+8ClJ0MQ0YGEXLYJGTX1y8
 RjPaH6vt/nu/q2SHTU0kEB6JV3LBnCPjGKhElJZcnNv2nJAYR83iVbFC2YhXI3D9uXiHB/+CoAG
 MEX+gtQIZ7QxkW6krik9sDGlvC5AtROfSoMK965kZKCPaHzf2eqQLZcgQsAGx32YbV1j7xfsHz3
 Un6SjvnUH7DvlM3xX9TryoNwPNJpVKti3H/UbQQrFAC6hE7wdkPa/i8h3QlR+ZEHDRPHyteqOaP
 5WKd/GaCuqDdpbsyOCHyt4LlAAW/NZUd26ENvlKocZrH9kMHgu4FXB776lnVyuRFLeJ4s2HDMrH
 gryfcQTLHIrfhNv2w0OorWFRDfr4WBQrrDgu76nZid1/NddQUiRNvfdl+isX/CWaMHGbq0tP44G
 iveVJFOk/Nc0P7OKmMw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aac1ffd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=jPD9I9OL_0JefA9qJ9oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mfwW1oK0paiSfmyJSm--U2su__SSmlcY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI0MyBTYWx0ZWRfXx6i5fJh2Qg3U
 i80TwJAhTxAxEgcDWBPasKp2OPAF+dEH8DfRk6fbqiOl3zkvZzzhZfeYjoKVFT9GG6ni9vyCbEM
 /T92JiMXJdzzyqgXxHMw03+7Qfk0I4M=
X-Proofpoint-GUID: WjNsAADu8J9r37w_4ipCNuZitilorEMF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170243
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
> From: Utkarsh Verma <uverma@linux.ibm.com>
> 
> Add spapr_vof_partition.c which implements basic MBR and GPT partition
> table scanning to locate the PReP boot partition during VOF enabled boot.
> 
> AI-used-for: code
> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
> ---
>   hw/ppc/meson.build           |   5 +-
>   hw/ppc/spapr_vof_partition.c | 176 +++++++++++++++++++++++++++++++++++
>   include/hw/ppc/spapr_vof.h   |  14 +++
>   3 files changed, 194 insertions(+), 1 deletion(-)
>   create mode 100644 hw/ppc/spapr_vof_partition.c
>   create mode 100644 include/hw/ppc/spapr_vof.h
> 
> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
> index 37aa535db2..68a5d2622f 100644
> --- a/hw/ppc/meson.build
> +++ b/hw/ppc/meson.build
> @@ -93,6 +93,9 @@ ppc_ss.add(when: 'CONFIG_AMIGAONE', if_true: files('amigaone.c'))
>   ppc_ss.add(when: 'CONFIG_PEGASOS', if_true: files('pegasos.c'))
>   
>   ppc_ss.add(when: 'CONFIG_VOF', if_true: files('vof.c'))
> -ppc_ss.add(when: ['CONFIG_VOF', 'CONFIG_PSERIES'], if_true: files('spapr_vof.c'))
> +ppc_ss.add(when: ['CONFIG_VOF', 'CONFIG_PSERIES'], if_true: files(
> +  'spapr_vof.c',
> +  'spapr_vof_partition.c',
> +))
>   
>   hw_arch += {'ppc': ppc_ss}
> diff --git a/hw/ppc/spapr_vof_partition.c b/hw/ppc/spapr_vof_partition.c
> new file mode 100644
> index 0000000000..ced2818998
> --- /dev/null
> +++ b/hw/ppc/spapr_vof_partition.c
> @@ -0,0 +1,176 @@
> +/*
> + * QEMU PowerPC sPAPR VOF Partition Table Support.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This implements partition table detection for VOF boot,
> + * supporting MBR and GPT partition tables with focus on PReP boot partition.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bswap.h"
> +#include "qemu/error-report.h"
> +#include "system/block-backend-io.h"
> +#include "hw/ppc/spapr_vof.h"
> +
> +#define SECTOR_SIZE              512
> +#define MBR_PARTITION_ENTRY_SIZE 16
> +#define MBR_PARTITION_TABLE_OFFSET 446
> +#define MBR_NUM_PARTITIONS       4
> +
> +#define PARTITION_TYPE_PREP      0x41  /* PReP Boot partition */
> +#define PARTITION_TYPE_GPT       0xEE
> +
> +#define GPT_SIGNATURE            "EFI PART"
> +#define GPT_SIGNATURE_SIZE       8
> +
> +/* PReP Boot: 9E1A2D38-C612-4316-AA26-8B49521E5A8B */
> +static const uint8_t GUID_PREP_BOOT[16] = {
> +    0x38, 0x2D, 0x1A, 0x9E, 0x12, 0xC6, 0x16, 0x43,
> +    0xAA, 0x26, 0x8B, 0x49, 0x52, 0x1E, 0x5A, 0x8B
> +};
> +
> +typedef struct MBRPartitionEntry {
> +    uint8_t  boot_flag;
> +    uint8_t  start_chs[3];
> +    uint8_t  type;
> +    uint8_t  end_chs[3];
> +    uint32_t start_lba;
> +    uint32_t num_sectors;
> +} QEMU_PACKED MBRPartitionEntry;
> +
> +typedef struct GPTHeader {
> +    char     signature[8];
> +    uint32_t revision;
> +    uint32_t header_size;
> +    uint32_t header_crc32;
> +    uint32_t reserved;
> +    uint64_t current_lba;
> +    uint64_t backup_lba;
> +    uint64_t first_usable_lba;
> +    uint64_t last_usable_lba;
> +    uint8_t  disk_guid[16];
> +    uint64_t partition_entries_lba;
> +    uint32_t num_partition_entries;
> +    uint32_t partition_entry_size;
> +    uint32_t partition_array_crc32;
> +} QEMU_PACKED GPTHeader;
> +
> +typedef struct GPTPartitionEntry {
> +    uint8_t  type_guid[16];
> +    uint8_t  partition_guid[16];
> +    uint64_t first_lba;
> +    uint64_t last_lba;
> +    uint64_t attributes;
> +    uint16_t name[36];
> +} QEMU_PACKED GPTPartitionEntry;
> +
> +static bool find_prep_partition_gpt(BlockBackend *blk,
> +                                    uint64_t *offset, uint64_t *size)
> +{
> +    uint8_t lba1[SECTOR_SIZE];
> +    GPTHeader *header;
> +    uint64_t entries_lba;
> +    uint32_t num_entries;
> +    uint32_t entry_size;
> +    uint64_t current_entry_offset;
> +    uint8_t *buf;
> +    GPTPartitionEntry *current_entry;
> +    uint32_t i;
> +    int ret;
> +
> +    ret = blk_pread(blk, SECTOR_SIZE, SECTOR_SIZE, lba1, 0);
> +    if (ret < 0) {
> +        warn_report("GPT: failed to read LBA1 (ret=%d)", ret);
> +        return false;
> +    }
> +
> +    header = (GPTHeader *)lba1;
> +
> +    if (memcmp(header->signature, GPT_SIGNATURE, GPT_SIGNATURE_SIZE) != 0) {
> +        return false;
> +    }
> +
> +    entries_lba = le64_to_cpu(header->partition_entries_lba);
> +    num_entries = le32_to_cpu(header->num_partition_entries);
> +    entry_size = le32_to_cpu(header->partition_entry_size);
> +
> +    if (num_entries > 128) {
> +        num_entries = 128;
> +    }
Why is silently truncating to 128 the right behaviour?

This bounds the loop, which is good, but it also means that a valid PReP 
partition after entry 127 will not be found. If 128 is an intentional 
VOF limitation, can we document that? Otherwise it may be better to 
validate the table size and iterate the actual number of entries subject 
to an explicit resource limit.
> +
> +    if (entry_size < 128) {
> +        return false;
> +    }
> +
> +    buf = g_malloc(entry_size);
The "entry_size" comes directly from the GPT header, so checking only 
the lower bound means a malformed image can drive an arbitrarily large 
host allocation here.

Do we need to allocate "entry_size" bytes at all?

We only consume the fixed fields at the beginning of the GPT entry. It 
seems safer to use `entry_size` only as the stride between entries and 
read `sizeof(GPTPartitionEntry)` bytes for each entry after checking 
that `entry_size >= sizeof(GPTPartitionEntry)`.

That also avoids having to invent an arbitrary maximum GPT entry size.

> +    for (i = 0; i < num_entries; i++) {
> +        current_entry_offset = (entries_lba * SECTOR_SIZE) +
> +                               ((uint64_t)i * entry_size);
Both the multiplication and addition are based on image-controlled 
fields. Could we validate the complete partition-entry array against 
blk_getlength() using checked arithmetic before iterating it?
> +
> +        ret = blk_pread(blk, current_entry_offset, entry_size, buf, 0);
> +        if (ret < 0) {
> +            warn_report("GPT: failed to read partition entry %u "
> +                        "(ret=%d)", i, ret);
> +            g_free(buf);
> +            return false;
> +        }
> +
> +        current_entry = (GPTPartitionEntry *)buf;
> +        if (memcmp(current_entry->type_guid, GUID_PREP_BOOT,
> +                   sizeof(GUID_PREP_BOOT)) == 0) {
> +            *offset = le64_to_cpu(current_entry->first_lba) * SECTOR_SIZE;
> +            *size = (le64_to_cpu(current_entry->last_lba) -
> +                     le64_to_cpu(current_entry->first_lba) + 1) * SECTOR_SIZE;
I think this needs validation before returning the partition.

If last_lba < first_lba, the subtraction underflows and produces a very 
large partition size. There are also multiplication/partition-end 
overflow cases.

I'd expect something along the lines of:
	first_lba <= last_lba
	first_lba <= disk_last_lba
	last_lba <= disk_last_lba

> +            g_free(buf);
> +            return true;
> +        }
> +    }
> +    g_free(buf);
> +    return false;
> +}
> +
> +static bool find_prep_partition_mbr(BlockBackend *blk,
> +                                    uint64_t *offset, uint64_t *size)
> +{
> +    uint8_t mbr[SECTOR_SIZE];
> +    MBRPartitionEntry *entry;
> +    int ret;
> +    int i;
> +
> +    ret = blk_pread(blk, 0, SECTOR_SIZE, mbr, 0);
> +    if (ret < 0) {
> +        warn_report("MBR: failed to read MBR sector (ret=%d)", ret);
> +        return false;
> +    }
> +
> +    /* MBR boot signature: byte 510 = 0x55, byte 511 = 0xAA */
> +    if (mbr[510] != 0x55 || mbr[511] != 0xAA) {
> +        return false;
> +    }
> +
> +    for (i = 0; i < MBR_NUM_PARTITIONS; i++) {
> +        entry = (MBRPartitionEntry *)&mbr[MBR_PARTITION_TABLE_OFFSET +
> +                                          i * MBR_PARTITION_ENTRY_SIZE];
> +
> +        if (entry->type == PARTITION_TYPE_GPT) {
> +            return find_prep_partition_gpt(blk, offset, size);
> +        }
> +
> +        if (entry->type == PARTITION_TYPE_PREP) {
> +            *offset = (uint64_t)le32_to_cpu(entry->start_lba) * SECTOR_SIZE;
> +            *size = (uint64_t)le32_to_cpu(entry->num_sectors) * SECTOR_SIZE;
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
> +bool spapr_vof_find_prep_partition(BlockBackend *blk,
> +                                   uint64_t *offset, uint64_t *size)
> +{
> +    if (!blk) {
> +        return false;
> +    }
> +    return find_prep_partition_mbr(blk, offset, size);
> +}
> diff --git a/include/hw/ppc/spapr_vof.h b/include/hw/ppc/spapr_vof.h
> new file mode 100644
> index 0000000000..08787d2aeb
> --- /dev/null
> +++ b/include/hw/ppc/spapr_vof.h
> @@ -0,0 +1,14 @@
> +/*
> + * QEMU PowerPC sPAPR VOF Support
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef HW_SPAPR_VOF_H
> +#define HW_SPAPR_VOF_H
> +
> +typedef struct BlockBackend BlockBackend;
> +
> +bool spapr_vof_find_prep_partition(BlockBackend *blk,
> +                                   uint64_t *offset, uint64_t *size);
> +
> +#endif /* HW_SPAPR_VOF_H */

we parse header_size, CRC fields, usable-LBA fields, etc. into 
GPTHeader, but only check the signature.

I don't think CRC validation should replace range validation, but at 
least the header fields which determine the layout we consume should 
probably be validated before trusting the partition table.

check CRC validation posibilities .

Thanks,
Narayana Murty N


