Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887ECCEFC21
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCEb-0002yM-JH; Tue, 08 Oct 2024 11:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syCES-0002x6-0U; Tue, 08 Oct 2024 11:34:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1syCEN-0001uc-B4; Tue, 08 Oct 2024 11:34:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtcTK009059;
 Tue, 8 Oct 2024 15:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2023-11-20; bh=HMU5bbLYuV0mk+yW38
 tPkeDFbSYhRQPYCtSjnVsyOek=; b=HV3f7ZgWJOxe/cKS5ar1yob6w1UEuzhqqh
 BnsxHI7yRWZGsI0Ry3ZWLwmAP3yhVwrGZVIojBtHT7iFmNvXslQSYVuCO8tyTNAB
 nWTodlSa5beXgWUDjOCfH/Ox4FCuHf8/mhY8q/BHeJIBOIf9HQPW9T0jpw/dkB3f
 c4Ni+Sahm31xm82xO4jCqtdYFscH5YAVqNh191eXHC43jBX6dtQi8zpV1A4UBjhq
 EYPr+RBWRvQoTX30BNIBgUOw8XYE2anQoJx+i+p2rL/liZNfd+bKSHQ65CP4TvxZ
 uW7Gevhk7H00TOWqGFR2xF7iizDvWIRfnPw7LQ4rlbk09kQ+DvFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pe15x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:34:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498FJLUK003251; Tue, 8 Oct 2024 15:34:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwdmj1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:34:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbaPnkQds5gK7XvZSPoLq9R/vrfI9hjzq8F90hCwKOyA+QBbQAZu9rwrAbsCzMOYsfWtt4qz5X24Ru9TRhR8ECxC9TCx8Rxp/ZudpPNlWzs0Ys6KqzjJtCTD2XuC7vTuIysqQHJsUEj1iItZq1njFfp+tvy1mSbrylLjl7ZhVcvBAu9zmsFbox1Sg86Gdz9Rsy0w+WsebquRtch4QjocraP9qObsozaE9eyMTiUCMzayAHAeUtCe4nwRBN+yRLUBgQ8+NRMIXAlBxT+IrNJFz/2BdUYrg3VH113YqG0Pws7Ea0P89EFDHeIfo+gC9TZW5lGSwd/Q0IYVfUTUN8vTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMU5bbLYuV0mk+yW38tPkeDFbSYhRQPYCtSjnVsyOek=;
 b=iEadYLGmaTdFO2rkYRvHl+LBg8cnVWts2R8bK8jJHzN9hxPcqtCv2hz5ZNAXOC7t/Slr+Y5z0LZOKfm4cuGAKZ01T03IOfmD8JMvv1aGqOqedM1r+uadosBvHLt1ver97I+QJVjYHHYHPAT9GJckFQNT1YO1TPgGPPmQv+hBjRBTqrb5RrlHiDtXHW3erbwzDV/8BUo+9r5jgpGzbrm7wz7zbpR9pakI+qzs+HKFqYzcDchexXzzgOK7S1y0PmrUoKk+cIrQlhCm3J1xolZGnQBpV9/EZBSxhH3L6ZMYu8rUqUlQf7QfgAb7SMkdlQlA6WZVhQ0rKyP/1pd97GFqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMU5bbLYuV0mk+yW38tPkeDFbSYhRQPYCtSjnVsyOek=;
 b=qYvSDLk93s4EjULXiNakmhGP7rWbGWWPJZOUVS+ekT4p41QJB3p6QPQhBTATAHnLoL3qC9/+W7kZzkA5b2ULwH3LKvZp62JmtAiPRFgPOTN3Rdv6yVN+uhXi8Bir3Sif+Z3OY+9StR2cXpETubW9d6TPfeT4dFs2AWh2y+IlF4M=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by CO1PR10MB4771.namprd10.prod.outlook.com (2603:10b6:303:95::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 8 Oct
 2024 15:33:59 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8048.013; Tue, 8 Oct 2024
 15:33:59 +0000
Content-Type: multipart/alternative;
 boundary="------------UhTmsb0bCQVzDmfDkFqX8cHW"
Message-ID: <688859f2-5d06-4012-8872-340085144a3e@oracle.com>
Date: Tue, 8 Oct 2024 11:33:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 PATCH 04/11] acpi: Support Control Method sleep button
 for x86
To: Igor Mammedov <imammedo@redhat.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-5-annie.li@oracle.com>
 <20241007153236.2b4d3ad6@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20241007153236.2b4d3ad6@imammedo.users.ipa.redhat.com>
X-ClientProxiedBy: AM0PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:208:136::24) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|CO1PR10MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bdb7d6-e400-4aae-4f3e-08dce7aea0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mmx1MnIrUWNnQjBXa2JOc1FYUDNOSHZBWFhONlN6b3NiTHFWT001RG5aOHNF?=
 =?utf-8?B?ZEd1QzNCK3pVYkNETWhnTnBDdUZZLzBZamFneHB3UlBpRmZreTZRcmZBYnpY?=
 =?utf-8?B?OEtBN2ZNMVdqM2FDMXY0NjJ1eXZHYU5lVk5oRktDS0YrWjZHdGlJeDRMVlFl?=
 =?utf-8?B?UHkydGg2Q0JtN2RpV2dMeUZQSHpRbiswL0tjT3lmL3VmWVgyb2ZnaDJZYkFm?=
 =?utf-8?B?ZkYrM0tDRWU1Snlnei9TS2M5N2MzczZWSTk2MElabkJ3Wm8wMGZpMVAza1lj?=
 =?utf-8?B?TVAzT2drRlVScFFKcFlMR1kwb0E2Z2ZZdGlyWWJqQmhVc0NLMFFwMEVRKzNx?=
 =?utf-8?B?azZqTWRLKzZHdXF4QU8zaGxVbHB1M1IxbTRQYVlQdW9XaEV0VGk3MFVwT3ll?=
 =?utf-8?B?b3pKNERUUXZkRnY1MHMvem5VZG5WQ0RIYWdaZmNhZld4TE9kWlZjSllLWHIy?=
 =?utf-8?B?Y3c3V2JXOU5RZFBlZGwzOXlqTnN1Ny9GdElwK25VWXhnbHd4Z1NQK2lEbFBE?=
 =?utf-8?B?aFh5SXg4UEV0a1B2TnYrZmV6cDlPd1hOOGtZTWZjL3FuQmFvQnptM3lwaVNl?=
 =?utf-8?B?TWEwbFI4d2pLMGxxd2s1WFlCL1c5dFlNR1g4VHVRMzgwQldPUXp5WGx1eVpL?=
 =?utf-8?B?RHZYYncvZzY2dE1oK3VSdVg3NFdBZGx2a3JaaFoxK0NsL3FpVWZ0M25FNVJl?=
 =?utf-8?B?K0ZvTXRUeXBXeVYxdXZwaGYzSjNlU1NBUTRjeDczazZxaUJhRVdVNlFSTFpW?=
 =?utf-8?B?bUxybkVwWnpyeEY2RXJzUk90aGlSQU1DYlJoRkxpL3BLMEdpb3ZiWjhlLzhI?=
 =?utf-8?B?ODdCUnhKRGZFLytWSi9sQUdGei94VmZqenhod045c0I3VS9Qekl1aXdmV1Fa?=
 =?utf-8?B?RGNuUVJjajZJYWxqTzY1OU1MZGdwQnJuRGJNYjNKTlNYZGoreEdDM2ZyLzNG?=
 =?utf-8?B?N2x5MzViTVpkMGdqM0h5NUxOMVRJYXJwTUtxZ2o3ZVNZS1Yzcll5azN3TDQ5?=
 =?utf-8?B?M1lHTTh0WXA1MjhkajBxODREOEZ3VWxySjJ3Vnh2dy9pc2l5Vm8raWRzWmhn?=
 =?utf-8?B?RFh2QjM4UGhDY0pyTEIvMXRrTUlIQ3lEbjMvcnEzZVYzcFZVOUZhYjl3QU9G?=
 =?utf-8?B?MHJvcVpJVVpxR2gyYXJkZVMvVkRreHUvcWttbjB5YTBNVkFOQWY2dUFudzA0?=
 =?utf-8?B?d0JXTHlQMFdvYjJxcWV4cTE5OXlKaFEzeCsvZXk2L2FUcFdLRTZQMkJhUTNu?=
 =?utf-8?B?eVBaUTBSQVlVdFZOYUcxTElnU3MxMElTWlJrNFIzRWxhcEV1VXM0T1FOZGUy?=
 =?utf-8?B?U0FEeXNnRjI5WG0vWHRydk5Bbk5KZ0k5NUNIMVBvcy8yUXh1WkZFT01uWm1Q?=
 =?utf-8?B?c0kwSFdIdXpDZFc2QnlQN1NyREZ0d2tYYUw2NUdSMkJOTWpZL3FKdmtYYThh?=
 =?utf-8?B?RHgxTyt5dzBOY2ZkdFBKelFGNjBzb3YvdFJ4dExpY1dmSC85MmN5RzYyZFdH?=
 =?utf-8?B?QWl6UGNIYU9Tc2hSdkdmQit6VmdOTjZUc2JJZGNzWHUxT0RBM3RSaHBUdUQy?=
 =?utf-8?B?TDkzRW1sNlBTdTNzT2NDUTF0YzdvcGp0RzdkbEgyZ05XdFM5TDhqRU1aLzVT?=
 =?utf-8?B?SUc4YjBRK2trc3p4S3dnRDJBQjlyY3lWditFazJKVUxDaks1K1BiRVptOEtQ?=
 =?utf-8?B?M2FNaE1xN2JxQjMyNUFsdkNiOVBnK0U1aU9UWmR4RERNeG1Zb0hyVTNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGs1SlozOTVSUkpiZ205R216UzlNL0hmamh5b2NFMFpvM0lmY1BmSHpzRVlV?=
 =?utf-8?B?ZGd4NklFTHcvNm5ZZEI5QjZiM2RhTnZPOHhtbTNIZ3lUMmYrRXJpUzN6NmNm?=
 =?utf-8?B?RUFISko5VXlBTUdTenVXVE13ZGtRZERXbXJNTlhWNHEwM0JtZTF5R0I3VkMy?=
 =?utf-8?B?eXNOV0ZwRnZIM0EydVNkVWo1TDhpZEdYQXlyaWVodkFTcnU0OE5Qc1RDWUhx?=
 =?utf-8?B?c2VmVWhpNEZzNkF5ekRxTktoS1NjWnhFNWF0dTdFdmxvNzE3VVZEUEZELytB?=
 =?utf-8?B?d0lQbUt2MldxSGRob1ZMQ21WZHBESndIRFQrUjlsWDBhSWIrRkF6cnhjVXJ3?=
 =?utf-8?B?VlVkamZnaUVkRFZrTWVKckYzMVZreFB3WWQwSE5OVTYxc1M0dVhXNGhhMDdx?=
 =?utf-8?B?Wmo2ZXhnQ0UvWkhrUm5TUHJUbzg4ZU1TRkZoc1pkdnUxL0k0UXZPZkNid0Q3?=
 =?utf-8?B?cmJzRS9mTTUydFV0RTlySCtRWkMrUkVURFRBbk5YcWYzY1NvZ2V6ZUZGekJD?=
 =?utf-8?B?Wi84Z3NtT0VWdllNSnpRRVI3VHVCMjRvc2czU1hLSDZTbE0wbVJxNDBRYjJt?=
 =?utf-8?B?amMxVk85ZzVZRFNydUlJWGdJTWt4ZUVIVkxMMVNaYUZjRG85SER5bXJBN3NX?=
 =?utf-8?B?aVNCMFMzVlRDb0VHelg5U0hyZGt6Z3Boc0c0dkZMVVdaVk04Y2lVOWRIUEFk?=
 =?utf-8?B?djFnN2tqZ0d3QnBTNUdrMmRzTU9QRmJUZVFQcWY1SHdwMGo4K2t0THBSL0Q4?=
 =?utf-8?B?dDRpcTVDVm9kS21uWUUxNXRiMkErTFNBR2ErU3oxdmttQ2lidi9wUW8xOG01?=
 =?utf-8?B?UXRrTmRhWkxMRUF2aE5RY1dkeE5uZll5Q2ROUmdjcXpaekVOTmJQKzFPTlF5?=
 =?utf-8?B?d1BqU1d3a2FwRDRzUityOE94RjAvVGx6T3Y5ZndJZzhQcHNTQUtvRm94eDhN?=
 =?utf-8?B?SVZGdUZDQVFFY3FKYURXa1p6Ti9xYWlOZ0N2NFI4MDc2Y3JiM3BXVVo3WG52?=
 =?utf-8?B?LzJTZDhrc2RwNC9TdWdhcTRkY0NZUnNERlcxK2NGNXk4UFpEL0NkRy9YZDEy?=
 =?utf-8?B?dlBiOGNpU2h5VERHVVh0TnlBZFhuUW1kUXF2UEI4WDdjZENqQVBkdWk4dHQ3?=
 =?utf-8?B?a2lYeGtNNThWOEdxcE9XSTduY0F6eGRaUWNvTGlSQVRTOS90dVkyTExnMm9Y?=
 =?utf-8?B?aWthVmlwSFUvMFF2amh1NStFRFFkUzZvZExodXdhdGZkMUJuMEV0VXdFZVFh?=
 =?utf-8?B?TE8wS0w0cXB5SzlPRzlHQlgxWkpWZGYrTENSdkhyWUMrRkhmTlpBTDA1bGdk?=
 =?utf-8?B?Q1BTUk1qeHo2Vkp5WEZ6Q2w2OXhXK3RYMVpqb2VxZXdlTFhiRmNJTnNaR0xZ?=
 =?utf-8?B?VHF4TEladFRNdmp6ZWdGbFBhQTM5bHJaaHYrRE1tOTA1azFxcXRWV1BHTkRk?=
 =?utf-8?B?RnlDYTZMTUYxN3IveGFsMlVIcUhaS0g4Vy9xL1lqN0F5TlN2a0Z6bytGcWdW?=
 =?utf-8?B?emxPMk95OXFFVDBQVDRWeW8rMEVlMmM3UWFJWDVzSWFQQzRKd2lvS3gyNHJv?=
 =?utf-8?B?dmJBNDQ3MWVyRXk3Nkh1bm1aNDhIL0IxS3hGRHJ3THd1TlQ5My9mTiszeUZH?=
 =?utf-8?B?aTdhaHlmcGZ3VzNPUkQvcFZ3ZTBVYlpSbWQyZFlLV01JUkVLdUdZZFVrUk9t?=
 =?utf-8?B?aENQem93VkFXcFhXODlOZG9haGVjaTBwMXk5YzJub0FxQmlidEpFMnRZYVF4?=
 =?utf-8?B?cmNmT0NCVEkxV3c3NG5Lekh0eVBzQm9ZOHY1SlQ1TU1XTGRVV29nUFZYTVpl?=
 =?utf-8?B?ZGY3WkFieGJNRVZtVEdDQVAwTElDbFd2UnJNM0c4eHgzNVVocUFuWDBGQXRI?=
 =?utf-8?B?Wm5zQklqVlFiOWlJZ0hsc1p4WHhHWlpMRG40N0dVRTc4QkdySjkzVWtGTGNp?=
 =?utf-8?B?cXdyS2pLUWJwd0tpZVczQ0ZpdVgrRVhvTERKMEpmTGk5UEVZVWF4QjhzR1Ax?=
 =?utf-8?B?VW5zR3I5elhDYkxPZDVCREowZkZFUzRnNEN4eEZvbmJuQ1BRVFpGMGpQdEh5?=
 =?utf-8?B?WVhMaTZHaGdGUXpmRTVjYnVIUnF0cG9LWTAyYytmbGRqSXZ6V3Y3NS9BSGpt?=
 =?utf-8?Q?pDDxSf15RN+vYB/I+SZshkGSd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4b30TUpiOtnTW91hY96oeaW8ef/ehFd/NcuK1A2FY8c9xf5pb+DrlKAw5XSz2DBRLC2J+sra6ibY8w34Nxznr/EE78SZvi6OrLfHpSE0p8XAocZlVpDOhYZ1ZDSLzwsboW6RT3BCnN1wbT93eMK/cW/4T3W+a3a8HTpqosukR6+seDo7krs4kRKH3dTdfNc3FlOai5mahxVOhAgbAZOHzXARZ1MxSNxItmo6V6tQjgbYvADz4mFe/OLBqaT7o7+51WX5aVeWQ3m2s2pEhSk9tpBzICvS8qMuUzYuESXvKzo1PLx+j57yce5HE/VXmeO8yIulKMBzI5fwANtB16uY4rHw9rFS4hlysXi8Qpsd5oV9CPMJE3Z+6AHPbP7m2Wh+/oBInV1BbBxF3I/4KEhnLVBFkNKZ0+2FhTgC8T5m2wHUCe1YzR2pZcPBCd4dGdL/1T+fn4GB7NNBYb/JqcRjtWPqN7wOSCTWSz4LorRAYJ9ivgcu31WVtFcB3pdrZv3vYb6AbZf7aM8MN2MIj3nwH6SiGFVji526++CH+oLf515Y6zSLUS1B8zmAMGNuksiPJLP0bX+99nyVr09XaHHseCUpYLbQ+U81gP7zLPt0qao=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bdb7d6-e400-4aae-4f3e-08dce7aea0d3
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:33:59.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5KuuSzOtP/rl1YCn1RvFrbydFSSVlvLeu4jrSeP+ShjHkoV5TfcpLphK1V5+qMRJC3AE30fAiaWBU6CDyzP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080098
X-Proofpoint-ORIG-GUID: 5kRRjF2K7TW80bI0c8jty4tNwS-RbJ4v
X-Proofpoint-GUID: 5kRRjF2K7TW80bI0c8jty4tNwS-RbJ4v
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------UhTmsb0bCQVzDmfDkFqX8cHW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/7/2024 9:32 AM, Igor Mammedov wrote:
> On Fri, 27 Sep 2024 14:38:59 -0400
> Annie Li<annie.li@oracle.com> wrote:
>
>> Adding Control Method Sleep button and its GPE event handler for
>> x86.
>>
>> Signed-off-by: Annie Li<annie.li@oracle.com>
>> ---
>>   hw/i386/acpi-build.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 5d4bd2b710..ee62333a03 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -40,6 +40,7 @@
>>   #include "hw/acpi/acpi_aml_interface.h"
>>   #include "hw/input/i8042.h"
>>   #include "hw/acpi/memory_hotplug.h"
>> +#include "hw/acpi/control_method_device.h"
>>   #include "sysemu/tpm.h"
>>   #include "hw/acpi/tpm.h"
>>   #include "hw/acpi/vmgenid.h"
>> @@ -1527,6 +1528,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       }
>>       aml_append(dsdt, scope);
>>   
>> +    sb_scope = aml_scope("_SB");
>> +    acpi_dsdt_add_sleep_button(sb_scope);
>> +    aml_append(dsdt, sb_scope);
>> +
>> +    scope =  aml_scope("\\_GPE");
>> +    acpi_dsdt_add_sleep_gpe_event_handler(scope);
> instead of having 1-off function, it would be better to inline impl,
> here, like we do elsewhere with _Exx methods.
Was thinking that "acpi_dsdt_add_sleep_button" is shared by multiple 
platforms, and "acpi_dsdt_add_sleep_gpe_event_handler" is related this 
function. However, it totally makes sense to inline this function since 
it is only being used once for x86.
>
> Also given that, series doesn't support wake,
> you don't need to copy example from spec related to operation region,
> as dedicated GPE event by itself tells us that sleep was requested.
>
> so all you need to do is sending Notify to sleep button device.
Got it, thanks for the feedback.

Thanks
Annie
>
>> +    aml_append(dsdt, scope);
>> +
>>       if (pcmc->legacy_cpu_hotplug) {
>>           build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>>       } else {
--------------UhTmsb0bCQVzDmfDkFqX8cHW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/7/2024 9:32 AM, Igor Mammedov
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241007153236.2b4d3ad6@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 27 Sep 2024 14:38:59 -0400
Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a> wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Adding Control Method Sleep button and its GPE event handler for
x86.

Signed-off-by: Annie Li <a class="moz-txt-link-rfc2396E" href="mailto:annie.li@oracle.com">&lt;annie.li@oracle.com&gt;</a>
---
 hw/i386/acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5d4bd2b710..ee62333a03 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -40,6 +40,7 @@
 #include &quot;hw/acpi/acpi_aml_interface.h&quot;
 #include &quot;hw/input/i8042.h&quot;
 #include &quot;hw/acpi/memory_hotplug.h&quot;
+#include &quot;hw/acpi/control_method_device.h&quot;
 #include &quot;sysemu/tpm.h&quot;
 #include &quot;hw/acpi/tpm.h&quot;
 #include &quot;hw/acpi/vmgenid.h&quot;
@@ -1527,6 +1528,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
+    sb_scope = aml_scope(&quot;_SB&quot;);
+    acpi_dsdt_add_sleep_button(sb_scope);
+    aml_append(dsdt, sb_scope);
+
+    scope =  aml_scope(&quot;\\_GPE&quot;);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    acpi_dsdt_add_sleep_gpe_event_handler(scope);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">instead of having 1-off function, it would be better to inline impl,
here, like we do elsewhere with _Exx methods.</pre>
    </blockquote>
    Was thinking that <span style="white-space: pre-wrap">&quot;acpi_dsdt_add_sleep_button&quot; is shared by multiple platforms,
and </span><span style="white-space: pre-wrap">&quot;acpi_dsdt_add_sleep_gpe_event_handler&quot; is related this function.
However, it totally makes sense to inline this function since it is only being used
once for x86.
</span>
    <blockquote type="cite" cite="mid:20241007153236.2b4d3ad6@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">

Also given that, series doesn't support wake,
you don't need to copy example from spec related to operation region,
as dedicated GPE event by itself tells us that sleep was requested.

so all you need to do is sending Notify to sleep button device.
</pre>
    </blockquote>
    Got it, thanks for the feedback.<br>
    <br>
    Thanks<br>
    Annie<br>
    <blockquote type="cite" cite="mid:20241007153236.2b4d3ad6@imammedo.users.ipa.redhat.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+    aml_append(dsdt, scope);
+
     if (pcmc-&gt;legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm-&gt;cpu_hp_io_base);
     } else {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------UhTmsb0bCQVzDmfDkFqX8cHW--

