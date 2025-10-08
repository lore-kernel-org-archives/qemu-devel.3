Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB6CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Wh0-0006RV-Nm; Wed, 08 Oct 2025 12:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6Wgh-0006Kp-3m; Wed, 08 Oct 2025 12:06:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6WgZ-0003Tr-EW; Wed, 08 Oct 2025 12:06:45 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598CNQiH012701;
 Wed, 8 Oct 2025 16:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7ZLo7HhfxC/OqtpUQhfiwxt8rlIS89N6KRAcDmJ5xlA=; b=
 h9wh3ur0L67IFhmi7e9wBNJ4BeNYirC6xURRGmR1ZK+ko7LOvcoWZFV4QcA+DYYJ
 Z2Y14/37sD9VYxN3PIsQIOnhCgo2iOg8wD9gjb5nJK5QeUG9W+8uBZ1fQhXtK+R2
 DwaPVc0lm8CoYdrcxi+dJpIzDnA9ZT8BsFTmpWLhj3s8Elj8vS8eN34wVCKS9sNn
 VFfju/AzZm4WPrX1BniiiCrHtR31ezolV5fgoSlNakyf7dOeFj/j8gWH6+PJrK1a
 NFaxD+1pwmh3dDgfcqSVsOqsGFBoF0JWkwruXKo5nImksgjsTcLEPSSz+u4hFS7w
 oU2o1B4mz1pGV4ldHh2Jnw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nkq28ysb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Oct 2025 16:04:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 598EZUqP004956; Wed, 8 Oct 2025 16:04:35 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011069.outbound.protection.outlook.com
 [40.93.194.69])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49np5y4420-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 08 Oct 2025 16:04:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qs4jIvs6dvABdg2FFH10KJiHstMMIHcG742m/GMH+hBKbKKSnZI5/kkDD6VLg2zCneUy36v4fobinLuhx9XfN+CDHEf3Ucth23DFyoGCL6bPNe5nTlul4HzwCltWoUQ8wQjmKjEq6Y0AWSDHgpda1DSuL6lzDHTtZyUKVaEsZG5KTsjXVtM4P5/OBrUH9Ir7c/9wQetCYS8IwrgAMJeiHgzm1v2MD2I+mO80tiVLl6ylXpQkyHAIqEOK3qKEQJTV0AP295WZK4tuX4ezs9v71X+WyLg9igjPyy73JgDLtTlrgtYyNaIjSId+qIkpJQ1LtldGn3tzZjKYD9AIa+Y+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZLo7HhfxC/OqtpUQhfiwxt8rlIS89N6KRAcDmJ5xlA=;
 b=Vr5AuuWltU0y06BtTD2YeR9QjNZ8+FpOs0V5sUDWSietDVN3dYUkEY2tORLmP60GBZT5nvUUzd5Kzeudk81shMr8GEmG5yMlU/w1JyclZil2pxrSFPBsZYvhKVRou80zQ36uz9bJkMNgFgFEFPq5hhPTVXi/9qeInFqyJXdNgs9IJj8I0avCjSXzSl+QiwE/oZQ3DpfxgWsxgWNIyhhlnI50DuOMvAtPQ5c6Uu1M/gZbdCA+jaYrcDnjT+8HIC708wEMOFUaKqfyALolS5FzxgimCfMJfCwoJCpAgK4oxefkuFhjv/ecAYgURaJOT/zzNkITK+q8H89Qdgm+mI0hSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZLo7HhfxC/OqtpUQhfiwxt8rlIS89N6KRAcDmJ5xlA=;
 b=svFjA1ssCM+cbmlOZjmKeY11pjWsRJUKzcNxpCh2lwUb09Hsw06lWr65NecUo7ZLPx0CR1yk6fw7q23qrKquW5sEvhFutwBujT4vTFVZA+y/a2EZPrp3DInZkC23wnM7yLga/CBUKCUXUjOJONsDji4kOYpdlaKLWx/uS5AP9JE=
Received: from PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 by DS4PPF26D9E501B.namprd10.prod.outlook.com (2603:10b6:f:fc00::d11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.21; Wed, 8 Oct
 2025 16:04:11 +0000
Received: from PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7]) by PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7%5]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 16:04:11 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Salil Mehta <salil.mehta@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "gustavo.romero@linaro.org"
 <gustavo.romero@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "gankulkarni@os.amperecomputing.com"
 <gankulkarni@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
Thread-Topic: [PATCH RFC V6 00/24] Support of Virtual CPU Hotplug-like Feature
 for ARMv8+ Arch
Thread-Index: AQHcMltnamnUQRT3aE2PGbO30B0W17S4OwBpgAA6mYA=
Date: Wed, 8 Oct 2025 16:04:11 +0000
Message-ID: <6A8391B8-5E75-49B0-834B-00183BA4CF3E@oracle.com>
References: <20250930224037.224833-1-salil.mehta@huawei.com>
 <871pndlgi7.fsf@pond.sub.org>
In-Reply-To: <871pndlgi7.fsf@pond.sub.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5894:EE_|DS4PPF26D9E501B:EE_
x-ms-office365-filtering-correlation-id: 3aa81fe7-7a05-474b-caa5-08de068451d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?WHRCNGZpTVZ1MFFTNlZadkNPVm9sWmlXRzArNmd0dTZmNnNyWlM0ZVZYRTBm?=
 =?utf-8?B?NlpwMkk2Y2lxU0V3c0cxU2dIRk1SQ3VMMHJuYktQMEpmN0ZKNDhKS0ZuOGMr?=
 =?utf-8?B?YU9hOEc3a2ZnY2RrOWlSSzVNWHQyaGVZd3pvV0FwVmgxejhkdUtTZFJxZTVq?=
 =?utf-8?B?d0hVK1NVQXoyT1FiSGdaeGpQcVF4NlZtWkNWcmZJTGJqUEJuL1RKZ0lUK3Vp?=
 =?utf-8?B?TEZtbS94TDhNVzZGUHJGNDNxWU9sUzBMRGR0WWZhS1VJSlRBUm9ZOWtHa1ZI?=
 =?utf-8?B?dDNoTHN3STlCS2I0QW1sSTg5RkFBYlpqMmlvcGFLcEpUdG5tSVZwZmFRZUV2?=
 =?utf-8?B?b09yQ3lNbUVIVHFkbGtlRWpwN25GR3kxUElLREZuV3kxRUh4TmJwN1RIVktT?=
 =?utf-8?B?K2ZZbkZvOWpsaVl4UTMzWGdPa2hQRHRRYkdvVVJkajZsOHJjSU90clNsQ0Rr?=
 =?utf-8?B?cWY0NzZ3S0k3VnlhTzRVWUd4K2M0NkhQVk1ML1dISkEvc3hweGhhSDNiS2hU?=
 =?utf-8?B?N1pQT25MZFhDZlphV0RJRHNSU3NUNXVLMDYrVUROOENGZUJzT0wxZVREbENk?=
 =?utf-8?B?eFViNWRvL3pkZkN2aVM4OS84dTR1RmNpUUU3dGhFUE1jQXRtODd2dFlVYTYr?=
 =?utf-8?B?b1JXRmhmQTQxNS83M3NKSWdGZWZmS0JqVzRLUW1NR1U4K2tyTWlnTWRxSGw1?=
 =?utf-8?B?cW15d1d6NXpJRndiZzlON1VpbjVHeVRjVDc3bGpRWkZKbVRsa1Z6MjB4WVpm?=
 =?utf-8?B?UDhzN1NrcFU5S3RJaGZza3YwTU1KRVpQajcxV3JGK2hsODVuczBPUDhJTnB0?=
 =?utf-8?B?UjVjZDBNTXVURHpSaWRoWUx6bGJBUjhGNW9KUU9BYjRyYnoyS0xVZFcwZUxp?=
 =?utf-8?B?VTdMdWgrVTcwcnh0VW1wZUNqOGsrNFQ0SFFpRllFYnJQcTN3dXNXaWEyUDVm?=
 =?utf-8?B?M0x3UGloK2lDMVdvOVNLalNUQXVJazlINHVDbjlnMER5UUpFSERzRWcvQWJx?=
 =?utf-8?B?VEJFck1lNFlIR3h1c21nNVY1TGpIa1AvZWtxeXkvOEwzTlBpaWlwMEM1SnFL?=
 =?utf-8?B?TUZoNnptWnU5eGZBdTdkOXFadGIrU1lKQzl1UmJGUkNEQkh0Mzc0YzdUV3NW?=
 =?utf-8?B?T3E3MEFoWlc3VUdMWG5oSjhqcGRBMkdhWTdEeURZbEhyQm9Ud0hGSGpPRUp0?=
 =?utf-8?B?bExLc3BFanRLUERKd1ByeWdHTzlBK3oxalZEZ29zQ1JrUkMwb283M0Nsd1pz?=
 =?utf-8?B?eDIwVm85TWIxdnp4REE0YzloQlJOWHcxOHpKVk95T3lGZ2UvVGNOYjZWNTRV?=
 =?utf-8?B?Ly9yZWkrY1htbGhjZXhvOGhYek9XWXdlQjZSSXFTVHczQk5WZUlBdzRjN2l1?=
 =?utf-8?B?a2RpZkpNUVFScmt1bTM5Y3V5dHIvcEZya1JIa0doanFGQzlLay82UHhwZkhj?=
 =?utf-8?B?OFl4dVpGRm9yOXM4alVQam53MFdsNnpKMzZWM1BNUlRNUkRWVVMvcUsrbGpW?=
 =?utf-8?B?L2pyVVRaMUtOU3lLVVdHU3VnYk5KWkxQVVVFV3pGSisvc1haSVZTcWtyWGMx?=
 =?utf-8?B?ZXVOZTRhQllIZXhnTUpuRlhQd1NXY1BzYUJ2bjFzVUpBZDFPbE4wN1lDNlZv?=
 =?utf-8?B?bHpXMktXQktCTnFnT0xQeTNtYXd2aGYzR0xrRUVmYUJqRHA4Q3M5dW8rSlRU?=
 =?utf-8?B?bDU5STh4YmVYY2N4Mkoxekk3c2JvUkxpSEVlcEtUa004YWlnVnFWMXIvaEZq?=
 =?utf-8?B?aVpBTnoxeis4MTM4QmgwVy9qSFlMRFg2Uk5mT0xtVnF0QXh5STdxMVFiRnpL?=
 =?utf-8?B?VTlab09ONS90UVVySnlTNSs4eFBmUUFsWkFlWGVoTS9ER0hQTk9KdGpqY3Q5?=
 =?utf-8?B?QStkL1dvWEZ0RXJhSkZtOXEwWGlKbk9OcFAzaGZaMkNrbytCdjQvNE1DdXRh?=
 =?utf-8?B?bFViS2VFN2x5bGM0ZkJpOUVhWi9EV2VrcGNlWC9CVGFUZGZHYVdiekNhWGVN?=
 =?utf-8?B?QTRTeWxHRGIvdDhIZUxPZytETjB0b1FtRHNjWHFxSW43TUJNSHlBZ3VDMDFx?=
 =?utf-8?Q?ztr959?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5894.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDRzOFJCUHBWckRoNHRTaEEyQzdCOUxZMXBiWVB4SmZIaDVLclRwcEJWTktR?=
 =?utf-8?B?eGlLNWpWYXBIcHltQ2ZwSDVjOFFNaHk2aHFOOGJKRzRXYktKcXNsQlRldE1l?=
 =?utf-8?B?cDZ4N1IrL2ExYUszVDBmOEgrb21ZRjByNDhHcjQ2VnFUM2t2S2s3OTV3bVZk?=
 =?utf-8?B?M2JTMHpQdDlsek9xd0d1Q21melRlbU5rS0l1WUd5cnVrT0hjWXlhMGpVOWVI?=
 =?utf-8?B?WlZVdnN6ZG45bzJOaVdVczJucUFDWnBSYVVHd3pqcHEvQUFKN2REMEFvNEl1?=
 =?utf-8?B?b0RoY2ZCUmxDWUhGQkpPNEhWa1VxRVhiaGJHZVNjQzdVUEJJY2ZVRmFESkJx?=
 =?utf-8?B?aW1vdHFNbUlVUUdvOU1sSE16bGZtMk9xQVFaRVc4ZjQ5YS9Pek1vSC90STl4?=
 =?utf-8?B?cVB6ZTQ5RDNleThVUGRiVE9KQ0pNYnh1STF2VzVNSlNwdWtuSGZYQUtURzJ6?=
 =?utf-8?B?cXlhTFBVZFF4UmF4NHpjSEoxZnMreDRKclFkS0RoR1YzcEtKZGxZN29SWUxl?=
 =?utf-8?B?MUZXSk1wd0N0SDN1UVZWTVlubDNLVjYzYTQxeklvZStFWk9RaS91Wjd0dG9H?=
 =?utf-8?B?M3VLRlRYY2NQZkpHTEdUMkZSSSt0UFlUbW5UU0hTSTd5eXRETDhHU3l4OVYr?=
 =?utf-8?B?Mml1U3JCVmlOdDhCeEUxd0hSbjIwV3Y2SGk3ZFBRcXE4K2paZWxGZUJiVGVl?=
 =?utf-8?B?SXZYd2NpSTNtYmV1L01sTmVhN09Ma3ZnZTk3TndGNWhUUGNGd0xZNGFQdUhO?=
 =?utf-8?B?dExOTHNQVVZJM0xic2x0NjF3NTdLRWRGa0NJc2N4U2tBUWlESHJtMityZzJ6?=
 =?utf-8?B?RVFjSVppbmdxcFVQdHozMldodDhZUm5ZNWU2RlRidnpRTE8vQ2owR0Q2Vkc2?=
 =?utf-8?B?MWU4bHJHOWs1ZDZ6Z1lXMkkvZ2xpQ1Z1T2VTSjVmekUrbEw3REhkL1BITm1w?=
 =?utf-8?B?cmdIYTMrbTZoenpnNncxTnA4SHBrTTgvTkp5djd3U0pKSjlrWVlLQ01rRjB1?=
 =?utf-8?B?VUdsMzNCZ3RQT3B4TGtoTDlQWFFDVHExUmtMR1JkMFJIY0pISFI0dnZxNVlT?=
 =?utf-8?B?bVRjUEY2MjdGS3V6R0ppcUFOSVVSNUNvekQyRHVNSGk4UUpwem5pNW41RUNI?=
 =?utf-8?B?bEhtU3EvbStaV2xwLzc1WkJpY25DYW94VEhXclVXOXZFMFpNaW16U2RxY0dQ?=
 =?utf-8?B?b3dFZ2Nlb241TmhnNGp3UTR2NUdJMUx4d2t6dzl2V2ZPTkFRdm16cEU0Rnhx?=
 =?utf-8?B?bDRkWG9DNjVJejlXeXJkODNhaXdvVzlxMVllVEJHMWZTb1lpUHpFZys4YWtO?=
 =?utf-8?B?QUJIUDBWMzFFaHhFWUFjTkRUREx6RGhxZnBhSGowSllnOHBjcTBzZzcrU3BO?=
 =?utf-8?B?R0hTQUVnb3hxajg1TmdqbWdpR0N0Vy9JV2Q2eTZSQzlEd1NIcE9PVVpuRXZZ?=
 =?utf-8?B?aThFUGlaVUVUMXZTVXNDT3lMbkhpMWFCKzZGSjdWTXZydkR2QVZ5b3J4NkVa?=
 =?utf-8?B?LzJYdFZIZEJpL0NqV0tONU5PczE1RWVkWm9EM0IzZU9zRkpZM0V2aytNM25R?=
 =?utf-8?B?c2cyNzVveUtjMVhyNE1VV2duak5NUHJuL1l0WGh3NEt3ai9neVZjV0crTmlG?=
 =?utf-8?B?QWxqNUlGeCtkelJKakVXZ1dGajg4YUdGeWdTbkdvYXdmMHJZZkpLallBS2sw?=
 =?utf-8?B?cVVKdCs3NVNLc1kyTmtCSTJzb2RDY2NrSEIyV3BVa0cralVYaGdWNWhVU3ZH?=
 =?utf-8?B?UmdheXdweUU2RE9uUk93YmN6MEhpbWxZRW9vM1p5SkZXNWdXSnhmWEF0TllK?=
 =?utf-8?B?b1c0VG5OVFRDTW5tS1VMY3U3SHBsMWV1STFaUXlkYjQwMTE0Mk5Td1FOZFN3?=
 =?utf-8?B?UXRESVVZeS9GZ2Y0dlJ4d00zcUFpU0FYcmx0TFVydGNURmVFT1dmQkhxTHFT?=
 =?utf-8?B?UnAvNERxUDgweVNYT3JPay94by9kdmF1a2o2cDBnV3ZwZ2srOENMUDVkdUFP?=
 =?utf-8?B?QW84bDRFWGR4R3JYVkJ3TVZBZmpKUU5tWXNPeGtIZjhxcExiUXhUejlIamVw?=
 =?utf-8?B?end1Vlk2aFlBNStMamdqaW9jKytueVcyTXFvRzcvQ1M2eS9tNkZIZ005VEYy?=
 =?utf-8?B?Nmw3VEZDN3drSk9SY2JBQmRXZ0tDUVREQXlSSUMxQXh1QU00K05UU2FLcVFS?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D9A9B98CA74045AAE61578B9D7B3A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IfN/1K3OVKjwZ0A6bkgjALf/CWFy0wNjotXwKkkW3THSToGwlQlD1DVTGsEoZMBNcV7+KLJqbzBGQ90XgaGyWRfnIYw+71LytExfD/K1yk/Vj845IjERR5KdfduqUnqle7A9fVEVpppRdikoTUrr24hLP1heri5SuSU4xrOy2q7qiEjVWvruWdlYzQiieHSYUEiT1d9+hSxg7eBPaH4RxnoThpghAIJGA8YwKVx9M+g6tGzZOJ8JzxGILqip65YAVQSo1TBfv07fxcyzLnNZz/0ec7Zw9HKkKPj9izHEPmhOBVpjxGRnYpBeyqUMZRJiEMk5Autr87obhquMO98V3ErS3FSP4LYlksh8tSrJdvig/oHNyHQeSo5eTNsHN+Ul/vXCfUYES+Qx2k8yR14qSJnPWCZKRvNTg/tJo05z0mVRsfPMk7kRzVkS18eM/y5T4Wg/xsGgUlBCh/YoZiEoCbcI2SKtLXYd/IqHCASfXi1oNsbkNtoBuFf5+NU7PoYi4xQWzfh4Mbtiq02KU/F+cD1DfbOX4c63j/zFKypsmXhW0S6zvDUnkRvVBGqXRSRW5/dWJjN6vhOHVFeQ20H+emiohz0Yp7PBggiSeI9vRV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5894.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa81fe7-7a05-474b-caa5-08de068451d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 16:04:11.1297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRxZvG4OTvnFCUwfd3XFzYb++DJpo1nV4YTjaRe7kNP0i7WuqJyOQVyevAFVazXJJdkQ/m/W05lhEM2GqA7I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF26D9E501B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 adultscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510080112
X-Proofpoint-ORIG-GUID: Wep8XsyFlq56MMW0Ss4FkztyeEBlwGWS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA0OCBTYWx0ZWRfX23e+weCch0pm
 MZMN5ogK26RXFxjTiQ3uwcpe7IYSil4893tlLm7I++u8uDacgg2UrtDo5vjtsSWQI7ZWQFpYofv
 SxQu6trh4V1Rv5BO/DJ9Ifh2Aipv02BmJvu9i23sIUfGQVqW2fozFcpwv3ikYXMlfTPEkWVJoAY
 0GetN9UYjM3odcQa4v+EkRR4h89etUbFjPQ/kclhxm7+TzGjhh189IJKExr+MzkR6B5rrt0tbBV
 w39pJPCSSPahZWOXldFTMapkDZiBq+wnPrlyXCVv6htC5fcZbNA4LpRJl8W478RXse2JkVKOx0i
 rb5X8oVrCW5+SDKoWtQE3QwC3ncUog9udjOKOHbBY7ZV2I30GzkgReYkYacn09sa/oYKqLiSuQV
 1h8OU4ffkDR/18fWRu66Z6AnWA3HOIbCawHX28ERaMiLClrzdEA=
X-Proofpoint-GUID: Wep8XsyFlq56MMW0Ss4FkztyeEBlwGWS
X-Authority-Analysis: v=2.4 cv=SoOdKfO0 c=1 sm=1 tr=0 ts=68e68b93 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=i0EeH86SAAAA:8 a=l4TUKpgJHg4eXzSyoRkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13625
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

SGkgTWFya3VzLA0KDQo+IE9uIDggT2N0IDIwMjUsIGF0IDEyOjMzLCBNYXJrdXMgQXJtYnJ1c3Rl
ciA8YXJtYnJ1QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gU2FsaWwgTWVodGEgPHNhbGlsLm1l
aHRhQGh1YXdlaS5jb20+IHdyaXRlczoNCj4gDQo+IFsuLi5dDQo+IA0KPj4gPT09PT09PT09PT09
PT09PT09PQ0KPj4gKFZJSUkpIFJlcG9zaXRvcmllcw0KPj4gPT09PT09PT09PT09PT09PT09PQ0K
Pj4gDQo+PiAoKikgTGF0ZXN0IFFlbXUgUkZDIFY2IChBcmNoaXRlY3R1cmUgU3BlY2lmaWMpIHBh
dGNoIHNldDoNCj4+ICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11LmdpdCB2
aXJ0LWNwdWhwLWFybXY4L3JmYy12Ng0KPiANCj4gRG9lcyBub3QgY29tcGlsZSBmb3IgbWUgKHg4
Nl82NCBib3ggcnVubmluZyBGZWRvcmEgNDEpOg0KPiANCj4gICAgWy4uLl0NCj4gDQo+ICAgIEZB
SUxFRDogcWVtdS1zeXN0ZW0tbG9vbmdhcmNoNjQgDQo+ICAgIGNjIC1tNjQgQHFlbXUtc3lzdGVt
LWxvb25nYXJjaDY0LnJzcA0KPiAgICAvdXNyL2Jpbi9sZDogbGlic3lzdGVtLmEucC9od19hY3Bp
X2dlbmVyaWNfZXZlbnRfZGV2aWNlLmMubzooLmRhdGEucmVsKzB4NTApOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGB2bXN0YXRlX2NwdV9vc3BtX3N0YXRlJw0KPiAgICBjb2xsZWN0MjogZXJyb3I6
IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXMNCj4gICAgWzY3NTcvNzIzMl0gTGlua2luZyB0YXJn
ZXQgcWVtdS1zeXN0ZW0tbWlwczY0DQo+ICAgIFs2NzU4LzcyMzJdIEdlbmVyYXRpbmcgZG9jcy9R
RU1VIG1hbnVhbCB3aXRoIGEgY3VzdG9tIGNvbW1hbmQNCj4gICAgRkFJTEVEOiBkb2NzL2RvY3Mu
c3RhbXAgDQo+ICAgIC91c3IvYmluL2VudiBDT05GRElSPWV0Yy9xZW11IC93b3JrL2FybWJydS9x
ZW11L2JsZC9weXZlbnYvYmluL3NwaGlueC1idWlsZCAtcSAtVyAtRGtlcm5lbGRvY193ZXJyb3I9
MSAtaiBhdXRvIC1EdmVyc2lvbj0xMC4xLjUwIC1EcmVsZWFzZT0gLURkZXBmaWxlPWRvY3MvZG9j
cy5kIC1EZGVwZmlsZV9zdGFtcD1kb2NzL2RvY3Muc3RhbXAgLWIgaHRtbCAtZCAvd29yay9hcm1i
cnUvcWVtdS9ibGQvZG9jcy9tYW51YWwucCAvd29yay9hcm1icnUvcWVtdS9kb2NzIC93b3JrL2Fy
bWJydS9xZW11L2JsZC9kb2NzL21hbnVhbA0KPiAgICAvd29yay9hcm1icnUvcWVtdS9kb2NzLy4u
L2luY2x1ZGUvaHcvcWRldi1jb3JlLmg6MTkwOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIg
b3IgbWVtYmVyICdhZG1pbl9wb3dlcl9zdGF0ZV9zdXBwb3J0ZWQnIG5vdCBkZXNjcmliZWQgaW4g
J0RldmljZUNsYXNzJw0KPiAgICAvd29yay9hcm1icnUvcWVtdS9kb2NzLy4uL2luY2x1ZGUvaHcv
cWRldi1jb3JlLmg6MjY5OiB3YXJuaW5nOiBFbnVtIHZhbHVlICdERVZJQ0VfQURNSU5fUE9XRVJf
U1RBVEVfRU5BQkxFRCcgbm90IGRlc2NyaWJlZCBpbiBlbnVtICdEZXZpY2VBZG1pblBvd2VyU3Rh
dGUnDQo+ICAgIC93b3JrL2FybWJydS9xZW11L2RvY3MvLi4vaW5jbHVkZS9ody9xZGV2LWNvcmUu
aDoyNjk6IHdhcm5pbmc6IEVudW0gdmFsdWUgJ0RFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9ESVNB
QkxFRCcgbm90IGRlc2NyaWJlZCBpbiBlbnVtICdEZXZpY2VBZG1pblBvd2VyU3RhdGUnDQo+ICAg
IC93b3JrL2FybWJydS9xZW11L2RvY3MvLi4vaW5jbHVkZS9ody9xZGV2LWNvcmUuaDoyNjk6IHdh
cm5pbmc6IEVudW0gdmFsdWUgJ0RFVklDRV9BRE1JTl9QT1dFUl9TVEFURV9SRU1PVkVEJyBub3Qg
ZGVzY3JpYmVkIGluIGVudW0gJ0RldmljZUFkbWluUG93ZXJTdGF0ZScNCj4gICAgL3dvcmsvYXJt
YnJ1L3FlbXUvZG9jcy8uLi9pbmNsdWRlL2h3L3FkZXYtY29yZS5oOjI2OTogd2FybmluZzogRW51
bSB2YWx1ZSAnREVWSUNFX0FETUlOX1BPV0VSX1NUQVRFX01BWCcgbm90IGRlc2NyaWJlZCBpbiBl
bnVtICdEZXZpY2VBZG1pblBvd2VyU3RhdGUnDQo+ICAgIDEgd2FybmluZ3MgYXMgRXJyb3JzDQo+
IA0KPiAgICBXYXJuaW5nLCB0cmVhdGVkIGFzIGVycm9yOg0KPiAgICBrZXJuZWwtZG9jICdwZXJs
IC93b3JrL2FybWJydS9xZW11L2RvY3MvLi4vc2NyaXB0cy9rZXJuZWwtZG9jIC1yc3QgLWVuYWJs
ZS1saW5lbm8gLXNwaGlueC12ZXJzaW9uIDcuMy43IC1XZXJyb3IgL3dvcmsvYXJtYnJ1L3FlbXUv
ZG9jcy8uLi9pbmNsdWRlL2h3L3FkZXYtY29yZS5oJyBmYWlsZWQgd2l0aCByZXR1cm4gY29kZSAx
DQo+ICAgIFs2NzU5LzcyMzJdIExpbmtpbmcgdGFyZ2V0IHFlbXUtc3lzdGVtLWkzODYNCj4gICAg
RkFJTEVEOiBxZW11LXN5c3RlbS1pMzg2IA0KPiAgICBjYyAtbTY0IEBxZW11LXN5c3RlbS1pMzg2
LnJzcA0KPiAgICAvdXNyL2Jpbi9sZDogbGlic3lzdGVtLmEucC9od19hY3BpX2dlbmVyaWNfZXZl
bnRfZGV2aWNlLmMubzooLmRhdGEucmVsKzB4NTApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB2
bXN0YXRlX2NwdV9vc3BtX3N0YXRlJw0KPiAgICBjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVk
IDEgZXhpdCBzdGF0dXMNCj4gDQo+ICAgIFsuLi5dDQo+IA0KPiAgICBbNjg3NC83MjMyXSBMaW5r
aW5nIHRhcmdldCBxZW11LXN5c3RlbS14ODZfNjQNCj4gICAgRkFJTEVEOiBxZW11LXN5c3RlbS14
ODZfNjQgDQo+ICAgIGNjIC1tNjQgQHFlbXUtc3lzdGVtLXg4Nl82NC5yc3ANCj4gICAgL3Vzci9i
aW4vbGQ6IGxpYnN5c3RlbS5hLnAvaHdfYWNwaV9nZW5lcmljX2V2ZW50X2RldmljZS5jLm86KC5k
YXRhLnJlbCsweDUwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdm1zdGF0ZV9jcHVfb3NwbV9z
dGF0ZScNCj4gICAgY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzDQo+
IA0KDQpJ4oCZdmUgaGFkIHRoYXQgc2FtZSBpc3N1ZSBhbHRob3VnaCBpdCBnb3QgY29tcGlsZWQg
Zm9yIG1lIGFkZGluZyBBQ1BJX0NQVV9PU1BNX0lOVEVSRkFDRSBmb3IgTUlDUk9WTToNCg0KZGlm
ZiAtLWdpdCBhL2h3L2kzODYvS2NvbmZpZyBiL2h3L2kzODYvS2NvbmZpZw0KaW5kZXggM2EwZTJi
OGViYi4uMjlkOWIwOTQ4NiAxMDA2NDQNCi0tLSBhL2h3L2kzODYvS2NvbmZpZw0KKysrIGIvaHcv
aTM4Ni9LY29uZmlnDQpAQCAtMTMzLDYgKzEzMyw3IEBAIGNvbmZpZyBNSUNST1ZNDQogICAgIHNl
bGVjdCBWSVJUSU9fTU1JTw0KICAgICBzZWxlY3QgQUNQSV9QQ0kNCiAgICAgc2VsZWN0IEFDUElf
SFdfUkVEVUNFRA0KKyAgICBzZWxlY3QgQUNQSV9DUFVfT1NQTV9JTlRFUkZBQ0UNCiAgICAgc2Vs
ZWN0IFBDSV9FWFBSRVNTX0dFTkVSSUNfQlJJREdFDQogICAgIHNlbGVjdCBVU0JfWEhDSV9TWVNC
VVMNCiAgICAgc2VsZWN0IEk4MjU0DQoNCk1pZ3VlbA0KDQo+ICAgIFsuLi5dDQo+IA0KPiAgICBu
aW5qYTogYnVpbGQgc3RvcHBlZDogY2Fubm90IG1ha2UgcHJvZ3Jlc3MgZHVlIHRvIHByZXZpb3Vz
IGVycm9ycy4NCj4gICAgbWFrZTogKioqIFtNYWtlZmlsZToxNjg6IHJ1bi1uaW5qYV0gRXJyb3Ig
MQ0KPiAgICBtYWtlOiBUYXJnZXQgJ2FsbCcgbm90IHJlbWFkZSBiZWNhdXNlIG9mIGVycm9ycy4N
Cj4gICAgbWFrZTogTGVhdmluZyBkaXJlY3RvcnkgJy93b3JrL2FybWJydS9xZW11L2JsZCcNCj4g
DQo+IFsuLi5dDQo+IA0KDQo=

