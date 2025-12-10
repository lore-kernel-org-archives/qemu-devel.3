Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52B0D3C526
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLJ8-0004dR-RU; Wed, 10 Dec 2025 09:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vTLIx-0004cy-MA
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:36:37 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vTLIu-0001Br-QK
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:36:34 -0500
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
 by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BA7uqTQ998799; Wed, 10 Dec 2025 14:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=jan2016.eng; bh=lsIXzLo2PzJ3gSYLcj25NwZo5PGiUMzTY
 1IvUxtMXsM=; b=UF2/FaZ0URnh9s6zlDwerpXqFKlN4kDOkWdfYoSSunRo5DE5o
 wsznnZHubznHO2FpGyduuGWbeHvBNFqqZhlaVZRBC4QEtrGztVAsN0ftPSefT0a0
 mi7VsI2dXoU9qa5RlCUxQXlmebWcL/jD0aRr4SLu9tNY0P9GALsxSKCz+jStgZVc
 gooTaOUg08YitIWE1idhRQ2vbWEvrK9lwZdYAraGRvxImUrMce4/aDPM0LuOaIBL
 zz8au8hUXKe7vl+fEebqSLf/B/BqVwl5zlxl3e4xd+ulV/amWDDLHQIUcFQaQrLM
 V2U1YLmq3RGYr5XnvOgtQ40To1jpZ94Ju6a6Q==
Received: from prod-mail-ppoint4
 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be
 forged))
 by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4axpeqhh07-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 14:36:27 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
 by prod-mail-ppoint4.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5BAE6jHg012474; Wed, 10 Dec 2025 09:36:27 -0500
Received: from prod-mail-relay03.akamai.com ([172.27.164.88])
 by prod-mail-ppoint4.akamai.com (PPS) with ESMTP id 4avgq1gp7t-1;
 Wed, 10 Dec 2025 09:36:27 -0500
Received: from bos-lhvkhf.bos01.corp.akamai.com
 (bos-lhvkhf.bos01.corp.akamai.com [172.28.40.75])
 by prod-mail-relay03.akamai.com (Postfix) with ESMTP id ADD6620D;
 Wed, 10 Dec 2025 14:36:26 +0000 (UTC)
From: Ben Chaney <bchaney@akamai.com>
To: qemu-devel@nongnu.org, clg@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, mark.kanda@oracle.com,
 bchaney@akamai.com
Subject: [PATCH] MAINTAINERS: Update reviewers for CPR
Date: Wed, 10 Dec 2025 09:36:23 -0500
Message-Id: <20251210143624.416697-1-bchaney@akamai.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512100118
X-Proofpoint-GUID: 9o3KZNOrmaqRx4JTEDoa0PjHHfDbW9lj
X-Proofpoint-ORIG-GUID: 9o3KZNOrmaqRx4JTEDoa0PjHHfDbW9lj
X-Authority-Analysis: v=2.4 cv=frzRpV4f c=1 sm=1 tr=0 ts=6939856c cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=X7Ea-ya5AAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDExOCBTYWx0ZWRfX7rBwbR4ozgdc
 TdFKlCAZFxQauZYVA/XAytG3kUQysynLiRQX5DFsoFgxoqZPb2a2xvuyI69ew/Ok8WgjlSTA5L2
 JtoxWH01kmWE2ztcxnOhfkiJaA+QHk7nHzNtWpmeMm2HFzFjyQM0p+ewdJFYTSJ5KlpQXQlXgu/
 i46bvKcfQ7DKFKPAqPQkNqXaue6WAh2hAgf+J9HH66S3TxAKiQF/ogCRw6H463jHLXCvyB70K8g
 eL9k/va13A8a+BBbHsQTHUUKuMndiZ24ePz3XKKviPpUtpmP0DdrzUX4aWIN3puKUVDU1y1I/Fi
 0iQx9n0DjnJG9wf2eLW0hapyNnRllqv/mVJGVy62Y1SaNmwVg5GWcYw/b4YwQjz7Tngd67FIyrH
 31p2U4sv87L2U+wdcoe6U9u2zzU8YA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_01,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100118
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Ben Chaney <bchaney@akamai.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..dc6235e174 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3118,6 +3118,8 @@ T: git https://gitlab.com/vsementsov/qemu.git block
 CheckPoint and Restart (CPR)
 R: Peter Xu <peterx@redhat.com>
 R: Fabiano Rosas <farosas@suse.de>
+R: Mark Kanda <mark.kanda@oracle.com>
+R: Ben Chaney <bchaney@akamai.com>
 S: Supported
 F: hw/vfio/cpr*
 F: include/hw/vfio/vfio-cpr.h
-- 
2.34.1


