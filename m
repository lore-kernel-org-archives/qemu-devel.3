Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED47D1A638
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDP0-0000VD-Ji; Fri, 09 Jan 2026 09:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1veDOx-0000U7-Qo; Fri, 09 Jan 2026 09:23:44 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1veDOu-0003ib-JJ; Fri, 09 Jan 2026 09:23:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbrOeb8rpmGSBr2BCjCXSC76yJpEhcljT9TH590BrqzvOH++KoKMvkc/tGYvuHgiyjtojYMRolOvEN3RtBKAf5J5nU+Lxj0yO09rI6NeWF3bKD4nY8rFADdvj6TodiemvNDbMdEgL8dl2Xt7uWi9lZjWLM10EX8+BPdROsbst/LlC0qVIz2IZM0YHnbxx6sb3eDJRSumCC9r/8ew0obLIAapvaYcG1u/9AVbqZXedbAT/5giURGbwSLv+5Xu5FFWB9dwNM4kkJ9sHq9CgBz/QdxmdWkbYNc4KgQqgzkWQ2vGU2JivIF7/zvwzkSur87BXnWhe/fRvT5lqiqi2zBdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLuElWul5lhdaCTBwEEbi+p/BZcaC7JLp4JBkVbGRWc=;
 b=JYNZl4zo/2TxOY0x03IOJwlnyBEg1n/rTLRD50UWgHwr4CmIUPCkBj56P6385nohazywsJ2pf8sv9PpFigF1BtH8IqSUHinV0m3zq4o16bBND+CEXhbnCleCsVKphpzfD9TMnGQmkbMUShtcy78j8b31XCWbNYtTsWlu6Pwc2gF4ZJZG73WbMlJP7X374UoHuTfl60Ej5DtrP3USHPZZ4y39Oo/YP1TNFBmHBlHy8Vn6fgGNqQasmwmV61ArQYyqh7yZC3Mu9lwuxWU44rTdhUl/UdjSIWfiFAF1l/Z4y/b/sQuVbTM8nHsb8FBNrSc5tD/8mE8C8eGLj8dGJn+kTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLuElWul5lhdaCTBwEEbi+p/BZcaC7JLp4JBkVbGRWc=;
 b=SkwER0TO01/lhB2kcBiQZ2FoGTOjwrjPGEvlSyIhTa1Ivo1GSDqd/TKxauhvHf6rbNUFpS3NhCQqL8gNep07NQ8qIULiVfzu8wwHOzPdHvjNAAbFWHcFlq7Xq4MKk7vHSzhiPg8HSg/+HybhUiUB1gy6jijh+x3+S5FnnchgZbp03iGr1rJNNc3BObMIABOpRUq9bpyhTPkyElD+WdVfQMytAokmstWUp6hWKR4bqojQoaipTbNcvBj0nGjYiv/DJtCskwCKCGVduleVLmLhMVhCiDUmLCV5tCWV+E4eBw//yjsfWk84pe5xYcH2O+vMLr0DLIdHwIi9SG6witX8DQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 14:23:30 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 14:23:30 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOCAAYu5AIAARN1Q
Date: Fri, 9 Jan 2026 14:23:29 +0000
Message-ID: <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BY5PR12MB4209:EE_
x-ms-office365-filtering-correlation-id: 9020d4f6-2508-4b18-9e9b-08de4f8aa972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q1ROYXlyRTY5NHhkN2lIUEprN3NSY1FPRGNpMzZtVWhZK1YzWloydUJuemJS?=
 =?utf-8?B?YXgzdmN3SDB5Ui8ybXhna2M1My9XcVgza1Y5ZlEzR1cwV0o5bmJVc1RYTlA2?=
 =?utf-8?B?OWpFa2NaM2tudUJJSE5NWVVJRFJ2MDVtMlNySnd4cGh0ZENwd3dkR0xKS01C?=
 =?utf-8?B?ZUZ0ZU9zYWJaYUxVZnU5Y1FmUW9mamJXNXVlQWNFRzNabXFJbHR1dmRtTTdo?=
 =?utf-8?B?aXRNbDRsa0tPeHB1c0lKWmNOUjcwZS9kL0NsbkVFQ1dCa0VBREVxSjl6TDgv?=
 =?utf-8?B?c1VEK1hJWlFGekptdFlwOTlwd2FMZlN6Wk1FQ0U1SWZ6dzF0N3ZybjJzYUpI?=
 =?utf-8?B?TjBmQjZxS1dvU0dZVnhidDNjUmFWVHI2dVprNnU2Skd4QmpnS25RcXR3UWt4?=
 =?utf-8?B?Tm1yYjZNeUd0cVB5VHB4TEM5WUFhcnRqdmYybXpVQmVXQzNUUmdqMWFQNXZV?=
 =?utf-8?B?bTd4TUlEMUFHbWRBSmlmTFg3N0tlR2Z4K2x4S1lZQkIzZjJROVF3cUgxSXY3?=
 =?utf-8?B?eTVMOFFWTWNjZndrQlcxTlgwQjlMSDRYTEtPQWtzN1Q0eEdMdWFCRm0vLzRX?=
 =?utf-8?B?Y0JxT0FkMGE3dXQ0S2t5QStnTUl6VHNtWThONk8vVW1wLzMyZGRSNjVqZFNX?=
 =?utf-8?B?SkFYbjUxWFpoc1dPVDFOY0JscHhMQWJoeUlzdUU3VUYweHFTU1hPVkhZNUZI?=
 =?utf-8?B?Ni9uVE9xQ3VTa1phc1FxSnpDanlyc3VxbEJNZjlxYTFLc3ZTWXF6QWtsdnUv?=
 =?utf-8?B?Y3lrQUFwWEVwZURtVXF3QzM3RGV1VzJPZE00UVQ4LzkxSXhod1J3NXhGK2JM?=
 =?utf-8?B?a3VtNDRiNWI2bVVzemZtQXdlTDh6dTltT3REUmVIWjk3OEZ0MGZnTksxTU91?=
 =?utf-8?B?YjJPZmtYN056Wm1EbjZtNEQvUFNJcXk4Nm5rRjcxQkhqM01KTEtqa3hTMFZL?=
 =?utf-8?B?Nnlnc2xrL1RSVmx1eVRqekVXZy9mSzVGWkMreUF5NzNadUNtdG4zT2tid1JL?=
 =?utf-8?B?TzhWbWdxc1VETHprWDlmRHNUQ1B3aWtHSjhoWVNxMFBsU3c1RUsycUFHMHhx?=
 =?utf-8?B?UmoxWUtMd0xxTElFY04zRENjanZ6OVBJNkV1S2RHWkNZZ0kyU29ETzV4UklG?=
 =?utf-8?B?R0dnUlpsUmE5UmtPMUxPRXJvRVFBUXlQSXRaY3lPbENpeFZLWXBYWlNaalZV?=
 =?utf-8?B?bkVhYW1RODlQb2VNRmQ5ZmhSd0lJSkFPR0wwRkxQR0JJRTNFRjByWFVGYkhS?=
 =?utf-8?B?dCt4SVFxNEV6Y3RielZFRnpaYkQ1SGFTbHVRNW5YeW4zS01HZTBydmNnSi9n?=
 =?utf-8?B?Y2k5WVFuYWxCREw5WWpiNTVUTklFc3RTL3hveXJwREtmMkxHNzhaNFdrUkpw?=
 =?utf-8?B?VThqVy9rV1VPSnhjMkhLbTZmYXB2OVYrUCt4UnBMZ1RRcEZudVFacmZ4M2Ji?=
 =?utf-8?B?VzFPRlAyK2ovVFI4NXMxTG1IMXhCVnlJanV1L1BQRlRQUWFwcitsM3NpMkdw?=
 =?utf-8?B?blQyeCtKOVhzOEFkRXRqQ2xrTFphWmM5Q2JSbldzT2NxKzJXaGtuWlVSa2Ew?=
 =?utf-8?B?bGdNM3hxZ1JVa2lGWktPeCtiK2tUT0JVNEZuQzJTcDdjT0ROSWFzZ3F2RnMx?=
 =?utf-8?B?REdtUVM0RTVuOWxWYXRLbE1sVndmcW55L09RU1dEbTk3dEhjcGxIeE5NTkoz?=
 =?utf-8?B?eU9sL28zenVsRzNxQ0RNM0JudGIvbXZFWTN3ZE9jZjFNeGVoaWJHR1hvZ2gw?=
 =?utf-8?B?Vm1yRkI4MnN1UVcyUnpzWlZEcnhkMlpGNndySUhpNmVzb2VVUVZQcXJ4WDVm?=
 =?utf-8?B?bkR0aWtNTFVDeDdzWW9jNnV3UHRHdUxaSjhVMjhUcmxlbFRLT0lOQ1YwVEk3?=
 =?utf-8?B?dDNheVhPUmV4MGtCSWQ3TGZkdFZ6NDJWdSt5TXNoN2RGZm91dDZGRTN5a05n?=
 =?utf-8?B?RzZBN3Q0MEtIQ0NpZTFqVUV5RlpURXFxaUp5RXNyc3d0dlBINkdxZEp6QmxL?=
 =?utf-8?B?M2J2MjZBNW1pbXp1Yjk3YkJVclE0a09qYWlUdWZ1S0U3QUdHNXlvc1NiZFJa?=
 =?utf-8?Q?/oNnFR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWNLeGlKZGNEd3BqZEpMbHVLcVRaMi83cDh1S1BXc3BQR21mVEk0Tm00VzdL?=
 =?utf-8?B?WU5mYjdnTzF0QVdubEkzczNKSTNXa2tCQ1FiWFN3QzNQa0hsYm5ZNWpKdnMr?=
 =?utf-8?B?S0ZKUW0yb1dJVGtLbW5uK3N6VFE1anFQajB0bkhjQm9SbDg1Vk0rekRkaDU0?=
 =?utf-8?B?djNvb1VvS1JmUWhoWUUwMVRHRWdQbWZRY0IrSlNUZ1hXbERDZWNkdytia3Jr?=
 =?utf-8?B?TzM1Qk1lWG1pa3lrUmdlLzNYdFBRZXRrdVpFc2NMZlJoOFFxYzUwc0xXb2Z5?=
 =?utf-8?B?VDVUQzN5RmVkQmN6dkhUQ1ZQV3ZOVUYwaTdtTUErd2hPSlA5Y1RpV3lpMFpr?=
 =?utf-8?B?WEhRZC9Lem9tL0ZyWmRkU2Z5dkI5QXdYUWgwWVVWYTlyRThXazFKOENjUWlS?=
 =?utf-8?B?YnAxbFR6TmxFQmdSRTJPWndIczViQnFUSHZXcWlEOGlpZVlSVk15aTQ0V3d3?=
 =?utf-8?B?clNPNHNKT0NyYmRBYjVoMzQ2cWRrNkZ1WkxTTFpEVHZyb0NySmIraTdhaHEz?=
 =?utf-8?B?dzVLb2tDRkJDcWdOeERmU1gwTnJxcWNJTVVRbkE4V0NZTXFnZStqWjRjbU5r?=
 =?utf-8?B?N3V0ZnRUbkNRTlR6bmdBMTFhYVRHWGtzV0RMNExMbG9hZ2s0SzU1TWVwMCto?=
 =?utf-8?B?STZlWWVrb1NVa3o5VWUxMU5oc0JmRXJzLzdSYjQ4bGpnN3BDektBRHdQeGVu?=
 =?utf-8?B?bnhEQ0tEN1lYdyt5enQ5dGtTOGQzZGpUTFdaQXNEQjdqcWtvQVduTkJhZCtI?=
 =?utf-8?B?NHZkays1R0ozblhmRlY1dzQ1bHhJUVNFK1Z2dHd2UzRHbENmdGVJeVZPRHRn?=
 =?utf-8?B?UURVdldiRUZNamRWYmFubFpUR21ya3VWbDZyOVVjYVJ1WHYrRVRLZVc3QnRo?=
 =?utf-8?B?dkRKREhMZmhiaTBsdmhJcVlwNDU2aWlkWWtIOVh5OHFNc2c4WW03YzRWSjBW?=
 =?utf-8?B?aTdvbmRmLzR3S3ZGbHBaNU5tU24vZ3RaQ0pCbnhMWnhhaXQyb0lGRHVjU1Nz?=
 =?utf-8?B?OWFla0pmVmFBRkUvYTVCNEtOY2dERDAwNzR0WnVmZWZQUDVxRzdraFVzKzlT?=
 =?utf-8?B?UG5QOEhKY1pqWHZTTFNTUVlQdmFCUlMrRlNGbmtHcHlPcUZUcWF1dHJiVHdk?=
 =?utf-8?B?b3dWYUg5QzlETFZPSERnbU5NRElnMEhmbXBvalF4MDFlQ0pxdGpjbkpKL0F0?=
 =?utf-8?B?cFdEa3orL3Awa1dVV3BxblRrZUxPNTQ4ODhEeFd3cW9uSjgxc05Ndnl0eFd6?=
 =?utf-8?B?WW9oUFdQbDFiM1pwR0w4ZVRjUmM4Z0dDLzNpUFBlNHkxOEl6VGtXOFMzMTNv?=
 =?utf-8?B?b3A5OHZxck5LNU1GZHdOSDFsajdpdkFwN1Uva2YwME5rNHM3MFBEWmtaTnZv?=
 =?utf-8?B?enNIK2d6OXBJL3VTcEo0TVBJZjN0SUozNVNQbU5wTHdmOVUrRi83dStnVmNY?=
 =?utf-8?B?eWJHcTBYdW5xLzMrelMzZ2RLRWY4SXhybWpzN1VYbVBCMm40YWNQRFFqMDA0?=
 =?utf-8?B?K1dyQjdkdGo5MURmZ3R2ci9JM3I1dEJ4QjZlenBYR3YwN0VCWmhEbTVsL0JX?=
 =?utf-8?B?RENCZEl4YXRHRTBJR0Q2RktnRUtkSllGbkZDTzhERnVKMzBnNmxiOGxuVDZa?=
 =?utf-8?B?Y3RrZkora01kd0I2RmhSN21yNzdLSG9SVTkwVGhoSFQ3YWZTSWErdDErWlRa?=
 =?utf-8?B?OWNoRjJOL3liNTA4V0VIbVAyQWgrWEdPQUQrSEdDZHdPQ2NycGpQa1dtdFA1?=
 =?utf-8?B?VUpOUm9NK1RCVzlPSlc0R3B4UHZxdUF4VnB3Q2IrbDk3eTNKVVJFejYrNmtH?=
 =?utf-8?B?UGk4U1VZaXFVUXF4MUMzQ1BaTVhZcnZ6ZjlSTXZBM0hjRmZ0NUl4NUJjd203?=
 =?utf-8?B?VzBtUVgxbnIzc1lnblhaOTdUS2plRFRRaWZ4dExNWEF2aXM3dC81MmlJNmFr?=
 =?utf-8?B?Njl5RU5aTkRxRU11Yk5YVkJvR2I2N0dBWVpqelhlL1QweTZxbzkyZWN3L1dz?=
 =?utf-8?B?a3pPTmJHNlh0MFFrcnk3Z2V2QzhPVHRNU1RpWlR3R3ZlS3ExeEJiM3AyK1N1?=
 =?utf-8?B?R1d1ek9zREpVOCs3S3NPU2xEbW1yQ2x6N2JNTHArekRxK3Bia2pCSlNtSUxF?=
 =?utf-8?B?dndGQ2tmTzJpWTBzQmp3NkR6bGJXSTUwRWduT1ZQNTcybWg0ekJ2bU1laXBK?=
 =?utf-8?B?dDVObzdXUVNkR3pqOEZsQ2tyd3lxN3NlQ2FhRmxJOUY5WWVYZlNuekNSZExL?=
 =?utf-8?B?NXEzRW9JS2xKVCtHYlE2SGw3RUR5NmNsTGFwRG5IZU44R3ZrNUF1bm9yZC8y?=
 =?utf-8?B?RVMrK281aVVtaTRrNmdXOTJsNURnVitrYjRpaWVZQUpaejRHMkpiUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9020d4f6-2508-4b18-9e9b-08de4f8aa972
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 14:23:29.9800 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K38uso5TjI1awDgwCRl8RDSxsjZmimhTad3JoLXh3ZTT6jHZynXQtm7soEMdNhPvrOKPlA22fOdu0cHxk4X0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHVhbiwgWmhlbnpob25n
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IDA5IEphbnVhcnkgMjAyNiAxMDox
Mw0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNsZ0ByZWRoYXQuY29tOw0KPiBjb2h1
Y2tAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT47DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsg
S3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCAzLzNdIGh3L3ZmaW8vcmVnaW9uOiBDcmVhdGUgZG1hYnVmIGZvciBQQ0kgQkFSIHBlcg0KPiBy
ZWdpb24NCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9y
IGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID5G
cm9tOiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPlN1Ympl
Y3Q6IFJFOiBbUEFUQ0ggMy8zXSBody92ZmlvL3JlZ2lvbjogQ3JlYXRlIGRtYWJ1ZiBmb3IgUENJ
IEJBUiBwZXINCj4gPnJlZ2lvbg0KPiA+DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4gPj4gU2VudDogMDggSmFudWFyeSAyMDI2IDA5OjQxDQo+ID4+IFRvOiBTaGFt
ZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+IGFybUBub25n
bnUub3JnOw0KPiA+PiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPj4gQ2M6IGVyaWMuYXVnZXJA
cmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90Lm9yZzsgY2xnQHJlZGhhdC5jb207DQo+ID4+IGNvaHVj
a0ByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsgTmljb2xpbiBDaGVuDQo+ID48bmljb2xpbmNA
bnZpZGlhLmNvbT47DQo+ID4+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0
IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBKYXNvbg0KPiA+PiBHdW50aG9ycGUgPGpnZ0Bu
dmlkaWEuY29tPjsgS3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAzLzNdIGh3L3ZmaW8vcmVnaW9uOiBDcmVhdGUgZG1hYnVmIGZvciBQ
Q0kgQkFSDQo+ID4+IHBlciByZWdpb24NCj4gPj4NCj4gPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBj
YXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gPj4NCj4gPj4NCj4gPj4gT24g
MTIvMjIvMjAyNSA5OjUzIFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+PiA+IEZyb206
IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPj4gPg0KPiA+PiA+IExpbnV4
IG5vdyBwcm92aWRlcyBhIFZGSU8gZG1hYnVmIGV4cG9ydGVyIHRvIGV4cG9zZSBQQ0kgQkFSIG1l
bW9yeQ0KPiA+Zm9yDQo+ID4+ID4gUDJQIHVzZSBjYXNlcy4gQ3JlYXRlIGEgZG1hYnVmIGZvciBl
YWNoIG1hcHBlZCBCQVIgcmVnaW9uIGFmdGVyIHRoZQ0KPiA+PiA+IG1tYXAgaXMgc2V0IHVwLCBh
bmQgc3RvcmUgdGhlIHJldHVybmVkIGZkIGluIHRoZSByZWdpb27igJlzIFJBTUJsb2NrLg0KPiA+
PiA+IFRoaXMgYWxsb3dzIFFFTVUgdG8gcGFzcyB0aGUgZmQgdG8gZG1hX21hcF9maWxlKCksIGVu
YWJsaW5nIGlvbW11ZmQNCj4gPj4gPiB0byBpbXBvcnQgdGhlIGRtYWJ1ZiBhbmQgbWFwIHRoZSBC
QVIgY29ycmVjdGx5IGluIHRoZSBob3N0IElPTU1VDQo+ID4+ID4gcGFnZQ0KPiA+PiB0YWJsZS4N
Cj4gPj4gPg0KPiA+PiA+IElmIHRoZSBrZXJuZWwgbGFja3Mgc3VwcG9ydCBvciBkbWFidWYgc2V0
dXAgZmFpbHMsIFFFTVUgc2tpcHMgdGhlDQo+ID4+ID4gc2V0dXAgYW5kIGNvbnRpbnVlcyB3aXRo
IG5vcm1hbCBtbWFwIGhhbmRsaW5nLg0KPiA+PiA+DQo+ID4+ID4gU2lnbmVkLW9mZi1ieTogTmlj
b2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+PiA+IFNpZ25lZC1vZmYtYnk6IFNo
YW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+PiA+IC0tLQ0KPiA+
PiA+ICAgaHcvdmZpby9yZWdpb24uYyAgICAgfCA1Nw0KPiA+PiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+PiA+ICAgaHcvdmZpby90cmFjZS1ldmVudHMg
fCAgMSArDQo+ID4+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPj4gPg0KPiA+PiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3JlZ2lvbi5jIGIv
aHcvdmZpby9yZWdpb24uYyBpbmRleA0KPiA+PiA+IGIxNjVhYjBiOTMuLjY5NDlmNjc3OWMgMTAw
NjQ0DQo+ID4+ID4gLS0tIGEvaHcvdmZpby9yZWdpb24uYw0KPiA+PiA+ICsrKyBiL2h3L3ZmaW8v
cmVnaW9uLmMNCj4gPj4gPiBAQCAtMjksNiArMjksNyBAQA0KPiA+PiA+ICAgI2luY2x1ZGUgInFl
bXUvZXJyb3ItcmVwb3J0LmgiDQo+ID4+ID4gICAjaW5jbHVkZSAicWVtdS91bml0cy5oIg0KPiA+
PiA+ICAgI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIg0KPiA+PiA+ICsjaW5jbHVkZSAic3lz
dGVtL3JhbWJsb2NrLmgiDQo+ID4+ID4gICAjaW5jbHVkZSAidmZpby1oZWxwZXJzLmgiDQo+ID4+
ID4NCj4gPj4gPiAgIC8qDQo+ID4+ID4gQEAgLTIzOCwxMyArMjM5LDUyIEBAIHN0YXRpYyB2b2lk
IHZmaW9fc3VicmVnaW9uX3VubWFwKFZGSU9SZWdpb24NCj4gPj4gKnJlZ2lvbiwgaW50IGluZGV4
KQ0KPiA+PiA+ICAgICAgIHJlZ2lvbi0+bW1hcHNbaW5kZXhdLm1tYXAgPSBOVUxMOw0KPiA+PiA+
ICAgfQ0KPiA+PiA+DQo+ID4+ID4gK3N0YXRpYyBpbnQgdmZpb19yZWdpb25fY3JlYXRlX2RtYV9i
dWYoVkZJT1JlZ2lvbiAqcmVnaW9uKSB7DQo+ID4+ID4gKyAgICBnX2F1dG9mcmVlIHN0cnVjdCB2
ZmlvX2RldmljZV9mZWF0dXJlICpmZWF0dXJlID0gTlVMTDsNCj4gPj4gPiArICAgIFZGSU9EZXZp
Y2UgKnZiYXNlZGV2ID0gcmVnaW9uLT52YmFzZWRldjsNCj4gPj4gPiArICAgIHN0cnVjdCB2Zmlv
X2RldmljZV9mZWF0dXJlX2RtYV9idWYgKmRtYV9idWY7DQo+ID4+ID4gKyAgICBzaXplX3QgdG90
YWxfc2l6ZTsNCj4gPj4gPiArICAgIGludCBpLCByZXQ7DQo+ID4+ID4gKw0KPiA+PiA+ICsgICAg
Z19hc3NlcnQocmVnaW9uLT5ucl9tbWFwcyk7DQo+ID4+ID4gKw0KPiA+PiA+ICsgICAgdG90YWxf
c2l6ZSA9IHNpemVvZigqZmVhdHVyZSkgKyBzaXplb2YoKmRtYV9idWYpICsNCj4gPj4gPiArICAg
ICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHZmaW9fcmVnaW9uX2RtYV9yYW5nZSkgKg0KPiA+
cmVnaW9uLT5ucl9tbWFwczsNCj4gPj4gPiArICAgIGZlYXR1cmUgPSBnX21hbGxvYzAodG90YWxf
c2l6ZSk7DQo+ID4+ID4gKyAgICAqZmVhdHVyZSA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVy
ZSkgew0KPiA+PiA+ICsgICAgICAgIC5hcmdzeiA9IHRvdGFsX3NpemUsDQo+ID4+ID4gKyAgICAg
ICAgLmZsYWdzID0gVkZJT19ERVZJQ0VfRkVBVFVSRV9HRVQgfA0KPiA+PiBWRklPX0RFVklDRV9G
RUFUVVJFX0RNQV9CVUYsDQo+ID4+ID4gKyAgICB9Ow0KPiA+PiA+ICsNCj4gPj4gPiArICAgIGRt
YV9idWYgPSAodm9pZCAqKWZlYXR1cmUtPmRhdGE7DQo+ID4+ID4gKyAgICAqZG1hX2J1ZiA9IChz
dHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9kbWFfYnVmKSB7DQo+ID4+ID4gKyAgICAgICAgLnJl
Z2lvbl9pbmRleCA9IHJlZ2lvbi0+bnIsDQo+ID4+ID4gKyAgICAgICAgLm9wZW5fZmxhZ3MgPSBP
X1JEV1IsDQo+ID4+ID4gKyAgICAgICAgLm5yX3JhbmdlcyA9IHJlZ2lvbi0+bnJfbW1hcHMsDQo+
ID4+ID4gKyAgICB9Ow0KPiA+PiA+ICsNCj4gPj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCByZWdp
b24tPm5yX21tYXBzOyBpKyspIHsNCj4gPj4gPiArICAgICAgICBkbWFfYnVmLT5kbWFfcmFuZ2Vz
W2ldLm9mZnNldCA9IHJlZ2lvbi0+bW1hcHNbaV0ub2Zmc2V0Ow0KPiA+PiA+ICsgICAgICAgIGRt
YV9idWYtPmRtYV9yYW5nZXNbaV0ubGVuZ3RoID0gcmVnaW9uLT5tbWFwc1tpXS5zaXplOw0KPiA+
PiA+ICsgICAgfQ0KPiA+PiA+ICsNCj4gPj4gPiArICAgIHJldCA9IHZiYXNlZGV2LT5pb19vcHMt
PmRldmljZV9mZWF0dXJlKHZiYXNlZGV2LCBmZWF0dXJlKTsNCj4gPj4NCj4gPj4gdmJhc2VkZXYt
PmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUgbWF5IGJlIE5VTEwgZm9yIG90aGVyIGJhY2tlbmQgbGlr
ZQ0KPiA+dmZpby0NCj4gPj4gdXNlci4NCj4gPg0KPiA+QWguLk9rLiBJIHdpbGwgYWRkIGEgY2hl
Y2suDQo+ID4NCj4gPj4NCj4gPj4gPiArICAgIGZvciAoaSA9IDA7IGkgPCByZWdpb24tPm5yX21t
YXBzOyBpKyspIHsNCj4gPj4gPiArICAgICAgICB0cmFjZV92ZmlvX3JlZ2lvbl9kbWFidWYocmVn
aW9uLT52YmFzZWRldi0+bmFtZSwgcmV0LA0KPiA+cmVnaW9uLT5uciwNCj4gPj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnaW9uLT5tZW0tPm5hbWUsDQo+ID5yZWdpb24t
Pm1tYXBzW2ldLm9mZnNldCwNCj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmVnaW9uLT5tbWFwc1tpXS5zaXplKTsNCj4gPj4gPiArICAgIH0NCj4gPj4gPiArICAgIHJl
dHVybiByZXQ7DQo+ID4+ID4gK30NCj4gPj4gPiArDQo+ID4+ID4gICBpbnQgdmZpb19yZWdpb25f
bW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+ID4+ID4gICB7DQo+ID4+ID4gICAgICAgaW50IGks
IHJldCwgcHJvdCA9IDA7DQo+ID4+ID4gICAgICAgY2hhciAqbmFtZTsNCj4gPj4gPiAgICAgICBp
bnQgZmQ7DQo+ID4+ID4NCj4gPj4gPiAtICAgIGlmICghcmVnaW9uLT5tZW0pIHsNCj4gPj4gPiAr
ICAgIGlmICghcmVnaW9uLT5tZW0gfHwgIXJlZ2lvbi0+bnJfbW1hcHMpIHsNCj4gPj4NCj4gPj4g
SnVzdCBjdXJpb3VzLCB3aGVuIHdpbGwgYWJvdmUgY2hlY2sgcmV0dXJuIHRydWU/DQo+ID5JIHRo
aW5rIGAhcmVnaW9uLT5tZW1gIGNvdmVycyBjYXNlcyB3aGVyZSBubyBNZW1vcnlSZWdpb24gd2Fz
IGNyZWF0ZWQNCj4gPihlLmcuIHplcm8gc2l6ZWQgcmVnaW9ucykuICBBbmQgbnJfbW1hcHMgY2hl
Y2tzIHJlZ2lvbnMgd2l0aCBtbWFwDQo+ID5zdXBwb3J0IGV4aXN0cyAoVkZJT19SRUdJT05fSU5G
T19GTEFHX01NQVAvIF9DQVBfU1BBUlNFX01NQVApLg0KPiANCj4gVW5kZXJzdG9vZCwgdGhhbmtz
Lg0KPiANCj4gPg0KPiA+Pg0KPiA+PiA+ICAgICAgICAgICByZXR1cm4gMDsNCj4gPj4gPiAgICAg
ICB9DQo+ID4+ID4NCj4gPj4gPiBAQCAtMzA1LDYgKzM0NSwyMSBAQCBpbnQgdmZpb19yZWdpb25f
bW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+ID4+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnaW9uLT5tbWFwc1tpXS5zaXplIC0gMSk7DQo+ID4+ID4gICAgICAgfQ0KPiA+
PiA+DQo+ID4+ID4gKyAgICByZXQgPSB2ZmlvX3JlZ2lvbl9jcmVhdGVfZG1hX2J1ZihyZWdpb24p
Ow0KPiA+PiA+ICsgICAgaWYgKHJldCA8IDApIHsNCj4gPj4gPiArICAgICAgICBpZiAocmV0ID09
IC1FTk9UVFkpIHsNCj4gPj4gPiArICAgICAgICAgICAgd2Fybl9yZXBvcnRfb25jZSgiVkZJTyBk
bWFidWYgbm90IHN1cHBvcnRlZCBpbg0KPiA+a2VybmVsIik7DQo+ID4+ID4gKyAgICAgICAgfSBl
bHNlIHsNCj4gPj4gPiArICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCIlczogZmFpbGVkIHRvIGNy
ZWF0ZSBkbWFidWY6ICVzIiwNCj4gPj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIG1lbW9y
eV9yZWdpb25fbmFtZShyZWdpb24tPm1lbSksDQo+ID5zdHJlcnJvcihlcnJubykpOw0KPiA+PiA+
ICsgICAgICAgIH0NCj4gPj4gPiArICAgIH0gZWxzZSB7DQo+ID4+ID4gKyAgICAgICAgTWVtb3J5
UmVnaW9uICptciA9ICZyZWdpb24tPm1tYXBzWzBdLm1lbTsNCj4gPj4NCj4gPj4gRG8gd2UgbmVl
ZCB0byBzdXBwb3J0IHJlZ2lvbi0+bW1hcHNbMV0/DQo+ID4NCj4gPk15IHVuZGVyc3RhbmRpbmcg
aXMgYWxsIHJlZ2lvbi0+bW1hcHNbXSBlbnRyaWVzIGZvciBhIFZGSU8gcmVnaW9uIHNoYXJlDQo+
ID50aGUgc2FtZSBSQU1CbG9jay4gQW5kIHRoZSBrZXJuZWwgcmV0dXJucyBhIHNpbmdsZSBkbWFi
dWYgZmQgcGVyDQo+ID5yZWdpb24sIG5vdCBwZXIgc3VicmFuZ2UuDQo+IA0KPiBOb3QgZ2V0LCBj
YW4gUkFNQmxvY2sgaGF2ZSBob2xlcz8NCg0KWWVzLCBhIFJBTUJsb2NrIGNhbiBlZmZlY3RpdmVs
eSBoYXZlIGhvbGVzLCBidXQgaW4gdGhpcyBjb250ZXh0DQp0aGF0IGlzIG5vdCB3aGF0IGlzIGhh
cHBlbmluZy4NCg0KSUlVQywgZm9yIGEgVkZJTyBQQ0kgQkFSIHJlZ2lvbiwgYWxsIHJlZ2lvbi0+
bW1hcHNbXSBlbnRyaWVzDQpjb3JyZXNwb25kIHRvIHN1YnJhbmdlcyBvZiB0aGUgc2FtZSBCQVIg
YW5kIGFyZSBiYWNrZWQgYnkgdGhlDQpzYW1lIE1lbW9yeVJlZ2lvbiBhbmQgdGhlcmVmb3JlIHRo
ZSBzYW1lIFJBTUJsb2NrLiBUaGUgc3BhcnNlDQptbWFwIGxheW91dCAobnJfbW1hcHMgPiAxKSBl
eGlzdHMgdG8gZGVzY3JpYmUgd2hpY2ggcGFydHMgb2YgdGhlDQpCQVIgYXJlIG1hcHBhYmxlLCBu
b3QgdG8gcmVwcmVzZW50IGRpc3RpbmN0IGJhY2tpbmcgbWVtb3J5IG9iamVjdHMuDQoNClNvIHdo
aWxlIHNwYXJzZSByZWdpb25zIG1heSBsb29rIGxpa2UgImhvbGVzIiBhdCB0aGUgbW1hcCBsZXZl
bCwgdGhlcmUNCmFyZSBubyBob2xlcyBpbiB0aGUgUkFNQmxvY2sgYWJzdHJhY3Rpb24gaXRzZWxm
LiBBbGwgcmVnaW9uLT5tbWFwc1tdDQplbnRyaWVzIHNoYXJlIHRoZSBzYW1lIFJBTUJsb2NrLCB3
aGljaCBpcyB3aHkgYXR0YWNoaW5nIHRoZSByZXR1cm5lZA0KZG1hYnVmIGZkIHRvIHJlZ2lvbi0+
bW1hcHNbMF0ubWVtLnJhbV9ibG9jayBpcyBzdWZmaWNpZW50LCBJIHRoaW5rLg0KDQpIb3dldmVy
LCBwb3NzaWJsZSBJIG1heSBiZSBtaXNzaW5nIHRoZSBjYXNlIHlvdSBhcmUgY29uY2VybmVkIGFi
b3V0IGhlcmUuDQpQbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcywNClNoYW1lZXINCg==

