Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E08CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcAo-0000xB-Lz; Tue, 29 Sep 2026 14:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBcAn-0000wV-27; Tue, 29 Sep 2026 14:03:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBcAk-0006Ym-Sd; Tue, 29 Sep 2026 14:03:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5cFi3836692; Tue, 29 Sep 2026 18:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PD0Qm3
 Qkf3CndWDkSXfY7CajMKBeGwehfjrg0/Od57c=; b=fHsNIF7C4THzNYDMqout6b
 ZK1OIy0NSODMiJKXPcPbUVF/hLD8QqRZDxUiwlj5IqFZcXVbVYPXU0/ORN6uV5cg
 /c/8dSJxwRF4klDZkogY/7UxrOk3yI7Jv9mnDL/bNGCBIlMSwz5PXTTDfVYIroQ/
 hL2UsdDeGyljnAoX64U+n3TwbsFb+7xfqqN07cWxQnXAN0J75UMVu4StHxMwfwAh
 dcuVrbd69CRDBH66rARSLZVETfHhn8eAo7uNf94bRmspCN0WHTOlIktwmv/gp2nI
 FA5vHr5nhnF8ggI1YxRzilBDMvMEOVuLIJiFrn4pbin+Cvm+RVBaJjvEc8Cpbr2A
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk84nm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 18:03:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF3s5X1616997; Tue, 29 Sep 2026 18:03:20 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwayhv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 18:03:20 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TI3J1j28312148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 18:03:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DA958056;
 Tue, 29 Sep 2026 18:03:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3D0E58052;
 Tue, 29 Sep 2026 18:03:18 +0000 (GMT)
Received: from [9.61.250.47] (unknown [9.61.250.47])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 18:03:18 +0000 (GMT)
Message-ID: <4db8e8c7-0cd9-48d3-bea5-781127649e47@linux.ibm.com>
Date: Tue, 29 Sep 2026 11:03:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Error recovery for zPCI passthrough devices
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260922171756.920-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r7yJnu-J53zudKD9MV2QP4bFigx-E7E0
X-Proofpoint-GUID: r7yJnu-J53zudKD9MV2QP4bFigx-E7E0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfX6au0K8EHyfXb
 K2GfGOy1w+B+QiyofesdnSd/xoJCDXD4Vx4QY+Y5nB7KYiNcLtBkZXXgW/fgECV3vLlkrHhwBWQ
 78cuLjPsL4e7wi5Ohj8AquU3xIQyRww=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abbfd69 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=VnNF1IyMAAAA:8 a=tItWsE-uffiCWhIg6pkA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfXyXTdYzsrPa61
 UudUPkCM+/EpNgzJ2iXAN0pcXn2xINnucSnMzW+XXgWrcmOy8QDQ/zeVeVNa2ms3J92O2sBad4Y
 y5ASIy70TEV8Fi9KezJ5FYvzmRL5RQNlymi6I8JVpyERNsY4jHivY0HCNlwJpC3HkyJOr2SPYQf
 LfeMnPLRVbMWoOUeae2CAAzuLTvMKkPKT2z6DT/fBDwNtjrCj4wkUKecF73AcT1wvCmCdPYKqNp
 Uo72mjkKsuSlHR9wj4UC5X7T6SyDROaqvPZrX3ShoT7VKutGB9avNhD7sx3ma59RL0ElfVqf1Vi
 g4/WnEn/QVv5URD1Hpcik6p7mQTmGOy/NJHTrXizHRsEIz2Bi0OBRAPLLjdxpuZ+NZX3HoT1YFA
 09WdRqeZB73QATWe4qgLq0vdqnRbyZJI/+vbtjmCi888ptexAbCjxg7Vyg2qDQs6gENTJJZGAzP
 H9jIXrBy02esnrT9pMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Hi,

Polite ping for this series.

Thanks

Farhan

On 9/22/2026 10:17 AM, Farhan Ali wrote:
> Hi,
>
> This patch series introduces support for error recovery for passthrough PCI
> devices on System Z (s390x). This is the user space component for the Linux
> kernel patches [1]. The kernel patches were merged for 7.3 release.
>
> The current design for QEMU updates the callback for vfio error notifier to
> an s390x specific error handler if the kernel supports the new device
> feature VFIO_DEVICE_FEATURE_ZPCI_ERROR, for s390 vfio-pci devices. So now
> on an eventfd notification for error notifier it will invoke the s390x
> specific error handler.  The s390x error handler will retrieve the
> architecture specific PCI error information and inject the information into
> the guest. Once the guest receives the error information, the guest drivers
> will drive the error recovery.  Typically recovery involves a device reset
> which translate to CLP disable/enable cycle for the device.
>
> I would appreciate some feedback on this patch series.
>
> Thanks Farhan
>
> [1] https://lore.kernel.org/all/20260818164326.387bb27b@shazbot.org/
>
> ChangeLog
> ---------
> v5 https://lore.kernel.org/all/20260914174420.12309-1-alifm@linux.ibm.com/
> v5 -> v6
>      - Address Cedric's feedback (patch 1).
>      - Update error handling to follow QEMU style (patch 1).
>      - Rebase on master.
>      - Remove linux-headers update as latest QEMU master has the VFIO headers
>      merged.
>
> v4 https://lore.kernel.org/all/20260831183151.12626-1-alifm@linux.ibm.com/
> v4 -> v5
>      - Remove err_handler() callback in vfio pci core.
>      - Update the vfio error notifier callback to an s390x specific callback
>      for s390x devices
>      - Include linux headers for 7.3-rc3.
> v3 https://lore.kernel.org/qemu-devel/20250925174852.1302-1-alifm@linux.ibm.com/
> v3 -> v4
>      - Include linux headers for 7.3-rc1.
>      - Rework VFIO API changes based on the kernel API (patch 3).
>      - Address Markus's comments from v3 (patch 2).
>
> v2 https://lore.kernel.org/qemu-devel/20250825212434.2255-1-alifm@linux.ibm.com/
> v2 -> v3
>      - Update arch_err_handler to err_handler and include Error ** in
>      function definition. (patch 2)
>
>      - Introduce helper function to hide the internal indirection of device_feature()
>      (patch 3)
>
>      - Update function definitions to include Error ** (patch 4)
>      
>
>
> v1 https://lore.kernel.org/qemu-devel/20250813174152.1238-1-alifm@linux.ibm.com/
> v1 -> v2
>     - Use VFIO_DEVICE_FEATURE ioctl to get device error information.
>     (Based on Alex's feedback on kernel series)
>
>
> Farhan Ali (2):
>    s390x/pci: Add PCI error handling for vfio pci devices
>    s390x/pci: Reset a device in error state
>
>   hw/s390x/s390-pci-bus.c          |  13 ++++
>   hw/s390x/s390-pci-vfio-stubs.c   |  10 +++
>   hw/s390x/s390-pci-vfio.c         | 130 +++++++++++++++++++++++++++++++
>   include/hw/s390x/s390-pci-bus.h  |   1 +
>   include/hw/s390x/s390-pci-vfio.h |   2 +
>   5 files changed, 156 insertions(+)
>

