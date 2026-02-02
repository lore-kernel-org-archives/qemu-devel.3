Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3DAE7DEF4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvaX-0006Yx-95; Mon, 02 Feb 2026 10:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmvaV-0006YW-HT; Mon, 02 Feb 2026 10:11:39 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vmvaT-0007Ac-HC; Mon, 02 Feb 2026 10:11:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjfIPmtq50zdwIKxGZM9oiL304Hg7MNJoMh6LOLmRqyjt6W/wneSbNX4tCggtP8WW8vzV/Y/bfamYPJSaGtRKHO+r51PrQg3DPAAyZ8+sIBs2zvAiRIiX5mQsHxk5yEedx959XFp3avz8ABwZNPhz5bpcsQXx9dmCRn9kE7/pwwJp4Z+PQpcK8lILZfVZOET3A7WRgt50toj4Ng3L8ym+bMf/uYNCUF3+ANTuBkHBK3ebIJmjMEhmvRnrDn6uFPP/O6eXbFLzlnAJ270kIBTARXQgth781mn1wd4Tmdd/Oelfa+/62G8DP1EF+Vvjct4nLr9lZKpfenxCYaVTd+3sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Snc5ilamqLuxc3guhFkIep83c4dD1tV2cdephmtxE=;
 b=Ttp8VIhrZGiJQiVBev9nCfLtQzqvlCU3jBBzKOJRjE2nWqkOv7P4lTodYYN8mQoie5YimHL2BhQHdmM0AYpE6NGd+l2NZskqhjwaiOxxDF2ZBvH28cYyiNxgKh+Mui3x2EBuxcNZvTz+pCYPA/U1QGjRy1t3g1NyXbrCAhIknkHvSza5ygh+HJB3Jd+nhUKmDqR7Ft37n3d3JmS9NJLCZit8zdTShN7E79LoSAXH9dzVHjLako6Ij7KglO9+iwp9ShhGwqXEWIzdQs+aeNr/juXmx/LfnXuVkBgJWEFj4dltrMp9a3QOUrbkjpAo7L7UJ7FUYqGGmGCPgn9fMmCChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Snc5ilamqLuxc3guhFkIep83c4dD1tV2cdephmtxE=;
 b=ttS24LDFtjk1m4HFY7XXcq+eO/r7qbWDBpCWeXEHI4MQgbUY/AokkdN49d+zI4MI6ICpy1vGcVd3fzRZ2lfMgNK8A55xj2YlRTNIRDYFfs8F3f7Ndwp5+s9B3adbr+o7pE1KndXI6iOXjDxP8e9OApiNYXk6k5KVKtKHRu4xdJBwhf1GPce8b8WJWte/8lqKxEDgPX8oRP+DZomJ3aiqtsy1mKP1F3mdukPqVTn9Jv1AGgEiFYLWyaX3pYbCVBQzzWqA6kwH89OalWf0ZUy4SNPS3YP13T1cik7NI6ecz76e/kn1HP4WWkrgOWci+ARRVPjXsBCX9s3X97Jts29eJg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:11:28 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:11:28 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Thread-Topic: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Thread-Index: AQHcjrF92YpMmGmntEqRZLFfH3O4H7VvhjCAgAAEUKA=
Date: Mon, 2 Feb 2026 15:11:28 +0000
Message-ID: <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
In-Reply-To: <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL1PR12MB5802:EE_
x-ms-office365-filtering-correlation-id: 2f28fc66-bf29-471a-5a8e-08de626d572c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SVpzZEc4SUJhN2szd0hDdTl4cWkrdzBVWVVPNnR3azg0b0RZMUpGOFhsK1Jx?=
 =?utf-8?B?T2xWMExIbDBzdHdQRTMwZU5QUzhOZ1g0V2EzZGw1OEJEeHBqRHBCNDJWQVpn?=
 =?utf-8?B?QVpxdXdRVUFvOFVvbENHMXVvdUxsTEVMS3E0cjdrNHU5eEkvNWY1eHI0bXZ1?=
 =?utf-8?B?NlpDUXAyVUhkR1h6QTRUT0Jvd05aekVRa2hQa1ZvRVNQZEYvSURXZzV6WEpr?=
 =?utf-8?B?dDVuRnl5UU9jZDhEalJDRHl1ZnV3NVlMQmRyTTUyU05YbGI3OWEvbFI2bUsw?=
 =?utf-8?B?Y0NHYmhPR3ZMdFI3NHAzUjcvZ2hjWTBuZ2ExUG5EakRxVmJPRWZVUnBkZ2o3?=
 =?utf-8?B?bUtFdnkrQVVkUzB3bnY4SlhsV3RzUG5JbDhaOFBRQ1lBbHJDUnlzenpBRm45?=
 =?utf-8?B?TmdEaUdPelhnTXpoNjZvclExZDVJRE1lang0VnBEcFZGWC9KendyT0x2cHA3?=
 =?utf-8?B?K3J1NCtiaklwcVRSOUZEQVc0OUpocExkaUJMVXNjT2VxUEpzY1dEZFJ3WkFX?=
 =?utf-8?B?Z0VsMDF3MTUrTEdGVVMwbUdXa3JEeHllUjBXeW1wd0EzQVJJbVY1RE9FZnpG?=
 =?utf-8?B?bFJrREM2dEpYdk81QWFDQWlNLzBjODMxZFQxLzE2aTRUdWxHazJQU0M2SGtk?=
 =?utf-8?B?L3k5SE9PMEdSd09aenNWTHEyZWJQNFd2ZWJMdEhHMkxJV1NRcTEyQ0t6V01Y?=
 =?utf-8?B?OHE5SXQxdHNTOURMMjI4WVVJamZvVGdZQXB0aGhqSGNXT0RFRDZ2bXdUamtQ?=
 =?utf-8?B?TERpci9NSVd5YTMwQnJHV3dYK0lYNHkwdDNRVTZ2aXRhMzIxc0RDNzRMT0Ry?=
 =?utf-8?B?SXgyb2dTc1Rack12OWwyMnZWdlMzc2h4L1VaUmwrMTE5K2J1c0F4ZGNram1n?=
 =?utf-8?B?Z2l5LzNReUNxSHRtUWo4RHdWb3hUY1B4dlovbUZCN0VFcXpBK1JkeXpYa3Bi?=
 =?utf-8?B?QmZhblF6MUIvY3RzdzBDYWhxZmFqa2IvREVwdmxwdFlnWGlzYUVXbElSNndi?=
 =?utf-8?B?ZGlnMGQ5dXUwdWl3Y2RTWGpPSUoxbnc1S0Zuc0xDMVpoQldNeVYvRlBpSzBR?=
 =?utf-8?B?VzN6QThuQ3J6VTdJSitIY2xoeHBNOWFUTURFYjMzOU54OTJaOVZqY2lNS1No?=
 =?utf-8?B?R1VhZFdwRkFPMmxaM1BmbkxyR3ltcktrOU5aUjkvWUhLeWFRS3ZzTndIb0tR?=
 =?utf-8?B?WU1GUzlMd0sraHlSK25aczUxT2podUc0OFRVQ2kxTGpURm5KbXZuSW1za0Fz?=
 =?utf-8?B?eDhVOGtOOEVYVEowKzUzSWhJZWx3d0lmWlEySGsxbmNnck8ya3BYSnFUaHFw?=
 =?utf-8?B?WWxSRFFMaGIwSDFmRFhOTldaSjEvVlV0ZElvYjVDTDdqRVJoeFVwaHdNV3ZF?=
 =?utf-8?B?WDlYQXpsdVk1eHRBVmpGSVh1VkowMExJNHZDRFEwbG80bUpaZWpFc2dFbDBZ?=
 =?utf-8?B?eWNENFFTL3lPSm5odTJlKy9CTEZ1RnZ5NDBiWDZFY25aZzVxZVRVTEZuMmlo?=
 =?utf-8?B?QlB2UUxoTVArRUE3d2ZFWm05Mng1QjFrVE4zNUcrYi9FaXgyc1ZxRVlLMURz?=
 =?utf-8?B?eWcrZVVHSWVTT0tyUzJ6MnE0ZDdiaHdTK1diUzE0U1ZYMmVhUkFkeW1qUElO?=
 =?utf-8?B?SXA2ckRldlg5UFNPTVB6MVF6elNrQ3MvNGhMYm1Nb1NmR0ZtSGNpdG04eEQv?=
 =?utf-8?B?TTIvdUt4TmtYR1NjMWZYMVdVSTdubEtLUnovM1lJM1VhOXBlbnRBS1dWd1dI?=
 =?utf-8?B?RitGU3kwMXJNMEEyd2o2QWc2NFh3ZWdHazVxMWRvK3hENXhTdy90cTZveHls?=
 =?utf-8?B?bGxFOW56a3l1NWgzTjErT0lNSC8yL1NWb0hscDVIZWY2Sjd0RFhtNEdDYnRE?=
 =?utf-8?B?cTdGdVpFR1I1NWVQMjh4eHlaek5MOFZMOGxqOHJCZUFFcHNwdGtUa3NqaHVD?=
 =?utf-8?B?Tm9aajdkUGNJVFpDS1dST1JVdEZlbW9rMFkwc0hlUlVSWXlmSFl1SkFBR05K?=
 =?utf-8?B?d3hOTnpFK3lyS1Vid0tJeEV3eCtLMWhrRzRTbjJETzNGVGExZ0tEUFhyaGh2?=
 =?utf-8?B?TXRJZnhjTzZ6U0NLeWltV3NDNFptL1lNNlM4ZmxKZWtJaG9Uc00yZFZFZ2di?=
 =?utf-8?Q?aNSDpoSgdPL2M0Td3QhhPdnJg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzY2bHM3MXRuQWF5TUNIM3FCMEJ5MVppcFpyT3RvWVVsRWdSQ2gzTkVUZGFP?=
 =?utf-8?B?djRsTDdGam9BMzRnRnhORHg3NDh1WTBjSHBST0NUNHd1YVlwVklkZnQ5ZDF4?=
 =?utf-8?B?TW1aMEUvc1FTZVh0TDkzcVZ4TmdadmZXLzcxaFZoZHphdUI0KzEwWUNLdk5u?=
 =?utf-8?B?Q2s3THRSMXdPU1dMLzBYYnREbm1icXkrNnBFUWgxNUhHWEpiVW5reEJPNjFn?=
 =?utf-8?B?YjRIQVRPelltRENnM2JJVXpxR3JnR2VxWnVyeHJTSE0ySWpHQnIra0txekNT?=
 =?utf-8?B?YnBUcUdsQk5qQi9sZHBDM2RmWVhKdGxTeWNTaWNoaEJCa2NLRjBEYTFUQkRr?=
 =?utf-8?B?eTFVaDBZZDIwY1dpbzI2R1BUTFlyMlNwVjFHeHNPVS9UeXUzRkE4elZ0WHN0?=
 =?utf-8?B?WUVOY2dKYzduaFNHRXM4NU5yNDlOVitzOFFhZ0ZmZkhMTXNDcDA0SVZvb3Rq?=
 =?utf-8?B?WWRsSHZlOEVCYmJqZDRJNUtlQXVvYVRRZ2E1ZmVuRS9lQVFuT3BVMnBsK3hG?=
 =?utf-8?B?MWJSaHJpWjRWNU12S2ZiRVhiV3h6NURnVXlvUTdWRDNaT28zWGs0anVGV200?=
 =?utf-8?B?Rlg4YnhwaHZVVjFWL1VpeFFFazFpSVFOV3V6UCtzM3p5NlV4bFo4QWZOOWow?=
 =?utf-8?B?MGt6T2tDNENINzdqTC9xVitGU3FNSWtLZjZxS2V2Z280bkpMUDF6VDlWak1a?=
 =?utf-8?B?c29Nb09wNkordG1OaFRkVHBoMThZeHdMcTFWREJrZFQ4Z3hUc29jL2htVk8v?=
 =?utf-8?B?OUE3N0NCbmY5ZWppNVY3RkEvczBWTjlER0tSRWpiWEpkNFhBS2JaMFVOaXUx?=
 =?utf-8?B?LzdlSU1VOWhXM05SNVRaejdieDYwYklzTzFJS2NGUHN6d0NLbHR5R2NwbklD?=
 =?utf-8?B?VHBtTzhYUVcwU0UycjVOc0JwOFFyWFJPWmJ5cVRxc1ZzMEVrWGdiL1hscWFx?=
 =?utf-8?B?Zlp6Z3lZQXBYRlZCMkthV2E2eThyMnBQUWY3UEFyYzl2R25hV25UOXZGMldv?=
 =?utf-8?B?ZmdTam9ubjlpV2Z5QnBqeTFqMWJLWFdHUW5QL25wUWV0amlpS3BXY1NnVjVT?=
 =?utf-8?B?RHRsaTlMbnhWQStIMFVmbnNNcTJQbTY4NnNLdGFQZnF5b3lLaEcvWTN3L2tT?=
 =?utf-8?B?b1VRVEtHb05lYzlxa1UramhlN1R5NkZNN1FBMWJ2QUtCWmNaQ1RsMHZNUzdL?=
 =?utf-8?B?YnpJeDEvQ1pzOTQ0bTFLaDByTlZmZWJwWVR4MkZETUJqZDNPcUVZYjhtTHZR?=
 =?utf-8?B?Vyt1Q1YrV25xNkNZWkNYYVZHNWdLVjRvTi9kclRiUE1UVXlKOVNEZks5WmdQ?=
 =?utf-8?B?bjVYUUdNK0NOU295WWMxQ1pyYnlkSDN4TTBsRDNuRVk5dFVBWVhwOXU3QXhi?=
 =?utf-8?B?ZlJudzFYNWZXc1hXTUFWSUx5Rm5XM1FyNmRKVXNzdEtmamNHVklpT0o3SEpZ?=
 =?utf-8?B?ZEZ6cW9Wa1VEUWQ5eXdlYXhUWTVaQzBrSUFvZDJzWmlzSVNSOWMwNkFKaTIz?=
 =?utf-8?B?a1JkbWdPZTY1RUFnSHFDTDlFdnp0WHhuamZMcVFVN3JHMThyYXM5ajYxOVNU?=
 =?utf-8?B?RzI2TmhpN25ZdG4zdjhPeWtPMTM0M1hDY2dHQ2RvU1ZXZWZISC9rWUtJOGxO?=
 =?utf-8?B?YXBPVmNpYTJiR0xJNUU3V1JFRVpKOFZiaEFCekRZc3c1WS9SejBtY3NpekZP?=
 =?utf-8?B?UXJxaDh2NWVGMkxEK3NveWtRUXFGSFlEc1BNUVVHeFQ3c0N6QUt4TEp3a2tM?=
 =?utf-8?B?WlRUTEp6UzdERjhuOFlpMzZWMXRHZW9KQmNlcm11VTY1OG5vM2htcFN0ck1w?=
 =?utf-8?B?WmRLWHhvbnFEckZmMS9zRU9kbmpUcWJta1Rhek93L1Yya0tlN2g1VzBja1BD?=
 =?utf-8?B?N2VacnZCTnNuQVNycHNOK21TMjVWUHhlV29tcndyVkV5RzFmV3N0NzJvUlht?=
 =?utf-8?B?OHpCMnlXSmhZMTFKdFo5aTU1N2NORjF1clJJcUNDeWtXOUpIcHJRWllVQWJ4?=
 =?utf-8?B?VTcxdUxTMUd6dmU2VXFpcy9oRk10c2FJTjgyZ1dKT3N4U0ZneHl4Rk4wWTl1?=
 =?utf-8?B?S2RmNllzeExUQk5KeE5UNTlCTjJGbzcvK0E5d0gweHpQNkZpZDF2bjFVNDl0?=
 =?utf-8?B?K0U2Z2lBalk3TGZMV2dxNUVRZ3FpSlV3cFF1dGFhaEtyb29BamJ3K2N1dVBP?=
 =?utf-8?B?VE1iQ0pqSktZZ1JZdTlxQy9OSEJweWJTdkVUNmxqNEs3RDArTnB3R2RpdGt5?=
 =?utf-8?B?NHBpV1VNZ0NwZGtwREFSWVhXOTcyWFlwYnFWWmgwd2cxRlRDWE5LWUZOdWdq?=
 =?utf-8?B?VUwwSVhsTy9ydmx1RU52bDZ3MDBGOHpPNTFEQzFGL0ozRnRPakRqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f28fc66-bf29-471a-5a8e-08de626d572c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 15:11:28.6381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hE9cBN6JY8wH5penu25lti1FOyxh/r56N3eV/90hH6KjzUObbERBfH6ObRUNvIadBVM/r+A6edMHjLk4K38wlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDAyIEZlYnJ1YXJ5IDIwMjYgMTQ6
NDANCj4gVG86IFNoYW1lZXIgS29sb3RodW0gVGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29t
PjsgcWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzog
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
PjsgTmljb2xpbg0KPiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsgZGR1dGlsZUByZWRoYXQu
Y29tOyBiZXJyYW5nZUByZWRoYXQuY29tOw0KPiBjbGdAcmVkaGF0LmNvbTsgYWxleEBzaGF6Ym90
Lm9yZzsgTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47DQo+IE1hdHQgT2NocyA8bW9j
aHNAbnZpZGlhLmNvbT47IHNtb3N0YWZhQGdvb2dsZS5jb207DQo+IHdhbmd6aG91MUBoaXNpbGlj
b24uY29tOyBqaWFuZ2t1bmt1bkBodWF3ZWkuY29tOw0KPiBqb25hdGhhbi5jYW1lcm9uQGh1YXdl
aS5jb207IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOw0KPiB6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b207IHlpLmwubGl1QGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlh
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAzMS8zN10gaHcvYXJtL3NtbXV2My1hY2Nl
bDogQWRkIHByb3BlcnR5IHRvDQo+IHNwZWNpZnkgT0FTIGJpdHMNCj4gDQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
SGkgU2hhbWVlciwgTmljb2xpbiwNCj4gT24gMS8yNi8yNiAxMTo0MyBBTSwgU2hhbWVlciBLb2xv
dGh1bSB3cm90ZToNCj4gPiBRRU1VIFNNTVV2MyBjdXJyZW50bHkgc2V0cyB0aGUgb3V0cHV0IGFk
ZHJlc3Mgc2l6ZSAoT0FTKSB0byA0NCBiaXRzLg0KPiA+IFdpdGggYWNjZWxlcmF0b3IgbW9kZSBl
bmFibGVkLCBhIGRldmljZSBtYXkgdXNlIFNWQSwgd2hlcmUgQ1BVIHBhZ2UNCj4gdGFibGVzDQo+
ID4gYXJlIHNoYXJlZCB3aXRoIHRoZSBTTU1VLCByZXF1aXJpbmcgYW4gT0FTIGF0IGxlYXN0IGFz
IGxhcmdlIGFzIHRoZQ0KPiA+IENQVeKAmXMgb3V0cHV0IGFkZHJlc3Mgc2l6ZS4gQSB1c2VyIG9w
dGlvbiBpcyBhZGRlZCB0byBjb25maWd1cmUgdGhpcy4NCj4gPg0KPiA+IEhvd2V2ZXIsIHRoZSBP
QVMgdmFsdWUgYWR2ZXJ0aXNlZCBieSB0aGUgdmlydHVhbCBTTU1VIG11c3QgcmVtYWluDQo+ID4g
Y29tcGF0aWJsZSB3aXRoIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhlIGhvc3QgU01NVXYzLiBJbiBh
Y2NlbGVyYXRlZA0KPiA+IG1vZGUsIHRoZSBob3N0IFNNTVUgcGVyZm9ybXMgc3RhZ2UtMiB0cmFu
c2xhdGlvbiBhbmQgbXVzdCBiZSBhYmxlIHRvDQo+ID4gY29uc3VtZSB0aGUgaW50ZXJtZWRpYXRl
IHBoeXNpY2FsIGFkZHJlc3NlcyAoSVBBKSBwcm9kdWNlZCBieSBzdGFnZS0xLg0KPiA+DQo+ID4g
VGhlIE9BUyBleHBvc2VkIGJ5IHRoZSB2aXJ0dWFsIFNNTVUgZGVmaW5lcyB0aGUgbWF4aW11bSBJ
UEEgd2lkdGggdGhhdA0KPiA+IHN0YWdlLTEgdHJhbnNsYXRpb25zIG1heSBnZW5lcmF0ZS4gRm9y
IEFBcmNoNjQgaW1wbGVtZW50YXRpb25zLCB0aGUNCj4gPiBtYXhpbXVtIHVzYWJsZSBJUEEgc2l6
ZSBvbiB0aGUgaG9zdCBTTU1VIGlzIGRldGVybWluZWQgYnkgaXRzIG93biBPQVMuDQo+ID4gQ2hl
Y2sgdGhhdCB0aGUgY29uZmlndXJlZCBPQVMgZG9lcyBub3QgZXhjZWVkIHdoYXQgdGhlIGhvc3Qg
U01NVQ0KPiA+IGNhbiBzYWZlbHkgc3VwcG9ydC4NCj4gDQo+IEFmdGVyIGRpc2N1c3Npb24gd2l0
aCBLdWJldmlydCBndXlzLCB0aGUgbWFuYWdlbWVudCBvZiBjdXJyZW50IFJJTCwNCj4gc3NpZHNp
emUsIGF0cyBhbmQgb2FzIG9wdGlvbnMgbG9vayB0b3VjaHkgYmVjYXVzZSBpdCBpcyB0cmlja3kg
Zm9yIHRoZW0NCj4gdG8gaW50cm9zcGVjdCB0aGUgaG9zdCB2YWx1ZXMuDQoNCkkgbWF5IGJlIHdy
b25nLCBidXQgaXQgbG9va3MgbGlrZSBLdWJldmlydCBhY3R1YWxseSBtYWtlcyB1c2Ugb2YgbGli
dmlydC4gT3INCmlzIGl0IGluZGVwZW5kZW50Pw0KDQpUaGUgcmVhc29uIEkgYW0gYXNraW5nIGlz
IE5hdGhhbiBpcyBhbHJlYWR5IHdvcmtpbmcgb24gdGhlIGxpYnZpcnQgY2hhbmdlcyANCmZvciB0
aGlzIGhlcmU6DQpodHRwczovL2xpc3RzLmxpYnZpcnQub3JnL2FyY2hpdmVzL2xpc3QvZGV2ZWxA
bGlzdHMubGlidmlydC5vcmcvdGhyZWFkLzVHRzc2QVFUVERVSFc1S1JBTlBZM1FVSUk0Wk9FWVJQ
Lw0KDQpBbmQgdGhlIF9BVVRPIHN1Z2dlc3Rpb24gbWlnaHQgaW1wYWN0IHRoYXQgYXMgd2VsbC4N
CiANCj4gSW4gY29sZCBwbHVnIGNhc2UgYXQgbGVhc3QgaXQgbG9va3MgZmVhc2libGUgdG8gdXNl
IElPTU1VX0dFVF9IV19JTkZPKCkNCj4gdG8gcmV0cmlldmUgaG9zdCBpbmZvOg0KPiANCj4gUklM
IGlzIGluIElEUjMNCj4gc3NpZHNpemUgaW4gSURSMQ0KPiBPQVMgaW4gSURSNQ0KPiBBVFMgbWF5
IGJlIG1vcmUgdG91Y2h5IGJ1dCBtYXliZSB0aGlzIGNhbiBiZSBpbnRyb3NwZWN0ZWQgdG9vPw0K
DQpZZWFoLiBBVFMgbWlnaHQgcmVxdWlyZSBzb21lIGtlcm5lbCBwbHVtYmluZyBhcyBCSU9TIGNh
biBvdmVycmlkZSBpdC4NCg0KPiBJIHdvdWxkIGFkdm9jYXRlIHRvIHR1cm4gdGhvc2Ugb3B0aW9u
cyBpbnRvIF9BVVRPIG9wdGlvbnMgdG8gZ2l2ZSBhDQo+IGNoYW5jZSB0byB0aGUgdXNlciB0byBh
c2sgZm9yIGhvc3QgZGVyaXZlZCB2YWx1ZXMuDQo+IA0KPiBDdXJyZW50bHkgaW4gaW5jbHVkZS9o
dy9xZGV2LXByb3BlcnRpZXMuaCB3ZSBoYXZlDQo+IERFRklORV9QUk9QX09OX09GRl9BVVRPIGZv
ciBhIGJvb2wgYW5kDQo+IERFRklORV9QUk9QX09OX09GRl9BVVRPX0JJVDY0IGZvciBhIDY0Yg0K
PiANCj4gUklMIGNhbiBtYXRjaCBib29sLg0KPiBPdGhlcnMgbWF5IG5lZWQgYSBuZXcgREVGSU5F
X1BST1BfT05fT0ZGX0FVVE9fKiBvbmUuDQo+IA0KPiBOb3RlIHN1Y2gga2luZCBvZiBhdXRvIHBy
b3BlcnR5IHdhcyBpbnRyb2R1Y2VkIGZvciB2aXJ0aW8taW9tbXUNCj4gKERFRklORV9QUk9QX0dS
QU5VTEVfTU9ERSkNCj4gDQo+IFdoYXQgZG8geW91IHRoaW5rPyBNb3N0IHByb2JhYmx5IHRoaXMg
aGFzIGJlZW4gZGljdXNzZWQgaW4gdGhlIHBhc3QgYnV0DQo+IEkgZG8gbm90IG5lY2Vzc2FyaWx5
IHJlbWVtYmVyIHRoZSBvdXRwdXRzLg0KDQpJSVJDLCB0aGUgb25seSBjb25jbHVzaW9uIHdhcyB0
aGF0IHRoZSB1c2VyIGhhcyB0byBzcGVjaWZ5IHRoZSBTTU1VdjMNCnBhcmFtZXRlcnMuICBEb24n
dCB0aGluayB0aGUgX0FVVE8gb3B0aW9uIHdhcyBkaXNjdXNzZWQgcHJldmlvdXNseS4NCklmIHRo
aXMgaXMgYSB2ZXJ5IHVzZWZ1bCB0aGluZyB0byBoYXZlLCBJIGNhbiB0YWtlIGEgbG9vay4NCg0K
VGhhbmtzLA0KU2hhbWVlcg0K

