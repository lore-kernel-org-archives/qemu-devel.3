Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E5606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ym0tc0vr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRWBn-0000Jx-Vx; Thu, 12 Nov 2026 09:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xRWBC-0008Nn-EG; Thu, 12 Nov 2026 09:53:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xRWBA-0006Ea-Jo; Thu, 12 Nov 2026 09:53:34 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2iIve1214737; Thu, 12 Nov 2026 14:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=FmeaJvaK4svj4NERxMWqHr6kNvuqBevGy4InWXGvR+M=; b=Ym0tc0vrIckS
 KDwCaAnpTPACe9oO5+eGul64N3XzXWNE45nm3VgCL792rvWCQPAdQOKmDLrKEXx8
 A5IDQ2PwW645LBMFS1oraRWcQRk8FFzBUN2oaB0s4/BI7FgHA5jF1dK+NuZy/WaF
 0WlS5d7CWQeiSXfRkHsMCvcSTOCZcbG2VzMKGytLX3/Zmozjvh23XKB5hdUwka6B
 /owUyvFdXuZd1m2AYtt6XYDI8C2LUcdzhbiSVmzlcVglkj/ZjQqrUIh5PphPc2Ye
 I4TyKG6bN0HPs05Xk5S8ngxYsz2SK2xsHmnh+L3J/269dOdbuD6BROofbCmTglUS
 EhrimpnkwA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntg1qj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 14:53:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACD3q9x3146060; Thu, 12 Nov 2026 14:53:28 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51xvtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 14:53:28 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ACErRGq47579516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 14:53:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CDB05805B;
 Thu, 12 Nov 2026 14:53:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3BCB58059;
 Thu, 12 Nov 2026 14:53:26 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 14:53:26 +0000 (GMT)
Message-ID: <f728d68ca68868d3995df0d1ee0f95476dd4dd1a.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Change XIVE status to Maintained, adding
 self as co-maintainer
From: Miles Glenn <milesg@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>, harshpb@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Thu, 12 Nov 2026 08:53:21 -0600
In-Reply-To: <20261112074640.219753-1-gautam@linux.ibm.com>
References: <20261112074640.219753-1-gautam@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1OCBTYWx0ZWRfXymyToDye08cD
 JtL92oWz3iLEqN9bUOzrND7UZiVe1kbPr6EpnsVnE3P9B+SLVTPRU/uEuj0gMPA92a5OE6hcjtN
 JAo+SYTvNpnsOHTNDJT2ECikZp5Dny7O3htgAFZMLgAVrxHo+UOYdZVwjytfxwstJiKQOPiNuZy
 KET8FMewBT1Yw6T7eL9OaL3sheLXUPqUznr8g2IVqKOPAad7xR5FNLLlvEeMTE1bvojlKdKLCO+
 zxIi5YmDrf7rQWNEEVOVsKvY9NtduhG7hkFpCBJO5xSwVh3xC2VY/BUrrh2PXAaMItoBkUgfgLj
 ux0neGan8Ak18d+axxDeU9uXnRxA4kgkHALQOzQ0Pt6jqx6qKyjkzZhK/jrOeVI59gA7cnr+GHm
 a8v636xmLPXvenFXZaUVy2vpHzyhvh46d4jctquUUxO7Zyg5xC2B5k1Wx+IzdA4cJmRYOmMyfVd
 wivq0H8DxOlSY82J95w==
X-Proofpoint-ORIG-GUID: i2GcbUavdKUVudI1FpoV9cf4qSdVGiMc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1OCBTYWx0ZWRfX7jeO+QBumJXd
 tcJKw7h10gdMVAdIlcdR+EgQPaObknF0K0u7mGke6KA828kkayWHgJnHdor46V/z6OJGwiGDe0M
 ntL0P7HXTa0Z/JoKh/iErebJMeNr7IY=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af5d2e9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=eXDhFBkwkLZeGlx9B3EA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: i2GcbUavdKUVudI1FpoV9cf4qSdVGiMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120058
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: milesg@linux.ibm.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Gautam!  Thanks for taking on maintenance of the XIVE code.  Could
you also remove me as maintainer?

Thanks,

Glenn

On Thu, 2026-11-12 at 13:16 +0530, Gautam Menghani wrote:
> Add self as XIVE co-maintainer and also update XIVE's status to 'Maintained'
> to reflect the actual status.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa0c6d0c9b..47c0b6b4ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3078,9 +3078,9 @@ F: tests/qtest/fw_cfg-test.c
>  
>  XIVE
>  M: Glenn Miles <milesg@linux.ibm.com>
> -R: Gautam Menghani <gautam@linux.ibm.com>
> +M: Gautam Menghani <gautam@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
> -S: Odd Fixes
> +S: Maintained
>  F: hw/*/*xive*
>  F: include/hw/*/*xive*
>  F: tests/qtest/*xive*


