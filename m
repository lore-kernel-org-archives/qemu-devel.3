Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00D5CF6BEC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdWYR-0003if-UC; Wed, 07 Jan 2026 11:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdWYK-0003a5-B6; Wed, 07 Jan 2026 11:38:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdWYF-0003s1-Tu; Wed, 07 Jan 2026 11:38:30 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6079Cm8j025314;
 Wed, 7 Jan 2026 16:38:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eYTSNW
 7SnBMQsMUVnddI5Ufn7Cay/9pY21JLAq6ylVg=; b=sx0aPX4YtXipaiEgvsv6aA
 cQoIs8RHfnaLkyDk2uop98Le8zaH0l8LJyDbJjg9C6Qa3kN7gS1mxOqWOSdBiPt7
 p5Piy4Mhkq8g8mix2XVzG72ubieK85JmafuHv6YViXHdh7CgeX2J40lYF5FiSXBM
 IVdm8+/qztzOTck25jPRrZCCxhEDeYZJPVOqWQOd37J0mCa5OVcSv1kN7QJcJTt8
 8Y0LVN4Q5nArYSX9w6wXZB4wKhZrOUZHycQuYFxgk6iGYH7nEpK1VIWSf6BV1IDz
 bro2XzcENkIqrwLrmHK6sMg8stB1KKNPnEieqjs3OdMQ9JnzdPLYaw5jbpQx2Bhg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtruec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 16:38:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607FZAOv012572;
 Wed, 7 Jan 2026 16:38:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjhy6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 16:38:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607GcMXk48431360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 16:38:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEE1858063;
 Wed,  7 Jan 2026 16:38:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01F2C58068;
 Wed,  7 Jan 2026 16:38:22 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 16:38:21 +0000 (GMT)
Message-ID: <bbb1ec46-3e59-4bfb-b656-7f07570ab981@linux.ibm.com>
Date: Wed, 7 Jan 2026 11:38:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-4-jrossi@linux.ibm.com>
 <1a5926ec-8bf5-49de-9228-595d3910275f@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <1a5926ec-8bf5-49de-9228-595d3910275f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695e8c01 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=ctsVLiZ_AAAA:8 a=8W_F8a7B4bqVqd1cZ4AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3VCIHQLkQthbvTRuo98s:22
X-Proofpoint-GUID: Yz-LNm3z6Ll27hh3c-gM4975kJ4TIj8X
X-Proofpoint-ORIG-GUID: Yz-LNm3z6Ll27hh3c-gM4975kJ4TIj8X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyOCBTYWx0ZWRfX/74hhH8dTixB
 zjFcF/fYoiDejjXVgB5iU6dVZM+luZ23mvR7epFDSbtMZ8N0iEpKVySm+8quImkansOjp0wJBUs
 4sBSFOOFgcuIL/mzC0WoQDptBjBeYsvM74PySl2TxofnMpGWTZFE3gSWDI/1Hl30ZHN9Bf257IE
 s2IkeIcdJ8mZ6rL8p7GqUJ2ZDJdWoxP5CTjZX+mD/JwIiLdNEghQNB5dxd2Ni6cu47+DkLgGyyb
 oqvwd1212areXvICRWCQZBR6Upo2c3YlWNsd7OB7Gp5lPT/aUFVXLjXgd1szateEkaw6RxXNSNm
 vgVCW+yEhX/wiBOxgLs9jN3sxUuWxTHqztdnAZTRCRiPLGxAEdxSv7Q9kFmSpCMVN12fjasoucJ
 XtSvRMoCCuvpUFA9WZH9uzRuzBUOSyvruH+iYm9eEJCNV4qD3tfCwAlnGbRyIAwlsLGD2mw+amf
 Xs+yfsZMzMQuGlXLwJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070128
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



On 1/7/26 4:40 AM, Thomas Huth wrote:
> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Separate the CCW specific virtio routines and create generic wrappers 
>> for easier
>> reuse of existing virtio functions with non-CCW devices.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
> ...
>> diff --git a/pc-bios/s390-ccw/virtio-ccw.c 
>> b/pc-bios/s390-ccw/virtio-ccw.c
>> new file mode 100644
>> index 0000000000..e121826625
>> --- /dev/null
>> +++ b/pc-bios/s390-ccw/virtio-ccw.c
>> @@ -0,0 +1,242 @@
>> +/*
>> + * Virtio functionality for CCW devices
>> + *
>> + * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
>> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi 
>> <jrossi@linux.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 
>> or (at
>> + * your option) any later version. See the COPYING file in the 
>> top-level
>> + * directory.
>> + */
>> +
>> +#include <string.h>
>> +#include "s390-ccw.h"
>> +#include "cio.h"
>> +#include "virtio.h"
>> +#include "virtio-ccw.h"
>> +#include "virtio-scsi.h"
>> +#include "bswap.h"
>> +#include "helper.h"
>> +#include "s390-time.h"
>> +
>> +/* virtio spec v1.0 para 4.3.3.2 */
>> +static long kvm_hypercall(unsigned long nr, unsigned long param1,
>> +                          unsigned long param2, unsigned long param3)
>> +{
>> +    register unsigned long r_nr asm("1") = nr;
>> +    register unsigned long r_param1 asm("2") = param1;
>> +    register unsigned long r_param2 asm("3") = param2;
>> +    register unsigned long r_param3 asm("4") = param3;
>> +    register long retval asm("2");
>> +
>> +    asm volatile ("diag %%r2,%%r4,0x500"
>> +                  : "=d" (retval)
>> +                  : "d" (r_nr), "0" (r_param1), "r"(r_param2), 
>> "d"(r_param3)
>> +                  : "memory", "cc");
>> +
>> +    return retval;
>> +}
>> +
>> +static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
>> +{
>> +    Ccw1 ccw = {};
>> +
>> +    ccw.cmd_code = cmd;
>> +    ccw.cda = (long)ptr;
>> +    ccw.count = len;
>> +
>> +    if (sli) {
>> +        ccw.flags |= CCW_FLAG_SLI;
>> +    }
>> +
>> +    return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), 
>> CCW_FMT1);
>> +}
>> +
>> +bool virtio_ccw_is_supported(SubChannelId schid)
>> +{
>> +    VDev *vdev = virtio_get_device();
> > +    vdev->schid = schid;
>
> At the calling site (virtio_ccw_setup), you're doing:
>
>  if (!virtio_ccw_is_supported(vdev->schid)) ...
>
> i.e. vdev->schid is already set up, and you already have a pointer to 
> vdev there. So I think it would make more sense to replace the "schid" 
> parameter of this function here to a "vdev" pointer, and drop the call 
> to virtio_get_device() here, and not to re-assign vdev->schid here.

I will work on cleaning up the vdev->schid assignments and accesses 
throughout.  Eric pointed out several areas that it seems to be 
redundant also.

>
>> +    memset(&vdev->senseid, 0, sizeof(vdev->senseid));
>> +
>> +    /*
>> +     * Run sense id command.
>> +     * The size of the senseid data differs between devices (notably,
>> +     * between virtio devices and dasds), so specify the largest 
>> possible
>> +     * size and suppress the incorrect length indication for smaller 
>> sizes.
>> +     */
>> +    if (run_ccw(vdev, CCW_CMD_SENSE_ID, &vdev->senseid, 
>> sizeof(vdev->senseid),
>> +                true)) {
>> +        return false;
>> +    }
>> +
>> +    vdev->dev_type = vdev->senseid.cu_model;
>> +
>> +    if (vdev->senseid.cu_type == 0x3832) {
>> +        switch (vdev->dev_type) {
>> +        case VIRTIO_ID_BLOCK:
>> +        case VIRTIO_ID_SCSI:
>> +        case VIRTIO_ID_NET:
>> +            return true;
>> +        default:
>> +            return false;
>> +        }
>> +    }
>> +    return false;
>> +}
> ...
>> +int virtio_ccw_setup(VDev *vdev)
>> +{
>> +    int i, cfg_size = 0;
>> +    uint8_t status;
>> +    struct VirtioFeatureDesc {
>> +        uint32_t features;
>> +        uint8_t index;
>> +    } __attribute__((packed)) feats;
>> +
>> +    if (!virtio_ccw_is_supported(vdev->schid)) {
>> +        puts("Virtio unsupported for this device ID");
>> +        return -ENODEV;
>> +    }
>> +    /* device ID has been established now */
>> +
>> +    vdev->config.blk.blk_size = 0; /* mark "illegal" - setup 
>> started... */
>> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>> +
>> +    virtio_reset(vdev);
>> +
>> +    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
>> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), 
>> false)) {
>> +        puts("Could not write ACKNOWLEDGE status to host");
>> +        return -EIO;
>> +    }
>> +
>> +    switch (vdev->dev_type) {
>> +    case VIRTIO_ID_NET:
>> +        vdev->nr_vqs = 2;
>> +        vdev->cmd_vr_idx = 0;
>> +        cfg_size = sizeof(vdev->config.net);
>> +        break;
>> +    case VIRTIO_ID_BLOCK:
>> +        vdev->nr_vqs = 1;
>> +        vdev->cmd_vr_idx = 0;
>> +        cfg_size = sizeof(vdev->config.blk);
>> +        break;
>> +    case VIRTIO_ID_SCSI:
>> +        vdev->nr_vqs = 3;
>> +        vdev->cmd_vr_idx = VR_REQUEST;
>> +        cfg_size = sizeof(vdev->config.scsi);
>> +        break;
>> +    default:
>> +        puts("Unsupported virtio device");
>> +        return -ENODEV;
>> +    }
>> +
>> +    status |= VIRTIO_CONFIG_S_DRIVER;
>> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), 
>> false)) {
>> +        puts("Could not write DRIVER status to host");
>> +        return -EIO;
>> +    }
>> +
>> +    /* Feature negotiation */
>> +    for (i = 0; i < ARRAY_SIZE(vdev->guest_features); i++) {
>> +        feats.features = 0;
>> +        feats.index = i;
>> +        if (run_ccw(vdev, CCW_CMD_READ_FEAT, &feats, sizeof(feats), 
>> false)) {
>> +            puts("Could not get features bits");
>> +            return -EIO;
>> +        }
>> +
>> +        vdev->guest_features[i] &= bswap32(feats.features);
>> +        feats.features = bswap32(vdev->guest_features[i]);
>> +        if (run_ccw(vdev, CCW_CMD_WRITE_FEAT, &feats, sizeof(feats), 
>> false)) {
>> +            puts("Could not set features bits");
>> +            return -EIO;
>> +        }
>> +    }
>> +
>> +    if (run_ccw(vdev, CCW_CMD_READ_CONF, &vdev->config, cfg_size, 
>> false)) {
>> +        puts("Could not get virtio device configuration");
>> +        return -EIO;
>> +    }
>> +
>> +    for (i = 0; i < vdev->nr_vqs; i++) {
>> +        VqInfo info = {
>> +            .queue = (unsigned long long) virtio_get_ring_area() + 
>> (i * VIRTIO_RING_SIZE),
>
> Would it make sense to add a "ring_num" parameter to 
> virtio_get_ring_area(), so that you could call virtio_get_ring_area(i) 
> here instead?
>
> virtio_get_ring_area() would then look like this:
>
> char *virtio_get_ring_area(int ring_num)
> {
>     return ring_area + ring_num * VIRTIO_RING_SIZE;
> }
>
> ?

That makes sense to me.  I'll change it.

>
>> +            .align = KVM_S390_VIRTIO_RING_ALIGN,
>> +            .index = i,
>> +            .num = 0,
>> +        };
>> +        VqConfig config = {
>> +            .index = i,
>> +            .num = 0,
>> +        };
>> +
>> +        if (run_ccw(vdev, CCW_CMD_READ_VQ_CONF, &config, 
>> sizeof(config),
>> +                false)) {
>> +            puts("Could not get virtio device VQ config");
>> +            return -EIO;
>> +        }
>> +        info.num = config.num;
>> +        vring_init(&vdev->vrings[i], &info);
>> +        vdev->vrings[i].schid = vdev->schid;
>> +        if (run_ccw(vdev, CCW_CMD_SET_VQ, &info, sizeof(info), 
>> false)) {
>> +            puts("Cannot set VQ info");
>> +            return -EIO;
>> +        }
>> +    }
>> +
>> +    status |= VIRTIO_CONFIG_S_DRIVER_OK;
>> +    if (run_ccw(vdev, CCW_CMD_WRITE_STATUS, &status, sizeof(status), 
>> false)) {
>> +        puts("Could not write DRIVER_OK status to host");
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
> ...
>> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
>> index 0f4f201038..0488b3a07e 100644
>> --- a/pc-bios/s390-ccw/virtio.c
>> +++ b/pc-bios/s390-ccw/virtio.c
>> @@ -2,6 +2,7 @@
>>    * Virtio driver bits
>>    *
>>    * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
>> + * Copyright 2025 IBM Corp. Author(s): Jared Rossi 
>> <jrossi@linux.ibm.com>
>
> I assume you wanted to put Authors on a separate line?

I don't quite understand what you are asking about here.  Or maybe I 
don't understand how to attribute the authors in this case?

Much of this was just copy/pasted to the new file, so I included the 
existing byline too.  Should I format things differently?

Thanks,
Jared Rossi

