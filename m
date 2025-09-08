Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010AACAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvatt-0005Tj-R2; Mon, 08 Sep 2025 08:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvatk-0005Ak-E1; Mon, 08 Sep 2025 08:23:05 -0400
Received: from mail-bn1nam02on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:2407::62a]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvata-0002hA-Ef; Mon, 08 Sep 2025 08:23:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKlBq+Fg8Ctm+ooDKkntrbymno9X/hoaw1V8qQ1qvgywHtARvc0bHzwhWIPrvVG3VI5uriBOQC2ohzJzhQTSIto0kWwonhfIDHl5lz8JfrOX+OukBxrbIYFjcKfgNld3wH6TfhTQkcZ0Wj/xLxRdJNS2OOZz94dXFjkVONIcvyDdQMs3pL0usZCNAsYu3yxRA2DrxJzRdoT89pxCWKSKNxfgwDiYnJk+U9KdhfWQYX4LD53pxw5a4EYDOrD+eN+PlJHbRTknHxhESdQBWF/zANYKcs1JFU3B1lTlcT3/IIhi6S6BfWDDvNmxHLfp6EVd24ZBjCIQpPO9BfrZ7eqBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bk64m3e4UWn+18kj9y1VPAz5Pjv0pLUdTCk5wjilwk=;
 b=xuHMWi4Na2/E4nERk9wANcWuNkYNowCjP/rrjesEYrXkd6OEyIUaxN2Dg6FzAn636AO5AdmbgLwHxfm8jc6KnttrzH7r9/CfV3xnhUQgiZlDUV56+YQDM0HVs+YWu92cl16hTMJgW6LvznkrrXZzQ+NjomHzmL+TMp6lmT8D+BztnOaFKx22BLyyXqBFnq+T0Ec4KYObneYEoBCtonJy8F0isjm5cnfhg/rZYBYSz7hq2XaSqQp0DhKBXP/V6jIIMJy5UOH1nSvy9svTKUWiTLm2kOWRxSvhZcKlbYCOUJH6pOomUfYW1RYGqIRIu4OLCUsDJd36XiTakdYPvbaFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bk64m3e4UWn+18kj9y1VPAz5Pjv0pLUdTCk5wjilwk=;
 b=bK09F/g/bXcPvSZJ6IYIvYadKJOgKAVWrnFHAUoAPfZxQKQ1qDoo0IqAfmM9T+yb2sVx1P94xw8GZsBFiPwAzkKJPoao+n3p3PCOTfoLKtZxs5TPvc4QEvjXFZuB2uWhOc+kFZy4XMz6nz0yeSrI/yn48NHm1jCc4sbjVfND29v/aYgTh8HICjptTfP40ttIJrPWIMbuX4U/xOH03aUrPodzMDCSn+5myH9uhdvM8JCTmTVkhYFyVCLTmB1j3uBk/b0j9nQ3SMLitiSS2goGZOHpF6iXbP73hVAAPeP2GHND1pteT2oQ2AfgBTnjJXNfc1i9PKAHg7byoSIX3pHu7Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 8 Sep 2025 12:22:36 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 12:22:35 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation commands
 to hw
Thread-Topic: [RFC PATCH v3 13/15] hw/arm/smmuv3: Forward invalidation
 commands to hw
Thread-Index: AQHcHmMClPvsX+w3SEqupbuCkXg0B7SJE65g
Date: Mon, 8 Sep 2025 12:22:35 +0000
Message-ID: <CH3PR12MB7548543A976A65B74DA6EA42AB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-14-shameerali.kolothum.thodi@huawei.com>
 <5ab38eaa-b005-432a-9de7-fae3e6096f89@redhat.com>
In-Reply-To: <5ab38eaa-b005-432a-9de7-fae3e6096f89@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB6112:EE_
x-ms-office365-filtering-correlation-id: b64aad31-98ba-4724-73b1-08ddeed264c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?L0hlRW50K3l6SGVQdWZ5aFpHQnlqVElHWGxDR0hBdUV4ZWI0OFFVR0YxUjZp?=
 =?utf-8?B?UXNwcVdvTEppS29LQ0lvRW96Zzd0TUsrZFpvalV5UGNldGZiZHQrOXcyZnpK?=
 =?utf-8?B?VmFzRUhCOWtYR294K2xvdjZCY1BHNUU0ejlMZmIzaWhEK3V0ZFkyelQ4cGNa?=
 =?utf-8?B?cnJBMVQ5QmNSeGRZeTJhR012WDRTK0hVeFAzUjU4WmxpZU5xMGFUcUYzbFc2?=
 =?utf-8?B?ZEFFL1Yxa1Zkc20wMDJTZFNwTGlYeWNORFZxemh3dHZwdFQ3S0dTejc3Z3Mr?=
 =?utf-8?B?eGtjUllSOWxxblJJWWIvZGR2TWJWUzVBWEVCT2hHckxIa3RQTmVGL3EvNkFX?=
 =?utf-8?B?cnBOcnpLcy9KMzNTV1VadGRoZkRmWTlmTTdzNDI4ZEFFOUxDYW91ekR4N25o?=
 =?utf-8?B?U3NENW5ZVkF0eVg4bkJSQVh4VFB1S1FNWC9VS0hhZFR2cERmdm1hR2FmaEty?=
 =?utf-8?B?TUEwRE9hbjJJQmNtZUtjWjZSWGVIcHVoSCtKZkxPS29jZHJWOTJTa1VOeU96?=
 =?utf-8?B?d1MwNkdhVVBJSkJNaTRsWXhBNHpZUlIxMmp3TW8wTVgxSUM2UVZweTR3YVE0?=
 =?utf-8?B?cGdRbXgrSWhHRjNSUVVzOEpnOXJUNCt3dEg3VDUvbW40Wjk3K0N5aWtvdDNh?=
 =?utf-8?B?SzZKRzg1R1o4VEpkcWZJT0tnTnNoNk1sdzd4V0RueHlESGl0RWt3azNGMEk2?=
 =?utf-8?B?dkpjZmhWdGlzODNGS0VpaWQyMWUyQjdUeHBOL29sUzc2K0d0YTFmVkNseTly?=
 =?utf-8?B?ck5zN1ZkV0FJM0thTytoZEZwbXRocDRoY0sxS1hkbk1IR0JjbE9ZcHJINWJx?=
 =?utf-8?B?Vjg0WjdJckNFMVpXZ0Rnc0dNM3JJSzRXZ0k1TUJVUmFzeVZvdk5KZkNRbTVv?=
 =?utf-8?B?MStwRlZ0WExMSmVweU9Ua3RPSzA3a2FVVU5MdHpsbUVpQU1DR2hYaWJ2aGVW?=
 =?utf-8?B?aFJsZzZ5T1kzdElIYmJHQk0xRUQvVWRpc3VWSG5KYTdMeFBuQmN0OHJVaktE?=
 =?utf-8?B?elplMmw0ZWdjZWh2V1BuYzRmRGNpbW5DYUxtYk5JTWJvRyszTS9HUUpuZFFj?=
 =?utf-8?B?ZENVcXFOaGZuRWxNQXVmZjFueXhoUDRNZ1k3OWZCanBqWE1ka2tuZUJYNkE2?=
 =?utf-8?B?eGw2M2cwYmk2YnZ4MXFIUGVpeFhpc003Q1pvRFJVaWRkSXpBbHFyczRVZjVm?=
 =?utf-8?B?YVh2ZzdRK0I4VXFMWnN3cTdsd3ZhMktMdGY1SUUzc09sRWlKV3BqNHh4Q2ov?=
 =?utf-8?B?dUFiSG1SdjZVQ2Y2cTMxQWhMMzMva2l1ZWNXZVRWZEN0dUdRWlo5ekxYc1VT?=
 =?utf-8?B?SEZnNWtjRFRBM0trQTR3cHNBYkMwc0RHZTAzZi96TDFwZlhPbVJxQWptWCtG?=
 =?utf-8?B?bXhPVHoyYWF1NURib29NaGFpNjN3dUZsaFZwUUw3THNyM01pbEF6Zm4xanI3?=
 =?utf-8?B?UGwyUUVFL1hnWWJMejlieHowWmhTY09xRURCbzRpbmZLYzJvVWN5SGZvRGxv?=
 =?utf-8?B?M2NQMENvUWRZYURJYjc4TXVWbmJpcE93RHdPRXVtclFLNmZYYVRNTDNiWnlB?=
 =?utf-8?B?Yjc3cmlSQkRERHY2VFoxUkNwbGt4TklnRWhCSVBzaDB0cUxEdUpYeXJZaGQv?=
 =?utf-8?B?dWpsUTkzc3RQcEl6d2NMMzg3SFBmUWNiNmdUMXR2eU5OTEtqMm9WdU9PQ0Rk?=
 =?utf-8?B?eHBvOVBwdlNHUEwvNko5Qk54eVcyZ3I0MENJUy9nNGZBYzBPUktZcW5WQjhE?=
 =?utf-8?B?Uk9zWS9GdkxYRUYxcWNNVjh4UW5mUytBS1c0SW9KdWNiZ1lBRHZoY3c5K3Jr?=
 =?utf-8?B?V0Z6RGtLVi85Q1ZvYXFzUlN1SFlEOHF3M3pKWmY2emlVVFByTXg4cFpNWUM4?=
 =?utf-8?B?M3JSd2JoVnFabVhHQ0I2eEwrSjkrN2RqV2dpb2UzSmwvZzdRNUJSenJFNWxp?=
 =?utf-8?B?SDZWUm1qa3pVOUZUakJRSWt1YXNxcmxZQWoySW83MEw1UEJDS2NzMGhHQy85?=
 =?utf-8?B?SzZ1cENBR0JnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RhVURGZk9xQ0lKaUxxdVh6eXZhR09BMFk2bWQ3bS9lcWFWbTVONGZVcFVT?=
 =?utf-8?B?VzY4a2ZzV1ZmdHgrU3Btd3BkVGZ0ZzYwREpXQmZXUkYxNG1xdVdhS1l5YWhT?=
 =?utf-8?B?cWtjOWFlYzdzMDY2RlFOZFR4QnRjN3UvMVE4Ymh2bnlZM3NMZnFydTNJdWp2?=
 =?utf-8?B?bFZKMEtpTGIwbEdZaE1aazN1djlBTnpKQnBHcDY1QVNYMm5YaDhmUXJGaThL?=
 =?utf-8?B?Q1hTTVBrYnk5L3NVckJXTHR6NThOaURqSlQrYWVmWm14SHh2aVh3SGg1bHRR?=
 =?utf-8?B?dVF3MklyU1lHU2IwSWkrdzFreCt4dTBRSDZSZ2RaL2lzaGR4YndLNzAyZjBP?=
 =?utf-8?B?ODFyRm9Wakp4d3U5MmpHTkMxU2gyR0NlSk0zQW1qUjYyR1hhbnh2QXhGMVhE?=
 =?utf-8?B?UTNDVWFhWXJzT2l4c0hYTzBHdGlqTVdlN2k4S2ZUQlRnSFdCekJSUmJXSmNv?=
 =?utf-8?B?dStVRVp1cVpqRjhqa2VqbDNRaFFPYjQzVUNnanFwNFcxQnN0NDdpT0krQW95?=
 =?utf-8?B?N2gxdFYrODN0TGgvY0lmOVlZVXF0WjczTUozSlRyZGVTU1hNcmJCNW1KVFlY?=
 =?utf-8?B?MzdaaDZlTmdOQkpsQTFCckdoekFRclgvWXVRN1YvZm9EbWh2dStHbW5seFV3?=
 =?utf-8?B?Y2FuUU9BUG9jbVVYNWtrNnVoQUl3OFl3NmRJRTk3WU1EWEFkNWVteWFPQ0R2?=
 =?utf-8?B?dlZZdXNkTmw3VDZOcktoUCtuMWhVeXpJT3pJNyswQzFzQkJxM2lqZFE5ejZr?=
 =?utf-8?B?NlhRckFEM1hUNE9mNmpBbC9mOVVWWW9SNDVtTHJ6ZnZWbnNxY0hqWnVod3M5?=
 =?utf-8?B?aHNtT0pHTkszM2VqQnBCaXhDdHhZTG1zWXRDcDhzQm9wQUtyMFI3MFhsK29S?=
 =?utf-8?B?Ym5ueXI2N3lGY0VyVlR0UDJMRDlONDk5cXN3cjdXdW05ZW1FemxUc0RFNGl0?=
 =?utf-8?B?YmxydlY1NmZiL0kyNFdRMHFiSHpBS2cxd3Z4eTR2a01lczVrM0V1MVVhRzlt?=
 =?utf-8?B?OWFhclRoc2RGRVova1UvYy9odk9xZ1hTbTJ2Znc5SjVLckxYZzlBRlhoVnZq?=
 =?utf-8?B?dUQ0WTltMEFVQ1lxazFvZGZIZ0NrdUx6UktGQXBaTUxUV1lYd2ZuS21ORUc4?=
 =?utf-8?B?KzBBUmVteUZzWndRT2JNKzlBSnJCcFBXTXZWaE9PNVJNdnVmZFhIN2piZGpN?=
 =?utf-8?B?U3JOc1pDaDV5aXU4YWtINmw4Zks2UkczcU5yUU01NXpJaEhybHFwNzdWK2JR?=
 =?utf-8?B?REdBSHR3clZMUjRUVW1FeGRDeDJrL2YwZkNHem1URkRQWXp5bDlGbnMzN3gy?=
 =?utf-8?B?ZXV5N2xoOW1udmVKRmVlL2o0L1R2QWlnMUR4TkRoUDliYXpxUUQyOWc4M0Nj?=
 =?utf-8?B?OEhvZG1RRncya1RIOXdjNFN5U1FDZzROS2tOZ0J6SExTdkthM29VNjJIaDlX?=
 =?utf-8?B?NFV1STVpWGtsYUdsTnpYUVhKeUdacmlFNkxONExySm55OGdCZDNLMUdtbGhW?=
 =?utf-8?B?MzZzQUo3NHlKVHFLckhacmFkVTFheVV4UWRDdUhsTUlMQmdqOTBGanlFalJE?=
 =?utf-8?B?QXpOOFh3TncyUEdncFNqUXBjellWVVJ3ZklBZEQzNTQ2NFlHclk2SzliY0Q1?=
 =?utf-8?B?NWNDanJwTE9tdmpVRlpZRUFkZ3dpa0RlWTNZa2lvbk5EYnRMaFNETDVFREIw?=
 =?utf-8?B?ZDJnamZKNlA5RmluV1J6d2NLTFhzdkwwc21sc2JDQWszZ09VbGZHdncxV29k?=
 =?utf-8?B?WENrZHRJMk05TmwvOFNJVmIyN0c1R3VwMlZ3cjhDTUFjbzk1Tk8yUlIvTTBa?=
 =?utf-8?B?b2QrTjUrNUozeXRyRE4rVlgzZTZPb3kyRVJkQmJ1ckVrck9lYlFVRnZOM3ZL?=
 =?utf-8?B?TERvdDhIWTBReCt2K04vbFVUbCtIREN4THZCb2dYSnQ0OFdkbUZ4SkZuWGYz?=
 =?utf-8?B?ZjF2dC9HRXJvekRtU3ZWeVN4N0ttdTljOXl3ZURNYk5aUS84aGhqSFVuZnpl?=
 =?utf-8?B?T0ZhOU5zM0tJRG4wYXpKdWZrbGZqbmJFWENNcDRkaHU0S1Z2V0s1SHlHdXVv?=
 =?utf-8?B?SkttNWlrcDVmUTJEMlF0ZVlUemt6T05BUEJoYUM0MGJTa3JzdzRjcUJ2VWFE?=
 =?utf-8?Q?2uVRjCzu003ZqNrMAM9y9BkSW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64aad31-98ba-4724-73b1-08ddeed264c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 12:22:35.7506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dvq0tmEZ8rqfMSr+gUb/cfMKn1Vzu3VjXAFhRuewzd6njj3t/4ODGHk9R7ud1aitnz+kgPSo/ltWwCZ949cyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112
Received-SPF: permerror client-ip=2a01:111:f403:2407::62a;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA1IFNlcHRlbWJlciAyMDI1IDEz
OjQ2DQo+IFRvOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IFNo
YW1lZXIgS29sb3RodW0NCj4gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsgTmlj
b2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQuY29tOyBi
ZXJyYW5nZUByZWRoYXQuY29tOw0KPiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsg
TWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgbGlu
dXhhcm1AaHVhd2VpLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3Vu
QGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2Fv
QGxpbmFyby5vcmc7IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsNCj4gc2hhbWVlcmtvbG90aHVt
QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAxMy8xNV0gaHcvYXJtL3Nt
bXV2MzogRm9yd2FyZCBpbnZhbGlkYXRpb24NCj4gY29tbWFuZHMgdG8gaHcNCj4gDQo+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0K
PiANCj4gSGkgU2hhbWVlciwNCj4gDQo+IE9uIDcvMTQvMjUgNTo1OSBQTSwgU2hhbWVlciBLb2xv
dGh1bSB3cm90ZToNCj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+
DQo+ID4NCj4gPiBVc2UgdGhlIHByb3ZpZGVkIHNtbXV2My1hY2NlbCBoZWxwZXIgZnVuY3Rpb25z
IHRvIGlzc3VlIHRoZQ0KPiA+IGludmFsaWRhdGlvbiBjb21tYW5kcyB0byBob3N0IFNNTVV2My4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGh3L2FybS9zbW11djMtaW50
ZXJuYWwuaCB8IDExICsrKysrKysrKysrDQo+ID4gIGh3L2FybS9zbW11djMuYyAgICAgICAgICB8
IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAz
OSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1pbnRl
cm5hbC5oIGIvaHcvYXJtL3NtbXV2My1pbnRlcm5hbC5oDQo+ID4gaW5kZXggOGNiNmE5MjM4YS4u
ZjNhZWFmNjM3NSAxMDA2NDQNCj4gPiAtLS0gYS9ody9hcm0vc21tdXYzLWludGVybmFsLmgNCj4g
PiArKysgYi9ody9hcm0vc21tdXYzLWludGVybmFsLmgNCj4gPiBAQCAtMjMzLDYgKzIzMywxNyBA
QCBzdGF0aWMgaW5saW5lIGJvb2wNCj4gc21tdXYzX2dlcnJvcl9pcnFfZW5hYmxlZChTTU1VdjNT
dGF0ZSAqcykNCj4gPiAgI2RlZmluZSBRX0NPTlNfV1JBUChxKSAoKChxKS0+Y29ucyAmIFdSQVBf
TUFTSyhxKSkgPj4gKHEpLQ0KPiA+bG9nMnNpemUpDQo+ID4gICNkZWZpbmUgUV9QUk9EX1dSQVAo
cSkgKCgocSktPnByb2QgJiBXUkFQX01BU0socSkpID4+IChxKS0NCj4gPmxvZzJzaXplKQ0KPiA+
DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHNtbXV2M19xX25jbWRzKFNNTVVRdWV1ZSAqcSkNCj4g
PiArew0KPiA+ICsgICAgdWludDMyX3QgcHJvZCA9IFFfUFJPRChxKTsNCj4gPiArICAgIHVpbnQz
Ml90IGNvbnMgPSBRX0NPTlMocSk7DQo+ID4gKw0KPiA+ICsgICAgaWYgKFFfUFJPRF9XUkFQKHEp
ID09IFFfQ09OU19XUkFQKHEpKQ0KPiA+ICsgICAgICAgIHJldHVybiBwcm9kIC0gY29uczsNCj4g
PiArICAgIGVsc2UNCj4gPiArICAgICAgICByZXR1cm4gV1JBUF9NQVNLKHEpIC0gY29ucyArIHBy
b2Q7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpbmxpbmUgYm9vbCBzbW11djNfcV9mdWxs
KFNNTVVRdWV1ZSAqcSkNCj4gPiAgew0KPiA+ICAgICAgcmV0dXJuICgocS0+Y29ucyBeIHEtPnBy
b2QpICYgV1JBUF9JTkRFWF9NQVNLKHEpKSA9PQ0KPiBXUkFQX01BU0socSk7DQo+ID4gZGlmZiAt
LWdpdCBhL2h3L2FybS9zbW11djMuYyBiL2h3L2FybS9zbW11djMuYw0KPiA+IGluZGV4IGM5NGJm
ZTY1NjQuLjk3ZWNjYTA3NjQgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2My5jDQo+ID4g
KysrIGIvaHcvYXJtL3NtbXV2My5jDQo+ID4gQEAgLTEyODUsMTAgKzEyODUsMTcgQEAgc3RhdGlj
IGludA0KPiBzbW11djNfY21kcV9jb25zdW1lKFNNTVV2M1N0YXRlICpzKQ0KPiA+ICAgICAgU01N
VUNtZEVycm9yIGNtZF9lcnJvciA9IFNNTVVfQ0VSUk9SX05PTkU7DQo+ID4gICAgICBTTU1VUXVl
dWUgKnEgPSAmcy0+Y21kcTsNCj4gPiAgICAgIFNNTVVDb21tYW5kVHlwZSB0eXBlID0gMDsNCj4g
PiArICAgIFNNTVVDb21tYW5kQmF0Y2ggYmF0Y2ggPSB7fTsNCj4gPiArICAgIHVpbnQzMl90IG5j
bWRzOw0KPiA+DQo+ID4gICAgICBpZiAoIXNtbXV2M19jbWRxX2VuYWJsZWQocykpIHsNCj4gPiAg
ICAgICAgICByZXR1cm4gMDsNCj4gPiAgICAgIH0NCj4gPiArDQo+ID4gKyAgICBuY21kcyA9IHNt
bXV2M19xX25jbWRzKHEpOw0KPiA+ICsgICAgYmF0Y2guY21kcyA9IGdfbmV3MChDbWQsIG5jbWRz
KTsNCj4gPiArICAgIGJhdGNoLmNvbnMgPSBnX25ldzAodWludDMyX3QsIG5jbWRzKTsNCj4gc28g
eW91IGFyZSBwcm92aXNpb25uaW5nIHNwYWNlIGZvciBuIGNvbW1hbmRzIGZvdW5kIGluIHRoZSBx
dWV1ZSwNCj4gaW5kZXBlbmRlbnRseSBvbiBrbm93aW5nIHdoZXRoZXIgdGhleSB3aWxsIGJlIGJh
dGNoZWQsIGllLiBvbmx5DQo+IGludmFsaWRhdGlvbiBjb21tYW5kcyBhcmUuIFRoZW4gY29tbWFu
ZHMgYXJlIGFkZGVkIGluIHRoZSBiYXRjaCBvbmUgYnkNCj4gb25lIGFuZCB5b3UgaW5jcmVtZW50
IGJhdGNoLT5uY21kcyBpbiBzbW11djNfYWNjZWxfYmF0Y2hfY21kLiBJIGFncmVlDQo+IHdpdGgg
Sm9uYXRoYW4uIFRoaXMgbG9va3Mgd2VpcmQuIEFUIGxlYXN0IEkgd291bGQgaW50cm9kdWNlIGEg
a2VscGVyDQo+IHRoYXQgaW5pdHMgYSBCYWNrIG9mIG5jbWRzIGFuZCBJIHdvdWxkIG1ha2UgYWxs
IHRoZSBiYXRjaCBmaWVsZHMNCj4gcHJpdmF0ZS4gWW91IHlvdSBlbmQgdXAgd2l0aCB0aGUgaW5p
dCArDQo+IHNtbXV2M19hY2NlbF9hZGRfY21kX3RvX2JhdGNoKGJhdGNoLCBjbWQpLiBUaGVuIGlu
ZGVwZW5kZW50bHkgb24gdGhlDQo+IG5jbWRzIHlvdSBjYW4gaXNzdWUgYSBzbW11djNfYWNjZWxf
aXNzdWVfY21kX2JhdGNoIHRoYXQgd291bGQgcmV0dXJuIGlmDQo+IHRoZXJlIGlzIG5vdGhpbmcg
aW4gdGhlIGJhdGNoLiBZb3UgYWxzbyBuZWVkIGEgYmF0Y2ggZGVhbGxvY2F0aW9uDQo+IGhlbHBl
ci4gDQoNCkFncmVlLCBhdCBwcmVzZW50IHdlIHByZS1hbGxvY2F0ZSBpcnJlc3BlY3RpdmUgb2Yg
d2hldGhlciB0aGVyZSB3aWxsIGFueQ0KSW52YWxpZGF0aW9uIGNtZHMgb3Igbm90LiBJIHdpbGwg
dGFrZSBhbm90aGVyIGxvb2sgYW5kIGluY29ycG9yYXRlIHlvdXIgYWJvdmUNCnN1Z2dlc3Rpb24g
dG8gaW1wcm92ZSB0aGlzLiANCg0KSSByZW1lbWJlciBJIGV4cHJlc3NlZCBpbiB0aGUgcGFzdCBt
eSBjb25jZXJuIGFib3V0IGhhdmluZw0KPiBjb21tYW5kcyBleGVjdXRlZCBvdXQgb2Ygb3JkZXIu
IEkgZG9uJ3QgcmVtZW1iZXIgb3V0IGNvbmNsdXNpb24gb24gdGhhdA0KPiBidXQgdGhpcyBzaGFs
bCBiZSBjbGVhcmx5IHN0dWRpZWQgYW5kIGNvbmNsdXNpb24gc2hhbGwgYmUgcHV0IGluIHRoZQ0K
PiBjb21taXQgbWVzc2FnZS4NCg0KWWVzLCB5b3UgZGlkLCBhbmQgSSBtaXNzZWQgaXQuIFNvcnJ5
IGFib3V0IHRoYXQuDQoNCkkgdGhpbmsgaXQgaXMgc2FmZSB0byBob25vdXIgdGhlIGV4ZWN1dGlv
biBvcmRlciBvZiBHdWVzdCBoZXJlLiBGcm9tIGEgcXVpY2sgZ2xhbmNlLCBJDQpjb3VsZG7igJl0
IGZpbmQgYW55dGhpbmcgcmVsYXRlZCB0byBhIHNhZmUgb3V0IG9mIG9yZGVyIGV4ZWN1dGlvbiBn
dWlkYW5jZSBmcm9tDQpTTU1VdjMgc3BlY2lmaWNhdGlvbi4gQWxzbywgd2UgY2FuJ3QgYmUgc3Vy
ZSBob3cgR3Vlc3Qgd2lsbCBiZSBtb2RpZmllZC9vcHRpbWlzZWQNCmluIHRoZSBmdXR1cmUgdG8g
Y29tcGxldGVseSBydWxlIG91dCBwcm9ibGVtcyBpZiB3ZSBkbyBvdXQtb2Ytb3JkZXIgZXhlY3V0
aW9ucy4gDQoNCkhlbmNlLCBteSBwbGFuIGZvciBuZXh0IGlzIHRvIHN0YXJ0IGJhdGNoaW5nIGlm
IHdlIHNlZSBJbnZhbGlkYXRpb24gY21kcyBhbmQgc3VibWl0DQp0aGUgYmF0Y2ggSWYgYW55IG5v
bi1pbnZhbGlkYXRpb24gY29tbWFuZHMgYXJlIGVuY291bnRlcmVkIGluIGJldHdlZW4uDQoNCkBO
aWNvbGluLCBkbyB5b3UgZm9yZXNlZSBhbnkgaXNzdWVzIHdpdGggYWJvdmUgYXBwcm9hY2g/IEZy
b20gdGhlIGN1cnJlbnQNCkhvc3QgU01NVVYzIGRyaXZlciwgYmF0Y2hpbmcgb2YgY29tbWFuZHMg
aXMgbWFpbmx5IHVzZWQgZm9yIGludmFsaWRhdGlvbnMNCihleGNlcHQgZm9yIGNlcnRhaW4gYXJt
X3NtbXVfY21kcV9pc3N1ZV9jbWRfd2l0aF9zeW5jKCkgY2FzZXMpLiBTbyANCkkgZ3Vlc3Mgd2Ug
YXJlIGdvb2QgZnJvbSBhIHBlcmZvcm1hbmNlIG9wdGltaXNhdGlvbiBwb2ludCBvZiB2aWV3IGlm
IHdlIGNhbg0KY292ZXIgaW52YWxpZGF0aW9ucyBhcyBhYm92ZS4NCg0KPiA+ICsNCj4gPiAgICAg
IC8qDQo+ID4gICAgICAgKiBzb21lIGNvbW1hbmRzIGRlcGVuZCBvbiByZWdpc3RlciB2YWx1ZXMs
IHR5cGljYWxseSBDUjAuIEluIGNhc2UgdGhvc2UNCj4gPiAgICAgICAqIHJlZ2lzdGVyIHZhbHVl
cyBjaGFuZ2Ugd2hpbGUgaGFuZGxpbmcgdGhlIGNvbW1hbmQsIHNwZWMgc2F5cyBpdA0KPiA+IEBA
IC0xMzgzLDYgKzEzOTAsNyBAQCBzdGF0aWMgaW50DQo+IHNtbXV2M19jbWRxX2NvbnN1bWUoU01N
VXYzU3RhdGUgKnMpDQo+ID4NCj4gPiAgICAgICAgICAgICAgdHJhY2Vfc21tdXYzX2NtZHFfY2Zn
aV9jZChzaWQpOw0KPiA+ICAgICAgICAgICAgICBzbW11djNfZmx1c2hfY29uZmlnKHNkZXYpOw0K
PiA+ICsgICAgICAgICAgICBzbW11djNfYWNjZWxfYmF0Y2hfY21kKHNkZXYtPnNtbXUsIHNkZXYs
ICZiYXRjaCwgJmNtZCwgJnEtDQo+ID5jb25zKTsNCj4gPiAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gICAgICAgICAgfQ0KPiA+ICAgICAgICAgIGNhc2UgU01NVV9DTURfVExCSV9OSF9BU0lEOg0K
PiA+IEBAIC0xNDA2LDYgKzE0MTQsNyBAQCBzdGF0aWMgaW50DQo+IHNtbXV2M19jbWRxX2NvbnN1
bWUoU01NVXYzU3RhdGUgKnMpDQo+ID4gICAgICAgICAgICAgIHRyYWNlX3NtbXV2M19jbWRxX3Rs
YmlfbmhfYXNpZChhc2lkKTsNCj4gPiAgICAgICAgICAgICAgc21tdV9pbnZfbm90aWZpZXJzX2Fs
bCgmcy0+c21tdV9zdGF0ZSk7DQo+ID4gICAgICAgICAgICAgIHNtbXVfaW90bGJfaW52X2FzaWRf
dm1pZChicywgYXNpZCwgdm1pZCk7DQo+ID4gKyAgICAgICAgICAgIHNtbXV2M19hY2NlbF9iYXRj
aF9jbWQoYnMsIE5VTEwsICZiYXRjaCwgJmNtZCwgJnEtPmNvbnMpOw0KPiA+ICAgICAgICAgICAg
ICBicmVhazsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAgICAgY2FzZSBTTU1VX0NNRF9UTEJJ
X05IX0FMTDoNCj4gPiBAQCAtMTQzMyw2ICsxNDQyLDcgQEAgc3RhdGljIGludA0KPiBzbW11djNf
Y21kcV9jb25zdW1lKFNNTVV2M1N0YXRlICpzKQ0KPiA+ICAgICAgICAgICAgICB0cmFjZV9zbW11
djNfY21kcV90bGJpX25zbmgoKTsNCj4gPiAgICAgICAgICAgICAgc21tdV9pbnZfbm90aWZpZXJz
X2FsbCgmcy0+c21tdV9zdGF0ZSk7DQo+ID4gICAgICAgICAgICAgIHNtbXVfaW90bGJfaW52X2Fs
bChicyk7DQo+ID4gKyAgICAgICAgICAgIHNtbXV2M19hY2NlbF9iYXRjaF9jbWQoYnMsIE5VTEws
ICZiYXRjaCwgJmNtZCwgJnEtPmNvbnMpOw0KPiA+ICAgICAgICAgICAgICBicmVhazsNCj4gPiAg
ICAgICAgICBjYXNlIFNNTVVfQ01EX1RMQklfTkhfVkFBOg0KPiA+ICAgICAgICAgIGNhc2UgU01N
VV9DTURfVExCSV9OSF9WQToNCj4gPiBAQCAtMTQ0MSw2ICsxNDUxLDcgQEAgc3RhdGljIGludA0K
PiBzbW11djNfY21kcV9jb25zdW1lKFNNTVV2M1N0YXRlICpzKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgc21tdXYzX3Jh
bmdlX2ludmFsKGJzLCAmY21kLCBTTU1VX1NUQUdFXzEpOw0KPiA+ICsgICAgICAgICAgICBzbW11
djNfYWNjZWxfYmF0Y2hfY21kKGJzLCBOVUxMLCAmYmF0Y2gsICZjbWQsICZxLT5jb25zKTsNCj4g
PiAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgY2FzZSBTTU1VX0NNRF9UTEJJX1Mx
Ml9WTUFMTDoNCj4gPiAgICAgICAgICB7DQo+ID4gQEAgLTE0OTksMTIgKzE1MTAsMjkgQEAgc3Rh
dGljIGludA0KPiBzbW11djNfY21kcV9jb25zdW1lKFNNTVV2M1N0YXRlICpzKQ0KPiA+ICAgICAg
ICAgIHF1ZXVlX2NvbnNfaW5jcihxKTsNCj4gPiAgICAgIH0NCj4gPg0KPiA+ICsgICAgcWVtdV9t
dXRleF9sb2NrKCZzLT5tdXRleCk7DQo+ID4gKyAgICBpZiAoIWNtZF9lcnJvciAmJiBiYXRjaC5u
Y21kcykgew0KPiA+ICsgICAgICAgIGlmICghc21tdXYzX2FjY2VsX2lzc3VlX2NtZF9iYXRjaChi
cywgJmJhdGNoKSkgew0KPiA+ICsgICAgICAgICAgICBpZiAoYmF0Y2gubmNtZHMpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgIHEtPmNvbnMgPSBiYXRjaC5jb25zW2JhdGNoLm5jbWRzIC0gMV07DQo+
ID4gKyAgICAgICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICBxLT5jb25zID0g
YmF0Y2guY29uc1swXTsgLyogRklYTUU6IENoZWNrICovDQo+ID4gKyAgICAgICAgICAgIH0NCj4g
PiArICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsICJJbGxlZ2FsIGNv
bW1hbmQgdHlwZTogJWRcbiIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgQ01EX1RZ
UEUoJmJhdGNoLmNtZHNbYmF0Y2gubmNtZHNdKSk7DQo+IENhbid0IHlvdSBoYXZlIG90aGVyIGVy
cm9yIHR5cGVzIHJldHVybmVkPw0KDQpLZXJuZWwgY2FuIHJldHVybiBFT1BOT1RTVVBQL0VJTlZB
TC9FTk9NRU0vRUZBVUxULyBFVElNRURPVVQgZXJyb3JzLg0KT2YgdGhlc2UsIG9ubHkgRVRJTUVE
T1VUIGlzIHJlbGF0ZWQgdG8gdGhlIGFjdHVhbCBob3N0IFF1ZXVlIHdoZW4gYW4gYXR0ZW1wdGVk
DQpTWU5DIHJlc3VsdHMgaW4gdGltZW91dC4NCg0KU28sIGJldHdlZW4gQ0VSUk9SX0lMTC8gX0FC
VC8gX0FUQ19JTlZfU1lOQyBJIHRoaW5rIGl0IGlzIGJlc3QgdG8gc2V0IENFUlJPUl9JTEwNCmhl
cmUuDQoNClRoYW5rcywNClNoYW1lZXINCg0KPiANCj4gVGhhbmtzDQo+IA0KPiBFcmljDQo+ID4g
KyAgICAgICAgICAgIGNtZF9lcnJvciA9IFNNTVVfQ0VSUk9SX0lMTDsNCj4gPiArICAgICAgICB9
DQo+ID4gKyAgICB9DQo+ID4gKyAgICBxZW11X211dGV4X3VubG9jaygmcy0+bXV0ZXgpOw0KPiA+
ICsNCj4gPiAgICAgIGlmIChjbWRfZXJyb3IpIHsNCj4gPiAgICAgICAgICB0cmFjZV9zbW11djNf
Y21kcV9jb25zdW1lX2Vycm9yKHNtbXVfY21kX3N0cmluZyh0eXBlKSwNCj4gY21kX2Vycm9yKTsN
Cj4gPiAgICAgICAgICBzbW11X3dyaXRlX2NtZHFfZXJyKHMsIGNtZF9lcnJvcik7DQo+ID4gICAg
ICAgICAgc21tdXYzX3RyaWdnZXJfaXJxKHMsIFNNTVVfSVJRX0dFUlJPUiwNCj4gUl9HRVJST1Jf
Q01EUV9FUlJfTUFTSyk7DQo+ID4gICAgICB9DQo+ID4NCj4gPiArICAgIGdfZnJlZShiYXRjaC5j
bWRzKTsNCj4gPiArICAgIGdfZnJlZShiYXRjaC5jb25zKTsNCj4gPiAgICAgIHRyYWNlX3NtbXV2
M19jbWRxX2NvbnN1bWVfb3V0KFFfUFJPRChxKSwgUV9DT05TKHEpLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUV9QUk9EX1dSQVAocSksIFFfQ09OU19XUkFQKHEpKTsN
Cj4gPg0KDQo=

