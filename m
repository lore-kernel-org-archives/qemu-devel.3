Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C52FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIkI-0006T7-E5; Tue, 04 Nov 2025 10:14:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIkG-0006RT-3x; Tue, 04 Nov 2025 10:14:52 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGIkE-0001OY-2Q; Tue, 04 Nov 2025 10:14:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTqm4prbXnfieak5UVG0551LfCWr36sFViBxM9SkuR9uXX1r75sGf6WxI6q3rMUVihIaaXh9Zi2ZIVI6s+Qk/5jc2wu/PAuX4kCT2i7kpaJ2RGC+SxQiFTT9Cw71+4YQ4H1Rt09GbTCkBEfd8yt9BS94V2jIRfvr1EHn7JGnhT4MipNovb/A09+VrM/dZsXi9fqFDiC+6AO3b499b7MP4J6Bh/kGxwaqkPxVgNrpjkQf3GKfB9XzwJlD6v5t0XA+TyiqTT0WkEfqSqjl6MaOrq0AqCrDX1J4I1BiXOKnOywD5rD/eMyvSYdjeWECoyuH6sKVy9FSSq0IekEg79Z24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S+1/5jPVSHgHW4IC3vttv3U4RKYtYC/wE3We+JlXm8=;
 b=Bsz0ElC4dU34koAxUHJS3amzJw5TQ4lw4wAka8ZaZCtViSM7Ej4TAYeWfscms35G5AGn2t7DUPTDqzFH8tewFByP2W8e8fcE2M+iGyLzjbvhQiHsatgitG6bwkRxVi6Gxc3p/ccbFWV6DFyoZHqUBD/JX5LWGGHn2iHD+elyUkaA8MWqvxGLNvArU4N0G8QJMJuILP2/0pvsoJjo55S8ZVqhslMxJrqZtrJxz6/7m1zvLuDuOfIsuX5fuwQYPEn51f8X3XVQHm/bRpJxqJpyJqFnzHWyxTDwpLzKvVQJYmeXF5Ja2dahLnCceUb9OWhop5ahHp6OJRJex2URtwt0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S+1/5jPVSHgHW4IC3vttv3U4RKYtYC/wE3We+JlXm8=;
 b=RKeWAA2/wkjrZNQ0cUiA3ACu1MLvN2aEnMerM71nEtWaSxq/sD+AaRYMcSKzAXPfJ4hb51z8elj3i0cAtDHoHO0CsUbVaCUJE70N80bsproxDMmts2wkJR+IM414SXqGOnQxddb4jD56nDYr6EpoH5MhTgwsdTg2Rqo7F8ofPQMsFNtFyz6Zjkn98IIlI184yX6z+BDDDVsgLVANURAxcHJ+mWKwRfHBXlufMxda5Mkb1Hem7eMRiJPsuNi2sTVZHHDEHR/ktEb2/RjTGfZRZ4qHsMmJP3gbJoXwh289FkSU6B+pV/oWn9QVeaG8o/psVzyJsc7SNdBHDkoqTLo9DQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CH2PR12MB4117.namprd12.prod.outlook.com (2603:10b6:610:ae::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 15:14:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:14:44 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTik/BQgAAD6QCAAAbV8A==
Date: Tue, 4 Nov 2025 15:14:44 +0000
Message-ID: <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
In-Reply-To: <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CH2PR12MB4117:EE_
x-ms-office365-filtering-correlation-id: c6e9b237-c465-420c-5647-08de1bb4e2c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RXVqeE1pejdDZUR6OFZrc2NUenRySllvc0Z6QXpYRnVwdXMyZk1aSmZhZDhF?=
 =?utf-8?B?R2picEVaUnZXNEw2Q3NhaU9pWHQrN1VpYmE3a052clVXYjRGMUdDeHNxTTVm?=
 =?utf-8?B?MXlMT2o0QUxUNjJJa2tvbCswMkd2MXQ5U3R2cWxWUnc3c3BTNTdOREY0bXFo?=
 =?utf-8?B?em1IbTVFWjY0YWVRRzlRNXU4VURwTjd4eHgvZ3ZiZEpadjIyYm91SFVQNCtt?=
 =?utf-8?B?WlRLekdIa0tDNU9raHJ0SXVHTjdVZkxHKzhhbTVpZEZYNUh0U3dXWDZzdzE5?=
 =?utf-8?B?dDZESEtuck02MmJ1MHdhNzNQQUJjdXp2MHpaMUdtRVluT1dIeWFEa21FZ0h6?=
 =?utf-8?B?VWhBR1ZIWnUwcnBTZTd4V094anVrekJrNk1WTXJvT2tEZURITWFqVFliMnBu?=
 =?utf-8?B?RXIzZHRzd2FWS1RXU1NGZElNdGxHU0xIaDZJY09CV3RjdzlHNy81R1luUjFq?=
 =?utf-8?B?cTJRdSt0Y25ncytvYmVRZ1p3RVVzT0xOSnQyUUFyNksxbWpHWVQ4WXJMZG51?=
 =?utf-8?B?QXcwQnBlWkRYUGFWWTVtSlBKY3dqOWFZTGhZMGY3SG1tRk50NWs0OGFBQXJN?=
 =?utf-8?B?cFIxVDNPMmR2bGQyeE9Bc0tOUy82dzNMZjRKTTJJWDZVcVVZd0hVN0hVbWVr?=
 =?utf-8?B?QkREYlVnSmdRaW1KZEcrVWUvVGtQSFdlQm5kb0pzYjFNZ1NISWlzR2FUNlFs?=
 =?utf-8?B?KzdaQzNGWU5jWXExTmwzT2JjaXVVeXZDM1VNZnI3bzllR2dUcWg3OG15L1NN?=
 =?utf-8?B?WDRwNEZsYUVOR1g0U281TVVYUGdaWjBWeTZmTEpDZHBMQzFYNXlGVVlCU05q?=
 =?utf-8?B?dE9rdDRDYW1OcWloNkFNZm92WnFVbmZ5WEdRdlFVU1R2NnlwcFMrY0sxcWll?=
 =?utf-8?B?WitsWWFjOHlxaUlKUGV3a25tVklrRFYrTEswRTJVUkVPNmIrb2ptMEhyaTFl?=
 =?utf-8?B?SWtaNWZBRTNpQVB1dGtZOXRvcGJaT00xcDUzK1U1OFdHNmVvMUZ3aW1mNXI3?=
 =?utf-8?B?NlRFOHE1Q21ualc1Si95WGZRczluWEVoQXNsSU8rdWpPTGI1by9IYnV0c3FO?=
 =?utf-8?B?K0kyVFVhUFZpc0tDMmFDQVhRTTRqQW1zUzl0cXRoWlhsYkp0UCtMV05mSmpu?=
 =?utf-8?B?eHhUcytJQW9JbnZiYkhJRjRib3dpakVyTUhlVnF2TEo4Q3FvSXFlZTNFbkx1?=
 =?utf-8?B?aGw0UE4xYVNqUVdRQ0hvYTZXT0ZjV0tSZlhhVXVNcEYrbXMrNDNRZ1IyK1F0?=
 =?utf-8?B?cXZkOWwyYk9mSlBWUG9sanppK2lHV2RxNGxvZ1AwY1E3QnZSUWorU0gwZGdp?=
 =?utf-8?B?SWJsWGFObTQwUkNRV0tIZWZSMS9meUVEelhEZkVGZXpNM3k1WTREdTRFeWdu?=
 =?utf-8?B?c3dnTXA4M0psV3JaSzRlY1JpdTRmcVRvMUthbGRoSG1mNExNam16UHh5aFd2?=
 =?utf-8?B?ZWxVcmN4UWVIRWNmN0NNUjYwa0lWRS9aY1gvWkRiaHI1YzE5Sk5PdU1OZGJS?=
 =?utf-8?B?RmxVQU0vekU2Tk5nQ0dkNnRoTmZUQ0JqR0ZBWkVUb2N3a2Z3dWtlR0llNU84?=
 =?utf-8?B?YnNoT2NIMEJJRldIQ1BBM1F4eWp4WUJhTVBKd3N6MTN6ZFhOOHd0aFkzOHhY?=
 =?utf-8?B?WnBVZHdURzd3QlozT2h1S2ZaK1laVUN1SjdFNVVtUnByblRGelVZZmRmQWFC?=
 =?utf-8?B?bmdKOWp5bWwyWXdTMU9WMlpYblhJRVJHdGR3T1BOQWljOXlMMXQ5Tm5sNzdT?=
 =?utf-8?B?NVNhNndzcnZPeTByWlFSUkRzVkN5TEUyU08wQnJrVW4xNE5OUnFxVUZjWUE2?=
 =?utf-8?B?OFZBK0VTQVp6SkNrZnN6V0RWd2Fta2tPYkJjS2Q3UCtWQ0gvQjEzRklCK093?=
 =?utf-8?B?Z0g2SWVxRWRaUFZKQnN5NzI3YXZOc0ZnVFppdTF0V05qcERiSVN4Zzdudkt6?=
 =?utf-8?B?TE85RkFSSmNpWWNHN2hGcU44b3JZUUZNUlNQVG0yRWwrSVYvU2xGc3dYRVZs?=
 =?utf-8?B?ZzlNaldYNWtybjF3aG1sNklQYXpHSW1QN2h3VXVPRVpJc1JXWTZabkdLekNI?=
 =?utf-8?Q?O2Jgcl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXBlRmIwV2hlY21YOWFwTi9uM3lVaEtSWFVmTEV4bDgrK2QrSFVZU3hKQTNO?=
 =?utf-8?B?UUxzOEVtWDVYakVBOUlCTDlGUlZsTXpaa3VobTMxU21kdUo1RGNna2FIZFd6?=
 =?utf-8?B?WUh5ejdlTldna1VIMVZqV0VhbHFqcGI3bERmbmdtQUJXK2lIQXVXSW4xL0Jx?=
 =?utf-8?B?YWZGcTR3MXZhQnFwa2IzTW8va01ZMDA0SFpkYk1uSm9iUFllSHNNZXFneEtO?=
 =?utf-8?B?YllTVnlZbFpZR1hkUGpGR01pWG9sbEFKVHlhYTZuRDJLVXZTMlV6R1AyUlBH?=
 =?utf-8?B?VVNsWmVJYjliVTRxMDgyTFZiM3laT1U4Z0owaHFMRXZvOCtOSGtBbDR4STVr?=
 =?utf-8?B?VUxUb3JBLzRJOTM3ZFI1ck81Sm1aMlJSZkQwZzNxVWUrdmhFOXBsOTV6Qkth?=
 =?utf-8?B?R25yRENpdDNLUGJJZXQ5eWlIRDA0TXJFTWlZRnhQZWdNeDR1aVQ2VU5LTWJx?=
 =?utf-8?B?b1haSXlQeEg0TVR4VFZMbVpYNDc2aWQwSlpQSWVnOEZ6c2dyQ1B6SlNEVEdq?=
 =?utf-8?B?T1RBQllKTGowWGRpRGVNSitEL1FZM1o2R1FWdXVCeE9oRVBKNllyZHpKM0N2?=
 =?utf-8?B?WkpBZmRSRFZxQmd3VDRxS3lNTzN4cmkwZk5UWnpiZDBmQ0ZuTzZlOWZvbkVm?=
 =?utf-8?B?WXNLQW85VTdzeTBpQlVRTUdMQ09lQlpORWFkbDJGYXRJb2d3YlNIZDZrYVY4?=
 =?utf-8?B?TlZYUnNlTllSVzFOQnZZMi85am96S29wZFJ2SkRiaituSmthV3phRUhYeEZ2?=
 =?utf-8?B?cnNQSlFBa0NyQlB2NGt5bVI4bDVMdzVNQ2s1WVdIZm1hbUVFYnV1V2RRZVcz?=
 =?utf-8?B?U0daMnRxSjc5bG9IZDFNdW81ZVRpVDg5UlpDQkNXQzNYdXpPSXhBMkRzSUhU?=
 =?utf-8?B?UEFQNVV0cENOLy9veGY2UTBLN1BzQnRuc1lQZDJUUTd0c0lRKy96bU1iUERr?=
 =?utf-8?B?bkVsdlp0UHpvMkMvVUJETTNVSCsxQTVQSzVQdnNjcHAwOVFjWHBXSDJaeEhI?=
 =?utf-8?B?aWFiRFBpd1hLOHVBSytNZTR3OVRGaGJ2U09KZGdwVFl6VndzRStBcFNIS2Q1?=
 =?utf-8?B?Y3FyMnFiRVFkcW5RZ0gwV0J0aC9obzFmWG9PbWlxUW1kdDlqQ0hENDBkeXgr?=
 =?utf-8?B?L2hkMUZUU1AzYVV0emdzQWRKa05uUk5hS3JXam5vNCtzcml5YkNHV1NMQXVP?=
 =?utf-8?B?cWsrTjdKK0ZhaHFoWngyT3B1K2pWSVBuV3pOTXhGN1pyVTdrUFZqNWRYYndK?=
 =?utf-8?B?aTdsc2FlaUxNczY5eVRWVU1VUjJuUmd3WXRZc012ZVIzMHVzYllIcFJFRHFM?=
 =?utf-8?B?WklnSUc0MkhGUUY3UytGQTh6TCs2K2Jub1B2YUNJYjN2U3dTZW1FVmpXN1Ra?=
 =?utf-8?B?aHIxMjk1aTl6OUJvdXFVNU9rb2hFdFYzYTFabVBXSHUyNWNSTEFheko1REVZ?=
 =?utf-8?B?aU54aGtwZGxYaVkzOHBnRjRXaS9ndnhwY1UrQWpJK3NTQUMrWWVIb3hpWXhn?=
 =?utf-8?B?YWJndCtGMFBvcFdMZXVKUjkxb1hJcCtVNFNEV2gxZTE2dnVMRSt3N2hic3V5?=
 =?utf-8?B?Y1FGNjM5NENMMHVhSzZiUUw0THRNdmw2ZEtHK0E0QmVCWUE1dW5ESllMTmhW?=
 =?utf-8?B?Y252bUFCQ1N1MElweldGb25Ib3BrUmMvZll6ZGd6cWM5MnYycmh2N1IwMGdZ?=
 =?utf-8?B?NCtRcGRYOWhwa3Bya3l1amJNSS91OEVDVzd3by8xVE5LMEF6UkNFbFM0S3VN?=
 =?utf-8?B?UTFObE9JTDhnR2k5TWFaQlhpZlBLZ1U1ZWU0WFFxNzlVOEdtNXllZXpzWVho?=
 =?utf-8?B?NWdXOS9rdU8veDNoWVB5QnBJaUJCWEYza0p5SlhoOXBjbEprYllHdVFaZDN5?=
 =?utf-8?B?UzU5djZ6Vnd3RERZUVZ1TUcyQlpOSWxRa1RVblBzc2xtdnlnMVlKMG0zaCs1?=
 =?utf-8?B?ZC9QN01yU0hEQml4cDZ6TklYQm90bzlsRUUvT0NTWGh1K1JnbmttODZjMU1t?=
 =?utf-8?B?R3h0Y2gzL1VqbE54VVNLRVNBNk9GN2s4Vkl5SWswdDBGK2k0N3lEODJxRUw5?=
 =?utf-8?B?TFRqUFBJb1hJWGVydDVid1ppU0pGYWNObVJMeEZtV2lMVjd3RUpnem1tTDdB?=
 =?utf-8?Q?d2DsCQ7ELRWwcb3glHUQnhyaF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e9b237-c465-420c-5647-08de1bb4e2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 15:14:44.5325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XODxbMk6S0ezowoMkoc4t/440OZb4rrEdBaR605cp2msOSdXy1qpBOVPXqbvMDUzdPcloKedsne6Dwm+HMqFuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4117
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNCBOb3ZlbWJlciAyMDI1IDE0OjQ0DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFy
bUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IHdhbmd6aG91MUBo
aXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOyBqb25hdGhhbi5jYW1lcm9u
QGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyB6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gS3Jpc2huYWthbnQgSmFqdSA8a2phanVA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxNS8zMl0gaHcvcGNpL3BjaTog
SW50cm9kdWNlIG9wdGlvbmFsDQo+IGdldF9tc2lfYWRkcmVzc19zcGFjZSgpIGNhbGxiYWNrDQo+
IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IE9uIDExLzQvMjUgMzozNyBQTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90
ZToNCj4gPiBIaSBFcmljLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPj4gU2VudDog
MDQgTm92ZW1iZXIgMjAyNSAxNDoxMg0KPiA+PiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90
aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiA+PiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZl
bEBub25nbnUub3JnDQo+ID4+IENjOiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluDQo+ID4+IENoZW4gPG5pY29saW5jQG52
aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207DQo+ID4+
IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+Ow0KPiA+PiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNv
bTsNCj4gPj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWku
Y29tOw0KPiA+PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwu
Y29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+ID4+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52
aWRpYS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTUvMzJdIGh3L3BjaS9wY2k6
IEludHJvZHVjZSBvcHRpb25hbA0KPiA+PiBnZXRfbXNpX2FkZHJlc3Nfc3BhY2UoKSBjYWxsYmFj
aw0KPiA+Pg0KPiA+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPiA+Pg0KPiA+Pg0KPiA+PiBIaSBTaGFtZWVyLCBOaWNvbGluLA0KPiA+
Pg0KPiA+PiBPbiAxMC8zMS8yNSAxMTo0OSBBTSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4g
Pj4+IE9uIEFSTSwgZGV2aWNlcyBiZWhpbmQgYW4gSU9NTVUgaGF2ZSB0aGVpciBNU0kgZG9vcmJl
bGwgYWRkcmVzc2VzDQo+ID4+PiB0cmFuc2xhdGVkIGJ5IHRoZSBJT01NVS4gSW4gbmVzdGVkIG1v
ZGUsIHRoaXMgdHJhbnNsYXRpb24gaGFwcGVucyBpbg0KPiA+Pj4gdHdvIHN0YWdlcyAoZ0lPVkEg
4oaSIGdQQSDihpIgSVRTIHBhZ2UpLg0KPiA+Pj4NCj4gPj4+IEluIGFjY2VsZXJhdGVkIFNNTVV2
MyBtb2RlLCBib3RoIHN0YWdlcyBhcmUgaGFuZGxlZCBieSBoYXJkd2FyZSwgc28NCj4gPj4+IGdl
dF9hZGRyZXNzX3NwYWNlKCkgcmV0dXJucyB0aGUgc3lzdGVtIGFkZHJlc3Mgc3BhY2Ugc28gdGhh
dCBWRklPDQo+ID4+PiBjYW4gc2V0dXAgc3RhZ2UtMiBtYXBwaW5ncyBmb3Igc3lzdGVtIGFkZHJl
c3Mgc3BhY2UuDQo+ID4+IFNvcnJ5IGJ1dCBJIHN0aWxsIGRvbid0IGNhdGNoIHRoZSBhYm92ZS4g
Q2FuIHlvdSBleHBsYWluIChtb3N0IHByb2JhYmx5DQo+ID4+IGFnYWluKSB3aHkgdGhpcyBpcyBh
IHJlcXVpcmVtZW50IHRvIHJldHVybiB0aGUgc3lzdGVtIGFzIHNvIHRoYXQgVkZJTw0KPiA+PiBj
YW4gc2V0dXAgc3RhZ2UtMiBtYXBwaW5ncyBmb3Igc3lzdGVtIGFkZHJlc3Mgc3BhY2UuIEkgYW0g
c29ycnkgZm9yDQo+ID4+IGluc2lzdGluZyAoYXQgdGhlIHJpc2sgb2YgYmVpbmcgc3R1YmJvcm4g
b3IgZHVtYikgYnV0IEkgZmFpbCB0bw0KPiA+PiB1bmRlcnN0YW5kIHRoZSByZXF1aXJlbWVudC4g
QXMgZmFyIGFzIEkgcmVtZW1iZXIgdGhlIHdheSBJIGludGVncmF0ZWQgaXQNCj4gPj4gYXQgdGhl
IG9sZCB0aW1lcyBkaWQgbm90IHJlcXVpcmUgdGhhdCBjaGFuZ2U6DQo+ID4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDIxMDQxMTEyMDkxMi4xNTc3MC0xLQ0KPiA+PiBlcmljLmF1Z2Vy
QHJlZGhhdC5jb20vDQo+ID4+IEkgdXNlZCBhIHZmaW9fcHJlcmVnX2xpc3RlbmVyIHRvIGZvcmNl
IHRoZSBTMiBtYXBwaW5nLg0KPiA+IFllcyBJIHJlbWVtYmVyIHRoYXQuDQo+ID4NCj4gPj4gV2hh
dCBoYXMgY2hhbmdlZCB0aGF0IGZvcmNlcyB1cyBub3cgdG8gaGF2ZSB0aGlzIGd5bQ0KPiA+IFRo
aXMgYXBwcm9hY2ggYWNoaWV2ZXMgdGhlIHNhbWUgb3V0Y29tZSwgYnV0IHRocm91Z2ggYQ0KPiA+
IGRpZmZlcmVudCBtZWNoYW5pc20uIFJldHVybmluZyB0aGUgc3lzdGVtIGFkZHJlc3Mgc3BhY2UN
Cj4gPiBoZXJlIGVuc3VyZXMgdGhhdCBWRklPIHNldHMgdXAgdGhlIFN0YWdlLTIgbWFwcGluZ3Mg
Zm9yDQo+ID4gZGV2aWNlcyBiZWhpbmQgdGhlIGFjY2VsZXJhdGVkIFNNTVV2My4NCj4gPg0KPiA+
IEkgdGhpbmssIHRoaXMgbWFrZXMgc2Vuc2UgYmVjYXVzZSwgaW4gdGhlIGFjY2VsZXJhdGVkIGNh
c2UsIHRoZQ0KPiA+IGRldmljZSBpcyBubyBsb25nZXIgbWFuYWdlZCBieSBRRU1V4oCZcyBTTU1V
djMgbW9kZWwuIFRoZQ0KPiBPbiB0aGUgb3RoZXIgaGFuZCwgYXMgd2UgZGlzY3Vzc2VkIG9uIHY0
IGJ5IHJldHVybmluZyBzeXN0ZW0gYXMgeW91DQo+IHByZXRlbmQgdGhlcmUgaXMgbm8gdHJhbnNs
YXRpb24gaW4gcGxhY2Ugd2hpY2ggaXMgbm90IHRydWUuIE5vdyB3ZSB1c2UNCj4gYW4gYWxpYXMg
Zm9yIGl0IGJ1dCBpdCBoYXMgbm90IHJlYWxseSByZW1vdmVkIGl0cyB1c2FnZS4gQWxzbyBpdCBm
b3JjZXMNCj4gdXNlIHRvIGhhY2sgYXJvdW5kIHRoZSBNU0kgbWFwcGluZyBhbmQgaW50cm9kdWNl
IG5ldyBQQ0lJT01NVU9wcy4NCj4gSGF2ZQ0KPiB5b3UgYXNzZXNzZWQgdGhlIGZlYXNhYmlsaXR5
IG9mIHVzaW5nIHZmaW9fcHJlcmVnX2xpc3RlbmVyIHRvIGZvcmNlIHRoZQ0KPiBTMiBtYXBwaW5n
LiBJcyBpdCBzaW1wbHkgbm90IHJlbGV2YW50IGFueW1vcmUgb3IgY291bGQgaXQgYmUgdXNlZCBh
bHNvDQo+IHdpdGggdGhlIGlvbW11ZmQgYmUgaW50ZWdyYXRpb24/IEVyaWMNCg0KSUlVQywgdGhl
IHByZXJlZ19saXN0ZW5lciBtZWNoYW5pc20ganVzdCBlbmFibGVzIHVzIHRvIHNldHVwIHRoZSBz
Mg0KbWFwcGluZ3MuIEZvciBNU0ksIEluIHlvdXIgdmVyc2lvbiwgSSBzZWUgdGhhdCBzbW11X2Zp
bmRfYWRkX2FzKCkNCmFsd2F5cyByZXR1cm5zIElPTU1VIGFzLiBIb3cgaXMgdGhhdCBzdXBwb3Nl
ZCB0byB3b3JrIGlmIHRoZSBHdWVzdA0KaGFzIHMxIGJ5cGFzcyBtb2RlIFNURSBmb3IgdGhlIGRl
dmljZT8NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg==

