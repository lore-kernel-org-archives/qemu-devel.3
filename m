Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E2606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=az5IfNlL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP08I-00010A-18; Thu, 05 Nov 2026 11:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP087-0000xY-Oe; Thu, 05 Nov 2026 11:15:59 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP085-0007Lh-UM; Thu, 05 Nov 2026 11:15:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSwQjjQZdmh9TXTMQiRlFSRjxWn9MK6d02U62IDFAIo3IHdOQ6EwItyuO1t0B8giVcZh1zQvglMAfNOzBoo5hOdPCFet4+11lsXNHs7dei8Ii9lkxoYOpv0SA/o3aqpEpNhUyHzVO6N+JNgbX7eqh181pqK0RCMotI5EiM6dLwWFURhvkE6HfwOmcvraJWqeKE36cqmWBm7T698S52Ff+91lM9HT+KanIkvSvKZFHaRxTMe5SHBGkU15gr6XNqJzdPhkSF+R2ji0hVFwxZGu+3oaDY8ZYzRmar+Xw1tOnsjEqusOMlGes5GaWQ3imwYGBizSGgNFAmEm5BWTWwMInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouB24UZomtz+kGTRSDAy+uQ42smV9GwROMobXjeANws=;
 b=JXbueCmQsICvW1YPfyh1P7WwIJHm0HSDI3+RZVlKcW8SQo2dtI6FfA8N7Kdzuomk8RuL686fGvwOm7Lk4nPBwJRSTEJlMkhjQGZ6fkyZHMN+cwl55Gw97bhwE6qpiHu2uMA7WbytD1FvVoLWQ7KtWKPJ0AEhLvWtlCRRrZj4qg3c+dppQhdrWfAxuCO3QFuJEKl0uDyGPIOTVXjUR7NyVNhN5lq5LgfTV5vrZLnoFI679Wcx4rK8xq/n9bFZOjSlbr6hy2OAX0DpQt5UcOIvvflXXZeV2K4xmlS/XfKgfgtOnf/R7snYX4xYQbiDFWJTeCnPSsWNT6G3V3NEjPybZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouB24UZomtz+kGTRSDAy+uQ42smV9GwROMobXjeANws=;
 b=az5IfNlLzcXh7DR81ymMUqOIFzku0hti7aIfxIZ+I60YVcuL1/4S5PV0I6G/mXFw3c/mPY+c3VE8VsYjrcfHFB0cX2Cu777TNkyj7O1H6RIMrLLgIU9XjJTPLf7RoeptuSAO6qVRDYzdkJJPh28S9DrpBo3Q/ZDbeI7r1VeF97IWRYwzcHDp8ZtBrs8XPs2lNrvN+JUj58WbSeGtblWBMAVADDD8wbVPxcC6LfPWlb10PNLOcL1umbfMA2B+Lc/Iu8jf/JVG1XGMCxJl//5huinNIasg7ok9vZbMpiTm/5IVsmVy3LdX6dq2HNMEZU/1MhkHRcJmYKwY71Egyzpd9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MRWPR08MB11805.eurprd08.prod.outlook.com
 (2603:10a6:501:9a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:15:47 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:15:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 3/3] iotests/290: add 'discard' and 'write -z -u' case with
 a snapshot
Date: Thu,  5 Nov 2026 18:15:15 +0200
Message-ID: <20261105161515.794213-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
References: <20261105161515.794213-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0182.eurprd09.prod.outlook.com
 (2603:10a6:800:120::36) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MRWPR08MB11805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d73229b-0044-48ac-078e-08df3b580c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|3023799007|56012099006|261026121527099003|261022115727099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|38350700014;
X-Microsoft-Antispam-Message-Info: NzgEfRvI1RAckZldnfSQuI4vtB2hqjABF3soYi9+Y2NQ+5sbuz93Eb6ZkcsAapoFxnYP0ct7Td0ZrLd/QNqzM88W+StwEVUWLxjinvRtwkOt0cOGbqskBYkwOkOdFY8qms2xbAUuS+Cibf35FaRfblqZ1Ew04G1V2H9U5pCSk7csjNQ6KIzj6vz2HjETdRn/i7rXhUgvjr87SGUYrFGvFXF3NBoVxau6NrOiQqotT5gQHjJQ/uXu2WGXir8r9r312TCVZ8Xt3wE9UDWHiQYYdd4j7Vg5tdtyyAJXHxj2UeJ/fTkkFxXBy0uoI5zLfnPqGinVCgjafTYdCzDsZJue0a5bDS634Sy/7h6UIPheMcA+yEz+Nq6E+XonfNyYxhp0R9oiB4k6ozXfTeoNE5AEDT+Uepbyi2CzcoebsUP785vwqrAHTT6o1cMZKXt9abuCb+p9+q04b36YfIe5NSxoEd7/IFO1ez4Jsn5s/LBri1HGpvLgMB96WiOwA9jZ1fWhjm71nuiRXLAPnGqBUv4Usslg8DLl9nech+861Eutsz9zZki/a2o/nOUUvfcrtj5UVckNk99jgbh7oPxq4fVO0Ac5TSfpB6CSBo+++KvYPE0Q45YSZeMNBCi16MjWkv52ks1OGiyDfl9deAk5btdDIgF6YZP31pmHYbWwPnj/rPGbnLZJD0irFHefDcALVM9KIRbo//8wpqcWF6piu0PYOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(261026121527099003)(261022115727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfBD9cZnJZ8zy1T0mg3YB419lyDxGBMKT5QsflDzRlnhHfhxu3PutLbyCYq1?=
 =?us-ascii?Q?5XUeqEDFrqSQqPY7wdvGa84nXAaagp621MSdYxqgyZHrcouw9uGKGvvi6hk7?=
 =?us-ascii?Q?FSVXaim8qsuLJUgF2Q4pOYqNYjPjKjhZrvyx8TuNtMSgk1HX3C/lV/fD5EAQ?=
 =?us-ascii?Q?mXq/xGZZ3AFBUE8uWOQiQG5M3TFMONqmVbkjjvH+klOgbNRs2kk913/Z5wHl?=
 =?us-ascii?Q?rNu+QTr+9QusQXZUJyV8t7xWUEe/yVOA8bqxeMw2uZlL+VRWx2neoRPsfUIH?=
 =?us-ascii?Q?ypQoorYhgf2NgSLfPoRLVxdgWdICm549oYD4brf1/+hhE+WgODKxxCKIJ9D+?=
 =?us-ascii?Q?dokdFBWjUgk/rKR5mawS8U7i/08DavVfeqK3BC0KCFF96fFbqmNlXLQ4KUMv?=
 =?us-ascii?Q?7bZIx0ba5VPNONo0jFsMH06a9owGyZjsLlToywVqMIlrLaD42QERQ9tgMPj7?=
 =?us-ascii?Q?/LzNQYppKt9Cl75n+P7wdhfoGT19oIT8dCfE+QxoCRmb54qafUjnhNBHeJV8?=
 =?us-ascii?Q?00g9Cg2VkUVeYiFyWCajyAML7wVTZEQhL4cJ7ZYnBZ2EXOQkURiblCeimbIY?=
 =?us-ascii?Q?TlLX6fBmLU0wGBrzSPxPFdq7D7AlwRuPHyraMLDYOPIRsYlhGpGkSr+yGdn/?=
 =?us-ascii?Q?DnN16U6mmZiaylVKHa/nv2QWMjte7XXA0eCZQ2wfxJ4zroVIT8Mpup1Y4qJX?=
 =?us-ascii?Q?S3lz3GBRJ7o3DnuKVgGkUktC+WA6PpX48eUcxVKGphkf9DA+qLFTjKiU+4SV?=
 =?us-ascii?Q?Y2rmg4qGHhdXAUrqsKbxKjY6M/kkXEVEKsLPUFW7AZ7yLqIWd1+1aA+zZMTL?=
 =?us-ascii?Q?gqzSlOPis5erCnj9gnsQzXuey7MQuAf2oq8aBNG1k3vHwwAjAIkygtzCJyBY?=
 =?us-ascii?Q?hQjxOEhjSYECLBUEQjeoJd+l/XjXQDKUUBMhvbpzejtEHl+a3Jqx42U8dRBG?=
 =?us-ascii?Q?N4oy4RAurpJsF4LHqnk7rrHwygczHJMAliM0MnwiLZtLjXx3qryx5wQu36kD?=
 =?us-ascii?Q?h9hF6fltWVPdhzx4oGaRJ9UxzN1cXSvrr2SWqBatu3wf40PbrxQC7L5mxXrz?=
 =?us-ascii?Q?udqa5fq0OYSZWKJEccS6HW3QsacJRB3Fm70J/4+wsFwg6WS17AcR8Ol7KFMc?=
 =?us-ascii?Q?fcDpV7Mgnx041M3dA/v2c5xfp3WpjEOekI+FWgAWOvW3XhgKoI4cg4gG3apK?=
 =?us-ascii?Q?Is7Wp5s1+Ya5t+hgQfEKwrwMTCv6MTsKmcwLpc6zWSzf1djGqZ/jJBoOYKsY?=
 =?us-ascii?Q?Cr5cYoX0+LNHsM8JhX+Nw5lI6JH/m6BErSrxvCZcxEG4FcUj4ph3NOrbzNQT?=
 =?us-ascii?Q?YS1oxsub99OC+P5LfCyJo9OfesYH6fYXEGSbymrMpcYNFgRTvoAhP+Yf6NX1?=
 =?us-ascii?Q?gKDLoGd1r1vqtrDbAU6L7WQl65cmBu3+0KyUExwtecuUYbbfl/JdgNFEVr5l?=
 =?us-ascii?Q?+LolUp6emdA6kg8sSCUQpBUJcvjk/wLIWyPi5GsD+hOmZXehf9ehBvCRJ14E?=
 =?us-ascii?Q?yOtUIVDvFJo79JRM3PiF5ACTQ+YMh7GAoRb9LmECiAlXVvG8Fsk8wv4R6Y6y?=
 =?us-ascii?Q?3VFycsilnDpfp7e7XP5EDcxu3v0X9gf1FlKbPUQFkMVKns1FHRObJfIoWVLo?=
 =?us-ascii?Q?Y9hzpDfBrAr+BcGXflQU+f9AaI2iPmduUODTf/LCchITV483W0POB+EPOnAV?=
 =?us-ascii?Q?R//R0sU47OT4xEEkIQDT8+FT42TYEsMhfZoIqgeCukF29XBXBbpWg1L12cfN?=
 =?us-ascii?Q?eOTQcQmYqsIl4eteEHzVUu4rsGu20kM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d73229b-0044-48ac-078e-08df3b580c9b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:15:46.5474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUphaihaKaFaPlxkDR548O7Wu6PkK1Y0lcZum7QcuU+aHvYpSu6QzRBbhcrOkqTXur7uGjzOpNIPXXoTG1jv+Atrzaapr7UPtYv4a1+qHRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11805
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Before the previous commit, issuing 'discard' and 'write -z -u'
operations with discard-no-unref=on option enabled led to data
corruption.  Add a test to cover this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/290     | 16 ++++++++++++++++
 tests/qemu-iotests/290.out |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index cf4ff6c2bac..b9a71b0cee4 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -128,6 +128,22 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
 echo "# Output of qemu-img map for the image with kept reference"
 $QEMU_IMG map --output=json "$NOUNREF_IMG" | _filter_qemu_img_map
 
+echo
+echo "### Discard with 'discard-no-unref' on a cluster shared with a snapshot"
+echo
+
+_make_test_img 128k
+$QEMU_IO -c 'write -q -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -c snap "$TEST_IMG"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT \
+$QEMU_IO -c 'discard -q 0 64k' -c 'write -q -z -u 64k 64k' --image-opts \
+         "driver=$IMGFMT,file.filename=$TEST_IMG,discard-no-unref=on" \
+         | _filter_qemu_io
+$QEMU_IO -c 'read -q -P 0 0 128k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -a snap "$TEST_IMG"
+$QEMU_IO -c 'read -q -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
+_check_test_img
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index d8f8d5ff493..264fbcb28ca 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -86,4 +86,9 @@ Images are identical.
 # Output of qemu-img map for the image with kept reference
 [{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
 { "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
+
+### Discard with 'discard-no-unref' on a cluster shared with a snapshot
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+No errors were found on the image.
 *** done
-- 
2.47.1


