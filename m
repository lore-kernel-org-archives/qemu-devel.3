Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD9F8E4B5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 07:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDdsk-0004qU-4a; Fri, 17 Apr 2026 03:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDdsi-0004pv-F4; Fri, 17 Apr 2026 03:44:52 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDdsh-0000D9-1i; Fri, 17 Apr 2026 03:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZR+k5ypA0ISxb4ceuAN4Rj3EWJhZhaV9ZgwJ2rM3FziTqOH9qafje6V9SnJUg50fuQE89KcZ9Rdwd43bjnjibI7fFO3mz24zLQuroITxxFmeUMzS0kPA8EwW2jHf+sZyChQlx3GmJSNGo562iypVdvmcdXiEl/ro8kw02MIu3cDdy1VeZF1lvS0ByUsaC9hMIKiQ7hZbuQIHSOcvPtMO5YdC4RiDdk7OzJ66JlZt1iXaedPXyL0AClKo3ZQx8mi+s4k0cDwA0NUGIQHafP1uFju7zf3EgWZ2DmPpGXVDh925R+birKNkwp+b58FbxIDr1hQeP16ekNUjbeaPFOuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R92eGV+c8m+ALHefgPfy/QdYH0vH+7B0C2f/AQZzTWc=;
 b=CGcTZEO8A0lmPHhz1WfVvJoJ3FHobX4xUvjNTsuekRIlr4oaOilgBsgcAgojKJ1fq1yIqOgLRcu0m/ACSS9rPfKFl63+5kmI+//l+PN6cjZVy2vptdBi6C/pYU0EJpsTZ5d/ZUIdBqxEgQDGQITZ6uPN1lX8U2Uvu4C4NbQf8lYB14EIKR9yhEPR/1TXnP0p8AHGBdt25Cj7OOmSZI1+hD3qxoycu7shfy213JnACp6GZfNmfHuYnkbf1H+qzT2VlxQWSwlWhMGT/8whtmcm7XmD3/E3K2geZk5iPcgUGBL+xoKvxTPa6gDxKmejIT7EIhCTM5BieTb//+KTZeexLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R92eGV+c8m+ALHefgPfy/QdYH0vH+7B0C2f/AQZzTWc=;
 b=N/StLIxJsQ+Y/Ahj8xuydsTypSLo9mM6f7h2LXoIn5IBTjs9Mcj79SkMnZEMxdm3HPoQ69X5+K7F04XZrbTBGbxzw4dcnTYmjWM2MI0k36fKLqmPG/AR1Yb7iNOwbxQ4sXbxqhWLP4FtU1In6AU6VOWP7oaPo+zbKrCw4wFYYs4TkKGPSKEHK2u/pfS8U7cBlwpyZfEqYe16KlBqt2G+iOnW+wmbxlu7WQPI6IvXLdwkRTE1XDECKnn45Ys1MyeOzl3zhJfWqEeLIyMYvAr/gsijp2cDZm5Q7qYhRiFSWAgezzhbHL81NM1dyZWia8zeBR5AezC5NemDYdn6mwgjmA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5390.apcprd06.prod.outlook.com (2603:1096:101:65::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 07:44:44 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 07:44:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v3 12/17] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Topic: [PATCH v3 12/17] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHczUNTnR/OW0Fgz0S9st3V80uVyrXizBiAgAAU3jA=
Date: Fri, 17 Apr 2026 07:44:44 +0000
Message-ID: <TYPPR06MB82064DC25F359E48B2D7B2D4FC202@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
 <20260416014928.1279360-13-jamin_lin@aspeedtech.com>
 <3d289236-eba5-4b94-9930-bfb0086ee66e@linaro.org>
In-Reply-To: <3d289236-eba5-4b94-9930-bfb0086ee66e@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5390:EE_
x-ms-office365-filtering-correlation-id: 636294e5-7aa9-43b9-1a0e-08de9c55312b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: h8bBllfQSg8bg+h5grfmULkCn2WQsVYOAH6QlR5TXTwu2C92sLqjZ4eR12kmFnOb7J8h4SeqlGy4yjlYiACEKueRT7NzV2UDW7LnmABd2waO750u8KLczIfLDw2hNFdFpukwa3yRfbg5MjZvAxU1XYFhjZhFR/FJEmSL/5tyHNRL5A2F2tKKzF21jIeC4Udto0VVODgfhhN8bJ4ZUwzrd8fm6DNl7COHlv9DVTGiqtogKaB3dzrmcreJ2+IWMCIpH4QTxpAeH1nsipmWqCEtGOHTimdA9ZHgyFsTfkOSkpct9tCDWes5uuA6uXpT7WFNgcl4rEyFdc/cMlYDAXDQDrPMAM65dKHznjL199kM5/36LzUVw+txnWePukOt3IQPwDO+lMs8KOKoP70g3J+6ZO60vc8nVf8FzLM2h+cTuek8aJjXRqkUmf78Y2ho9RZWrBkmwoHfmByGcku4FsJMGF64Nvgg3LOF45nXX1SDmA0h9ZjOw13e3eq5bBYxAelggXzC6qrQtDfW+VXAPfyfc1Htz7neJkk5wo49Mk4+ms+fIod4mCy6bXCNGkm1YR7NDtvksO5B3JbJxv2Yn6DXtOysv/OJzGiKXQwSICgI35Je8L9SDoLH1jHk3ToAbm68pCD7rGYOKHYqAZh30GlZO5mKR+QO1lmM8rIZvhVBqsjoVT9dG9eLpZAks+PcgXbeghj7gKExFxBE829vQv/uOke1nMk5kNoYlR3yg4jn7U1ELwGNCPmwHI63MBEtz/VzieTV3Bw0mI9Tz+CEZKC8uf76FaqXBj7Viv66A7hIFqzrqwyAQXaaiuSnrCUoedJo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDNERXhuWmN0OGdyQld3UG5xb0htaW1vSW1SNHg0T1RDWnhGa1hrdnIrTjJJ?=
 =?utf-8?B?Mk1xcDdndU5oNm5yNzk2WVdob0hBNWRTNjc4WWdCa3loaUtybWQ3ODBuUVVn?=
 =?utf-8?B?bU9GWWZ1a0pYVk4rSWNabjJpN2I1VGhiOHNLQWlVaVVJUFdEZzIyeUFOZEdE?=
 =?utf-8?B?NEZqeWJqOGRWeXczaTlkc0thRmJSQ0JmSGVZZkpXRVcxZmpHRFM1Zlhhc3Ns?=
 =?utf-8?B?NFRIMkc4Y01ja1BnblBlc3J4b21wV3lrUEZ4c1F6ZlhUTlRJY2hCMmJYZjhy?=
 =?utf-8?B?VWxsQVJzdmE0czBNQWI5ZnNGOWtJYm9EOFgxMEJZUzQ4OGI1ZHlPVlVWZlFM?=
 =?utf-8?B?Vm9VdzF5VFFMNHNsSFFkOGU4TEluME1DUHRGSGh1azhYMXZHVlNTR2pCMzUy?=
 =?utf-8?B?SytiUUNtTDNvOEFxMHRLVjA0SnhjWk9ESExhUGgzSTRRc3YxY3U5allDU0FZ?=
 =?utf-8?B?bXBEWTROa0ZJbDZLZ0Jrb2dUN3ZneFB3clJCa28vY3I3UzNjdnJIUE9SUTRh?=
 =?utf-8?B?RysvSmpEV1BYaFFGd01ZcnJLa2dWVE1PZTdVTVNVQXZUL3lxdi9vcjdYZWRl?=
 =?utf-8?B?cXd0N1FjU0lOekZiTDF5a1dDWndidC9RZUo0STF5MVRpSHpZUVQwdmZKSjc0?=
 =?utf-8?B?a1UwdCs5SDVZR1Q3MjYrNm9JdFpPL0N0MllMTjVNMHVVekMwdmE0MXBYcGY3?=
 =?utf-8?B?N0RkMjRxNCs5TXY0TmlrdzMrd01sYU9DTFVqTE5VMXRlSW52bWxWb2w1ekxw?=
 =?utf-8?B?V0VjTVdtRnZUMittZHVzTEhYaEovRjFTTUxzR1JlQ3d3aWdWOEZDbE5pZS85?=
 =?utf-8?B?T3VoVktKM3FUSnNFRnBzZEdmRmNSN2tmRTdPTkp1ZHJ5T3JlSlV4M2RnMGlK?=
 =?utf-8?B?S0I5bERyMzUzSk14dGU1UzJIQjN4cFBIOVlzUjM0eFVrbjNJZWE5ekJOQnVq?=
 =?utf-8?B?dUw3cWoyeUoyTmtrdDJPaGVhbVpNT2xpWGZHdGE2bDNHeUtWbG5SREQ3bjRG?=
 =?utf-8?B?MVFrN0lZN0JackZyRlo1N2lmQjNSOEhUUWg3d2UyUlJuQUE0cXhtaFhudS9o?=
 =?utf-8?B?a3Y0U0VMdWIySmo5ZEYvdlFtbEY2RHVEN3BDckpzaUlwNmlMM201ayt5eGlq?=
 =?utf-8?B?UWFLZ1dVT3dKSU0rMFFYTmMwbnJObEp6S01rV0pmS0h3cXIrc0Q0a0duUFE4?=
 =?utf-8?B?UEhtU1pWemM1b01XOWJOd0MyeG9NdFYrN3ZWT1pHV3Q1cEtDT1QzdUYyN3ZT?=
 =?utf-8?B?SHRxMHNxMmtVeGxPaWNCdlc4UEJtWDQ1ZmJoSFhZQnhhNTA0SUwwQVVGU0xN?=
 =?utf-8?B?cmZONnBFdVhtY1I2c1RrM1lpMFFpOGdWSnR2UUhmL21KRHdDQk5MZ3U4SmRW?=
 =?utf-8?B?OWFXcU9RNnhtaGhFcGhhcXhFcVZUdEtsdnZUWCtxYndoZlBUWUM4cjhOWWNF?=
 =?utf-8?B?Y29BdHFYZGxPd3pXZXZ4OUZLS3F4YVlmSXZHOGh1aU1qeHZiZnFkdWprdDJR?=
 =?utf-8?B?RHZ4cTFtWC9PbzhIeVlIZ0h4aTVKc0Qrb0t4TmllVzVMTis4dVZ2NlRyQ3hE?=
 =?utf-8?B?ejhXL1JYU09nU1pJSWlHSWk3QW1NVlJ3b2twTFRNdU5kWDFTL0ZKZ2ZWcXY4?=
 =?utf-8?B?U0dBaDd2N0k5dDkremVQQjV1Ni9XbmQzSkpBZ3JBdmZUMjdFVHUybDVFSy9O?=
 =?utf-8?B?L1hkK01BVHpWZWxNNWVsVWU3NVk3b2E4dTdVemdUMWx2d1BlaWpPNlV1TmZK?=
 =?utf-8?B?RjVOMFluemQzSXNscDRiSDJWc01aNzBqUHM2ZjZRUmNCdnNpMFcxY1RCS0dR?=
 =?utf-8?B?ZlN2TjlQZVpqRTJna2l6MzJ3bXVjU21zaUNUclMwU0dlMmp6VGU2NE4xanFx?=
 =?utf-8?B?aGRLZVJOVndwdkpSOGpzak9nNkN0aTBrWHZqbEFwYmZDcHdkeTMxUXpnNnMx?=
 =?utf-8?B?VncvSDVES3R5akl5TGErUUk1TmREcVdqWXJhUjd5TG53cjY3cWJKL2drV0Vr?=
 =?utf-8?B?dkRzdUVkL2F1TmZMUXFFZWdqYlNRYXlkTWV3djIxSVZEcHNqQVRqdFBVMGJy?=
 =?utf-8?B?Q1VMcURScFdqU2s4YUlMeENyYjVpNlVmUG9zdis0aW8zYnpRWmtCeW9mcGNE?=
 =?utf-8?B?aXRoa1FRUnk2VEFRQW90enhaVENyYXA3OVUyMjBjQkVpNWNUQU9UTjRMVjEv?=
 =?utf-8?B?R05ML2tzR2doWXZtTC9TMFZiems0SjV1Qm9xL1dEdk5YSXdUSytJdXdzaHlG?=
 =?utf-8?B?SURyTFJldFJKa0g1Wm9qVU1WanJ5dCtyeGxreE82NFFOTmcydzdWcTcvbDFQ?=
 =?utf-8?B?cnp6UzVmam05WjdvM2hGWVZYT0hJZDRETE5wRXMydFBmQUN4NWZyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dpUzttL8e88w4H4X8+fBtfSUMS6M+Jzf32UNMyAq8qQqzrpuCVHeJ0PfhCH5PfXfb8Z5+dKLyn7CNiJygaXR2n7dhf+NFGuXwFEDPJfjY9JDocDfs5YhaYIQBewaNC8uHZ40XxhxWmJJLYGosInp9UrWBVcD9iHB+FzWtsuE561ou0Ht8Mq+tlC0mi0kx3rzq3eohoxm4jALPF7Nsn+nXTgMFQuvx7NDLv2lBEla7kQjQj9OfNHKHzeDxy/w6bjTOSmLep7L5ywYvfQcH56n7/Q0oLH46P3GE5PBeFGmwFgEIURZpWUBgJRGjdjurJyl61uCWn4HH+nnPiCRGhalWQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636294e5-7aa9-43b9-1a0e-08de9c55312b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 07:44:44.3855 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Az78nUBbgZxtpu8Sa1DjQGwpZTL/lAiL/PtbimyekrGyWFdbYnVQmBrzQjBuzpHX5jim9EcHzeU+SLOIoiRLvCiKLDbCsQwJuAB4/xvEV/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5390
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgUGhpbGlwcGUsIA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTIvMTddIGh3L3VzYi9o
Y2QtZWhjaTogSW1wbGVtZW50IDY0LWJpdCBzaVREDQo+IGRlc2NyaXB0b3IgYWRkcmVzc2luZw0K
PiANCj4gT24gMTYvNC8yNiAwMzo0OSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEVIQ0kgc3VwcG9y
dHMgNjQtYml0IGNvbnRyb2wgZGF0YSBzdHJ1Y3R1cmUgYWRkcmVzc2luZyB3aGVuIHRoZSA2NC1i
aXQNCj4gPiBBZGRyZXNzaW5nIENhcGFiaWxpdHkgYml0IGluIEhDQ1BBUkFNUyBpcyBzZXQuIElu
IHRoYXQgbW9kZSwgdGhlDQo+ID4gQ1RSTERTU0VHTUVOVCByZWdpc3RlciBwcm92aWRlcyB0aGUg
dXBwZXIgMzIgYml0cyB0aGF0IGFyZQ0KPiA+IGNvbmNhdGVuYXRlZCB3aXRoIDMyLWJpdCBsaW5r
IHBvaW50ZXIgdmFsdWVzIHRvIGZvcm0gZnVsbCA2NC1iaXQNCj4gPiBkZXNjcmlwdG9yIGFkZHJl
c3NlcyAoRUhDSSAxLjAsIHNlY3Rpb24gMi4zLjUgYW5kIEFwcGVuZGl4IEIpLg0KPiA+DQo+ID4g
c2lURCBsaW5rIHBvaW50ZXJzIGFyZSBzdG9yZWQgYXMgMzItYml0IHZhbHVlcyBhbmQgbXVzdCBi
ZSBleHBhbmRlZCB0bw0KPiA+IGZ1bGwgNjQtYml0IGRlc2NyaXB0b3IgYWRkcmVzc2VzIHdoZW4g
NjQtYml0IG1vZGUgaXMgZW5hYmxlZC4NCj4gPiBVcGRhdGUgdGhlIHNpVEQgdHJhdmVyc2FsIHBh
dGggdG8gdXNlIGVoY2lfZ2V0X2Rlc2NfYWRkcigpIHdoZW4NCj4gPiBmb2xsb3dpbmcgbGluayBw
b2ludGVycy4NCj4gPg0KPiA+IEFwcGVuZGl4IEIgYWxzbyBkZWZpbmVzIGhpZ2ggZHdvcmQgZmll
bGRzIGZvciBzaVREIGJ1ZmZlciBwb2ludGVycy4NCj4gPiBBZGQgYnVmcHRyX2hpW10gZmllbGRz
IHRvIEVIQ0lzaXRkIGFuZCB1c2UgZWhjaV9nZXRfYnVmX2FkZHIoKSB0bw0KPiA+IGNvbnN0cnVj
dCBmdWxsIDY0LWJpdCBidWZmZXIgYWRkcmVzc2VzIGZyb20gYnVmcHRyW10gYW5kIGJ1ZnB0cl9o
aVtdDQo+ID4gd2hlbiBwcm9jZXNzaW5nIHNwbGl0IGlzb2Nocm9ub3VzIHRyYW5zZmVycy4gVGhp
cyBhbGxvd3MgYnVmZmVycyBhYm92ZQ0KPiA+IDRHQiB0byBiZSBoYW5kbGVkIGNvcnJlY3RseS4N
Cj4gPg0KPiA+IFdoZW4gNjQtYml0IGNhcGFiaWxpdHkgaXMgZGlzYWJsZWQsIGRlc2NyaXB0b3Ig
YW5kIGJ1ZmZlciBhZGRyZXNzZXMNCj4gPiByZW1haW4gMzItYml0IGFuZCBleGlzdGluZyBiZWhh
dmlvdXIgaXMgdW5jaGFuZ2VkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmFtaW4gTGluIDxq
YW1pbl9saW5AYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICBody91c2IvaGNkLWVoY2ku
aCB8IDEgKw0KPiA+ICAgaHcvdXNiL2hjZC1laGNpLmMgfCAyICstDQo+ID4gICAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L3VzYi9oY2QtZWhjaS5oIGIvaHcvdXNiL2hjZC1laGNpLmggaW5kZXgNCj4gPiBhZjhj
MDgwYzYwLi42NDA2ZjUzNmU4IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3VzYi9oY2QtZWhjaS5oDQo+
ID4gKysrIGIvaHcvdXNiL2hjZC1laGNpLmgNCj4gPiBAQCAtMTA5LDYgKzEwOSw3IEBAIHR5cGVk
ZWYgc3RydWN0IEVIQ0lzaXRkIHsNCj4gPiAgICNkZWZpbmUgU0lURF9CVUZQVFJfVENOVF9NQVNL
ICAgICAgICAgMHgwMDAwMDAwNw0KPiA+DQo+ID4gICAgICAgdWludDMyX3QgYmFja3B0cjsgICAg
ICAgICAgICAgICAgIC8qIFN0YW5kYXJkIG5leHQgbGluayBwb2ludGVyDQo+ICovDQo+ID4gKyAg
ICB1aW50MzJfdCBidWZwdHJfaGlbMl07DQo+IA0KPiBOb3QgdXNlZD8NCj4gDQoNClRoYW5rcyBm
b3IgdGhlIHJldmlldy4NClllcywgYnVmcHRyX2hpIGlzIG5vdCB1c2VkIGZvciBzaVRELiBJIHdp
bGwgcmVtb3ZlIGl0Lg0KDQpUaGFua3MsDQpKYW1pbg0KDQo+ID4gICB9IEVIQ0lzaXRkOw0KPiA+
DQo+ID4gICAvKg0KPiA+IGRpZmYgLS1naXQgYS9ody91c2IvaGNkLWVoY2kuYyBiL2h3L3VzYi9o
Y2QtZWhjaS5jIGluZGV4DQo+ID4gM2RiMWMyNWU0ZC4uZTFkNWVjYmFkNyAxMDA2NDQNCj4gPiAt
LS0gYS9ody91c2IvaGNkLWVoY2kuYw0KPiA+ICsrKyBiL2h3L3VzYi9oY2QtZWhjaS5jDQo+ID4g
QEAgLTE3OTEsNyArMTc5MSw3IEBAIHN0YXRpYyBpbnQgZWhjaV9zdGF0ZV9mZXRjaHNpdGQoRUhD
SVN0YXRlICplaGNpLCBpbnQNCj4gYXN5bmMpDQo+ID4gICAgICAgICAgIHdhcm5fcmVwb3J0KCJT
a2lwcGluZyBhY3RpdmUgc2lURCIpOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+IC0gICAgZWhjaV9z
ZXRfZmV0Y2hfYWRkcihlaGNpLCBhc3luYywgc2l0ZC5uZXh0KTsNCj4gPiArICAgIGVoY2lfc2V0
X2ZldGNoX2FkZHIoZWhjaSwgYXN5bmMsIGVoY2lfZ2V0X2Rlc2NfYWRkcihlaGNpLA0KPiA+ICsg
c2l0ZC5uZXh0KSk7DQo+ID4gICAgICAgZWhjaV9zZXRfc3RhdGUoZWhjaSwgYXN5bmMsIEVTVF9G
RVRDSEVOVFJZKTsNCj4gPiAgICAgICByZXR1cm4gMTsNCj4gPiAgIH0NCg0K

