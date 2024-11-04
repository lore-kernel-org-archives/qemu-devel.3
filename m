Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D68D132BE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wd6-0004zy-1F; Mon, 04 Nov 2024 07:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1t7wco-0004yy-NH; Mon, 04 Nov 2024 07:56:06 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1t7wcj-0004OR-62; Mon, 04 Nov 2024 07:56:06 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A48fm5K020956;
 Mon, 4 Nov 2024 12:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=00fcCbkdKj4vCDTchzk7imFH1uu/qXE1eNrCfI+KCXk=; b=
 R6kjkAC5ITc5FqqwaTwvc1QWEXSFMARxSAOeGfp6wDmG9LVkEIDu4D0PDVV2qNwW
 92bVqscOKpVBHokKZdkB2PMoowjGZNNrZ2joqiexLBJmT/l4KpImtPqXanPaH9gQ
 kzgFwMLB35RG24djlSjIqoHBp+REdZO0xUV/bfMkfelOjLPOgFbc6Q4rk5hIyIZB
 bmuYqSrC28AOSjsvWQ1vvYxKbP5YNRSkwjiSIU76sqXLd3hXHW78staDZB7K2w1y
 c7AFBBFabHImt1g3QLR+mpAzJ+azGa84ld/iDFaHCw2/kFpwub2m9tio129dQqFx
 c+kNBGin7z65rm/nhRex+Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8tm59-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 12:55:05 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A4BsT8V031294; Mon, 4 Nov 2024 12:55:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42nah5esmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 12:55:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VL5V6qeu3KatXoxbSlOabAJftrmAjz0RAfavyGzsrs7MH9Ddiyj6wAkwiFc/U2xLCAh20+40w1/OLzR8mLNRPy7c3xXnhxEhZim2qO+zesWvRSdhMI4AagHMjtRq0Xdb/a1IAHLkKGR2WRd+MB1mlKbHu5/AoOLEu0lqRC2jkIvt7MNvIXx1cXSVrZm2Ag0rztMn9tXOJY6ZRg+3+N0vwDUidXtDPkceMiFJSm0Ve9KQhiE2jtnNnBW9OdwTFmxmWtfAXj7yUqt5IjItXbAPgFf7I1N8ixXsLIcY8yyYJjjg9gzCI+T77t/lIgdpCxFCuFaraEAduRMQgWYYJ2wT9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00fcCbkdKj4vCDTchzk7imFH1uu/qXE1eNrCfI+KCXk=;
 b=AK1TjQcrVWPUjPSj/XxsZvnchfdjWFiZu2TuF7AB16+R0iAmenJhGoSa2+/52OjxRUeBCKty7A3hOkNGMJ+bRHgo3E+9atJe7gvanmHrf/eYmGmunBsvRVewRyHbrKpQpr6hzcAuZJZZGZ2tT6HfUKNsgbIKHf1VnGclyTGyBkmqkAXcDoLns6Fn7ulAiyyd4Vq+f06aV1cwx61pwnkVrctFWbJxqjfNSfQXxIoZGlcixBIumtAHjtFaBzBGZ9iSFlopz+dHLxTjvlfZzdBXRYDPBOSg8AdI1jdMYKtWNDn9fyaDFIKMMMl/zM2XJuPu8PVTv4KvbrCxQzYD/TGFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00fcCbkdKj4vCDTchzk7imFH1uu/qXE1eNrCfI+KCXk=;
 b=lIZgvuuT85zQHfTS0oAThigDdwhaY050RYiagGSfWSsLNyQn3OqQ/VwFExA23VNU40dPdHHvrMOLfSyUiRnHWLvhXkriP5HGN/zVoC0P4Ce0EMa5CHcm3wvi2CYEQq9jI0BZGFT1unwHSEUv6fnCnHQy5+Ubayu9jPsB8GPFqGY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH2PR10MB4151.namprd10.prod.outlook.com (2603:10b6:610:aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 12:55:01 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:55:01 +0000
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
 "peterx@redhat.com" <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>
Subject: Re: [PATCH V3 0/5] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
Thread-Topic: [PATCH V3 0/5] Arch agnostic ACPI changes to support vCPU
 Hotplug (on Archs like ARM)
Thread-Index: AQHbLdrrsF1QhedG0Uqd9RO3VYmaNrKnFcIA
Date: Mon, 4 Nov 2024 12:55:00 +0000
Message-ID: <C4FEC9E7-69DB-428A-A85F-30170F98814B@oracle.com>
References: <20241103102419.202225-1-salil.mehta@huawei.com>
In-Reply-To: <20241103102419.202225-1-salil.mehta@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|CH2PR10MB4151:EE_
x-ms-office365-filtering-correlation-id: fa366c82-aae0-4326-1409-08dcfccfe4ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZXV2c3lwZGw2cy81Qkg1R1lsMGdmalFZbTJFMmkxTnFvV3ZxQm1ET1dZb25E?=
 =?utf-8?B?UjB3TzJmTHRwMHFPQlRpQ3ZJZUwreFNMUkZJSE82SE1yV2NZVDhqT2pqRmp5?=
 =?utf-8?B?c1psVXZnNXhBK3o0TXZMNm5JVzBaOHcyK29tVlJqQ0xCYWxWSXJJeHlYTVFn?=
 =?utf-8?B?Q0plMHNCZ3h6Y3NNOXpzTVF1TjB4a3E2UkhOQ2huaWQvZmhpQmowZmcrYTI4?=
 =?utf-8?B?TXpiL0VZMGtCb0dzUmZZSDUzdyt1Tmt2dk1PeDcvZnRVK0pjanQwaHl6SWgy?=
 =?utf-8?B?dTdKQVFIczRtRDB6eXIyRXFWK3JBcXdwczZqTEdDVHBkWk80R2xaaUVSakVs?=
 =?utf-8?B?N2daS2hZY2tjcTZ6UWVBeGVQR0hXS3FBYytDRHM4SS85OXZWaVh4Ym4yZVpt?=
 =?utf-8?B?RVpCOWx6M1RXVytGWnhXMWNYK3JwWlUya2hrb0IvVy85UXYyWTNiUjczdHZC?=
 =?utf-8?B?R3BtL2NPSnNGZVBGZS92bzlyN01tT20wMDVacTJNdDNrVDdQbFBoaVo5Zm11?=
 =?utf-8?B?ejZBMTFTY3hob0xPS3RUNE5LazY5MTI0OUcyNHB2VmxTRDVTOW5VdG45YlIz?=
 =?utf-8?B?MElVemFBN1NJekZkNGpURXZkVlBoRFZKS3B4clllbUpNOGZhbXFRTzJSeGE0?=
 =?utf-8?B?UlV3WXNkcTdKV3lEUDMxcVp2WExIeC9mSXhmeTNnRHlUZkl6UHRCN0krbndY?=
 =?utf-8?B?MmRmWVVxVlJjYmVOWTk5eHkzOTBzQ3JKM1dJRjQ0eFVsdVppczBKcVYwaSsz?=
 =?utf-8?B?QWxubGZZZXU4aUtoQW9nSFpqb3BxcVdVMTA1Sklrci9DOWNCSG16MCtTc0lS?=
 =?utf-8?B?THNoWWpPc3gvSVRqUi92RUVIM2ZTbEhCMjlyV1FlcWw0bzJIdDdVWFBXRExP?=
 =?utf-8?B?U3Q0UmJmYXYyOVc5T2tiaGNROXI2L20xQ29ZTXNyM2wrbHhYYkRGdzdrZFM3?=
 =?utf-8?B?OHNIWHRERnEvNTBib1lYRTJWYzI4dmRsdjZ1T0ZLckIzRlI1YkFaTUtEZzhL?=
 =?utf-8?B?bDdOa2ZTTzcxbXdLbzFIdVRsT1lUcjVHZDZDWUpUdjg0VjdpUFZKQWRidGVI?=
 =?utf-8?B?NG5GYmtTb0pGckFyYlVZNjJ0VHM4QldreXhlRjRCWDVaeHpiZDhSMHFDcnYw?=
 =?utf-8?B?RTFyeHNmV1VQdFlUZTRPVmhoTkU2dEJUKzNJdTR5N3ZMajdlemxKbDlDUHRH?=
 =?utf-8?B?MUhZcGlZcjcyb1RSbUN3OGdkNFZoYzJKRmlIMzlMekttNDYxYW0vMythemJK?=
 =?utf-8?B?eEh6R2p6R1FkbDlLT09NZ2JxNWN0eHBZRTFlcUNwQW1VYzdpZnJwV3pHdDRx?=
 =?utf-8?B?Uy8ySElZN1AxQXJaSFJoS0l3T2hzNWxVc1paZVR6SHNYbTRIWDArRXRGeGdm?=
 =?utf-8?B?dWNISGkxMUdJNkV2MDdsa3JmWXNSZExYTmlicWxLZnR6NmJjSmNWSEJmc3hj?=
 =?utf-8?B?THhkb1d6bUJFby9RY0N1dmg3UVdNWHFkZ3NSK2M1dmhTOUt4OVNIOXhxTGJR?=
 =?utf-8?B?SUJHR1dUK1BBRExERExQWnlJZy90d2EvRzFTRldsdEdHTVRoQVoxTEQ0K1p5?=
 =?utf-8?B?QW9VTnE2Umk4eTVxWTBya1F1cnNmQTd3dWh5T1Nzbys1VWEzcTdvTHFZTmx2?=
 =?utf-8?B?V3hSd1dkV1hmL1RDejJpcG43WnNkdzk2bE9GN1lVTUFvd0xjVVlWQ0U1VGV5?=
 =?utf-8?B?RWFFdXlTaDF5eXVINHlMMXNxSDloZk9iWkM3UXlMclRqWWNMaDRYRjRWMGJ2?=
 =?utf-8?Q?sXN5LKHaCw7gSaej/letIfNSGCezVqW+5lDqmxP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVdwQkkwZHZoWXlCK3NTUGorUE1HMjlib21aV3A4cnhmSmtjTzE5ZTRYRjZk?=
 =?utf-8?B?MWI2RjBlaUNWZTcvamN1eE9jakZFWWZOaThtQ2c5RlBzdStIbkRnT1pab2Iw?=
 =?utf-8?B?dkplRGxvcUNWQWRvRUZ2bHhaazBOOUg1S1NWa1lCbHE0VkVBWCsvMlJpeUhs?=
 =?utf-8?B?UVdlYlZUb1BjdExPVFhJaXduLzVSMmlqZkw2bUhyUVhhclkzREQzSUNTNnMx?=
 =?utf-8?B?bEtYY1dXb3g2VlREdDlLOU1yMkFodVkxYzZubHRudGlZSkNxVVBmS3FQV3RV?=
 =?utf-8?B?T1pzUkt4ZFo0aFM1dHZCUnVPd0IrdmRhc0xhVWNGZjlZOXFLOGZ5SjRDTHlq?=
 =?utf-8?B?SnV1Uk5qR2ZKang1UG0zV1A4cG9JckRWNTFydjRVUityaXRVWXlGQ1FLUWFa?=
 =?utf-8?B?NU1GYk4weHFsZEUxQWw5bGVDRjdXdGRjc2Q1ZGliTHk4NURjVVBRNUZ3WE9k?=
 =?utf-8?B?Ny9DTkpRU3d4UE9lb1NFNk1POWdQclAzay9NaUZyd1p5RXQwWkl6dWx1THpp?=
 =?utf-8?B?bUt6KzFibm9vSU9QSWprN0M5MjNtMXN6RnVCdkx2TkRxZ29NZXFvWDlJNEhU?=
 =?utf-8?B?TkFObzIvZTJZcGpsWGdwNlR3dzJRWUMvUUVNOWlmWG5MYkRLcXNheUZZanBh?=
 =?utf-8?B?Z1Z5WnU4aEtveFdBUmZVUlBtdzZrQ0JFdHR3SHIwY2FUMEgwZndjWm9vVUdN?=
 =?utf-8?B?SG9lVnRHeGNwNGFjYlFIa2RURW5qaVk2M1Q5bFpZT0dHL0NTd05selJGY3Nt?=
 =?utf-8?B?NGFua3dSRktSVmxCNVgxcHBaejhtUWJEZllwOHl2aXo5MU5weHNGZ2VLWFVF?=
 =?utf-8?B?dDdkdXk0T3pEQ1FhSkFLcC9UYTdxeDNqR0VZVFRES3htL1hWWkQ1eE5qemxq?=
 =?utf-8?B?aXBrKzhDa0pGTXBTUzV6V3ZITlVVMGxCQmhpVzVjMFBpWnlMMk1odXVXSmVG?=
 =?utf-8?B?TVp4d3BQVE5CUW9GUy9qM0thdHRTTis3RzBpSXFZSWwzejE3azlaTzJRazQy?=
 =?utf-8?B?OStRRTVqZWV4QjN2SDFRY1NoR0pXaXJPNC8xVFYzZDdqSHhQMEZjVHN3QlVu?=
 =?utf-8?B?Y2swR0hRVnJZM1Y3VDZVLytYaEh6eWJQR0VNT1VFTWc5cjdwRlpoZ1VKeVFX?=
 =?utf-8?B?VjFvNGhpM1FxRjNXaDlQTXZZd01LTmErb2pTNlF0L0VMTHdBY3FoWkEydS9K?=
 =?utf-8?B?dHMzaGlsMGN4aEl4ajNLbEZJcXFBQjkrb3oxbWVEUFpKeTJGZVA2NVN1RHN1?=
 =?utf-8?B?b1FsYjQ5QjUxbUNsTVliNjAxVldFcE92ODNJMDVNenZnMmpTaEZpYmVvS3Y2?=
 =?utf-8?B?blNobUhoeVZlSWdFb2U2LzBOcmtBUVJBWjlZOU1QWGY3NU9GRUZVR0pUVnNs?=
 =?utf-8?B?WHZ4bHZoRWpheHg5VWFZckp5V0taV2Vpcm5NQm5wTSs0b3R1aEFiNWo4aG5N?=
 =?utf-8?B?OWlBTTQxbnRtak1sZHVHUW9vbDE3bEN6ZEhnU1FzdEtRVjgwU3Jvcy9PYU1N?=
 =?utf-8?B?eUZaUzZ5UkZybHB6R1dvdmdHVW9vaGgzU1IvSnQrb0I2RExiV1pNUDk0Mndp?=
 =?utf-8?B?QnNFTDNPM2dsU1FDMS9OVDBIVVMzVWRpREgxOEdBQlJpd1lCNStxdnFSZ2Qw?=
 =?utf-8?B?REJEM3l6d1Q1Y1d6MGVQUVF4MG5pUmlWaUVkR0J5dVYrZ2FIeFp0N2hHc3lX?=
 =?utf-8?B?YjVvWGhncmM1WTczZnora1RHbVZOSlZSZDJySWJQUFYydUhUVzdoczVuODFC?=
 =?utf-8?B?M25tS2g5TXpZS0NNNXpxYzBySFBQb3FxeFF2dkZMbGZSaE9tMkMvVVl4VXVi?=
 =?utf-8?B?dlhDdksvdzd6OWJZRmFtbzl1emNHSklmdnc3ajk3UDdmK2Y4Z2IvWmRXV0RW?=
 =?utf-8?B?YnlQZFMvSEpUWUNUS2JVZVRXWTlKOWRPa2ZsL3gxb2hFdVorMTlra3BIOG9C?=
 =?utf-8?B?S1RWb1AyMTdOMEdHKzlUMWVNczdvN2VHRWM2K1dncHVDc2UxTks2YnZ6alRJ?=
 =?utf-8?B?NzhqU3d3NGVDQkRYVmtGcE5JZzBhY3YxWGZvS3VYS1ZaVHdKSmxLNk5zRVU2?=
 =?utf-8?B?eVV6OVhjRzl6bGMwYTVJTThOY3JrOHNLTTVpSy9xY05EVkxHVXltNDNGQU9o?=
 =?utf-8?B?ZDUrUGFKRUFhZjFhQnp5UVYycHZkNFIrU0xOdzduNWhNTnduaDdvR1J0WU1C?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EE64722031689428F6DE120DE0509BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N+DaD/dnIfKEaW8gtik80Z5+a6eGjJQU7tFHl/jonQvcIKtHeimXbOGwtK9YlRK+CofytPl/FZVPOKf0/pH7i92WZo/f10gyD5Wsb01+w4XVk+ZgM0slew8byX4GjMsF56P0Cq+B6ViypS+Jhb8saoTIM05b/J2NMmiqF+mpyXzmq86Y++d1bOiupJDSlAeSlc5A/jep7PnTBbrXKDmBMIGD6k/xp+WRw+2SsDcZ3zKx2k6LrORGTxADqDK2z6P2MyKkvm3h6dObJfyqhMbQHzlWGKg7TvoA+OC+OvVS5ZWUaqDH3cMSyHVkThKlOHXFQaTOdaeedxRLbcKdARe3loNwV+YVrvBpC3zR88qerxsAHrt/CLA/dFUVACebdvXyyDzJvZLxXiO6FISjyMxpFlSWsq1COHMivaEumL9jhYT4C464bmCuH3P0HIQfK4P26y/h3KFTJ4oXlaj+M2RwmnEUhWHctaJ0LMmjElzQEM1BIIyKCcoI+k2RAuVKnSLJIfwJWV7Uc7cvJNzfZQMmLJCFXsWJ6PqbsbSTxqzybtcapv8sxsGSZbGqm6BkINtQB3xvIWJ1YYkXcSnXtGwbDYOA8RkkjEr7eNgzE6Vvzs8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa366c82-aae0-4326-1409-08dcfccfe4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 12:55:00.9689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMHjWkLPp16sCdaQjPT8Qll1VFpESFxIaWs1tof/u1Kl79AG+N+f1bHza6xGQExMlG5nuNRRar3ypns7nxBP1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_10,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040113
X-Proofpoint-ORIG-GUID: gxobJ88aogIH71OchhrIVlOQL2YC8Yyc
X-Proofpoint-GUID: gxobJ88aogIH71OchhrIVlOQL2YC8Yyc
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

SGkgU2FsaWwsDQoNCj4gT24gMyBOb3YgMjAyNCwgYXQgMDk6MjQsIFNhbGlsIE1laHRhIHZpYSA8
cWVtdS1kZXZlbEBub25nbnUub3JnPiB3cm90ZToNCj4gDQo+IENoYW5nZSBMb2cNCj4gPT09PT09
PT09PQ0KPiANCj4gUGF0Y2ggVjIgLT4gVjM6DQo+IDEuIEFkZHJlc3NlZCBsZWZ0IG92ZXIgaXNz
dWVzIG9mIHg4NiBzdWdnZXN0ZWQgYnkgSWdvciBNYW1tZWRvdiAoUmVkaGF0KToNCj4gICAtIFJl
bW92ZWQgdGhlIGBBQ1BJQ1BVc3RhdHVzOjppc19lbmFibGVkYCBTdGF0ZSBhcyB3ZWxsIGFzIGl0
IHdhcw0KPiAgICAgYnJlYWtpbmcgdGhlIHg4NiBtaWdyYXRpb24NCj4gICAtIEFib3ZlIGlzIGlu
IGFkZGl0aW9uIHRvIGBpc19wcmVzZW50YCBzdGF0ZSB3aGljaCB3YXMgcmVtb3ZlZCBpbiBWMg0K
PiAgIC0gRHJvcHBlZCBbUEFUQ0ggMS82XSBvZiBWMiBwYXRjaC1zZXQgDQo+ICAgLSBJbnRyb2R1
Y2VkIGhvb2tzIGBDUFVDbGFzczo6Y3B1X3twZXJzaXN0ZW5jZSxlbmFibGVkfV9zdGF0dXMoKWAN
Cj4gMi4gRml4ZWQgdGhlIGFjY2lkZW50YWwgQ1BVcyBBTUwgYnJlYWsgb2YgeDg2IGluIFYyIChz
b3JyeSBmb3IgdGhpcyEpLg0KPiANCj4gUGF0Y2ggVjEgLT4gVjI6DQo+IDEuIEFkZHJlc3NlZCBJ
Z29yIE1hbW1lZG92J3MgKFJlZGhhdCkgcmFpc2VkIGlzc3VlczoNCj4gICAtIFJlbW92ZWQgYEFD
UElDUFVzdGF0dXM6OmlzX3ByZXNlbnRgIFN0YXRlIGFuZCBpdHMgaGFuZGxpbmcgaW4gdGhlDQo+
ICAgICBBQ1BJIEFQVXMgQU1MIGNvZGUgYW5kIG5vdyBhbGwgUU9NIHZDUFVzIGFyZSBwcmVzZW50
Lg0KPiAgIC0gRHJvcHBlZCB0aGUgY29uY2VwdCBvZiBgYWNwaV9wZXJzaXN0ZW50YCBiZWNhdXNl
IG5vdyBRT00gdkNQVXMNCj4gICAgIHN0YXRlcyBhbmQgdGhlIEFDUEkgdkNQVSBzdGF0ZXMgYXJl
IGNvbnNpc3RlbnQuDQo+ICAgLSBRT00gdkNQVSBvYmplY3RzIGFyZSBhbHdheXMgcHJlc2VudCBu
b3cgKGFjY29tcGFueWluZyBSRkMgVjYpDQo+ICAgLSBBZGRlZCAubmVlZGVkKCkgaG9vayB0byB0
aGUgR0VEIFZNU0QgdG9jb25kaXRpb25hbGx5IG1pZ3JhdGUgdGhlDQo+ICAgICBBQ1BJIENQVSBo
b3RwbHVnIHN0YXRlIGF0IHRoZSBzb3VyY2UgVk0uDQo+IDIuIEFkZHJlc3NlZCBaaGFvIExpdSdz
IChJbnRlbCkgcmVwb3J0ZWQgeDg2IERTRFQgVGFibGUgYmlvcy1hY3BpLXRlc3QgZmFpbHVyZSAN
Cj4gMy4gSW5jb3Jwb3JhdGVkIEd1c3Rhdm8gUm9tZXJvJ3MgY29tbWVudHMgYW5kIGFkZGVkIGhp
cyBUYWcgdG8gW1BhdGNoZXMgMSwyLDRdDQo+IDQuIEFkZHJlc3NlZCBHYXZpbiBTaGFuJ3MgY29t
bWVudCB0byByZWR1Y2UgdGhlIGlubGluZSBjb2RlIGNvbW1lbnRzDQo+ICAgd2hlcmV2ZXIgcG9z
c2libGUuDQo+IA0KPiANCj4gQnJpZWYgUmVjYWxsDQo+ID09PT09PT09PT09PQ0KPiBXaXRoIHRo
ZSBhZHZlbnQgb2YgbXVsdGktY29yZSBTb0NzLCB0aGUgY29uY2VwdCBvZiBDUFUtbGV2ZWwgaG90
cGx1Z2dpbmcNCj4gaGFzIGJlY29tZSBsZXNzIGRpc3RpbmN0LCBvZnRlbiBmdW5jdGlvbmluZyBh
cyBhIHBvd2VyIG9uL29mZiBldmVudA0KPiByYXRoZXIgdGhhbiBhIGZ1bGwgaG90cGx1ZyBvcGVy
YXRpb24uIEhvd2V2ZXIsIGhvdHBsdWcgc3VwcG9ydCBhdCB0aGUNCj4gZGllL05VTUEvc29ja2V0
IGxldmVsIHJlbWFpbnMgbWVhbmluZ2Z1bCBhbmQgaXMgYXJjaGl0ZWN0dXJlLXNwZWNpZmljLg0K
PiBWaXJ0dWFsIENQVSBob3RwbHVnIGNhbiBiZSBzdXBwb3J0ZWQgcmVnYXJkbGVzcyBvZiBhcmNo
aXRlY3R1cmFsIHN1cHBvcnQNCj4gZm9yIHBoeXNpY2FsIENQVSBob3RwbHVnLCBhcyBpdCBzZXJ2
ZXMgcmVzb3VyY2UgbWFuYWdlbWVudCBuZWVkc+KAlHN1Y2ggYXMNCj4gZHluYW1pY2FsbHkgc2Nh
bGluZyBWTSBjb21wdXRlIGNhcGFjaXR5IGJhc2VkIG9uIGRlbWFuZCBvciBTTEFzLA0KPiBvcHRp
bWl6aW5nIGJvb3QgdGltZXMsIG9yIHJlZHVjaW5nIG1lbW9yeSBmb290cHJpbnQuIEFsdGhvdWdo
LCBpdHMNCj4gZGVzaW5nIG11c3QgYmUgc2NhbGFibGUgYW5kIG11c3QgY28tZXhpc3Qgd2l0aCBm
dXR1cmUgZGllL05VTUEvc29ja2V0DQo+IGxldmVsIGhvdHBsdWcgZmVhdHVyZXMuDQo+IA0KPiAN
Cj4gTW90aXZhdGlvbiBmb3IgdGhpcyBwYXRjaC1zZXQNCj4gPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gSW4gYXJjaGl0ZWN0dXJlcyB0aGF0IHN1cHBvcnQgdkNQVSBob3RwbHVnLCBm
aXJtd2FyZSBvciB0aGUgVk1NL1FFTVUNCj4gdHlwaWNhbGx5IHJlZmxlY3RzIHZDUFUgc3RhdHVz
IGNoYW5nZXMgdG8gdGhlIE9TIHZpYSB0aGUgQUNQSQ0KPiBgX1NUQS5QcmVzZW50YCBiaXQuIEhv
d2V2ZXIsIGNlcnRhaW4gQ1BVIGFyY2hpdGVjdHVyZXMgcHJvaGliaXQgWzFdDQo+IG1vZGlmaWNh
dGlvbnMgdG8gQ1BVIHByZXNlbmNlIGFmdGVyIGtlcm5lbCBib290LiBUaGlzIHJlc3RyaWN0aW9u
IFsyXVszXQ0KPiBjb3VsZCBiZSBkdWUgdG8gY2xvc2VseSBpbnRlZ3JhdGVkIHBlci1DUFUgY29t
cG9uZW50c+KAlGxpa2UgaW50ZXJydXB0DQo+IGNvbnRyb2xsZXJzIG9yIG90aGVyIGZlYXR1cmVz
4oCUIHRoYXQgbWF5IG5vdCBzdXBwb3J0IHJlY29uZmlndXJhdGlvbg0KPiBwb3N0LWJvb3QgYW5k
IGFyZSBvZnRlbiBpbiBhbiBgYWx3YXlzLW9uYCBwb3dlciBkb21haW4uIENvbnNlcXVlbnRseSwN
Cj4gc3BlY2lmaWNhdGlvbnMgZm9yIHRoZXNlIGFyY2hpdGVjdHVyZXMgcmVxdWlyZSBhbGwgQ1BV
cyB0byByZW1haW4NCj4gcHJlc2VudCBpLmUuYF9TVEEuUHJlc2VudD1UcnVlYCwgb25jZSB0aGUg
c3lzdGVtIGlzIGluaXRpYWxpemVkLg0KPiANCj4gVG8gYmUgYWJsZSB0byBzdXBwb3J0IHZDUFUg
SG90cGx1ZyBmZWF0dXJlLCBhcyBhIHdvcmthcm91bmQgdG8gdGhlIGFib3ZlDQo+IGxpbWl0YXRp
b24sICBBQ1BJIG1ldGhvZCBgX1NUQS5FbmFibGVkYCBCaXQgY291bGQgYmUgdXNlZCB0byByZWZs
ZWN0IHRoZQ0KPiBwbHVnZ2VkIGFuZCB1bnBsdWdnZWQgc3RhdGVzIG9mIHRoZSBRT00gdkNQVXMu
DQo+IA0KPiBUaGlzIHBhdGNoIHNldCBpbnRyb2R1Y2VzIHRoZSBmb2xsb3dpbmcgY2hhbmdlczoN
Cj4gDQo+IDEuIEludHJvZHVjZXNgQ1BVQ2xhc3M6OmNwdV97cGVyc2lzdGVuY2UsZW5hYmxlZH1f
c3RhdHVzYCBob29rczogVG8NCj4gICBjaGVjayBpZiB0aGUgQ1BVIHNob3VsZCBhbHdheXMgcmVt
YWluIHByZXNlbnQgZXZlbiBhZnRlciB1bnBsdWcNCj4gICBvcGVyYXRpb24gYW5kIHRvIGZldGNo
IHRoZSB2Q1BVIGBlbmFibGVkYCBzdGF0dXMgaW4gY2FzZSBpdCBpcw0KPiAgIHByZXNlbnQuIExh
dGVyIGlzIHVzZWQgaW4gY29udGV4dCB3aGVuIEd1ZXN0IEtlcm5lbCBldmFsdWF0ZXMNCj4gICBB
Q1BJIGBfU1RBYCBtZXRob2QgYW5kIHRoZSBzdGF0dXMgaXMgcmVhZCBmcm9tIHRoZSBmbGFncyBz
dG9yZWQNCj4gICBpbiB0aGUgUWVtdSBBQ1BJIGNvZGUuDQo+IA0KPiAyLiBTdXBwb3J0IGZvciBN
aWdyYXRpbmcgQUNQSSBDUFUgSG90cGx1ZyBTdGF0ZTogRmFjaWxpdGF0ZXMgdGhlDQo+ICAgbWln
cmF0aW9uIG9mIHRoZSBBQ1BJIENQVSBob3RwbHVnIHN0YXRlIGluIFZNU0QgYnkgY29uZGl0b25h
bGx5DQo+ICAgbWFraW5nIGl0IHBhcnQgb2YgdGhlIEdFRCBWTVNELg0KPiANCj4gMy4gVXBkYXRl
cyB0aGUgUXRlc3QgYmlvcy1hY3BpLXRhYmxlcy9EU0RUIGJpbmFyaWVzIGZvciB4ODYve3BjLHEz
NX0NCj4gDQo+IFRoaXMgcGF0Y2ggc2V0IGlzIGRlc2lnbmVkIHRvIHdvcmsgaW5kZXBlbmRlbnRs
eSBhbmQgaXMgbWVhbnQgdG8gZW5zdXJlDQo+IGNvbXBhdGliaWxpdHkgd2l0aCBleGlzdGluZyBo
b3RwbHVnIHN1cHBvcnQgYWNyb3NzIGRpZmZlcmVudA0KPiBhcmNoaXRlY3R1cmVzLiBUaGlzIHBh
dGNoLXNldCBoYXMgYmVlbiB0ZXN0ZWQgYWxvbmdzaWRlIEFSTS1zcGVjaWZpYw0KPiB2Q1BVIGhv
dHBsdWcgY2hhbmdlcyAoaW5jbHVkZWQgaW4gdGhlIHVwY29taW5nIFJGQyBWNiBbNF0pLCBhbmQN
Cj4gaG90KHVuKXBsdWcgZnVuY3Rpb25hbGl0aWVzIHBlcmZvcm1lZCBhcyBleHBlY3RlZCB3aGlj
aCBjb25jZXJucyB0aGlzDQo+IHBhdGNoLXNldC4gUGxlYXNlIGhhdmUgYSBsb29rLg0KPiANCg0K
Rm9yIGFybTY0Og0KSeKAmXZlIHJhbiBtYWtlIGNoZWNrIGFuZCBiaW9zLXRhYmxlcy10ZXN0IHBh
c3NlZCBzdWNjZXNzZnVsbHkgYW5kIGdvdCAwIGZhaWxlZCB0ZXN0cy4NCkFmdGVyIGJvb3QgdGhl
IG51bWJlciBvZiB2Y3B1cyBtYXRjaGVkIHdoYXQgd2FzIGluaXRpYWxseSByZXF1ZXN0ZWQgdmlh
IC1zbXAgY3B1cy4NCknigJl2ZSBhbHNvIHRlc3RlZCB0aGlzIHBhdGNoc2V0IGFsb25nc2lkZSB0
aGUgdXBjb21pbmcgUkZDIFY2LXJjNSBhbmQgYm9vdGluZywgYmFzaWMgaG90LXBsdWdnaW5nL3Vu
cGx1Z2dpbmcgb2YgdkNQVXMgYW5kIGxpdmUgbWlncmF0aW9uIHdpdGggYW4gYXN5bW1ldHJpY2Fs
IG51bWJlciBvZiBob3RwbHVnZ2VkIHZDUFVzIGxvb2tlZCBnb29kIHRvIG1lLg0KDQpQbGVhc2Us
IGZlZWwgZnJlZSB0byBhZGQ6DQpUZXN0ZWQtYnk6IE1pZ3VlbCBMdWlzIDxtaWd1ZWwubHVpc0Bv
cmFjbGUuY29tPg0KDQpUaGFuayB5b3UuDQpNaWd1ZWwNCg0KPiBUaGFuayB5b3UhDQo+IA0KPiAN
Cj4gUmVwb3NpdG9yeSBvZiB0aGlzIHBhdGNoLXNldA0KPiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09DQo+ICgqKSBMYXRlc3QgQXJjaGl0ZWN0dXJlIEFnbm9zdGljIEFDUEkgY2hhbmdlcyBw
YXRjaC1zZXQ6DQo+ICAgIFJlcG86IGh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11
LmdpdCAgIHZpcnQtY3B1aHAtYXJtdjgvcmZjLXY2LmFyY2guYWdub3N0aWMuYWNwaS52Mw0KPiAg
ICBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vc2FsaWwtbWVodGEvcWVtdS9jb21taXRzL3ZpcnQt
Y3B1aHAtYXJtdjgvcmZjLXY2LmFyY2guYWdub3N0aWMuYWNwaS52Mw0KPiAoKikgV29ya3Mgd2l0
aCB1cGNvbWluZyBBUk0gYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBhdGNoLXNldCBSRkMgVjYtcmM1
IFs0XQ0KPiANCj4gDQo+IFJlZmVyZW5jZXMNCj4gPT09PT09PT09PQ0KPiBbMV0gQ2hlY2sgY29t
bWVudCA1IGluIHRoZSBidWd6aWxsYSBlbnRyeQ0KPiAgICBMaW5rOiBodHRwczovL2J1Z3ppbGxh
LnRpYW5vY29yZS5vcmcvc2hvd19idWcuY2dpP2lkPTQ0ODEjYzUNCj4gWzJdIEtWTUZvcnVtIDIw
MjMgUHJlc2VudGF0aW9uOiBDaGFsbGVuZ2VzIFJldmlzaXRlZCBpbiBTdXBwb3J0aW5nIFZpcnQg
Q1BVIEhvdHBsdWcgb24NCj4gICAgYXJjaGl0ZWN0dXJlcyB0aGF0IGRvbuKAmXQgU3VwcG9ydCBD
UFUgSG90cGx1ZyAobGlrZSBBUk02NCkNCj4gICAgYS4gS2VybmVsIExpbms6IGh0dHBzOi8va3Zt
LWZvcnVtLnFlbXUub3JnLzIwMjMvS1ZNLWZvcnVtLWNwdS1ob3RwbHVnXzdPSjFZeUoucGRmDQo+
ICAgIGIuIFFlbXUgTGluazogIGh0dHBzOi8va3ZtLWZvcnVtLnFlbXUub3JnLzIwMjMvQ2hhbGxl
bmdlc19SZXZpc2l0ZWRfaW5fU3VwcG9ydGluZ19WaXJ0X0NQVV9Ib3RwbHVnXy1fX2lpMGlOYjMu
cGRmDQo+IFszXSBLVk1Gb3J1bSAyMDIwIFByZXNlbnRhdGlvbjogQ2hhbGxlbmdlcyBpbiBTdXBw
b3J0aW5nIFZpcnR1YWwgQ1BVIEhvdHBsdWcgb24NCj4gICAgU29DIEJhc2VkIFN5c3RlbXMgKGxp
a2UgQVJNNjQpDQo+ICAgIExpbms6IGh0dHBzOi8va3ZtZm9ydW0yMDIwLnNjaGVkLmNvbS9ldmVu
dC9lRTRtDQo+IFs0XSBVcGNvbWluZyBSRkMgVjYsIFN1cHBvcnQgb2YgVmlydHVhbCBDUFUgSG90
cGx1ZyBmb3IgQVJNdjggQXJjaA0KPiAgICBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vc2FsaWwt
bWVodGEvcWVtdS9jb21taXRzL3ZpcnQtY3B1aHAtYXJtdjgvcmZjLXY2LXJjNQ0KPiANCj4gU2Fs
aWwgTWVodGEgKDUpOg0KPiAgaHcvYWNwaTogTWFrZSBDUFVzIEFDUEkgYHByZXNlbmNlYCBjb25k
aXRpb25hbCBkdXJpbmcgdkNQVSBob3QtdW5wbHVnDQo+ICBxdGVzdDogYWxsb3cgQUNQSSBEU0RU
IFRhYmxlIGNoYW5nZXMNCj4gIGh3L2FjcGk6IFVwZGF0ZSBBQ1BJIGBfU1RBYCBtZXRob2Qgd2l0
aCBRT00gdkNQVSBBQ1BJIEhvdHBsdWcgc3RhdGVzDQo+ICB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxl
cy10ZXN0OiBVcGRhdGUgRFNEVCBnb2xkZW4gbWFzdGVycyBmb3INCj4gICAgeDg2L3twYyxxMzV9
DQo+ICBody9hY3BpOiBVcGRhdGUgR0VEIHdpdGggdkNQVSBIb3RwbHVnIFZNU0QgZm9yIG1pZ3Jh
dGlvbg0KPiANCj4gaHcvYWNwaS9jcHUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgIDUzICsrKysrKysrKysrKysrKystLQ0KPiBody9hY3BpL2dlbmVyaWNfZXZlbnRfZGV2aWNl
LmMgICAgICAgICAgICAgICAgfCAgMTkgKysrKysrKw0KPiBpbmNsdWRlL2h3L2NvcmUvY3B1Lmgg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3Bj
L0RTRFQgICAgICAgICAgICAgICAgICAgfCBCaW4gODUyNyAtPiA4NTYxIGJ5dGVzDQo+IHRlc3Rz
L2RhdGEvYWNwaS94ODYvcGMvRFNEVC5hY3BpZXJzdCAgICAgICAgICB8IEJpbiA4NDM4IC0+IDg0
NzIgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9wYy9EU0RULmFjcGlobWF0ICAgICAgICAg
IHwgQmluIDk4NTIgLT4gOTg4NiBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3BjL0RTRFQu
YnJpZGdlICAgICAgICAgICAgfCBCaW4gMTUzOTggLT4gMTU0MzIgYnl0ZXMNCj4gdGVzdHMvZGF0
YS9hY3BpL3g4Ni9wYy9EU0RULmNwaHAgICAgICAgICAgICAgIHwgQmluIDg5OTEgLT4gOTAyNSBi
eXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3BjL0RTRFQuZGltbXB4bSAgICAgICAgICAgfCBC
aW4gMTAxODEgLT4gMTAyMTUgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9wYy9EU0RULmhw
YnJpZGdlICAgICAgICAgIHwgQmluIDg0NzggLT4gODUxMiBieXRlcw0KPiB0ZXN0cy9kYXRhL2Fj
cGkveDg2L3BjL0RTRFQuaHBicnJvb3QgICAgICAgICAgfCBCaW4gNTAzNCAtPiA1MDY4IGJ5dGVz
DQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcGMvRFNEVC5pcG1pa2NzICAgICAgICAgICB8IEJpbiA4
NTk5IC0+IDg2MzMgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9wYy9EU0RULm1lbWhwICAg
ICAgICAgICAgIHwgQmluIDk4ODYgLT4gOTkyMCBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2
L3BjL0RTRFQubm9ocGV0ICAgICAgICAgICAgfCBCaW4gODM4NSAtPiA4NDE5IGJ5dGVzDQo+IHRl
c3RzL2RhdGEvYWNwaS94ODYvcGMvRFNEVC5udW1hbWVtICAgICAgICAgICB8IEJpbiA4NTMzIC0+
IDg1NjcgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9wYy9EU0RULnJvb3RocCAgICAgICAg
ICAgIHwgQmluIDEyMzIwIC0+IDEyMzU0IGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1
L0RTRFQgICAgICAgICAgICAgICAgICB8IEJpbiA4MzU1IC0+IDgzODkgYnl0ZXMNCj4gdGVzdHMv
ZGF0YS9hY3BpL3g4Ni9xMzUvRFNEVC5hY3BpZXJzdCAgICAgICAgIHwgQmluIDgzNzIgLT4gODQw
NiBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULmFjcGlobWF0ICAgICAgICAg
fCBCaW4gOTY4MCAtPiA5NzE0IGJ5dGVzDQo+IC4uLi9hY3BpL3g4Ni9xMzUvRFNEVC5hY3BpaG1h
dC1ub2luaXRpYXRvciAgICB8IEJpbiA4NjM0IC0+IDg2NjggYnl0ZXMNCj4gdGVzdHMvZGF0YS9h
Y3BpL3g4Ni9xMzUvRFNEVC5hcHBsZXNtYyAgICAgICAgIHwgQmluIDg0MDEgLT4gODQzNSBieXRl
cw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULmJyaWRnZSAgICAgICAgICAgfCBCaW4g
MTE5NjggLT4gMTIwMDIgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9xMzUvRFNEVC5jb3Jl
LWNvdW50ICAgICAgIHwgQmluIDEyOTEzIC0+IDEyOTQ3IGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNw
aS94ODYvcTM1L0RTRFQuY29yZS1jb3VudDIgICAgICB8IEJpbiAzMzc3MCAtPiAzMzgwNCBieXRl
cw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULmNwaHAgICAgICAgICAgICAgfCBCaW4g
ODgxOSAtPiA4ODUzIGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RTRFQuY3hsICAg
ICAgICAgICAgICB8IEJpbiAxMzE0OCAtPiAxMzE4MiBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkv
eDg2L3EzNS9EU0RULmRpbW1weG0gICAgICAgICAgfCBCaW4gMTAwMDkgLT4gMTAwNDMgYnl0ZXMN
Cj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9xMzUvRFNEVC5pcG1pYnQgICAgICAgICAgIHwgQmluIDg0
MzAgLT4gODQ2NCBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULmlwbWlzbWJ1
cyAgICAgICAgfCBCaW4gODQ0MyAtPiA4NDc3IGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNwaS94ODYv
cTM1L0RTRFQuaXZycyAgICAgICAgICAgICB8IEJpbiA4MzcyIC0+IDg0MDYgYnl0ZXMNCj4gdGVz
dHMvZGF0YS9hY3BpL3g4Ni9xMzUvRFNEVC5tZW1ocCAgICAgICAgICAgIHwgQmluIDk3MTQgLT4g
OTc0OCBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULm1taW82NCAgICAgICAg
ICAgfCBCaW4gOTQ4NSAtPiA5NTE5IGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RT
RFQubXVsdGktYnJpZGdlICAgICB8IEJpbiAxMzIwOCAtPiAxMzI0MiBieXRlcw0KPiB0ZXN0cy9k
YXRhL2FjcGkveDg2L3EzNS9EU0RULm5vYWNwaWhwICAgICAgICAgfCBCaW4gODIzNSAtPiA4MjY5
IGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RTRFQubm9ocGV0ICAgICAgICAgICB8
IEJpbiA4MjEzIC0+IDgyNDcgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3BpL3g4Ni9xMzUvRFNEVC5u
dW1hbWVtICAgICAgICAgIHwgQmluIDgzNjEgLT4gODM5NSBieXRlcw0KPiB0ZXN0cy9kYXRhL2Fj
cGkveDg2L3EzNS9EU0RULnB2cGFuaWMtaXNhICAgICAgfCBCaW4gODQ1NiAtPiA4NDkwIGJ5dGVz
DQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RTRFQudGhyZWFkLWNvdW50ICAgICB8IEJpbiAx
MjkxMyAtPiAxMjk0NyBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULnRocmVh
ZC1jb3VudDIgICAgfCBCaW4gMzM3NzAgLT4gMzM4MDQgYnl0ZXMNCj4gdGVzdHMvZGF0YS9hY3Bp
L3g4Ni9xMzUvRFNEVC50aXMudHBtMTIgICAgICAgIHwgQmluIDg5NjEgLT4gODk5NSBieXRlcw0K
PiB0ZXN0cy9kYXRhL2FjcGkveDg2L3EzNS9EU0RULnRpcy50cG0yICAgICAgICAgfCBCaW4gODk4
NyAtPiA5MDIxIGJ5dGVzDQo+IHRlc3RzL2RhdGEvYWNwaS94ODYvcTM1L0RTRFQudHlwZTQtY291
bnQgICAgICB8IEJpbiAxODU4OSAtPiAxODYyMyBieXRlcw0KPiB0ZXN0cy9kYXRhL2FjcGkveDg2
L3EzNS9EU0RULnZpb3QgICAgICAgICAgICAgfCBCaW4gMTQ2MTUgLT4gMTQ2NDkgYnl0ZXMNCj4g
dGVzdHMvZGF0YS9hY3BpL3g4Ni9xMzUvRFNEVC54YXBpYyAgICAgICAgICAgIHwgQmluIDM1NzE4
IC0+IDM1NzUyIGJ5dGVzDQo+IDQ0IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KPiANCg0K

