Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DB1CA0EE4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 14:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umCJO-0007FW-LH; Wed, 13 Aug 2025 10:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umCJL-0007F1-Uv
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:18:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umCJI-0004UT-TL
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 10:18:38 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNCVU006609;
 Wed, 13 Aug 2025 14:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rruePf6cmUAZRgNzn7vsL3cpO9kVP27/uIc6tiuwJX8=; b=
 YltNVLhqb5z7K9nHFHEMK9Esr4GrwKCe5aRIRzxww5PGUX48pooxGO8YsT1U3NL0
 o5dk5uWN1s1MVGy51oYNLf2hp5G28OX8YgCbqJW18Ipgdgo6Qct0NbV9w0jhs89p
 yqejad1VPePiE7nbKkj5ijeeB30EpIErUTmt0/IjovDknE0KtrZI1dA2B0wZsZQT
 5U5TKWyKfGCIOk5Ybq43tAuieFEZNfmfJyeK7j/Orc+FGhV22kfxLEzQB827X4Zh
 X+pJvq8YyW0ih0basJU109vtk3sqL2myJ88+cPy3klJf2j6zxNa4NEfnIRHtkU+O
 vyY/z0LW7nWYLn6UAEExDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44ypwr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 14:18:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57DD9HLG006428; Wed, 13 Aug 2025 14:18:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsb988b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 14:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMd6sVBuNnqAz11ky40k7ij1h8MwEX33svQvaK9daLZQEoH7Js/uxRRnKYgcwiO3/KvsrWbrdsqcNzkenD7QkgVBTxEWG/F2RQs6XPWpzQi2F9FwrmBu3r6CodFPvtUtGH6xGQdhmmyM5wXJHewAOToTB1wNS1EFUNuVzsuEF7G3OOdgVxRKBwfONtGuPhEcHNHzCeIthTGXfoFToWpniki1c+k5CloKF5Mf3mu/qDtHPMOVv8Qv9SwQPW6jWjqseNbOaWx/8wpOWgbYQCJ3wQwG7ddqd0H3ORcN2XUD4Yc0WNLIRzHWCcU/bomwCXh7u9/7lUwjgn8YYaD5Kirpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rruePf6cmUAZRgNzn7vsL3cpO9kVP27/uIc6tiuwJX8=;
 b=PiJttYQt4JtH1S2nwfaPgM3z9Q6hpFUHHzy0Egmjs3CXOxQ2wZSG68Oufs7m67UjdGd5NoqQ9qw0rfBMY4paSQ8XJn5t8hSucTANfba/2hWVPQWjsMBXkvBizmJd15P9Jvf8S+TKNsAkJQg1o4sNiE/TDCHJhAVI7oa8ael37NCXwXwxT/Lm2s3hvAIkeEj/sm3pr+hX5XtlNVgrpl3QjG8XeX3ChumqbHBE8nrjngO45mjWiRIstjF/Iano8tRdqi55+kHu3BlX2c4CmXzcXUx4UbPVuys68tvb/Q6W0BWVhBWEp/3MXe6zISdovRI+7yVKQx0liHgOStnD5D9qcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rruePf6cmUAZRgNzn7vsL3cpO9kVP27/uIc6tiuwJX8=;
 b=RR8mJBQyDojv0efITM11N0nqIfQd2UlQ9vVMCB0lHW+ymM2ZEdWAv9ubHXXIWbQ1W8efZNXFhvRk6Z7zE9+0GU2nDU2BRMsAsZsXpyNGHcuK4NoQbV9kAOxfPhwNJOkr0yYaPuLiiTCS2a23ysvoFCY0dRYvhSJH57AWX4LLaVk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 14:18:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 14:18:23 +0000
Message-ID: <1ba90af9-5ad2-448b-8e94-9688417c6e81@oracle.com>
Date: Wed, 13 Aug 2025 10:18:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 08/38] vfio/container: recover from unmap-all-vaddr
 failure
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-9-git-send-email-steven.sistare@oracle.com>
 <9d709d91-1567-456a-83ae-b80f165da9a9@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <9d709d91-1567-456a-83ae-b80f165da9a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 9737c9bd-249a-4856-0402-08ddda7442ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBMRDcwTGVyU1l3aWF4REtxL1JWeWZtM0kzSnF0UnJEUVJ4bXc4Q2JhSDNX?=
 =?utf-8?B?M1J1STNhUDIyTHNISDNnMTVic2U1NGNoZVNQUStpZXpqbjRDM0lFZE1vUTd5?=
 =?utf-8?B?c2FBMk4vSEJsK0dObjVaTUpzYTVYYWxzSmpHeU1ud0xpOTV0c0dVYVBkRDB0?=
 =?utf-8?B?Mk5FSit3dEJlMnVta0NyS2lCeUxXNTJPbkd5cUtKUlNuRzZQdUNRNjdvU3Vh?=
 =?utf-8?B?MC9oUnZCY2orOXg4VnM2VC9QYmE4SSt2ZkRjcmROMU5BNGJPZ2FydGhJMytD?=
 =?utf-8?B?SkRyamd3cGJlUVgwek1XWUtXYU1OSzBmZG11TEp2KzRNWkxHY1dLUG9zQzVW?=
 =?utf-8?B?RGFCM05lcFRNYlRtNGFhVDdlYWJWczhCaUx3VjRkMm5YWElzUUNiOTlWbFZa?=
 =?utf-8?B?YlJSRlo0bFRRUFZJeEhvQVlvRDAvVjBmVlQ4T1hDSzRDcXhJKzdaNE5nM1ox?=
 =?utf-8?B?Ti80bTBWNjlLdUx6OU5aVUVmRWMrMGc4bUlvSDA1bXR1WUZnb2lVRzVQc29S?=
 =?utf-8?B?TEVlL2xkbTBGWjVnLy9keXE0K01wdmdCOGhkWEtFQXRzRGpnSUVBSHBzWlFp?=
 =?utf-8?B?MGljY081Zk5HUCtKc1NaMy9MV3FnOUVldmgwbkF5ZE9NQkIxV1FwTlRJcldn?=
 =?utf-8?B?SFplTy92ZE9DRXh5K3JhU3VQYnM2MDBVdityc0ZTem9yazhkb2dPMlRZbWE0?=
 =?utf-8?B?a3dRTk15WmNFUG1MSmVTc2hmM3VtNE9YQUJvVjU3RXJkMExnWjFKZGpzQTNo?=
 =?utf-8?B?VHh6cElRSHM4U3YrdTZaaXpJeWpIb2w2cnd4ZWJwTUQrV0dHZmJMTVNNZ2ZK?=
 =?utf-8?B?UG9Zbi9YeFNpcEI2UFBnc3Y5UDB3SzBvRTJwSFlra0ZRTWdmNXNVbGNHbTRU?=
 =?utf-8?B?ZzBkWE9RSk1ueVF1NWFrM0tScERXOTBMOGpadU5RWUNvMXMxV0Y3YWVZaU1X?=
 =?utf-8?B?SU1pNkg2Qm1IWlJoV0NMODJ0alRlcURING5ERy90NnRqVFNtNzllSXVwQyt4?=
 =?utf-8?B?Um5MVE9uRlZlS3lkc29xWkcvS25xOXpua2ZoY09lMnl5V0pTK1A0RGFUQ2JI?=
 =?utf-8?B?QkwxNTEyMlhhd0tkOFJtRk5lWS95REwxaXJWUTVENGtuWmYycEV2QUt2TW5C?=
 =?utf-8?B?dTlGTzQ3Q2RtUFRzWE9saTIvdC9OQ1R4QUFkcU5JaVlORzZDRTBtOXFjWjlj?=
 =?utf-8?B?SlpFcWc1VmNUSWQ2RWpyLzJTTEt1MVlyejBwZm45QzE5N041Q2RqU1d2QTli?=
 =?utf-8?B?NllhaGx6U2xRT0xOTGVRb1ZVekxZa2pCN3BwWUpFWGVPdUdPK253ckNlU3Ft?=
 =?utf-8?B?RmthZGJaSEJpMmNNOGpuQlB0SzVja2lVMkxPdWdEWXJhR3EzSUluWVVwL0Fl?=
 =?utf-8?B?OVVOR2liajg2VXVMYlJ3aGkxYXN0cEJubllWUGRLcVBiTThHTVhUbHJKdGFt?=
 =?utf-8?B?U3dmL2ZXd1dkQjRHSVcySmRRVGo2RDMyaW4wSWpEaTJGMEdLSG5FY2N1ZGNT?=
 =?utf-8?B?bzZRZUJCVG15eUNhbHk3WGZ2NUp6Yi81RDlMaHZ2UXErLzd4VUorS3J1ZUh4?=
 =?utf-8?B?VzFyY0d1UHJldi9PdFgrR05WRnltcmVzSGRHWXhrallqSzAzVC9BeUtLWTBr?=
 =?utf-8?B?bDdTNDBQOXpaWWhWZUdHcWZJa21vTU9IUm1OWkx1aUZGK20zQWRBNlpBOHpW?=
 =?utf-8?B?K05sdnNVWk43L3BJYkM2ZXJVbVNCWU9UbHJjTGRHdUYveWZEODRlY0RnUUps?=
 =?utf-8?B?MEhtRVBpOTcvWmRxQjhvdC9NQkpjTnpyRWpIS3diR3NQZEl0dTNoOXQweFls?=
 =?utf-8?B?RkxtbWIwMlRvZnpUUy9ZY0hYRExQam5XK1RJM0RlenFKc3lQVUVrR3ZvbFZU?=
 =?utf-8?B?TnVQSHRpaUVUZUlpQ2JXOWRlY2lJRnFrSVNYOEQ3OFh4bEJId0VqSG1qODMw?=
 =?utf-8?Q?V/wzKVawLw8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWIxOHBSL3NBWkVzNE1kZXVOOFA3cm1xU2tmeEJsOXI0L3BXcWx5OC9RN01v?=
 =?utf-8?B?YisvVmh6b1VQL3R2RDJCUTlOdlMrRTdHMlVxdEcyYmw3dG5qWHFxT0d0TzBs?=
 =?utf-8?B?L1oyM09xS2JnMDZZOU5WK2JGTlE0M1hWbGV3eXgxakFiT0RCbTVxbEdzWmE4?=
 =?utf-8?B?c2s2TkxFaGU1UjVqNHM0bUhUMVltT2c5akY3MEE0UnRLZjBrK3g2TTdjcUkw?=
 =?utf-8?B?RjRLTU1HSE4vRWsyVkI0THRBbFpoU1Vyc3NvUlYvcThKTXk1amdITERKbjNO?=
 =?utf-8?B?Y0kzSDlZTXcxeU5aUU1pS0Z6SmVuUGdRVjlTdnRRMUdTR01OSjBJK1ErYS9V?=
 =?utf-8?B?OFJHYnhSUlA4MWdYR1JWZjFpaVRTaDNQTXB3L3hMa1ZLQk9oVWc1bDNoeFBv?=
 =?utf-8?B?aFNNQlVCNnA5N2VZMWVNVkdwR3B5cGtIR0xySjVMcTVHcFViT1NqU1hhcS9S?=
 =?utf-8?B?N2xHQ1UzM2JDa25GZXhabllzWEQ5b3BUNXBaMDRJbWFWMXBnZ3MvSWNackhq?=
 =?utf-8?B?bUd1dGxsRUZwd3NMWUtheDVVTEhrQm5OUEUzWnVyY3Q1NUhobkltKzZPcGRB?=
 =?utf-8?B?RXpqQ1Z6cmluWHNqN2hEVmIzc21UR25CbWpUckNUT0dRYVNoOFRmeTJWclJt?=
 =?utf-8?B?c3lGdTlVb1l2V0JnV3UrNHVUZUdHVzl6eUo5MnE3QXpxVzIxM1RPY0RFQ3dI?=
 =?utf-8?B?MmpURXBaekU0Vk9CQ014cVdRV3NyRXpSNGdZMzZYY3BwejVWQTg5bGhxNC8r?=
 =?utf-8?B?d0ZtRzFaZyt6RkI5cWJxbEhWeitzTnpuN2hEd1BBb3huVi81M09Uak9RTHFq?=
 =?utf-8?B?NDM2c2E1RUJXUWxRKzBWY3NpMGZDRzlzL3cyZFhlbGh0czl6MGl1Z0NoVWZz?=
 =?utf-8?B?ZEJDbTZVd2J1Ynl5VkxOczBLNlZTaG5CajJQTnJEWUZ2NGkvWm9CYUpRSVpB?=
 =?utf-8?B?Z0lkTDJFeklIaStHWnhKbDdzeENvVk9OblJ4K3h6dXZ2RzlCUUlEWGV2UUp1?=
 =?utf-8?B?d0JRcllXRXZGdURPS2krN0NaTkN4blo4Wkh1NXV0cmtYNllwWWVlVHBocDho?=
 =?utf-8?B?MTBuOXVpWDZoSDIvbzZhOVJ2d0o1VjJ6UlV6WUpUNmRSbGRtNnNWcXdyYXk4?=
 =?utf-8?B?ZzROSEtxR3o1bFVtLzRiOTdQRDVuNmIxNlBpYmxZcTRnU0ZIVHpDWjFBNmpX?=
 =?utf-8?B?Z21sSW1jdXFZWUQzVTlNZnJYRUI0UVlUcDRWWU5mWXVqYm44WXBwL1dValRB?=
 =?utf-8?B?ekxNMDl1M3pzNWVZTE5sekx3Z3hxdC9XWTlaM2Z3eGppV1QzQk9ZUFNSZ0tv?=
 =?utf-8?B?SXdEcDhoYmJQRnlhNXlBS2FQb3BVSDZnYkdFcktLR0RVL1N5eTI4MWJwQURM?=
 =?utf-8?B?Y0VsUkRPTjlBNDdmbUpyTnpSejh4Z3BVMmpLRk1MaS93eVdFelJMWG9lQ1Jo?=
 =?utf-8?B?QURKTGpkNnBXVW5Nem8vR3lkVkxLMFhrUnRZdmVnSDVHamZGbzFweTU5dzlY?=
 =?utf-8?B?RHA0SVZYUGpnSG1UM09YczV0VUJBTmZVUFp1ZkJOa3A1RUQyYmZVeEpnQlM3?=
 =?utf-8?B?QnBMLzNyRnR0cDE5Zml1ZEgyRzhRY1FSVGx2MU9IL3d2a2R6S0xhQXZ3MENu?=
 =?utf-8?B?WXcraU80dFN2VmlBWFVmTTNJVGthKzhNQVExVlNEelYzMTRnbXVXM1RtaDRa?=
 =?utf-8?B?bEtZT0o4ZUdTUmptMnhQNGJ5dmk2NkEyZ1Z3QW9qcVZMUXpYN21FTXNPL0VB?=
 =?utf-8?B?VGtIVlRDRHNsVzJTOWQ2WTJ2Vi9VR1NvL3VGRmtJN1NHN3A1ZHlVc2t0TFQ4?=
 =?utf-8?B?NDlDNnVGOVAzSzB1N0FoNW5vM05aT2ZOcDNVT0pHSVNSUW1kWllubUFEbk9s?=
 =?utf-8?B?eGVFRVRJKzFQM0N1a1VlRkNsN0loMlh0UGpoUE4yeWF6bWhlOHRsNHZhaHVS?=
 =?utf-8?B?ZzY1MTVlN1R3d0lWY0VjK1VmWXErTFVNWGRnOVozbHZVcENxL25WUXlQOE5F?=
 =?utf-8?B?bHh4Wi9yYWExeFNrOE5hQWFjbTd2aVpVaW9VMUsxaWc1eU9UT2NaZDZxQXFM?=
 =?utf-8?B?OERhNExNWGg4bHo4a09tTHd1Vk9zQ3FLMHBMWU9rRnhHVVlrdzErcnJRL0Rw?=
 =?utf-8?B?aDRUdHd6a3NYUGo0bkEvUDMrTC90L250aldKSlMxOFpRZ0VBVWQzTktwTVdI?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aQ3TYk8OUZSxNTcrVyuUIxhUDOQD1KUp1NF1rZwu+uzEKamtsEkMzLbOP5MI2L47XXIC8hvKyfzfcP0wlHnuH+9Wsqby6vazphJKaqLNk0x8kMAItrbsYtiyS+h/BzrFOziNiuhHrfNFODNpUL7F7DCGne9Fzv0/waU65JejTy3eqaorKNgqvT0WOoZgVcfZaQ/H5wpGlUOOi1+pi5CM1fGp/pHE2q6gXhqVboqPXXX0yRBSBPAnIYetSN7LFEyjuz5zvwkBOYHl9Liran99NbRS80PtamKpxqhWe6v0lk4YxYwgEhXbiqmD1+9svPBgAvmX0KW3/W189BvxmlICGp/sfInSsmiUTRBU3HMIjO/cUpuhaK2gLVZr0ZkujBacPwxymMW0pgkjrToQf071UYpJ85QkrJXGlTG54msIyhTiWPjATpPHmOGjOvruY6kw8knt/V2X3sjyWrDgvKy1T5CenY4BXsKyjEaL190Hiw+J5AUBnfDIFKEZbIq37sSTTMKxdyZifHRRF3QyVSiUA2/hEKAt3wYDs2WDVdwthcQe8I3c4S8SHyprailHhd1aUNqL0AaPyksgIP8HV8P/0y2rdryB1RxOgCLwsdnlnNE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9737c9bd-249a-4856-0402-08ddda7442ce
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:18:23.0548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfCDXE77ALzbIdNbuBi++Y1k5qb5wLgfDXsO8+2+SiJpKCeuyqB0rUenShQbY/49bFmwYzBWqQqlURYJD8i1sOI26P3rsaf57WUdQ0QqenI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130135
X-Proofpoint-ORIG-GUID: 4HNNrI2P7dKF0RKAB4wb3DnoxgwEw938
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzMiBTYWx0ZWRfX9rRN2g2GSj5h
 jwzUOylHmfhrEqHWoE8/xOlCtLN/YBiCpTmmxgFeBFK0dUKaDsRaqprRAYqSuGibCDgR67q6qIV
 A9ycIwNJZaBYFKPc7/3KVEc7E1aCYbr75lLTjEw7q+rfwpT+IVkNq27+mVU16/Y/9yubXlYOSnL
 mcaWMygbc1/xHUFHRfw8AZN9O5QbatM1QUK7mkeXxCv1cgdqUh9FOnkkMGr3ckEcVoPu9sCPeI+
 rCv9OZqZMqLt+7uZJmHNSEpLCMAOxXw3Q2lZW99SGlkoAFPsv3AJqLG38Xh1tIJ3ysu1zfANeg+
 QLonSM57Uv7+//1pzcHW6OpFn2Ad/CTvFubbdCEe0Mm3OXQNso8ZhdR6Xz2T++9IC8iGc/8KOOf
 2AYXMq3IRHggUZNUVIUMmme15UzifFrxIMVPE3mvguCAQ51q42skmALZoJ0fTNPd1jW6PVsy
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689c9eb7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=D8WYm96AcK1-sglnf-sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: 4HNNrI2P7dKF0RKAB4wb3DnoxgwEw938
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 8/13/2025 8:54 AM, Cédric Le Goater wrote:
> Steve,
> 
> On 6/10/25 17:39, Steve Sistare wrote:
>> If there are multiple containers and unmap-all fails for some container, we
>> need to remap vaddr for the other containers for which unmap-all succeeded.
>> Recover by walking all address ranges of all containers to restore the vaddr
>> for each.  Do so by invoking the vfio listener callback, and passing a new
>> "remap" flag that tells it to restore a mapping without re-allocating new
>> userland data structures.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>> ---
[...]
>> @@ -558,7 +570,12 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>        * about changes.
>>        */
>>       if (memory_region_has_ram_discard_manager(section->mr)) {
>> -        vfio_ram_discard_register_listener(bcontainer, section);
>> +        if (!cpr_remap) {
>> +            vfio_ram_discard_register_listener(bcontainer, section);
>> +        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
>> +                                                           section)) {
>> +            goto fail;
> 
> vfio_cpr_ram_discard_register_listener() can fail without setting
> an 'Error *' variable. I don't think this will generate a QEMU crash
> (we are in the !bcontainer->initialized case) but it would be better
> addressed if &err was set.

Thanks, I just posted a fix - steve

