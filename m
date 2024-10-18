Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC862D3E180
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 19:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1sSM-0001V7-Mo; Fri, 18 Oct 2024 15:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1sSK-0001Ui-9p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 15:16:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t1sSH-0000K7-Gy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 15:16:12 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIfjm9004628;
 Fri, 18 Oct 2024 19:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=hcFPRqvcM87EWWRqqU24gI4p/IgwCiJeYAmFZDYaT3o=; b=
 alg+l0ghEsSnfL/Oue32DZOKzPqfZOB5Vqn/LTvyv6FTXaeQhgl9usZH+EGoljiU
 ZJndVWuxdzpD5wV6M1QSaSN/iOg6xMWW7tZo3aiTOiwTBmeruSd6ePZQda0XHDs/
 h5i+aPUkQE0PK0LlGfDLauiAZwIOUu7ccpow2y71iZ0fKliW1USXavj6n+lfaXIC
 AAk9Bmoy9ySQSaSVVfyND51X44AApY6OomJ6VRILowkjIYfTtjadhBBnev+IHC59
 3GMWn540cRhEAn0G8qb3ZtkYXTXKlDitMBFagkT72bUnRNqunOuoddwfTiidrmpD
 No0IVwQ7fnFKO2QwApzLZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1asahm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 19:16:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49IHsnuk027163; Fri, 18 Oct 2024 19:16:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 427fjjkhn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 19:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eo/BMj6twsk01LT1WyyS7xXO16O4E20bcP8J1LILI5/k/FASUEYWN57/5p2w/bC5zgwrKRQyCCxXsf/mj3GBR17rPZQar5fTb73TbvznjBabtooGpRJA5SjhAeSL+Pw56xhtqBMUnRl8+ZnoO5DObqbcCZoD3zZx80nVX5FBRRWam1ACJAkVTJQ1FQbmofvOAT1Hn5Wa+P4ORfenKihjkm8EGolhgoVZWXXRBuPAuXuYc29VodL18ezzblSC78aq9rVojpQlekTfEOl8HClXYl2ujd8ZN1md+M0LcH6/MDC8FlHjFSqSMN9/y668SuIelLy52jbnF1vfmfVDU4Lfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcFPRqvcM87EWWRqqU24gI4p/IgwCiJeYAmFZDYaT3o=;
 b=Dm3OewyrYRGKRxhub45mTgkLmHBlM4RIESWb7m43Y0I+ZJqLBevPXThqEZoZkWfjiogxy1vvwyHPbJikIPgSyv2LrYErAq9z68xlc8+b3K3djzt4EyihcXt9J52l+PNppZZekRR7BZSPi9j3muTk0mUWD4ipsNeNSU+YLzaRqsaYEj5c8ZNKFmMsbUorKBtZ8NHKsalcobfmmQnoO+xIRTlR8i9wKyxdJRwJPVNp2V1nbLMTO75lb3Ss9ORTwcO34oDp6fMzzC2A/Y9lEoqffqkivdmIRcvzPJPkevEyUTuwYP1d2MVl/qbwOXmPoQn631rdPThXL59iCIio+nFH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hcFPRqvcM87EWWRqqU24gI4p/IgwCiJeYAmFZDYaT3o=;
 b=Any3JZ7TIcd3ST8sdmaMD2M/6AosK7DrsVlASNxqR/EYUC+P7Ai0oYKY4u2oqOy0fU0uI/Xo5rpGVs73l1L6LGOaL3aAOWtSTle0HtxnbLA43IPqqOjGEnJmnBz72J1JXefjwoE5spi5wohU3dRVoTWQ/rNbTuDqDHj9TXEO9MY=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 19:15:58 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 19:15:58 +0000
Message-ID: <3da9ec87-3466-4fad-b4c0-2bcfe3853b5a@oracle.com>
Date: Fri, 18 Oct 2024 15:15:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
From: Steven Sistare <steven.sistare@oracle.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <87ldyl1mah.fsf@suse.de> <628ceba7-9cf4-4ad2-b3e5-6af4037a0bc1@oracle.com>
 <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <4c0645c9-a38b-4399-ba30-cf2ced63fc5e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:408:f5::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b556f74-ea83-487f-ff93-08dcefa94bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmljOGdXbUpVa1k3ZVZicHIxN3RxTmhKRW5lM254UHNrblBMR0J1NkJDQnJi?=
 =?utf-8?B?UXc3NEh2cFNIaHZCaHA5bTBuREcvTk5lUTBkSGNsaERPNVk3dVlEcUdBUmRM?=
 =?utf-8?B?S2M1bm9UczNwQ01NRFRNc2VLY1VsRmJPUFdZOEFhdmU2MWlaNGJacFBiS3Vr?=
 =?utf-8?B?dnJIdXpBT1NkVk5lTjA5bWJYaysvcmpJakNrOFlWNEpELytRQ0NEMEc2a1ly?=
 =?utf-8?B?QTgyM3BBU0xYRFNNL0t5M2lFMStrVFl5LzJTdGtiSncrRGtqV3hQbXB6Vmpq?=
 =?utf-8?B?bW1NaHNHSHhsbERWUHhxRG1aTjFRbENQbUlPMThoamRBcDRzSXJFU0pCMHdK?=
 =?utf-8?B?NXdPbC9IN05HZXg3ellxR0w5WVNpUThKaC93WXp1cTgzbmRNUEdWU3QxalpU?=
 =?utf-8?B?cFdETUlZZjBXdk5Dd0FXdUJNK3NvM1NIRjVlQlA3Z0NZWDNscmZLQUM1cGd2?=
 =?utf-8?B?ZHFqUzdkQ2J6TWI4eGs1SWcrcG5UZXU0VWM1eFk3SzJteW8yVGRaWVR5aDRL?=
 =?utf-8?B?QlRjMlkxdVI2ZnpIcmNMWm5ZSVR3VkYwOXVJcGg1cG0zc3dnYmFKV0lWSFZp?=
 =?utf-8?B?U0N4UC9Ha01OR2V5NG9nZ3ZuN1RtTGtvQjBWVWR0dW5DSEZXTlMrckRuaEpk?=
 =?utf-8?B?S0QxQkN4UjkzdjhEVGJJYXg2Y05GSXFaNVBITlBOWk5MUkVHK2Z3ek5jM3R0?=
 =?utf-8?B?eStGVFN4aUxDUGZjN0NHYTQ3WStlQlhuY1Z2OEJaby9oSmVGbFNtcTk5d1R0?=
 =?utf-8?B?anNVRDJ3amV0c0w2aVNFbGwxOVZrK2VQY0dDa2UySTJxOTBVUkErT3ZZZFY1?=
 =?utf-8?B?NTdxdklsTVlxazNMZlgwQWhzcktZSlhVa1I3a2dyb1NmUlRBRG5IdDlwaldC?=
 =?utf-8?B?UGZvR3Q3Q1lZMzRjOXczVkpYcVFVeVFxb2hmWnFoWVJOd0lMazdBdUxpUCsx?=
 =?utf-8?B?K3Q5VXRJTVN4WnEweVg4L2l5TVYxV3FIdFphNy85akJLT0VIbmdhdmtyaFBB?=
 =?utf-8?B?VWpNbDZ4a3VhU2pvMTJ2YnhRdjhQcTlvMnRpTUpJU0E2RGZvVE5wMmwralFC?=
 =?utf-8?B?TVBQeHRGVUZKU1UrVjY5ZEM4NDROOGtJSkRHVnNhc3VyMjJtMm96eWRmV0Vo?=
 =?utf-8?B?K1dGUXdCRkl6U1RMYlNOZmQrSW5yM0Exb3ZKdytoWjJsRXI2eG5yNmhXWlda?=
 =?utf-8?B?Wnl2N3V4SnBpTk93dDRVNzhWQ3BuL0liWjZRd2FMcDkxdjhXbnJtRFJjMVhk?=
 =?utf-8?B?c1grSU1NSXhHYVZ5TU9rdHF0c3ZwRVFGY2xTZm1FYTNWcjJuSExJVU9qakY5?=
 =?utf-8?B?SndmQ2o1UUxqOFdRdzhrY2FqdlpRNmxxaExQTzVncTV2aXU5cks5a2VPNGwx?=
 =?utf-8?B?b1E3MVNHM0FiclowSG9nYlRUSFdaWjdGaFgzMEhVVGM1dnFMRXZHTCt4NGY4?=
 =?utf-8?B?ZUlXN3Y2ODU1ajVDY09XalRVbE1Ocjh4NjUrUnN5THA0VUpJak0xUEc2L1BQ?=
 =?utf-8?B?L0VPaXBldklKYXRxNUtrS3NVcEhnWkpoZWFnUHpld0NWWWNYYzlzK0lCNlEx?=
 =?utf-8?B?UGdrd2l0WGtodHRUT2xlVmxGTXFua2IvSVdiYjYrbGdQVmJmMzh1dG5McG5H?=
 =?utf-8?B?b3MzWUg3OThSdmpKUHRRVHFwRTZCNG1hZWRjSnN4Si9BdXhMNlNETzNZK0cw?=
 =?utf-8?B?a2lnd0JpMGw3YW5SWHM5RGdIekJxY2dqVjRTZFl6ZGhuUkxJMjV6NjlpbURH?=
 =?utf-8?Q?zIUQ2Ij4ca7YMpZIQ68j5AZKqY5queUGV2FUcnl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRRNzhhMlh3SHg2dGxuYndEWWlEMEo3V24yZHdtbm1qY0VJUFl5VG5Qd3F6?=
 =?utf-8?B?cWU4Ty9PeGtnVGlSd0RrV0lrM3ZvTFZaSVlWZUtOQ3BPcUtmeGNhQ0ZOSHZj?=
 =?utf-8?B?MDNYRnFWb1FJSEpEbjlESkQ4R2F0TmZySTJyYlIyZUEwWk9jMm0zaEc1OTF6?=
 =?utf-8?B?SE1oOThMRGZyUGtaVEdoQkpUbWxQYzlGcVBpREJGTk50UzA0cGF4S0lGTFdT?=
 =?utf-8?B?akVrQlVOemNkMWJwTGF0V2pUeXY1dWNxU2R6NlRlTTN0WEpHckVFVGFua0pH?=
 =?utf-8?B?VDcvREtQeEtLVjN3U2h0eG5CWEhpUmt6a0NFRERCSVNFWjNpZHVFdVlCYzRG?=
 =?utf-8?B?eXJsb3BJMmlIalI4UHhncGJnQnoxb3YxY3RsWGxCbHRCZ3RYay84ZUZ6NjVo?=
 =?utf-8?B?cHRWdWE2TFZTQzFpa01ud3U1TFUrOVR1NkFJeXVIalBDZ1kwTTZ2d3lpdEtI?=
 =?utf-8?B?ak9yNmcxRXpOMm5SNzgzTEpVcEJpdnk5WCt0RTV5QUlnYjd5QmtCQmgrWjhD?=
 =?utf-8?B?Q1phLzVIU1UwWWJueUdVVERqaXhDQUVSK3FiYWhjKzBhdWZDdUdueDJHNTVZ?=
 =?utf-8?B?WHJCTUljMFRxUDUzQkZORW0xYzBBZHk4Z1M3ZUNHdktyTzJ6MUNjSExpdFJn?=
 =?utf-8?B?UGs1bWJkZGZTeGthZ1ZqWDRTWVBkaUIzYStMa1Y3RmVadnVMeUZOV0JLeUg1?=
 =?utf-8?B?VURNNmk3VHZXYTQzTTJjWXg0YWtXc3VwNDEvSkltdkpXa3JyOW0xMFZzR0h2?=
 =?utf-8?B?ejFKZU9LNTdGSU01QVhudE5renBIOGZUaVZ5bm5hc0ZRN1lhWmY3Qk9yZXZy?=
 =?utf-8?B?Wk1md01SVy9YdFRuZnlPZUpiVUpyMlozUE92UXYyUWNHK3E4WFkrREgxbzNT?=
 =?utf-8?B?YnRmL0hlUTliYThVTFdHL3lyaWVYYmtkWllNdVpvOWd5SE1JMjEwLzhCY1c4?=
 =?utf-8?B?TlZoc2s2WjlEV3lmenpMYW1sNXZDaE1CVCs2b0FLa0RhY05XZWRxR0Z5MmVB?=
 =?utf-8?B?eStiUzc1TGJFdXBGVkI3SzNiSkk1ZHdsR1RIZVhOeVlNc0ZoUkEzM2tRUTZ0?=
 =?utf-8?B?akR6S0gvWUphcGUxcGMwVFhLRW5iK3plMEkra2xWY2dJWnZjOGYrN3NzNkRH?=
 =?utf-8?B?VC9uMEpwdmZaaFFhanNBOUh5TDEwSnpaMEVhdVhyN2Z0UG02V090ZDIzL3R0?=
 =?utf-8?B?cXduUEx5MndZa2ttZkUxaVpIeitXcndDMTlmbDRkSWF4RnBjMDJGTTd0SXUv?=
 =?utf-8?B?L1R0OFc3d1VZSDgvWW5yRlR6NUlDeWoxWHFoZXVEU1Brb1N0SU9hL0ZrMkFD?=
 =?utf-8?B?Um1kVmNVcllhZWZPZkl6KzcybWN5RVJWNm84YjNqODB3dUZxeXFkNlhvQW83?=
 =?utf-8?B?L0RPM3JRZjJOQTZsaVFiMVozY1l4bmdXR1p0VGFtY0Z6LzExa095UlFHRktl?=
 =?utf-8?B?UGgwdzRmdWpBWU40eGRYV2Z5NU9Rck4wUW8ralJuNWtjTE5SY3dReG5Xa05Z?=
 =?utf-8?B?dU1zYkZkT1g5djJhNlJvbi84ZWVFcGEyTi9SM1VubkxhMzUvejFPMEhGY2xt?=
 =?utf-8?B?OTA0ZDdvMzVaZGhUVWRKaHhtcHFOOVZOdHB1dHRaRTdIVVhaS2p1OHdsTC96?=
 =?utf-8?B?MHV0WFp5NWVsUjhpbHlNK2hOV25WQzd2bkJYanFzY0FDamRjS1U2TDNLQ2FU?=
 =?utf-8?B?bklobnI5MGZqU3VQUERSSjNzci9YaDNnUUsrekJrSWZnZXJaUk00OFc4NFVO?=
 =?utf-8?B?VEJVd0JFVHVGN0NqOG1jTW83RDRpSCtLd2pSOUhYSW9zaUhxZzdTK1pEaDNm?=
 =?utf-8?B?c0N0TGloMFUwdWFENEhMYkZOSnNFNVQrQ2dLTjdRMEdVWjlIVW1SbUR3SHBQ?=
 =?utf-8?B?RTNSSlpweHlFMGtMRTdMbFRFUFpoZ3hubWNDeXpyakRyVHViT3BKaDZORGJC?=
 =?utf-8?B?VGxZd1dGSkNFZXd3NE9qUGNEWERMa1d3ZGx0V3I1TWZ4RXNpU1RSTVYxb2Za?=
 =?utf-8?B?VVRPdzhkMlUvL29zOXlwMDdPMFkwRGkzVVlpczZ4ZWRRRy9Qb2pUUFdRazhi?=
 =?utf-8?B?STVsWjBNeWVKNFlsUXZ1YVg3K1lwTzhHQkViVVNlYk9BSlJockR3RmhlQW8v?=
 =?utf-8?B?Yzh4YnRXTjdDSzlNQlhRTmJZQldIWldhSkoyejlvQXZQbHZycW8vSFFiUS9C?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bpoMQBZTUpfPNg5aMze6imM0A8cLgOP8Msl8guZeAiCPor+vrwtco/BSOFUQzHIInQpHKvs5UAEltU09LJViu/2SSI3ihcc+iOTscD1egY68pIt6H3a9lKXea797vCUmGWnLZF6EwIT4rdDved4nKEgHQTxxyFQWBu93Cs6f3h9MKRZqoj6ROCKvOOL/5nxMiIB96dXoT/zD+953X1d+hiTVlfaivPWm5+Dc1EelP9b4tcKBSVBrMS5nDTvhQZ372MbiOl5YBZrqsWZgwJOkJLaY9WHqSSKuThPRqKsOAF+rwxqPr6yI9VtL28COQW03CEGOCE29mG4Y1d5xJy7f4csxS1sj3hrqtlZCqf5IPB8B9KfSqx3R8R4Mc//2tKQTG395GjBWrhEFWwgoxBgQwuadQyE0BlAO8SYq0GtslsslYi2WJ/kmykHhSMW6rfQkyIRP+lAb+LxS4BNGSwBsxwp/jPqiwhxLKwZefKOiFgtuGgVCjUITcnM4VU2NN6ymkih3zmTwoQZuHz1i6FFcp9V6CVbvShRbaHhyGDbtJxCuRlpx/e9aCJkgblOHASIqYSv5+ir0O2j2H0exaLWoZ5nnnPdR44sFvG3zX/yzpMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b556f74-ea83-487f-ff93-08dcefa94bb4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:15:57.9855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4c6Jm9BCw4XN2dA434NPFzQpstzK0Eo3ZTGFCnNRXdlgAmTsP/ktXwgu6Y95E76m6Nn9V70Q6ASmC0Q9Z1i1yaQnmIFt416LnO3+/1VKAW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180122
X-Proofpoint-GUID: ormxHeADGyjYiXQ1PiS1nKKkKH1Olwi8
X-Proofpoint-ORIG-GUID: ormxHeADGyjYiXQ1PiS1nKKkKH1Olwi8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/18/2024 11:40 AM, Steven Sistare wrote:
> On 10/18/2024 11:32 AM, Steven Sistare wrote:
>> On 10/18/2024 11:08 AM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Make all global and compat properties available before the first objects
>>>> are created.  Set accelerator compatibility properties in
>>>> configure_accelerators, when the accelerator is chosen, and call
>>>> configure_accelerators earlier.  Set machine options earlier.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>   accel/accel-system.c |  2 --
>>>>   system/vl.c          | 34 ++++++++++++++++++----------------
>>>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>>>> index f6c947d..c8aeae4 100644
>>>> --- a/accel/accel-system.c
>>>> +++ b/accel/accel-system.c
>>>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>>>           ms->accelerator = NULL;
>>>>           *(acc->allowed) = false;
>>>>           object_unref(OBJECT(accel));
>>>> -    } else {
>>>> -        object_set_accelerator_compat_props(acc->compat_props);
>>>>       }
>>>>       return ret;
>>>>   }
>>>> diff --git a/system/vl.c b/system/vl.c
>>>> index b94a6b9..bca2292 100644
>>>> --- a/system/vl.c
>>>> +++ b/system/vl.c
>>>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>>>           goto bad;
>>>>       }
>>>> +    object_set_accelerator_compat_props(ac->compat_props);
>>>>       acs->accel = accel;
>>>>       return 1;
>>>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>>>       parse_memory_options();
>>>>       qemu_create_machine(machine_opts_dict);
>>>> -
>>>> -    suspend_mux_open();
>>>> -
>>>> -    qemu_disable_default_devices();
>>>> -    qemu_setup_display();
>>>> -    qemu_create_default_devices();
>>>> -    qemu_create_early_backends();
>>>> -
>>>>       qemu_apply_legacy_machine_options(machine_opts_dict);
>>>>       qemu_apply_machine_options(machine_opts_dict);
>>>>       qobject_unref(machine_opts_dict);
>>>> -    phase_advance(PHASE_MACHINE_CREATED);
>>>> -    /*
>>>> -     * Note: uses machine properties such as kernel-irqchip, must run
>>>> -     * after qemu_apply_machine_options.
>>>> -     */
>>>>       accel = configure_accelerators(argv[0]);
>>>> -    create_accelerator(accel);
>>>> -    phase_advance(PHASE_ACCEL_CREATED);
>>>>       /*
>>>> -     * Beware, QOM objects created before this point miss global and
>>>> +     * QOM objects created after this point see all global and
>>>>        * compat properties.
>>>>        *
>>>>        * Global properties get set up by qdev_prop_register_global(),
>>>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>>>        * called from do_configure_accelerator().
>>>>        */
>>>> +    suspend_mux_open();
>>>> +
>>>> +    qemu_disable_default_devices();
>>>> +    qemu_setup_display();
>>>> +    qemu_create_default_devices();
>>>> +    qemu_create_early_backends();
>>>> +
>>>> +    phase_advance(PHASE_MACHINE_CREATED);
>>>> +
>>>> +    /*
>>>> +     * Note: uses machine properties such as kernel-irqchip, must run
>>>> +     * after qemu_apply_machine_options.
>>>> +     */
>>>> +    create_accelerator(accel);
>>>> +    phase_advance(PHASE_ACCEL_CREATED);
>>>> +
>>>>       machine_class = MACHINE_GET_CLASS(current_machine);
>>>>       if (!qtest_enabled() && machine_class->deprecation_reason) {
>>>>           warn_report("Machine type '%s' is deprecated: %s",
>>>
>>> Hi Steve,
>>>
>>> after this commit:
>>>
>>> $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/xlnx-can-test
>>> # random seed: R02Saf9b44f2d88dd417052905692ee79981
>>> 1..5
>>> # Start of aarch64 tests
>>> # Start of net tests
>>> # Start of can tests
>>> # starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-2396.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-2396.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine xlnx-zcu102 -object can-bus,id=canbus -machine canbus0=canbus -machine canbus1=canbus -accel qtest
>>> qemu-system-aarch64: Device 'canbus' not found
>>>
>>> I tried briefly to figure out what the issue is, but I don't really
>>> understand the dependencies involved. Hope you can tell us.
>>
>> Thanks! I forgot to define the preinit method for the qtest accelerator in patch 1.
>> I'll verify that fixes the problem and send you a one-off patch if you want to continue
>> testing.
> 
> Actually that is not a problem.  qtest qtest_init_accel does nothing, so preinit will do
> nothing, so it is OK to not define preinit.
> 
> Still looking.

I understand this now.  The old code worked in this order:

   qemu_create_early_backends()
     ... creates "-object can-bus,id=canbus"
   qemu_create_machine()
   qemu_apply_machine_options()
     applies link property "canbus0" with value canbus, finds canbus object

The new code fails:

   qemu_create_machine()
   qemu_apply_machine_options()
     applies link property "canbus0" with value canbus,
     error because fails to find canbus object
   ...
   qemu_exit_precreate()
     qemu_create_early_backends()
       ... creates "-object can-bus,id=canbus"

The fix is to provide a new function, called before qemu_create_machine,
which creates only the backends that are needed to create the machine.
AFAIK can-bus is the only one, because the xlnx-zcu102 machine has
link properties.

- Steve


