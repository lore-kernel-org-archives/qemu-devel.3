Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52788606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mj6kLidt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHMP-0002Kd-PP; Fri, 23 Oct 2026 11:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xKHMN-0002IA-FT; Fri, 23 Oct 2026 11:39:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xKHMJ-0006bH-Sb; Fri, 23 Oct 2026 11:39:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEEPoY1517751; Fri, 23 Oct 2026 15:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8STOlT
 zPDYzA4yhGw6Y7RIiCJHvtWqQG5SfoVyYmu28=; b=Mj6kLidtVZ54pnjmj29h8z
 /pAt3XEckZdHsJ+4tinQUlpeHxOES9CNo+Zr1QnyQ2I2MpW7dv2O9TKKiXHm2Usa
 PYHDO1sQ6N7xa2ULYXLkSGIfEKwNXNRhsu0vPZ4RJ9lTV6+bhb1uXFElJNHDNMtD
 3GKDDSs1HBrdX4Grfi58oWjqGHhGKvJFsEpPS8j95hrDrerKXLO7hVdymlzA8OEn
 T/Om1y0gjAHb81KU17pv9oCEqM7Fo99AQKBFMz+rMD528cyVEY0Ur29SFzuOO6wz
 SFJSInsgL+obGVZdXMSTyG11DjE1Rf8kNKAdtUnkpG9nvIqUWCiH0JkNZQedaBoA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bx61r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:39:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE66Ka2263036; Fri, 23 Oct 2026 15:39:02 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck65qx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:39:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NFd1hq11666072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 15:39:01 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0498958058;
 Fri, 23 Oct 2026 15:39:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9959558057;
 Fri, 23 Oct 2026 15:39:00 +0000 (GMT)
Received: from [9.61.170.195] (unknown [9.61.170.195])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Oct 2026 15:39:00 +0000 (GMT)
Message-ID: <9c558165-c746-4fed-8bc1-aa561c3b87ce@linux.ibm.com>
Date: Fri, 23 Oct 2026 11:39:00 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: Add other s390x tree
To: Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
References: <20261023151229.1196404-1-farman@linux.ibm.com>
 <20261023151229.1196404-2-farman@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261023151229.1196404-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vLWSPmWvXbXgpSyclN7cO8jOmK_xS3CS
X-Proofpoint-ORIG-GUID: vLWSPmWvXbXgpSyclN7cO8jOmK_xS3CS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX4fzQE/10dDob
 9dcrNZw4GoXColHARPG+MFUvfogMZA6qbZOlPKSp7Nc8ucE6ZDgv05lk7iKNW5JLPurgAxoUudj
 NKhF+F6VIUzKhArSvLOmHbIB2AyEZFo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX+E3ARxOuDtmX
 tK6PdCbrQP7wFqb5ZVsX/RhDfSWsvQe7UTSdi8y2h4BsCFZ0wC0+Pp3trEZ8P5cz5EazMNFrzoR
 8nmMtFMF12n9gcE5+ZFEiDJbXPJYRfGRiCh0jeFHTQGRow3V9ttic4XTLhyG3CYrlj5h6RXrx4e
 WPsfsRZByJsqReZnPTEzSgEq9XqYDgqMLGU7vmOy8BluXOc56TpGomTgfh1ZmD1ywVRGjrhGAQ/
 vyKs85X4bvSa7fw8c3QeNmzGSEcGrXMk8DiJ/lxt4m2WLTsjmSPw5ECQxKFIbK52wryRWkPDsc0
 R+UycU1bjoNaMLae44ar0PX0fAdWcppJgoGV/oWwhWMWLKCEa8v+kupmE6K5G7XQ7j6rcnwvUYr
 j3c2WN51sy4CPq3ukZQGCfNLpQETnGL/zyrTkQbqiDsQM/rse7SKlMOwnvpENGIkHqogpRNVA+c
 U8v8IK11TZ5Zre47Uug==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb7f97 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=UTLNF-ZZHEpAsmNzUOwA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 11:12 AM, Eric Farman wrote:
> Add my gitlab tree alongside Cornelia's
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

I wonder if we really need either T: at all -- but I did check and there
are various other examples where >1 tree is listed for an area.

Thanks Eric!

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9209f043f0..6ee1800707d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -129,6 +129,7 @@ F: docs/system/s390x/
>  F: tests/qtest/migration/s390x/
>  K: ^Subject:.*(?i)s390x?
>  T: git https://gitlab.com/cohuck/qemu.git s390-next
> +T: git https://gitlab.com/efarman/qemu.git s390-next
>  L: qemu-s390x@nongnu.org
>  
>  MIPS general architecture support


