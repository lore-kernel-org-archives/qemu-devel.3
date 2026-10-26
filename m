Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1827606A338
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dYeOBzEn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLIg-00083J-2B; Mon, 26 Oct 2026 10:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH4-00070R-FU; Mon, 26 Oct 2026 10:02:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH0-00018P-AG; Mon, 26 Oct 2026 10:02:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEPmR3336318; Mon, 26 Oct 2026 14:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=9pD3UfzElZjtaGhX/
 pW8fR97w+l+l0IDYd95IWSM1Ss=; b=dYeOBzEnJXuvS0SQeX4+gxcjs6GPbtuQ4
 BYUi+JogW61PIVOv/ib5VS7v7vHu/hb2iVTQ2ve055lHqFp8STtas+YOFg/cJHN4
 /mqNHNOMDJxNusedGgq1gN7YvdU4qpha5Pw/PG4eVYCp3gu3b2l6pzgBNdZeIgOX
 CzQ13BK/TcdyvbwEceE2B1XuhoP1FhLJoSiIroq4JmywZKvXYVq2tRz4999kepbs
 nlniKaw+27q7fLGNr3Qta7UgyWNSRPHPUu1J7BNWcUYSpCMu02nBlTR5ejFOQShp
 BorRIPZR6vkMJqu5ZTg4a1yVHM0b2apeuAYe79JB0/EZs3yJPi8AQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6tan7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:02:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QB4ttG1270400; Mon, 26 Oct 2026 14:01:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gp11g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:01:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE1AIF30933598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:01:10 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0537258063;
 Mon, 26 Oct 2026 14:01:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A6DE58053;
 Mon, 26 Oct 2026 14:01:57 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:01:57 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 2/6] target/s390x: mark feats dependent on deprecated feats as
 deprecated
Date: Mon, 26 Oct 2026 10:01:49 -0400
Message-ID: <20261026140153.2072253-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf5d58 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=q5U61L9vTmfSjpBbcYAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXwKLTDXBfcft1
 DapG0Z6SMvAFttt3ax+fO2t7cxHGPZUyb3T+ddVEKPHsNsErmEwVjmqOgYca+vKHm3ouOnPfh7T
 0KrGIC3ksx5TZXewqlodergUe0kNbQczdZ3k0wWeGKHWMJT3RZvJDVUq2z2lbBGqZwyFV+ihPLd
 nyS0kUzEx/e1lf8xAMcSkQW1KFdwEWtERjmOTZlsZCLC6COCfMAo0gCKA/rfU9bku+fxiigLOrc
 0SX4tRW9sDcohppFzertYW+1sGwAUQzMCgmlPnb968lDeKB7W0oci6XWdtFAGPwMJt6EVdU98x3
 9l+HzSdOlGXY1AXI31ypE8/d1hjM3p08KkFlqi1arPJ+Uw7CxI9YcK+uL8dW+8nDD0lLXmxklfA
 FlxTDiUxtorHGdPBBWGqV6cubdNYPSUKy/DhaLo32mZpPtK/0EncpiJAxalYp43AoJVETRpGNfr
 X4+MkfxrU7eNaqq+zQg==
X-Proofpoint-GUID: 6XqKTYFmTgZkmuxxaXzbKA2-w9uMKcy3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfX8Qeom+3aopeN
 YYbi4UsBm1W5ElA/+w06WtUavcM8KakvGeOvjMkNgJuV+39TGagZUvmqKa76a+8Jtg1gSZeITgV
 fKloLgD/f0tgymVwdld5frRv19ExX2M=
X-Proofpoint-ORIG-GUID: 6XqKTYFmTgZkmuxxaXzbKA2-w9uMKcy3
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Collin Walling <walling@linux.ibm.com>

There are certain CPU model features that depend on other features
that are flagged for deprecation. For example `ineff_nc_tx` depends
on the `te` deprecated feature.

If a user defines a VM with the current list of deprecated features
disabled, the following warning occurs:

	warning: 'ineff_nc_tx' requires 'te'

To alleviate this, add these "dependent features" to the deprecated
features list. This allows the user to see *all* features that should
be disabled to ensure a successful migration to a host system that
may not support certain deprecated features.

Fixes: 6e55b32d45 ("target/s390x: flag te and cte as deprecated")
Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261009185559.144750-3-walling@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/cpu_features.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 20f9947c7b..babee7f5ba 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -360,10 +360,23 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          S390_FEAT_TRANSACTIONAL_EXE
     };
     int i;
+    bool restart;
 
     for (i = 0; i < ARRAY_SIZE(feats); i++) {
         set_bit(feats[i], features);
     }
+
+    /* Mark features that depend on any deprecated feature */
+    do {
+        restart = false;
+        for (i = 0; i < s390_feat_deps_len; i++) {
+            if (test_bit(s390_feat_deps[i][1], features) &&
+                !test_and_set_bit(s390_feat_deps[i][0], features)) {
+                /* Restart in case set features have other dependencies */
+                restart = true;
+            }
+        }
+    } while (restart);
 }
 
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
-- 
2.56.0


