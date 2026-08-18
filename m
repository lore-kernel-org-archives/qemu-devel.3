Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2E1C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwL3d-0007Eh-2b; Tue, 18 Aug 2026 10:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wwL3b-0007EH-1A; Tue, 18 Aug 2026 10:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wwL3Y-0006sk-4o; Tue, 18 Aug 2026 10:44:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3ZIS505190; Tue, 18 Aug 2026 14:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NE1S/T
 vOlEJOYGM5tMBuRxTw45HlF9qj6q2qrt2T5G0=; b=oXAZ5MfqoTU/+VK7RdJIrX
 bQHMj/3eU4CVFW0uMG4NvQgrMsz/x/P66CWtna5iMDKCbvV8iXNg35UQMQS2MppW
 BqOTuZJ/Jx1J2rneoz9gORHhf9ymF29yU8PKPW9m9k/Zrj74hAWxvn9/u4mNUVsD
 yeXsUK27qf+SOsNX21xPCnbfA7i6M04UKE15GefuPCipv+eocvFe9yalpVvXKuQX
 4eAMh2s3a7yZND7qikAHfewqs0LeSy9pIwyUSYXM69HdEThssLL8nIrkqsslqCxH
 yyhlhCpYAtL60PqgXYZWFhDtnovk+tciE3HGzOewCIVfkawjpgy2TfiS3dgb9XYQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4rw3b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 14:44:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfK8I029618;
 Tue, 18 Aug 2026 14:44:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ngbgus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 14:44:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IEifNm30933698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 14:44:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBFB65805A;
 Tue, 18 Aug 2026 14:44:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF29A58051;
 Tue, 18 Aug 2026 14:44:39 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 14:44:39 +0000 (GMT)
Message-ID: <fd9f6195-b597-49c0-846e-b3b20e92a243@linux.ibm.com>
Date: Tue, 18 Aug 2026 10:44:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 34/34] MAINTAINERS: Add secure IPL files to S390-ccw
 boot group
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260730214624.2328883-1-zycai@linux.ibm.com>
 <20260730214624.2328883-35-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260730214624.2328883-35-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lmsi1BWt10Y4Wbf5UUVJW1u6ia9Sub8l
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a846fdb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=a0ZOiI3JHlCJRT-QAOkA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX4lozVHX6dv9I
 e8cx7CtXbWZ5XRgigjnxwCmVr7johjp5b8nAQ6cfWl+udhJ+zTDU48RfdWUKL3Rgc5oqpLe38L4
 O0Lv/J7Ys7Gr6o7YJSnz0c0+kO2PUM0=
X-Proofpoint-ORIG-GUID: lmsi1BWt10Y4Wbf5UUVJW1u6ia9Sub8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX6gn1PAZcAPhr
 jlF90LxSUsXga3BuPPy68jnfiXrmAdJUUDaea1JY5GePi2TlxG1+x9nkb6jS695neIoI+kHha5F
 ykK04kbQ0gUUUIEHZ+a8MLllYhZdHcV3LcFDkcYIRl190D792HoyRGhBNVU+/pIqguUSYigLvvf
 z0e2AQCnZmQnKq1CaQMSvlKn+cU98qe0fY5C33d4CcPntCnkwBCdz9G+QMvCqG3H2PRxIi01ig7
 wvnlsVB2DAMx2c52kVK04YvLNMWygXBQqqSL1Zc4Zs7p6ezzv1mrx1I6MU6X3ICq8UghKb6NTYx
 5Kwm4+gMem8Lm5JO11DONsfwYQcVAWk//ILlvCfxIw4xmxtLPoI3uLaKvLbHbS2sMLkCrgg/8zv
 QZBaVTCJwY6PaoNTLagoIvG3FG+E3clwYWI5hfakHiJYXXtjLc9bJp+c31setTcYt5tP+KzaKxY
 nlCiT4FFWZv8ZmV9Jkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107
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

On 7/30/26 5:46 PM, Zhuoying Cai wrote:
> Add entries for the files introduced by the secure IPL series (cert-store,
> diag headers, documentation, and functional test) to the S390-ccw boot
> maintainer group.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 902db77218..0742076861 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1926,10 +1926,15 @@ R: Christian Borntraeger <borntraeger@linux.ibm.com>
>  R: Jason Herne <jjherne@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ipl.*
> +F: hw/s390x/cert-store.[ch]
> +F: include/hw/s390x/ipl/
>  F: pc-bios/s390-ccw/
>  F: pc-bios/s390-ccw.img
>  F: docs/devel/s390-dasd-ipl.rst
> +F: docs/specs/s390x-secure-ipl.rst
> +F: docs/system/s390x/secure-ipl.rst
>  F: tests/functional/s390x/test_pxelinux.py
> +F: tests/functional/s390x/test_secure_ipl.py
>  L: qemu-s390x@nongnu.org
>  
>  S390 PCI


