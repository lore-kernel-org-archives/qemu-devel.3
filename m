Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3930C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9qnG-0005De-OU; Thu, 24 Sep 2026 17:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9qn7-0005Bq-6O; Thu, 24 Sep 2026 17:15:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1x9qn5-0007V6-75; Thu, 24 Sep 2026 17:15:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ62VX2915314; Thu, 24 Sep 2026 21:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dQd8m4
 30AlCBAYkxT7dTqRKCn7J5e5ZvX4wCCXJuT3E=; b=iorVsLEHFaXLDfemXbiH32
 0HrGOmfOStsGIjoJxHzWIopnm3wcnDFRrFwZS1OgQwHyS9B5FS1cSrvdM85OKWRQ
 c+noh1booP6sdThvNxXDwvHcQ/sE7UNnjmIQrVXHONUq1fd/dzQamUhMPz3beYIE
 R7zPhkKNmDHef0e5+KJIAL+q3K/Da3KkngptxhcYe/F/b7pAre0eqYdSLk/Aw9zw
 GUb+ndT+E5+yQmLS6cEcpri2BAS22ZrFqpdVzwB3vixJ9P+c67jZw9GmqSejtFFg
 5VPWOQWpPszbFHzpLT8TtitwNREQ10wLfeBEs716PgmBwrijPCWwwjMUDGXVmcEQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1ty3b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 21:15:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlV2a2569883; Thu, 24 Sep 2026 21:15:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qqte3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 21:15:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OLFYcB55771608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 21:15:34 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 394205804E;
 Thu, 24 Sep 2026 21:15:34 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 960FC5803F;
 Thu, 24 Sep 2026 21:15:31 +0000 (GMT)
Received: from [9.61.7.131] (unknown [9.61.7.131])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 21:15:31 +0000 (GMT)
Message-ID: <032734ca-0c40-4e85-97ec-bfb1240199d8@linux.ibm.com>
Date: Thu, 24 Sep 2026 17:15:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260924194837.80732-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yNglXJceOezsAyolZWtnuTMnY2Sn_kD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfXxqgRrnGj9nvB
 ikLzaGY/b2M+PWnbjYJn3FDlMHxiidg1FY1YUqQJ/zVb760kOk/YBIwD6lIiL7HR6izt7eYHZ7G
 +dtjjo7tGDvKmJMDkJCoZM4jXqIUvYWIC3mX66f4iMWeyJ3T8nInBnPrCjCpujUVRCL+Hbt5Crn
 5DKphWkOLgjHj1biUcAvbOcTSxSlyyggdS/3wXqK9FKHKr7yPEa2M1RM3xbFyYNfkrvo0P4EEzn
 voJpLbyxC+2zVLKya9al3ejvrKyIQ5TCvPx7NW2Iayo/RRfVXuzBqrLuoEcTnGXOjA8YWNyHgd0
 IfeIWKSxuiMkoTXsxiFKLjUqeFoRBqBLRjcIzmOenhZHrc65YVyIpmiKFcdLjMrQePPnSiQU0kK
 zcojAkP6EEuD+uL6i85N8n8lWxh31ZVijp53wMQ8kEfdpJJW7Z174/eK0E37aBPeJVvZ3DWJ5of
 t4w8xY7QFZnzA4gTFkQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab592f8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=hNTO0ZySSFXKkZstvnIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX8asJar2jqGr/
 H1fM22msnDHZcAYYewOIsA3zj7AR+RrfPQMpRqMk667HzfyBtVeAMRX4KSbDDSL2jMIQJ30se4T
 79uzZ4HF2LDZJzytupUkLdjTPZAEgeU=
X-Proofpoint-GUID: yNglXJceOezsAyolZWtnuTMnY2Sn_kD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240086
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 9/24/26 3:48 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> including it in the PXE test suite. The test verifies that PXE
> network booting works correctly with virtio-net-pci devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> Tested-by: Joshua Daley <jdaley@linux.ibm.com>

It's still kind of confusing, but this is a little better.

Not sure if we will need to come up with a better way of identifying the
existence of a feature for s390x bios in the future, but for now:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  tests/qtest/pxe-test.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index 61ad572bb7..b12de2bedc 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -126,9 +126,20 @@ static bool s390_bios_has_net_ccw(void)
>      return s390_bios_has_string("Network boot starting...");
>  }
>  
> +static bool s390_bios_has_net_pci(void)
> +{
> +    /*
> +     * Check for a string unique to virtio-net-pci boot support in the bios
> +     * to determine if the binary was built with support for this device.
> +     */
> +    return s390_bios_has_string("Setup failed for virtio-net-pci");
> +}
> +
>  static testdef_t s390x_tests[] = {
>      { "s390-ccw-virtio", "virtio-net-ccw",
>        .boot_dev_support = s390_bios_has_net_ccw },
> +    { "s390-ccw-virtio", "virtio-net-pci",
> +      .boot_dev_support = s390_bios_has_net_pci },
>      { NULL },
>  };
>  


