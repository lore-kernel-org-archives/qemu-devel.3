Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C9606A324
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=fMCIRi/o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO3L4-0008Uv-IG; Mon, 02 Nov 2026 20:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xO3L1-0008U2-1e; Mon, 02 Nov 2026 20:29:24 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xO3Ky-0003Po-R7; Mon, 02 Nov 2026 20:29:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NhGTv+5rNlEjyIDzWeRUsaCRzRwrCSAtDCBKNMTp75qALYdLi6ShGzSenkBXosP9sUdULB1uFAy/mRudQMSC1Bi62Kl2gIZEYTylvGSJ6ugZdLr5Pj/4dmxk8NfLrpUW3NgVdlv+wsP2yF9FE0RUcqt94gWYCxQgC+oqg3NkVWooY2RJhgM2Cm755h7LsXFfG4KDNUlfgYoxSAX/zx3ynJWFzxM+0Vtz5RZxVLhWlpN8FXzKQOw3+1JT+CufmyRsE7a7YOz9+2m5QQ5yE1iTMdknHlhyiqfOP8RrzqEvtWxhVuT+zs3IpxlbV+GI9gu3zgCu+j16SWvCJACYC90EHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgG99Qy7/S+pgOVttA4wUNPSI3JdtSgVJ1Yo+vE0UPk=;
 b=Rh50sgGv/CJFJ6IRxcsb7BWVlwoFckXWlh8uMB+TLAzOhwCthtt8vsNpzBrzMuGoX4EOQFQQh0F6+ADd8Ya82PnyMnSU7diQIsh7x9hsAF2OqlhnjAxIZyPSIryZh7ypubYK0BXl7uSlo7UykFJZ7s0Im2YTuFAMRk4eaywbuJrAi6JaifHOGwCxX5oRbSQ6gdf1cix05ohAXZaQUjRHneepOUTteeJYDnh0hPfGsjIChgNOJ4P1kTy5LIoVJU1k/HV5kpYgxKpy0TcVusli32G8JVwuzGBLNhMGx0o0uQWd03Aq3GEpryne4miObJmT538FRBOaPpmx4T+DGKJ5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgG99Qy7/S+pgOVttA4wUNPSI3JdtSgVJ1Yo+vE0UPk=;
 b=fMCIRi/o+uYtjEqidMFTAhavrDUssY3proBo6zQ8XsmK4ZQDA99wgfSWVvRpaedWMcJU4Yt3XxjGJyrcXvpU66uvu+HaWPTfsfN7RCK36UC20TNeTKjwnYQpQ57KZWugyiHFO4T1l7WeJ701d9zsAor+SF57JjFnPf7axHy52AYYpNZTzsoyLZN+GRtwHrkfJVwW+kuVtZs8wjDYslZ6/PocrUKGxzqxqLTvDChKnuf45cQOIPCjPDcap0DfORFcrDRBqhlwjBunSWJsmzkfDhJQkz4Y6mReQ7sGi128+LqkFxFsj/431m+XKtIVcLBwPZ8Oq1qsICIBqUlhojksGw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEZPR06MB5642.apcprd06.prod.outlook.com (2603:1096:101:a6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 01:29:13 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 01:29:13 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, "junjie.cao@intel.com"
 <junjie.cao@intel.com>, "junjie.cao@linux.dev" <junjie.cao@linux.dev>,
 "clg@kaod.org" <clg@kaod.org>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v8 05/18] hw/usb/hcd-ohci: Add an auto-hub property and
 leave it off
Thread-Topic: [PATCH v8 05/18] hw/usb/hcd-ohci: Add an auto-hub property and
 leave it off
Thread-Index: AQHdaquj7EwX/4j+EkiS0LfitZAyFLca0acAgAC+S3A=
Date: Tue, 3 Nov 2026 01:29:13 +0000
Message-ID: <SEZPR06MB73620A5E8EB72452ADC9D933FC692@SEZPR06MB7362.apcprd06.prod.outlook.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
 <20261102092201.1729245-6-jamin_lin@aspeedtech.com>
 <179362845010.3960472.4266154712960924675.b4-review@b4>
In-Reply-To: <179362845010.3960472.4266154712960924675.b4-review@b4>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEZPR06MB5642:EE_
x-ms-office365-filtering-correlation-id: 20081860-5679-4bf2-2f4b-08df3949de29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|38070700021|4143699003|56012099006|261021121427099003|10067099003|18002099003|22082099003|261102123227099003;
x-microsoft-antispam-message-info: 0UvYkuXHS6vDyNWLSUDsgUMXUpH3zH8xJBVGTh0js235T9HtYNNBNpSC1hTCW651g2dPigUS0coqGWDtgSDgZx5bBLREDN1e15megyqQA4OnMvu/+TjE0ab87TcPTxdidEks8s3nCNRX5wV8JweZ2zK+Ve1ygcUtm1nNXYfUIV13Ov1qHxs5hpA7tPmPRD2Q8sFSdf8MYiqNlYNx66WtdyqzNWUua8+FjKnCS77Up3xWmlCK5rCexUID2HMrALSUVz3sZzQbHGaJy3+oTDgV1Gk8XUoIaGxRaH+baLoO102SodXmkUriM0Sl9G47xcrrx8Dodr0xW6D40ASeFu6TqIOEGlEOA2fhqD5YUOSt1mLQA5JwTElitJXthWbEXHQzDpNl/VfgFgKws4VKxPoSTN8qnzXfFQzaOpxQkBPOu1ZnOrMoF4sylTenT0wecer9uNNZTX8vP3YZ9I2m9h8u3CoKeiy9Wwj8FJdCqcOlt3dqsyU0IQoqEORugr6yJv1tl3S55wukCMmRrPZpb3/I1efh0X2I+uMG0Gq9mz/wNlTH2LcF3Wfb+zrB8cGUm7Znw5AYYMRwE0FLvhuDB5SjTDTPumUW6gw44288ZwtYvsqNhbhHSU1N1cPqOfjC9dMsKX7u3L4KslKcuueiUhTTS21Q3sfdaemqRDJeW0nlW/SVBAM2uAwmgNMaFe1xKnudj7i0InuyqUUzUT9RRXDbjs9s6xYNpLgjd844IaARjAU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(38070700021)(4143699003)(56012099006)(261021121427099003)(10067099003)(18002099003)(22082099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2dGWEVBcGRpU05XN3FiRnNlTGZpQnVMMHF0VU9tVmlKUC9PaTk5Y28zZGd6?=
 =?utf-8?B?b3gxWXU0OUZVOUpORlFNQ0Q3bkZCa1RkemV0emR3TVc2dklKRmpxbXpUUDFh?=
 =?utf-8?B?eXhyVlNPcVAvUFhvRWthaFNheEZka0JOdVNINnhxMXFSKyszT0kzOXlEVFpY?=
 =?utf-8?B?NWpzTXNlcndOQkZvZEF6SjlEUDJrSlpueENSTld2aVUyMTNMUlN5bG1wcU4r?=
 =?utf-8?B?bGl3SGd1eEU4RnJkMWRQVjhuTHNLejEyQ2g3eUs0MzN1T0U0MDRRSUhFK3N0?=
 =?utf-8?B?Z2l6L1pya1o1NkdDZHdHLzI1Y1FCNkc5SDEzYlJNVXlDZENyVlBLc0RsQk9G?=
 =?utf-8?B?bjlSdTViVmNBZW15RU1aaDFqMzFnOGZDWXZxdU1OMFQxYytGRkF5ZlY4N1Vl?=
 =?utf-8?B?LzZRL0tYbHFPenRFTzNWaHcxbFZYdENzZ0pBVUJ0UHlIYkNyY0lIV2J2RTFY?=
 =?utf-8?B?Sm9RallqdXFQS0VqbGpSeFZnS08wYXprL3pmTmtZY3czS1RaaGZhd0YyWFJS?=
 =?utf-8?B?aG92WUttU0JiZW1EbjhYUFpEZ09ycmwraGNrTDZCaDRKenBQYk1CUXF2M25X?=
 =?utf-8?B?U0RJS3Z4UmZjeUtrMjBnTW5lV1ZCSWF1djNaejNKQ2RCN1RHbXNaeUY2dE90?=
 =?utf-8?B?UWU2QzN5MEkyQkgzMXZHZ1YvYVZLMHo4TGJHc1ZTa1RGVkk0ZjhCdzJFQ29J?=
 =?utf-8?B?djBuYkV6ODM3dTM0b2FGK0NzcFhNUGkrRXNBZGpMRXl3VE5STndHQTVuWHQ4?=
 =?utf-8?B?MzVKRWpUSE5SZXdpS3U2QjEzM28xTVVWQ3F1dS9JRUo4V0VGSFpIbEY1QXBi?=
 =?utf-8?B?Y1pvSmFnV1M5enR6dU0xeGZWeFdJeXlwNXpMNTB4T1kxRDcvL1krSWhKNW4y?=
 =?utf-8?B?by9ObUNGVlovL3hDcnlPOWlQMklycHNmS2toU0l1L1lJcHkzVlpXaU9EamNo?=
 =?utf-8?B?WGQxb3pGa3dtd2VmWmQ4OFVTdzBBR3gwRWtmTkNJRFI0NTlJaThRcGkzZFBr?=
 =?utf-8?B?UXpPMkRLR00wd1ZPYjlHSzVOQ2dML1lTSjN3ei9HRkJJREo1b2NzaHYxL2cz?=
 =?utf-8?B?UWQ5OFNDQmVBQkJRR2xQUG5NM2hMMEtKdXZwdzNSSGllemUxZmtkc0ViSkJ6?=
 =?utf-8?B?Y0lqeS9hQjJjR1RWcG40ZGY1dC9WY3g1Q0Fzdll1MDRZMlpXZTVQOGJhY3FG?=
 =?utf-8?B?UGt1em55dml6NFY4eEZ6UU5IbXAvckRLS05sc1dLN2hGcXpUdTRNR2ZvMnJ6?=
 =?utf-8?B?TGsxZW1oV0syMC9YYmFlZWZDV1NwbUNZSEtjTkE0WFo0Mjc2K1VjWkZ0ZFQw?=
 =?utf-8?B?bTd1U084blZ2eHhvNm0xMWxLUWpNblFHTmpmdHpEUlZVaHc5a2RjZUxoNTVm?=
 =?utf-8?B?NXZEdjBYRk1Wcm9vT0ovMjJvaXJHcnBkMk45UzkvcEtETCtUVVJNRnJmOHdP?=
 =?utf-8?B?RUhvTFNmbTVyT3RRbDAzbXJ3YUk5Z1VLYy9rUklYMjBUNC9zMmc5cStmZG9H?=
 =?utf-8?B?NEtwWmdiTWthRW9zTkFreG56MGtkN0o4YmhURUxVOEYwZU1teGRwMDZsUmMv?=
 =?utf-8?B?OW95WkI4VGJuazBjaU41NmxYK0plTkl4ZU0reHppdnFSOTg1cjcwY3VWNWpC?=
 =?utf-8?B?alFjUE01ODBmTk9ZN3o3Uzl5QWx4a1M2aUk4YS9scGFqR2R2MFpOTzN6VUR2?=
 =?utf-8?B?aWt6Wit6RVNvenBhM0lVM1ZxcFFHeERYUjVNcHU1YzlBUWV4VFV1b1ZORHlW?=
 =?utf-8?B?NVZyOHNYWXUvWC80czUxajVYeTZvZm9TK2xjNmV5eXV6TENTWXl0TU5tektq?=
 =?utf-8?B?Qk9LRmVvcE5vUkRVYi9DLzZ1UGpnNXBhTmUzMnE3OVltVFlBSWZtY21PR1Y0?=
 =?utf-8?B?dUdMeU5BWjBSSHp0elZIYkx4Sno2TjhLNW5TcW1GejUvWEJsSFJBZEdvMWpJ?=
 =?utf-8?B?My9HaHZ4dFhKdWxTZEhoV2ZsNTd1YVcvUXN5cFlEaXVtTnpIdkZodS83Vms2?=
 =?utf-8?B?VXdJMFhwVGZ1eCtjdDZNclV6cUNzN28yM2tuOEhhbVJISDVOelVLeWczQms0?=
 =?utf-8?B?OTI0MDRsQm10UWE2TVRqSzdVSkdhcGlUSWNwSVRCYnhzZCthK3puQ1RPM2tO?=
 =?utf-8?B?am4zWjJIRk1JbEJLVmRRZUVBMWY3VWpaSERSU3FmR3B4MkY3bFo2Y2FnaVJ3?=
 =?utf-8?B?VkEwV1hXS0dicld5V205UllQNkhZWjBJeUFQQzJTQlk3cUNtc3pZbnhWdHlr?=
 =?utf-8?B?WnQ4Mzl0WG1ZZW52RzN6emo5ZDYzY1VEZUtNR1BrcElKMXFqcU9TZFZhTzEv?=
 =?utf-8?B?dWk4RTZicWZqeVIwK29rc0RtcXJIQnJzd1dXcnRIcUNKcGZPcmNGZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PR1fHkmX23QBrWH0RmuxPy0ZtdO+rMkVApm8ivVIXhqFZnoXJ2bIv//gLAzsvarXyaCWDbwE42h1giekqhumOil5145rjLShNqowfZO45tPQE2/+GKJ3TQi5iAe+bLBRvpSPQ5k41gVlnNu4opTacpYSYWnrVpRcZvl74mpOp5540NnJm85UO4+NNgveUVrDsgjSdy61Ae6xXtYZjB2mXdptArdCWp7+TpL6rsOV46Dhsj2u84zHMp1B/AubpTmOPqHznTMEX9Bk4Y3LwYkYnIf3eEMXvZYSll65oX6Ij9Itsn6cV0wSAsZYGMbPEB/dzSqNg4Z6+a7StHRSqK+Xwg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20081860-5679-4bf2-2f4b-08df3949de29
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 01:29:13.2361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qA3B4+PE0N3Il0q3VctWCGHOemhZrcRyTcWOl+HS+zatsGshOIbjfFhmQhYMdhPn2UBSkn4PWRCukZh/Ru9FqViGFe5PuZn9geX9U66O6zU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5642
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OCAwNS8xOF0gaHcvdXNi
L2hjZC1vaGNpOiBBZGQgYW4gYXV0by1odWIgcHJvcGVydHkgYW5kDQo+IGxlYXZlIGl0IG9mZg0K
PiANCj4gPiBBZGQgYXV0by1odWIgYW5kIGxlYXZlIGl0IG9mZi4gaHdfY29tcGF0XzExXzEgdHVy
bnMgaXQgb24gZm9yIHBjaS1vaGNpDQo+ID4gYW5kIHN5c2J1cy1vaGNpLCBzbyBhbiBvbGRlciBt
YWNoaW5lIHR5cGUga2VlcHMgdGhlIGh1YiBpdCBoYXMgdG9kYXkNCj4gPiBhbmQgYSBndWVzdCBz
YXZlZCBieSBhbiBvbGRlciBRRU1VIHN0aWxsIGxvYWRzLg0KPiA+DQo+ID4gcGM4NzU2MC1vaGNp
IGlzIGl0cyBvd24gUENJIGZyb250IGVuZCwgbm90IGEgcGNpLW9oY2ksIHNvIGl0IGRlZmluZXMN
Cj4gPiB0aGUgcHJvcGVydHkgaXRzZWxmLg0KPiA+DQo+ID4gQSBjb21wYW5pb24gT0hDSSBhZGRz
IGl0cyBwb3J0cyB0byB0aGUgRUhDSSBidXMgaW5zdGVhZCBvZiBtYWtpbmcgb25lLA0KPiA+IHNv
IHRoZXJlIHRoZSBFSENJIHByb3BlcnR5IGRlY2lkZXMuDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6
IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEph
bWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IE1lc3NhZ2UtSUQ6IDwyMDI2
MTEwMjA5MjIwMS4xNzI5MjQ1LTYtamFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0K
PiA+ICBody91c2IvaGNkLW9oY2kuaCAgICAgICAgfCAxICsNCj4gPiAgaHcvY29yZS9tYWNoaW5l
LmMgICAgICAgIHwgMiArKw0KPiA+ICBody91c2IvaGNkLW9oY2ktcGNpLmMgICAgfCAxICsNCj4g
PiAgaHcvdXNiL2hjZC1vaGNpLXN5c2J1cy5jIHwgMSArDQo+ID4gIGh3L3VzYi9oY2Qtb2hjaS5j
ICAgICAgICB8IDEgKw0KPiA+ICBody91c2IvcGM4NzU2MC1vaGNpLmMgICAgfCAxICsNCj4gPiAg
NiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9o
dy9jb3JlL21hY2hpbmUuYyBiL2h3L2NvcmUvbWFjaGluZS5jIGluZGV4DQo+ID4gZjc5MzM3ZTdk
Nzc0Li4yMmQyYjgzNDU5NWEgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvY29yZS9tYWNoaW5lLmMNCj4g
PiArKysgYi9ody9jb3JlL21hY2hpbmUuYw0KPiA+IEBAIC00Nyw2ICs0Nyw4IEBAIEdsb2JhbFBy
b3BlcnR5IGh3X2NvbXBhdF8xMV8xW10gPSB7DQo+ID4gICAgICB7ICJwY2ktZWhjaS11c2IiLCAi
YXV0by1odWIiLCAib24iIH0sDQo+ID4gICAgICB7ICJiYXNlLXhoY2kiLCAiYXV0by1odWIiLCAi
b24iIH0sDQo+ID4gICAgICB7ICJwY2ktdWhjaS11c2IiLCAiYXV0by1odWIiLCAib24iIH0sDQo+
ID4gKyAgICB7ICJzeXNidXMtb2hjaSIsICJhdXRvLWh1YiIsICJvbiIgfSwNCj4gPiArICAgIHsg
InBjaS1vaGNpIiwgImF1dG8taHViIiwgIm9uIiB9LA0KPiANCj4gU28gaXQgYWxzbyBuZWVkcyBw
Yzg3NTYwLW9oY2ksIG5vPw0KPiANCg0KV2UgY2FuIGFkZCBwYzg3NTYwLW9oY2kgdG8gdGhlIHRh
YmxlLCBidXQgaXQgd2lsbCBub3Qgc2V0IGFueXRoaW5nLg0KDQpod19jb21wYXRfMTFfMSBvbmx5
IGFwcGxpZXMgdG8gYSBtYWNoaW5lIHR5cGUgdGhhdCBhc2tzIGZvciBpdCwgYW5kDQpocHBhIGhh
cyBubyB2ZXJzaW9uZWQgbWFjaGluZSB0eXBlLiBDMzcwMCBpcyBqdXN0ICJDMzcwMCIuIEkgYWRk
ZWQgdGhlDQplbnRyeSBhbmQgYnVpbHQgaXQ6IGF1dG8taHViIHN0aWxsIHJlYWRzIGZhbHNlIG9u
IEMzNzAwLCBzbyB0aGUgZW50cnkNCm5ldmVyIGZpcmVzLg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+
IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0K
DQo=

