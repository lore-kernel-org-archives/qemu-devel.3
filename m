Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA8EA3F28
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlo-0001Ev-C1; Tue, 10 Feb 2026 04:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjla-00017h-Iz; Tue, 10 Feb 2026 04:10:43 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlP-0004iv-2j; Tue, 10 Feb 2026 04:10:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2p0aqmoq/VI4KYAzYn9DbOvaRIYhzQPrFBFD+LaL1s0Ps1pCkGXNU6GoTnqueYRnMCAV8Cz5BUbsb5tZMmsj48Y89lsgUh10v6YtGvXT3TR5Xh9V2fVjhnaUbOxFwXuR8nqiy0efGwrRkQ1UQq7+DQr2CYM3nnbn6/kafY4KoAz2tNB6F3rtEd3cJrX6kCDTz2HPIAC2sbN/R8HJcYK/B5Y2kzR/HIhDKwIzfER0tpu4J0g7cYzaWkacaP74mWsSHhuy08t90Ph+MLv1Bz3oZzd8K+d86TltTjVdaeWLcNkdq7LXlRZTc+eyxF4f3lLW4GAq7lgGOV2OjKEfYxt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gYQnBAq34sWYxliQDOyox+onivinbcmbdCmRpnGio=;
 b=pOFSBuV8ChenLSjvO/cvCO7S9Y9V18s0kiZyLRe52alLrX9tx4OQ9POfInj3rmENaFMnsGgrgVVst+UxdV0dmgWx/0Pzw40bLme1dIYZceMXQIr5kfCGfTzJOoMrXUMMgPeCLJyJ0ttz8q0g5zCJGAGGLs+ZjjbmJnYW6mHMcLaZ0kd/RS0vnP7ntEE6lojJwYnORHL09Nb+9pJ8Z+gO6k0yyojMhHTMRZTCTIjdurDeot3nPPa/IIo6so84Y5x1kLiM/vKcya/rszmLIkLjkYj0BT4Jm6KakzbZbugJDNOJXEoPF12nPmRFvzD49LuwsDCZH9taFCfKZnP3JfVA5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gYQnBAq34sWYxliQDOyox+onivinbcmbdCmRpnGio=;
 b=hFyJAMiCtH5hWAH5jj4WI0OwOoeADbVYQ2OAQ1v2O+Z/BT8vl2Xaw8uQgngPyJDXUzGZZfHZcqDAvAEbAJi0PvwwbB36oh6Bo/OyYPgKVpqIkCLZvvDRxOjdmR+REHChiIT1eZtFBUlH+gWlSCmBb8+FU7xrFv8KCxyDLrZvYbbGPGy1Ns3WONqmlZjv9WNDM2ogyilzoW2b4CmO6RevIWD/4OFjMfrBtraels3tGs4UFd+/Na2wAn5K/ULdxXfcmEjAVLwzBqp02XbNziMeJBXrol9Zg7tFuY1TCcKK+99UuocF0ofBV+CJEfmD5ppefIvhfFqTF0APA9uFufGhaA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SG2PR06MB5216.apcprd06.prod.outlook.com (2603:1096:4:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 09:10:23 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:23 +0000
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
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v5 02/21] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
Thread-Topic: [PATCH v5 02/21] hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and
 align parent_obj naming
Thread-Index: AQHcmm0WThx8Q8HAsEOOmYBLnR3zGw==
Date: Tue, 10 Feb 2026 09:10:22 +0000
Message-ID: <20260210091018.1553489-3-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SG2PR06MB5216:EE_
x-ms-office365-filtering-correlation-id: a6b224ba-fb97-4d92-c921-08de6884392d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IakWq2bjlYEZgC6pinOL6AaE1vFHwKay1YIcLA7rMkuHTfcXF8Q6UtlUoq?=
 =?iso-8859-1?Q?6ue0akJD0h1oeqUbgJYuA0efKV4G7DIyGQKnN8YuTTuUhP9+3YkrTXBjeP?=
 =?iso-8859-1?Q?Dqbq9gDwVILElm7dIiv86cJzoswWdpcToIvBPQp2u+jWCmUh7j3xVoVM6Q?=
 =?iso-8859-1?Q?fY2cIAGVQ2Vblnuk13fY8wbjbCbUr9+yXJ/RSw5uT3DoJZsdR20mEmn80n?=
 =?iso-8859-1?Q?9xc46XuEwaszn0yUqwExepvSLfNEgG+yu2DDWatqz74cNIDE9Ehatqrpnx?=
 =?iso-8859-1?Q?pNsDK4ItGlbAtoSFeMBryMyWznpC4epRfoEC/Pbj90TPqrLly97eLcxp+X?=
 =?iso-8859-1?Q?sZqe3Ys+35gu48tQpMyCfaHOv56noaPhPwPk0oPGeXM7cJODp+bk9DOyUB?=
 =?iso-8859-1?Q?8KyxwasNCeYmGf6g3rrokEJBlHij8asN05te3y+D1JCWDVREUbYPBA/CGq?=
 =?iso-8859-1?Q?52DkSG78pe9RPyAjosT18faj9Yl7gkwlzy4CJu2bl/TAnNvZA8O1G7shC0?=
 =?iso-8859-1?Q?XQTYoPRiTM/sCY5fWvknS4Q6vvxxnhvClinvjoBAgN1UjORH5V9w0U3J8i?=
 =?iso-8859-1?Q?w1+6ceSW9aGNh13LXgDgGjXT4i6W31KMuiNZYl029ui/cZLtxJ/Pfk8OIh?=
 =?iso-8859-1?Q?lgJGmLHNsaVl2k+9aQSpGl1lwlUbdCgdXk/JfQBV2CLLlHmVpOumOevQ9i?=
 =?iso-8859-1?Q?7DuRF6EoZ226PzNSK2N6mmA0bkeXDuxxCaAkgpgyDn1Hf5aauKkFv7CQJL?=
 =?iso-8859-1?Q?5kD5oOJzPFYNMzgiTdK3PluTBi0/oHj+sgLJdYDsUKOPd7EseGoCe1R05P?=
 =?iso-8859-1?Q?Yv2T5A1u5mEEwKk4wU+uq/paSLPuS4Q/DkSPDlVQr1ijaqFo9C2d3mhzem?=
 =?iso-8859-1?Q?/bdmjYmky8jSIJArocJYVWX+fMQiygy6KkLaCzXc+IeXz1YsmV08ODK0FA?=
 =?iso-8859-1?Q?KN4T00mNnmaEdaIsDuT/Tz1Gl5G/FRWV2zwTTwhK4mfQ8h6ISjh276v+8m?=
 =?iso-8859-1?Q?JE982bdB870rYlPbcscOevaXZGK6+uFTHZapD0lZ/HM8CWEsFo5Jqtzeol?=
 =?iso-8859-1?Q?VOOYCIJ8u4Z5SFedcV8sIucIBW1iPMuEi4xlcZJ06GROz8YJN0xRAXmSRV?=
 =?iso-8859-1?Q?nT9GhNQXJsf08Gn0A17BiOcdFESBbqrKQrJq+sXIDc+zBwaqmlzg26w0I4?=
 =?iso-8859-1?Q?jR4hkQzt61G80qqS0CF3qBJXtczD+sl51jpSa7XKJ/LDSxBqqGdTmT0dg8?=
 =?iso-8859-1?Q?tMv1m38wCwj5dVWFyVdsh4jj+O9sPq41XMedK7IwsnQMqvQcxP+QjwGchc?=
 =?iso-8859-1?Q?qj7InMMaYpjDvgBI++l/TDDdEQ8qEl10UETmGxFr7/3NfAoBc+uqpDNVdl?=
 =?iso-8859-1?Q?kXIBfbxinYtYPxm1I9QHo5EccGR7sSjxPnK7Wiwjm/4BU9ycLxxHPqdKoN?=
 =?iso-8859-1?Q?fQrU+BSe3W+/U70SJAfJ/Crb6UNIu1KeqMaxkXLH1lY+I3KE9EZUNQrjLA?=
 =?iso-8859-1?Q?8HCYDe1qMolK6TnofX74NfAGWsg7HR5cVGFslqw3PO8YeHNGLtT0rl6Y1O?=
 =?iso-8859-1?Q?ZUCQzTRgAGGbTH6vEFnN9FNx1T3hTI6OI/qDF5dgee8hSvcTW1MPUN4sG+?=
 =?iso-8859-1?Q?ggMzguyQK1duBMXKQ7fMtZTRHKiOcGcrjSUyy6A7n65PC5Z3kdib0JBmtA?=
 =?iso-8859-1?Q?vdrztVrSG2Pl5IU5YBjVTjrG4hnrnU7R9Lvq1fPe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?byNR1c1zFU4mWwsmcaBWO3iURaoJjQhfqXs0MLaohuNpNN8Yd2dNJLt2B2?=
 =?iso-8859-1?Q?RCwpjUvaydT1shfesQ4CEHOAlje3t7Wj6HKoFIMY4aXFLF/OlIg7evYAhM?=
 =?iso-8859-1?Q?/GlF22QPxaFE4e5clHojgVf8MZXRh5hM4LFPLU2L7VgFOwECUJVPc5e1hU?=
 =?iso-8859-1?Q?j/UocnKbUq7dpgSMnUIZS8WCndmCLRfmIn7QAltCv8nQWnoI5oQWvtGWP7?=
 =?iso-8859-1?Q?2u9NiM8UmSKRPSHjsqCDaTZ3oL7JVvst+vFf4XGzH9VBxNF3ohCeshXY+L?=
 =?iso-8859-1?Q?UNS3TBprkLJM+HsuXtMmAP2OFUIBGGGn1GOlKVba3XXYGWm0Q+izDXiqtt?=
 =?iso-8859-1?Q?tfzQjO+f54f6Ek4h9TfPUCL5sAOxNMaOj+Hjg2Da2JvFDi9aTJwp+JRy1x?=
 =?iso-8859-1?Q?f2GkPZto+AWCBbDDPxE+0PnbwXdeLt1uWg/Eg8TkmXvHjyOVldzvHRSCA0?=
 =?iso-8859-1?Q?DqA8jLAxOMiBaTEmxsAPotXCpr20m3DbmCvVa0gcb42133XQeCwU3yDugK?=
 =?iso-8859-1?Q?+8XhxGlgAvm27fPXk+HJY0ODjd2qXoIiDMD8WGhbqc0TJzQf2saPbUcv0W?=
 =?iso-8859-1?Q?fySMyvTi2MqQObD879nrzui2CYHC9D7ubJTApr1UBFuUIDKHQGdfzT8VKK?=
 =?iso-8859-1?Q?IPEaDePPgjfxHtLgZxtdylBLP6tljBS/sUj+tkoZfh6cj7F0KOrtClR0D5?=
 =?iso-8859-1?Q?LRX/FdtVIClw1HLYcA7HC8BdKeRVwfU7YZPifrsjU0Btlje81YnDuUG86Y?=
 =?iso-8859-1?Q?fTXcNPtxg3sBfriybRfRiFgCxGsP3y8Jv3JHwMAfrsgs7UM4yr2dMI8vPg?=
 =?iso-8859-1?Q?VDd+kPlFz1biiwBdtziUOIiugeg4Bla86XUPpF9cxEtBUuF7eHHnPdwgyg?=
 =?iso-8859-1?Q?xjz3P7R9sVlAjcxNnXvyvL1dDhjruM/8CLtgq0XdQIY1Y+Zt9bChWFmJSN?=
 =?iso-8859-1?Q?om661b9Oye1p3JEISQsdZ1n/aGO7aqDT4vmgL1XuZDLHx/vnR1QTsFswCK?=
 =?iso-8859-1?Q?AAAurqVJX7g7uZniO1IZtouS1h7Pc4dWZylxyUxk1Uqx5OeTmRK3ZtKdtF?=
 =?iso-8859-1?Q?P+Ct6dhbTxYVMNwgtpqjXmy3EO5Afs/RcialKi2CG2Rbza1YgpePYQ/ese?=
 =?iso-8859-1?Q?dtkObyGikGKBi2ZrEinDHXiQ7LOuZJDT1Z3tjjCfVOweJb8TAESqK3NhA/?=
 =?iso-8859-1?Q?1z8dkGAIYq2cn5z8eh/MxNJHa+67hEpJ2nB+OtbQE8laThnyZGD45JTiJN?=
 =?iso-8859-1?Q?WlT4qeEKBceW1lebKledWbwWK/yJRmgfqSxOv+H/mzMk5wuA3vvz/JBbHg?=
 =?iso-8859-1?Q?SIqFaKHznX+780+/TeCEa0OVSEpebYGW2UjqphGgQ8rVpAtphdIYlAQaiF?=
 =?iso-8859-1?Q?vCpQcd0tdr2WziHsX7eIV+JBaY2E0VHQuPJvRox4VoXsEJmXnQ0He2vzi6?=
 =?iso-8859-1?Q?lPyDX/NehVJ9NmL7RLxK2C0mTEZnljPrWmTvF1tiuq2pHsBVIVcp+Iuupk?=
 =?iso-8859-1?Q?U5rc+0zVtPS/CAXttU7d0r7pjenWfcb/xvogtw9gGqW9dbxp72jpLKcb4P?=
 =?iso-8859-1?Q?gZ6bvMHLoHOZfb/cHgMOdxGCzXXtNVIggjBlobuOdMe6JMSAss6COaOn0f?=
 =?iso-8859-1?Q?fdsP26F81gWBcwYUWycMhahj8QhNi91tWO9o7VzxOxiN2YsmGvYw4mzrwB?=
 =?iso-8859-1?Q?MHTbotFlepUHM1UOlErd9/XZZf1beoz7PgaapfPQRdx7GW5rqJC9zj6+zZ?=
 =?iso-8859-1?Q?lzYVylf1VNr7sKs0JRiZ8LKOfQt2fElcgzZq2aH18z5mlWydpqN8/DzhRP?=
 =?iso-8859-1?Q?CK/clY2Rhg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b224ba-fb97-4d92-c921-08de6884392d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:22.6926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SDH2oMjGH9nN8fMTYTJer+4rzF0l75HXUIYSQiKnmqhsEqNtJ41Rhc8dw6FQmIRGQnte0b0MmONTvslYrZSDec2bBA7ZkmgRVEHm+OvIDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5216
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Following review feedback, update the Aspeed I3C device to use the=0A=
DEFINE_TYPES() macro instead of an explicit type registration function.=0A=
=0A=
DEFINE_TYPES() is the currently recommended approach in QEMU for=0A=
registering multiple TypeInfo entries and avoids boilerplate=0A=
type_init() code.=0A=
=0A=
Additionally, rename embedded SysBusDevice fields from "parent" to=0A=
"parent_obj" to comply with the QEMU coding style guidelines for QOM=0A=
objects.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i3c/aspeed_i3c.h | 16 ++++++----------=0A=
 hw/i3c/aspeed_i3c.c         | 35 +++++++++++++++--------------------=0A=
 2 files changed, 21 insertions(+), 30 deletions(-)=0A=
=0A=
diff --git a/include/hw/i3c/aspeed_i3c.h b/include/hw/i3c/aspeed_i3c.h=0A=
index 7a984e1f01..bd0ffc84ea 100644=0A=
--- a/include/hw/i3c/aspeed_i3c.h=0A=
+++ b/include/hw/i3c/aspeed_i3c.h=0A=
@@ -21,28 +21,24 @@ OBJECT_DECLARE_TYPE(AspeedI3CState, AspeedI3CClass, ASP=
EED_I3C)=0A=
 #define ASPEED_I3C_NR_DEVICES 6=0A=
 =0A=
 OBJECT_DECLARE_SIMPLE_TYPE(AspeedI3CDevice, ASPEED_I3C_DEVICE)=0A=
-typedef struct AspeedI3CDevice {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
+struct AspeedI3CDevice {=0A=
+    SysBusDevice parent_obj;=0A=
 =0A=
-    /* <public> */=0A=
     MemoryRegion mr;=0A=
     qemu_irq irq;=0A=
 =0A=
     uint8_t id;=0A=
     uint32_t regs[ASPEED_I3C_DEVICE_NR_REGS];=0A=
-} AspeedI3CDevice;=0A=
+};=0A=
 =0A=
-typedef struct AspeedI3CState {=0A=
-    /* <private> */=0A=
-    SysBusDevice parent;=0A=
+struct AspeedI3CState {=0A=
+    SysBusDevice parent_obj;=0A=
 =0A=
-    /* <public> */=0A=
     MemoryRegion iomem;=0A=
     MemoryRegion iomem_container;=0A=
     qemu_irq irq;=0A=
 =0A=
     uint32_t regs[ASPEED_I3C_NR_REGS];=0A=
     AspeedI3CDevice devices[ASPEED_I3C_NR_DEVICES];=0A=
-} AspeedI3CState;=0A=
+};=0A=
 #endif /* ASPEED_I3C_H */=0A=
diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c=0A=
index fff259ff66..e7cdfbfdbd 100644=0A=
--- a/hw/i3c/aspeed_i3c.c=0A=
+++ b/hw/i3c/aspeed_i3c.c=0A=
@@ -337,13 +337,6 @@ static void aspeed_i3c_device_class_init(ObjectClass *=
klass, const void *data)=0A=
     device_class_set_props(dc, aspeed_i3c_device_properties);=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i3c_device_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_size =3D sizeof(AspeedI3CDevice),=0A=
-    .class_init =3D aspeed_i3c_device_class_init,=0A=
-};=0A=
-=0A=
 static const VMStateDescription vmstate_aspeed_i3c =3D {=0A=
     .name =3D TYPE_ASPEED_I3C,=0A=
     .version_id =3D 1,=0A=
@@ -366,18 +359,20 @@ static void aspeed_i3c_class_init(ObjectClass *klass,=
 const void *data)=0A=
     dc->vmsd =3D &vmstate_aspeed_i3c;=0A=
 }=0A=
 =0A=
-static const TypeInfo aspeed_i3c_info =3D {=0A=
-    .name =3D TYPE_ASPEED_I3C,=0A=
-    .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
-    .instance_init =3D aspeed_i3c_instance_init,=0A=
-    .instance_size =3D sizeof(AspeedI3CState),=0A=
-    .class_init =3D aspeed_i3c_class_init,=0A=
+static const TypeInfo aspeed_i3c_types[] =3D {=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_I3C,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_init =3D aspeed_i3c_instance_init,=0A=
+        .instance_size =3D sizeof(AspeedI3CState),=0A=
+        .class_init =3D aspeed_i3c_class_init,=0A=
+    },=0A=
+    {=0A=
+        .name =3D TYPE_ASPEED_I3C_DEVICE,=0A=
+        .parent =3D TYPE_SYS_BUS_DEVICE,=0A=
+        .instance_size =3D sizeof(AspeedI3CDevice),=0A=
+        .class_init =3D aspeed_i3c_device_class_init,=0A=
+    },=0A=
 };=0A=
 =0A=
-static void aspeed_i3c_register_types(void)=0A=
-{=0A=
-    type_register_static(&aspeed_i3c_device_info);=0A=
-    type_register_static(&aspeed_i3c_info);=0A=
-}=0A=
-=0A=
-type_init(aspeed_i3c_register_types);=0A=
+DEFINE_TYPES(aspeed_i3c_types)=0A=
-- =0A=
2.43.0=0A=

