Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247A8D73E87
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 22:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vla4Q-0000ya-78; Thu, 29 Jan 2026 17:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vla4I-0000wH-Pa; Thu, 29 Jan 2026 17:00:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vla4F-0005iZ-4E; Thu, 29 Jan 2026 17:00:49 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEbhs4011188;
 Thu, 29 Jan 2026 22:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QnFFyH
 U+czdPK6rMjgd5U00RdQ2n2w7U12U3nQWxuiQ=; b=T2LIppKbdL+qjycrPj+xjP
 PPbbaBjScNedJgNNSwoXT3lkDZUqH2HVb8aXpTmR/IV/tgZNor/iUWuO/cDt3V3B
 qIsRFtLu/6Yg+VvNuM7dWYBmE77FlKNsFWmcF0hB276ZWXoIxAJoo1h8yIPaHg0k
 +oFFuqVWskC7ILgcnsQ2Zea43RCpXL3WuZO4ebI1Y091+lMVEYg9XeUASr5AYK+a
 QmxaybykRWPq1Z9Mwo2M03ady1ORXviRfS8iTJUDhJf3rzK+XLafHzJbbDDKvcxo
 7OMtVsrv4iLkIpgdx4+uz4PvlUo+eRt58AQfwgVJ1FvayIym9u2ptCxITDnTn1Gw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgg8es6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 22:00:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60TJUP39019844;
 Thu, 29 Jan 2026 22:00:45 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9dnbu9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Jan 2026 22:00:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60TM0hUx26739274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jan 2026 22:00:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DB1958069;
 Thu, 29 Jan 2026 22:00:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 71A6258065;
 Thu, 29 Jan 2026 22:00:42 +0000 (GMT)
Received: from [9.61.243.220] (unknown [9.61.243.220])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Jan 2026 22:00:42 +0000 (GMT)
Message-ID: <4194b7ee-c773-402b-be3f-e9ec15ec3bd4@linux.ibm.com>
Date: Thu, 29 Jan 2026 14:00:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/14] pc-bios/s390-ccw: Remove redundant vring schid
 attribute
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-3-jrossi@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260127161547.459443-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=697bd88d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=qH6Dlb6NeDLKRq4xZLcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: j1SFUvLqJmrt4VcgFNZqXMs_RH6Gwhai
X-Proofpoint-ORIG-GUID: j1SFUvLqJmrt4VcgFNZqXMs_RH6Gwhai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDE1OSBTYWx0ZWRfX4s9VWHzCiB8n
 +AFSW+2lpCDVcriUJEukdaW/5T+4N2K4zhkgtQKz43MaiTpESDP2WZ2oCDGHX0+2Hl30GAHm325
 Cii8+y8wzQonCmCE31nlZv1I0yQbBIj4iKHYZLd4xe3G9CxM0HyAvLkvrt4g8/bT2RZut7O7PsV
 BlxQACU4SwYB2jzYhQ1mg09t/yaFORUhyqBbigrAjdIvchrXIa1m2RKFJYhe8KAHc0ldWJnEzb/
 7uzJBTggNJF2ulmT8Xso6eJIOizPk54I2Yklx1jOtTKlPWhNFwXnt0iIw+1ve/g///Mj1bYmpuQ
 WW+awPM69PJcglUG8AFqxYTUjubx2StjTihaW+KJt5bzWl8US9VCEak6QqqEOInqo4Ny/GI2PtV
 NmpStPTijmaqYyuDubeGEez5TywMzYx7k0vVTU8Z79djCHiBe1V44cNiyrBi8EOwxW/pINBGnTH
 Cx2jDXNaAO51HeNDKww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601290159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 1/27/2026 8:15 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi<jrossi@linux.ibm.com>
>
> The schid is already stored as an attribute of the VDev itself and any other
> instances are copies of this same value.  To avoid CCW specific attributes in
> the VRing let's just access the existing VDev schid attribute as needed.
>
> Signed-off-by: Jared Rossi<jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/virtio-blkdev.c | 2 +-
>   pc-bios/s390-ccw/virtio-net.c    | 2 +-
>   pc-bios/s390-ccw/virtio.c        | 9 ++++-----
>   pc-bios/s390-ccw/virtio.h        | 3 +--
>   4 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



