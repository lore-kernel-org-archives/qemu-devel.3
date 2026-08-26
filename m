Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2766C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGi3-0003sY-Op; Wed, 26 Aug 2026 12:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wzGht-0003rd-BD; Wed, 26 Aug 2026 12:42:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wzGhq-0007LT-Uz; Wed, 26 Aug 2026 12:42:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1Upa2333650; Wed, 26 Aug 2026 16:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WFAgA4
 sKhm6TCPolRBTz7lIgd2EoPeC1C7sMB6Ena9s=; b=YTPAxBCQenbNouLoY1W+VN
 P8q/U7Y1TiwwI8+kT/PNC/cqQECVQCeEMgvKeQc3oTMbJAGCgKol5boHNO6S/Uwx
 PpCJU5pIdMVcR3WiyOjAfwACX824DSxyFbojzeRrQctTF0X9CwLBzIUQlCoX5u3i
 V/2ZlZz1qm1mYzmAyxl7gEpQ7swW/jxP8dPY+Dr3mulsGQI0DW8wf4ePM18hDRw2
 +tTb/Yrt5cdCvBJsnSafWL6jpEnWkyQQNUuo3ThlfTA9o0Ydu+7b0kiDYHXqyyr6
 lMMSU/IMMxaEDFsqL9OTLUwpQE04Ds4x97Cw9a5UPI98ybqwJt4M9+PWAcZpSLIg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqyvf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 16:42:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGfILq025794;
 Wed, 26 Aug 2026 16:42:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwb43n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 16:42:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QGgQwn22020666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 16:42:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A697C58053;
 Wed, 26 Aug 2026 16:42:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BB4958043;
 Wed, 26 Aug 2026 16:42:26 +0000 (GMT)
Received: from [9.12.79.241] (unknown [9.12.79.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Aug 2026 16:42:25 +0000 (GMT)
Message-ID: <114ff09c-3b52-4662-bd28-c025a1bf692e@linux.ibm.com>
Date: Wed, 26 Aug 2026 12:42:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] pc-bios/s390-ccw: Abstract virtio_run() for
 generic use
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-6-jrossi@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260811144629.866641-6-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QUg5ijICziUfq_zHFUg3eftIhu1SyTVs
X-Proofpoint-ORIG-GUID: QUg5ijICziUfq_zHFUg3eftIhu1SyTVs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX8h0/igAm79/9
 RP1mzSPrbMFhEMXrgO+8DMQBTIPCpZfqejn0doJQ2ITCcUY1h/ee8zSqfUnJ7X581m/r+piFhgO
 t1qrRmXB4XlcXn3UH1VtALnSWETnRdb2kLKB5gY7b+X9GujVJinThcLP4D7DvjOtMv7iIZKb6AC
 GUji86MaxaDgLNFs1rp6En7G80WM68WcmXtowge+S1vLvLnnsAWa22QqcI+c5HEp8QtENGbmYTo
 4ZjewQxrnL3IIjF8ogxROVkdN0JA7y09vTUKiKgZruGbTuDgChPlB7XqNKuQx/54VstNrwWL9PT
 Tj0IWss9CnrdnetOEvyRQrOkkU5kJz5mBK6ZimWvA0oLOtxVIq+shHlWPFoq10Hf2kkOGDfS6BH
 C1W/Mt8ZTF39JqkSApKp/rudszZagEvrqFxE7KCgEyxKCD09Is/DEwWxiF36QnjG4LPLkRspEa4
 2pxrf6pQ/fP010QkU3w==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8f1775 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=3P42ayun9Ii4-pH_0bUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX4jTxukEGHSfv
 PcriglrgypzjB/cMUi5X0/FJ5J7B3wskcgxYxh/x6HZkhTPMpEa2ZTexxkWKOCX4bFc/uK9PZAQ
 ombTMX5ERPom99mjE0MCUNCxcYf/vcs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
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

On 8/11/26 10:46 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The existing virtio_ccw_run() actually has no dependency on CCW.  Rather
> than add a case for non-ccw devices, we can just put main logic right in

Small nit: "we can just put the main logic..."

> the virtio_run() call so that it can be used for other bus types directly.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio-ccw.c | 17 -----------------
>  pc-bios/s390-ccw/virtio-ccw.h |  1 -
>  pc-bios/s390-ccw/virtio.c     | 16 +++++++++++-----
>  3 files changed, 11 insertions(+), 23 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-ccw.c b/pc-bios/s390-ccw/virtio-ccw.c
> index 5cb2158ed2..ea5dbc2857 100644
> --- a/pc-bios/s390-ccw/virtio-ccw.c
> +++ b/pc-bios/s390-ccw/virtio-ccw.c
> @@ -107,23 +107,6 @@ long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie)
>                           vq_idx, cookie);
>  }
>  
> -int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd)
> -{
> -    VRing *vr = &vdev->vrings[vqid];
> -    int i = 0;
> -
> -    do {
> -        vring_send_buf(vr, cmd[i].data, cmd[i].size,
> -                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
> -    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
> -
> -    vring_wait_reply();
> -    if (drain_irqs()) {
> -        return -1;
> -    }
> -    return 0;
> -}
> -
>  int virtio_ccw_reset(VDev *vdev)
>  {
>      return run_ccw(vdev, CCW_CMD_VDEV_RESET, NULL, 0, false);
> diff --git a/pc-bios/s390-ccw/virtio-ccw.h b/pc-bios/s390-ccw/virtio-ccw.h
> index a506767eaa..43d21906e5 100644
> --- a/pc-bios/s390-ccw/virtio-ccw.h
> +++ b/pc-bios/s390-ccw/virtio-ccw.h
> @@ -16,7 +16,6 @@ extern SubChannelId blk_schid;
>  /* virtio-ccw.c */
>  int drain_irqs_ccw(SubChannelId schid);
>  bool virtio_ccw_is_supported(VDev *vdev);
> -int virtio_ccw_run(VDev *vdev, int vqid, VirtioCmd *cmd);
>  long virtio_ccw_notify(SubChannelId schid, int vq_idx, long cookie);
>  int virtio_ccw_setup(VDev *vdev);
>  int virtio_ccw_reset(VDev *vdev);
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 0b33544144..34c5e6ee22 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -70,13 +70,19 @@ int drain_irqs(void)
>  
>  int virtio_run(VDev *vdev, int vqid, VirtioCmd *cmd)
>  {
> -    switch (vdev->ipl_type) {
> -    case S390_IPL_TYPE_QEMU_SCSI:
> -    case S390_IPL_TYPE_CCW:
> -        return virtio_ccw_run(vdev, vqid, cmd);
> -    default:
> +    VRing *vr = &vdev->vrings[vqid];
> +    int i = 0;
> +
> +    do {
> +        vring_send_buf(vr, cmd[i].data, cmd[i].size,
> +                       cmd[i].flags | (i ? VRING_HIDDEN_IS_CHAIN : 0));
> +    } while (cmd[i++].flags & VRING_DESC_F_NEXT);
> +
> +    vring_wait_reply();
> +    if (drain_irqs()) {
>          return -1;
>      }
> +    return 0;
>  }
>  
>  void vring_init(VRing *vr, VqInfo *info)


