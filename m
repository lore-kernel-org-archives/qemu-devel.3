Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81FCD2E9F1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 13:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAUaB-0004ka-GU; Mon, 11 Nov 2024 08:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tAUa7-0004kK-OG; Mon, 11 Nov 2024 08:35:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1tAUa6-0002Hp-8v; Mon, 11 Nov 2024 08:35:51 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABCe2Uu016678;
 Mon, 11 Nov 2024 13:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yf07ZX
 maan3YRXWHSRL+tT9S5Rdmyp/AoCng7T+AKMQ=; b=BcnYnDrExw34zRfYsQ095V
 2oRHhQwMsO+XxenhIG5h4tH9HAXYep8moTNq8J6p65VtE7FalkYpm7rVzL9+obzQ
 9IMaV2c+TKEQhTDbNjOGLAK79HrUXNyxP3JT6EzNAIrsYT7VPNAmDn+IpvV8dEeO
 GEUvzkjPyf5VD6Aek5OdT4e0WET1snL38agZnQSMOnBxbu6piwg/OV5XvVnG3lcR
 p9+i3oqMX9cUNOdxjyOoJMBEH7fZm0S2hNQKJzYp7Mr2jdskgImqR9lFTbRNsTs7
 KzNV0BiJdZ2ZgrUFSG4x5kl7t7SoZdIp6s9J48pqqSh86WVAky52rgOHcnxZ10Wg
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42uj4h05dy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 13:35:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9lLuH017144;
 Mon, 11 Nov 2024 13:34:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9ja7cc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Nov 2024 13:34:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ABDYHIp50594218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Nov 2024 13:34:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 73A9458065;
 Mon, 11 Nov 2024 13:34:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22D4D5805D;
 Mon, 11 Nov 2024 13:34:17 +0000 (GMT)
Received: from [9.61.110.7] (unknown [9.61.110.7])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 Nov 2024 13:34:17 +0000 (GMT)
Message-ID: <4b449524-8a20-4d92-bff8-0b7e81a12d5c@linux.ibm.com>
Date: Mon, 11 Nov 2024 08:34:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pc-bios/s390-ccw: Re-initialize receive queue index
 before each boot attempt
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20241111131120.317796-1-thuth@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20241111131120.317796-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CZ_t6I_NOnHVbTIKzlwp_lzi62FHGwHe
X-Proofpoint-ORIG-GUID: CZ_t6I_NOnHVbTIKzlwp_lzi62FHGwHe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 mlxlogscore=979 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 11/11/24 8:11 AM, Thomas Huth wrote:
> Now that we can boot from multiple boot devices, we have to make sure
> to reinitialize static variables like rx_last_idx to avoid that they
> contain garbage data during the second boot attempt (which can lead to
> crashes when the code tries to access the wrong ring data).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   pc-bios/s390-ccw/virtio-net.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
> index f9854a22c3..578c89d0c5 100644
> --- a/pc-bios/s390-ccw/virtio-net.c
> +++ b/pc-bios/s390-ccw/virtio-net.c
> @@ -51,6 +51,8 @@ int virtio_net_init(void *mac_addr)
>       void *buf;
>       int i;
>   
> +    rx_last_idx = 0;
> +
>       vdev->guest_features[0] = VIRTIO_NET_F_MAC_BIT;
>       virtio_setup_ccw(vdev);
>   

Thanks Thomas!

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

