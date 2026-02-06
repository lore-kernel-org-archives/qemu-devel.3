Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BABECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCOf-0001rz-PR; Thu, 05 Feb 2026 22:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCO1-0000TC-1k; Thu, 05 Feb 2026 22:20:02 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1voCNz-0008VR-Kn; Thu, 05 Feb 2026 22:20:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNgUJmj8SLX8pTdyrMwkGSkvOhrq+t3lB3iVlR4uf8J7QdzDXV+clYWxfUh7AsQdcbTheNMlHozuZVOk9ZYY2FOimBh+9IsQHR5zMf5i6CXk2/XqPdH9ak3po62LdYMrlX/GZ3SIQ1JEtijKBIShzgB3dAR3/qc2I20IjcvP++AxSdpjPKcJ9UiuEQWNfc/4NjuAWiBlwwjZ6/DAG7Qfohn4Lffxe1+tLTNg9U0NfSF8jIZPjijJDTSXM83OCnQwH9CrDHXlIuma6Zrbl6u8jgpCjyJJWu7hGBnS5kl27IG/Pde24h6hfJcW1ubjqdKXRehJN/1K5fj9BlkskU7ufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BARTMde8tFM1kJAldWJbGHVMgJJXQLOTGN7MHLbF2Ko=;
 b=ORJ/P7vTxZHziC1Iv61WEzTk4PbWhmICRd8mkm96ehMqXvmNxEkMDK7dI2z3TRMkRek2wzvUVvR5Uv+wHaBJjpfL/hn+tZyw0MkkLcozZDYP5X+DdApP+KyOt00fwngmQU3RAK/MrS1SOf74E2+V90BnG3VLcEm4V7MtulpKRTx+195CpEfODqG+vKC8pKazKgbBuOWD2c0ffcRWA78u2/AHyB33a6kDVLIUtR9nohyT4+dcMTGoEuSduHHgoPpac5NtrFo6uFhPLnIuYtM9IuM7HUsVvHQ8YFv0JLn2zTOiUClA757dGod7E83va6b5Ubc0v8w/XE0paWBm8q2d3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BARTMde8tFM1kJAldWJbGHVMgJJXQLOTGN7MHLbF2Ko=;
 b=rvltI6N7xmsG11HwL04AikqLRDgsVNGvowlchBK9Vxd9oL7Bch3TeDq1AyLx8T0/UxaBMIyUt5bvooS4Bnw0KWroZJFYK6Hn8SGW6O9c9CcafYt8lObgB/kxTixJInAPJZfkhYjsHmHHxLEKUA8O7pUVimj7HDrNzFWlWEhsPuHfDfi3XAlCZnmP/bO0ob+smmKEi1SLGETO9dwAlFvYVzoCEYU4v7EQ6soir8bzbClfsxKlXGNzpcnoBIn+ZsIQLfdX0zDbi1VloUaPRTE24VFGFWUtU9AxmqKJ4xT57dexclKJS73yzJb5Yg6xFsPbM9nD4bZjCyvXApnduoFM+g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TY2PPF4DD1DCAD3.apcprd06.prod.outlook.com (2603:1096:408::78d)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 6 Feb
 2026 03:19:53 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:19:53 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, Joe Komlodi <komlodi@google.com>
Subject: [PATCH v3 18/20] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Topic: [PATCH v3 18/20] hw/arm/aspeed: Build with I3C_DEVICES
Thread-Index: AQHclxd2DdVUppI1HEewIHDbXTdayQ==
Date: Fri, 6 Feb 2026 03:19:53 +0000
Message-ID: <20260206031926.3227848-19-jamin_lin@aspeedtech.com>
References: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260206031926.3227848-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TY2PPF4DD1DCAD3:EE_
x-ms-office365-filtering-correlation-id: b5dc851d-0f63-41fd-3be0-08de652e98a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?D3FzX+6pAJHE32PZiLAzTq23fDEO26W8wG1qTIttiJOLlGx61ZDA5sFf8I?=
 =?iso-8859-1?Q?m1RZrOmcc8/NAtRJ2Y2yIxrWJZYsEqReQIHz/RooN+nlx7PcIUSQKNz33e?=
 =?iso-8859-1?Q?WWVyRWwOE1KDO9gY1r43L3jX0VjDdoC+M+8Z7nt2vvNN0iHwoMm+g4WqyD?=
 =?iso-8859-1?Q?7ZX2Nn/Dzo7H5GJqqdJxklTs/8/28m6xaQ6qMgAZMi5Rpx37ad19ddMUl6?=
 =?iso-8859-1?Q?qLc4t9BbS2QmbXIht5g1+NXgwjCHT9GgyyLc/WjmdcFDEGvIR18AsWZCwb?=
 =?iso-8859-1?Q?lAKK2MKworqB+c9g1d0wQ0BkNW/Z5T+YVQyk3XvTcFTEHL7W+Y3RYn4cAI?=
 =?iso-8859-1?Q?vevjJ9hMprqXlLhauMqdm3PKy7ZeK5y5gS3um37dtnQCVx1aJefibWXLjQ?=
 =?iso-8859-1?Q?dEH/L2I0MK2hvADzr+zH15g+fbtoIqHb6XD0U4V/49Iv0qyPW8N9aDR0fp?=
 =?iso-8859-1?Q?FHDuTVZN0fWxBuhma79uEz7vylpLPcfz0RwOKu6Yk63EPSKjFsMqOHaKXH?=
 =?iso-8859-1?Q?pVDry1Cc3ozvBSxa78Fy73LsrfM96li+dIVrrEKq8uDqIaq0uKO92fv4pO?=
 =?iso-8859-1?Q?/fhfZWQDRKp0fPYIC80j+UtN4QSfhKUjq40jP+D8BFObdMvk7erqtrDVR3?=
 =?iso-8859-1?Q?kRbp83GsfM0RJCUcBt1I7cl10+KWrQDsKd/QKhFRkK3o6y3Jv5D1hBEmYE?=
 =?iso-8859-1?Q?N961uFX1E5pbyAp8sPBe0MA6NQehOuAq1MiC9S6s35ZHbsTkpQePz0M+tf?=
 =?iso-8859-1?Q?MiH6qk4d830I6DP6+jBKkuG6JF68NOH3xt/4XFs3C/6T1kCsrpiQ+KzFSA?=
 =?iso-8859-1?Q?gddkN3c+CA7INVem1qvQ3Kg2c7SNBMCA2ilQgOV65obsoApE7rTjGAx4P+?=
 =?iso-8859-1?Q?GVjN52zARpxmk+uWJUihteTcq6hxSgOUYN2l4oDrZjZHSoMTjQaoGAqzEL?=
 =?iso-8859-1?Q?K/nCJuQTTDrwEhqAJP8KhJzqkOT7/U7CBObTBKBYyg9lfeAhHY/KAVS7GS?=
 =?iso-8859-1?Q?afSpA66Oj3SxeuzlIwd4oV1wHgq0KDK313ZH3TdjG4SoO7NMJcjUDhfqTn?=
 =?iso-8859-1?Q?eqCmqn5+KuZRXik28IPnyqh6EliSFNvsZo5dShkcJI+oh7tqksiYIBAOnU?=
 =?iso-8859-1?Q?6yhe6ZT/lq9SlaZuUjwoKFkkE9MpTHIMSCSxzWwpSpm6wJQ02YWT9ILBVv?=
 =?iso-8859-1?Q?/VFyEw1rIjB5jKgcq/6nZrm9pFpZk1RbP0fBhDnpjhiIkzrtapgUeAc6DD?=
 =?iso-8859-1?Q?ikaVuROF/AwTYPL7djs4SS9UJwDk4VaC/FMqOHkzd4CEyEr48HCF4KCnm1?=
 =?iso-8859-1?Q?EfeObvLVdDVwDgzORrBjN+KGab+VzU/4nmavK57baezKc+oo4vTbtG6skf?=
 =?iso-8859-1?Q?kGtknrct5p5HcYZndSFmz8B5tYHJZqFgykv5Iw0ykOjlzv29CBXQnPswCx?=
 =?iso-8859-1?Q?gBWvKwYpUj/sacyw6LEJbOf9TMBSFeXuOW28yMfIzTWbKwQhgwFutgbaDb?=
 =?iso-8859-1?Q?+lxCBzOdlLA38i7aiCBh4Aaj5K5n1H0tGEs92B3T9fgf+ZIWwWqNGH+4/b?=
 =?iso-8859-1?Q?DBWjd1LsNRxF7PsLTCIW4rmxl6JFUHq6fOOUKGfqjHaIh91Orl8TbgWR0e?=
 =?iso-8859-1?Q?NzFMrqNujUhs9g9ktIBHRAgWvtnqvtSm+VC+7y5Tq9p1ilhsvhXGWRRuKF?=
 =?iso-8859-1?Q?DgCqaO6Wzb7H/IDh9RrIeJ4S+Fe9n2hr0M2XcG59?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cC7mUv0P1qC19mMIft+Fphcvb0+6IG0xIcy8OhHZh3flPkHVyUZMnNthYi?=
 =?iso-8859-1?Q?Xhjamhsx9YVow1o4rO2C5tkgqZH/x3iDhFgsbufcQjP+/4PIRrd+tYGEg/?=
 =?iso-8859-1?Q?YQ4cvLwf2G3pnOPBfe9xxSQK8d/xxKxbujI/Zs0kdRZbnu4I9bWnB2DP8/?=
 =?iso-8859-1?Q?a/UUsOuzbdIJaNXhdfn8GJ0juMf9K/AEBuwJx8MceCizPDhCpyLN/VaSQo?=
 =?iso-8859-1?Q?i3LKmDSY88ZBP+vV7kTAzVv5DfZhvKsar5tAyFO0ZDKQhxqb/kFDEivbv4?=
 =?iso-8859-1?Q?aPVeNEUrGHM3Sb1FWSKi/lG/rLLdXUEji4OgnfPiz+BakQKGQHDJr+4zN2?=
 =?iso-8859-1?Q?XCuvjZ4yi//sP0V9ttCNGNPN++9JqUbZ4I681zmyXE4KXqgoqeb5Kboita?=
 =?iso-8859-1?Q?nLOLrmW1GdTMrL7ktDVl/5n/ZJFyeruE35y0WO8/SkobdI+9KIogleQZ22?=
 =?iso-8859-1?Q?RsDi6uM8ZzGZIVuqJLt4Tb57X1cT/GA8gYXCU+JnSvwm1Gf+yw3pUj4lXy?=
 =?iso-8859-1?Q?IHLqytTvGr+kvl07Zp8efWe3VeVnvU1FgsbFxs6FfQhmCzb/vcyhvtRjZx?=
 =?iso-8859-1?Q?C7smGoQVNwP+1EFtxRKffsoIIki7wZUYGvze5EP8yDBRmDZWXqEmOYKVEs?=
 =?iso-8859-1?Q?UtVbKQOBPrWRKwSbzcqzOoOuoj6UDYnj3dzVhAORe/IbzydgeUF1fchZW8?=
 =?iso-8859-1?Q?sBt44nGDXS2/FSzDqOdyFjwxPQMkVB5DzFOdM2lm9IbhKswXUAZ2UfBTR7?=
 =?iso-8859-1?Q?wGjSIZL4p3OtQ3nmJVanwMsqd6teaLOY6OFWH6uKg0kf6lucTWZMSXJ6E0?=
 =?iso-8859-1?Q?Q11dMZlrDZ0rrPtagG4WVLap+TEovtuWe+V6hHMloqEmCkyil45OnIk2S9?=
 =?iso-8859-1?Q?ReS8272+9bnNupHwxyEnj2eScQS6t/uakrKeomrMtCQtMBEGcueevagww5?=
 =?iso-8859-1?Q?NIRWU288Qz5hioOkrxVyN5ChwQ5vocLE4P+3GIQeMagDIlNogMHAelgn4b?=
 =?iso-8859-1?Q?z6QU26hv3nWKvhC2RZlqs4Jd5bMmof4zIZzPWdcx1mjnzusRDdYODFgww+?=
 =?iso-8859-1?Q?7jyRJGoCBixgmK0LbUWX5ze2sM07VMBCclvXpC1Jqu1CHcDyiHCyMyS4gF?=
 =?iso-8859-1?Q?v4CxKR51bKpIdtlnJ3VxdrNbD2mhBvcJSzEEKzdYT189oj513pL7yqzqtu?=
 =?iso-8859-1?Q?vND9o59S1WcMR7UrwnCqaZP+obfRnZEC+3AtLaqj+naSzE+cps/XEVQxOZ?=
 =?iso-8859-1?Q?BTAXXzouQ6vx3VncZeQXAZXpzZciF3G2K9fzVS6DFhDNaAZdmxgwZ2B/x+?=
 =?iso-8859-1?Q?4vWFLQRXDxjzMGv49/OUcgNFZPO9V2Hom9oQdcntmwMPvjovDwXuVj6nzN?=
 =?iso-8859-1?Q?Ya+x4NrqsSSGwMoTNuVBiRIu0M/VhG2BleNt2lWpct1cZCIFSro6ZcehUh?=
 =?iso-8859-1?Q?Dm1/X9b0AY9tXKTp14GDxLtiLqgyA7sbpOYG2mAMr0RAYmIxHlPNv6AgPd?=
 =?iso-8859-1?Q?O4TNmrpFcNqFNEiVTSKoJsq4i873D8G33ATtioGVsmxPY+j3yR6V0ZJXjx?=
 =?iso-8859-1?Q?PH6nkJ8jN4ybc/4WDjJPNe+zFUZbv/HVcQWSntCY8PIUMEm02aqov3xAfC?=
 =?iso-8859-1?Q?Sat5smJpC9CPtyRL7RVyUIDYIIV+J8fZoNaNUw8+t2P5K/DQiT903jbNOb?=
 =?iso-8859-1?Q?e44h0cDLFZIKKdjlA8jWkFx09P8/PAkEpzhXqtPEY9mZTvHBlhtGDZxJUa?=
 =?iso-8859-1?Q?t1xjIYwaborGMHRZxV0JV92qrPEa5VZ/VIldjz0MsO7o9MfDCm3/uWCo0P?=
 =?iso-8859-1?Q?3Cl914EOEg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc851d-0f63-41fd-3be0-08de652e98a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:19:53.4795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XV4xypClQHGJTR7irkay+WCbv9sRi6qNuq+6p9OEtWwhoURa2VwVTZkVdjHJNr6XNYymhDM4FYrUsrN6bwWm8IOCCZl/Wc1wrABO0ctecmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF4DD1DCAD3
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Allows us to attach the mock I3C target=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/Kconfig | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig=0A=
index d545ecd712..3396a32fd7 100644=0A=
--- a/hw/arm/Kconfig=0A=
+++ b/hw/arm/Kconfig=0A=
@@ -547,6 +547,7 @@ config ASPEED_SOC=0A=
     select I2C=0A=
     select I3C=0A=
     select DW_I3C=0A=
+    select I3C_DEVICES=0A=
     select DPS310=0A=
     select PCA9552=0A=
     select PCA9554=0A=
-- =0A=
2.43.0=0A=

