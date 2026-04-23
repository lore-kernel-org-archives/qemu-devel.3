Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA65FAD40D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSy-0007hS-9E; Thu, 23 Apr 2026 01:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSj-0007e1-TL; Thu, 23 Apr 2026 01:18:53 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSh-0003DU-Fe; Thu, 23 Apr 2026 01:18:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFFSOiUKNSqSk2teQocu2fxpJCkKkd5wcehtPJFqDZWEG19l71VKw30puRkgKGeSNpl791D8F/H+POQczf4Rh3TabzYJBZmnm4G9orKVd5fgKfzRvWGBlRMuBmjqIq4cr8H3zM6J3CNmjSyz0uozEp+JNumW3ns/2bn1QVg+VjXkkUVQdCBEYEUi8UB3LWJ2n6N2f22e/db/PgSZY/tRF8aqWiaOEOLlLS/b+FFt6LtM0zhRxOBJaBWVSfJZvPjOx72d8GDrd/0QleufpPpm1UN6ZyKdeY0Iu90ndu0/pVUbzD5wglk/ngUkjCCkU6YPZr2udJ4o8C+Y14UYES06ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84a6H1AYkCG3PlZqCD6Dcg7C2Qm8Mm+r6Pi+HNsJuUc=;
 b=b2wj3TbyhAU+S6TJtgcMZ1HblZvNVhxZkb/fyPlJpOTdohu8eoVuw9nGn86/rfX8KvAyG94UPKkJ9hViX/o6oVt7raeJSnlSUbAGH19WWCIGfuKtgBYaAAyc+x/3fNHjrdnTkN3BujmSaS4oNfDVQKgTT8LfXOCiwS+Pqh6mXNBW3a1ORVZiPwvhDy/l2lunkHSKqlOrt4jP+CvP+Qcx2Wur82ira9M2zUwSex8y/2K4ZBlw/iLGmNiyIXRGu4Mv707ORs1nnheeSXfpztVWPTbxS2TU3IOpUluoV/yrFZqE1GAuv8J67uj+mqzF7YrvmowOp/1ACh9Grto6xSaYYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84a6H1AYkCG3PlZqCD6Dcg7C2Qm8Mm+r6Pi+HNsJuUc=;
 b=r3ub6lDLR7aSZUHI+hcKAViUcp6fyJvMqHm7fznBGCWJaYz+Yxmi1s/WKDI5K7n6QZruO9EW0/69pMuD/W3v/iqHQ6iPTMwnSqxxzAg67UE1Qb0hboHZb66sEfklFgDUaaQkHbnnlJqzlfrxgchXQgelxfNrA2bbNKYpagWB8JBm+YA+g89CA43L6G7M5IyBpOE0dF+GGefJKU6i3GjH2oKMoi8HMu2G7xdKovM6pP+kjw5D7vYAZDGsA6ajCxCJWBavJfhs1zoOUC6h4lLx66fWrC8xZordfKp8XjEWKkf12942uR4RWXcGDvznFatSg5sCSGH/N9+1nojsliAaFg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB8534.apcprd06.prod.outlook.com (2603:1096:d10:9d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 05:18:18 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:17 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 10/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Topic: [PATCH v4 10/17] hw/usb/hcd-ehci: Implement 64-bit QH descriptor
 addressing
Thread-Index: AQHc0uCYw6djoa5ZSk+U7a+LeVecxQ==
Date: Thu, 23 Apr 2026 05:18:17 +0000
Message-ID: <20260423051804.362095-11-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB8534:EE_
x-ms-office365-filtering-correlation-id: ff8c536d-7762-44eb-7de8-08dea0f7ba7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: kDattUptkqUu1gbKkT3h2J6l5p0WPFXF7JPgYKdcYjlJXkRtnOZJMJSM29cmR8DllZYFMMaHk6HAUbp5F2YZfCrn4LbALR9urEZWdnVYQOag5ayr5KIZAKPU/B7pY3osKNqST0VmZpQo6+hRfmrmQZ00qgjG7+KJKatwMoyGcei8/Xh7P4BWZzQiwheM2zlPdu7UW+6vea7oITRpQlFdUhq0PPBrY0TDueHvWKTbTbwZnkeePV+/IK3wpfz4rnLzRKfBWMkc1vPtIV+yavRl6pUqH0EUIzu9FOzKzBgCdrusJpAtBjzLoPUNfKQwzlAnGMtOtoSGqW8UFUfbp6E8lhNodW/UWxvrQYbBLL0lpfcyF2dj48g2/Yy+ji+z6C/HpTll6S3NkYEEuMb0kWyz3ImAGjAHzsEPv70ayRuzCK9uHCuBN7zDrSWcjmz0oKk6r5Tv5lr1HeZa1LA/rR6CBdPJNpNlVNWxsPvhUfBwrFvUoFcwBXeDdOUbUW8B+eTw/QNr9U+ZlYXLEmzO0IEgQX2+IEOSghEKqsFB6uSbZWP3PBtQAGGE1TSO0IxkO0aBqoFqhxpiXAx0OvTpLv+SikU1vNb+J03Z2w9GHOKfZtaioL4G/01Z0WT4SCuBzW65h9TovRcwGj28AAS7KPL/28StzFePB7MfU3GeASRSFehU4hOmNPzeotNN6wOVL7wwmDUv7WKylIGb4TCU2/WCAY/ryO9+NnZUJsvbrPLVuGYRdc62MosTty6KI2Da2EGbyXhsfSjjkUX4l+9XuZ6V2FgDuVdIVbzJbNWxNgXzB3aPIi5oqram+Z0DIhjWtXdg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tTrb22JRh8VqmglPUJJWAAmXR6xiqZkSJO8EgXI1+XJOvTJibVYfcCTFkM?=
 =?iso-8859-1?Q?MJgqydrXHCPHyFhz2WuTb32zQrUqQvjxML3gYgxUNd9kYeMoGk84rxoHPN?=
 =?iso-8859-1?Q?ULR65GNeY9eD/IfpfIAmW5yr9NvkPCQI0X3ZtP0d+u1xonAeU1NDBO7quI?=
 =?iso-8859-1?Q?C4zWzhnyX4GbYiPENNOktjpS/37i4aOUlcsKR4MnX1KrSH93ED/uHmCScD?=
 =?iso-8859-1?Q?0PucjbEWwDipS/WJzj2X/3ReRtvY+yAUzkpnREBqlkQiVBdyC2fWqujpjL?=
 =?iso-8859-1?Q?KpKLYNsuIlXC+UteigsuHuIic5rgBrv3oxRkQtpE8/tfVFaCVh98JiQbWq?=
 =?iso-8859-1?Q?ztbaDGTZ9LyCAr5/Z+tw+aRY/E6Qj6xH0rSkP9bkWvbFTADECJkYJaLNxR?=
 =?iso-8859-1?Q?rlkYdhwpZ6s2BYq9YAyjGyc30h/GcwPUeiFYsFp+IdlxGp22Cp6WtE6tbA?=
 =?iso-8859-1?Q?NGiye2TccfOZjKvM5513gjEouXiMl6as2Ev4HmXk6d8tD5OvsDhtKmgFft?=
 =?iso-8859-1?Q?bafW5hX1QrfwzVW1U15UmDcHNTPJiWFDEnd7gtiDHStVjS6YMI/a1Dfe6n?=
 =?iso-8859-1?Q?NkkYLE68GPuYPapMRAqLZsBUFY8phR4h5z7h+Sob0kdv7dvf+URNGxz9ur?=
 =?iso-8859-1?Q?RmgBtu3WQ+c4wv59PNU0AJXIvtqZw44ED1VdBPC+MqhZK+VHU7w5HqsbXi?=
 =?iso-8859-1?Q?SUqLJyPWk0hIFdRtROr5E9OurZrIuQgz4YdQnjqos8h4XRb7RSYZgDBYae?=
 =?iso-8859-1?Q?Wck7SY4VtQ0WXzfDo0nVqLxzIjCueHhXvBwPnInqSGP888d+14SWRRKfzi?=
 =?iso-8859-1?Q?Ic3XY8EO+EMD8/KvckSb/hYPudS/LeDPringxAHdIxld/wGcqI/j2ybC/e?=
 =?iso-8859-1?Q?x+shWKVmYnlHCyQzZx28i439iy5U9iUYeTod+h17tAdSl3zaVZFY/evc88?=
 =?iso-8859-1?Q?PiiR0UOSQknKs1sL6xp2uyKN66yIqgNfizMlmMWl9mp15QePOpWi8SFl9j?=
 =?iso-8859-1?Q?nZeV9KJtwXFhjA0+tC5C0wPyjtJQh97aJfZRprZm/DCLHWtPvl1Vq/DIEw?=
 =?iso-8859-1?Q?GavJrBtnz3N0QoLy4jUpcnnRrOP4E6V4tNqHm/EsBt1hiPjbsRdaOOCfEK?=
 =?iso-8859-1?Q?j3ZInhUO9pl95kigtvCcH8ywksqpmOsYYJwsCUt8/F+Mt47WBmwXwcQQ9W?=
 =?iso-8859-1?Q?u6pZufA5ZjRQD1YO93gCXaB0awjsEQrtKrFK4J/FBcKG+qMUY/m2iqpwhl?=
 =?iso-8859-1?Q?5X8RKg+Xt7h07bHceJoGFe3kJhmYCwbBpZ4Uvp8oTxgJwCI23cioYbADrU?=
 =?iso-8859-1?Q?ACrkhTXPYQg73wWlag9jzItq/E0z6OX2aNsd0ndJa7X9gzGObL4BJigEb1?=
 =?iso-8859-1?Q?Ji89kFroxJkH8rTMRNJeF0fy3QTLbNeBmE+O1dbjdP3PFXqmbRjoBJrNrS?=
 =?iso-8859-1?Q?mlGk6n66uHDsWq7FczBFSs/D8Or8mJFMMFZEA/dv7ikAPWjsjN7B2FMHP8?=
 =?iso-8859-1?Q?Fci79tJNv6dlNV+nKy9iEAf0LE9D4OO+JxQ0r8p17VP/HWzy0eMmLucUqa?=
 =?iso-8859-1?Q?Snk5GPXQF25P5oFLOZ2mQQgj/9oEwd3CZf2lkNjOjJC7GUx2Dooep3vC22?=
 =?iso-8859-1?Q?VzKQSgSEg3m3Ti12PLomfc4PeVQRnc0kKy9KuGnTKE0iIYAZqOft2cB/K7?=
 =?iso-8859-1?Q?qCHLzkszicDQso/XJpdkfEi9QAJvJMYVHN9LAHiOCOgRf9P8aHNj0Cy/jk?=
 =?iso-8859-1?Q?nPNjzqy6FghqRqIH+IzXu7xtQ+2IK8nH540uCg0fyMoYXlRUKbJ6ehaIIv?=
 =?iso-8859-1?Q?kcJFFEgrRw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PXMlSGTA105XQ4TtbKIb5WeWNW6g0/0Z1mDOM82EsOEfl4D9uDN9rOC4wAR+XcO/HKFlYDRHUBD8LT8B9JwHtlZqG62jqhO1luhX6ARUVTH5Q+59xVbFkXm4wrhj0P3l3uZAAVAKDr2D4u8m0CNFcWwGpwRiR8+u7otQs9Kw9jJzc/Qk8nOB8BgdBdJmzP/wOEtOQl4oiodfQR1+PdFfHTPY2hPpix4eAThwD6z9P3K4MtXuaDamdodJNTPyai81HEwpyzPT7BcFxQ2LK+abpf+SqxoLWjIy2GJz9nlBumqBEASlo8LilEQPvci6PTpQtSbjjjvnApcq/8NaclpxJA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8c536d-7762-44eb-7de8-08dea0f7ba7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:17.9354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMcyRpZakzu+d6IHL461dOk8O26sRO84UuTlK3VrMK5hGHdUIvmIX/DlacPvZAvouZg5rhXDDz7hcuat3QDriYaLhx9ogNFouh2F/tpW0v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB8534
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register supplies the upper 32 bits which are=0A=
concatenated with 32-bit link pointer fields to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
The current implementation assumes 32-bit QH descriptor addresses=0A=
and directly uses link pointer values without applying the=0A=
CTRLDSSEGMENT upper dword.=0A=
=0A=
Introduce a helper, ehci_get_desc_addr(), to construct full 64-bit=0A=
descriptor addresses when 64-bit capability is enabled. Update QH=0A=
traversal paths (async list walk, horizontal QH link, and periodic=0A=
schedule entry handling) to use the translated 64-bit addresses.=0A=
=0A=
EHCI 64-bit buffer pointer fields are defined in Appendix B as=0A=
split 32-bit low/high parts located at separate offsets, rather=0A=
than a single contiguous 64-bit field. Therefore, the buffer=0A=
pointers cannot be represented as uint64_t bufptr[5] without=0A=
violating the descriptor layout defined by the specification.=0A=
=0A=
Introduce ehci_get_buf_addr() to construct full 64-bit buffer=0A=
addresses from bufptr[] and bufptr_hi[] fields. Use this helper=0A=
when calculating transfer buffer addresses so that data buffers=0A=
above 4GB are correctly handled.=0A=
=0A=
Also add bufptr_hi[5] to EHCIqh to support 64-bit buffer pointer=0A=
fields as defined in Appendix B.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Note: Similar split 64-bit buffer pointer handling is required for=0A=
qTD, iTD and siTD descriptors, which will be addressed in follow-up=0A=
changes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.h   |  4 ++++=0A=
 hw/usb/hcd-ehci.c   | 47 ++++++++++++++++++++++++++++++++++-----------=0A=
 hw/usb/trace-events |  2 +-=0A=
 3 files changed, 41 insertions(+), 12 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index f1f2fde578..3428839ec6 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -141,6 +141,9 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
+/* QH overlay: altnext_qtd, token, bufptr[5], bufptr_hi[5] */=0A=
+#define EHCI_QH_OVERLAY_COUNT 12=0A=
+=0A=
 /*=0A=
  * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
@@ -194,6 +197,7 @@ typedef struct EHCIqh {=0A=
 #define BUFPTR_FRAMETAG_MASK          0x0000001f=0A=
 #define BUFPTR_SBYTES_MASK            0x00000fe0=0A=
 #define BUFPTR_SBYTES_SH              5=0A=
+    uint32_t bufptr_hi[5];=0A=
 } EHCIqh;=0A=
 =0A=
 enum async_state {=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index b23ff92e12..5ffd4c9885 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -147,6 +147,23 @@ static const char *addr2str(hwaddr addr)=0A=
     return nr2str(ehci_mmio_names, ARRAY_SIZE(ehci_mmio_names), addr);=0A=
 }=0A=
 =0A=
+static uint64_t ehci_get_buf_addr(const EHCIState *s, uint32_t hi,=0A=
+                                  uint32_t lo, uint32_t lo_mask)=0A=
+{=0A=
+    uint64_t addr =3D lo & lo_mask;=0A=
+=0A=
+    if (s->caps_64bit_addr) {=0A=
+        addr =3D deposit64(addr, 32, 32, hi);=0A=
+    }=0A=
+=0A=
+    return addr;=0A=
+}=0A=
+=0A=
+static uint64_t ehci_get_desc_addr(const EHCIState *s, uint32_t lo)=0A=
+{=0A=
+    return ehci_get_buf_addr(s, s->ctrldssegment, lo, UINT32_MAX);=0A=
+}=0A=
+=0A=
 static void ehci_trace_usbsts(uint32_t mask, int state)=0A=
 {=0A=
     /* interrupts */=0A=
@@ -440,7 +457,7 @@ static bool ehci_verify_qh(EHCIQueue *q, EHCIqh *qh)=0A=
         (qh->current_qtd !=3D q->qh.current_qtd) ||=0A=
         (q->async && qh->next_qtd !=3D q->qh.next_qtd) ||=0A=
         (memcmp(&qh->altnext_qtd, &q->qh.altnext_qtd,=0A=
-                                 7 * sizeof(uint32_t)) !=3D 0) ||=0A=
+                EHCI_QH_OVERLAY_COUNT * sizeof(uint32_t)) !=3D 0) ||=0A=
         (q->dev !=3D NULL && q->dev->addr !=3D devaddr)) {=0A=
         return false;=0A=
     } else {=0A=
@@ -1538,7 +1555,9 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
     EHCIqh qh;=0A=
     int i =3D 0;=0A=
     int again =3D 0;=0A=
-    uint64_t entry =3D ehci->asynclistaddr;=0A=
+    uint64_t entry =3D 0;=0A=
+=0A=
+    entry =3D ehci_get_desc_addr(ehci, ehci->asynclistaddr);=0A=
 =0A=
     /* set reclamation flag at start event (4.8.6) */=0A=
     if (async) {=0A=
@@ -1566,8 +1585,8 @@ static int ehci_state_waitlisthead(EHCIState *ehci,  =
int async)=0A=
             goto out;=0A=
         }=0A=
 =0A=
-        entry =3D qh.next;=0A=
-        if (entry =3D=3D ehci->asynclistaddr) {=0A=
+        entry =3D ehci_get_desc_addr(ehci, qh.next);=0A=
+        if (entry =3D=3D ehci_get_desc_addr(ehci, ehci->asynclistaddr)) {=
=0A=
             break;=0A=
         }=0A=
     }=0A=
@@ -1693,7 +1712,7 @@ static EHCIQueue *ehci_state_fetchqh(EHCIState *ehci,=
 int async)=0A=
     }=0A=
 =0A=
     if (trace_event_get_state_backends(TRACE_USB_EHCI_FETCHQH_DBG)) {=0A=
-        if (q->qhaddr !=3D q->qh.next) {=0A=
+        if (q->qhaddr !=3D ehci_get_desc_addr(ehci, q->qh.next)) {=0A=
             trace_usb_ehci_fetchqh_dbg(q->qhaddr,=0A=
                                        q->qh.epchar & QH_EPCHAR_H,=0A=
                                        q->qh.token & QTD_TOKEN_HALT,=0A=
@@ -1876,10 +1895,12 @@ static int ehci_state_fetchqtd(EHCIQueue *q)=0A=
 =0A=
 static int ehci_state_horizqh(EHCIQueue *q)=0A=
 {=0A=
+    uint64_t addr;=0A=
     int again =3D 0;=0A=
 =0A=
-    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D q->qh.next) {=0A=
-        ehci_set_fetch_addr(q->ehci, q->async, q->qh.next);=0A=
+    addr =3D ehci_get_desc_addr(q->ehci, q->qh.next);=0A=
+    if (ehci_get_fetch_addr(q->ehci, q->async) !=3D addr) {=0A=
+        ehci_set_fetch_addr(q->ehci, q->async, addr);=0A=
         ehci_set_state(q->ehci, q->async, EST_FETCHENTRY);=0A=
         again =3D 1;=0A=
     } else {=0A=
@@ -2205,6 +2226,8 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
     uint32_t entry;=0A=
     uint32_t list;=0A=
     const int async =3D 0;=0A=
+    uint64_t entry64;=0A=
+    uint64_t list64;=0A=
 =0A=
     /* 4.6 */=0A=
 =0A=
@@ -2229,12 +2252,14 @@ static void ehci_advance_periodic_state(EHCIState *=
ehci)=0A=
             break;=0A=
         }=0A=
         list |=3D ((ehci->frindex & 0x1ff8) >> 1);=0A=
-=0A=
-        if (get_dwords(ehci, list, &entry, 1) < 0) {=0A=
+        list64 =3D ehci_get_desc_addr(ehci, list);=0A=
+        if (get_dwords(ehci, list64, &entry, 1) < 0) {=0A=
             break;=0A=
         }=0A=
-        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8, list, ent=
ry);=0A=
-        ehci_set_fetch_addr(ehci, async, entry);=0A=
+        entry64 =3D ehci_get_desc_addr(ehci, entry);=0A=
+        trace_usb_ehci_periodic_state_advance(ehci->frindex / 8,=0A=
+                                              list64, entry64);=0A=
+        ehci_set_fetch_addr(ehci, async, entry64);=0A=
         ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
         ehci_advance_state(ehci, async);=0A=
         ehci_queues_rip_unused(ehci, async);=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index 8c90688bb3..67249d69c2 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -113,7 +113,7 @@ usb_ehci_dma_error(void) ""=0A=
 usb_ehci_execute_complete(uint64_t qhaddr, uint32_t next, uint64_t qtdaddr=
, int status, int actual_length) "qhaddr=3D0x%" PRIx64 ", next=3D0x%x, qtda=
ddr=3D0x%" PRIx64 ", status=3D%d, actual_length=3D%d"=0A=
 usb_ehci_fetchqh_reclaim_done(uint64_t qhaddr) "QH 0x%" PRIx64 " H-bit set=
, reclamation status reset - done processing"=0A=
 usb_ehci_fetchqh_dbg(uint64_t qhaddr, uint32_t h, uint32_t halt, uint32_t =
active, uint32_t next) "QH 0x%" PRIx64 " (h 0x%x halt 0x%x active 0x%x) nex=
t 0x%08x"=0A=
-usb_ehci_periodic_state_advance(uint32_t frame, uint32_t list, uint32_t en=
try) "frame=3D%d, list=3D0x%x, entry=3D0x%x"=0A=
+usb_ehci_periodic_state_advance(uint32_t frame, uint64_t list, uint64_t en=
try) "frame=3D%d, list=3D0x%" PRIx64 ", entry=3D0x%" PRIx64=0A=
 usb_ehci_skipped_uframes(uint64_t skipped_uframes) "skipped %" PRIu64 " uf=
rames"=0A=
 usb_ehci_log(const char *msg) "%s"=0A=
 =0A=
-- =0A=
2.43.0=0A=

