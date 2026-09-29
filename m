Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FFFCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbnC-0006Cn-00; Tue, 29 Sep 2026 13:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBbn0-0006BL-U2; Tue, 29 Sep 2026 13:38:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xBbmx-0004Ak-DB; Tue, 29 Sep 2026 13:38:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5a5K3836671; Tue, 29 Sep 2026 17:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JDJjNr
 2LgS2TaACM5U8cKZCshOabWBHtclM+NEO0PQ8=; b=VUqKH+Ep1meaJXaWSb3kj7
 RfyMP4K7rG5e9UlxiwGt4AnaZkROsnmYrFdD5yfARkX8kf2qJpX2Tt64mJ2Li+lR
 kLIQBDHHzncak3cuK4SQAbabfLn8J/tYjLE3fPawTEbCIWhUtnyeCu7zGPkAKaGr
 bMIzgOUS4idFMUbMfeMzy9GBKXWym8fhS+D1LVLl5wzok4fgbo4wfAcVpjPURKYM
 1wd+0w3EN2su86RA/Xb3SqIE5nORxN5WtQ6CqJAvxeRv5ggoSDD7JFj3rts8qlSo
 sdqKwpTHA4KRgZk1G/FxCLeMEgrCBksuCKrjxQ/C/aLo8gC371zEfN03NuEywYug
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk8116-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 17:38:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TH8jqG2116437; Tue, 29 Sep 2026 17:38:33 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfp8390-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 17:38:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68THcW6j24642058
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 17:38:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 520A958056;
 Tue, 29 Sep 2026 17:38:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 971C658052;
 Tue, 29 Sep 2026 17:38:31 +0000 (GMT)
Received: from [9.61.250.47] (unknown [9.61.250.47])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 17:38:31 +0000 (GMT)
Message-ID: <14e21583-8399-4ad9-b5dc-f9f0efa2adc0@linux.ibm.com>
Date: Tue, 29 Sep 2026 10:38:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] s390x/pci: Use qemu_log_mask() for guest-triggered
 errors in reg_ioat()
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20260929153012.774530-1-mjrosato@linux.ibm.com>
 <20260929153012.774530-3-mjrosato@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260929153012.774530-3-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o_q8THnfXo4DvjI_9hz8Fc_TjksZBWeL
X-Proofpoint-GUID: o_q8THnfXo4DvjI_9hz8Fc_TjksZBWeL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfXz9Bb9erHoiFx
 fd3Ck8w/a6p4OStoV8FD0CJ0xufu1GsveDUZaVeAenYi0FjIBsyW3VEg6Ef9R0W3TUTzFJlPdd6
 J4LWSURag/qrVw2PbamWFXqFp7gziZI=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abbf799 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=k3bWgf8ghfIjuqb0U84A:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3MCBTYWx0ZWRfX1HBes6o+PIOe
 Q/TzMw3C2LxhEUkGPeYoefYmOKi56X5BNAYHWQlutX02Xz0DlJLvmZNB3N1HEw30jQVyqRvukY/
 BpbZuy0npnm0dDSi6JhSLGvxE9X8ePGs2aKi8gZ294V9tRVhCiLgVHkYg6ow9lolIucnfNh8Tiv
 XEgEudlO9PDKYBlkszu9dLKpPN8dIZ2C5Myz9hQrPTHFP899YPXBAWydyapjpHGsIG1vyHQrBGI
 KcTngnYUtq8eJCTIyLsdaYs/Xr2hctQ4IZLbqaV/TsXjNycYMDlKXHbiipB8cJRuG4SC218rKm1
 BdbS36jmb21BgSeD51M//qs15Ka84fGcg65MztaX6LD4WIFZx2yYmFd5R3OVBGY62fehB1teFNX
 MAOYrIYr4UQ4buGV12KN/bEudbEuV8ZP14A7M8D1mEmeuUdH4osezyzQm8tEAdJCTde5fbbsQhN
 yYh2tBI0UDWbJi0JXfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290070
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


On 9/29/2026 8:30 AM, Matthew Rosato wrote:
> The error paths in reg_ioat() that are triggered by a guest providing
> invalid MPCIFC arguments use error_report(), which writes unconditionally
> to stderr.  A misbehaving guest can exploit this to flood the host log
> by repeatedly issuing the instruction with bad arguments.
>
> Replace these with qemu_log_mask(LOG_GUEST_ERROR, ...) so that the
> messages are suppressible.
>
> Fixes: 863f6f52b713 ("s390: implement pci instructions")
> Fixes: dfcee1ea4c52 ("s390x/pci: add support for guests that request direct mapping")
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-inst.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>



