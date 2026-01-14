Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC395D29FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfzxU-00036A-6i; Wed, 14 Jan 2026 07:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfzxN-0002z0-N9; Wed, 14 Jan 2026 07:26:37 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfzxL-0000jV-MM; Wed, 14 Jan 2026 07:26:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLqMo7syHoIvRthWYUuNKpiYDnrdn8ttkeoM9rcmrTyFpQYypb4+1qjGFf1c3bGtQokCs1XDxHcmEPq6GHdGECk7Nqg5FKdKlGmKGMzvNMef4bMOhAvuLbWCV9p8vW6+G0BOviqFSC22BD3eil9u0sMfdnLRw5543Gi2JwoU5+VJrU9L2Hs8GJ18OePECCmxuj0gkagveHL2q8QG/ZExqY1ST+KkNaJQqli/hxsZfIo5Ra1inHaCEf1yvJHHSwFOiX0ssUR8sIAHxiraHrE01c4kpOqGd90A4yHUFBTP8lruB39TlQ46zk47GzsymaQjgn1wAdmi7mnga9jIJgZCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO8+kUZLuulGKfvlITxt+lJ42sre/TxaHjT7G/qkiYI=;
 b=AbP9j1S12kdMEYSh+8IXr8P8wHXFlHHz1CNjAkoDOJO4oaUEndmAkrivMwLiePDkrma2NnMI3hPjrf0X7eKwYAYy6KgMU2NKhNi6Y+mL7BuZLVFTgFr0FISwRcVuVf1+zFPvejpECF2n35BDO4k23aqD5vKpX4d3FMNNew0Pb26xbB3pm0M8FSYHRGUZlS/024rZAprvshbMKPRGKZyiF9k3WwMK82hcmENOdWN3QGFobW9Sdrh7yRkF5kGHycYYpeITAiNqY0ud97XQOstR1xSwifSzSPdO7rp406jz2eF73vuPhs/7MsAug2wnEQfumRn2PuRSFFyM7DkPXS2Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO8+kUZLuulGKfvlITxt+lJ42sre/TxaHjT7G/qkiYI=;
 b=cf0WRxMaYBEPngf7z/C3I6qzQyoeeMrhsQwCfTblH5sylz63U5ckgOHiG4f/39hgokSqsKaGoTGzK80+h9dZI4mFWCG9uDpWgTVHqkhTp/4VqKoVh8J0tYdsjsT0PLkXQGSrn60ZPQf41Wrr3PCUml/yjpLMVsXbW3QflBFmZy6LXqlLtjIL8KBPoXatUM+fEIvqR+i25Bb74XlekTs3meduvNzi5ciuighmrcv4CRQhVsw/Zax1FHbpHg1LewHdReJYdGQ4qe51IBvajKyZPhHM2wzfYN/WIr1QX2d8wDc8COHc8K8X1Q+WQmEzirxxDwu0DRItICeUT7fcIy43rw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 12:26:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 12:26:29 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: RE: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Topic: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Thread-Index: AQHchUtYWMpnqnwbYUGleR31M25t67VRkjFg
Date: Wed, 14 Jan 2026 12:26:29 +0000
Message-ID: <CH3PR12MB7548C1DABCCCB8CB332B59A0AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <20260114114556.0000153c@huawei.com>
In-Reply-To: <20260114114556.0000153c@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA0PR12MB8352:EE_
x-ms-office365-filtering-correlation-id: ee15d4ea-5c22-4101-8260-08de5368252f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Y1VZeEVnMXBHR0FvZWdDeVg5UFNHZStONS9kRXQxcFN2WldIUTdCd2ExaUda?=
 =?utf-8?B?RE5XNlMrczBCZVgrRE5WQnlWMGEzckViZlJnMXJBNzBJTVRkQnlQTmdmZU5q?=
 =?utf-8?B?aUZrT0NvcURDUkJPN3VNd1FFSDRsbkZ2UkNDTFBwOEZuZ3M1SXZlb3JHSEM2?=
 =?utf-8?B?dkxCNy9vc1JDaW5FNWMyZnF3K2liTG04eHd4Y0RySWE1b3JucTdOQ01HMjRy?=
 =?utf-8?B?RGppZU1qbHd4c2tlR2Zpckp1eVRrVFphN0hvTnJwQ0tnZU9rdDd3VHRvZFls?=
 =?utf-8?B?QUl4WkhQYUdEYWJsRElJdDNncDlreHNIcGRPSXFkcDlXczR2YzBjVkJMWUhH?=
 =?utf-8?B?dlVsTmEwNVl3T2VKQ0NydTJGVTJGYXhYM0hWYzFZT2I3YlVnbVVjNDQyOERH?=
 =?utf-8?B?dlZVOGNya1JIL3BrMzdKUTR3MzhjUXRQL0NZSklQYVl1Uzd4YXV3ODdLWWtW?=
 =?utf-8?B?VWlTb0pPbXZwUnd4d2VEQ3l3RHF6dlh3djhRVVRqSHdGSW9hOVpselhJeFlW?=
 =?utf-8?B?MFRvZFlCZmp6Q3ZwbkZaRUsveXNnV3VkQlJiclFHa1lEYk52TVpIVzZXQW5p?=
 =?utf-8?B?Z3ZsblFYZmdkaGF1OVJ6NkFDMWNHeXc5cExaSjllSzAvRE1XQmYrMU54a0Ra?=
 =?utf-8?B?VVN3dEFmTmZtMWQzdnNDRXVvdkdjTE1vZ2VMdkhHRkJoSUxUTUcyRlJHSkhD?=
 =?utf-8?B?NzBnQ0FhTWxYbFlZak9YaG1Ga3MvTnFxYXIyWk5JQWVrYUVkNkdSNFFPcDRN?=
 =?utf-8?B?SmlKdGtJVUxRNTRybE9GWG5acjgyWEJWZ2E1aHZ4MW9tMVcxalV4Mk13VmZ6?=
 =?utf-8?B?SnFPaHVuS3NqQWh2WlpPV0xMdktLcWRhc29US1pDcVB5TWlQSXg4TzJpUElL?=
 =?utf-8?B?UHZxbm1Pc2hlaE45QjlxSVRzWm1HMC9IekxyVjJKVkNtb1JUNDF4WXZTZnR4?=
 =?utf-8?B?TUt5YjBteG85RTFwY0F0RXF2WFVWWDhiMkErMG9nekExQXg3TkdGdTlKS1A1?=
 =?utf-8?B?ZGdxQUpSczltemtNZll2WTdzYzduYVNlQkFmdXAyd2dicTY0VSthbExYaC9v?=
 =?utf-8?B?MG9SNU1lRlplZVgvL0tQUTlOR0pJekEvTE9EY0VxR3NWNS9ta29zajJ6bmVV?=
 =?utf-8?B?TWMvR3lINStnd1hXc2NkcHBlZjFVcnloWEN5MUVwd1N0NWJ2OENkVUxMYjhk?=
 =?utf-8?B?Zk5tdjhZeU9KOG9WcE9VaFRPUHBzR2xWVDdGeGZId2xWODdCYjBHVmdwQjlD?=
 =?utf-8?B?aXlRRUdVVEtxUGtvbVhPYWpqcVNhUEpXVTIveWhwUFB1dG4vK0FVakpkbTY1?=
 =?utf-8?B?bGFKYnFYQmVFbHh3MExmc0NhYUxEYy9yajQyN2FWQThLU0JuYm1id0lURXp5?=
 =?utf-8?B?Ym9nVjVEMTE4NU41eStlOTdqMlg1S08yKytuN1NNY0p4U2RiQkRoUzlsSnZN?=
 =?utf-8?B?TmpuT3czTTY3aEUvNzRLc0RUWktQUXpRQkNmSk4vTS9CUGRTTktxTDZSUmw0?=
 =?utf-8?B?ZFJzSnUwZE84UC9wb2JiLzUySGY5Rkl5MmVMWmQrdTJDVGpPL2htblVsOVlv?=
 =?utf-8?B?QUZIQWYrbWV2NmJLWEEyT0UyWGZzU0NxNmI4NksrSFhsK3llUDdtMXAvcFpN?=
 =?utf-8?B?Uno2ajFJSXFRZUdIL3ZNRDZtSmRvWFY4UFY4UU1OZDNpZlBwakZSTnZRM1ps?=
 =?utf-8?B?NmdQelZsU0czMDNCOU8xUzlhT094ZUxFcmhNczBBNHBJTm0xdGpnSUJKbDhl?=
 =?utf-8?B?SjZuYkpUNjV1NzNvV2gyVEszU0szbStUYkxsLytINEZlQ0ljUWJqbGdzSjRt?=
 =?utf-8?B?bnU0WlE5MnZPZjdwc3FsdVo4MHNRMlA1YTBtVlgyT2d0OVJxOEMzdzJVYzBx?=
 =?utf-8?B?MDJDZFVKM3ExL1ZCT1g4YkkxanVrL2s2YlFQYmdlWG1YclZ2L3pLS01QWVNB?=
 =?utf-8?B?Zkh5S3lTKzYxVU1NRlJsMjZVS0dzMHVBbDdaajFrOUNrZm91M1JmNDJlTGFT?=
 =?utf-8?B?bGpwT1BFZ0g4WmV5WWRWNlY3Tjd6TnVvdkFKR3Y2ekNjUHozYi9CSFcvb3Vs?=
 =?utf-8?B?Z2ljKzNCbFJWbWRnQzZaMy9yNDM4WUpJaDNIMlducTlKZThkMXlUajNYQTBN?=
 =?utf-8?B?bDdpTjFsUXlTZ2M0R1FwYnhCejdJRzhmcnBwZ0YwTEVqRU5XMHdzdXhOeW5W?=
 =?utf-8?Q?7tv8ThH0jdiDEyANwoRZRso=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d25jV21Zck4xb0UzQmYwZWVjUUlZcUJGVEFFOU90UkNoZGdzeXhmRHo3NHJZ?=
 =?utf-8?B?NDhWT3lBQ0JEUFpVaEhENEkvajVIelY1SWVic3paRUpFVGRRNFBSc2Z3QmVh?=
 =?utf-8?B?UmUyTEFNQnZiWTZ6K1dFSlU2cUsyZDN4VmROdEkvUlZUYkE0OTU5ZjRWTzln?=
 =?utf-8?B?VWtzWkNOMEI1bDRlMktWN3dvNnNYa21YSkZsMlM0SGlPWnpWOGl4T3o2cVlS?=
 =?utf-8?B?RUJWTTFsNDhJek9EU2VsS3Vlc01tM2dKQzR0dGVjM2o0bU5ScytoQXlVa3d5?=
 =?utf-8?B?a3cxNHdDemVGRm1FeE9RUWxiNHYxT1ZIVVZPemg5WERpQ2NXK1BtQVg1UG5r?=
 =?utf-8?B?cjNtOEQvcXNJdS9UTUYvWlVzQ2NrTUI2MmxvUS9FaUNyaG1VcXRLcTV6MGZx?=
 =?utf-8?B?THY2Mm5GdXFNL3Z5bzd6TklWczFxMVh3aVZqQXdUVFI4SWJPVGxOUVZzbk90?=
 =?utf-8?B?bXlQR1VDaEZPRGJ6b0JlbFBVYm04WGNIcHRlOGNlYkl1bzZrQW5qQU9ZdXBt?=
 =?utf-8?B?N3M3djNhcVZhZnRaUVNLdkVPNHpXeVBST0ZLQkpHM2U1NDBMSXFuUWoyUmhp?=
 =?utf-8?B?WE9ydWhacWdjVFJjVUhLTHVMUnE4NTJwQ20yTit5VzlFUWJPNzN3TDNSTkEy?=
 =?utf-8?B?clRVdFR0YS9HVFdaVmJmQ2U5K2JINEJmdW1DZDFDSUxZM2pBZi9jTE5MeG1P?=
 =?utf-8?B?bXcrRVVGeVpyeHZteVdKUnhMK1NxTUZTNThORUt2bGY5NlQ5cWpWWENvbEI1?=
 =?utf-8?B?QXZBc3UzMnJVWkQ3OUxTeTg0bGpaelRpdDBER0lGdkZ6RUZLSnQvRVp0Q2xJ?=
 =?utf-8?B?Mm9sVFRsVGxlMVIxaWxhYi8rRkhEeTJlYmVaRU0vWnYrUU0zeTdySnpLU2Zy?=
 =?utf-8?B?dHBrSEhPNjZ6MjdOV2p4MXQ0dytxYkNhQit0N3FkNkUvQTNveko2dzRFZXpG?=
 =?utf-8?B?ak1lMVlERXdOMkVVREc0ZS9nU2Juamd4UC9DL09uK1F4Z2NMcDU1ZllVZlFF?=
 =?utf-8?B?dkNLQmttTCtkWWJKNWhnQzhFSTMvL3FJcHFCYjdGOEd2VW91ZHpVVHNmUE9H?=
 =?utf-8?B?N0s5UnVBNWlOak1ybDRickZ3czhQQVFqdFpUTktBa2FodWo3R1ZGWXN2cHVv?=
 =?utf-8?B?RnJCcWM2clAxUnBIVmhyR25kcVRwZVBiZm5jQjllaTVJK0ZSKzlFUS9hVUVF?=
 =?utf-8?B?Qm1nOUhXdDQxQjgzd09Hc1VRWjllWnppMUo0Z2s4am1vMUx4aUV1ZDNURmt3?=
 =?utf-8?B?ZHZOcURaZGxhR3lkSTFhUmdJOEVXR0pseFNMSnFyVmh0WmMvUHM4MnM0T1Bt?=
 =?utf-8?B?VU1UODFpd0ZVeURsNGVVLzZ6S3JRWjBNV3N3QWc1TzJuZHdybU91QVBSa0NY?=
 =?utf-8?B?d0dFcmFwV2YzcGdJaFVzVGtHdUFFWnk5YnF5enY5Z2ZaNzdCMnJ0Zk5kakJF?=
 =?utf-8?B?VUFqU0NSSXZhMXRYRlFqT0RCcm1XUmdiRXVqTXJpT29tV0t6VDFWNmhCQ2pk?=
 =?utf-8?B?eGNrQ2dlaEMxZjBIclprN0xYWkw3VVB0VkFmS09YVE5DV0JJTS9XUzlWKzZS?=
 =?utf-8?B?amkrTS9Xajk0aU1ncVJORmZndC9UWTAyRjg1ZGQ2eXlkUHRRdnV6NHI1YnBS?=
 =?utf-8?B?TndINDZyNmZIbDN5eWl6VFlmMnd0NnVhWFkvWStITVJGcGp0VElFRUwwZlVx?=
 =?utf-8?B?L2JaWnlkdXovRFpQVFA3RG1veUpMUEg5cWNiRzkwSGtTQk9JWGFyVVYxcVRV?=
 =?utf-8?B?dXNGWW9GcCt5cmp0b0VKeXBNYmp5N3dDSEllTjlUN3hqSVhBK2QwbXVxQU9v?=
 =?utf-8?B?NGZldVVKK01TRzZHdTFaSGhrSnNIMEVHWVBPU3YxMmdBNFBPQTY4amhDbHR4?=
 =?utf-8?B?VFpzQzRWa2hKVEVvVkZNUWQ0TUo2RGliN2p2Z0dwUWNHb3NGR3BIT2hhdjR6?=
 =?utf-8?B?ZVZ6N2RvTE9CNGxGUDhkcGorcG1NRkhuSWlXUStZZU1Qc2xjaFdmTVNraHgz?=
 =?utf-8?B?MXVxQkV0WkxHR1hoMUY4WEpQSStYRWRmck1PM1Racm1lcjJXaXhRNkJQTG1m?=
 =?utf-8?B?Vk9HWUxkTHp1R3c2Ly9ZdnRyQ3VMUTZndUlyNXVGdnYrSytrVDlKNnZCcXEy?=
 =?utf-8?B?L1k3V3BmdHhyYzdjQjVjN09Va2YwSnRKWFoxWjRvS2dick5NL2VqSU9wMjZB?=
 =?utf-8?B?cEhMVlFzdVZqaGQwOXdiL1ozMC9NMmpmNlgyMWxsVlBjT1JTWXpUbVVXM25w?=
 =?utf-8?B?QjFiZE1nNVBjaGJjdUhraDF3aTNHemd5S2FCYmQ3QkR6TmtDc0FVcUhRS2Zx?=
 =?utf-8?B?UG0wWCtROWtBTEdObTgvbndDdGkwOGRmVlNtYytWcGt1Qno4UW5Bdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee15d4ea-5c22-4101-8260-08de5368252f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 12:26:29.8738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yMZYOwAgBpVYRpni/t12q4M9hw5fLZTKxrhhMFXkMRgm+sZNGIMzS/sXK1CBj8Zy8wXJaUqW1v8VY54pr8Q2gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTZW50OiAxNCBKYW51YXJ5IDIwMjYg
MTE6NDYNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0K
PiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBlcmlj
LmF1Z2VyQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgSmFzb24gR3VudGhv
cnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT47IGRkdXRpbGVAcmVkaGF0LmNvbTsNCj4gYmVycmFuZ2VAcmVkaGF0LmNvbTsgY2xnQHJlZGhh
dC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5hdGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5j
b20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29t
OyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgemhh
bmdmZWkuZ2FvQGxpbmFyby5vcmc7DQo+IHpoZW56aG9uZy5kdWFuQGludGVsLmNvbTsgeWkubC5s
aXVAaW50ZWwuY29tOyBLcmlzaG5ha2FudCBKYWp1DQo+IDxramFqdUBudmlkaWEuY29tPjsgTWlj
aGFlbCBTIC4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djcgMzMvMzZdIGh3L3BjaTogQWRkIGhlbHBlciB0byBpbnNlcnQgUENJZSBleHRlbmRlZA0KPiBj
YXBhYmlsaXR5IGF0IGEgZml4ZWQgb2Zmc2V0DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNh
dXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIFN1biwgMTEg
SmFuIDIwMjYgMTk6NTM6MTkgKzAwMDANCj4gU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhv
QG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gPiBBZGQgcGNpZV9pbnNlcnRfY2FwYWJpbGl0eSgp
LCBhIGhlbHBlciB0byBpbnNlcnQgYSBQQ0llIGV4dGVuZGVkDQo+ID4gY2FwYWJpbGl0eSBpbnRv
IGFuIGV4aXN0aW5nIGV4dGVuZGVkIGNhcGFiaWxpdHkgbGlzdCBhdCBhDQo+ID4gY2FsbGVyLXNw
ZWNpZmllZCBvZmZzZXQuDQo+ID4NCj4gPiBVbmxpa2UgcGNpZV9hZGRfY2FwYWJpbGl0eSgpLCB3
aGljaCBhbHdheXMgYXBwZW5kcyBhIGNhcGFiaWxpdHkgdG8gdGhlDQo+ID4gZW5kIG9mIHRoZSBs
aXN0LCB0aGlzIGhlbHBlciBwcmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGxpc3Qgb3JkZXJpbmcgd2hp
bGUNCj4gPiBhbGxvd2luZyBpbnNlcnRpb24gYXQgYW4gYXJiaXRyYXJ5IG9mZnNldC4NCj4gPg0K
PiA+IFRoZSBoZWxwZXIgb25seSB2YWxpZGF0ZXMgdGhhdCB0aGUgaW5zZXJ0aW9uIGRvZXMgbm90
IG92ZXJ3cml0ZSBhbg0KPiA+IGV4aXN0aW5nIFBDSWUgZXh0ZW5kZWQgY2FwYWJpbGl0eSBoZWFk
ZXIsIHNpbmNlIGNvcnJ1cHRpbmcgYSBoZWFkZXINCj4gPiB3b3VsZCBicmVhayB0aGUgZXh0ZW5k
ZWQgY2FwYWJpbGl0eSBsaW5rZWQgbGlzdC4gVmFsaWRhdGlvbiBvZiBvdmVybGFwcw0KPiA+IHdp
dGggb3RoZXIgY29uZmlndXJhdGlvbiBzcGFjZSByZWdpc3RlcnMgb3IgY2FwYWJpbGl0eS1zcGVj
aWZpYw0KPiA+IHJlZ2lzdGVyIGJsb2NrcyBpcyBsZWZ0IHRvIHRoZSBjYWxsZXIuDQo+ID4NCj4g
PiBDYzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gSGkgU2hh
bWVlci4NCg0KSGFwcHkgbmV3IHllYXIhDQoNCj4gDQo+IFJhbmRvbSBtdXNpbmdzIGlubGluZS4u
LiBNYXliZSBJJ20ganVzdCBmYWlsaW5nIGluIG15IHNwZWMgZ3JlcCBza2lsbHMuDQo+IA0KPiA+
IC0tLQ0KPiA+ICBody9wY2kvcGNpZS5jICAgICAgICAgfCA1OA0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8
ICAyICsrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2llLmMgYi9ody9wY2kvcGNpZS5jDQo+ID4gaW5kZXggYjMw
MmRlNjQxOS4uODU2OGEwNjJhNSAxMDA2NDQNCj4gPiAtLS0gYS9ody9wY2kvcGNpZS5jDQo+ID4g
KysrIGIvaHcvcGNpL3BjaWUuYw0KPiA+IEBAIC0xMDUwLDYgKzEwNTAsNjQgQEAgc3RhdGljIHZv
aWQgcGNpZV9leHRfY2FwX3NldF9uZXh0KFBDSURldmljZQ0KPiAqZGV2LCB1aW50MTZfdCBwb3Ms
IHVpbnQxNl90IG5leHQpDQo+ID4gICAgICBwY2lfc2V0X2xvbmcoZGV2LT5jb25maWcgKyBwb3Ms
IGhlYWRlcik7DQo+ID4gIH0NCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBJbnNlcnQgYSBQQ0llIGV4
dGVuZGVkIGNhcGFiaWxpdHkgYXQgYSBnaXZlbiBvZmZzZXQuDQo+ID4gKyAqDQo+ID4gKyAqIFRo
aXMgaGVscGVyIG9ubHkgdmFsaWRhdGVzIHRoYXQgdGhlIGluc2VydGlvbiBkb2VzIG5vdCBvdmVy
d3JpdGUgYW4NCj4gPiArICogZXhpc3RpbmcgUENJZSBleHRlbmRlZCBjYXBhYmlsaXR5IGhlYWRl
ciwgYXMgY29ycnVwdGluZyBhIGhlYWRlciB3b3VsZA0KPiA+ICsgKiBicmVhayB0aGUgZXh0ZW5k
ZWQgY2FwYWJpbGl0eSBsaW5rZWQgbGlzdC4NCj4gPiArICoNCj4gPiArICogVGhlIGNhbGxlciBt
dXN0IGVuc3VyZSB0aGF0IChvZmZzZXQsIHNpemUpIGRvZXMgbm90IG92ZXJsYXAgd2l0aCBvdGhl
cg0KPiA+ICsgKiByZWdpc3RlcnMgb3IgY2FwYWJpbGl0eS1zcGVjaWZpYyByZWdpc3RlciBibG9j
a3MuIE92ZXJsYXBzIHdpdGgNCj4gPiArICogY2FwYWJpbGl0eS1zcGVjaWZpYyByZWdpc3RlcnMg
YXJlIG5vdCBjaGVja2VkIGFuZCBhcmUgY29uc2lkZXJlZCBhDQo+ID4gKyAqIHVzZXItY29udHJv
bGxlZCBvdmVycmlkZS4NCj4gPiArICovDQo+ID4gK2Jvb2wgcGNpZV9pbnNlcnRfY2FwYWJpbGl0
eShQQ0lEZXZpY2UgKmRldiwgdWludDE2X3QgY2FwX2lkLCB1aW50OF90DQo+IGNhcF92ZXIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBvZmZzZXQsIHVpbnQxNl90
IHNpemUpDQo+ID4gK3sNCj4gPiArICAgIHVpbnQxNl90IHByZXYgPSAwLCBuZXh0ID0gMDsNCj4g
PiArICAgIHVpbnQxNl90IGN1ciA9IHBjaV9nZXRfd29yZChkZXYtPmNvbmZpZyArIFBDSV9DT05G
SUdfU1BBQ0VfU0laRSk7DQo+ID4gKw0KPiA+ICsgICAgLyogV2FsayB0aGUgZXh0IGNhcCBsaXN0
IHRvIGZpbmQgaW5zZXJ0aW9uIHBvaW50ICovDQo+ID4gKyAgICB3aGlsZSAoY3VyKSB7DQo+ID4g
KyAgICAgICAgdWludDMyX3QgaGRyID0gcGNpX2dldF9sb25nKGRldi0+Y29uZmlnICsgY3VyKTsN
Cj4gPiArICAgICAgICBuZXh0ID0gUENJX0VYVF9DQVBfTkVYVChoZHIpOw0KPiA+ICsNCj4gPiAr
ICAgICAgICAvKiBDaGVjayB3ZSBhcmUgbm90IG92ZXJ3cml0aW5nIGFueSBleGlzdGluZyBDQVAg
aGVhZGVyIGFyZWEgKi8NCj4gPiArICAgICAgICBpZiAob2Zmc2V0ID49IGN1ciAmJiBvZmZzZXQg
PCBjdXIgKyBQQ0lfRVhUX0NBUF9BTElHTikgew0KPiA+ICsgICAgICAgICAgICByZXR1cm4gZmFs
c2U7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICBwcmV2ID0gY3VyOw0KPiA+
ICsgICAgICAgIGN1ciA9IG5leHQ7DQo+ID4gKyAgICAgICAgaWYgKG5leHQgPT0gMCB8fCBuZXh0
ID4gb2Zmc2V0KSB7DQo+IA0KPiBTbyB0aGlzIChzb3J0IG9mKSByZWxpZXMgb24gYSB0aGluZyBJ
J3ZlIG5ldmVyIGJlZW4gYWJsZSB0byBmaW5kIGEgY2xlYXINCj4gc3RhdGVtZW50IG9mIGluIHRo
ZSBQQ0llIHNwZWMuICBEb2VzIE5leHQgQ2FwYWJpbGl0eSBPZmZzZXQgaGF2ZSB0byBiZQ0KPiBs
YXJnZXIgdGhhbiB0aGUgb2Zmc2V0IG9mIHRoZSBjdXJyZW50IHJlY29yZD8gIEkuZS4gQ2FuIHdl
IGhhdmUNCj4gYmFja3dhcmRzIHBvaW50ZXJzPw0KDQpUaGF04oCZcyByaWdodC4gSSBhbHNvIGNv
dWxkbuKAmXQgZmluZCBhIHBsYWNlIGluIHRoZSBzcGVjIHRoYXQgZXhwbGljaXRseQ0Kc2F5cyB0
aGUgbGlzdCBtdXN0IGJlIGZvcndhcmQgb25seS4gQSBkZXZpY2UgZG9pbmcgYSBiYWNrd2FyZCB3
YWxrDQp3b3VsZCBiZSBwcmV0dHkgb2RkLCBob3BlZnVsbHkgbm90aGluZyBsaWtlIHRoYXQgZXhp
c3RzIGluIHRoZSB3aWxkLg0KDQo+IE1laCwgSSB0aGluayB0aGlzIGlzIGZpbmUsIGl0IGp1c3Qg
Y2FtZSB1cCBiZWZvcmUgYW5kIEkgY291bGRuJ3QgZmluZA0KPiBhIHJlZmVyZW5jZSB0byBwcm92
ZSBpdCENCj4gDQo+IE1vcmUgaW1wb3J0YW50bHksIGlmIGl0IGlzbid0IGEgcmVxdWlyZW1lbnQg
YW5kIGEgcmFyZSBkZXZpY2UgdHVybnMgdXANCj4gdGhhdCBoYXMgYSBiYWNrd2FyZHMgcG9pbnRl
ciwgdGhhdCBqdXN0IG1lYW5zIHRoZXJlIGlzbid0IGEgJ3JpZ2h0Jw0KPiBwb2ludCBpbiB0aGUg
bGlzdCB0byBwdXQgdGhpcyBhdCwgc28gYW55IHJhbmRvbSBjaG9pY2UgaXMgZmluZSBhbmQNCj4g
dGhlIG5leHQgPT0gMCBjb25kaXRpb24gbWVhbnMgd2UgYWx3YXlzIGZpbmUgYW4gb3B0aW9uLg0K
DQpZZXMuIA0KDQo+IA0KPiA+ICsgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICB9DQo+
ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAvKiBNYWtlIHN1cmUsIG5leHQgQ0FQIGhlYWRlciBh
cmVhIGlzIG5vdCBvdmVyIHdyaXR0ZW4gZWl0aGVyICovDQo+IA0KPiBMb29rcyBsaWtlIG9uZSBz
cGFjZSB0b28gZmV3Lg0KPiANCj4gPiArICAgIGlmIChuZXh0ICYmIChvZmZzZXQgKyBzaXplKSA+
PSBuZXh0KSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiArICAgIC8qIEluc2VydCBuZXcgY2FwICovDQo+ID4gKyAgICBwY2lfc2V0X2xvbmcoZGV2
LT5jb25maWcgKyBvZmZzZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgUENJX0VYVF9DQVAoY2Fw
X2lkLCBjYXBfdmVyLCBjdXIpKTsNCj4gPiArICAgIGlmIChwcmV2KSB7DQo+ID4gKyAgICAgICAg
cGNpZV9leHRfY2FwX3NldF9uZXh0KGRldiwgcHJldiwgb2Zmc2V0KTsNCj4gPiArICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgLyogSW5zZXJ0IGF0IGhlYWQgKDB4MTAwKSAqLw0KPiANCj4gQ29t
bWVudCBpcyBhIGxpdHRsZSBjb25mdXNpbmcgYXMgeW91IGFyZW4ndCBpbnNlcnRpbmcgdGhlIG5l
dyBjYXBhYmlsaXR5DQo+IHRoZXJlLiAgV2hhdCBJIHRoaW5rIHRoaXMgaXMgYWN0dWFsbHkgZG9p
bmcgaXMNCj4gDQo+IC8qDQo+ICAqIEluc2VydCBhIE51bGwgRXh0ZW5kZWQgQ2FwYWJpbGl0eSAo
Ny45LjI4IGluIHRoZSBQQ0kgNi4yIHNwZWMpDQo+ICAqIGF0IGhlYWQgd2hlbiB0aGVyZSBhcmUg
bm8gZXh0ZW5kZWQgY2FwYWJpbGl0aWVzIGFuZCB1c2UgdGhhdCB0bw0KPiAgKiBwb2ludCB0byB0
aGUgaW5zZXJ0ZWQgY2FwYWJpbGl0eSBhdCBvZmZzZXQuDQo+ICAqLw0KDQpTdXJlLiBIb3dldmVy
LCBaaGFuZ2ZlaSBoYXMgcmVwb3J0ZWQgYSBjcmFzaCB3aXRoIHRoaXMgYW5kIEkgaGF2ZQ0KcmV3
b3JrZWQgdGhlIGxvZ2ljIGEgYml0IHRvIGNvdmVyIGZldyBjb3JuZXIgY2FzZXMuIEJhc2VkIG9u
IGhpcw0KdGVzdHMgSSB3aWxsIHVwZGF0ZSB0aGlzLg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCj4g
PiArICAgICAgICBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcgKyBQQ0lfQ09ORklHX1NQQUNFX1NJ
WkUsIG9mZnNldCk7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgLyogTWFrZSBjYXBhYmls
aXR5IHJlYWQtb25seSBieSBkZWZhdWx0ICovDQo+ID4gKyAgICBtZW1zZXQoZGV2LT53bWFzayAr
IG9mZnNldCwgMCwgc2l6ZSk7DQo+ID4gKyAgICBtZW1zZXQoZGV2LT53MWNtYXNrICsgb2Zmc2V0
LCAwLCBzaXplKTsNCj4gPiArICAgIC8qIENoZWNrIGNhcGFiaWxpdHkgYnkgZGVmYXVsdCAqLw0K
PiA+ICsgICAgbWVtc2V0KGRldi0+Y21hc2sgKyBvZmZzZXQsIDB4RkYsIHNpemUpOw0KPiA+ICsg
ICAgcmV0dXJuIHRydWU7DQo+ID4gK30NCj4gDQoNCg==

