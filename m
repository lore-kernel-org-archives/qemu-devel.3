Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6382CA5FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqTs-0004F4-4Q; Mon, 05 Oct 2026 17:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDqTm-0004EO-Im; Mon, 05 Oct 2026 17:44:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDqTk-00032p-V4; Mon, 05 Oct 2026 17:44:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZSjH3658139; Mon, 5 Oct 2026 21:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nouQUE
 PXOT5msozQ0jpq48UeQrvfuQz2+twDjPW3tIo=; b=dPiO8GhzLuVvjlEMkqdQd+
 FVUVP4CXBnvq4WhsrPXP5SbwnejvPssmk0/pgRKfSMiDb+P9/AJfvIGfzTML4kO9
 H0XSi8HpScnl77PAnGsrukd4h5bPjrfRTGHj9OC4yOd7uCX/qcPWgtk4bVP3dnD/
 vhBX62uNh+wxc+mu/nSRFb8q5VwsC0HdqrxnES9RwEsPdImQcFaYCF2JaWwFV/uh
 qXpJaWr7U7O+zFfwnqBlsvsAKfe10Rju8IUALRFCLScqMKIAdbehq7U/6RVfs3Vh
 3KKHEDr16ztpAzeCKL8p10iFqeaYN8pyABTOhbyPPcW3FbvcNen5SBgPeoFdYtfQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrcm3v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 21:44:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HMbv43252062; Mon, 5 Oct 2026 21:44:10 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy71xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 21:44:10 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695Li9Gv7471746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 21:44:09 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 162775805A;
 Mon,  5 Oct 2026 21:44:09 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B7DA58051;
 Mon,  5 Oct 2026 21:44:08 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 21:44:08 +0000 (GMT)
Message-ID: <54ccae64-501d-4f17-b4c5-14eed8d502e8@linux.ibm.com>
Date: Mon, 5 Oct 2026 17:44:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] Error recovery for zPCI passthrough devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20261005174314.871-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261005174314.871-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfXziNB0Mbn8G+w
 2qVIosoGGLGzhacg62hO9WlPmbHOXN9A2uIP1yS2xNMICkfWquq2P1LxB5ISr1j+xXLzUtekm+w
 VWZMZUlIxMtw0GUY6KouOHPOnMOeAXI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4NSBTYWx0ZWRfX4V4qGIysb4g7
 DjkRWt74cAKEiS4U1Ftf8ioqnhhlhE6OHwlVCWn3BRKEz1IucZZbsC28tFilml+IpyC81q01meo
 5CjmJTZsOBo+8/OYXRAa62dA9tF3YXoKTHhqDd2T9m2spE+1OImMjRpUIRS8MnRGItjjCdLB5gb
 Q5z0B5pfmuUbn6H/B3s2/mvvn+mxNN7ruzYJgPOT8aWAChuShGtGybJCl59QgDr3KWMe17LvSZQ
 RU/3wZyj7uV7WHZPE5c00I7qn8gl3ku5DVT4pttFyvHsVvMwMPfAds9shFMkoaRGtyMf2CzyjDa
 JHFTzSr7G/yGaRAvcp+1ILnPeyESdP+uCE0mEXN5vpKdXlgofw5jmQ+Q0NkVpy82Cu84Os/fWdB
 t+fkK65nXJezIX4z9pYfRDzDeBR0C7PaVixKO4GVfOn/+9ORLwmAYtdF9hQZ8wJKJi83qTDPVyW
 RKsR/nAyPbrxR79itBg==
X-Proofpoint-GUID: Rjbyt8VTH0eXYfWgMB0nHcDnMclpCxlh
X-Proofpoint-ORIG-GUID: Rjbyt8VTH0eXYfWgMB0nHcDnMclpCxlh
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac41a2a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=t0SE7IyajQzYD5HYdf8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050085
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 10/5/26 1:43 PM, Farhan Ali wrote:
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
> Thanks 
> Farhan

@Eric: Series LGTM at this point, let's give Cédric and/or Alex some
time to look too.

This series should also either go after Konstantin's migration series or
at least we should take my patch from that series (s390x/pci: implement
IOMMU replay) to ensure that is in place prior to enabling this recovery
feature; basically, we want that patch with whichever feature lands first.

Thanks,
Matt


