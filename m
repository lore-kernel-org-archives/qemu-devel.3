Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BA6EF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxnEe-0001Ro-AR; Wed, 04 Mar 2026 09:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxnDz-0001I3-3z; Wed, 04 Mar 2026 09:29:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxnDx-0008QN-7J; Wed, 04 Mar 2026 09:29:18 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6240qAUd674109; Wed, 4 Mar 2026 14:29:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xfaZ02
 /mGTT3ToUfii0gM93MPHXYKiqhn7tMc9DeWp8=; b=UK0AqvgFnVCZ9LNQShxhGx
 JCsgncpxVjf7bIfEznYS5nZ9tHYhGkuJdFVW9Fn/FHfN+Q4kO3HwQtA3JZR+S2Wg
 gIYHUV+HR/K2dv2vU1bnHCnktCGFf/p345JJqq5eKUjdQsZ6Ji77PdmBMH/SjTQO
 pWuXzmRF8746qOgvfDyn6WXbgYDiVsffkcDKs3NxJa7X4P56/vuWq662Qz44oSiw
 mhjxmVfI34oDSm1HyHe0Xw28A6Zw7md3JAIkwtEiDD2gtEqwxmTLj8fYsSmvz0yb
 Wa6wrldOpAvJ4ZGkvk191kcZZcgJe+c9ZZnOjaLdiftmrllTjAg9j7IJq4tX1C/Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj7qvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:29:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6249uGW0003243;
 Wed, 4 Mar 2026 14:29:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y74ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:29:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624ETCfY27001584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 14:29:12 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45A645805D;
 Wed,  4 Mar 2026 14:29:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0174258059;
 Wed,  4 Mar 2026 14:29:11 +0000 (GMT)
Received: from [9.61.180.105] (unknown [9.61.180.105])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Mar 2026 14:29:10 +0000 (GMT)
Message-ID: <c8b28b9c-51e1-44aa-93c4-c94846676b93@linux.ibm.com>
Date: Wed, 4 Mar 2026 09:29:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] pc-bios/s390-ccw: Add support for virtio-blk-pci
 IPL
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-13-jrossi@linux.ibm.com>
 <d359ade1-7e86-40c0-bfa2-6452fc48f69d@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <d359ade1-7e86-40c0-bfa2-6452fc48f69d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a841bb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Rgukp8Kgh_SnEbTn2V0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExNCBTYWx0ZWRfXw2F6HA7vNsI1
 L2h6hrAnuxcaBls0y0PAZjMmOnD7M71hSzbfdTxtXZs4y+1AGAjxutGv6iNbLXYYDgJoWc5AZ7b
 JUYbztoTKZp9/+hSOGZ2/H+llH1MYqgBeOde7pwzdC3hDjLd5fDPkX0pS7GOSI/XESaLwq+kh7T
 LgFXvJxHkyrTrkSZSG70R5dbCWQWSp+uQDMELyDnJLkKoneFTCOqMrxX3fVSkNSNwepClMuNK1i
 m53SnQdFTttFWh0Ba/eV8auPKQpzHmdXvYxdQcWmGOqkg0vTwQ+V5dWWBNlU4HPS2to58KftVkQ
 3B6Wy/JlUsRfAZ6cWniIu2DMb6oCXcRbODfns/SpqjlpzTTwzUwmTzkffeTf+mp9D/mPKCrQ6ob
 88Xu01dmFM0nFLW6Fl1QBNrVoSo+vr0u8RDI/YKzamdyvf3NhCAJjcP/wU/Nab1G2uqyqChCutZ
 7N8hV5/0VLuSJCPxthA==
X-Proofpoint-GUID: gpZ8NIZkyhShikRKgMuE2rtRgGjEATv5
X-Proofpoint-ORIG-GUID: gpZ8NIZkyhShikRKgMuE2rtRgGjEATv5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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



On 3/4/26 4:53 AM, Thomas Huth wrote:
> On 04/03/2026 03.59, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>>
>> Add little-endian virt-queue configuration and support for 
>> virtio-blk-pci IPL
>> devices.
>>
>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>> ---
> ...
>> +static int virtio_pci_get_blk_config(void)
>> +{
>> +    VirtioBlkConfig *cfg = &virtio_get_device()->config.blk;
>> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, 
>> sizeof(VirtioBlkConfig));
>> +
>> +    /* single byte fields are not touched */
>> +    cfg->capacity = bswap64(cfg->capacity);
>> +    cfg->size_max = bswap32(cfg->size_max);
>> +    cfg->seg_max = bswap32(cfg->seg_max);
>> +
>> +    cfg->geometry.cylinders = bswap16(cfg->geometry.cylinders);
>> +
>> +    cfg->blk_size = bswap32(cfg->blk_size);
>> +    cfg->min_io_size = bswap16(cfg->min_io_size);
>> +    cfg->opt_io_size = bswap32(cfg->opt_io_size);
>
> So it looks like you read a bunch of optional config fields here ...
>
>> +    return rc;
>> +}
> ...
>> +int virtio_pci_setup(VDev *vdev)
>> +{
>> +    VRing *vr;
>> +    int rc;
>> +    uint8_t status;
>> +    uint16_t vq_size;
>> +    int i = 0;
>> +
>> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>> +    vdev->cmd_vr_idx = 0;
>> +
>> +    if (virtio_pci_read_pci_cap_config()) {
>> +        puts("Invalid virtio PCI capabilities");
>> +        return -EIO;
>> +    }
>> +
>> +    if (enable_pci_bus_master()) {
>> +        return -EIO;
>> +    }
>> +
>> +    if (virtio_reset(vdev)) {
>> +        return -EIO;
>> +    }
>> +
>> +    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
>> +    if (virtio_pci_set_status(status)) {
>> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
>> +        return -EIO;
>> +    }
>
> ... so I think you should enable the corresponding feature bits in 
> vdev->guest_features[0] here? QEMU might be very forgiving and provide 
> you with the fields anyway, but let's better play safe. Something like:
>
>     vdev->guest_features[0] = VIRTIO_BLK_F_SIZE_MAX |
>                               VIRTIO_BLK_F_SEG_MAX |
>                               VIRTIO_BLK_F_GEOMETRY |
>                               VIRTIO_BLK_F_BLK_SIZE;
>
> ?

VIRTIO_BLK_F_GEOMETRY and VIRTIO_BLK_F_BLK_SIZE are already set during 
the virtio-blk setup.  I actually don't think the other two fields are 
used, I jut swapped any fields larger than 1 byte.  I suppose the 
feature bits should be enabled though... otherwise we could just just 
not touch the unused fields at all?

>
>> +    vdev->guest_features[1] = VIRTIO_F_VERSION_1;
>> +    if (virtio_pci_negotiate()) {
>> +        panic("Virtio feature negotation failed!");
>> +    }
>
> Maybe double-check whether VIRTIO_F_VERSION_1 has really been 
> negotiated? Otherwise, what happens if a user runs QEMU with "-device 
> virtio-blk-pci,disable-modern=on" ?

I haven't tried running it with "disable-modern=on" (I will test that 
next) but the config is big endian if I don't negotiate that feature 
bit, and little endian if I do, which I think is the expected behavior 
when VIRTIO_F_VERSION_1 is set.

Just for my understanding, do you see something that makes you suspect 
the negotiation isn't actually happening?  I will try running with 
"disable-modern=on" and let you know the results.

Thanks for the reviews,
Jared Rossi

