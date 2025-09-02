Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03504CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 05:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utJsr-0003h9-TW; Tue, 02 Sep 2025 01:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1utJsi-0003eN-9M; Tue, 02 Sep 2025 01:48:36 -0400
Received: from mail-koreacentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::7] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1utJsf-00027H-94; Tue, 02 Sep 2025 01:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv8ZYaS5fuD6724Ve1NImOSZgPGD3m9XSW5GUDTRvh3b4lUk4GMivFPq/fWNSpptR6uWT2iBy+Q+cXrPVNNkUf/GMeP6d9B7FFGio97++KXlJXqgvWGWb+SRFiHJIs+kgIr5ormkz7SYIj57hobRCnHn3VjfZB1ZNLaW+7Fty1ztmE9Q+uQA3LrkHehjMbKAcG+B2RpgEP+3syIBcfute2WZ4gzfixCI2PTTL/F/DIzfSxBjIs6jVJ/v7fmbBUGk29ALXNJOj1Uw7u3ax8gXPLxx4CueSgqJxWBO7kndHFInylYVjXr4NEMniQgtE6v9Odmk50Wqk97vCndcG4Q4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eoE4+vyMmxcWemNL6OIcZV1DdTTf3oVk4NBRHWMp2M=;
 b=Luag0/ITu8IMec7cFKFAgFvQ05lsOhTdtT1pQgBcD3MrbsGsOSNjcdFUIrwDoP7Bjs/AmMSiV+c2eyj4oGZXi7fyL8YR5J1UCV8bUX6MzVdUYPZ2Y07XkZg4Z6jymmIp78kRog8Oh6PKmvViA3JbyNFGIDWbyoATsYoaOAjgKjpie2FR57PWQnyWaeNU1n/RAREdqMxp8PleuOx060ifPai7n/LDpMop+0xtm52i/rxlaqtmENnNVPpKKfoHorWR9Gux27g72LagicT5X8vtdtC3p2tbsW09+DgIY5M2uj/TezAHdCewFg7mjPt9Z2I++CqYp2BvXniCsMM7p93fVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eoE4+vyMmxcWemNL6OIcZV1DdTTf3oVk4NBRHWMp2M=;
 b=KIDT81ItYvcvtw2TlpiQxrdULKHhp5p8zpVRTPRj+y4cWfiGCKNM64o3CE8TgX0vzOtzp0lyxXTo6iWsye7bID5wfpQDmwmr4x0Sa8Yqjchw8RgkoEjwspvwxxkiwro/Qf8yqM6dXclzifLclaCNjwJGu/b4H3EatiOE3PxB2Af53DnJMnpgmb4xl0hjfBPCakx00N1DPEyqIym/jQE5g2Pfhqb/ZZ8UE5H/RVF8McQvR/smn2wSNAjQwRsi7QxuXz7QhPI1KjmRNXdenXaL4UXr1rr0yonNvwp1o7UDfU9ieFXfXX4ATMA4wEDcu/lK9n0+qKyD1Uo9MZimyeeUyQ==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by KL1PR06MB6577.apcprd06.prod.outlook.com (2603:1096:820:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 05:48:22 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::602a:6372:fff6:feca%4]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 05:48:22 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [SPAM] [PATCH v5 09/10] tests/function/aspeed: Add OTP functional
 test
Thread-Topic: [SPAM] [PATCH v5 09/10] tests/function/aspeed: Add OTP
 functional test
Thread-Index: AQHcC20h6rtDSBY2F0+ufCW2oTDe8rR/gZuAgAAAy/A=
Date: Tue, 2 Sep 2025 05:48:22 +0000
Message-ID: <SI6PR06MB763148A27465179BFA3DFEF8F706A@SI6PR06MB7631.apcprd06.prod.outlook.com>
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
 <20250812094011.2617526-10-kane_chen@aspeedtech.com>
 <824761eb-2994-4065-bc11-1dfa326839f0@kaod.org>
In-Reply-To: <824761eb-2994-4065-bc11-1dfa326839f0@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|KL1PR06MB6577:EE_
x-ms-office365-filtering-correlation-id: 4d185876-8b5e-4802-df4f-08dde9e453bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?ZVV5dWZ2aUxyckJWbXZDT2RwaEhtRzB2dTlwclk3bnNrV2MwYXVwSlltcVAw?=
 =?utf-8?B?U1B1WWFkUnRIZ0VUbTNBeE5WalBUck04Tk9GVGpickJMK1VRMWNKK0kwRFJr?=
 =?utf-8?B?OXhmRFpsdy90aHF4Y3RraFRNTTdDRHJMVDFCVlpkZGRHSUJFSlBLMEpiWEJv?=
 =?utf-8?B?cDExS0JQeUtKdmNQSHFEVnBkd245elZVYlVicDVzVjFwMitRMnc5aktPQng2?=
 =?utf-8?B?SlRBanV3UEFsSDB4VTJLZUJhNk1LU1gxZ1dGTEJrQkc2R053QkNxTWxVVmR3?=
 =?utf-8?B?QzIvb3Y2MkxrTDJ0a01uTXVFNDl3K09mK3RLNk1tNzY0NFhsQ1FvNG1obDlr?=
 =?utf-8?B?ZEZ1ZnRER29RZ0huLzFXdDh3eUcybEU3TmhqRXVod2psMmFJbVA3UGR4bE9J?=
 =?utf-8?B?eXIxOGdZbjdjaHdDeHpLUUYvZG5DVm1Za1pBeTI4bVM2TjBQb3pkSDcxYUpm?=
 =?utf-8?B?QU8wbThEZlFQSjB4UDA3bGNiTytGYXNNV2tDclFlTnBYUTdKSXJCK0I5b3Vo?=
 =?utf-8?B?M2UzMkdMaDNsKzl5bWg5aWNaa251OTllcURVQ1lkby82YWRaOUFkZFlnMEdT?=
 =?utf-8?B?OVlway9CSlkwbS95bDFTeGhwNnlodGgxZGRZcWZQRVcwaVFnSS9QYnR5bXEx?=
 =?utf-8?B?S2NMaktoUERhTUlqbWF0eDFUc3hNQnYxazRQUlVzdEoxbFVzWkpERkp0bjdO?=
 =?utf-8?B?U1FJYUxxUStWdGx0UHd1UWhLZ25oMzdnbVJ1UjNMY0p1MDBEUHprakFTdDl5?=
 =?utf-8?B?enk4aHhnWFpWeTRMd2k3TGR4VjVzeVM1TGhVbVBSQW5mc1ZxbGR0OW9Mdi9L?=
 =?utf-8?B?d0lacVd4b3MvY2N1aUZNc2xEVHYvaVc3RFVoZDA4aW10enB2TGtsb24rU2VD?=
 =?utf-8?B?QnUvRjZrTjRTWlF4ZkJNSWQ5UnNRKzlmUDBtNVhib1pWZ2VwUER0UzgyM3Rs?=
 =?utf-8?B?SWsyVG5rZ1hZMzhoNkM3RzdWcFdocXh6anhTbFpEQ3JNRk0za254R0ZXOHRR?=
 =?utf-8?B?dWo1MHpEM0ZYTkExM2NUZXFtNVpvRjJGTFJjNGlsTHFRck5rN21iQ2Z5Sjc0?=
 =?utf-8?B?Zno3SVdnbC9ES0JKcEJsSjlnWUE1bGd5ODlaeDJpRVhqMzhmbmZ3emM4Tjg5?=
 =?utf-8?B?eHIwcDVXL0Q4Y1pUcjBINzBWOCswOExDQWNTdmdOZ3NtR0xHa0hYcnpHeEVT?=
 =?utf-8?B?a3A4bEFmRW1ZU3pyZjh4TUYzTzlIUndqWnMwb3RsTnFhT0R4UU1jeHMwbmNT?=
 =?utf-8?B?d3RxSWJiLy9xT014T1ZaUkFQOTJmMHl4UUhFS3VrbjhHWFZtTlBzYjluL21G?=
 =?utf-8?B?bWdaK0FDaXpWbDJkcFp2anhuTWt1Q3RCa08vaEd0Rmk5RGFTN2owRnd5c3NK?=
 =?utf-8?B?YkFXQWhvai8rY0FDNXZVa2g3UDR4RlVPL0Zzb2NyQUllbHJMT3lINnJ1NC8x?=
 =?utf-8?B?ZHhqS0pwa3UybXpzelNiZmxjdHl3MWlnOGx6OHRKNjhHZHg0UGVwREt1OERv?=
 =?utf-8?B?Wk4weVVQL01IbjViZmJkMk82aXdMSUdpUHhqUDRtNjdBSDJxZEg4bk04SFcw?=
 =?utf-8?B?dzZ5bzBpZ0FJNnZXVmYrZ3ZwYnJOdXhKQTcyejB5TVRDZFJzdFc3NU5xejZF?=
 =?utf-8?B?MHdGM2Z3RzJqY0pTVEtvcSsxbDJCN0dMYTNzbWlyZGlUeXowb3BTM3Z0QmRV?=
 =?utf-8?B?WUVadXNvSlVRM25IZVVjMXhkL1c2UjE0QVllRzRnSm83RDkxSGNQNHErd2hF?=
 =?utf-8?B?SE8wdURBNktnc29yaW9vRmh1QWljWDNiVzAvRHNLajhhSkM2ditnaENsMG4z?=
 =?utf-8?B?NFZQRGN5czE5MlJlemRQMGw1L3JSTm9BdWs0bllvNkdrRWxEd1lidXBLS090?=
 =?utf-8?B?M3grTG1kcTRHd25tcVhxa1FTaVErT2NiMmtlWnk3Y1RTaDV3UlpuM1JrZEpk?=
 =?utf-8?B?SWx6T1RDaUVNWm1xVG1iVHN0VmZRQ1RjKzFVcFpWTStDRjRkZ1BQQm5keS9h?=
 =?utf-8?B?ajZ3ZFhqUTBJNXNRVGpvd0lqdmMrSk0rUDhWNnBRNE9JdkZnQWUzNG4xWTdW?=
 =?utf-8?B?OFVVOGN2S3NWVGhuTWpQS2FzVmFvemkvSGJvdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlVieUcwRE9kM3V4WFQvaEVrWjNwSmVWa3k1MjR6TXBBUk0wbEp1dzl3V0Nh?=
 =?utf-8?B?VCsySUVCcFVCMWY1VTBpdHY2ZW5tdkRDK3FwM2R6MkVLZTRlWnhTZklOUnlY?=
 =?utf-8?B?M1JkdVFIM3pxdVBCNDVId1gzMUJicVVVSHBtVFMvOVlvVFRaQjBiVDdNcXNE?=
 =?utf-8?B?dHVOenNvWUlRTmJVMCs5YVRxVUVDbXBFU2hLQnhNWStHeHVhSHNoaXR6Umgz?=
 =?utf-8?B?WUZpK2JDL09Na0NmS21iTVRuUThTQllXMkUrZTltOVY1SlRBWTFkYjYvRzI5?=
 =?utf-8?B?cTF1RituN1FTRXN4UjBEdlREZDlWdENWYzdLakJvNlZKRUJ4cnpFZURGM1dK?=
 =?utf-8?B?b0o0TGViSk9jR0t2Tngwb25od1VlNHE1SE43UjZIVTJrdFlSN3Q0T0JQVUV2?=
 =?utf-8?B?S2NWVEwwRkJQcEpaRisrWi9iMkx6ZUpkQTFHWm5TU05tL1RkM1VVb0RyZ1d6?=
 =?utf-8?B?N1FWcEhpRDFqaXlSZEhkV0NLZis3MmVFeXZxRExCTmlKSGlSMUJ0UmFzOXFh?=
 =?utf-8?B?QlpCWVpUUE8wNkNKN2pVTUVObU56NkpjYTF2TFM5clVBYjNCWXpDRGVBSFFS?=
 =?utf-8?B?VXAwZGt0a3hIQ0UzQWx0ZFdlZFBrZnBYS2I5WEFiMHNMbDJzZlFyTGhyWGNM?=
 =?utf-8?B?R0tZQVhZdWcrOW5RUmNtL0tWSEhqanlSY1VsUjh2dUVpajZ6SkxiYmViMHpq?=
 =?utf-8?B?MnJTaGJmVW83SlEvbFNUZm5vSFVvaCszaWdrMWVSdGZZQWlOUFNpMGVZT3NL?=
 =?utf-8?B?MXBrODBIOHp2N3Q5cmhidHV3cXM4WnkxVFAwa0grVFptVTA1eTlTbk9mbmtU?=
 =?utf-8?B?L3hISzlnTDI1QWFXbEYzay9qN2lrK1RZK1dCZGtPaWNZL0cwUllkdTcxNWJB?=
 =?utf-8?B?VjJvZFVQY3JETUpWWEhza3JSd2NKbWlyZFhObFhGckx0NDUzM0J1YUZCYVFu?=
 =?utf-8?B?VWZ3cDJldHRlTlFFcFQzZFZuR1FwTzVyRG94VDZXZU12SmxFcWdzN3lxTjkv?=
 =?utf-8?B?Rmh0Vy9uRlBCeDV5ZUlNRUcwQXpqV21aQ3VLaG1XRDd2QzdCVTVTVnRLMzk1?=
 =?utf-8?B?SHh4ZWVmR1NjcEIyU2hWdTlleFlkcU92MWlhb0lOYlR5N052VlpQQUtPSUx6?=
 =?utf-8?B?ODJ6c0tOZytJVExad05TRmloTnFSQjZwMEtPeEJTUXNOWkxJcVNoQzQraU9D?=
 =?utf-8?B?bmtpWEs2S0QveXFLcDhCNTZmN21uY01udW9qTTRDTGZPS3lxRm9Nb3hra3hH?=
 =?utf-8?B?aGRqSi9YVjFMYlIzMUpPS0VlWnRHalJyRUlKWmpyVjlSL0xJSW5mODM3Nm04?=
 =?utf-8?B?T01hYVZHbEhpdnRhbFBmVWxNMS9qR3o2NTkycVJUb01VdXgvYzZ2UFhKbTVB?=
 =?utf-8?B?NmRERmlldzcrWE9RbjR1TTRySUlXbmZMaktDeG1xU2x0VjVIcno0SGI1WjFD?=
 =?utf-8?B?bTZSdGovcDdUSElxRGp5Z283U0JiZU92djNEdWlPU0VnRjRDN0tIRWhPajFq?=
 =?utf-8?B?UXpqNVNaZVVNeWFPZHFIRU05enpISUtIQ3hMY2M3eSs3VDRCK05HTnZ3Ymgy?=
 =?utf-8?B?R2I1UVJhamR1cUVrWld2eWVsVDh2cGNIVWNMOTNjSG1NWHN0dFhrWDJiLzc5?=
 =?utf-8?B?YUt0Ym0xa0V6TjlWOUI4RjJWR0tDU2RBR2JLeHFuTC9kMytjd241SmpVblB5?=
 =?utf-8?B?NVJtN2Y5eDJOVFZ5Vk5OdDFvbnRUdnNOSjYwRStHQTltTzQwNnl4NXUxdzV5?=
 =?utf-8?B?VXZ0c3BvdCtuS2ZLOW04MW5LV3R1cmQzc2J1RjlRQ1VzTmgyRkZkeVhnQkNH?=
 =?utf-8?B?cDQ0VmJKOGYwSkIxbW5EOHQ2VUhFZlhrZEJ4WS9PT0lRMEVlUThwOU9zRmpN?=
 =?utf-8?B?bG04dXlRKzR6c2M1NFlJL0t3LzBSb3dJdlVtK3lLY0V6VG1RaHJxbEhCYm15?=
 =?utf-8?B?UzFWcjVLTFJSR2YrR1ZpZGlGcDBSeVhtSjV2TkV4RFk4YXdKQmlzT1laK2FL?=
 =?utf-8?B?RmIrSEtRUHgwMmNTdmhNdW02QnBETmVLWm1OcCtnUFJ3cjZSZjVXVnFwWGRU?=
 =?utf-8?B?QTgyenpGK1Jranl0TkVEN2Z5c3JIclpjb1hhZ0Z3djIvazdTNEtoRDFzeTZV?=
 =?utf-8?Q?T1E42L0NjEVVFKuN3YDgcW72I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d185876-8b5e-4802-df4f-08dde9e453bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 05:48:22.2576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQQrxBoCPJspB9fkzHnG5BADtHkiJ3EIHBbkujcKvVdqPKOQJ3tbIUaa9Xz0CIP3CCXfnvIkuDb+OirmGkUwpNJB2PuEKg3jzn15QFPv+ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6577
Received-SPF: pass client-ip=2a01:111:f403:c40f::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

SGkgQ8OpZHJpYywNCg0KTWFueSB0aGFua3MgZm9yIHJldmlld2luZy4gSSB3aWxsIHJldmlzZSB0
aGUgdGVzdCBzY3JpcHQgYXMgc3VnZ2VzdGVkIGFuZCByZXN1Ym1pdCB0aGUgcGF0Y2guDQoNCkJl
c3QgcmVnYXJkcywNCkthbmUNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
Q8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVt
YmVyIDIsIDIwMjUgMTo0MSBQTQ0KPiBUbzogS2FuZSBDaGVuIDxrYW5lX2NoZW5AYXNwZWVkdGVj
aC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBTdGV2
ZW4gTGVlIDxzdGV2ZW5fbGVlQGFzcGVlZHRlY2guY29tPjsgVHJveQ0KPiBMZWUgPGxlZXRyb3lA
Z21haWwuY29tPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBBbmRyZXcN
Cj4gSmVmZmVyeSA8YW5kcmV3QGNvZGVjb25zdHJ1Y3QuY29tLmF1PjsgSm9lbCBTdGFubGV5IDxq
b2VsQGptcy5pZC5hdT47DQo+IG9wZW4gbGlzdDpBU1BFRUQgQk1DcyA8cWVtdS1hcm1Abm9uZ251
Lm9yZz47IG9wZW4gbGlzdDpBbGwgcGF0Y2hlcyBDQw0KPiBoZXJlIDxxZW11LWRldmVsQG5vbmdu
dS5vcmc+OyBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT4NCj4gQ2M6IFRyb3kgTGVlIDx0
cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtTUEFNXSBbUEFUQ0ggdjUg
MDkvMTBdIHRlc3RzL2Z1bmN0aW9uL2FzcGVlZDogQWRkIE9UUA0KPiBmdW5jdGlvbmFsIHRlc3QN
Cj4gDQo+IEhlbGxvIEthbmUsDQo+IA0KPiArIFRob21hcw0KPiANCj4gT24gOC8xMi8yNSAxMTo0
MCwgS2FuZSBDaGVuIHdyb3RlOg0KPiA+IEZyb206IEthbmUtQ2hlbi1BUyA8a2FuZV9jaGVuQGFz
cGVlZHRlY2guY29tPg0KPiA+DQo+ID4gT24gYm9vdCwgdGhlIFNvQyBmaXJtd2FyZSByZWFkcyBk
YXRhIGZyb20gdGhlIE9UUCByZWdpb24gdG8gb2J0YWluIHRoZQ0KPiA+IGNoaXAgSUQgYW5kIGRl
ZmF1bHQgc2V0dGluZ3MuIFRoaXMgY2hhbmdlIGFkZHMgdGVzdCBjYXNlcyB0byB2ZXJpZnkNCj4g
PiB0aGF0IHRoZSBmaXJtd2FyZSBjYW4gYm9vdCBjb3JyZWN0bHkgd2l0aCBhIHByZS1jb25maWd1
cmVkIE9UUCBpbWFnZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEthbmUtQ2hlbi1BUyA8a2Fu
ZV9jaGVuQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC9t
ZXNvbi5idWlsZCAgICAgICAgICAgIHwgIDIgKw0KPiA+ICAgdGVzdHMvZnVuY3Rpb25hbC90ZXN0
X2FybV9hc3BlZWRfb3RwLnB5IHwgNTUNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdHMvZnVuY3Rpb25hbC90ZXN0X2FybV9hc3BlZWRfb3RwLnB5DQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZA0KPiA+IGIvdGVzdHMvZnVu
Y3Rpb25hbC9tZXNvbi5idWlsZCBpbmRleCAzMTFjNmYxODA2Li5jNzMxYjc3OWRkIDEwMDY0NA0K
PiA+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvbWVzb24uYnVpbGQNCj4gPiArKysgYi90ZXN0cy9m
dW5jdGlvbmFsL21lc29uLmJ1aWxkDQo+ID4gQEAgLTM0LDYgKzM0LDcgQEAgdGVzdF90aW1lb3V0
cyA9IHsNCj4gPiAgICAgJ2FybV9hc3BlZWRfYmxldGNobGV5JyA6IDQ4MCwNCj4gPiAgICAgJ2Fy
bV9hc3BlZWRfY2F0YWxpbmEnIDogNDgwLA0KPiA+ICAgICAnYXJtX2FzcGVlZF9nYjIwMG52bF9i
bWMnIDogNDgwLA0KPiA+ICsgICdhcm1fYXNwZWVkX290cCc6IDEyMDAsDQo+ID4gICAgICdhcm1f
YXNwZWVkX3JhaW5pZXInIDogNDgwLA0KPiA+ICAgICAnYXJtX2JwaW0ydScgOiA1MDAsDQo+ID4g
ICAgICdhcm1fY29sbGllJyA6IDE4MCwNCj4gPiBAQCAtMTMyLDYgKzEzMyw3IEBAIHRlc3RzX2Fy
bV9zeXN0ZW1fdGhvcm91Z2ggPSBbDQo+ID4gICAgICdhcm1fYXNwZWVkX2JsZXRjaGxleScsDQo+
ID4gICAgICdhcm1fYXNwZWVkX2NhdGFsaW5hJywNCj4gPiAgICAgJ2FybV9hc3BlZWRfZ2IyMDBu
dmxfYm1jJywNCj4gPiArICAnYXJtX2FzcGVlZF9vdHAnLA0KPiA+ICAgICAnYXJtX2FzcGVlZF9y
YWluaWVyJywNCj4gPiAgICAgJ2FybV9icGltMnUnLA0KPiA+ICAgICAnYXJtX2Nhbm9uYTExMDAn
LA0KPiA+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfYXJtX2FzcGVlZF9vdHAu
cHkNCj4gPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hcm1fYXNwZWVkX290cC5weQ0KPiANCj4g
VGhlIHRlc3RzL2Z1bmN0aW9uYWwgZGlyZWN0b3J5IHdhcyByZWNlbnRseSByZW9yZ2FuaXplZC4N
Cj4gDQo+IEFsc28sIEkgdGhpbmsgSSB3b3VsZCBwcmVmZXIgdGhlIG5ldyBvdHAgdGVzdCB0byBi
ZSBwYXJ0IG9mIHRoZSBleGlzdGluZyB0ZXN0IGZpbGVzIDoNCj4gDQo+ICAgIHRlc3RzL2Z1bmN0
aW9uYWwvYXJtL3Rlc3RfYXNwZWVkX2FzdDEwMzAucHkNCj4gICAgdGVzdHMvZnVuY3Rpb25hbC9h
cm0vdGVzdF9hc3BlZWRfYXN0MjYwMC5weQ0KPiANCj4gU29tZXRoaW5nIHRvIGRpc2N1c3Mgc2lu
Y2UgdGVzdF9hc3BlZWRfYXN0MjYwMC5weSBpcyByYXRoZXIgYmlnLg0KPiANCj4gDQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwLi40OGM3Y2FkM2YzDQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL3Rlc3RzL2Z1bmN0aW9uYWwvdGVzdF9hcm1fYXNwZWVk
X290cC5weQ0KPiA+IEBAIC0wLDAgKzEsNTUgQEANCj4gPiAraW1wb3J0IG9zDQo+ID4gK2ltcG9y
dCB0aW1lDQo+ID4gK2ltcG9ydCB0ZW1wZmlsZQ0KPiA+ICtpbXBvcnQgc3VicHJvY2Vzcw0KPiA+
ICsNCj4gPiArZnJvbSBxZW11X3Rlc3QgaW1wb3J0IExpbnV4S2VybmVsVGVzdCwgQXNzZXQ+ICtm
cm9tIGFzcGVlZCBpbXBvcnQNCj4gPiArQXNwZWVkVGVzdCBmcm9tIHFlbXVfdGVzdCBpbXBvcnQg
ZXhlY19jb21tYW5kX2FuZF93YWl0X2Zvcl9wYXR0ZXJuLA0KPiA+ICtza2lwSWZNaXNzaW5nQ29t
bWFuZHMNCj4gPiArDQo+IA0KPiBQbGVhc2UgYWRkIGFuIGV4dHJhIGJsYW5rIGxpbmUNCj4gDQo+
ID4gK2NsYXNzIEFzcGVlZE90cE1lbW9yeVRlc3QoQXNwZWVkVGVzdCk6DQo+ID4gKyAgICAjIEFT
VDI2MDAgU0RLIGltYWdlDQo+ID4gKyAgICBBU1NFVF9TREtfVjkwN19BU1QyNjAwID0gQXNzZXQo
DQo+ID4gKw0KPiAnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRlY2gtQk1DL29wZW5ibWMvcmVs
ZWFzZXMvZG93bmxvYWQvdjA5LjA3L2ENCj4gc3QyNjAwLWRlZmF1bHQtb2JtYy50YXIuZ3onLA0K
PiA+ICsNCj4gPg0KPiArJ2NiNmMwODU5NWJjYmJhMTY3MmNlNzE2YjA2OGJhNGU0OGVkYTFlZDlh
YmU3OGEwN2IzMDM5MmJhMjI3OGZlDQo+IGJhJykNCj4gDQo+IFBsZWFzZSB1cGRhdGUgZmlyc3Qg
YWxsIGZ1bmN0aW9uYWwgdGVzdHMgd2l0aCB0aGUgbmV3IFNESyB2OS4wNyBpbWFnZXMuDQo+IA0K
PiA+ICsNCj4gPiArICAgICMgQVNUMTAzMCBaZXBoeXIgaW1hZ2UNCj4gPiArICAgIEFTU0VUX1pF
UEhZUl8zXzAyID0gQXNzZXQoDQo+ID4gKw0KPiAnaHR0cHM6Ly9naXRodWIuY29tL0FzcGVlZFRl
Y2gtQk1DL3plcGh5ci9yZWxlYXNlcy9kb3dubG9hZC92MDAuMDMuMDIvDQo+IGFzdDEwMzAtZXZi
LWRlbW8uemlwJywNCj4gPiArDQo+ID4gKw0KPiAnMWVjODNjYWFiM2RkZDVkMDk0ODE3NzI4MDFi
ZTcyMTBlMjIyY2IwMTVjZTIyZWM2ZmZmYjhhNzY5NTZkY2Q0ZicNCj4gKQ0KPiANCj4gU2FtZSBm
b3IgWmVwaHlyIGltYWdlcw0KPiANCj4gPiArDQo+ID4gKyAgICBkZWYgZ2VuZXJhdGVfb3RwbWVt
X2ltYWdlKHNlbGYpOg0KPiA+ICsgICAgICAgIHBhdGggPSBzZWxmLnNjcmF0Y2hfZmlsZSgib3Rw
bWVtLmltZyIpDQo+ID4gKyAgICAgICAgcGF0dGVybiA9IGInXHgwMFx4MDBceDAwXHgwMFx4ZmZc
eGZmXHhmZlx4ZmYnICogKDE2ICogMTAyNCAvLyA4KQ0KPiA+ICsgICAgICAgIHdpdGggb3Blbihw
YXRoLCAid2IiKSBhcyBmOg0KPiA+ICsgICAgICAgICAgICBmLndyaXRlKHBhdHRlcm4pDQo+ID4g
KyAgICAgICAgcmV0dXJuIHBhdGgNCj4gPiArDQo+ID4gKyAgICBkZWYgdGVzdF9hc3QyNjAwX290
cF9ibG9ja2Rldl9kZXZpY2Uoc2VsZik6DQo+ID4gKyAgICAgICAgaW1hZ2VfcGF0aCA9DQo+IHNl
bGYuYXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfU0RLX1Y5MDdfQVNUMjYwMCkNCj4gPiArICAg
ICAgICBvdHBfaW1nID0gc2VsZi5nZW5lcmF0ZV9vdHBtZW1faW1hZ2UoKQ0KPiA+ICsgICAgICAg
IHNlbGYudm0uc2V0X21hY2hpbmUoImFzdDI2MDAtZXZiIikNCj4gDQo+IFBsZWFzZSBtb3ZlIHNl
bGYudm0uc2V0X21hY2hpbmUoKSBhdCB0aGUgdG9wIG9mIHRoZSByb3V0aW5lLg0KPiANCj4gDQo+
IFRoYW5rcywNCj4gDQo+IEMuDQo+IA0KPiANCj4gDQo+ID4gKyAgICAgICAgc2VsZi52bS5zZXRf
Y29uc29sZSgpDQo+ID4gKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygNCj4gPiArICAgICAgICAg
ICAgIi1ibG9ja2RldiIsDQo+IGYiZHJpdmVyPWZpbGUsZmlsZW5hbWU9e290cF9pbWd9LG5vZGUt
bmFtZT1vdHAiLA0KPiA+ICsgICAgICAgICAgICAiLWdsb2JhbCIsICJhc3BlZWQtb3RwLmRyaXZl
PW90cCIsDQo+ID4gKyAgICAgICAgKQ0KPiA+ICsNCj4gc2VsZi5kb190ZXN0X2FybV9hc3BlZWRf
c2RrX3N0YXJ0KHNlbGYuc2NyYXRjaF9maWxlKCJhc3QyNjAwLWRlZmF1bHQiLA0KPiAiaW1hZ2Ut
Ym1jIikpDQo+ID4gKyAgICAgICAgc2VsZi53YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oImFzdDI2
MDAtZGVmYXVsdCBsb2dpbjoiKQ0KPiA+ICsNCj4gPiArICAgIGRlZiB0ZXN0X2FzdDEwMzBfb3Rw
X2Jsb2NrZGV2X2RldmljZShzZWxmKToNCj4gPiArICAgICAgICBrZXJuZWxfbmFtZSA9ICJhc3Qx
MDMwLWV2Yi1kZW1vLTMvemVwaHlyLmVsZiINCj4gPiArICAgICAgICBrZXJuZWxfZmlsZSA9IHNl
bGYuYXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfWkVQSFlSXzNfMDIsDQo+IG1lbWJlcj1rZXJu
ZWxfbmFtZSkNCj4gPiArICAgICAgICBvdHBfaW1nID0gc2VsZi5nZW5lcmF0ZV9vdHBtZW1faW1h
Z2UoKQ0KPiA+ICsgICAgICAgIHNlbGYudm0uc2V0X21hY2hpbmUoImFzdDEwMzAtZXZiIikNCj4g
PiArICAgICAgICBzZWxmLnZtLnNldF9jb25zb2xlKCkNCj4gPiArICAgICAgICBzZWxmLnZtLmFk
ZF9hcmdzKA0KPiA+ICsgICAgICAgICAgICAiLWtlcm5lbCIsIGtlcm5lbF9maWxlLA0KPiA+ICsg
ICAgICAgICAgICAiLWJsb2NrZGV2IiwNCj4gZiJkcml2ZXI9ZmlsZSxmaWxlbmFtZT17b3RwX2lt
Z30sbm9kZS1uYW1lPW90cCIsDQo+ID4gKyAgICAgICAgICAgICItZ2xvYmFsIiwgImFzcGVlZC1v
dHAuZHJpdmU9b3RwIiwNCj4gPiArICAgICAgICApDQo+ID4gKyAgICAgICAgc2VsZi52bS5sYXVu
Y2goKQ0KPiA+ICsgICAgICAgIHNlbGYud2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKCJCb290aW5n
IFplcGh5ciBPUyIpDQo+ID4gKw0KPiA+ICtpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOg0KPiA+
ICsgICAgQXNwZWVkVGVzdC5tYWluKCkNCg0K

