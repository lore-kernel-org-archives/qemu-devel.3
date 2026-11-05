Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B5606A329
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=MkDPA0m1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP08H-0000zi-28; Thu, 05 Nov 2026 11:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP083-0000wi-4w; Thu, 05 Nov 2026 11:15:55 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xP07z-0007Lh-Nh; Thu, 05 Nov 2026 11:15:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn3Tksd/5IMkg5mXcUJmofa2aTSA6RckND0ojP0jhdjQqoN6rYZS5gIxhetaI2dAraZYksL10yaZj6qrjBvdpSrbdnJDpTi+fucIIcwE79Tj0V+VPKvJU+SOka9vkusJyOEBhywNpIdv76r05QH7ZO+QpPzj0J5jvGbrUEuLhap1J8ZLc/vkgoSHKbqwoY5eoAE6Ts8ESaTRoSk0YT44GvCMIvXSb9pZo1fV5xymdbJ4pH1bJHABbKHVI6yhTYdPpUXZv2fJh6g14Z0x0QmmK7tnrDVvMHzRG2ohxtyfhV8R2wivZ95WIq5ItfoC9RfAsPatosu06S+SondlR3eW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARGPcUFmn8zky0NeeI4Vs9NcXbxpW+/byyJgZwpyvEM=;
 b=uKaftGHcUhPLzgy6KDknKHvMZxIoFx0dSK8MvJ5yowL/Mfk/AbFf6GQyuEp+Q7/UlKkw8y1KEOGxC7spSJIYa3x7g3paqPicChqoMd5mhLPKdYXMZ+0S8JrtVGs/AEIJ4QSqUznoaYccFlcHHa38ekmzIMn15SDtZJTYxtrD05NUjqFHF3UAn3WYgsNsaINMeRHOW0K1mzYDBIUgt+ICNuwJaFLjrqqcVoABWWFSdiua05t5WDsFmbK5y7wv4+RVA2G5HOeS3ihjl+4QD1tyNxqGH5RZQ79F0FZe92oc5J/9vFkr54Yt6IaJyLhW4b6ztysO/9vr4Htfmbxp5AOerg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARGPcUFmn8zky0NeeI4Vs9NcXbxpW+/byyJgZwpyvEM=;
 b=MkDPA0m1LrCynoYe0M8xKaLui9uAwpgukXKZdt89UV2OGMRyy3Q5RKwxqlGEXpMvH7Ay2+NDhLjWn3sLmiL1E+1RGM5+Fmo3SdVtLICBuQJfRY06cFdBlOz42ACXdKp5iZvMPfJhUDvjhC6eUyyjEDeDmjDZ2mJrD9/P7S+PhMLixguW2Ue8mOBzQClOG5yAcev9gnYBw5cWb1/8h4S7kR52lDCr+By2Efy/OPiPX0xEhLJ6BTALtXle6A8rLcT+0/cJBEtSC3+hwYWt4gg80MPNT+OnZ1GWoB6MoVwekpzyaFTosX6bAa528Kyt4B08L0S9i8eseLQJqh9BpVRQ/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MRWPR08MB11805.eurprd08.prod.outlook.com
 (2603:10a6:501:9a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:15:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:15:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 1/3] iotests/290: add test case to check 'discard-no-unref'
 option behavior
Date: Thu,  5 Nov 2026 18:15:13 +0200
Message-ID: <20261105161515.794213-2-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e149ec4-9bb7-411a-d0b8-08df3b580c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|376014|366016|1800799024|18002099003|22082099003|10067099003|3023799007|56012099006|261026121527099003|261022115727099003|261028144727099003|261021121427099003|261026140227099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|38350700014;
X-Microsoft-Antispam-Message-Info: ePPRy1/mjCvkcdqipynYwVlIxCa+19VdwMgvKecYs07pIUC67T/u3ohuCuH22JnejjUZSXDZ7KGcAnBWrm9Bolzukkc/8Rq5diiV5Ur/Dy28lzAUXuWWZyQBCyvKuHBrdjHWIk1dabrV1hKJS2m9vdNjDQQqHPlDXr1AdqMXlUsXmzAIgS3GzWGqzrIfuPvDhmtVXpcYnlIHPr0UORWLp1fE/8oSEa794z4i89TMqk618RvdnwdDTiU47i2RhgXaj+8ApqmBEirdStI4XGZ6oUdioTfVlwfq3gIuqxljWCtrG3joTyJZX3xuX+2c7BqWczCBj3vrZ9rFXQgpGdLmS8TEmBGqMVJ5hGlxnTUIW5JslbKm+I2h42M9vNHvDw6FjX3284pEiBJNf7vsYr4JZ/4VLSF9LM8WAO/Wj8RL5QpaWOCge2QWaKrEeLCznQrQThgaWjnDYkbaoiWgGHkBXWX/ifidpvHx7B3w7KBCz1mN971Zrl65GKmuskPJjWZb86tmm104DB+TNBlCLTwEe0QyG2nbx/gyEwAViSOob1KKroLykbHgq1p18cRxsNNRNZI6kD7YRra7A50SnvRT1EEXpIjc6KCvdv8WPwPDdt3vWlc5dqcifeqdexIiYwDwHyhdzSdITyceaPIPGzT0vixaFupbbEyjtcRmWkIJW42cVoW6SBcZP1ZHMu3c79OMAMcSHLYkMTJjMlu3Mc6g+4w9kBv5JDOErXoc6N9lljw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(261026121527099003)(261022115727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GDvdblwnjF68Sf2It7o6C1t+34rPA8wfKPVdbmT6n4fOfo9TGlkPNtMu0opx?=
 =?us-ascii?Q?PoLhDVEDJF6i4OjuEDSM2N30U7usa2//KJ/wXg6zwMJGu08W5yxsbRbuzch9?=
 =?us-ascii?Q?4YNQTr/14N2E0Yc9W4mcVClpQd2IHRBE5tHlHQQs0SwTwCPjWL6+hnLSNeg4?=
 =?us-ascii?Q?uJb8VFOxYzcC1aojM7EvcBVU36/XJyZKxxb4O87H12hjgMXbnSqDC+d+zKOD?=
 =?us-ascii?Q?Vb+eR31JWFi/RqCswd0jPkKiQQq6au6S0YHfItEObYbrfsOSzaFUdNyppy2w?=
 =?us-ascii?Q?M1NL6Rr4D9n5UBafklo8+3QFLyOlF6Y3SDfJVP6Y2vILnnbh859ID5x/bQCa?=
 =?us-ascii?Q?RB/8acwdah2cyOEYK/VwmHwZFbIoAepUZIuZVUbTeuzO0NZiWzqexdGd7HGC?=
 =?us-ascii?Q?lbFEtZNP+SfqXBVn+5tDs2+M9lXIEgvRIvKtIyNKaASaeNBAg2VrQOBHuObd?=
 =?us-ascii?Q?asdTQdgJIL2T/gyLkLMV3tmTZ2uvFeCPiNc5RcK6OhUHaOR3C4mLB7qxdnW8?=
 =?us-ascii?Q?vHevC2/s6+Iqf1QzVu/QM522/k5kjbjBlZm36TOBMg0+wHBkuQVUKEGgQ5HF?=
 =?us-ascii?Q?5NJfbqAVmobh4IKkil+Qzl5Tkf7ME6hdaUbvgjN/BOC4LfXtV79epPZFSYVO?=
 =?us-ascii?Q?OeO4pTnDUcfZGZI2mj6MJoxfYcP055rViDvvdOmFHgGECpB2R8pTwlEs6b2Y?=
 =?us-ascii?Q?E6/Ft5vZ9wW5cUjfrYUXXVrtdNZ7IF/dA+PIryibczhZM+cf5jF7Wrk0pq0O?=
 =?us-ascii?Q?kaiPf6g1iLs4LXcvUDqgiEGY9R+o0QkbA4qQBZvOI+uMlAHSB2Q8a143KYoX?=
 =?us-ascii?Q?Jt2CMV9wTVvYvMr5UI8+FS6bZf5lQDWVNgoqZuF7m4DT+PcX4FNSUdUZBJEa?=
 =?us-ascii?Q?yHOjo1Lg0c84R+JX9Pvr9bbpH+VN6ppnd+PxfZx6BL+/o6yYXbQGy6f/8arH?=
 =?us-ascii?Q?gWhtg9ji2FNE0jqq/Zep8o5n/ND5PsKR+re5eZcfk5lGL60L1caY6d0RLFeX?=
 =?us-ascii?Q?mFnsqk8CcN07i8l6T7Gpo3mvJk2TKUYoaIlgYY/M0STPZTgd9M7HUlYmEcro?=
 =?us-ascii?Q?fwpFCqQe52CDEMS3Bc/Q6ZCXuZ1H/hho+olsZJ2vDDNks29SsdcXJFd3S3Ut?=
 =?us-ascii?Q?v67DioAB+VDA0xLkzjnCVtQSxb44OpmWiATi35t9/kXrJvM2V1bAtZUUxIzl?=
 =?us-ascii?Q?j+nTw2vHcMPQtw8ozFgCRGJo+DO85iJ/OGpbbDWi0D+A8i5spCq+oepnLSIF?=
 =?us-ascii?Q?rq+p2iiOqTYaNpQ42/5spCPxmV3Jd07k+ZoClvK6PhU6y0BTasR4xoFH1FKD?=
 =?us-ascii?Q?FX19nflLC5une0O5mcfhPR81HJfHeFwwbNB28/okEcQA1ABFoEWTKS8etbPQ?=
 =?us-ascii?Q?Ee8hU7U8OFK99NziLRbUNbQYiIPk2P5PghBTgJ4g3eORPwtS/F3DXbmlJCma?=
 =?us-ascii?Q?EZ8nCxZQSjwfmR+qOji1ivHrMrxa3G12N8OzClOoqTueYLqCyWtvg24VIhij?=
 =?us-ascii?Q?NRSp/1IxzkjZNq9SsIrqakoxP/MHZ9ay2XGAXlav6Pv/wH1okkuR5dOu4wjA?=
 =?us-ascii?Q?wTcEnFKMTy/HkWQHUF4T8QMg5TB72z50h+JO1mjIVJdctQBoiMZHPesWF/+4?=
 =?us-ascii?Q?/kgnlr1XsezxM+gmJbYZuurgEg+skZK9RomdKouipQZvmRs0Y+Af1pQmMkzb?=
 =?us-ascii?Q?eU5OVKJuN/09s7i4HS1GpiycVJU9T+r5lnsTr0N62GbMbCfbWPWDeT+9kvlC?=
 =?us-ascii?Q?EkhotmCIyUJ7x0FO1MKAeNHCPyuIxAM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e149ec4-9bb7-411a-d0b8-08df3b580c1b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:15:45.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21vofzSvxFuWO2ET1PIVdUFJ3CbYSdfuW2zBnTRcB/q/PaEIf7OaDBZizBZkSGVZswD1HKiO9QJLufvlulcsLSk0KYdYdwtIl8cu5FEFHvk=
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

We basically fill 2 images with identical data and perform discard
operations with and without 'discard-no-unref' enabled.  Then we check
that images still read identically, that their disk usage is the same
(i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
both) and that with the option enabled cluster is still marked as
allocated in "qemu-img map" output.  We also check that the option
doesn't work with qcow2 v2 images.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/290     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 341a25f96b5..cf4ff6c2bac 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -29,6 +29,7 @@ status=1    # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    _rm_test_img "$TEST_IMG.nounref"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -40,6 +41,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts 'compat=0.10' refcount_bits data_file compression_type
+_require_disk_usage
 
 echo
 echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing file"
@@ -90,6 +92,42 @@ for qcow2_compat in 0.10 1.1; do
     $QEMU_IMG map "$TEST_IMG" | _filter_testdir
 done
 
+echo
+echo "### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled"
+echo
+
+echo "# Check that qcow2 v2 images don't support 'discard-no-unref' option"
+NOUNREF_IMG="$TEST_IMG.nounref"
+TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=0.10" 128k
+# This should immediately fail with an error
+$QEMU_IO -c 'reopen -o discard-no-unref=on' "$NOUNREF_IMG" | _filter_qemu_io
+
+echo "# Create two compat=1.1 images and fill them with identical data"
+_make_test_img -o "compat=1.1" 128k
+TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=1.1" 128k
+$QEMU_IO -c 'write -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'write -P 0xaa 0 128k' "$NOUNREF_IMG" | _filter_qemu_io
+
+echo "# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both"
+$QEMU_IO -c 'discard 64k 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'reopen -o discard-no-unref=on' \
+         -c 'discard 64k 64k' "$NOUNREF_IMG" | _filter_qemu_io
+
+echo "# Compare disk usage of the 2 images"
+# Don't check the exact disk usage values but rather that they're equal
+usage1=$(disk_usage "$TEST_IMG")
+usage2=$(disk_usage "$NOUNREF_IMG")
+echo "disk_usage($TEST_IMG) - disk_usage($NOUNREF_IMG) = $((usage1 - usage2))" \
+    | _filter_testdir | _filter_imgfmt
+
+echo "# Check that images are still identical"
+$QEMU_IMG compare "$TEST_IMG" "$NOUNREF_IMG"
+
+echo "# Output of qemu-img map for the image with dropped reference"
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+echo "# Output of qemu-img map for the image with kept reference"
+$QEMU_IMG map --output=json "$NOUNREF_IMG" | _filter_qemu_img_map
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index 22b476594fb..d8f8d5ff493 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -58,4 +58,32 @@ read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 # Output of qemu-img map
 Offset          Length          Mapped to       File
+
+### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled
+
+# Check that qcow2 v2 images don't support 'discard-no-unref' option
+Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
+qemu-io: discard-no-unref is only supported since qcow2 version 3
+# Create two compat=1.1 images and fill them with identical data
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both
+discard 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Compare disk usage of the 2 images
+disk_usage(TEST_DIR/t.IMGFMT) - disk_usage(TEST_DIR/t.IMGFMT.nounref) = 0
+# Check that images are still identical
+Images are identical.
+# Output of qemu-img map for the image with dropped reference
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
+# Output of qemu-img map for the image with kept reference
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 *** done
-- 
2.47.1


