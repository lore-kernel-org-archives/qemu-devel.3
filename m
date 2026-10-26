Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD88606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lnNZQOx+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLTO1-0004kr-2c; Mon, 26 Oct 2026 18:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xLTNz-0004kI-5n; Mon, 26 Oct 2026 18:41:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xLTNx-0005Sl-2f; Mon, 26 Oct 2026 18:41:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QJE87U3297473; Mon, 26 Oct 2026 22:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fJqwmV
 bhmf7XrTuvfJpMsUVlSrsPZGNiOsHyxrljW2w=; b=lnNZQOx+06J/T7qvt5eFQp
 YBhj6ecOXysd6EKAsU89c5QtBu7aHh0c/NV4BTHfmdFNdHrP7rqr6AhzQL8mvZaj
 Uo7i4+GeoPi3Tq26GdLhDYFEm3uVeUyf4vqph2c+M706Fskv5rgZ+ftVRej7M/m1
 OeYoplHGaPZgKkn0ark8KAfRNMUc/kHoWFHxaMxGaemvwFfiiRn8Kskjd1Y4VLLl
 8HA1yGWGS4ipbBbVpmsEWCIufAWuZtn28jiOiC7mJdxnYWtq5f5Aqd0RPMwOlvIW
 Qam23gul3IMbhlXUG3oLCCsRq4gcAH8JmCijYfcDX3kQjLGGeAgmLKeUuwOxgjOw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3fvjwt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 22:41:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QMYtFB3252541; Mon, 26 Oct 2026 22:41:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh70prdn6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 22:41:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QMfdLl29426194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 22:41:39 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5469158051;
 Mon, 26 Oct 2026 22:41:39 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7FE75805A;
 Mon, 26 Oct 2026 22:41:38 +0000 (GMT)
Received: from [9.61.36.128] (unknown [9.61.36.128])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 22:41:38 +0000 (GMT)
Message-ID: <1c4de182-2501-4ed6-af53-7ec340615692@linux.ibm.com>
Date: Mon, 26 Oct 2026 18:41:38 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/pci: Change reset method from legacy to
 resettable exit
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, oelghoul@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261026171325.876-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261026171325.876-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6adfd724 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=K4JEhkl_TqowDnDZ9-EA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: Y22D7AskGGVOPZMNGQuHB_8P86MI2MXf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4OCBTYWx0ZWRfX2kysufLmdID1
 IYE6kUQ9iE50GsxbC9gEtTTAxzY79R+SjCKDiGVugFOlCzE/FZ0A82ZpiQn2XzHNzJ9lZOxnMlo
 l92gZesenmP7ZNaM1g+nmlEvkn3qA5A1YpBub5m6QFEeaxRDjv7K250dwTgugjEHlf9rd5eDF+s
 AyUtvV4C7rRlYdSNk03eBPdWasdttEeQJjek4sWce9Qi5yEZDyCN+GL7337LaXSflAzZbq9VUCH
 xJPub9NXRfTLu8EjL2AFGWDXoXGXG77jNU7YBg6iigO+b2wyZeBdW4vu8lMWNFW7V142DWSQQt3
 gbHSildyfgIlcU8CRYm80SMfO7mB+2OHz44tKwrgzqznHA5U/XKQrBozpC1eCE7OF3qjEOhSJpU
 eNU41OgS9KMiJHSn3L3YMQmCH/XXPCdpEGmRMQIRSUIpgGodMdWK91jv1RZ7M13tEd20urigRi+
 vqgB+TjXyX4NxsE4Zsg==
X-Proofpoint-GUID: Y22D7AskGGVOPZMNGQuHB_8P86MI2MXf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4OCBTYWx0ZWRfX8eGO5Y9F6njI
 DsOczABbjXGb9OmLTWiTlgSFfv3W+pKQYSIspNegfoqgR2Vt9nveaYlWoWGvRdW24saan8nF+tj
 HJua1yVjJgNbetjAxw1uxFhHMgheo50=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260088
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/26/26 1:13 PM, Farhan Ali wrote:
> On subsystem reset of the s390 PCI host bridge (TYPE_S390_PCI_HOST_BRIDGE),
> child buses S390PCIBus and PCIBus are reset in order. Because S390PCIBus
> devices are reset first via the legacy reset hook, IOMMU mappings are torn
> down before the PCI device itself is reset. For a PCI passthrough device
> this opens a window where the device may issue DMA to addresses that no
> longer have valid IOMMU mappings, causing an error (PEC 0x7) on the host.
> 
> The QEMU reset documentation (docs/devel/reset.rst) specifies that IOMMUs
> should perform teardown in the resettable 'exit' phase, after all devices
> have completed their 'hold' phase. Move the S390PCIBusDevice reset logic
> from the legacy reset hook to the resettable exit phase to close this
> window.
> 
> Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Thanks Farhan - I think this looks good, but I believe there's still
something off here that could either be fixed in this patch or with a
2nd patch before this one.

My concern is the interplay between the unplug_requested flag and the
FMB -- I think in the unlikely event we pcihost_reset() when
unplug_requested is set we would now miss freeing the FMB timer because
we won't actually end up driving s390_pci_device_reset_exit().  That's
because pcihost_reset is still operating on the legacy interface (i.e.
it gets run during the hold phase so the device gets removed from the
bus before the exit phase)

I think the simple answer would be to make sure the FMB timer is freed
in s390_pcihost_unplug() e.g. by calling fmb_timer_free() during
TYPE_S390_PCI_DEVICE handling.  If it was already called before there
will be no timer to cancel and the FMB will just get re-zero'd one last
time.

Could you take a closer look?

Thanks,
Matt

> ---
> v1: https://lore.kernel.org/all/20261022185829.11835-1-alifm@linux.ibm.com/
> v1 -> v2
>   - Change to s390_pci_device_reset() to resettable exit function. 
> 
>  hw/s390x/s390-pci-bus.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 2724b27ec2..a24ec98c1e 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1777,9 +1777,9 @@ static void s390_pci_device_realize(DeviceState *dev, Error **errp)
>      zpci->fmb.format = ZPCI_FMB_FORMAT;
>  }
>  
> -static void s390_pci_device_reset(DeviceState *dev)
> +static void s390_pci_device_reset_exit(Object *obj, ResetType type)
>  {
> -    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
> +    S390PCIBusDevice *pbdev = S390_PCI_DEVICE(obj);
>  
>      switch (pbdev->state) {
>      case ZPCI_FS_RESERVED:
> @@ -2010,10 +2010,11 @@ static const VMStateDescription s390_pci_device_vmstate = {
>  static void s390_pci_device_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      dc->desc = "zpci device";
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> -    device_class_set_legacy_reset(dc, s390_pci_device_reset);
> +    rc->phases.exit = s390_pci_device_reset_exit;
>      dc->bus_type = TYPE_S390_PCI_BUS;
>      dc->realize = s390_pci_device_realize;
>      device_class_set_props(dc, s390_pci_device_properties);


