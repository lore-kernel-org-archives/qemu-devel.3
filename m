Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C236CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 09:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcK0z-0006yU-PJ; Wed, 24 Jun 2026 05:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wcK0x-0006xl-K9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:35:23 -0400
Received: from mail-westeuropeazon11021110.outbound.protection.outlook.com
 ([52.101.70.110] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wcK0v-0004ye-Jp
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 05:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjZoyTa5RmnS/2s1a+mJfquwpWonUS8ICgMmHTdmCq2ReCHs3l8n9hD4hQZGI5mGvfrWLmgpizovC+giyNylQkTGZsFMFuDn0h9x96X/WQftiw8mDOy8kcJYIdcUDzm7jPTyrsRmabcdAsbubt2o9CUCoxTeBb/qZkyNIlhEX9pqR1EDM/aEEgb5CU61Fu6gs9lQs35loFDhvAAQTGScPNyWa9X9JbANW9BsQTFaGWThN5bDW23d0bzWK0Ggflq22PRnEdtd2/N8cts0zcVmldznRV1jfvZwYl2D/HFWR+joq20RIT/S8KN9IAzXfl4yx/p/E6Kg+rpR4z3wqmY6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPNSVzMKWOp4YPdLbxnajAKDjp1AxmTV/DnvjQp9okU=;
 b=WDJ9kCijH3AktrtbVBcv+LEo0DRmiu5KJQEa7AyV3x6X3MX2lO3Vis8NOmR3368dZHovom7oLI/nvr3PYUfBjE8LpYDa+e+pvbC1TJE6pV+nZnHkP8K6+HxyLs18MtKhgq7EAPemmOJsj+x6WLpt08b34WH7vollDhobAi9LwWuUor/ONudQJIL9buAFS9i41Zj+RD8tiy4kQZ7GlhTo29MbjroxdxtI/1HmFlBbpX39VLdchseSn3mCbuhi6gF3dLBq+9JQGFuzEWC4SEseRkEiGX/+sDQhTWEzb5FkPk2l62D/6VqLDfiDfvHU8dg2i3kz/TSuq2KmAKabRjvvxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPNSVzMKWOp4YPdLbxnajAKDjp1AxmTV/DnvjQp9okU=;
 b=LlIWr8AnSS/Q+zDT59gjpPRuzMOTWkUUYvPuy2fWwB5cZIlVCVWnJ0ZRV+YkdNsu4wFMf3pHdBqMhEOwwltKkmuGv/402tghU3OJ3hokG7veSnXWySi+v4xKBI1JoQEX+RIPEHo+atx9rDR63LnLakvWRQ1Du+M6ThnK7bP+Mr4zR/ZITF4JbvLylpYHuRbaGkU9OniUQ20Wzwfpi6fuVSeHr+m3a3x/TWaDUuztAWAbBY680MQQEzVVKJbJBpUPrpQoAu8/eofSri5MRLh4Joysj1WLp85b1VzwhOP+vEzEIJRKYZxlwd2rIHqwy7T+8F16wRPH4wOXMel+dGA8FA==
Received: from AM0PR08MB4353.eurprd08.prod.outlook.com (2603:10a6:208:144::10)
 by DB9PR08MB6555.eurprd08.prod.outlook.com (2603:10a6:10:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 09:30:15 +0000
Received: from AM0PR08MB4353.eurprd08.prod.outlook.com
 ([fe80::82b2:c5a:a06f:78cd]) by AM0PR08MB4353.eurprd08.prod.outlook.com
 ([fe80::82b2:c5a:a06f:78cd%6]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 09:30:15 +0000
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: "kkostiuk@redhat.com" <kkostiuk@redhat.com>
CC: "michael.roth@amd.com" <michael.roth@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, Andrey Drobyshev
 <andrey.drobyshev@virtuozzo.com>, Den Lunev <den@virtuozzo.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "philmd@mailo.com" <philmd@mailo.com>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: Re: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
Thread-Topic: [PATCH 4/4] qga: Add AF_VSOCK channel support on Windows
Thread-Index: AQHdABacCxErlGxqWEGOmRzs08qGLbZKSxmAgABYUYCAAEAbgIAClGwA
Date: Wed, 24 Jun 2026 09:30:15 +0000
Message-ID: <171847c9efcf0636f71e821762ed64336525c312.camel@virtuozzo.com>
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
 <20260619180121.2982356-5-polina.vishneva@virtuozzo.com>
 <CAPMcbCphbipUTQm5d+A3hPJMLXVo3jBVxxzCii8axjTyQtBGSQ@mail.gmail.com>
 <3fc4bc652795f349d0f82bd30c7aaac9323fd14f.camel@virtuozzo.com>
 <CAPMcbCod4Pv20=Wvw+Yd=2yY3WcRLFY0LXGpdsOtF95aBaZP+w@mail.gmail.com>
In-Reply-To: <CAPMcbCod4Pv20=Wvw+Yd=2yY3WcRLFY0LXGpdsOtF95aBaZP+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR08MB4353:EE_|DB9PR08MB6555:EE_
x-ms-office365-filtering-correlation-id: 26593a5e-340a-449d-f4d0-08ded1d332e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|4143699003|56012099006|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info: QD8CBMWERLWXV09ZN+cSWDRS3k7TxdAOm4SZ6LX6bQrtxCmqZ5AXcdZEMh2s/EutheKEcJl+8OETLqUHjot8NXUqi0gWnYUEI2QVwew2FSuPmRD3TZxO+g+e+vrJ9mb5MzvMZlGWcYCNTekgUIx7/ubDKRdVinFeT1S948tx2QlgA3U4cz+zqQNw72bjiqtF/+cTGzXW/2bRc+dev+EKXs+2slOy1Th5D3/JpkYQr/IatLw1fCjdqjgxDgmweUc2SuHBJ/5yRoV8ALbNHAlulyzZtUz4cI3Myx5RtM3V6862blNUZh9bl2RkpnLnHZINnGm5ISF6YTbyf/pLZL8BsGsSPDt8XaD0oTO3bX1t7OjVlHd1z1nyn4rqMGQyHHwLsLg/a523S9QqaALwp0Ff81kU1jaK82sglIhfVclHzIgn/GHSyrqZvKJMoD/JjvG2psAG3ZX771CYoU3+T3DlzSlxEF+fv2IO7wlMxBxpzGrDkNWpydB9Fw+OtLV+3vp6FrpPDG1w6jvJsQvqM5PW/zb6qIwlRX7BHfwBI2Ds7+GZQmmweyV5ZbCh7hXtaMEwVb/9P+C7R5CgUVGMG6z/beBWhzbR4y8AVToRW/SmrS5aFpM1RZkKNjtqYk9V4YezefwWC8WhalPHXYhj8v3UQlvhKiFbTJG8diIcr6hRgvGKTqXMKztHQx+EK/TxIaLUquwGud0fgBwCuNdjG7cKk/azuzThvByJnRDZL50JuYw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4353.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXVOTTlYN2Z2ckw3OEVUSy9PdHFQM0tqQ2JUOThzb3pRMytWekRaNTdhQ2Q5?=
 =?utf-8?B?SVNBNnlIV2htcEVKa2RjSmw0bXI1ZUo4ZVlaajVJS0x4Smt6cmd1UUNrUHFv?=
 =?utf-8?B?dUc5aGpHM3hWNGpyVkVxVzNjMnpMb0F1R0wzME1YTzl1a1lENzVlNzh3NUE4?=
 =?utf-8?B?VEMrd1drTVA2NkVWZFpDV0FOaHdwb1FxS2lxb1V3QWVBSHJGQlU1V0kwZDI2?=
 =?utf-8?B?M0djNHUvMERkYndBQmhDbXBUNW5SWG9sK2dobkhIKzFvOTNlVkdJYWVNcFZt?=
 =?utf-8?B?eDFBRStDR3NQbnBzMkMrRDk0RXErZzV4WDhqcXBJQVRuMiticy9BbmxEUlFr?=
 =?utf-8?B?U21NaUg4RXErdE5KMmVyTHZNWExDZGxpTFlhVUJXMEFvSUR2MDlGaTNheGc0?=
 =?utf-8?B?YkVMWjhpbldNOUNwTlVlSm82MlNRdndJQXFSRTlVMTFtWHJPK3RCaGRZN2sw?=
 =?utf-8?B?N1Jkb2ViR1hKbnpOekFXRXdtd09pQ01UTVNIOXVRNGo5bmpHQmRQZ0p1bGxP?=
 =?utf-8?B?VjNYOHR3cWU3ZllyRVZpSDVXVTh5TUFuc2pyQ0NrSFZJdk9CRVpKWkhWaEd4?=
 =?utf-8?B?NlB6d3hpTW85Zi9JTmh0aUhnbFhwNHhxUWlWd011eTdDNW1Ec0E5MElNUTcz?=
 =?utf-8?B?SEhaRVQvQXdhK0RBMjdaSWFNUW4vTDBaMVdBZ01SM0dOaS9SRXhPaEJJR3pl?=
 =?utf-8?B?NDZJM01xb2tDR3YwV2FpYVB1ek5zSENoMUpHaGNCbUFjeVRNemgrWjE0OVpm?=
 =?utf-8?B?U1pUUTk2T3hyVUJuUkFnaFNGcmkrbHhzcjFjTHNSQU42NmIzQjlmY2JvSmpl?=
 =?utf-8?B?SVlhVVpaV2xMSkVmNnQ4eW43SzJXSXlOUzRyZGdadDRMbjFKZWd2bnJTUW1u?=
 =?utf-8?B?NHJVOFRBODlHZ0lSQ1Y5b1VvMlRpSERUWnJOa0J4UzNBMkptcERreUhaU3l0?=
 =?utf-8?B?dHZ4SXpsZUNQS2ZmUThSOGJtaXl3UnkwTlZFT1BaWnphODVvOG4zeGM1T2Ju?=
 =?utf-8?B?a202bkRUVnhEMk12UFFrbGRFOW9kTlJoT1dHV0pCMFE2S29RNjI1am9PeFdS?=
 =?utf-8?B?djRtbzJvN3J5d0VVaEZ4U2lycUNmYy9UbXc2OUNIMG9XaTJUTFpCVkNjS3Uy?=
 =?utf-8?B?OHdyN2ZDVURqYkxQRWlSMUZyZGllSVFTczdSaHJLK3NxU0E5ejdkckNMeFBk?=
 =?utf-8?B?dFpQeDhFQWxVemZuMWpWUDF2YTdEVFE4dEFsV25SUkEycXM2VlEwR1M5alBi?=
 =?utf-8?B?UnJwMXJrSUpuYS9JSUd0R0tDbDNEQisrUGxVM0xaaHNITVhXbEdnUjB2RWNj?=
 =?utf-8?B?N1BrSXBUL2VIVVJ6NUNhVGY1d3pkMUlzUEdpVnlOTkUrWnlkZVAzRVpxMk5J?=
 =?utf-8?B?cWlCVWJENkJLcCs2YlFjajVCekJrQ2lPdDBDSWJLbG4rN09YSmNxMUxDNU1D?=
 =?utf-8?B?SVpCQzA1VjlRTXJwUytnZHFVMXlKRC9yWnZLZ0NXSFp2enZ1eHRpTmFqNFdZ?=
 =?utf-8?B?d1lxTUN0Q2J5Q1NubjJPVUlmckVXYUdvTnhDVjRhN2JoRWlSa1R2UTJtUUdm?=
 =?utf-8?B?aVRLZnRDL0tCcUwxR1drcVBWWlIvS0l5N2Jhelg0YzM1NFE4LzJwdTZFRkZO?=
 =?utf-8?B?TlZiNGJ2RzU5N2xKTTkvcm9WczVkVFljSHJUWEtkbEE2NkUrak04OTMwaGZr?=
 =?utf-8?B?bjl4MW5Rcm9URndMc1puTFVpUlhaL1g2dk5ORUlLYitGRkp2aWV4SVgwblow?=
 =?utf-8?B?UlNEVjFMVXAxeTFkRndrbTJCKzNhMDVwYzhCamtOVTY5QzdxeEh6K2xsV0JV?=
 =?utf-8?B?dHl4Q1JTSmV0dFlGWEZSUS82ZDFyaVpLbXZva3lGRzVXSWNwQUthYUluNHdn?=
 =?utf-8?B?QlRES1hEUm94cE9zTEJLc1ZJbFhDc0xReStmSGhZQk55eDZQS0Njb2dQd3ZQ?=
 =?utf-8?B?M3hya3JPR3piTGNieGtaa2VOMHdiUjNEbEVPN1BhMmIyazJiY2F4NWVPcDJj?=
 =?utf-8?B?M3VoNk9rZy95d1pqVjNPajVnN0c1Z1l4TUY4UTA4TzdGWXhsSWdPRGkxMHNx?=
 =?utf-8?B?VE9hM0pBYTRHNitHTjRibzY4OTltZTFzaGZqUGxPeUdVUXo1Qm8yS0lRUXJV?=
 =?utf-8?B?WEV3b3lrVEZqWG9xNFNSTStoUHRSU2t1blNRTTJLaXFpMWwzNnEvRjY0NHJE?=
 =?utf-8?B?MGhweEdDVU9ZSjFxRnpqUFBNUVlLbW90WlN4VmFselpWK3NVZVdDUnVybEVU?=
 =?utf-8?B?QVI3bm1LbUtlVjVrajMrVWRmeGJNVTB5Y3VFMDdMUHBEVHhVSXM1NzFxeHBB?=
 =?utf-8?B?d0VSWDFXcEVVUnQ2elI3TFRlSXhhYUdPSW9UWjQ0L29xVnFoU09WcVdya2FO?=
 =?utf-8?Q?vt0+ZcJXTRy5BkvA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A49E4ED1792A7A4EA09C40DF2B1E2A56@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4353.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26593a5e-340a-449d-f4d0-08ded1d332e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 09:30:15.5032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKj34OztrwNCOm6mtsfCDU3unkiSgHunoBmtd/CSLL8/JDmUmTgR3NMJya1NgrNNfQMH+0BhLVcgEJRotq7KnvVPkGK+/CexlMiTax2xbw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6555
Received-SPF: pass client-ip=52.101.70.110;
 envelope-from=polina.vishneva@virtuozzo.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

T24gTW9uLCAyMDI2LTA2LTIyIGF0IDIxOjA2ICswMzAwLCBLb3N0aWFudHluIEtvc3RpdWsgd3Jv
dGU6DQo+IE9uIE1vbiwgSnVuIDIyLCAyMDI2IGF0IDU6MTfigK9QTSBQb2xpbmEgVmlzaG5ldmEg
PA0KPiBwb2xpbmEudmlzaG5ldmFAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+IA0KPiA+IE9uIE1v
biwgMjAyNi0wNi0yMiBhdCAxMjowMCArMDMwMCwgS29zdGlhbnR5biBLb3N0aXVrIHdyb3RlOg0K
PiA+ID4gSGkgUG9saW5hLA0KPiA+ID4gDQo+ID4gPiBGaXJzdCBvZiBhbGwsIHRoYW5rcyBmb3Ig
eW91ciBwYXRjaGVzLg0KPiA+ID4gDQo+ID4gPiBCZWZvcmUgcmV2aWV3aW5nIHRoaXMgcGF0Y2gs
IEkgd2FudCB0byBhc2s6IHdoeSBpcyBpdCBuZWVkZWQ/DQo+ID4gPiANCj4gPiA+IEkgdW5kZXJz
dGFuZCB0aGUgcGF0Y2ggInFlbXUtc29ja2V0czogRW5hYmxlIEFGX1ZTT0NLIG9uIFdpbmRvd3Mi
LA0KPiA+ID4gYnV0IEFGX1ZTT0NLIGhhcyB0aGUgc2FtZSBiZWhhdmlvciBvbiBMaW51eCBhbmQg
V2luZG93cy4NCj4gPiA+IEkgZXhwZWN0ZWQgdGhhdCB3ZSBjb3VsZCB0b3RhbGx5IHJldXNlIHRo
ZSBQT1NJWCBwYXJ0LCBzbyBqdXN0IG1vdmUgaXQgdG8NCj4gPiA+IGNvbW1vbiB3aXRoDQo+ID4g
PiBzb21lIGRlZmluZXMgbGlrZToNCj4gPiA+IGBgYA0KPiA+ID4gI2lmZGVmIEdfT1NfV0lOMzIN
Cj4gPiA+ICAgICAgICAgaW5fY2ggPSBnX2lvX2NoYW5uZWxfd2luMzJfbmV3X2ZkKGluX2ZkKTsN
Cj4gPiA+ICNlbHNlDQo+ID4gPiAgICAgICAgIGluX2NoID0gZ19pb19jaGFubmVsX3VuaXhfbmV3
KGluX2ZkKTsNCj4gPiA+ICNlbmRpZg0KPiA+ID4gYGBgDQo+ID4gPiANCj4gPiA+IFdlIHRlc3Rl
ZCBvdXIgZHJpdmVyIHdpdGggU1NIIG92ZXIgVlNPQ0ssIGFuZCBzdGFuZGFyZCBMaW51eCBTU0gg
d29ya3MNCj4gPiA+IHdlbGwuDQo+ID4gPiBTbywgd2hhdCBpcyB0aGUgZGlmZmVyZW5jZSBpbiB0
aGlzIGNhc2UgdGhhdCB5b3UgYWRkIHdpbjMyLXNwZWNpZmljIGNvZGUNCj4gPiA+IGZvciBWU09D
Sz8NCj4gPiANCj4gPiAxLiBUaGVyZSdzIG5vIHNoYXJlZCBHSU9DaGFubmVsIHBhdGggb24gV2lu
ZG93cyB0byAjaWZkZWYgaW50by4NCj4gPiBjaGFubmVsLXBvc2l4LmMgaXMgYnVpbHQgb24gR0lP
Q2hhbm5lbHMgKyBnX2lvX2FkZF93YXRjaCgpOw0KPiA+IGNoYW5uZWwtd2luMzIuYyBpcyBidWls
dCBvbiBvdmVybGFwcGVkIEkvTyBvdmVyIGEgV2luMzIgSEFORExFIHdpdGggYQ0KPiA+IHJlYWRl
ciB0aHJlYWQgYW5kIGEgY3VzdG9tIEdTb3VyY2UuIFRoZXJlJ3Mgbm8gaW5fY2ggPSBnX2lvX2No
YW5uZWxfKigpDQo+ID4gbGluZSB0byB3cmFwLiB2c29jayBpcyB0aGUgZmlyc3QgR0lPQ2hhbm5l
bC1iYXNlZCBjaGFubmVsIG9uIFdpbmRvd3MuDQo+ID4gDQo+ID4gDQo+IEkga25vdyB0aGF0IGN1
cnJlbnRseSB3aW5kb3dzIHZpcnRpby1zb2NrIGRyaXZlciBkb2VzIG5vdA0KPiBzdXBwb3J0IG92
ZXJsYXBwZWQgSS9PLg0KPiBCdXQgd2hhdCBpZiB3ZSBhZGQgaXQgYW5kIHJldXNlIHRoZSBzYW1l
IGxvZ2ljIHdpdGggb3ZlcmxhcHBlZCBJL08gb3ZlciBhDQo+IFdpbjMyIEhBTkRMRT8NCj4gV2hh
dCBkbyB5b3UgdGhpbms/DQo+IA0KPiBJbiBnZW5lcmFsLCBteSB3aXNoIGlzIHRvIHNpbXBsaWZ5
IG5ldyBzb3VyY2UgY29kZSBhbmQgcmV1c2UgZXhpc3Rpbmcgb25lLg0KDQpUaGF0IHdvdWxkIGlu
ZGVlZCBhZGQgdW5pZm9ybWl0eSBhbmQgYWxsb3cgdG8gY2FsbCBwbGF0Zm9ybS1zcGVjaWZpYw0K
ZnVuY3Rpb25zIGZyb20gdGhlIGNvbW1vbiAobm90IHZpY2UgdmVyc2EpLCBidXQgYXQgdGhlIGNv
c3Qgb2YgbWFraW5nDQp0aGUgd2luMzIgY29kZSBldmVuIG1vcmUgY29tcGxpY2F0ZWQuDQoNClNv
Y2tldHMgZ2V0IEdJT0NoYW5uZWwgZm9yIGZyZWUsIHNvIHdlIGp1c3QgcmV1c2UNCnJlYWQvd3Jp
dGUvbGlzdGVuL2FjY2VwdCB3aXRoIGNoYW5uZWwtcG9zaXguYyB2aWEgY2hhbm5lbC1jb21tb24u
Yy4gVGhlDQpvbmx5IHdpbjMyLXNwZWNpZmljIHBhcnQgbGVmdCBpcyBwbHVnZ2luZyB0aGUgc29j
a2V0IGludG8gdGhlIG1haW4gbG9vcCwNCndoaWNoIEdMaWIgZG9lcyB2aWEgV1NBRXZlbnRTZWxl
Y3QuDQoNCldyYXBwaW5nIGEgc29ja2V0IHdpdGggZXhpc3Rpbmcgb3ZlcmxhcHBlZCBJL08gY29k
ZSB3b3VsZCBvbmx5IGFkZCBtb3JlDQpsb2dpYyBhbmQgcmVkdWNlIGNvZGUgcmV1c2UuDQoNClRo
ZSBzZXJpYWwgcGF0aCBjYW4ndCBkbyB2c29jay1saXN0ZW46IGl0IG9wZW5zIG9uZSBDcmVhdGVG
aWxlIEhBTkRMRQ0KYW5kIHJlYWRzL3dyaXRlcyBpdC4gdnNvY2sgbmVlZHMgYmluZC9saXN0ZW4v
YWNjZXB0IGFuZCByZS1hcm1pbmcgYWZ0ZXINCmVhY2ggY2xpZW50LiBUaG9zZSBleGlzdCBvbmx5
IGZvciBzb2NrZXRzLCBub3QgZm9yIGEgSEFORExFLCBhbmQNCm92ZXJsYXBwZWQgSS9PIGRvZXNu
J3QgYWRkIHRoZW0uDQoNCkknZCBob25lc3RseSByYXRoZXIgd3JhcCB2aXJ0aW8tc2VyaWFsIG92
ZXJsYXBwZWQgSS9PIHdpdGggR0lPRnVuY3MgdG8NCnVzZSBpdCBhcyBhIEdJT0NoYW5uZWwgKHNv
IHRoYXQgYm90aCB2c29jayBhbmQgdmlydGlvLXNlcmlhbCBhcmUNCkdJT0NoYW5uZWxzKSByYXRo
ZXIgdGhhbiBkb3duZ3JhZGUgdGhlIHNvY2tldHMgdG8gYSBtYW51YWwgR1NvdXJjZS4NCg0KPiAN
Cj4gDQo+ID4gMi4gZ19pb19jaGFubmVsX3dpbjMyX25ld19mZCgpIGlzIHRoZSB3cm9uZyBjb25z
dHJ1Y3RvciwgYXMgaXQncyBmb3IgQ1JUDQo+ID4gZmRzLCBub3Qgc29ja2V0cy4gR0xpYiB3YW50
cyBnX2lvX2NoYW5uZWxfd2luMzJfbmV3X3NvY2tldCgpIChpdCBzZXRzIHVwDQo+ID4gV1NBRXZl
bnRTZWxlY3QpLiBBbmQgcWVtdV9hY2NlcHQoKS9zb2NrZXRfbGlzdGVuKCkgcmV0dXJuIGEgQ1JU
IGZkDQo+ID4gd3JhcHBpbmcgYSBTT0NLRVQgdmlhIF9vcGVuX29zZmhhbmRsZSgpLCBzbyB3ZSBy
ZWNvdmVyIGl0IHdpdGgNCj4gPiBfZ2V0X29zZmhhbmRsZSgpLCB3aGljaCBpcyBhbHNvIHdoeSB0
ZWFyZG93biBuZWVkcyB0aGUgZXhwbGljaXQNCj4gPiBxZW11X2Nsb3NlX3NvY2tldF9vc2ZoYW5k
bGUoKSBvcmRlcmluZywgdG8gYXZvaWQgYSBkb3VibGUgY2xvc2Vzb2NrZXQoKS4NCj4gPiANCj4g
PiAzLiBXaW5zb2NrIGRpc2Nvbm5lY3QgZGV0ZWN0aW9uIGRpZmZlcnM6IEdMaWIgcGFzc2VzIEZE
X1JFQUR8RkRfQ0xPU0UgYXMNCj4gPiBvbmUgR19JT19JTiBhbmQgV2luc29jayByZXBvcnRzIEZE
X0NMT1NFIG9ubHkgb25jZSwgc28gYSBwZWVyIHRoYXQNCj4gPiB3cml0ZXMtdGhlbi1jbG9zZXMg
bmV2ZXIgeWllbGRzIEdfSU9fSFVQIGFuZCB0aGUgbGlzdGVuZXIgaGFuZ3MNCj4gPiBoYWxmLW9w
ZW4uIFRoYXQncyB3aHkgdGhlIE1TR19QRUVLIHByb2JlIGxvZ2ljIGlzIHJlcXVpcmVkIG9uIFdp
bmRvd3MsDQo+ID4gd2hpbGUgb24gUE9TSVggcG9sbCgpL2Vwb2xsKCkgcmVwb3J0cyBQT0xMSFVQ
IHJlbGlhYmx5IGFuZCBkb2Vzbid0IG5lZWQNCj4gPiBpdC4NCj4gPiANCj4gPiBCZXN0IHJlZ2Fy
ZHMsDQo+ID4gUG9saW5hLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4g
PiBLb3N0aWFudHluIEtvc3RpdWsuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gRnJpLCBKdW4g
MTksIDIwMjYgYXQgOTowM+KAr1BNIFBvbGluYSBWaXNobmV2YSA8DQo+ID4gPiBwb2xpbmEudmlz
aG5ldmFAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gQWRkIHZzb2NrLWxp
c3RlbiBjaGFubmVsIG1vZGUgdG8gdGhlIFdpbmRvd3MgZ3Vlc3QgYWdlbnQuDQo+ID4gPiA+IA0K
PiA+ID4gPiBUaGUgbGlzdGVuL2FjY2VwdCBwYXRoIHVzZXMgdGhlIHN0YW5kYXJkIFFFTVUgc29j
a2V0IGhlbHBlcnMNCj4gPiA+ID4gKHNvY2tldF9wYXJzZSgpLCBzb2NrZXRfbGlzdGVuKCksIHFl
bXVfYWNjZXB0KCkpIGFuZCBwbHVncyB0aGUNCj4gPiByZXN1bHRpbmcNCj4gPiA+ID4gU09DS0VU
IGludG8gdGhlIEdNYWluTG9vcCB2aWEgZ19pb19jaGFubmVsX3dpbjMyX25ld19zb2NrZXQoKS4N
Cj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBvbGluYSBWaXNobmV2YSA8cG9saW5h
LnZpc2huZXZhQHZpcnR1b3p6by5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZG9jcy9pbnRl
cm9wL3FlbXUtZ2EucnN0IHwgICA0ICsNCj4gPiA+ID4gIHFnYS9jaGFubmVsLXdpbjMyLmMgICAg
ICB8IDI1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiA+ID4g
IHFnYS9tYWluLmMgICAgICAgICAgICAgICB8ICAgNiArDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5n
ZWQsIDIyMiBpbnNlcnRpb25zKCspLCA0NSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gDQo=

