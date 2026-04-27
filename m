Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E09FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIR8-00072T-WC; Mon, 27 Apr 2026 05:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wHIQv-00071D-VO
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:39:20 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wHIQu-00027Q-2h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:39:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHhadP36l2+KzoDz19Ez/D3RBi/0oH70Yh4T6jC7qzFYzg7LRVZVVDmd8PP/xr5vtaVdMQ4y2DxjQ9WQhaGwya0NCbKei0JcPE4CfJjZyoz+/exmkTWpQHo87EzZuNvXUKbxcYyxia2W7G0mpocoNG56MABTJf0oLuz95zunTAw6eIB1S2Yj9RaYtiPoKP6HI9abwUYVqUv8AEWwNUy6XjyuTLbhKrDlJIyzgWssr7NSTYi0lUlRiRZy93PjH1MdodyZWIgIcQ8alcXz/74mDYQQnC7z7otzyZKeRMIaEPnUn4AEAjYD1+AyvJNChuzj6tLhavMl1Kq8SuhaFmFwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKyKGnvqfRoJsp7I+PaDvut64McvwTmbvCD1wjEYLnQ=;
 b=tjUEZg+ACWcIeZSJ+TXMis8xd1R953+4o6Zh50laj8N8iaNnS7EnQ3xyhafvKiwzN42GXhY2JfiNKMRYpk4vtyvbqPKGyHlNxWoAAg56HPnHLmzEGl3NgLrgyykFBh4BpGRJRLUUvAoZeKcrCd8ZWzQGU1yjbBEIequyG0kWuvwBe2+KovIwKzWZ5kxKcSwKTeOgJX18OgMrX45aNkISmZJXLV05va/SpQx2NgNjcFRmT8g21ulnQuxtPXEN9n8ME3yivMeNeCdjtSezZMEDEslOrkKB63b9QOA8AuxlA6hk0K2A7iELlktdcx7ZxGmXXaHgLke617qXxds8DC50tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKyKGnvqfRoJsp7I+PaDvut64McvwTmbvCD1wjEYLnQ=;
 b=V/b1ABJ6GdzBe2LYKs249k1LrFXInAhPQW5kmzTeviEbRonhXcm2x1+P2HdoMwV2jGUrY/oGA6wF8yX5QebwNgagRpp0Zi89djK1a9suWYEVc5/QRvpcUFglRqW5i3HpovlBSC4yaYiV0gZT5LK8MptkM7EwobtkFLLfRdSLFIEdHdJkBOpRK3i/80egQXyO/+PgkuFbAQZ7kQlgAJbFLRffq5YGnX/j5xhqa81JIDCD0jNwbFWZndBxUzWgrNCJ5ZRD0YtU97FzeIbj8pE02CIajScrdyXd/fcOEBXB9V3qkrHwkK1pScBk8JwULnK1heuGcqEIxDgzbfFjHv3pfQ==
Received: from VI1PR04MB4383.eurprd04.prod.outlook.com (2603:10a6:803:6b::24)
 by AS8PR04MB8072.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:39:11 +0000
Received: from VI1PR04MB4383.eurprd04.prod.outlook.com
 ([fe80::b0f9:1ea6:972c:7c58]) by VI1PR04MB4383.eurprd04.prod.outlook.com
 ([fe80::b0f9:1ea6:972c:7c58%2]) with mapi id 15.20.9818.039; Mon, 27 Apr 2026
 09:39:11 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: RE: [EXT] Re: [PATCHv7 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv7 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHc0VtupKxiji9OA0+gLy63hk7YgLXynsmAgAARO1A=
Date: Mon, 27 Apr 2026 09:39:10 +0000
Message-ID: <VI1PR04MB4383AC3D44459E57DA0CF28E87362@VI1PR04MB4383.eurprd04.prod.outlook.com>
References: <20260421065226.3907745-1-gaurav.sharma_7@nxp.com>
 <CAFEAcA84EkMEUj2fL5q3_eSNnce_voLbqyA3NU_avEsKHzqOWw@mail.gmail.com>
In-Reply-To: <CAFEAcA84EkMEUj2fL5q3_eSNnce_voLbqyA3NU_avEsKHzqOWw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB4383:EE_|AS8PR04MB8072:EE_
x-ms-office365-filtering-correlation-id: d86a3f28-83a2-4a16-461d-08dea440d624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ZQ4H+d4DQ7uSoDC5iQrx3E9b6z+FZz37h9Slea6/P88PMuNA2Q71GEbVs9l+5DjuJst/1pxewqsqKMJWnGgF3bw0S25IkzPPCk1xNZHG0qAVlLxDSnIr87lww38W5P1T4Jtkwk92+vvd4xcvOHTDJVdiKu7U2A+Re8qzWSub9MtG0Wt+SvkSmVAra/a/laga7/yRojhC045FnHt3PK7F055ceTgfadhPR5oAmYcUKXVQiAlAD3f4pC7fDIYA9WrACkJym2vakj3fHZ1Wpu0dpFnR1w71Iapfb2f14+RAXyhtN47xpgJs2IMnWFoUY9wvHUb7w0gEmTfkU+lL1uqLE5Ik32Jvps1hFsqJc0zMI7bjPcZiPXjfXhXB25ABRcau5FR3YOMnf7KF6f8JlAwV10f44rallcC9O9pN9JfQs1i0YvqEI//Q3u6V9K+jhf2kOs/UsG4WWq2L99zIFoPEvm5h40d2BXBMnHOcn4Tu6a2onjW7GiJTBtTsCpHos90DhDN0kqlNAaA9fmpWL4FnupHaPKHV9YWnBtJoMu10YBugHXL/dphZrZJlJJP9dBtcNaZWp0xVJsQPzu7VCKRNd6d4JyXcd50rgbyZCXmlzwYsvNejQ4gZrnh5GOJEY1Z8PswrTG8SQob8r48HBnwrMRdPMvkymB4b6G/LcjMK/gnP7B0ABFCvya0TfWuIz/T2l/0WHB7zqjmS3528gnkyz/7SLcsMmEUJRSPiiY4TPB7AygInNhqOBwkfREF0XVNyRPQbUkgxrXxZtn8eN+6aUPsNyKZnppp5WGIFku6xVok=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4383.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTVQaTByUnp4Y2doSytGRDc4Um12aUo0ZGhsV20ydk80K2UyWWNJWU5iSlBW?=
 =?utf-8?B?MjBRSGdtZTVaa0RlTm5iVmJoNmdXdGM0RGJnV1hWRk5FWk9BRDlkZG9lSnVB?=
 =?utf-8?B?UVhFMUdjWG1uVzAzeU1wTVFJY1FtWkdIZTJlL3pRVVFTOW1XS3d3YTJNRlV1?=
 =?utf-8?B?NjVNNk8rK0lDbEZId296TmpBUW1Gdko2S3BFbWpJRHpnWjdsRERqSFp1eGZa?=
 =?utf-8?B?NGlNWkZrbUdDenE4NldXM3RuWGhUNldxdFc1YUdRUUpjWmhIVlYrbVBhNCtl?=
 =?utf-8?B?bFl0UFI4YWw3N1Z3N2ZTWXlCclNiZ0pYU3ZSQ0h1dmFvRGQwOXB0NEl0ci8y?=
 =?utf-8?B?QThpSng3ZkhyaWsrQU1WMFJXc3BqdTlmOExnazN6VFNmMDdHN2h1VzBmVzlz?=
 =?utf-8?B?Rm0wV0kwNDRUanNvZzZFaUliZUhwZnBtbCtUY2didzBiMU03ajEwbThCeUtL?=
 =?utf-8?B?eDhiVmNzeUpBVTNEblEzUVlvbXcwTFhxeExPOU5mNHduS2hlcXVuZnNSdDlL?=
 =?utf-8?B?eFhVbXZISXkzMFlXS0h3RU8wNnVTQnpNV09iUzNYajdXTUhzNDd0bmhML2Q1?=
 =?utf-8?B?V0hrM3N3YWlMMm5rbnFPSURicDVKc0gyUXc2L1dTZC9VMm5manZXUWVkNzlN?=
 =?utf-8?B?b3F0di9rU0FZVkNQbU14Q2RCYWpsd1dQRnI2NmVyeWlXUUpQL2FaNllYUFJy?=
 =?utf-8?B?clRSOCtoZlZXYkFIc2psdFJFWCtGSDBMTFlGWitCMUc1eDRLRjRXMnFiQXNw?=
 =?utf-8?B?MTFvajhmSXJDRnUvWkR2WStZTHJPa2FObVAvNWowYlNSWWRFVVg1MUpUc2Rt?=
 =?utf-8?B?ckpUOWtXZU8yZXBFUExoL1lxWDY1aktaVjFvbFBGck1JemVOcUlsak1JYW15?=
 =?utf-8?B?M3hlL3A4TWxPazdqd0dHQTlFNVRtRU05M3UwZnBaMFM0OTlRRGdnQ3hMdUxV?=
 =?utf-8?B?RXF0enFQL0JCWjJSMW9BMnlmdkVUazZOSlRDQzFsZ3VHQnVFRjJnc0kwWVZX?=
 =?utf-8?B?L3JseW9NemVuL0wwQWR4ZTJJUjRXcEs0dGNpSG9QU2RlKzI1RG5RbVJVaEhB?=
 =?utf-8?B?TEVON2RmYVMvK29jSDRRbkNoaGJQWXNmMW9hRHJoK1lwUlhGWHFTS2ZBM1B3?=
 =?utf-8?B?VGJRWC85MlRxZmxwY3pwK3VxVHM3aGhRSmxxOEFYZkR2YVJHVkszZ2xUOG91?=
 =?utf-8?B?SFFseGdRcVQ3VnF5TTh3RXFCS01xRCtvWS9tVUdhVTI4dVFGczN3N0hJcUFN?=
 =?utf-8?B?RlU4ZmpaUUh5by9sRFQ5ZWU0dDBOcnRHTkZoQ01tOVI3T2tNazIvN3NwdWE0?=
 =?utf-8?B?cWlCOEFjQWF6dXl0bGU0eVVOQUtkUmprcE4wRnE4Tm1lNDBjS0pGYVNzNFpZ?=
 =?utf-8?B?RUZQZTVjUzBwR1psanB4MjlaMXhXV1JXTUtidWVxa05ZODNjYzZRNElZMHNU?=
 =?utf-8?B?SzNvRk91TXdKUDJGdlUwTitPY1VQRWFKb2crRytTek5NOVFJNmtPNHVCc3Za?=
 =?utf-8?B?OTN3eUEzTEZlUmJNeElLcnRXK1E4Y0hwY1kyU3NKeGFtRmc0UENiSmhWcXlD?=
 =?utf-8?B?d296WCtOWm5GcG1CTWlsTHFtZks0ZDJDNlpQclZPOXNHN3A4b3hOd2tzTTIw?=
 =?utf-8?B?OHlxZFp4K21DWE0zQUlVVWZteDJqcHNOUVZ3K2xaMUI4dkt4YW9PSTk0SjJT?=
 =?utf-8?B?cXR0dTQ5YmpKV2R1YzNIeWx1V3J6cFAxYUVnWG1wS0Qxbk9udE5lYUtmaUtI?=
 =?utf-8?B?NzRwRVNOUGRUSjgyZDZ6SFpsWnRJY1MydnZpWlVxQ09acUxUUGRUeWhmTnFS?=
 =?utf-8?B?WE5iWUQrbEhDMys4YldGR2o2U1dtblBOTU5DU2RRd3d0amVxL3JPakNhbitX?=
 =?utf-8?B?QmlPSkRtM214SVF5VDRUWXNwRUliT1RJcjl0Zm1vTVF3M1ZTUUFzYkRqWnU1?=
 =?utf-8?B?MkZyT05ybHpvcGkvN1JndlB1bnNJZ1Q2Y3pUN3YwbkZ0b3VPa052NE5raDZ3?=
 =?utf-8?B?Y0xVT3ZkSjFnRTg1MEl2WlFyY1A2YjhJSmZWS1RrN2JxeE5sSlNzQlMxZTJZ?=
 =?utf-8?B?Nkt1WHZrd0RwS1Fhc0R0ejlSMHZwcnROeWxEdWxYZ1JWYU1rQVJqRjB4SjJV?=
 =?utf-8?B?WnRNTThudzNsNjFFT1E1cTB4enJOVWtlL3BJTy9aakdJZnM3MldMQVVnT016?=
 =?utf-8?B?M0ZwMVF0NXkvSjNqWWIyNzdROUQ3SXhIU3RwUlpKNWRDYlFHV0VpUTdtSEhS?=
 =?utf-8?B?dlpJSEFZd2tFOC9vYlZJV3JVb1ZUUUorVVlMdjNIMklmaUZGNHVuazdwZXZu?=
 =?utf-8?B?a1hWSkRTNnZzSWF3VjcwVkVyTG96ZGduWmd4K2VQa25aa01zcnZOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4383.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d86a3f28-83a2-4a16-461d-08dea440d624
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 09:39:11.0149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gwycY1MzEh/ZgwOAMWqE6kkEBmFkc/9CQDJ001tZlsy0Cmwfuz35ZKfbhKygJ5LFdnKB88KUTg/107KF0qZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8072
Received-SPF: permerror client-ip=2a01:111:f403:c200::1;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=0.353,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiAyNyBBcHJpbCAyMDI2IDE0OjA1DQo+
IFRvOiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gQ2M6IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsgQmVybmhhcmQgQmVzY2hvdw0K
PiA8c2hlbnRleUBnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0h2NyAwMC8x
NV0gQWRkaW5nIGNvbXByZWhlbnNpdmUgc3VwcG9ydCBmb3INCj4gaS5NWDhNTSBFVksgYm9hcmQN
Cj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNh
cmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGlu
IGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFp
bCcgYnV0dG9uDQo+IA0KPiANCj4gT24gVHVlLCAyMSBBcHIgMjAyNiBhdCAwNzo1MiwgR2F1cmF2
IFNoYXJtYSA8Z2F1cmF2LnNoYXJtYV83QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+IFRoaXMgcGF0
Y2ggc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIE5YUCBpLk1YOE1NIEVWSyAoRXZhbHVhdGlv
bg0KPiA+IEtpdCkgYm9hcmQgdG8gUUVNVSwgZW5hYmxpbmcgZW11bGF0aW9uIG9mIHRoaXMgQVJN
IENvcnRleC1BNTMgYmFzZWQNCj4gPiBkZXZlbG9wbWVudCBwbGF0Zm9ybS4NCj4gDQo+IFRoYW5r
cywgSSBoYXZlIGFwcGxpZWQgdGhpcyB0byB0YXJnZXQtYXJtLm5leHQuDQo+IA0KPiA+IFJldmll
d2VkLWJ5OiBCZXJuaGFyZCBCZXNjaG93IDxzaGVudGV5QGdtYWlsLmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYuc2hhcm1hXzdAbnhwLmNvbT4NCj4gDQo+IEZv
ciB0aGUgZnV0dXJlLCBwbGVhc2UgZG9uJ3QgcHV0IHRhZ3MgaW4gdGhlIGNvdmVyIGxldHRlci4N
Cj4gV2hlbiB0aGUgdG9vbHMgcGljayB1cCBhIHBhdGNoc2VyaWVzIGZyb20gdGhlIG1haWxpbmcg
bGlzdCB0aGV5IHdpbGwgYXBwbHkgYW55DQo+IHRhZ3MgaW4gdGhlIGNvdmVyIGxldHRlciBvciBm
b2xsb3d1cHMgdG8gdGhlIGNvdmVyIGxldHRlciB0byBldmVyeSBwYXRjaCBpbiB0aGUNCj4gc2Vy
aWVzLiBUaGUgaWRlYSBpcyB0aGF0IGl0IGxldHMgYSByZXZpZXdlciByZXBseSB0byB0aGUgY292
ZXIgbGV0dGVyIHdpdGggYQ0KPiBibGFua2V0IHJldmlld2VkLWJ5IHRhZy4gQnV0IHdoZW4geW91
J3JlIHNlbmRpbmcgYSBzZXJpZXMgdGhlbiB5b3Ugc2hvdWxkDQo+IHB1dCB0aGUgdGFncyBpbiB0
aGUgcGF0Y2hlcyB0aGV5IGFwcGx5IHRvLCBzbyB0aGF0IHBlb3BsZSByZWFkaW5nIHRoZSBlbWFp
bHMgb24NCj4gdGhlIG1haWxpbmcgbGlzdCBjYW4gc2VlIHdoaWNoIHBhdGNoZXMgYXJlIHJldmll
d2VkIGFuZCB3aGljaCBhcmUgbm90Lg0KPiANCg0KTm90ZWQuDQoNCj4gSSB0aGluayB0aGUgdW5k
ZXJseWluZyBwcm9ibGVtIGhlcmUgaXMgdGhhdCBmb3IgdjQgQmVybmhhcmQgZ2F2ZSBoaXMgcmV2
aWV3ZWQtDQo+IGJ5IHRhZyBmb3IgdGhlIHdob2xlIHNlcmllcywgYnV0IGluc3RlYWQgb2YgbWFy
a2luZyB1cCBhbGwgdGhlIHBhdGNoZXMgd2l0aCB0aGF0DQo+IHRhZyB5b3UgcHV0IGl0IGluIHRo
ZSBjb3ZlciBsZXR0ZXIgaW4gdjUgYW5kIHVwLg0KPiANCj4gQmVybmhhcmQ6IGJhc2VkIG9uIG15
IHVuZGVyc3RhbmRpbmcgYWJvdmUgSSdtIGdvaW5nIHRvIGFkZCB5b3VyIFItYnkgdGFnDQo+IHRv
IGFsbCB0aGUgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcy4gSWYgdGhhdCdzIG5vdCB3aGF0IHlvdSBp
bnRlbmRlZCBwbGVhc2UgbGV0IG1lDQo+IGtub3cgYW5kIEknbGwgZWRpdC4NCj4gDQo+IEkndmUg
bWFkZSB0aGUgbWlub3Igd2hpdGVzcGFjZSB0d2Vha3MgVGhvbWFzIEh1dGggc3VnZ2VzdGVkIGZv
ciB0aGUgZmluYWwNCj4gcGF0Y2gsIGFuZCBhbHNvIHdyYXBwZWQgc29tZSBsb25nIGxpbmVzIGlu
IHRoZSBkb2NzIGluIHBhdGNoIDEsIGFuZCBmaXhlZCBhDQo+IG1pbm9yIHJlYmFzZSBjb25mbGlj
dC4NCj4gDQo+IHRoYW5rcw0KPiAtLSBQTU0NCg==

