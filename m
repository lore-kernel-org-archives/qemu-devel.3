Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F02BF3C266
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzb3L-0002DU-Aj; Mon, 09 Mar 2026 09:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzb3C-0002C5-M9; Mon, 09 Mar 2026 09:53:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzb3A-0006rJ-P0; Mon, 09 Mar 2026 09:53:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628LqcCa1502518; Mon, 9 Mar 2026 13:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4cQQ6M
 w8lig97p6J1fetIOkOpftB+vjSeQ78lK7F4AI=; b=RYDM+uLR1l3F7ayC791mF0
 Bk/FdPkHX16EU17hOsn/Tg40HwxDtG/Qjmc8lWWHxZZcw63PfXxJgWriZexkH7Qd
 yIOi+rbQ9S6qO+McO1fNBRo2cEusOd88rVjIpgdbHfmZgJM+7nMlWgk1myy8iJBq
 wqAQTthvWz1BXQ3+rIji6ysRT3ffw+Jw74hNlkWkIaKGoF21tBTXApqybaQ/lBwP
 Vwh4V2lip2VCSGnSyPHe81+L8hVug1P3Yq6itLUr3Z70Eny/5fdepGrXeyzo6Sqz
 MlWFnPvIAp++Ls3MArw8U/U18EmSaD1A9WWEKmbt/t+JBdeJVPszBfQIwDMf32/w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr6kam-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 13:53:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6299D5Af009057;
 Mon, 9 Mar 2026 13:53:34 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crxqy58k3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 13:53:34 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629DrXmZ28574404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 13:53:33 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23AC55805A;
 Mon,  9 Mar 2026 13:53:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C45458061;
 Mon,  9 Mar 2026 13:53:32 +0000 (GMT)
Received: from [9.61.138.24] (unknown [9.61.138.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 13:53:32 +0000 (GMT)
Message-ID: <4653ec61-8e8e-4d49-a622-a1018bf442b9@linux.ibm.com>
Date: Mon, 9 Mar 2026 09:53:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] pc-bios/s390-ccw: Introduce virtio-pci functions
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <20260309003601.242634-12-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260309003601.242634-12-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEyMyBTYWx0ZWRfX7dwpOIWaZ171
 h9o5+WjLFQgUw95i7aEKpDja/zQ0XVF0P1f5FDWXsRZwt84jAu7sS3NQrfmOTU/PaMuzwABukZV
 ++n3oN+iuVPesWbYxAHbF+VolQL8hQETjbVdadar/LDduyQqVIstpQucxZtDQ4JcChW5ZUykdiY
 4HFjka4S84a3GQlmZoog7sqNhGeHz+gISS9waHS0BgHCLt1i4NolUWdGuxQXaBNSk5mCHfhM0RU
 qSe4ahu5oCi+R7TkEcyA7+i2+VYPdhElT3C4nYXL26Qgf7fCz1zCCVOXjzVvFy94Qc3rYFGlYHc
 yQz8GzFfd8x6Y5VvwBx4xY0u64BGmWK33upKx59nXdPDRvPptm5plBJ/OjMWyWyt94u6jUBrF/J
 K543yrV9bsq4Y2VF2FlYWpl+TlrOpJ5FOWD1T0YKcv/hv1Be65TYE+LAP6JEkKseHc0FHH1YKWe
 iOaCMMwcBprdd+J6YEA==
X-Proofpoint-GUID: i95yO8cLUKley1Z34b8XpeMiArlSg_AJ
X-Proofpoint-ORIG-GUID: i95yO8cLUKley1Z34b8XpeMiArlSg_AJ
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69aed0df cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Ne3vNMM0jhlbvOzbJGsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090123
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 3/8/26 8:35 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define common functionality for interacting with virtio-pci devices.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
> diff --git a/pc-bios/s390-ccw/virtio-pci.c b/pc-bios/s390-ccw/virtio-pci.c
> new file mode 100644
> index 0000000000..f6ce7ec766
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.c
> @@ -0,0 +1,167 @@
> +/*
> + * Functionality for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.

Nit: 2026

> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +

> diff --git a/pc-bios/s390-ccw/virtio-pci.h b/pc-bios/s390-ccw/virtio-pci.h
> new file mode 100644
> index 0000000000..54c524f698
> --- /dev/null
> +++ b/pc-bios/s390-ccw/virtio-pci.h
> @@ -0,0 +1,80 @@
> +/*
> + * Definitions for virtio-pci
> + *
> + * Copyright 2025 IBM Corp.

Here too

> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +

