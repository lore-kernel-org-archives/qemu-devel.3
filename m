Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3F9CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 14:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbri-0001E1-84; Fri, 19 Sep 2025 10:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbrC-0000Yy-7i
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uzbqz-0007WG-Bo
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 10:13:00 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDuSkG018787;
 Fri, 19 Sep 2025 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=iSkBmVyrzvdeS7/ZCn59L1EbTtbtoN3x8q49RKreKkE=; b=
 Xi7P+zeW4KNCuexn3KDbIcKj8wFD4qMjXkW+F9bXiVwcfpyaLMcSiBqiogtyugIy
 2i8hioQ8eZ/WlFtMDmlEtCUfVVNBgnpERPfeLpHenedlpXtLRLTyeHK6gvW3UAOE
 tOPme/Nhn8rAC+dfiujDJJHqwFePqbzpTBDWx4lfj+mxV5AMCI/Jf1T9Yyw2kNoU
 6J3UV8RLleH1iyBipWVmDJhyObN9/dvVVBTHR73kY7RbD/iaq4wF7ZPcpnt2dijl
 p7yhLJ6u93yqY5ujRjTSPsIUKuKFKx3IkWT88vPXvILAx7Nhj4Azev511iWolp3Q
 fCV9xMG4drONEkzmkkTdFw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9wpqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JCujDQ035132; Fri, 19 Sep 2025 14:12:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2pu96q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 14:12:43 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JECYXH003357;
 Fri, 19 Sep 2025 14:12:42 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 494y2pu924-9; Fri, 19 Sep 2025 14:12:42 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 08/11] migration-test: misc exports
Date: Fri, 19 Sep 2025 07:12:30 -0700
Message-Id: <1758291153-349744-9-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190132
X-Proofpoint-ORIG-GUID: X0Od870uIzKGpWOXA4cSYI2qsySrRwiE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX0mw/OhepBEvO
 kWvexzx/VRHRe1VFhF7Lv2+Dp2sClHsyAPbd4pG1BkTeqjlLbFg8kcjKhWORj0wztgKWJIufoDf
 8cu+PbLGHGNrGqx1kEvYBhYH++B4miVKDoxP4cWMmSWdpmDGCVGynrA6PUWc27MtqYoASFBBnr2
 xBmiefq27Wj4Gn0R2iDhAsJoxv5AbPen/u4ikXzhQCyhiCLC6N1+wiC0e3Zayjhsmg412nXKpgE
 ehREEzyuFaDcpE0yHeYhRiA8R0dG1gasXxPLbOShwn680Rqwdi70artewbuKBSkN89A0/Ig6nMK
 SjzxIjx/GvKJiLAZh13PTBm06qtb4QmQQA3sZqryLu64fpxAo5xISRoDE90WM84NDZ1KejxPu1I
 n1r1x57pTLnIkn6xj8dmguWu2uQ0YA==
X-Proofpoint-GUID: X0Od870uIzKGpWOXA4cSYI2qsySrRwiE
X-Authority-Analysis: v=2.4 cv=C7vpyRP+ c=1 sm=1 tr=0 ts=68cd64dc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=ON8abKIKo2PTab2e5BMA:9 cc=ntf
 awl=host:13614
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Export misc definitions needed by the cpr-exec test.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration/bootfile.h  | 1 +
 tests/qtest/migration/framework.h | 4 ++++
 tests/qtest/migration/bootfile.c  | 5 +++++
 tests/qtest/migration/framework.c | 7 +++++--
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration/bootfile.h b/tests/qtest/migration/bootfile.h
index 6d6a673..96e784b 100644
--- a/tests/qtest/migration/bootfile.h
+++ b/tests/qtest/migration/bootfile.h
@@ -35,5 +35,6 @@
 
 void bootfile_delete(void);
 char *bootfile_create(const char *arch, const char *dir, bool suspend_me);
+char *bootfile_get(void);
 
 #endif /* BOOTFILE_H */
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index f1bb9d4..7ff3187 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -18,6 +18,9 @@
 #define FILE_TEST_OFFSET 0x1000
 #define FILE_TEST_MARKER 'X'
 
+#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
+#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+
 typedef struct MigrationTestEnv {
     bool has_kvm;
     bool has_tcg;
@@ -237,6 +240,7 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
 
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
+QTestMigrationState *get_dst(void);
 
 #ifdef CONFIG_GNUTLS
 void migration_test_add_tls(MigrationTestEnv *env);
diff --git a/tests/qtest/migration/bootfile.c b/tests/qtest/migration/bootfile.c
index fac059d..479c432 100644
--- a/tests/qtest/migration/bootfile.c
+++ b/tests/qtest/migration/bootfile.c
@@ -68,3 +68,8 @@ char *bootfile_create(const char *arch, const char *dir, bool suspend_me)
 
     return bootpath;
 }
+
+char *bootfile_get(void)
+{
+    return bootpath;
+}
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9d04f36..8f9e359 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -28,8 +28,6 @@
 
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
-#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
-#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 #define MULTIFD_TEST_CHANNELS 4
 
 unsigned start_address;
@@ -1005,6 +1003,11 @@ QTestMigrationState *get_src(void)
     return &src_state;
 }
 
+QTestMigrationState *get_dst(void)
+{
+    return &dst_state;
+}
+
 MigrationTestEnv *migration_get_env(void)
 {
     static MigrationTestEnv *env;
-- 
1.8.3.1


