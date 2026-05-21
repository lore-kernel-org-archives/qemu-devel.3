Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C12CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPxBi-00024k-Iz; Thu, 21 May 2026 02:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxBg-00023b-3j; Thu, 21 May 2026 02:47:20 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wPxBd-0006fG-Hj; Thu, 21 May 2026 02:47:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6nI5M+cEgKbEJD4q3meALO4gfEKGCniHTQzYvG3qPzwZ0c6dszXaOrKzGXFpjV327E5+dbIHHk0rdzVLKCmf78378nQWvlDjhMdzszqjl+4HsiANk237GHqE9bOk9bpRukwmzOTGJWdDlzqvQdEmP59jJ6khvIzxOeePSDX735qclXkQvTzcWVAqtkK+iVIlVaXeOvGKH3S/C36nupmWlYludfRKiPUR3NcMcnEPGONu9DHBFN6atCwojJ6jMBij77Q4GvNT91Ehmy4H0YbkR75xCwwTXN0938QzcnQLJmLh4TR3jnKCXks4yDZotchWgzMiPRxw5XIjuuHIAX7EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPyRPV/QjfS9g0OqEOnB8AzwtCLBCPOZiU+Yci0vOjI=;
 b=gjCUkcn629HndhQr78p7/JBh7oyRJCuCgSVV9c4tX5D7RkZi5tIUXw9wTkwQAK7WMdLh0BtxBxUCEKuKtuGBEfB6KkZ9I8lWB4RF9+3CAJz5TBBanRimGx5dmRRApjPTdzHTn4Eezt4wYbVOh6gbTqpKRucpNJJKOUEli+yW8Xv4FBtiSKxhtWmMVU2hTTZHhMCv78IH96ozeWIeFAxopoR/75lU6b3Vwo2cN+/bOSpcLn2zGRcKs6LBLOtllL0REnjI8GBFX2h8ekvDGxbmtkzrD0+PleyIcIlCwSpSXHbt/4H8p2HIdqX9aiQWhwYZh4Mk/5FMWXyNcaB6PCaZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPyRPV/QjfS9g0OqEOnB8AzwtCLBCPOZiU+Yci0vOjI=;
 b=k1G2BMu8FANY94zshRI9SKJXLdOznbEfEK9P2tNhn5xrrVaUt53pjIVqgImGv2Sv71qjoW0PF4LM+94O0PRiNWIZU7Y79kuXL8l2PyE/4mM6Cx8t3nrZp02av/d/X7nsjWIlfSiuZbePE5sazfpAjAGmJYoJ1WB0advLhpXs6TqtjACtMbbfj78IITkJUcyf4OoW2zIxjtQ3To0/POsGXYOb2lw6PO4iNnwUbLeJiLU1jAsDd9Mf7rJ6mXcytgPLUPva22tmCie6aMjA/phs14YqOm0dFFk6tn6yFdjKRLmYtUnzUzXTti0cy8rQXKyCWqhUACtME6PTSHko78th3A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUYPR06MB8820.apcprd06.prod.outlook.com (2603:1096:d10:99::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Thu, 21 May
 2026 06:47:06 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 06:47:06 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 00/21] Add SSP/TSP power control and DRAM remap support
 for AST2700
Thread-Topic: [PATCH v4 00/21] Add SSP/TSP power control and DRAM remap
 support for AST2700
Thread-Index: AQHczhpHdueeYCsr+0KxqBKmTjL7fLYYPc+AgAABDOA=
Date: Thu, 21 May 2026 06:47:06 +0000
Message-ID: <TYPPR06MB82066822249FCC099A910FDBFC0E2@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <2277d954-478f-472e-934c-01a837b0a392@kaod.org>
In-Reply-To: <2277d954-478f-472e-934c-01a837b0a392@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUYPR06MB8820:EE_
x-ms-office365-filtering-correlation-id: 39e92a6b-71c9-4691-1e11-08deb704c5f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|38070700021|921020|4143699003|18002099003|56012099003|6133799003;
x-microsoft-antispam-message-info: Cv3UD0QpMHxrGeJHjC0bSZYxHWx92YOKEWs/PHspTRkcfnRKCtzaIfPuMol4W29QR1LuoZkSKwGIQQPVb/Z7uT3nAkM5Jh/KW0juieGCsStH32BOC3XTFCGO6Es7IdFy8uWoe48VZ/IF0V1urt0Nhs+lupfhN/qZyTymkK1R4lom0twCXebHX8Qvf2GL2mQmwbyk48cDyPzaIWXazAC0cTjSlyLAu++lt9h9tHBHIzdDEkhUdO91n0SZJyO+VXpMf9cf/+DiBt0h1OX3KwA2TUkNWvw4sIRu23xJVeXJW9KRSnGFTVQ2yewSpNcay3y4gPm+n0Drvo9iBvtTpckBtmlzG+PX51g0AG2Ndr7m5bNrr4AG/ryeD8G+xuxrICpsTw/UP0ChiqkJQmxIG41cU914yHKsr3RpqcMSzdSj+gkLJeapacNFSDrzrYk6rYj1IfBwXnKZzMGpK1wU27wbGRz1eFe1OWd4CIewq0Y5o2KD6F0eCtRl+LFOtaEDaGWeDTZLA3lVVoP7eMzlsP5I1y1X5S9QUfmCX2n75dFxn1aH18VgRxWNWfiB/vI9wqxF2LbkTZPwU6nnsm2k9+8+3QhyZep++lCbv5stJziYTtvVUBTKs0HpBWA1set+OGdKHTMaE7mX1QzmeYSnNBaz8kNKARyfjxA16e+0hpjaXPVg8qnIhCX9g6PfSmhllDD2chD0FFoRej7IjXKrKDkWiih+fO77R23IvytV7vnU9iOl6ea2kGkcTyvnWwLyov6p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(38070700021)(921020)(4143699003)(18002099003)(56012099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVBoTTkxN0Y4b0IvQ2NUWjRGb0hCRjRDcHMwYWd1cktrMzNuWmw1S0pZeUQx?=
 =?utf-8?B?NjRORHNhOXA1NFhpY1FDQXIzS013NUthN2Fvc0FFRnB5bTR6SnpYS0ZUN3Rz?=
 =?utf-8?B?b1pJNlIyajdINitGeThiQlk5aXUwcTB6Q0tEL0N6djhnU2d1aVVQa2ZNa05U?=
 =?utf-8?B?OVhVeEJFcHF6VERmYysxRTdzbGNnREdBZkxDelFrSHcySVhia3Y4K0Q1ZUdG?=
 =?utf-8?B?elZWK2FuMHc0TVhHSEN4eHlpc3dqVGpZQ3E2TGlHUHRVZWdhT2xjbVJLa2xU?=
 =?utf-8?B?VksycDZNVVNNNVVzMWYyV0Z2L0huVEdZK2xvSFpWOGV6amF1Z1hzb291WlZU?=
 =?utf-8?B?d2V6YXcvMnA4QlVEY1FmejZZWk1ybVBSTkQwWEdFaUl1VDBBVXNZMlQ3L0Vv?=
 =?utf-8?B?NlU1dXdtUXRzdEhCdWNNaDQwRm1zcnZZZzM0UnpOVmVJMmpoZGxNRjFzSGR4?=
 =?utf-8?B?Y0F1aTM3aTVmSDZwWmoxOTFheGNUb2V0MUV4S0tRdGE2aXRKN0pTR1FTeFhm?=
 =?utf-8?B?M0ZkZlV3b0tNd05vZ2dTdXpWdjMvRUEyYkhMMTZXUTRycjlUL3NLWkxacnMv?=
 =?utf-8?B?VER1cXc3ZUxHQkdLbzRpM2ZzRGhDcFFwQmJxbTUzQjFDa3lBMzRBWXU4aUl2?=
 =?utf-8?B?TklxNE5BZWFwZmhMdnNqZVNLVXlZTGF0RDNnendTaHd0d3d5YzNUcUVZVzhq?=
 =?utf-8?B?WG5hWmFRMUp4V1B6RnExeCtwUnpJZ0hNaENhdTBMYlRLRU9tVzdjT0ppcEFl?=
 =?utf-8?B?ZVVpS1RlK1dtUzdYMlJ4VVRTY0Z4K09WUmlreC9TRUk5eTN2Uyt6L2gwempC?=
 =?utf-8?B?TjBBNEtQT1F2L285SHZxb21aL1VnUE8vd3VnR2Y0MHd4WFFNOTNZK1pGSEFF?=
 =?utf-8?B?YklWOXlQRVlBaVV0alpnMzZzZEdGQTVxWTRFUkl6MzMxbUZ5bDdXZUhsN3py?=
 =?utf-8?B?aERScU1JOEY0RTZVc1lmZFNqc1lkdHBVbGdSQTNkQzNQK1N4YlR3NHBJRnYy?=
 =?utf-8?B?cGtJdEp4OVlKdkp3MnNWaHkvWkxibEZQTmVpcFVnUG11N0Q0RUNsRmR2OWZp?=
 =?utf-8?B?OWFIZWt3anB5ekJraU5VWW5qMGo3Sm96M2pYelZkM3FZTHBvM1ZicWdJUnNC?=
 =?utf-8?B?eUdocmlNZ01ZWjdOQlBnQ0VBaVVCWFZOa3pUSU9yTjRiWkpLeHl3dFZteEFZ?=
 =?utf-8?B?RWZTY2lINitNaXpyMXlwV3VhSFBOZGhKTnhGV1hGSE5lQ0N1R05hSFRhajM3?=
 =?utf-8?B?UDhTSDBNTEZqVEFwT3dFdzU0TE9BcHQzZzhGWm9HckR2Wk5RTXVKTmRrcG9G?=
 =?utf-8?B?a28yWGZiNkEyWlhoeDhNSWVsWngvZ0liM0IyTVVDbHhIQlZpeFBYM1M1bU1N?=
 =?utf-8?B?Y0xvdlgybTZ2OFgzbWJiTFZnVEtoMnVxc3MxWTQxeis4clUzZnRIOVBRZU1H?=
 =?utf-8?B?TWxmOHVUS2ZxZ3JXVHRDTVVFWWNVYTZuRTZaWnRqZUZPUjVMc3h0NkFxQWd3?=
 =?utf-8?B?WWx2R3M3UVJ4d2FtYVZPZXhhNEMvNmFxc25Mbk9GNTh3SVN2amFMelRSdkJr?=
 =?utf-8?B?eC9SVi9XUVZURDh4MlBMZm50bzRkL3pXamtzVjJwSWxCWUkycERPS3d3blBX?=
 =?utf-8?B?ZjNMdThUMTNLeEZsb3o2bnE2RzUvd0Frc3UrYTBuc0l1U0h3aENVMjBtUEw2?=
 =?utf-8?B?QWxjMXJUT3RodjY3VGUrZWlhQWt2UTlOMzJzak9Bd3VCczVPeVRFMDJmd2xZ?=
 =?utf-8?B?Y291cGV0V3cxczFIeHdReW1lR3dRZ2tzZHNPczZDRm1kMnJTeW9ZNFUrd25V?=
 =?utf-8?B?K0dLRmJuZmZNbWZIRjVqai9pSDVlcm1tOVpjNld6THU5enE3bDZTY2ZxNk9R?=
 =?utf-8?B?NmZRZWc4NFBldWh6clE5bFFLengyOStxVmRJSzVEOTNXbGtWZGhmMVcyWnZl?=
 =?utf-8?B?WE5QMm5lc0FNQ1lLby9PZTJmelhSVjBjZlY4VWlYdWpUbUtNMXgyQTc5MVFl?=
 =?utf-8?B?eWxFb2RyM1JaQ1B4aU1vWVdzZFRQV3lWMnpTWEl0OHhLdi9IS1dCdTJBTUJz?=
 =?utf-8?B?SlhwZDlWR21teS9CMEJFQXVjRFo3QzFGMG1hd0lHOHRtbVlOd2FuM3ZCREhY?=
 =?utf-8?B?UGtFc0lyK0R0REgrSUl6bU1qMmNqZUVhQVdWZ1p0cWhIRzhBWGZhMVAvcVI3?=
 =?utf-8?B?QUNCY1BJbllZbEZpSkcxZVpseit2S1RGOHBVNnNvUkdZVVNKQUVBUUs5ZzBk?=
 =?utf-8?B?MU1IY01FZ1YyZ0FnNVBjODU5WTF5d0JCVkJJc0pVQzN2bnhpTlJnL09QbDhI?=
 =?utf-8?B?cWN4MTJkNnV0V09idFZnUUhJc3JyckxyTmpISnNBcHI3a3U0ZDFRUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XDrTerjMD5PZxan20KQiV4v2Tzj9SW0UGPx1+5R8pWbomDV5HDFbmy5PFg/znb8Fc0qOI/Qv5iUPWSCB+Egmtg1Y+yuOYbjBhFG7kTHqQ7KOb7bUM2znD0ZqqwjZ+Gtq5+Ed8CygiO1mfEmmwVhzQ5TrCgA0IONxz3YjsZAtaEcINp1+7/ILBtXPdGqcIpWpusdBH6MpbWHnWPUiTznDEcZXjJYa4tDsMWse4MDOZll1nLd3u5w2UO4RXUn9n3mq1ZSRzRoV6rPR1uIkhEX/1gFRuCukV1pbpXRKExIKUhx+R0fmZZjWgrOP0+3ltNoHco+Sa0AFDZ3R2uDU8Q6b/w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e92a6b-71c9-4691-1e11-08deb704c5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 06:47:06.1831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/bJY+xhI2N/cuNaUHXUbaheS29KrlDd3PDjIZX8GXrBEvJGA5ORo+S2XrDIdG142rY5uvrYFA7yhcMGRGacY3WNQfuyhl2dincFoWk7Io0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR06MB8820
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDAvMjFdIEFkZCBTU1AvVFNQ
IHBvd2VyIGNvbnRyb2wgYW5kIERSQU0gcmVtYXANCj4gc3VwcG9ydCBmb3IgQVNUMjcwMA0KPiAN
Cj4gSmFtaW4sDQo+IA0KPiBPbiA0LzE3LzI2IDA1OjI4LCBKYW1pbiBMaW4gd3JvdGU6DQo+ID4g
VGhpcyBzZXJpZXMgaW1wcm92ZXMgQVNUMjcwMCBwbGF0Zm9ybSBzdXBwb3J0IGJ5IGFsaWduaW5n
IFNTUC9UU1ANCj4gPiBwb3dlciBhbmQgcmVzZXQgYmVoYXZpb3Igd2l0aCBoYXJkd2FyZSwgYW5k
IGVuYWJsaW5nIERSQU0gcmVtYXBwaW5nDQo+ID4gcmVxdWlyZWQgZm9yIHByb3BlciBmaXJtd2Fy
ZSBib290IGZsb3cuDQo+ID4NCj4gPiB2MToNCj4gPiAgICAxLiBUaGUgY2hhbmdlcyBtb3ZlIERS
QU0vU0RNQyBpbml0aWFsaXphdGlvbiBlYXJsaWVyIHRvIHN1cHBvcnQNCj4gPiBtZW1vcnkgYWxp
YXNpbmcsIGFkZCBEUkFNIGFsaWFzZXMgZm9yIFNTUC9UU1AgU0RSQU0gcmVtYXAsIGFuZA0KPiA+
IGltcGxlbWVudCBTU1AvVFNQIHJlc2V0LCBwb3dlci1vbiwgYW5kIHJlbWFwIGNvbnRyb2xzIHZp
YSBTQ1UgcmVnaXN0ZXJzLg0KPiA+ICAgIDIuIFdpdGggdGhlc2UgdXBkYXRlcywgU1NQIGFuZCBU
U1AgY2FuIGJlIGJvb3RlZCB2aWEgUFNQIGFuZCBsb2FkDQo+ID4gdGhlaXIgYmluYXJpZXMgZnJv
bSBEUkFNLiBGdW5jdGlvbmFsIHRlc3RzIGFuZCBkb2N1bWVudGF0aW9uIGFyZQ0KPiA+IHVwZGF0
ZWQgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiB2MjoNCj4gPiAgICBGaXggIm1ha2UgY2hlY2siIGZh
aWx1cmUgY2F1c2VkIGJ5IGJvdGggQVNUMjcwMCBhbmQgQVNUMTcwMCByZWFsaXppbmcNCj4gdGhl
IHNhbWUNCj4gPiAgICBUWVBFX0FTVDI3MDBfU0NVIG1vZGVsLg0KPiA+DQo+ID4gdjM6DQo+ID4g
ICAxLiBEcm9wICJNb3ZlIERSQU0gYW5kIFNETUMgaW5pdGlhbGl6YXRpb24gZWFybGllciB0byBz
dXBwb3J0IG1lbW9yeQ0KPiBhbGlhc2luZyINCj4gPiAgIDIuIFN1cHBvcnQgU1BJL0ZNQyBGSUZP
IE1vZGUNCj4gPiAgIDMuIEFkZCB1bmltcGxlbWVudGVkIGRldmljZXMNCj4gPg0KPiA+IHY0Og0K
PiA+ICAgMS4gSW50cm9kdWNlIEFzcGVlZDI3MDBTQ1Ugc3ViY2xhc3MgYW5kIHNlcGFyYXRlIGZy
b20gZ2VuZXJpYyBTQ1UuDQo+ID4gICAyLiBBZGQgc2VwYXJhdGUgcmVzZXQgaGFuZGxlciBmb3Ig
QVNUMjcwMCBTQ1VJTw0KPiA+ICAgMy4gQWRkIEFTVDI3MDAgU0NVSU8gUk5HIGNvbnRyb2wgYW5k
IGRhdGEgcmVnaXN0ZXJzDQo+ID4gICA0LiBTaGFyZSBzaW5nbGUgU0NVSU8gaW5zdGFuY2UgYWNy
b3NzIFBTUCwgU1NQLCBhbmQgVFNQDQo+ID4gICA1LiBGaXggQVNUMjcwMCBGQyBoYXJkd2FyZSBz
dHJhcCBzZXR0aW5ncw0KPiANCj4gDQo+IEp1c3QgYSBxdWljayBub3RlIHRvIHRlbGwgeW91IHRo
YXQgSSBkaWRuJ3QgZm9yZ2V0IHRoaXMgc2VyaWVzLg0KPiBUaGlzIGlzIG9uIG15IFRPRE8gbGlz
dCBmb3IgUUVNVSAxMS4xLiBJdCdzIHNwcmluZyB0aW1lIGFuZCBjaGFuZ2VzIGFyZQ0KPiBibG9v
bWluZyBhbGwgYXJvdW5kLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gQy4NCj4gDQoNCk5vIHByb2Js
ZW0gLSB3aGVuZXZlciB5b3UgaGF2ZSB0aW1lIHRvIHJldmlldyBpdCBpcyB0b3RhbGx5IGZpbmUu
DQpUaGlzIHNlcmllcyBpcyBub3QgdmVyeSB1cmdlbnQuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBz
dXBwb3J0IGFuZCBhbGwgdGhlIGhlbHAgYXMgYWx3YXlzIQ0KDQpCZXN0IHJlZ2FyZHMsDQpKYW1p
bg0KDQo+IA0KPiA+IEphbWluIExpbiAoMjEpOg0KPiA+ICAgIGh3L21pc2MvYXNwZWVkX3NjdTog
SW50cm9kdWNlIEFzcGVlZDI3MDBTQ1Ugc3ViY2xhc3MgYW5kIHNlcGFyYXRlDQo+IGZyb20NCj4g
PiAgICAgIGdlbmVyaWMgU0NVDQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBBZGQgc2VwYXJh
dGUgcmVzZXQgaGFuZGxlciBmb3IgQVNUMjcwMCBTQ1VJTw0KPiA+ICAgIGh3L2FybS9hc3QyN3gw
OiBTdGFydCBTU1AgaW4gcG93ZXJlZC1vZmYgc3RhdGUgdG8gbWF0Y2ggaGFyZHdhcmUNCj4gPiAg
ICAgIGJlaGF2aW9yDQo+ID4gICAgaHcvYXJtL2FzdDI3eDA6IFN0YXJ0IFRTUCBpbiBwb3dlcmVk
LW9mZiBzdGF0ZSB0byBtYXRjaCBoYXJkd2FyZQ0KPiA+ICAgICAgYmVoYXZpb3INCj4gPiAgICBo
dy9hcm0vYXN0Mjd4MDogQWRkIERSQU0gYWxpYXMgZm9yIFNTUCBTRFJBTSByZW1hcA0KPiA+ICAg
IGh3L2FybS9hc3QyN3gwOiBBZGQgRFJBTSBhbGlhcyBmb3IgVFNQIFNEUkFNIHJlbWFwDQo+ID4g
ICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBJbXBsZW1lbnQgU1NQIHJlc2V0IGFuZCBwb3dlci1vbiBj
b250cm9sIHZpYSBTQ1UNCj4gPiAgICAgIHJlZ2lzdGVycw0KPiA+ICAgIGh3L21pc2MvYXNwZWVk
X3NjdTogSW1wbGVtZW50IFRTUCByZXNldCBhbmQgcG93ZXItb24gY29udHJvbCB2aWENCj4gU0NV
DQo+ID4gICAgICByZWdpc3RlcnMNCj4gPiAgICBody9taXNjL2FzcGVlZF9zY3U6IEFkZCBTQ1Ug
c3VwcG9ydCBmb3IgU1NQIFNEUkFNIHJlbWFwDQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBB
ZGQgU0NVIHN1cHBvcnQgZm9yIFRTUCBTRFJBTSByZW1hcA0KPiA+ICAgIGh3L2FybS9hc3QyN3gw
OiBTaGFyZSBGTUMgY29udHJvbGxlciB3aXRoIFNTUCBhbmQgVFNQDQo+ID4gICAgaHcvYXJtL2Fz
cGVlZF9hc3QyN3gwOiBBZGQgdW5pbXBsZW1lbnRlZCBQcml2aWxlZ2UgQ29udHJvbGxlcg0KPiBN
TUlPDQo+ID4gICAgICByZWdpb25zIGZvciBTU1AvVFNQDQo+ID4gICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwOiBBZGQgdW5pbXBsZW1lbnRlZCBPVFAgY29udHJvbGxlciBNTUlPDQo+IHJlZ2lvbnMN
Cj4gPiAgICAgIGZvciBTU1AvVFNQDQo+ID4gICAgaHcvYmxvY2svbTI1cDgwOiBJbXBsZW1lbnQg
dm9sYXRpbGUgc3RhdHVzIHJlZ2lzdGVyIHdyaXRlIGVuYWJsZSBmb3INCj4gPiAgICAgIFdpbmJv
bmQNCj4gPiAgICBody9zc2kvYXNwZWVkX3NtYzogQWRkIERhdGEgRklGTy1iYXNlZCBmbGFzaCBh
Y2Nlc3Mgc3VwcG9ydCBmb3INCj4gPiAgICAgIEFTVDI3MDANCj4gPiAgICBody9taXNjL2FzcGVl
ZF9zY3U6IERyb3Agbm9pc3kgdW5oYW5kbGVkIHJlYWQgbG9ncyBmb3IgQVNUMjcwMA0KPiA+ICAg
ICAgU0NVL1NDVUlPDQo+ID4gICAgaHcvbWlzYy9hc3BlZWRfc2N1OiBBZGQgQVNUMjcwMCBTQ1VJ
TyBSTkcgY29udHJvbCBhbmQgZGF0YQ0KPiByZWdpc3RlcnMNCj4gPiAgICBody9hcm0vYXN0Mjd4
MDogU2hhcmUgc2luZ2xlIFNDVUlPIGluc3RhbmNlIGFjcm9zcyBQU1AsIFNTUCwgYW5kIFRTUA0K
PiA+ICAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYzogRml4IGhhcmR3YXJlIHN0cmFwIHNldHRp
bmdzDQo+ID4gICAgdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDBm
YzogQm9vdCBTU1AvVFNQIHZpYSBQU1ANCj4gPiAgICAgIGFuZCBsb2FkIGJpbmFyaWVzIGZyb20g
RFJBTQ0KPiA+ICAgIGRvY3M6IEFkZCBzdXBwb3J0IHZib290cm9tIGFuZCB1cGRhdGUgTWFudWFs
IGJvb3QgZm9yIGFzdDI3MDBmYw0KPiA+DQo+ID4gICBkb2NzL3N5c3RlbS9hcm0vYXNwZWVkLnJz
dCAgICAgICAgICAgICAgICAgICAgfCAgNDIgKystDQo+ID4gICBpbmNsdWRlL2h3L2FybS9hc3Bl
ZWRfYXN0MTcwMC5oICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgIGluY2x1ZGUvaHcvYXJt
L2FzcGVlZF9jb3Byb2Nlc3Nvci5oICAgICAgICAgICB8ICAxMyArLQ0KPiA+ICAgaW5jbHVkZS9o
dy9hcm0vYXNwZWVkX3NvYy5oICAgICAgICAgICAgICAgICAgIHwgICA0ICsNCj4gPiAgIGluY2x1
ZGUvaHcvbWlzYy9hc3BlZWRfc2N1LmggICAgICAgICAgICAgICAgICB8ICAxMCArDQo+ID4gICBp
bmNsdWRlL2h3L3NzaS9hc3BlZWRfc21jLmggICAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCj4g
PiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1mYy5jICAgICAgICAgICAgICAgICAgICB8ICAyMiAr
LQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXNzcC5jICAgICAgICAgICAgICAgICAgIHwg
IDY3ICsrKy0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC10c3AuYyAgICAgICAgICAgICAg
ICAgICB8ICA2NCArKystDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMjIgKy0NCj4gPiAgIGh3L2FybS9hc3BlZWRfY29wcm9jZXNzb3JfY29t
bW9uLmMgICAgICAgICAgICB8ICAgMiAtDQo+ID4gICBody9ibG9jay9tMjVwODAuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMzYgKy0NCj4gPiAgIGh3L21pc2MvYXNwZWVkX3NjdS5j
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDMyNA0KPiArKysrKysrKysrKysrKysrKy0NCj4g
PiAgIGh3L3NzaS9hc3BlZWRfc21jLmMgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExMyAr
KysrKy0NCj4gPiAgIC4uLi9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDBmYy5weSAgICAgICAg
ICB8ICAyOSArLQ0KPiA+ICAgMTUgZmlsZXMgY2hhbmdlZCwgNjcyIGluc2VydGlvbnMoKyksIDgx
IGRlbGV0aW9ucygtKQ0KPiA+DQoNCg==

