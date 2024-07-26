Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E96C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 06:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXE1D-00074v-S8; Fri, 26 Jul 2024 02:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sXE0t-0005dS-7L; Fri, 26 Jul 2024 02:01:17 -0400
Received: from mail-sgaapc01on20720.outbound.protection.outlook.com
 ([2a01:111:f400:feab::720]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sXE0p-00082A-CC; Fri, 26 Jul 2024 02:01:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgWh8l+LqLK6BOTe9O7jol6Q/aSEV0MqRaAdq4j95yRJi6LXS0qT7Jlrki+GNXQ6xPbAaEEGAxrB6jnaIMS9qzwT7Yq6/RTOCKQhwJ76XO2UCoTsSuKSn6r2Weuxzy4XIgaZs+qPcs0pmLUNA6/ai7M+MMp02j0go2DBzPZXfbUZctJuJkADx81aofKz4PQUmoAP1PUiJl4VA61lMnwRmsa24WkF0nw09O+ZT4rWOsZJ7iJqn/v58SugP4HxaW2EjZHwV85VHl0tHqSQDDOvV1lRuSS4v672VLvCnoFrasTEI1bNrfO+9jBAqO8ISV6RuyXLP09DjHw/lD+qYT/omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPexOZ029Qn1QLyNSxvxbukw3EpD9Iz6wr9+JsaAuxc=;
 b=untEv3oKBGjz730OPy8L0DrPMLHIR9/D5Yv2o1IyE1CBx/xMyhy1RE5fOOX8M2cX1SihLRunt/4q2+6Zy8esD0uGO+0e5PI89o9DGTKRcrmngDiOcBgmXZ2i/4yYWuKEv1FpmSipP6+yrSOXljO5SYB2ebE66cOTsmzD+0uMB7LpueDEVtMErUi023FOkrJiLR97E96IpgB0YvuLP1XXrINBMQExn6R9Xphu9ouvTezBryB6onuSAJMHxW8O+t9TdTyHuHrfOCoraSdyMh+W6SI8369ORe6WfShAH0PGfz1HsaP0UPTg4MvRqdCBxcIxJ08Wwp9xwYzA15lOEALd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPexOZ029Qn1QLyNSxvxbukw3EpD9Iz6wr9+JsaAuxc=;
 b=FaS+3TtdQuP9X0CjL7Ac2ZIs1AIcrqFnzF7WALa/qjIz+d8YoK6BKFWIZdODSVzqyF0MQSxVoLcTlZ1eDjTfOYKlTVlPjGwshzV5cwLhLlCYavG62GnqnARfUHvzBRmYLFOyPrx0eRXOBoCQOOYuhSY3ygtbmRtnXizgzoM/rTiwB+sxNHRuOl1DcmF5Co1CiQBvyZ748Ky1svsgelavBALbPIfm77TZpn98/W+YxotXWRtGaH+XcW9wNrWp17tvNH0XbOQntQWWp4DP+PW1VtDokIjSUV5pFjxLtIrPt9mkJRMuw0x27BuiY30zfHUuU17OjxK58GqPbdTfE5OzmQ==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SI2PR06MB5316.apcprd06.prod.outlook.com (2603:1096:4:1eb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.20; Fri, 26 Jul 2024 06:00:57 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 06:00:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
Thread-Topic: [PATCH v1 04/15] hw/i2c/aspeed: support discontinuous register
 memory region of I2C bus
Thread-Index: AQHa2N7FJ4EHEryDLUODXq5rrtI5x7H8K8oAgAAQGICAAEKygIAMCnCg
Date: Fri, 26 Jul 2024 06:00:57 +0000
Message-ID: <SI2PR06MB5041D50CAC61711661F4B56FFCB42@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
 <20240718064925.1846074-5-jamin_lin@aspeedtech.com>
 <de851b5c-5983-44f6-955a-6ba71f966c71@kaod.org>
 <SI2PR06MB5041E3D271FB5839B12E76D4FCAC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <c7d00701-cada-4ed8-856b-85249aa1ac0b@kaod.org>
In-Reply-To: <c7d00701-cada-4ed8-856b-85249aa1ac0b@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SI2PR06MB5316:EE_
x-ms-office365-filtering-correlation-id: 53720007-6e90-437d-4388-08dcad38516b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RDNZcDY1OFlpQUVITnB3SUt1VGRqQ2N4L20vNWIvWW0wd0VqVkMyWWtTTm9P?=
 =?utf-8?B?V1pwdFpwSmpUL0RjbGxIbFFDeFh6b1l6aTMvajkrczFoQU1JMzNHbXAwTjNK?=
 =?utf-8?B?Um03VG9ZNUNYNWNYL0tKUTZCeU9weHpSbmovTTZ0NXM2T2txaVV5b1hsYzYz?=
 =?utf-8?B?UnBoUHlDUVFHUjkxeEF2M2FVWnVRU3NTSWRKbnhFRXlsQ244T3JlazBWb1dp?=
 =?utf-8?B?WWZwVVhLODFLRjR4RXFCK29uc0ZYcUNUcjdZU1p5cnY4QXlqdmFGbkJaNmEy?=
 =?utf-8?B?dXRCeDdCN1JUaDRGZTd6OGE1cHp3eG1EV0NOZ0I2Vlc2dGFIeDdVQjAwQzdY?=
 =?utf-8?B?RU1JaXRQS1BHcmp0S01rNy9XcWwwOVhXdHpqV0p4ZThxOXlSNUNVRzA2RUF6?=
 =?utf-8?B?ZUxCK25ibFFNdE1walM5V2JEd0hqWW9UczZRVFNrOWZkYURNTW5NQUlSRGFV?=
 =?utf-8?B?c09WaC9mWWE0UGE1RWp1YVF3UWpSNnVpMlJhciswaTJpMERFOThrY0FvQk9U?=
 =?utf-8?B?cDJVYmFXWEpUSVgrZkp0SlVwQVpZUkZoOUk4ZkVSY1ZRc3pUWDIrYVR4cVJ0?=
 =?utf-8?B?VVVvazJySk0rR1BTaG5hbzUyVGJKVGI1cDVkbFdBN2E4SjBuR3krR3NXQ3dn?=
 =?utf-8?B?NVBIZW1EUVFZSnQ1MEdiT0pSeUpnWmNOcXdpa3FlTVBMbXRSaFVLaFlLV1FI?=
 =?utf-8?B?MXo5Z3lZNzlvbXJYbXVIeWxGdURERlNEQTFaZlNKbTlwZEZ3L00weEVqRkRm?=
 =?utf-8?B?V3RuZDdUNE03eDlsV05RbVRRYmM0MFdITEpWbEtnbEdmNzdsR2IvcFhRUGEw?=
 =?utf-8?B?ejlFdm5BVDN2N3lXblRzT1UxRjNQMXEyTGNoalFjbDJ2TG1HRHVDVWtLaUU3?=
 =?utf-8?B?bXJtbFpia2JtSjNHUGJ6WlZDdUhyZU1wZUIvQmdaemdTQzUxSXNiOFk0Q3cz?=
 =?utf-8?B?Y1dtalYyYkh5VGtPSTAxUjNHQ0M3Zld2bmIybzA3NlBuMkZ6ZjQrQTN3a1E1?=
 =?utf-8?B?ei9WS2FqWXlyRWtjdC95MDlubHZrek0wOXFKdDJidUkzcVlUUk5iVHhtTVZx?=
 =?utf-8?B?eENwWSsvY29CSzBVWVNuc3loMXcvdUZpdEFyRUJzS2dxbkpvbko1VUp0Y24z?=
 =?utf-8?B?clQ1L1RySjhXTk9vK25yczhPVkgvNjczLy93YXZtdUVBdkRIY3RCSXZWWndB?=
 =?utf-8?B?ZlZRZ1hXc1NNR2VnRCtUNDhLRnptdFpKVmx4dnYxdU13MWZlejA1elphb1lG?=
 =?utf-8?B?WXVzL0ZIeFN2Q1hta21Bcy9GMmVvZVRQSm9uYnhYbEh1RCtQRCsxa2xIazlp?=
 =?utf-8?B?VWM4ZjBPMGNyeFVDSGpnVURxMkdVdldIcEM1UE1OeVhtRDRrY1JPWDYrMU40?=
 =?utf-8?B?ZDhmdVRIYWJmeDB3OWJVWHp3Rm1JYlFFVTRhSDVGQ0hXWk1RcXFka2NNZDRx?=
 =?utf-8?B?VWV5MTlUWVVlTy9sY3N5aHpsVUIwcHR4TVFwMHA1WHlGUlVJSHQ1MWtMWWM5?=
 =?utf-8?B?cXNrMDZZdStVM2JrWVI1M2tDQ2xCS0ZESzBVdldqR1hoV21VMUd1NVZ6YVQr?=
 =?utf-8?B?Z1Q0aWxDN1BBY1FucHRVak82OXB1bWpIZ1pQcEVmUC9uWGxuS3Q1WjBhNGZa?=
 =?utf-8?B?SEpObkZmZ3ZZMFpYQytOaDFaUHoxZFJ0akZQczB6Z0p3c0hBZVlPcVR4RnNL?=
 =?utf-8?B?UHF3Nmhkb2hsQ1Fmb016WDh2SjJJcjZ0RTlxRGZWR09wZjlxQ25nY1ZBbzU2?=
 =?utf-8?B?WHpSdkpRaVpncFEwRlBaY284ZDd0L3BESVBYMUV4Rk10dTRxcVdHRzVBMWs0?=
 =?utf-8?B?RVI2dFVPU2lpQllodGhrazh4VGVLYzUxTktXNXh2N2xnZ25KWE4xcTcvVURt?=
 =?utf-8?B?QVM0L0VDZDJSQ29Od2d6M01IQzZ0eWhnVWNYMUtHR1FqVFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUVsOWgzbnpaSjd1MVIrZm4ydklibVpqczQ5WFZRM3dKNkczS1pNcURBaDdp?=
 =?utf-8?B?THNzTWprY0MwZ0taK1lramd5NHc4YjBjUUZqeDVWN3RiVVphWXRKWGFKYTFr?=
 =?utf-8?B?R3FDWmZCbGwxeXlGRGdoMGVDN0NkaWNaUWtFQXM2SHpleHNqMXVxWjQwRmhU?=
 =?utf-8?B?RXVUYk5zd0kxdmQwYktqWjd1bTR6QmhrS1FOWWt3MUl3TW9KTHZlUnlyTjRn?=
 =?utf-8?B?T0VoYUl2UXdYdmcrWFhCY0czcklmb0JzTE5UOCtFeVFzUXNxV1Njclg0cU01?=
 =?utf-8?B?cTNJTHMvRzJSeVBmY0xMdWtKR2Y2cWNPSzZyUUIrc2FpeWhIZTRHMFhPNVFt?=
 =?utf-8?B?RFEvbC9YbG52Njd2TDMyMlhBdi9USWQ0SzNibVMzbC94T2xYbWs4WmtMNFZD?=
 =?utf-8?B?bmdvN0FLVG9VcXYwbm9zSTduci8vaUVLaUw1cWZydUJ4eEN6MUIxMUhlcVRV?=
 =?utf-8?B?ZElNT1hNREJMVFlUY2Zuc2c2NHhBYTZjL1BualVxUDJJTWEwa041WnAvV0ho?=
 =?utf-8?B?NnNqbE5WQVpHRGlxNXdTTjVwaTBGNTVjMkRIRTRZYzZlRitSTXp3MXBGakdq?=
 =?utf-8?B?cGs5MlhYMnNmV0J4eXJycjZkekhyaUFvUGpzVnUva0ZrTjk1eE9ZTk1Ld2Rv?=
 =?utf-8?B?ck1FRGVwc1kvdnFwZ0ZwbndKUEdLS1NUa0FUdjdOQmRCS0VnbHN3dnZHR0cy?=
 =?utf-8?B?c2ZlOWtsZWh3UkROVzFhbmlJYkgxcURtcG91dnhwZEZNSVJNMHE0Uk9wWU5M?=
 =?utf-8?B?VXUzLzFyU3BILy9IRlFZdG5vRkg2aU5KNEJmWnlodVRsMDQvV1BBMUV3ekdZ?=
 =?utf-8?B?bDZ3OVFGR3pPYUpNclBJNXJGbGMxQ2ZwZ213MnB2ai9kU1ZaSjFzZTE1Y0Y3?=
 =?utf-8?B?elBvWnNRWnNtMll6akt5SXl1S2YzK0NaRFJ3R1ZHVWh2eTlrbDZRd09OVXQr?=
 =?utf-8?B?SmE4S0dCd1dxcnVtcGtLRGErVk5nb2JycjRvcmRxK0I5aE1TbGl1c0ZVRDl1?=
 =?utf-8?B?RHFONFI5UGtLRExaaHVMYUJVZUZRZlNNM01UZW91TmVHYVY0U3dkM1ZFRDFW?=
 =?utf-8?B?WmVmZllFK25meGx0alRIUXcvRTlYckl4WkRlTTlxVWI5TEh1SWdSM2xYcXUx?=
 =?utf-8?B?YVYzQS9RbjZBb2tabFV6akdNZUw0NFI4UFYrbFBqejhORE04dDZsd0hkKzkw?=
 =?utf-8?B?Ky9nekRId2F0NmFFd0V1bTU1bk1yMVJ2VU03YUw1U1BPOGFLSXZIY0V5SEpr?=
 =?utf-8?B?OWdqY1N1WjlqTTZ4OXN3WTNSV29ETUR5OXNnTm5OaHBZeWdMejMxd0RKcXNp?=
 =?utf-8?B?N3VBNTZKTW5kYzVuakRjRDlxcXBsSTNUTmtmUVVMYkZxSVNuR2VSaDNjNmlI?=
 =?utf-8?B?Nmw5MjMyV3ZHZmpweld6eVV2TnVBY1JjN3dCcmJIbnRGb1hqbEtyMmtROG1I?=
 =?utf-8?B?bmdOY2w4MW9EM1NKTDZNWXlwckpFc3d6WmNqcmduQW5PZzlSU1pyOGNMUGwz?=
 =?utf-8?B?UjR0MEx1cUVXaWZ4NTJQT1F1VkdIYmo0dlJZZ3Y2MEtzVWhZQWVOQ0xsTWwz?=
 =?utf-8?B?TlMwU0ZKU2VGME1maVN6S0cwQmVpWkNvbC9VQUYzOTAyYXpUTnlDU1NVRHBC?=
 =?utf-8?B?TC9yZWprOHpTTDdCbVorb2RlV1pIaENhZVpnc0pFbzczQlNIRXJHTHZveVg3?=
 =?utf-8?B?V0NRTG1HbFUrcGVQR2NoSE9BN1dIcmlqbEx5czhIL21lRWdIalFXNmEvcmNS?=
 =?utf-8?B?bldQM3JEMUhrMHB4OUJ3TGl3TE0wTmpkRE9XMGVtNnZ0aUdLK29JQmcwRU9H?=
 =?utf-8?B?VFhkK2ZMZFBhMy9VS1Ewb1hHOS9mMjU2MGh3ZXdkNXk4YkxPRzJ0cGRnUlYv?=
 =?utf-8?B?V2hieDJzRjI5aWlzangvMEZoaHZ6Z0ZoR1lyVUgzS2N0K1NiTldwb0tvZEpG?=
 =?utf-8?B?c0JnNEhLR21GL284bTNtRmZrbXViWTgyZThuWTJpL3NDZFpCd1V3bDQ1SUp2?=
 =?utf-8?B?TGxvWTdLalhmeXUxdGsxamY2a2NIRUY1WDF4dmNlT2pNZmw1V1gxTDVMUytF?=
 =?utf-8?B?OGNSZkR6WE9VbkdjUUowTVd6TGF1bjg5K1lwL3FPb2o0MHMzczBLUGF2Um0y?=
 =?utf-8?Q?ZcAVfQjeX3/7Hkqt3mQ/uTOeb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53720007-6e90-437d-4388-08dcad38516b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 06:00:57.5481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +A5r+mVp6HHXmH72FVf6sh1cU3kIEVgh0Wf/x2N8LpqsF/IssOG8tM9gl1jjZi18AijHiDF5k3/XuAN90aVSDJ07aTDRS7RcQdujERCUrIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5316
Received-SPF: pass client-ip=2a01:111:f400:feab::720;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDQvMTVdIGh3L2kyYy9hc3Bl
ZWQ6IHN1cHBvcnQgZGlzY29udGludW91cyByZWdpc3Rlcg0KPiBtZW1vcnkgcmVnaW9uIG9mIEky
QyBidXMNCj4NCj4gT24gNy8xOC8yNCAxMTo0NCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEhpIENl
ZHJpYywNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA0LzE1XSBody9pMmMvYXNw
ZWVkOiBzdXBwb3J0IGRpc2NvbnRpbnVvdXMNCj4gPj4gcmVnaXN0ZXIgbWVtb3J5IHJlZ2lvbiBv
ZiBJMkMgYnVzDQo+ID4+DQo+ID4+IE9uIDcvMTgvMjQgMDg6NDksIEphbWluIExpbiB3cm90ZToN
Cj4gPj4+IEl0IG9ubHkgc3VwcG9ydCBjb250aW51b3VzIHJlZ2lzdGVyIG1lbW9yeSByZWdpb24g
Zm9yIGFsbCBJMkMgYnVzLg0KPiA+Pj4gSG93ZXZlciwgdGhlIHJlZ2lzdGVyIGFkZHJlc3Mgb2Yg
YWxsIEkyYyBidXMgYXJlIGRpc2NvbnRpbnVvdXMgZm9yDQo+ID4+PiBBU1QyNzAwLg0KPiA+Pj4N
Cj4gPj4+IEV4OiB0aGUgcmVnaXN0ZXIgYWRkcmVzcyBvZiBJMkMgYnVzIGZvciBhc3QyNzAwIGFz
IGZvbGxvd2luZy4NCj4gPj4+IDB4MTAwIC0gMHgxN0Y6IERldmljZSAwDQo+ID4+PiAweDIwMCAt
IDB4MjdGOiBEZXZpY2UgMQ0KPiA+Pj4gMHgzMDAgLSAweDM3RjogRGV2aWNlIDINCj4gPj4+IDB4
NDAwIC0gMHg0N0Y6IERldmljZSAzDQo+ID4+PiAweDUwMCAtIDB4NTdGOiBEZXZpY2UgNA0KPiA+
Pj4gMHg2MDAgLSAweDY3RjogRGV2aWNlIDUNCj4gPj4+IDB4NzAwIC0gMHg3N0Y6IERldmljZSA2
DQo+ID4+PiAweDgwMCAtIDB4ODdGOiBEZXZpY2UgNw0KPiA+Pj4gMHg5MDAgLSAweDk3RjogRGV2
aWNlIDgNCj4gPj4+IDB4QTAwIC0gMHhBN0Y6IERldmljZSA5DQo+ID4+PiAweEIwMCAtIDB4QjdG
OiBEZXZpY2UgMTANCj4gPj4+IDB4QzAwIC0gMHhDN0Y6IERldmljZSAxMQ0KPiA+Pj4gMHhEMDAg
LSAweEQ3RjogRGV2aWNlIDEyDQo+ID4+PiAweEUwMCAtIDB4RTdGOiBEZXZpY2UgMTMNCj4gPj4+
IDB4RjAwIOKAkyAweEY3RjogRGV2aWNlIDE0DQo+ID4+PiAweDEwMDAg4oCTIDB4MTA3RjogRGV2
aWNlIDE1DQo+ID4+Pg0KPiA+Pj4gSW50cm9kdWNlIGEgbmV3IGNsYXNzIGF0dHJpYnV0ZSB0byBt
YWtlIHVzZXIgc2V0IGVhY2ggSTJDIGJ1cyBnYXAgc2l6ZS4NCj4gPj4+IFVwZGF0ZSBmb3JtdWxh
IHRvIGNyZWF0ZSBhbGwgSTJDIGJ1cyByZWdpc3RlciBtZW1vcnkgcmVnaW9ucy4NCj4gPj4NCj4g
Pj4gSSBkb24ndCB0aGluayB0aGlzIGlzIG5lY2Vzc2FyeSB0byBtb2RlbC4gQ291bGQgd2Ugc2lt
cGx5IGluY3JlYXNlDQo+ID4+IHRnZSByZWdpc3RlciBNTUlPIHNpemUgZm9yIHRoZSBBU1QyNzAw
IGJ1cyBtb2RlbCBhbmQgcmVseSBvbiB0aGUNCj4gPj4gbWVtb3BzIHRvIGNhdGNoIGludmFsaWQg
cmVnaXN0ZXIgb2Zmc2V0cyA/DQo+ID4+DQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldyBhbmQg
c3VnZ2VzdGlvbi4NCj4gPg0KPiA+IFNvcnJ5LCBJIGFtIG5vdCB2ZXJ5IGNsZWFybHkgdW5kZXJz
dGFuZCB5b3VyIGNvbW1lbnRzLg0KPiA+IENvdWxkIHlvdSBwbGVhc2UgZGVzY3JpYmUgaXQgbW9y
ZSBkZXRhaWw/DQo+ID4gVGhhbmtzLUphbWluDQo+DQo+IEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQg
dG8gaW50cm9kdWNlIGEgZ2FwIHNpemUgY2xhc3MgYXR0cmlidXRlLg0KPg0KPiBTZXR0aW5nIDoN
Cj4NCj4gICAgICBhaWMtPnJlZ19zaXplID0gMHgxMDA7IC8qIHNpemUgKyBnYXAgKi8NCj4NCj4g
aW4gYXNwZWVkXzI3MDBfaTJjX2NsYXNzX2luaXQoKSBzaG91bGQgYmUgZW5vdWdoLg0KPg0KU29y
cnkgcmVwbHkgeW91IGxhdGUuDQoNClRoZSBhZGRyZXNzIHNwYWNlIG9mIEkyQyBidXMgYW5kIHBv
b2wgYnVmZmVyIGFyZSBhcyBmb2xsb3dpbmcNCjB4MTAwIC0gMHgxN0Y6IGRldmljZTFfcmVnICAw
eDFhMCAtIDB4MWJmOiBkZXZpY2UxX2J1Zg0KMHgyMDAgLSAweDI3RjogZGV2aWNlMl9yZWcgIDB4
MmEwIC0gMHgyYmY6ZGV2aWNlMl9idWYNCjB4MzAwIC0gMHgzN0Y6IGRldmljZTNfcmVnICAweDNh
MCAtMHgzYmY6IGRldmljZTNfYnVmDQoNCkkgdHJpZWQgdG8gc2V0IHRoZSBhaWMtPnJlZ19zaXpl
IDB4MTAwIGFuZCBhaWMtPnBvb2xfc2l6ZSAweDEwMC4NCkFuZCB0aGUgbWVtb3J5IHJlZ2lvbnMg
b2YgSTJjIGJ1cyBiZWNhbWUgYXMgZm9sbG93aW5nLg0KDQoweDEwMC0weDFmZiBhc3BlZWQuaTJj
LmJ1cy4wICAweDFhMC0weDI5ZiBhc3BlZWQuaTJjLmJ1cy4wLnBvb2wNCjB4MjAwLTB4MmZmIGFz
cGVlZC5pMmMuYnVzLjEgIDB4MmEwLTB4MzlmIGFzcGVlZC5pMmMuYnVzLjEucG9vbA0KMHgzMDAt
MHgzZmYgYXNwZWVkLmkyYy5idXMuMiAgMHgzYTAtMHg0OWYgYXNwZWVkLmkyYy5idXMuMi5wb29s
DQoNCjAwMDAwMDAwMTRjMGYwMDAtMDAwMDAwMDAxNGMxMGZmZiAocHJpbyAwLCBpL28pOiBhc3Bl
ZWQuaTJjDQogICAgMDAwMDAwMDAxNGMwZjEwMC0wMDAwMDAwMDE0YzBmMWZmIChwcmlvIDAsIGkv
byk6IGFzcGVlZC5pMmMuYnVzLjANCiAgICAwMDAwMDAwMDE0YzBmMWEwLTAwMDAwMDAwMTRjMGYy
OWYgKHByaW8gMCwgaS9vKTogYXNwZWVkLmkyYy5idXMuMC5wb29sDQogICAgMDAwMDAwMDAxNGMw
ZjIwMC0wMDAwMDAwMDE0YzBmMmZmIChwcmlvIDAsIGkvbyk6IGFzcGVlZC5pMmMuYnVzLjENCiAg
ICAwMDAwMDAwMDE0YzBmMmEwLTAwMDAwMDAwMTRjMGYzOWYgKHByaW8gMCwgaS9vKTogYXNwZWVk
LmkyYy5idXMuMS5wb29sDQogICAgMDAwMDAwMDAxNGMwZjMwMC0wMDAwMDAwMDE0YzBmM2ZmIChw
cmlvIDAsIGkvbyk6IGFzcGVlZC5pMmMuYnVzLjINCiAgICAwMDAwMDAwMDE0YzBmM2EwLTAwMDAw
MDAwMTRjMGY0OWYgKHByaW8gMCwgaS9vKTogYXNwZWVkLmkyYy5idXMuMi5wb29sDQoNClRoZSBt
ZW1vcnkgcmVnaW9uIG9mIGFzcGVlZC5pMmMuYnVzLjAgKDB4MTAwLTB4MWZmKSBvY2N1cGllZCBh
c3BlZWQuaTJjLmJ1cy4wLnBvb2wgYWRkcmVzcyBzcGFjZSgweDFhMC0weDFiZikuDQpBbmQgdGhl
IG1lbW9yeSByZWdpb24gb2YgYXNwZWVkLmkyYy5idXMuMC5wb29sICgweDFhMC0weDI5Zikgb2Nj
dXBpZWQgYXNwZWVkLmkyYy5idXMuMSBhZGRyZXNzIHNwYWNlKDB4MjAwLTB4MjdGKQ0KVGhhdCB3
YXMgd2h5IEkgY3JlYXRlZCByZWdfZ2FwX3NpemUgYW5kIHBvb2xfZ2FwX3NpemUgdG8gZml4IHRo
aXMgaXNzdWUuDQpEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbj8NCg0KVGhhbmtzLUphbWluDQoN
Cj4gVGhhbmtzLA0KPg0KPiBDLg0KPg0KDQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlh
bGl0eSBOb3RpY2UgKioqKioqKioqKioqKioqKioqKioNCuWFjeiyrOiBsuaYjjoNCuacrOS/oeS7
tijmiJblhbbpmYTku7Yp5Y+v6IO95YyF5ZCr5qmf5a+G6LOH6KiK77yM5Lim5Y+X5rOV5b6L5L+d
6K2344CC5aaCIOWPsOerr+mdnuaMh+WumuS5i+aUtuS7tuiAhe+8jOiri+S7pembu+WtkOmDteS7
tumAmuefpeacrOmbu+WtkOmDteS7tuS5i+eZvOmAgeiAhSwg5Lim6KuL56uL5Y2z5Yiq6Zmk5pys
6Zu75a2Q6YO15Lu25Y+K5YW26ZmE5Lu25ZKM6Yq35q+A5omA5pyJ6KSH5Y2w5Lu244CC6Kyd6Kyd
5oKo55qE5ZCI5L2cIQ0KDQpESVNDTEFJTUVSOg0KVGhpcyBtZXNzYWdlIChhbmQgYW55IGF0dGFj
aG1lbnRzKSBtYXkgY29udGFpbiBsZWdhbGx5IHByaXZpbGVnZWQgYW5kL29yIG90aGVyIGNvbmZp
ZGVudGlhbCBpbmZvcm1hdGlvbi4gSWYgeW91IGhhdmUgcmVjZWl2ZWQgaXQgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSByZXBseSBlLW1haWwgYW5kIGltbWVkaWF0ZWx5IGRl
bGV0ZSB0aGUgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgd2l0aG91dCBjb3B5aW5nIG9yIGRp
c2Nsb3NpbmcgdGhlIGNvbnRlbnRzLiBUaGFuayB5b3UuDQo=

