Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBAAF46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fxK-0005XU-GU; Mon, 23 Mar 2026 10:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w4fx3-0005S3-QX; Mon, 23 Mar 2026 10:08:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1w4fx2-0008FM-4T; Mon, 23 Mar 2026 10:08:17 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N9dtoX3201297; Mon, 23 Mar 2026 14:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3wTRN9
 yjSg92TE4cb1t3O+F2b8WxLeRm/US4zoBQU1o=; b=YQzffg1Kj97N6GnG2Zgfrw
 xwIz/zVIw0E8Il6anj49S91RApnTJyVigvRROkDFkoi1dTrAo2ZgFjwy1oC64eFf
 2dsEf6SsTv7LF3hrlU/QrHAGPLG7lItqsHkO+bGmS4v8x6lbcit8R1v1WQvSnpMN
 zRnDMwaIX3evc6Nmp1bkg6c9UMYhXIVbjMdM3eL0Gzy5JZ+iJrrUOGMbCpowTYpC
 imIuJwQG6Dh48KPg+a/FMPKg2bjafE9rc8e1K01+mtg5dkQD8hCXJ93Rsbzn027P
 1kBJ3OEodz11ojgIHhE7W+Kwhq6gfkV6fauHV/ivSe0b7zOa/1V4chBij1ouM2tg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9q5kv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 14:08:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NE0Ddc004399;
 Mon, 23 Mar 2026 14:08:11 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c1wc8h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 14:08:11 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62NE8ALr24838776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Mar 2026 14:08:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B35958043;
 Mon, 23 Mar 2026 14:08:10 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C4CF58059;
 Mon, 23 Mar 2026 14:08:09 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.71.103]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Mar 2026 14:08:09 +0000 (GMT)
Message-ID: <fd46a8b9713870833e9b4a661f63dffae0b652e1.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: S390 CPU topology: Change maintainer
From: Eric Farman <farman@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Cornelia Huck
 <cohuck@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Date: Mon, 23 Mar 2026 10:08:08 -0400
In-Reply-To: <20260319094835.80329-1-ggala@linux.ibm.com>
References: <20260319094835.80329-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cIxPMAX11JmAAK8gwh5DD4nH8FOK0Esr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEwNyBTYWx0ZWRfXy/GtNrp2dQCc
 8VEx5pqS6sBMwG7I0GPAhghIIGU2HNMgRq1Yc8l26qRLusUg8jRLjhObq156IW6EkurUOepRpFK
 Wbs89AvTeTi5Tk0BaFWElQxGVzehjJOiXCLI4TuypSrlsYTf0wTvS+4LdF3HCMAEWhdfmz8bvoJ
 h/uIRSnNaGrdau4trTJZmJgyfYTck0iyEFte6F55fkj87gnqV7BzD+Vnv5zhifCNiydF4TNWOqK
 l8KejT/2Lmv4Or+YUUbEC4tk8WTz6n5C0YiAhbqNWRFhKvmWvfAtQWc0zYYRbC6AjRqcHLQbnUC
 CMZUeY4d3xGtsz5si80xS2lJ7dL72+uaeqhDlMQF7Syg+dtvuFfJ7pW2R4kCHTU0FXtPC4QEVqP
 MKZ3V6bLhTBkTjsevfleX6e/wSq30luT3ZtX/iNNns/c+qPC9xnnLa+hfo0Hra4TSvemHnGyf3X
 cH84ttpW6KyyHsafwJg==
X-Proofpoint-GUID: cIxPMAX11JmAAK8gwh5DD4nH8FOK0Esr
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c1494c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=vDfXbEq_FW8YIDqasRAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2026-03-19 at 10:48 +0100, Gautam Gala wrote:
> Replace Nina with me as the maintainer for s390 CPU topology.
>=20
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97f2759138..f977a41757 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1916,7 +1916,7 @@ F: hw/s390x/sclp*.c
>  L: qemu-s390x@nongnu.org
> =20
>  S390 CPU topology
> -M: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> +M: Gautam Gala <ggala@linux.ibm.com>
>  S: Supported
>  F: include/hw/s390x/cpu-topology.h
>  F: hw/s390x/cpu-topology.c

Thank you for picking this up, Gautum, and thank you Nina for your work!

Reviewed-by: Eric Farman <farman@linux.ibm.com>

