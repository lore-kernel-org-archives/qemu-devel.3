Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1276AFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 07:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKA6L-0007Bm-Hh; Tue, 05 May 2026 03:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wKA6J-0007B3-TF; Tue, 05 May 2026 03:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wKA6I-0006Ia-65; Tue, 05 May 2026 03:21:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6457BaKG3003512; Tue, 5 May 2026 07:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NbkkIJ
 2wn0FXM9OGDHvyEvEt2Orl9IqJnHFUqZxtVRI=; b=Qs979Jl0UvTEsSPcGWZRkx
 0sH5qCVuY1rdtb/YFZLBZaB2g2KTG6p4xcw4pS9Gom62ogr8zuO3NR8oj13ZrNNK
 Sj0IwGAXCi2OWiYQo8EmqUFtkJhEfw7rgWIkJC+V8z3pdyMB7dxOm8+DE62KyWAS
 sK4ypOh+ZieKvtsS8s30Rr4wLt4AFVAERQ2RfvOz2gM/9s1gjmGavS46woSsBaza
 ts7YoXH6sa5nCE8J2RXZOVaeeY+jai5z9kuS8AmQtJAUHU4f23l6CSSNORVZ07Yw
 bcX9fU1eN7m4m5b2UiL52Vxd8HupsWnSiQ59pKbkE14arWZxa/DZn7um7ImEBRPw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7aevt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 07:21:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64579X5W005503;
 Tue, 5 May 2026 07:21:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq8nt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 07:21:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6457Lc4830802284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 07:21:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD1562004B;
 Tue,  5 May 2026 07:21:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0EFB20040;
 Tue,  5 May 2026 07:21:37 +0000 (GMT)
Received: from [9.111.37.142] (unknown [9.111.37.142])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 07:21:37 +0000 (GMT)
Message-ID: <ffa64345-6a7d-455b-983d-7dae3a799d55@linux.ibm.com>
Date: Tue, 5 May 2026 09:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] s390x/pci: Improved zPCI Function Measurement
 Support
To: Omar Elghoul <oelghoul@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Gerd Bayer <gbayer@linux.ibm.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, clg@redhat.com
References: <20260501200026.22784-1-oelghoul@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260501200026.22784-1-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2NCBTYWx0ZWRfXwiF/iC5FQ3ps
 ROL7O226Wi5h3D6ViY5ymuI81pvas/6YfOAe6Y7xSBB3L0eZxbNsiofeHtTJZcQdxfMNVoI01KJ
 1HPYzX38BCAblXQY7UOYHD716JyLwhGXtTkFUBvrV03WogmP0fCQ3cgrXDjPH8+DYZmYIc/IyFs
 3u1TPO4jcbq75EmQpwFjcDa1R0IDgZ+gw9gRCYjJqGFvo5KvLJhzPJOQP8LyKFKmH/qQws6/fIc
 iba6nP8sENRK0spOAVKs/UVvo5fWl8vGhVmpdY2Rj3BLs+uGUI9tGHDCgKmhE99PC9fER5JPXui
 Bx0lEs0U19Ls6xPZwBLYXXc8vkS1WkNMGwN2vka7HkngkbjcvAbWB5A8URXb6HxG48V3Fm8uFgx
 /ONND9ep8UyVozNOK/tpiMoHqoTiiFVfM+vz4zQgqS4JyTBpNHGjjck2Xv7tp+nCpK939F1TTZO
 KzNqVgu5+NmAZLRWCTg==
X-Proofpoint-GUID: Nf1_qYnmB9T_tcudO6gNLS0uzWlxYv4l
X-Proofpoint-ORIG-GUID: Nf1_qYnmB9T_tcudO6gNLS0uzWlxYv4l
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f99a87 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=ITle8x_VIzyELaMaH_AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Am 01.05.26 um 22:00 schrieb Omar Elghoul:
> Hi,
> 
> This patch series improves support for function measurement on s390x for
> zPCI passthrough devices. It is dependent on the eponymous kernel patch
> series linked below. [1]
> 
> Motivation
> ==========
> The firmware on s390x machines allows for tracking a variety of statistics
> relating to zPCI devices in a function measurement block (FMB). At the time
> of writing, the kernel does not provide QEMU with a structured mechanism to
> fetch the FMB of passthrough devices. QEMU also does not report the PFT to
> the guest, which can cause issues with tools such as smc-rnics that depend
> on the PFT to detect ISM and RoCE devices. Furthermore, the FMB itself can
> take on different formats depending on the PFT, while QEMU's implementation
> is limited to only the generic section that prefixes the format-specific
> structures.
> 
> Proposal
> ========
> The aforementioned kernel series proposes a VFIO feature that allows QEMU
> to read the latest snapshot of the FMB. In this patch series, we propose
> using that mechanism to share the FMB with the guest, as seen from the
> host. We also inform the guest of the PFT and the FMB length as detected
> from the host's CLP. Furthermore, we implement the format-0 FMB (DMA
> counters) for virtio-pci devices.
> 
> I'd appreciate any comments on this approach.
> 
> Thanks in advance.
> 
> [1] https://lore.kernel.org/all/20260501192530.9429-1-oelghoul@linux.ibm.com/

CCing Niklas and Gerd for their Linux zpci expertise.

> 
> Omar Elghoul (5):
>    [do-not-merge] linux-headers: Add definitions for VFIO zPCI FMB
>      passthrough
>    hw/s390x: Clarified FMB format for emulated and passthrough devices
>    hw/virtio: Add DMA counters for virtio-pci devices
>    hw/s390x: Internal support for FMB passthrough
>    hw/s390x: Report FMB passthrough and/or FMB DMA counters to the guest
> 
>   hw/s390x/s390-pci-bus.c          |  17 +++-
>   hw/s390x/s390-pci-inst.c         |  65 ++++++++++++++-
>   hw/s390x/s390-pci-vfio-stubs.c   |  16 ++++
>   hw/s390x/s390-pci-vfio.c         | 133 ++++++++++++++++++++++++++-----
>   hw/virtio/virtio.c               |  16 ++++
>   include/hw/pci/pci_device.h      |   4 +
>   include/hw/s390x/s390-pci-bus.h  |  29 ++++++-
>   include/hw/s390x/s390-pci-vfio.h |   4 +
>   include/hw/virtio/virtio.h       |   1 +
>   linux-headers/linux/vfio.h       |  43 ++++++++++
>   10 files changed, 301 insertions(+), 27 deletions(-)
> 


