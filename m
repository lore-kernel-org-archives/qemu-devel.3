Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E537ECCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 05:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHFCr-0007PO-L4; Fri, 07 Nov 2025 00:40:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vHFCZ-0007Ju-Iw; Fri, 07 Nov 2025 00:40:04 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1vHFCW-0001xA-UU; Fri, 07 Nov 2025 00:39:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSUlQhWC8EZwrLfTpPeAZ37MOx7+cnDVBX5L+sHRtfndJpztjMcWrE+zKH0cyeyK5hAIOL2gK3M7ojdueDHH2NYcGpk39QVob2AUwpRYc+1jo88WUrrN0+UYkqEhB2FrSMfnW9rNGMAy9LxwBKG+h+Tl4hWWSeU0AWeJeAj/X62So0qpkqixc7btKYm7PXNpj15p88tVPSg37VedfAbjVn18Jvno5NAe5aYJZEsCi9u3EcInKKm7liS3VEKgtxbVpdqF1foC2ZLnOb8Wm/TXjVYbyVkBODSTbSesItzHZImsPwICbOoLw9aEQlhupND+cyRYfxfacBisXKHTRAWRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxhggbHGacDYfLJPctkYFg6YQ5girJRnYhOqTSIVIcM=;
 b=Ym4sze9bcvBfGaOkxUq20wTTnWh680Ufp7D9/nhiDsF57Mn+fTOUQVKzLHIZCrh8wr5KFZPUxbhAqtifr5UV1OdNuiLauC12vlBUcqU1jVPS3aVNyFGl+hqcXrHKo2roO1dXRoPy1JXIixNwgvep1m/llE2p7KgAg2Meaf22a0IDgwFaxahzI1uAt5uJCgmbUb9qQ82IhKFsB5ylyhpLuJ3J5mr4CvM4RmmxP5hGIFYJLFPady2xcAGlPxxj+REVCFD6wEI47yiLLWF8RsCkLOkcETiLsh0IUKdqfwiQxhoMyIvz5bRPDiECpBx12Yr94VC8ZK2nPvWictlyGrj88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxhggbHGacDYfLJPctkYFg6YQ5girJRnYhOqTSIVIcM=;
 b=MpDdwWhtYVtNtBFSmn3H54qPlGYXF3fONZ6UcKCo4hU3H6BN99E+WrtjX3iPdNcyibXGpC1ARQRavNKUsM9LsfzFADcxATekkEBFLrNBPWdg9nHWmPNnvSx6qP3jYbbH5O8CYeZ7NsK8x3ZIyDHNWtuF9DmKZIgx9w51ZzDtyA+ovsnM0Lf8gOdeEOR3SatYYkXDPegulXZMk7U5AYzfeFG6hDRPXLGqRT0KfkeoGMQIrQSOMnlVvMLC8GEu7nF6lT7/9nl4oIgfj9m7pbJleiT4B+7K8kq6zt2+/RlbXfo62ueG5iGU8lpBRFivKLkD7wqFdqyLT3kOsykn5Almew==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by SI2PR06MB5220.apcprd06.prod.outlook.com (2603:1096:4:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 7 Nov
 2025 05:39:48 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%6]) with mapi id 15.20.9298.007; Fri, 7 Nov 2025
 05:39:48 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Nabih Estefan
 <nabihestefan@google.com>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, Troy Lee
 <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v2 09/17] hw/arm/aspeed: Attach SPI device to AST1700 model
Thread-Topic: [PATCH v2 09/17] hw/arm/aspeed: Attach SPI device to AST1700
 model
Thread-Index: AQHcTgiNuTYypmurUUmlcrqM/xZDO7Tkl+sAgADUZxCAAAXvgIAAAKSA
Date: Fri, 7 Nov 2025 05:39:48 +0000
Message-ID: <SI6PR06MB7631B9585407C002183D6787F7C3A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20251105035859.3709907-1-kane_chen@aspeedtech.com>
 <20251105035859.3709907-10-kane_chen@aspeedtech.com>
 <CA+QoejUqmspVZG=-T8TRbbc5nRXy0YQsLg6A4M54o6k=EkW6kA@mail.gmail.com>
 <SEZPR06MB7619311D7021C5112BAF664AF7C2A@SEZPR06MB7619.apcprd06.prod.outlook.com>
 <99b099b0-e28d-4fc3-b2d3-5e9f08d1d6f2@kaod.org>
In-Reply-To: <99b099b0-e28d-4fc3-b2d3-5e9f08d1d6f2@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|SI2PR06MB5220:EE_
x-ms-office365-filtering-correlation-id: b8af72d6-5650-4e7d-d3d7-08de1dc010b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0ViMXN4cytrOGhTZkNiNCtiWEtrb3dpaW5aTGdiQ0xOYytkd0ZwYzZiejk1?=
 =?utf-8?B?UzdDZW41NTNwT1pGc2RXT282Q2szS0Y4N1kzc0RTWkhlQmtLQTE4SDlXRzBB?=
 =?utf-8?B?QWhRR0c1T1g2STEzeUhYNHhySEZqbHYyMWhLbnR3WENFZWpBRld2Ti9uVDZV?=
 =?utf-8?B?VDNBV3h4alVsbXJvWitQMkVFejRLelZyVDN4cE1XR3V3QVh2YXRVN1U5MDdP?=
 =?utf-8?B?eUsrT1lhZkI0YWZwK2xpMUZTeVZjaUxodzd2cEp4Nm5jbVlVQTlqcmV2aFgz?=
 =?utf-8?B?TWdDY0p5VHgwZ3p2SU1aZVVCVjUzL2tLcjJjNllNL0huaUVJTFVHdXYySkJ5?=
 =?utf-8?B?czY5RGtFbyt2VnNYTG4wU0dBNlNCdHRRekR1bWdmZmFmYm9rRHZJRklKVlhE?=
 =?utf-8?B?eWJXYTNkN0plbG41ek5MMUlRdmVUblMxMXdKaWZWWjhJaXpHcVBBLzVnM2w3?=
 =?utf-8?B?OVMyT1ZWekVHeU9LNG12MjJKVTkwL3hCOE10NVpTT00xZ0YwSUttaytQaTZx?=
 =?utf-8?B?MnFtV1BhUVhjQU92T29ZTCtXRkxIU0tVMURFb05lcmdqZlo0MG92SHhwS0Fw?=
 =?utf-8?B?amZlRjRwSDlDai96SXhVQkt6NXo0VXZHSVhRaGNNOEFsMzZiZFNSNkhOME52?=
 =?utf-8?B?NmErYWswdVpIcjVpYXlzcSs5aEFuOTNkZHpUZ0dveDNxdXpxN1RLZmpMRW1l?=
 =?utf-8?B?MXhQeWpsNWNFVW41Rnl5WHFqQmtGWEdac0h5akVkbVBlTk1ZU1lyY1A0MWpM?=
 =?utf-8?B?aHAzOU12MVhlMWd3Skp6aGpIUUdVQWZwU09ac3A1MUN4bkdyaFd5R2tUV3lI?=
 =?utf-8?B?V3RlalV5YnRLSEFyVDlSSTFpcEM4WGR2eTBJa0R2RlIxOGFmZkh0NG1BOXBO?=
 =?utf-8?B?dFVRNkhESjN3TUgvMDB4SVFvWkVvMnM0TmZwZm9aalpGYUFuNkpWaGZUZkNK?=
 =?utf-8?B?dDhzZ0FDWkJUQWp2Rnd1MlhOWTVBSkhmNGltL1ZqSGZaN1VYL05WWWRDUTBZ?=
 =?utf-8?B?TzEwWEdxWFJyYVo3d0tsYTcrM29GMDl6dVN2Lzh4UmtrR3B1d3VDaEQvekxY?=
 =?utf-8?B?bkQ5VG95RXZ3ZzhPekFzci91cSt4VXo2TmlZN0J2NmE0UFVWMmMzek5NVlds?=
 =?utf-8?B?d3IzWS9jRGE5TlQzTDVPajhHT1diUk9RRVFzQnpyVkpUVElHQ1VzeDRLNTVH?=
 =?utf-8?B?VXBKREMwZTdqcUxWekJ6WnFXYUs5N1NOL0czRXdRc0tvWVBiL3N3M203dy80?=
 =?utf-8?B?blBsVVdJNkhuOHgyQ3JMejQ3L2phSGpNTXFEQmxTZHg4dHZkUjh4TDhXbGVk?=
 =?utf-8?B?MmhhK2hZQjVtWUdmUkhVcDE4Qmt1WUVVZWphai80cHYxbVl1VS9jYmJiNnFO?=
 =?utf-8?B?b3RiODZES2NpbjR2YUtxM3RsVWZIWjh3WDJHcFJENGdhY1gwSk5IRTZTNzl6?=
 =?utf-8?B?dlpvSXFXT1AzbDQ0bW1ITW5lNzUxazdTMXorNk1DaXNXUmJhSU91eFpEbzhX?=
 =?utf-8?B?L1p1UWR4eVNoT0lHWDhuUmZEN2MzQ2FGRXNaWVQxRWZTb2tTbThQS09vZ1dZ?=
 =?utf-8?B?NW8yTWgrKysrbEJRbFBjd1B6eUxkcHRDbkhsYitzTlFLU3ZKYzcvcm5lbnh5?=
 =?utf-8?B?VW9haXp4RWNSSHNkMWJkWlRzeGRqREZQUDdkT3BSVk5lTEhLZFBsbGFud1BB?=
 =?utf-8?B?Nm5sdzdXeXZaREFLZGVDVXh2TmovUHRXejNVMlhiblpIR1FVZldjWExybE84?=
 =?utf-8?B?elo0NWxQaTR1eW1TZng2YThBWFBHU1VBcXVhZXR3WSs1eElmQmJ6T3ZEbkQ2?=
 =?utf-8?B?WDhBUWpZbjdOdDRpbVplSXdQSXFPcEF6SThsdHhuRWJmaFBKb3JGL2doL3hs?=
 =?utf-8?B?OUVxbnk4UVlCd3BwM1NqS3VubmdTYTZiQ1JYZzFmRTVaSTdlWlByY01PQkxm?=
 =?utf-8?B?ak1aZStVUEoraXJ1VVYwZ3FTU254UHBRV2J6ZDhoTzVIeENyc0FpajFWWlBF?=
 =?utf-8?B?T2M5ODEvWVhaRHZaTHFRSGhNTGxEMlJJTm5OVWFIZGxCaGdXNVNFUFpCMEZF?=
 =?utf-8?Q?MW5rtA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nkc5eks1SjQ4SDZncHlGQ0Z6Nkl4cEZha2lQTm54aHFma01jME1ub3ZpVWdn?=
 =?utf-8?B?Q2hzRURmNGlmL3dNTmZ1dENQZXVDS0x3VzJyYVUvR3liS3ZsWEY2WE5oNW4w?=
 =?utf-8?B?OURGVktBbW4rMHhHTnpSNjBTaC9WdG5PR0VINS8wQ2kzcStVUmNSNStuMmll?=
 =?utf-8?B?dmpOdmhNeGRubURwUE5SVy9PNHMvUEU3Q2lRLzNJSW9pU2JJOGM1WUxRa21x?=
 =?utf-8?B?N3VCb01lOHZ3cFlrMGlrUmFwMHFhS3JVbDFrVytLdGZwTGpZQWpkU2xvOVF6?=
 =?utf-8?B?cnp0NVgxeUZJTW96clV1TEt2QWhOYkhGenI4QUpCYUluOHV1NkJDMlJzNXMv?=
 =?utf-8?B?WUV6d0tnWmQrdlJ4RWZjYklkcVhlV3dLZ29TdW52UmN1aFVLTzBPVUxBTTZF?=
 =?utf-8?B?ejQreFdFbFFBYWsxRVV2Rm9tWVN6RTkzdzIvVXJYenFDK3VtU2NYQUdEZkpm?=
 =?utf-8?B?TEMrRnVGc0UvUmNEU1J6VmhGb2orMTljc0xHa0QyT3hjeDhrdlJoa3Y0OVVu?=
 =?utf-8?B?RDhWc1VQcmhBbDIxOThKdXFUQzNWZm5aVUszUWJzUzVsS0tETFZyVGcwbE90?=
 =?utf-8?B?MStjRlVnMUFrNzNYY0VGeEg5UmVpbG94Y3AxbUVjS2JpR3BEMXNRcjZxcVMv?=
 =?utf-8?B?dzJiditLRTJ5Q3BBOC8xQlpiK1JzanhlTzc3Nml5OUVCR01ldGt6aDFMQTBB?=
 =?utf-8?B?NUErSEs2cXRFdlJLL1haWVRvclNqT1h0dlNUaWMydjUrMEYvb1NHVDQxUHNO?=
 =?utf-8?B?ZGZtalQ0U2labFRFZ1lUa08vMzBaMm9TTnVncDVoZWs3QkY1V0ErcURuUk5U?=
 =?utf-8?B?andNeXRLWThqTjJKekRyclVCcDFBQmU2QWVlMWxxbFVPMHFGM1l4OTdnQ1lI?=
 =?utf-8?B?V2tRZ2FialFleUhTcmdIc3RyY3BHNExrUWpJbmViTllmWmMvTEpicWExTzlw?=
 =?utf-8?B?dWVod0RtL1VwYmVuUDdLaXFrc1A1dHo4cjBzUTA4bFJ0RDloSjh0RDFvbXJn?=
 =?utf-8?B?ak9hRFpxY3Z5cUQ3MWJoTWFoMUZ3eGxYbUhEYlVyenhKZk4zMUhkRmlHOFlH?=
 =?utf-8?B?dU5qbWpqL1hxemRaUDUvdEd2T2QxUGNVbjZhbXU0Qk5wODIxUXRFWUJrR2Iy?=
 =?utf-8?B?dnlvVmExSDZDSFNhcmZNbEN6VjgvTzdNeFJWK0kwSjFNTlFwMTZxMEpxSjlF?=
 =?utf-8?B?SkJHRGtaa1pickhyUW1yaUYweEhXaCt0ckY4ZDNUWXluaGFvS3VGYVNVN0ZI?=
 =?utf-8?B?bXplUFhjcjVNLzJuWVdYK1h0ZytHMWU3OWF6SkY0TGZKYmlGZzZrSlNqN1NB?=
 =?utf-8?B?UWVZbTFQQWc0cUllbkVEUGdKRDBnaFplY2ZNa0dQeldqNUpWdzhxSnlKVTd0?=
 =?utf-8?B?UnFjTENzM1gzOGJHT2lnNG9raTdLaDREMC95QkZPakUyMjNqU2dYL29lbzVp?=
 =?utf-8?B?UWR3SXI5bUdhOENVR2tEZUpXTGI4Vnk1Qm5OcW5oMDcwZnh4VHhjMG5rWEdn?=
 =?utf-8?B?QjlTbHlDTnAwc1RkdnZ2UmpNR0Qwa1NCZTBIa1NDSTJVK1J4RGFJOGdQZkpE?=
 =?utf-8?B?dlN0RkIvMHBjdjVwd0VCbS9vR0sxeEtTNWsvZldPT1ovOXJUUHNUZEkzR3Mr?=
 =?utf-8?B?U1VDdlZ6WGZlT0t4ZVFKaFJ6N0tSb3M3aG1iZFFMbEVFVmNwenQ3TW16Skh0?=
 =?utf-8?B?NHRab1FQOVlJN2IyaWlheHZCaUJyM3FYRHRKTjFlSUpUYnFiY2FhQllTRVlr?=
 =?utf-8?B?UmRlWHJMVXhROVJYTUFYQTRRVVVPWkRZR2djSDExclNvbmowT0J2aFVvRXNt?=
 =?utf-8?B?b3dTbjRGL1JVcHdqcWphYTNtYzJDMVh4S1djaEY4ZlhVaG1wUlJ5dkFoNUYy?=
 =?utf-8?B?TnZ3ZkVIQXZzVm5IdnhPSDhqUWZPRVhzOUdWcHRvd245K0licUR2ZmhmY0Rj?=
 =?utf-8?B?b3g4QmtNa0JudEFuZ3FBOTAxYkNTUjVUZm41Q1ZRTUpBdnJhNEtLS0RtWTNu?=
 =?utf-8?B?dGhTSHNtRjgwRyt3QXFqalRFWFpUc3hPdnJWS1B0WkNsWmZCZFN4TDdjVjRk?=
 =?utf-8?B?eHZiWlc5bWgzSXhDY0o3RG5UaVIveVZ2UUpCeEFqK2N0NzhaVGVzTXBOZG9w?=
 =?utf-8?Q?7TifQRVle6neFyQr9fjoKpBxt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8af72d6-5650-4e7d-d3d7-08de1dc010b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 05:39:48.4134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTty5SViyWmUiX/kVpwcjUYDNfCj011VHtbqcU5dNIfJ1+hudhOUGUhlRkpoxr8NZRX5GNk7h8o9n1Kl5MULR96+WDxu/QYzWINtGjXJ8JA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5220
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=kane_chen@aspeedtech.com;
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

SGkgQ8OpZHJpYywNCg0KVGhlIHJlYXNvbiBJIHJlZ2lzdGVyZWQgVHlwZUluZm8gYXNwZWVkX2Fz
dDE3MDBfYXN0MjcwMF9pbmZvIGlzIHRoYXQgQVNUMTcwMA0KbWF5IGJlIGNvbm5lY3RlZCB0byBh
bm90aGVyIFNvQyBpbiB0aGUgZnV0dXJlLiBBcyB5b3UgbWVudGlvbmVkLCBhdCB0aGUgY3VycmVu
dA0Kc3RhZ2UgaXQgc2hvdWxkIGJlIGZpbmUgdG8gdXNlIGEgZml4ZWQgdHlwZSBuYW1lLCBzaW5j
ZSB3ZSBvbmx5IGhhdmUgQVNUMjcwMA0Kc3VwcG9ydGluZyBBU1QxNzAwLiBJJ2xsIHVwZGF0ZSB0
aGUgcmVsYXRlZCBjb2RlIGFuZCByZW1vdmUgYXNwZWVkX2FzdDE3MDBfYXN0MjcwMF9pbmZvDQph
Y2NvcmRpbmdseS4NCg0KSWYgeW91IGhhdmUgYW55IG90aGVyIGNvbW1lbnRzIG9uIHRoZSByZW1h
aW5pbmcgcGF0Y2hlcywgcGxlYXNlIGxldCBtZSBrbm93Lg0KSSdsbCB3YWl0IGZvciBmZWVkYmFj
ayBmcm9tIHlvdSBvciBvdGhlcnMgYmVmb3JlIHByb2NlZWRpbmcgZnVydGhlci4NCg0KQmVzdCBS
ZWdhcmRzLA0KS2FuZQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIg
NiwgMjAyNSA2OjIyIFBNDQo+IFRvOiBLYW5lIENoZW4gPGthbmVfY2hlbkBhc3BlZWR0ZWNoLmNv
bT47IE5hYmloIEVzdGVmYW4NCj4gPG5hYmloZXN0ZWZhbkBnb29nbGUuY29tPg0KPiBDYzogUGV0
ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPjsgU3RldmVuIExlZQ0KPiA8c3Rl
dmVuX2xlZUBhc3BlZWR0ZWNoLmNvbT47IFRyb3kgTGVlIDxsZWV0cm95QGdtYWlsLmNvbT47IEph
bWluIExpbg0KPiA8amFtaW5fbGluQGFzcGVlZHRlY2guY29tPjsgQW5kcmV3IEplZmZlcnkNCj4g
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQu
YXU+OyBvcGVuDQo+IGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUtYXJtQG5vbmdudS5vcmc+OyBvcGVu
IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZQ0KPiA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgVHJv
eSBMZWUgPHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDA5LzE3XSBody9hcm0vYXNwZWVkOiBBdHRhY2ggU1BJIGRldmljZSB0byBBU1QxNzAwDQo+IG1v
ZGVsDQo+IA0KPiBPbiAxMS82LzI1IDExOjExLCBLYW5lIENoZW4gd3JvdGU6DQo+ID4gSGkgTmFi
aWgsDQo+ID4NCj4gPiBUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJdCBzZWVtcyBJIG5l
ZWQgdG8gYWRkIHRoZSBhYnN0cmFjdA0KPiA+IGF0dHJpYnV0ZSB0byB0aGUgYXNwZWVkX2FzdDE3
MDBfaW5mbyBzdHJ1Y3R1cmUsIGFzIHNob3duIGJlbG93Og0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuYyBiL2h3L21pc2MvYXNwZWVkX2FzdDE3MDAuYyBpbmRl
eA0KPiA+IDNkOWE5MjBhN2EuLmVjOTUyMTdmMTYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvbWlzYy9h
c3BlZWRfYXN0MTcwMC5jDQo+ID4gKysrIGIvaHcvbWlzYy9hc3BlZWRfYXN0MTcwMC5jDQo+ID4g
QEAgLTI4Niw2ICsyODYsNyBAQCBzdGF0aWMgY29uc3QgVHlwZUluZm8gYXNwZWVkX2FzdDE3MDBf
aW5mbyA9IHsNCj4gPiAgICAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihBc3BlZWRBU1QxNzAw
U29DU3RhdGUpLA0KPiA+ICAgICAgIC5jbGFzc19pbml0ICAgID0gYXNwZWVkX2FzdDE3MDBfY2xh
c3NfaW5pdCwNCj4gPiAgICAgICAuaW5zdGFuY2VfaW5pdCA9IGFzcGVlZF9hc3QxNzAwX2luc3Rh
bmNlX2luaXQsDQo+ID4gKyAgICAuYWJzdHJhY3QgICAgICA9IHRydWUsDQo+ID4gICB9Ow0KPiAN
Cj4gSG1tLA0KPiANCj4gUGxlYXNlIHJld29yayBhbGwgdHlwZW5hbWVzIGluIGFzcGVlZF9hc3Qx
NzAwX2luc3RhbmNlX2luaXQoKTogcmVtb3ZlIGFsbA0KPiBzbnByaW50ZigpIGFuZCB1c2UgZGly
ZWN0bHkgc3RyaW5ncyBsaWtlICJhc3BlZWQuZ3Bpby1hc3QyNzAwIi4NCj4gRm9yIG5vdywgSXQg
c2hvdWxkIGJlIGZpbmUuIFdlIHdpbGwgc2VlIGlmIGV4dGVuc2lvbnMgYXJlIG5lZWRlZCBpbiB0
aGUgZnV0dXJlLg0KPiANCj4gQWxzbywgSSBkb24ndCBzZWUgd2h5IHlvdSBuZWVkIDoNCj4gDQo+
ICAgIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBhc3BlZWRfYXN0MTcwMF9hc3QyNzAwX2luZm8gPSB7
DQo+ICAgICAgICAubmFtZSA9IFRZUEVfQVNQRUVEX0FTVDE3MDBfQVNUMjcwMCwNCj4gICAgICAg
IC5wYXJlbnQgPSBUWVBFX0FTUEVFRF9BU1QxNzAwLA0KPiAgICB9Ow0KPiANCj4gQ2FuJ3QgeW91
IHVzZSBkaXJlY3RseSBUWVBFX0FTUEVFRF9BU1QxNzAwIGluc3RlYWQgID8NCj4gDQo+ID4gT24g
dGhlIG90aGVyIGhhbmQsIEkgZW5jb3VudGVyZWQgYSB0aW1lb3V0IGVycm9yIHdoaWxlIHJ1bm5p
bmcgdGhlIG1ha2UNCj4gY2hlY2stZnVuY3Rpb25hbCB0ZXN0Lg0KPiA+IEkgbmVlZCB0byBpbnZl
c3RpZ2F0ZSB3aHkgdGhlIHRlc3QgY2FzZSBmYWlsZWQuDQo+ID4gT25jZSB0aGlzIGlzc3VlIGlz
IGNsYXJpZmllZCwgSeKAmWxsIHN1Ym1pdCBhbm90aGVyIHBhdGNoIGZvciBmdXJ0aGVyIHJldmll
dy4NCj4gDQo+IFdhaXQgZm9yIHNvbWUgZmVlZGJhY2sgZnJvbSBtZSBiZWZvcmUgcmVzZW5kaW5n
Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCg==

