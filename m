Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F906105F78C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w11fX-0001CL-63; Fri, 13 Mar 2026 08:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w11f3-000123-IU; Fri, 13 Mar 2026 08:30:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w11f0-0002mf-SN; Fri, 13 Mar 2026 08:30:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D60xF12307445; Fri, 13 Mar 2026 12:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GP6klg
 LufnuPQ+kDQtvTWRIHH45OgRbsZEfnN/8TZlI=; b=QjQRMha5hoQN0Yv4tJ7lbs
 iNngyopbxmIntiVUgYTM/yE2Qf9mCF3rWPRz6f3E1N2Q66r4MItiUTBw71IDI3Qo
 D5ziBBJ472+ymB0kX/eXhQG8JHDsxDZ4iBqTQzQgEumLPippeAUDakp43bUj/a+P
 v8kwlSgvQ2qqakYltlhMju+YU7n133Z+8umLsELgyhiOhNe3C7oV48vZAs/FapdS
 83on7JQekGv76l85aat/2v4yEX3AeYSnf1nNbYUoCBvXabIfJCYzRZfYYdvfPLv9
 14d0pmxld9xka/jKqyFN6rDCc5iuowmXHOKglfYdsR61Qe1DGWO4Rtn5JfwcnbYA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh96fg64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 12:30:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DA9Qhn008972;
 Fri, 13 Mar 2026 12:30:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha76mvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Mar 2026 12:30:24 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62DCUO4D26084036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Mar 2026 12:30:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF0DA58059;
 Fri, 13 Mar 2026 12:30:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6522458043;
 Fri, 13 Mar 2026 12:30:23 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.181.94]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Mar 2026 12:30:23 +0000 (GMT)
Message-ID: <ac816b83c2d0f3278823158472e505e2fdc39fba.camel@linux.ibm.com>
Subject: Re: [PATCH 2/4] MAINTAINERS: Update the s390x maintainers
From: Eric Farman <farman@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck
 <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Daniel P ."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: qemu-s390x@nongnu.org
Date: Fri, 13 Mar 2026 08:30:22 -0400
In-Reply-To: <20260313113424.15583-3-thuth@redhat.com>
References: <20260313113424.15583-1-thuth@redhat.com>
 <20260313113424.15583-3-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX3Aia6WzuHk6i
 VuWDOTqIV3z8W4zMWud/A7c/d3mQG2wHtTk8IES0hEaCFphyr0ynnmewOC4Td5u1gQegBY5Xq67
 lRAjk3PqEWwwim+PDSD88fuGbYrMja6gSr8fduo/ogYuNb5d5cGFyj5RzyenT6O3NxF2Z82Sk8j
 2CJ5LLXg2PogjY0F7KNW86Pctkwp1WFuTsgMRlV7hkILIFW4u6O1fUsRW6QWkv90+oa4+0cefXM
 J3goHT9H2B33Yu5NMjsagjY+nTsJXQYgajGEkA9gmN+NH3oVQL5lFliNOurAfeyE2+Q1xlUFBFk
 ahISxr+hxlJkFKcBzdi6lbRus9/ODUGhKivBPOCOJXAkIsi1HUhz/FMYi+bCPhmGpXwUV8kQ6ap
 u8wCeJ9R2FtLeEgAXyiQJ4NC6LTO4GNL3BnLuZlGsEMt6RpfG2XlnstRpA1sUztQJkcD+33TJot
 SwKCQQK1draRwPmcnRA==
X-Proofpoint-ORIG-GUID: SKBNIS3g2R0yyv6T4NnrqrUc_7j_u1fh
X-Authority-Analysis: v=2.4 cv=RLO+3oi+ c=1 sm=1 tr=0 ts=69b40361 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=LZu0NBD1WcyN9yPbgcEA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: SKBNIS3g2R0yyv6T4NnrqrUc_7j_u1fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130095
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 2026-03-13 at 12:34 +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
>=20
> I'm going to move to another project next month, so I will not have
> enough time to take care of s390x patches anymore. Fortunately,
> Cornelia volunteered to take over the job of collecting s390x patches,
> and Eric and Matthew offered help to back her up, so we can keep
> the "S390 general architecture support" section in the "supported"
> state. Thanks for your help, Cornelia, Eric and Matthew!
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49e9b7dccbb..9a859e4133a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -102,7 +102,9 @@ T: git https://github.com/vivier/qemu.git trivial-pat=
ches
>  Architecture support
>  --------------------
>  S390 general architecture support
> -M: Thomas Huth <thuth@redhat.com>
> +M: Cornelia Huck <cohuck@redhat.com>
> +M: Eric Farman <farman@linux.ibm.com>
> +M: Matthew Rosato <mjrosato@linux.ibm.com>
>  S: Supported
>  F: configs/devices/s390x-softmmu/default.mak
>  F: configs/targets/s390x-softmmu.mak
> @@ -1862,7 +1864,6 @@ T: git https://github.com/borntraeger/qemu.git s390=
-next
>  L: qemu-s390x@nongnu.org
> =20
>  S390-ccw boot
> -M: Thomas Huth <thuth@redhat.com>
>  M: Jared Rossi <jrossi@linux.ibm.com>
>  R: Zhuoying Cai <zycai@linux.ibm.com>
>  R: Christian Borntraeger <borntraeger@linux.ibm.com>

Thomas,

I cannot begin to thank you enough for all that you've done for us, and I w=
ish you the best in your
next endeavors. Cheers!

Acked-by: Eric Farman <farman@linux.ibm.com>

