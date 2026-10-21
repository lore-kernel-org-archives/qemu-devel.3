Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D4606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WFVT9TE9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJSzA-0003L4-IE; Wed, 21 Oct 2026 05:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xJSz9-0003Kk-6G; Wed, 21 Oct 2026 05:51:51 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1xJSz6-0007XL-Jr; Wed, 21 Oct 2026 05:51:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEibrvswxKbK7Atd9cMimEa15JQc80qrVmjUDujG6jE2UtjJqGR3FnivCaJsWJtI7jN3PZT/Q5cO1Wr7u60Cpn9ATgmUTdBe3Zh4y2FMB0B2AruZ7RgX8rqm7VZDKkD5ceHmejDzxJ9K7flqZn3y7XnhWYOskmGKj/ok0x/AaM2xVUgMdKUyGzw/BnIiDuZYJGar+8+RvhN+TcPGKNrkRm+0DtrgakkWMLDT9Q1IzROx4DixuKMe6AQ8Ikw5qTYgaS2mYDzYQBziORko9E0oOlqv36VGf7XxNyJPOTMuMyDEM1ssutzO4WzBVQLZoIs1XijitGVhFpndZlpLU55cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa54tXSzv8S5CVrSh17MXFwkUsco+QTbY0j/UDZUuVc=;
 b=q+b4ZhCpXaWe05uEHPeORAlfrRDBc+XFet+rX1K154RMLdeXx0WFxaP6A+dDNiR1aZLKnazIKKYV1ofM3cP4wuFJ1KmExaPEscb1NdXBI6haH6PCSSVdtUsePRkdFpAx/T09b5VRHIAX0LY+HmgqQ7Cjr/vz50EQ+qHCrvE5maqB7R9WlVJSnObg2i6n8A7oTEcn9NkeIwhwlOMiJNvYHKOOJfYy+afIf4p9hCsPlCps+bcHHKnigAckfhqSF9wxtcfrgkeZNznJy4k343KOAXA70LpbNyik/Td1mOKFncnHCFHzWhMc8aiQi0CFjL4Cz+vrxgpIz8rn0ylydD9ccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa54tXSzv8S5CVrSh17MXFwkUsco+QTbY0j/UDZUuVc=;
 b=WFVT9TE9XEEnStyL43JSAztCMsSgqHATJd0Gw67aNRW+h7q3rbf2j9Yp4KyaSomk1KMErv9oNz3QaabSjgVuyW8F3RNBhhyRVQ4JdM5w/EQQ5j3plhMeCjudhdJ9prXWUnqOeUC8jQIWZouaMidqGQJkL9hc08kV5r+wiw7JH4TXJa52pBp6rfBQueuuBBzotndQckYlYXdZa/YM49xMYKg5mV/z+nC7/Eb8/M5KJHUXeC18IKKNy4CEUiwfRvXBKvrXv2Ohk8Rh4G8B3VsG2VTs4mGIYzNlmdnvbqAGW1TKTiI0MiyPPF9UsPka2s/T6Gx2lbhtpuVirRFduYgtMw==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by BR0PR04MB378298.eurprd04.prod.outlook.com (2603:10a6:2c8:45::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:43 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 09:51:43 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "shentey@gmail.com" <shentey@gmail.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>
Subject: RE: [PATCHv4 00/11] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Topic: [PATCHv4 00/11] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Index: AQHdVkQvN7kxSz/UyUKL1KI+4SVqarcH1HPg
Date: Wed, 21 Oct 2026 09:51:43 +0000
Message-ID: <DB8PR04MB71771DC9E2A1E6C588590FB587662@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
In-Reply-To: <20261007101105.3917771-1-gaurav.sharma_7@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-10-21T09:42:31.0000000Z;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential; MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|BR0PR04MB378298:EE_
x-ms-office365-filtering-correlation-id: bcc4fd49-fea0-4627-a20d-08df2f58e99a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|23010399003|261009223027099003|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003|5023799004|11063799006|38070700021;
x-microsoft-antispam-message-info: 9DgNiMva46hpSQ1ghwwyBNP8+flBkjCVgINTtyEjORRTIJ/qlLr4fpZDHo6/zH8eT5jRlIN38DmknV5NyKJSgJFJDYUj95GKP69Hcntu7+gXJ15ptfjU6ggJ1/C+VNvlGA28bk/xDTRiztuy4ab3e8M+Ko9RGIp7CempEl5cXCLg6VUelr+lVX1Ll4tXEFBUUzqsu/eT3vy50ebd7wXweL+tXjfCjGiT+7lq02MmQGRuKDZ04DVCxnX0ng4YyDoKLw+tmJWqSVjALe64NoBrpEzUsRsCM3yyMNrhJDnR1tF3qldhcMUmmIZ8S5pk85N3IeH5Sk7TwE/ZLx+yNU7n0MD3EbQe0dPX1RqS+7Y6jiEQKdBp5+UFAIGIgJ9U01Wb4hGoSTCclywmxtdOaqcEbmc1iI2t41a7+pxzh9Nke6aTqBEOXUT5A3K090GusKlJ7gJpKP3PUMXngFWxHKtLkvlnwnwDxzV2WFnva3uqGuHL0i0+xSqL4BRQ9ZcvuKVyvZGsawkrVL6eN9tCR1vLXpB/wuXjLicsoi4HcsDTQLkCfJIRd3YbVyGtwFrx3BQb0Bp2pK8qrFFLR77A7RZ42zNZ27w+7oJCgr+JQAg9Yi51NwD4X1Dp5nOjKxQbCaoT2hqbunRDt/1zP04czamd17AdcP0R+7Hq0d2420zj9y7fBdhVJ0tYivjZ2dB1hEClwrTczplv8pP/2tQ8+0aBAwMgfPBGhlUiQkdaoWl5phw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Yzdjb25nM1E1dGxtSmlIczFLMzNSZjZWV0lNVVFFMnZFbnlrTVM0Nno2dG5S?=
 =?utf-8?B?a1ZWWDVrYklkUm1XMUtoUG9pUVhHMzk0d05keFdDdVljYk1FWkJ6d3ZBZE1S?=
 =?utf-8?B?MkovVjFsSVlmL3NYRVJpdEQzdGIzVWJsSnQrZ0FxdU44ci9PTmh1c04wN1ow?=
 =?utf-8?B?SWFLR250YmlROXh1UE40THIyUks2RDNUMXlqRHVLMHc4ZmRYOThmSnpJT3p1?=
 =?utf-8?B?UDl5N2srOHRlS0ZVdlZJZkEvUm51NytPMjhIeTQvcWJVSTVqSG1WRVRGUEcz?=
 =?utf-8?B?cUV6eDBFbWd3VGZKR2d4d3lTSTk3YWhuMzVoeE41UHB1V2QxNDY5OSttcm5M?=
 =?utf-8?B?WmdaU0FQN1BDQ2M5OGgzSDZJa3EzQXExNWwydWlzb3EwMzcyUmR5Rml1WVFE?=
 =?utf-8?B?OHd4ZkNia21HWTVMVkZ0Wmhwa3VkSElnSUlXMTloYmtvbXhlWEV2cjgrU2V0?=
 =?utf-8?B?ZXhxdkhGUndubDBkY29CN2VLY1lXY3dMbVp1eHg1ZXdMT1cweG5FL1YxaGt3?=
 =?utf-8?B?Ymc3SDJCWm9tUGRESXBkYmhGTHF2QVh6SDkwWW5FUkdIZHhZY1YzRlpwZ1ZK?=
 =?utf-8?B?ZGlTMWhTNUh4bVNhdmNpcVNQWnIrYnh1WTg0dFR5SS9IbjFONG9URmZzTjAx?=
 =?utf-8?B?VGo4NjVoWEtzcnlVQnpxR2J0TGdkbGFSeVFSMlNmMmlrOVZKeFJkbWpWbFhS?=
 =?utf-8?B?K2dTcyt0NlRWbWdYdmJCNy9PamFkYjNOblZkYjVJamwyODdWTDN4YnpDMUk5?=
 =?utf-8?B?YUNVaWNTZGNOZUZURkVRck02NFhUcDBRMUJBbVdGbGQ4OU9haWlyUG5zSkMr?=
 =?utf-8?B?T2g2ckVPU0RHNW14K3Y5cmNjNXNPaVFTNnBGMEEzK2NaSEEreloxdzRUMkdV?=
 =?utf-8?B?dmgwNnpmbkNLTFNJa0JhTnc0WUFRQk5ZdnRIdng1WGxLVEdGUFNTTU9VdGQv?=
 =?utf-8?B?MmFnVldIaGptM0pvdzBveGo0Q0h2Wm9NU2hGS1JVUUpsNXJSc1pFZklmSkNP?=
 =?utf-8?B?bGd3dm44WDIzdmVuemJYZmNMUXJnTWFtaDBveEZlMWF2bmtidVluMkVJREMx?=
 =?utf-8?B?YjJvendyTkJnN2pHaW9UQzFkOHdJTTVSZytrai9NR293ZWdBTjJsNDR3SnRu?=
 =?utf-8?B?Y3ZoUzlrbVQ3VXRRNWx3M2lObng4THNQQ05iVDQwZzYra2l5TVVRK3liWmZk?=
 =?utf-8?B?R0FhSHl2Zm9ZbDNIeC95VW9sb01SNjlXajZyL2Z5amQ5NVdjYU16d1E2RTZ3?=
 =?utf-8?B?dDRRc3drSUpDZXU2K0NELzJaV0ZBR2Q0RmpCUEdvU0JURWRkL1NRUmVkOU1M?=
 =?utf-8?B?SWxHQTN5OVBUMXR3K2ZTUDRIU01kbGhGclF3ZnpsbnNFekRac0U4dzRrQ0ts?=
 =?utf-8?B?bFgvaHFpOHFSWFFFK2lVN0ErM1prYmlsQVRnWit6WEFSdEQ5RGJrRXQ1eml6?=
 =?utf-8?B?ZzVVN3VwKzFnTmdYMHhzbzhhem1GK3FmSEUvWC9TTUswUEU0Nm9raFd1MCtm?=
 =?utf-8?B?MHp5VXJ3Wm52WCt6SEd2Q1dsTEQ3Uk12Mk1yM0ZJOHg5ZHU1VFNrMEdxRDda?=
 =?utf-8?B?ZlZJMWJiSldzaXA0bTdDMGFDQXJ6ak9XS0tjQkx6Umc3d3NLQnpqWGlmRHJV?=
 =?utf-8?B?YlNCcmNpb3lsWEptanpRWFdVSEpadjJZTnZaRm5RUUpoZUZZdkh6TExBbW84?=
 =?utf-8?B?dW5sa2ZhUENZOEZRYXlVWTZvWFRzc1J3RHVDQVl6MUpaNW1CZzR5aDJaVzBR?=
 =?utf-8?B?VGZqUG56QUdudkhBY1lPMHFXc0FGa09QcnBTWitLZ3ZFK3k3Ry9kZHBFelFm?=
 =?utf-8?B?MnNtUndEWk92dGM5SHluWk1ZOGsybldlNm80VWNFN254cVJ5di84Njg2R2Vl?=
 =?utf-8?B?OVIrZnNvelMzVElCditkZHZua3A3TmRKVzRMZjBzdEQ5c3J1TjRqQnF6bkJJ?=
 =?utf-8?B?YzFuSzhYRkp6UmIxVTB4MkxwaUc0N3cyWklDeU5MSTI1YU95UUFBRm9zZjZo?=
 =?utf-8?B?N1VDUWZQL2lKUjBJR3JUVTJJK1VJK0N1eXZZWnRnbW9TeURLQ0pQK3ZIV0ZM?=
 =?utf-8?B?d3N2YTNLV0NTRitmWDBzZThuamJsMnZuV3FqMUtrTEpYMDFpT1doVXlwUWU2?=
 =?utf-8?B?TEF6SUZiQURYQklhUFVQRXJRdm5CRnJBR0tQbGpBZGkzNHVab0owcUJiYTRP?=
 =?utf-8?B?RjVNVVhkKzJyT0Qrcitvd2JzVDRqYk1FekwwYVNCZE5aNHgxckFIenExQXlO?=
 =?utf-8?B?NlErU1RET2dnckhwQitzVXpxbzROZWF4bUtJT28zR3lCT0RuVGxpUnZIVktR?=
 =?utf-8?B?T055eE5RZVN1QmJZU1JvWlJCZkNkVjFBN3pOREpTTG1SVmZ4VHpXZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc4fd49-fea0-4627-a20d-08df2f58e99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2026 09:51:43.2406 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/FJLjFC7CB0I0ETecc4nvxSMOndbMxGaQjD+8b5qjHFU5Oyh7ubW3iI5xcK0Nw5XMhSz7HYQDTookXVVR2sFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB378298
Received-SPF: permerror client-ip=2a01:111:f403:c20f::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UGluZy4gSnVzdCBjaGVja2luZyBpZiBhbnlvbmUgZ290IGEgY2hhbmNlIHRvIHJldmlldyB0aGlz
IHBhdGNoIHNlcmllcy4NCg0KDQpOWFAgQ29uZmlkZW50aWFsDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IEdhdXJhdiBTaGFybWEgPGdhdXJhdi5zaGFybWFfN0BueHAuY29t
Pg0KPiBTZW50OiAwNyBPY3RvYmVyIDIwMjYgMTU6NDENCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4g
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBzaGVudGV5QGdtYWlsLmNvbTsNCj4gcGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tOyBHYXVyYXYgU2hhcm1hDQo+IDxnYXVyYXYuc2hhcm1h
XzdAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIdjQgMDAvMTFdIGh3L2FybTogQWRkaW5nIENv
cnRleC1NNyBBc3ltbWV0cmljDQo+IE11bHRpcHJvY2Vzc2luZyBib290IHN1cHBvcnQgZm9yIGku
TVg4TVANCj4NCj4gQ2hhbmdlcyBpbiB2MToNCj4NCj4gVGhpcyBzZXJpZXMgYWRkcyBBc3ltbWV0
cmljIE11bHRpcHJvY2Vzc2luZyAoQU1QKSBib290IHN1cHBvcnQgZm9yIHRoZQ0KPiBDb3J0ZXgt
TTcgY29yZSBvbiB0aGUgaS5NWDhNUCBTb0MuIFRoZSBNNyBmaXJtd2FyZSBjYW4gYmUgbG9hZGVk
IGFuZA0KPiBzdGFydGVkIGZyb20gTGludXggcnVubmluZyBvbiB0aGUgQ29ydGV4LUE1MyBjb3Jl
cyB2aWEgdGhlIHJlbW90ZXByb2MNCj4gZnJhbWV3b3JrLg0KPg0KPiBUaGUgc2VyaWVzIGludHJv
ZHVjZXMgdGhlIGZvbGxvd2luZyBwZXJpcGhlcmFsIG1vZGVscyBuZWVkZWQgZm9yIEFNUDoNCj4g
ICAtIEdQQyAoR2VuZXJhbCBQb3dlciBDb250cm9sbGVyKQ0KPiAgIC0gR1BSIChHZW5lcmFsIFB1
cnBvc2UgUmVnaXN0ZXJzKQ0KPiAgIC0gU1JDIChTeXN0ZW0gUmVzZXQgQ29udHJvbGxlcikgYXV0
aG9yZWQgYnkgQmVybmhhcmQgQmVzY2hvdw0KPiA8c2hlbnRleUBnbWFpbC5jb20+DQo+ICAgLSBN
VSAoTWVzc2FnaW5nIFVuaXQpDQo+ICAgLSBFeHRlbmRzIHRoZSBDQ00gd2l0aCBNNyBjbG9jayBv
dXRwdXRzIGFuZCB3aXJlcyBpbnRvIHRoZSBpLk1YOE1QIFNvQw0KPiAgIC0gRW5hYmxlIENvcnRl
eC1NNyBib290IGluIGkuTVg4TVAgRVZLIGZ1bmN0aW9uYWwgdGVzdA0KPg0KPiBDaGFuZ2VzIGlu
IHYyOg0KPg0KPiAtIFJlbW92ZWQgdGhlIHVzYWdlIG9mIGRldmljZV9jbGFzc19zZXRfbGVnYWN5
X3Jlc2V0IGluIGlteDhtcCBncGMsZ3ByLG11DQo+IGFuZA0KPiAgIHNyYy4NCj4gLSBSZW1vdmVk
IHRoZSB1c2FnZSBvZiAnc21wJyAsICdtYXhjcHVzJyBhbmQgJ2VuYWJsZS1jbTcnIHRvIG1ha2Ug
dGhlDQo+ICAgaW52b2NhdGlvbiBzaW1wbGVyLg0KPiAtIENsZWFuZWQgdXAgaW14OG1wX3NyYyBi
eSByZW1vdmluZyByZWR1bmRhbnQvdW51c2VkIGNvZGUuDQo+IC0gVXBkYXRlZCBNYWludGFpbmVy
cyBhbmQgaW1wcm92ZWQgdGhlIGlteDhtcCBkb2N1bWVudGF0aW9uDQo+DQo+IENoYW5nZXMgaW4g
djM6DQo+DQo+IC0gQWRkZWQgYSBuZXcgcGF0Y2ggZm9yIHNtcCByZW1vdmFsIGZyb20gdGVzdF9p
bXg4bXBfZXZrLnB5Lg0KPiAtIEFkZGVkIGEgbmV3IHBhdGNoIHRvIGludHJvZHVjZSBJUlEgc3Bs
aXR0aW5nIGZvciBpLk1YOE1QIEFNUCBpbnRlcnJ1cHQNCj4gICByb3V0aW5nLg0KPiAtIEFkZGVk
IGEgbmV3IHBhdGNoIHRvIHJlbmFtZSBGU0xfSU1YOE1QX05VTV9DUFVTIHRvDQo+IEZTTF9JTVg4
TVBfTlVNX0E1MywNCj4gICBzaW5jZSBNNyBpcyBiZWluZyBpbnRyb2R1Y2VkIG5vdy4NCj4gLSBJ
biBHUFIsIHBhcmVudF9waGFzZXMgbW92ZWQgZnJvbSBnbG9iYWwgdmFyaWFibGUgdG8gY2xhc3Mg
c3RydWN0DQo+IC0gTTcgcmVzZXQgaGFuZGxpbmcgbW92ZWQgZnJvbSB0aGUgbWFjaGluZSB0byBT
UkMgZGV2aWNlIG1vZGVsLg0KPiAtIEFkZGVkIElUQ00gYW5kIERUQ00gbWVtb3J5IHJlZ2lvbnMg
dG8gc3VwcG9ydCB6ZXBoeXIgZmlybXdhcmUNCj4gbG9hZGluZy4NCj4NCj4gQ2hhbmdlcyBpbiB2
NDoNCj4NCj4gLSBNb3ZlIGluZGVwZW5kZW50IE1BSU5UQUlORVJTLCBDUFUgcmVuYW1pbmcgYW5k
IGZ1bmN0aW9uYWwtdGVzdA0KPiBjbGVhbnVwcyB0byB0aGUgYmVnaW5uaW5nIG9mIHRoZSBzZXJp
ZXMNCj4gLSBDcmVhdGVkIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIElUQ00gYW5kIERUQ00gbW9kZWxp
bmcuDQo+IC0gTW92ZSBJUlEgc3BsaXR0ZXIgaW5mcmFzdHJ1Y3R1cmUgYmVmb3JlIENvcnRleC1N
NyBpbnRlZ3JhdGlvbg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHYXVyYXYgU2hhcm1hIDxnYXVyYXYu
c2hhcm1hXzdAbnhwLmNvbT4NCj4NCj4gR2F1cmF2IFNoYXJtYSAoMTEpOg0KPiAgIE1BSU5UQUlO
RVJTOiBNZXJnZSBNQ0lNWDhNTS1FVksgYW5kIE1DSU1YOE1QLUVWSyBlbnRyaWVzDQo+ICAgaHcv
YXJtOiBSZW5hbWUgRlNMX0lNWDhNUF9OVU1fQ1BVUyB0byBGU0xfSU1YOE1QX05VTV9BNTMNCj4g
ICB0ZXN0cy9mdW5jdGlvbmFsOiBGaXggaS5NWDhNUCBFVksgU01QIGNvbmZpZ3VyYXRpb24NCj4g
ICBody9taXNjOiBBZGQgaS5NWDhNUCBHUEMgKEdlbmVyYWwgUG93ZXIgQ29udHJvbGxlcikgSVAN
Cj4gICBody9taXNjOiBBZGQgR1BSIChHZW5lcmFsIFB1cnBvc2UgUmVnaXN0ZXIpIElQIHRvIGlN
WDhNUA0KPiAgIGh3L21pc2M6IEFkZCBTUkMgKFN5c3RlbSBSZXNldCBDb250cm9sbGVyKSB0byBp
Lk1YOE1QDQo+ICAgaHcvbWlzYzogQWRkIE1VIChNZXNzYWdpbmcgVW5pdCkgSVAgdG8gaS5NWDhN
UCBkZXZpY2UgbW9kZWwNCj4gICBody9taXNjOiBFeHRlbmQgaS5NWDhNUCBDQ00gd2l0aCBDb3J0
ZXgtTTcgY2xvY2sgb3V0cHV0cw0KPiAgIGh3L2FybTogQWRkIElUQ00gYW5kIERUQ00gbWVtb3J5
IHJlZ2lvbnMgdG8gaS5NWDhNUA0KPiAgIGh3L2FybTogQWRkIElSUSBzcGxpdHRlciBmb3IgaS5N
WDhNUCBBTVAgaW50ZXJydXB0IHJvdXRpbmcNCj4gICBody9hcm06IEVuYWJsZSBDb3J0ZXgtTTcg
QU1QIGJvb3Qgb24gaS5NWDhNUA0KPg0KPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxMyArLQ0KPiAgZG9jcy9zeXN0ZW0vYXJtL2lteDhtLnJzdCAgICAg
ICAgICAgICAgICAgICB8IDE4NiArKysrKysrKysNCj4gIGh3L2FybS9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDQgKw0KPiAgaHcvYXJtL2ZzbC1pbXg4bXAuYyAgICAg
ICAgICAgICAgICAgICAgICAgICB8IDIyOSArKysrKysrKystLQ0KPiAgaHcvYXJtL2lteDhtcC1l
dmsuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArLQ0KPiAgaHcvbWlzYy9LY29uZmln
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMiArDQo+ICBody9taXNjL2lteDhtcF9j
Y20uYyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gIGh3L21pc2MvaW14OG1wX2dw
Yy5jICAgICAgICAgICAgICAgICAgICAgICAgfCAxNDYgKysrKysrKw0KPiAgaHcvbWlzYy9pbXg4
bXBfZ3ByLmMgICAgICAgICAgICAgICAgICAgICAgICB8IDE1NSArKysrKysrKw0KPiAgaHcvbWlz
Yy9pbXg4bXBfbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDM0NiArKysrKysrKysrKysr
KysrKw0KPiAgaHcvbWlzYy9pbXg4bXBfc3JjLmMgICAgICAgICAgICAgICAgICAgICAgICB8IDM5
NyArKysrKysrKysrKysrKysrKysrKw0KPiAgaHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNCArDQo+ICBody9taXNjL3RyYWNlLWV2ZW50cyAgICAgICAgICAg
ICAgICAgICAgICAgIHwgICA1ICsNCj4gIGluY2x1ZGUvaHcvYXJtL2ZzbC1pbXg4bXAuaCAgICAg
ICAgICAgICAgICAgfCAgMzIgKy0NCj4gIGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfY2NtLmggICAg
ICAgICAgICAgICAgfCAgIDMgKw0KPiAgaW5jbHVkZS9ody9taXNjL2lteDhtcF9ncGMuaCAgICAg
ICAgICAgICAgICB8ICAzNCArKw0KPiAgaW5jbHVkZS9ody9taXNjL2lteDhtcF9ncHIuaCAgICAg
ICAgICAgICAgICB8ICA2MiArKysNCj4gIGluY2x1ZGUvaHcvbWlzYy9pbXg4bXBfbXUuaCAgICAg
ICAgICAgICAgICAgfCAgNTMgKysrDQo+ICBpbmNsdWRlL2h3L21pc2MvaW14OG1wX3NyYy5oICAg
ICAgICAgICAgICAgIHwgIDQ3ICsrKw0KPiAgdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3Rf
aW14OG1wX2V2ay5weSB8ICAgMSAtDQo+ICAyMCBmaWxlcyBjaGFuZ2VkLCAxNjk2IGluc2VydGlv
bnMoKyksIDQ3IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IGh3L21pc2MvaW14
OG1wX2dwYy5jICBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9pbXg4bXBfZ3ByLmMgIGNyZWF0
ZQ0KPiBtb2RlIDEwMDY0NCBody9taXNjL2lteDhtcF9tdS5jICBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gaHcvbWlzYy9pbXg4bXBfc3JjLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21p
c2MvaW14OG1wX2dwYy5oDQo+IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvaW14
OG1wX2dwci5oICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gaW5jbHVkZS9ody9taXNjL2lteDhtcF9t
dS5oICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gaW5jbHVkZS9ody9taXNjL2lteDhtcF9zcmMuaA0K
Pg0KPiAtLQ0KPiAyLjM0LjENCg0K

