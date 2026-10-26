Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A085606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBq9oR8K
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLJV-0000uy-CZ; Mon, 26 Oct 2026 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH6-00078P-Cu; Mon, 26 Oct 2026 10:02:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH4-000190-CS; Mon, 26 Oct 2026 10:02:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEvvr3337328; Mon, 26 Oct 2026 14:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=f3Pg4pr7U0zB/ZDu/
 dH8wQUkaNKpjnxdb4sFFKY4XqU=; b=tBq9oR8K9KtGZV/NgWDO5DT5k+7LrNS8/
 +rg1+1HDdmgbSmUCMfloKg3eiZXXWr6r4byoHqE0+7yLqVGjVjdDmYIQeyLQ94fW
 39spP71wRQUmi20gHT2JWDekirmRPbU+6+nLDJvXNBBcWmWuBZEe6WcxRmAI5Eyo
 1j6cJEO3uTY4lfwx50oiksLKNzlAgJSdELzrV622q42xQO9Mhlny4PkIo8wR6FLa
 p1rsy+6RiZEWDXz1dsP4h0Nu8VZKCXCvuqd13Y4vQYjZNYKwJvFKDyvTbRLVhcKG
 r0toUNvpsTVmbl1rBHIzr4sQ1HV0dsVp3DAGV2cxNfvCiO4tHkTWQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6tang-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBK8oi2443168; Mon, 26 Oct 2026 14:02:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cveakt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE20TY11535092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:02:00 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B046758043;
 Mon, 26 Oct 2026 14:02:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F9525805F;
 Mon, 26 Oct 2026 14:02:00 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:01:59 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 5/6] MAINTAINERS: Add other s390x tree
Date: Mon, 26 Oct 2026 10:01:52 -0400
Message-ID: <20261026140153.2072253-6-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf5d5a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=VcBA9oKi8UTSD-B-aecA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXzoU5Redov9uV
 c3xEX6DVHxPxiCSpQFxE0ClMTBBllf+kCU/bov07LZMNOZWObgwReG9xnKVCUI2HyDGkn/FE8s3
 WoQOYopxH2JhIt7i4JLDNaqcSZQx9RFvunisiVsDqH0lcsJviwqid8F5vXCumxAVcTQ4K6Ia0dk
 DCn2wISDbE2dSl7X6WU5KAovxuSA6Tb1P5Nd1jXY4g5htzqu8T7tAwgAkJ0HBi/emWKcw1eqYSu
 +aF3ByDN+Vx6VbkHS5oBwnL1yXG4zyru1mlJc9EYeATn5GerJrh4Kg0j6b7KwxhFpopsYJ8htGb
 aqmKuNvwShLBJVdEBfo4VG20yUEKGuVF5n/QTNdFUmOQ5im6K0cUrsHxMIc+tEzkvyAYwRlKrSP
 Wb/AYnGjqRlZT20Ev8i9O2uC0nkbAryDcvO3Xpv26UF2Ze+SQZW8xqign6W+9nIEkF1fqVF88pe
 P7InOTqpt9wWCY4xYqg==
X-Proofpoint-GUID: AsZz2M3WTrOPIh9tf8JRh_eyLhBcvqfd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX2vgmiwNHy0Ih
 x2CGXbHEAgjwzWxM2zlTFWxqxsBkh9m86JSeSLquRZe8LWpLriUlulaPxPmiLfioTJKH7A8Ck0j
 X3DwbtxHt8lLuBMgL1cSXvMfZO+jyw0=
X-Proofpoint-ORIG-GUID: AsZz2M3WTrOPIh9tf8JRh_eyLhBcvqfd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add my gitlab tree alongside Cornelia's

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261023151229.1196404-2-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33b4f7c259..040d27a94f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -129,6 +129,7 @@ F: docs/system/s390x/
 F: tests/qtest/migration/s390x/
 K: ^Subject:.*(?i)s390x?
 T: git https://gitlab.com/cohuck/qemu.git s390-next
+T: git https://gitlab.com/efarman/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
 MIPS general architecture support
-- 
2.56.0


