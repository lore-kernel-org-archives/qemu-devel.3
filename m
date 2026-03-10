Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B3CEB1076
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzOU-0002S5-HS; Tue, 10 Mar 2026 11:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vzzOS-0002Ql-9D; Tue, 10 Mar 2026 11:53:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vzzOP-0004mw-TU; Tue, 10 Mar 2026 11:53:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9ETch1505945; Tue, 10 Mar 2026 15:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=LVSCxs
 JYaUb30I8VXW74xDfsmGeX4mjCGngqDyaWkao=; b=lNYX3P7QgK/CeuhUJcb484
 cEuXFhlDFhQVS6wy3CmkAb8IKE7rdwJYrzf+z686snVFb38KY4BG164FDt7Dgr0c
 hfuAWb8nLu+XTx7H3j1moz44orgkTzXStT9o3hwrnYWqakeucPzK5HN64tHCA5Et
 ribI2ldEORL2HyuuIHGQ0Oywt81M/SzfjrGjzfc1yer2ajFJ5PkkqhkNMxYMmuMX
 z4LUIy+EYqD3VtgD0HwqnUfsHGu8LHymrfLQ4Mw4XS+ZFYGr5ZnSIy8Y8kuWrkbD
 KR3j4i3frJgskpyZS0Twegd2cTpWOhYOK0kAWYXULsq4/c+GUhJUIxZSC/fzKSdg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crd1mk9k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 15:53:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AD2MFN015761;
 Tue, 10 Mar 2026 15:53:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1221f9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 15:53:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFr6QX29688392
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:53:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11FCE5805A;
 Tue, 10 Mar 2026 15:53:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8158758056;
 Tue, 10 Mar 2026 15:53:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.185.62]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:53:05 +0000 (GMT)
Message-ID: <18bca005750d835cff2d855cc46501fbaeec39e1.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: Update S390-ccw boot maintainers/reviewers
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, borntraeger@linux.ibm.com
Cc: mjrosato@linux.ibm.com, zycai@linux.ibm.com
Date: Tue, 10 Mar 2026 11:53:05 -0400
In-Reply-To: <20260310142118.1120291-1-jrossi@linux.ibm.com>
References: <20260310142118.1120291-1-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ds3Wylg4 c=1 sm=1 tr=0 ts=69b03e63 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8 a=qQASs0gnnu4lUi2r55sA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzNSBTYWx0ZWRfXzcYL97LoKg4m
 +CEhHCx7ZMvvc/fxOnOiLu3E/DMpKVymOQ09rGyNlu55jOAwuWVYazIM5pKdhDdCZseSVkOaKeu
 ACMGa/OWBE/ejrkOJxKqjARkPdZ3jZ6+hlbu25hgX8FJqvRizmIqENo7C1gRNBa9L4oaL4xGXiW
 +3KRXsqFeiq0agELAgXHkawzc6OTJBZQ6q9nunXTBdnvOkgUKjclVD3jahcVeUGpcrLKpbgTWr2
 VWbjbksi6I9vb9SVOfJvkeeD8FT8J++/W1EwCrURJ7eToZAju3gtPH6pq885oNjdgF4LwXYQZcJ
 DN3TC37as6RDcXlHvuBV99zd9XGDIsFfq8R+BWs1MIvjyuaKsNRGWSEQovYBql0sbHKFwlF+WnL
 P02XsYMD2c38r3RV2BVgusVRdZ/+tEUwE7S5vZQtrhVp0v+PN2qs1Wo4wG3PwmHZm1bFtXiFIgC
 lop8mANxSDFGXcOqNzA==
X-Proofpoint-GUID: ockR7c98D7bAbknDsjZifp0BqQly5Huf
X-Proofpoint-ORIG-GUID: ockR7c98D7bAbknDsjZifp0BqQly5Huf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100135
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

On Tue, 2026-03-10 at 10:21 -0400, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Christian Borntraeger is no longer active in this space.  Promote myself =
to
> maintainer and demote Christian to reviewer.
>=20
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thank you for stepping up, Jared!

Acked-by: Eric Farman <farman@linux.ibm.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80e10e43b5..1012135dd4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1862,10 +1862,10 @@ T: git https://github.com/borntraeger/qemu.git s3=
90-next
>  L: qemu-s390x@nongnu.org
> =20
>  S390-ccw boot
> -M: Christian Borntraeger <borntraeger@linux.ibm.com>
>  M: Thomas Huth <thuth@redhat.com>
> -R: Jared Rossi <jrossi@linux.ibm.com>
> +M: Jared Rossi <jrossi@linux.ibm.com>
>  R: Zhuoying Cai <zycai@linux.ibm.com>
> +R: Christian Borntraeger <borntraeger@linux.ibm.com>
>  S: Supported
>  F: hw/s390x/ipl.*
>  F: pc-bios/s390-ccw/

