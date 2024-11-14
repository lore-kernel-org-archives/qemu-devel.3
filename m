Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6C1D637D0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 05:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBSRq-0006j8-4U; Thu, 14 Nov 2024 00:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBSRn-0006ho-Cq; Thu, 14 Nov 2024 00:31:15 -0500
Received: from mail-tyzapc01on2072f.outbound.protection.outlook.com
 ([2a01:111:f403:2011::72f]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tBSRl-0004t9-5p; Thu, 14 Nov 2024 00:31:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPMeOZttNwV3zYAx6n0aurrnhDDlRXfySlglqlk97lvDaafcvBl2wPv8mwJ4LT9+1cmO/qWd7ehsyKziRUEZgw3KFRSziMO+hkjcQTSK04QAdi+8kwun6oU1FnBNIFV7vC7xtXopktFrp0p8xKH5dAS5BDC2JK8LLslI0E5Gd17aowqsF8m5uzuOgaV9bEPu72Fe9LMgMbDZEzTxBpxDoGqR3hbUWO1lM4ZALUzH7TcLtTqAgOwx3k1mdo76hnEN+TqjY+L54VQwwh7mKj0Z34hNS0eu0Q29zC/OML2zrDLQTRS6VcO5OLGVPBh96gdllNjAvnokcBaxau5minOezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev6sVc39PNY6dzvFLR/aBCcMI9UTDvb/wJ5MNtiSzS8=;
 b=WIMBpErG/J28FL2fpEjmeOwmP6h8LpxjoYwkX4/PokmWIkBTjvsHgn/teGeT/IG3tIU6KJP+nWK6V+2Kj7uQhNVHWKWVRE6uoYC27ZiTrQ+t11lfhiNOUP0vpTnpXHF5FMp32qT8kD17meFPTTRQAj+vU+at9X5VTRhI+wR2tK33NGQwKGa99FbBCX2ILRLM/l8NZ7/NhMLbmSkNESCE8OqqQEHM3f6GZR8/KivLCeEhIxIl1qRED+3p8FvIZl4pQ3bISyobSZqPbH2XmMvsRS7zGas02aCoFosaMhRHE3Cev7LhNbqt5hEuDrDSH9ElrdsEa4i44HjJksM/BFHXjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev6sVc39PNY6dzvFLR/aBCcMI9UTDvb/wJ5MNtiSzS8=;
 b=MEzVQoT5i4Bsa5SHxVqUD6+p5ft3h3wmTwxwMc/Uvds+24dCanpHqvEr1ehkqLOXGJnIBqREheOaDPYFnock4b1rIUV8fFm6RjyMCJS0kzvFiba+nRyv1AlX9M48+SYKxULTkKtx5FQHK7ksIqzFoepPMvAqq6plwXVNk2FVjbGb6kgxsnFQNVNQhqZvgRWBVzN0M/Yq32vM3dpPkgDTvkfEUTVRM/0aRQtyuvVGtxpcnKShMAB8d1ONLo4ow+99zIOZlZs3iOhp0OUGdMBGkLeEhCzARIjS0MqdxtMC9CvXUev376IqRUazBUywW2pkSXJ8p6XBfY8EEf5R2ww7Mg==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6578.apcprd06.prod.outlook.com (2603:1096:820:fa::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.16; Thu, 14 Nov 2024 05:30:57 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 05:30:57 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v2 00/18] Fix write incorrect data into flash in user mode
Thread-Topic: [PATCH v2 00/18] Fix write incorrect data into flash in user mode
Thread-Index: AQHbJGaQVsUKUjWOB0e3PeDsyHwdArKVbkWAgAAArRCAIPRlMA==
Date: Thu, 14 Nov 2024 05:30:57 +0000
Message-ID: <SI2PR06MB50413F4922CA4FD3F61E12CBFC5B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
 <9fe3e1cd-6aed-473f-9193-8541a202b7a0@kaod.org>
 <SI2PR06MB50419A139B7233B352CD1E31FC4E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB50419A139B7233B352CD1E31FC4E2@SI2PR06MB5041.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6578:EE_
x-ms-office365-filtering-correlation-id: cee05f80-0fc5-4a7a-a4f7-08dd046d841c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VGpYTVNzMXZseStJc3NvTHhLalh4QlNmVmttTDMxRzQwZmE1M2RRcU1UOHdk?=
 =?utf-8?B?R2xKN1NiVHRic1FhMk5NczNBVGt0dUV2aFE2cG5mQWlDU0M4R0hyNlZNWG1O?=
 =?utf-8?B?bS9xb3FUbmlGM2tYYlltK2ZiMDdkN0hrRWYvdUxuekxoVTc5U0lIWnJTOHlC?=
 =?utf-8?B?cnJSbXc3NmdtaytNcHJ4akhIdmNBenRNcWZaQnA0RFFET2cxcVlRakV2M0ta?=
 =?utf-8?B?WHhPaXphYjhLNHQyYWdpMU1iY0RZSlM1U2xGMGZZTVZ6dHhNaWcxdnFjcmpm?=
 =?utf-8?B?VHV4VEd5Z3VoZ2RONFBEWlVrazRFQTQxR1oxd0NRZ3drWWxVMG0vazhTb1Zz?=
 =?utf-8?B?YkJUNkVIS1BTSlFJcU1kWHpoR1Q4dHRUTCtDc3hnRG1yOFpCanlDeVdkWFVx?=
 =?utf-8?B?aVMySk42bllCS3lZZGw3WXNmZXdaQlhxZkdnTzZBZCtnSklRdEpTRUhlNitu?=
 =?utf-8?B?dmp0b20vcWdDaVBzSjk0ZnV6ZVAvRFVTbitwQVhueUlQMUt2dXdKcmI2Rmdo?=
 =?utf-8?B?aHhtWXJrYU1PTlQrUmpuWVVWY0d6Vk1FU3V4UVdVc0VSczFrbFhwSC9sTEQ2?=
 =?utf-8?B?TVFHc0ltWmJlS1dXREVla3NReUZIYTMwT2I1T3M4YXZlWWFBTDhQenR5bVVa?=
 =?utf-8?B?UXdSeEs1bnlQdWdXQTBpdEhsTHZJd08wczR5WDY0OWk2Wk5CRG1vWEVmMFND?=
 =?utf-8?B?SEdPV3RCZFRwNk1wR3A1TFNwUHZ2UkgvdVQzcFFkOTdzWEhnNjVKUWx2b3JZ?=
 =?utf-8?B?RHUyOXo4OS92bGFUNk1vaG01SXJhOU4vWUU3SmFSc2EvNE1zVUhxOWhTRHZM?=
 =?utf-8?B?MGgybmx3NGFkakZQSlMzU09FdHU3VUVDZTczWTdOWm41OUF1MnpYQlJoVDV4?=
 =?utf-8?B?L05lMnhPdkdOdktya1V4c285RVlicXhJRy9oWmhSUk1Mak9walZvVVdBWmR2?=
 =?utf-8?B?RlZjMVNQLzkvQldRN0RiMjZVaWVCeDQ1YUFPeWdHN0l5Zy9CZHF1SS85aVBa?=
 =?utf-8?B?TnB1dytYd0VSejB0Wk5XM3lzeGZ3V1FOZ2Z4M3Z0cGJOZEJiMXJqa0krUmJq?=
 =?utf-8?B?TnFERVlySkY3aUp4RTFCWDdSN3U3WVR5ZDNKcEY1VDZrb0l2eUFUREJrYTJJ?=
 =?utf-8?B?Z3BmN0VFVncxeEx3NS8xa2R2L1JFWlVLYWl0bDNvRE91WDROZ0pYYlg1K08z?=
 =?utf-8?B?TDZjL1l1M2VxMGp1Z2dFT3c2OXVZa1BOeGp0aGRqN2wwczY3bTZvV25LY3Bu?=
 =?utf-8?B?MVpRcXNDSGphV3ZNZHltRmhqcnpMR0hTb29rY2F4WGVqUzQ5dkFLV015Nmdy?=
 =?utf-8?B?NUt0YTZ5M2V0ckdkMVk0bWJvUEp1TlBlU3FIN3cvWkhqVjZ6aEtKdjI5OUFK?=
 =?utf-8?B?N1BtZFM4aFREUzFvL2lEZ3BRcXZzU01vdi9nSmoxUjA0V0d4ZXk1UFo0TXhH?=
 =?utf-8?B?ZHF1ZzBVeGUyWkQ0UjhiNmFEaWdGVlhYNVhpTWJlb3RObEI1K0lVN050QmEx?=
 =?utf-8?B?alpPVDBMMUFWZ29jc1JoSW5NRnFDOFg3KzhCbURmcDBqdTZoMFQ5ODZuUGR1?=
 =?utf-8?B?OFJBWWtCUURMWTR5NzIzbHY0Y0pVbER1TFNFYm9tWjdMT1oydldycUtQNEtG?=
 =?utf-8?B?Tncvd25DVE5pQmhBVW5WSnppNWdBOXJCdVB5Z2w1V0NpVElsRUxQanJibDRD?=
 =?utf-8?B?TTZBdlQxaG51UmxWUVdIMTFmczZrdXVxbDZPbHc1Y1VPamVxQXFlY0VBT2sz?=
 =?utf-8?B?SjczRS9LYlRtSVBSMXpUejdQdkVQSHJSMGpyTEpYRkFaVHllVVhySGozbU5U?=
 =?utf-8?B?c2IwOWtIWjNHYjFoRkdpM2FkVDdBY3luVXMzdTJrM1pEKytIcDQ4M1dlaHFC?=
 =?utf-8?Q?EdHei0UKKIkoA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1BoRjNFTHlNMDVsa0dNUVhUZTV1TFFHWFoyNG9la05lSGtxNnR3YXF0RlRB?=
 =?utf-8?B?M2xkWEZ3WW1Bd0xueWQ5d2FQTG5WSzRNc2laWmxjcmxHRU1pRzRsVkpJRzhJ?=
 =?utf-8?B?ZFJtWEEwcnVjOGF0akprNzRMRkhudHFIdUpuK2JHR2NOVmNFV2tONWpqc0ND?=
 =?utf-8?B?QjJ3UklNeWUvUUoxeDFOLy9sQVpBSDJaTjArd2Q5WnRRWVljaTQwazBnME4y?=
 =?utf-8?B?TVRYRmoyUFBmbUpqL2ZWaExGaUN5ekRaN0N0RmtXRzhWN28yMHUrVndGS2p6?=
 =?utf-8?B?VW5QU1FJWVgwb3JodFBrallUckw1MjJSSHNrRUJ5QzdiV09LZzlEZjJiZGdX?=
 =?utf-8?B?bHIwdWpVT1B6U25IeDM1dUFnazRUNHZNVmVWQzhxcjV4amh2UDlHWkh4SjZj?=
 =?utf-8?B?MkY2cEc4b3A4MzFmRGcwQXMxNWZwRUIxQ0o1ZTkyaUk3eGdJUStNakNYdVhI?=
 =?utf-8?B?UlE1MFp3YXhYOE5Hcis3UjkxbzlHaHpJdVVuS3d4TFVZeU0yc0FNdmRQY3ds?=
 =?utf-8?B?MFJaSG00cFRmT3RaUXFVOEZwcDBSNGs2bEpJZisyZWdkUHE4anB3SEFvSUZZ?=
 =?utf-8?B?cVlmbWx6ZGFrcXZHNS9rbk1RZkJ3dXplaUg1WER6cTB0aXcwZTlGQVJzZlJr?=
 =?utf-8?B?WFU5bWF0dlByZVpkWnAzWTRPaGlZYlRzRkN3Y2xZL3ppc3VScWZpUkRjMHMr?=
 =?utf-8?B?MHpyaHhsNmN6TTNmMmZDbzBQb2hzbWxNMkxkY0d2aEJtOTJBd2NnMzR5NTc5?=
 =?utf-8?B?cGRnNHowL3JoRFhsbzJEOXk2c0hvQmVrbkF0TGJDcmQwcEYxMmdZRGxwRllu?=
 =?utf-8?B?RlNsSXhuSVJIc01OaUtjYVp3Ui9Bc1Vlem9kRHZMUzVJdEdDd2NXNTVYQ1RS?=
 =?utf-8?B?VkNsazVrTVdsK3VReDduR3ZHQXNxOVZoRjROdXlFbHdxNXM5U2l3c3VIRi9N?=
 =?utf-8?B?L2VaSExKbXVLOGo0T3VoOTE1OXVyakNMZG5BZTl3M1I2Y1dqY2F1aEUyU3dh?=
 =?utf-8?B?WUFrVTJjekk3Q0hGYzB3VmVxUmh4WmlqM1JHZVRrVFZhdHRTYUJQb2lpRFNW?=
 =?utf-8?B?b0xVUXdManp3c1B1L25SY1Noc3hLQnVUeTBad0F0MTBVWk01TFpzVU9ndUtj?=
 =?utf-8?B?T0F2NmRybzRDQU43V0NkekV1OTMxSjU5d3ZjNG0wQzFSb0ZuWmlJZ2Y2M09J?=
 =?utf-8?B?blNEc0lvRndXa05PL3FlcWNuZzJpWmltQytzaVVpd0ZjUlZuOXQ3RlFWTG85?=
 =?utf-8?B?OTFKQW1WNTA0RHVrMzBWWjFQTSs2K1J6QlZsZ0ovbGVCU0ZCeTlCdytjbGtO?=
 =?utf-8?B?OVFkMEx5MC9SRVFjMmxVT3B4ckVrQzdSWFpQWnVacnc2bmg1aVNuWGdGaDFt?=
 =?utf-8?B?RnpXQkRYWTN3N3lVYjZWRHZVcG1LaFhRdkNRM1VCQ0tVUHdscnJZeW1NTzVX?=
 =?utf-8?B?RzYzN093T2VlSVBsZTQ1Q0tyRVZnNUFCQld0bFAxaExvN09VNW9WdHNTTVhM?=
 =?utf-8?B?WXp0akZ2VEM1WUQrOXBUT3VhMXNlWUpEa1JvWUFvYVNOd3ZLTmczQ3ZQY29S?=
 =?utf-8?B?R3doYmh3RXJzV2tqK2Y2MytJenUwM1dYSlJtSUhEQU0xVVkzNzBRWXg1aGdC?=
 =?utf-8?B?WnBsaTZma0pXZ0FsTEtXUWhWNTcwN3FRK2hCQm5IZHR0SU1tNXg0VVdQdkZ4?=
 =?utf-8?B?RUdjemI3cjd3Y3lXdmk2L0FYdS9rQW0zUnh2OERINyt2dVB1S25yRm5IQTAv?=
 =?utf-8?B?RFBEb0xTdnUvVDk4M2RNYVo4Q3FHSHRudUVWS1AvL2Z3QjNlZHpwL3MvSTFz?=
 =?utf-8?B?TWZQWHFaMi9xb25kM2JKdks3OGpZcTFqVUN4UGVNY2lpSzBCajNOWmVpLzBl?=
 =?utf-8?B?Tld1R2duNThJOGNuNVZmNkcvcmRRaThWTnVFaWlGOVBBSlY5dWw2SHZFcEVY?=
 =?utf-8?B?eW1rSnNONjVJVW05TGFmcHlFZXB4QWIwWXJKaEw5VHBnUm5KbDVWL1czR3Uv?=
 =?utf-8?B?MjhzZ1MwazM1UmFVRVkzaUtsbUZaZ3R6T2xDODhiaUxSbmE4VlNFTWRqUHVi?=
 =?utf-8?B?UUp3TllXZHJVTWorekRROVIvem9kc1pPOFVRV3lsN0VoQ2tVc2ZSNGRER04x?=
 =?utf-8?Q?HyGOk3pHsklm3BjrIfmQWapeZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee05f80-0fc5-4a7a-a4f7-08dd046d841c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 05:30:57.0712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19yuzNAfEZSp0mIzDp0D0xLfkTaqH+9a35nLpDtSZGROOF6sq8HaPpyhfswejdJ5lZ1GIp5PsitIlBbcCrVWtIbLDv3M1zAkd4FKdNqW+eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6578
Received-SPF: pass client-ip=2a01:111:f403:2011::72f;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
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

SGkgQ2VkcmljLA0KDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjIgMDAvMThdIEZpeCB3cml0ZSBp
bmNvcnJlY3QgZGF0YSBpbnRvIGZsYXNoIGluIHVzZXIgbW9kZQ0KPiANCj4gSGkgQ2VkcmljLA0K
PiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAwLzE4XSBGaXggd3JpdGUgaW5jb3JyZWN0
IGRhdGEgaW50byBmbGFzaCBpbg0KPiA+IHVzZXIgbW9kZQ0KPiA+DQo+ID4gSGVsbG8gSmFtaW4s
DQo+ID4NCj4gPiBPbiAxMC8yMi8yNCAxMTo0MCwgSmFtaW4gTGluIHdyb3RlOg0KPiA+ID4gY2hh
bmdlIGZyb20gdjE6DQo+ID4gPiAgIDEuIEZpeCB3cml0ZSBpbmNvcnJlY3QgZGF0YSBpbnRvIGZs
YXNoIGluIHVzZXIgbW9kZS4NCj4gPiA+ICAgMi4gUmVmYWN0b3IgYXNwZWVkIHNtYyBxdGVzdCB0
ZXN0Y2FzZXMgdG8gc3VwcG9ydCBBU1QyNjAwLCBBU1QyNTAwDQo+ID4gPiBhbmQgQVNUMTAzMC4N
Cj4gPiA+ICAgMy4gQWRkIGFzdDI3MDAgc21jIHF0ZXN0IHRlc3RjYXNlIHRvIHN1cHBvcnQgQVNU
MjcwMC4NCj4gPiA+DQo+ID4gPiBjaGFuZ2UgZnJvbSB2MjoNCj4gPiA+IDEuIEludHJvZHVjZSBh
IG5ldyBhc3BlZWQtc21jLXV0aWxzLmMgdG8gcGxhY2UgY29tbW9uIHRlc3RjYXNlcy4NCj4gPiA+
IDIuIEZpeCBoYXJkY29kZSBhdHRhY2ggZmxhc2ggbW9kZWwgb2Ygc3BpIGNvbnRyb2xsZXJzIDMu
IEFkZA0KPiA+ID4gcmV2aWV3ZXJzIHN1Z2dlc3Rpb24gYW5kIGZpeCByZXZpZXcgaXNzdWUuDQo+
ID4gSSBoYXZlIGFwcGxpZWQgMS02LDggdG8gYXNwZWVkLW5leHQgYW5kIHNob3VsZCBzZW5kIGEg
UFIgd2l0aCB0aGVtLiBJDQo+ID4ga2VwdCB0aGUgdGVzdCBleHRlbnNpb25zIGZvciBsYXRlciwg
dG8gdGFrZSBhIGNsb3NlciBhIGxvb2sgYW5kIGFsc28NCj4gPiBiZWNhdXNlIEkgd2lsbCBiZSBv
biBQVE8gbmV4dCB3ZWVrLiBUZXN0cyBjYW4gYmUgbWVyZ2VkIGluIHRoZSBuZXh0IFBSDQo+ID4g
aWYgd2UgaGF2ZSB0aW1lIGluIHRoaXMgY3ljbGUgb3IgaW4gUUVNVSAxMC4wLg0KPiA+DQo+IEdv
dCBpdCBhbmQgdGhhbmtzIGZvciBoZWxwLg0KPiBKYW1pbg0KPiA+IFRoYW5rcywNCg0KQ291bGQg
eW91IHBsZWFzZSBoZWxwIHRvIHJldmlldyBwYXRjaCAxNyBhbmQgMTggPw0KRG8gSSBuZWVkIHRv
IHJlLXNlbmQgcGF0Y2ggZnJvbSA5IHRvIDE4IG9mIHRoaXMgcGF0Y2ggc2VyaWVzPyANClRoYW5r
cy1KYW1pbg0KDQo+ID4NCj4gPiBDLg0KPiA+DQoNCg==

