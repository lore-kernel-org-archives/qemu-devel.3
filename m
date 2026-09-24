Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F1FC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jgl-0006rD-Ij; Thu, 24 Sep 2026 09:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9jgj-0006qq-NO; Thu, 24 Sep 2026 09:40:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9jgh-0006UG-EH; Thu, 24 Sep 2026 09:40:37 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6XBd2183891; Thu, 24 Sep 2026 13:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+ked7D
 y/hV5jIGdJTYODvtSe7WqS7LTaBdg7sqheiYM=; b=QD0O3EZfaGVNfXNkYdKA25
 8prLEsjOURNsg9mufyPKdIH6GwvC7EGJlLOTywzX6Y0KfdVCxfBunSashMzyWeQ3
 Wjaq943304qwvGpY/rU7QxKtHmcfI+26rZ+oFyKbVP6577Qcxvq9cQ+39umpxvWX
 LKyr6eRB855itDJ9cdmVXdk+PTgyDWnbXY678xaKlWbvoa4WWfFUK1yhjZkrCljM
 LxTYgkpXd61p1rrziMSpwYePlTyFmDrTQtA9wcQb/x5BG3OSCPIQ/bvtHzbDAR9e
 LzrYRUPxKGU6HHgLbPIhzDtQL6Hpvw1I5FVRiKuvXu3o+JfcmZrkYGQPvKsjCD0A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgshcaf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:40:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHcxU2046912; Thu, 24 Sep 2026 13:40:26 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1x2gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:40:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODeO2h17236556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:40:24 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 888B058052;
 Thu, 24 Sep 2026 13:40:24 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D19C258056;
 Thu, 24 Sep 2026 13:40:23 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:40:23 +0000 (GMT)
Message-ID: <7e2ce224-3cef-4d15-872b-e06a67dcc923@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:40:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390x: Expose pv attribute in QOM
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, brueckner@linux.ibm.com, borntraeger@de.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, david@kernel.org,
 iii@linux.ibm.com, richard.henderson@linaro.org
References: <20260924110909.146831-1-frankja@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260924110909.146831-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab5284b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=PnuIWlBC_-zf_FTQ8uQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P94bNnuIaWVnzKnKHXzx19cShJyvQmmz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfXzKu4+5hMA3Rt
 xSwiCL8gV/d6uCa2DTd6McEiSLuMn8wZZ9Qd7sLWdP8/KD6PIVS8fWCWkocUf3vKhYOk8q9bLw4
 yHEQLyoq54O6w6wwnLzIzcV/00fmfcJq8s4Rq16g8D0uMr8nLluKnn6KnbH2JeOrbVTTqEmrqMk
 OzHoqMCwe6ZMI5yuaObGS4WayCmateslz/hDYsWwn3Z4WrV6xIwIflvbjRAbuwB+70gxlUQMxmp
 ilR//bmBVTygxohtMU5g8p6HtgKeXgIkaI9T4DxXO/DXXUjFxTBS23RkzKa+aYI/1xM0zNv1W4J
 jnTbopoR1htISTCz7/vcIGRxilhA4HDd8YMNLbh3TmAbsOYVrDh9hCqx1RfcJj290UJw4bQKyUc
 qN2Kmoq4NNgqvIycUnOJl76KABqdtpXP/U12YFoiYfXjme5FqT6ee+0un4Hkr+Aa72wjM6ITFze
 4Ht0topqfn6vY46sp4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX1UYr/n/eQM/3
 FQvd+SDJ7AupW1rxUPEh/BSBj362Z5CZNsvUM0lhq51lR9DqfvFw0dGRe4jYy53Rt4PgpEar1Ks
 rYBGdH9P0XsF+KP1AIpWPF+SrxbtxrM=
X-Proofpoint-GUID: P94bNnuIaWVnzKnKHXzx19cShJyvQmmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240056
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

On 9/24/26 7:09 AM, Janosch Frank wrote:
> People doing VM management requested a way to query if a VM is in PV
> or not. So this patch exposes the runtime PV atrribute which is true

typo: attribute

> once the VM sucessfully made the switch into PV mode (according to

typo: successfully

> KVM) and did not yet reboot to drop out of it.
> 
> This of course does never replace attestation, it's merely QEMU's view
> of the situation.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> CC: Hendrik Brueckner <brueckner@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> ---
>  docs/system/s390x/protvirt.rst | 11 +++++++++++
>  hw/s390x/s390-virtio-ccw.c     | 13 +++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/docs/system/s390x/protvirt.rst b/docs/system/s390x/protvirt.rst
> index aee63ed7ec..f4d25b5ae3 100644
> --- a/docs/system/s390x/protvirt.rst
> +++ b/docs/system/s390x/protvirt.rst
> @@ -65,3 +65,14 @@ metadata. In case this boot method is used, the command line
>  options -initrd and -cmdline are ineffective. The preparation of a PVM
>  image is done via the ``genprotimg`` tool from the s390-tools
>  collection.
> +
> +
> +PV property
> +-----------
> +
> +The s390x-ccw machine exposes the read-only runtime "pv"
> +property. This property is true if a guest sucessfully made the

typo: successfully

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



