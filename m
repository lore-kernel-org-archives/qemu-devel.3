Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF65CF11F5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 14:48:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syuSA-0001ar-Nq; Thu, 10 Oct 2024 10:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1syuS8-0001a9-HI; Thu, 10 Oct 2024 10:47:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1syuS6-0001eM-Dm; Thu, 10 Oct 2024 10:47:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMZY6009563;
 Thu, 10 Oct 2024 14:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+AON3dIx3rsjeGYWmxDPLf5/RoWextDSqZYZecpGdLI=; b=
 XAeRlhTDSqveSoiNRJjCmRKduxkwYq33t/9sqsEuMsvljPaxDZpmHcQX/ygT+kSs
 /5F4igvWANk4IXrrrnWO7/XuHtVaaBQJez5GmEgZv+dvQM3cbPLAjM3wq+Z7E2mL
 0FfeT5c3AUgkPOFjoK5SKDaR4t0hP4lmdnUXcrHEBxJFznmO8gDcRgh5PZbccK+B
 1yj9fRuadQuOD9bn5djcPurer6FdM/AIg0zylhvZ3l+U48NHBne1YUP27HUyLXBB
 kmxSxylGtVD4tXvkdJcHTgW6IN1tGPIxe/vrHZEhFXyM2RneSJnBQ7YmX0vGHbbk
 mTN/JyDep1C+Xyd1Qc+4Qg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e32ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 14:47:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49AE5jol019135; Thu, 10 Oct 2024 14:47:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwgebww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 14:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4MUnkQknZPWvc3NMtgTHUPE6S78KOewnpVrocxQb3XJxSfHZJ+OyBeveDmoukbRAoi/66dClPZspCNrJ4Ka0487kT/idlm/ZmJJMFxNkSszCHimzfjl3w0CDZAi8BpwDnUAsgJwUHpJ3/1nVMm1txon++QCImYteBglIR+iY3YS1lL85r6asNUPMYVXIw9z2no94sRi8fc9tEtXiNRPcm9J32RsO/aKMUCsFM5e6Bi3ERBslnRDyn8ZsNTSBrbe66YEwT2bv7R+vYuNOfUKrEg/FrnSWhW6FO3SAa5cRf1GdAiImyp/G+nc4+8T9SKrNbgokmhk6CnYZbn7IXatEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AON3dIx3rsjeGYWmxDPLf5/RoWextDSqZYZecpGdLI=;
 b=RiBAr6xBwZfxYrunuv3uuLBsfWNOUSVyUgsaGdBEfaodX0acLN3UboUray1bAsjYG/VNXCsD8OQYNf2GbHy2Z3HObswpLcdZ5OytdzMs6PUM0mPExwf1nKWIvPHH2nNRFImnn9j/cTA1j8Jh6+p8X/+tLtwL4YkZWpUAhCYiS9Dn8AIiBtC1o1Djen2PHYF5bNS2IlUhq/texOQf7sTG3tyA5uqmysrQXpjKaO09K2hXa8jrh32sAxii3etQqv/q5S6i4OSgnEdlsMOTdiv2RAD18k8ZwNVgiuxeUb6pGvVsmkunBunHVEBc4u9VZlR6A+0YgfK3m+j2K9XwWtIxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AON3dIx3rsjeGYWmxDPLf5/RoWextDSqZYZecpGdLI=;
 b=n1AeymkcoAEJ4hQurdSI+uG2FLD024GGrIRilsiWEf343JtyT1dVNfoR5YQ6NINHPajk1n0/O4gFWAgygGVIohoV61v7VgnPRRlygr7kpzCMvwb1tpKzKBGcRRyeTyL2exNkZpRhwiVYOm0CNPhQD8lDsg59hP2tZBVSZDIZlAc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SA1PR10MB6293.namprd10.prod.outlook.com (2603:10b6:806:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 14:47:01 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 14:47:01 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Salil Mehta <salil.mehta@huawei.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Marc Zyngier
 <maz@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Peter Maydell <peter.maydell@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>,
 "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: Re: [PATCH RFC V4 02/33] cpu-common: Add common CPU utility for
 possible vCPUs
Thread-Topic: [PATCH RFC V4 02/33] cpu-common: Add common CPU utility for
 possible vCPUs
Thread-Index: AQHbGfoutCdRbgn2cUijroPO6hWGo7KAEoEA
Date: Thu, 10 Oct 2024 14:47:01 +0000
Message-ID: <23D4A389-FEB6-4C24-93B5-2D775F208390@oracle.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
 <20241009031815.250096-3-salil.mehta@huawei.com>
In-Reply-To: <20241009031815.250096-3-salil.mehta@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|SA1PR10MB6293:EE_
x-ms-office365-filtering-correlation-id: d3865ae1-6c39-414d-339b-08dce93a667d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WnhVWFRPMG4reTBocHpCY2I0SVBaRWsyUGprY3RZcG5QcjBLenVLaTA5QmNJ?=
 =?utf-8?B?QmlFRERXanRFNmtYL0RsNlh5OUtSZGFYdmY3U2dkc0F4KzF5RWZjZWRCQzhj?=
 =?utf-8?B?MGMzUHVUbFppSEhtdzRGQ2ovZ3VHL0U4ZDhTZVdpaVJrd3liOFdxWHM2N3NT?=
 =?utf-8?B?TGdqM2lvczBwMWFCeGF6NnBaWWJkWThLQW0rN2pCQnpIejN5SUZDUE1KblFE?=
 =?utf-8?B?cVplc2VxNGdQYlB1c0lMcWNrUW5XbDNUN2FwdzlDd2JLYk1tamNCSTlGUE41?=
 =?utf-8?B?SGRzdmRPTHNwbkJYandBVDM3WW5IWFZxMmRBc0xsanlqcmlXMUhBRVhBcTho?=
 =?utf-8?B?TFBSakE1YjJESGdGcVI4UFRxOC8rL2k1bFpYZXp5ckhPSTY3SVBPdC9vRi9o?=
 =?utf-8?B?VEphQk9zQ0Iya0p0TWY2UlB6Mnd2dk40YXBpSStRNk5BM0xaVEo0VUhWbjdy?=
 =?utf-8?B?eGJLc29yYlRzOFJIYUZWUGxtT01NZU5qRGRVbkdzWW1kRUU2eUdMNnVqYVZG?=
 =?utf-8?B?TFpMZzVUclVCTmZCaHJCWjZNRlpGbTg5TXlFSGQ0TmkyMkNxZHIwZDNDeU45?=
 =?utf-8?B?aDlENTFiSjdRdnlhMWhaWmhqblMvT1c2NGc5cWRUOGxOT1VSZUtyWVlzZGpq?=
 =?utf-8?B?QklORTlJS2gzdzF3d2VkYjQxdVlKd1k5NlgzR3RXZzdId3c3VkNuZXFzalU1?=
 =?utf-8?B?RzBDeVZWcW5qLzRQY3MvSjJjUVlya1M1bnFPZGM3Wkp4L2tqM3NmdFcwUEJJ?=
 =?utf-8?B?eDNxYkxOZDN6NWxXN0JQa1VLdkRxZEw5V3g1Wk8zLzdoaFlWQmd4UkFqejZh?=
 =?utf-8?B?OXhlTEoxUXptSUlZNFR4RjZJU0cvVHJHSVVYbmp2V3FXUzdRRktvZHc1VWlU?=
 =?utf-8?B?anQwdVp6T0xJS0Fwa0lqb2tiZlk4MGVaRnhwZGJZaFVBcm54bWlxUWwxOEdG?=
 =?utf-8?B?Z2xwZkJSUy80UGhrN1dtT1I3NVlUd3FHMGppTlMxZUlmRDArcjJHOFZpNEVh?=
 =?utf-8?B?NDVTTGtXT2xYRWxHbzM3UENmckxsYXVnZTZGWXQ2VjhHYkI1UW9pcEVOMnFN?=
 =?utf-8?B?VVVabmJ2SjQ1dTY1OUJhOUhmRUxscXp1dWhIVGlFSER5bm5FSHpiNDRsUXRG?=
 =?utf-8?B?M1g2VkVlQVZ1cGw3MHNhYVp2RGRhREs0YUpCRU1zL3AxeEhROGNsc1pCMi8x?=
 =?utf-8?B?ODVrNGlva05BbWtlb2FtMDhpK1d0WlViZ2prZnp5cUxFRmpNeEtRMkhsRlVB?=
 =?utf-8?B?bDlneEViQ0UxSERPcEpOb1RuaFdEREkxMCtRU0pUUng2bG9ma0tINzI4YUhh?=
 =?utf-8?B?R2o3cTU3STE2dG12VDg5VEVrTUw1RzZjUUdmS0prSU5MMTAwa294bzR5ZWxI?=
 =?utf-8?B?eW0xb2lhaXljNUhsb1BDYkpFNVFPZWxGMThDRzJhZHRYVzRzL0dRWUJtSXNh?=
 =?utf-8?B?Uis0QUtCTmpaN2QySTJXb2l6RUg0cFZ2Y00vNmc1MlBYNzk4MUNYend2OHFk?=
 =?utf-8?B?YjB1YnhER3hRdndaT1dEQmhoVnlhZGFPbTcwZ1MvL2pONWorbElqcnRZU00v?=
 =?utf-8?B?aHE4N0p6MjZIU3FqaFRDU0pkVGZocjE3bGljd2xDZTEzQkZoTXJGWDlNZkFO?=
 =?utf-8?B?NW00KzB2ZWgxSGtMTFd1akx2cWJxTUlDZk9kTm1pSWZrRUMzeU85eUg5VmVW?=
 =?utf-8?B?bFlNUVNHUGR4YVZjdnpUTU5BZEdnaWVVenl4S2hIODZIdjZDZEIwSFdLOTEr?=
 =?utf-8?B?OHhtWEJvYThlTkZqODljajlwUlVOUEJnM3ZuVFFtT0ZpU2tTM3E0Zkh2YjRw?=
 =?utf-8?B?LzY0K3hGV3NMK2dJazFvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDlmeExZdjdKSDRBdDZjY3h5UkFmSW83T2pvVDlaTXRBY1pCZ0xXYms4UWlE?=
 =?utf-8?B?N1RMcGpiREVPdVNLQlBNWjhyenVEeXNDNGo4RE10YXZ1THJGL1p0UXJ6aGNK?=
 =?utf-8?B?ZUZlaUh5bXF1T09aUVB0N0VhNms5ODNPMFdyK1hGT2NPZkllSmlXaUk2UDB1?=
 =?utf-8?B?NG9OckxKK0h0RStHL2lZYU04dWZxZzFxQWE3bmNSaXYycU5hd1lKd3VwcFRJ?=
 =?utf-8?B?L1pUNitIM2toUzFRalUyYWd2ZTA2RnJ5VXMwa25YN3EvYURrSjlzZ25GdEFq?=
 =?utf-8?B?TVZ2aHBOdE95Vm8wd1ZwTXhHREtrOXpMNHU5dk0rMUcrSThoc1NISkRWWGxF?=
 =?utf-8?B?QTBtbFBHOGM0YXRET3dVcytOWmZMcFZGajZ0SWIwejVINEVYQVhqZlpiL3Z4?=
 =?utf-8?B?MUN0TExJbUd1MGR1bXNuRkRCTzJ2MnZqWEpBUHgxR0JKb000ZzBKRlFyS1U3?=
 =?utf-8?B?VVdyUnduTU42SU1DMzhPTmI3S2lIVFZtMTVtaTZHQzVGMktQTXpNMmsvVnNM?=
 =?utf-8?B?TXZRRFl4K2JtdjhvMmhjTjl4Z3ptVHhVTGE1Ym54ckRVZUd3bHN0bEgvRTdr?=
 =?utf-8?B?VnFFQlpZOWF2ZVdLeWFxMVQ0M2ZrcG5tSGp5TmlLSW5wNGUvZVpoamFaTkVB?=
 =?utf-8?B?cWl4UVYvZkNOb0tnZjdpWnJIeDNxOXlQNG8rU1dFMXNRZ0d4NlhyZmorWHU2?=
 =?utf-8?B?cGh6V2E0VCsybDJYU3pqOWo0NTI3YVVkNWQ2RjNMU2FIaU95TTlQWFZ5ZU0r?=
 =?utf-8?B?dnNjamlXZHRtc3NRdW40NW9jY0hpTGc4dDhqMW1EdnJkUXR0QURzUmVobnZJ?=
 =?utf-8?B?WEprb0F5T29IaTJra29TNnhsU01paEJwaFZhYk0yMXFQSEVic2tKeVJNSTFC?=
 =?utf-8?B?RWlTcERmT1pleFVWa1dTS1hKYlM4VnVYTitxbGVFcHRncnpsMU03RlFzR3h5?=
 =?utf-8?B?ZzdDNlRaYTdhY1drSk5zNW15WjJNRVd5aEM1MXdhTVEyc1VTMkYxQnlCU3Za?=
 =?utf-8?B?ZXNTOWhhanp3UFNLb3Y0RG4zMExQN3EzYVk4dGx4Qy8wUnZzODBaeXY3QXFa?=
 =?utf-8?B?Szdvd1B1NzU4elJOa0M4MGt2bUVRS0NNU0hGM04yUW9qY25LdlhqYStianlh?=
 =?utf-8?B?NnJsRDRMY3ZxbUtMejA5UmJnVG9oUWR2OVNvdDA4ZExFYUdKOFA5SU5WNjJI?=
 =?utf-8?B?TWhkc1FLdUM4TFE5RXUyOVBTT1NKdE42RVVmK2NPR3lGQVIrS3ZVTDVUbER5?=
 =?utf-8?B?akF3YUgzL0dGOFJ3N2MyekowbHVCNnpMYzZ5RVhzNUR2Rk1CaXNzbWpwUFRw?=
 =?utf-8?B?T2VLYlhreFQ4SC9sbXdEYWdwQ2xYbzNmTGxCN0F3Q3dzR2txNVNJa0ZDNXcx?=
 =?utf-8?B?YXVkdDBqbzdicFNRR01pMnlHeElsYXQ1S3BSYjl0Rkx4WU9UaFVxN0ZJcyta?=
 =?utf-8?B?QzVmUUhYYWVBTG5WV3plSExPMFpQZzgvV2F6TU5vYm5EZzhRd0pFR3Z3Y013?=
 =?utf-8?B?dmM1bHJ6MmdWT0dBYUFpWG0zbk5qL2pHT01TODE3cUNER1FlUjlUTXpNdVNp?=
 =?utf-8?B?YjNHdVF3d0V2M1UzU3QvdU8vaEhSS3NtdExhZXI5Uks0OTNJQ0N0anllWDRy?=
 =?utf-8?B?UktZQStCR1c5alRFeTNXb3JjUk5DOFdYY3dsR3A0Y3FMRVRHTTlWOWhXZXY3?=
 =?utf-8?B?bXNJVFFBVDkxTVpxLy9MalUyZTlXcFlpU0xhMWx5Y29GZ2lTMWpROTg4UUIx?=
 =?utf-8?B?YWZCY0ljR3dORUlkWUpIOWJYZDVtZm9VdWJ6VnJCVEJKTmVaSEpoWDFKV0Vx?=
 =?utf-8?B?VkhLMXgzNWhJbVhhenZiS0R0Z0hmeUs5c0JmMkNVMXc1dEdDZXpsWDNIU0JW?=
 =?utf-8?B?bEVCVFB1MjdJajZWWnc4SXFiZi9ubmY3R3lYek1lTXgxaVJ0aTMxYmxUb0xs?=
 =?utf-8?B?N2JDNStjZ01CUTFoM05UWWdvd0FmVlRCei8vVTQwV0ZnS0xGRHhRSmJKTTZ0?=
 =?utf-8?B?RUp6SnZLMzhzdlZuNlRpVy9GTE1hSjF0MjFzeDF5VzIvQlBnMGxqWTJHSHJS?=
 =?utf-8?B?RDNBWkh1RFVwNnpUUXQvL3BFWTRzSFRrOTBReVkwQnpYZTRkUndOdWxCdk9S?=
 =?utf-8?B?N01oZjdIcnpid1hTT0JNUHRLc0FjQlh0aWNJQTdkMjJwSldOVzlkbE5lY2RT?=
 =?utf-8?Q?YbqieWai49sM3Nu/rr9TRf0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99677AB2EFAFD74AAC7F82BFD9674A49@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AeUCkLs6wODc8zSiLl63g84YSJ9lQBylYEv9TEnudFkOWAwRPhiw6zXTXalv0C0tGvegJmwFxGXXmTf3pz6cg/dO0zQILo6vNihyeEARDsNBUBo20kTTbvM2CdDguQY6DxGj1BC4IeA3eav6MsYlxkP/Ty9Gtvy9NKSJFaJia8g6A7ORpKfglqQWcNEx80hg15ZfIVrO2hk1PtpSiJPsafbGWI2r4GYG3KmWf/LiSsu17armAebeQTC1+eVLGG50CkgIOAxvpuIIxTet7/wZJJOXsn3cG/ONR4qlEyWh4k4yRv7XobvWidyoZZS9IVTuMjLDf8+TpNQdkilIRiw0BJx27wyFN9o+9rdjXsdhq12k1RyYiAb6xAoOzoio9p5AbNY29a0+oK/2y7pXVmNJL9af3aUT6stM8+BRhDLUlUHqy7fs2CpZ5BwZaYtfwtmJSsidXYZtFj8Ne/x5ZrX3ZkUmik5SmDufuI3kxjBAQxWYCT3fhrmLdJAdU8bdLwegeu2WPMNjUvVD+szTbGKhZn28zGjs6w9uj2XW6UHQzS+xnP93Jac9swH5oDTOmtLUuyhUx206C0x+YaBkzTz3gURNKETCi+oIWjFeLYMZe3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3865ae1-6c39-414d-339b-08dce93a667d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 14:47:01.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZdggN994lteHWfvtU3zjmQPzHuRjddIFoEcwZMXiJyHR/I17AKMixBzATVlpfvtz7a3pLjGrLP6uKpCflxovw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=991 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100098
X-Proofpoint-GUID: AthZu8UeDPunbzcZ3ZT4uDURJNdIZYgL
X-Proofpoint-ORIG-GUID: AthZu8UeDPunbzcZ3ZT4uDURJNdIZYgL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgU2FsaWwsDQoNCj4gT24gOSBPY3QgMjAyNCwgYXQgMDM6MTcsIFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IFRoaXMgcGF0Y2ggYWRkcyB2YXJpb3Vz
IHV0aWxpdHkgZnVuY3Rpb25zIHRoYXQgbWF5IGJlIHJlcXVpcmVkIHRvIGZldGNoIG9yIGNoZWNr
DQo+IHRoZSBzdGF0ZSBvZiBwb3NzaWJsZSB2Q1BVcy4gSXQgYWxzbyBpbnRyb2R1Y2VzIHRoZSBj
b25jZXB0IG9mICpkaXNhYmxlZCogdkNQVXMsDQo+IHdoaWNoIGFyZSBwYXJ0IG9mIHRoZSAqcG9z
c2libGUqIHZDUFVzIGJ1dCBhcmUgbm90IGVuYWJsZWQuIFRoaXMgc3RhdGUgd2lsbCBiZQ0KPiB1
c2VkIGR1cmluZyBtYWNoaW5lIGluaXRpYWxpemF0aW9uIGFuZCBsYXRlciBkdXJpbmcgdGhlIHBs
dWdnaW5nIG9yIHVucGx1Z2dpbmcNCj4gb2YgdkNQVXMuIFdlIHJlbGVhc2UgdGhlIFFPTSBDUFUg
b2JqZWN0cyBmb3IgYWxsIGRpc2FibGVkIHZDUFVzLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5OiBL
ZXFpYW4gWmh1IDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtlcWlh
biBaaHUgPHpodWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogU2FsaWwgTWVo
dGEgPHNhbGlsLm1laHRhQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiBjcHUtY29tbW9uLmMgICAgICAg
ICAgfCAyMSArKysrKysrKysrKysrKysrKysrKw0KPiBpbmNsdWRlL2h3L2NvcmUvY3B1LmggfCA0
NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IDIgZmlsZXMg
Y2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NwdS1jb21tb24u
YyBiL2NwdS1jb21tb24uYw0KPiBpbmRleCA2YjI2MjIzM2EzLi40YTQ0NmY2ZjdmIDEwMDY0NA0K
PiAtLS0gYS9jcHUtY29tbW9uLmMNCj4gKysrIGIvY3B1LWNvbW1vbi5jDQo+IEBAIC0yNCw2ICsy
NCw3IEBADQo+ICNpbmNsdWRlICJzeXNlbXUvY3B1cy5oIg0KPiAjaW5jbHVkZSAicWVtdS9sb2Nr
YWJsZS5oIg0KPiAjaW5jbHVkZSAidHJhY2UvdHJhY2Utcm9vdC5oIg0KPiArI2luY2x1ZGUgImh3
L2JvYXJkcy5oIg0KPiANCj4gUWVtdU11dGV4IHFlbXVfY3B1X2xpc3RfbG9jazsNCj4gc3RhdGlj
IFFlbXVDb25kIGV4Y2x1c2l2ZV9jb25kOw0KPiBAQCAtMTA4LDYgKzEwOSwyNiBAQCB2b2lkIGNw
dV9saXN0X3JlbW92ZShDUFVTdGF0ZSAqY3B1KQ0KPiAgICAgY3B1X2xpc3RfZ2VuZXJhdGlvbl9p
ZCsrOw0KPiB9DQo+IA0KPiArQ1BVU3RhdGUgKnFlbXVfZ2V0X3Bvc3NpYmxlX2NwdShpbnQgaW5k
ZXgpDQo+ICt7DQo+ICsgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUocWRldl9nZXRfbWFj
aGluZSgpKTsNCj4gKyAgICBjb25zdCBDUFVBcmNoSWRMaXN0ICpwb3NzaWJsZV9jcHVzID0gbXMt
PnBvc3NpYmxlX2NwdXM7DQo+ICsNCj4gKyAgICBhc3NlcnQoKGluZGV4ID49IDApICYmIChpbmRl
eCA8IHBvc3NpYmxlX2NwdXMtPmxlbikpOw0KPiArDQo+ICsgICAgcmV0dXJuIENQVShwb3NzaWJs
ZV9jcHVzLT5jcHVzW2luZGV4XS5jcHUpOw0KPiArfQ0KPiArDQo+ICtib29sIHFlbXVfcHJlc2Vu
dF9jcHUoQ1BVU3RhdGUgKmNwdSkNCj4gK3sNCj4gKyAgICByZXR1cm4gY3B1Ow0KDQpJIGRvbuKA
mXQgZmVlbCBxZW11X3ByZXNlbnRfY3B1IHNob3VsZCBiZSBuZWVkZWQgYXMgY3B1cyBhcmUgaW1w
bGljaXRseSBwcmVzZW50IGFzDQphbiBpbml0aWFsaXphdGlvbiBwcmVtaXNlIGFuZCBhcm0vdmly
dCBiZWluZyB0aGUgb25seSB1c2VyIG9mIHRoaXMgbm93Lg0KDQpUaGFua3MNCk1pZ3VlbA0KDQo+
ICt9DQo+ICsNCj4gK2Jvb2wgcWVtdV9lbmFibGVkX2NwdShDUFVTdGF0ZSAqY3B1KQ0KPiArew0K
PiArICAgIHJldHVybiBjcHUgJiYgIWNwdS0+ZGlzYWJsZWQ7DQo+ICt9DQo+ICsNCj4gQ1BVU3Rh
dGUgKnFlbXVfZ2V0X2NwdShpbnQgaW5kZXgpDQo+IHsNCj4gICAgIENQVVN0YXRlICpjcHU7DQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2NvcmUvY3B1LmggYi9pbmNsdWRlL2h3L2NvcmUvY3B1
LmgNCj4gaW5kZXggMWM5Yzc3NWRmNi4uNzNhNGU0Y2NlMSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ody9jb3JlL2NwdS5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiBAQCAtNTM4
LDYgKzUzOCwyMCBAQCBzdHJ1Y3QgQ1BVU3RhdGUgew0KPiAgICAgQ1BVUGx1Z2luU3RhdGUgKnBs
dWdpbl9zdGF0ZTsNCj4gI2VuZGlmDQo+IA0KPiArICAgIC8qDQo+ICsgICAgICogSW4gdGhlIGd1
ZXN0IGtlcm5lbCwgdGhlIHByZXNlbmNlIG9mIHZDUFVzIGlzIGRldGVybWluZWQgYnkgaW5mb3Jt
YXRpb24NCj4gKyAgICAgKiBwcm92aWRlZCBieSB0aGUgVk1NIG9yIGZpcm13YXJlIHZpYSB0aGUg
QUNQSSBNQURUIGF0IGJvb3QgdGltZS4gU29tZQ0KPiArICAgICAqIGFyY2hpdGVjdHVyZXMgZG8g
bm90IGFsbG93IG1vZGlmaWNhdGlvbnMgdG8gdGhpcyBjb25maWd1cmF0aW9uIGFmdGVyDQo+ICsg
ICAgICogdGhlIGd1ZXN0IGhhcyBib290ZWQuIFRoZXJlZm9yZSwgZm9yIHN1Y2ggYXJjaGl0ZWN0
dXJlcywgaG90cGx1Z2dhYmxlDQo+ICsgICAgICogdkNQVXMgYXJlIGV4cG9zZWQgYnkgdGhlIFZN
TSBhcyBub3QgJ0FDUEkgRW5hYmxlZCcgdG8gdGhlIGtlcm5lbC4NCj4gKyAgICAgKiBXaXRoaW4g
UUVNVSwgc3VjaCB2Q1BVcyAodGhvc2UgdGhhdCBhcmUgJ3lldC10by1iZS1wbHVnZ2VkJyBvciBo
YXZlDQo+ICsgICAgICogYmVlbiBob3QtdW5wbHVnZ2VkKSBtYXkgZWl0aGVyIGhhdmUgYSBgQ1BV
U3RhdGVgIG9iamVjdCBpbiBhICdkaXNhYmxlZCcNCj4gKyAgICAgKiBzdGF0ZSBvciBtYXkgbm90
IGhhdmUgYSBgQ1BVU3RhdGVgIG9iamVjdCBhdCBhbGwuDQo+ICsgICAgICoNCj4gKyAgICAgKiBC
eSBkZWZhdWx0LCBgQ1BVU3RhdGVgIG9iamVjdHMgYXJlIGVuYWJsZWQgYWNyb3NzIGFsbCBhcmNo
aXRlY3R1cmVzLg0KPiArICAgICAqLw0KPiArICAgIGJvb2wgZGlzYWJsZWQ7DQo+ICsNCj4gICAg
IC8qIFRPRE8gTW92ZSBjb21tb24gZmllbGRzIGZyb20gQ1BVQXJjaFN0YXRlIGhlcmUuICovDQo+
ICAgICBpbnQgY3B1X2luZGV4Ow0KPiAgICAgaW50IGNsdXN0ZXJfaW5kZXg7DQo+IEBAIC05MjQs
NiArOTM4LDM4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBjcHVfaW5fZXhjbHVzaXZlX2NvbnRleHQo
Y29uc3QgQ1BVU3RhdGUgKmNwdSkNCj4gICovDQo+IENQVVN0YXRlICpxZW11X2dldF9jcHUoaW50
IGluZGV4KTsNCj4gDQo+ICsvKioNCj4gKyAqIHFlbXVfZ2V0X3Bvc3NpYmxlX2NwdToNCj4gKyAq
IEBpbmRleDogVGhlIENQVVN0YXRlQGNwdV9pbmRleCB2YWx1ZSBvZiB0aGUgQ1BVIHRvIG9idGFp
bi4NCj4gKyAqICAgICAgICAgSW5wdXQgaW5kZXggTVVTVCBiZSBpbiByYW5nZSBbMCwgTWF4IFBv
c3NpYmxlIENQVXMpDQo+ICsgKg0KPiArICogSWYgQ1BVU3RhdGUgb2JqZWN0IGV4aXN0cyx0aGVu
IGl0IGdldHMgYSBDUFUgbWF0Y2hpbmcNCj4gKyAqIEBpbmRleCBpbiB0aGUgcG9zc2libGUgQ1BV
IGFycmF5Lg0KPiArICoNCj4gKyAqIFJldHVybnM6IFRoZSBwb3NzaWJsZSBDUFUgb3IgJU5VTEwg
aWYgQ1BVIGRvZXMgbm90IGV4aXN0Lg0KPiArICovDQo+ICtDUFVTdGF0ZSAqcWVtdV9nZXRfcG9z
c2libGVfY3B1KGludCBpbmRleCk7DQo+ICsNCj4gKy8qKg0KPiArICogcWVtdV9wcmVzZW50X2Nw
dToNCj4gKyAqIEBjcHU6IFRoZSB2Q1BVIHRvIGNoZWNrDQo+ICsgKg0KPiArICogQ2hlY2tzIGlm
IHRoZSB2Q1BVIGlzIGFtb25nc3QgdGhlIHByZXNlbnQgcG9zc2libGUgdmNwdXMuDQo+ICsgKg0K
PiArICogUmV0dXJuczogVHJ1ZSBpZiBpdCBpcyBwcmVzZW50IHBvc3NpYmxlIHZDUFUgZWxzZSBm
YWxzZQ0KPiArICovDQo+ICtib29sIHFlbXVfcHJlc2VudF9jcHUoQ1BVU3RhdGUgKmNwdSk7DQo+
ICsNCj4gKy8qKg0KPiArICogcWVtdV9lbmFibGVkX2NwdToNCj4gKyAqIEBjcHU6IFRoZSB2Q1BV
IHRvIGNoZWNrDQo+ICsgKg0KPiArICogQ2hlY2tzIGlmIHRoZSB2Q1BVIGlzIGVuYWJsZWQuDQo+
ICsgKg0KPiArICogUmV0dXJuczogVHJ1ZSBpZiBpdCBpcyAnZW5hYmxlZCcgZWxzZSBmYWxzZQ0K
PiArICovDQo+ICtib29sIHFlbXVfZW5hYmxlZF9jcHUoQ1BVU3RhdGUgKmNwdSk7DQo+ICsNCj4g
LyoqDQo+ICAqIGNwdV9leGlzdHM6DQo+ICAqIEBpZDogR3Vlc3QtZXhwb3NlZCBDUFUgSUQgdG8g
bG9va3VwLg0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQo=

