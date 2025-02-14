Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19693C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj750-0004Bb-6X; Fri, 14 Feb 2025 20:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj2Us-0001h7-VY
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:41:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tj2Up-00033N-K6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:41:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EGBWwq019280;
 Fri, 14 Feb 2025 20:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=i8ijTI2Ia1dGVJNw91RoIgXUzHYAyEC79xIVvrrUEMg=; b=
 I0H6xAlwbklcxRcJwkxnImg6BZB+HDJPfE/tVr/aUBLy/jI+qx5QiRat7iUht604
 APDQjdatlR1luj3CflnpbBm+rK0AxINIm2cA4B7RtppdoCHX41y0khG93ddDKLIi
 775HbyhgehAsSPTZMfH642dqElY3iSItzt2R5zD6sQqZ43AyuI2iG8j5lkVQsW3U
 LoJVvCCMqnB1RvuvkIg6uEKQShvTpmL9Ck8Mri1gw36bEeFpN/8bPKufQw+q5MNe
 XJS3MI+B00LXhmO1839jSVzRJkGggzRfsbZuC3cUYlvYj9w9hhLtbP/8R35quZqE
 2wuul3OB10jo7uhycGPHrA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qyvjbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:41:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51EJJaLg014072; Fri, 14 Feb 2025 20:41:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqm7ns2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 20:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGsZil89jCzdXWg9LBohTq0jOa8RmYI4RYR2DWQTHrcZhuLc18DEokYuMo7Eyekc65zyuLifiPLOeMllzGUoauiG87w3oDxKMYerioXNIZyBkPANdRlgjYOe1EfBAvjGYe6vtLTlkz5aDXgn1x7n3mDl0egJlCjHobXUkucrSX33NWBJw978xQ/o3eRPn7yeN29f18NW18tXyki5NRuwWlOGp+XZtQIb3huyk714WQpeDKw01FkQshXmBAJHVGF+HTcPhO2Z66267PuaJ56RkU/7KC8fUGOqZAmxLkO9y16xkeT8nRIr7Rr4PDtyYSFP13LlKYdQO0jcx2l3VFGHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8ijTI2Ia1dGVJNw91RoIgXUzHYAyEC79xIVvrrUEMg=;
 b=wMP9i2S/Ll8wLi44xT1X7rCIQ51ufrHXXgvQtQKNH8nfpThRoB66LHVb/JQYJcv24H9EKyFtX7sh24Mj43iHxOdSKSq818HhKoATARPGTuGteKs2AqUQTa9r0Z4gUj0VTy2BrFtb8bdH3ccVYta7A/0loVaB0CdJo9KeVWJLRzvosFLQMKQUV0ReJ1xYlU71kn6+BZztpHJOaqXS5Vgo1j7+MeqymaMbmm9/PLoPAG9vnLCleFsl78N8iFih9+qBEBGV9PnwyLxUlGgtkoKd0VNmB4N3gfyiYhZCfNuTFG9GbY9L9rNlEgOi8iCskestdCbvfMCiFcL51YwUMTTTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8ijTI2Ia1dGVJNw91RoIgXUzHYAyEC79xIVvrrUEMg=;
 b=bEVpoCWTbpCkoltaXasNeOxvyvv34Jl8DhEMyHZREnb4EJS6cfFEqPfuCyl0Y3mwiEYNK+6hc3rdP/BBPJkM74X3NM8MUeDlFr4JiIX5URqUpSRrlSpBYuzm4gE1CU5cQfvr5/K3dKAH+pW3cvGBqNVmyYZNFkC6DlgKlPM6310=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Fri, 14 Feb
 2025 20:41:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 20:41:04 +0000
Message-ID: <b6e19df6-cb38-4576-bdd0-6278997e402e@oracle.com>
Date: Fri, 14 Feb 2025 15:40:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
 <Z69z6oTtaGOC287O@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z69z6oTtaGOC287O@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6293e9-9f48-484f-d1a8-08dd4d37e6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTN6emlRcUUvWGR4N3FPbjg3Ync1RUxGb2NWamdnbmFTYVdOaStFUlZIdmtq?=
 =?utf-8?B?UVZJK28xRVpOOTRISUR4L3QydHdFc28xeEthU1lRZTZKanZOWWVOZ0EzNnZh?=
 =?utf-8?B?Skx5NzFNbU1xVUFPS3REU1NzVi84OTdycHBTOUszQ0Y2NFpmK2lhMFRtY1A0?=
 =?utf-8?B?ZE43QTFVVFo2VVZweEV3dHlGS1RNSWpBNFhZZG9XbXNycTEyN1RiR0J6UEti?=
 =?utf-8?B?U1crcXlJd2diUVA3S3Era2ZkcVlFckJTejladjcrL3dXUnFyeWNKREJtUlVD?=
 =?utf-8?B?R2JLLzdobGQzeHk4a085eUVoOTFXcGsySFQ2cTd6RDZmUmYwSHR6NlU2RHBD?=
 =?utf-8?B?ZWdUWlE5ZDFib05oOUl4eGhhZWtmSUxtWlQzdEhCSFVvUDdMN0NucEZOYXZS?=
 =?utf-8?B?eDJXdUhjMFo0WGlxT2tzWWVEb3lTZmVsV3dPc3lOUjZyZUh3ZDFHdkFGSUVU?=
 =?utf-8?B?d2hwRVd6L2NXWmM0c21Ja0dnN2p4aysxWW95azJRcitCTktvK3RoaFFlMXRF?=
 =?utf-8?B?YUxsaC94NmR5QVRkQ1NpbjhVMmVRRkFrR1VCK2lycmNyNTdWeXdyTFdSWTVz?=
 =?utf-8?B?UVRQV0xUQUVxdStPdFE5QURMUmdYK0IxejZEYXVlM1gxcE5waGNxangyWEFB?=
 =?utf-8?B?cHZkU3YxYUhZekIrY1Y1cTRDN3l0UVJNd2ZLZjZBNDdpaWIyOXFjMjRpZlVF?=
 =?utf-8?B?WXk0WFNyb3daSllEeGR4Z3ZHRUVnMUZSZW1Xdm5ha1hFQXEwWmNsU2I4akph?=
 =?utf-8?B?UE5XaVhDWHk4MlE4YTdONXpOcWVzTDJKdTlnL25FcmJiYjBVbWJOc21yNjZq?=
 =?utf-8?B?NVdqeno3UXhpeHp6bW9TQ09Tb3J2a2pqODJIZHpDeXc4bmNjYkZVMC9ZVVJV?=
 =?utf-8?B?V29oNGZNYzZGOWd4TFRmQURtNlY4SmYwankycHJQTW5hSmZIb0E4a0k1Mk0v?=
 =?utf-8?B?OWpIckI1NWVub2Vsa2hSbnRjRlJCclpDM1lKNldLSUVCSWVhV3A3Ukd1dVhV?=
 =?utf-8?B?c2V3NzdKQ0RFbVcvSHBRM2FmdkpqZ2Q5UzluanlCTUVFbERXWmdDVXBjZ1U2?=
 =?utf-8?B?N0Z2NVRGQjYyZGxRQVBjQ1U5VnpsTjdwNXQvSldBZGM3MTNwbEEyTnpDS2dU?=
 =?utf-8?B?NUJTTGZxWGNrdGl5ZlVUMmdCd0FhbVV1WkNwelNBR0x4RTJ5OW04WmNUbnZj?=
 =?utf-8?B?YlE4QWxNS254WDdQcE1rdnVOZHVIY2ZwNEtrd2w3WFdaMUJWaXU4eCthWlY4?=
 =?utf-8?B?WjAxdEpXNnZuUi9wODM0c05uWVQweEUyWng2KzBDKzFpQmE5UllGVFpoM2hP?=
 =?utf-8?B?ZjBBbEF6bmlmNHo0ZjN5ejZobmtTakRvckxDUjhYWVJWWUp0QTVWRVd5bFlk?=
 =?utf-8?B?WjZPZDdrMGx0dGFCUVZ4VUlkZWFOYjgvY0hDSEtoUkZ2UmhsK2VGOE5icklh?=
 =?utf-8?B?dkZnU3crbWZIakU0dEQrTTdSV05XT2tjaDR6NnlKM1NyWS9aVEdjM0tlZ0J4?=
 =?utf-8?B?NFVRVitQd2xaVFZjTlFBcldHajdFbEpyaE5ucFluOHVhdUhqaGlOelBCRTJE?=
 =?utf-8?B?d1FxNTFLTldQYVdKQmR5ODREZS9IZXJFQnVLUXlteTZDTWlVVDBEclcxMS9L?=
 =?utf-8?B?Rm9Iam1kTy92c1BUeXdBbVRlZTlhbU0wR01sd1hsUlRNcmZnSWw2alI1Q1VL?=
 =?utf-8?B?eXNiMEx5QUo1VllDZTdmeEVIWVFEUk54QkZNUXdkQkhndXZLZFdKMU9jKzR0?=
 =?utf-8?B?b0krRGZjYXUwOTNjem5sc0QxMEd0M1BRWHFRRDcvOGhvNWNVMFYzVEU5bEdk?=
 =?utf-8?B?R09JbVFSV1BrODVYUkRlQVd5K0FKM0VmNVp5enJSMXM3Zk9oMjExV05ZVTZh?=
 =?utf-8?Q?AzkU7uwEv9bsM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU5ieFJxM2JLSHVLb2tqeUZHK3pVdGpTV1d1QzdRTlRiSStmQUJBSm44c0kx?=
 =?utf-8?B?R21VcklxTlBXR2tEUktwTEs2c3p0UUxnTkhpMHQ2cEJSRXMzTUxkVEFmblNr?=
 =?utf-8?B?cEZjTTk4Q0JDQ3Q0WFU4NFgxZzhBUmIxdXB0a2pqTGZRRXJMcDV5RnRBaEV0?=
 =?utf-8?B?aFNuQ05xVnJDUzdZc0hQd2gzOTRuQnpGekNLVGpGQ2JBRFZlMVRDT3c4eEJR?=
 =?utf-8?B?OGJ1YWVjbytoMUErUkFEV1REQVBRUC9wVkRhZEhJN0dtdUpzaGdXdWM0enFP?=
 =?utf-8?B?T3ZLMDQzQzE0dzU0N20zVGpoN29VVVBnUHZjdE8zR3I0MTY3WEN0bzZSQnRj?=
 =?utf-8?B?UHNEblVzU0dFNXlLSlNtaGJiYTc3MkI1dVFFNFo1Nzc2dTUrSFlPaGJlR0dk?=
 =?utf-8?B?ZVNSalc0ZGl3TUtoQitnVEJ4QzBWN05nMWY4RzFvQW0yQTFKRUhTY21hZG9U?=
 =?utf-8?B?WXlzV0ZpKzc0V3FzNDZHY2lHajhFQU9JUEJiL1BnbmdPS0JTTUs5cGM2cW5D?=
 =?utf-8?B?M2E0eTBSNGpvdnJqYmdXbE1WUkJWcHJwazhtVXJvR2luMC9yQ1hYYWhzbEho?=
 =?utf-8?B?czdxNENTdzFPamR4aHhaN1RFZmNEV2dTUkwzTFVKVlFhRGd2SjdqTEhlYUJE?=
 =?utf-8?B?RGZhMldicXowb3BaenFEZXkyV0toN2RFNGxzNTRIdis1UEhpSDBMVEsxcVk4?=
 =?utf-8?B?UjEyU0k5RkNOV0NvZlRhSk5uT0pzN0cvdnpIbTcvSTVlMjJHNjFOL3F0Sldn?=
 =?utf-8?B?V2txQzNRZWErRXdMcXp3REJDYmpmM2pvaDRLc0JLb1Z4em9BR0NHd1NMeDda?=
 =?utf-8?B?dE55U2RQWDB5Yll5MENVajdzSnd1a0ttWTZSblJjWHQ3dVFrT3E4ODF4emRn?=
 =?utf-8?B?RldML2QyNkJJazBRQ1ZZNmRhMW8rcHZXUnFWdnIyaFlCQXh3UkJNMUd0NXY2?=
 =?utf-8?B?c0NIRmlVY2xzR1ZYaWJJTlo4eUVlYmVDVDc2b2VITFI4UkQrRWJKWnkzVnJR?=
 =?utf-8?B?WDN6eXNKajZzN0R6NVhRVjFzTFhCczJFOUVOeDNETFZweHFoSjFXcyt5NXBM?=
 =?utf-8?B?UWw1aGEwb0dhMnhRdDBTYUIrTFpLdmxMYmxoTkRjVWF6QkNtZC9iSCtDTkQ0?=
 =?utf-8?B?UE15OVgxUGJ5azVmWjhxYjJhRFMwMHczREQwRmVlOSszS0xZTHk3dG9SaWpi?=
 =?utf-8?B?Zi9pNzRWYzZyaDJGdUwzZld3QkQxVS9QcW12NlB6d2lBWUJXTUFPL1pQd1lG?=
 =?utf-8?B?eW9YWGgzNGJRR04yY1orbjdvZktxbXh2ZUgxZTdDck1mcFRXc2pPUGVnSS91?=
 =?utf-8?B?TmpDRFU4dU5JTE9NQVA4NHh0VGxRZGduVm1wbWsvNU1VTmd5bGFualFENVds?=
 =?utf-8?B?Vi9HaWRjUi9qUXJma2lkdzBhUnJNbjM2dnVENkFLaHNBQTN3bDE3RkN0RmxG?=
 =?utf-8?B?NCt6bnI2MHNNdVdyYjZUcGQ5SjFWWlRiR0ZsZC9jMVhtVzdjeGZqdDdTVk9h?=
 =?utf-8?B?U3RlaWVucEh1Z0JXSTQ4RFZLb3JpdFh4aUVYVm5uZ3NSQlgyRzlSTU43YnNw?=
 =?utf-8?B?a3RQdEplUlBFMitEZThtRzJLc2hGQzIrMEZ3OGd5b0ExeEJJQS9IOFJla1dM?=
 =?utf-8?B?RVAvbHNVazJHV0J5ckl6WFJJUzRibHF2ZndUcWhhQzg5c1F1aFBqMStrV2hZ?=
 =?utf-8?B?L1hZY1cyMHRkNGR0RU1MM3Q5d05YNndNc0trTGVZN2ZqdGtnUGVYMVh6a0dR?=
 =?utf-8?B?MXBhRHdNdlhScUZLNURvUkJ6SW1kaDRKSFNoWHRGWG5GdzYxNHJuRWRWYml6?=
 =?utf-8?B?U21wOGJCOGZtcFdsblNTU3U5UWtlekVxNWJPNU1IRkh0VlZIVm9xQjB3S3Yz?=
 =?utf-8?B?Tng0SzdpekxkZGZqdWp1amgzUmxnd3NPS3FpMWN6ZnpzSFFQQ0YyWWNlRk9B?=
 =?utf-8?B?RURLR1NxRXZzd0praW9jUlFBMUFZQllpdnBiMjlsWWxKWEZ0VnBiWldlUjM0?=
 =?utf-8?B?cVFOK2UzZTNsMUV5eGJST2FFWkdneUpkQStvZTJ6TmFHdVQ3dGRaWk5kQ2Nn?=
 =?utf-8?B?Q2d1WXFwL2RRendCd2xIb242cXR3SVM3Y2Z3MXFlVGY5aEtaSVBMS2N2VU80?=
 =?utf-8?B?QzJqcENTL0ZxSnRvU3ZtQk5lUWVnd2ZlLzY2bXZnaVhzODNmNlZMOC9JNC8z?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U/OyhARlLl5+gZMYkcV+hkuG1tF/keZ155Xt5V2scaB7UwjnGusrU65MYqf7eTMCRl0jTiF27RpoaDg511hZ0mwQDgsjr/i3k4P5LhBp0wpCO1d//5t5NgWpwDbhZaTpPhBIpVfxNLnDxYD2okAHXOMwWz/HjENoETqdr0ZOhdD0VG8PDvTdHFyFiRIwxyHjZbYq/r3YsT3dCCzgl9THV5XeW/p6+fO1mWzacGOZhTo+zBmlRLTSaMeKGFaIjqbJey05kpf+WtQ+lpJ+1PcGUi2wACQ6QZW+o7vL+/pAwKeDMNKQdwwesBxw8pyTLvl0Uw7vBE2OH6iMrsK83xMZ38iRqyr0I7Vdd0/mXcSx3Z2LZ9Gra3oUNOhTh7f/9EPt148/OwQNq9ymzET494RHOgEGR1pUlEhC+GtAuNxM+X96ooJTxeXMEdowPwaALK4lYI2qR2DX9x0tnNTZWcUlVjf/llg5puPv0Husy4kg8zHV4DZv59cN14qjIULSdY5gfCv48ntIXN2yBwvKUWn9uleY8cURLsMlPjXqhw0C3CRbW+j9mWWhayD+LzQUVI5bavmZNE4rCE40917e2rTurQgSyXvrhSOS3Elblbipa9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6293e9-9f48-484f-d1a8-08dd4d37e6b8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:41:04.8065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMGD+0R1xooIbKpsL/l4f7VKrnlpyUzUL6JUV6arrmaN52jzRT8C1+pJtI/azHNQBvAlcK6lXTKZEoYg7JhW8eluSeYMMXj4ZXdASNvcTe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140141
X-Proofpoint-ORIG-GUID: jIoyAQeL17yYullXcz9SMgXGeJ-qZhWj
X-Proofpoint-GUID: jIoyAQeL17yYullXcz9SMgXGeJ-qZhWj
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/14/2025 11:48 AM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 06:14:10AM -0800, Steve Sistare wrote:
>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>> region that the translated address is found in.  This will be needed by
>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>
>> Also return the xlat offset, so we can simplify the interface by removing
>> the out parameters that can be trivially derived from mr and xlat.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/common.c       | 21 ++++++++++++++-------
>>   hw/virtio/vhost-vdpa.c |  8 ++++++--
>>   include/exec/memory.h  |  6 +++---
>>   system/memory.c        | 19 ++++---------------
>>   4 files changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index c536698..3b0c520 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -246,14 +246,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>   }
>>   
>>   /* Called with rcu_read_lock held.  */
>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                               ram_addr_t *ram_addr, bool *read_only,
>> -                               Error **errp)
>> +static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
>> +                               hwaddr *xlat_p, Error **errp)
>>   {
>>       bool ret, mr_has_discard_manager;
>>   
>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>> -                               &mr_has_discard_manager, errp);
>> +    ret = memory_get_xlat_addr(iotlb, &mr_has_discard_manager, mr_p, xlat_p,
>> +                               errp);
>>       if (ret && mr_has_discard_manager) {
>>           /*
>>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>> @@ -281,6 +280,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> +    MemoryRegion *mr;
>> +    hwaddr xlat;
>>       void *vaddr;
>>       int ret;
>>       Error *local_err = NULL;
>> @@ -300,10 +301,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>>   
>> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
>> +        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>>               error_report_err(local_err);
>>               goto out;
>>           }
>> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
>> +
>>           /*
>>            * vaddr is only valid until rcu_read_unlock(). But after
>>            * vfio_dma_map has set up the mapping the pages will be
>> @@ -1259,6 +1263,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       ram_addr_t translated_addr;
>>       Error *local_err = NULL;
>>       int ret = -EINVAL;
>> +    MemoryRegion *mr;
>> +    ram_addr_t xlat;
>>   
>>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>>   
>> @@ -1269,10 +1275,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>   
>>       rcu_read_lock();
>> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
>> +    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
>>           error_report_err(local_err);
>>           goto out_unlock;
>>       }
>> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>>   
>>       ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>                                   translated_addr, &local_err);
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3cdaa12..5dfe51e 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       int ret;
>>       Int128 llend;
>>       Error *local_err = NULL;
>> +    MemoryRegion *mr;
>> +    hwaddr xlat;
>>   
>>       if (iotlb->target_as != &address_space_memory) {
>>           error_report("Wrong target AS \"%s\", only system memory is allowed",
>> @@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>>   
>> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
>> -                                  &local_err)) {
>> +        if (!memory_get_xlat_addr(iotlb, NULL, &mr, &xlat, &local_err)) {
>>               error_report_err(local_err);
>>               return;
>>           }
>> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
>> +
>>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>>                                    iotlb->addr_mask + 1, vaddr, read_only);
>>           if (ret) {
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index ea5d33a..8590838 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -747,13 +747,13 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>    * @read_only: indicates if writes are allowed
>>    * @mr_has_discard_manager: indicates memory is controlled by a
>>    *                          RamDiscardManager
> 
> (some prior fields are prone to removal))

My bad, thanks. I'll delete vaddr, ram_addr, read_only, and add xlat.

>> + * @mr_p: return the MemoryRegion containing the @iotlb translated addr
>>    * @errp: pointer to Error*, to store an error if it happens.
>>    *
>>    * Return: true on success, else false setting @errp with error.
>>    */
>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                          ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp);
>> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
>> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp);
>>   
>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>> diff --git a/system/memory.c b/system/memory.c
>> index 4c82979..755eafe 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2183,9 +2183,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>   }
>>   
>>   /* Called with rcu_read_lock held.  */
>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                          ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp)
>> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
>> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp)
> 
> If we're going to return the MR anyway, probably we can drop
> mr_has_discard_manager altogether..

To hoist mr_has_discard_manager to the vfio caller, I would need to return len.
Your call.

>>   {
>>       MemoryRegion *mr;
>>       hwaddr xlat;
>> @@ -2238,18 +2237,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>           return false;
>>       }
>>   
>> -    if (vaddr) {
>> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> -    }
>> -
>> -    if (ram_addr) {
>> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
>> -    }
>> -
>> -    if (read_only) {
>> -        *read_only = !writable || mr->readonly;
>> -    }
>> -
>> +    *xlat_p = xlat;
>> +    *mr_p = mr;
> 
> I suppose current use on the callers are still under RCU so looks ok, but
> that'll need to be rich-documented.

I can do that, or ...

> Better way is always taking a MR reference when the MR pointer is returned,
> with memory_region_ref().  Then it is even valid if by accident accessed
> after rcu_read_unlock(), and caller should unref() after use.

I can do that, but it would add cycles.  Is this considered a high performance
path that may be called frequently?

- Steve

> 
>>       return true;
>>   }
>>   
>> -- 
>> 1.8.3.1
>>
> 


