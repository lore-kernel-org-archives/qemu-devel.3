Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE805104C00E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0H6b-0001dj-9e; Wed, 11 Mar 2026 06:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1w0H6O-0001cK-F1; Wed, 11 Mar 2026 06:47:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1w0H6M-0001Ez-7Z; Wed, 11 Mar 2026 06:47:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B1vV4m049228; Wed, 11 Mar 2026 10:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jF/Ken
 oI3xWzufMFlxgeCnulwbQylHRPVFFbFeR7+F0=; b=tPOVJuemok0tE14mzXO3b2
 3EZEwBOcUzO7BpB1yNNI2RIYN3qFawbzcogzRMtEc3Hk4LATBNSAQvuuNawgwTq8
 Y+OWkV0mqcbHTX5kMJrl07Bd6OOOZYpG/EQE/Gl25NWqTPeo/iTpfStu1W0aVEE+
 ihD+Jfz+qTcsVEYjhsS6tb7RGAxkNqcEX+GJi30WuDVfMdQkVYAisKuxbI2GosWU
 eKxCPmZgniUQqk6ckrdfMBp+emwTrOmobmCpSpwzg+D1Jz+0XOtr5HoGc0YhSd0e
 RNoJ9i4EAbMFzSJls0JlLkQxHhGqYA34KQ1hlz5hXR521qxPkD/V2yDZ8L5UvNHQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmfg21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 10:47:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B83s7t024660;
 Wed, 11 Mar 2026 10:47:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk4wq0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 10:47:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62BAlZtS38797832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 10:47:35 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25D1D58059;
 Wed, 11 Mar 2026 10:47:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1821C58057;
 Wed, 11 Mar 2026 10:47:34 +0000 (GMT)
Received: from [9.61.143.63] (unknown [9.61.143.63])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2026 10:47:33 +0000 (GMT)
Message-ID: <cc51de63-ab94-4044-89c0-c440b724a344@linux.ibm.com>
Date: Wed, 11 Mar 2026 06:47:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] util/event_notifier: fix error handling for
 event_notifier_init callers
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-s390x@nongnu.org
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-4-viking4@gmail.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260310182801.196443-4-viking4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: m_e2cJjvG5riBDcIkUCHSvA4U9_C_zev
X-Proofpoint-ORIG-GUID: HWVFOLtRPfE32H2hlV0lHwCpcbMPRYKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4OCBTYWx0ZWRfXzzNW+Rak04dw
 IUND1BcGA+sBhpplhpXNvScHptvjwtyptwI/2DHKGzth707BtiG/ijU55PtecWzl/AVi/l77ivd
 4gAgCXR0F8dt1oTZUJN2mlMPAUMLim8BniO7FbXcIDb18j4JcYIfRL7sjLe5NJrOcs3M5F2laN7
 AJoxy8ffaeJfZ5Xee4eCwRSX0FMUmJ2RtSVldldusRRmooZxUH7FQVVUaahRsklX9ToaqOVF/Rw
 OeOcxTA8B7kuOWwGtn8I3+B1Ab5FcYFjOpK/hHlKDOMZ2C3uT/Jbz2pmW7CQ9YcU0t33EILIKRU
 PbZa/p7Fp6nVo2DJdlTbPQsrLBU8cFYhExq0qeBKT680j7dMMNPGleqFCh7DvOhXfjOCxZb769T
 4MUKjSX0AHRoxs6Gq93pcIO+ZpsmfaOsd63pYf7H/hqMK+/DDAVwcXPo7HQrD89R01yQd41wqcg
 eB/kvADaFIHnO41M0IA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b1484a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=EgclEWYoO7V04lid-PAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 3/10/26 2:27 PM, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
>
> Check return value of event_notifier_init() and return early on
> failure instead of continuing with invalid state.
> - Use ret < 0 to handle negative return value.
> - No functional changes.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/413
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>   hw/hyperv/hyperv.c     |  4 ++--
>   hw/hyperv/vmbus.c      |  4 ++--
>   hw/remote/proxy.c      | 15 +++++++++++++--
>   hw/vfio/ap.c           |  2 +-
>   hw/vfio/ccw.c          |  2 +-
>   hw/vfio/pci-quirks.c   |  2 +-
>   hw/vfio/pci.c          |  2 +-
>   hw/virtio/vhost-vdpa.c |  4 ++--
>   8 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 27e323a819..aa278b179e 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -439,7 +439,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
>           sint_route->staged_msg->cb_data = cb_data;
>   
>           r = event_notifier_init(ack_notifier, false);
> -        if (r) {
> +        if (r < 0) {
>               goto cleanup_err_sint;
>           }
>           event_notifier_set_handler(ack_notifier, sint_ack_handler);
> @@ -453,7 +453,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
>   
>       /* We need to setup a GSI for this SintRoute */
>       r = event_notifier_init(&sint_route->sint_set_notifier, false);
> -    if (r) {
> +    if (r < 0) {
>           goto cleanup_err_sint;
>       }
>   
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index c5bab5d245..2f0d2a03d8 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -1425,7 +1425,7 @@ static void open_channel(VMBusChannel *chan)
>           goto put_gpadl;
>       }
>   
> -    if (event_notifier_init(&chan->notifier, 0)) {
> +    if (event_notifier_init(&chan->notifier, 0) < 0) {
>           goto put_gpadl;
>       }
>   
> @@ -2416,7 +2416,7 @@ static void vmbus_realize(BusState *bus, Error **errp)
>       }
>   
>       ret = event_notifier_init(&vmbus->notifier, 0);
> -    if (ret != 0) {
> +    if (ret < 0) {
>           error_setg(errp, "event notifier failed to init with %d", ret);
>           goto remove_msg_handler;
>       }
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 5081d67e7f..e91566509f 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -52,9 +52,20 @@ static void setup_irqfd(PCIProxyDev *dev)
>       PCIDevice *pci_dev = PCI_DEVICE(dev);
>       MPQemuMsg msg;
>       Error *local_err = NULL;
> +    int ret = 0;
>   
> -    event_notifier_init(&dev->intr, 0);
> -    event_notifier_init(&dev->resample, 0);
> +    ret = event_notifier_init(&dev->intr, 0);
> +    if (ret < 0) {
> +        error_report("Failed to init intr notifier: %s", strerror(-ret));
> +        return;
> +    }
> +
> +    ret = event_notifier_init(&dev->resample, 0);
> +    if (ret < 0) {
> +        error_report("Failed to init resample notifier: %s", strerror(-ret));
> +        event_notifier_cleanup(&dev->intr);
> +        return;
> +    }
>   
>       memset(&msg, 0, sizeof(MPQemuMsg));
>       msg.cmd = MPQEMU_CMD_SET_IRQFD;
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index e58a0169af..5c8f305653 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -180,7 +180,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>           return false;
>       }
>   
> -    if (event_notifier_init(notifier, 0)) {
> +    if (event_notifier_init(notifier, 0) < 0) {

Acked-by:  Anthony Krowiak <akrowiak@linux.ibm.com>

>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 2251facb35..ce9c014e6a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -418,7 +418,7 @@ static bool vfio_ccw_register_irq_notifier(VFIOCCWDevice *vcdev,
>           return false;
>       }
>   
> -    if (event_notifier_init(notifier, 0)) {
> +    if (event_notifier_init(notifier, 0) < 0) {
>           error_setg_errno(errp, errno,
>                            "vfio: Unable to init event notifier for irq (%d)",
>                            irq);
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 7b907b9360..66e02b15a4 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -318,7 +318,7 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
>   
>       ioeventfd = g_malloc0(sizeof(*ioeventfd));
>   
> -    if (event_notifier_init(&ioeventfd->e, 0)) {
> +    if (event_notifier_init(&ioeventfd->e, 0) < 0) {
>           g_free(ioeventfd);
>           return NULL;
>       }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c89f3fbea3..29bf6511b3 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -70,7 +70,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>       }
>   
>       ret = event_notifier_init(e, 0);
> -    if (ret) {
> +    if (ret < 0) {
>           error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
>           return false;
>       }
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 2f8f11df86..9c7634e243 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1075,13 +1075,13 @@ static int vhost_vdpa_svq_set_fds(struct vhost_dev *dev,
>       int r;
>   
>       r = event_notifier_init(&svq->hdev_kick, 0);
> -    if (r != 0) {
> +    if (r < 0) {
>           error_setg_errno(errp, -r, "Couldn't create kick event notifier");
>           goto err_init_hdev_kick;
>       }
>   
>       r = event_notifier_init(&svq->hdev_call, 0);
> -    if (r != 0) {
> +    if (r < 0) {
>           error_setg_errno(errp, -r, "Couldn't create call event notifier");
>           goto err_init_hdev_call;
>       }


