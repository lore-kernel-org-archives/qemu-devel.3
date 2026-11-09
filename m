Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA1606A333
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rfOslL2V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQP8f-0008FL-Pi; Mon, 09 Nov 2026 08:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xQP8e-0008Em-5I; Mon, 09 Nov 2026 08:10:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xQP8c-0002Pz-At; Mon, 09 Nov 2026 08:10:19 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9AEQm43061588; Mon, 9 Nov 2026 13:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=nxOTKq
 qkmptaztO5RE487fr2RMwRix1sL09HIlO9gow=; b=rfOslL2V1qaSMxQc5mge8G
 mzi8TaVTuD2NeJR/03dcr+VtEy6hTdiL58UG6PP+dE0PPLIk9/tdfIju2mGxqSud
 nV2cPFoJlmMUlBaiR7v64x7+gvwhpZ/OFhB25FBJi8XfYOfeIQ2jiZ7rArHU0i4t
 ixnCLmcpQyg82xUj0HaNclD43tI/6EZfsfCDeuGAve2OI6bIDhfyHesXCABH5cGG
 U3nB9Yo4WcW85E3Z4Te5HBTrw36QUtTWwtJkUFlewbqTxcK+YKaLogtZB4IVGuHE
 iO6S9RZ7yzELJCB1ni9Thh3U+lg01ZdPefZTffFm3MVC9DwCX3DGMyEFKi7su7vg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkdkm5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 13:10:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9A4sZA4004466; Mon, 9 Nov 2026 13:10:14 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfajyukk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 13:10:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9DADdQ32244398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 13:10:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60B91580FC;
 Mon,  9 Nov 2026 13:10:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D395580FB;
 Mon,  9 Nov 2026 13:10:13 +0000 (GMT)
Received: from [9.61.241.37] (unknown [9.61.241.37])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 13:10:13 +0000 (GMT)
Message-ID: <d8caabd2-b855-46a0-abd3-f1df4908cca6@linux.ibm.com>
Date: Mon, 9 Nov 2026 07:10:13 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vhost: only use config notifier when exists/initialized
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>, "'Michael S . Tsirkin'"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20261103172732.837511-1-farman@linux.ibm.com>
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
In-Reply-To: <20261103172732.837511-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af1c637 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6R7veym_AAAA:8 a=xlo9B-6kGIh_nWvDcuQA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfXwkHhLmEmXD1C
 sAAv9Kvlgx/RE97hC6nazrO3K5iyQHv8/d+tzf/9eOmc2+ylLa9rkaBfU0X3zQ3CaEsF/3rJAC8
 FAmNwzJIRk1p0+OtD+9UZeHBJ01fo9dvko1Xe1kD3kTSeNeGv3Pr55eTVZyaSvSb3hEubr/MZj5
 ImLO9B4fLEwg0OiM0E817iv687lN56IDDwJs+mcc+WORYCvt7G3U3u4AnMqqIx5gT7KDofrf1bY
 Y+kwq72UyBDDI29swrO2pLpq1d6YWmV+g0W2pca2repP97nMSpfe2hf6o68EwoJ66eKEWFYVkOQ
 SQEHRGmeNVOZCSf2Rzy+XiwRV/BmamcB51gVKY61sSHmTcgPsANZwzbsLoGS3dXIEqtCDWIxHeQ
 Ebjqci2J/K1fFSsmCzVovDY7MI++PT2PdDxvfXTXk9s+V9xJHUS05Uld8BwIN6eYhVJqj5WlQAJ
 JoFY5ArvZa7XWmgsO+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MCBTYWx0ZWRfX9ogPFZMNLjj7
 PJBwDfxSmsaLmHqObZwQB8eKE0EqVerkdkoLdhlEANDDq7yzjqz17De2oMLABoU1CWd/q8J6SsF
 F8kpbUY9jmiSYwOMtSeIL78dA+06G4Y=
X-Proofpoint-ORIG-GUID: mQEujhgbe8-_0DOT41ROC7DHwe9NFjAi
X-Proofpoint-GUID: mQEujhgbe8-_0DOT41ROC7DHwe9NFjAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 261103 11:27, Eric Farman wrote:
> Commit e3b12d0c55e4 ("util/event_notifier: more strict API") added an
> assert for an uninitialized file descriptor in event_notifier_get_fd(),
> but it presumes that such a thing always exists.
> 
> On s390x, where a config notifier does not exist, this is a breaking
> change for any vhost-backed device such as virtio-net. To remedy this,
> move the acquisition of the file descriptor within the guard against
> vhost_set_config_call and expand the guard to ensure the notifier is
> initialized before being used.
> 
> Fixes: e3b12d0c55e4 ("util/event_notifier: more strict API")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/virtio/vhost.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index b25919c5c7d..189ac541178 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2119,8 +2119,9 @@ static void vhost_start_config_intr(struct vhost_dev *dev)
>           virtio_config_get_guest_notifier(dev->vdev);
>   
>       assert(dev->vhost_ops);
> -    int fd = event_notifier_get_fd(config_notifier);
> -    if (dev->vhost_ops->vhost_set_config_call) {
> +    if (dev->vhost_ops->vhost_set_config_call &&
> +        event_notifier_initialized(config_notifier)) {
> +        int fd = event_notifier_get_fd(config_notifier);
>           r = dev->vhost_ops->vhost_set_config_call(dev, fd);
>           if (!r) {
>               event_notifier_set(config_notifier);
> 

On s390x:

For VDPA-based virtio-net devices using the CCW transport this patch 
fixes the "Assertion `e->initialized' failed" in 
event_notifier_get_fd(). In this setup all fields in config_notifier are 0.

With the same setup using the PCI transport, the config_notifier 
assertion never happesn, because config_notifier is initialized.

Tested-by: Konstantin Shkolnyy <kshk@linux.ibm.com>


