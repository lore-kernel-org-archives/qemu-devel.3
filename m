Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95691606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bK4ICPgR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGwr-0000gH-T5; Fri, 23 Oct 2026 11:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xKGwm-0000eB-SC; Fri, 23 Oct 2026 11:12:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xKGwk-0003dp-Uv; Fri, 23 Oct 2026 11:12:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NEEDlB3288886; Fri, 23 Oct 2026 15:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tKm89Lpq4gBHlTXj7
 QXR1Tpd2BRBoXWRNK63geEePwc=; b=bK4ICPgRrRryKitWn5j0UN8NonTxEoQZt
 kaK4GZJsQ92MmVYpV12hD2SuniqgIHLT6PRMkXWjsvPJI4Dbvr9Xp9NBe2eQRL6p
 g+Os9HkXNy/tLeEV2p8IQ/i66bxPM5mWsD9VF43TUeSWiKurgKvj83NP40Gkm4TW
 1/p7c5bME6bmS3I7xwqahAFZ2bfqJby94fSyF8DYxAtG1Gba46aflP6U7cwADntP
 YN4Ttr9k0CdLfxBA4S/5nT15l1fELWjXMUngcnyIzLFSkN2VB35CzMHwt9AS7wd+
 G/x93dQdFqFxMQO1DNV39POLQLKoN9Mjj84ZuiRLxV4zW4FZcPtmA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw59604a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:12:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE649v2165726; Fri, 23 Oct 2026 15:12:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfkg25cgb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69NFCVFj52166954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Oct 2026 15:12:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F51A20043;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F37120040;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
 Fri, 23 Oct 2026 15:12:31 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 57932161FB2; Fri, 23 Oct 2026 17:12:31 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>
Subject: [PATCH 2/2] MAINTAINERS: Update s390 boot reviewer
Date: Fri, 23 Oct 2026 17:12:29 +0200
Message-ID: <20261023151229.1196404-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023151229.1196404-1-farman@linux.ibm.com>
References: <20261023151229.1196404-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jjhzc-ZJen7-f2mlgaP6efYY6KWEWCat
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfXyFowTU700Vhh
 7d9HPLU4IE2B4ROQ9wbO72/Jvr7a6Dy28fNmnelzcdU9SNGRs09O6kelNFH6ch9yaZGG6l4TaO4
 xhnhQIW1hLR1D4qiGJJpqtncV230d+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1NyBTYWx0ZWRfX+Y+f2CoqXgfI
 dMwQJHdUr68u2GpfePzs8yIXnMp3LAjmefqqi4M5DfRWieJDXXM9OMh5SilWQlPnh+jn0AN9f5F
 /dQQytDRHu1rJBLJ7qQ2rQmNISvBFF/il1aXvW556WlYE9WXudtav/9f8W7vGQC93CQwKbmWYNO
 XejyEAyiaLI79zI71tiNEQtxmRTwHbU3GrLqS0xtX/+uD+oMeF9tsBbUvwOuGnBPEaf4CHj+HLL
 GxG9Ob73ru7Tv/CyvyCfQDTNRer5KKjhwOhd+CW9mGbw+w45n1WkqDw+K93X72N7uhmIxMFQUnf
 Oxrh7dBj1IFvNgNaJHvwnXScucEma2EHnEVVJ9BcuQ7NuGmxOyne0RCFIYDcX5Du5LIF1Iceq1c
 c2M3mK2e8MwRGV6cEc+r7Ht4jvhNBZML629+yKfC21ER8Kke9uJ/R/izxg0/fpcyl1oX2upYPGm
 XDHRuKYW7xToGf3Z1cQ==
X-Proofpoint-ORIG-GUID: jjhzc-ZJen7-f2mlgaP6efYY6KWEWCat
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6adb7964 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=fQ-ETlQAWqNoHmYCrFAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230057
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Josh picked up some recent fixes in this area, and offered to help
with reviews as well. Let's free up some of Jason's plate.

Thank you, both!

Cc: Jared Rossi <jrossi@linux.ibm.com>
Cc: Jason Herne <jjherne@linux.ibm.com>
Cc: Joshua Daley <jdaley@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ee1800707d..f35dfd06c22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1987,7 +1987,7 @@ S390-ccw boot
 M: Jared Rossi <jrossi@linux.ibm.com>
 R: Zhuoying Cai <zycai@linux.ibm.com>
 R: Christian Borntraeger <borntraeger@linux.ibm.com>
-R: Jason Herne <jjherne@linux.ibm.com>
+R: Joshua Daley <jdaley@linux.ibm.com>
 S: Supported
 F: hw/s390x/ipl.*
 F: hw/s390x/cert-store.[ch]
--=20
2.53.0


