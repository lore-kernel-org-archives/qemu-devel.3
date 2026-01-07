Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAA3D0D164
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdYL2-0002by-2X; Wed, 07 Jan 2026 13:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdYKt-0002Wr-L5; Wed, 07 Jan 2026 13:32:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdYKp-0007ru-Ty; Wed, 07 Jan 2026 13:32:46 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6078dqKQ005656;
 Wed, 7 Jan 2026 18:32:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EaEEfO
 gJBlTZImekR5BvBOO84N4H7sicaukSxtDeFos=; b=Tq6VMlZ1s0jkAqvoGpbt8c
 JcMBjNZ1H9tDndONmDTRIkF+kWGW4uqvytka/d+XNXkgMBPlKA3I7xPuSKh2SdCQ
 gT2+hEwQ8qQ2XJoBYtgm9TjIc4rizsJB1Q3PljMvvb8M6gzOmANYuUK4zbYJ0rNq
 bMF5mkvhlN9tNzvHQlyO+P/xEQNrxj0t+DocTQVM0dIdXrvhUd+L8d4WpjiWYKQd
 BbhYEyZa/tAFzss4ObjUIbKfvfMElJkLm9CCnHuxfoYu4NvZPd0UHYCu/DyfwxXy
 7lV34/ZTLZG4p5Uq/cDUgOVztqaTk4CPWl4tPFeXx4ZVPByX6KK830jOlvDT4f9w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtsd3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:32:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607HqrAP005250;
 Wed, 7 Jan 2026 18:32:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexkap34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:32:41 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607IWdfP25952958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 18:32:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6C7A58059;
 Wed,  7 Jan 2026 18:32:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA32058055;
 Wed,  7 Jan 2026 18:32:38 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 18:32:38 +0000 (GMT)
Message-ID: <2f2bb112-34d7-4a5f-aad0-c5d0630bb064@linux.ibm.com>
Date: Wed, 7 Jan 2026 13:32:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pc-bios/s390-ccw: Add support for virtio-blk-pci IPL
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-8-jrossi@linux.ibm.com>
 <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <386824c5-d0f9-4384-a4de-d2ff5a3445d7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695ea6ca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=dcReAGJ9NW_a59aa5fUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dJM5jXeIoElGnArqSg422fvKpkgq2OsL
X-Proofpoint-ORIG-GUID: dJM5jXeIoElGnArqSg422fvKpkgq2OsL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX9iVxjdasIof+
 Xj4Ff4oUtpifhE8wDtQdn+TZuFvUXWjlSKnPI/lUvUbekaq9+szmaMwalPioF7JCcTz1wWgbHzj
 SfFIPyV73FwUTNCxY53+hlOng/+ystGlkzqkTV35W0COOXPD+0Qo8gbUBrsHkU341i3arOgxlfS
 R13o5TMsnBiXWOxUV0Hl3CEppU861ganiKhyg5mknqyStQaJPLvSYhEASbqtUbsy/aFIg8YnKvM
 DsP4pJfpnaeNgvI1CQeJLAxj/VyaKh0eX8bV5ijvtXyrRFZVfyHvAI61it6EWQpWbK1csX5lM6y
 WPRXlgkIhx56AyY1Mfv7v9LRI2Zcm18MsBnbvYqmtS2GZ4/sD0BkmkQqcg2XiUgOaihygvCvkra
 N5wDQxiYSjj8V+1VkION6QjYRZlO6V9VpwWIMdnnlzV1L3wObFOyhyXDlwP91hlqb2boJI6yoYX
 ivVvuQ7aqcIbTY0h7wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 1/7/26 9:44 AM, Thomas Huth wrote:
> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Enable virt-queue PCI configuration and add routines for 
>> virtio-blk-pci devices.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
>>   include/hw/s390x/ipl/qipl.h      |  10 +
>>   pc-bios/s390-ccw/virtio-pci.h    |  79 +++++++
>>   pc-bios/s390-ccw/virtio.h        |   1 +
>>   pc-bios/s390-ccw/main.c          |  60 +++++-
>>   pc-bios/s390-ccw/virtio-blkdev.c |   3 +
>>   pc-bios/s390-ccw/virtio-pci.c    | 360 +++++++++++++++++++++++++++++++
>>   pc-bios/s390-ccw/virtio.c        |   5 +
>>   pc-bios/s390-ccw/Makefile        |   2 +-
>>   8 files changed, 517 insertions(+), 3 deletions(-)
>>   create mode 100644 pc-bios/s390-ccw/virtio-pci.h
>>   create mode 100644 pc-bios/s390-ccw/virtio-pci.c
>>
>> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
>> index 8199b839f0..5c7779a1c3 100644
>> --- a/include/hw/s390x/ipl/qipl.h
>> +++ b/include/hw/s390x/ipl/qipl.h
>> @@ -22,6 +22,7 @@
>>     #define S390_IPL_TYPE_FCP 0x00
>>   #define S390_IPL_TYPE_CCW 0x02
>> +#define S390_IPL_TYPE_PCI 0x04
>>   #define S390_IPL_TYPE_PV 0x05
>>   #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>   @@ -105,6 +106,14 @@ struct IplBlockQemuScsi {
>>   } QEMU_PACKED;
>>   typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>>   +struct IplBlockPci {
>> +    uint32_t reserved0[80];
>> +    uint8_t  opt;
>> +    uint8_t  reserved1[3];
>> +    uint32_t fid;
>> +} QEMU_PACKED;
>> +typedef struct IplBlockPci IplBlockPci;
>
> Is this supposed to have the same positions for "fid" and "opt" as in 
> the ipl_pb0_nvme structure in the kernel 
> (arch/s390/include/uapi/asm/ipl.h)?

Yes, I think.  That was my intention anyway. Are you suggesting it 
shouldn't?

>
>>   union IplParameterBlock {
>>       struct {
>>           uint32_t len;
>> @@ -120,6 +129,7 @@ union IplParameterBlock {
>>               IplBlockFcp fcp;
>>               IPLBlockPV pv;
>>               IplBlockQemuScsi scsi;
>> +            IplBlockPci pci;
>>           };
>>       } QEMU_PACKED;
>>       struct {
> ...
>> diff --git a/pc-bios/s390-ccw/virtio-pci.c 
>> b/pc-bios/s390-ccw/virtio-pci.c
>> new file mode 100644
>> index 0000000000..838231d86c
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/virtio-pci.c
>> @@ -0,0 +1,360 @@
>> +/*
>> + * Functionality for virtio-pci
>> + *
>> + * Copyright 2025 IBM Corp.
>> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "clp.h"
>> +#include "pci.h"
>> +#include "helper.h"
>> +#include "s390-ccw.h"
>> +#include "virtio.h"
>> +#include "bswap.h"
>> +#include "virtio-pci.h"
>> +#include "s390-time.h"
>> +#include <stdio.h>
>> +
>> +/* Variable offsets used for reads/writes to modern memory regions */
>> +VirtioPciCap c_cap; /* Common capabilities  */
>> +VirtioPciCap d_cap; /* Device capabilities  */
>> +VirtioPciCap n_cap; /* Notify capabilities  */
>> +uint32_t notify_mult;
>> +uint16_t q_notify_offset;
>> +
>> +static int virtio_pci_set_status(VDev *vdev, uint8_t status)
>> +{
>> +    int rc = pci_write_byte(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_STATUS,
>> +                             c_cap.bar, status);
>> +    if (rc) {
>> +        puts("Failed to write virtio-pci status");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int virtio_pci_get_status(VDev *vdev, uint8_t *status)
>> +{
>> +    int rc = pci_read_byte(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_STATUS,
>> +                           c_cap.bar, status);
>> +    if (rc) {
>> +        puts("Failed to read virtio-pci status");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Find the position of the capability config within PCI configuration
>> + * space for a given cfg type.  Return the position if found, 
>> otherwise 0.
>> + */
>> +static uint8_t find_cap_pos(uint32_t fhandle, uint8_t cfg_type)
>> +{
>> +    uint8_t next, cfg;
>> +    int rc;
>> +
>> +    rc = pci_read_byte(fhandle, PCI_CAPABILITY_LIST, PCI_CFGBAR, 
>> &next);
>> +    rc |= pci_read_byte(fhandle, next + 3, PCI_CFGBAR, &cfg);
>> +
>> +    while (!rc && (cfg != cfg_type) && next) {
>> +        rc = pci_read_byte(fhandle, next + 1, PCI_CFGBAR, &next);
>> +        rc |= pci_read_byte(fhandle, next + 3, PCI_CFGBAR, &cfg);
>> +    }
>> +
>> +    return rc ? 0 : next;
>> +}
>> +
>> +static int virtio_pci_get_hfeatures(VDev *vdev, uint64_t *features)
>> +{
>> +    uint32_t feat0, feat1;
>> +    int rc;
>> +
>> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_DFSELECT,
>> +                           c_cap.bar, 0);
>> +
>> +    rc |= pci_read_bswap32(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DF,
>> +                           c_cap.bar, &feat0);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_DFSELECT,
>> +                            c_cap.bar, 1);
>> +
>> +    rc |= pci_read_bswap32(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_DF,
>> +                               c_cap.bar, &feat1);
>> +
>> +    if (rc) {
>> +        puts("Failed to get PCI feature bits");
>> +        return -EIO;
>> +    }
>> +
>> +    *features = (uint64_t) feat1 << 32;
>> +    *features |= (uint64_t) feat0;
>> +
>> +    return 0;
>> +}
>> +
>> +static int virtio_pci_set_gfeatures(VDev *vdev)
>> +{
>> +    int rc;
>> +
>> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_GFSELECT,
>> +                           c_cap.bar, 0);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
>> +                            c_cap.bar, vdev->guest_features[1]);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_GFSELECT,
>> +                            c_cap.bar, 1);
>> +
>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + VPCI_C_OFFSET_GF,
>> +                                c_cap.bar, vdev->guest_features[0]);
>> +
>> +    if (rc) {
>> +        puts("Failed to set PCI feature bits");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int virtio_pci_get_blk_config(VDev *vdev)
>> +{
>> +    return pci_read_flex(vdev->pci_fh, d_cap.off, d_cap.bar, 
>> &vdev->config.blk,
>> +                         sizeof(VirtioBlkConfig));
>
> I'm a little bit surprised that there does not seem to be any 
> endianess swapping for the config.blk data anywhere here ... isn't 
> that config space data supposed to be in little endian?
>
> ... oh, wait, you're not negotiating VIRTIO_F_VERSION_1, are you? ... 
> so the config space is still in big endian for legacy virtio? ... hmm, 
> I guess it's ok for now, but in the long run, I think we should rather 
> use VERSION_1 instead.

I will figure out how to fix the negotiations, both for this and 
VIRTIO_BLK_F_BLK_SIZE as you mention below.

>
>> +}
>> +
>> +/* virtio spec v1.3 section 4.1.2.1 */
>> +void virtio_pci_id2type(VDev *vdev, uint16_t device_id)
>> +{
>> +    switch (device_id) {
>> +    case 0x1001:
>> +        vdev->dev_type = VIRTIO_ID_BLOCK;
>> +        break;
>> +    case 0x1000: /* Other valid but currently unsupported virtio 
>> device types */
>> +    case 0x1004:
>> +    default:
>> +        vdev->dev_type = 0;
>> +    }
>> +}
>> +
>> +/*
>> + * Read PCI configuration space to find the offset of the Common, 
>> Device, and
>> + * Notification memory regions within the modern memory space.
>> + * Returns 0 if success, 1 if a capability could not be located, or a
>> + * negative RC if the configuration read failed.
>> + */
>> +static int virtio_pci_read_pci_cap_config(VDev *vdev)
>> +{
>> +    uint8_t pos;
>> +    int rc;
>> +
>> +    /* Common capabilities */
>> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_COMMON_CFG);
>> +    if (!pos) {
>> +        puts("Failed to locate PCI common configuration");
>> +        return 1;
>> +    }
>> +
>> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, 
>> &c_cap.bar);
>> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, 
>> PCI_CFGBAR,
>> +                               &c_cap.off)) {
>> +        puts("Failed to read PCI common configuration");
>> +        return -EIO;
>> +    }
>> +
>> +    /* Device capabilities */
>> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_DEVICE_CFG);
>> +    if (!pos) {
>> +        puts("Failed to locate PCI device configuration");
>> +        return 1;
>> +    }
>> +
>> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, 
>> &d_cap.bar);
>> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, 
>> PCI_CFGBAR,
>> +                               &d_cap.off)) {
>> +        puts("Failed to read PCI device configuration");
>> +        return -EIO;
>> +    }
>> +
>> +    /* Notification capabilities */
>> +    pos = find_cap_pos(vdev->pci_fh, VPCI_CAP_NOTIFY_CFG);
>> +    if (!pos) {
>> +        puts("Failed to locate PCI notification configuration");
>> +        return 1;
>> +    }
>> +
>> +    rc = pci_read_byte(vdev->pci_fh, pos + VPCI_CAP_BAR, PCI_CFGBAR, 
>> &n_cap.bar);
>> +    if (rc || pci_read_bswap32(vdev->pci_fh, pos + VPCI_CAP_OFFSET, 
>> PCI_CFGBAR,
>> +                               &n_cap.off)) {
>> +        puts("Failed to read PCI notification configuration");
>> +        return -EIO;
>> +    }
>> +
>> +    rc = pci_read_bswap32(vdev->pci_fh, pos + VPCI_N_CAP_MULT, 
>> PCI_CFGBAR, &notify_mult);
>> +    if (rc || pci_read_bswap16(vdev->pci_fh, d_cap.off + 
>> VPCI_C_OFFSET_Q_NOFF,
>> +                               d_cap.bar, &q_notify_offset)) {
>> +        puts("Failed to read notification queue configuration");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int virtio_pci_reset(VDev *vdev)
>> +{
>> +    int rc;
>> +    uint8_t status = VPCI_S_RESET;
>> +
>> +    rc = virtio_pci_set_status(vdev, status);
>> +    rc |= virtio_pci_get_status(vdev, &status);
>> +
>> +    if (rc || status) {
>> +        puts("Failed to reset virtio-pci device");
>> +        return 1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +int virtio_pci_set_selected_vq(VDev *vdev, uint16_t queue_num)
>> +{
>> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_Q_SELECT,
>> +                             c_cap.bar, queue_num);
>> +}
>> +
>> +int virtio_pci_set_queue_size(VDev *vdev, uint16_t queue_size)
>> +{
>> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_Q_SIZE,
>> +                             c_cap.bar, queue_size);
>> +}
>> +
>> +static int virtio_pci_set_queue_enable(VDev *vdev, uint16_t enabled)
>> +{
>> +    return pci_bswap16_write(vdev->pci_fh, c_cap.off + 
>> VPCI_C_OFFSET_Q_ENABLE,
>> +                             c_cap.bar, enabled);
>> +}
>> +
>> +static int set_pci_vq_addr(VDev *vdev, uint64_t config_off, void *addr)
>> +{
>> +    return pci_bswap64_write(vdev->pci_fh, c_cap.off + config_off, 
>> c_cap.bar,
>> +                             (uint64_t) addr);
>> +}
>> +
>> +int virtio_pci_setup(VDev *vdev)
>> +{
>> +    VRing *vr;
>> +    int rc;
>> +    uint64_t pci_features;
>> +    uint8_t status;
>> +    int i = 0;
>> +
>> +    vdev->config.blk.blk_size = 0;
>
> For really getting blk_size, I think you should negotiate 
> VIRTIO_BLK_F_BLK_SIZE ?
>
> Also, I assume the generic part of this function should rather be 
> agnostic of virtio-block specific settings instead, so it can be used 
> for virtio-net-pci and virtio-scsi-pci later? So the above line should 
> likely rather go into the "case VIRTIO_ID_BLOCK" part below?

In the existing virtio_ccw_setup code, config.blk.blk_size is 
initialized to 0 for all device types like this, which is why I did it 
that way here too.

Conceptually, I agree that it makes more sense to do it only for actual 
block devices that care about it.  I'll check if there is any reason why 
it was done this way in the CCW code to begin with, but probably it can 
be moved it into the VIRTIO_ID_BLOCK case.

>
>> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>> +    vdev->cmd_vr_idx = 0;
>> +
>> +    if (virtio_reset(vdev)) {
>> +        return -EIO;
>> +    }
>> +
>> +    status = VPCI_S_ACKNOWLEDGE;
>> +    rc = virtio_pci_set_status(vdev, status);
>> +    if (rc) {
>> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
>> +        return -EIO;
>> +    }
>> +
>> +    rc = virtio_pci_read_pci_cap_config(vdev);
>> +    if (rc) {
>> +        printf("Invalid PCI capabilities");
>> +        return -EIO;
>> +    }
>> +
>> +    switch (vdev->dev_type) {
>> +    case VIRTIO_ID_BLOCK:
>> +        vdev->nr_vqs = 1;
>> +        vdev->cmd_vr_idx = 0;
>> +        virtio_pci_get_blk_config(vdev);
>> +        break;
>> +    default:
>> +        puts("Unsupported virtio device");
>> +        return -ENODEV;
>> +    }
>> +
>> +    status |= VPCI_S_DRIVER;
>> +    rc = virtio_pci_set_status(vdev, status);
>> +    if (rc) {
>> +        puts("Set status failed");
>> +        return -EIO;
>> +    }
>> +
>> +    /* Feature negotiation */
>> +    rc = virtio_pci_get_hfeatures(vdev, &pci_features);
>> +    if (rc || virtio_pci_set_gfeatures(vdev)) {
>> +        return -EIO;
>> +    }
>> +
>> +    /* Configure virt-queues for pci */
>> +    for (i = 0; i < vdev->nr_vqs; i++) {
>> +        VqInfo info = {
>> +            .queue = (unsigned long long) virtio_get_ring_area() + 
>> (i * VIRTIO_RING_SIZE),
>> +            .align = KVM_S390_VIRTIO_RING_ALIGN,
>> +            .index = i,
>> +            .num = 0,
>> +        };
>> +
>> +        vr = &vdev->vrings[i];
>> +
>> +        if (pci_read_flex(vdev->pci_fh, VPCI_C_COMMON_NUMQ, 
>> c_cap.bar, &info.num, 2)) {
>> +            return -EIO;
>> +        }
>> +
>> +        vring_init(vr, &info);
>> +
>> +        if (virtio_pci_set_selected_vq(vdev, vr->id)) {
>> +            puts("Failed to set selected virt-queue");
>> +            return -EIO;
>> +        }
>> +
>> +        if (virtio_pci_set_queue_size(vdev, VIRTIO_RING_SIZE)) {
>> +            puts("Failed to set virt-queue size");
>> +            return -EIO;
>> +        }
>> +
>> +        rc = set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_DESCLO, vr->desc);
>> +        rc |= set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_AVAILLO, 
>> vr->avail);
>> +        rc |= set_pci_vq_addr(vdev, VPCI_C_OFFSET_Q_USEDLO, vr->used);
>> +        if (rc) {
>> +            puts("Failed to configure virt-queue address");
>> +            return -EIO;
>> +        }
>> +
>> +        if (virtio_pci_set_queue_enable(vdev, true)) {
>> +            puts("Failed to set virt-queue enabled");
>> +            return -EIO;
>> +        }
>> +    }
>> +
>> +    status |= VPCI_S_FEATURES_OK | VPCI_S_DRIVER_OK;
>> +    return virtio_pci_set_status(vdev, status);
>> +}
>
>  Thomas
>
>


