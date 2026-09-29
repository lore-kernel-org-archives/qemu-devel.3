Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A7ECA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBbYo-0006Ac-9d; Tue, 29 Sep 2026 13:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYm-00069j-BY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:08 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBbYk-0002ne-Dj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 13:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFoHRdy7u/RwuNrxekWra3I+MyyFYZjnVpdLjRR8i9jBr83u5ARrMNE0i7LHfQg6H/umjkFyQmXz4Pc8o58BTEKhibde2okGC/In0xUpdO70nvTU8epEaRaTN6Q/6fGH3z9H7SBXcKSMaxwgngjPURtSc8VCv3l0RaWJbE0mUQJVynKA+uCwTUCW2hmntxfFVgqwex+wY8JNZgAdvV4NKiR+VYN1Hg1nhZJsdRK/TkW/JCzNg94iMZUA/fulnJE7qrsDC8GJUIE903580CxPiXXw5SeBwVgTQ3dQTjjd2js8AIPMMEennkNeBokPv5QqPMMnSd9oxylxDs/btS6e1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6atyNkgbw+OR6v+48a6SwVH6z/T94VKhpPr1IzUjA0=;
 b=O5XXUNjySyIbxNQk6Iw0ty2l6UnAdK9tNfYQQdI+HHqhmuFM1Dtt6J7/4LkQ9Qkvda4j6yO0PV7aQW3TagimE16rdxJrBRFzHFxPmx1QKp1UADo2I84mjmJG4qusuIXtZvH0jqFOhPI5E3ItlGTErLnW4b1D06SjFmtCrFOcjnVXRbqzNqR5KiL2QswxOgfS5kxoZEK4eOOGZ1Xr3wQu/jMIuf5EJ9Ld7N2xWoOrfGd1qgYIOE3NzD3md+nC74im7CIaWMTQkAuJNPmf9Sd3UaE9CIBBbl+u4CHPcNH6lrchUcqBrP4Aw1Z47Bxjx2FpTueUISvasbNcg4y9tcdnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6atyNkgbw+OR6v+48a6SwVH6z/T94VKhpPr1IzUjA0=;
 b=J5tatwoDfo90b++J4WJygme+t5troYMGlc5ck8nNpX/WBjFTlwpw4hywjs9pbdiQxKCEEQ1j5yQnJyJfWO117XuD5dqU0RHUKtE2EX/RIKNl33ypnFCcQV4YtlUHkw2eF5gzWdLnd/NoaTSfU2NiKwyIzUnm9uFQvVk4ILe87iFPtgw1lPv5JRN1ec8d46MRVW5SRcAqQxwFx5NxQlYEFAXCWc6lbkfNVPgZrQdXGmtkKvpVnWZQfyR9NzCRN21EiLmbgylfgKkLXm/Kbxlumu87eEGgg7Y8IKGHI3lUXw6O3QCDKfS4bYUZ4cS4RyR6LS9oE3iQj1YVviIDpBI51g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MA9PR08MB435041.eurprd08.prod.outlook.com
 (2603:10a6:250:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Tue, 29 Sep
 2026 17:23:56 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Tue, 29 Sep 2026
 17:23:55 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 29 Sep 2026 20:23:35 +0300
Subject: [PATCH v8 16/17] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-up-vsock-vhost-v5-v8-16-12bcf1c0b84a@virtuozzo.com>
References: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
In-Reply-To: <20260929-up-vsock-vhost-v5-v8-0-12bcf1c0b84a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, peterx@redhat.com, 
 sgarzare@redhat.com, bchaney@akamai.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MA9PR08MB435041:EE_
X-MS-Office365-Filtering-Correlation-Id: 4357bdb4-e499-43c4-34eb-08df1e4e70c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|23010399003|1800799024|260925021311599003|260925021911599003|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003|260925022911599003;
X-Microsoft-Antispam-Message-Info: fGsNaOg9n9t7MX3muL0HseZrDj9scS+ADUwU+cyqk9A1fEX8n8x34NVDsZSVyldllPIEf9/lexAScwnTMhm9UPoYg1lsZPSLe41ePiaXQ5JAofJYH4YuXBOTEOARUtyHX/Mm2lxK8v400M/LErZYSI+pdYZWrANP72xQijk/S3TwTOQ8n6C5G925gSeGsU1IpKTQhPz3ZoZsHZov6ardjq8Q5dBVtiQSIeORbpcFHkYXIO2Q7oc1SU9sHcoVZ0MSKozez9YAQUxEsCaQnaLoXkQM6Iy00SYWwtcla8GY+CkKK7K/b5XBvJEW+9pGOD+y7DYPyuXDcRei0f3xFTw5m8iI1qKeiPhOyu2nOqX7Y9G7v6FcIeJXXl2YhdvoBPvFiN8wixYyZfoNy4vPvDmFlilT8pO27p0mJKTt6LaQLVE0OQrrenVRMXN/fqpKdKTjk7UAGPhG3BPiBqHRd+UZyZnGIoS81RNMIxEwp57BLR2UHT4H1T2se01LQ23xaPuM24/uXpJCuBL9as+kxEiGBXShzw+JEddVq1J+GH9Q6EVaiC2tzMmPd9aqOgAhqBsVpUiYyNGe+7Ax+28+7AcNSjevjlHL7MiJGKyENIMjiQl/qxalnaHysX/Qm0YNSDJJaR784D84QFHWR4hA18GnudstXWEOBbYa5WBqVrF7Ic7HH3cgJmrNt7xgsYyfYmP8KW+ddQzETTPw0i7FFTmU7uUduhxi8fG13qJbGO7OM6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(23010399003)(1800799024)(260925021311599003)(260925021911599003)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003)(260925022911599003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2lUbDcrTXFpMVZ5bFN1alRMM3NYN2xmSXZqK2QxcnpYUkF2Tmd2ejQyMkxX?=
 =?utf-8?B?cTFYNU03M291UFRqNGV0ZVBUN255WUtRYUlLOEF2YmI2WGZZeUN0bmhxNWcz?=
 =?utf-8?B?eW84bVdzY1VjcWlaZlliMEkvWXlLK0NEM0pENUJuYk1HelphM3FQZHQ3UzhZ?=
 =?utf-8?B?VGJEVzV1VFpkT1UzaHo1UUtPbkpHRWI1bWdkN3lPOTBNM0lJUEErMlF0MVJK?=
 =?utf-8?B?aFhaUDhTT01XVWsrems3OFZ3VndMY2NvZVpyNjFydUJ2dU1oMDArL2JiQXV2?=
 =?utf-8?B?RVJsclE0ZXlZcm93UTUzUzcwQ2RPeE4vcTIyeXY1a1JXRk5mWkMzekNIdmtp?=
 =?utf-8?B?b3poOWFrc212OStrU0pOdGxEQWVvWXVqSE5ERTU3TmtmNWMvclJDYXM2Q2ZY?=
 =?utf-8?B?cEowbldJZTVza2dEbmdQSUJmdFN1aE43SFVzdmhYSmFWSlhpUldyR2tBbDZK?=
 =?utf-8?B?bFZnV3pESW1FVzIxWHhVQnNBeHZNMW5kWWlMV1dpOU5pZGNwV1QyNDA2ZnFL?=
 =?utf-8?B?a3hrWHY2cXJLRis1bmlzeXJuWmxlRUNDSm1qb2w5cUhQY1NaaCt3aXJ4TkI5?=
 =?utf-8?B?c1JOOHRHek5CdFBOc29CTmxRQ0hXZTVvSFI5K2hNajlsand6cm11K2xuaEVT?=
 =?utf-8?B?YVVkNjdWSVNPbGlLRXFDRmFPMEs4WllaNFY2Ty8zVGl5aklJZ1R1Tzl6RnZ3?=
 =?utf-8?B?WEkwSU1sZ05YeFI1S1lTczZQNXRYNklRSUhHdVpBNzB2c0I0RFRqMWdxOVN1?=
 =?utf-8?B?N1pIK0x2bDRGRWZmQ3FXaEJ6RWVpV2gxNmlIUXk1dVJPdUIrVlF4Y1BFMVNB?=
 =?utf-8?B?TjJtMEVsRHZ5R0Rka2ttNHhHamJLNXMvTTZFRGkwYnpNMDdGenRmTUF5VjZl?=
 =?utf-8?B?ZGtKb2VhR1QrWjZoa2NsUWFid3hDdm8vb0NxbkcwRkZTdzU1dXdWT1RpVUFu?=
 =?utf-8?B?ZXo0TCs0eU91SkpYY0dlTEJHWGtYdGhlN1pvajJCUkdEY3RRY3BBYVp0dmJz?=
 =?utf-8?B?WkhmNDUwTFlYb3QrNlZucFhWVmJuS29CSXc1a0xZL3RJRCtJM2NNZk9mVit4?=
 =?utf-8?B?eGdpcXJZVVdtMkpSc1VDVEgySjV4SmY5RjRGeFpCUWhvb21LNHlZTS9MZGVD?=
 =?utf-8?B?N3hKUU41MGJCVjB0VFkrYWJTSzJhZFlYVC9YSURzdEl4aXBvaE12c0FhNUQ2?=
 =?utf-8?B?NXZMQmNrcWg4a2dENHJHQXRKMkY2R0FkYjlYR29YRDJKMWtTMXJzckNiK1pi?=
 =?utf-8?B?dy9mV2Flc0FwMmYzUWsyeDVKZ2N0Y2EvNkR1WEgvOFJZSHZsb1A3cFhUdkR1?=
 =?utf-8?B?dGI1MUVPYmhYVkNRMUdwSnRRcFhmU1pYRS9HVmFiUktzTFlIOXkwcjlWcTNF?=
 =?utf-8?B?VTZQU2dQMFh5UkdzQWFydkl6TEk2UWNEUDF2N2RjY1VFUDdFaFN5VGhlK1VE?=
 =?utf-8?B?UmUzVzRycUlkd1JxQTNHYmR1NW9nQjI2cWNKZjRBSWR5Tk1FM0pvMzFLYlkz?=
 =?utf-8?B?MzNJUzcrQTdaclJCTzBSRytkT1UwcC9SaXZwUGluWlV0U29aTDU1TFJlakho?=
 =?utf-8?B?SVJKTWhRaG1pYjRuNXFqbUpqUnc3ZUpZMnUvRWk4UFN5VXYrdWVnMDlldTdU?=
 =?utf-8?B?UTVFeDBWL2dzRFh3ejdSdUpGeVM5ZHkyNnZSeXF2SXZRNUJxRnRGV0FSL3dE?=
 =?utf-8?B?OXRVRHBrTWRHdzI2Z3B2b2dZclNRTm9ISlZKb1B6WmJmQlZydzg4WDF4bXds?=
 =?utf-8?B?Z2hwdk5oekIvU1BFaHA1YnFQbXlMNkQxQlNjQjFYaWNOeTA2RGx4ak9EYW9S?=
 =?utf-8?B?MWFrWnBEMm9EUzNHM1ZPVEtJdjNoMEZOb2ZZcTVkSC9zUFhObUZOZk9qbVJ6?=
 =?utf-8?B?eTdxWXhRdk5PYlBTVkRsOTJXQ2UxajJHZWZ6V3Z5SDZkdjY1WGswc2VuVyti?=
 =?utf-8?B?YlRndWt3VHZpQmtFOXN3Y29sSjhXUXR2MHdxbVhYbFVHeEFQc1BUSkpoOGZX?=
 =?utf-8?B?a3oyTGQrYS9SNDROaTZVeWFUS0lTVDYveWUxS2tST1VtcDVPSkdKS1hEMkJu?=
 =?utf-8?B?ME9pc0xyMzVSZGlBd1BzVmdxUnF5ckFWQzRXdUlLL3FjS2R0Qm0vQXJqRjZI?=
 =?utf-8?B?NWxqUTZXeHhDVWNQZVUwSVYzeTVSSnRybXlxSm1hZXJtSk9nQTZSRXpOZHlW?=
 =?utf-8?B?dG0yKzJ1WFVKZUh0ZkZPUFh1azloaFhuNTg2QmI5L293ZFVUc014YmxlQm9l?=
 =?utf-8?B?d3VTelVhaTlGcTVjTGFmczZhUTJZVWdDeWlEWHZsS2RjcW5nVFBTUlhKOVNQ?=
 =?utf-8?B?aWhEdDdZTEhzSlhjMEpDZW5WWk1Jc1Yrd3VyNG5sc1BLWEh6UGNIU2FtVXVY?=
 =?utf-8?Q?oDUl5XBTLRz1nh9w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4357bdb4-e499-43c4-34eb-08df1e4e70c5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:23:55.9229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90XiQ74P+sHy1HalGIWZ1fYv5N6NMH6KzfR1/SBKCAXegUkdThXfPnQNLKrCACshzXvzmYd1hVqS2/dbXLXBTRhcmKIHj2v+BYLpDHnqFgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB435041
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 2be0fc8c07e..30c94582685 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,13 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#endif
+
+/* We expect this CID to be unassigned on the host */
+#define VHOST_VSOCK_TEST_DEV "vhost-vsock-pci,guest-cid=4000000000"
 
 static char *tmpfs;
 
@@ -101,14 +108,17 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer,
+                                      const char *dev_opts)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
     g_autofree char *opts_target = NULL;
 
-    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
@@ -154,12 +164,12 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    test_mode_transfer_common(args, false, NULL);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    test_mode_transfer_common(args, true, NULL);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -276,20 +286,85 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *dev_opts)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, NULL);
+}
+
+/*
+ * A vhost-vsock device can be handed over across CPR only if the host
+ * exposes /dev/vhost-vsock and its kernel supports VHOST_RESET_OWNER
+ * for it.  Skip the test otherwise.
+ */
+static bool vhost_vsock_cpr_check(void)
+{
+#ifdef CONFIG_LINUX
+    bool set_owner, reset_owner;
+    int fd;
+
+    if (!qtest_has_device("vhost-vsock-pci")) {
+        g_test_skip("vhost-vsock-pci device is not available");
+        return false;
+    }
+
+    fd = open("/dev/vhost-vsock", O_RDWR);
+    if (fd < 0) {
+        g_test_skip("/dev/vhost-vsock is not available");
+        return false;
+    }
+
+    set_owner = ioctl(fd, VHOST_SET_OWNER) == 0;
+    reset_owner = ioctl(fd, VHOST_RESET_OWNER) == 0;
+    close(fd);
+
+    if (!set_owner) {
+        g_test_skip("VHOST_SET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    if (!reset_owner) {
+        g_test_skip("VHOST_RESET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    return true;
+#else
+    g_test_skip("vhost-vsock is Linux only");
+    return false;
+#endif
+}
+
+static void test_mode_transfer_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_transfer_common(args, false, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
+static void test_mode_exec_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_exec_common(args, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
 /* Snapshots must be refused while a CPR migration mode is set */
 static void test_mode_no_snapshot(char *name, MigrateCommon *args)
 {
@@ -350,4 +425,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
     }
+
+    /* The vhost-vsock handoff doesn't need KVM */
+    migration_test_add("/migration/mode/transfer/vhost-vsock",
+                       test_mode_transfer_vhost_vsock);
+    migration_test_add("/migration/mode/exec/vhost-vsock",
+                       test_mode_exec_vhost_vsock);
 }

-- 
2.47.1


