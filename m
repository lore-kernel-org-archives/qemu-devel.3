Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0196606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BG74Tpd/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWvQM-0006vi-FW; Fri, 27 Nov 2026 07:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xWvQE-0006v5-VI; Fri, 27 Nov 2026 07:51:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xWvQC-0000A0-0e; Fri, 27 Nov 2026 07:51:26 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARB4ZpJ2907873; Fri, 27 Nov 2026 12:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jG0Jwc
 tiHBxY0zaZN2pDEndvlGfugt7NANDR2IB5Eqw=; b=BG74Tpd/DjHHK/9sWImlqk
 CI+fID98c9X8h9aj57YLVBdZEY9K1u15m4BuUPR95+nFQfeKPcEtsEqh9wMtRdT0
 FHGTn+ZwgENwFbTKFlYGrRqRlWF7hbfxGPr7v7EmmoAoUjZBR+mzZD7v8MF7WD0D
 bKRJZrFpt+wVdlPHU78gLEXK86EEd7v+DnG0maj2AGaY8lrgI1yTEORD5yKxDOsp
 ulH3IZH2Q2XvTktQI+n2dIXoCMFeBftDrNWRkTMVHbNzzlt6Gl5YupHLxCyWwbb7
 bFpYcQZ0At9z4TRdZ7FFg9+uugXWPC07tsevZy+8CujGTnlu4BNESP/0tuG7Ibvw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkwuhj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 12:51:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARCnOjx3812845; Fri, 27 Nov 2026 12:51:21 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6ucctmwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Nov 2026 12:51:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ARCpJw717302096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Nov 2026 12:51:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C76D5806D;
 Fri, 27 Nov 2026 12:51:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 334C458058;
 Fri, 27 Nov 2026 12:51:15 +0000 (GMT)
Received: from [9.123.12.1] (unknown [9.123.12.1])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Nov 2026 12:51:14 +0000 (GMT)
Message-ID: <be84f6c0-3075-421b-a974-ec95e5e20bce@linux.ibm.com>
Date: Fri, 27 Nov 2026 18:21:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] tests/functional/ppc64: add pseries virtio-blk
 hotplug test
To: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, misanjum@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
 <20261124110030.30097-4-anushree.mathur@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <20261124110030.30097-4-anushree.mathur@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX6CkCgh1m33wQ
 TNzjEnabkXSzm+4KuS9bwSukjhMnCwPjnZPqJ0TZH4Wwswe2yS9i8jMhRGcZ8fheowa3vlgos6R
 MW5FNm7n+VvknFopki4/Iqxr4pTbG38DJ1ta4cIwZGfgPyR5VCEHuErAdjfgpLToccT9c8IWolq
 vSWTOxlhtch8AF8KHfyq1Bp0JMBk0M/o8URiYmfBqPIVMsRDekHZTr4oQOP68Wom+breajiE85T
 DiuwLai2ZNRdT1guOuPVkfi6T8CTpdvpT2LFpwHsKb5LkpED/zCFgttX+recaOkZbGn1P5RixR+
 xUgtGIm+K1WLAuBYhGt4KRAciu7WanUDPEHUmVMB2whlaI0ZmcjAc+EdY3XQ+gAS6NWd93DxRBz
 o9wiVA8mSGtcz2uEF/HhaKxXrZwpWp8s2zKE60VSvttOD9RLQUFIqCFIeDG3y9JvLEA0eBz1dWl
 QexgWI3IOS8f9mDJR4g==
X-Proofpoint-ORIG-GUID: CkXc_pYHP_VcIcuYY9RQjcDWQzeqvFfx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX4O/x11UR+iMP
 cELGx9oJ4SgnegVPiMztXePfBcrZavZzjD6XvKIWtJi5XgHz57UaNUmatt6zXJokP1hUiOO4zaz
 KUsWdYgGl8QxPm46MzmlWcY3jVtTQ+c=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b097cca cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=RPpspFQFnpQDC-jiWLoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kJ-3gcrX063ik3baTzM8BuJXcsfAx7PY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 4:30 PM, Anushree Mathur wrote:
> Add a functional test that hot-plugs and hot-unplugs a virtio-blk-pci
> disk on the pseries machine.  It runs with TCG, and also with KVM if
> KVM is enabled.
> 
> On pseries a PCI device added through QMP is only enumerated by the
> guest once rtas_errd (ppc64-diag) handles the RTAS hotplug event and
> runs drmgr (powerpc-utils).  Neither is in the buildroot image used by
> the other pseries tests, so the test uses rootfs-hotplug.ext2: the same
> image with those two tools added.
> 
> The test boots with a second PHB (phb1) present so that the guest
> registers its slots, adds a null-co backend, hot-plugs virtio-blk-pci
> into phb1.0 and waits for /dev/vda, then unplugs it and waits for both
> the QMP DEVICE_DELETED event and /dev/vda to go away.  The root drive is
> used with snapshot=on so the cached asset is not modified by the guest.
> 
> Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> ---
> v3: the rtas_errd start and the initial /dev/vda checks used patterns
> that also matched the echoed command, so they always passed; they now
> use the shell variable sentinel, and rtas_errd is verified with pidof.
> Bounded the wait loops (60 seconds) with a failure message on timeout,
> and the test now asserts that DEVICE_DELETED was received.
> 
>   tests/functional/ppc64/meson.build         |   2 +
>   tests/functional/ppc64/test_hotplug_blk.py | 206 +++++++++++++++++++++
>   2 files changed, 208 insertions(+)
>   create mode 100755 tests/functional/ppc64/test_hotplug_blk.py
> 

Reviewed-by: Utkarsh Verma <uverma@linux.ibm.com>


