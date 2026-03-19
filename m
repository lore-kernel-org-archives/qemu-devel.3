Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA110108E1F7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BsH-0001di-M0; Thu, 19 Mar 2026 07:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1w3BsE-0001cq-Es; Thu, 19 Mar 2026 07:49:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1w3BsC-00007x-Fp; Thu, 19 Mar 2026 07:49:10 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J43PXv1288189; Thu, 19 Mar 2026 11:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=coIGNs
 Vbc3q2DWciHsb5bOplNBOD5Y7XC50nJYXv5Xg=; b=AiytlhbcX+NfkViK+nqSOb
 2ZAeHcFK36KqyCS8jpSre2zOeORzqeYQbff9jchynOaD/P66e6KI4zXTB6x+HMBt
 2icteP6Y1b0gx5SAIRFIYgmpcL+3mg9zQVvvFU/igrvdhcShjOEBRKKpTe82Oo+H
 tOuGNtQEaYnxCl1OjEbbXkUjZ8FJ4c6emFJtQIqPO3Qw3TarhmnTXT5f75gA7jS+
 bFK14u2c3ggcW0C6j5cIwLm3dKXQWXxlppd+hjpagLaoY3q1WnCBs6HFjh5JHwGe
 Sn4OqzJFICH0BT8skHYNQ+vL+PoNoZ7Ck/CHp45AU3palpTLEqAX5vDOk9tLIO5Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfry4y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 11:49:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J8ouKc028720;
 Thu, 19 Mar 2026 11:49:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkj99x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Mar 2026 11:49:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62JBmxvv47186400
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2026 11:48:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E7F02004B;
 Thu, 19 Mar 2026 11:48:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F5E720040;
 Thu, 19 Mar 2026 11:48:59 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.52.214.219]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2026 11:48:59 +0000 (GMT)
Message-ID: <1b6ccc353a721ff02242b7fe2193b9524cf54fcb.camel@linux.ibm.com>
Subject: Re: [PATCH] MAINTAINERS: S390 CPU topology: Change maintainer
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Gautam Gala <ggala@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Date: Thu, 19 Mar 2026 12:48:54 +0100
In-Reply-To: <20260319094835.80329-1-ggala@linux.ibm.com>
References: <20260319094835.80329-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pYIeUTNCYu7gU_N-xplR-HU5lO-K0jk9
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bbe2b0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=vDfXbEq_FW8YIDqasRAA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfXybnnM8GvBAqN
 YW51d7wKySFFN7sBHwb8peBl5LnhEZmjQM5VMCOw/v7ZNsVZvBl0wTf3TelUvTqiu9d9xTD8uOj
 /ha8BwGEp6jCgm+sQLbXeW7CHpbGnOcY3DgLVxUbAHox/c3cIHrFbnjkIfUjXHRO9RKC59DWtpd
 5Eq8TPIysabSpG9pF4d3Sx19ToMrMR6v7Ca7uy4NWRE8CNUnRzr4FCdROi5FnXkyUEvxQtmik40
 BBSElB+ON3u7l2G3khP5ZYIbsSC1FbPSo/bsAjUExMlTmkTobsbs+Qnk47AEdskqb1Yvsavz707
 mVglRm20ufq4iQNYGiqaC/ssdFj4ptXgAjr1MkpPW1t/j+/Rp3R42K0NMLr0WZT38wSMtxSREMA
 G84Yl7Fur9IGBarrIw0/+HI9BgdFsc1T2ZGuD7obGKquVwpriyoi/ZvHhsMOaN291WnvlOzruYz
 fZ1Owq3fX7YrEji2waw==
X-Proofpoint-GUID: pYIeUTNCYu7gU_N-xplR-HU5lO-K0jk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2026-03-19 at 10:48 +0100, Gautam Gala wrote:
> Replace Nina with me as the maintainer for s390 CPU topology.
>=20
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Acked-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Thanks Gautam

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

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: Ehningen / Registergericht: Amtsgericht Stuttgart, H=
RB 243294

