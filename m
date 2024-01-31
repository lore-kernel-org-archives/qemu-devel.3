Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCFEC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7Ux-0001Jd-DJ; Wed, 31 Jan 2024 05:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rV7Uu-0001Dz-KB
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:07:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1rV7Us-0000oS-Fz
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:07:12 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40V9i7fg020737; Wed, 31 Jan 2024 10:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=avHdZXDNJmG4/71vWa5Gh44QL0qELdOMEFzM2V4cwEY=;
 b=W9X4DUlL3qsHk2njgYRsMqx/Sjpa1cxRZSI2dSkWhW2c1Sq7kK5QOKH95+qsxcQ3ZNSq
 JFet8X5pEjDnUJvschjgyaGfyb+WJ2j+nj1/tpDtkzyR6rxMeTYB5/nRkd6ZJFZOOoBV
 vptprg1p0vbgvMi2jPLfC66gl72nh2LvGRXN78ilIYWFowBbBMiEWD/DiMx3vmPf4Yl0
 +bwMf4ptEzKI+btm+ACSCLnrimn4ILMSfg4fcOPxmR5qZKPQRUZY8ufNI68DkT2n2Dji
 VGGr4z8lTL+mpiZmFKizQ5qZPFK1R7RMrzxNE/dBvj/hA16/Ou4amY5DV61/hjMx3Nhl mQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuhcd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 10:07:02 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40V9cIWL014683; Wed, 31 Jan 2024 10:07:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9eudev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 10:07:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBz934gNNRlV6SrfE24WG3WrHO/HJpwxvOEwCyc5qa/mR9Xf27J82soMtcnGB8xjqeLkt0QpKVYdi78cEP5ynVsfARmZ0BXadaqF2G6ukrI8dQNFSALyjgUjhEG/aGkQL2AC1xSPcnHdkQiZ5P5c7Bt9mBNOIE9rynIYyhCUs+Vb74+J1WNalTSNkmamEc8S0cKkSs8CnlKm+L93snvdXT9nHqq2uaHo1wM8kPw/INE3DYd2E7JEx7EImhXCszHODXOE30sIHHJRDEtsXX11qsdMIOTfZYdHN9cNYQ61pcK3GZhAkDa+kp3xZHuzJ4wtyPauoYjcuJX7oVKljvaKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avHdZXDNJmG4/71vWa5Gh44QL0qELdOMEFzM2V4cwEY=;
 b=GeiVRLhhwh7oIrEp2AgU2fs3jqJPvUJztgcCJFk0n4JPewjuj/6/mhobKNcCTF4yRo1lZTkb+I9nIultVXofQFBWqfMw6WUG7pMP6LHmW2XbXPq5QZkkvmp+psHNvZLCYlcD+i7vU24wHkafbjWcKKU6Evwt4iXoeISkyqA8hGZK9ZmQz/9gjgWkPb8OEZ7x1yhODKXBtJaojOJ37XcSnEZ5dHQlx9/aUCEcMEFcgrrgLa8nWqeOTHrip37PhVSJHcqMf2ENa+GY15UxHT+b7PpqAibWqTIE+3E4tQMF3mpiFPzdttsLKQ5n36ki2K//NiUODRH7OUGDB9Xptk1fCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avHdZXDNJmG4/71vWa5Gh44QL0qELdOMEFzM2V4cwEY=;
 b=CEnQ/0XH+sVQMcXCur6vqW9f0d2A7vv0OpuZPiYBd3dJK6BodHDXs36vPNibRjcdGb235+FLoOXqNfESmTwgz+a0rEfuoZWmfePLnugPstuJwkxATWd4pR0ysgHpIPHcnWDAJyTFmBUqfhLdaul6hWFle1hZIwXZ+Cwzeve0yE8=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN7PR10MB6473.namprd10.prod.outlook.com (2603:10b6:806:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Wed, 31 Jan
 2024 10:07:00 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::f03c:dac3:9f74:8593]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::f03c:dac3:9f74:8593%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 10:07:00 +0000
Message-ID: <92ecfd90-8d06-4669-b260-a7a3b106277e@oracle.com>
Date: Wed, 31 Jan 2024 02:06:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] vdpa: check for iova tree initialized at
 net_client_start
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Parav Pandit <parav@mellanox.com>
References: <20240111190222.496695-1-eperezma@redhat.com>
 <20240111190222.496695-2-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240111190222.496695-2-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::10) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN7PR10MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 194006e2-37cc-4b8e-af1d-08dc22445d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXC2Pg1jY3jnTBtkseet5qiLwGaA1aXq7LOI0J05XmtMY4YvPnLhbdaEq6ZoitSkzOVD2G+wxGc9zoL7bDv4obwsqMhm7ny9ZW4FvIpVwQUttiforvcwzIc4ojCS9TMZ9cbNmCMLYV0vCGmvmZTVn8CJ9rvNJF1tzMpTCGtHE6etH4Gva0FNSnMg1tis0yhuVX8pC6OaOPeoBMgV+l1IWcpaYWgGIzSwESukMA/NG2ESVDa+zMjAKpFcWu91YROmuCwcZr6vmJGhgI65eVcZKrrYBvHwyNitrttuupqnNvqFqM0UOKZBz3tyYvQDVLRWYc6lzyETngRBSWbH4gfLge9ATudaMALM0kK31jgR9SkLhe+5TbQF9H8Ebvo+BOPE1rqsxOU+XO123QX4xxx3v3EfGXv5Sa9+rxEabMUCRz2DybFmnh1r/r4w3O+ZhICChGgujpCEHqMUFTbBkIHtKrSy3t2/rLEZFBzEUtEF6KWYYy57NXQqRU3v1PSwaYk2LEVHGHND43PldZoY59QScY/zSTrAGDAB5Ag9snCdx9jvxzKXr+XZl/3goZqvqRnfqdYC8HWzOhMOcHu9SvbJ7B11wmQslOfCFu6sEq9kYMlBKXEf/w6ETJynS5kse3J2TsqgUKk0ev2UAdHkWeRPew==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(66476007)(66556008)(66946007)(2906002)(54906003)(8936002)(8676002)(36756003)(4326008)(6512007)(86362001)(31696002)(5660300002)(38100700002)(31686004)(7416002)(83380400001)(66574015)(26005)(2616005)(6666004)(6486002)(6506007)(478600001)(36916002)(41300700001)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sit0NXlOY3pyWFoxTmpjUUJaTnptSGpvOEMxTXF2enJLbU04RXBEanprTGpm?=
 =?utf-8?B?Unc3ZU9DNHBDU0JxZ0tYNC9rUmNucHgvK0RKdTBGYjJ6aHMwaU13cUdHelFv?=
 =?utf-8?B?WWtLaHAycVlFRmJSSkF5Q1EwVFhZamM4NEFMTUhlaStqNjMwM0Jwb1FGcGpU?=
 =?utf-8?B?bFlveDExeWJsTWNpRjBtS2RPVUV5M0J4dC80NW1NN3hMWmovY09Hdm5teFJH?=
 =?utf-8?B?dklxV2laL281bnBLV3QrVlBIL0hXMEFpZEVIdDg0M0NCbEtPL3hqUXd6aGhz?=
 =?utf-8?B?TFRkVFRoWXpWT2psSTVNcHdUckdHaTdaRW5LWVhoM0M0eDNaZzRMaUttREI1?=
 =?utf-8?B?MjY0WHRCdFNnSzBMMmlpcmQ5OS93WkdCVUdBSXJjNkZJNWJlOWhGckJHMmpt?=
 =?utf-8?B?ZmpKRUxRc2hwaUZMSzBvRmFyRGZ5ZDhPUnQ0elcyd2Y5bm9YTkQwYWk2NEFY?=
 =?utf-8?B?RnV2NkFQUjZvMDJSQWZpYlRVb25yQVM5THRXdmhEeXg5a09LK0E2MEdBeXJH?=
 =?utf-8?B?UExPTVR4NC9NUFpObDBjdlhZSU9BdzJxVlBpam5hMEYrZXpwcjhjWUpXRTEr?=
 =?utf-8?B?anUrZ3VIVXYzZ21OdnJlcHVBbmZPZW8wckdPTWt0cGg1Tkx4T29uTG1HbVVx?=
 =?utf-8?B?N0hWTGRnT2p0SjRIcWtPTjY5UVM1ZUVHZWJ3ejNyTmduTHFPemlseG1SVjd5?=
 =?utf-8?B?NkxsNW5lcXc2ZzhjUlVjMlhqSExlWXNkZEdIUlVTakNVSUZiUXBBQTc2Q0Fq?=
 =?utf-8?B?MDliR1RWK0xwTXZ4R0xEdWtHWUdTaXIyMTlQZ3hYS3lNWjhCRkxrQ3Vlays3?=
 =?utf-8?B?Mm51SUhBd2xYSFpCVlNSdDNNYTQydHNYdkhhL2xOU2JNY1Jvemduby9jSkc3?=
 =?utf-8?B?M20yb2gzRVRmbG5PblI4RUFVK1NIS0dGYzl1dk1JYnRxWk9xU3lJbXFFMFBY?=
 =?utf-8?B?djhzYVBhQW9sS2JnS01PcUZBR1RJK0pDeFFXQVNhM1BERElEYTFLeDNmNUYx?=
 =?utf-8?B?WDFzdkVMdi9MVmRRdmV1ZnV1di9tVExDbEo1emxhcDVia1pqQXdvQ210U3A1?=
 =?utf-8?B?RGZZL1U5M0t5RGc5RG1QQ3d5RVVONGFRYkV4Y1F0ZVQxRzdaRFp3UWQ0a0xE?=
 =?utf-8?B?VTN6SEpVMFNjdU5yNU1UOTYxVDk4bEpDOURXaDF1aHU2dWQwVEVjNkExYlBj?=
 =?utf-8?B?VUVzQkZCbkwrN2JOZnRqbUVWQlRPTDlSeTVXU1dCN1JZbDRNVmk0cjBMWGh1?=
 =?utf-8?B?dUQxYzNDaU9tbStrUlNhVkhBMVRHcHpEa3FVNkFVcUJSSlJSc2VFaTN0RzZo?=
 =?utf-8?B?L3B1RnlmTHBlVk1Rd1ZDWDA3eWtHOTBWZVI0NXdjZzR1dHRidGlzVTdrWXRJ?=
 =?utf-8?B?d2VhTVBjeXJ0QXNLb1BTRUU0Q0RYRUREcFZzdWtzLzFhOUhoejh3emVHU3Fr?=
 =?utf-8?B?ekNYWGEyMVFsL0QrazJWOE5tQWlCbUdJdXhtYmNlajJySFl1ZE4rQnhCTGN5?=
 =?utf-8?B?N2RDWmFTMXBELzE4Y1Y1cUJMSTRSNFVEOWI4QnBjeG9LOXVGWUZESjhoOFhq?=
 =?utf-8?B?RmpEckdmeFFOam1IRkVPVmZCZXZYN2hNTnFBV0gybVYrV0pPZis5V1hsdWZH?=
 =?utf-8?B?TXBSdXE1NmIyLzk5Y0J2Mk1PNUJvdGFGL1Z3SzJjakxiT3A5OE8rZzJ5dGY2?=
 =?utf-8?B?UkthVTd1TldEMnZ5dFBBUi96bXRUSi9rSWlQTVZ3M1ZDS3BXZTBCK21Udjd0?=
 =?utf-8?B?RkllM3M0VmpBTVhISjBDZ3BoVENReDgxa2F1bGpWcHM2M3pBOUlhQVZENzd5?=
 =?utf-8?B?NS8vYVVid0dROGdSMk9hSWc5cStIdXoxT2I3Mkp2bk9reFYrVE9kZjVLMDNl?=
 =?utf-8?B?T3oyc3NET3kzb2ZDalRFaG5rbjdZOXhzMC9tTnpFR3grMFhiQVpjZWhkQzVL?=
 =?utf-8?B?M3NTR3B6NkZXRnIvdFdSZU1BOHJWcW0yNmVMaDZJeEs3ODFZN1F3cGwzMnp4?=
 =?utf-8?B?YVQrbGRhYzdncVRwVTRvNE8xcjhtZDlIREJoZHYxRkpHUlUwUTlXanZ3Zmx1?=
 =?utf-8?B?SnRFZENyTHNUY2Q1RERaVVZMUW5QeTJmem1PMVVTN29OZG1EV252eU9tclcy?=
 =?utf-8?Q?wrN8nOIcU3zQYs0IbOnWNx1ka?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e/Z2nCJw/jqFHPmXm+h6vKK/Am1Dbe0/VCn63cUrUdgkVgiQ/TfYghB+ulScHQ0miUwFxGycNuFZ0FnKEz5Oq5BIyzbgm9iOwPKXuFZFpMWypQ1Qun+LK5pQKHOC76ak3K2Qr9cDL897/0ec6PwtakME+xO4CsBbTQUatnJQ2v1debAqEFtTDXQuXfMy5mwa2F22fckbYWBrA+ad5O6/3jHevsJV5VhB/usIRARBJx7PK2bmDmaiCue2a4V376XxVcRhPnvu3DeJTpCAC5hXk1vcmVTJ/bGftO+8HW+COU1ejYes8QEDdaRr9Ttiy22kuD2ncpZmPc1dJU6CLztTJIiPRZUmCEg3LwMePS82s0DuE8HH+zhllZFROsHr/uRvMKKAmo5RGyuqXZZH5VYugeHQx2rrNkl5vzVUIwDgVYc39ajXv3cm3U1jwYzDu0HKRg1tSoYPikj8chULZ6Le+J/hkxpBSAbvgR8FQUCNycULqwGzbJSVIf1682aSUwqolY6yWleAfHdX4HKPGRrOHvEBl7HqEZwJp7lojQA6iClbxVr+fJ5w1VII6xl+XZvQdbgPPzm8jJ2ZOXDcSzLCwQ1RDhMxW6KjP6QwRTKQV4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194006e2-37cc-4b8e-af1d-08dc22445d5e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:07:00.1555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHVCZFFbzE5WVz8+LSYuHgtue+GKkfqkeWBg1BqLpUIzGuRCqFOb05deJGJz4GwO5o7suXqwQz0Uz7V1EI7TRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310076
X-Proofpoint-ORIG-GUID: ZCh1qQxa2WA-ymbviBUHrx4la812OMzQ
X-Proofpoint-GUID: ZCh1qQxa2WA-ymbviBUHrx4la812OMzQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Eugenio,

Maybe there's some patch missing, but I saw this core dump when x-svq=on 
is specified while waiting for the incoming migration on destination host:

(gdb) bt
#0  0x00005643b24cc13c in vhost_iova_tree_map_alloc (tree=0x0, 
map=map@entry=0x7ffd58c54830) at ../hw/virtio/vhost-iova-tree.c:89
#1  0x00005643b234f193 in vhost_vdpa_listener_region_add 
(listener=0x5643b4403fd8, section=0x7ffd58c548d0) at 
/home/opc/qemu-upstream/include/qemu/int128.h:34
#2  0x00005643b24e6a61 in address_space_update_topology_pass 
(as=as@entry=0x5643b35a3840 <address_space_memory>, 
old_view=old_view@entry=0x5643b442b5f0, 
new_view=new_view@entry=0x5643b44a2130, adding=adding@entry=true) at 
../system/memory.c:1004
#3  0x00005643b24e6e60 in address_space_set_flatview (as=0x5643b35a3840 
<address_space_memory>) at ../system/memory.c:1080
#4  0x00005643b24ea750 in memory_region_transaction_commit () at 
../system/memory.c:1132
#5  0x00005643b24ea750 in memory_region_transaction_commit () at 
../system/memory.c:1117
#6  0x00005643b241f4c1 in pc_memory_init 
(pcms=pcms@entry=0x5643b43c8400, 
system_memory=system_memory@entry=0x5643b43d18b0, 
rom_memory=rom_memory@entry=0x5643b449a960, pci_hole64_size=<optimized 
out>) at ../hw/i386/pc.c:954
#7  0x00005643b240d088 in pc_q35_init (machine=0x5643b43c8400) at 
../hw/i386/pc_q35.c:222
#8  0x00005643b21e1da8 in machine_run_board_init (machine=<optimized 
out>, mem_path=<optimized out>, errp=<optimized out>, 
errp@entry=0x5643b35b7958 <error_fatal>)
     at ../hw/core/machine.c:1509
#9  0x00005643b237c0f6 in qmp_x_exit_preconfig () at ../system/vl.c:2613
#10 0x00005643b237c0f6 in qmp_x_exit_preconfig (errp=<optimized out>) at 
../system/vl.c:2704
#11 0x00005643b237fcdd in qemu_init (errp=<optimized out>) at 
../system/vl.c:3753
#12 0x00005643b237fcdd in qemu_init (argc=<optimized out>, 
argv=<optimized out>) at ../system/vl.c:3753
#13 0x00005643b2158249 in main (argc=<optimized out>, argv=<optimized 
out>) at ../system/main.c:47

Shall we create the iova tree early during vdpa dev int for the x-svq=on 
case?

+    if (s->always_svq) {
+        /* iova tree is needed because of SVQ */
+        shared->iova_tree = vhost_iova_tree_new(shared->iova_range.first,
+ shared->iova_range.last);
+    }
+

Regards,
-Siwei

On 1/11/2024 11:02 AM, Eugenio Pérez wrote:
> To map the guest memory while it is migrating we need to create the
> iova_tree, as long as the destination uses x-svq=on. Checking to not
> override it.
>
> The function vhost_vdpa_net_client_stop clear it if the device is
> stopped. If the guest starts the device again, the iova tree is
> recreated by vhost_vdpa_net_data_start_first or vhost_vdpa_net_cvq_start
> if needed, so old behavior is kept.
>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3726ee5d67..e11b390466 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -341,7 +341,9 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
>   
>       migration_add_notifier(&s->migration_state,
>                              vdpa_net_migration_state_notifier);
> -    if (v->shadow_vqs_enabled) {
> +
> +    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
> +    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
>           v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
>                                                      v->shared->iova_range.last);
>       }


