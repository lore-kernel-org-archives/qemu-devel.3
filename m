Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4C6CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6rj-0000Tt-Gz; Tue, 23 Jun 2026 15:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6ri-0000TZ-A3; Tue, 23 Jun 2026 15:32:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wc6rg-0006x2-HR; Tue, 23 Jun 2026 15:32:57 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmMvW2135782; Tue, 23 Jun 2026 19:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dZYaHy
 o9qRgHexT5MVT9v7X4lKz13O9r7kjuwRlelmw=; b=EJn1ksDSD+7gNynDS5/bdi
 Tg57+/o2hSF8c71/pWCu5NtcXpXFqBjuPfg+FbewXUTV02kmS3F6nBcZMUVBxa3l
 n7z13BnxjW/ngnufocj/iDfmo7naGe6KOP4qtIrN394PSaknrCPqmoSZ/P3u9+Ym
 HudkCk6vEa1WbNsm/wd+9SFBoy60iX8r8aJIK/Cw7m98lAO1sth3bunoJEswm8kg
 O3HoAUOrsYbUAhsYzv9/JE6oMrJjg0Clxpy2TgqDIItBApJKZXQgEFcISg5nz7Is
 BavxbobZbRoMxj+smynpTG+yI5q88Ku0kbbN/aeyu+BNi3+RCy5HiejkQxT3uiIw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqrfpa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:32:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJJfK3010379;
 Tue, 23 Jun 2026 19:32:53 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qd8t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 19:32:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NJWpKt26804962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 19:32:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A63BF58058;
 Tue, 23 Jun 2026 19:32:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EABD58057;
 Tue, 23 Jun 2026 19:32:51 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.119.138]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 19:32:50 +0000 (GMT)
Message-ID: <100858bebb022479be4e1cb7ca2a30dd5d8377e1.camel@linux.ibm.com>
Subject: Re: [PATCH 2/5] pc-bios/s390-ccw: Add per-queue notification offset
 for multi-queue virtio configurations
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: zycai@linux.ibm.com, jdaley@linux.ibm.com, jjherne@linux.ibm.com,
 nrb@linux.ibm.com
Date: Tue, 23 Jun 2026 15:32:50 -0400
In-Reply-To: <20260623002539.126124-3-jrossi@linux.ibm.com>
References: <20260623002539.126124-1-jrossi@linux.ibm.com>
 <20260623002539.126124-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3adf66 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=FL2x9lXo9NC6j_DobJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfX+gpeuAYDDgUY
 9GpyucDt6qweKuAiOeIo526L87qsxyU0nsNyufLbJCw/xVM/iRz2ydgCSq4JjRUDfWP5zoDM8Qj
 5qYdMeIrE9L7f5ayqCIdRnUL0B37TTw+sW3pcQSDiM/5CUa3DTqlVdM9219QuyUPWpnbmm3NJIS
 lPtck/wLZdNt0oynV7gAyvaKJ50TAh6w5h+rOyVm36o96vfEpWdUXXiQJmwIK8snIsHWOX6rZaL
 cKx+UrgLlVv1DLHYXGN+zGWlHChqM0X5FXmUiYGZucIDYWsDHR2qxusA/73x2MCF80jy7b++NOM
 VQdupD6rg+D2B0q1hIRO7+zD/PgS5wz36IkPrpgwmsF+INWfLt5R6CnOcuhTAhjwzq07DJd3i2n
 WgIItJHki3LEneUEfMN7nY0d5fO+pN0B3uiANZNBCDGWIffOh0FngA7row57io0fi0ENNFCqPhp
 8IcHL87X3zewb3q7VBA==
X-Proofpoint-GUID: BbLTv3wAKfptg9ehCKgRJR8G02jpSdhu
X-Proofpoint-ORIG-GUID: BbLTv3wAKfptg9ehCKgRJR8G02jpSdhu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1OSBTYWx0ZWRfXz4jRU3Q0c1ij
 FnjRw6As0S6b/F+TjTTwNdUO67n5pFgjh2FvapCFNO8tYKpCANejG3HvYkyFc+K1TOhr/dRSQJB
 24tK56e8I1GGBcQSo7oIyV2H7o9HwAY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230159
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
> From: Zhuoying Cai <zycai@linux.ibm.com>
>=20
> The initial support for virtio-blk-pci IPL devices used a single virt-que=
ue, but
> other device types require multiple queues, and for PCI device types this=
 also
> requires a per-queue notification offset.
>=20
> Add a PCI notify field to the VRing struct so that each queue has a uniqu=
e
> notify offset as defined in the virtio spec.
>=20
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-pci.c | 38 +++++++++++++++++++++--------------
>  pc-bios/s390-ccw/virtio-pci.h |  2 +-
>  pc-bios/s390-ccw/virtio.c     |  3 ++-
>  pc-bios/s390-ccw/virtio.h     |  1 +
>  4 files changed, 27 insertions(+), 17 deletions(-)

...snip...


> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index a448dc96e2..df04479aa6 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -114,7 +114,8 @@ bool vring_notify(VRing *vr)
>          vr->cookie =3D virtio_ccw_notify(vdev.schid, vr->id, vr->cookie)=
;
>          break;
>      case S390_IPL_TYPE_PCI:
> -        vr->cookie =3D virtio_pci_notify(vr->id);
> +        vr->cookie =3D virtio_pci_notify(vr);
> +        break;

The addition of this break is an important (and correct) fix, but shouldn't=
 be tucked into this
change. Please make it its own (preceding) patch, with a Fixes tag against =
d72fb5e6b2e.

Besides that, this looks fine.

>      default:
>          return 1;
>      }
> diff --git a/pc-bios/s390-ccw/virtio.h b/pc-bios/s390-ccw/virtio.h
> index d32a4830ca..75ae5bdbc2 100644
> --- a/pc-bios/s390-ccw/virtio.h
> +++ b/pc-bios/s390-ccw/virtio.h
> @@ -107,6 +107,7 @@ struct VRing {
>      VRingUsed *used;
>      long cookie;
>      int id;
> +    uint16_t pci_notify;
>  };
>  typedef struct VRing VRing;
> =20

