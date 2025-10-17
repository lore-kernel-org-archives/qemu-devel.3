Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3B1CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gzp-0006BP-4D; Fri, 17 Oct 2025 05:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v9gzn-0006Av-B8; Fri, 17 Oct 2025 05:43:35 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v9gzj-0005s7-ME; Fri, 17 Oct 2025 05:43:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adP4O6AMkJLJDJP1fZiW9EenmDcG0a3/ABQx3Iu4WbnWDdbsK8Lysg0hUle/lIVCmnRiPK93hfnQS9uF/uVPU2B7qhFbzM51m1j0H+jPWFJ9by/Mh1TUXECt1tnd9tHPRDkxFB3sb8N6HAnp7d3LNpVbuLjHUc39STPBFeLP/gDTK1Ucawru9voaHqJggDhL1wD7thIdwOXYe/mys+bNaWztCht6f/im+iPHYTwwcqkYtno++7uA3lLmIEsMXAwJw1kvMvxQrnpxTuilbeeOUhEtEXwo6cYYbVqrmfNazIZrL0G/qFJUFKRzGKuf2CtpISM0HlsP69/sdODkLA21FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPFn11PnOFIEXETCn99D3eQ/IsAKKMTi3qjVRwZ/niQ=;
 b=qJbybuYFRsw9XJxDDpTgxfokFmR6Ybkd9DbthP0Q9pbxLzBw1qOFBGJZ0eOtpuS4TZPSTtqNOjOpIieXugr8PIch10/MxGOppnbTce8+k+QJZfhNlb6zWXog2IxaxOUY1rYWPDMXKISZtNJEBFUVtdngnXn5P3xyWm0HrsQTH3JBEqaL3RFMUHVP+CfTW3SHclePNfzX+ep5+wrVz2iks5N/58S0TvHoIH5b54q14sXquaTLQiPQXDaEh7GtJILkkzAHPyCnwolFaMFo/Bzj61RsVCZPfLTIR98QtXUKF6bOct5F3CDZ/eA5bx5YXTmSoHf1Pyi+JQEkfzdCpB5lig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPFn11PnOFIEXETCn99D3eQ/IsAKKMTi3qjVRwZ/niQ=;
 b=hSG+HNQkFX06Ph9H0CqOTLOPXg/t/lDNUZ7FM/0RwG3LC1ZJcMASfEWYVDi4GJqacmDleoi+u65ofAKZEDU9kyzPgynOhddeptg0+Dxk6JOF8Xb6bPe1lSsOF+5Esvyq3orQ0npkzGGgKSW+o91XoJDi3vq6HztPwrVCy1XJQdcmTqO6lOCHnO89i2zM/+NIe1pb9nsRSf25w2LZ8X3U7nc7TX3nAtOyFjtzODXhxZDrMAK2DUIF5oV12rHY1omCfOqC/yaQjqH5QdUTyd6V103v+sm2NIwx4iKa4kKCrPZic1A7/HGsazikONHo30FLdKtjAIVyg9iwnZk/7xhHqQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 09:43:21 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 09:43:21 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 00/27] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v4 00/27] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHcPy7ek5elBjxJQkqEx+6f0j/XULTGFbVg
Date: Fri, 17 Oct 2025 09:43:21 +0000
Message-ID: <CH3PR12MB754802BBB37C2A36B4F7552CABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <CABQgh9Fzf0XJYwybb2S0ophuSZ6v+=FM=OWmnG3md7bXOo95-Q@mail.gmail.com>
In-Reply-To: <CABQgh9Fzf0XJYwybb2S0ophuSZ6v+=FM=OWmnG3md7bXOo95-Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6064:EE_
x-ms-office365-filtering-correlation-id: 11867ea7-4a14-4f4a-63e5-08de0d619be7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NjN0Wk5ab3FDNUo5Z1kxckVmeHBmcDFuV3JLOUg1YWFVazdYZjNKRzZFSHcx?=
 =?utf-8?B?cEhNNzEySzlrZWoxVFFWSmhHdkFpMFNQTXF6S2FZUUFTSC9YQ1lQcVk3YWRH?=
 =?utf-8?B?RmFsRXV0Qjg5YnIvR0syZkdjSTRlMjl6blVEa2pLdHM2V3FSaTZyM0VQTVAv?=
 =?utf-8?B?L1dVYktvYmdjVHM5ZVoyOHFrT3F5R2ZpWUd3MlFoaFBkdFpaSHU4YVRLNFox?=
 =?utf-8?B?Nld6UUVxTWI4SWJDYnRSZUhtWm5aTkZmM3hYNEttYStBTXo2K3Q2bUhmbnEy?=
 =?utf-8?B?NUVhUU90SFdiL3BDQVh1R0dTa0JiU3gvTlBkS25rM29hN3o3K1g5SjZWR01h?=
 =?utf-8?B?RDVNWklVNWdnT01JQm4xUE5tVTltK1RkYVdPSmVQU2ZQVGRYVXZhMklrZjB6?=
 =?utf-8?B?RStBQmt4azdOOCtyMTlKTGoweWZwVUNVWW15Yi9ZTGx1OVBsRVdhMWx4Zmgz?=
 =?utf-8?B?R3VONjhhdEFSdE84L2x6Wnc3QmNRWDZMajFwVS82NVlHNWY2WXNDaFVQZjRD?=
 =?utf-8?B?ZTlOeFhmdmgvSGNzeU1WNDJLV3luaG1VKzlLczlSa3Z0NjRsVnhqRFVLdnpN?=
 =?utf-8?B?WVVaYXNYd2l6ci8rME1oc1lTK2U2REpyWFpKakJQRTI2OTFqd09SVHRuNE42?=
 =?utf-8?B?aDVlWWRuSTBabHJzZHhYZFBGcnVlZzhiN3dnRjJsSG93dVpOQ0ZWcFBNaGpq?=
 =?utf-8?B?SzZTTG1hY01hbzZyaUczQ1F2RGlJeERTbUU1VjIyVFFKUVB3V1NuS3VoTkgz?=
 =?utf-8?B?T2RwdXBKMGNCNms2TlVSeHB1MmVoM1VxY2U2UTAzRW1KaEk3T2VwaGhndWlv?=
 =?utf-8?B?VzUwYml0eEQ4QkI1V3hYenpjcTA5TnUzSG5lQjVYRUl3c3pLVkxyT2RsT1Bp?=
 =?utf-8?B?Zm9JaTBxMGNITFpsRHBOY2l3WUVXbmovVmpFRzVtU0lmQ3JUaHNKTVd1Z3oy?=
 =?utf-8?B?bk9ib1Z5UTVQKzJpT1pnVWw1RytrdlQ4blR1eFR6amd5QlprSVFwbUNwc3k1?=
 =?utf-8?B?UXo5NjlkeXR3bHh6VEY4YW9xUit1TUVQUUNtWHpNNnFVMzk2czFiRXJWRDBC?=
 =?utf-8?B?cmtJTVVSMTBmdmZWWUN0U3NXM1dhUDRGaFArb0dZcUtJd0RuUlVrbGNzUUhF?=
 =?utf-8?B?SHFieTlsbmxJZUdzdHM1RU5JcjdOOG9PN2dHWi9naFlvdUd0Ym1pL3YvbWlK?=
 =?utf-8?B?aUxYKzVLcnNTQTlMMDBWdzRBM2JVTVFZOXlDUktjSzhpUWFNVzhlTVJLVC9v?=
 =?utf-8?B?NENCckoxc2FBV2g2ZlNxazM3TEtYM1ZtekRZR01QOFdEVjZ4eVdQWkZsaWxJ?=
 =?utf-8?B?bzRmZzdHY0xjVTVIOG5peFc4cnBCdEJHNHlRZzg1Y2lRODJNM2Vwd0NxcHoy?=
 =?utf-8?B?bnpqbFdPakpldEZJSzZ5ZXZQbG1XcDVOR0lkUDMxd2w3c09ocUIyeThjcXpW?=
 =?utf-8?B?d0RWZEpjT3h4RVcvOVMrZmc0V3VCK052WHRIWFpGRitYQzNYblFwUGVXZ0VB?=
 =?utf-8?B?SjZFNVAxMW9lZnlUeW1WRzN0d3hGL1djMnNRRWtVWWoxcFlpWXgrMnRNL3Ry?=
 =?utf-8?B?ZFBvNlNqL1NRYlpsZmpsc2VtQlJmWERIRW1iSCt1Y3VhdkJyS21BeXlRYjg2?=
 =?utf-8?B?Y0ViMHVzZHZucjNtU1NRTTJSOFk2Si9obHJXL01iNHVtUDVoYTgweHNUYlJx?=
 =?utf-8?B?bEh5SDZFeXBySUVHdlRMWU9kN3QrNm1hNnl3cEM4NE1LcW5pUjBqODRSeWpY?=
 =?utf-8?B?QnAyb2ZxS3RCeS9rbmFnVmFTTXpOWW9KaEp1MHlLSE9vdjNIdHVEeTNGWVcy?=
 =?utf-8?B?bHcxbFF0SzJZRHFwd3pKWUF4OTF1c1dpVkRPQ3RubmM1aWV5ZjNUZVJqVndG?=
 =?utf-8?B?bW9aMVVnd3NTT0wzai9iTDRoVGl2TXJRWnBrdmd4UDdISitGZTZndEhoMjZh?=
 =?utf-8?B?K3BxbkxHdE5SYjF6RkhSdEN0Nm9xekFSV3cyTnBrWk1xeUZXeWtLYjVJdFVp?=
 =?utf-8?B?U1pYa0JlVTgwQXAzSTl2S3dtbnQ4Q3I0bUVzYndrdWFZZWNMeEpLZWxVWnl1?=
 =?utf-8?Q?GA1/Ej?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTlmUlNNQm1CaDJPbmh0bDV3QUhXZU41MGcvUGJ5citTZmFOY0FRRjE5THBx?=
 =?utf-8?B?RHJTY2JwWEJVMndVY1JNNnZYNzg4Z0xDMkJZNVppelRERC9uSkptR0lHaEk0?=
 =?utf-8?B?R0ZwTXlmUzViVWw4anhTdklORUVqQjlnVTBZNERWZHVRZGdNRXRkSHp0ZVNS?=
 =?utf-8?B?QUpKcFAvY0x4YWZMb1ZoMkwzWk5SUkIwQXFJVUVtRGVpZHREYkdFQ01CWWVv?=
 =?utf-8?B?SkdyL3h3STFKTjBYOHpzZnBxdVF1MXgxSTVyTERkNzVmdG51SURwYTFqY0p0?=
 =?utf-8?B?V2ZVQXA5MUc5dmx6b2NXbEwwTWZicjJrTU9ORUpGcjJJb2krN2dOWGI3dlV4?=
 =?utf-8?B?VEgxVUdaWWgra1VxSzdtZG50cjZvMkxuc3pKK1BIdEF6TGFMWFIwWk1jRW1D?=
 =?utf-8?B?WVVpaXlWNVc5TVFET0FCWEVLVHNHQXg2ZUhYS2FuN1BiKy9DSzVvZy9xRjh4?=
 =?utf-8?B?Y284S2JIdzBHTjlLTHJnbm9oS3lpNXNuam03UzUxV2N2Rzd4eHlqNFc2STVz?=
 =?utf-8?B?KzhCZi9SUGh6dlU5ZG9KWDhLMzVjK3ZMenhtSmlTTHFnbDY2QnNtZUJFWFF0?=
 =?utf-8?B?OEg1Sys5ajA0VWJaY1FZSXpwVmpGMzhpM204b1NNVXRoRDFRS1k3ZkZrLzY0?=
 =?utf-8?B?Mk9OUmFibzI2VE9Hd0VGSWZFQ2JSZUFYekNUWVZxRTZwNjE0QmRaZ0dtYlNz?=
 =?utf-8?B?UXM5VVZxd3QrTEJ0OWRZemtVeVZtbHhxRDZHMWxIMVJGUlJzRkRjTWh3TmJs?=
 =?utf-8?B?NDd4c3JmV2pSWGNRU0pEbHhwdmU0bFZXMVZvSjlNMVJSemo1VlZGSm1KQTVo?=
 =?utf-8?B?amZDNGJ6eWJEa0xzbXM0Q3Y5UDhPOHQ1TFRORTM4cGNHcWpkOWpteThlUzJh?=
 =?utf-8?B?aGVzQUd2OFVuaGN6TXp0Yk1Xd1NMbk1qK0dqVkszVUJSYno2Z0k2UDFYamJV?=
 =?utf-8?B?QUNBSlJkVk9WZExsU1E1emdmL3NRMXpGUmQrY1YvT3l1SUorTXRaa0NpWUp0?=
 =?utf-8?B?TE54cE5obWZzdXBhclhUKzgzYWJKNnpSUjhCdzlzaG9kZG9QeG5aWS9xSXVL?=
 =?utf-8?B?THVUZU84QTdHSFZzU1ZUbXBDTk9VL0VPN25lNDBuLzRJZ3RvRmZJd1lsRXZq?=
 =?utf-8?B?Vy90VFhlaDZpb3U3RU4vS3A0ZkRuUHg5R2oyazFKMTNHWFFhakV2TGVGeUhh?=
 =?utf-8?B?QkxIaUdUTVRsTmhVWXE4TS9LWWpQQlVFR2U3UTl6Skx2bEJlbk9HSGJrcll1?=
 =?utf-8?B?MStvbnJMYlZBQnhyZHNOekdvS2QyRnMwMzlXTTN6b0RReldacUxVSmVJQW9v?=
 =?utf-8?B?WXlvV0JSakZaWlBMc2xEekFKN0JoOUtWdklpWTVqR3RFMUNEeE5GVkRQRDAv?=
 =?utf-8?B?cUNLVUFibHJWenNJa1ljOUVKeGJBVWJzVXZURmQxVTlsSDBueVJaRWVNaUh3?=
 =?utf-8?B?eTNnWVFpRHhPejNudkpzSmxxOThIMHNxc0x3cUFmaGM3S09KNnFDK3pvQkdP?=
 =?utf-8?B?eHhLNmk0MWpScDU2VUZMQ2wwRG9ySnB2WUt4eDdOaXg0aTBuL3JTdjhMd1Fp?=
 =?utf-8?B?OCtkWWtoOC9YWWRCR0kxckhuallKMWVzMGRFb2EveHdYb3RIRWhRam4xYUpx?=
 =?utf-8?B?QkQ4N2VNZnBwOWI4ZGxONmdrRlRmMkJXb21xM3Y0TWdDN0RKSU9Sak9DRi94?=
 =?utf-8?B?YlZoWng5cWY0eVExQnZxZTN4OTZsNWE4SWJhcEtvOTRScFNUL05jSXVTdk0r?=
 =?utf-8?B?bFlvenhwbFUwYnRucjJ1T2ZKb2dldExDMEF3d1JBa0lETVJBSmswRFlFZStU?=
 =?utf-8?B?Yjgrekk3YjB3ZG95MzBTNTFKQXFjM0Y3OUZGZTdpMldSbWJ2N3IrNG9XUmh5?=
 =?utf-8?B?VnBGN1FFamljRzRDWkRDUEo4T2pVVWY1dm5ySnRVQStBRHRXS3k5VWdVS0cz?=
 =?utf-8?B?RTRhT211VE4ycm5CK1FkM2s3ZThCQ2t2VXduWjBmb2tnQnFNR05TKzdLWnAy?=
 =?utf-8?B?a0xmTDIxTzNCNmpTdlNOZHoxRjNDUmhEdE5zY0lNVWtGd0Z2U1VwWm5ybzlE?=
 =?utf-8?B?Ums5VWhwZVdiUnZlaU1oWUhhdmNFanM1a1FtUTd2Sm9aeXZGU2JQUjdUWXh3?=
 =?utf-8?Q?IA0VCOT3YgJvKqmvcAhXxvZG3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11867ea7-4a14-4f4a-63e5-08de0d619be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 09:43:21.1538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1EVnjSye3PVMrYMrg6sfVQCBgSEVG1xdDJ9qF1xlqeAxdT9UHSg4fFTYgxZSbqcBWFytvTM3HybXRCxD/1KQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgWmhhbmdmZWksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhh
bmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMTcgT2N0b2JlciAy
MDI1IDA3OjI1DQo+IFRvOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNv
bT4NCj4gQ2M6IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4g
ZXJpYy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1
bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5hdGhh
biBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5j
b20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4g
amlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gc2hhbWVlcmtv
bG90aHVtQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAwLzI3XSBody9hcm0v
dmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXItY3JlYXRhYmxlDQo+IGFjY2VsZXJhdGVkIFNNTVV2
Mw0KPiANCiANCj4gSSBoYXZlIHRlc3RlZCB0aGlzIHNlcmllcyB3aXRoIHN0YWxsIGVuYWJsZWQu
DQogDQo+IFRlc3RlZC1ieTogIFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+
DQoNClRoYW5rcyBmb3IgdGhhdC4NCiANCj4gQnkgdGhlIHdheSwgdGhlIHN0YWxsIGZlYXR1cmUg
cmVxdWlyZXMgc29tZSBhZGRpdGlvbmFsIHBhdGNoZXMsIGluY2x1ZGluZyBwYWdlDQo+IGZhdWx0
IGhhbmRsaW5nLg0KPiBTaGFsbCB3ZSBoYW5kbGUgdGhhdCBhZnRlciB0aGlzIHNlcmllcz8NCg0K
WWVzLiBJIGFtIHdvcmtpbmcgb24gdjUgb2YgdGhlIHNlcmllcyBhZGRyZXNzaW5nIGNvbW1lbnRz
L2ZlZWRiYWNrIHJlY2VpdmVkIHNvIGZhci4NClNUQUxMIGNhbiBiZSBlbmFibGVkIGFzIGEgZm9s
bG93IHVwIHNlcmllcyBhcyBpdCBpcyBub3QgdGhhdCBzdHJhaWdodGZvcndhcmQg8J+Yig0KDQpU
aGFua3MsDQpTaGFtZWVyDQoNCg0KDQo=

