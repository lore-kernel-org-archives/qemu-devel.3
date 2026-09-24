Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91C5C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9eN2-0005mM-5p; Thu, 24 Sep 2026 03:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9eN0-0005la-7W; Thu, 24 Sep 2026 03:59:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x9eMy-0002tf-Ov; Thu, 24 Sep 2026 03:59:53 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5brUZ1179987; Thu, 24 Sep 2026 07:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ssqIUE
 kbqrXipXTK4vsdmEOymAivVe6aIOkkxhWap9c=; b=SlSMywNu7qw93ZP3UtAwr/
 wl2++64jMAqG3zrf6aJ2VSVCH/UyWIpUOLwat8Q+dOTSYIQlW3cEUauo0v07mJVg
 l1CRJ8xEm068aVf8vlpxWbhWE21ALvLWmLQVzvMIsJbDEaLqHjD3ZiHiS1j8QV8X
 Zk7CUDYMD34XUfGO7rtFv8zrYzDCZEc52TMwKDdYq8GAiT3UYdFZT+3LlxV58j9Q
 YddI31u6oyI0DNJ18Sh0JLznXxY7vBvN6iS07nkeMN+p2TqDYKSpOMhnSVwI5XcT
 Zn2uQcGY0/HBPKJnchB045rGXWX88JcTlXXlzb/EsYE4XLs8+F/YaerR/7jAF5pQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1q5dm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:59:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5lWGs1539521; Thu, 24 Sep 2026 07:59:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1vq01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 07:59:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68O7xhZ838863180
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 07:59:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D74B420043;
 Thu, 24 Sep 2026 07:59:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F4552004B;
 Thu, 24 Sep 2026 07:59:43 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 07:59:43 +0000 (GMT)
Message-ID: <95f73734-b645-45ec-8f10-b33cf842a2d2@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260923141518.960364-1-kshk@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f61L1GARTMuX_zb1riHLcwXFXslJ-Cgw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfXwL+ES0zwfAHe
 UmHuJ1WerD7xQNhPgbVkNKJga1+Q5aEQhA+vVcA1ztBd7tZieWw6zAw/qq4SvfBdcyciMOYG6k9
 8CMcVxl2gNtnaDyUEXsh6nVDfxZTyS6hclRfvUMMBEPvmMsHeDo0LtUHbS/MLhkhDcz18Cj9IZT
 9PueYpPXfzPY35uCjPDQUmCv4zJYPNaLDAqEAcfUg/tpQJb4HKkncHbEXtAPdgqS6Z5YgxkhYdN
 sVjI+sUFJhVRVlPhwvMEYkM+NfKCbSIU74LYhlZhShP8GFVNr2cwI0bZoy3x3A/l/vQdo0bc4LC
 abTfWA1gf1unUrTErlGyDxoR07DJrAGYzo9/XGWd6EBoFW+Le61H10Lt0EPvvyKsO7o8EXHXoYo
 KXopd+fVGND0dFAZ8fQgSdK0h1qorbrgQ4fSzz664Dxo27WxpkBL+jU27ZNNR5ksjn1d4t7rqWg
 DdrAcJeDX/MqADRHLzg==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab4d874 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Fht0ITwEfJk-VYH6yIMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMiBTYWx0ZWRfX4PuB/CmRl49C
 irQd9Ceu5WLdNfep3gbqPabgC6/kCa/kQfbyfBblM5xY6fmP0G0T8x8HHiuP1p/qW21IOXpsK3V
 SMiCYLLmhxyBtQWOYV7kNBkSQ2TeLUs=
X-Proofpoint-GUID: f61L1GARTMuX_zb1riHLcwXFXslJ-Cgw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240032
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Am 23.09.26 um 16:15 schrieb Konstantin Shkolnyy:
> Up until now QEMU marked any zPCI device as "unmigratable."
> 
> This patch series adds support for migrating emulated devices, which are
> simpler to migrate. It leaves VFIO devices still unmigratable.
> 
> To enable migration, the device state needs to be saved/restored to/from
> the migration stream.
> 
> There are 2 kinds of emulated devices - those that use the zPCI IOMMU page
> table emulation in QEMU (e.g., Intel IGB NIC), and those that don't (virtio).
> This is important to note for testing purposes.
> 
> This change was tested on IGB, virtio-net and virtio-blk devices by running
> I/O on them while performing "virsh managedsave, virsh start" and also live
> migration to another host and back.



FWIW, I asked an AI to test this series and I can confirm it works:
Pre-series baseline: the same guest cannot be saved at all: "State blocked by
non-migratable device 'zpci'".

Managedsave and restore: completes, the guest resumes with identical PCI functions,
reads from both virtio-rng devices keep working, and the MSI counter keeps climbing.
The stream carries the enabled state, the IOAT registration, the MSI-X indicators and
ISC, and the FMB address for all three functions, and the FMB sample counter advanced
across the restore.

IOMMU replay confirmed: with translation tracing on the restored instance, the device
configured with iommu_platform=on produced 12,299 translations for a 256 KiB read and
the bypass device none, with six translations already during the load itself from virtio
reading its rings. That is the priority ordering and the replay doing their jobs.

After restore: hotplug of a new function and unplug of an existing one both work, a second
save/restore chain into a third process works, and savevm/loadvm on a running guest works
twice, including with a device that was hotplugged after the snapshot.

