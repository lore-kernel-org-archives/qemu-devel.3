Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C016CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNwh-0002s3-S8; Mon, 11 May 2026 06:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wMNv2-0002h5-O2; Mon, 11 May 2026 06:31:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1wMNv1-0002m5-4v; Mon, 11 May 2026 06:31:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BA7tBh2635669; Mon, 11 May 2026 10:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gC9dN6
 ZARWW5Y0/YqzelG/g9zjb9af4EfTyaKKNfEQ0=; b=rmcH5Vev9QV3GGnzEwfVx4
 Y8RfYJ8GTrolCMz8mVPtzLU5oKyeoz8QAA8Nkw/6s56YPykeRuoEckBgN4erFNBS
 u40ZcGm2EmIGc1urUhb6Nki9iL9MXmhpD937ZO7jV/4BLwoGESqHWQb1eCexqxqv
 yN0ceGXbkGtLQnsvyh1wmWIOxxRGJei+E8FqE2cETT6IRRdmtgFTX8OcKe+wwPuq
 RY3cfUb3tXePi9UgJz6Wo/RmqNkV0sriqFzly/WjIU3QAj60wWf718XLWRGX6ApE
 xaMOmxnyTPWeBWLMoBJyLhIpuevwyU7f/q3+P9aM9f/m0dGFjoRYZw3XGAxfC9PA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vn4qrs2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 10:31:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BAOSl4010275;
 Mon, 11 May 2026 10:31:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg4msw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 10:31:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BAVDJF4850370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 10:31:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21E1A58067;
 Mon, 11 May 2026 10:31:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62E0358079;
 Mon, 11 May 2026 10:31:12 +0000 (GMT)
Received: from [9.61.29.46] (unknown [9.61.29.46])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 10:31:12 +0000 (GMT)
Message-ID: <8a95b6d6-70f7-40fd-950e-56b087715b58@linux.ibm.com>
Date: Mon, 11 May 2026 06:30:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vfio/ap: Return false when IRQ notifier setup fails
To: zhaoguohan@kylinos.cn, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
 <20260510084353.58263-2-zhaoguohan@kylinos.cn>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260510084353.58263-2-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BM+DalQG c=1 sm=1 tr=0 ts=6a01aff2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Qmd6pTco9rnQzs-oBLoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDExMSBTYWx0ZWRfX6KlQasE02xPg
 e7QCCpO6m43gikrDnBhDWhvP1v4QD/QncRsXfbW75gdR8o/0mQCvHm5MvHb1vQM+9Gi4pqdLR6P
 TzpLAlPkLyP1YeD1yfH9Ry2CcqFUy+QeRzZcvsPGevdR+Y6T+kiCFbmYHSZmCJIdnYjK/x710qa
 HnkdW4AzabU+Kpl8B2WaMi3f2N5DHdFyF8C5lRECmcZ2d70buAAqeOB9SRDTV7PUOo/VmLwH7js
 BG7dHLJ0z+YmzTjouuFlubhT41hpu5YNuMSeEZ2sNsI70bNfY28eNKqOrtJaGgDiM20vo5VAnYk
 7O6bdQe7hwdO7o3EE1lSieWW8qqcZ+V4DTfWau1uPH1VFImll1SfX9uFrM3JndCMIdTCxZtO1NU
 Tczj3zLOowiB5FeZvO3KuSSQil8GWvhSFd4VwNK76ptDiGw8wyn6hD16rgY3EOc+TP+m9tNUimU
 SItWAWKa6qXA9o2f2EQ==
X-Proofpoint-GUID: wBlNk4kxu5sSp3-6rsk1LhlqC-EnHHGA
X-Proofpoint-ORIG-GUID: wBlNk4kxu5sSp3-6rsk1LhlqC-EnHHGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 5/10/26 4:43 AM, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>
> vfio_ap_register_irq_notifier() cleans up the fd handler and EventNotifier
> when vfio_device_irq_set_signaling() fails, but still returns true to its
> caller.
>
> Return false after cleanup so the caller can handle the failed
> registration path instead of treating it as a successful notifier setup.
>
> Fixes: cbd470f0aac5 ("vfio/ap: Make vfio_ap_register_irq_notifier() return a bool")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>   hw/vfio/ap.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 276ae8c207bf..6e2a1223ea8d 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -193,6 +193,7 @@ static bool vfio_ap_register_irq_notifier(VFIOAPDevice *vapdev,
>                                          errp)) {
>           qemu_set_fd_handler(fd, NULL, NULL, vapdev);
>           event_notifier_cleanup(notifier);
> +        return false;

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

>       }
>   
>       return true;


