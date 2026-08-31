Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F20DC61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0vQP-0000r9-D1; Mon, 31 Aug 2026 02:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0vQN-0000qu-GY; Mon, 31 Aug 2026 02:23:19 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0vQL-0000MB-Fg; Mon, 31 Aug 2026 02:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBm+RhsvvgSXdIIXrqARU99rNcQB8MYGSxWYGud7Gkw4rVhMAi87iirC9lGV06GI7tmtQGKL5JS/re6yv8b9gINsJzWzKTPSoy9Hty6bss5hLMefQLWBBtRQK4RZ0wPvM2FiIbZ/RlNEC1G1acn2n+mebRW3jcfUZSQc7UNulD2HMURFw2gomdNlH3G875+snW8lzmQetX4xoyYWH25y5lrB9uIEDQMdFTpkgEV/otFzLTw9qr+PDu4zm39gWDpxuab7VxXxk3hVPkmTqT8AxW2OJSP8FChFiT3X5qjORjwXSpuhxWtb5okNYzkS21Is8v1pXW4a9O6fqndvv2+Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLcq1BJoqgAeFGH3Cfo+FM+yr1GzcxPhJ50ng5XkqwY=;
 b=dmKpkDkXL+LjbCcGYnU1Fx/I0vQlm9NTQuvdzsBFlCebHCWoiDqj1OY9eOlFOxmkSpnxM4/LU9bZBcCsT8yZqtWf7QhhfAJfLY0M1FCmui/WT+w1DlGFLoOBRm7uwanW/CJ34nEjX+vCMO6qZECrkOUBnTJiGTsMGzBg84HDKAKd5QpB5SS5XUpsn1hDBAi9LYjBRaKPB1N90GBfs6NuLlHe4saApQKAGh6Q5VrDXHhDcFf90hsOAhOkcRM/XFTSni4uCMPFP7p+Pa+N4F/2B8PUUS6EZhHKiQj5foqNT8CymjODUtjbcNNfxkBcnZLXunieRukD02oYkTzx6NuSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLcq1BJoqgAeFGH3Cfo+FM+yr1GzcxPhJ50ng5XkqwY=;
 b=NKboJ718J9KxhC5dWrYU9AZeZnoP1sDPpRFVtxWKr2LJqThbHH8VrzEq6IuP3T8yh5H4b08d5pKrlHoK29bipqvhi+fTyRuU9dJFRjOQ43dygzWexvf8mbclwdONCTHIgH/4ttBt0QXLt7kkmXhqdCw1AICY2vtU4IIYCOTEKOWyYPyzb+JdMBIKdupF4h7e5s4njwulTmtcgnRAzcTT+RqTH19CZ6QYJ/67l9wP5J/wHdX9+Y3uPPQTOM+00l5n07pT6fWJ7tm3Ts7rfn6VEoqhUY4XWutJHp3kTyLXsYxyp+xf4Xlo6CBT/4hlTVoz8H77+SBxvPlMGc22qEKzHg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SEZPR06MB6229.apcprd06.prod.outlook.com (2603:1096:101:f1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:23:09 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:23:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v3 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Topic: [PATCH v3 4/9] hw/arm/aspeed_ast10x0: Remove obsolete
 unimplemented SBC mapping
Thread-Index: AQHdOPqtd5QUDj8ZqUSVCEfgziBpl7a3qV+AgAAAmYCAAAZEoA==
Date: Mon, 31 Aug 2026 06:23:09 +0000
Message-ID: <TYZPR06MB49805BE5615599EEA3E7DC79FCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260831034153.192916-1-jamin_lin@aspeedtech.com>
 <20260831034153.192916-5-jamin_lin@aspeedtech.com>
 <c8e259b7-3b42-4dc3-963d-2ce8ee680500@oss.qualcomm.com>
 <5f9b574d-84aa-4220-afcd-a5d5bf80dcff@oss.qualcomm.com>
In-Reply-To: <5f9b574d-84aa-4220-afcd-a5d5bf80dcff@oss.qualcomm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SEZPR06MB6229:EE_
x-ms-office365-filtering-correlation-id: b84e6014-b6af-4846-7207-08df07285390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|7416014|10067099003|22082099003|18002099003|4143699003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: DrIVXRDJLTYL19HAsuzILnBeI9wPfb0bJXAnaXWgj4TFxsB4Ffr6xHJEarOnj8d/IVzp0NHVXzr3Judd1KmwploJ2DUX240HmuvoUL/4uM9nBACGeeRBvsjTrKTJCHVmkE1LqYwQxirn9SoCylJ8yrLCjG/4c+aqVdr1ziquhE9etxqHsilDzu+8hy4FRD8RFMC+M+GRFvYn2YZ4BIF6dYlAFTPsy2Y4gE0IpDFEiItOMbLNae6mo1LoLmSZ7DpNoU+jSrdfIgAmC4s3aXHUX9sa2Ew2nJxj9Hg+4C787vbMZV2yEgiALvpHKhmCIStx5emCTkpolV1xtzNpdipgrx889R7/xrRo9utzqDWS0Giyxwn8Ct1b8aS6OlC/X+n8e9bQ8eJKazFB3zjyVHagx/sHySDJdzenmH1LhZN7gicOrT5mYucdWvLoIUNyfCbqICc3htG/CY6pppliaPXxlRotm73QIKwef1xnLGZr25/7/YiWIHKJP4u0URgEX4xHExtnm0JOTeegP1pbd5JuLXyo8Ub2aZU9Zzc04aTNobHTBF5t32Lg/QIr2qtXh/Y8bdbziauNUSKG5U4CyFQvpEmIKx7qB+2dQZZmFdkbyvXZlU+5hwHRt/wTWvkIChQuDXjIyWu9x6Es2lLvsU5HgLD/IYYstC37EeR1Dwrg/OYHZMXiQo+WD2xqtOH8g4x8McSxRgRIqgWxcdqnsP+S/v5Ehmunp8J2w7wLWHLTbrw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0ptTk8zRC9jdzlRSjhRdjN3UHIrYloxM2l3Nmhrb2piTVF0L01lSXVrdU9G?=
 =?utf-8?B?Ym1YUlpPOTB6TDh6U2hGYjhtZVpydklqQ1BmTDFRem9oOWtpRWQzalRudnVY?=
 =?utf-8?B?N0VNWERzdUgxWHBXU3hnOHF2cnlpUEprazVqVG1hVS83V1YrdVdXNHJ6elp6?=
 =?utf-8?B?YVNPWllkZ3FwNzJiZjkvUUhJcTAxOGhBV0twb0xTMjZRV3REZjgwbGxrYkpM?=
 =?utf-8?B?TldXeE9GellOQTR3QTRYaXZNSUxJbHBxa2N5d3VRT0hLektzdFkycm5LWUgz?=
 =?utf-8?B?bDN3OVhuNmU0NGptVVE5QVVyUDhYR1JKbVpLeis3RmdIRGt0aWNkYTNBUGYz?=
 =?utf-8?B?SVpHZnhQbWdQZjFpUGpMMkh6VDZrUE11RzNvT1dOemZKV0FKYW85d2pmREs3?=
 =?utf-8?B?MTJpQzBFZmNUU2VPWWViTmJ4Nk80Y1NUZis4ajBkLzMwdkhFK3VCWWFydlRo?=
 =?utf-8?B?cDZzSitKWlNyMWVwRDZxbEpZVThBMi8xejJFMllwUVVxRHBFYnluclgzbm5p?=
 =?utf-8?B?bUVtUzdMTkVzMlBaeEFaeHhPMlR5a2RtOE9IcklqZEtOaE40OFB4d0JMQlhL?=
 =?utf-8?B?eUl0Y1FMaHRISEU1cmZZWjZPcXNGWHo2YjZrQnhaN3BpdnkwaStpWUtqNTVI?=
 =?utf-8?B?bXFtSjNaYlpZblJYaFFsN25lTWV5UFhGMS92ejlRaWNEdVlZZVFWQ2NqU0sv?=
 =?utf-8?B?K1JjVi9YZGVOdUhoZkFEZHBrRnhjcTZrN1FPYnBvRW1hWjNSb0NFYSs3Z1ND?=
 =?utf-8?B?SytnaDltcGJGVzNXcE0vUDhtd0d4b0I2YVFOSXBMMjZ6akZMWnRrODd6VTdY?=
 =?utf-8?B?dkFQSko2ZG9ucnRDaWp1Nm4zSGdZMk5BRFh3Mm5VbVFWV2FpQStWRmM0S3Vv?=
 =?utf-8?B?T2RKcjRSNTVhYThyZzFNemJ0d2RvT2Jlc0ZpYlp3YnZZYWJaT3JwUXp2bG5G?=
 =?utf-8?B?M005OGx1OGJpb29UZHpERmkzZDhQZWdYdTBSK2lDT2lKQ2NJLys1a3J2b09U?=
 =?utf-8?B?Z005U1pxbkl3WnM3VGV0dXRLcGZ4NnBqdWl6c0grL0RDZmpRR1Q4WTk3Umdz?=
 =?utf-8?B?OVNCZVpoR2lBd01LNWFsSURWcDd2S3g1N1dtdUlFSHpCSjJQMFJvL3VoRm9s?=
 =?utf-8?B?d2R0UnYrZG5XSHF6WUpEMnRQaFNMU1NadE1xQU1Cd3JSQ2N5TmRuSytYNnA4?=
 =?utf-8?B?bVdqVjlwNk9TTmhDeER1eHpkaVl6VFVEZmJlWDlDOE1OaGdDOTNMMk9TUjBj?=
 =?utf-8?B?T2Fvc3JrT1cydHEzVXFuaWo5anZ4bTZtZnMyMG5nTjJXQnRzR1JhWXc1Zmo5?=
 =?utf-8?B?ckpnU1ZocCt2MDl0bXBDY1lTVVVaUXlmZ1dEaitpVUJOT0pBVXdqaTByT3dl?=
 =?utf-8?B?Lys4Z0RKdytrSnMxajBCSHFHSzhiRHVTbEhhQU9qb0VjNlkzZTVDZU5Nei9a?=
 =?utf-8?B?emNraE5wVHA4NDh3KzBrSjFsSUZqOGc5a1ErRzJxdGI0TmQ5NjcwTWExSTdZ?=
 =?utf-8?B?b05BTkFFRHVodWg5UlZjUG5jN3lEVit4SFl0ell4Q1ZqZE9yWWpSOXVZUkg1?=
 =?utf-8?B?L2NWV0VjYm5DV1NhSVRCb1ZqeVQ2bmFKN3Iyb2pqRmg4c2l6ZU9Tb0ZRdHZi?=
 =?utf-8?B?enpzYVV1eUxJN3l0ZWN0L0tKb3hVYnlRckJGVGkwZkhTQmRoTEpHYVhzRHEr?=
 =?utf-8?B?Ni9DS2lzZ0xVQWVJaGxtMG9qS2pGOXYzckRqQlJTSGRxVERaZmJ3YW9NTXBk?=
 =?utf-8?B?eTB1MDV1VElJTWFUYnRPZkFRMGpqUkUyTzRBbVNTYzU3eFdQRVlDY1FlaUZD?=
 =?utf-8?B?UDB2bGdvVTJUMnhxRldMVWdJM0crU1BtaHB3clNFekd3VDJ2NERFMWhJY1Nx?=
 =?utf-8?B?TE92NkpYRXB3NXdFWVJVV09xVjNkTkxTNGtyOFZpNktHT1E0SmtvOURKcnli?=
 =?utf-8?B?L0hiT3NmYU8wWTlOcldKdWNqbVV3ZkRvekFkSEdwbjBPNm81RW9jS3dVQUFv?=
 =?utf-8?B?SkI3dkF4UDVncVRNeHpCVml2S3JhYms1aXk5ZGtFZGFYWS9pdkhlSnh4T0NT?=
 =?utf-8?B?MHRpV1JoRk4ydDdERUZkZ3NLbVEzOFZWZCtsbDB2MEo4clF0OWt5NFd2RDhI?=
 =?utf-8?B?M2dZMlA0YUZXb0F4REliRTZBTHNjOUlRVTVqRFVPNmRmWEN1T1VoR053ZUVT?=
 =?utf-8?B?Rm9sSXNXcFc4aWVmcGRQbSt0VE96YWlUU1ZsNTAvK3YweEFDSkhkcWxxVGlh?=
 =?utf-8?B?azdIbjhmQ295UW80UjJiNTRUTmdkbnROQlNBNFFTV3l6Ni9MMno0dm95Z0dT?=
 =?utf-8?B?Q3dlTHpXbE43eGNGRURXYnhGTk5qU2NUdVp1UjNjaHNFYldjME5SQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Cq8rU2rGh/6YrrbmtMLiEaYvVn+AKY84AhQc5CRes9FEL810jPTSFZBFz9Iq6Q2B8vY9LnEu4Uk1Qk8SujbfLqweGDC/WCiJYkBTo5Tzh+tYqdTWdkgbPYN3GCjmQCc7m6Ztq1jV6Mf99TwxNf66BbG7qCSXEpo5e7zJDG5kaHSXO0cyE6ttvosC93PwNJQPoET1jt4A5ha8XqSUy+aIG81A5Igd5T3349Pi4oR0HSUueZ0+pofQdVLMl8Zm2v2bqjd06hca3ImCaa25wcxcssBMSUawRE0xYhGuh8Spgt9guVTpDoiHqiuaJdk8Z1EJVynF9RKTYD0N/SqX++b8CQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84e6014-b6af-4846-7207-08df07285390
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 06:23:09.1436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTLTLnEGdRrtbHLbiaFuYePmM4noh18LASGwskF2Qh86spS22podECFZmZvUs1SWigxcFh7WSOqz85ba+VwuJALL77QtMZmmpUkuzkAN2r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6229
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvOV0gaHcvYXJtL2FzcGVl
ZF9hc3QxMHgwOiBSZW1vdmUgb2Jzb2xldGUNCj4gdW5pbXBsZW1lbnRlZCBTQkMgbWFwcGluZw0K
PiANCj4gT24gMzEvOC8yNiAwNzo1NywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+
ID4gT24gMzEvOC8yNiAwNTo0MSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+PiBUaGUgQVNUMTB4MCBT
b0Mgbm93IGltcGxlbWVudHMgdGhlIFNCQyBkZXZpY2UgbW9kZWwuIEhvd2V2ZXIsIHRoZSBvbGQN
Cj4gPj4gdW5pbXBsZW1lbnRlZCBTQkMgbWFwcGluZyB3YXMgbGVmdCBpbiBwbGFjZS4NCj4gPg0K
PiA+IFNpbmNlIHRoZSBpbnRyb2R1Y3Rpb24gaW4gY29tbWl0IDM1NmIyMzBlZDEzICgiYXNwZWVk
L3NvYyA6IEFkZA0KPiA+IEFTVDEwMzANCj4gPiBzdXBwb3J0IikgaW5kZWVkLg0KPiA+DQo+ID4+
DQo+ID4+IFJlbW92ZSB0aGUgb2Jzb2xldGUgbWFwcGluZyBub3cgdGhhdCB0aGUgU0JDIGRldmlj
ZSBpcyBpbXBsZW1lbnRlZC4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBody9hcm0vYXNwZWVk
X2FzdDEweDAuYyB8IDcgLS0tLS0tLQ0KPiA+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQG9zcy5xdWFsY29tbS5jb20+DQo+IA0KPiBQbGVhc2Ugc3F1YXNoOg0KPiANClRoYW5rcyBm
b3IgdGhlIHJldmlldyBhbmQgc3VnZ2VzdGlvbi4NCldpbGwgZG8uDQpKYW1pbg0KPiAtLSA+OCAt
LQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oIGIvaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX3NvYy5oDQo+IGluZGV4IGNkNjhjN2YxY2FhLi5lYjViOTI5MTk1MCAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9hcm0vYXNwZWVkX3NvYy5oDQo+ICsrKyBiL2luY2x1ZGUv
aHcvYXJtL2FzcGVlZF9zb2MuaA0KPiBAQCAtODksNyArODksNiBAQCBzdHJ1Y3QgQXNwZWVkU29D
U3RhdGUgew0KPiAgICAgICBBc3BlZWRTQkNTdGF0ZSBzYmM7DQo+ICAgICAgIEFzcGVlZFNMSVN0
YXRlIHNsaTsNCj4gICAgICAgQXNwZWVkU0xJU3RhdGUgc2xpaW87DQo+IC0gICAgVW5pbXBsZW1l
bnRlZERldmljZVN0YXRlIHNiY191bmltcGxlbWVudGVkOw0KPiAgICAgICBBc3BlZWRTRE1DU3Rh
dGUgc2RtYzsNCj4gICAgICAgQXNwZWVkUFdNU3RhdGUgcHdtOw0KPiAgICAgICBBc3BlZWRXRFRT
dGF0ZSB3ZHRbQVNQRUVEX1dEVFNfTlVNXTsNCj4gLS0tDQo=

