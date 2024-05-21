Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027D0C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PI1-0008A1-2b; Tue, 21 May 2024 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHU-0007iH-V5
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:55 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHP-0001ZU-M0
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297107; x=1747833107;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=UC955ve1PDtXXjeo7AbZf0igBYATbHJ9851haDKRd9o=;
 b=H83Gs97//Pp3t+EDp4Wysnr7m6YOUW8AsFmFTGnZlMHKZo2RyEJdVMJA
 tDt8FOCZudio5cajL0q0Y0CWqFRahrNMXkJI/Rtr2/WrbLqoYJFS+mAHh
 hx6ND5XbAu3RIEkiZQ9uOKDGTQY6JiccMlgSbQmyUB0BIVlGU+R1q7yEM
 //aO0lGVfGJxuUXlZJ3aj9OYgFO0OS0dejknDt5PMcTFaD6/GxyHvjm7B
 5YsHufNu30KioQEsM0gUMy0ZH9PEjNTOxwZUrotCGdVBkRB0/EYyEi6BB
 qb6tPcbr52l+pzLIehr7duv6TQR00ShsIoJuf4RcqV0K6uktHrzuAKIXP w==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13007989"
X-MGA-submission: =?us-ascii?q?MDF1mtFCsQanr84fsYZrmjGoHIjo6GLPMpvc3u?=
 =?us-ascii?q?z5on+xJm06eQ6VfEXY4+tbMcSHENBGjTn3BKJhTtVQJ4QqlqxvPMZRv7?=
 =?us-ascii?q?8rxdVSziUKdi7aQalFpBYJCpSkVr7xW8L6hia9bsLRYizJ0VarRB7/tx?=
 =?us-ascii?q?Hu0QUHN+ILq/RHu3hjkUp7WA=3D=3D?=
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:40 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzMk6flweDgEEZQIabrOF6KJRlw9Ardyb5aCwclMkBo7Zn7IAOwza+/QG9+uDcDTzjyWBnXdlHfg5hAH7Jfd7B6MMf02HJ44j7EOvP4mt851sS5QzQf1p3QEH0inCiApsm9q3+WOBgU+p5j/KgmSjmsKbQGMZlZXSvOuK9XOnaPEtUMXT/dNZ0Ph1NkFH9IqmwMBRZnOExeuKHc7lSwexz43QO0ZqLX1axBkE2S/26uIUajeOzB3UhmsXU3o0j7v9DCBH0AyBgz6uRbToBJZTZCizc2N3nsT3bH/JjBQ0+kxJETjwT1/cg/CmIWpJkz66cAN+9dBtAEvF1MMLPDnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC955ve1PDtXXjeo7AbZf0igBYATbHJ9851haDKRd9o=;
 b=Q1BpdFnd6OUWaEHwdzD5C67GjCA+3EKOAJ2C7ANKAITZAGh90sw6zzkQvbyrrd9Vxr2ZhDVL71rv9IhUhmuQDBAuTrPF2tWeCihzaqVVg3nbe4rNGqAghfBVvLdtdYvERPWc1yliGFvA84B92w9jjJ0lkciEB7CNzw7j01fOJ5mgn8VvAoH6YEBqvx/y9Ba07RKDuMcLcgqVPwHwzog/TK+jsVTzzoUyhJod53mGQajsBThQbO8PXx2dI6SL5NmK9n+sb4TTgH1TLswn/KG/n4wcXyGJB6u34DmZRUa2v3J/LnejAZccJrvQEbiyOY39b6pv3L3h+ytEow4C3kP1FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB8148.eurprd07.prod.outlook.com (2603:10a6:20b:323::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 13:11:37 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:37 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd 00/22] ATS support for VT-d
Thread-Index: AQHaq4Bp7DM+3gMpqEmkh696Y/p0ew==
Date: Tue, 21 May 2024 13:11:37 +0000
Message-ID: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB8148:EE_
x-ms-office365-filtering-correlation-id: fc05b5ac-43e4-46ee-986a-08dc79978bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZWhMeFd5UEhwQit6cXRYL3FRODRYcTRBaWdScGt6VWFCZFU3clRyWEsvam5s?=
 =?utf-8?B?Z3BlVklUMitZcVpNaTYrS1ROS0RiL1N2QjlIU0tTY0ZCeW5oYi9mTWZoNU9u?=
 =?utf-8?B?N3BYVUhIKzR6QUhrY0F0cWNoRnpnckhDa2tzcnJYWkNCaEhkeG1zNlRMRmp3?=
 =?utf-8?B?Z1FNckxDa0N4QUhuV2JyTWZvaUZ5QWluRVlDMjRBQXdwNDRkODNFK2JiQXdQ?=
 =?utf-8?B?N0lvVHNLOWluYWQvSHFjMm5pa2l2cC90UHJiLy83YTBTcmc2TFpvT1UrUUk2?=
 =?utf-8?B?U0pKcUl3aW9mYzBoRHBVMlJDcXpQUHhCc0oxUVB6a2ViVyt4L0lrKzUxd1Js?=
 =?utf-8?B?UHhhVE5zZGlvVkFEZFI1cVR3Wm5DNFNEeG0yRi9MMHFIZStXNzdFYklMVXAv?=
 =?utf-8?B?TXNpVTZnNE5QMEpibitmUmFaSHNpcnFDSVRNaGRieVhEWU1ieDJBL1BZSWd1?=
 =?utf-8?B?NWJySUNJT01YSEllQVc2Q1dUUXRTSitUbXozVC9kY21VWDNPd0JMNGJEdTl3?=
 =?utf-8?B?ZXYrZkpJRjRFSVBQTDFlWjRKRG1tdUFvS1JPdFVwbmllek5vSFUzREFhanU0?=
 =?utf-8?B?UTQvdmtNcGd5SzgwVkgvRzhVTGZKdXJTc1cwNzdFazdtK0djNElUYWtBckJH?=
 =?utf-8?B?Lzg3NlUxUHFwRWhmVlBXbXo1aFBoRlVyZmdHaUFVaG9vclEzYmNRdWxXU1o1?=
 =?utf-8?B?WXFSbXR5STJEMlJJYXltZUEzcXpzelg0R05IYWdHRUlNR2NXRWlsSm8rbkFD?=
 =?utf-8?B?R2pmdGMxVjhUK3dzUjdkcnlzdmh4c0UwSnhYRzkrRzBaQjcvTjZZZUExemF1?=
 =?utf-8?B?b0tKRjF6Y05uREVjbmNYS3IraUJOMmdBVUFsbXdxK3FjcDN0Y3VsV3RtVWJk?=
 =?utf-8?B?Zlg0aUl2VFd2YTlJK0VDdUI0WGtTTjQzUEczQ1N0N0MyMEk1SEVadTdFY0JS?=
 =?utf-8?B?cFVxR0hoRmk0TG5CNUZyV04rZHZrMk1vMlFaQVVLa2NLS0ZyaHNOdEJqQldZ?=
 =?utf-8?B?NlJvZmJhRGFJTDl2SXdoOFpDZm5HMzVNTS9MMU1jWFZMWi9ibzREUjlwZzZR?=
 =?utf-8?B?cjNsUTNiWkpvSG53Umc2eUVKeTgxMEsxb2FYVENtWHhoWm13WmxydGY4VGxI?=
 =?utf-8?B?dUttRGc3cTQxZVcyTytVT3ppa1ljcHc3WXFjOEp5bjcvU0V4Rzc2cUc3d1ZJ?=
 =?utf-8?B?VklVSTRwSG5TTDRjWDhFY0I0Y0ZVbkVSaFZqQ0xZN0xZdVpCOHNWK3kxdXhj?=
 =?utf-8?B?UlVVUmkzRnpGeCs3OHdUeHQ3ajZmYzRUWjdGMzY2RUlIWkpDVWprTXBDL0Yw?=
 =?utf-8?B?RVZiMGlBNWhXZzlVeHg5eTV6QUF0dHdWRGlyVjk3R21sSGdtQ0V0RGlMWjEx?=
 =?utf-8?B?YjBVVExZR1M5WFRJZHFseVNMMGt0d3AveWZWVG12WXZOTU9HUW9OWkVONHBV?=
 =?utf-8?B?eXVoeUQ4QjJ0amNSQnBOSmxvbDR1SERiSXBXL2U2UzI4VGhGeXNYY2xpWXJ2?=
 =?utf-8?B?ZnBsbm5nL215NTNQb3BCcGl2cDhaUmgvVGgzR0lIR3dEamx3c1dEV3NLbVdS?=
 =?utf-8?B?OFpKZDhCSDY5N0lVUzM2Z1BKK0FiVDhkZzdFT2puQm5zemVrQ2h6ZzhqOUtD?=
 =?utf-8?B?RDZsS2pveFpTYzRkbkRSQnpzbkpaQkNob2toM1YreHZsMVNrMFBLZlN0QTVq?=
 =?utf-8?B?NXdhWDJQYkc0TCs4MUxlMnRxOXNNeGJOOGNzRGhqTDJ1U0hWYldzSnFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2d3QUVGRlYzWVdJOWJmY2Z6QzBzZGZXaFl3eWlDbStpWEpya2ZjV3pOZDgw?=
 =?utf-8?B?eVhUUzlNT3ViK2VMYldKL1VZbjRzblZWWkE5UGJjeHMvbWVaNnRKTStWNE9p?=
 =?utf-8?B?NmlmTFZaRDVzd0ZSRUVBbXZISVZxLzVVMGxrcUppalFYK3ZKdFRKWC8zR3Bo?=
 =?utf-8?B?UGtKK1lnWGZRMDYwSTVHcVAwR3JNTlVkUnkyTUowZTI2aTJrZmRwYUlMK2JG?=
 =?utf-8?B?cVkvNi9XNTBEMTRNSVNibjN2cFJlU1lFdStXWlhUUWtqMGZPT3hLZXRQZWV0?=
 =?utf-8?B?bmNoVXdJZTJyNDIvSVhLTlc0ZXdoUGVrdWtsVHNYRjJ0ZE9TbTdENkEvT09G?=
 =?utf-8?B?akNvZlZINWRiVS9td1ZKdnBocXBIMmJSSGo2QjdrZWRhaFhHTS9DVHpZbWU4?=
 =?utf-8?B?TWRrTVMyWkNUVjFzS0crZS9EYXVyRzFYaVJ3RTVXK1Y3eXQxUm01RXBKS0V5?=
 =?utf-8?B?b0JmeWVEaU9uN3VoNWlTTURNZVhTdjVGNGh5dEFZUndQV0tBWWZ3WXNzNyts?=
 =?utf-8?B?M1ZnRGhOYnZnTWlkaC9TTk9mYlYyb3J6TUx2Qmlmd2tUOTViMlNmQTErNWxz?=
 =?utf-8?B?NnhYSVhCam1BSXpKZGdLRTBIM3NHTHZsTkx5QWlhZkx2TStzYWR0MFpzbUFl?=
 =?utf-8?B?Q2MwaExEaXE4WUZnN3J2VGU1eUdsaVl5dmZ2RzRVNDMvelVzb1JJWDdldkd4?=
 =?utf-8?B?cS9VZm5xdVhmOGs0bWVncHVvWDhCZkJmS1lKWDRpWXVKZXh0cGROK3J4NldX?=
 =?utf-8?B?RnZ1VVVkNTFoS2M2V2VpKzZQdVJFSk1VU05mNHVHelFzbzVpL3pZU0hZQU02?=
 =?utf-8?B?RHNWWEUyRGFjZEF1YmNWSEJ2VURjV1o5VS9tS2crbGt0UlBUck10bUtUZloz?=
 =?utf-8?B?dC9GMkJtbWQ5cFhTUDFWQWtaVjFlb0w5cEFWeC9RL0k1b05JZkxJZVRuS05w?=
 =?utf-8?B?SGY1eXZ2cXV0UXo2TGhkMENwY3BwelU1bkZ0dzJJemcvbnAzUTlyaVhEdzg0?=
 =?utf-8?B?MUIvN3crRUJTOHNwZTlsUk9iaVZHMWtXMXhyZnBNQ01tL0dyVjJnR0ZQYURM?=
 =?utf-8?B?OXlpY3M2U2ZnZVU0U3czS3pUQXVzd3o5dTFuWHdNenpWOW9rV3I5Z3Nyd3hx?=
 =?utf-8?B?SWZXODlzZDRURHpwT3BURWROMytDUDhYUHFJYXFYZm1IRzcvUGNxYnh6eEdj?=
 =?utf-8?B?cWFYT2ExWEh1eEV1NW5XWTc5TjF4c1RNRW1Qc3g4VDFkNnNDeloyQWVocm1z?=
 =?utf-8?B?MWcxWFA3TGlaSTFHS1VrS3AyaVBSVWdYaEh1N1F0azNzWkJNdnZudWtsQjdE?=
 =?utf-8?B?VXVRN2Y2Y09aRlp4UUpZZTNRTUZhOVlHaXorWWN1QXBaejZIRnNFV3NSUHg5?=
 =?utf-8?B?VGs4NXBXV1B1WVowMGNrSEhEQ3hmejVzRTdwVUdNbHRVajF0UGNaOW5welRF?=
 =?utf-8?B?czBQRHdvVWlmS0FiMjVGdTIySThSUVFxZUtMcXUwT01BaHp0cldWZDdROTlL?=
 =?utf-8?B?MjAxQWZzaXBCUXBIODdCSGIrNU1ydWsvVm43dGpRRUhGWHpTS1lSUFFyVWpK?=
 =?utf-8?B?cjFKS0kyRlZ0QVB0SlF0NFRWYklYRFplS3pGU3RDZUlDcDQ2eS9XQ2NRdEVr?=
 =?utf-8?B?NDVtbEVCckFmWCs2NFc1WWd3T1QrMFYrM1I3cHNkUFQ2TXI3OWZLOUJLNnBY?=
 =?utf-8?B?d0Y0QUcwMFE5UE5vcWowZDlHdHVuVmo1OGNXUkZDMFBuTEdPdmxYQTFPQ2Ri?=
 =?utf-8?B?eE4vNnlUa1NWbXRoNXlyZitnZExpaWZWcEQ1QVBMT3dyaklUN3l0b2x6dnlK?=
 =?utf-8?B?TVVzclhtbWR3MHI2a0dPQmJxRVBIZlFLTEFrQzBVa0p2SnROQk9yM2RQOHlu?=
 =?utf-8?B?bWZsTUNCQUptKytqZEdEbi9HQWJiYVpwYWppbTlkUllIU1U0TXhYTllvNFF3?=
 =?utf-8?B?K3M4NUtpZURJNUlqTU9vTXRjU1Q2bVlNWW1hbGNoTE5oVDM2d2F2QXlIOW9E?=
 =?utf-8?B?K01OSmo3NmNTQXF5NmRVUG1kM2Mrc1JHRkYyV1M1L0hYdUFWaUdPaGhoMUNt?=
 =?utf-8?B?b1BDdURBdkZ6VDFaNG8wQ1hFM1FXOWMyYitxSjhHQlFwaitWQmcvOTVpR2Jl?=
 =?utf-8?B?S29xdldyek5VMk0zUFhYNFUwdjdXUzNSbXFpbTcyM0ZNOWUwZVlLQjVjYWlB?=
 =?utf-8?Q?LDp680jNLCOxfybSe9pNISs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BF7193DBE3DB042AA29DA46BC29D8BA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc05b5ac-43e4-46ee-986a-08dc79978bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:37.3260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01EkUkQiqrpgc2E7pYgCJghEM9v5qkgsEqx7kHFa1vWx8B/Ws8dJwDa5c53nzkwaukIbLHZPjid5jChvYo0TNjboDGIyiknec3P6ZidQCC3xsmwUYLFrPGxkECEA8+xT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8148
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

VGhpcyBzZXJpZXMgYmVsb25ncyB0byBhIGxpc3Qgb2Ygc2VyaWVzIHRoYXQgYWRkIFNWTSBzdXBw
b3J0IGZvciBWVC1kLg0KDQpBcyBhIHN0YXJ0aW5nIHBvaW50LCB3ZSB1c2UgdGhlIHNlcmllcyBj
YWxsZWQgJ2ludGVsX2lvbW11OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbiBmb3IgcGFzc3Ro
cm91Z2ggZGV2aWNlJyBieSBaaGVuemhvbmcgRHVhbiBhbmQgWWkgTGl1Lg0KDQpIZXJlIHdlIGZv
Y3VzIG9uIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBBVFMgc3VwcG9ydCBpbiB0aGUgSU9NTVUgYW5k
IG9uIGEgUENJLWxldmVsDQpBUEkgZm9yIEFUUyB0byBiZSB1c2VkIGJ5IHZpcnR1YWwgZGV2aWNl
cy4NCg0KVGhpcyB3b3JrIGlzIGJhc2VkIG9uIHRoZSBWVC1kIHNwZWNpZmljYXRpb24gdmVyc2lv
biA0LjEgKE1hcmNoIDIwMjMpLg0KSGVyZSBpcyBhIGxpbmsgdG8gYSBHaXRIdWIgcmVwb3NpdG9y
eSB3aGVyZSB5b3UgY2FuIGZpbmQgdGhlIGZvbGxvd2luZyBlbGVtZW50cyA6DQogICAgLSBRZW11
IHdpdGggYWxsIHRoZSBwYXRjaGVzIGZvciBTVk0NCiAgICAgICAgLSBBVFMNCiAgICAgICAgLSBQ
UkkNCiAgICAgICAgLSBEZXZpY2UgSU9UTEIgaW52YWxpZGF0aW9ucw0KICAgICAgICAtIFJlcXVl
c3RzIHdpdGggYWxyZWFkeSB0cmFuc2xhdGVkIGFkZHJlc3Nlcw0KICAgIC0gQSBkZW1vIGRldmlj
ZQ0KICAgIC0gQSBzaW1wbGUgZHJpdmVyIGZvciB0aGUgZGVtbyBkZXZpY2UNCiAgICAtIEEgdXNl
cnNwYWNlIHByb2dyYW0gKGZvciB0ZXN0aW5nIGFuZCBkZW1vbnN0cmF0aW9uIHB1cnBvc2VzKQ0K
DQpodHRwczovL2dpdGh1Yi5jb20vQnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0K
DQp2Mg0KICAgIC0gaGFuZGxlIGh1Z2UgcGFnZXMgYmV0dGVyIGJ5IGRldGVjdGluZyB0aGUgcGFn
ZSB0YWJsZSBsZXZlbCBhdCB3aGljaCB0aGUgdHJhbnNsYXRpb24gZXJyb3JzIG9jY3VyDQogICAg
LSBDaGFuZ2VzIGFmdGVyIHJldmlldyBieSBaaGVuWmhvbmcgRHVhbiA6DQogICAgCS0gU2V0IHRo
ZSBhY2Nlc3MgYml0IGFmdGVyIGNoZWNraW5nIHBlcm1pc3Npb25zDQogICAgCS0gaGVscGVyIGZv
ciBQQVNJRCBhbmQgQVRTIDogbWFrZSB0aGUgY29tbWl0IG1lc3NhZ2UgbW9yZSBhY2N1cmF0ZSAo
J3ByZXNlbnQnIHJlcGxhY2VkIHdpdGggJ2VuYWJsZWQnKQ0KICAgIAktIHBjaWVfcGFzaWRfaW5p
dDogYWRkIFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQgYW5kIHVzZSBpdCBpbnN0ZWFkIG9mIFBD
SV9FWFRfQ0FQX1BBU0lEX1NJWkVPRiBmb3Igc2hpZnRpbmcgdGhlIHBhc2lkIHdpZHRoIHdoZW4g
cHJlcGFyaW5nIHRoZSBjYXBhYmlsaXR5IHJlZ2lzdGVyDQogICAgCS0gcGNpOiBkbyBub3QgY2hl
Y2sgcGNpX2J1c19ieXBhc3NfaW9tbXUgYWZ0ZXIgY2FsbGluZyBwY2lfZGV2aWNlX2dldF9pb21t
dV9idXNfZGV2Zm4NCiAgICAJLSBkbyBub3QgYWx0ZXIgZm9ybWF0dGluZyBvZiBJT01NVVRMQkVu
dHJ5IGRlY2xhcmF0aW9uDQogICAgCS0gdnRkX2lvdmFfZmxfY2hlY2tfY2Fub25pY2FsIDogZGly
ZWN0bHkgdXNlIHMtPmF3X2JpdHMgaW5zdGVhZCBvZiBhdyBmb3IgdGhlIHNha2Ugb2YgY2xhcml0
eQ0KDQp2Mw0KICAgIC0gcmViYXNlIG9uIG5ldyB2ZXJzaW9uIG9mIFpoZW56aG9uZydzIGZsdHMg
aW1wbGVtZW50YXRpb24gKG5vdyBjb250YWlucyBzb21lIHBhdGNoZXMgZnJvbSB2MikNCiAgICAt
IGZpeCB0aGUgYXRjIGxvb2t1cCBvcGVyYXRpb24gKGNoZWNrIHRoZSBtYXNrIGJlZm9yZSByZXR1
cm5pbmcgYW4gZW50cnkpDQogICAgLSBhZGQgYSB1bml0IHRlc3QgZm9yIHRoZSBBVEMNCiAgICAt
IHN0b3JlIGEgdXNlciBwb2ludGVyIGluIHRoZSBpb21tdSBub3RpZmllcnMgdG8gc2ltcGxpZnkg
dGhlIGltcGxlbWVudGF0aW9uIG9mIHN2bSBkZXZpY2VzDQogICAgQ2hhbmdlcyBhZnRlciByZXZp
ZXcgYnkgWmhlbnpob25nIDoNCiAgICAJLSBzdG9yZSB0aGUgaW5wdXQgcGFzaWQgaW5zdGVhZCBv
ZiByaWQycGFzaWQgd2hlbiByZXR1cm5pbmcgYW4gZW50cnkgYWZ0ZXIgYSB0cmFuc2xhdGlvbg0K
ICAgIAktIHNwbGl0IHRoZSBBVEMgaW1wbGVtZW50YXRpb24gYW5kIGl0cyB1bml0IHRlc3RzDQoN
Cg0KDQpDbMOpbWVudCBNYXRoaWV1LS1EcmlmICgyMik6DQogIGludGVsX2lvbW11OiBmaXggRlJD
RCBjb25zdHJ1Y3Rpb24gbWFjcm8uDQogIGludGVsX2lvbW11OiBtYWtlIHR5cGVzIG1hdGNoDQog
IGludGVsX2lvbW11OiByZXR1cm4gcGFnZSB3YWxrIGxldmVsIGV2ZW4gd2hlbiB0aGUgdHJhbnNs
YXRpb24gZmFpbHMNCiAgaW50ZWxfaW9tbXU6IGRvIG5vdCBjb25zaWRlciB3YWl0X2Rlc2MgYXMg
YW4gaW52YWxpZCBkZXNjcmlwdG9yDQogIG1lbW9yeTogYWRkIHBlcm1pc3Npb25zIGluIElPTU1V
QWNjZXNzRmxhZ3MNCiAgcGNpZTogYWRkIGhlbHBlciB0byBkZWNsYXJlIFBBU0lEIGNhcGFiaWxp
dHkgZm9yIGEgcGNpZSBkZXZpY2UNCiAgcGNpZTogaGVscGVyIGZ1bmN0aW9ucyB0byBjaGVjayBp
ZiBQQVNJRCBhbmQgQVRTIGFyZSBlbmFibGVkDQogIGludGVsX2lvbW11OiBkZWNsYXJlIHN1cHBv
cnRlZCBQQVNJRCBzaXplDQogIHBjaTogY2FjaGUgdGhlIGJ1cyBtYXN0ZXJpbmcgc3RhdHVzIGlu
IHRoZSBkZXZpY2UNCiAgcGNpOiBhZGQgSU9NTVUgb3BlcmF0aW9ucyB0byBnZXQgYWRkcmVzcyBz
cGFjZXMgYW5kIG1lbW9yeSByZWdpb25zDQogICAgd2l0aCBQQVNJRA0KICBtZW1vcnk6IHN0b3Jl
IHVzZXIgZGF0YSBwb2ludGVyIGluIHRoZSBJT01NVSBub3RpZmllcnMNCiAgcGNpOiBhZGQgYSBw
Y2ktbGV2ZWwgaW5pdGlhbGl6YXRpb24gZnVuY3Rpb24gZm9yIGlvbW11IG5vdGlmaWVycw0KICBp
bnRlbF9pb21tdTogaW1wbGVtZW50IHRoZSBnZXRfYWRkcmVzc19zcGFjZV9wYXNpZCBpb21tdSBv
cGVyYXRpb24NCiAgaW50ZWxfaW9tbXU6IGltcGxlbWVudCB0aGUgZ2V0X21lbW9yeV9yZWdpb25f
cGFzaWQgaW9tbXUgb3BlcmF0aW9uDQogIG1lbW9yeTogQWxsb3cgdG8gc3RvcmUgdGhlIFBBU0lE
IGluIElPTU1VVExCRW50cnkNCiAgaW50ZWxfaW9tbXU6IGZpbGwgdGhlIFBBU0lEIGZpZWxkIHdo
ZW4gY3JlYXRpbmcgYW4gaW5zdGFuY2Ugb2YNCiAgICBJT01NVVRMQkVudHJ5DQogIGF0YzogZ2Vu
ZXJpYyBBVEMgdGhhdCBjYW4gYmUgdXNlZCBieSBQQ0llIGRldmljZXMgdGhhdCBzdXBwb3J0IFNW
TQ0KICBhdGM6IGFkZCB1bml0IHRlc3RzDQogIG1lbW9yeTogYWRkIGFuIEFQSSBmb3IgQVRTIHN1
cHBvcnQNCiAgcGNpOiBhZGQgYSBwY2ktbGV2ZWwgQVBJIGZvciBBVFMNCiAgaW50ZWxfaW9tbXU6
IHNldCB0aGUgYWRkcmVzcyBtYXNrIGV2ZW4gd2hlbiBhIHRyYW5zbGF0aW9uIGZhaWxzDQogIGlu
dGVsX2lvbW11OiBhZGQgc3VwcG9ydCBmb3IgQVRTDQoNCiBody9pMzg2L2ludGVsX2lvbW11LmMg
ICAgICAgICAgICAgICAgICAgICB8IDE0MiArKysrKy0NCiBody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggICAgICAgICAgICB8ICAgNiArLQ0KIGh3L3BjaS9wY2kuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTI3ICsrKysrLQ0KIGh3L3BjaS9wY2llLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDQyICsrDQogaW5jbHVkZS9leGVjL21lbW9yeS5oICAgICAgICAg
ICAgICAgICAgICAgfCAgNTEgKystDQogaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggICAg
ICAgICAgICAgfCAgIDIgKy0NCiBpbmNsdWRlL2h3L3BjaS9wY2kuaCAgICAgICAgICAgICAgICAg
ICAgICB8IDEwMSArKysrKw0KIGluY2x1ZGUvaHcvcGNpL3BjaV9kZXZpY2UuaCAgICAgICAgICAg
ICAgIHwgICAxICsNCiBpbmNsdWRlL2h3L3BjaS9wY2llLmggICAgICAgICAgICAgICAgICAgICB8
ICAgOSArLQ0KIGluY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oICAgICAgICAgICAgICAgIHwgICAz
ICsNCiBpbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaCB8ICAgMSArDQog
c3lzdGVtL21lbW9yeS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjAgKw0KIHRlc3Rz
L3VuaXQvbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiB0ZXN0cy91bml0
L3Rlc3QtYXRjLmMgICAgICAgICAgICAgICAgICAgICB8IDUyNyArKysrKysrKysrKysrKysrKysr
KysrDQogdXRpbC9hdGMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMTEgKysr
KysrKysrDQogdXRpbC9hdGMuaCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMTcg
KysrKysNCiB1dGlsL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSAr
DQogMTcgZmlsZXMgY2hhbmdlZCwgMTMzMCBpbnNlcnRpb25zKCspLCAzMiBkZWxldGlvbnMoLSkN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvdW5pdC90ZXN0LWF0Yy5jDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IHV0aWwvYXRjLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdXRpbC9hdGMuaA0KDQotLSAN
CjIuNDQuMA0K

