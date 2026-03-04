Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70448EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 20:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxsfC-00010G-D1; Wed, 04 Mar 2026 15:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxsf7-0000zS-J7; Wed, 04 Mar 2026 15:17:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vxsf5-0006IU-Pj; Wed, 04 Mar 2026 15:17:41 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6248Nb591183853; Wed, 4 Mar 2026 20:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=b2AsJe
 PtUx0X1ebIcEDE6KsmpEkJirDe+97ca33F0js=; b=V4wheJNWNLxBMiWca3EJTp
 Jk+jVT3C4mXd3/ODwama5DwmpevWpQWzPpMYZn2bLtaPxicI9AyM1cAvcJxd6ya7
 ms/UTPysFEk+YGTeP72QsE7U0aHGUwBkpQUC6RYqUNdcJIVQS61R/CS1dR34NLXS
 ceFVMRLJ4ngX1teJjmehusqfQfRqS/statY0dL+GwQwGQG7BGqCw7doPeME+8qg+
 qz1NHA7G2/3LMKEJR/qI+RmpSVux8lFQawY6enRejjDBUWOe4NgtJIv+seHzk98k
 IfM76k/FErS6WjY86ozEKGjhm2dmA+cD9U+QP3Ju7dnfSE79+WknUqtTxDvk1X9Q
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc0kxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 20:17:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624KDRgE027662;
 Wed, 4 Mar 2026 20:17:37 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjg0y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 20:17:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624KHZvi20120290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 20:17:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68E4E58058;
 Wed,  4 Mar 2026 20:17:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88D2C58059;
 Wed,  4 Mar 2026 20:17:34 +0000 (GMT)
Received: from [9.61.180.105] (unknown [9.61.180.105])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  4 Mar 2026 20:17:34 +0000 (GMT)
Message-ID: <5126b04a-dd1f-40ad-a720-4d2c3a7cb1aa@linux.ibm.com>
Date: Wed, 4 Mar 2026 15:17:33 -0500
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
 <c8b28b9c-51e1-44aa-93c4-c94846676b93@linux.ibm.com>
 <79fb74d7-4b42-4ffc-902f-2498e1de5a52@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <79fb74d7-4b42-4ffc-902f-2498e1de5a52@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5P3vsNqAN9mb84fhBXvHTlyCgnNvAXSv
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a89362 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=eHidbRiHdkJEy-zaHDMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE2NSBTYWx0ZWRfX+uW0oOPrXyKE
 t739mQVnET071Tzxho7GCGpCaGoz1uPA6W2rvO0i+0QbfXJ5GmIG2C5J1XcE9ckH5S3DdmZcMrX
 18lzTBvv1Ef3MeD7Izjn4LsYNg8+YqWROuazbmEI+WkMj/MImvrU3EUHmo3Xo3ie8RbCjzgjyGG
 OwjDzrxwzRpbv8UlFY1ymUeZiSMmdN60GNIuOK+Q7YQdDCfTJXAmVtMip8n1rK6n7Egma6SqXss
 myYvRFo3XPt9re7rWRc1DWH/84wllFSygP1nlo2/Vth4zMSGXn0ZFssPo9ys8qQwk1+Ut37pnAu
 U4f8LMmU1MfRVMkq6amaqZdoeO3zgWAh254SDvb4Ta0Z4lu/g1zDZoPJm/d0eCI6vpKlCbKlKi/
 gVi8NWulS3q7/PSsT/KCsCPreOnPjYCUZMdKr6VFivaec8dz7mDSrLYK2Pe8RGOw+FG178WIsxy
 Y8meLx//57TnqKO6leg==
X-Proofpoint-GUID: 5P3vsNqAN9mb84fhBXvHTlyCgnNvAXSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040165
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 3/4/26 9:39 AM, Thomas Huth wrote:
> On 04/03/2026 15.29, Jared Rossi wrote:
>>
>>
>> On 3/4/26 4:53 AM, Thomas Huth wrote:
>>> On 04/03/2026 03.59, jrossi@linux.ibm.com wrote:
>>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>>
>>>> Add little-endian virt-queue configuration and support for 
>>>> virtio-blk-pci IPL
>>>> devices.
>>>>
>>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>>> ---
>>> ...
>>>> +static int virtio_pci_get_blk_config(void)
>>>> +{
>>>> +    VirtioBlkConfig *cfg = &virtio_get_device()->config.blk;
>>>> +    int rc = vpci_read_flex(d_cap.off, d_cap.bar, cfg, 
>>>> sizeof(VirtioBlkConfig));
>>>> +
>>>> +    /* single byte fields are not touched */
>>>> +    cfg->capacity = bswap64(cfg->capacity);
>>>> +    cfg->size_max = bswap32(cfg->size_max);
>>>> +    cfg->seg_max = bswap32(cfg->seg_max);
>>>> +
>>>> +    cfg->geometry.cylinders = bswap16(cfg->geometry.cylinders);
>>>> +
>>>> +    cfg->blk_size = bswap32(cfg->blk_size);
>>>> +    cfg->min_io_size = bswap16(cfg->min_io_size);
>>>> +    cfg->opt_io_size = bswap32(cfg->opt_io_size);
>>>
>>> So it looks like you read a bunch of optional config fields here ...
>>>
>>>> +    return rc;
>>>> +}
>>> ...
>>>> +int virtio_pci_setup(VDev *vdev)
>>>> +{
>>>> +    VRing *vr;
>>>> +    int rc;
>>>> +    uint8_t status;
>>>> +    uint16_t vq_size;
>>>> +    int i = 0;
>>>> +
>>>> +    vdev->guessed_disk_nature = VIRTIO_GDN_NONE;
>>>> +    vdev->cmd_vr_idx = 0;
>>>> +
>>>> +    if (virtio_pci_read_pci_cap_config()) {
>>>> +        puts("Invalid virtio PCI capabilities");
>>>> +        return -EIO;
>>>> +    }
>>>> +
>>>> +    if (enable_pci_bus_master()) {
>>>> +        return -EIO;
>>>> +    }
>>>> +
>>>> +    if (virtio_reset(vdev)) {
>>>> +        return -EIO;
>>>> +    }
>>>> +
>>>> +    status = VIRTIO_CONFIG_S_ACKNOWLEDGE;
>>>> +    if (virtio_pci_set_status(status)) {
>>>> +        puts("Virtio-pci device Failed to ACKNOWLEDGE");
>>>> +        return -EIO;
>>>> +    }
>>>
>>> ... so I think you should enable the corresponding feature bits in 
>>> vdev- >guest_features[0] here? QEMU might be very forgiving and 
>>> provide you with the fields anyway, but let's better play safe. 
>>> Something like:
>>>
>>>     vdev->guest_features[0] = VIRTIO_BLK_F_SIZE_MAX |
>>>                               VIRTIO_BLK_F_SEG_MAX |
>>>                               VIRTIO_BLK_F_GEOMETRY |
>>>                               VIRTIO_BLK_F_BLK_SIZE;
>>>
>>> ?
>>
>> VIRTIO_BLK_F_GEOMETRY and VIRTIO_BLK_F_BLK_SIZE are already set 
>> during the virtio-blk setup.  I actually don't think the other two 
>> fields are used, I jut swapped any fields larger than 1 byte.  I 
>> suppose the feature bits should be enabled though... otherwise we 
>> could just just not touch the unused fields at all?
>
> Ah, right, I missed the initialization in virtio_blk_setup_device(), 
> so we should be fine here, indeed!
>
>>>
>>>> +    vdev->guest_features[1] = VIRTIO_F_VERSION_1;
>>>> +    if (virtio_pci_negotiate()) {
>>>> +        panic("Virtio feature negotation failed!");
>>>> +    }
>>>
>>> Maybe double-check whether VIRTIO_F_VERSION_1 has really been 
>>> negotiated? Otherwise, what happens if a user runs QEMU with 
>>> "-device virtio-blk- pci,disable-modern=on" ?
>>
>> I haven't tried running it with "disable-modern=on" (I will test that 
>> next) but the config is big endian if I don't negotiate that feature 
>> bit, and little endian if I do, which I think is the expected 
>> behavior when VIRTIO_F_VERSION_1 is set.
>>
>> Just for my understanding, do you see something that makes you 
>> suspect the negotiation isn't actually happening?  I will try running 
>> with "disable- modern=on" and let you know the results.
>
> No, I think it's fine for the default case. I'm just wondering what 
> happens when someone uses "disable-modern=on" ... I guess the code 
> will currently behave in weird ways since the endianness is wrong ... 
> thus I thought it might be better to check VIRTIO_F_VERSION_1 again 
> and emit a proper error message in this case?
>

I tried running with "disable-moden=on" and it failed very early in the 
virtio-pci setup when trying to read the PCI configuration space.

    Failed to locate PCI common configuration
    Invalid virtio PCI capabilities
    ERROR: No suitable device for IPL. Halting...


Actually that happens before we even try to negotiate 
VIRTIO_F_VERSION_1.  From the virtio spec, it looks like the legacy 
interface requires the common configuration to be in BAR0 (4.1.4.10), 
while we normally expect BAR15 to specify the layout. Typically we need 
to read the capabilities config in BAR15 to determine which BAR the 
common config is in, then that location is used when negotiating the 
features, etc.  My guess is BAR15 isn't populated when 
"disable-modern=on" so it bails out when there is no capabilities 
configuration.

But as far as I can tell it isn't an endianness issue since we are 
trying to read single byte fields at this point anyway.  What are your 
thoughts?

Regards,
Jared Rossi



