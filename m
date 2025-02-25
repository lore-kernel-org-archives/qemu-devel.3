Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7C8C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 06:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmoea-000372-KA; Tue, 25 Feb 2025 01:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tmoeZ-00034z-6S
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:42:51 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tmoeW-0002cJ-GD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 01:42:50 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250225064244epoutp015cabad18d29d7d10889c94594e535cc6~nYGRI3LWt1074710747epoutp01l
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:42:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250225064244epoutp015cabad18d29d7d10889c94594e535cc6~nYGRI3LWt1074710747epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1740465764;
 bh=jZMWt0qVM0Z5I3Y7XzuI6Y5sbl2PVdpMrEGtETZLJPw=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=M0xGgbeOeaA6dGD25l8vZCngomwl3NYUyy1Qlu7G7x/W/Iaxxkq2Yt5ivDX09NO18
 4MYOam80LUbuUMBAdNsLAgY3d8wOsbEj3X3yHabrGWkNqXCHxz0zdcnSkoaCPySAK0
 5y4ZrPneDCyduTCpK4jshjpyCgNPQrFS6iEEhsdY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20250225064244epcas2p1ade7de4224dc563d508f671aaa79f29c~nYGQeI4HY2126821268epcas2p1v;
 Tue, 25 Feb 2025 06:42:44 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Z27MR27bTz4x9Q3; Tue, 25 Feb
 2025 06:42:43 +0000 (GMT)
X-AuditID: b6c32a48-e7eec7000000564e-25-67bd66634db4
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.4B.22094.3666DB76; Tue, 25 Feb 2025 15:42:43 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 2/2] tests/qtest/ufs-test: Add test code for the temperature
 feature
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, Keoseong Park <keosung.park@samsung.com>, Jinyoung
 Choi <j-young.choi@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250225064243epcms2p8b7b59e7bf381bd68d30a6f59b40dea9f@epcms2p8>
Date: Tue, 25 Feb 2025 15:42:43 +0900
X-CMS-MailID: 20250225064243epcms2p8b7b59e7bf381bd68d30a6f59b40dea9f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmmW5y2t50g6/n+CxeHtK0eP1iObPF
 g7v9jBa9/VvZLO5vvcZocfzkO0aLJRdTLT41SFns3/aP1WLWu3Y2i+O9O1gcuD2eXNvM5PF+
 31U2j74tqxg9Np+uDmCJyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
 tVVy8QnQdcvMATpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgXqBXnJhbXJqX
 rpeXWmJlaGBgZApUmJCd0TBJveCZYMXZNddYGxgf8XYxcnJICJhIbJxyhq2LkYtDSGAHo8TF
 i1OYuxg5OHgFBCX+7hAGqREWCJO4vLSLEcQWElCS6Fq4lRkibiCxbvoeMJtNQE9iyu87jCBz
 RAR+MEo07bzDBOIwC+xhlJjQeYQRYhuvxIz2pywQtrTE9uVbweKcAn4Sf2c3QcU1JH4s62WG
 sEUlbq5+yw5jvz82H2qOiETrvbNQNYISD37uZgQ5WkJAUuL9VUWIcL1E6/tT7CA3SAhMYJRo
 PPYHao6+xLWOjSwQT/pKNHytAwmzCKhKnPj2gw2ixEXiyJW9rCA2s4C8xPa3c8BhwiygKbF+
 lz7EJmWJI7dYICr4JDoO/2WHebBh42+s7B3znjBB2GoSjxZsYZ3AqDwLEdCzkOyahbBrASPz
 Kkax1ILi3PTUYqMCE3jUJufnbmIEp00tjx2Ms99+0DvEyMTBeIhRgoNZSYSXM3NPuhBvSmJl
 VWpRfnxRaU5q8SFGU6AvJzJLiSbnAxN3Xkm8oYmlgYmZmaG5kamBuZI4b/WOlnQhgfTEktTs
 1NSC1CKYPiYOTqkGpmnHhS7oRNmp/Lq152NDa9K0T/NepUzfF+Ubqh1obiB/ciMro8Cpe5x3
 Xfd7xLCV7I3uCI3weF1WrvB+h3XckY1LrtceOCicXsLem6cw427EO7U1R9/tLd80zaVAXNdR
 msf/zbzrv8t+vRVf9OuZt3fFx5Pn5FJrPG5PtZVRzdobNZ2p41V53L1PB0KX2c16vzB587To
 P0c7Nq07UGipLKBtFVe5JuG04SX7nRdF/KWDZ22xzWKa+trGpCQyVexCn2H8JS8G35bdJkuc
 vdU6DOY9//HL2Pb6n+Du73o9C/k+nXJYmLDh9aUuxwmHbTpzM8sDNDRFk8RFnl8sm6Cf26XH
 /ZY5LOOrYGT27UpPJZbijERDLeai4kQAfNE+ViQEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8
References: <20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
 <CGME20250225064001epcms2p81497a6cf84a0c06e54cbce0360053bf8@epcms2p8>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=keosung.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds tests to verify the correctness of query attribute
results related to the temperature feature. It ensures that querying
temperature attributes returns expected values.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 tests/qtest/ufs-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index d5076bdeb5..4867ccf08a 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -784,6 +784,30 @@ static void ufstest_query_attr_request(void *obj, void *data,
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_CASE_ROUGH_TEMP, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_HIGH_TEMP_BOUND, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(160));
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_LOW_TEMP_BOUND, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(60));
+
     /* Write Writable Attributes & Read Again */
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.25.1


