Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94167C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 07:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcevv-00084U-WE; Mon, 05 Jan 2026 02:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcevt-00083u-Pb; Mon, 05 Jan 2026 02:23:18 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vcevr-0005Nl-JT; Mon, 05 Jan 2026 02:23:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NBHST/ylEocsNPSysMwPpjUWQevYoF7EYvp0daDKzAPLvKbW+wthDvi4xnNvmCISkDxlCJyV9ZvP/D4W2bFa7rtlNaiREYun/rTHg+WUyAMqoyQE5ZDOf0OxbX236Iuyd6bRytwM2tmwFASKV5c7h65A2EAzw7QfvSVicCK62M50AUuYQKw30vZcP3fV4uLSKfC9nO5dLonpj6YfJ2TUJVwTMP6+xwAMkD7bL6JTtXXw7lKO6vq6IxM9NbqZbXFRZRRvS99xVpeXMenvCrybxp8euY+oUzEVwi6wHdX7FEQy0aPNm8qKXq39zQqKf/+BeeYsNR+tDHAroyP+NcLQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEOpYPc0tMmjJjHdMlrxmSE+nV9EWLr+EZ5lZHmftQ0=;
 b=k+opmyhBBStIKAKK4lymVYGs2eOkAQ7hz3xbuHB+KvPgwZFyHscgeUECJDVnZQe/2HxNfnsJxR3dJ1IWHvJQi7RlBu9SGXIHORozcQ3XFsycUK0Xhfg0rrE6XykmRfl/iUo0dlW85/xjAyCJrdrFdgunnllw6xRzBY0shOYl68Gp9JXXJT+BnGJk/km42uwWSI1kNf6Ok9K3vnnIwRw/cvyX3ARkYcEEXiInFB5JVGobbU0cQcBNvMDQLD7zWnWIyQ8DvjJOAbx8LEu6Kv6ZmUEcvmVzlLiifcD5w/BLAeQVSeFSvrKFFtt/QsdaHy60Lx4t72v8NxnfknVAvdAaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEOpYPc0tMmjJjHdMlrxmSE+nV9EWLr+EZ5lZHmftQ0=;
 b=ckAZhjv4AuGQVvomVKRTL0JIOf57NKx8QYz3EXndDjC5SPQ0tm7kjwuoq2GkLGYqeXHMZ4Nz4I9F4W7Ny7c0JueaTiL2jHu22VZ0xA1QbuJZG6ICHUzdczrDtp7B41LB8wLElo3dU+Mvuhwr/P1eKJv0jO6mn8aXHDzKPgIN19jGKHcGk+Ew9rqAQwHvax1E4UZvYvkBSHZkx0rJGFxkOKw0cieJKhkH600UeTFGhCy/r5DO5ZbTQ+GhIwL5Zbn3DOMDI6OT2wwaptlDTUWwK78Zbu4v8j+SR5Y24hhKlkdUI8O2mcVHeopfN7eiMfwAmlkuuPs5PjNYBUzuq5Jr9g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUXPR06MB7999.apcprd06.prod.outlook.com (2603:1096:d10:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:23:07 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::b420:4392:6eb0:91e5%3]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 07:23:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Joe Komlodi <komlodi@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "venture@google.com" <venture@google.com>, "clg@kaod.org" <clg@kaod.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 08/19] hw/i3c/dw-i3c: Add register RO field masks
Thread-Topic: [PATCH 08/19] hw/i3c/dw-i3c: Add register RO field masks
Thread-Index: AQHb2/a69N6iv3Qb+UW2cpzsiRhITrVEby+Q
Date: Mon, 5 Jan 2026 07:23:06 +0000
Message-ID: <TYPPR06MB82060801EFF3D85E695284EFFC86A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20250613000411.1516521-1-komlodi@google.com>
 <20250613000411.1516521-9-komlodi@google.com>
In-Reply-To: <20250613000411.1516521-9-komlodi@google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUXPR06MB7999:EE_
x-ms-office365-filtering-correlation-id: ae18bd31-a511-4de4-bfdd-08de4c2b455e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WHJTYnZJSUpxUC9WR2dDY1h1dXJMZXlVbjZRRlEvbUM2TytacVBDV293QmJK?=
 =?utf-8?B?dWUvczlxT0thaXVzUE9nQytHRWVoUzRPZ21yTWV0ZS8zeHVpak1uR2cvSmRR?=
 =?utf-8?B?NlZsbXpLZnF2eDkxTzdJRDl5WGFxbkoxUTV1MnNwQzFJYW9WUGtBaStiL2Nq?=
 =?utf-8?B?bmQwd3RvNWc4d1ZBTHEycTJqSUlrcjg3R1BFQWJ5QnRRTC9uckV4aytYSUI3?=
 =?utf-8?B?UElVSFVyQVZOdnp6VmRPK3NzT3Bqdkx0aWRIU3VGL3VNdDc3QUh0cXZvblpp?=
 =?utf-8?B?djNmR3RIc3RrdUZtYnpma0RGcTQ0amE4S0ZlZzM4MVVuMlBRUk95aldiSCt3?=
 =?utf-8?B?Um1RdXd3QWlDUlhBYUJHTDg0dzN5UERLTERiYi9YRktZY3BCcXVpLzFkZ2hR?=
 =?utf-8?B?K1ZvN3NPODIwUWUrVkI5SUd1SFBLV0NFRWhRQ1dxZ3k5K2MxWGlrQ2Nvb0lR?=
 =?utf-8?B?d1Nadm51SzFhZVlHejJ0dVIxQVpUSDRvTlQxWVhRdStWRDdMdFk1QWFpNnR6?=
 =?utf-8?B?Qzd5MldZcE40ZzdLR1ZUdU4rUU1UMlhmZlUyL0VNTitKU0w0R2k3Y1JIMFQv?=
 =?utf-8?B?TGNpV2E1NW54TURtTHNKOHJyVXViUWI1UWN0NWY0eGZ0MmZsWXNSWUE2SmVn?=
 =?utf-8?B?enRCQ2U2ckErajJPTFdsYTU3RVhsdmdvdzFta0pDamJOM0dlYTBKdks1c2hK?=
 =?utf-8?B?WjhNOFFDaDRjR0dOODhBdWNHNWI1NjJ2L0xsVjJjaUErRm9JQjRWSUZYeTAz?=
 =?utf-8?B?Mk5uRzEyZmE1U2k4U0xETldlWlQyS0VTVzlVOXkwMFFVU0hXQ21iVHZrMEZD?=
 =?utf-8?B?dzFjUHVnKzBqTFdrOGpnNVltQ2I5LzR6UWhqWXVWMEttMzBuR2VIei9sUXUy?=
 =?utf-8?B?VmoyUlNtZUJ1MkZFR0tHOUMrS2pFUkFmT2lCeWdPdWlDRzVud3cvaHdFaW1R?=
 =?utf-8?B?VFFieGt5dUhBNDhiY1oyajVYWjkrczhaZ0JSY1VTMEZGSmV5RkhzbVlKZlpp?=
 =?utf-8?B?N2cyZmV2M1FOWkYyWHNrY2ZnTTJNNFI3SWUzaVBGbTRsYXR0ODVJbHF5dUJ3?=
 =?utf-8?B?RFFRWGNMOG1zVGxqbU9UbW1OaUxxeUdnSzhWUjVFeHlXSkpLeGhBdTAydkZ3?=
 =?utf-8?B?M3IrcjMyYlkwREQ4blZhUXRIN0d0eWl6MW92b2JRZTJDR0dXYS92Ky9GeTFX?=
 =?utf-8?B?MEg5YnNzRmR4ZmxIL1JFbm1LL3VrUSsrblgvSFFvdlFYeHRueTgrcDVCWVJu?=
 =?utf-8?B?WG4vSUtkOFZQUDRsdHpRck1ocUIrcklNangwVzFBNGMrMVBES01xUDBWSEdT?=
 =?utf-8?B?bVJYWlFEaE4yaExCMDNhWmVrdHEzdjdnY1hxR3N2NVo3R0orSnBpT1VER0Jy?=
 =?utf-8?B?d1hURjZmaENnYWlVYm5BVG1lUEJDQThqdmNWRFlQSjVlTExjWmpyaDh0Ky9P?=
 =?utf-8?B?UWpQczNQUGVLQnVCNjhBaFN0WXBMVUl4ODZBSllLdTdWc24vM290QVcxSFdq?=
 =?utf-8?B?cS9OLzA2dXZ3K1JRVzlTY2UrSVVtOHdLcUxtQkN2L3RLclorSUlkN0J5dHdp?=
 =?utf-8?B?QzVKR1Q4VEVHOUtraGpYbXFVTEkvOXk4SXFwa1cxOEk1NGJtTEJNNVBBRXZp?=
 =?utf-8?B?bjJxMDZESzhNMHBSOVZvNnFtVG9RQTVMeDlYNStZWnFUbkxpVlFSQnBZaEdI?=
 =?utf-8?B?UVU5Y0V3U3VIYVk5WHpvS2JrM2wzR1lUQUl0eWNyRmFOcGdqVjJHUkVOWUJo?=
 =?utf-8?B?d1JMMnBsbzB3ZWR3Vkp4QWhyY05Ncjlra1pXVGdDb093dzk1bExna2NueXFm?=
 =?utf-8?B?bVhMVHVyRDNZdlhzWkpTQ2p3Vi9qbUlsK2R1ZUNLVWtHbkwzLytJQXAyUmxH?=
 =?utf-8?B?U29KVlJ0aEVyNngxMjlQQW80SFZTSUtsK0dwVmtEUDZrQ2VIbnNSUHF3cjRl?=
 =?utf-8?B?Z1JuU29zcHMzS0R6b0o2K0c2MjBiMXFCKzNTTFhISG1PT002N0thVkxmbTZp?=
 =?utf-8?B?dDY1SFBsOUNxZldScENHQSs4d1p1U1dFbnZZTmZhWVVtajB6SXB4VkdiejhG?=
 =?utf-8?Q?jNQQ0T?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3NucFUwSlNFVTN2Vm9iZlllK2tXellZUTd1REo1SUtDVS9lK2JDSllDOUJK?=
 =?utf-8?B?S0t6Qno3MVZ6Z3UwK2FwUzhqa2pxeERlWHNUdGVBQ0h2c0pqSFROQnl0d1B6?=
 =?utf-8?B?RWlYbFp6S0JNSi84OWozZ2dnVTc3RWt1VDRlR0RTYWRTc3BQUENNV2xjVElF?=
 =?utf-8?B?WFlYWUorWllPRHdSQVJCVmltZUtjajhvU3hJKzJsR2FaV3RLNU8vNjVxcStx?=
 =?utf-8?B?NzhzZTk4MkpOTXJOdzFlc0NFRWJzblJWeUlucW1YaUpCT2J5YzBsTlRlNDJs?=
 =?utf-8?B?Q1ErZWJOK05VQjVnOCtwcDIreE9UTlNVRDJpS0d0TjkzUC80Q012ekhuNlBE?=
 =?utf-8?B?N0tmNHFDNFFVSnRkd0lObzd6ME43SDhLQnZybHFUY1A4aFNmQTZBYmZ0Z2R3?=
 =?utf-8?B?KzN0MDJtTDhPZC9WUEdpTnNLRE1CUllyd2ZWUk92aHY2SmhJK1VIS0pTbDJJ?=
 =?utf-8?B?VVJ1OFp4ZnlyT2thb2oyZlRiODdYdURCL0ovQUdGT2JQY2ZmdkVFc2tYNmpK?=
 =?utf-8?B?Q1N0YUY3bTVzVVpOYndLRVFiWHRnZ3FCd2hmMjkwZmhycng1UDk5Q05aME42?=
 =?utf-8?B?aDhEdzZGNUZwWHBPTVVBa0lrRGszUFdWNU1URFNCcHdRMEs1U1poZEFPQWNW?=
 =?utf-8?B?VDBxVmRBbGhCRHBoRlBNbnE1cFA5K2NPdmlYdWpNV21QbWRiRVJlYTExWlhU?=
 =?utf-8?B?bVNqSW05dFQ1UnJRZVp6WTZoTkxuTFJkM0FheWpyREgxRGU4b1dERUFyeEVM?=
 =?utf-8?B?M1JjM3Q3SkVxR1ZMcVRIWk9zeGp4YXV4Qks2YWJlemVXeXR4aU5NL1ZIUC9P?=
 =?utf-8?B?ZmV4bi9PdWVHNk5TQ29GKy9GTkt5KyszSS8rd09odFlEclFyeWtrSklKSjJs?=
 =?utf-8?B?SWpNd3NncXJ5a1lwSlZkYzY3VUFzb3V2UWl6TTBlb2lWbEpMaE5ObzhQVEFl?=
 =?utf-8?B?ZThYNVB3T3g2YTNMVTNDOEZkbGZjdWxLV2xKbWVHR05rYXBjN2tvVkNja3hY?=
 =?utf-8?B?djdiK0Fob1dhNFoyMm9wR3lUQ3FyRlRNRXVYc2dKaG1QWHZkLzdWNy94Ylpj?=
 =?utf-8?B?K0dNTTlvWW5Mb29hWUpsYlZWU2l0TVRmRFNpZWlHcXJZOVZrdXRPRUJBTmhu?=
 =?utf-8?B?SnBSU0w0N3dONlViQ0NWaUN6WlNNallGcjdsRm54OHFVSFp5TW5IVlNEN3ZS?=
 =?utf-8?B?blhHMDBJbEI5cDVOczl0ZTJOdkNXbmtITXpIbGkvSGNscDI2cU9FcE5mSktw?=
 =?utf-8?B?L0M2N2NURzBkcjdnYVc5RElDMU0yTFdvVmdrZFptMkZ2V0Vvc0dZcStFUlg2?=
 =?utf-8?B?Nk1sZzkxbklSSlZtbzNOdmU0bVlvSDdVdVFvSEdBRjVzR2s3WDFxNTVtNWt2?=
 =?utf-8?B?ak5TZlpWVFZNQTZRWXNBdFJtWEg1QXdDUE1XMSs0MFRHYTVsRnpDQ0ppb051?=
 =?utf-8?B?RDFqZFZMWklhbnEzUGZTeit2eG5CeFNhSU52V0pxYXNyanBrZEUvb2J5VnQ3?=
 =?utf-8?B?VnpwRkVQNmZRSU1wa3lHaitiMnp4SUw4NUxIT3ZVbXY5NHVHelBTUWFqOU5L?=
 =?utf-8?B?OFIzd1MzK1FDNDNqZjNhUkM5T1M4QjBhYW0vdzErd3RrSExiU1NEU1o4bU4z?=
 =?utf-8?B?RGpHdW1GMW1WalloMlovWjFKZkMrL01mZ2VpQlh4dVU1T2I2RkpaS3hIcXcw?=
 =?utf-8?B?RTJLc25vb1FTNWRoZmd2WlZWdEFXYStNTy9vc2V2QXNMOXNleGVXL1F5azJX?=
 =?utf-8?B?S2FMbFB2ZFV6aFVHMkNJNm1SRlBzbnVZRW9JQW9TQXE1R3V0L2IzdUp3MUJi?=
 =?utf-8?B?aU9PckVKeFhIOWx0MCtMbzc1U1EzcS9tRG5WbmI4M2ZOaWdJaXJoc2IzU2Ev?=
 =?utf-8?B?K1hhMUs0RkJJN0czUmV6Z2VMdzhrT0IvYXZmOWFUSW50c0RzbXkzTzRYNnR1?=
 =?utf-8?B?WWNnM0ZBanczcTgvR3B4MGgxQzJ2VVA2MU1aclhRbGE4aXR0cUFsYlhzT0Rr?=
 =?utf-8?B?S2ZvcXJPcTJwMnFwanNzU0FBWGw5WUhuU3R3SzhYZVM1bEJPVDhReEswUHVr?=
 =?utf-8?B?bTJFKzFlSlNUdC9qeUt0S0FNY2xpN2NvczlHNjI2d2R2bTdHOEw4Skl3VnhV?=
 =?utf-8?B?aUFuWW1aZzRhMHpQbUpTMWZVb3R2VUE0THBFcHFHOE4wQVZ5dVp5cE9CUzll?=
 =?utf-8?B?enVUUDlYSlREblVudTRlbnJybUZxekhBcE1IcDdaR01uU1d2UC9Ja0dTaWxl?=
 =?utf-8?B?eTB4QnhwQXExZHBiSmlLRVVyN1RFRmFtYUJTdzR4ZUlrd2NrQSsvem93alht?=
 =?utf-8?B?aXdSb0RSeW01T2hnMEx4dzdxSU5jbkRGYWwyb0I4TFJmRTZFbE1pZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae18bd31-a511-4de4-bfdd-08de4c2b455e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 07:23:06.3819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCX5pDKfdLUpha7nGJkc12OGy5CtSiBcD7lhSNaYvgJwWx1FkV2HVE/iyN4k7/xb9dhQfCPKAQPD6uG3vna7EitH3ExC5IsD+In9j9UrO5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR06MB7999
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

SGkgSm9lLCANCg0KPiBTdWJqZWN0OiBbUEFUQ0ggMDgvMTldIGh3L2kzYy9kdy1pM2M6IEFkZCBy
ZWdpc3RlciBSTyBmaWVsZCBtYXNrcw0KPiANCj4gQWRkcyByZWFkLW9ubHkgcmVnaXN0ZXIgbWFz
a3MgZm9yIHRoZSBEd0MgSTNDIGNvbnRyb2xsZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2Ug
S29tbG9kaSA8a29tbG9kaUBnb29nbGUuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IFBhdHJpY2sg
VmVudHVyZSA8dmVudHVyZUBnb29nbGUuY29tPg0KPiAtLS0NCj4gIGh3L2kzYy9kdy1pM2MuYyB8
IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvaTNjL2R3LWkz
Yy5jIGIvaHcvaTNjL2R3LWkzYy5jIGluZGV4IDg0NWZiZDVlZmQuLjRmNDBmOTk5ZjQNCj4gMTAw
NjQ0DQo+IC0tLSBhL2h3L2kzYy9kdy1pM2MuYw0KPiArKysgYi9ody9pM2MvZHctaTNjLmMNCj4g
QEAgLTMxMyw2ICszMTMsNDUgQEAgc3RhdGljIGNvbnN0IHVpbnQzMl90DQo+IGR3X2kzY19yZXNl
dHNbRFdfSTNDX05SX1JFR1NdID0gew0KPiAgICAgIFtSX1NMQVZFX0NPTkZJR10gICAgICAgICAg
ICAgICAgPSAweDAwMDAwMDIzLA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgY29uc3QgdWludDMyX3Qg
ZHdfaTNjX3JvW0RXX0kzQ19OUl9SRUdTXSA9IHsNCj4gKyAgICBbUl9ERVZJQ0VfQ1RSTF0gICAg
ICAgICAgICAgICAgID0gMHgwNGZmZmUwMCwNCj4gKyAgICBbUl9ERVZJQ0VfQUREUl0gICAgICAg
ICAgICAgICAgID0gMHg3ZjgwN2Y4MCwNCj4gKyAgICBbUl9IV19DQVBBQklMSVRZXSAgICAgICAg
ICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9JQklfUVVFVUVfU1RBVFVTXSAgICAgICAg
ICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9EQVRBX0JVRkZFUl9USExEX0NUUkxdICAgICAg
ID0gMHhmOGY4ZjhmOCwNCj4gKyAgICBbUl9JQklfUVVFVUVfQ1RSTF0gICAgICAgICAgICAgID0g
MHhmZmZmZmZmMCwNCj4gKyAgICBbUl9SRVNFVF9DVFJMXSAgICAgICAgICAgICAgICAgID0gMHhm
ZmZmZmZjMCwNCj4gKyAgICBbUl9TTFZfRVZFTlRfQ1RSTF0gICAgICAgICAgICAgID0gMHhmZmZm
ZmYzZiwNCj4gKyAgICBbUl9JTlRSX1NUQVRVU10gICAgICAgICAgICAgICAgID0gMHhmZmZmODA5
ZiwNCj4gKyAgICBbUl9JTlRSX1NUQVRVU19FTl0gICAgICAgICAgICAgID0gMHhmZmZmODA4MCwN
Cj4gKyAgICBbUl9JTlRSX1NJR05BTF9FTl0gICAgICAgICAgICAgID0gMHhmZmZmODA4MCwNCj4g
KyAgICBbUl9JTlRSX0ZPUkNFXSAgICAgICAgICAgICAgICAgID0gMHhmZmZmODAwMCwNCj4gKyAg
ICBbUl9RVUVVRV9TVEFUVVNfTEVWRUxdICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBb
Ul9EQVRBX0JVRkZFUl9TVEFUVVNfTEVWRUxdICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9Q
UkVTRU5UX1NUQVRFXSAgICAgICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9DQ0Nf
REVWSUNFX1NUQVRVU10gICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9JM0NfVkVS
X0lEXSAgICAgICAgICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9JM0NfVkVSX1RZ
UEVdICAgICAgICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9ERVZJQ0VfQUREUl9U
QUJMRV9QT0lOVEVSXSAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9ERVZfQ0hBUl9UQUJMRV9Q
T0lOVEVSXSAgICAgID0gMHhmZmNiZmZmZiwNCj4gKyAgICBbUl9TTFZfUElEX1ZBTFVFXSAgICAg
ICAgICAgICAgID0gMHhmZmZmMGZmZiwNCj4gKyAgICBbUl9TTFZfQ0hBUl9DVFJMXSAgICAgICAg
ICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbQV9WRU5ET1JfU1BFQ0lGSUNfUkVHX1BPSU5U
RVJdID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9TTFZfTUFYX0xFTl0gICAgICAgICAgICAgICAg
ID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9NQVhfUkVBRF9UVVJOQVJPVU5EXSAgICAgICAgID0g
MHhmZmZmZmZmZiwNCj4gKyAgICBbUl9NQVhfREFUQV9TUEVFRF0gICAgICAgICAgICAgID0gMHhm
ZmZmZmZmZiwNCj4gKyAgICBbUl9TTFZfSU5UUl9SRVFdICAgICAgICAgICAgICAgID0gMHhmZmZm
ZmZmMCwNCj4gKyAgICBbUl9TTFZfVFNYX1NZTUJMX1RJTUlOR10gICAgICAgID0gMHhmZmZmZmZj
MCwNCj4gKyAgICBbUl9ERVZJQ0VfQ1RSTF9FWFRFTkRFRF0gICAgICAgID0gMHhmZmZmZmZmOCwN
Cj4gKyAgICBbUl9TQ0xfSTNDX09EX1RJTUlOR10gICAgICAgICAgID0gMHhmZjAwZmYwMCwNCj4g
KyAgICBbUl9TQ0xfSTNDX1BQX1RJTUlOR10gICAgICAgICAgID0gMHhmZjAwZmYwMCwNCj4gKyAg
ICBbUl9TQ0xfSTJDX0ZNUF9USU1JTkddICAgICAgICAgID0gMHhmZjAwMDAwMCwNCj4gKyAgICBb
Ul9TQ0xfRVhUX1RFUk1OX0xDTlRfVElNSU5HXSAgID0gMHgwMDAwZmZmMCwNCj4gKyAgICBbUl9C
VVNfSURMRV9USU1JTkddICAgICAgICAgICAgID0gMHhmZmYwMDAwMCwNCj4gKyAgICBbUl9FWFRF
TkRFRF9DQVBBQklMSVRZXSAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gKyAgICBbUl9TTEFWRV9D
T05GSUddICAgICAgICAgICAgICAgID0gMHhmZmZmZmZmZiwNCj4gK307DQo+ICsNCj4gIHN0YXRp
YyB1aW50NjRfdCBkd19pM2NfcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBvZmZzZXQsIHVuc2ln
bmVkIHNpemUpICB7DQo+ICAgICAgRFdJM0MgKnMgPSBEV19JM0Mob3BhcXVlKTsNCj4gQEAgLTM0
MSw2ICszODAsNyBAQCBzdGF0aWMgdm9pZCBkd19pM2Nfd3JpdGUodm9pZCAqb3BhcXVlLCBod2Fk
ZHIgb2Zmc2V0LA0KPiB1aW50NjRfdCB2YWx1ZSwNCj4gDQo+ICAgICAgdHJhY2VfZHdfaTNjX3dy
aXRlKHMtPmlkLCBvZmZzZXQsIHZhbHVlKTsNCj4gDQo+ICsgICAgdmFsdWUgJj0gfmR3X2kzY19y
b1thZGRyXTsNCj4gICAgICBzd2l0Y2ggKGFkZHIpIHsNCiAgICANClRoZSBmb2xsb3dpbmcgcmVn
aXN0ZXJzIGFyZSByZWFkLW9ubHksIGFuZCB0aGUgY29kZSBhbHJlYWR5IGNoZWNrcyB0aGVpciBh
Y2Nlc3MgYmFzZWQgc29sZWx5IG9uIHRoZSByZWdpc3RlciBhZGRyZXNzLg0KV2h5IGRvIHdlIHN0
aWxsIG5lZWQgdG8gZGVmaW5lIHRoZW0gaW4gZHdfaTNjX3JvPw0KICAgDQogICAgY2FzZSBSX0hX
X0NBUEFCSUxJVFk6DQogICAgY2FzZSBSX1JFU1BPTlNFX1FVRVVFX1BPUlQ6DQogICAgY2FzZSBS
X0lCSV9RVUVVRV9EQVRBOg0KICAgIGNhc2UgUl9RVUVVRV9TVEFUVVNfTEVWRUw6DQogICAgY2Fz
ZSBSX1BSRVNFTlRfU1RBVEU6DQogICAgY2FzZSBSX0NDQ19ERVZJQ0VfU1RBVFVTOg0KICAgIGNh
c2UgUl9ERVZJQ0VfQUREUl9UQUJMRV9QT0lOVEVSOg0KICAgIGNhc2UgUl9WRU5ET1JfU1BFQ0lG
SUNfUkVHX1BPSU5URVI6DQogICAgY2FzZSBSX1NMVl9DSEFSX0NUUkw6DQogICAgY2FzZSBSX1NM
Vl9NQVhfTEVOOg0KICAgIGNhc2UgUl9NQVhfUkVBRF9UVVJOQVJPVU5EOg0KICAgIGNhc2UgUl9J
M0NfVkVSX0lEOg0KICAgIGNhc2UgUl9JM0NfVkVSX1RZUEU6DQogICAgY2FzZSBSX0VYVEVOREVE
X0NBUEFCSUxJVFk6DQoNClRoYW5rcy1KYW1pbg0KDQo+ICAgICAgY2FzZSBSX0hXX0NBUEFCSUxJ
VFk6DQo+ICAgICAgY2FzZSBSX1JFU1BPTlNFX1FVRVVFX1BPUlQ6DQo+IC0tDQo+IDIuNTAuMC5y
YzEuNTkxLmc5Yzk1ZjE3ZjY0LWdvb2cNCg0K

