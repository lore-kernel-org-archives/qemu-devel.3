Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA10CCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 18:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDS9N-0006V9-Tw; Mon, 27 Oct 2025 14:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDS9I-0006UB-St; Mon, 27 Oct 2025 14:40:57 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vDS93-0007fD-4W; Mon, 27 Oct 2025 14:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8v6GmMOWMnYwqq6Z+5Uy8Q4K+uYZ56kitYTL10d97p3VtHC9ioQ12z3m80fW0nt7k5y1LQcTkAXXDK0SkrcGUkw8jtYj0xJN/pm/kLqA1hN+ortjAAJU4ooF1WR9WTBo252jJDoJnZjIdE8kteuXETgiAwuvbYh6yUJuNq4ah/mBi1S8BT6ZaL2opXPECRodaThlUE9YOtrg1E9BZFsiFXId4WssuaRpe/U8Wp1ngsPoOTNgFoTQoC7tuqoWZ4h1IRoSCwrW9WRzVF07RVZWtXY3jRODdzAIT9klrRBVNjPIx3jbiJUkqVZcKYip386B+8/uDuTT6ZFq81RWU9u6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TADuv5BMKmasRDA46pBEkDXOmy/84jTUSyjCPHftWOM=;
 b=jioHjHh1yHmtlXI1cJyr2qPdl1zg30spqAtYsJRWvlf6H7AYcMy5E7AN1z96mF5AVQbSe7ZiqVvLqUXNMOkCEDQOGutknuGiABbY/ECV1GrWvwZVK+FjtH3FX+ZRCJbFrnnZLDcMilrV4djLn+FtXQyizWm5KbSJP5jBOxIpxslB03EkisXDaT80DJf+Cft1l96j5lazUbKyMQJMM2QcziAkfOZwxvm29uuWJuKQ/D7VJ4gSfSX7iZR4ULBvaCHy/RNmurlRn5CSQL25zMv/MVeY43E5qXtFduRYnXMbEiovElAno47GBNlmenFaHYAsfyRcLDdtQGzbam9xbdjqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TADuv5BMKmasRDA46pBEkDXOmy/84jTUSyjCPHftWOM=;
 b=ZXlkwYWxTZcg9KpFJfiXr29Csr9uNd9YgPhpWr6I6iFr9fyLhq7dkQwitz5vvE8t5F5KNoUehzYRiQBU3VAtmemtYLRUsYeRsgJXFzNO5dSBD0isF0TfEdsa+6NeQmYNbvC0Dvzlmu5Fd0gl6dWtGSCDxFPsd6snWfgYqpVc5cDvAhZUKZPlhdd43SW3ZnWr7hopUDPSxyeVnKBkUrEpFhhleP+xL5/x4uK7LHN4/shGpiWCQ1smIDDRLTGvJ3DZ6tDcxBUsJ5IcvJCFQX6HnjAjRjjD8PYXJXjhcEyLMfvbGvEqoel1dbyrahjxH8kR9MC0YQ4B6HjYyquNuZjT5w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:40:26 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 18:40:26 +0000
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
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 27/27] hw.arm/smmuv3: Add support for PASID enable
Thread-Topic: [PATCH v4 27/27] hw.arm/smmuv3: Add support for PASID enable
Thread-Index: AQHcR22pNRMa4QzP9UexFPCfwAFUR7TWT8Qg
Date: Mon, 27 Oct 2025 18:40:26 +0000
Message-ID: <CH3PR12MB754886D66A38C699CBA87D8AABFCA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-28-skolothumtho@nvidia.com>
 <e4eef901-174a-4dad-bd0a-860d705673e1@redhat.com>
In-Reply-To: <e4eef901-174a-4dad-bd0a-860d705673e1@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH0PR12MB5646:EE_
x-ms-office365-filtering-correlation-id: 1b3e0020-fe8b-41ca-26e8-08de15884bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021|13003099007; 
x-microsoft-antispam-message-info: =?utf-8?B?amFlbTFVd3dKbTE1ZW5xcFdLK3dxUld3TEgwTWZqSlhCWXNiRGwwdDhiRTlR?=
 =?utf-8?B?bDhIdVlweVVCbHoyTDc3cERoWGc2VklxT0RMb3lSU21VNWQ5R0x2VVZjdGVW?=
 =?utf-8?B?blRXbk83djZyVkJTVEpZS2Zhdit6R0x6SUZuaUhnRytOY2J5RjQxazdQeDFl?=
 =?utf-8?B?YUd3OTIvUGpON3p0NnFwend2MG9UVTNhSksrL3A1UWMxVFhVaDlLdFRmalpL?=
 =?utf-8?B?RUF2cmVPY2F4Q3Y2RjdZOURyRkZ0blRraUdMalA1bWkvNG4xZ2t4aU9kYWJm?=
 =?utf-8?B?NlR5M2lCcHJ0T3l0d2kwNFV6MzNXRDI1dVU3SmtJbkk4a1JUaTlBYjQ3a2V4?=
 =?utf-8?B?b21BMW5PRExZeW1pQUU5aHNINjltTUtiaVJyem9NOG80N1hHakhBRGlRcC9m?=
 =?utf-8?B?R01aS2RNelJ4THZpaDBJZ0JPQllkKzNXWXRXc2g3RFZIaXYvRVBzWkFvaDJp?=
 =?utf-8?B?UjBZS3dnaGhMZGRVdnVia1VPZ21GUVN2LzVrc0UxN3FGR2ptejcxZ3hVcTFN?=
 =?utf-8?B?b0Vuc1o3UXRIZEg4VDZQYXZqdnIvN3NvSmZPRk5YNlRVU00rRE9jbTV3ZldS?=
 =?utf-8?B?ZDdCL1VKd0xQMmpkMk5kUENvVk5zQVdkOE1xcTlTd1p3YmhkSVBZQW9ZUStq?=
 =?utf-8?B?TE5EdTAxR0tGb2RhaWhXcVBPeU1MZG5yelZGY05lbGNqZC9qMEFyRm1XN0Jh?=
 =?utf-8?B?QWhoWDlwMGkxc0xvc2Z4M1F6SENSY0ZBbTF2WWkxN1FsMkNWZ3M3aUV6QmVz?=
 =?utf-8?B?RmhDTVJmOVdYVldMaHpTTERrN3grUlEydG03Q1ZWTEw3dzVSN1dsSWhSY3E5?=
 =?utf-8?B?aC9hY0t6S0V5Q1h1bU5RZWRXZ0dvOFF4aElJZWhzL04reTNHVTlJZjNwM205?=
 =?utf-8?B?aTdjU0orQ3NVMWhyT05QcmN5NUdrZ2pHZEx6OG1wZ1NBOXpXK2cxbndPZ1RD?=
 =?utf-8?B?dWdMQ0ZPODkwQnFqWFdNa2g4QldrM3R5Sml6anFvYlk5SzZsOXVUdkRzVHhH?=
 =?utf-8?B?cklFQng4eE5nd0dsWTU3V3J2WnhHN3M2SkdJY3p5NHhreDVNbXh4bUpuclBq?=
 =?utf-8?B?SFR1eFYrYXV6WjJVUWcvVTdhcnlXSzF6VzNzc0NlampEUmxVMFJzVTJMdEJv?=
 =?utf-8?B?KzJORi9vRHRvcStpUk5YS2xSSmhlc1JpbFJmQ2dBRWpIcEc2eE9NcGRlb1NQ?=
 =?utf-8?B?V0xhaFRpc3MyV2NZZ08zazRUSmpVa2Z4aGVGaTNaeDlrR0poKzJ5Z0ViT1lF?=
 =?utf-8?B?WndLdE9NU2ROdm44TXlDZTRGakYzMjlIMENHOFVNSmR6WHU5K1dCN3FOMnFX?=
 =?utf-8?B?cEtPdytMRHhNSFVXZk1ka2lQVUFhRVJNeUpJeExpTG9NNHZ2dkFHMEJHYXdt?=
 =?utf-8?B?ZDNNU00rbXQweS95L1hEWWFwWEh5MmhGVW56cS83V3o2OWEzamNWa1NrSlZ1?=
 =?utf-8?B?eXlLQ2dha3J1d0U0YVM5K3NyWW52bFVVSU15UzVJTDlFNHc5dXRrVEhuTjNM?=
 =?utf-8?B?TkIwQXBIKzUxZHBhaGZCTTJaTmZHNU1ZK3VTQXZFQ0N1Vnl1dmdUcll1OFdY?=
 =?utf-8?B?UmxZRjZXSWdMdUNUUXBvV3JqZXo0ZEhjSklhVTNzUzF2dlQwRnZiUGNjeVNx?=
 =?utf-8?B?eFY5WWh0WVE2eUY4eGxlY0psZmtDcHd1SWhLWmt5MjkwMUhXYVc1ZlhlaEcx?=
 =?utf-8?B?SHJIRkFqQml5NU1pQ0lHRnEzenVweDFHUTNWNGp3MWlYN3NDdlQzb2JoZHlj?=
 =?utf-8?B?elJFT09JTWF0M0o2dmRVdmlCdTBMc1V5UzBuVTh6b2NHaVhFVHo1ZmJxaERn?=
 =?utf-8?B?R3FSRFpuLzZMSmFpeXJqUzNzV0RISWhmTkQvcXRaaXl5UXI3QmFwSEhZLzBq?=
 =?utf-8?B?WkF6WXZJTFZqMzNtUGdEWHhra2sreFFxdkttSHRIeTBFN203QkRKa1VpUEly?=
 =?utf-8?B?MGgvUXkxZDNrTUhvTWtjTTQ1UHZ5RUYySG0rRy9IT2tNQ0V0bVVNUGUybWpw?=
 =?utf-8?B?NSt2MzRCdi93PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkplZEgwdmduN054L0FUNit0REQyOVVCTHlwbXN5dWM0NWRSbndqNkhNQ2Zx?=
 =?utf-8?B?c0pLZERBb3NTbzR2ODFyaFNsdEVnNkJzQnNoazVucnZJcVNIM1B2MkVnazB3?=
 =?utf-8?B?L2NyVGtqMVRpRTJLQ0dFU0l0aDFEa3NJQ3lXN3VlT1lpY29VeW9GM0svTEVW?=
 =?utf-8?B?aHp6UVpzRVZLd0tPRmtxYytXQjMrTjZkLzFuQ3ZGb3V6M3F3cXdXS3RYb2Ix?=
 =?utf-8?B?UjltazJiUnFvUVdqVzlOWE1vcENndnJhME1Lb0tWdmFFRXh1U3NSWWRhVFla?=
 =?utf-8?B?cHFaUUJqeTMvdU9GWUpDd29FQXpYOWtKeENJV0w0OWRzaEJqYWhNd2p1VkMr?=
 =?utf-8?B?K0hsV2M0LzNnYzZ6Ky94VXcxVkRDZWFLSUUzY2tndTNSU2pzWGVPQkNlWHhR?=
 =?utf-8?B?T2ZXVDlPL1lxQnJKVUtTNTlKMlJyY3VWaFR2SkloRDl5Mmg0c0FlTzg2SDZu?=
 =?utf-8?B?V0UrdFBsazFlRWVtWkFlZVI2U1ZWOWZ2aEN3OEF3UlVybndnMnZSYU1hUnVX?=
 =?utf-8?B?NFJBUk5BVThuYU8wcmx6UW1GTDIvdHAvdUdWQWpsd0V2V0VHQnFBamEvclA2?=
 =?utf-8?B?WGczZ09iSW04NSs2WEZLS21CZit1Vi9HS2xkSzI2TUYrOEFJODM5aENIRW1N?=
 =?utf-8?B?UUFWRUU5UklqUWFBQWtHTVhyL1R5ejRUZzlkNTQ5KzNlQktQRld4SGpKY3Z3?=
 =?utf-8?B?amoyTG56djRmdjlUaGl3bXRCOTVCR2NpczMwbWdlZ3pHa2VISEVDMXdNWU9G?=
 =?utf-8?B?aTNoamx1dGNzTHlrTkI4aTlGbDk4YVJLRkZvTHIvWEh5Z3FHT0lWaGQvcGNj?=
 =?utf-8?B?VHFXL2VGZU94dENSdGVVYWJwYk9rczZxZFJNZTRRQTd4MzRuVTE5SWVFMmxS?=
 =?utf-8?B?M3YrL1kwTzliakw1bVBjN2NydTFoVkVnL1gwZElZM0w3MlpuSFVJbWo0RGUy?=
 =?utf-8?B?V0ZRUC8vQmFCWTQ3dFBMbndzRGE1NE51eVd4R3JVb050WDZqWFdib2I4Nno0?=
 =?utf-8?B?bzR6MERTOUZaRlp3K1VJb0V5NUZLWCttT3FmZHhvaFZjbEJZV3pqcGtmNjdm?=
 =?utf-8?B?eXBWWXVhWjVRWHR3MEZiWCtNSDVJdWRJTW53aHpxaXpocFJJRVBLMVlHSkRD?=
 =?utf-8?B?Z0Flb0NiajlmNlE4YVphckNsYVN5UERmQ3lQUWNvRGxGRmpTS25PUTNwSWF0?=
 =?utf-8?B?Z2xZMzAzbHdPVk1US3IvU0pMaUkvRlYvV0puL1JrRmlYMU1BWnNWb2wrQzJ3?=
 =?utf-8?B?aFlTeER2YXkwL3kzYXJRQnB1MHlkREd6dTdvZ0piQTlVWTlYbi9ENmVYY1Vz?=
 =?utf-8?B?ZjdUd0VETGE1Ykd6SzQxbkxtdGoxVFVraDFSS3RmQnVHSWhmdSs4cC9NZ3Jm?=
 =?utf-8?B?eUVwSzdrSkV3amJjNEw4elVrV0xUSEZCcHhoQ2hIUGJZcUpYdVFQVGxvMTc2?=
 =?utf-8?B?R1YvdkJ3Qm1WTTRFWGxxbkhteXU2RWZXRnVvQVllWEdCNzhmVmMzVEpTL2ZL?=
 =?utf-8?B?dUEwYjFQNVg4bmF0NGd6eHZ0OHp5Ym5uM00yNTZiMDA3T1ZZYVBKNkprSTF2?=
 =?utf-8?B?cnR6UEpoeStweWpqTEhUVlZnL2o5c2wzSE5BZE05Q0JtTFB0Yk9ndC9qdStF?=
 =?utf-8?B?SFkyQlNvSk92OWZ5eWR2bXc2bnZkSlRVK2hsT09xOHhmekVZbi9vbmZQcVpr?=
 =?utf-8?B?K1FTZURncENlWEIrMExTeGJZckR3Q3JpeFVxRm05eSt5dExuQWhrMjVuUVBu?=
 =?utf-8?B?cnZDQlc4T2NtTlF3c0lHdDFrQ2ltcEdDd0twUWhvcEhUN1NSYXJvOTBjSEZH?=
 =?utf-8?B?UUFFSlkzWW9na2M3WU1FRlE0MXRUQnh1Q0k0U2M0YUlWYndJcHIxQmNJWGdt?=
 =?utf-8?B?eTdUOHZCVUE2SXVCcVc1aGNJaTlBV2NtM3I5aW5iWDZNaE5hdittLy9MZy9o?=
 =?utf-8?B?Q0N4UzAwZ0VheUVQVU5GQUx0RnVERlhrV1lFbFVWVjNWS1pJS0d5UGE5R1F4?=
 =?utf-8?B?V0JOa1o1MGlrVFVXa3k4UGE0N1FKcExpLzBwMkFoV1A4d3VrSXZ3amhqVUJq?=
 =?utf-8?B?Mnp0eVNZeXFEVjUzMkZaUHhYaUtoYUhVVCsyRkpwTFc2QlFHYjVlellSeDI1?=
 =?utf-8?Q?XrUU5MUJ0gZ7u2+CPwwXc1Vqr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e0020-fe8b-41ca-26e8-08de15884bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 18:40:26.3321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujIc10/8v1BavJZFmosOyYMNBov6uVlEzzeVKxnnQOtNQA348ADKsVLf3jIxOsseAoOPh1KAPAimNkm5umwNag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDI3IE9jdG9iZXIgMjAyNSAxODox
NQ0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5t
YXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBOaWNv
bGluDQo+IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJl
cnJhbmdlQHJlZGhhdC5jb207DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBN
YXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5n
emhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4u
Y2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25n
LmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBn
bWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAyNy8yN10gaHcuYXJtL3NtbXV2Mzog
QWRkIHN1cHBvcnQgZm9yIFBBU0lEDQo+IGVuYWJsZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFt
ZWVyLA0KDQpbLi5dDQoNCj4gPiAtICAgIGlmIChTVEVfUzFDRE1BWChzdGUpICE9IDApIHsNCj4g
PiArICAgIC8qIElmIHBhc2lkIGVuYWJsZWQsIHdlIHJlcG9ydCBTU0lEU0laRSA9IDE2ICovDQo+
IHdoeSBkbyB3ZSBjaG9zZSAxNiBhbmQgbm90IGEgYmlnZ2VyIHZhbHVlIHRvIGF2b2lkIGluY29t
cGF0aWJpbGl0eT8NCj4gd29ydGggYSBjb21tZW50DQoNCkkgYW0gbm90IHN1cmUgd2hhdCBhIGdv
b2QgdmFsdWUgaGVyZSB0byBzdXBwb3J0IG1vc3QgaGFyZHdhcmUgb3V0IHRoZXJlLg0KSWYgd2Ug
c2VsZWN0IGEgYmlnZ2VyIHZhbHVlLCBhbnl0aGluZyBsZXNzIGNhbid0IGJlIHN1cHBvcnRlZC4N
Cg0KPiA+ICsgICAgaWYgKCFGSUVMRF9FWDMyKHMtPmlkclsxXSwgSURSMSwgU1NJRFNJWkUpICYm
IFNURV9TMUNETUFYKHN0ZSkgIT0NCj4gPiArIDApIHsNCj4gPiAgICAgICAgICBxZW11X2xvZ19t
YXNrKExPR19VTklNUCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICJTTU1VdjMgZG9lcyBu
b3Qgc3VwcG9ydCBtdWx0aXBsZSBjb250ZXh0IGRlc2NyaXB0b3JzDQo+IHlldFxuIik7DQo+ID4g
ICAgICAgICAgZ290byBiYWRfc3RlOw0KPiA+IEBAIC0xOTYyLDYgKzE5NjMsMTAgQEAgc3RhdGlj
IGJvb2wNCj4gc21tdV92YWxpZGF0ZV9wcm9wZXJ0eShTTU1VdjNTdGF0ZSAqcywgRXJyb3IgKipl
cnJwKQ0KPiA+ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIm9hcyBjYW4gb25seSBiZSBzZXQg
dG8gNDQgYml0cyBpZiBhY2NlbD1vZmYiKTsNCj4gPiAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+
ID4gICAgICB9DQo+ID4gKyAgICBpZiAocy0+cGFzaWQpIHsNCj4gPiArICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJwYXNpZCBjYW4gb25seSBiZSBlbmFibGVkIGlmIGFjY2VsPW9uIik7DQo+ID4g
KyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICAgICAgcmV0dXJuIHRydWU7
DQo+ID4gIH0NCj4gSnVzdCBza2ltbWluZyB0aG91Z2ggdGhlIFNNTVUgc3BlYywgSSBkb24ndCBz
ZWUgYW55IGhhbmRsaW5nIGZvciBTVEUuUzFEU1MNCj4gYW55d2hlcmUgQWxzbyBJIHdvdWxkIGV4
cGVjdCBzb21lIENfQkFEX1NVQlNUUkVBTUlEIGxpa2VseSB0byBiZQ0KPiBlbWl0dGVkPw0KDQpT
MURTUyBpcyBwYXNzZWQgZG93biB0byBob3N0IGtlcm5lbCBkdXJpbmcgUzEgdHJhbnNsYXRlIEhX
UFQgaW5zdGFsbC4gQW5kIGlmDQphbnl0aGluZyBpcyBtaXMgY29uZmlndXJlZCB3LnIudCBDRCBi
eSBHdWVzdCwgdGhlIGhvc3QgU01NVXYzIHdpbGwgZ2VuZXJhdGUNCnRoZSBldmVudHMuDQoNCkRv
IHdlIG5lZWQgdG8gY2hlY2sgUzFEU1MgaW4gaGVyZT8NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

