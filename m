Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B90C0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 10:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdoTb-0001Vg-Vz; Fri, 31 Jan 2025 05:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tdoTY-0001VP-Ir
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:42:16 -0500
Received: from mail-co1nam11on2070.outbound.protection.outlook.com
 ([40.107.220.70] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiw@nvidia.com>) id 1tdoTV-0001yl-V0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 05:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6voRsAHAED01boCoTnoQ4cc3Q9ovNCY1zs3/5fUTusb2vqOxmccsViKGLdwegOgsSLvTjWUT1SPmXj5Uqjw7Gw1NjL5SzbMZB2HGAArlnTCXZYbusCtirL+o1Rt1Je6GmtnIxNPr2FbCa7d0E/Qao3b6GTs5XlmKvv5Zzkf+7ulKZ/AXqjLOZxouSsGUABObGrJkSEdpqUd//IfUI0Vq/3jxENOe4KEG/HG1SWvzHES5PgooK69OEaA5GOMlebhNRaHB9CUDfjU8bYyqBRJu9MISUjhoFOyX8P/f5bSBL1PNRiUi/dDcAoWwq/Xt8lRgqaZdaYvk2z+CilxVVHyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVmhV8sqKBZGyrmsD/dv7yLCaf2O/Lix4+dvneUznm4=;
 b=cDiZ+ewxnZ4VoB6pgzeamySasTL7OXQhS9I/RajZt1GpURfN7rR4kd2b5E68cmePs5SOvt9OyxWVnWqiNZ5OqJxRbC6m2sOMzrQ43EoCKzF+g2jcD5UIXdz5rVc+aNOwveyk1UynQd3WIPBgKsNF7EGFS2Smth9IbNhl0+BjORZGoihP+XmJTZWSEi6bv52llNoUM+zAjgCtXWhQHPsVPa7Qc4oPtEeXph0jQzn6qBDKR11OFzt8bzftBTtk3/2YogMZGXw0bY7Q+y6MEZ1WAdngw/rGd8yMa16qt3/XB6QRDw6BPG2CyUSlINJG8B36S7gojQW95xxIBiZYxK5mPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVmhV8sqKBZGyrmsD/dv7yLCaf2O/Lix4+dvneUznm4=;
 b=LXfkT8Rzx/wwoQKa8ayib8Hna6xWJFOt6RoebCeVcF8p0bzi2tTORFaILXRJ2sClYmo/cea4a8jcMcG2QVCkWIzWN7oaowxDwKfbKL4vWFPTVWwzZzAEIBrzKiOkP2eZH0V+lJN8vshPvgYHUgOENe6itCOwFy30EvRtqT5IvV4q5Nb7owkYsJgK4y4+DBFLDHizyhS4dwP4Y0+7d/YVoEcjqmKUzwTeUAm0d27w21uNidVIphqxINAS/l2wd1Y8CCN5+OGv/bN0R2TZkL3pT+t0M+kA8U+j0b08kXrsqMEG8RIv8cPNszDTyzTw9qoHDp2gYkaQ9LQFjrn83e00CA==
Received: from SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 10:37:06 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 10:37:04 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%6]) with mapi id 15.20.8377.021; Fri, 31 Jan 2025
 10:37:03 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Alejandro Lucero Palau <alucerop@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "dan.j.williams@intel.com"
 <dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>, "fan.ni@samsung.com"
 <fan.ni@samsung.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>, Andy Currid
 <ACurrid@nvidia.com>, Neo Jia <cjia@nvidia.com>, Surath Mitra
 <smitra@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, "zhiwang@kernel.org" <zhiwang@kernel.org>
Subject: Re: [PATCH 0/3] Introduce CXL type-2 device emulation
Thread-Topic: [PATCH 0/3] Introduce CXL type-2 device emulation
Thread-Index: AQHbTJZ0G41BzI2+Dkac88XSNwFEobLi0mWAgAAWlwCAPrHfgIAPZB0A
Date: Fri, 31 Jan 2025 10:37:03 +0000
Message-ID: <2bbcd4f6-5da4-4c3e-be3d-e3f755090a4b@nvidia.com>
References: <20241212130422.69380-1-zhiw@nvidia.com>
 <eb417797-04aa-3572-02cf-5b858866edc7@amd.com>
 <7c8c7dd1-2e57-4a65-94f3-46ef6482474e@nvidia.com>
 <20250121153453.000062ee@huawei.com>
In-Reply-To: <20250121153453.000062ee@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|SJ2PR12MB8882:EE_|LV3PR12MB9401:EE_
x-ms-office365-filtering-correlation-id: 8872f9e4-f422-4e36-ac06-08dd41e333b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eDV1SHg5MGVpc2V5Z1BOQ2w0TzNhRnVXOTJLUlpNV3R6a2FEZ3Z6bW10aHYy?=
 =?utf-8?B?dTBVeWxmeUlZdm5rQWZLZ0dIQXhEaEQzS01Yck16STlpbGJIUTQ4TEI0VmNw?=
 =?utf-8?B?alRtZWdlNW9TQnJUb3dtNDFFWXVlaGZPQTF1YWtrQ3ZLdWI0dENmU3p4NWFO?=
 =?utf-8?B?Z1d3VzhuazBPVldWU09UalZiMGdzdms0QnF6M2tUSFl1WUVGYW96QXFDUHF6?=
 =?utf-8?B?ZFlJSGdMWHc3QTBLTmlhajNHRVQ3TFlyYU13MHp6d1RoV05jNFBwbHd3MU9a?=
 =?utf-8?B?WUVMSngwNkNiZEQxZjZ3R3BDYTdML0RKZ3N0QUY0M0psVUN5c0x5QUlkSGxL?=
 =?utf-8?B?cUdLWmg2UVVJVktVSk5yRDFCa0RiV2loOTZtOTBGZ1RsVWZXN3pTbWo3cEt6?=
 =?utf-8?B?OWRkT1RUa1lRRHJLYWRXTnd5bm1ORnZXOEx6aVNFS2tTWWs1cFROQmxycUVw?=
 =?utf-8?B?SmV0c213THVMVVFmL3dMKzlHUnZLMk5RT0JLa05PdXVWZ2s0QU1vRWpOTWlO?=
 =?utf-8?B?bDg4RXppdHNmYnN1NmVibWVuN0NtYjdaL0RGMFBSYnEwRVlSbmVTRVFudy9q?=
 =?utf-8?B?QXhOdUNBczkraG1DRlNwcGQ3RmxZdUsybjE2Wm9qNXJBRnZMajBzdHBpWEo4?=
 =?utf-8?B?MldmakNIM1YyTHBzT2c5K1JaQURvQ0dVb2RXTi9QSEprNnJ3eWpkZHBuS2pp?=
 =?utf-8?B?NnlLUjF5cFpCb3hHanV5NkpSemxYS0lnMjFwejBjNFVBbGltdzRaL1pkT0tM?=
 =?utf-8?B?a05kTEhRVzJ1ckpUVXZqdStZeTBxcWtlcC9jWUQ5WkNmTGppelc1OGZHYjg2?=
 =?utf-8?B?b3dEc011VENqZk1HNTZTNmtMZ1pXWHhCQjE5cXpPcDVobEJuRWU2SXpJK3ly?=
 =?utf-8?B?WEg0SU55bmRTaDVwNHpMWWlHMW5NUlFyNjdzUUZDN1FpUkhQZXlkMUpDczVi?=
 =?utf-8?B?L1lJK2pUTkRmREMvWUVDSUgwcEVETXFyb2VkL2t2Q1NKb3AvMzRBTUhqT0xo?=
 =?utf-8?B?dDZHazl4bW1xbkZrN0t4cUdaTTkzbVB4M1J3SFE0TFJtS1g0RUc1OWhsNHBj?=
 =?utf-8?B?Umd1SWdiNDNzNVRjN3JBWUJvV2V2UDNDWE5UdVcwbm80Y1dzSXZJOTJOeTda?=
 =?utf-8?B?WTA3ZkljQXFlMzhJNnRqZyswb0VWaXBIdVFUV2Z3ekFQcjRoeXA3MkF1bmp3?=
 =?utf-8?B?SkNxcHczWGxkenFrZ3RCRGJKMVFvV0NJWVgwNndtSzU4TkRxTGpZajBJQnp5?=
 =?utf-8?B?MHRsVFgvK0hKZUFPV1BtQlM1TDRQSmpSVXhWWGt2cmFLeGVKeXVqZUh3eGdO?=
 =?utf-8?B?OVNzcis1R3pXSWZGWFVXNVZVSXBmMDd5QWxPeWxUNVZ1NjlscitGQTNDVXpT?=
 =?utf-8?B?MXlTS1ZEY0hwSGQ0a01HM01YdXd2Zzc3WHBuLzNHTGFDQTQ2QnVhclZUQ3BH?=
 =?utf-8?B?NDRxSWdJNWxsTUkwRWJBbVZqVzBjbmVOZ0dOM0FCeUF5ZFZHYVJTNHR6ODUx?=
 =?utf-8?B?TGdUY2l6dmx5VzlrQm40TC8zd2RIY2twOC8ra3daZ2RFa002aUtGMFVhdjYz?=
 =?utf-8?B?Tnp5RGM1M0wvejZ0MDVnVDhsaHdNYjRJM2hSUUp3bXlKZHVFUlVaeGRmd3FH?=
 =?utf-8?B?bkdlVTQzMzJPeWJqazdwYkxRUFNoYm01NGdyTFM4VjA4My9BT09RV2Nlb0hH?=
 =?utf-8?B?VndFTW05a084K3EyZ2grQkJrWVRWUGlPNkRKL0kwamdRREtlcld3dHkrYkc3?=
 =?utf-8?B?d3dLSHUxZVN0TWRzNFlwZllwcHliakN1YXAwVm9VRjBIMGpqSUFEQjJ4SG1v?=
 =?utf-8?B?L1dvMHBWc2Rjald2U2pLNTl5TzhVNXB5ay9BVkNndWNUaGZOd3BwNEhFVlFS?=
 =?utf-8?Q?ykNIO5qMLFMoS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(13003099007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnkwdE10d0lrczZLM3E3RnEzK2Zib1pJWS9OcHBGYm8rakdxbjVqQ1pseloy?=
 =?utf-8?B?K0RxbWlxSCtrOTBwcWF4SHRINitzZTRTdUozZEtYVW5LYTVsUVlVY3dDdnJs?=
 =?utf-8?B?MTNGck9rS1VtN25sSEc5SXROcHAxVUs0SjV4c0V0ME52aThxdGl0TFVhZTZh?=
 =?utf-8?B?MU95ZEhReFNLSE54bGg1TWhJWW9DVzRibnBPN1diUVN2VGQxdjFsTW4zWU9z?=
 =?utf-8?B?NVRFcFFNM1FwbldOVjI2bjV1d2R2WjJtN0s4UEdJL1k1NEREakFhN05ybEVG?=
 =?utf-8?B?RU9WdGFvcXZ3bHpWMUphQ3hhS0lvWEpBVTdjNWloN1Z3TldISjF2L282RU15?=
 =?utf-8?B?NEQ2ZWVOY2xkMFI5M0w0WlprVkVUSCtZemYvMEllRFhCRW5KZGt0ajNiUUZN?=
 =?utf-8?B?T0szWVBpQjA0empUMkV6QWJSM2ZFK0g0VkltdUlYRjJuNjRPekFOV3NuRDhV?=
 =?utf-8?B?bGFadEszdVBOUXFkN3hrUXo5V1FOVXZBOU9QUjJNT2Z0bHAvb1V4a2kwMGNE?=
 =?utf-8?B?RUdYbys3OEEraTY5QW0zbnBTaWtzMEhlNi9RcVRqSUI1QWF3bVhmRGRURXpi?=
 =?utf-8?B?NnFVanM1TkZEMVRuNDhKWjBrOERnbHNJT283bnUvWDVpVU9YZDFLU2xCZnQz?=
 =?utf-8?B?QkNZN0NQTTBTNldOaWJTL0RrNWNKZ2xYSi80T3hIVDQ4V1dxcUQ1aFgrbXVF?=
 =?utf-8?B?NEdwM1lzWVBTd1dtdm1iZktuTWRLTTUzT0tSYVlwMXlRTXJBVVRGNm1wYXBw?=
 =?utf-8?B?OWtVZExHaTRCR0ZmcE1NSlVodGVtZmdsU3JrYVJQZjZhbnN3bXE3ZHM3djNq?=
 =?utf-8?B?a29lOEVnd1dnbWVYay9pcDU5WmVTMnE1N2J1ajcrS0s5UlBhVFhOcWFUbUlB?=
 =?utf-8?B?TThTbEJTamh5QmdkZFFPKzdOOVlHckloaENsbWVvaWxzOTM2bHJjcjlFTGI0?=
 =?utf-8?B?OUpWSWZuUEdRTUQ2N1lnVEI1SjM4QjFIL0FFTVA4bHE2djJiM3UxMW5EQkda?=
 =?utf-8?B?SXIyRjBybjJkTWV0OUVoUXhMTkpKOE0xSzdUeHJacHlBd2Q1N0l6dGIzcXdm?=
 =?utf-8?B?alVlaWgxVC9NU0lJRjdVd1lTSGFTWUJxci9UcXNVWDZqN3NhQUMxeFNqbUda?=
 =?utf-8?B?dzMyVE9Jb000WXdIVm51d3c1UmJyWFR3Mng4NmpLakZSUWQ2WHBlNHZURVpu?=
 =?utf-8?B?SHZYVi9YRlBtUEFXZGs5OWFSUlhBamVRbGVXREJmcGF4RWgzMlhNWlE5M2JY?=
 =?utf-8?B?MC9LdHhqQVVsU3FjWXZlYjE4NFhnY051ZGZHYk1ESm5Ma3M4bGZ6MjA5NUYy?=
 =?utf-8?B?dXVCR0RybEJ2NnVDZ2lkZVZrbnpzM25wbnVXaURMd05PbnJKNkxUbUJsYmdP?=
 =?utf-8?B?cU1oUXl6TTU3a0JDbzBjS0ZyVWljdUJVTE0wdVZQeHUweFk2U3FFbktNVjdP?=
 =?utf-8?B?dDc4dkZLejVYcThRWDltVDhRY3JDNVhiQjY2MUNsSGN3MndWZWZwLzU1Nm1l?=
 =?utf-8?B?cEZyKzFkRGFVcHFjNXp4TnYxTHp3a1NiT1NXSnIraGlDTWJtWmE4YWxIbEtE?=
 =?utf-8?B?WnIwRjFMZzBSMWNQbnFmOUE1Y1BVODZwa05HTy92clNGcXg4emhpUmd3cXlj?=
 =?utf-8?B?SFZaWmF4WWxZYTR3RGNld2QyOGl2TjRWT05rY3phU3hyWkllSTBLSkRieUI2?=
 =?utf-8?B?ajFpL2FwR1B2eUpHS2xjWjM0dndZV3NHSjZ3NlZiWlFPaHY1NDRnQWlNNjdW?=
 =?utf-8?B?YzJMQjZLdTZydEZyYU42bU5OamIrQ3dlOUxqcGl0RU9SbHRsMHlDdU8wTWZI?=
 =?utf-8?B?RjBTV2RFWHpMMUxoSVV2Ny9PWlZjSTg2V29XTWpNTzBnUFJ3SjY2Vk5GOUZv?=
 =?utf-8?B?VzN3aG4rRlNWUGJIaHlmYTdRZVdiWHZubWVxdllhQjBmYWVoRWZBRTVwNDVU?=
 =?utf-8?B?c1RsSkRnNjM4aDVsTWF6VzB5YjkzTWlOMXBxNWNJNHh4ckpraFhyR09EUEhV?=
 =?utf-8?B?UEMyWGFtQWJjMVRVT21nekhkQkV5RUN1K1EyUkdCelM1K1BIYTFFNGJoUFly?=
 =?utf-8?B?MVFtUFhsTzVXeCtYT3VoTEVjU0o0djFka3BBenhMejc0aklxVHl6RUV1VGg1?=
 =?utf-8?Q?KH4I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7B92891E0ED144CBEBAA0277A9A7175@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8872f9e4-f422-4e36-ac06-08dd41e333b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 10:37:03.6913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8t5ezjsyIBxXEQCCR1/acN/B1sq6tgGgGBGfInYVT1B+3IKL2+seSshUwR3XDiL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
Received-SPF: softfail client-ip=40.107.220.70; envelope-from=zhiw@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gMjEvMDEvMjAyNSAxNy4zNCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVGh1LCAx
MiBEZWMgMjAyNCAxODoxMDoxMCArMDAwMA0KPiBaaGkgV2FuZyA8emhpd0BudmlkaWEuY29tPiB3
cm90ZToNCj4gDQo+PiBPbiAxMi8xMi8yMDI0IDE4LjQ5LCBBbGVqYW5kcm8gTHVjZXJvIFBhbGF1
IHdyb3RlOg0KPj4+DQo+Pj4gT24gMTIvMTIvMjQgMTM6MDQsIFpoaSBXYW5nIHdyb3RlOg0KPj4+
PiBIaSBmb2xrczoNCj4+Pj4NCj4+Pj4gUGVyIHRoZSBkaXNjdXNzaW9uIHdpdGggSXJhL0pvbmF0
aGFuIGluIHRoZSBMUEMgMjAyNCBhbmQgaW4gdGhlIENYTA0KPj4+PiBkaXNjb3JkIGNoYW5uZWws
IHdlIGFyZSB0cnlpbmcgdG8gaW50cm9kdWNlIGEgQ1hMIHR5cGUtMiBkZXZpY2UgZW11bGF0aW9u
DQo+Pj4+IGluIFFFTVUsIGFzIHRoZXJlIGFyZSB3b3JrIGN1cnJlbnRseSBvbiBzdXBwb3J0aW5n
IENYTCB0eXBlLTIgZGV2aWNlIFsxXQ0KPj4+PiBpbiBMaW51eCBrZXJuZWwgYW5kIENYTCB0eXBl
LTIgZGV2aWNlIHZpcnR1YWxpemF0aW9uIFsyXS4NCj4+Pj4NCj4+Pj4gSXQgcHJvdmlkZXMgYSBi
YXJlIG1pbmltdW0gYmFzZSBmb3IgZm9sa3Mgd2hvIHdvdWxkIGxpa2UgdG86DQo+Pj4+DQo+Pj4+
IC0gQ29udHJpYnV0ZSBhbmQgdGVzdCB0aGUgQ1hMIHR5cGUtMiBkZXZpY2Ugc3VwcG9ydCBpbiB0
aGUgbGludXgga2VybmVsDQo+Pj4+ICDCoMKgIGFuZCBDWEwgdHlwZS0yIHZpcnR1YWxpemF0aW9u
IHdpdGhvdXQgaGF2aW5nIGFuIGFjdHVhbCBIVy4NCj4+Pj4gLSBJbnRyb2R1Y2UgbW9yZSBlbXVs
YXRlZCBmZWF0dXJlcyB0byBwcm90b3R5cGUgdGhlIGtlcm5lbCBDWEwgdHlwZS0yDQo+Pj4+ICDC
oMKgIGRldmljZSBmZWF0dXJlcyBhbmQgQ1hMIHR5cGUtMiB2aXJ0dWFsaXphdGlvbi4NCj4+Pj4N
Cj4+Pj4gVG8gdGVzdCB0aGlzIHBhdGNoc2V0LCBwbGVhc2UgcmVmZXIgdG8gc3RlcHMgaW4gWzNd
LiBVc2UgdGhpcyBwYXRjaGVzZXQNCj4+Pj4gd2l0aCB0aGUgbGF0ZXN0IFFFTVUgcmVwbyB0byBi
ZSB0aGUgUUVNVSBob3N0LiBJdCBhY2hpZXZlcyB0aGUgc2FtZQ0KPj4+PiBvdXRwdXQNCj4+Pj4g
YXMgaW4gdGhlIGRlbW8gdmlkZW8gWzRdOiBUaGUgVkZJTyBDWEwgY29yZSBhbmQgVkZJTyBDWEwg
c2FtcGxlIHZhcmlhbnQNCj4+Pj4gZHJpdmVyIGNhbiBiZSBhdHRhY2hlZCB0byB0aGUgZW11bGF0
ZWQgZGV2aWNlIGluIHRoZSBMMSBndWVzdCBhbmQNCj4+Pj4gYXNzaWduZWQNCj4+Pj4gdG8gdGhl
IEwyIGd1ZXN0LiBUaGUgc2FtcGxlIGRyaXZlciBpbiB0aGUgTDIgZ3Vlc3QgY2FuIGF0dGFjaCB0
byB0aGUNCj4+Pj4gcGFzcy10aHJ1ZWQgZGV2aWNlIGFuZCBjcmVhdGUgdGhlIENYTCByZWdpb24u
DQo+Pj4+DQo+Pj4+IFRlc3RlZCBvbiB0aGUgQ1hMIHR5cGUtMiB2aXJ0dWFsaXphdGlvbiBSRkMg
cGF0Y2hlcyBbM10gd2l0aCBhbiBleHRyYQ0KPj4+PiBmaXggWzVdLg0KPj4+Pg0KPj4+PiBbMV0g
aHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/DQo+Pj4+IHVy
bD1odHRwcyUzQSUyRiUyRmxvcmUua2VybmVsLm9yZyUyRmxpbnV4LQ0KPj4+PiBjeGwlMkYyMDI0
MTIwOTE4NTQyOS41NDA1NC0xLWFsZWphbmRyby5sdWNlcm8tDQo+Pj4+IHBhbGF1JTQwYW1kLmNv
bSUyRlQlMkYlMjN0JmRhdGE9MDUlN0MwMiU3Q3poaXclNDBudmlkaWEuY29tJTdDM2E2MTEzOWJm
MzU1NGY0ZjM4ZjQwOGRkMWFjY2YxYjklN0M0MzA4M2QxNTcyNzM0MGMxYjdkYjM5ZWZkOWNjYzE3
YSU3QzAlN0MwJTdDNjM4Njk2MTg5NzYxMzkwOTE5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5
SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJ
c0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT02V3pp
S253TWxaSlE0eXhUMmpMbjdXMVNvME9mcVlzczc4Zk9vc3VMaXdBJTNEJnJlc2VydmVkPTANCj4+
Pj4gWzJdIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vPw0K
Pj4+PiB1cmw9aHR0cHMlM0ElMkYlMkZ3d3cueW91dHViZS5jb20lMkZ3YXRjaCUzRnYlM0RlNU9X
MXBSODRacyZkYXRhPTA1JTdDMDIlN0N6aGl3JTQwbnZpZGlhLmNvbSU3QzNhNjExMzliZjM1NTRm
NGYzOGY0MDhkZDFhY2NmMWI5JTdDNDMwODNkMTU3MjczNDBjMWI3ZGIzOWVmZDljY2MxN2ElN0Mw
JTdDMCU3QzYzODY5NjE4OTc2MTQxMzAzOSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhC
MGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZP
SWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9aFRGJTJGMUkl
MkI0ZllQUWVDejdOaE0wdXZXZCUyRnJXZkl6YUtkY3RlRDUlMkJyY1owJTNEJnJlc2VydmVkPTAN
Cj4+Pj4gWzNdIGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
Pw0KPj4+PiB1cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZrdm0lMkYyMDI0MDky
MDIyMzQ0Ni4xOTA4NjczLTMtDQo+Pj4+IHpoaXclNDBudmlkaWEuY29tJTJGVCUyRiZkYXRhPTA1
JTdDMDIlN0N6aGl3JTQwbnZpZGlhLmNvbSU3QzNhNjExMzliZjM1NTRmNGYzOGY0MDhkZDFhY2Nm
MWI5JTdDNDMwODNkMTU3MjczNDBjMWI3ZGIzOWVmZDljY2MxN2ElN0MwJTdDMCU3QzYzODY5NjE4
OTc2MTQyNTY0NiU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRX
VXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxk
VUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9V3EzbXIwbVhaQ2JHM2NYUktsaWJxJTJC
a3NUdXdMOFJHcWlVUzlqQkZEZkRZJTNEJnJlc2VydmVkPTANCj4+Pj4gWzRdIGh0dHBzOi8vbmFt
MTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vPw0KPj4+PiB1cmw9aHR0cHMlM0El
MkYlMkZ5b3V0dS5iZSUyRnpsa19lY1g5YnhzJTNGc2klM0RwZjlDdHRjR1Q1S3dVZ2lIJmRhdGE9
MDUlN0MwMiU3Q3poaXclNDBudmlkaWEuY29tJTdDM2E2MTEzOWJmMzU1NGY0ZjM4ZjQwOGRkMWFj
Y2YxYjklN0M0MzA4M2QxNTcyNzM0MGMxYjdkYjM5ZWZkOWNjYzE3YSU3QzAlN0MwJTdDNjM4Njk2
MTg5NzYxNDM3NzgwJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5
ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJ
bGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1TUmVUbkJVQzFiSWhCd0MlMkJ2QVND
WFglMkYwbHRJWWNmV0FrSFhNbWklMkZUUlJnJTNEJnJlc2VydmVkPTANCj4+Pj4gWzVdIGh0dHBz
Oi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vPw0KPj4+PiB1cmw9aHR0
cHMlM0ElMkYlMkZsb3JlLmtlcm5lbC5vcmclMkZsaW51eC0NCj4+Pj4gY3hsJTJGMjAyNDEyMTIx
MjM5NTkuNjg1MTQtMS0NCj4+Pj4gemhpdyU0MG52aWRpYS5jb20lMkZUJTJGJTIzdSZkYXRhPTA1
JTdDMDIlN0N6aGl3JTQwbnZpZGlhLmNvbSU3QzNhNjExMzliZjM1NTRmNGYzOGY0MDhkZDFhY2Nm
MWI5JTdDNDMwODNkMTU3MjczNDBjMWI3ZGIzOWVmZDljY2MxN2ElN0MwJTdDMCU3QzYzODY5NjE4
OTc2MTQ0OTU4OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRX
VXNJbFlpT2lJd0xqQXVNREF3TUNJc0lsQWlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxk
VUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9cG1aOEpOY3RVbGNMRndRTGl2Tk1rSGo3
Zk10MlBSMjRlJTJCdUhZJTJCazdiTkElM0QmcmVzZXJ2ZWQ9MA0KPj4+Pg0KPj4+PiBaaGkgV2Fu
ZyAoMyk6DQo+Pj4+ICDCoMKgIGh3L2N4bDogZmFjdG9yIG91dCBjeGxfaG9zdF9hZGRyX3RvX2Rw
YSgpDQo+Pj4+ICDCoMKgIGh3L2N4bDogaW50cm9kdWNlIGN4bF9jb21wb25lbnRfdXBkYXRlX2R2
c2VjKCkNCj4+Pj4gIMKgwqAgaHcvY3hsOiBpbnRyb2R1Y2UgQ1hMIHR5cGUtMiBkZXZpY2UgZW11
bGF0aW9uDQo+Pj4+DQo+Pj4+ICDCoCBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4+PiAgwqAgZG9jcy9zeXN0ZW0vZGV2aWNlcy9j
eGwucnN0wqDCoMKgIHzCoCAxMSArKw0KPj4+PiAgwqAgaHcvY3hsL2N4bC1jb21wb25lbnQtdXRp
bHMuY8KgwqAgfCAxMDMgKysrKysrKysrKy0NCj4+Pj4gIMKgIGh3L2N4bC9jeGwtaG9zdC5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE5ICstDQo+Pj4+ICDCoCBody9tZW0vS2NvbmZp
Z8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDUgKw0KPj4+PiAgwqAgaHcv
bWVtL2N4bF9hY2NlbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMzE5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgwqAgaHcvbWVtL2N4bF90eXBlMy5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2MSArLS0tLS0tDQo+Pj4+ICDCoCBody9tZW0vbWVzb24u
YnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+Pj4+ICDCoCBpbmNsdWRl
L2h3L2N4bC9jeGxfY29tcG9uZW50LmggfMKgwqAgNyArDQo+Pj4+ICDCoCBpbmNsdWRlL2h3L2N4
bC9jeGxfZGV2aWNlLmjCoMKgwqAgfMKgIDI1ICsrKw0KPj4+PiAgwqAgaW5jbHVkZS9ody9wY2kv
cGNpX2lkcy5owqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4+PiAgwqAgMTEgZmlsZXMgY2hhbmdl
ZCwgNDg0IGluc2VydGlvbnMoKyksIDY5IGRlbGV0aW9ucygtKQ0KPj4+PiAgwqAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGh3L21lbS9jeGxfYWNjZWwuYw0KPj4+PiAgIA0KPj4+DQo+Pj4gSGkgWmhpLA0K
Pj4+DQo+Pj4NCj4+PiBUaGFuayB5b3UgZm9yIHRoaXMgcGF0Y2hzZXQuDQo+Pj4NCj4+Pg0KPj4+
IEnCoCBoYXZlIGEgc2ltaWxhciB3b3JrIGRvbmUgZm9yIGhlbHBpbmcgaW4gdGhlIFR5cGUyIHN1
cHBvcnQgd29yaywgYnV0DQo+Pj4gaXQgaXMgYWxsIHF1aWNrLWFuZC1kaXJ0eSBjaGFuZ2VzLg0K
Pj4+DQo+Pj4NCj4+PiBNeSBtYWluIGNvbmNlcm4gaGVyZSBpcyB3aXRoIHRoZSBvcHRpb25hbCBm
ZWF0dXJlcyBmb3IgVHlwZTI6IGhvdyB0bw0KPj4+IGNyZWF0ZSBhbiBlYXN5IHdheSBmb3IgY29u
ZmlndXJpbmcgVHlwZTIgZGV2aWNlcyB1c2luZyBzb21lIHFlbXUgY3hsDQo+Pj4gcGFyYW0uIEkn
bSBhZnJhaWQgSSBkaWQgbm90IHdvcmsgb24gdGhhdCBzbyBubyBzdWdnZXN0aW9ucyBhdCBhbGwh
DQo+Pj4gICAgDQo+Pg0KPj4gSGkgQWxlamFuZHJvOg0KPj4NCj4+IE5vIHdvcnJpZXMuIFRoZSB3
b3JrIGlzIHRvIHByb3ZpZGUgYSBtaW5pbXVtIGJhc2UgZm9yIENYTCBmb2xrcyBhbmQgQ1hMDQo+
PiB0eXBlLTIgZm9sa3MgdG8gc3RhcnQgd2l0aCwgZS5nLiBpbnRyb2R1Y2luZyBtb3JlIGVtdWxh
dGVkIGZlYXR1cmVzLiBBcw0KPj4gdGhlIHR5cGUtMyBlbXVsYXRpb24gaGFzIGJlZW4gcXVpdGUg
Y29tcGxpY2F0ZWQgYW5kIEkgd2FzIHRoaW5raW5nIG1heWJlDQo+PiBoYXZpbmcgYSBjbGVhbiBz
dGFydCB3b3VsZCBoZWxwLiBGb3IgcmUtZmFjdG9yaW5nLCBJIHdhcyBtb3N0bHkgdGhpbmtpbmcN
Cj4+IG9mIGEgc3RlcCBieSBzdGVwIHN0eWxlOiBFLmcuIHdoZW4gYm90aCBlbXVsYXRpb24gb2Yg
ZGV2aWNlcyBhcmUNCj4+IHJlYWNoaW5nIGEgcG9pbnQgdG8gaGF2ZSB0aGUgY29tbW9uIHJvdXRp
bmVzLCB0aGVuIHdlIHJlLWZhY3RvciB0aGVtIG9yDQo+PiBkcmF3IGEgZ2x1ZSBsYXllci4NCj4+
DQo+PiBBbHNvLCB0aGUgcGF0Y2hzZXQgaXMgZ29vZCBlbm91Z2ggZm9yIHBlb3BsZSB0byB0ZXN0
IG91ciB3b3Jrcy4NCj4+DQo+PiBJZiBmb2xrcyBhcmUgT0sgb24gdGhpcyBtaW5pbXVtIGVtdWxh
dGlvbiwgSSB0aGluayB0aGUgbmV4dCB0aGluZyB3b3VsZA0KPj4gYmUgbWVhbmluZ2Z1bCBmb3Ig
dXMgaXMgYWxpZ25pbmcgdGhlIHBsYW4gZm9yIHdoYXQgZmVhdHVyZXMgdGhhdCB3ZSB3YW50DQo+
PiB0byBwbHVnIGludG8gdGhpcywgc28gdGhhdCB3ZSBjYW4gc2hhcmUgdGhlIGVmZm9ydHMuDQo+
Pg0KPj4gVGhlIGl0ZW1zIG9uIG15IGxpc3QgYXJlOg0KPj4NCj4+IC0gTG9ja2VkIEhETSBkZWNv
ZGVyDQo+PiAtIENEQVQgYW5kIERPRQ0KPj4NCj4+IEkgcmVtZW1iZXJlZCB5b3Ugd2VyZSB0YWxr
aW5nIGFib3V0IHRoZSBjb25maWd1cmF0aW9uIHBhcmFtcywgSSB0aGluayBpdA0KPj4gY2FuIGJl
IHZlcnkgaGVscGZ1bCBvbiBwcm90b3R5cGluZyBkaWZmZXJlbnQgZmVhdHVyZXMgaW4gdGhlIGtl
cm5lbCBhcw0KPj4gd2VsbC4gRmVlbCBmcmVlIHRvIHJlYWNoIG91dCBmb3IgZGlzY3Vzc2lvbnMu
DQo+Pg0KPiBSYXRoZXIgdGhhbiB0cnkgdG8gc3VwcG9ydCBldmVyeSBjb21iaW5hdGlvbiB1bmRl
ciB0aGUgc3VuLCBJJ2Qgc3VnZ2VzdA0KPiBhIGNvdXBsZSBvZiByZXByZXNlbnRhdGl2ZSBjaG9p
Y2VzLiAgIEFueW9uZSBkZXZlbG9waW5nIHRoZSBrZXJuZWwgY2FuDQo+IGNvbWUgYW5kIHR3ZWFr
IGlmIHRoZXkgbmVlZCBvdGhlciBjb21iaW5hdGlvbnMgb2YgZmVhdHVyZXMuDQo+IA0KPiBUeXBp
Y2FsIHRlc3QgY2FzZXMsIHNvIGV2ZXJ5dGhpbmcgb24sIGV2ZXJ5dGhpbmcgb2ZmLCBhIG1peCBv
cg0KPiB0d28gb2YgZmVhdHVyZXMgb24uDQo+IA0KPiBUcnlpbmcgdG8gbWFrZSBzb21ldGhpbmcg
cmVhbGx5IGNvbmZpZ3VyYWJsZSB2aWEgcGFyYW1ldGVycyB3aWxsIGVuZA0KPiB1cCB3aXRoIG5v
bnNlbnNlIGNvbWJpbmF0aW9ucyBhbmQganVzdCByZXZlYWxpbmcgYnVncyBpbiB0aGUgcWVtdSBl
bXVsYXRpb24NCj4gcmF0aGVyIHRoYW4gd2hhdCB3ZSBhY3R1YWxseSB3YW50IHRvIHRlc3QuDQo+
IA0KPiBJZiB5b3Ugd2FudCB0byBnbyByZWFsbHkgZ2VuZXJhbCB0aG91Z2ggZmVlbCBmcmVlIHRv
IHBpdGNoIGl0IGFuZCB3ZSdsbA0KPiBzZWUgaG93IGJhZCBpdCBpcy4NCj4gDQoNCkFncmVlLg0K
DQpJIGFtIGxlYXJuaW5nIHRvd2FyZHMgdGhlIHN3aXRjaGVzIHNob3VsZCBiZSB1c2UtY2FzZS9k
ZXZpY2UtZmVhdHVyZSANCm9yaWVudGVkIGFuZCB0aGF0IHdvdWxkIGJlIG1vcmUgYWxpZ25lZCB3
aXRoIHRoZSBwdXJwb3NlIG9mIHRlc3QgYW5kIHRoZSANCnJlcXVpcmVtZW50IGluIHJlYWxpdHku
IElmIHRoZXJlIGFyZSByZWFsbHkgc29tZSBzcGVjaWFsIGNhc2Ugb2YgYWRkaW5nIA0KYSBxdWly
ayBvciBzb21ldGhpbmcsIHdlIGNhbiBqdXN0aWZ5IHRoZW0gY2FzZSBieSBjYXNlLg0KDQpaLg0K
PiBKb25hdGhhbg0KPiANCj4+IFouDQo+Pg0KPj4+DQo+Pj4gVGhhbmsgeW91DQo+Pj4gICAgDQo+
Pg0KPiANCg0K

