Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51B606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=DzzEmJet
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLtSa-0004MA-IB; Tue, 27 Oct 2026 22:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSY-0004L5-8n; Tue, 27 Oct 2026 22:32:14 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xLtSW-00082E-75; Tue, 27 Oct 2026 22:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdHa/v+3/BP8fQaMdIqGgmth95FpSaLmIjj3mu94p1sJJkgSEf56OMJ0vcBCuGlmf5ypPchuVCjPb5Q8sRrWHfUyKZv7SkS/CbNtp+KHldhbAHEo7isOq0ftcsBlCed1iQ7fDNw2xldVM48eH7tbt9bhFn45v64YoEDfCTNM5PNu+kcrMl6fpx62SW1DTnGImhMq/FScbqVWQN+9z/BRO2XhXngRHPJ16thsCb0PszIcBOWTa8kCjQJDKgGzVVz5YdrbkkX+aetEu8n7eWPsynBqyhyizy9YniW57cHIrAoPMKHkZlUwer17CqQTjg7czzCPu50VP/B3ffdnfZorYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXXCjk6J8Flla8Kx74defY0Brk2CV1L3YvOvlh2XG3M=;
 b=w65nvPn7KhK6SqsEmOhjVACbjAUyTKINX60fVf9MDMHeJ5oKH7gdnacjqESMesaMd798N3zoc2UXnF0Hr6twj/1zC00imxNIUTxceMV7PQLOvuQLrjewQeU3r4elbcRRJLMNOKCYq0cw9KUV4fZeXz0RJQqAPa76iEz/2XwxRPATe7q8acMVZN2cMlhzrIUm+0yD7OcCLCSgzmbk7Oet/ijhqBI0qk9TKjTUhy5ZPgXgVvx/e3bq0Kg2m1cC5cllDzmUoqZ+0mJ+UfwDSkx+2dYiRIz531Ok9jp+rArhclydXSCnAaNav2wZEboU5H+38bEsanfVYMGarnNkNrn8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXXCjk6J8Flla8Kx74defY0Brk2CV1L3YvOvlh2XG3M=;
 b=DzzEmJethHjRIOY6Sex/wkMqzCJVkDbp3pz5h/ACzMxnZey6BQ2IKrpTEL8Coc0ll6+HBPaORdLhxOF5YC27VVJkaq46noVllqd/3rQvUYXx/1DujUWEx6/3sMRLfIdzwQL+LD6FDWYLMedS3r/zq1RePcFUO1SbVS8jHCoNSWiDqtZQ6CP6q7G7KLS4ybiVRsojgEz3zKYrwQwc8CGhwvMiNz7rGxTORydeXaZbiT0V8U/C0Wj7LLv0oKcNbOGuBTS2IpqNfDKFsa+tRx/b2nXd0IBrWeAyhONtjQZCI0pJNmgd/X2dqwVuZLF/VfHnrO7hH58YPJqn+IaHrY4c2Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KUYPR06MB8531.apcprd06.prod.outlook.com (2603:1096:d10:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 02:31:59 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0569.006; Wed, 28 Oct 2026
 02:31:59 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 04/13] hw/misc/aspeed_scu: Correct AST1040 A0 revision ID
Thread-Topic: [PATCH v2 04/13] hw/misc/aspeed_scu: Correct AST1040 A0 revision
 ID
Thread-Index: AQHdZoSBG+ihUqQhaEik2BpZAF8wsQ==
Date: Wed, 28 Oct 2026 02:31:58 +0000
Message-ID: <20261028023154.48395-5-jamin_lin@aspeedtech.com>
References: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261028023154.48395-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KUYPR06MB8531:EE_
x-ms-office365-filtering-correlation-id: 271e2d39-9f58-41a1-541f-08df349ba463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|921020|56012099006|261021121427099003|261021123027099003|10067099003|261009223027099003|38070700021;
x-microsoft-antispam-message-info: XYk/jpr9UBqU0CCD5bliNkQhJbwJcnXNog4Ct3FoNrMm7WrL0MNuxzSBa4689Qauq5lkRHExY/xxL5XyvapyVYGZ0mXzACDJWTPs1kmS6jtApyTf8GSOLBVvYy6s/f1bPoLojAnG3WQfh4Z5/0Li6opHaFwsbyU1p6/XJUVVH1yvEpn9ySqVdT/ZrXxBZqddXOjSn5aWQK+UkKbtNVtPf5fQSm4q9OyBs0/yQEVq94XOBAn/OEaeevZvhIfoxv0I6d5cf0z2tpD+kxWViBCEvqgkQVby0ZR5GtOsFz/mAVkOWmTvSLm0c68zC9/2nQMs3FLrKaM7dNEAnx00FQSVwEZ4qLXcC34aJ0LWm5x0Z588rjUzLD82uViQQrkHJ9wEwiWC8AfWBEZMukrNp39ev2CA1OxJkP1ELsQOOSj54gHKTANovvPjR35h6Pq/1p4Lg/mTB1+aShuKXVP3H8pRSM2AkZCFHFr0XZg11gWr9F4KM2s5SBkm3BVwokDNG4llalE9PMibzd57DsfguWuTX2g6/C+Y0uWJ2TE4/Zj0+M5xJPDRrsP9K3sNZ10j7SP/hUuZA7yjOtKDIjGsq8V3fYLrReNkkuYOHOyNZD5NQ2vbYiTXLp0bdB64DeyXZiG94X7sT1ktN5YarKImq1FWeiQN4OkBoxwTZKAe37p5hCpklk/6JyzgSusYD+f4+4C52wb1/FmoKHBkDtp5y02b+IDuwzzxEsA6TcEoJYiP13fsk7eITk14jYbiaLdx4ns8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(921020)(56012099006)(261021121427099003)(261021123027099003)(10067099003)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Qg2NG1mHnIBaZsomrpScCSry4BUvlMAUaxCtNeS6UIctISnVr958pAwZe/?=
 =?iso-8859-1?Q?U4j4LD7NFlPgtBy0qvwu7q5O4b7iziBjQSlD/+Nk7W/pqoGjoY1X3ZtqBN?=
 =?iso-8859-1?Q?NZHIW5+90wfzhTaeiqO2oXnDCcx0lTzN7GG9K4PdtkYcyVytdPb3H/Hg/x?=
 =?iso-8859-1?Q?YRIn3GXSLDRltThLAs8Hpg+BPPVVzACSJXbjZu0tc3yqia6zATMr0iyn4x?=
 =?iso-8859-1?Q?ApmMGeCKAeoWaL/fqrBBBXeOP5kmzNpATpRxav6lTuR78lURdeTG/x//F2?=
 =?iso-8859-1?Q?ohJT/WYh7oUwqspLqhk6qMlTe+SUf2tHCVV8lh+SpR+7uNe2bqGpAICN4N?=
 =?iso-8859-1?Q?tHEE396r0S0RPSaUR2KuxnpaCMJn4Y9w/793tzm9mUfrcBJttRAIm+2Vh3?=
 =?iso-8859-1?Q?YVJdQX3vF0p0+Me86ojuoelpg6YiH6K09KQu4cVNYTt7MQQs7k1lwFTw0k?=
 =?iso-8859-1?Q?Jzq7CohltJk+nY+fLMbsrcPqZsMadSSRh1MPADeDBX7YpscUHUb7qeNgho?=
 =?iso-8859-1?Q?rdV6IAvBalYgqUTfDgA6+D2lXM899zWuS36AHmGz7NEBWkB/iSk2jOIOsV?=
 =?iso-8859-1?Q?60d1udwY5pq++wHcSJhquCQXyuLOa52eag1CUUCohwoGxZEapPftfqS4AQ?=
 =?iso-8859-1?Q?b94IWlpPjES3p+pjbbe+WcI+vpJLoDO9iFq9wqo27ykyvUCvFWxnCMBX9Q?=
 =?iso-8859-1?Q?jfeCEJwrCpaBzxTHc6ktN2Jr5tbj5VqDIUCaIvNtuOtSIL7vBbyNFrMEtf?=
 =?iso-8859-1?Q?WpF6S/2zDhKpJ9W5LZKql7iVEC6J56dIFwa5EL7JWMUB7Nahxdt8OXoVgO?=
 =?iso-8859-1?Q?BBQL/30/g/Q7FLlXK4qudKDMmdHWKJWD/kbD1DJ3iKRZnyAHJGbUpbqGkZ?=
 =?iso-8859-1?Q?RkT2CP48JJ+jq5uiHa28jPW+lMfrcFxnBrMVSdtJNNUOWWXY212gCoQy35?=
 =?iso-8859-1?Q?Fvoj6kHitjJuMdFJ9kL9RpjpMqgrliGNK22VE60WL8aAYzjmIarM7e6VWs?=
 =?iso-8859-1?Q?vvqhDGbZFF4FmAuHCCXTVDdIdmLvY3G1iWSkM4eSDTz0g3PEjnaADSerDe?=
 =?iso-8859-1?Q?WAe57mZOu32Gy2kjBO9vcExy4DmX7CoDsqk0ngwEkIvoiMyfMOeJEEp51B?=
 =?iso-8859-1?Q?2wgZNTLnfcEvN2wsMLuHYs8ex9JT44x/Yj+ZPmZGf/9lYI0Zj1qtr/J75J?=
 =?iso-8859-1?Q?8fbzo4XQituVBnxfPGuKiC68kRRfZOrKKMH2rZfUMUVbN/fskarAgl1GI3?=
 =?iso-8859-1?Q?OQ05qAr7RMJuiv8QiD5LPml/+VqCNwCpF25FUjk8eCZu3j9C2taWr1LscT?=
 =?iso-8859-1?Q?omceSTad3QYbzrp5qThB4dHFVGEsiXDX+yI7qwu1yez2mrWth1CLDPK9Dc?=
 =?iso-8859-1?Q?3imvtCug+Ig87TUbI/xo7PY082MgbYugK/WNLvjkBc2IMzvpPMYuODFLqs?=
 =?iso-8859-1?Q?RVz12BfplmesSYlhOix9FeBQOMdWYVSL+cOGWvCq4URi7bctJDdZ2MMgEi?=
 =?iso-8859-1?Q?1EaUkcS9+EEhUeP4btqSpi06c2AVhZPZv1dQJ5l/Ii4wtCPPMzNUwACKVk?=
 =?iso-8859-1?Q?IKH787We6o6VLKAmYc56O/lBYu8rsADv6T/ERpYJamn4+/ns/UIrR9ftXY?=
 =?iso-8859-1?Q?w6PNTySmYjIyvMVe8JR6+0rl9FKIsnlh1hLms9O626sI2+urPO41pIZaiM?=
 =?iso-8859-1?Q?0jKI6GYTCZ4XkJTJskpNNWID7xzT/wozXmm3VVLTjlzDz8dJpNLwy4Td9h?=
 =?iso-8859-1?Q?hVr+8mWsVVgukJCF0KRCE0zBTl4SEbcsWzsTplPjLGD69ifymTixCAZz/s?=
 =?iso-8859-1?Q?Z5+goUXdUQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e2d39-9f58-41a1-541f-08df349ba463
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:31:58.9907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOP4t0k0Xh8KmVPB4nMhajzqtjzeACDRiFmnBUuLfovdRwlmoDJdS2rh7UUsL0XsoskQjp1cX5ABwn/vAB4P++dYjx1A+CY+GEEZp3Oz4Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8531
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Correct the AST1040 A0 silicon revision ID from 0x81000000 to 0x80000000.=
=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_scu.h | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index 904549465f..6482038f12 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -51,7 +51,7 @@ struct Aspeed2700SCUState {=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
 #define AST1030_A1_SILICON_REV   0x80010000U=0A=
 #define AST1060_A2_SILICON_REV   0xA0030000U=0A=
-#define AST1040_A0_SILICON_REV   0x81000000U=0A=
+#define AST1040_A0_SILICON_REV   0x80000000U=0A=
 #define AST2700_A1_SILICON_REV   0x06010103U=0A=
 #define AST2700_A2_SILICON_REV   0x06020103U=0A=
 =0A=
-- =0A=
2.53.0=0A=

