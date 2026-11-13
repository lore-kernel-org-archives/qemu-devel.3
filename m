Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD033606A332
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FdQQDygz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRoD2-0006FM-2b; Fri, 13 Nov 2026 05:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xRoCe-00063l-NE; Fri, 13 Nov 2026 05:08:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xRoCc-0001x4-30; Fri, 13 Nov 2026 05:08:16 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8iDq92377716; Fri, 13 Nov 2026 10:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=LDtrpSfORY8xZNFjLiZz1TgjtDJXHL
 NcK8LHnjmJmlg=; b=FdQQDygz3hUw5sFVwq4onsgnwxMGsk/hwRp+eCMuvVtITE
 UITVnCEoMa3mZJbAPivlA5gmZiAHnkCd5mjI/vrt0nVqmVGRoSVav9ngcog18AcW
 beNCVYDEhROd/Qzz2VetbMEuvbJAjcXfpTavDCxR2MYZZr74eTyKyeUGAvnLAFMg
 KzIU3DNVKLS3oe09IRyIbK/oShzmGxPinX2qgDCX6u8hDhqj+BfAX4eB1yEURbA3
 KJ8eW0QzsVifguIpeNohfBV98DghRJE2rzxXbjthXixAMSbrbVHhFe7LxVF2+TtR
 Iw4Zx+kZ7+g4rCMVznsRQrRp5aHro4lYfC4tZ5yw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv9cww-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 10:08:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD8o8NB2067157; Fri, 13 Nov 2026 10:08:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq10r10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 10:08:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ADA85D734144756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Nov 2026 10:08:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7796920043;
 Fri, 13 Nov 2026 10:08:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DACB20040;
 Fri, 13 Nov 2026 10:08:04 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown
 [9.39.17.165]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 13 Nov 2026 10:08:03 +0000 (GMT)
Date: Fri, 13 Nov 2026 15:38:01 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Miles Glenn <milesg@linux.ibm.com>
Cc: harshpb@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Change XIVE status to Maintained, adding
 self as co-maintainer
Message-ID: <avbhQTWuvdbuu7jr@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261112074640.219753-1-gautam@linux.ibm.com>
 <f728d68ca68868d3995df0d1ee0f95476dd4dd1a.camel@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f728d68ca68868d3995df0d1ee0f95476dd4dd1a.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzOCBTYWx0ZWRfX+pvzxKL7FlGT
 wBzVo5WzvPS90nvNwiBr4HrE0oO1E4OHMBHDLyKoS2NJMxwrpbmURuFdkPvsiYu7lwxD/yPlVoY
 sphXBCQly4dCORNgYmqd0OZwf/d0EcU=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af6e18a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=eaLHB01iMlaGLgDQ3HQA:9 a=CjuIK1q_8ugA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: aUlkx1L0KlSCA-ePphNvRZybFCJ3BdX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzOCBTYWx0ZWRfX7YMRJzj5KlPI
 HjwA4TCZq917Pz3qm3qkpP5DumHsoIZ5FagO4ur7onNTmHCKwoj0/q96vEuD1EDSSfF5BwbHKzd
 aNFhspKv3F/hY1WsEA8tVekai8Mo9HE7hv6oXTWC6o7sCxP8qMA2WBSHmH/Cxp9zR+ZJxWSPGPS
 gn8UNfgMglzaxvBoq1RBHop77di1ZAfNFa7nMLZgeN5g679293T+G5hOdI/be68jSFSUTjSAjHe
 wqXJy6oEflHPRiCoi3XYPmXKbvp3tZtChOMZ3s5L6XKdfglGSf5Y1guLOpznwLF521IRlpSRjVe
 VIWbZ/jdnKh9UD2qh3zjW5vXMkuaRlSYrFYb4c0K00/Y8JhoaYr90FgkD/biv8U29Krvd7KeHxw
 h5Hu+V+pIRBQ3MgNg29HysDJufa8gLepsCiQt6o8PvIKpZrG3tRgGuTh8BvuinJyeFHDI41zSwP
 D1Fzk6Gjw0RojR9C8kg==
X-Proofpoint-ORIG-GUID: aUlkx1L0KlSCA-ePphNvRZybFCJ3BdX2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130038
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 08:53:21AM -0600, Miles Glenn wrote:
> Hi Gautam!  Thanks for taking on maintenance of the XIVE code.  Could
> you also remove me as maintainer?

Hi Glenn,

The intention of this patch is mainly to mark the status as maintained, and I'm stepping up to share the
maintainance responsibility. It would be good to have you as the co-maintainer / reviewer.
Do let me know your thoughts.

Thanks,
Gautam

> 
> Thanks,
> 
> Glenn
> 
> On Thu, 2026-11-12 at 13:16 +0530, Gautam Menghani wrote:
> > Add self as XIVE co-maintainer and also update XIVE's status to 'Maintained'
> > to reflect the actual status.
> > 
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  MAINTAINERS | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fa0c6d0c9b..47c0b6b4ca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3078,9 +3078,9 @@ F: tests/qtest/fw_cfg-test.c
> >  
> >  XIVE
> >  M: Glenn Miles <milesg@linux.ibm.com>
> > -R: Gautam Menghani <gautam@linux.ibm.com>
> > +M: Gautam Menghani <gautam@linux.ibm.com>
> >  L: qemu-ppc@nongnu.org
> > -S: Odd Fixes
> > +S: Maintained
> >  F: hw/*/*xive*
> >  F: include/hw/*/*xive*
> >  F: tests/qtest/*xive*
> 

