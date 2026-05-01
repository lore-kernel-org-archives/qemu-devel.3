Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A70CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 14:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIp0S-0003w1-EO; Fri, 01 May 2026 10:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wIp0P-0003vX-C1; Fri, 01 May 2026 10:38:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wIp0M-0005uB-T5; Fri, 01 May 2026 10:38:13 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ULXYj72006058; Fri, 1 May 2026 14:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d9IvaX
 u2puBw4FYWewBZnV8UQnu7SX6W+gRbQynIjuk=; b=PWDixbEJ5qdlSwm/ZrvoGL
 c0F2BeTp2VJpWrS4OkYw3M7AjyvPE0KO1wnmw2BlwcfjfJS6tlWA0nYWcFsqls69
 Z+Gkw9ixQYJGt/tngQinS/MB8rBRPmtSFnDhw49Vbywv/b4ehudkpR0V452IPVCt
 /Mlh101/DnlQis4OD4iyM8cLSgq4s3jhLNwMKrFJyeTd1HFPQxQ/ozmQLZ0IdIWI
 cwJKYhLvidcAIIAykD/7B2/9LEaM/7SmkaMyREEjRX2TlEGSsfB/Pr0RqKzdu2Pg
 A6jB5M/rnrJZhYhOLb/pvt+iIySYiM3VMnV7Cz6G//+kaAwmibbFiK4qXeyhsf0Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vu0sj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 14:38:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641EOAS3015880;
 Fri, 1 May 2026 14:38:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqqxdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 14:38:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641EbxPq34013650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 14:38:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE3C958050;
 Fri,  1 May 2026 14:37:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1939258045;
 Fri,  1 May 2026 14:37:54 +0000 (GMT)
Received: from [9.124.223.14] (unknown [9.124.223.14])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 14:37:53 +0000 (GMT)
Message-ID: <bdc3eaee-d117-476d-8d7c-2ffeb23730c3@linux.ibm.com>
Date: Fri, 1 May 2026 20:07:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] pnv/phb4: Add reset logic to PHB4
Content-Language: en-GB
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f4bac9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=rYLnrmdl_moKlWV4vG0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: F7deu80aasj4lupivsVK6RLhngvlDmYv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEzOSBTYWx0ZWRfX0YuaE0jZHgKP
 pfs9oGaPQLIo7qQaY7B3pjwihMBRuqFl1C6VvvsLN4i1K1ZJkWnfVGQAL3PuKpU6+oiXB/Tb71m
 ISRW/xxdKydPZFXTbxh90I788WI5KhJ5MZyaZe41UwhudMeIW3ZCaWCdaUCLaQyU7wbKOYLolZW
 GjbZRdqrN64K5wqQEJKOg7gL8QsISE0e5dl+YHU+eDvqYSIV1zEujodKS5ZAvdYY5XWsCGLfrPy
 2EyG2L3b7wqPHT5WrcNqrPvsk74I86uHd2u+DpFW/FtK4WGFh0M4lDqf3xXzn5Ds6hl34RK85xG
 7+2erhKr5UcSniJOU6zCqqS9k/DmTAG6DPik7fk3PqJtdex4/iWsr8def8eKujCQjJ7NSAHfT6T
 CTnMqceGKjfGyKXpyg4hovlR7APQwOHitDCGjg0EyjPrKme9GAdjnpV8NUTkfmFCz9YdjuORYnU
 3NlvU2lg8qNJyEw6EZQ==
X-Proofpoint-GUID: ZnVD7mXc2GFWu_TFdJBLMZj6Ns_quhuB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010139
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 05/03/26 11:39 am, Saif Abrar wrote:
> Add a method to be invoked on QEMU reset.
> Also add CFG and PBL core-blocks reset logic using
> appropriate bits of PHB_PCIE_CRESET register.
> 
> Tested by reading the reset value of a register.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v3: Updates for coding guidelines.
> v2:
> - Using the ResettableClass.
> - Reset of the root complex registers done in pnv_phb_root_port_reset_hold().
> 
>   hw/pci-host/pnv_phb.c               |   1 +
>   hw/pci-host/pnv_phb4.c              | 103 +++++++++++++++++++++++++++-
>   include/hw/pci-host/pnv_phb4.h      |   1 +
>   include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
>   tests/qtest/pnv-phb4-test.c         |  28 +++++++-
>   5 files changed, 145 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
> index 0b556d1bf5..d4f452d7b2 100644
> --- a/hw/pci-host/pnv_phb.c
> +++ b/hw/pci-host/pnv_phb.c
> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
>       pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>       pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>       pci_config_set_interrupt_pin(conf, 0);
> +    pnv_phb4_cfg_core_reset(d);

Cover letter says updating to PHB5 spec, but here we are calling phb4 
specific reset in common phb code?

If the reset logic applies to all versions of PHBs, we should better 
call it just pnv_phb_cfg_core_reset(). Otherwise, need to better 
refactor code such that pnv_phb.{h,c} contains only common code which 
applies to all versions of phb, keep phb4 specific code in pnv_phb4.c, 
export reusable routines from common code which can be called from 
phb{4,5} specific code in pnv_phb{4,5}.c files respectively.

I understand we already have phb5 specific code in pnv_phb4.c, but we 
need to reorg it at some point of time, and it will be great if we can 
do it sometime soon, preferably along with this series. However, I am 
fine if you wish to take it as a follow-up work. Having said that we 
need to get the naming corrected as applicable (i.e. just phb vs 
phb{3,4,5}), so that later we would only need to take care of moving 
phb5 specific code to pnv_phb5.c.


>   }
>   
>   static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)

<snipped>

> +
> +static void phb4_tests(void)
> +{

I guess you meant phb5_tests here since using machine powernv10 inside ?

> +    QTestState *qts = NULL;
> +
> +    qts = qtest_initf("-machine powernv10 -accel tcg");
> +
> +    /* Check reset value of a register */
> +    phb4_reset_test(qts);
> +
> +    qtest_quit(qts);
> +}
> +
>   /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>   static void phb_version_test(const void *data)
>   {
> @@ -72,8 +95,6 @@ static void phb_version_test(const void *data)
>       /* PHB Version register bits [24:31] */
>       ver = ver >> (63 - 31);
>       g_assert_cmpuint(ver, ==, expected_ver);
> -
> -    qtest_quit(qts);

This should be cleaned up in the prev patch where it was introduced.

Also, whenever sending next version of patches, please avoid sending as 
reply to previous series. You can keep updating changelog in cover 
letter with links to previous version when sending the next version.

Thanks for looking into it, significant work!

regards,
Harsh

>   }
>   
>   /* Verify versions of all supported PHB's */
> @@ -94,5 +115,8 @@ int main(int argc, char **argv)
>       /* PHB[345] tests */
>       add_phbX_version_test();
>   
> +    /* PHB4 specific tests */
> +    qtest_add_func("phb4", phb4_tests);
> +
>       return g_test_run();
>   }


