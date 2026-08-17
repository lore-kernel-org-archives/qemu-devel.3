Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CF5C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Tt-0000qD-3w; Mon, 17 Aug 2026 14:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ww2Tq-0000pT-0z; Mon, 17 Aug 2026 14:54:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ww2To-0005bs-Fa; Mon, 17 Aug 2026 14:54:41 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVQjL2173654; Mon, 17 Aug 2026 18:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xS003l
 IGV8fWe/0UB4TKQ1VHmKO0F3kwtusrASlyCNU=; b=nDXUC18cfWbWbUcaOA8U1k
 md1vpgIUBUEMlYE5jNu9+RmJGsGXKLu+FghdN0cdy6KAbxN1W0W8QH7R6o/ogYyK
 umYPiB1fU8lv3MYuP55pXsM35crQ/b884ASVGEIb136ibiirjJ8VKVb11WYSZezB
 KuEzj6ISGkWoEqDdv6azm6h6rpoD+XajWOG99mRXs94k9XNj3LgUCxmnC7zVARRR
 7IJHJKbH8OZQB6apJ0NYwa5/j5k06KxDcPvbIm6eNje9HQUStb3K+CwBh8fdl1Sr
 4lhoLllQKdTwLSDixgqVQYs4eSogN3NcbcoSxF8uWfFVq/KQmBeGTqXxc8YrlpdQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4kvjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:54:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfYio021992;
 Mon, 17 Aug 2026 18:54:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejya3u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:54:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIsXo733555052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:54:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 440D95805C;
 Mon, 17 Aug 2026 18:54:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E61FC5805A;
 Mon, 17 Aug 2026 18:54:31 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 17 Aug 2026 18:54:31 +0000 (GMT)
Message-ID: <95d17f14-98a7-43fa-bd23-537dccc2d220@linux.ibm.com>
Date: Mon, 17 Aug 2026 14:54:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] hw/s390x/ipl: Add secure boot support to PCI dev
 IPLB builder
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, zycai@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-2-jdaley@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260812152112.3330493-2-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 73z3oJ_nnu6-WNtHH7e-2IpyfFyzwbCZ
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8358eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=cNJl82erYdd-GZbzjZcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX5A9ivU6xvtPg
 PGRrup8SpctjvG4HvUmLgFMI7VVDkJ7zkSBIrzciEQ2yhhl8jtSllGnq7erONdC1IWTY7dTQSRB
 cxHgy+WSUPSce4BfZOVuKP3X0wlpXm0=
X-Proofpoint-ORIG-GUID: 73z3oJ_nnu6-WNtHH7e-2IpyfFyzwbCZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX4YPeUZ6MjXmG
 fsXEQ84D41Tnz77WLSpjaHQvdYUWOXac03AHyH914fnmQcYRCJN1w53EGmrFGUgb9BUdvxcpvm4
 MRkUNkcF01QjM43n5bmmnsI011I9CVhsc5KxPsSkIGZf940LMXJJFqeLjKc8ke9ne9OU2HNvfcD
 4jZZpwo1H1DFYAY4a+y4yA5TS2fNCILpV4vbGsxYydBUYvtU3YTFsNdCY3Z3VuYE7xqBRSwaSv8
 L/Mqa+0XOEMkykr+FxUO0rxnb3f999pRiFKbDcgJ0+mVzPXg7sZIX7I8JQFJuXeDtTsDXZDnvLr
 L2/8kW+X01b5jQbhXjnw4kD52rjJls6nflQSa37RX1vO4LIsPHXrVIC3m5SrWgpi3tC3p1MNR/h
 uxyjrTwZ6RTzt3XCoVic5+el5gAqYiIem3B0OvMU93ml2zdpsK+eKDr6WSOiWjMu/vXwxZCnvIr
 kxs1ONs1aiEvEYIKG9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
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



On 8/12/26 11:21 AM, Joshua Daley wrote:
> In the PCI boot device case of s390_build_iplb(), call
> s390_apply_secure_boot() to update the IPLB when secure boot or audit
> mode are enabled.
>
> Secure IPL is now supported for virtio-blk-pci boot devices.
>
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> ---
>   hw/s390x/ipl.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d59ed36c78..b0da3cbb27 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -599,11 +599,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>   
>       pbdev = s390_get_pci_device(dev_st, &devtype);
>       if (pbdev) {
> -        if (s390_secure_boot_enabled() || s390_has_certificate()) {
> -            error_report("Virtio pci boot device does not support secure boot!");
> -            exit(1);
> -        }
> -
>           pci_lp = object_property_get_str(OBJECT(pbdev->pdev), "loadparm", NULL);
>           if (pci_lp && strlen(pci_lp) > 0) {
>               lp = pci_lp;
> @@ -625,6 +620,9 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>           s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
>           iplb->flags |= DIAG308_FLAGS_LP_VALID;
>   
> +        s390_apply_secure_boot(iplb, devtype, s390_secure_boot_enabled(),
> +                               s390_has_certificate());
> +
>           return true;
>       }
>   

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

