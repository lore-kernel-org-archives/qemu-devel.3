Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA7606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=JHb8X85y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLefs-0005JV-Qb; Tue, 27 Oct 2026 06:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefq-0005IX-Du; Tue, 27 Oct 2026 06:44:58 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefo-0007qr-LU; Tue, 27 Oct 2026 06:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEv+yM/9lIVwj1jgEEAJwjOYsLI7oomym+VGRozNlwL9GGDArwlIpJbNR9hI1uK2a96K5epYu6UiIMBAFiQrKb0GlEIjqdh9rnfPcgPptJEFG1/S3KeSycJ5QvoGzU+n4Wt6vZBbMpowBOBEfmYid2wAVlOKBzK56pzU0wRQgkapdAF1Zwz4g1DJUiTlY80Ucyhd0fuKPiSVZsgituPgXKiHDdXmLORQjLUV5U+ytKypY/hF7zOiZOeaL+ztm7VrbK1Wf4kjhUjJRvc2vd8qoYY1ld22t9MqFq7Xdq0weKSALHugud8lBMyDv7yJpVMGcPjL76T1FScxS+cEIFMYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtYIxsoq/zL9t/KE7x4bUF7jHvol1c+4t8ZmkeMdOBY=;
 b=p7PffksBYDKrUvYb1DgnqWnb+mcfX1VmYXywGI2gH6yhzazLUxeG3gh5GsSMhiRfODYzUoPZOf3BTvoHNHc2WrF0Hum6YJT7fVwpDEqKVwQzmYZSPXIXa1S2vNISRm2Y8DlVGYYdDjJXOB658ZuY9P3bbzfH4YcYhwZm90pu5DdSvhSw6J6UIzGM5Wbk1u+BzwjnNzYx8QbvndKgJEE6dHRuK9vYZ4zqV+n4JViLtGdnKzeLshSN0jnSWEbqrfnyfaNfoZwTNO/RmiKFgFEKeFrEZBLbc2VacVwv8HimmnWnOekC4fXTuzrhrKyVQSAaBLELnlzLmAtnA5GVEV4zSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtYIxsoq/zL9t/KE7x4bUF7jHvol1c+4t8ZmkeMdOBY=;
 b=JHb8X85ylloWJuYTsjEjBqhV5Z+9ne5mrpTUr+PD3dVnZQ9hyJjwxEbrEKeluxTR/Pi3QnN+X4+drQsQ4XMPXwpG5h+GS4kXqOwWAMAX0F/V1SrN8lzN75//EONSqrpgNyI/5/m6wG4rrpQfpijQKH4TZcceH/prCNKauj7IFMM4J3oEkHOnJR2W1UtY8TlQ57fDn4nViFh39btjhCu/YZsIdihAn5yIgzGGPbeW3IlgGR2PEK7SwVHMG8j8fagWZ3kyM3Iq8D+Dg2GvptDCAdGV5WuMppgw3pjzKRBsRkG2YR0gWm9Zr9TX4zHsJTI5P7lmkiTd81X9Nnfvdw9AqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB8805.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:44:48 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:44:48 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH 1/3] iotests/290: add test case to check 'discard-no-unref'
 option behavior
Date: Tue, 27 Oct 2026 12:44:39 +0200
Message-ID: <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0070.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS2PR08MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 37cd6ea2-6724-4b01-2da6-08df341752a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|52116014|376014|261026140227099003|38350700014|56012099006|261009223027099003|261022115727099003|261022105027099003|261022075727099003|261021121427099003|3023799007|261026121527099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZbJyOrGiDuxKl0OJFfib0EzrPX6cOX2a5LvSqiuLHAVZlbu4aJwkcseGgRVX/BMjDizsuCOpzLCP1qbKXFhuXLCpbkuLTUZyEZeB45lB+fWpNwgFVVBYVe7bDKTfZ0KxZSJIX+OEcngCgKd5sVq4AY1DvkyiaXK/kGDcMeoXpVZBIYx0OwYmJxILzLusubGU3NKEdPUgHsA5ggmDYT2uObG20xaFLkXOKX0BT66K+sUJ5+T3UMGU2nG1x0NGdrMGmJHUMIf4ogJMlRYRdKWY3iuiHYvXqmxOgvb7n5vzf1/UCHaI5qcUmpGanShBtBDVfVIonf/UmBK+8zd1YPFK9ROTbao/q4uwr8rtYXNNL6W2njURCm+fosgQmNFgeB7mNOdVRCBlK0+q59OnvKLZB1gaeh3afTWSQ0GmXAgnjRwZlvcDYv4D+Scgiz4t/aWzQY3ftC8xT+F70NBXKKgmfsDF8ZMtLmi2GvbI2x+LmqaYrdzO3XCvl7L5J1GA/AIRuFyJQ36oNHmGb3jqePWQfiWCDKVJ7KhhJ9BQ3qHyyLPkuV6ZaJfzgCRU9yXLQ8b641T6eNiNCjMyWAXnAYvQbi1BkeZkE3hPgl1WzAjC8pBanhhzLSajWy+2ZuFm8it0q3TaOCRt6jM5R9TI/IzNDV8oSzpmYuneS+tMfrekgcmkV0y1Fj7WumJ/td5CfvF5fZk8zDFUADrFcx4MdJrsdUZi150BjWKIyeHmCEpNBTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(52116014)(376014)(261026140227099003)(38350700014)(56012099006)(261009223027099003)(261022115727099003)(261022105027099003)(261022075727099003)(261021121427099003)(3023799007)(261026121527099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fl2ZCLpO0s54MmprWwtZcPsKjXMVybAABzBQxo/sPrAlyPOobYqcMqryGe7S?=
 =?us-ascii?Q?KWMBTAjcH6fGnyL5+ShhCOwArNdo1XsBKKMLIjBKRcvkZ/HRd2lbkVsv3gwc?=
 =?us-ascii?Q?PjLPJEW+A2YWWKO7TNEcrXj/eegb0937C3cvicRv6GFJROhQAnK3JyXFc5wv?=
 =?us-ascii?Q?lci0qCwlSWkaBvr8HHPPbYnxW9qDUDU73fzbQti/nq/fSXurXEBtdH8KmQQ9?=
 =?us-ascii?Q?oVTZlyRh20NWKfwY9aw3tgB6PlsYAktX2S6KtszCocWi7zg6aRBOwzyOqwXd?=
 =?us-ascii?Q?orGoaiJwCpe6BVpthgRaHgQ0q7/iKx6gKmxBHcUq2GHLsPW9n0rGfi3iDnYu?=
 =?us-ascii?Q?CgVSnoS6CBf8dWR/V4rGbgHPi6rcQ2qC3oby6d2IzkslMMPoPqnyDK6epRKe?=
 =?us-ascii?Q?13TbTZfVw6pIkTQFj5l/xYaKWNBmco/p8wBoEXK9+4v23xXToE/O19luO1J2?=
 =?us-ascii?Q?PRplTB+88/C/2qdgSEgEKYqf05dCFjll2WrvTlmkKHIaQCmMWzYEIymJ4PSC?=
 =?us-ascii?Q?N2eoipmjI9dbwsoDurbErOzCuTXGo8UIwigR5+4wtzv8MXbRZAIbEzgP8RVy?=
 =?us-ascii?Q?2qf0wprhLK2GlqyQaZt3hpKW6WxK3jqK3zq2ml/HKa0dzj1x7QKW3S57mXNP?=
 =?us-ascii?Q?JPymziho3ibVBI9RK/k7MF1K72mj32dAePFT/cAXu4bWc2kUKhNPdjoXK80W?=
 =?us-ascii?Q?eOXy3xTpBgM/f9hcoxN94KV9VAN7LS8jHo1GVEC7W26luN4PzWw1tzymQ++y?=
 =?us-ascii?Q?qvc8IMeAFoae+uvYYngPQBRUgWGM3YSkMxxlWr9eF1/Jjxq7wUPbDjRDtsOF?=
 =?us-ascii?Q?fjLX2guFYXe9mK61MF66ooMqFYI20z5cYoX3BVNCD7YB0X1ILk/RPymDpnYY?=
 =?us-ascii?Q?cLj7bglwR/Hh01I1PjOdiD3rXZ5+B2AFvI8PwDmPaDkRLv4pVxwgKgjHc4wd?=
 =?us-ascii?Q?1CQLhew5WXD3gH374sRU6dafOlmEXfpKH6Ctw7m/0mR3/s72cC5Ofzngcyqa?=
 =?us-ascii?Q?0rCDPUsPNrNsIv6I9fDmcrQtzgvKfrCQVUVrT7dQDzwaAp+Hpsc1CCMx1IAa?=
 =?us-ascii?Q?xcs51Wj2wqc43mU6b1BnFxd4lFY8OFhK5sLuHr1amVjsdxikMkSBpPzcUw+j?=
 =?us-ascii?Q?Gao4XvSP9ILQrp3nqn+UUrGUfu/QJ1VDI9ViXCSumlPh771smT/qkPzkHywd?=
 =?us-ascii?Q?pvHvjGUeAC2AK7uMXay2rogTaygiGTQ8azJ/zTkipRJ6LhNtwQMeqJbgv1jP?=
 =?us-ascii?Q?ijvpn7hKDXarLoaSklb7ke/kePZX0yY/SDI/4ruXnTKNsnWVI4sG/nVw0gxr?=
 =?us-ascii?Q?1N0JKk6197L5BkUSdRcvjIZlk8fcTGd3Tvkg/zCLl03B6TBJEUJQQTgzob96?=
 =?us-ascii?Q?4zTaurs4FIRn1h6GSB26LnTJ8Mi9Gj0GQwIFSJJFhHdV/OERzqusOMuNkkT4?=
 =?us-ascii?Q?f/jcasPPziwXspp6ukUtd4i4VQH8ZaRcuWb0QCMmWjAzEj6kACRa7JUh/FtP?=
 =?us-ascii?Q?Xj+yJYptDf4lyQBJCcYSPJchFau3wo0M3dKbgljjoRzeA69e2Uje/kiqLsq/?=
 =?us-ascii?Q?mKyKTd9OkFtIMvTNC7SSmbaaiNVGjzEWL3wdWqW8MYA/QH8YNpSmwhAQCyMV?=
 =?us-ascii?Q?dUz2dUKjFIyTS6UQmv9wvNeBsQgj0+NV7kOzYBImjN8Bi2zN7kpLse7in1M3?=
 =?us-ascii?Q?i5ZoN0SOEGYTJeWwcOF3ZxdXWuKXpjJUO94pvpF6xQG+Pcy6BnOmXEQVX1iE?=
 =?us-ascii?Q?+of2iP9CG7yk0BTiXqZofkXdAMuos0E=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cd6ea2-6724-4b01-2da6-08df341752a5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:44:48.6252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T44E4EuqoM2miJ2siP7IjtCKjP0z4VBcf7knq9A7Yw11OboJxd/todmGJoeEIM81cX7w/F5b2Iu544kDxZjaK3myXUcjobjLgKbju+/r8AI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8805
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
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/290     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 341a25f96b5..152fd7c5d1f 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -90,6 +90,40 @@ for qcow2_compat in 0.10 1.1; do
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
+echo "disk_usage(`basename $TEST_IMG`) - disk_usage(`basename $NOUNREF_IMG`)" \
+     "= $(( `disk_usage $TEST_IMG` - `disk_usage $NOUNREF_IMG`))"
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
index 22b476594fb..f790feae81a 100644
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
+disk_usage(t.qcow2) - disk_usage(t.qcow2.nounref) = 0
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


