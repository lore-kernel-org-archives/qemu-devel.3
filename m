Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59392D1714E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 01:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t33tO-0003c6-Vt; Mon, 21 Oct 2024 21:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t33tN-0003bj-9O; Mon, 21 Oct 2024 21:41:01 -0400
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t33tL-0006om-Dn; Mon, 21 Oct 2024 21:41:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHfv9t1/0oHToM1WY3hisgGq+NmTUdkAJp06HCC3DcrvwQfZM0abTjWbu1/6q+L8YgSD4rSO11M8vORMFkcF3QLZydtXcQtN5Lg+t1x3O+aLCVB5nH1NHjVm84i+GOfLfcC46N9fVGjl4odGbkVGe8cqhFVqaUhe/e2E/r3+pksI6m2JYX5oW+yfmaNTQSevO3iXknhJrvW83c1QfnP0/KqH32PwOPUhXopVEIr1yM2bRPHErvBkfe/YIf9AAyzFYXtIiYGGhRFWwmTWB9q7VxXkjKk3kMst7enUAoOsL5RZiSSw1jqLtNgEaWkCRhCAy9TtX0uOsuIfqX5++/4Hrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ijO7K+iPZiXcDCvcnWq6pfchmSV8m35kJwSQOg6/hQ=;
 b=mb9n2gFXRq0zQKHOub/Xo2HS8s2qJttLSwlX1MJwXmStwlixbgIUnlL/a3ODyVy+96Yd+ijcNJRC1Zqt2d7ClxqOlu5cMpPtmH5Uope76VnrJ+97o/DxPzqjlQgNU0eqQqUcQONqxX17K32oZFrSlpQ2EuEM0nNu5g2V7sbxG/nbECLW8KvVPqym4YAn7WNZqDEYIQ/9l2NiMoD9oY/1REdCbiVx2RLSwZQ+PVI48Qf85wv1pnZ/xcv0D3YZMv3WnhnKC74adUneIlLsxk1e4tsZ93A9dpdDjP+Yo6Xjxi5Cm343bcaZ30+2W+egQt8R4V5lAK7qwZ8lTGNdJbU32A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ijO7K+iPZiXcDCvcnWq6pfchmSV8m35kJwSQOg6/hQ=;
 b=ZpzX1LaI6vCT5oKiGcYyAXP2pL0RmuJZTgdZ26lCU4rWbjgUxYgyMqIRelK5t/t/VzBK1qiLpXNK4u3EMX4VdxuIHlOqtFLtUeeja5kMatw1+hmmL0oDj3e+/uVvM0fqLC9Cp2mepwcpLyTcAf7z7LRToapIG2wbkWcpQvzyFgQR8t2fqI3HuFdo2pUw4VJ3AUcRl6pUpp5RF7hj3Ix3paP+ZDh+adlU7O0qDn+fbDkM618nn8J1XJoGYryOaRste9Zkqq5wl5LWxiRSe8BAPcnwwAG6oioneAJDnTwtp3SKRMRpWyD1+ZG87uo7EWLm/RUVjWtMQWNR0/UzxVB8zA==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 TYZPR06MB5370.apcprd06.prod.outlook.com (2603:1096:400:1f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.14; Tue, 22 Oct
 2024 01:40:51 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8093.013; Tue, 22 Oct 2024
 01:40:50 +0000
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
Subject: RE: [SPAM] [PATCH v1 11/16] test/qtest/aspeed_smc-test: Support to
 test all flash models
Thread-Topic: [SPAM] [PATCH v1 11/16] test/qtest/aspeed_smc-test: Support to
 test all flash models
Thread-Index: AQHbIR79Icmd3KnXX0eKCqlWinj/MLKRKkEAgADaImA=
Date: Tue, 22 Oct 2024 01:40:50 +0000
Message-ID: <SI2PR06MB5041D52238A05BFACE9BAEA6FC4C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
 <20241018053112.1886173-12-jamin_lin@aspeedtech.com>
 <777c3650-5e02-4ab0-a900-ecb0e425b935@kaod.org>
In-Reply-To: <777c3650-5e02-4ab0-a900-ecb0e425b935@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|TYZPR06MB5370:EE_
x-ms-office365-filtering-correlation-id: 77a6ea8b-1991-43e9-d237-08dcf23a8f09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020|217643003; 
x-microsoft-antispam-message-info: =?utf-8?B?OXhVVG1LZjN6QVhPb05KdTRJUFUvd2EvbytuTms5OGtrSk56bzlOc0RGcnQz?=
 =?utf-8?B?cFBXa0o2VkF5ZS9CdkNab1k4UWpsVWxxTE1nODNYeFl2bEZEczA2a3QrZFZh?=
 =?utf-8?B?emZISnB0enNLbFM3d2RMby9DWWZ0SVQrMDEzMkhzMUdvVzd3SGJvUzZMd3hY?=
 =?utf-8?B?UFE0UmRRU1oyUk9qS0p5MGxjc1gvQ0QwTlJFRkxTMFFnWXhNUXlOV1BScUNN?=
 =?utf-8?B?U0gvNUFpVi9KRTFaMXdEWGpnWjk5dEN3UGtUc3h0Snd4WW9rQ25DUnVXZ1V2?=
 =?utf-8?B?OVFWMkpJcit1aHErVFRNaXRkaFFVL1NDMS9mcU1CcmdTbktVQW02UmM5QlBv?=
 =?utf-8?B?VVZoL3pBRGphVExFMEREYS9ibnNDR3ZiRUdQT1V0TFgwLzR5ZE5TcWhjSDQr?=
 =?utf-8?B?aXo5SnVuVmpPcXpublEzK09nNDBmWFdLMGtFQUJKL3M4ZFhTL2ljcU9ZYTM5?=
 =?utf-8?B?UUVuK1RMeHl1K1MzTFRNWGRKc0lMUC9aZXp2aFd0ZFJVZzk2eENvNzVTS0dz?=
 =?utf-8?B?M0hDZFF6b0N0MC9WSFZiemtPL3hOVWtQOWxsZHZZNHYvZE1FMHVGSzlMaElq?=
 =?utf-8?B?cHVwTURrWmV3c1pjbUpiSEhWQWJxS3ZocjJsWEowSEd4bWFabUFFK1VzNXdM?=
 =?utf-8?B?VVZKM2hoejVUYnRaNTM1NHF6c1RPeVNFbU5YZjQwV3VyMmVaS0psNFRpdlBR?=
 =?utf-8?B?VDVyeXYvcHJySktDR1BMY0ZVd2ViT1RibElVOEh6SUF4VWI4bm1oV1h0MHVt?=
 =?utf-8?B?NGx1UUVJWktJNldBOTdFN2h3ODNJOXhaMWh0eFgvalZuTUFuNElVd3gybTBW?=
 =?utf-8?B?TmZyVkd3S1dQMmJIRmdkUlB3NXcvekNHWHRUeDBrcnlBN0RLd2NGblBNL2Zl?=
 =?utf-8?B?aHJyeUNkemNFSkdyNkVOS1Fpcks3ZGJaalV4cGZ0YnJjTXlENVcwVDlZeVVu?=
 =?utf-8?B?NkZmNkk2TUZtSFEzUEkyY1RhTXRsQVUvYTcvU3ZwOVhuVllrUEtvRG9oMDFS?=
 =?utf-8?B?RTN3NHU5WklrODFrNkN4K202M3AvZmtUeUtwUTZvOXVIcDFINnRMWkRIQ241?=
 =?utf-8?B?SVVnMGdtS3pCcVlkUzBLVXB0OGRNdmhpSmJkSEwxeHVPTk51TWZiNXZBZzdy?=
 =?utf-8?B?bDBzbGJ0c2dKRDI1TUdncWpxNHVCVFVwWWpzc0ZWS2M1S0wyZGVpdVJqb2lY?=
 =?utf-8?B?TjNmOEpJQ0NHRjh5cWR6NW43OVJVZVhoaGVHNFBHTGJDMHEvUDRGc0k2c2tS?=
 =?utf-8?B?cGJ0WXVyN0kvRGRzSEhFVjJHTXZxblRUMWllN0hWR3VRRVk5WWxlOFdvNFZO?=
 =?utf-8?B?OXhRak5XUjhOTHdEc2FDQndhVkt5Wk9FM3puQlFxNm1uN0gwV3pyOEIrNkVR?=
 =?utf-8?B?SU1OVmptK3Q5Q0tZc2RuN05xVmlHYzA3TTZnbmxleGd4WWNMYy9SMGxLZHpU?=
 =?utf-8?B?RUdEVjlGNE14YURoZ3BiRk1FNm9yNGVPTHVLYUlxK04vYktrSmtSOERUcFA0?=
 =?utf-8?B?QlVEOUJ2bUNnZGF2UTVEajVrZEhSK0R1TDZYcDRZRW05OURLTlc5YWtRa3Nw?=
 =?utf-8?B?aElIZlNnOGdxRzA2WlpxaGZmQmdDaEtyN0YwNGsrOXlhYVE1QUNHanZiRFIv?=
 =?utf-8?B?L0IrVGxSNXFycjdyVmxOQjVGME54MldDQ1JPSGY3ekIxVHdQVS9ibTk5Wkhi?=
 =?utf-8?B?VFdkRDlUNVFoMzNzalMyS3lwbElnOFlRcllOMTI3NzB1KzVlaU91NDVGeVFt?=
 =?utf-8?B?REx4YmRPb3EvRGlySlRMdEg1NTVPZUpzeGE1dWs0a1htVVNoMjZEVlV5SGJU?=
 =?utf-8?B?Q3JOVjVFQXA4SHZxZ1VGTGxBYlBWMzB4TGJmbmJsOVE3ekYxNDEvTHRKbzdn?=
 =?utf-8?B?SExKNjgzQUtHdFN4TzJ4Rm9qTWtWWjA3NERGNFQvelJHU3BSQVp2dE5FUjBQ?=
 =?utf-8?Q?+VPfgl1/JU8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020)(217643003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTRpdHBVcUl6TUIwV3BQRXRmeVFTYVIrZWRUS3FiTXVYU2dHNW5WcUJBbVg3?=
 =?utf-8?B?TFdMN09kSG9NU0hNWm44eWsxMFhlOGtIQWxFLzlmeFJQdUNob05nRUNDQjBY?=
 =?utf-8?B?TGMwWWJZWFVMUVZVQTh0MFZld0F1U3RKZHhWUVlnQlllZERFK2tjaUVEa292?=
 =?utf-8?B?eWRhakJ2WVhPd3hqTHd6czVFUXRJNmdhWGtVbDFtdy9wc1lqSUxZTFd0ZjFw?=
 =?utf-8?B?MjZ6N01kTitxTUNEQWplcWdHUXMrb3BFNzg1V3BCZGJEeDhGQms2WlB4Q2Vw?=
 =?utf-8?B?bFVVTnRBOXUzQWpHeXIwWW5oVFQxSk1qWm1PRlNOWW5NRjZOdFhPRmtzMk5Q?=
 =?utf-8?B?bkg4eldyalJxeXNIR1hTWlNPbTE2NElMSHZHVGxKUjZvWVc4K0JOOCtaM0NQ?=
 =?utf-8?B?QUNQRWdHQ09IT1NkUG54YW5nc0dReGdWNVFnREFKN0xuellMOVpaS3R6Z3Qx?=
 =?utf-8?B?aWlCRzAva0FneGZ5cEMwUHFjeFFraUN5bnBGRkIyMHB0ZnRMUXVCcWY2REc3?=
 =?utf-8?B?c3FtWTNQZ2tMcCs1WFZ3RUlxdXdadUNhSGh0ZFljR2dFZ0plVXBVaGJDWGs5?=
 =?utf-8?B?R0JadmNkTC8yMDU4L2V4NkhUZzhobGVMMjlFZkxjVnMyV3kxd2F6UWVIVlNv?=
 =?utf-8?B?bGpJSkZMUjFkbHpNOW11MFVDSHdVOTdjVzRLRTZienNUN2IzaUR4dWVEL0gw?=
 =?utf-8?B?aldiNWI5a1QwcWxlYy9jbzFoSjZ0WTNpUThVaTZ4d0srOUMrdCtwTHl6K1Iv?=
 =?utf-8?B?RmljRkN3MGFBMGZYNys5c3dRYi85U0psODFnNG54Q3ZweU5FbUVhNzlNY3JU?=
 =?utf-8?B?QnJMNXlJOGtkNDFGejM4Sms2Tk02L2U0Qi8vWDR0SHJ3OFYrUG9Kay9EdEt2?=
 =?utf-8?B?akpWYzROckNlM2tDcG9aVTlZcEtJd1NBUG1NRG43VEJ5Y3dlcG56NjhkMVRu?=
 =?utf-8?B?YnBzTDJjTEdmcHpyL01aYzFYSUpmK29qQ1FOVUFRc1dzaXhDNHJzQXVNNXdr?=
 =?utf-8?B?TDFPWHg5NndmNWpZa1hPWnpidExGRFZqSTFGOFNObTAzN2ZYQkc4dGkvK0tT?=
 =?utf-8?B?Z2pJZVcyMitKeWhtT0RzOVM2WmprQWtDb1JRckNYYWhrc2ViSEl3NjU2bjM3?=
 =?utf-8?B?ZjRmaGtpTVozN3ZxbUY4ZHI5T3FtczRTM0hMWTZpVk1tTXhaV3l0djlWdTJv?=
 =?utf-8?B?RklpYXVUZXdlYWVHQzZVc2dLMmRzYXJydnluZ2M3UWhpSk03eUlYUno0Tm1H?=
 =?utf-8?B?eWpSZTNyelZRZU5KbjNkdjNLZEVDViszd0QxVUJJYTQ3VG1MdnY5bCs2NktT?=
 =?utf-8?B?eEw5ZG9iNElmcWwwUW1JOXVuYWE1ZWRId2FSdXEzbW15aDM0V1hQTDd5dmxs?=
 =?utf-8?B?Y3lIbDlITjlUUGU4Q2M3ekFDa3BKV2E0em9sNEFnSittZmxVNFdzUWIzS00x?=
 =?utf-8?B?Rm5YOG9kbHh0TXVLU3RPZzN3emdjUkV5TGt0d21JK1VsKzJYWHRXMUwzc1pU?=
 =?utf-8?B?OEUrOUp0K2liWUE3NXRMa2ErMmw0SDFmbGFmRGd4UXVHaTdZSCtGQjlpUkR1?=
 =?utf-8?B?Q0s4UUw3R0w3RTZTemMrZ3lWSWdaUHc1dlhsY2tJcHNaVC9ySlZTTWxjdGJU?=
 =?utf-8?B?cHN0Q0xveHlsRmxsanVoK2JSTUV0UVNqQU83OGNra3ozNThrQkZCVW9BeXZm?=
 =?utf-8?B?VHZ4T0RKbFkwNVA2cEk5UFo5eXEwSXM5eEhGNjNhZll1OGNJQWRQVkR1S1V3?=
 =?utf-8?B?V3JydDEwS3R0eFZ4MmR4dlZaYVF3NHhLLzNXSHd3eTV4aDVOZGRlYnFOTnpD?=
 =?utf-8?B?ZXBzVDJtNFpFQlE4SDE3dHUvcXRHNVFRRzNGdS9aSGpJcndLbkUxaERwVWNY?=
 =?utf-8?B?MGNYSjhMODlUK2U4RitTbThRRHd4ZlN6eUcxRHpVSk9KeCtoNHNLVmFqZ2xB?=
 =?utf-8?B?MGZHUFhoYXcwOUlXcXN5OW84QytuSy9wOHE5eGlYbFlYeEJGald3cDBmWDBW?=
 =?utf-8?B?SzJiQnlxcTNxRnVGbHJuM3JMWWNibWs4QVIrbGZTZmt2ZVQ0S3M2ZFdGbCth?=
 =?utf-8?B?N2RDY3NoMUNtZGpmNkZGdnEvOXVrbVRPVVVMSDUwVlc3S2dtUlZUSGlRQ1Ay?=
 =?utf-8?Q?v84xp9uQs+YUs7lT6gzl5c4fA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a6ea8b-1991-43e9-d237-08dcf23a8f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 01:40:50.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4nCIjL2pxcMgf1t+FBQB2jCHQ+AGXtfrjz9YvzhDRg/Wo/zcotZF0VLDmlok+sxVX0HGF4kHoBJMAxEksLokFRI49E3LLyjagvgW3FE/t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5370
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
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

SGkgQ2VkcmljLCANCg0KPiBTdWJqZWN0OiBSZTogW1NQQU1dIFtQQVRDSCB2MSAxMS8xNl0gdGVz
dC9xdGVzdC9hc3BlZWRfc21jLXRlc3Q6IFN1cHBvcnQgdG8NCj4gdGVzdCBhbGwgZmxhc2ggbW9k
ZWxzDQo+IA0KPiBPbiAxMC8xOC8yNCAwNzozMSwgSmFtaW4gTGluIHdyb3RlOg0KPiA+IEN1cnJl
bnRseSwgdGhlc2UgdGVzdCBjYXNlcyB1c2VkIHRoZSBoYXJkY29kZSBvZmZzZXQgMHgxNDAwMDAw
DQo+ID4gKDB4MTQwMDAgKiAyNTYpIHdoaWNoIHdhcyBiZXlvbmQgdGhlIDE2TUIgZmxhc2ggc2l6
ZSBmb3IgZmxhc2ggcGFnZQ0KPiByZWFkL3dyaXRlIGNvbW1hbmQgdGVzdGluZy4NCj4gPiBIb3dl
dmVyLCB0aGUgZGVmYXVsdCBmbWMgZmxhc2ggbW9kZWwgb2YgYXN0MTAzMC1hMSBFVkIgaXMgIncy
NXE4MGJsIg0KPiA+IHdob3NlIHNpemUgaXMgMU1CLiBUbyB0ZXN0IGFsbCBmbGFzaCBtb2RlbHMs
IGludHJvZHVjZXMgYSBuZXcNCj4gPiBwYWdlX2FkZHIgbWVtYmVyIGluIFRlc3REYXRhIHN0cnVj
dHVyZSwgc28gdXNlcnMgY2FuIHNldCB0aGUgb2Zmc2V0DQo+ID4gZm9yIGZsYXNoIHBhcmdlIHJl
YWQvd3JpdGUgY29tbWFuZCB0ZXN0aW5nLg0KPiANCj4gVGhlIGNvbW1pdCB0aXRsZSBhbmQgZGVz
Y3JpcHRpb24gYXJlIGNvbmZ1c2luZy4gQnkgImFsbCBmbGFzaCIgbW9kZWxzLCBkbyB5b3UNCj4g
bWVhbiAiYWxsIEFzcGVlZCBTb0MiIG1vZGVscyA/DQo+IA0KPiBTaW5jZSB0aGUgY2hhbmdlIGlz
IGludHJvZHVjaW5nIGEgJ3BhZ2VfYWRkcicgZGF0YSBmaWVsZC4gSSB0aGluayB0aGlzIHNob3Vs
ZCBiZQ0KPiB0aGUgdGl0bGUuDQo+IA0KVGhhbmtzIGZvciByZXZpZXcgYW5kIHN1Z2dlc3Rpb24u
DQpXaWxsIHVwZGF0ZSBpdC4NCg0KSmFtaW4NCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4g
DQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0
ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgIHRlc3RzL3F0ZXN0L2FzcGVlZF9zbWMtdGVzdC5jIHwg
MTcgKysrKysrKysrKy0tLS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L2Fz
cGVlZF9zbWMtdGVzdC5jDQo+ID4gYi90ZXN0cy9xdGVzdC9hc3BlZWRfc21jLXRlc3QuYyBpbmRl
eCBiOGFiMjBiNDNkLi42ZGIxODQ1MWQyIDEwMDY0NA0KPiA+IC0tLSBhL3Rlc3RzL3F0ZXN0L2Fz
cGVlZF9zbWMtdGVzdC5jDQo+ID4gKysrIGIvdGVzdHMvcXRlc3QvYXNwZWVkX3NtYy10ZXN0LmMN
Cj4gPiBAQCAtNzIsNiArNzIsNyBAQCB0eXBlZGVmIHN0cnVjdCBUZXN0RGF0YSB7DQo+ID4gICAg
ICAgY2hhciAqdG1wX3BhdGg7DQo+ID4gICAgICAgdWludDhfdCBjczsNCj4gPiAgICAgICBjb25z
dCBjaGFyICpub2RlOw0KPiA+ICsgICAgdWludDMyX3QgcGFnZV9hZGRyOw0KPiA+ICAgfSBUZXN0
RGF0YTsNCj4gPg0KPiA+ICAgLyoNCj4gPiBAQCAtMjU2LDcgKzI1Nyw3IEBAIHN0YXRpYyB2b2lk
IGFzc2VydF9wYWdlX21lbShjb25zdCBUZXN0RGF0YSAqZGF0YSwNCj4gdWludDMyX3QgYWRkciwN
Cj4gPiAgIHN0YXRpYyB2b2lkIHRlc3RfZXJhc2Vfc2VjdG9yKGNvbnN0IHZvaWQgKmRhdGEpDQo+
ID4gICB7DQo+ID4gICAgICAgY29uc3QgVGVzdERhdGEgKnRlc3RfZGF0YSA9IChjb25zdCBUZXN0
RGF0YSAqKWRhdGE7DQo+ID4gLSAgICB1aW50MzJfdCBzb21lX3BhZ2VfYWRkciA9IDB4NjAwICog
RkxBU0hfUEFHRV9TSVpFOw0KPiA+ICsgICAgdWludDMyX3Qgc29tZV9wYWdlX2FkZHIgPSB0ZXN0
X2RhdGEtPnBhZ2VfYWRkcjsNCj4gPiAgICAgICB1aW50MzJfdCBwYWdlW0ZMQVNIX1BBR0VfU0la
RSAvIDRdOw0KPiA+ICAgICAgIGludCBpOw0KPiA+DQo+ID4gQEAgLTMwOCw3ICszMDksNyBAQCBz
dGF0aWMgdm9pZCB0ZXN0X2VyYXNlX3NlY3Rvcihjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgc3Rh
dGljIHZvaWQgdGVzdF9lcmFzZV9hbGwoY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgIHsNCj4gPiAg
ICAgICBjb25zdCBUZXN0RGF0YSAqdGVzdF9kYXRhID0gKGNvbnN0IFRlc3REYXRhICopZGF0YTsN
Cj4gPiAtICAgIHVpbnQzMl90IHNvbWVfcGFnZV9hZGRyID0gMHgxNTAwMCAqIEZMQVNIX1BBR0Vf
U0laRTsNCj4gPiArICAgIHVpbnQzMl90IHNvbWVfcGFnZV9hZGRyID0gdGVzdF9kYXRhLT5wYWdl
X2FkZHI7DQo+ID4gICAgICAgdWludDMyX3QgcGFnZVtGTEFTSF9QQUdFX1NJWkUgLyA0XTsNCj4g
PiAgICAgICBpbnQgaTsNCj4gPg0KPiA+IEBAIC0zNTgsOCArMzU5LDggQEAgc3RhdGljIHZvaWQg
dGVzdF9lcmFzZV9hbGwoY29uc3Qgdm9pZCAqZGF0YSkNCj4gPiAgIHN0YXRpYyB2b2lkIHRlc3Rf
d3JpdGVfcGFnZShjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICAgIGNvbnN0IFRl
c3REYXRhICp0ZXN0X2RhdGEgPSAoY29uc3QgVGVzdERhdGEgKilkYXRhOw0KPiA+IC0gICAgdWlu
dDMyX3QgbXlfcGFnZV9hZGRyID0gMHgxNDAwMCAqIEZMQVNIX1BBR0VfU0laRTsgLyogYmV5b25k
DQo+IDE2TUIgKi8NCj4gPiAtICAgIHVpbnQzMl90IHNvbWVfcGFnZV9hZGRyID0gMHgxNTAwMCAq
IEZMQVNIX1BBR0VfU0laRTsNCj4gPiArICAgIHVpbnQzMl90IG15X3BhZ2VfYWRkciA9IHRlc3Rf
ZGF0YS0+cGFnZV9hZGRyOw0KPiA+ICsgICAgdWludDMyX3Qgc29tZV9wYWdlX2FkZHIgPSBteV9w
YWdlX2FkZHIgKyBGTEFTSF9QQUdFX1NJWkU7DQo+ID4gICAgICAgdWludDMyX3QgcGFnZVtGTEFT
SF9QQUdFX1NJWkUgLyA0XTsNCj4gPiAgICAgICBpbnQgaTsNCj4gPg0KPiA+IEBAIC0zOTUsOCAr
Mzk2LDggQEAgc3RhdGljIHZvaWQgdGVzdF93cml0ZV9wYWdlKGNvbnN0IHZvaWQgKmRhdGEpDQo+
ID4gICBzdGF0aWMgdm9pZCB0ZXN0X3JlYWRfcGFnZV9tZW0oY29uc3Qgdm9pZCAqZGF0YSkNCj4g
PiAgIHsNCj4gPiAgICAgICBjb25zdCBUZXN0RGF0YSAqdGVzdF9kYXRhID0gKGNvbnN0IFRlc3RE
YXRhICopZGF0YTsNCj4gPiAtICAgIHVpbnQzMl90IG15X3BhZ2VfYWRkciA9IDB4MTQwMDAgKiBG
TEFTSF9QQUdFX1NJWkU7IC8qIGJleW9uZA0KPiAxNk1CICovDQo+ID4gLSAgICB1aW50MzJfdCBz
b21lX3BhZ2VfYWRkciA9IDB4MTUwMDAgKiBGTEFTSF9QQUdFX1NJWkU7DQo+ID4gKyAgICB1aW50
MzJfdCBteV9wYWdlX2FkZHIgPSB0ZXN0X2RhdGEtPnBhZ2VfYWRkcjsNCj4gPiArICAgIHVpbnQz
Ml90IHNvbWVfcGFnZV9hZGRyID0gbXlfcGFnZV9hZGRyICsgRkxBU0hfUEFHRV9TSVpFOw0KPiA+
ICAgICAgIHVpbnQzMl90IHBhZ2VbRkxBU0hfUEFHRV9TSVpFIC8gNF07DQo+ID4gICAgICAgaW50
IGk7DQo+ID4NCj4gPiBAQCAtNDM4LDcgKzQzOSw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfcmVhZF9w
YWdlX21lbShjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgc3RhdGljIHZvaWQgdGVzdF93cml0ZV9w
YWdlX21lbShjb25zdCB2b2lkICpkYXRhKQ0KPiA+ICAgew0KPiA+ICAgICAgIGNvbnN0IFRlc3RE
YXRhICp0ZXN0X2RhdGEgPSAoY29uc3QgVGVzdERhdGEgKilkYXRhOw0KPiA+IC0gICAgdWludDMy
X3QgbXlfcGFnZV9hZGRyID0gMHgxNTAwMCAqIEZMQVNIX1BBR0VfU0laRTsNCj4gPiArICAgIHVp
bnQzMl90IG15X3BhZ2VfYWRkciA9IHRlc3RfZGF0YS0+cGFnZV9hZGRyOw0KPiA+ICAgICAgIHVp
bnQzMl90IHBhZ2VbRkxBU0hfUEFHRV9TSVpFIC8gNF07DQo+ID4gICAgICAgaW50IGk7DQo+ID4N
Cj4gPiBAQCAtNjc5LDYgKzY4MCw4IEBAIHN0YXRpYyB2b2lkIHRlc3RfcGFsbWV0dG9fYm1jKFRl
c3REYXRhICpkYXRhKQ0KPiA+ICAgICAgIGRhdGEtPmplZGVjX2lkID0gMHgyMGJhMTk7DQo+ID4g
ICAgICAgZGF0YS0+Y3MgPSAwOw0KPiA+ICAgICAgIGRhdGEtPm5vZGUgPSAiL21hY2hpbmUvc29j
L2ZtYy9zc2kuMC9jaGlsZFswXSI7DQo+ID4gKyAgICAvKiBiZXlvbmQgMTZNQiAqLw0KPiA+ICsg
ICAgZGF0YS0+cGFnZV9hZGRyID0gMHgxNDAwMCAqIEZMQVNIX1BBR0VfU0laRTsNCj4gPg0KPiA+
ICAgICAgIHF0ZXN0X2FkZF9kYXRhX2Z1bmMoIi9hc3QyNDAwL3NtYy9yZWFkX2plZGVjIiwgZGF0
YSwNCj4gdGVzdF9yZWFkX2plZGVjKTsNCj4gPiAgICAgICBxdGVzdF9hZGRfZGF0YV9mdW5jKCIv
YXN0MjQwMC9zbWMvZXJhc2Vfc2VjdG9yIiwgZGF0YSwNCj4gPiB0ZXN0X2VyYXNlX3NlY3Rvcik7
DQoNCg==

