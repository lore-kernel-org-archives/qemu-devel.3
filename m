Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3699F8A171
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:51:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDMAp-00072O-BQ; Thu, 16 Apr 2026 08:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDMAn-000703-DC; Thu, 16 Apr 2026 08:50:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wDMAk-0005RW-KX; Thu, 16 Apr 2026 08:50:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G9GbGt1804412; Thu, 16 Apr 2026 12:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Eq2eED
 QHrM4+DYTJjRaXgt5qtLc+FSDgooI3zaQl/pg=; b=aGccwsJ/t28A9AXTAtcpGF
 EOqbsrJMZZp5g69247RQocQEgQlGJ5O436BQZgEumCt5pfwYCKjlAk7FH+C0NNxE
 AKNUopVJdB91cht8Yr4UxF78lB33ue1ZeCTqfZD02h7HHGtWsjbZ4eZJCYDj310D
 5GZv6BYGWCScj+3tcimZg2Y5E6mDmjgnU6k6KlHpFBfkRaS/jQGQSoaa7M5qzN+k
 JaCugwp/CoA5vGFRv6JCAfOnf3yK0uRJXz4Nl14n44+Nksw8dP6cnSE491lfBjrp
 ztaTkr3FynmvVL9C5bfRIy4hup8B0XCic3mngYwVJmUXbEOj9Hd+27faKWmyJAKQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kcj1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:50:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GBPOdr003514;
 Thu, 16 Apr 2026 12:50:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnjv6q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 12:50:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GCoFsV24642104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 12:50:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36D1458054;
 Thu, 16 Apr 2026 12:50:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 119AB5803F;
 Thu, 16 Apr 2026 12:50:14 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.88.215]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 12:50:13 +0000 (GMT)
Message-ID: <c8e9ecae00045cc6c2c18ca2f446d75532c9e58b.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/27] monitor: Do not check TARGET_S390X to build
 s390x commands
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Markus Armbruster	
 <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Dr.
 David Alan Gilbert"	 <dave@treblig.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Cornelia Huck	 <cohuck@redhat.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Date: Thu, 16 Apr 2026 08:50:13 -0400
In-Reply-To: <20260414003001.97571-10-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-10-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VKR1ZPzk0iEmkeBkYivPz3ibW8TE0Pd8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEyMiBTYWx0ZWRfX6J/5M3JbBlBp
 KxOQO9v8sT4PlSMhGLjQ8KSSwOo7Fpz1x1c4SSVTlaczsfyI51fyZOoPu8GR2XgW+QIcogFPOOa
 HrX1dpKRRLHDUJLgT6aO1Ftcv5qPetF4V7w5dawwDTwg4fDEu3L8nTymyWNggDUU4mvmsm2gVtC
 wn+uUim+tzwUhZfdszeIuoIZXWxZWqv4pSmhRa6qKP0FguCPwlPdo2V0mPBo0wDLImmLo84L+er
 LMFgOzo3Q6emrLYZ0oM+R6EJ+DiGn1YE9hxN92H6Ax0yXjrsrLPUx34MDc8rKcHBUhxo+aHP4Nz
 Z7539fEg9FKmC3H9QgRwp+h+95JeW/6opCMiMpWjw9cCd/APk0KI2HnYO7XhK/jVkQ0UrkPn66G
 W8gLrEtFhLsG0lQ6IW3FTA8OHvnQMpLRSCVdN5WvifEaksbjRmbtYKplw1kOxxhNXyeBiUNA6pZ
 jjo7P5YZalJPJgzNryw==
X-Proofpoint-ORIG-GUID: VKR1ZPzk0iEmkeBkYivPz3ibW8TE0Pd8
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e0db08 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=7lKa2-ft5RzbA9ghYS8A:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160122
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

On Tue, 2026-04-14 at 02:29 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> These commands are filtered at build-time for s390x binary.
> By using the recently introduced HMPCommand::arch_bitmask flag
> we can filter them at runtime, making it possible to compile
> hmp-commands[-info].hx files once.
>=20
> Since the methods are used inconditionally within hw/s390x/,

unconditionally

> define them in the same stub file.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  MAINTAINERS               |  1 +
>  include/monitor/hmp.h     |  7 +++++++
>  monitor/hmp-target.c      |  5 -----
>  stubs/hmp-cmds-hw-s390x.c | 15 +++++++++++++++
>  hmp-commands-info.hx      |  6 ++----
>  hmp-commands.hx           |  6 ++----
>  stubs/meson.build         |  1 +
>  7 files changed, 28 insertions(+), 13 deletions(-)
>  create mode 100644 stubs/hmp-cmds-hw-s390x.c

Reviewed-by: Eric Farman <farman@linux.ibm.com>

