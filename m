Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E13D0D16A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdYfl-0006ja-0F; Wed, 07 Jan 2026 13:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdYfi-0006ir-EU; Wed, 07 Jan 2026 13:54:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1vdYfg-0004MB-Ia; Wed, 07 Jan 2026 13:54:18 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 607I1SRs000462;
 Wed, 7 Jan 2026 18:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bFyYKY
 IyNPdkcM7/ZPWTn2AqXhoe/AUaGBJSf4zJThA=; b=LvRr/O0s2BlYMd7dibZZe+
 iZg1z5zp3pqwh8nC0/l2sK8CSeTUQfA0PGKlmI4/kL+8K+VO4hic9Sm563mgHlbc
 DWmAOxfgkBPibZ3TNVBhjV6yX86IvC8qfrkje4ICedXRErA/VShp+ud5cEBiIRve
 wvAsXw6JopgjtsaPNi4AfCI6HNa+E62gU6COzPPKmGzhtd9x2HMktLgA4lyZrh2/
 mbyxECQOD8PlC8QUpfpWY5j3QuNEQQJV6gOLYtiB7KTyZvdSkHIUC/LhDPJkxVR1
 VqE6CzvVoQiZrkvOFksaovlnOYgM5SimDHTl5bxMfY3Vd6wLx2hjNkqV4y1J9aVQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betsqasud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:54:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607I2fWC012581;
 Wed, 7 Jan 2026 18:54:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bffnjjmy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:54:13 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607IsBfn19989066
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 18:54:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A39875804B;
 Wed,  7 Jan 2026 18:54:11 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4CFF58055;
 Wed,  7 Jan 2026 18:54:10 +0000 (GMT)
Received: from [9.61.39.95] (unknown [9.61.39.95])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  7 Jan 2026 18:54:10 +0000 (GMT)
Message-ID: <76901b78-b3dd-41b7-b28a-5ff013514df6@linux.ibm.com>
Date: Wed, 7 Jan 2026 13:54:09 -0500
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
 <1c7f4a33-b730-4668-9a3c-948d47203ab1@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <1c7f4a33-b730-4668-9a3c-948d47203ab1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K6tPukJydapLN7e2EkPQhr4IaG0yD-WL
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695eabd6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=qF9lIotkpC8H2rgQ9q0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: K6tPukJydapLN7e2EkPQhr4IaG0yD-WL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0NSBTYWx0ZWRfX2zuqNFfWDaFr
 ZT8c2R0V0UhDKB1qSEm43S6Z1lIwQAactM+Uwl9khY6NmiyQOh2e3nlIaaDtXwKpnvH+XP8OIbS
 ifE/ysxQb41KNWMR5fDH3TSH9JAOZjKSm5kEmOoi8KPOu3YabfLFYGN37tYSV89JvEnTDPJtkWq
 kL0YczFzRQFSU8OhZxbb2eanH0VbyFAlYcyhGBRT+8nJTvFX/Wmzws8A/Bl0r7WmCnBegN8Csfk
 alhGs91Io+9zOdJGSOZT7/mPzHCC3lvWcsEMTl6EdteRMC4lxge6YoBAJTN/jxup2DQZu1V3s3a
 iB5qjH5oNBrfk9qX126EI99+FUc3qqiVD+LLrmBaz88vYWYw7RrUClIM0k8MYVfQuB8D/KkyLwt
 1EqsTTigZkzfgi+p038+nTu5E9iTH/0YY2M2X3Z5lQJ5sS4gLWKqzZKUwiFBSDDLhkUsa62lHqA
 kOt/k3SagFGfWLD76jA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601070145
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 1/7/26 11:08 AM, Thomas Huth wrote:
> On 07/01/2026 15.44, Thomas Huth wrote:
>> On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
>>> From: Jared Rossi <jrossi@linux.ibm.com>
>>>
>>> Enable virt-queue PCI configuration and add routines for 
>>> virtio-blk-pci devices.
>>>
>>> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
>>> ---
> ...
>>> +static int virtio_pci_set_gfeatures(VDev *vdev)
>>> +{
>>> +    int rc;
>>> +
>>> +    rc = pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>>> VPCI_C_OFFSET_GFSELECT,
>>> +                           c_cap.bar, 0);
>>> +
>>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>>> VPCI_C_OFFSET_GF,
>>> +                            c_cap.bar, vdev->guest_features[1]);
>>> +
>>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>>> VPCI_C_OFFSET_GFSELECT,
>>> +                            c_cap.bar, 1);
>>> +
>>> +    rc |= pci_bswap32_write(vdev->pci_fh, c_cap.off + 
>>> VPCI_C_OFFSET_GF,
>>> +                                c_cap.bar, vdev->guest_features[0]);
>>> +
>>> +    if (rc) {
>>> +        puts("Failed to set PCI feature bits");
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int virtio_pci_get_blk_config(VDev *vdev)
>>> +{
>>> +    return pci_read_flex(vdev->pci_fh, d_cap.off, d_cap.bar, &vdev- 
>>> >config.blk,
>>> +                         sizeof(VirtioBlkConfig));
>>
>> I'm a little bit surprised that there does not seem to be any 
>> endianess swapping for the config.blk data anywhere here ... isn't 
>> that config space data supposed to be in little endian?
>>
>> ... oh, wait, you're not negotiating VIRTIO_F_VERSION_1, are you? ... 
>> so the config space is still in big endian for legacy virtio? ... 
>> hmm, I guess it's ok for now, but in the long run, I think we should 
>> rather use VERSION_1 instead.
> Thinking about this twice, could you please have a try to use 
> VIRTIO_F_VERSION_1 right from the start? I already heard from some 
> people that they'd rather want to get rid of legacy virtio in QEMU 
> (e.g. for the universal binary project that includes multiple targets 
> in a single QEMU binary), so I think it would be safer to immediately 
> go with VERSION_1 here.
>
>  Thanks,
>   Thomas
>

Hi Thomas,

I touched on this in reply to your other message, but yes, I agree that 
it is better to do all of these negotiations in the most compatible way 
right from the start.  I will fix the feature negotiations and try to 
avoid using anything legacy.

Thanks again for your reviews,
Jared Rossi

