Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D13CFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 04:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOqEG-0000BR-2w; Thu, 27 Nov 2025 23:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hdijk@accesssoftek.com>)
 id 1vOqED-00006w-BO; Thu, 27 Nov 2025 23:37:05 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hdijk@accesssoftek.com>)
 id 1vOqEB-0002pi-MG; Thu, 27 Nov 2025 23:37:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmI4+PVbyAHtM531ZCBDmahgAJmeXZC0TU+5q/2wYDMDaXrM5022pKmh6h7SnfYjApUru9c6rND3S092VEVbJJ135TBp8lng4ZNy/miqJ/dI7DKgTJe/My4fj5JvzgTcnGlLg7CFm57+P3LP9v1j9dkb687CmOsauN+O3KQrSL0XzseWSEDdMROky7WlV/p+Q0WmtO0Hg6cSx5dt/u1ExWvchkFYBAAvzFn+PPb3NR1eqrLWVDuqLVzvlXyoAhchDWTltGS2Oz7uS7lP++9kfWwuvMt4OB2q8pl0Sic3rCtX6Z6S0yzqGLCGoWQhVeaqVVvBJG71qRj7+dVVUMmyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbkz6oxeAD5i/DpmHjoS/tXlE7Ocm7dtZK1PaZQlo+U=;
 b=ycNTDIemX/+E/E84ul72dT+sh9h+8048pyRsEsdkeceATWP8fjKZ4tGQ7yyJ+KdMrC6Rm3Ren/Bpmkbv+B4lvIh8g/Ml/duSC8250hgYaUULYOw35NQTR7Z5pLsgxYfwkeixajMI0Jh23TlopzkXUmLiCCDrNvYOFqQoWIT9lDRMh/PIjr1GtaQfbwq13zOX7A0z6S30hEmAGSE6aI8+9l2EtmPb8B+g7ZMFj8bape6IQfKv1E9pPbvsFLTiNrxQpFnDa8b8ncHtK3c0qdn0PAzoEoNRxfkuDUg34jUKIC2sB/niv+k+cV7OX371/zrGGfwi1IPqQLi2qOisZ8JEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=accesssoftek.com; dmarc=pass action=none
 header.from=accesssoftek.com; dkim=pass header.d=accesssoftek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=accesssoftek.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbkz6oxeAD5i/DpmHjoS/tXlE7Ocm7dtZK1PaZQlo+U=;
 b=tBXZkRqEy28c5XkMHyoGGqK+V+tgyR/3BAFJOGRn7Cpf7Kxzh1feADXfGEVqCXSr82qR6BiR11jSYxoegRoTEMJ6DCmUDcFRqJl63TTl9+28ncuasBTGcatuN3k4EK5Fw9+rljo9NY8KdblqDAth0Uhf1cNIC6b+xG6BCni8coMgh5x4ZbMZc94WPoilYCOtQDuVcLnEf9lqfSFT4MArk4C3OcAY9xAEBgdngGWP9Ait+y5M9743Nyq0pq5aYJYTmsMODN7yalU3yIPzSt61wtcDwq8GdwvqYHYd7hxWELxJwYoxdE6lP+mSoaFd9wzZGk1GMe49D7RRdBsRjr//pg==
Received: from PH0PR20MB6156.namprd20.prod.outlook.com (2603:10b6:510:2a1::7)
 by IA0PR20MB5730.namprd20.prod.outlook.com (2603:10b6:208:436::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 04:36:59 +0000
Received: from PH0PR20MB6156.namprd20.prod.outlook.com
 ([fe80::ae6e:9fbd:b45f:edac]) by PH0PR20MB6156.namprd20.prod.outlook.com
 ([fe80::ae6e:9fbd:b45f:edac%6]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 04:36:59 +0000
From: Harald van Dijk <hdijk@accesssoftek.com>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/arm: Fix assert on BRA.
Thread-Topic: [PATCH] target/arm: Fix assert on BRA.
Thread-Index: AQHcYBXPrJr2DfWb/0Ohfaf2PrVCI7UHgRiA
Date: Fri, 28 Nov 2025 04:36:59 +0000
Message-ID: <45f2dc76-66fe-4376-a04a-55bcef530bc2@accesssoftek.com>
References: <b42ee4ad-2378-48bb-a18c-0b0a5f16b132@accesssoftek.com>
In-Reply-To: <b42ee4ad-2378-48bb-a18c-0b0a5f16b132@accesssoftek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=accesssoftek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR20MB6156:EE_|IA0PR20MB5730:EE_
x-ms-office365-filtering-correlation-id: 1773314c-0eb7-4c74-8b9b-08de2e37c4e8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|10070799003|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?N0ZqYUFDM3VGa3JIT0lJNkZ6ZkFvSmJVTklPbnFtNzJUanJpUlFpR3JyWHBU?=
 =?utf-8?B?V1hvSzBkTE5rRkZyODE4M2Q0WXNuNTNSVjRTL1RYeXowejBaWXRRRFRxYkw0?=
 =?utf-8?B?Wlc3RUdyVEZvREM0aW9TRlFsWks0UE5tZlBiL2syNkNUSFMrOVpzL0REeFJM?=
 =?utf-8?B?MGdDSE5qcGh1RWlTdUVQd3J6VnlTRUtXOGFhbC9ZY1FLNm9pT3JSOTZRcGx3?=
 =?utf-8?B?VVFHWmdPSEF0ZFJuVXRrUlowSy93K0JJNkZ0N0VRSTFYYWtxRUczRWNYcGI5?=
 =?utf-8?B?RFpYb3ZGdFhYYVRVT25XYVd1NmMzWVZOaUh5cDBkbjZKRTFxUG5idDNjUkll?=
 =?utf-8?B?ejNpMUJKWnRsMjZwK0lYT3duZGxadkhWWWVObmVFb3BZVUxFa3ZuZVB4RlZH?=
 =?utf-8?B?RWNrUm01L1pETzIweGl2djgxaFpZVUFTQmhDckhCZktScUM0akVXSkxLbGxz?=
 =?utf-8?B?QkcyeEQ0M0d2T2hhdGJZR3NuV01rcXR5ZFJUOEt5NVlmZFdLWlVMTjZoZklF?=
 =?utf-8?B?SUwyeU1HaXhHZ1VlZHEzbXk0S3c0ZTl5S2gxWEZwaVRtdzcwdU5KTmRvdlhF?=
 =?utf-8?B?MFIrbWZpQ0VFZS9xVmZjeG9RYzdNeUFocDMyejZieUJ1MlNNb0hhYnErUGpI?=
 =?utf-8?B?dVFuN1hZenNtOEJoVnI4TVdNamg2MWhnVGNtL29pNFNlOEVxN3ovTElkNjlv?=
 =?utf-8?B?bkVLOE4xbDJqcHlQc29UTjgxSnhFa1BFQWhPVC9SeldRR2RZSWRhdm91M0pt?=
 =?utf-8?B?TU1HZjhUTWVaVnNGZnVha1dkYmhWOUI2SE02S1VoZzNMTVJJejdyTlZTa05T?=
 =?utf-8?B?elF0dmk1b0tQTU1iTjRxM09YWm1tbUxwbFQ1aFYzT1pTTEpLdEl3TkpxSVJV?=
 =?utf-8?B?QzZvVmFGRGhPV3lyVkRvMWtCbmlPUS8ycUYyMmN1TnpVV2hVTWk1eDV5a3cw?=
 =?utf-8?B?TElGOGF0RzV5dElQcUhpYmxkK2tqVGIrTnIrQjVqZnRZUTdjdkhQazZWdkRu?=
 =?utf-8?B?cXlHSmpMRkFSaE1wdGF2S2o2QVFrb3h0MHZVMkovRVYrekZ2UElUcjhiSGIz?=
 =?utf-8?B?bUR0alRFSnVvV3kzMmVkclppcXlwRStrM2dnWDhHYlJmbFVyam5BZFdRNGNB?=
 =?utf-8?B?UnhYUVNUS1Iza0s3dE4vcWVhWldzaGFmU1p1VGwzaTcwb2lGR0JtN09SRDFX?=
 =?utf-8?B?WFBXd1poOC9Fd2tJbmtqNGxHWVlUK2dGazlyaDRxOElGY0o4ckxWUmkxRVU4?=
 =?utf-8?B?WGdIV0pvNGxKZE1oSXdOVTJyNXJZOGdFQWpMUUw3UHpTT25aQlRsUCt3bTdr?=
 =?utf-8?B?dFZyYWlWS3o1T0k5WjV1MGFRNnU2VTBYTUVJOCtuQU9FY1lMelV0R1pvL1ls?=
 =?utf-8?B?MHZWN3hrWEc4N0hERTdiVjE1eFYrU3l0QW12bDQ0MWYrTGRkdXNxR1lGa1ZI?=
 =?utf-8?B?TGpNUDZDaHByNUQrdFNGOXpNaENBWGhaWUp6THNSTlByMWlGdjB1cmVqdnZF?=
 =?utf-8?B?NklJS1FweTE0cCtWWTRzcXF1TDhxcmpkZ3J0K2Q2SmRsUmE5dkVlTDBxdm9h?=
 =?utf-8?B?Uy9ObDBRbXhUS2grcDN1eEl4UTd0RXozUi9lTWlGYk96U3JPbXhUZXkzZGE4?=
 =?utf-8?B?WXF3MVdZSVBLdEZSRHYzRFQ0ejQ2R3FlZXN3YUdpaExsb20zcE1VZ3A2NE1N?=
 =?utf-8?B?QjNjZldqdGxrcWNQTkwwWkdneTVrTUNkV2hDd21jTWN3QmZ1dXlud1ZycXhl?=
 =?utf-8?B?WEUwWllWdTVHYUdhcUMwR3M5d0ZXSTYreTEvUllPR1dueVFLekg0OVVCV2dl?=
 =?utf-8?B?WWVhaTFpclhQMU90bm0zVVphVVBKR3cvRjI2VFk3bXdkNmRRdjFDNlJvN0Mx?=
 =?utf-8?B?bis2U2ZuYUs3ajZTaGw4ZTQ4MzVaNGxEYlJBNnZSUGgrQjB2akc1M1dPblN2?=
 =?utf-8?B?am9TR0k3TjU1V3J3VVR4K3htNmdZb2dNV0R2MjBNdnlSZ2xTOTZWVUhaZXhS?=
 =?utf-8?B?UlBBNmYzeXdMRUZnS2hzaTVrWExjOXpKVmM5Q1BrVWhvTFZBUXExUCtEaHRZ?=
 =?utf-8?Q?YpA3OT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR20MB6156.namprd20.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlNEb0V2M1BQRWl5SHJXcEppZVBRTDBUL2xEUGZxZVJPMUxRRmJMb1lCL3NO?=
 =?utf-8?B?ZEhsbFA3WFlFOWlaS0YzN0pHS1VyRE9TVmd0REtzN3hLelpsLzlEQndUWVlu?=
 =?utf-8?B?V2pvVEloeDQxd0VnSW5PS1NaeXNZeUYweE8zVk44czlSMjMwSW1UdUNRMEVX?=
 =?utf-8?B?QncvRGN5M0hXeVFvUHhFY3d4Q0daSUZtN0pia1oyV1JNYWtEb3JPRDRvbEFh?=
 =?utf-8?B?TGR5Z0ltMW1QOHpCN29MTVZld1RsUEhtOGNyeTZZSllKWHhYNVpUTlRlVzl2?=
 =?utf-8?B?aVpnSTdGcS9TMXVKSmtZdWxnQnNWeWkxbktrU1JiVTZPcVBvczk1azVRaU9n?=
 =?utf-8?B?cU5pU3VTdURrZzJ1VDdjeTFHN3VRWUwxSlNlOHl6M1BFU3BQUDViWC9lbDRo?=
 =?utf-8?B?Sm1OSFcrbnoyemtHbXM3VGdqYVM1M1piOVUxd3U5SU15MnlhTlZvQUM1aW5q?=
 =?utf-8?B?MXRPQVhjbEpLZEZvbTI0L0ltcGdiZ3kyWkRLUGxwMitqYTRFOHE2blNENkU3?=
 =?utf-8?B?ZWxXem5SbHFiWDh1WTk3TlEraUp6Q3hNNEhUTmk1L1FTNUNzSmU3SU5zSkxo?=
 =?utf-8?B?ejNwSE5nVnNtYkdsQmgvYTJhTEgzK3ZZRnZqR05kRTNjWTFVTmZGRjUxb3Uv?=
 =?utf-8?B?TkFFOFFPN09DSTF1RjNJbVYvR1RlbTNFZHJHanQ3VnRWb2hEYmZKZkp5Slh6?=
 =?utf-8?B?bmF0RURRT2xFNHdac3YrNFAvSVRqcTBCT2lLWXFrSnZEcEhZLzBERlc4NTJx?=
 =?utf-8?B?ZWdMd2pYT29iSlFWVFR5MTZ6dE1nSXBDT2pRRmJ1R0VXc1ZWRld1bWhvdGR0?=
 =?utf-8?B?elBNOXE4NS9YSmNVeVlMalpUb2tWUUovYm0yUHJtb2s4dlRVQk9RaUZEeHJD?=
 =?utf-8?B?dmwwWGdVa0k2VzdsN0JKcjk5clpBdGs5dWxqcWc4UmhINXZtSmVSUDhOV3Vq?=
 =?utf-8?B?NkNKMHVucC9QYXN0R2RCZXU2UU9IZFNjYmlQYkJ6c3QxK1ovZXFwZzVBMjJU?=
 =?utf-8?B?alJDT1dnYVpPT2V2blMxV2FiMWljYzJLeFk2MkgxUFJpL2lwbkR6dXNFL29P?=
 =?utf-8?B?UktQR3NoS3RoZDEzOGVPdlRMakg3UEFMR2RTc1F3b0FVbkNuMjZQSUZ5VUp0?=
 =?utf-8?B?a1B3Rm5TblNtNW5reExHdXBzSS9BaVBCYVlnQmxETGhrYnhFak84Q05PM3RO?=
 =?utf-8?B?c3BsYnhDcUh5TmxNWVNmelU3OGUvVHdNTy82V2tuelhobHR4OHJJSDBnVjVT?=
 =?utf-8?B?eXhwWThmaWQxNmI0STEwTVpKaVhoTThBQWUrY0w1blVNQ0c5ZDF1UFhyN08z?=
 =?utf-8?B?R0pYaVljaWdOMTRzUDJJTHdyeklyL1N5R3BNUGp0dVNyMzVhMUxqNSt4SzlQ?=
 =?utf-8?B?ZUV4RWwybmZoSmQ1YkY2SVluVVUvbGl0MkpDa3hjUGdlNVhuMTdISlFsT0s0?=
 =?utf-8?B?OGJ0T3ZJMUtzdzMwRjJzcWZTTlA2bEY3L3lkMVlveDdIZTVoQzAyQ3FTVmlS?=
 =?utf-8?B?VDBiNlFrQlhQNnNTNzNzZVAva2Jxd0RLOHorMnNLbEhKTnBTeTN3aTAwRC8v?=
 =?utf-8?B?R3hZQ2RRVWROQVVTcm04cldHUlozSTdrZ3FCTGxTZVJhZHFnSzlHcUZlQUo1?=
 =?utf-8?B?M3o3VVVZK0NZZGsrZnh1UGdHZzc1ektOSXcyQ29vOERVU0hqV0hzVzIxTHhN?=
 =?utf-8?B?NW41UFU2UGZac0c0QnpMcTgrWDQrRFV0cDhRdDBjNmFBdnVWdDJzTUJtWEg2?=
 =?utf-8?B?TzJ3SGdzR3lKeTZuSGxpNHRqUG0vdE9XYTExak9kMktxSzVIcTJJK3VCN0VB?=
 =?utf-8?B?QVNoY2NMMnVQUTFUSU1CU3VrcVgySnpmNVVyMzFjQ2hjVmJud05POVU5aFRw?=
 =?utf-8?B?TEJ6UFhRUEt0bXUrNlMvcUZuMHFkRkdCZU4waW1oODRjVFB4TVBzZDdhbzZh?=
 =?utf-8?B?bzlwZWR0UWhwd04zSzRWTXhOVW8wbmd4T1dPbGF6b0Y1SlZHamRzV01iS09s?=
 =?utf-8?B?bVJBT2tTcnBoeDhxYkFrRElYcEdhUGZCK0JsUXN3Qkw4ZmZUdXpXdDVQRkpF?=
 =?utf-8?B?Y0xkSXhyWWRnd0Y3b0pBL01QM0FMdjdYYi9uaGhYdzBRL3UwVUlvM0F5WitL?=
 =?utf-8?B?VFVDQUE0aXIyZ0JJcmV5NEJWT2ZEMnJiL2Njakxnb25KdTE5VlpaZks1NmEx?=
 =?utf-8?Q?Yl15YnMkl+zZ310FYXC0PmgXkFeb8L8tx/LF7hRE2bN4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE8B9535771FA045A070ABEE0B16BA17@namprd20.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: accesssoftek.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR20MB6156.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1773314c-0eb7-4c74-8b9b-08de2e37c4e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 04:36:59.4288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c0629ff-77ca-4be4-816c-d880f9e12cba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wAJRYWDHfmXqaS31WA0rnL8hicbqy4UEUCn0NqAX2qiKw1KIb5sORkvTN4Qw4bx5XRHChlLRfr8sQx77cfAog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB5730
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=hdijk@accesssoftek.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

T24gMjgvMTEvMjAyNSAwMzoxOSwgSGFyYWxkIHZhbiBEaWprIHdyb3RlOg0KPiB0cmFuc19CUkEg
ZG9lcw0KPiANCj4gICAgIGdlbl9hNjRfc2V0X3BjKHMsIGRzdCk7DQo+ICAgICBzZXRfYnR5cGVf
Zm9yX2JyKHMsIGEtPnJuKTsNCj4gDQo+IGdlbl9hNjRfc2V0X3BjIGRvZXMNCj4gDQo+ICAgICBz
LT5wY19zYXZlID0gLTE7DQo+IA0KPiBzZXRfYnR5cGVfZm9yX2JyIChpZiBhYTY0X2J0aSBpcyBl
bmFibGVkIGFuZCB0aGUgcmVnaXN0ZXIgaXMgbm90IHgxNiBvcg0KPiB4MTcpIGRvZXMNCj4gDQo+
ICAgICBnZW5fcGNfcGx1c19kaWZmKHMsIHBjLCAwKTsNCj4gDQo+IGdlbl9wY19wbHVzX2RpZmYg
ZG9lcw0KPiANCj4gICAgIGFzc2VydChzLT5wY19zYXZlICE9IC0xKTsNCj4gDQo+IEhlbmNlLCB0
aGlzIGFzc2VydCBpcyBnZXR0aW5nIGhpdC4gV2UgbmVlZCB0byBjYWxsIHNldF9idHlwZV9mb3Jf
YnINCj4gYmVmb3JlIGdlbl9hNjRfc2V0X3BjLCBhbmQgdGhlcmUgaXMgbm90aGluZyBpbiBzZXRf
YnR5cGVfZm9yX2JyIHRoYXQNCj4gZGVwZW5kcyBvbiBnZW5fYTY0X3NldF9wYyBoYXZpbmcgYWxy
ZWFkeSBiZWVuIGNhbGxlZCwgc28gdGhpcyBjb21taXQNCj4gc2ltcGx5IHN3YXBzIHRoZSBjYWxs
cy4NCj4gLS0tDQo+ICB0YXJnZXQvYXJtL3RjZy90cmFuc2xhdGUtYTY0LmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCk9vcHMsIEkgZm9y
Z290IHRoZSBzaWduLW9mZi4gV2lsbCByZS1zZW5kLCBhcG9sb2dpZXMgZm9yIHRoZSBub2lzZS4N
Cg0KQ2hlZXJzLA0KSGFyYWxkIHZhbiBEaWprDQo=

