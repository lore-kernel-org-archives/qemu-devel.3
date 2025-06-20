Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0E3C7115A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 01:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSQTw-0000jj-LW; Thu, 19 Jun 2025 21:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uSQTt-0000jP-UL; Thu, 19 Jun 2025 21:23:50 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uSQTr-0005Sx-CA; Thu, 19 Jun 2025 21:23:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEEpSRqm1t4c1aPg2Jcvd/4YDzv8dQJRDmozvRhl2KcN0W88tzezhjxd0OiLA37AmnzuQwYka7dkwwWgOT0ZcJ36jSVIh/3/WP+8ardCy9UMeio56oiy0RDxQGNnDlyg1yv6JRfN4ZDnY5bkPANFQ+fYQ9cchDiacclXeaAUToSH5yme+WGK7mb37mQ4yPt3eicN8XC0Iwgw6iRVWXiSvDqw6z95lP3G59tNixS1rsdce9UjrFnlhBM4T9wgvuMxNFFwe9AY9JhE1N4l9tH/QKZt4ydSGjm+geKMtLGzc2l52c+YivgWQYjNRmhVGoAdQnskep7WktjpLVh6OiPJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXRGdixDSjWjnL+5GYT52dmzWQcTeWvwHW3QwJo5meg=;
 b=fozotyt65Ki3KP1Q/Rayo6CCJYnjtV6Mk+AsYKrpr1q7cJlyxn7ElON6ngL/bxSrNIbJTk/9uxPtwlA8qzhfyrqLHfjpyspJwxvav3OXL0rT8fANFmORpj2HyTD3Xi842RRTdbxChCZ2vo8uzfRNWtlWKUYtqdjn+Z00ntnnoOw7vOsgM56xCJt12f/avOJEMbDbMPV6SFN6fijzN/rPRZDnMIkBrdywW+nXdGrzjqHETFPVFwYGAE+woPfet2If5/csQzDCiDMIk0T3boK28CL8ssBsiu49JwR0O7oYmyRztdMzriXRuTVSlF5gPAtbbWqSKa69O4nu9afkruMfXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXRGdixDSjWjnL+5GYT52dmzWQcTeWvwHW3QwJo5meg=;
 b=cXdm4MK4SUg5TaEJvZmWQ9LwkMgMt6wEPlrj3Mlc1F9V6iEaQVnYJdOdaxpPma10Jo8EYnc8cWtrz/6tDoJ45IR4i+zl//p0cgBSk0V8B0QYJQWszS5U4mpnCAR++NqCl2CvOp4ZHfmmhQ+ZLuBPzfYGtzCk33iRbTvbuBCjhv+17oq1iF+LqiIALldb0gla9wQLNm+3rG1cd80iQrFukMFG/g9JfXyb4cHMipnuLY5Lf9/QttdHAZLB70hA9Rxf8VusX4HXzDHsiW9IoXp4pmZpiw1zUvSrqKOXXs/RMrFczlKftmNjh209tJTqZflU+cCOLH2PntXp82rqZe/Qsg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB5528.apcprd06.prod.outlook.com (2603:1096:400:28e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 01:23:32 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 01:23:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Tan Siewert
 <tan@siewert.io>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v4] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Topic: [PATCH v4] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Thread-Index: AQHb4PeprLsGkdJb6EudWpgWaDPJ7LQKYR0AgADgCxA=
Date: Fri, 20 Jun 2025 01:23:31 +0000
Message-ID: <SI2PR06MB5041A8B6109499DDAAF298E5FC7CA@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20250619085329.42125-1-tan@siewert.io>
 <c58bf387-a484-4cc3-a4b6-76cb955c6b0e@kaod.org>
In-Reply-To: <c58bf387-a484-4cc3-a4b6-76cb955c6b0e@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB5528:EE_
x-ms-office365-filtering-correlation-id: 48d6f4bb-a190-4592-898b-08ddaf9911b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b05wYm92citibENlYjRDQmZGanNaVXQ3NEtuZWxhTGdaa01DV3hpZmw5WmZj?=
 =?utf-8?B?NXZwb0QzU3QzV2dOa1hGRjV0ZWJ1cWt0VUYvZUxOTVdiTFJXNmQ5Y2VPVTRE?=
 =?utf-8?B?WG5lS0Y2N2s4bDJjTGc0emlIbFhYSCt4TUFWdjBFSEd6aWdFSGYxcnVqRDdF?=
 =?utf-8?B?Zk9KSkUwK2xsV1VpOG04NTRibEZ5ZExBSzdjeEIrNjh1bWtIRzVUbnJzZ3lZ?=
 =?utf-8?B?LytSaXJWeVZLVDc4UmNFYytTVVdWaUhmSllUcDlXZkRYMURsaXFJL1FnN3ZN?=
 =?utf-8?B?YWwwOTR3eFBhaDE1Ukw0TVVuTGxKUmhpZmFqM2Z1WVBJQm0vYk5rUExsSmRD?=
 =?utf-8?B?b2dOVzFnUGNtdWE4R2dvRzBVNDFEdGhTd282SUxQTldsSXorS2xOVHZCa1By?=
 =?utf-8?B?T1RuSzZqTDhncVhEQ3Y4dDZQRmE4bzhIQjZaVmtXSkFZd0NQWTBZdHpHaVNB?=
 =?utf-8?B?eElNak5mdUp2VWpVSnE2QWNwM0V5M09QTjBDWHZwSUQ2b3M5VDZWYkh0TURs?=
 =?utf-8?B?c2UvTG5kaGdsOGJzbmRHOVR3d1ZEM1RKWkQrSzVzSFU3VGJadURKTEl6ck4y?=
 =?utf-8?B?NXlXNWkzTmp0cEJLd0ZPQld1R0FYTk41NXlZYi9OaFlSM2dHTXVLVTJjcXdo?=
 =?utf-8?B?bENlQXN6UXdNb05EZlVocjVUZ2xFK2pRV1FIVlhvQ1p3TkVJM0VMOHEzVVU5?=
 =?utf-8?B?bGtrdlZlcVVOVXc2Qzc3aEp4cFZJYUFjaDErQWdYanZVYm9VWGxsaW1tRElo?=
 =?utf-8?B?MFdEbnpOemcrZjJhYVpLRElqVEVmRXFqdjJSWFRDSjRpcHBhVXFEb1FWUHd6?=
 =?utf-8?B?cTRwcGdrT1RCcldoZFo5b214dWRYaksydVRnT0lrVlVDUW05UmdtbFMrVXAy?=
 =?utf-8?B?Z1NnWEh1TEZDUGpWNTFMazVpUFR5d3FYckp2dEdLYlhnekpYbkNqN25aZUE3?=
 =?utf-8?B?VTMyYUJ6N2diVWh6MjR1WVFQVk9QanlZUkNpNXBUanBiNnRiUDd5NHZudUdm?=
 =?utf-8?B?cFFmWXNRbjFIQm1qUnBxUjA4REt5YU9MU2RRUlY4TDlLRzBVN1NLem9KTGpJ?=
 =?utf-8?B?ZTRUVmd6NXM2UlcyTzhyd0U4bHhicHJ0TTF3MGppVlpZd2w1UEQ0NGxtZ1Z2?=
 =?utf-8?B?RkNQWnBFUFhaejJoczBjZGFFRDQzNUZnaEVzRlhRaEdnUWx1Unh6VWh6N1VK?=
 =?utf-8?B?NElMRi9ncVltOEtKZnZkWEhNa2kxcDVzcllVTFFyM0JSRVJWdGVCMlU2Lzha?=
 =?utf-8?B?U3QzTXdMQk11Zk9wdzFBL1VVR2IyVVJISmhkSmhTQzc2bGZod1FsOFdXNlVu?=
 =?utf-8?B?QWZXTGJKaitmVHp3aE1QalJFZHlmMSt0cjQyRjNmYVdocmpDYmN3d2I0UVFI?=
 =?utf-8?B?TUVONndCdDJVWUVCT2xTaFM5RTBBenBXclRybWhIbHBPa1JNQ0k4RG5peC9r?=
 =?utf-8?B?Q09MNHJkejlJeVlVNnNxU21OK3h3a2h4ZTcwa21CZDc3Y0dlWWttaEhjV3hR?=
 =?utf-8?B?enRuL2ZIZDhtWnpxYngrMkJJRWFCdWhwYXJkMXpKR0tIbFVGMy9hUzFZckRN?=
 =?utf-8?B?NGtKMTZOYndMM2FXeUpENDhYZHFDV1o2QzEzNjhnVG80QnhRY0FiSGYrd2Fm?=
 =?utf-8?B?K3hKU1NlQm1IaGZiNzc0WnJjK3h4cmRRRjhxVGd3Q1JtWHNRSGJIeFFyaVd6?=
 =?utf-8?B?Y0tXT2Y0MmpsVTdWTFU1RDlsM3pBZlBjanJtOGdiazBGalFEb3EvUmRDVWVq?=
 =?utf-8?B?eGh3Q0ZrYmk4VVdzN1NOZDF2WFFVUUlJV0JFVGdhZ0xoSTV3MjBMYkRGUzZs?=
 =?utf-8?B?L1owdkdOS3ZhdlIrMXlXbVJmcUZtOE00blprQTlIdW9kbnVtb0pia21GalRD?=
 =?utf-8?B?UlExL1FaazNaY05HaXZ0aDQwM21FTWtZV2Y0UElpYm5PSzhja0lLcWtKUEsr?=
 =?utf-8?B?SzBsZFNRd1U0WXJWcVNoREp1UVV2R0dVZEJxNXhWRWVkbGRZb0lONG9ZV3Qv?=
 =?utf-8?B?aUhzTlh6WElnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFJKdDdHc3J0Wi90RGRqbHBQYUt4S0xKWHZxUzVQMVFLMStvYkhmSjd5MzNK?=
 =?utf-8?B?bTU1aHJ2elp2Z1FyYUpJYU9ROE5XNWI1cWlHeVk5LzFHSUdmSU1zaHNVdmRk?=
 =?utf-8?B?ODRqM28xbEZ0eERvVWFwR1h6SWp4Z3YyNlZpS3RqM2k1VitrUnNWMFBkSlA0?=
 =?utf-8?B?bmxKK2xrYklaaGdpbUVvU0RGMnVzaTBUeVYzczNsVWdyNDZEdk9WcitaeXpE?=
 =?utf-8?B?WWlBcnpMams0SHB6Yy92NnNSWldLRW9YS1B0QjB1MG56dTNkcTQ5aWdzc2NF?=
 =?utf-8?B?dDNnait2UXRndXUwMGQyWWZCV2REUzFvcHNGTHpsblBQa3F5RGZkOUVEMVh2?=
 =?utf-8?B?R0ZjcktFWFpRdzlma3ErejhOMUx4bkl1QjFrRUp2U1BGMXZDdHRFR0YweHBC?=
 =?utf-8?B?ckZ4UkQ4RFN2NFZWdmpZSzNvTUEvRTRNOHVDM090NmNzNHhqK1FmVDN1ZVpJ?=
 =?utf-8?B?ZU1YTkdSa2dtUEt6WnU3blFEZUw1QWhmZktwMFdISUlKekc3TVJpUHQyRVZa?=
 =?utf-8?B?M05kRTRKVjBiTWQ2Vk1ZM3FqMldKbnRhOFVCL0U3MjNqTnJPWnc1V0haWXBW?=
 =?utf-8?B?eXF6ZXBNVkhqZWQxM1RuSDZYcE1DZUtZenVlM3NsMUFLVXdsRjNUQk5hSWZs?=
 =?utf-8?B?UldFcTlYQ2d4RURkMWdHRUsxc05LKzU4d1BZVVZZUENtZlVuQ2Z0VGFYTWw3?=
 =?utf-8?B?bnBPVjQ2blArUWVoRUdhakQ1OGdhcTRxeCthSlFjMy8xQXZJTzdQSkZNc2M1?=
 =?utf-8?B?MXhNQVdDQUZoUmlMelc4MURJTFExSHFzb2t3SzU0WFhQSjZpVzVYVi81QUJt?=
 =?utf-8?B?OTVqVkVOM3E1K2NaMzVJZTlpQnlHcEpUelU5NUM3aW5pQWdFMkVMRWV3OStr?=
 =?utf-8?B?UEVBR0dVQnE0WlJaZ1dwcm9YVHNUd2tQbCtDN3ZyalpPcmRQWUNEWGQwMHZw?=
 =?utf-8?B?dVhGQ0RycUhZWGxtNkxtaFFQanRXa0tTR2lKeUI5RVYwRWZOMytveTVLeFZK?=
 =?utf-8?B?dzJQa0gweEJBdFczOWEzZWw0R2sxV3JDVFlWNDdnNW5pN1dCMUFnYWhiL2pq?=
 =?utf-8?B?bldhV3RxUFF3SDNWR3RSa21hVWQrckFIbHhMa05oTzVsRGliMDlSNVVES3Ix?=
 =?utf-8?B?UitSRnJjQWtXem1sWm83cWhseUpOT1hncm0rV3RZbHdQNFNuS2k0K1RXTFlF?=
 =?utf-8?B?OHhTUExzSnR6SkQyZFZYTnlNbStYZkl3dmgweU16dHJsamNJby9ldGhCUXRE?=
 =?utf-8?B?eW8xdFdWVkYxUThiQzhXR2lOck5JMmRBemRRbnRpWk1ZUDcxc0x0V1NDa1pT?=
 =?utf-8?B?WXV5MlZSYUZ3bXZES2xxanpaSkowc0VnRFkrNWlJTDZWdzhXVkt1eStDd1E2?=
 =?utf-8?B?WStWaktyV1RuVFQvUGV1eWdzWVRuY0tzbXVHSkEyQmV6dXVwYTR0Z2xjQ2Qw?=
 =?utf-8?B?L05XMzIydVNYa1JzbllIL3gvU3hxTUFNMG1QTmJnOXpZUGdkbjcrK0czZ3p4?=
 =?utf-8?B?bjFoUHZ5VlhPVk9hVTE5Ym1IdFJNSkZtdkpVU1BkNzN1TnNUT012aTlxYkZD?=
 =?utf-8?B?NDBnYWI0Qjh1UC82VS8wTlBCN0tHRkEwMGVSQjJVNXoyK3ZXZFl5TURrbDVu?=
 =?utf-8?B?TFEzbXp6Wm9WZS9oaS95MWdhNW5kdGtzdGx2Sjg2ZTJMSEdEL2NvWndmY0hx?=
 =?utf-8?B?NlNIL01sV29XT095ODV5QjB2SmJ3WWNVcHZqRTF0WVpSWTd3YzZqdEFKQ1Mz?=
 =?utf-8?B?ZHQ2NUpWQXdPRXd5VnNYaTI4ZkNSMkM0TEZYUm5Sa3NITCtXMkJLWjEvSjBD?=
 =?utf-8?B?YUpiS09EMStWbDJGREFqTmhZV3g5d01vSXhtbExEVlh1c3lGZWpRVUEyWFI0?=
 =?utf-8?B?K3IySkdwL0V1c2pxY1NQOXVuNk5wc0JFSXkvUWxXODQxdWNEQ2RqVURCV2lu?=
 =?utf-8?B?N2I0NVVlb2V6ay93Unp6YlBKVlg0cTFqdmZOdXF4NUE1NjZXdG5ic1NhZU1L?=
 =?utf-8?B?R0h3Qy9ibVJob1l6THFzalBDTmhHWUdFY0NsSU5NQm9GYUFRaE9FOFlQbThq?=
 =?utf-8?B?bmpBeEtITml3TjBTSFZIa1JDYTVOK1JweWhlc0loSzIwRGdhSlV4ZEVNQkM3?=
 =?utf-8?Q?O4D7k4xyw75ZbWboewbW6RefY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d6f4bb-a190-4592-898b-08ddaf9911b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 01:23:31.8326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Egt+wAh7k/joKLVqgySNQbd2N942MYlfeWCsrctiFVhTNEfE2XQUZmMZkQ0aAQqHR7J28p+vSuD0NqVjkwAXinDwmF+wXFjvXqwV6jMMHLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5528
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIGh3L21pc2MvYXNwZWVkX3NjdTogSGFuZGxlIEFT
VDI2MDAgcHJvdGVjdGlvbiBrZXkNCj4gcmVnaXN0ZXJzIGNvcnJlY3RseQ0KPiANCj4gSmFtaW4s
DQo+IA0KPiBPbiA2LzE5LzI1IDEwOjUzLCBUYW4gU2lld2VydCB3cm90ZToNCj4gPiBUaGUgQVNU
MjYwMCBTQ1UgaGFzIHR3byBwcm90ZWN0aW9uIGtleSByZWdpc3RlcnMgKDB4MDAgYW5kIDB4MTAp
IHRoYXQNCj4gPiBib3RoIG5lZWQgdG8gYmUgdW5sb2NrZWQuIChVbi0pbG9ja2luZyAweDAwIG1v
ZGlmaWVzIGJvdGggcHJvdGVjdGlvbg0KPiA+IGtleSByZWdpc3RlcnMsIHdoaWxlIG1vZGlmeWlu
ZyAweDEwIG9ubHkgbW9kaWZpZXMgaXRzZWxmLg0KPiA+DQo+ID4gVGhpcyBjb21taXQgdXBkYXRl
cyB0aGUgU0NVIHdyaXRlIGxvZ2ljIHRvIHJlamVjdCB3cml0ZXMgdW5sZXNzIGJvdGgNCj4gPiBw
cm90ZWN0aW9uIGtleSByZWdpc3RlcnMgYXJlIHVubG9ja2VkLCBtYXRjaGluZyB0aGUgYmVoYXZp
b3VyIG9mIHJlYWwNCj4gPiBoYXJkd2FyZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbiBT
aWV3ZXJ0IDx0YW5Ac2lld2VydC5pbz4NCj4gDQo+IENvdWxkIHlvdSBwbGVhc2UgcmVzZW5kIHlv
dXIgUi1iID8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCg0KUmV2aWV3ZWQtYnk6
IEphbWluIExpbiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KDQpUaGFua3MtSmFtaW4NCg0K
PiANCj4gPiAtLS0NCj4gPiBWNDoNCj4gPiAgICAtIEZpeCBtaXMtdW5kZXJzdGFuZGluZyBvZiBv
ciBvcGVyYXRvciBpbiBsb2NrIGNoZWNrIFtUYW5dDQo+ID4gICAgLSBNb3ZlIFNDVSBwcm90ZWN0
aW9uIGRhdGEgdmFyaWFibGUgb3V0c2lkZSBvZiBzd2l0Y2ggY2FzZSBbQ2VkcmljXQ0KPiA+ICAg
IC0gRml4IHUzMiAtPiB1aW50MzJfdCBtaXN0YWtlIChub3cgYm9vbCBhcyBzYW1lIHJlc3VsdCkg
W0NlZHJpY10NCj4gPg0KPiA+ICAgaHcvbWlzYy9hc3BlZWRfc2N1LmMgfCAxNiArKysrKysrKysr
KysrKy0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9taXNjL2FzcGVlZF9zY3UuYyBiL2h3L21p
c2MvYXNwZWVkX3NjdS5jIGluZGV4DQo+ID4gNDkzMGUwMGZlZC4uMzk4MzJjZDg2MSAxMDA2NDQN
Cj4gPiAtLS0gYS9ody9taXNjL2FzcGVlZF9zY3UuYw0KPiA+ICsrKyBiL2h3L21pc2MvYXNwZWVk
X3NjdS5jDQo+ID4gQEAgLTkxLDYgKzkxLDcgQEANCj4gPiAgICNkZWZpbmUgQk1DX0RFVl9JRCAg
ICAgICAgICAgVE9fUkVHKDB4MUE0KQ0KPiA+DQo+ID4gICAjZGVmaW5lIEFTVDI2MDBfUFJPVF9L
RVkgICAgICAgICAgVE9fUkVHKDB4MDApDQo+ID4gKyNkZWZpbmUgQVNUMjYwMF9QUk9UX0tFWTIg
ICAgICAgICBUT19SRUcoMHgxMCkNCj4gPiAgICNkZWZpbmUgQVNUMjYwMF9TSUxJQ09OX1JFViAg
ICAgICBUT19SRUcoMHgwNCkNCj4gPiAgICNkZWZpbmUgQVNUMjYwMF9TSUxJQ09OX1JFVjIgICAg
ICBUT19SRUcoMHgxNCkNCj4gPiAgICNkZWZpbmUgQVNUMjYwMF9TWVNfUlNUX0NUUkwgICAgICBU
T19SRUcoMHg0MCkNCj4gPiBAQCAtNzIyLDYgKzcyMyw4IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9h
c3QyNjAwX3NjdV93cml0ZSh2b2lkICpvcGFxdWUsDQo+IGh3YWRkciBvZmZzZXQsDQo+ID4gICAg
ICAgaW50IHJlZyA9IFRPX1JFRyhvZmZzZXQpOw0KPiA+ICAgICAgIC8qIFRydW5jYXRlIGhlcmUg
c28gYml0d2lzZSBvcGVyYXRpb25zIGJlbG93IGJlaGF2ZSBhcyBleHBlY3RlZCAqLw0KPiA+ICAg
ICAgIHVpbnQzMl90IGRhdGEgPSBkYXRhNjQ7DQo+ID4gKyAgICBib29sIHByb3RfZGF0YV9zdGF0
ZSA9IGRhdGEgPT0gQVNQRUVEX1NDVV9QUk9UX0tFWTsNCj4gPiArICAgIGJvb2wgdW5sb2NrZWQg
PSBzLT5yZWdzW0FTVDI2MDBfUFJPVF9LRVldICYmDQo+ID4gKyBzLT5yZWdzW0FTVDI2MDBfUFJP
VF9LRVkyXTsNCj4gPg0KPiA+ICAgICAgIGlmIChyZWcgPj0gQVNQRUVEX0FTVDI2MDBfU0NVX05S
X1JFR1MpIHsNCj4gPiAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsIEBA
IC03MzAsMTUgKzczMywyNA0KPiBAQCBzdGF0aWMNCj4gPiB2b2lkIGFzcGVlZF9hc3QyNjAwX3Nj
dV93cml0ZSh2b2lkICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsDQo+ID4gICAgICAgICAgIHJldHVy
bjsNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAtICAgIGlmIChyZWcgPiBQUk9UX0tFWSAmJiAhcy0+
cmVnc1tQUk9UX0tFWV0pIHsNCj4gPiArICAgIGlmICgocmVnICE9IEFTVDI2MDBfUFJPVF9LRVkg
JiYgcmVnICE9IEFTVDI2MDBfUFJPVF9LRVkyKSAmJg0KPiA+ICsgIXVubG9ja2VkKSB7DQo+ID4g
ICAgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLCAiJXM6IFNDVSBpcyBsb2Nr
ZWQhXG4iLA0KPiA+IF9fZnVuY19fKTsNCj4gPiArICAgICAgICByZXR1cm47DQo+ID4gICAgICAg
fQ0KPiA+DQo+ID4gICAgICAgdHJhY2VfYXNwZWVkX3NjdV93cml0ZShvZmZzZXQsIHNpemUsIGRh
dGEpOw0KPiA+DQo+ID4gICAgICAgc3dpdGNoIChyZWcpIHsNCj4gPiAgICAgICBjYXNlIEFTVDI2
MDBfUFJPVF9LRVk6DQo+ID4gLSAgICAgICAgcy0+cmVnc1tyZWddID0gKGRhdGEgPT0gQVNQRUVE
X1NDVV9QUk9UX0tFWSkgPyAxIDogMDsNCj4gPiArICAgICAgICAvKg0KPiA+ICsgICAgICAgICAq
IFdyaXRpbmcgYSB2YWx1ZSB0byBTQ1UwMDAgd2lsbCBtb2RpZnkgYm90aCBwcm90ZWN0aW9uDQo+
ID4gKyAgICAgICAgICogcmVnaXN0ZXJzIHRvIGVhY2ggcHJvdGVjdGlvbiByZWdpc3RlciBpbmRp
dmlkdWFsbHkuDQo+ID4gKyAgICAgICAgICovDQo+ID4gKyAgICAgICAgcy0+cmVnc1tBU1QyNjAw
X1BST1RfS0VZXSA9IHByb3RfZGF0YV9zdGF0ZTsNCj4gPiArICAgICAgICBzLT5yZWdzW0FTVDI2
MDBfUFJPVF9LRVkyXSA9IHByb3RfZGF0YV9zdGF0ZTsNCj4gPiArICAgICAgICByZXR1cm47DQo+
ID4gKyAgICBjYXNlIEFTVDI2MDBfUFJPVF9LRVkyOg0KPiA+ICsgICAgICAgIHMtPnJlZ3NbQVNU
MjYwMF9QUk9UX0tFWTJdID0gcHJvdF9kYXRhX3N0YXRlOw0KPiA+ICAgICAgICAgICByZXR1cm47
DQo+ID4gICAgICAgY2FzZSBBU1QyNjAwX0hXX1NUUkFQMToNCj4gPiAgICAgICBjYXNlIEFTVDI2
MDBfSFdfU1RSQVAyOg0KDQo=

