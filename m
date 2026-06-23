Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9188CCDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6tk-0001J4-It; Tue, 23 Jun 2026 15:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6tj-0001IZ-1R; Tue, 23 Jun 2026 15:35:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6th-00079S-CP; Tue, 23 Jun 2026 15:35:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBndEB1859500; Tue, 23 Jun 2026 19:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ld2gGb
 j4/yDEXcI912FZf6ooUeFIeSY7j6YJoE1AJxo=; b=q3Svm7GXX/5pWXsxCUeMaw
 ruqQX1DKPXcl4t8PxWwU3jfFEX9bLZo7yqTlCLfMj6GVcMcB4ZkBinHHYsOxZwDx
 KSipX6Qfd9KJslkO8lhcWD2NdL1Gw+7BMxxo5nHOj+orMoHsIaskGdx/sxzdeTps
 nRzWE23B9CpxbU5n9dWW8IWaC5BzrHQPKVchhBmsLHyOUgSLdaRP2lYglC+ulZWC
 l0UjGhfOR+oUUPWlZJ/5L7X9y5W5RkgM9xtBuUCkbgwd00slfgcw8SPq6Qgll844
 8tfo55xniLdDKfvyom3p1X6YcvaflrlpPlC6BD0yTylOpccE5HqnO5sBedBQKizA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hrrah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:34:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJYjsi012266;
 Tue, 23 Jun 2026 19:34:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vymrnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:34:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NJYv9p60686606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 19:34:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4B3858045;
 Tue, 23 Jun 2026 19:34:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A27758052;
 Tue, 23 Jun 2026 19:34:56 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.119.138]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 19:34:56 +0000 (GMT)
Message-ID: <6e9b03193bf4c9f91fc3b048bb5351214fd6cbe5.camel@linux.ibm.com>
Subject: Re: [PATCH 4/5] pc-bios/s390-ccw: Verify virtio support when
 booting from PCI device on s390x
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Tue, 23 Jun 2026 15:34:56 -0400
In-Reply-To: <20260623002539.126124-5-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-5-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4y7J0HawALgIrO_91qHWZ1Sc3Hy25Gu0
X-Proofpoint-GUID: 4y7J0HawALgIrO_91qHWZ1Sc3Hy25Gu0
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3adfe3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=AFl0a9Ox4e6MA6pfEscA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfXyCme7w9Ndxej
 266YyoIfc1cjqqx19uwlkSJhdWggs/GOiqsyRliLfmr/tqqnW8utku4ZptG4acrSTlUsiqQRE2k
 gxzuIXlMN0FFnRZi+dYk9+SLSFJsWYUlvlKxlcKAmL/PxTAnC1PViLoitZLOIKXycwETuBZbgpj
 /KMxeiEMWlK7qwJQNBdH5d/IcIBN7JZtetKcWOn4AMezVTa3A9Eqsk3S/aiJcdejuwEVhz/I5Wz
 2bsFaHnDda22Vru2CGR7/qBWSKZXMqu6LCmdyeU/ydZkzwLWdlhr8Dk1/X33li2k/ueAvNRNYdp
 vCXFYB2oOXWllFrzRcrZOaeW+WSAXn3yTAhtMRWZcDxu6vUsPdbT4talrDk9EhiHDDd5p0kLvQO
 KmoZVrUmKZ3trF3lz6FhEfO9kaRGEoKLKzWq2AmeTlX7h5ELToh+PlN3zaofGrCFAYsNbqeG/rN
 k++TYI4e2y2IELa3gKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX0Y9akxpBY3FR
 dF/4kCm4QYrKlqRyswBcripP4D5fS83w9RqeebuNk2Qh8/X0kIgjqkFa9X/qvu5yTPEbPFQ9GRg
 NO8IxsUDaPDYrG1yZkZKt8pUH9zU9e8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

On Mon, 2026-06-22 at 20:25 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> The virtio specification requires that each PCI device has a vendor ID of
> 0x1AF4.  Verify this value before continuing with boot process.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/main.c       |  1 +
>  pc-bios/s390-ccw/virtio-pci.c | 19 +++++++++++++++++++
>  pc-bios/s390-ccw/virtio.h     |  1 +
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index 1059fda03c..567e97bf32 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -164,6 +164,7 @@ static bool find_fid(uint32_t fid)
>      }
> =20
>      vdev->pci_fh =3D entry.fh;
> +    vdev->vendor_id =3D entry.vendor_id;
>      virtio_pci_id2type(vdev, entry.device_id);
> =20
>      return vdev->dev_type !=3D 0;
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.=
c
> index 2c83ec4f13..07b53b894f 100644
> --- a/pc-bios/s390-ccw/virtio-pci.c
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -325,6 +325,20 @@ static int enable_pci_bus_master(void)
>      return 0;
>  }
> =20
> +bool virtio_pci_is_supported(VDev *vdev)
> +{
> +    if (vdev->vendor_id =3D=3D 0x1AF4) {

I'd prefer this hex value be lowercase, as they usually are in code.

Not sure where a good place would be, but defining a constant for the PCI V=
endor ID 0x1af4 (similar
to `#define CU_TYPE_VIRTIO          0x3832`) would provide some good contex=
t of what's happening
here.

> +        switch (vdev->dev_type) {
> +        case VIRTIO_ID_BLOCK:
> +            return true;
> +        default:
> +            return false;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  int virtio_pci_setup(VDev *vdev)
>  {
>      VRing *vr;
> @@ -335,6 +349,11 @@ int virtio_pci_setup(VDev *vdev)
>      vdev->guessed_disk_nature =3D VIRTIO_GDN_NONE;
>      vdev->cmd_vr_idx =3D 0;
> =20
> +    if (!virtio_pci_is_supported(vdev)) {

Why is this done here, versus called from virtio_is_supported() such that i=
t covers both -ccw and -
pci paths?

I'm guessing it's because the CLP data that contains the vendor_id isn't re=
ad until find_fid(),
which runs against the possible call in probe_boot_device()->is_dev_possibl=
y_bootable(). If there's
a way to straighten out that chicken/egg I think that'd be useful.

> +        puts("Virtio PCI unsupported for this device ID");
> +        return -ENODEV;
> +    }
> +
>      if (virtio_pci_read_pci_cap_config()) {
>          puts("Invalid virtio PCI capabilities");
>          return -EIO;
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index 75ae5bdbc2..aa307025e0 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -259,6 +259,7 @@ struct VDev {
>      bool scsi_device_selected;
>      ScsiDevice selected_scsi_device;
>      uint32_t pci_fh;
> +    uint16_t vendor_id;
>      uint32_t max_transfer;
>      uint32_t guest_features[2];
>  };

