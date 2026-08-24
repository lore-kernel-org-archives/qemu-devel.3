Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4208FC5DF9B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyV3c-0002f1-CX; Mon, 24 Aug 2026 09:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyV3b-0002ek-4Q; Mon, 24 Aug 2026 09:49:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyV3Z-0006Ug-GB; Mon, 24 Aug 2026 09:49:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1WJ01957968; Mon, 24 Aug 2026 13:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bXsj4x
 8N8njqacY/Kvj2m4UwSfHGqRUQ9HSv0y/FXrw=; b=aXf7kJVLS4dDGy2LChyexj
 Iu42hSofrbA/QDZ68v0vdBX4tR4svt5TqZl4qNeVgX8SOWZ9oeDd3nR0iffvq0qZ
 OnfC0ALXyl5rY6M9IJ9j0v9qgT9hlZqlITtk1VAXa4rlIZCudQYVwsQiLJKOvIwG
 FaLozAKXrU5cIQSShONamQY50ZFkrthRx4ULWgH3TmwnQSmwaZkbec8RckyetjXR
 LM3dApqypVa9XTL3a7zdVT7EZ4cwPLMj8GjSqDaqvrkA/aK194vPfc8rlFrdUjTZ
 WMCcQIQ5sVg6U0xkkTDY6agdpR20WF1b/g5P/yYXqGKSKCBAbCHc25JnJRnfiXVQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4hnk8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:49:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67ODfNAr032294;
 Mon, 24 Aug 2026 13:49:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkgx55g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 13:49:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67ODnbm561735320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 13:49:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 571DA5805A;
 Mon, 24 Aug 2026 13:49:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D03858056;
 Mon, 24 Aug 2026 13:49:36 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 13:49:36 +0000 (GMT)
Message-ID: <ac9d1d5f-c89e-4e54-8db9-3637b90ac7b9@linux.ibm.com>
Date: Mon, 24 Aug 2026 09:49:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/s390x/ipl: Add secure boot support to PCI dev
 IPLB builder
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-2-jdaley@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260812152112.3330493-2-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t7qFEgCyiYJDz-Gr4m_JR9N7lt6S5wV-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX/F2j0Qz/eDt3
 97QW/JdG6SKET9hXIOvff0Nn4xS1DB75btei+STJHrbaQFTiGF4RqeMNZvTTIp2PO9ZcVJKfTem
 HnErZzSaPuFY4SwHldKTHuh8CIP0WpM=
X-Proofpoint-GUID: t7qFEgCyiYJDz-Gr4m_JR9N7lt6S5wV-
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c4bf3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=N5xNZ2vn1O12e8wU_7UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExNCBTYWx0ZWRfX8VTCb1b3cn0T
 QzCuWDxeSYTjK4ya7d61Jhr4ymRBxL7PXaWJjdScKrgNG/U2Oey1ly2ePBK0hu3kTuY5USzcVZL
 qq/oNwnS8qWetENxkByCYrFEmg9AzbJW5piOjZn8TLGKyC35UfhuWYJAqbTmp232oiJDvGbBOTa
 zRXs7p3y+arYoPd6/DhC5ykzU1HH7OFGpxSjs6ipmYOoPmm9/iuGlzBmPH6SF/IU8CHY7AHxdhV
 lVzTTPANe6LvHKQ77kIValEEJNNq8znJsRKYCzlN08wTJeSX6awehGCbUDci3i/POthXigXKmts
 kPaPabffkIlSz9xAKqy51VfH3eoLDNvjU8Y0qjdmPcDIrGGrEZNRoFyX/fEMTnZkQVU6r4xLaU6
 pawYBqb40oPgQKaWdYeLYsWzi7D7jyynEwwoh9uNp/M6FWTmyOLj4Oz9ey3Z/TWXtClfY0MUEkc
 0ehRGzs/Q+ElkIWcNaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240114
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 8/12/26 11:21 AM, Joshua Daley wrote:
> In the PCI boot device case of s390_build_iplb(), call
> s390_apply_secure_boot() to update the IPLB when secure boot or audit
> mode are enabled.
> 
> Secure IPL is now supported for virtio-blk-pci boot devices.
> 
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



