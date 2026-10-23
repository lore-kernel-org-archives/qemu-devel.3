Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C21606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AxJwf+a8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGwr-0000g5-CH; Fri, 23 Oct 2026 11:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xKGwm-0000dy-BA; Fri, 23 Oct 2026 11:12:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xKGwk-0003dk-6i; Fri, 23 Oct 2026 11:12:44 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEEBBZ2036074; Fri, 23 Oct 2026 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=nl5SMdY8TeyCNOwn1
 rg+zztvLQMD7t+RQYzEVPyKH2E=; b=AxJwf+a8QwLt7tZzL/jQpD0rEFXd7i9sW
 G9U4yHYmyb5J8XdVY+aGSK32oRyF0Th3vfbupVo3w2JEBni77PwcjY0mZOE2PCJQ
 5pHw4JUP29k+MjZpl5xW74Qcr2jSzM8wUNlMDOXXiJKOWxn7nwy/Av4X+5Goe7Jn
 BSad+KvMLxxxK9Usw3GTyeddYvvDSMgHxTSpobf4kWLh7LzlAbjjv0j7oCqMsYT8
 rR7kgUnJhu/M8no3H8sbeIWPIeqZRaUI/EdmxuB/sk0rSsD1BQS/S5Gu6LEe7Ply
 tPLSojsHXsQHMJJWuks0wZS7f5VaCb24NriBcvSFDiC5BjPxXBeZQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58n8q2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:12:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE659U2263017; Fri, 23 Oct 2026 15:12:35 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck62x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NFCVso48759114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 15:12:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88BD22004D;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7031A20040;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 55D6F160E04; Fri, 23 Oct 2026 17:12:31 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 1/2] MAINTAINERS: Add other s390x tree
Date: Fri, 23 Oct 2026 17:12:28 +0200
Message-ID: <20261023151229.1196404-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023151229.1196404-1-farman@linux.ibm.com>
References: <20261023151229.1196404-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX5bluFH38M8T8
 Qrfwyrls6kGJykDUhDezUGJP76TRPQNtk/nooz6ODTbulG69YlCLs9FLavyWRGb8Su84DpmPbw8
 kGeh86AHL92xpZlpmLQiPMgnCeaCwyQ=
X-Proofpoint-GUID: StmBhTV-WorMXTZ6nLQu5ffjWxS9P2GC
X-Proofpoint-ORIG-GUID: StmBhTV-WorMXTZ6nLQu5ffjWxS9P2GC
X-Authority-Analysis: v=2.4 cv=UOBIjyfy c=1 sm=1 tr=0 ts=6adb7964 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=akEG_2BtdzyEkUquQR4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX+3E0zNvO5DHx
 HkLgaFfP2TbiUQdjLMstkvQ8p3uTu9j8sik7GBNzZHtY0JmPggU9I4TyR3+xIrl12qXfRIDhCyw
 hcdjEAfoXWliPiTkeOtiaN3vgnm4tBlfSPWMUgO9OvykD6P15qBSvPUDnfCRVpZfryATFA0U0wo
 Q21qx8lr9g0AY/ukFzd6+dylGE+qdFBWExMrUCadyKqUBNqq0LfZTsU05QU8+YKxQeejPZ5naIE
 Jw5c2f+grSxE+3i8ubpCzFEc+PS5fzmbiiSCqIU9uMgfPngMxMvxE6ESk0CVEV02K1PXY5xOWKJ
 /EPKiJajfAdyc0iYd46Zc1L4GJf3SixWueJBhJu/8vMczwv+v0V4O+b0IqOhtktRYAHcyMNzYFM
 KYU4xeEyhIP6EgLTGMLCvoLQCwPmlpu+vcdr4eyDAvHIEyT1PDKwjS/qnZ2FEM8P+ttTd/QWhRQ
 EhZZ/lkNqIvM+zG/oAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230057
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add my gitlab tree alongside Cornelia's

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9209f043f0..6ee1800707d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -129,6 +129,7 @@ F: docs/system/s390x/
 F: tests/qtest/migration/s390x/
 K: ^Subject:.*(?i)s390x?
 T: git https://gitlab.com/cohuck/qemu.git s390-next
+T: git https://gitlab.com/efarman/qemu.git s390-next
 L: qemu-s390x@nongnu.org
=20
 MIPS general architecture support
--=20
2.53.0


