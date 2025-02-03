Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D421C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 22:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf4tw-0000Sy-Il; Mon, 03 Feb 2025 17:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tf4tv-0000Sp-3V
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:26:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tf4tq-0002EN-Vx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 17:26:42 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMsNs000972;
 Mon, 3 Feb 2025 22:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=FvNY4ATCcOhbXZ4/wGigXolY84uXO+NxouG4cEYIcpQ=; b=
 XZGLF6zkk2ha8ZLnL13DG8puHpOFr2G5q69vBz6zKRwHTjtrCTd8LwbXULKfC9Kt
 tLpA04VsMeeAGXp0Fh3QQ2DOePhTi9bwuzyODtWhqi3FheNYRcjkOZuwVFF/QUd/
 WWfslkj4fN78QpUy5vAX2D6vmjiSvoju0DIqhxN0IpTGaGUxIhFblrpYCzl6SG06
 lpjfwy5qnOhgoXYOG0gJABvxksvH5weOI+yXXotVgBdMYeYMnWkqUFtQM41QAdHg
 T4DK7obZNW1OkreckQboh28Meta0O4tU/6EROZ+b2pQrUjrW2KH8zh/rGTzIRlt4
 VZgwS0BRDLSyy4gmHHkF4w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtupjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 22:26:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 513LUA9h036195; Mon, 3 Feb 2025 22:26:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fkfgp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 Feb 2025 22:26:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MehxlEymELei6kjitTrGLFeT6japqZ0VywKtmQgd7UHU/rMNcx1RNRHXfy0jVziNUUmmfaYgYOGV8v5Vp9HJ4LHidG/sdHixgv38KQxa6YeL1WLop9OptV6C9/Fsg9o2M6rF5hA70mgKMpD173MESAWR6qGCNxhukkDucd/sBjtErBq4dZRtD8ApvjVI0KGMkpOaUnJzho7ld5ARivAdaRkP7SR42cR9s5Hc563hOuhm4Kga5Kz1pG3xK4PKaUqVJiJLCT8KPGC9uYAL++6Nl3FNHCDt6Uf7jUiS8PCSvCJWKiE82g82cN/gE29cf3xbSHqci1bgwmyB2s8uXr6MqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvNY4ATCcOhbXZ4/wGigXolY84uXO+NxouG4cEYIcpQ=;
 b=EjgQEgq2ClAK25h+flmDzR4YIAGTGkBPRg/MOn3KxWN8fF7IirsaLY8SEl3C4j83nh9E4jHjYwM0fSf1oCSx4ni9rCfaS2AHDbdESHwbNQro3JobAViNl1rv1JQT5kRCheFdz9i8HkJ7hIz5yNjqNkhwvyoM6tODtd1b+/WfETQVJ047nqwzvC5G68CpmwbLq+blTXiN/E/39NNLYVSJ5ku+2CXnf82eb2spXb6ixknG04KnC+blvp/sgvrqnIiKs8sHqaJ9DTB92FQTbOrKy4ONRNLM0VAPdD6CE1POYadfWEM9iuU1dizSfgHOT0p8dJg7bIC9cpRm5Phaf5VN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvNY4ATCcOhbXZ4/wGigXolY84uXO+NxouG4cEYIcpQ=;
 b=LL9WhdjxuXDOFrk3PYAI//aezuajmxUwS4Iz9j4APVsvdsuBa3PfWB4MDIXCZ/Dt2hgKAkuAAckKRBTvouzI65N6WYk6CQsKp9LR7GeG2+z9KIKLG3ssWEEu7PbHR0sBz/HmjC2ZRe+Km0rzL38etfn/z5CoRlRGPzE0nJKZUsU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB7265.namprd10.prod.outlook.com (2603:10b6:930:79::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 22:26:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 22:26:15 +0000
Message-ID: <18e1d2e1-6055-4d8f-a6d6-7e13fe8d60b0@oracle.com>
Date: Mon, 3 Feb 2025 17:26:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 05/26] vfio/container: preserve descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-6-git-send-email-steven.sistare@oracle.com>
 <692bd42e-b9c0-4727-bfdc-339a3bd53162@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <692bd42e-b9c0-4727-bfdc-339a3bd53162@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 750df021-d46c-468a-d9b8-08dd44a1c5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0d5bFZUVWpaQ0I5S0JUVnY0aUh6WnB5cHV1U0tIS2ZkNVVIMnc2elNFNHdM?=
 =?utf-8?B?MVRIRitMOGxMTzFaNFhPQ0NXUmZIMk1nYmlCT010eWp0YVVjWW9wLzg1WWx1?=
 =?utf-8?B?UmtpR0FmTzhkaDM5RVpaVll3c0ZReU1DUG1lT2lsV3NXT3VCb2pNVEMrNlpZ?=
 =?utf-8?B?NDZTOWpCWm5ZT1MraTBNcjdBNm5EK2JXVElBZlVybW9MR0VpeUlkaVltSktH?=
 =?utf-8?B?WVJoVUdzb0M1aEJSTlJRSTkwOU9sK2RXRTgxcFA5a2EzdGFuS2hoM3lxMUpI?=
 =?utf-8?B?Q2MybzRqY29XaTB1aFdLWHcvVGkwa3JkNFR6cXVyN3lSWTNJMU9ucnRWdHRV?=
 =?utf-8?B?U2NYNmh2NVhHSzNBaVNsNVB6bUhBVE9pMEFYU2xuUkhaSytSQzVtb3lmUW9K?=
 =?utf-8?B?M1o5cW9SVWtEb3RXM3J0VWRyc1Z3YjVGQWk1SnlscUthSk1oRlR6WUVPOWFl?=
 =?utf-8?B?UE9xRjlVeUZiUGhKYlNKK3dZYnZ4TkN2dENkWllocXA5bEp4UVdHcFUyOUFq?=
 =?utf-8?B?Qk5mTFUrOGFsVTUvcWlCN2IwNlo0Y1BiUVpua0tNN0wvUkNER1FLd1dvakJO?=
 =?utf-8?B?K0owSi9BeVZ5TEdWT3kwWW4zT3J0UkxmUHFaeHNrYWNFZFhIbXNOS2hKYTAv?=
 =?utf-8?B?RWJ1L2toSG83SlJDUnVwQXlNaHJTeXFkSlQyUEdoSHdCUzZYQ1pDdlFNS29K?=
 =?utf-8?B?elRud0xDWENMQzFuSi9SQ1Ixa2lXOFozeHRPbGg1QmhIOGtma0VuamRsalp4?=
 =?utf-8?B?aU00dENHYzJnNmcxcTNWaU9laDdyWTdBYnBTQ1ByUkNhVjRIcjNCT2RKelNh?=
 =?utf-8?B?WUNVamN5ckw3b0pLbk1pazM4Z0lqSU5ZLzIvY3pqWUFnSFhHejZVSDRDUjRG?=
 =?utf-8?B?TWVFTCtmMmE3OXhwU05KOElEZWhkVU9rc1BOOVphRmtUYURFTTIxTnZLd2ds?=
 =?utf-8?B?YnVOdG0wcVpMb2lEaWlQY1cvWXF0dzNvRHorczRrUGZhYTk0aFFPTXJSaXZp?=
 =?utf-8?B?Mm9XY0tjZHBFQ0tQT0FvcTRPZFFvcndHY04zY3FHWFdxV3pqQ3piZGtaSyt4?=
 =?utf-8?B?U205UHh4OEtPTnJld1JEZU03UlJ4dlpyY0RjQUk3Qnk4VklHTTg1ZklXeDI1?=
 =?utf-8?B?ODR2VWF2SnhUWnFnZ2F3TVFLb3FQay90aGo2UjBTL0ViQWllZHFOdFBJbTBH?=
 =?utf-8?B?UzdsSExKTFlTOEtGZktWNFpUS3dlUkUySTJ3aXhldEpvNnplemdzYU9CQnFo?=
 =?utf-8?B?bk1WRmRiTnljV2xORSthbWJIRHBFZElmRHh5dmMxZHI0cEtlVlN0VDIyWDJH?=
 =?utf-8?B?T0JLQkdobG5YMjVaTTYxYzNWdnRBNC80T0ZDZXg3V2w1Y0ErKzc5ZEJaY1lT?=
 =?utf-8?B?SVc4YlRMcUlTZHZYdzdsUVN1bi9JTFFoMlJMY2pOUmFpL1l5R0NWMGdhR2lw?=
 =?utf-8?B?RGlGVnJFNjZRWjNGNFR2djczY1pRUGw3dkJHam9DZFI0blgwVjh3SVR0VHNh?=
 =?utf-8?B?enhKbnBReGVGNnJuSTgwRXNVeGJ3ak1lU1lYSlhRZ29YUSticmdFSVhGb3FT?=
 =?utf-8?B?Nit3STM3QnJvdVhlRHJTQU4xRFlHYUkwTTdkVnlLWFdVMThYRnV5NHRQd01B?=
 =?utf-8?B?MWQrbUg1b2UzbzdLNjRWTWE1ZkhLREN1Z0g5ZXJad2JRMXRxdXJwMmcrc0pX?=
 =?utf-8?B?YldCV0NUbVkwSHVrOVMyaHg0T1NMNXhmak5wVFNXZGdHUU1raDZScEhySXg5?=
 =?utf-8?B?Um1jdjkxRnFXSlVqVW5lblJ5TUU0aXVlbDROSkV5Q055dmtPMUZOQVkzM3ly?=
 =?utf-8?B?L3VTY1lBNzNFV3NtRi9OcTJYLyt0VGJ0L05BNUNXOEdvSnBMYUJQTUlGT0Vo?=
 =?utf-8?Q?VwQQn08QFKWGP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWswdTU2cHN2SU1aU0pKcXhtbys2QnhSRXNOeTRRZzV4VGdOQWljT1BDSmhr?=
 =?utf-8?B?ZnRESjRwUmFZWjEzUzJJZ1l0YWVTb1BmOEwwS21TSGxXT3dyN3ZiUERPVG9W?=
 =?utf-8?B?UTVEZU1tVVdQZ3RwOVZwT3g3U1U1dzlNT2pMbXZuSS9FN3VCYWNDZVRTQ1hN?=
 =?utf-8?B?SmNOKzJadzJJc2xkYXRwNjNhMVJCd3FCU2FJMlhvYWtqRExENnAvalpnZmlz?=
 =?utf-8?B?VWNyMHRhTzZIdjVRRFo3SWFNM0c1LzJpdjA1c1YyY3QxTnl3QWNEN3pnNGRZ?=
 =?utf-8?B?c09ud0JoMWlkRVZDOUJVYWh6STNlR2p6VUhOSWZaRCsxRUF6bVhGTkZxTjVD?=
 =?utf-8?B?NjIyRUREcVI1ZE1Ra1hCenJmQW1RQmptamRkbmUwc2dINi9XTGZXRzF2enJB?=
 =?utf-8?B?VVc4eFdYVHR5ZGZySFlKandlK0VkU3NHUXg4ZzFwZHpjV215VEY4T2RvTXNz?=
 =?utf-8?B?SFE4NjhKZE9Pd2k3dVJnUEVoaEMrRFVIN2pWUnRUZU0vSE0yTTFnTVVFQlgw?=
 =?utf-8?B?U2RkeEFwaGdtY3g4U1NSdUNHOUQxQTZmWTUraUhlakR0bjhXMjFON2VDaSty?=
 =?utf-8?B?ZVdDbUNJYlNxYU9BdjIvdzduZ2E0a2dXckNmdVYySVhsN2lPVFVRNStXcVlM?=
 =?utf-8?B?Zy96WWUwRHhFTElwR2F3bG4yc05sU2lsMlBVTUJLeFZkdkY0clR3RXhYYXAx?=
 =?utf-8?B?eEtudnRIdFZnODlyanN4WnRWb0x1dGxXZGVEQXFyZFAwUURLZjI0ekt2S1FR?=
 =?utf-8?B?dU9idmRUWjQyK1k0ZDEzOWM5N2E4b2pjc25aWFB2N040dDFwWUp1WVRUbTJu?=
 =?utf-8?B?SmtnODBHTVJnV2FaV1lFZUpQZ3d3M01zcWMzanRqNlQ0QTFMb25lUXhlZU41?=
 =?utf-8?B?N1pUbEFaNW9Iclp5aWRBYXozRUhkdTRXaEcyc0kyd2RKUVdRa0lLMWZ2UVFG?=
 =?utf-8?B?RUl4K2JLNU1ZTmdqSVRJSVpxRTZzYmVXYXA0TVA3aDJHVG5SelJ4SGtxdnZI?=
 =?utf-8?B?bGg5K1EwZXpJbGJtRHViNDhsMEZOVVZzamJQeDE1NHl2dCtQSUZ6bERhU3Na?=
 =?utf-8?B?WC9nYTFidTc1SytUcE9RK3BQbGhtWXVoTEtCNnQydDliNXBBYmJCamFMNFNx?=
 =?utf-8?B?QUk0bXlWQ3ZNT09aSzhkYysvZDkzejVrSDBkUU8xdnlKb0NuS1o2bmRLT0tI?=
 =?utf-8?B?Z2dPY3p6d2dORUY4NlBOUnQ0VDFjZThLNk1QSWZPcFFLOWE3c01tQ21LSnFy?=
 =?utf-8?B?bkF2NXFsbXdlMkZrQno4ai9HOTF4d2lwMlQ1akxMVmg2d2dYREl2QUZ2T0xU?=
 =?utf-8?B?cTUvemNUWEFkcm1UZUI4aUl4VkhyWE9vWndMczFKQUNuRXZsazVsbndjVWIr?=
 =?utf-8?B?NjhkKy9iWWZRNXBZckd3cjBUWWx1VWlsNDdaZ2tyYVlvc2J3R1hwZ0VuMDd3?=
 =?utf-8?B?d1R6VjF0cGpBbXBkSnNSRm9IZmhFUysyT3lPc2ViR1dsVHJkWCtYRTFMdzJD?=
 =?utf-8?B?UmpuTGFFVTVmSTl3c3hYbzFEZ1FkVVlNZmhMZ0o4RDVaZWdnTkROTk1nTVVr?=
 =?utf-8?B?RUZ1cWh3dEpBNHlQeEhFZXVCRFpmZmlucjNTN3N5UFp3REZTQUV5SEFGRHhx?=
 =?utf-8?B?aENiMWJJWWF2UmFVN1g1c0RPVWNmTFo1WlhaMllJK3I2bHNpUlVkOGs4OHls?=
 =?utf-8?B?SjIrMFpXYk9aS21HNVo3a1lXTjB0elowc3Q0TUtETzVQL2FML0Rma05hM0Vv?=
 =?utf-8?B?bWxZM2NvR3hFZ3JyclRiTmpHMzJqQ3liczFYM3c1QUplaFR1cEYydnV3Y1Zs?=
 =?utf-8?B?a2EranlTQ2JUOHFaWllyakVIVmtTVEcwUkxoVkR6bGpGT3h6dHRrWDUvOTlB?=
 =?utf-8?B?K1Z3YUxMMlM2MGpGNTlPMXpLcnRETlN6eE5YdEo4THJiYUMzOHpOd2RiTGFn?=
 =?utf-8?B?d21tUkFKempISlc2bGlteVRSM052aDROUlczWHkyZ20yVHJiLzFjSEFLZDNW?=
 =?utf-8?B?dk52NXBpTko2Y2VmQXhzWXpnM09sNGt5SGdkLy9QYVBncENCaDBEZ1JvRWJW?=
 =?utf-8?B?Sm1vRUpjTHl5QXBWV3MxTlR3bEpKditpK0o5WWt4dDJnT0w2bFBadFNxNzl3?=
 =?utf-8?B?cnp4M2pKQVRNRGh4R3R6SWNRbVVjY1dkNUdudzlCN0JwM1YzNFlsK2JkTmor?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BMD6IOBh1Ev/qlfZxK8x2CMAIU6VtzaOXt7rrV1x3T+ugRNl4RY1/isNL+DSYaK+LXwKKfnWF0BhexvzCqXkGFtdLungNiA73OzUrgx8Jmxn7WqRFZIDHNISpSrNJEaXJbD8P67cjD3KryEUOglrBPnutXSly4DivecB88hvdLddioJjOeuTnlcmfATMEr2CVjrezfsrHAADNOEE/Oi+lcCqSRt9TiYD2Fh4mvo9LjCS/2A/oFnGdCWPCZjdjFLjc5WBpM22KX+eccfiQC94NOQDkU7a51w9v+v/Y5hNQCd9D54vYYOzN3UXdyuTtedE723aE2LwLA4rLQK4g4XhGpL/+28eG0kmxIXziJOUwaqHhlJZ5NW+l5C7+iU5uTIyZBiWzgPgIMdV1KzPo3/aUZe2E7UC9Aebt79NoS4Zt5snLlnDd5XEuqYNAwPvuRrhd0I9X1UK/uW8P9vYY+m+fse/oE+7n4X0Wv5bQNGKxdZV49nM10FN1g9tU2fDPCiWy6LunD+dIH5702kwfYbi++b5502GyQRt8dZ53hH1LJ+PTbsm54GIHSQGi0OqF5PZofqSrbsqDNm71gD0hzG/2xe8PJ8Ez3eDHzkQGeIaFjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750df021-d46c-468a-d9b8-08dd44a1c5d8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 22:26:15.8217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw+jbsz0IcSEwcVTUNsNJwcXkljf0GIOO0CJmV4Ji9nYG59vjdNmQqpy86hXkfIn8Oxo6/4LbWvLqnZlDfrcKf02N29zyaN92nkcNNhiSsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7265
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030163
X-Proofpoint-GUID: 0XhnORWVzB-xG_WPaPXWwSxiDoUjFpj4
X-Proofpoint-ORIG-GUID: 0XhnORWVzB-xG_WPaPXWwSxiDoUjFpj4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/3/2025 12:48 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> At vfio creation time, save the value of vfio container, group, and device
>> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>> the saved descriptors, and remembers the reused status for subsequent
>> patches.  The reused status is cleared when vmstate load finishes.
>>
>> During reuse, device and iommu state is already configured, so operations
>> in vfio_realize that would modify the configuration, such as vfio ioctl's,
>> are skipped.  The result is that vfio_realize constructs qemu data
>> structures that reflect the current state of the device.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c           | 105 ++++++++++++++++++++++++++++++++++--------
>>   hw/vfio/cpr-legacy.c          |  17 +++++++
>>   include/hw/vfio/vfio-common.h |   2 +
>>   3 files changed, 105 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index a90ce6c..81d0ccc 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -31,6 +31,7 @@
>>   #include "system/reset.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "migration/cpr.h"
>>   #include "pci.h"
>>   VFIOGroupList vfio_group_list =
>> @@ -415,12 +416,28 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
>>   }
>>   static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>> -                                            Error **errp)
>> +                                            bool reused, Error **errp)
> 
> Please rename 'reused' to 'cpr_reused'. We should know what this parameter
> is for and I don't see any other use than CPR.

Hi Cedric, glad to virtually meet you, and thanks for reviewing this.

There is no other notion of "reused" in qemu -- CPR is the first to introduce
it.  Thus "reused" is unambiguous, it always refers to CPR.  IMO shorter names
without underscores make the code more readable, as long as they are unambiguous.

Also, the "reused" identifier already appears in the initial series for
cpr-transfer, and to switch now to a different identifier leaves us with two
names for the same functionality.  Right now I can cscope "reused" and find
everything.

For those reasons, I prefer reused, but if you feel strongly, I will rename it.

>>   {
>>       int iommu_type;
>>       const char *vioc_name;
>>       VFIOContainer *container;
>> +    /*
>> +     * If container is reused, just set its type and skip the ioctls, as the
>> +     * container and group are already configured in the kernel.
>> +     * VFIO_TYPE1v2_IOMMU is the only type that supports reuse/cpr.
>> +     */
>> +    if (reused) {
>> +        if (ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU)) {
>> +            iommu_type = VFIO_TYPE1v2_IOMMU;
>> +            goto skip_iommu;
>> +        } else {
>> +            error_setg(errp, "container was reused but VFIO_TYPE1v2_IOMMU "
>> +                             "is not supported");
>> +            return NULL;
>> +        }
>> +    }
>> +
> 
> Can we use 'iommu_type' below instead and avoid VFIO_CHECK_EXTENSION
> ioctl ? and then set the iommu unless CPR reused is set.

Sure, I'll mke that change.

>>       iommu_type = vfio_get_iommu_type(fd, errp);
>>       if (iommu_type < 0) {
>>           return NULL;
>> @@ -430,10 +447,12 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>           return NULL;
>>       }
>> +skip_iommu:
> 
> I think we can avoid this 'skip_iommu' label with some minor refactoring.
> 
>>       vioc_name = vfio_get_iommu_class_name(iommu_type);
>>       container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>>       container->fd = fd;
>> +    container->reused = reused;
>>       container->iommu_type = iommu_type;
>>       return container;
>>   }
>> @@ -543,10 +562,13 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>       VFIOContainer *container;
>>       VFIOContainerBase *bcontainer;
>>       int ret, fd;
>> +    bool reused;
> 
> cpr_reused.
> 
>>       VFIOAddressSpace *space;
>>       VFIOIOMMUClass *vioc;
>>       space = vfio_get_address_space(as);
>> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
>> +    reused = (fd > 0);
> 
> 
> hmm, so we are deducing from the existence of a CprFd state element
> that we are doing a live update of the VM.  This seems to me to be a
> somewhat quick heuristic.
> 
> Isn't there a global helper ? Isn't the VM aware that it's being
> restarted after a live update ? I am not familiar with the CPR
> sequence.

There is a global mode that can be checked, but we would still need to
fetch the fd.  Checking the fd alone yields tighter code.  It also seems
perfectly logical to me when reading the code.  Can't find the cpr fd?
Then we are not doing cpr.  BTW, it is not heuristic.  The cpr fd exists
at creation time iff we are doing cpr.

>>       /*
>>        * VFIO is currently incompatible with discarding of RAM insofar as the
>> @@ -579,28 +601,52 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>        * details once we know which type of IOMMU we are using.
>>        */
>> +    /*
>> +     * If the container is reused, then the group is already attached in the
>> +     * kernel.  If a container with matching fd is found, then update the
>> +     * userland group list and return.  If not, then after the loop, create
>> +     * the container struct and group list.
>> +     */
>> +
>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>> -            ret = vfio_ram_block_discard_disable(container, true);
>> -            if (ret) {
>> -                error_setg_errno(errp, -ret,
>> -                                 "Cannot set discarding of RAM broken");
>> -                if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
>> -                          &container->fd)) {
>> -                    error_report("vfio: error disconnecting group %d from"
>> -                                 " container", group->groupid);
>> -                }
>> -                return false;
>> +
>> +        if (reused) {
>> +            if (container->fd != fd) {
>> +                continue;
>>               }
>> -            group->container = container;
>> -            QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>> +            continue;
>> +        }
>> +
>> +        /* Container is a match for the group */
>> +        ret = vfio_ram_block_discard_disable(container, true);
>> +        if (ret) {
>> +            error_setg_errno(errp, -ret,
>> +                             "Cannot set discarding of RAM broken");
>> +            if (ioctl(group->fd, VFIO_GROUP_UNSET_CONTAINER,
>> +                      &container->fd)) {
>> +                error_report("vfio: error disconnecting group %d from"
>> +                             " container", group->groupid);
>> +
>> +            }
>> +            goto delete_fd_exit;
>> +        }
>> +        group->container = container;
>> +        QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>> +        if (!reused) {
>>               vfio_kvm_device_add_group(group);
>> -            return true;
>> +            cpr_save_fd("vfio_container_for_group", group->groupid,
>> +                        container->fd);
>>           }
>> +        return true;
>> +    }
> 
> The above changes are difficult to understand 

Agreed, the above diffs are indeed hard to grok.  Please apply the changes
and review the resulting code and let me know if it still needs helpers.
I could move all of the code after "Container is a match for the group" to
a helper, or just the code after "group->container = container", but IMO
neither choice helps one understand the slightly tricky logic in the loop.

> and I really don't like
> these 'if (reused)' code sequences scattered all over the place. It
> would make reading and long term maintenance easier if we could
> introduce helpers to hide the "CPR reuse" aspect of the machine
> initialization phase.

I'll look into refactoring and helpers, but I'm not convinced the resulting
code will be more readable,  because there are many separate steps that must
be performed in order, and the lines to be skipped for cpr are interleaved
throughout.

Again, I hope you get a chance to read the patched code, and not just the
diffs.  Reading a patched function from top to bottom, it is easy to see
what is skipped for cpr.

>> +    /* No matching container found, create one */
>> +    if (!reused) {
>> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>       }
>> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);>       if (fd < 0) {
>>           goto put_space_exit;
>>       }
>> @@ -612,11 +658,12 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,>           goto close_fd_exit;
>>       }
>> -    container = vfio_create_container(fd, group, errp);
>> +    container = vfio_create_container(fd, group, reused, errp);
>>       if (!container) {
>>           goto close_fd_exit;
>>       }
>>       bcontainer = &container->bcontainer;
>> +    container->reused = reused;
> 
> that's done already in vfio_create_container()

Thanks, I will delete the redundant assignment.

>>       if (!vfio_legacy_cpr_register_container(container, errp)) {
>>           goto free_container_exit;
>> @@ -652,6 +699,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>       }
>>       bcontainer->initialized = true;
>> +    cpr_resave_fd("vfio_container_for_group", group->groupid, fd);
> 
> can't we have an helper routine to open/reuse/resave the fd ? Same
> comment for vfio_get_device() and vfio_get_group()

Yes, for some cases where the descriptor is opened using qemu_open, I could
define a helper.  It would work well for vfio_get_group, which was:

     group->fd = cpr_find_fd("vfio_group", groupid);
     if (group->fd < 0) {
         group->fd = qemu_open(path, O_RDWR, errp);
     }
     ...
     cpr_resave_fd("vfio_group", groupid, group->fd);

and now becomes:
     group->fd = cpr_open_or_find_fd(path, O_RDWR, "vfio_group", groupid, errp);

but now we need an additional call to delete the fd on failure, so the helper
provides only a modest improvement in lines of code:

     free_group_exit:
         cpr_delete_fd("vfio_group", group->groupid);

Also, the helper cannot be used for vfio_get_device, because it creates the
descriptor via VFIO_GROUP_GET_DEVICE_FD.

And it cannot be used for vfio_connect_container, because the reused fd must be
known early, during the search of containers, before qemu_open("/dev/vfio/vfio")
is called.

>>       return true;
>>   listener_release_exit:
>> @@ -677,6 +725,8 @@ close_fd_exit:
>>   put_space_exit:
>>       vfio_put_address_space(space);
>> +delete_fd_exit:
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
> 
> Another exit label. That's the 7th in vfio_connect_container() ...
> This is becoming too complex, we need to refactor first.

I don't see any obvious subroutine candidates that would reduce the
goto count.

But, if we set and clear variables appropriately, we can check them while
unwinding, and rely on some cleanup functions being safe to call even when
not needed, and delete all intermediate labels:

fail:
     if (group_was_added) {                     // new local variable
         QLIST_REMOVE(group, container_next);
         vfio_kvm_device_del_group(group);
     }
     memory_listener_unregister(&bcontainer->listener);  // safe
     if (vioc && vioc->release) {
         vioc->release(bcontainer);
     }
     if (discard_disabled) {                // new local variable
         vfio_ram_block_discard_disable(container, false);
     }
     vfio_legacy_cpr_unregister_container(container);  // safe
     if (container) {
         object_unref(container);
     }
     if (fd >= 0) {
         close(fd);
     }
     if (space) {
         vfio_put_address_space(space);
     }
     cpr_delete_fd("vfio_container_for_group", group->groupid);  // safe
     return false;

Sound good?

- Steve

>>       return false;
>>   }
>> @@ -688,6 +738,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>       QLIST_REMOVE(group, container_next);
>>       group->container = NULL;
>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>       /*
>>        * Explicitly release the listener first before unset container,
>> @@ -741,7 +792,12 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>>       group = g_malloc0(sizeof(*group));
>>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>> -    group->fd = qemu_open(path, O_RDWR, errp);
>> +
>> +    group->fd = cpr_find_fd("vfio_group", groupid);
>> +    if (group->fd < 0) {
>> +        group->fd = qemu_open(path, O_RDWR, errp);
>> +    }
>> +
>>       if (group->fd < 0) {
>>           goto free_group_exit;
>>       }
>> @@ -769,6 +825,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>>       }
>>       QLIST_INSERT_HEAD(&vfio_group_list, group, next);
>> +    cpr_resave_fd("vfio_group", groupid, group->fd);
>>       return group;
>> @@ -794,6 +851,7 @@ static void vfio_put_group(VFIOGroup *group)
>>       vfio_disconnect_container(group);
>>       QLIST_REMOVE(group, next);
>>       trace_vfio_put_group(group->fd);
>> +    cpr_delete_fd("vfio_group", group->groupid);
>>       close(group->fd);
>>       g_free(group);
>>   }
>> @@ -803,8 +861,14 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
>>   {
>>       g_autofree struct vfio_device_info *info = NULL;
>>       int fd;
>> +    bool reused;
>> +
>> +    fd = cpr_find_fd(name, 0);
>> +    reused = (fd >= 0);
>> +    if (!reused) {
>> +        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>> +    }
>> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>       if (fd < 0) {
>>           error_setg_errno(errp, errno, "error getting device from group %d",
>>                            group->groupid);
>> @@ -849,6 +913,8 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
>>       vbasedev->num_irqs = info->num_irqs;
>>       vbasedev->num_regions = info->num_regions;
>>       vbasedev->flags = info->flags;
>> +    vbasedev->reused = reused;
>> +    cpr_resave_fd(name, 0, fd);
>>       trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
>> @@ -865,6 +931,7 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
>>       QLIST_REMOVE(vbasedev, next);
>>       vbasedev->group = NULL;
>>       trace_vfio_put_base_device(vbasedev->fd);
>> +    cpr_delete_fd(vbasedev->name, 0);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index d3bbc05..ce6f14e 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -29,10 +29,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>       }
>>   }
>> +static int vfio_container_post_load(void *opaque, int version_id)
>> +{
>> +    VFIOContainer *container = opaque;
>> +    VFIOGroup *group;
>> +    VFIODevice *vbasedev;
>> +
>> +    container->reused = false;
>> +
>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> +            vbasedev->reused = false;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>   static const VMStateDescription vfio_container_vmstate = {
>>       .name = "vfio-container",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>> +    .post_load = vfio_container_post_load,
>>       .needed = cpr_needed_for_reuse,
>>       .fields = (VMStateField[]) {
>>           VMSTATE_END_OF_LIST()
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 53e554f..a435a90 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -85,6 +85,7 @@ typedef struct VFIOContainer {
>>       int fd; /* /dev/vfio/vfio, empowered by the attached groups */
>>       unsigned iommu_type;
>>       Error *cpr_blocker;
>> +    bool reused;
>>       QLIST_HEAD(, VFIOGroup) group_list;
>>   } VFIOContainer;
>> @@ -135,6 +136,7 @@ typedef struct VFIODevice {
>>       bool ram_block_discard_allowed;
>>       OnOffAuto enable_migration;
>>       bool migration_events;
>> +    bool reused;
>>       VFIODeviceOps *ops;
>>       unsigned int num_irqs;
>>       unsigned int num_regions;
> 


