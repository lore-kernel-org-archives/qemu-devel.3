Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3B0C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmuII-0005Ej-W1; Tue, 25 Feb 2025 07:44:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1tmuI9-00054h-FY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:44:05 -0500
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com
 ([40.107.236.48] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1tmuI4-0003Yo-Le
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:44:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or20lAd232/m1G1WkpL8pPhq/THC1lkWwTuYa4hnlrNjW4FqOdXTU2kYsGJodShqA81sYBp5pKYgM0SeF96CPilhSCWTnh6lmNrwVHH3g0U0l8NZBBbO+q6C6tNP5CHymQWRxYIM10Al9kF0qzZ64e+ylBKqjMoJJIohwumi5EHLvLl2SQ5mMQ3artk+80y4u95MR3WZNEQ7JR+PJHQMrJ1DraX9gDMRrHw1wsY71lLmovY3z20ZquHrmSibWZtflk3+YghXlWLuXWaKQVr1PfpVrXkxx7DYjnVjrmvGIl/PL6MtaL6Sjqef/2QeO63zzSd4rYdHbw0b1ItSVqqKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QookRDZBrcHmm2RQKRhtHcXgN1vRs+Zdg11u+m1kj0w=;
 b=RD3Zx2iIn727VbvnviFdwOt00BwO6Hv38TW6Im5Q3rDCb5ysH+7rZkTbFom5EmmrWaZvUPvh0MOIlSYhBTxJib9IbxFduHpmyEEc1kITS8G/FCBXF5QK/oqZ25hJIaa9YuSCCD904mCOTr5exS/D36u081bcu3oRWNu1TJkMh22DJigMIJmpJc7yDSf+/mlhjV/j6wI1v3LRQcmGBrOL9vsfYKFEES4de7NS0wwU2IAH4RTadg8F6cyllDyA87lxKJPi+IXwn2QAS7klzgsBW0U7CLp+MMx72jH9UY9ZEOAKmvQqU4aWRedX1QmD9UbP8IGQ2cdYci6KevuzMMRjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QookRDZBrcHmm2RQKRhtHcXgN1vRs+Zdg11u+m1kj0w=;
 b=nCZuH8fsGkszBy+orJBLRbopSrSPKBhOvToYeRYCKc0JNUAG5OQltwCqrg20RTfm5qbJGxOO4T+IIWHYGkPpOxqpsfMADYv7xiMbKlfO7hZXhdQagvHwP/nolFxrO7A004q6myLkKWTJ0+SWvIi/LbRZcbjUsIuVJ3XlBC1a4abryBq0XYVDS2jxDdor71EHJWNh/56yxT76MzKIHoOF45hRPmo8CqWxtnauOvv0AML386OFXC8MjBc0sQUBQfE3iNm5iKgw27HsvRvRcX40GqgAadv0gc/ofV5QGzpKNjB6y+GaTpJXnRdp9qvqNUviSFGS6XvioXQVFnjYlqXdlg==
Received: from BL4PR12MB9480.namprd12.prod.outlook.com (2603:10b6:208:58d::7)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 12:38:50 +0000
Received: from BL4PR12MB9480.namprd12.prod.outlook.com
 ([fe80::ddc2:2fee:53c1:7612]) by BL4PR12MB9480.namprd12.prod.outlook.com
 ([fe80::ddc2:2fee:53c1:7612%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 12:38:50 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, "tomitamoeko@gmail.com"
 <tomitamoeko@gmail.com>, "corvin.koehne@gmail.com" <corvin.koehne@gmail.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH v4] vfio: Add property documentation
Thread-Topic: [PATCH v4] vfio: Add property documentation
Thread-Index: AQHbgWJL5FaK74V1kki4U+yc+RMT4rNYAXBg
Date: Tue, 25 Feb 2025 12:38:49 +0000
Message-ID: <BL4PR12MB9480D046F12CB12442410DECDCC32@BL4PR12MB9480.namprd12.prod.outlook.com>
References: <20250217173455.449983-1-clg@redhat.com>
In-Reply-To: <20250217173455.449983-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL4PR12MB9480:EE_|MW4PR12MB7430:EE_
x-ms-office365-filtering-correlation-id: 02343ac1-d6d2-4f6c-a4b0-08dd55995aef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QlRtVDg4WGdXRmhCdHVhMFJmZ3pjaTBIWHN0VGVQeWhRQ3VVdnJyQ2M3SDho?=
 =?utf-8?B?aWpEKzNJait6YjZvTDJNaXlEbENNUHdUTnB0V2REb2lwV0FnUUZ5aHJGZ2xr?=
 =?utf-8?B?ZEo5TFhBYWNoMXF6QWVueDZiWE9mUmtxYVdsZks2SjJkcGp5TUh3UmlHdGFu?=
 =?utf-8?B?TkhHYXljdnVrYkdmVnBOUjJHRHFNTWxEblFYemFmNXlSN0JpQXNIcjdHcWdB?=
 =?utf-8?B?a3k3Uiswc1BaVVJ5NjVmTlJ5N1BYMndodDlUVHB5K0RrRm5DSEUvVEhPZDdF?=
 =?utf-8?B?c1BXSXlFWlZsN3ZxWktqRGZSNnJRczdPcEgwYXNaZ2puU0c2Nkl2dWd2Y1Er?=
 =?utf-8?B?NjlHcVdtamV2TnNsTnc3NmMwMGtpUnM5ZG51aFhNNTlPZlZlODB4Z2dYMWpG?=
 =?utf-8?B?YVI1dFdHc2pYVGk5NldMa2Jxdy9aOEtVQkptSTFOK1BlRFNvK1MrbG1GRnM3?=
 =?utf-8?B?YjAyRjYzNHN3WkJKWXhuOVBxMEw2ZE1kRGZnc2lUMW5PRHcvaGlMWEFNQ2ti?=
 =?utf-8?B?dXhKM3FxSGs4M2FDbFl5emtFNnFvOXBUT3BNQ3E2aGN5MVhleUtGRllZd0l4?=
 =?utf-8?B?Q0hkdXNGTmVGcGxhK2UzcVZvTnVSN1ZtdzN4MlBMSzl1ZXlLNGQzV0llY0V4?=
 =?utf-8?B?TUljTWh6VUFXRk92Q05rN085TGFnVHlaeExLVjZzRTkwVWFMUERQQjFFQ2Rv?=
 =?utf-8?B?S2Z6NVZXNzdtUC9UNnFCRlBaUnkzMW41a3hFVTNDTWRwT2tiZTNqcldvdC81?=
 =?utf-8?B?SWxOZFRKZGFkaSs4bk5yVGJqdXdMRmVjV3ZDNEJRcGc2czd2Q3dJeU52VjA5?=
 =?utf-8?B?K0JrNU5tb3RtckZOYnhraSt6dzAvWVBYcDgxbzZTWnRad201NnRTZXFMaTV4?=
 =?utf-8?B?azhicVpFVVVWTCtnbFZzb3VTRTd6bWF0YlFHYXpRRjhxbFhrYW1GckVudnZz?=
 =?utf-8?B?bEVpb0dsYTVsRXpvNXBSK0dUN29IWWkvU1VkTVJKN3kwaUZxNzlQNGRjSmVq?=
 =?utf-8?B?NTZreStTdXNKWmxQMXVPUnUyTUs5VTB1bU4yY01mYUV3ZlVtQ0t0ZjBhekVM?=
 =?utf-8?B?eDBnUEhEODA1dFdLOFd4Z2Q0RWVtS3Z0UmdQS1kzQ1NCS2tvcWdPdEdUOVVW?=
 =?utf-8?B?WWwyTkhXYjlTTWJ4RFJIdTg1VlJXcHJJOUkwWVBSTGNFMWpwOUZEUk5nWWJ4?=
 =?utf-8?B?THc3dTZZYnNiaVpHS1A2S0NXd2VWWURGQXRZV1RiRmlNUGlxTk1wS2FPNDM4?=
 =?utf-8?B?UEIzeEl0Rk9waUE4dE1pdlk5REs1MTlhbDYwaHlMNmZlTDZFTXRlcmR5VDcv?=
 =?utf-8?B?SVE0TEpRRGlNaURwdlNGMXNvSTRlM3FjZ0Izb1ppZjgwbEFHeFJ0SDhERUgw?=
 =?utf-8?B?dXBSMHVGNHBlakxvT2R3QzluUHJ6QkFQUVpwRHZuUlNXMERudG9nSVZRUGY5?=
 =?utf-8?B?MWlBeENvYmcwSWFvcExuRDBvVHV1eExRNmM1TytKbGpXbEFXUS9aOE0xTVpX?=
 =?utf-8?B?YktmR1FhSW9tZDVocnRtNnI2UmRFTVBZMzJRYlRnRjlTNVhmYzQ4aGttR25s?=
 =?utf-8?B?cTVLY1NnR2VucitnZjNFVy95QXYrZFZ3dUxSamN3RHdnbkZUUlhxVFE1WC8x?=
 =?utf-8?B?Q05KZGNjeHR6TmRPOW5henhHZVE4Wm91RDAyWkcvVlQrWGNseTRPRkxSZVVN?=
 =?utf-8?B?TzRBT3lBQ2loaTF1dElDeTVCZloxc04xL0RaV0MydUpYcVpweDg3Q2pxWVYy?=
 =?utf-8?B?UDd6czRLK2trVVJ1b3daaURzc3Jac1IrZ3N4YnN1TzVOSDVnd3N4YU43NjZz?=
 =?utf-8?B?WlpNMTFZQXJmbkx6WkdQeWo4YjZYTjllbnpKNWRLZ3B0aFVYc205Q1hya2Jl?=
 =?utf-8?B?aFZSRlAwOW1yYW9RczFvSWFIM2QvaG03VUlxRFJrL3E3cSszNFdIWlpoNEVt?=
 =?utf-8?Q?ksC6hiYmNdJMlj+GAAfp81grb+R7r0M9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL4PR12MB9480.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFuZTFMS05HSjVOVkg2K3NKc2ZGTWMvM0FjWDd2b3lpVWlTYjNQNXpyOWVX?=
 =?utf-8?B?NmJNMmQwOHZYYkRObnltQkxlWmVVcVJpYnI2ekk2YzZkWFJZSm9tcEgwL0lS?=
 =?utf-8?B?dHNmOW83UXZCZndZbWVlVE5KYTNkbnZEdnc3d2lTV2phK25sUTkxQ2VLVU5Q?=
 =?utf-8?B?QVhnMGxqZ0ZtNnZ5elVxakYxdGdXZTlzUy9UZUxjM204UzdUZEo5T2ZFR0Nn?=
 =?utf-8?B?RHpTRms3YnBDL1dWQVZWaHhHMFBDdkkxL2xJc2JXOS82cDZTNTcrZjR3aUYy?=
 =?utf-8?B?blR2c3V0KzlRSjFrbnYvWk84T3grYlltTVVmdGlGSkgxSG85bFdZd2J0bnpS?=
 =?utf-8?B?OXdRTmJoSzBtbCtyQWdYckdkYkRBTEdaajhJWTZqQnRPWC8vaTZCMG9qMUpl?=
 =?utf-8?B?S2ZNWG16Q3VYemYxdHNsSjA1c2d3TmV6b1VLc0ROb3hyOUNFVmVFWEhDQjZq?=
 =?utf-8?B?WndsK1gvbHBSc0laUE96WFEwOHJNdE83TWdqSUdVK091Yys3OGZOcThPb2g1?=
 =?utf-8?B?SWJ5Q3ZTUHhUVzlZVkR0eVNhZ2lPbWx2a2swYWdnbmgrcUFtandEWTl3Zkx0?=
 =?utf-8?B?bDNVUkcwMndGM0g5ZzlFNW9McWp3MFNaRzdQWlJ4ZllYWG8vUWFmOGVoWGti?=
 =?utf-8?B?TExkeVh6Z0sxQkUwNkVRcmRLbXpoY2FYOGxjMVZPSzV0TUJhRTZXMW16QzRp?=
 =?utf-8?B?eDBOaGl3L0JJc1lITHJmaHZ3MWV3ajJtSGNNTEFRQkxnSTRZMCtSNTZrTms4?=
 =?utf-8?B?dWhoV2JNMmFZdU5OVlFVVCtNaWJRYXB0OXlSby9GVDQwYlpXT3ZmLzkwclBu?=
 =?utf-8?B?MjZXVlpYZklGYno5M2w1dG5jZ3NNQitKRE5BOTZ6aGdFcHl5NTA1b01oVjRx?=
 =?utf-8?B?NldENFVDSlFaSjNvRk5IUjdrRVd3QXNCUjVZdjQ4b0FlWTRTRjJlU3ByNzF2?=
 =?utf-8?B?TTM3c1pYTU9tcGc5RlJaYnExc2t4MHpRS01VcVhWdGdYQlY3Z2x5ZVY3aUIx?=
 =?utf-8?B?djI2dTRGekxlbWdjZnhEeGRKdW1xcDNUYTBQbHVoN3RXVUVLY3BRY0xwNDNY?=
 =?utf-8?B?VlhZQUQ1VEVWNGIxd2FPWTAvSC8rVEpreTZ3cFhtczhBSjlRbUZHRzJCLzFk?=
 =?utf-8?B?U3hsN21ZaXBrNnZuVjhNRCt0MlI3V09PUGRkc1VNdkNyM0sybldqaEJjOE91?=
 =?utf-8?B?WkZRUU1WbGVLR2JtK2tQM0t6c0o3cVFNaHFhMlk1bjJNTm4xRXJKbzFqRHBH?=
 =?utf-8?B?ajBNV3dJd2hwWUJQbzF1TGVkL1B4V215c3JIL3NEd2gzYVJtWE43R1V3QkpL?=
 =?utf-8?B?V2d5TnlHTnp4OStpdzF3aTJocS9NRXlCYnFoQWxVcWh0M2U0TjNoSVBLaVVj?=
 =?utf-8?B?UnVQa3FCVWVmU1BQeS9jb0lNWDJ3RW5JUUdSWWU4Y2ZadUVoMnQyL2RKejZ6?=
 =?utf-8?B?TzRpcGVGS2NFWWlhZGlqZGtyRUdGSVQyeDVpS3NYVHlzamNPZVNRcXI1UXNy?=
 =?utf-8?B?ejhRQmZYY1NZOXRybU5iaWJwZGY2NjlWOEJqMXJNdTliWGZ6RVk5aG9JYkx5?=
 =?utf-8?B?bi91OEZhajFGSkNQaElwWHBzZzVMRkNHUG5JMFV1WkRIeGtDQ0tWa2VVYWIr?=
 =?utf-8?B?YjNPcUFHdm5keDY0NUFtM3hKY2Y0cWJYRFQrNDNEZVVBTzBKZHMrd21WcCs3?=
 =?utf-8?B?d1NXSUxvSHNFZnVhQmtiempVTjl4LzMxRTFHUEFUeDdIaHVMTjhITWowbXNV?=
 =?utf-8?B?S3FmSGNOYXVMK1RDOXhWLzhOQ3BkN3NLZms1TG9YQ1B1dHhiK3h4T2RKcVZl?=
 =?utf-8?B?cnZCYjdkUGJtdXUvRUVlTlJ2cWdVaU9FUzRtbVNZWUxYcHMvN3AreEh5UVNB?=
 =?utf-8?B?b1dKbVNPSmdsR25HYVJYZlQ2RFErVUMzMmtkN3A1SXlnckQxdDB6b0hnRkdQ?=
 =?utf-8?B?S2pSUEpYa1RHM0VrbWVrak9QZTJSSm9Da0JKbm1nWDhhY0VsQ0VqcGJCZENG?=
 =?utf-8?B?OFYrSndsV1ZzUWFuTXlpWXozNVpPbXNzc1k2UC9MZlgwS2NwbTdjYTdjaEND?=
 =?utf-8?B?VXlzTzVLV1BsS08rMFZUVHQwZlBjK1FtLytPdi9KNStNZXRNNlR6aU84MXM2?=
 =?utf-8?Q?1+AHkRrFnBOWXs9MVchU7ngVN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02343ac1-d6d2-4f6c-a4b0-08dd55995aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 12:38:50.0118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKCMh9CaUOnxZx5vBChVpJ/3oiVthfxITfgsycYfhRlCuw51lVT25G4vy42M+dHXXfdn66IOkXBKgNYKIBxcmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
Received-SPF: softfail client-ip=40.107.236.48;
 envelope-from=kwankhede@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTZW50OiAxNyBGZWJydWFyeSAyMDI1IDExOjA1IFBNDQo+
IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53
aWxsaWFtc29uQHJlZGhhdC5jb20+Ow0KPiB0b21pdGFtb2Vrb0BnbWFpbC5jb207IGNvcnZpbi5r
b2VobmVAZ21haWwuY29tOyBLaXJ0aSBXYW5raGVkZQ0KPiA8a3dhbmtoZWRlQG52aWRpYS5jb20+
OyBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+Ow0KPiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+OyBUb255IEtyb3dpYWsNCj4gPGFrcm93aWFrQGxpbnV4
LmlibS5jb20+OyBFcmljIEZhcm1hbiA8ZmFybWFuQGxpbnV4LmlibS5jb20+OyBFcmljIEF1Z2Vy
DQo+IDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCB2NF0gdmZpbzog
QWRkIHByb3BlcnR5IGRvY3VtZW50YXRpb24NCj4gDQo+IEludmVzdGlnYXRlIHRoZSBnaXQgaGlz
dG9yeSB0byB1bmNvdmVyIHdoZW4gYW5kIHdoeSB0aGUgVkZJTw0KPiBwcm9wZXJ0aWVzIHdlcmUg
aW50cm9kdWNlZCBhbmQgdXBkYXRlIHRoZSBtb2RlbHMuIFRoaXMgaXMgbW9zdGx5DQo+IHRhcmdl
dGluZyB2ZmlvLXBjaSBkZXZpY2UsIHNpbmNlIHZmaW8tcGxhdGZvcm0sIHZmaW8tYXAgYW5kIHZm
aW8tY2N3DQo+IGRldmljZXMgYXJlIHNpbXBsZXIuDQo+IA0KPiBTb3J0IHRoZSBwcm9wZXJ0aWVz
IGJhc2VkIG9uIHRoZSBRRU1VIHZlcnNpb24gaW4gd2hpY2ggdGhleSB3ZXJlDQo+IGludHJvZHVj
ZWQuDQo+IA0KPiBDYzogVG9ueSBLcm93aWFrIDxha3Jvd2lha0BsaW51eC5pYm0uY29tPg0KPiBD
YzogRXJpYyBGYXJtYW4gPGZhcm1hbkBsaW51eC5pYm0uY29tPg0KPiBDYzogRXJpYyBBdWdlciA8
ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiANCj4gIFNob3VsZCB3ZSBpbnRyb2R1Y2UgZG9j
dW1lbnRhdGlvbiBmb3IgcHJvcGVydGllcyBsaWtlIHRoZSBrZXJuZWwgaGFzDQo+ICBpbiBEb2N1
bWVudGF0aW9uL0FCSS8qL3N5c2ZzLSogPw0KPiANCj4gIENoYW5nZXMgaW4gdjQ6DQo+IA0KPiAg
LSBMYXRlc3QgaW1wcm92ZW1lbnRzIGZyb20gQWxleA0KPiANCj4gIENoYW5nZXMgaW4gdjM6DQo+
IA0KPiAgLSBSZS1vcmdhbml6ZWQgdGhlIHZmaW8tcGNpIHByb3BlcnRpZXMgYmFzZWQgb24gdGhl
IFFFTVUgdmVyc2lvbiBpbg0KPiAgICB3aGljaCB0aGV5IHdlcmUgaW50cm9kdWNlZA0KPiAgLSBB
ZGRlZCBwcm9wZXJ0eSBsYWJlbHMNCj4gIC0gSW1wcm92ZWQgZGVzY3JpcHRpb24gYXMgc3VnZ2Vz
dGVkIGJ5IEFsZXgsIFRvbWl0YSBhbmQgQ29ydmluDQo+IA0KPiAgQ2hhbmdlcyBpbiB2MjoNCj4g
DQo+ICAtIEZpeGVkIHZlcnNpb24gbnVtYmVycw0KPiAgLSBGaXhlZCAjaWZkZWYgaW4gdmZpby9j
Y3cuYw0KPiAgLSBBZGRyZXNzZWQgdmZpby1wY2ktbm9ob3RwbHVnDQo+ICAtIE9yZ2FuaXplIHRo
ZSB2ZmlvLXBjaSBwcm9wZXJ0aWVzIGluIHRvcGljcw0KPiANCj4gIGh3L3ZmaW8vYXAuYyAgICAg
ICB8ICAgOSArKysrDQo+ICBody92ZmlvL2Njdy5jICAgICAgfCAgMTUgKysrKysrDQo+ICBody92
ZmlvL3BjaS5jICAgICAgfCAxMjUNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICBody92ZmlvL3BsYXRmb3JtLmMgfCAgMjQgKysrKysrKysrDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDE3MyBpbnNlcnRpb25zKCspDQo+IA0KDQpSZXZpZXdlZC1ieTogS2ly
dGkgV2Fua2hlZGUgPGt3YW5raGVkZUBudmlkaWEuY29tPg0KDQo=

