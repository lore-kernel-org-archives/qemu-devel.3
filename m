Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F5D3B98A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 19:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT309-0003cu-1M; Tue, 09 Dec 2025 14:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1vT306-0003cR-LT
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:03:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1vT303-0004fj-NH
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 14:03:54 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B9IgIWG1590518; Tue, 9 Dec 2025 19:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=otbYhtOYnv0zm0uDWr
 lgF1VSdmptcwAVT6xyt5OPteY=; b=WsVdnSLV7UBoaCAPuFC+DahBvnhiSf6TKm
 kY7cHgmirTkvbSvhsuaSWGSRos7x0BhmZrJLyeNrP/bD62vBEkhYn3ZGbwR+gBfq
 IOL5eTln6mH0qiP2O+U0mYNg1dqh1kHwQWoAB2dA8B7R5S0Kzh3bY8x6Ms5HDkFg
 y1MNGJONennUDlQH9RG5kl6UDw5byAS1JxW0i8fMaBaziISFPhC82+1feDjrUaJF
 NGax1I0EUF2re3c/I6YdrQQ2uYLih1a2SJmMieo5yunKbAhWLUyvQ+1FZ2OJiauz
 k9GFQtA80hxtOdH6WRUD8wVCxZ+zb9TENcBN8mGRVB60pcvlJ1gw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4axqy2r6v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Dec 2025 19:03:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5B9InqQX039963; Tue, 9 Dec 2025 19:03:34 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4avaxk8kb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Dec 2025 19:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2I/0hbk2Uet38cF4TmKIS/ecG038rnZAK97vHj+NlFSsCySOlBZH2WXsAz/iPf/O3bML4mQv8uhTCayZWR18mFE1QfgKyNBKrpxKyWdniGeYtkgJHoEhiv4rvvCwpGTpUsPhmKFCuevlfS/vHZk4hufxjJCpEql+stb5MWq2YK1k3IHhdYRSQK7BtXFd3Q6/QKhV5V+GMeVMBZKGrnS1KAP42/GbLtyEwXxFZn7mVZ3TQ7r/EYWkMJzaeLy08KKPpJkUmj/HO0KRWT44rQbT/YHTbMNDt/kMFV0t+UQAzkAZ5Guy3eCzQiESZ2iPEfHIRpdjK/57iDLw9D2BoYjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otbYhtOYnv0zm0uDWrlgF1VSdmptcwAVT6xyt5OPteY=;
 b=DIJkoH/Xje9bBXt6k+nK1vQ8uuMuU7bkeu1nk0Bf4Wq5TAcNm5Ypdga69oMLJzLB/1+uz1ZEeMAqaquPIVjFAqnDCfTODF5yV21ZqNX/FV5mGTJCQ3ZhC5CjwAT8iEm4rWfy47Dlm5B68bwMdFShaZL9WlNqg4plT1vhClHpSiRNx6gwehkE/QI9ldngY/cIrg+HKUyZGfeGOohJtlSMO1hrKS8I/+uJYE59sPFEwED30/ZqaEXUMwPVTDQlBdFZW1JoB9OzJ70FXpFLynDTFJb2nLh8zXnBtWd2x1FQqxExTtSiCGtTleEd9n/X0jwXAx8kab7vUnlRUkZrpuDn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otbYhtOYnv0zm0uDWrlgF1VSdmptcwAVT6xyt5OPteY=;
 b=wE98xRIiWjxA6MgWHAkcFQxQo6AHy/czd43qoyaCXCqxEW8pphW9oKxJ4+fEHph5qdDRABE0FcqkD9grXsPTqgwZtFFdZSRhGEhIWnpcZEEAXqblwHEqyXeNCqMSnThGqmQcSKMruaC4EgoMiDQpR8podKtbBAzMVde5x9DK+rQ=
Received: from BLAPR10MB5170.namprd10.prod.outlook.com (2603:10b6:208:321::18)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 19:03:02 +0000
Received: from BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191]) by BLAPR10MB5170.namprd10.prod.outlook.com
 ([fe80::f215:a25c:4fce:d191%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 19:03:00 +0000
Content-Type: multipart/alternative;
 boundary="------------IdjdpBwAqGTTgFIgw5MnZThH"
Message-ID: <b6caf9a7-f0b4-41ef-8841-d8aca5c97607@oracle.com>
Date: Tue, 9 Dec 2025 13:02:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update reviewers for CPR
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org, clg@redhat.com
References: <20251209183412.3903519-1-bchaney@akamai.com>
Content-Language: en-US
From: Mark Kanda <mark.kanda@oracle.com>
In-Reply-To: <20251209183412.3903519-1-bchaney@akamai.com>
X-ClientProxiedBy: DM6PR02CA0129.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::31) To BLAPR10MB5170.namprd10.prod.outlook.com
 (2603:10b6:208:321::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5170:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: f21bb688-7a84-41c9-eb6e-08de375592bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|13003099007|7053199007|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTcwNGVKQ2ZrWTZ3WFpSdDNaQmIvd1pIcWF6VkYxZ1BrdVIvZFVJYmtCRnNU?=
 =?utf-8?B?UG1yT1dZUHphRU5sZERWWHpDV21NR0Vqa3lVTFdyRkhkdE5NSFd2VjRGWG10?=
 =?utf-8?B?WG91QUdURmJ3empWeWprMkNBemVPSHAvR1Q1VStMZ1ZqdGQrcFFXYytKUDVJ?=
 =?utf-8?B?MktJWVg5VW95eWVlZjJYUXdQenhuZkxZNGd2NGMrRG5YcEVFSGVpa1IvRm50?=
 =?utf-8?B?Vlp0VEluMnBLSndwRkJINkp4SmxOQUdGSmdGRlN0MFExbnhYWW1tODJUbG9Z?=
 =?utf-8?B?MDM5NFRnenhQUTVJeUFwVGVUOWlwMlV2ZHBEVGlKemZnVUppL3VCUFlhamJK?=
 =?utf-8?B?bmp4WmJjRzFKSWJwR1Jwa3FvVUk1N1RDdHowbXVCUkVFZGxOU1lOZVZSdjU2?=
 =?utf-8?B?MHJrMnF5TXZuRGdWa1FTamp1VjFid05raTl0OGtBdlBIcGlBUEM3di9XZzBF?=
 =?utf-8?B?Z2ZBZlRtbThmdjA4aDFlQk5Jb3JSTkQxektyeUpmL2N6STBuL0JrSHk4bG9m?=
 =?utf-8?B?OUY0TVlpNHY1NnRXaTB5S3YyVUg1dGdkbjJiR0p2N2RTTnZaK3NFNmJCdTVK?=
 =?utf-8?B?NTdqdkR3YkU2ZWxEQVhOWFpRbkZGazlVOFVYSjY5SmJtbFU4dmhqbXlSRzVX?=
 =?utf-8?B?dnlWYTUvMThLZm9RcjFic0VWbjExaGVuWE5WSjl0WVg1eFo5cXpJRXhycEcr?=
 =?utf-8?B?U0xlejV1cDFrbXd0dDk5dW94cmNOR2tqQkZJWG5VS3Y3aTB0SHJxQnpZaUZN?=
 =?utf-8?B?OVovQkFRc2ZGaGpINGhpL2Q4cHJBaTluZE01a05QUDdaLzNwNkw4TlVRMG9W?=
 =?utf-8?B?SUR5b2NhNzdpb0RiNTE1OGYxNlc1N0ExRXlwN2hGcDVKYW9ZRU9DZjlZNlAy?=
 =?utf-8?B?NkUwWGx2SFV2dXo2MjZ3R3EzTWNqQXpQVUJaTlZoUDN4VFFrUjZnMFJzZERL?=
 =?utf-8?B?enJwWjQ5bXdXK0EzZmNISHd0RlJwTUxlMEJUalpxUWQ4ZUFtWDdYSGs0N3Vi?=
 =?utf-8?B?a0k0Sys0ek1yOTZCcUwxbmdUaUZsWmV4Q3RqVjBjREFxK2hGczN3T2RrZDU1?=
 =?utf-8?B?a0pHVVhoRkk5TXB5bGVVR2R4MWV2Um1STUpaWldQbHVobEdTK2RoMG9pYW96?=
 =?utf-8?B?TkVZVXBOZjR2ci80NnlzSEQzWHVuZzhKdm9HVnF2Y1V5ZUs2K0pUUkNRQWVN?=
 =?utf-8?B?aUsvbGsrbnp6VlBZZ095eFhQNXNOMGFZV21PT052Q1M2NkdvNjRDRm9EWXBm?=
 =?utf-8?B?MlpHUnJUYXJlaEhJN2pwK0xuWVNWNHEzbjFIZU1mck14akt6WHVWbmlSZldo?=
 =?utf-8?B?OHFBVElQLy9SV29UUFE1dEUyMk8xd1ZVUkhRZ3luYklPSTRYVHNnSkJVR2pl?=
 =?utf-8?B?WitvN3J4QVFDMzlUK2ZwK0c0MmxrSFdtbXhtVUd0OWtxV2gxRkZxK3ZiR2lm?=
 =?utf-8?B?cVlPZUpqR0hIOFJCVjAySGgzb3RxRWE5YndkMjh1eDhlTXArbnNHemRrU2F5?=
 =?utf-8?B?OVdWaWU1TUhiOWtDT0J3b1VFdG9kNVhoaVNXeXlTcUhiTThtSXBhb2ZpajdD?=
 =?utf-8?B?c0RTOGxwTTI0dDlwOU9XYTcyVzZZQlhPOElDSktZa0Y3ekl4SS9LRDQwRnA3?=
 =?utf-8?B?am42SEJpQllYZEpxTy9NZklOMGZMUzRkSHp5ODNIMGlUMHhrTEV5VGxscVU1?=
 =?utf-8?B?V2w5bXMrK3kwVlh5d1BGRDlrUnBCYTFiNjFCSHQzZUVVRmdiWGsxVFM5c21O?=
 =?utf-8?B?cnZnVC9WdE8zN1Y4UzZsWGxScndwSW9ZWEFXVHJtMmlNVFJvWkJUM1hQNzN5?=
 =?utf-8?B?TWNTK0NWQkxoV0ZyeHVaUTJ6eVdnUWNpcFZTVnBzV2pKUzBnSXJiOFphUUdT?=
 =?utf-8?B?dHoraWh6ZmxSR1ZrajJnSVRBUFRUa09lcTc4RHNLM2hXWmlwMXVTaW45SUZ4?=
 =?utf-8?B?R08zN3Z5Z0tkY1BsMnZVS1N4dzBYWER6SEZ2VGkwVnFHOCtqVDZKTElqczl3?=
 =?utf-8?B?RU4wbG0wMklnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5170.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(13003099007)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVBWL2RvUnNVTmtEdTFLK1A4TzVXVGhFQ2RYalQ2ZVRURVRRM29VcTVoTHNh?=
 =?utf-8?B?ejE2azYxYUcxMGNSME9xcmk1MUE2QjRMWU9JbWliVk1QN2FHbVc4bUxXdDNJ?=
 =?utf-8?B?aVdOanpWaWVBQlYwZGlncFVObVdNUlBmWUpJMVU3SFR6VzM2NjlqZGZnSlE0?=
 =?utf-8?B?bE1HRnFsV1VwQ0g4Z3FzMWp2citrQlI0c1RWeUV0NVJEbTFLbXZ6WkMxbk5J?=
 =?utf-8?B?KzltYmdmRTh2MGZBenBLdG8yRkVXbjZRVGNscTErSTkrbGVzaWUvYXdKb1dm?=
 =?utf-8?B?VFdWSk01V2Y1VTRWZFplV0dqV1lkZmdVYTZFZG9ENS8xdG04WkpNd1drdUJV?=
 =?utf-8?B?b1Biemp4akJqR0xxM1luR21yWi9VYkI0OEt6VlgvdCtzdWhUOE1pbUNqbTdr?=
 =?utf-8?B?UFNuTXZTbkZqZ3J3azJLenhpbW0yRHRkSkJVSWxzaXYzUzlGVWtFOW5NY0lr?=
 =?utf-8?B?clJZR2JOaUpzY0kyU1pOYUFRZXVsNWI4YitDZ040TWI4aExPeFF3QWZyaEJY?=
 =?utf-8?B?T3czMkdYN29mRHlvclE4TDh6bHBGUEVLUmFoamlvS29MNkVrYWpIVWNWMS9Z?=
 =?utf-8?B?Uit4WldmdHpPUzdrWDN1R0tHWHZ2eVlrZml1UUdWazB0RWRVbm9aRWtheXp6?=
 =?utf-8?B?ZGIwNVByQ0dRbG5hL1hwS1RmdFQrakdWOUxOMjl4RFpBQzVUU0JtZzRYWDRH?=
 =?utf-8?B?STZybjhreHlZZnNXRHN2c1ZjNXVEa3NrRE5CMkd2Z0RlRGxLeDdQNzRkZHQw?=
 =?utf-8?B?WXhlUjE4SHI3Zy9QTGUyTkxpdGxNZVJoRGErMEJacUZtRXR4VDNaOHFBenp4?=
 =?utf-8?B?NitteTRmNkhoYm9pcGJSV0dWY2RyTk11cjk2VE44c1RkTTk4dnF4V1g2enoz?=
 =?utf-8?B?eUhoYTh2STB5bFhWVC9WS3JwczVXb3pYaFVOcm4zaXdtZkNCdVBiOXVDVE9l?=
 =?utf-8?B?ZjFXcGtZQW1lNklWWFpNek5TSFpxU0Jtc3diQWh4T21jbmhEaGVSbU1aKzFH?=
 =?utf-8?B?SjA1OEtwRHAwc1hDcmlUb005TG5lUUpwZW14dFp2eTZyblAxZFBxMlVMWEVq?=
 =?utf-8?B?b0x3WGl1QlQ1L2JqSW9CUDZsbmhZRGd1OStEUFQySWExL0hicGRpTTNlZEJv?=
 =?utf-8?B?ZnBTTnRBekNyOGFqQ2I3MWUyamt5LzlnMDV5cEk3aUhXUFkvQVNTYmhUZFIz?=
 =?utf-8?B?dDdienhQeWFXSktYWTR6ekI1OGhIMWpINkdTQ2NjSXk3VCtVa0djc0o5UVVT?=
 =?utf-8?B?cjM5SG5BdktKU0RFWTdQb0Fpb0RPbk5YMTdXcXlpU043dnBUdUdiVExGTElF?=
 =?utf-8?B?ZnVpZGpLR3FXc3FBOVlXRXV5QmJKVEdJalcrbUpSVWY3T2ZYRjBhWVUzc2J6?=
 =?utf-8?B?VHBQTnJvYzVWRFZMalJ3dEhQTUdiU282NVF0WTlkZUpnbzZNSjRDSWxTVm5s?=
 =?utf-8?B?VkU1OXFtc2g2S1RSb1hjSGQ3eGZSR1pvYW5scE5zMkZNYkJtTXl6eWVXWmtq?=
 =?utf-8?B?REY3UU5QMyt3emFYN2gwbjUvOVFrcmNlUkpFNHhVVTlWRVR5dGFuRjBDRVNG?=
 =?utf-8?B?TXBSWmZhSDlTODl1dWd4TWgxMzVDaG5QeHRRcVZxZ1BiREhnU05JRk0xOFEy?=
 =?utf-8?B?aGRGWE5MMVZLOTVPZjhpaXI5aWF5YkRzVW9aR2NSemtKem91SWFHcE40ZGRB?=
 =?utf-8?B?a2ZVYXN2dzF3NXJiYWtsTU03Sm8yTC9DbXRVSTZIVWJiSUZnZm1OSUlQU1ht?=
 =?utf-8?B?WFdLZ0dZR3Y1RlNOeXRHSlB6VXMyaE90K1B5dEtRSUZRYUJzZk9PVjJzNFEr?=
 =?utf-8?B?Uk1mbWhHMnhub3JaUXgrVGxXK045dCs5MFRQUkxVTUE0RmNhR0xSY3ZUNzRM?=
 =?utf-8?B?Zkk2SUFlMjJ6Y01waWtJS2dhZUo4NTFON1NETzVwMGtlQUFVUFA4NWpjOE94?=
 =?utf-8?B?YXdHREZGamNwWjNpendLMWN4TWsyUEJnWjZ5L3J6ZllxNm1rVzVpbmNWY2Vk?=
 =?utf-8?B?U21kMVpZQkFDZk02aGM0eGpzdy9rTURybGlONmt1MGlHWFh4Z2dEWU5kUnY2?=
 =?utf-8?B?ZkdaNXNnVWJvMi8xcUxwZ0pXRVduMzliZHhOTnhvdkVaUDRrT3hoc2Y1VWdC?=
 =?utf-8?B?T2hEcE1OYkZxOGxmTXlQamJ5WWpqUTNtaVp5VEhmUGpCTVh5REJqek9BMThI?=
 =?utf-8?B?clU3MlBVUklacGF6bFFVdkx3UWIwVEMvNlhVUXQ0MnpTa2lrWHZvZ2lkbTV6?=
 =?utf-8?B?SDY2eTR3T0FzNzNEUEtNcXpvc1N3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xer0BeFlFKB6qDK7IzXBO4FyLRbVId0XXFS2qXzpeDrSyn60JNUnvlA/3bwtL+ZmZ/a+rtvnLAvl/htFI2a54GAy5sbeArR73BrxHRWdX00lOylTjihdqElroowgb5p/CdPE5fR6oi4Lmu6oXIW/iIoJKPY6/p9+4ANLFNR5uDHYgTifw1mC13vAINF21efW/NZ+2HOG0aydUCKG33MdNQXlCuJUMjstAuwxJmNoJBrPbGL6Elbbs9ka3qgkOOFPZE7cxkB6EeOcJpED8UQoSc3qtlsZj/0ThgzU11+bKJXjL49XYL+delXmpdUWh/wUdEd7vY8aXpDAPHsfs9CVBJjMmJNUGkM5uJGnCBIeCUJ+JEQDQ2Q+p3v1KOb+RU19Pqrq91+33yfPsPO1Sb0EGxA7/kzDts486ro+28uxPGzfb4Geb/x6ytMZi1oRl6TCkjytZ/BH+fa3cuAN+xMwy9GBIU6WqbfV3XPcMIYiYZ/J4yIi39T2JdLW96iYejQjtA1CwIF6wP+M1eb+c9YYdhEJ1cDHqFG581xcKJvSDm4fOdTrABDv1YK3Jt93uAOTA6MUzf/ftdPfYKk0L/hzhATE1VuOi0/m9I5EAEOIdG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21bb688-7a84-41c9-eb6e-08de375592bb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5170.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 19:03:00.8226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCZpnUiEBzDs976bywY+s+mx0TfBgvftJ7dj4HFTx/vtym6ptxHG1HBxHxrpnP2iKYlSbh3Qwxgg5fKWhOtpBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512090145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDE0NSBTYWx0ZWRfX8ApdOb5r1UxV
 aLA3+6P2yOS5Gg7prRUZX8l+uRAxsSJAufo2l0Mn9V/x1Fwtgn+wraLJfZueck0fkBED/nKI6TF
 ZY/5/1caiAQBCu9gQy8lDIWB5YQYhxVdw2/x6oXmaW+L4Se4oNkgjWkL8QcicXvnK364SP7xsfO
 PAUyjol7SHLm3t9vIFEeKETwk3v466zTPLBQox5P2DmG8ziDr28Lk/D8duMWYU2Vr4H3Qcu1Wpj
 oYFFjaMG1+lb/Au5i4A5cZnRQ1nnxKcu32SPbGT8QJtBlDJMTfaObaYkCoZpuxd61JdLska70wu
 g2zS2deEqzfEtU4BGEGDdo19LSxdL9PGvYnDyQQsDwApQFGMlqozkse0Lk55UeHr//sQc4NRjDx
 U/fwxmxL00CxnnrnQQifFEsnU7oLuw+kfc5SYDggojVnVMy3fLM=
X-Proofpoint-GUID: UP5FydZKzP4VuPIaY0lB96U-aXrQkfp9
X-Proofpoint-ORIG-GUID: UP5FydZKzP4VuPIaY0lB96U-aXrQkfp9
X-Authority-Analysis: v=2.4 cv=HqN72kTS c=1 sm=1 tr=0 ts=69387287 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=p0WdMEafAAAA:8 a=X7Ea-ya5AAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=fV1FAWy0HGoMm5ULgAAA:9 a=QEXdDO2ut3YA:10
 a=4VVcHpUFlTeZ-k0x__MA:9 a=gDwHcxbvNw3NJgrN:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 cc=ntf awl=host:12099
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--------------IdjdpBwAqGTTgFIgw5MnZThH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/25 12:34 PM, Ben Chaney wrote:
> Signed-off-by: Ben Chaney<bchaney@akamai.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 63e9ba521b..812c86fab3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3116,8 +3116,8 @@ T: githttps://gitlab.com/jsnow/qemu.git jobs
>   T: githttps://gitlab.com/vsementsov/qemu.git block
>   
>   CheckPoint and Restart (CPR)
> -R: Peter Xu<peterx@redhat.com>
> -R: Fabiano Rosas<farosas@suse.de>

IMO, Peter and Fabiano should continue to be Reviewers.

Thanks/regards,
-Mark

> +R: Mark Kanda<mark.kanda@oracle.com>
> +R: Ben Chaney<bchaney@akamai.com>
>   S: Supported
>   F: hw/vfio/cpr*
>   F: include/hw/vfio/vfio-cpr.h

--------------IdjdpBwAqGTTgFIgw5MnZThH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#f9fcff">
    <div class="moz-cite-prefix">On 12/9/25 12:34 PM, Ben Chaney wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251209183412.3903519-1-bchaney@akamai.com">
      <pre wrap="" class="moz-quote-pre">Signed-off-by: Ben Chaney <a class="moz-txt-link-rfc2396E" href="mailto:bchaney@akamai.com">&lt;bchaney@akamai.com&gt;</a>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521b..812c86fab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3116,8 +3116,8 @@ T: git <a class="moz-txt-link-freetext" href="https://gitlab.com/jsnow/qemu.git">https://gitlab.com/jsnow/qemu.git</a> jobs
 T: git <a class="moz-txt-link-freetext" href="https://gitlab.com/vsementsov/qemu.git">https://gitlab.com/vsementsov/qemu.git</a> block
 
 CheckPoint and Restart (CPR)
-R: Peter Xu <a class="moz-txt-link-rfc2396E" href="mailto:peterx@redhat.com">&lt;peterx@redhat.com&gt;</a>
-R: Fabiano Rosas <a class="moz-txt-link-rfc2396E" href="mailto:farosas@suse.de">&lt;farosas@suse.de&gt;</a></pre>
    </blockquote>
    <br>
    IMO, Peter and Fabiano should continue to be Reviewers.<br>
    <br>
    Thanks/regards,<br>
    -Mark<br>
    <br>
    <blockquote type="cite" cite="mid:20251209183412.3903519-1-bchaney@akamai.com">
      <pre wrap="" class="moz-quote-pre">
+R: Mark Kanda <a class="moz-txt-link-rfc2396E" href="mailto:mark.kanda@oracle.com">&lt;mark.kanda@oracle.com&gt;</a>
+R: Ben Chaney <a class="moz-txt-link-rfc2396E" href="mailto:bchaney@akamai.com">&lt;bchaney@akamai.com&gt;</a>
 S: Supported
 F: hw/vfio/cpr*
 F: include/hw/vfio/vfio-cpr.h
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------IdjdpBwAqGTTgFIgw5MnZThH--

