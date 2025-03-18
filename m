Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C3EC35FF3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueFd-0004PU-Ud; Tue, 18 Mar 2025 17:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tueFT-0004Oe-TF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:13:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1tueFS-0002gD-9C
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:13:19 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IHs3hJ014861;
 Tue, 18 Mar 2025 21:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=aQrStNSkmZQFsZ3LaSXs/3
 DaPMjgbCHs0GNigt3DWO0=; b=D1J6b05HHFywK7pOTSuUnGQuc64il93+jRQLMq
 Th29FzshGZv2zqQyEr8RN1gyCMT0asmcOpnnsoHuGXBvrj7OKse/04ZnC93gDY/W
 JJpxsRpBBhr2zvspYicDDXqERw26wu8eXFD0orVFvJT0gzNbgXuL+xYeuXC2KC9X
 4BVaAuBE5TLMA4dgzkkhmluOdAd9L6aK8tjagBqPjCrsGG+HMcg6L+AKdF1liB82
 O3IT1tpIY3OxYrKh2qH1insO93h1z8WpppZZUJ0Dbej1jtASmZivr9ow7asINdrw
 m1BQ4pj3UnU/kCkxCXn2HZ+VVRSuqzJGVDfJfjq9bpz+rDfQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwre64-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 21:13:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52ILDDHc011860
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 21:13:13 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Mar 2025 14:13:13 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <ovoshcha@redhat.com>, <farosas@suse.de>, <philmd@redhat.com>,
 <thuth@redhat.com>, <bcain@quicinc.com>, <quic_mliebel@quicinc.com>
Subject: [PATCH] Add files: a
Date: Tue, 18 Mar 2025 14:13:03 -0700
Message-ID: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 5UvNKvr3Z5zgUpgw26LpoUVdDZZc_Zyb
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67d9e1ea cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=3H110R4YSZwA:10 a=Vs1iUdzkB0EA:10 a=8NOlEqnmxsVMj69GXnwA:9
X-Proofpoint-GUID: 5UvNKvr3Z5zgUpgw26LpoUVdDZZc_Zyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 mlxlogscore=890 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180153
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

tests/functional/test_migration.py says "The test works for both
netcat-traditional and netcat-openbsd packages." But when I run it for
qemu-system-aarch64 on an Ubuntu 22.04 container with netcat-traditional
installed, I get the following error:

TAP version 13
Traceback (most recent call last):
  File "/pwd/tests/functional/test_migration.py", line 97, in test_migration_with_exec
    self.do_migrate(dest_uri, src_uri)
  File "/pwd/tests/functional/test_migration.py", line 72, in do_migrate
    self.assert_migration(source_vm, dest_vm)
  File "/pwd/tests/functional/test_migration.py", line 40, in assert_migration
    self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
AssertionError: 'failed' != 'completed'
- failed
+ completed


not ok 1 test_migration.MigrationTest.test_migration_with_exec
ok 2 test_migration.MigrationTest.test_migration_with_tcp_localhost
ok 3 test_migration.MigrationTest.test_migration_with_unix
1..3

With netcat-openbsd (the default), it runs fine. Perhaps the test is no
longer compatible with netcat-traditional?

QEMU was configured and built with:
../configure --without-default-features --target-list=aarch64-softmmu

Thanks,
Matheus

