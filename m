Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057CCCF2560
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 21:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLTWs-0000cx-6H; Tue, 18 Nov 2025 16:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vLTWc-0000R8-2Z; Tue, 18 Nov 2025 16:46:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vLTWS-0005VI-Bf; Tue, 18 Nov 2025 16:46:09 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIHCI6Y018752;
 Tue, 18 Nov 2025 21:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ToWCve
 a5EN5YRCo6fIgblRXyTnn8G3VwvRZHFyeBIQs=; b=tnUJ6TeNxMf3H5OyDtfdqi
 4cU40GTIu4DOSaqJ7tvpNPvfeo7DewvOIILn77cr2FuvZ3KxQVSfP5JBK29bINbE
 svwgjAw75hbT4RenZ1G6ka6fKPYxZEjz/m0V1GJuCglRspc25QUkY6SaOvQoxVGi
 fWoRl3ieazvGT0fCOjDJEk0ACU8ZmkpIjaIH0Kl28JdTI4wkP7kTNEZEZtIM7x3t
 JId3d3bUsOpjSe8eJFRDFKQc2D/T7Mj8S0w3bsF2229K4jRxYgjK69V8dt+5Qv0R
 ddaLQrKoi8Zua9++8E/Oy9N3LvnlDYuJVUDDz/AOTf7wds5+PbamsAQXFm6CHEEw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjw5cxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 21:45:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIIsN0u022354;
 Tue, 18 Nov 2025 21:45:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af4umwc7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Nov 2025 21:45:50 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5AILjnjg57147660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Nov 2025 21:45:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0574358054;
 Tue, 18 Nov 2025 21:45:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E82975805A;
 Tue, 18 Nov 2025 21:45:47 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.147.101]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Nov 2025 21:45:47 +0000 (GMT)
Message-ID: <8fd35be2f4d424f0093110a050c7e29830561012.camel@linux.ibm.com>
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato	 <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Cornelia Huck <cohuck@redhat.com>
Date: Tue, 18 Nov 2025 16:45:47 -0500
In-Reply-To: <20251118174047.73103-1-thuth@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BanVE7t2 c=1 sm=1 tr=0 ts=691ce90f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=Xb_Ia24lGh4acGu2WagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX163q4jBHKr+R
 UZ5eWWaUW5880tgklAbzVcsxFoWFo5OtDfa/j/G7BowQhJGoGWWHMGBZ92MScL2PdrvhLjetxG4
 5M55QBN24GBj1sxcJUZK7RLqa7rtFnyDq688LHwKlADIXi936dIHg7m3ujiajzp1H15Vg6Au7yk
 v5vHjBezrqkZMFKUuRdkEah00ZwtFEJgNaxa/EK9SLPwsx0FLQFsie847NWWUWFOOIJv3psz/tp
 T32RoOQjeB/Kn9Vx5v485dXD82dWNzA8TWnIrqY+/5tB+Riw9kAnB6doMJbJUnOZ8FyVWi8So2X
 IbJ3W6tbefwn8JCu9e+Gdza9TWFlcZGmWTon5oeyHyaz6oLDhOU0AU4zYMFTgQ/czXmweUE4WXS
 2JJvwd3eUyx5rUwX3slm+rcyWr2woA==
X-Proofpoint-GUID: jwpGAYeVX8cj9E35gOWNWahve6rLedXc
X-Proofpoint-ORIG-GUID: jwpGAYeVX8cj9E35gOWNWahve6rLedXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_03,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 2025-11-18 at 18:40 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> Consider the following nested setup: An L1 host uses some virtio device
> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
> device through to the L3 guest. Since the L3 guest sees a virtio device,
> it might send virtio notifications to the QEMU in L2 for that device.
> But since the QEMU in L2 defined this device as vfio-ccw, the function
> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
> but since "sch" belongs to a vfio-ccw device, that driver_data rather
> points to a CcwDevice instead. So as soon as QEMU tries to use some
> VirtioCcwDevice specific data from that device, we've lost.
>=20
> We must not take virtio notifications for such devices. Thus fix the
> issue by adding a check to the handle_virtio_ccw_notify() handler to
> refuse all devices that are not our own virtio devices. Like in the
> other branches that detect wrong settings, we return -EINVAL from the
> function, which will later be placed in GPR2 to inform the guest about
> the error.

I still think this is a good idea, but of course "let's try it" got me into=
 the weeds. I
reconstructed a configuration (dasd->virtio-blk-ccw->vfio-ccw->virtio-blk-c=
cw) that crashes the
nested guest upon startup with today's master. Applying this patch generate=
s that message to point
out where it's broken (yay!), but the nested guest hangs during boot. Need =
to ponder this more
tomorrow.

...
2025-11-18T21:22:36.645657Z qemu-system-s390x: warning: Got virtio notifica=
tion for unsupported
device on subchannel 00.0.0002!

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v3: Print the subchannel number to ease debugging
>=20
>  hw/s390x/s390-hypercall.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
> index ac1b08b2cd5..508dd97ca0d 100644
> --- a/hw/s390x/s390-hypercall.c
> +++ b/hw/s390x/s390-hypercall.c
> @@ -10,6 +10,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "cpu.h"
>  #include "hw/s390x/s390-virtio-ccw.h"
>  #include "hw/s390x/s390-hypercall.h"
> @@ -42,6 +43,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id,=
 uint64_t data)
>      if (!sch || !css_subch_visible(sch)) {
>          return -EINVAL;
>      }
> +    if (sch->id.cu_type !=3D VIRTIO_CCW_CU_TYPE) {
> +        /*
> +         * This might happen in nested setups: If the L1 host defined th=
e
> +         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
> +         * L2 guest passes this device through to the L3 guest, the L3 g=
uest
> +         * might send virtio notifications to the QEMU in L2 for that de=
vice.
> +         * But since the QEMU in L2 defined this device as vfio-ccw, it'=
s not
> +         * a VirtIODevice that we can handle here!
> +         */
> +        warn_report_once("Got virtio notification for unsupported device=
 "
> +                         "on subchannel %02x.%1x.%04x!", cssid, ssid, sc=
hid);
> +        return -EINVAL;
> +    }
> =20
>      vdev =3D virtio_ccw_get_vdev(sch);
>      if (vq_idx >=3D VIRTIO_QUEUE_MAX || !virtio_queue_get_num(vdev, vq_i=
dx)) {

