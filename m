Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B211606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DPWXHV6H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOJq-0002WC-46; Tue, 17 Nov 2026 13:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xTOJk-0002VM-Tm; Tue, 17 Nov 2026 13:54:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xTOJh-00014r-VT; Tue, 17 Nov 2026 13:54:07 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQt9U2731233; Tue, 17 Nov 2026 18:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Gl30yeper/9jSIRmPKka1EbbTCp22uA8gzytBflCQrw=; b=DPWXHV6Hcalc
 YKtavBGjdRWO33Oln+4EBmbYuFqTFoNtfdnTKiN/OOTyWpdUQNJ52JZbHzkiCfF+
 uW5kygGzx65c12BQNihsgdL3eMC2o2R/JKacIcBrRwixWwYbY1rAQShuoosuMoXb
 Gtm6i0IxF9zxkSVo1P4naESwa1qZ9VbpUsKi696qE5IOXZE+Z54TT39p/E7IG6nj
 riJCYkj72OzaTDYVXxCZh7Zkh20azZX+mTQkUVqzhSPdvohXdvnLQssSHVZM1OgF
 Q+trBT25p0AUB+20HL6rDwg3xnJn1zzTy4teHgqLQrBfE6z7Z0Dt2XUsM6XGNGJQ
 onI4cLZBuA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfc54ybb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:54:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFnpZ84159552; Tue, 17 Nov 2026 18:53:59 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvf5j1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:53:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AHIrwcZ65405356
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Nov 2026 18:53:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A969A5805A;
 Tue, 17 Nov 2026 18:53:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3828158054;
 Tue, 17 Nov 2026 18:53:58 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Nov 2026 18:53:58 +0000 (GMT)
Message-ID: <54099e817836cac4c73174496253d2f299a686c4.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Change XIVE status to Maintained, adding
 self as co-maintainer
From: Miles Glenn <milesg@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: harshpb@linux.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Tue, 17 Nov 2026 12:53:57 -0600
In-Reply-To: <avbhQTWuvdbuu7jr@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20261112074640.219753-1-gautam@linux.ibm.com>
 <f728d68ca68868d3995df0d1ee0f95476dd4dd1a.camel@linux.ibm.com>
 <avbhQTWuvdbuu7jr@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX23InHUYN/J3o
 +1NOcGZlbIusg0Q4ip+NMW2WiL7IDhybjU5rCDLKv6k+BUMUTLwMdqGSZ8POd6fCLVz3foE6/GE
 yYz2rSAuzStvWTRStQ6xsAWoH3txhZg=
X-Authority-Analysis: v=2.4 cv=Fu6QbGrq c=1 sm=1 tr=0 ts=6afca2c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=-C0ItT94nz96NXNb-dIA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3MyBTYWx0ZWRfX8JKD5eUwGVbj
 64czMee7CfP/vs4UqXOYa2zrwxeSJFWSFrN00sHGXbnEdgHv8Ihbmgb6nul0blEOIWJ5M+oikP1
 MSCPMnGfcNa+U2KJHdFLxAG9p4lwrDhcHyw776DONu/sE/krzKz3m5FT527sRV/6LOjxcpmLCLl
 FAWe120tibCGMlbyWpZY0pe8pdj3t2BYQZglOdULki3ZCVTNAjLvjETjRGWExyYT9XT2MuofkNV
 Kd6yYRXbliIkoN1+h5ojvoifF3f8+OWffRKypdMMZZX5vRo7P+qz0xBa+ypcKJvihZqXwUV3XTq
 Os3Bii7i3GLvnThYbd5LZ00Tb4qXw+0SroZYyRDfeJYJehjlDdDjyM1bN7RyIcNg793AtjJ+2aR
 CBPuss5Xcz0Et55PklbVHQNm0+6QIOUJCzIKbGTr03CrLItvOXHHZZKJQ7AAJX2EJZnR9TKLN1U
 sK80x7+lciVFvwq71Cw==
X-Proofpoint-GUID: CAqOnt-zDgWBF1ciH4sOucOiL4ZCK3zS
X-Proofpoint-ORIG-GUID: CAqOnt-zDgWBF1ciH4sOucOiL4ZCK3zS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170073
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

I was only supposed to be a temporary maintainer until someone with
more XIVE understanding (you?) could step up.  It's fine if you would
prefer to keep me for this patch.  I can submit a separate patch to
remove myself later.

Thanks,

Glenn

On Fri, 2026-11-13 at 15:38 +0530, Gautam Menghani wrote:
> On Thu, Nov 12, 2026 at 08:53:21AM -0600, Miles Glenn wrote:
> > Hi Gautam!  Thanks for taking on maintenance of the XIVE code.  Could
> > you also remove me as maintainer?
> 
> Hi Glenn,
> 
> The intention of this patch is mainly to mark the status as maintained, and I'm stepping up to share the
> maintainance responsibility. It would be good to have you as the co-maintainer / reviewer.
> Do let me know your thoughts.
> 
> Thanks,
> Gautam
> 
> > Thanks,
> > 
> > Glenn
> > 
> > On Thu, 2026-11-12 at 13:16 +0530, Gautam Menghani wrote:
> > > Add self as XIVE co-maintainer and also update XIVE's status to 'Maintained'
> > > to reflect the actual status.
> > > 
> > > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > > ---
> > >  MAINTAINERS | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index fa0c6d0c9b..47c0b6b4ca 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3078,9 +3078,9 @@ F: tests/qtest/fw_cfg-test.c
> > >  
> > >  XIVE
> > >  M: Glenn Miles <milesg@linux.ibm.com>
> > > -R: Gautam Menghani <gautam@linux.ibm.com>
> > > +M: Gautam Menghani <gautam@linux.ibm.com>
> > >  L: qemu-ppc@nongnu.org
> > > -S: Odd Fixes
> > > +S: Maintained
> > >  F: hw/*/*xive*
> > >  F: include/hw/*/*xive*
> > >  F: tests/qtest/*xive*


