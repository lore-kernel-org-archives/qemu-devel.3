Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F72D1D896
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 18:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0mUj-0001p2-I2; Tue, 15 Oct 2024 14:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1t0mUg-0001oU-Sq; Tue, 15 Oct 2024 14:42:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1t0mUd-0006Je-Dl; Tue, 15 Oct 2024 14:42:06 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHth6p024661;
 Tue, 15 Oct 2024 18:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=AgsNKJQ6A9fFE3+dcW9amQ1CJkLb8+hdpWKIghLCNOc=; b=
 bAPrGH01H2Es9B/yN3pwPJ3f1HoiBd4oxngNihJStsEx6Bu+esXH5niDzXAWa212
 5nhnQuaKezsZyJ6mO23ezPHeeqgxSYV7gh62CTBCO3NuqG3LmtoBB97dhT1M2z3g
 ej0tIqjbEHJkeYYpfo3DS4xm7gaGeRBUe9lr868mSlIZUIs9GEWpBqMWuwIkr7YZ
 1gzWfz8dR/ZqeNLBl12arqsisvk+Bi0rkEU4WP9/8laTe0SpyMQQqTG37s7UbkZK
 R9jtoR1X3/RjxtkVPF273UFKt7YwXIGKHeQwjE/EflViF+0JV4cfF6CPETXoHvQz
 tN87Sc2JbJz0/yhGaJB8VA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cj6xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 18:41:23 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49FHSj6n026193; Tue, 15 Oct 2024 18:41:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 427fj7uq4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 18:41:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZepRjFQkaVSNgUflhBunx2W7AO9RAEkKGZv+ZtG5W7nWeD9dQrGD3m1nBTsAbC+eeI43V2hUY3hBldE/X7yQmCSiui22yvRFHqfm6ddKslo5dfKGrdPWYzDkVWphciNHqQJnx6j0Rxwgvrnfdx+4+hzBcA4RF6pZC07rlc9iWjbEEGXhnrkcdGQKwqWV7sBvXIs/q3qOr00Fbg4AW5Cw/602UIr+tswC+QPMAgziM6snYCkhGW0fNLSRSAnfCAZdj77GPZKJyMn1rWSvI8uWG5iJHGkVWo+paDeyVpUmI5LOwYgki7Fv1qeq91+bN3sFONX6EP5nwNFTVOBtCkb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgsNKJQ6A9fFE3+dcW9amQ1CJkLb8+hdpWKIghLCNOc=;
 b=K3/CWWg0LRCy61Oec28G0obIOK3VqRGiNafbqrMljOyI/WKqNIktsrAsPTlpWZzePbUcN4bwP3xgbOEsOczaFi8TBcQjqTg6VjMbEbCOXZd0aCqkZI1hGCtgZDv+nqirKbzD9XBMx9NxGuFwoeXvwfKvSIvlL5ltDi69cZQC62I5nh6aynkMsBzA7nwVcy29TLE85z+yVuM5reEmrU/gUh4wR6sHhQFovYDcLb8KSDowNgcZeypaOAH4IHMYDop8U3bjmSUbViItNM98OZhQ2mIYxGgXnNKopoREGGcUky+2DrLhW52F2ZeL9sFP3kG1cRrfoqaxc6S0xJkJO4b1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgsNKJQ6A9fFE3+dcW9amQ1CJkLb8+hdpWKIghLCNOc=;
 b=CJ2ecH2TMf3dP56tgWkBqeCgCYnXoSCD2JYzDr5nq4uYXPYNR1s9Me82MhZi0caXrOJ1q+MjXdoR/GL/cnb+5qFcxTq1wIX6brxqzzOL73QPr1TNo0ABZy+/l+DVvrT/JcQ5+R5ZBFzNWNFa4AR5MIspd4jbVBi7t/9IovYPhY8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH8PR10MB6502.namprd10.prod.outlook.com (2603:10b6:510:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 18:41:18 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:41:18 +0000
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
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
Thread-Topic: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU
 Hotplug (on Archs like ARM)
Thread-Index: AQHbHm56whvhiJQb3U2TrOaR1/5F77KIJrkA
Date: Tue, 15 Oct 2024 18:41:18 +0000
Message-ID: <B1CFD37B-3422-4766-A5EE-64D000FDEC2B@oracle.com>
References: <20241014192205.253479-1-salil.mehta@huawei.com>
In-Reply-To: <20241014192205.253479-1-salil.mehta@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5433:EE_|PH8PR10MB6502:EE_
x-ms-office365-filtering-correlation-id: f0ff9edc-4ce9-4f3a-26cc-08dced48f532
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VFlnbDExcjlrTmcwb0Q5QkU3RW83Vm1zdlAvbXQ5cm1DS1ZteFpvQ0drNXRu?=
 =?utf-8?B?dlJUYmNMbE1ES3M4Z2FrREZzam10VXdBa3EvbCtIV3A1TU1UWWZFTTVpMXdM?=
 =?utf-8?B?Y2ZEM2NVZmo2QVprcTVYbUtiaUFrcldScTlYai9DRjI5YkwvcVNUTlNXdEtR?=
 =?utf-8?B?THpjYjFLbkJUVkl1eEdqMmNPaGJIbXAvRjcrODdtTDhxT2hqbUdXenlmd01P?=
 =?utf-8?B?N0FNc3kwV3VkdDFybjV4MFBqczZoMnQyRW5UcWdQREV6cUdIOGZoVlF4Vm9J?=
 =?utf-8?B?a2t3dVk4WHJJUklqWUdDdWFpTDAxQm9YV1VXNkoxL3R6UWlTQnlXYTQrbzFr?=
 =?utf-8?B?dTVoU1U5Ykc1ODNXRGdpQy9Wc09ZMUJCWWZLN2Rrb0JHcEIrSzBPZ3J4OWtn?=
 =?utf-8?B?V0lsNVk2cm5wVFp2UllIVWVPSnljUkRqRVkveHMwQTJ1Zk9ON2pLTXhEazc0?=
 =?utf-8?B?enIyS2Y1UXBla2dncHl3TXQzMWcrUDFKMXNYbCttQmNHaWlaeTVaL1VQMkFG?=
 =?utf-8?B?czNXMTVEeGZiTERLMGlhb0N5SExSaUpRS1RMRklQQjdFbUk0MjY4QWJGK0xx?=
 =?utf-8?B?b3FiNXlnbTgwRURFK24wZDlzdldGVUk4V21PUmJua2lSdW1FQTNvekZ1RnBk?=
 =?utf-8?B?Qjdrdm1mcTB4QWtTVHIrQTduTURVUWtaMU9UUUpDcXhLREJuOVF3L0dIMUZ1?=
 =?utf-8?B?Sy9tQVE5NGVIdnRaUGdpT25KaGhpbTFWWjlFNmJNOEVLcWlWUzdkSGhiNnkw?=
 =?utf-8?B?cG9HSVF6UDRPekFvcUNnS2M0b0NrOXlYUktpMlB4WFRYMG1rdUtlbXRIQTlk?=
 =?utf-8?B?TlB1MllNVFYzVlR4QlhvL1lWM2hmYkVwYWxMM1plVnc1MHhRR3BOM2JSS1Ju?=
 =?utf-8?B?RHNBWW1FNmtDOFNIN0QyMGw0ZjhpWUFodGlDSFAyZEpOMy9uR0xOSFlnZXB3?=
 =?utf-8?B?UENYSms0Q3BLWmJUbnlrMVZBY2JwRWRweHFadzFmZEVCamx2TFpXZWdFaHho?=
 =?utf-8?B?MG9FZGN6ajQ2UCtlWVVabkErc2ZmSWw2MVZSOHB5b3RtMnpJVHJKZGRHTTBZ?=
 =?utf-8?B?RUk4YTZESFNRUUJ2M3VaeTJ3NWZLV3FycndONE9Mb2c2MkFESzJVNmlDZU1n?=
 =?utf-8?B?Z20wWTF0emorT0owbXpFUGFQbUM2dkNTZ1ZuVGxZdzlKcGtjSXJ3enZOdG5n?=
 =?utf-8?B?TTliUkxlYVY3S3o2cmphR0YrNWZkb1FXWW1GQkp2UFVIZHFJbDBFU0ZsOG1K?=
 =?utf-8?B?UmtDbW1qelJCSE9ocUhRL3dhT3NkYkYzbTNMTFdYYi9sdnRMSXUxUjR4Y3ho?=
 =?utf-8?B?cE5RSXkzVnJleWNXS2t5dUIzK1dxa2s0SHNPeGttOTBRK1FobkJUUDYwRk82?=
 =?utf-8?B?YUJ6bmlWc0JMZzlBOTBYT0lCQWJCOW9aYnhVMFU5RkNxN1dLcmpGazN5Wk9Y?=
 =?utf-8?B?MjNGajhMM0ZCT2Y1eU44T1BteUFqRHNZQVVMUE1lNHdzT3hHMC9NbTF0K3dy?=
 =?utf-8?B?WU50bzRTSlNtTnZoWUI5YVppajc1bm5qa0NXbXpuVzh5VWVuTTBiVmhFb0d0?=
 =?utf-8?B?MW5YRXdmb0VNa2FmMGEyVlF2OXRyMVJvRmdvVXhkS25Hbk0rUzJmNldjUGYz?=
 =?utf-8?B?bXZaaXhZT243V2VQTlRSRnM2ZGZNcWxzZ1hvSFNhR0M2SEtyYzh6RzdIYmp1?=
 =?utf-8?B?dGRndm9PSXdyVDJRZmYyTFJzeVdFM0g3dUZidWVRTG0zZkNRY3h1TDkyaTdn?=
 =?utf-8?Q?n0UTmjQMRYUrysDt+g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5433.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUZldS9mQ0pLdWxreENBQ25vL1BJZFlLWXBBbGRIS0VETDlJR0tUcVJCK0J1?=
 =?utf-8?B?NTArMXdJbEVKZ0JJMG82S3cxcEFJMmJ1dEkvKzBGSjBHMms4QnZLOUgrMWMv?=
 =?utf-8?B?eDN0WVFRTEFhWXowZHhEelIvSTNZZkovRml1ekJOY0Roa2tydHlYc0JRWU9v?=
 =?utf-8?B?OTRXalRoYUVEMXdVNVdtTTZxeVd5dUFaVC81SDJtWDNKYTdDd0MxMUtPZXA4?=
 =?utf-8?B?NmIzc2ZXdWtsL05mZHNSYlhUVDhqYnZvdUNPUEFVaFlZT29taHJ4TWMrelhz?=
 =?utf-8?B?WkxmclMwY2FaeUIxdGZweFRsQkh4RUd4ZWVtYld5V00xQUJKVWNBMGFXU3hk?=
 =?utf-8?B?VTFyZTdKVTRqSld1a3NjRWhmVUlQM1hkK2xPaXdzbkRlc3RsU2xKdTdkT1JQ?=
 =?utf-8?B?azFyZGcwcm95YWwxdXFoZUUzZ0pRVjh5SVREOCtqeUNKdjVWVElQN3gzcCtX?=
 =?utf-8?B?SnlQMHhIak9RbHpOUldYZWFsRkRnTDJCR0RZSTVHN1N4TjU3c3dpYzU4dE5n?=
 =?utf-8?B?MmNNdlBucHNEbFNPMVVxQXBoQ2RQcTBLaG5HUThmcldMN29kdEQvdnl5eTJV?=
 =?utf-8?B?dk85K2NhYjJ5WUJUV1lXd20xbUpKQlpPYldMUzV1U05JM3g3djkrMUg4Nzhr?=
 =?utf-8?B?cWs0dkVDY3o0YS9CQzJUZkxzR1ZDQzM2dnpSeTlNQjNkVG9lQTNubFRrUnox?=
 =?utf-8?B?NlJkK2lxMnVvMUt3TDRFZy9qYTM3cUc2MnFENFVKUStORVRWZzJXK2RleFlX?=
 =?utf-8?B?bzdZelozR0FoYXl0TlRsM045Q3Q3Z0dhN0FhSkE3Z0hCK1FncVlYcS9XS3Qz?=
 =?utf-8?B?TGNjc3Z0aXlYQi9HLzNxOTV2SnRMT2NIbWk0T3gzWkxTNVkwMnZqY1hhMmt5?=
 =?utf-8?B?L0h3NnJicVNFNk95UFpQak83di9Zd05Xa1ZFWDhjbkZ5TVc4ejNja1ZVTVk1?=
 =?utf-8?B?TmxacXA4M2lYNlZlM3Q3MTlMOVdpOXZMZGxjZzd2Z1dCVHB0MWNxQ2NxVVdr?=
 =?utf-8?B?bGdoTXlQWjR4OEl4N2ErcmtKTEhlV1FIUjdmTVJLL0s3czhKVHV5TG5xTlVV?=
 =?utf-8?B?cVVuWUFUWGtqYVFrcDBPMjV6eW1kbDM4K1BzdmV4RW8ycGZIVkxLbCtaSlBV?=
 =?utf-8?B?NFFvNWt4M0tsOWdDNEhtLzFvSFlCM1gzN1VWRnZiSlNIL281UVNLMkVReHI3?=
 =?utf-8?B?eXE5Ym9GTGhZR1phMmhoMzBxOXppWDd6dGhKaU1BM29KZ2FDdVNJcVplTTRo?=
 =?utf-8?B?YUlhMUtUekg4MGs5Ukg4SmhrdWtZVGdEUkxWK2x3N3hkc2plSjl0MU03VGp4?=
 =?utf-8?B?MGFiNXV5NU9uNkFNUW1PUWk3YnpkNVBvbzBlWjFlLzQ5b1p3b2JRcFM1Y1ky?=
 =?utf-8?B?REo5bzNzSFlLY3pING9GN056OXIzdXgwdEZrRHhNL0VSOVVqdzZ1WXdmekZJ?=
 =?utf-8?B?Rlk3K3BhVllIM25SZ1hTekdiTDJ4TkY1NTlMTC9ycFBBbDloYTVLN0xmeUlj?=
 =?utf-8?B?WXdvU0pNdkZTUTI0bHZsazVvb2ltb0JMY1FFUERQMkZxbjMrclhpb0sxbVFR?=
 =?utf-8?B?L3VGc3BrOWp5a3FRcytIQlVTVUhVaGNtdytWZjdsb2Yzck5ieFlTTndSL0dJ?=
 =?utf-8?B?dC9uUVpkbWgzeU9FcWtuQStzTTdzZFkyMUMwN0l6dEkyU0Y5aHpEbFY0bEoy?=
 =?utf-8?B?OVg3MkhJa0oxd0FlcTdtdW5GMmpWU1J5VzdNbDMrc3lXeDF5RkF1QWxtMDhr?=
 =?utf-8?B?SGVlN0wxa2g1cjNmZXUyeCt1NDVQRFNhZ2lsUk9TdTZBb0dscThiVTV2M2t2?=
 =?utf-8?B?My9PMkFOWjFXVm5vQXhFWXVQNWUwOGZLQ3RJZWpJbllkNUV2cG43VU5kMUJ0?=
 =?utf-8?B?VlFtWTdnRkRwUG5seG9velVaQ0hnWHRJSTlwT2piZ1dQTEVLVEMxbGRVOEwy?=
 =?utf-8?B?UXFZM0RkT3BQYi95aTQ5Qzhld2Z4V1VlOGRmQjBxNjBIMjNIazI5cjFUY3lp?=
 =?utf-8?B?aG11ZXJIUW9NZCtTMm4reVN0ZTNaRExsODcvWVRpMk9HRlYvWkhFR05lbG40?=
 =?utf-8?B?ZU9ZVlpkRHp1aE03RkdLc0hiSGh6UGorRFZkb0d5OGp2eW90VUpjd05OWTN4?=
 =?utf-8?B?RmRnN0FaZmEyRnEzZnQ1NzFRS213eTdCQ1BDZUtMcFJUNmZtelpDS0VxN2Vr?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE2E59DF1BD80F42A03411BCAE8EDFF2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SAtpqOdl5B6tbhSortSpSN95jHek6FuVa/QcnpVXgULySUDDiuzsUfhfOtuIBOmEauOpPUb1G4E/mZ40IkHuxByHxgaZ8NXiSKQ4MZZ2xHhBMuuerAnyedio7FH41AfPK9kiSMis8WF1q9LcYTzVGIXb9N8BxZJBiCiF+KGpzRXWfwqxkJ/LxV7yGwAks6YoaVGf+geBpo/Y3Wlgn3gyIXUYJcF9c4jMFJ8rXOSW+PrNgZ+SyX/4U3ly5mOzSTUb5FLAAy8cOwKmONXMxKx/n45NfRDMIsxMoIyS7J5VAjmk8nf9uftTNMy7RNuPaqe4jutLB63RnfIB/lD7lUjHE09F11g2ipVrzgXb920IwOAV5rGm3puh8Y5YdrHLBb6iCDmZlpdeQSJ/+ajBYiJRm+ZY0RtrdyC+lPAe7qCZygb70Dvd7QKjAsc4goAQXbqGgHkRgIRtJP3ue6MwSHbVV6oWDJdt64AFwWW5Q5BY5PW7bGA3E5XHyhDpNAnH1zw/juxtYXsEoFIhjnm4o8yyCS5Hn41TpkyHcRcekrT+jHOZmCv7u8C7e5Uxf9g+qqboRE/AvImp2oZtc5iMV5TkH+lW/xiK3yd05w/f1PRmyW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ff9edc-4ce9-4f3a-26cc-08dced48f532
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 18:41:18.6879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lsmrqEy1v8dhlQd6vwmnl/zU9rSOsJWzI54jRAZ+LGxVLALJnHozxf8g0JZ2ObWuAeM7bx4ZhvnSsJQ+gv6lXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150126
X-Proofpoint-ORIG-GUID: Wvpmf_4uncZj2PZoUM6HRUHhAN36nmxm
X-Proofpoint-GUID: Wvpmf_4uncZj2PZoUM6HRUHhAN36nmxm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

SGkgU2FsaWwsDQoNCknigJl2ZSByYW4gdGhlIHVzdWFsIHRlc3RzIHN1Y2Nlc3NmdWxseSBvZiBo
b3RwbHVnL3VucGx1ZyBmcm9tIHRoZSBudW1iZXIgb2YgY29sZC1ib290ZWQgY3B1cyB1cCB0byBt
YXhjcHVzIGFuZCBtaWdyYXRpb24gb24gQVJNLiBQbGVhc2UgZmVlbCBmcmVlIHRvIGFkZDoNCg0K
VGVzdGVkLWJ5OiBNaWd1ZWwgTHVpcyA8bWlndWVsLmx1aXNAb3JhY2xlLmNvbT4NCg0KVGhhbmtz
DQpNaWd1ZWwNCg0KPiBPbiAxNCBPY3QgMjAyNCwgYXQgMTk6MjIsIFNhbGlsIE1laHRhIDxzYWxp
bC5tZWh0YUBodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+IENlcnRhaW4gQ1BVIGFyY2hpdGVjdHVy
ZSBzcGVjaWZpY2F0aW9ucyBbMV1bMl1bM10gcHJvaGliaXQgY2hhbmdlcyB0byB0aGUgQ1BVcw0K
PiAqcHJlc2VuY2UqIGFmdGVyIHRoZSBrZXJuZWwgaGFzIGJvb3RlZC4gVGhpcyBpcyBiZWNhdXNl
IG1hbnkgc3lzdGVtDQo+IGluaXRpYWxpemF0aW9ucyBkZXBlbmQgb24gdGhlIGV4YWN0IENQVSBj
b3VudCBhdCBib290IHRpbWUgYW5kIGRvIG5vdCBleHBlY3QgaXQNCj4gdG8gY2hhbmdlIGFmdGVy
d2FyZC4gRm9yIGV4YW1wbGUsIGNvbXBvbmVudHMgbGlrZSBpbnRlcnJ1cHQgY29udHJvbGxlcnMg
dGhhdCBhcmUNCj4gY2xvc2VseSBjb3VwbGVkIHdpdGggQ1BVcywgb3IgdmFyaW91cyBwZXItQ1BV
IGZlYXR1cmVzLCBtYXkgbm90IHN1cHBvcnQNCj4gY29uZmlndXJhdGlvbiBjaGFuZ2VzIG9uY2Ug
dGhlIGtlcm5lbCBoYXMgYmVlbiBpbml0aWFsaXplZC4NCj4gDQo+IFRoaXMgcmVxdWlyZW1lbnQg
cG9zZXMgYSBjaGFsbGVuZ2UgZm9yIHZpcnR1YWxpemF0aW9uIGZlYXR1cmVzIGxpa2UgdkNQVQ0K
PiBob3RwbHVnLiBUbyBhZGRyZXNzIHRoaXMsIGNoYW5nZXMgdG8gdGhlIEFDUEkgQU1MIGFyZSBu
ZWNlc3NhcnkgdG8gdXBkYXRlIHRoZQ0KPiBgX1NUQS5QUkVTYCAocHJlc2VuY2UpIGFuZCBgX1NU
QS5FTkFgIChlbmFibGVkKSBiaXRzIGFjY29yZGluZ2x5IGR1cmluZyBndWVzdA0KPiBpbml0aWFs
aXphdGlvbiwgYXMgd2VsbCBhcyB3aGVuIHZDUFVzIGFyZSBob3QtcGx1Z2dlZCBvciBob3QtdW5w
bHVnZ2VkLiBUaGUNCj4gcHJlc2VuY2Ugb2YgdW5wbHVnZ2VkIHZDUFVzIG1heSBuZWVkIHRvIGJl
IGRlbGliZXJhdGVseSAqc2ltdWxhdGVkKiBhdCB0aGUgQUNQSQ0KPiBsZXZlbCB0byBtYWludGFp
biBhICpwZXJzaXN0ZW50KiB2aWV3IG9mIHZDUFVzIGZvciB0aGUgZ3Vlc3Qga2VybmVsLg0KPiAN
Cj4gVGhpcyBwYXRjaCBzZXQgaW50cm9kdWNlcyB0aGUgZm9sbG93aW5nIGZlYXR1cmVzOg0KPiAN
Cj4gMS4gQUNQSSBJbnRlcmZhY2Ugd2l0aCBFeHBsaWNpdCBQUkVTRU5UIGFuZCBFTkFCTEVEIENQ
VSBTdGF0ZXM6IEl0IGFsbG93cyB0aGUNCj4gICBndWVzdCBrZXJuZWwgdG8gZXZhbHVhdGUgdGhl
c2Ugc3RhdGVzIHVzaW5nIHRoZSBgX1NUQWAgQUNQSSBtZXRob2QuDQo+IA0KPiAyLiBJbml0aWFs
aXphdGlvbiBvZiBBQ1BJIENQVSBTdGF0ZXM6IFRoZXNlIHN0YXRlcyBhcmUgaW5pdGlhbGl6ZWQg
ZHVyaW5nDQo+ICAgYG1hY2h2aXJ0X2luaXRgIGFuZCB3aGVuIHZDUFVzIGFyZSBob3QtKHVuKXBs
dWdnZWQuIFRoaXMgZW5hYmxlcyBob3RwbHVnZ2FibGUNCj4gICB2Q1BVcyB0byBiZSBleHBvc2Vk
IHRvIHRoZSBndWVzdCBrZXJuZWwgdmlhIEFDUEkuDQo+IA0KPiAzLiBTdXBwb3J0IGZvciBNaWdy
YXRpbmcgQUNQSSBDUFUgU3RhdGVzOiBUaGUgcGF0Y2ggc2V0IGVuc3VyZXMgdGhlIG1pZ3JhdGlv
biBvZg0KPiAgIHRoZSBuZXdseSBpbnRyb2R1Y2VkIGBpc197cHJlc2VudCxlbmFibGVkfWAgQUNQ
SSBDUFUgc3RhdGVzIHRvIHRoZQ0KPiAgIGRlc3RpbmF0aW9uIFZNLg0KPiANCj4gVGhlIGFwcHJv
YWNoIGlzIGZsZXhpYmxlIGVub3VnaCB0byBhY2NvbW1vZGF0ZSBBUk0tbGlrZSBhcmNoaXRlY3R1
cmVzIHRoYXQNCj4gaW50ZW5kIHRvIGltcGxlbWVudCB2Q1BVIGhvdHBsdWcgZnVuY3Rpb25hbGl0
eS4gSXQgaXMgc3VpdGFibGUgZm9yIGFyY2hpdGVjdHVyZXMNCj4gZmFjaW5nIHNpbWlsYXIgY29u
c3RyYWludHMgdG8gQVJNIG9yIHRob3NlIHRoYXQgcGxhbiB0byBpbXBsZW1lbnQgdkNQVQ0KPiBo
b3RwbHVnZ2luZyBpbmRlcGVuZGVudGx5IG9mIGhhcmR3YXJlIHN1cHBvcnQgKGlmIGF2YWlsYWJs
ZSkuDQo+IA0KPiBUaGlzIHBhdGNoIHNldCBpcyBkZXJpdmVkIGZyb20gdGhlIEFSTS1zcGVjaWZp
YyB2Q1BVIGhvdHBsdWcgaW1wbGVtZW50YXRpb24gWzRdDQo+IGFuZCBpbmNsdWRlcyBtaWdyYXRp
b24gY29tcG9uZW50cyBhZGFwdGFibGUgdG8gb3RoZXIgYXJjaGl0ZWN0dXJlcywgZm9sbG93aW5n
DQo+IHN1Z2dlc3Rpb25zIFs1XSBtYWRlIGJ5IElnb3IgTWFtbWVkb3YgPGltYW1tZWRvQHJlZGhh
dC5jb20+Lg0KPiANCj4gSXQgY2FuIGJlIGFwcGxpZWQgaW5kZXBlbmRlbnRseSwgZW5zdXJpbmcg
Y29tcGF0aWJpbGl0eSB3aXRoIGV4aXN0aW5nIGhvdHBsdWcNCj4gc3VwcG9ydCBpbiBvdGhlciBh
cmNoaXRlY3R1cmVzLiBJIGhhdmUgdGVzdGVkIHRoaXMgcGF0Y2ggc2V0IGluIGNvbmp1bmN0aW9u
IHdpdGgNCj4gdGhlIEFSTS1zcGVjaWZpYyB2Q1BVIGhvdHBsdWcgY2hhbmdlcyAoaW5jbHVkZWQg
aW4gdGhlIHVwY29taW5nIFJGQyBWNSBbNl0pLCBhbmQNCj4gZXZlcnl0aGluZyB3b3JrZWQgYXMg
ZXhwZWN0ZWQuIEkga2luZGx5IHJlcXVlc3QgbWFpbnRhaW5lcnMgb2Ygb3RoZXINCj4gYXJjaGl0
ZWN0dXJlcyB0byBwcm92aWRlIGEgIlRlc3RlZC1ieSIgYWZ0ZXIgcnVubmluZyB0aGVpciByZXNw
ZWN0aXZlIHJlZ3Jlc3Npb24NCj4gdGVzdHMuDQo+IA0KPiBNYW55IHRoYW5rcyENCj4gDQo+IA0K
PiBSZWZlcmVuY2VzOg0KPiBbMV0gS1ZNRm9ydW0gMjAyMyBQcmVzZW50YXRpb246IENoYWxsZW5n
ZXMgUmV2aXNpdGVkIGluIFN1cHBvcnRpbmcgVmlydCBDUFUgSG90cGx1ZyBvbg0KPiAgICBhcmNo
aXRlY3R1cmVzIHRoYXQgZG9u4oCZdCBTdXBwb3J0IENQVSBIb3RwbHVnIChsaWtlIEFSTTY0KQ0K
PiAgICBhLiBLZXJuZWwgTGluazogaHR0cHM6Ly9rdm0tZm9ydW0ucWVtdS5vcmcvMjAyMy9LVk0t
Zm9ydW0tY3B1LWhvdHBsdWdfN09KMVl5Si5wZGYNCj4gICAgYi4gUWVtdSBMaW5rOiAgaHR0cHM6
Ly9rdm0tZm9ydW0ucWVtdS5vcmcvMjAyMy9DaGFsbGVuZ2VzX1JldmlzaXRlZF9pbl9TdXBwb3J0
aW5nX1ZpcnRfQ1BVX0hvdHBsdWdfLV9faWkwaU5iMy5wZGYNCj4gWzJdIEtWTUZvcnVtIDIwMjAg
UHJlc2VudGF0aW9uOiBDaGFsbGVuZ2VzIGluIFN1cHBvcnRpbmcgVmlydHVhbCBDUFUgSG90cGx1
ZyBvbg0KPiAgICBTb0MgQmFzZWQgU3lzdGVtcyAobGlrZSBBUk02NCkNCj4gICAgTGluazogaHR0
cHM6Ly9rdm1mb3J1bTIwMjAuc2NoZWQuY29tL2V2ZW50L2VFNG0NCj4gWzNdIENoZWNrIGNvbW1l
bnQgNSBpbiB0aGUgYnVnemlsbGEgZW50cnkNCj4gICAgTGluazogaHR0cHM6Ly9idWd6aWxsYS50
aWFub2NvcmUub3JnL3Nob3dfYnVnLmNnaT9pZD00NDgxI2M1DQo+IFs0XSBbUEFUQ0ggUkZDIFY0
IDAwLzMzXSBTdXBwb3J0IG9mIFZpcnR1YWwgQ1BVIEhvdHBsdWcgZm9yIEFSTXY4IEFyY2gNCj4g
ICAgTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MTAwOTAzMTgx
NS4yNTAwOTYtMS1zYWxpbC5tZWh0YUBodWF3ZWkuY29tL1QvI21mMzJiZTIwM2JhYTU2OGE4NzFk
YzYyNWI3MzJmNjY2YTRjNGYxZTY4DQo+IFs1XSBBcmNoaXRlY3R1cmUgYWdub3N0aWMgQUNQSSBW
TVNEIHN0YXRlIG1pZ3JhdGlvbiAoRGlzY3Vzc2lvbikNCj4gICAgTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDcxNTE1NTQzNi41NzdkMzRjNUBpbWFtbWVkby51
c2Vycy5pcGEucmVkaGF0LmNvbS8NCj4gWzZdIFVwY29taW5nIFJGQyBWNSwgU3VwcG9ydCBvZiBW
aXJ0dWFsIENQVSBIb3RwbHVnIGZvciBBUk12OCBBcmNoDQo+ICAgIExpbms6IGh0dHBzOi8vZ2l0
aHViLmNvbS9zYWxpbC1tZWh0YS9xZW11L2NvbW1pdHMvdmlydC1jcHVocC1hcm12OC9yZmMtdjUN
Cj4gDQo+IFNhbGlsIE1laHRhICg0KToNCj4gIGh3L2FjcGk6IEluaXRpYWxpemUgQUNQSSBIb3Rw
bHVnIENQVSBTdGF0dXMgd2l0aCBTdXBwb3J0IGZvciB2Q1BVDQo+ICAgIGBQZXJzaXN0ZW5jZWAN
Cj4gIGh3L2FjcGk6IFVwZGF0ZSBBQ1BJIENQVSBTdGF0dXMgYGlzX3twcmVzZW50LCBlbmFibGVk
fWAgZHVyaW5nIHZDUFUNCj4gICAgaG90KHVuKXBsdWcNCj4gIGh3L2FjcGk6IFJlZmxlY3QgQUNQ
SSB2Q1BVIHtwcmVzZW50LGVuYWJsZWR9IHN0YXRlcyBpbiBBQ1BJDQo+ICAgIF9TVEEue1BSRVMs
RU5BfSBCaXRzDQo+ICBody9hY3BpOiBQb3B1bGF0ZSB2Q1BVIEhvdHBsdWcgVk1TRCB0byBtaWdy
YXRlIGBpc197cHJlc2VudCxlbmFibGVkfWANCj4gICAgc3RhdGVzDQo+IA0KPiBjcHUtdGFyZ2V0
LmMgICAgICAgICBwYXRjaGVzLnZjcHVocC5yZmMtdjUuYXJjaC5hZ25vc3RpYy5hY3BpICAgICAg
ICAgIHwgIDEgKw0KPiBody9hY3BpL2NwdS5jICAgICAgICAgICAgICAgICAgfCA3MCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+IGh3L2FjcGkvZ2VuZXJpY19ldmVudF9kZXZp
Y2UuYyB8IDExICsrKysrKw0KPiBpbmNsdWRlL2h3L2FjcGkvY3B1LmggICAgICAgICAgfCAyMSAr
KysrKysrKysrDQo+IGluY2x1ZGUvaHcvY29yZS9jcHUuaCAgICAgICAgICB8IDIxICsrKysrKysr
KysNCj4gNSBmaWxlcyBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gDQo+IC0tIA0KPiAyLjM0LjENCj4gDQoNCg==

