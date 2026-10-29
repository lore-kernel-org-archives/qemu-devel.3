Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94227606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tnnf2DNg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUMF-0008GT-4I; Thu, 29 Oct 2026 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xMULy-0007tB-Jo; Thu, 29 Oct 2026 13:55:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xMULw-0005CG-Lo; Thu, 29 Oct 2026 13:55:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGE6li482833; Thu, 29 Oct 2026 17:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IlrBHB
 T/zZQHrnkRQF2SzOl4Ni3MY34iRmH1jz0aOw0=; b=tnnf2DNglgmnTFNm18T+FJ
 TsnQeeZKEZ1+D3GFG6fMLoVEi957oAel11CNjyR44IgFIcKxXUniqhKP6ARxRH2Y
 rR0YRTOCAXLhBA2updEVPXMMxpAL8fP5Z9enpuwBUK1VfYa5+tkYc4zrWLayAvtg
 55SkVrbEF+zmS2i+P9Vp96XsUQfsVef7+Uhj6y6RhkikrYJ0tJ+v1VdvneRn7tiJ
 PtAZiJqXKgO/nbex69k+Ivp3+ky4amaIG36BnyNq3KLlVF2LZc0Blf2Kmu8lTl/x
 OmgBQsqoobYLvb1Lf7gN8tov+vB1zveRlBuoYXott4JtqCXRomcSF9pJdJRgtTcg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmavubt2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:55:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGJoV63392692; Thu, 29 Oct 2026 17:55:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e1cqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:55:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THtf6V42992116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:55:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7F0F58050;
 Thu, 29 Oct 2026 17:55:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8DB458054;
 Thu, 29 Oct 2026 17:55:40 +0000 (GMT)
Received: from [9.61.36.128] (unknown [9.61.36.128])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:55:40 +0000 (GMT)
Message-ID: <fb146831-3e5d-4ece-96cd-b68d00315c93@linux.ibm.com>
Date: Thu, 29 Oct 2026 13:55:40 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] s390x/pci: Free FMB timer on zPCI device unplug
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, oelghoul@linux.ibm.com,
 qemu-stable@nongnu.org
References: <20261028224611.240515-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261028224611.240515-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX3UDn76fSdgP4
 yAMLMTOImliRmMWnC9rAg1PQ1cMFh2iyyqUDTb8Te9YB5f8Tdo+jH//tjMKzsqcQNaa44vETNKU
 3krDlwPnsNJYamxAFEfA/RsmJxFoQhU=
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae3889f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=zRaVaEmAqH1r-lHb3lsA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: tzoiRf-BkLhqRUi6GWmjHO-DfQZpcSI6
X-Proofpoint-GUID: tzoiRf-BkLhqRUi6GWmjHO-DfQZpcSI6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2OSBTYWx0ZWRfX1VP1GCR4OzlW
 3+oHlOsUz6qPgc/+wPQLSceToz/DYtsPz3QjzsXH/fUCc8qxLDyxAupRqVZJNcdsiTR+rCn9HxE
 vG9HDSB0J/VYH/TiguotSuZEtLnM5Cvd/4oYYpLXkJotXO+4tPw3hbfdI7HLMejqxSJWXVkKYn2
 Oms/vR4gdyeL0sVV3/KF7eCydFvjeIOb8l7RdN0Kb1/Q3DxHoTmcX4a/gl/p5FgFR9x37S8AbTo
 XItSOtU2vSesmgHAdMHTxcyQyFS9CedR6fTRCqZNkHo5crPp1nU1x1EgzR0JJK0pZIYrvxon7Ik
 WqkUn3pJvOIbyGN7Z9c5DCg7TAy/QtkSGLrQPSvfR+AEPnqj+F8itgLZMG7Tlpdo2TRBx6tFqEj
 3mF19UzR50lWMYF8gklZ+JB/dmJ66g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290069
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 6:46 PM, Farhan Ali wrote:
> On an SCLP deconfigure we don't clean up the FMB timer. If there is a
> pending unplug request then we can destroy the S390PCIBusDevice object
> without correctly cleaning up the timer. So fmb_update() will then run on
> freed memory. Clean up the FMB timer before we destroy the S390PCIBusDevice
> object to prevent this use after free.
> 
> When FMB was introduced with commit 6e92c70c37 ("s390x/pci: add common
> function measurement block") we originally cleaned up the FMB timer in
> s390_pcihost_unplug(). This behavior was changed in the re-work done with
> commit e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug
> handler").
> 
> Fixes: e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug handler")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


