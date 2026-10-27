Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC8606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=selector2 header.b=CX1NGFtX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLefy-0005Lg-2v; Tue, 27 Oct 2026 06:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLefv-0005Kt-Gr; Tue, 27 Oct 2026 06:45:03 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xLeft-0007qr-IL; Tue, 27 Oct 2026 06:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLH1UBZC0eIVbEt1xkgG33NU3FOIDfn4pJ0wnsKpmmrV2tYNnMfU0M7foOLRKeOu1RUiRDax6aLJ+m2E3VtdVHnfNcnsboesVvGMhL+g1AdrRG0dzD/P6lB+GTBcJiNeDbrqtZYalnyyLiYlwXpPNkBI89/XXx/YyZGpnZ6PLYO8UYpUhg1FMLZJqqm8djRm1kP+XbLS16PAwK2TwyKNhNsKv9NcoGfASCTnb2s+T0u6T4x4Sq3z+qglieh+kd2sHBetV6Rll7tyh1YdLzbSSeOYUq0EeU/+3TfCSkbDwx/9YxSD+fKq4oQsrRZhgJzV86vB/RWgtmD2PXsMk++NFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c75kuvQ/6lovahKT5hXHP/vtpqjHezeu08IcgZWOuBA=;
 b=Y1h9nUAfxDptSrJmFqzLZaVMLripr1lYZjloKLr4vscCazhXiLuTXqv/zCb2JW5R5yzx18h1bFNvgdeRqh6+Onu7H5IFBbIw4Q9BgJ4nx7NzDJAYIQWSc+7ts9KwG7A8nY/raYTZMFoXZO7Xomqv/hREn6KfGcFLikGy3uh362fwVqi6XizQCZP5c+GPbj++x8vlPqn6tovLpjGO1UCfP7BChCX5N7zwMbyYrcSma5zt+LgmiuzhLh6ZoKJeoGwMEpZnAzq3GgsdjjyZOiDc/ony65eKKOf7X1HDCTzyK+/qa+QwS1rw6mHX9z+OJ71F193Eul82PoeS6eN9OFaksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c75kuvQ/6lovahKT5hXHP/vtpqjHezeu08IcgZWOuBA=;
 b=CX1NGFtXaU8qUDlNeEZ70z6lct5s0SNd7TVDqtb3n4FvSu3EYZJOyY955ktJJVRSf3rTV0/t8pgBLIsEidWTcvPD/DL2LZGxcWD/y9FI/1cLe5rlaMUG/k1KcMjDUNsFz4SwzYYsbiIHojb/CT262KE5lMUWCrc2Ed9+zM1ZddkO/wWyazm9buJ1FiTa9x9ShcrCNd1DldYQe7mhGifoP4rwbI3qV/XFkC/3j/Iu0nRiD/5TCqzO8N4HmQR7dSa/nxQq7MiaR/X3K6CZ17kM40jYAwDPW5NoclwIfQPsFbBL6hh4T3NqMBxYqj/lNuoT3eAS4qO+t68BRkDFwjEIGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS2PR08MB8805.eurprd08.prod.outlook.com
 (2603:10a6:20b:5f5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 10:44:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 10:44:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH 3/3] iotests/290: add 'discard' and 'write -z -u' case with a
 snapshot
Date: Tue, 27 Oct 2026 12:44:41 +0200
Message-ID: <20261027104441.830212-4-andrey.drobyshev@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2349593c-a677-462a-8971-08df34175329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|52116014|376014|38350700014|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|3023799007|261026121527099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1poU8Jo6oBB2kxgWGTKnGtAIDQ4gq0Nva/c1+mRGEAthyDwplwHY8Uft6AYiRTNxOQVE7Kq0CfWvHDBaV7MJcOn/ArVvv2F0zjugZ68rRr+wVMdjhfdWF9ewBGV0ppe7ChNdKDxSLT+qcEySdSwwEV1cEWg7iG4cxqBX953FZiWxyWCEzgFjCj9SeIPeVreUS6hV2tXgsbUWCvOdBCGfbtAW92zbdDWItRxQNNf2FbLHji9f8MTxljk6KkJKQ0i4oOXeTaW/ctF11EO+gBIneTz8/+Y+QjDY9gIuX3CL4NvmcyCXDBdklXyBlqWqd6V6BWbA3nOGUWu2VCUJwJd6P8vlSzdHDriJX8C6KvEbC7wSQMMNEPvUE8Qs5e30vKqgcBxgU5270mVxeLpAlhF0avtaGt1EweWPKOt23/fTwIjYx7pcsNQfpmQjSYer0bo8FIXHUrj1XdsEe9OpaT/W47In0ZRNaQOTG0qwaxjUajlWAXvS0O681Y0kOwjMuUee9WPpBCeG0SqFcSFD95oJqhcU/HrNNLeUqaaOij5J66+EXxVdijNq5F1KxrCAqDex1PbCig5HZaFKCqwOfirqU9j91KLDs/7in/lStHgc4Si11FzlnE8An2y6N6IR8/ySJQ7x0dL/26w4PeFvvMWnmrPfIGdrJE+eqq2aPc7SNbTyqr7g5sE2Fp1qCVj1zro591/uBMfxqjJYzAhgj/1i8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(52116014)(376014)(38350700014)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(3023799007)(261026121527099003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q197lLCvLN6ImEasQxatlHI4UqqwpRbqKWWclOrmXxE90XnnUAq/USRMOiUW?=
 =?us-ascii?Q?CFclz2fU4yW3kRHMhUI4IR4mmO4TbyzYqfkcS4aLCzTpFXBt3CGS0RZYm9tL?=
 =?us-ascii?Q?cDC7+VckLdmeQ14Tt8NFpxjTWKptEIr/3NOTZJ/10tcD1m82IjMJqlkUeClJ?=
 =?us-ascii?Q?51wuVXtnUi+Sp/wltppkha9GMFRUMeps4GV0mAu1mkCuer9DQbZthZSVKBmn?=
 =?us-ascii?Q?SVD/s7x+TwLnUFGAPcVHo8XKDGxPbRce4h7LNfZcFtXYhvgt6aFYasqp/g73?=
 =?us-ascii?Q?ni1e8vMcgv2d+38MjDBGFvO89T1B/ax55bwVmkdDr9Kr91YFmoJA4TcXlQHX?=
 =?us-ascii?Q?Qjus4/CHJDkai5gtVbp2Fg6O5M2wht1ZQDKKCCPI1rRm/B6wkOXq+KdZbtMG?=
 =?us-ascii?Q?6rnQ2Tmj0tIzyD2gFg59td3lBQCRqx2Euy1fi3/1flBHL3/PClH0iyT3nLkl?=
 =?us-ascii?Q?M1rGfCKpDwBt3Htv0Uiz6uce7AVwbRiPVDmVm5Iey134Tli/JNBkOd8Desgf?=
 =?us-ascii?Q?ioqFa0NIJPzPrjy3O5S1cCoTjYDkAiiRy5MJ+O+s2agJd7H1pNNjOpiDNlQr?=
 =?us-ascii?Q?L9REPlpi8lnrl+I7r2V2KMNp+EoL5E69aE/5Pu48dxHEdGpyDbIoL16xpGKv?=
 =?us-ascii?Q?rSRUPbYVWgTCnnv+HDqkDF6sxDclmIKHwComssjbUmGfGkLEIze8UM4ZuFoM?=
 =?us-ascii?Q?LPZEXnXDK3lOxfOg5yvfK+o6+VwX6r2muLpVuzhsNpKp+PMrulBD84oIOuZR?=
 =?us-ascii?Q?0nbAYuH8swUT/dy3KnoX3FrhnQw99B2KoIUUBMLNv4wTb0gwrgU1jVsY4LT7?=
 =?us-ascii?Q?lg3KMTKSLVYU5Mztu+WB9xp72VhXggCgq7AoPpT1ItoSm1hH5lAZxM6aln1T?=
 =?us-ascii?Q?Dq39JBKpq53U3lZoX14C6SUgJqhNPk+eSFtBBBUB6mcfMLvLwlPWJz1oca8a?=
 =?us-ascii?Q?dClFBCQHKY6VnhSMxVYYAQmm8h/8eJOgUWNt4up7Sgd+Fa6jbsEL50x41x3y?=
 =?us-ascii?Q?TQe+VKMQ8FcfPm+s4ZNmKreTgJgmMnxstjS0jamtCH0x6xxlm/yWf6oJsadK?=
 =?us-ascii?Q?2FJd83cvAmO4qTgKEmhmwAgKNmhq5B2daQpgW5qEnzdQ9IWjacE5EP42QknA?=
 =?us-ascii?Q?/3tpiFFhtN+Gi68C+itKq3ff90d4ltRT7bfF3EseLy/BjMdIJnzor5GUlCtB?=
 =?us-ascii?Q?U0r+6ePvoxxvCFM6SW5VB8QlTSmF+A71ZatKR+yubvE983Fj7mNMxfGL3tRY?=
 =?us-ascii?Q?eIV1E3vi2Upd3ddGj0LGBI4xZoF1uO69yfeRhWEGzzZVZBpjYcOg5w/+IBtj?=
 =?us-ascii?Q?tz1BXaWSHZWMBLK2UHqGk3GtRQ30rbrhWXOSxaI+ljJXTPBXOgXlJjSa2XRK?=
 =?us-ascii?Q?wpH/Szyb0fQGs/kNmp8gT/elKVKwAfuq7ai36FbUpXIOjz9BV8GzVSS5d4w9?=
 =?us-ascii?Q?bgvjKc/muJtUPZCf0p70ICth76U5ve6itZvNDfb1kwT9I/K4vIaU0UkBkkcD?=
 =?us-ascii?Q?58rS6+ciuH4fXrxLzuQBMfhOtqWDN0+4rJnuWMCF1E0UI7ikaPU4ZbqV6xB8?=
 =?us-ascii?Q?5FghCzOrqxHtKL3PXMQalWhl9roGoIt1geHeFATIAgmzH8FUaUpIUXFHaaJj?=
 =?us-ascii?Q?RMPOVCrnaqMVowji7m/Jz1rDM6nN1B8EJJghNteGe1EFv7p2hiploKzBZ2B4?=
 =?us-ascii?Q?Xmntz+jHcwBddGDRrYCoBVekfNOZbz+quI1C3FnerSvwPZo/8SrqLReFbbSz?=
 =?us-ascii?Q?A3A6Yp68TcHwyfAOGhXcCiz4430fKhY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2349593c-a677-462a-8971-08df34175329
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 10:44:49.5324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+a0vJeErz6EH4qQv36h/NgZWt+8gJPiV8LvFb+5ZhKM9+tAGO4hrVxBFoBIF/1pmWGghjL+wF2qqQzznTgSC0chuHJRdiilwdJJ8Z4KWSg=
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

Before the previous commit, issuing 'discard' and 'write -z -u'
operations with discard-no-unref=on option enabled led to data
corruption.  Add a test to cover this case.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/290     | 16 ++++++++++++++++
 tests/qemu-iotests/290.out |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 152fd7c5d1f..049a0ef7f13 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -124,6 +124,22 @@ $QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
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
index f790feae81a..aa5d164fa9f 100644
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


