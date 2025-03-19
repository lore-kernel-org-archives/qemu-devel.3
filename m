Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DA0C35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusVl-0007pl-Ae; Wed, 19 Mar 2025 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tusVi-0007pJ-E7
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:27:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tusVg-0004nS-7s
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 08:27:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8g0M2004622;
 Wed, 19 Mar 2025 12:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=7otYsH+4bcALrJr4FcT05OjThgOENTyWZO9Mn+4/Usc=; b=
 A5hzpQWYsFGwjcja598kqmrvlTm0QZGqEi3auj64hIv9wdYS17oQC/Cv2D5HaafX
 EDs6iYjaCPN38lh2jmvYRfiUO4b7D793WamhHwYBRP7sMNlClcqxfmU9jyB5FmKo
 +GQUDnbMFBWYnBENkPBwb4U+hG/vI26O4J1P7Oe7g8OSGagRQ5JiN+vWrWMOamXb
 6wCH1aGwxhCQ0LrpsPm/A58ntssoHtyAcaz1+zYnDYZEFGp5eOaMalgo4AfI3HML
 5j2XhcWeWtCQC12oufal/1PCnPmCNS6f49/WgKAfHsT+67kPLZ0LFrNfYaUv95lt
 9321MAG2Ak0D2HEt+KEspg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m133xu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:26:57 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52JC0ruM018564; Wed, 19 Mar 2025 12:26:56 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45dxdmj2vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Mar 2025 12:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXusAmwJLA6txgg7ify/0sYL8Ux/ApPcjnJGaf1fKETSOgsXF0AvsR0iR71CisXJ+1myh6aydocpfOkZCXloDqI2fanJ2+p5KzVJzo/v64poRb2ixK5sYdzdOnMpAWsdlZq33q/khFIQm7CRKeVfJoAy+tAgG/ozFAR7v1clab6cL5O1q8TowVinXmf/rQve1wTpp6Z+3I7lxa9GJXDah/r6skCQzN8uT7g7/njZF7FamMAStgUf8wyhFHvNf6lWRwuDuWg7b86qvpV/8YrJYXLKZscSykCh+LnvOmKNsd5kMt69w7ckCOIXITQB5TngqZbG8TwoNGFiWlCOtk7pKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7otYsH+4bcALrJr4FcT05OjThgOENTyWZO9Mn+4/Usc=;
 b=RBVp4KWtTBp8OWxEEWhpYgoVy6/5Z4bvHREC2ps6wNIpgXHUjoT0NnRC8VK3dhqqJGGdoXQ7T0cWBzrKeK7kx9g0jiztG03gw/cJj4Ii/R85tMWG4DRhTvR7k4SLZAlCEuNYcLihjTZvmZg9ShLUuHrdMeoW5MQY8gxfAwcpYVj0iYtwxfgaLUuavm3YGt7asPxdvV8X4tnKhrmVERE8ePcERSXC6FXTTKkbVuevHk6Y7Kd2+X4VGdyWCgS1Wu2fMXScUZ2k8MZM3ySEA2uBMhZRmV/fbbwSBkOwuFoP7X9obN/pMvPcaZ8RVfzkGlbI9sQRNT7U6yuWrYiKyQp5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7otYsH+4bcALrJr4FcT05OjThgOENTyWZO9Mn+4/Usc=;
 b=qmQo6+y/iz7D34DswoOz1EKkDEj6KN8kI9QeoH2l9urBBfZSUfdkgVF3UVPfzxitWZA3lHZV1CvUP6wCoj24N4EHJNmFPGEgj5n+Tn1lC2WDtejS144QMKymHXFuYJXwq6WVYYov6VoKJSSGDxtCyOfWceisUfsBOK1e30aAxgI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH2PR10MB4374.namprd10.prod.outlook.com (2603:10b6:610:af::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:26:54 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:26:54 +0000
Message-ID: <4d4031cf-4e58-4a53-97bc-207983a5deb5@oracle.com>
Date: Wed, 19 Mar 2025 12:26:49 +0000
Subject: Re: [PATCH for-10.1 05/32] vfio: Make vfio_viommu_preset() static
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-6-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250318095415.670319-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH2PR10MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a38ebf7-4b54-4489-7605-08dd66e1550f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWtOYmdGRVpGcmZqaGxjcHlvdWJFQ2NWZGFPVlFzZVllK0FvWG04UHdEOXlD?=
 =?utf-8?B?cG5sWFVSVGlzWTV3WWErYjVha3lRK09nQzZRTUlKZVU5UnNKWjlrelZtUEhQ?=
 =?utf-8?B?Rksra3B6QlJPZzk5cU5VanFLSHZkYXAyWGhCY1pKNGpDZHVjaUhRSFhYaWNs?=
 =?utf-8?B?RmxNVk5aMHJNaHpHeXYrbWNONGVVSE0yY3F1bWhLQkpZL1U5L0xnTksyaElG?=
 =?utf-8?B?VUVIWnRKT0dGK2R5WVpraC9oL2JnaXhFaGNxZnJxS2xrcGRDWW1PR24yZjQr?=
 =?utf-8?B?MGlZaC9kbVFSaHhiVWZ0QWRLcm1JRHFrR3pWZE1NNk5NSit6U1BYL01wc0pE?=
 =?utf-8?B?S2ZFTHo1akEwcXNRSWc3UFNrRDdlSFEvNDV3TjRCUDRVdmpjNnhNUFlQWWw2?=
 =?utf-8?B?U2RNZWF0RXpmakpqNXJKVDFuSERSVHFxN21lUUV5VzJISlNXUU4yWWkzUCtQ?=
 =?utf-8?B?ZzJHZys4MlFLeWFxM0VxblF6eXVLRnlrMTlRU2xUK1BmMDRWbmJudU1aQlor?=
 =?utf-8?B?ZHozWUhicSs1VXJLakZ0WHRuYXJKZG9sVTBpbGo3Z3dCcVFKLzlsQzlDQ2No?=
 =?utf-8?B?d1lnZWZCWDFsM0xxTDRxcVc2RkJJRTBRTlA0MEhaUkRrNHRHTjg1TDZqYTZB?=
 =?utf-8?B?MGwzRFZJaWJ3ZHBpOXhRQ1p3Q2Q2VWhzbzh0VXAzZEpsZXdxN0V1TXZMYUdK?=
 =?utf-8?B?WHFuRlhxUklIVzlzTWNnamM2allMWVp3WE1kaEhqc0NNc3dGR1hISlEzdGVh?=
 =?utf-8?B?cTJtN0RjZGd3T2dBd3pydDZUdm1xd0N6UG51dFN3ditRbFNNandxQUNhQ1Y4?=
 =?utf-8?B?b3B0NHdlalVFVkMxcVBzRlYyaTJqMndnTTNSajluN3pjbVQydm9wMFVzNEJn?=
 =?utf-8?B?c3FMcm9YMm52V2QrUHEzdmNvMG5IamlYZVBzOVdLekYyT2pZOUFsZTErUGpV?=
 =?utf-8?B?dGFuVFRlRGtJN01JZDJic3dEbDhLTjBCbWNSMGdTS1QzSlpxV0JoejZjaW5x?=
 =?utf-8?B?Ny9sVWE0SUZGNjZ6VHpwN3AwZ3FjRDEvNzNyNUZhNlJWd2ZSYlNnRlBCQmtW?=
 =?utf-8?B?ZTdzaDJ1a0wyODkwaWcwOVRTQytzVHB2eUZDRnc5UnBvZS9GZnAyeit4a1dG?=
 =?utf-8?B?NWpja1RLVXFIWmI2ai9xUU1OKzBaaC9sSHgyUTJ2MmQvZ3h2QTJ3UktXWWhx?=
 =?utf-8?B?RjFUcGF1d0RCYmo4UGZZaTVseldBSzJhTlpodTNxTHVYY1FvdGJDaGRRUFBL?=
 =?utf-8?B?T1VUNkk0YTE5VlVZRlNUMlRlbmkrdHNsaVVvQXI1QmRnTjRabGR0TUtYYUYw?=
 =?utf-8?B?QkxQTC91aTRnV2tXZjF2Ym9zME5qcGFLWU9IbGFBcnc1dUwvcnZrcU1PZFVN?=
 =?utf-8?B?NlNCNnNWS1VHNmxoTkhDcHNmMkwzVUlYdGtheEFDVjZFRS94aXp5dWgyemor?=
 =?utf-8?B?MEoxcmtWeHFWK2F2MllPMmxWSHVUMUF4NnVkL2ZuT1Z4TXZEWUp2bU5VTE5m?=
 =?utf-8?B?REc5UmRMSC8wUzJaZGx6OGxZQk1Na1k5ZHB3WkJxdnNZdHhFL0dCeUxranRm?=
 =?utf-8?B?L1Y2YTFQU3VEbzhOZmpOSDhMTkJoQy9EaUJNQUlRRVBraWNRV1lGTHN0YUc4?=
 =?utf-8?B?MDJVYUVkSWI1cEpMeURRTThiTkFPMXArb040c3VVQ0kyOWNJTllZSTNFRkdE?=
 =?utf-8?B?aXphUG40QmVsZXh1ZHZsRWpaMG1QZllaa0dhcHNYQ0k2SWNJazB6OVBhNlVZ?=
 =?utf-8?B?WXB3TVJRTGxuV1p4M09VYTkrYmwzbVFVQ0hjV0xkWE9HaXhkUlUrRmpJMXNH?=
 =?utf-8?B?azY0SDJhMklDM2Z2WXloSTZGa2RMMTFBK2FaakovV1lQYnlqWDhub01pY2tJ?=
 =?utf-8?Q?j0mtH3tedTfY/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xPR3FzZEdXOE91MTcvWEZqQjRQd3djQTIyK2h5akNaRE51QURoY2cvUVJK?=
 =?utf-8?B?ZlN4R0FYUURkeWJ0WE8vNFBHSnpydnIxNFpMcVFadkpaak92ZFZqZjFmQzNL?=
 =?utf-8?B?eGJpQ0dUSkNTd29wdTRzRXFKRjc0VlRrcG5pL25RT1M2NUVyNmV3RFE4cVUv?=
 =?utf-8?B?a2NaekZJWXNQUUlZRU8yYmFOWStYTHFCNEtsalduWERIaEFrZmloN1ByZHpM?=
 =?utf-8?B?WE92QmVUam5kUU5aOEg1RjM5WEthcUFxSjFKM2ovR1pUSjJFS1ZPdjBzUjMx?=
 =?utf-8?B?TTR2Ty9JVXNzUmpoYzk4NnlMWVJLTm1MOVcrZW5iUmtpdXB2OTh1OTdGb0Y0?=
 =?utf-8?B?amljbmc3SFp1SEJOcVVvYW55NENMOEx6VlU5K3lKWS9RYittT3NDMkY3dER2?=
 =?utf-8?B?TVdjSnI4N1d3Q2pBMHdudW9mS1FsdmRMdzFWbGp0ZzZUb3dIcEx4SjhGQUxa?=
 =?utf-8?B?WVY2WU83NG1ndnhjYVdINVBNcUFIYkpuMjhLYzNxeUw1bEdBSmtIWUlCb2xs?=
 =?utf-8?B?N0VSQUN5Uk5kNGhuOS9QT05tUzlUcjRxZEQ4RyswcHZza0hRaHZyUTJmenMr?=
 =?utf-8?B?TklPZkYvR05SczF4MHhVelF3VnBNTjlVVVdURGkrZWh4RStXOHRBMDdWWXVD?=
 =?utf-8?B?QVpxbUwyVVowMXJTcVVIQjZjVVlPaVJVK2p6TzQxQlZRejVtV3JuLzh2V3Ru?=
 =?utf-8?B?bDBXdnV1M2hqZUZRWWRsWW5LSFl1NUZCNTRzREZvY0I3bHNCdVUxREZSRUta?=
 =?utf-8?B?bXRZQy8zRFl2OWRXNWM4QTlwaTBFb1RLeTU1d2Zpd1RTVDc4eHVPUFZBZ3lB?=
 =?utf-8?B?cCs1Y0gyenUvQjR4NzRTUXNMWXdIZ0FKeTNmUk5sMjJkalF0WXBJbmNZRmg5?=
 =?utf-8?B?cnNKWk84d3FYQS9QUUg0MTZXdHJ1bDBlWlJrdThQZHR5TU9IR0dVeE9xelAw?=
 =?utf-8?B?d0F1V1pjY2xESTRVcXUralM1bnFXK3IvTnJoR0FFRXBQWER0SWs3M09HSVZE?=
 =?utf-8?B?QzU3MXFXWThRVjQ0OEpDNW9XeXo2NW5xeXBIL1d4WXZkWHFEMWdpTGNQVlBQ?=
 =?utf-8?B?ZXVvaHorQmg1Mm1kdFlKWkd5cC9RQ0llRXUxcUhtb2hwZXovMG0zb0RvNUVB?=
 =?utf-8?B?eVIwNkJtaGh1WUhIY2N6NDRyODhTeU9DVGJzbnl1TG8zVW9mdXhZc0pXUk0y?=
 =?utf-8?B?MDF5eXJyb2hnNExuR04vMDMzUG0vbExPV0JQTTVxZHVDRWVmcFIyK1ExWUFn?=
 =?utf-8?B?SlhFMmp2ZXdNNXZmMytaQXBwZEkxV0tKVm1tNzhUcXJGNHY5RHhlWEtJbG5m?=
 =?utf-8?B?UE5kNUJRWXQrYzA0eXlEY3lKNWg1eTk5U3NRcERxeFlGYi9KMDdpMVRRazVQ?=
 =?utf-8?B?TXlkQktGa0Y0dUVOMVZJamY0Qmp2S2gwQXN5SlNORmdaa1hWOTRvK1RncUNs?=
 =?utf-8?B?dzl1OFZGM0tiUlFhSzdtSVhLakFqSVAxOHJNMHlxRStyMXA5ODdvaUVhMjlq?=
 =?utf-8?B?ajUwN0Q5VGp1ZlFzTzF3eWI4TE83TStYRDVVZW5FN0E2MXRvUE53UnY5YU9o?=
 =?utf-8?B?Q2lMazE3NlkwZkYxKzQwM0VBaHZyaTVZWTBKbHRPZkZXZy9pNkR2UFpqcWNG?=
 =?utf-8?B?U0s1VVNuWmhiUTRDQmM2VDRRZ0JqUGxSb2lSaXZsN25yWFRDYlJBVmptZC94?=
 =?utf-8?B?RGFOSUpHTUQ2NXVoYVVuNy91MW4wblc1c3RVNmFWRVo1SVo2QTAzUFdOakIy?=
 =?utf-8?B?TUpVemRxSkR0RnVSd1NLR0NRSFd6Mks4bFBKNVlTY0NFR0J0TmxsYTlJOFR4?=
 =?utf-8?B?S3RqKzFFZFR4bC9hMUJFS2JGeE85WlNoVVU3Y1kyWWsxbVB2R1N0LzMwNlh3?=
 =?utf-8?B?bTZESW5nRkd0aVpUUEpqWWszb3ZmMVdTN1QyQU01a1hDZkI1a0xnUU9jaVpn?=
 =?utf-8?B?S0V5bFZkWEtqamlJem44OEJTcnJhVlJEQVExNXhER3Q3QkEwVnozR0JOclh6?=
 =?utf-8?B?c0ZiZzZFMzlzM2xvTGUrSnNMZ1JlWHdiWFNFa0JDZk9HYmp6VVhqcFVuVjJk?=
 =?utf-8?B?VWdnY2o4RVdiRVFnTS9VNVFrVTFhMXZIdFFIZllDUHg0QWxpRTBIdGVNd1ZW?=
 =?utf-8?B?VUg1ejlTY2ZrU3JvYy8yNGhzdXJvSFB4NlNxaitySlRSNk1DaUtzUFBEaFE3?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8GEyjgnOVFEjGQbD8N/IO9sarY2YPNHTVu80IsMiHUIhasXh2RD7qM7Kl4QsHFgy2U8QF8hu2I0pAZU9tKbBHV2kaDVZEQc7L9Lrx1w6BMez/gFFbou+KUH3as/PJMzSHzr+OkSTYTmwgg0sBJ6fg4+amG/Q+0yON2ZQFXWEYxJoNVRxhYwDJhA8KKNK3UNtl9z0KwINztpGqvk7i7BEkwl4y9wwgGAOFsR1d0PDuJGUlN4cc2PmZBwvMLhRwae2WsY43iLiWlNN1gVyOCgxhVKAd73wdef2xdIWhGcDZW02vAzjloFUeYEPBve849XS9vWN+Z8T2yjw7WPQOMAzOBXRZux7W2PXRFa4BJVo0s/yiOapuxPSASqYc+M1wZ6HoCCPjKTNcKTCnhajkViThbbGTDFjA28i27zlKclAs0lByu9p412KyCTk34y9Ged3Xa2g4z9KWzJZjAmyVU0PzEYfLEVyEBgsouYfWteJ4MY1eUmUOfeYk+gASXU4btHnJs6o3dHSPc23mK58jTii3XxnIKm1onxM+nccS2jHbwAwTrHcRvPt+C7/2OKXmzXvEQrp7yWrZiFkcEokjMWH3TVAmx+BGgWAzJyvbf6NQco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a38ebf7-4b54-4489-7605-08dd66e1550f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:26:53.9819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVjnJVWT4XrLCYUq2Ac1KcefGiAL6j3MyM8YS/tPneupEbKSN/foCH1/zkdE5TIR0cupifhb7L/zsCtnmMBwXhLtpoNhufee1egkm7Sb+X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190085
X-Proofpoint-GUID: F3xVicsNjkCk9ayFkI3VQrq2JCK62_44
X-Proofpoint-ORIG-GUID: F3xVicsNjkCk9ayFkI3VQrq2JCK62_44
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 18/03/2025 09:53, Cédric Le Goater wrote:
> This routine is only used in file "migration.c". Move it there.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  include/hw/vfio/vfio-common.h | 1 -
>  hw/vfio/common.c              | 6 ------
>  hw/vfio/migration.c           | 5 +++++
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 5f082e5a321d97e90066d48cd3c1eaad56912ccb..0aae88131cffda1a90b8ccd0224387133c0fa83a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -290,7 +290,6 @@ extern VFIODeviceList vfio_device_list;
>  extern const MemoryListener vfio_memory_listener;
>  extern int vfio_kvm_device_fd;
>  
> -bool vfio_viommu_preset(VFIODevice *vbasedev);
>  bool vfio_device_state_is_running(VFIODevice *vbasedev);
>  bool vfio_device_state_is_precopy(VFIODevice *vbasedev);
>  
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ace7a4403bd49f35cf85009015b3ba315f80cd30..0b9b071cd0490867bb6aa4ceb261350ccd6e1125 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -65,12 +65,6 @@ int vfio_kvm_device_fd = -1;
>   * Device state interfaces
>   */
>  
> -
> -bool vfio_viommu_preset(VFIODevice *vbasedev)
> -{
> -    return vbasedev->bcontainer->space->as != &address_space_memory;
> -}
> -
>  static void vfio_set_migration_error(int ret)
>  {
>      if (migration_is_running()) {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 951e073a20287c46ca199b1648782b59415d0d2a..a1ba993ce549fce0d2a9a60ba07d4782c87c0c09 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1141,6 +1141,11 @@ bool vfio_mig_active(void)
>      return true;
>  }
>  
> +static bool vfio_viommu_preset(VFIODevice *vbasedev)
> +{
> +    return vbasedev->bcontainer->space->as != &address_space_memory;
> +}
> +
>  /*
>   * Return true when either migration initialized or blocker registered.
>   * Currently only return false when adding blocker fails which will


