Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CF2D172CE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHf-0005vo-Bi; Mon, 02 Feb 2026 01:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHe-0005uo-1K; Mon, 02 Feb 2026 01:19:38 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHb-0003NC-Vp; Mon, 02 Feb 2026 01:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUSJimKs+Up4z2AC5CA4GjAuIPq7sgTAuAz6p+fow5+6g7XR+IxW1FRZHH4zPdEMkrIFk5A2zOqiV6Yr0b/h4Ig+9g6Trbz72o9ADM2Wm7zSUiDt1BduH6fj5APfWbjxenjKw6BZz/t1O/0VCGHqS7sHN0FM2au/yHcNEge2WOF7fyG5rsqHJTFZuyKxrsZnXACEHzE1VyZEI6+Cas3SnkWt2o5YWorqpV5NhktbEfgIheNneVvcRd1s476t7C7KiIdjt6s2UUHhRVw5126CkGoBnuCaJZk38keuE/3NZRIxrSLZpuobUO6Z3NYCJ+XoKWqH1wfZJ9ScjDC5x/nmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgv75juDt1dm2Vt6SHB4KavwjICzmpOsQEthtCM/7PE=;
 b=p20PNf/ISR55ATaAsaxbu9Z9MpDKI48Zk00BZEkuwpsy5HyG/8mAPBmhkhhIX8h8K7f4dylM8bpav8QDEhuaAer9vN+UQgArjZHMmr/JsVv5dEcYH0hdBxJHtZQ8a2kR6zQVVJxm/DMY8s0anqDJO1HFMMrGvK5oAsLVqB+wtgocWD6QOuzV6oKZerQcy+iVsu7QCOJDbMv1HBlxdSZq6MrypeWbXZEGrNYL2rjigtFgacm/5mIc9yUWo2oaChE+dw2DbKGphiizRgqMVk+7R2O8/YRZgNFXPrPr9cNPySWvma2L+GSKPRzUvU0xWyfh3d3BHtM7fMQw0l8ck/jvcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wgv75juDt1dm2Vt6SHB4KavwjICzmpOsQEthtCM/7PE=;
 b=rjkS28IeJWt8Hb7g1it1VGmL9ZAyYfk5iwn9W6w2zS7+kt5KPJEF71hRxtOBsbBaOwwUspzezFjQN2UoFwIb5NkvK+3D1UHEpbnFkQv5ZyTHGQMI5RwsHgUrqJtp7FC9AU+CdJKzGDlNIPzzgeHFi5TsAmLR70OR0Mbcf75W8voZHzB9XKYBerE+YSbqeVHo83EQZ6ZjuVDkzPajKFfTH0RHxvcutU5rsrrhkEKunjJEEJSDC9PffGriwZ9458TBDvQliJ0DKx0dFcHQ/ziFvlxHLcLt3VF5J9jy276i6tm1ggpJZNRZ5mniM4TQlCVRPGRg50ZQIErClCWp3Nz3Rw==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:28 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 2/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap tables
 by address
Thread-Topic: [PATCH v1 2/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP memmap
 tables by address
Thread-Index: AQHclAvgzVmEkFyrJEunBeK3hliZeA==
Date: Mon, 2 Feb 2026 06:19:23 +0000
Message-ID: <SE3PR06MB81994C77A1BFA4816C9DF699FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: a837cda3-80ad-49ae-f360-08de62230521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xgyCzmlU4tIgjRXoeScqT6d0jZKHUWEE/stsD2EUqbX9M4qPyUuYX5aLZXzw?=
 =?us-ascii?Q?ZtM3STKrwln3XZDosnJ+C1wkVU3wRuA9+GqlL61qSXmlMXh/dHprlZrY9SQu?=
 =?us-ascii?Q?0cO0+tGu5RK5wMekv7Hlcuv8rLYHvZgEAf2B39J2772WxJ+AhkjjATq3Jtrq?=
 =?us-ascii?Q?qO/QYpTIxv795etKYypphi769Dl1okDdiRm85a+pWL0NmMV/VtzNBXgAzCfy?=
 =?us-ascii?Q?NxxSLcZKzY9TO35QBgDRuLeQ7HXFQeBGyWC2Hxr/UuCguKlPUd47zk6l9LML?=
 =?us-ascii?Q?sAL0C/DCrtcoOwca4w/qfbUB6pqrq/fa9DmPtZWblAdeg5Evwbj9PCsbrh7N?=
 =?us-ascii?Q?IdE6O2phdT1S5HIVHtpMikArgJ7g8MNptworTcDbaWaqOcJz+MxWSPAQcdUN?=
 =?us-ascii?Q?WtDUJnedJ3TZUa/VHgdwsyz1/qDoPbMxd9BtNKcRjkDH0XPrqaXMlqK8HJ7B?=
 =?us-ascii?Q?Vt59uNXXWJ3bspSU5VihXhRVzi7GGP9ZK4vzocqnRN1LoYXGFa7UGsmiOP4o?=
 =?us-ascii?Q?vZRqNiljLYsBYWTVa23SwIIM2meFebL8KtvBXosm3hVR8bIl3cY+Z217kLJv?=
 =?us-ascii?Q?CKxyXXE5w7E/y0P06MOc3BoVL5ds2SWKDmb87nJS1YgTlkcdO1ge1GGsc6OQ?=
 =?us-ascii?Q?jQLx9vUGeD59bbWXxkptmuw2sJUhSZ1LC4habCSAGudDdQpgESUg78UpqJMW?=
 =?us-ascii?Q?n3lwZHXjtbKuxypKKLwMAcH7SJm6wGs+pZv+7giM5dhETN2pP0Yzr92wzKX5?=
 =?us-ascii?Q?4F7yQ42L1u/7hg//8qRWx122W7RM8OwAGxuQqzE9vvRv1Sr8P1NyHw/f4szB?=
 =?us-ascii?Q?u8qRMjJN2MBM7Vw20++4Uiuct2xHBFHf0l833P398zCKW/zLsvjPZxT6+Sa6?=
 =?us-ascii?Q?P6e38D9qr1x3ZctphmrOYVP3wD1PRXo/AHx8mGtBx64jmxxpd39Mxye87K8/?=
 =?us-ascii?Q?7jyy96imppnlmcD59q1IXFWMcqjIiDkU0frpv6SIY1sdfsi1ONOwlDarPxvo?=
 =?us-ascii?Q?bZK39tD/77z1rLppyg48HMHorb2oKjoJ3/nCzViHbIFbPIks9F9e7wqmMnSu?=
 =?us-ascii?Q?r+WadJ2mZZkYJ1rbAXioFeun1tqGJewWTg2os/Eot0XOhEUMF8e1F5Se/s/V?=
 =?us-ascii?Q?QQZqTQGI1g3RHnX56h3IpvHoS+vVjChMAlLw/7292WcMD6qyKvF+widGfePq?=
 =?us-ascii?Q?lenHN5MFaj2DAnUIqsYwGHt5k/MNCch7Nd15L/mQzIvLVj51xQZCk8MNwfTB?=
 =?us-ascii?Q?UAhyJnBpBGqVc4XCp9u/GALq6iVf8TNiuI9q1mbWdiCw2BzQ0mgoywQL0ook?=
 =?us-ascii?Q?98++Lvj4/k45pq3KL8FMGm+KLuc9zMq+2qFQ/DQ8QADUT2SYSf+Jhofg+KpR?=
 =?us-ascii?Q?ihfIZyRb7nl6LT4KArjcgLemQH/pjvvu7PkSPsxn6A3VzUZsq0mNogthXVQO?=
 =?us-ascii?Q?nDWNn0TWDLY84hmVKp/wVLh0EQRV0x+oxTbERVNqRdubS+Tj4sc9jV0uu4ao?=
 =?us-ascii?Q?tg8eOJRVcIhFqgds1SRth2JAar7mvHdlaEQM760c4rrTItAXSMBzykGY3n2/?=
 =?us-ascii?Q?n87mkkA7AQYbz+iUsC/W2ZJGvu4iAveh35oSRTR7xson+L4sf5H8J6sCXNMP?=
 =?us-ascii?Q?+p5Fb2JAgJHCeKlcRh9USvEn6glSlqGaZnHUWkf/ZriC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bSRyo7V+XlGrvh4s8OguyZqjJ97EIGixsE3+eAGellx0p0MzsT8BuA0S28rl?=
 =?us-ascii?Q?X8sG6bR32C4NwlCet/rGzWm3KR8LVWduQYEhSKGsqyR5dsbviojMr757sOVM?=
 =?us-ascii?Q?MX3JsBEtMvlZRziaewTNGLue7gSgHrgqCphlFw6nuxgraZ/ScyfgtrmM22cm?=
 =?us-ascii?Q?pNRYk/IC1//uiQepZAIeo4EdtHNOCOgJb7OzlFu2gBhB4Xzvk45I6EhRfwit?=
 =?us-ascii?Q?XUMVJLWZrxVoKfe/zCcEZQN51ieqIvN+OtCHzf/58BCtQ3JJ884DKyC135J2?=
 =?us-ascii?Q?4i5smXLdTn8OmPFjwhCtcBox4SMQ5RZ3dNzP5rB4JrkmEF9bsTgWKIoCccx7?=
 =?us-ascii?Q?ItikaBqklnf7oStNRV0tQ+h3Xq2yIKtDovKvmnpOniUUTZ2feOir/DvqE24a?=
 =?us-ascii?Q?cod4T0B+mZZMWjj+zH8Ct4EAXFGfqRzTOR/ip09WYbI68ek4MviJ90DdIe2/?=
 =?us-ascii?Q?cC9IO1SXgKyv4Vze3Z/ybhpuuSVVLvfyYvx60vDDxPClhuhcUf1ffOHlluV2?=
 =?us-ascii?Q?PvuiSZU78EaRRXEYZMzjvkYECGHBHq6hJhUpzQW0G4fQcXz2s2Tj0YAiRZ0J?=
 =?us-ascii?Q?aR0Cm6CM8h2aOysk1VqFOrAKZqmwOrP/69cIa9B5K+c3/Id1x+fh6o7dRXDq?=
 =?us-ascii?Q?S35iqWp3TjfVX53nwieEPqQ7B5u4Pfko7vYiRX89+tILuvYLOy4lg5q8esJ3?=
 =?us-ascii?Q?SqKpHuL83zsj9mND/2YkPb9AOjmJpBBzuMRUOVd900czmImYiZtoJBE7wjmT?=
 =?us-ascii?Q?+MvvPt16UD0lvi8zfiVfWxLovQwX5VbLIbZPULjx4jcDk+cfHU/yIUCJRnCC?=
 =?us-ascii?Q?BT1CG75KRdgZJ0FcmlIy5GO3+YrY58J0ckPCIzAdMMTbgCf+3ZKJsuW6ewCF?=
 =?us-ascii?Q?+mm9zPdp5IVXg+ES3aG2QPtrJYx7/4h3IN/bYot33ZOz1SFlaKPt+4TeFqx3?=
 =?us-ascii?Q?5uQUYwKKTLix7d1jtWIm4OE5WAlyag1zmeTdtaTu1WJs2tQOS33xq1iY6Bnh?=
 =?us-ascii?Q?wVgEGXtzNeegcO0iDpHzD52cCVZyYl0jFJGGOhKm4y1ldl0JRRAHB78g+O78?=
 =?us-ascii?Q?mUPM0BFHtVf2Gyzm0J0TUeyhGTGxxR8XvuUo/o42sxUOWV8W+X8EALmQkdEs?=
 =?us-ascii?Q?b1yp4TN9doaVU3OtePwQS4cHUzECWRbbb56otvZA939EZEsYU/LPNVeT9N2Q?=
 =?us-ascii?Q?gP2uJsbxIWInTCUtnqiJuuDaUG4Wou04xBB3u9C4iDQcdAMruHV7dP6BgCzz?=
 =?us-ascii?Q?AyacgpvfpDoKDABRtB8ZOzvWPvQbyq52cD8o3NqcSCzyB6d+HfY4/+LqLEIr?=
 =?us-ascii?Q?nnVhdqOcbDtPbngS980Rcuq3gnnSIb57uDjMNw3D4iF7XKzglkiy/Mijtkr5?=
 =?us-ascii?Q?3tHqP4NgWijyCRw4Q87OlkFnoFvYDUThPw9WEEriU0Xd4RQ8JHgpFkqFMNTF?=
 =?us-ascii?Q?Tofd+DEFICj14qAVWOj/xcy8bRQroMDWfb7wupMNQ6ed6D5xB3k6aNIUM6Er?=
 =?us-ascii?Q?9hWtEUUHQUTp4Xro57uRgpMLEdDHpQkSFDNtrlmjRIAeGzZcRU/vSQBYsE5B?=
 =?us-ascii?Q?z9QKdNMrqV0In73jbrxvQxXuCcod7XGXBjnlxF3GZKsswToQTtjUEs3sjmFd?=
 =?us-ascii?Q?gBQFeKccj+a18FPow97wAfxv0sgfZ+inOa1OfpEXTFaPBxRekvXso9WcR9jn?=
 =?us-ascii?Q?zM5P5s6Yza3/pukBnycswSwFYPZH+T8h6WdUxcx/I7fQ0Xv2LaNmPm+NvZoK?=
 =?us-ascii?Q?9MX/2+rNJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a837cda3-80ad-49ae-f360-08de62230521
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:23.9460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVi6N/LFKlmT5vAnWMSRSZFi1VlwnNiM9VqYb/bqwiNQw9HUw43ST283sKIhS4JEcZq6rEB9lxMwdk/YKdq2lXXZDn50w4zJEDqLxPG8iPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
Sort the SSP and TSP memmap tables to improve readability and=0A=
make the definitions easier to maintain.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/arm/aspeed_ast27x0-ssp.c | 10 +++++-----=0A=
 hw/arm/aspeed_ast27x0-tsp.c | 10 +++++-----=0A=
 2 files changed, 10 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index cee937b37e..e4bcf0fa2a 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -23,15 +23,15 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
+    [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
+    [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
+    [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
     [ASPEED_DEV_UART2]     =3D  0x74C33200,=0A=
     [ASPEED_DEV_UART3]     =3D  0x74C33300,=0A=
-    [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
-    [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
-    [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
-    [ASPEED_DEV_IPC1]      =3D  0x74C39000,=0A=
     [ASPEED_DEV_UART5]     =3D  0x74C33400,=0A=
     [ASPEED_DEV_UART6]     =3D  0x74C33500,=0A=
     [ASPEED_DEV_UART7]     =3D  0x74C33600,=0A=
@@ -40,7 +40,7 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_UART10]    =3D  0x74C33900,=0A=
     [ASPEED_DEV_UART11]    =3D  0x74C33A00,=0A=
     [ASPEED_DEV_UART12]    =3D  0x74C33B00,=0A=
-    [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
+    [ASPEED_DEV_IPC1]      =3D  0x74C39000,=0A=
 };=0A=
 =0A=
 static const int aspeed_soc_ast27x0ssp_irqmap[] =3D {=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index 9c11c016ca..68683a15d8 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -23,15 +23,15 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D =
{=0A=
     [ASPEED_DEV_SRAM]      =3D  0x70000000,=0A=
     [ASPEED_DEV_INTC]      =3D  0x72100000,=0A=
     [ASPEED_DEV_SCU]       =3D  0x72C02000,=0A=
+    [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
+    [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
+    [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
     [ASPEED_DEV_SCUIO]     =3D  0x74C02000,=0A=
+    [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
     [ASPEED_DEV_UART0]     =3D  0x74C33000,=0A=
     [ASPEED_DEV_UART1]     =3D  0x74C33100,=0A=
     [ASPEED_DEV_UART2]     =3D  0x74C33200,=0A=
     [ASPEED_DEV_UART3]     =3D  0x74C33300,=0A=
-    [ASPEED_DEV_UART4]     =3D  0x72C1A000,=0A=
-    [ASPEED_DEV_INTCIO]    =3D  0x74C18000,=0A=
-    [ASPEED_DEV_IPC0]      =3D  0x72C1C000,=0A=
-    [ASPEED_DEV_IPC1]      =3D  0x74C39000,=0A=
     [ASPEED_DEV_UART5]     =3D  0x74C33400,=0A=
     [ASPEED_DEV_UART6]     =3D  0x74C33500,=0A=
     [ASPEED_DEV_UART7]     =3D  0x74C33600,=0A=
@@ -40,7 +40,7 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] =3D {=
=0A=
     [ASPEED_DEV_UART10]    =3D  0x74C33900,=0A=
     [ASPEED_DEV_UART11]    =3D  0x74C33A00,=0A=
     [ASPEED_DEV_UART12]    =3D  0x74C33B00,=0A=
-    [ASPEED_DEV_TIMER1]    =3D  0x72C10000,=0A=
+    [ASPEED_DEV_IPC1]      =3D  0x74C39000,=0A=
 };=0A=
 =0A=
 static const int aspeed_soc_ast27x0tsp_irqmap[] =3D {=0A=
-- =0A=
2.43.0=0A=
=0A=

