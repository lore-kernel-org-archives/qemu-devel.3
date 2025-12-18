Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ED2D70DF2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 19:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWJs0-0008VP-8U; Thu, 18 Dec 2025 14:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vWJrx-0008Ug-2X; Thu, 18 Dec 2025 14:41:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vWJru-0008Pg-Os; Thu, 18 Dec 2025 14:41:00 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIG1B6u011837;
 Thu, 18 Dec 2025 19:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lWHtek
 a3NzhUeMZKwBEHPT0rbPqo81msew1EANH/1K0=; b=RK7xVMSWnu3OMAoti3DlJT
 WkWVqihTVeUoIsfrBWktDGGRvbaMREnux2RxjuFk1EgeS+SzVo1OdGQnmU4HsoLG
 hbdKOq0twJTjzg7bO40yTtyDogwQOzSLR175UptQC2ck/zsGVTs21LzpADqXgcAb
 SdvZ2song4TzqJlyKRxBEs/qHcAkRmxpJbp4tSCQmFyk7kFZckh5sFnc685dK2ul
 Oc5002qxkEbWYeNC2NclDiyaOBBRJor69WvbbPXanwY15nQyf5j6UyG7dbav3AL6
 g4pSbnYAT918pqondnRq7unRnSRBfdpcpdvDOV7yf+mi0YO7wM91HOjzd0AyTZaQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yt1ufvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:40:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIJY5eU031459;
 Thu, 18 Dec 2025 19:40:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b4qvu80u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Dec 2025 19:40:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BIJetCh29033114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Dec 2025 19:40:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADC8958059;
 Thu, 18 Dec 2025 19:40:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFEDD58061;
 Thu, 18 Dec 2025 19:40:54 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.79.187]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Dec 2025 19:40:54 +0000 (GMT)
Message-ID: <a14c3180990bcaf3aefb59f6f68e877fb0918693.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Add util/s390x_pci_mmio.c to the S390 PCI
 section
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>
Date: Thu, 18 Dec 2025 14:40:54 -0500
In-Reply-To: <20251218193642.170968-1-thuth@redhat.com>
References: <20251218193642.170968-1-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IRFeX8ObjTLa9qx_mooBEgFOq32q9y29
X-Proofpoint-ORIG-GUID: IRFeX8ObjTLa9qx_mooBEgFOq32q9y29
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfXzraC9JFx7BZQ
 kn9RzaaR0db4x3eG/EXVoKefpyLLlWdh08lfTvKtwiCozpnsCjHRRbKuf3mrq7HnrQtBX1cjBMh
 HMuhWiGeuPrTkt7AgxodcWwyAQGuL4fNykKei1e0T38+X1oA1iKn89bNDZq1hr+YIpPEjt2Q18/
 CfY3IkB/IBg9kpSCk7hi1NBc/UJpwRCVfStxDnJnIB8aC/BtIsfIqS62ot1RLMWN8Rdn1hr7+aC
 /d8iVNppUqC/IjaOJ47O6ftENQ0TRtPb9xY58PqP0ZW3vpJ6EpQjTARKaTQb7Euew5MUM7fVckK
 hxEP2LT0byg1OLpoWvCHXu1LYAXcyNUKS1N4KOkRuzcPWmNSqd1YAHEztQXB0ZZBeB5ehkseRl3
 +eWQI6CHX2ViPAH6tJtxMu1yZikrrA==
X-Authority-Analysis: v=2.4 cv=L/MQguT8 c=1 sm=1 tr=0 ts=694458c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=y1HG68m94I6UZcum19sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 2025-12-18 at 20:36 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> s390x_pci_mmio.c currently shows up as unmaintained. Add it to
> the S390 PCI section to make the right people aware of changes
> to this file.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7faa5672a4..226bf64f68e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1843,6 +1843,7 @@ M: Eric Farman <farman@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/s390-pci*
>  F: include/hw/s390x/s390-pci*
> +F: util/s390x_pci_mmio.c
>  L: qemu-s390x@nongnu.org
> =20
>  S390 channel subsystem

