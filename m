Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86636C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taG86-0007H2-L7; Tue, 21 Jan 2025 10:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taG7m-00077C-Ub
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:25:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taG7g-0004qa-DB
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:25:04 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDw9S000558;
 Tue, 21 Jan 2025 15:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=sk9fDSFJxdzPDYv9pkcUhykin+QBoIAt7gYnXz6h0Vw=; b=
 dSEBYrUhqjDBVuJ+x7SWXhS5TgcH7789iEa4jbWMsqkmMF58CSrPt/33DWMSYXqZ
 XP0SO/8OC5vTbdIhCQ1dQBalTPJdthCjG0bUNwxIRY+DvzqQ/k1wF1z5WfVaxQjT
 R4xDtVwm2KvbPij+AWwvkkV6kg9w99Lisv2aXKASQvi3gI9mGD6wl/zKG2Gfokw+
 7jaSzjqOlHddlTfgU7SFN9ARvQwolvLuMwMcGFus5CK82Sl8lP17Z7K6mI6k81MI
 KViQO2C6HGK795+K4mRjSVpmG21dE5ljFmqICsg94gHlQptQkK0bNiocHiS4+9Xq
 WoSehv53WFUmjd/Lpz6DLQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nsdhry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 15:24:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LEUsq8038157; Tue, 21 Jan 2025 15:24:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4491a04d3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 15:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+TSdkECIBXE8MMhp6B+j7wx+daQhBGXvc5CeyJTHiQog6U4FdimwO9F8oS4t29aEFe7QT3/DkEI2udENW/Aeo2XmQsD/I6mVLNfCF2qKfcpCqW+P2e739Mk+LCM4mUmoBjZt3L6aYJsg1IO1/syblPj1FZ5VdCOSiQS0OtcFc0KcWnKG4UH65rKKDHUoALlloll1MhcK2n8stzfIDPvOGIgaWBn5Cd0NmIoPjMz8xQ1XqKuvQG98sMHJpyAvfpSCYcHaL9FHkQmNKpsf1yM/vw+O9dDEKY019G9kQocCo2alcQu3kHGIOud/FuR28qbrMn1ggc+dDv3u1tPa8swjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk9fDSFJxdzPDYv9pkcUhykin+QBoIAt7gYnXz6h0Vw=;
 b=u7zkniOssNIRfAJgeg5VCx+EyGijvVOpLT6gW/p3Zha3XZ4KvdmAC5iqsHMsLD5v6VWkb/B3h/dMjd2Tj9j1MH3wvnNeydCco9i8sE5sjcfK0Vk8jGj0PFYq6mm5j6XcmBDQu1MQWI1gVuHhHFFA4JAHl7GMuC5wN0kILo6lLWqBbrAlbmfeAzsiq7eW5Jh4fHuE2r7SMVqT+OdkHBw/eTmV66EuQ9/JiLRtFfQ8K0oFK3f7RnAVDEV66SrbQLXjMVZ/MNOW6BcTyF2hFWNSKvRlmDoYsv01Z/jzGj+CyXDwoxTxJ12eUlwr1fVuQdYzT2rrcdgbkZiXrecfYSFPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk9fDSFJxdzPDYv9pkcUhykin+QBoIAt7gYnXz6h0Vw=;
 b=FRhEKnzSq18ZdjqmL00LrZJMCCjncMmrs1kO5OS6JsuY0hdzbCmWfYLl8vPLfKI1CBTvSUiRy/OumxAJk9fVQC/x+NYm3c/x09pKVvfB6ZV+I9TupCXMbbZxurNfz6IltC9ZJHt5NT6xiur9XLdqsYMs+5c6C/wyk5xezVz6N5I=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by MN2PR10MB4205.namprd10.prod.outlook.com (2603:10b6:208:1d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 15:24:49 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:24:49 +0000
Message-ID: <206d8dad-61a9-47af-a72c-92a7df2367e9@oracle.com>
Date: Tue, 21 Jan 2025 10:24:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 3/5] vhost-vdpa: Implement the GPA->IOVA tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-4-jonah.palmer@oracle.com>
 <CAJaqyWdv+Vh5SVGzqy08J8d0VEHYbYX8CK9YuNGZVpE85fOKKg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWdv+Vh5SVGzqy08J8d0VEHYbYX8CK9YuNGZVpE85fOKKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:408:143::19) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|MN2PR10MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c469c0-8e77-4a7f-c54e-08dd3a2fbe9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW1Fc3ZkaC85U1hyOGZuQ1ZYbXRIYzZMeVA0YzVLTWJyVjMxc0g2cnNpNUZM?=
 =?utf-8?B?cWx1NnRWWFczZk54NGUxVDhiVWF3UWE0TmV2OVNudVBpNEJuRGQ5NE9TVFJ3?=
 =?utf-8?B?ZGJyKy9sNnZiM29MelVCMGZRYkZUc2F3eUVnMUhubU9qK3F4WDNuUmVVaVc2?=
 =?utf-8?B?YW1xS2RXMWU3Rm1YV0ZEakcrZ3YrNFNJVzFVbXMxTXo0SUVUTjkydzRyTlps?=
 =?utf-8?B?cmJIN3hHTEwxUjFXSlBzYVB1ZFdPSlh0UlBpUU0wemt2d2N2SVVtb2RFekdI?=
 =?utf-8?B?L1gvNG1WcnlVSWFGSHdTUHlJSzltcG1SRTF5Vml6S2pzZ2kzZkY1Q1F0RG94?=
 =?utf-8?B?NUZHOWU0VXR4anRnR2kra2NsQVJQTWNpb0NiQTNGM3c4N3dHVlhGbkRnV2JZ?=
 =?utf-8?B?MDBsczBZMjVhaldyd210dXp2N2tZL2x3VUtScy9OMlBRSDBxRmVMUTBGVGtS?=
 =?utf-8?B?VXhmYU1kSXVaUkI5TUNaNGw4THU5WHhTa2ZUcUgxaXRVcUs0MUFSeXFjQXRp?=
 =?utf-8?B?UHNrMEs4Y3VIVWF4aGNUUy8wckYxRTJKSUR5V2M4V3lSMWZvVjN2N3NOWVFu?=
 =?utf-8?B?Zi82VmRqMFpnTGFNWTBHUHNGZiszM1NVSENLVm41NmY3MkdFbURpM1RGclZx?=
 =?utf-8?B?RUlYKy8wM3FUWHV0eGNicm1kT3dKemJxOENMV0JsWWZjT216UmVCdEV0TnA3?=
 =?utf-8?B?Ly8zMTRuUVdhbzJVdVdHNVlJY1ZaWE5CNUc0SXdZY3IwekxvSmhmbmhMQzVn?=
 =?utf-8?B?TFdqUWg0cG8vVmJGdWNONTNPdkZ3N0E1eldIYTFXaGNuOWUyNHNBQU5nOVk0?=
 =?utf-8?B?d2JacG5wY1JoNEgrVlJIeG9MN0trR244NlE4ZnRsSklKS1EyNzdpZ2doNnR4?=
 =?utf-8?B?aUVMWDdPcXRWbjE2SVRzSUg1QnMyMmZXckdWYXFsM0s1TkxYUUUzT00remEw?=
 =?utf-8?B?eG00cTl6cjJsWXBOVCt5RllWcFVhU3VNSXcxZHNXM3J3N0RxVDh2ZjdkemVt?=
 =?utf-8?B?eUp0QWlzM3c2cytnMTJoQWpEZXU5YStuRmdVZVZxUWF2MnZ4Q1dWZjRUU0po?=
 =?utf-8?B?NllQdlA0RVFTRkRZOUhUcUZSZ2tmMHdsNXc4SS9HTUdBT1VKbUhpU0J3TEFw?=
 =?utf-8?B?TUtLNTFYYkNtMGo1UXJkcUFtTFZld3gwMU04OFA0N29WbzJ3NFdnSWVQZ2Uy?=
 =?utf-8?B?WHRVakZDUXFZWFpIam9NeGlwZ2RpSGhOb3RTVFc2SGZ4UEdzRzFBYWYzMXpS?=
 =?utf-8?B?TnhlcmZmQmJPTXFmcml4cUFNTVFSVFpUWUNVSW5PQmkwOEdXeTJjZEcwUEx2?=
 =?utf-8?B?c01JcTM2REdaTmh3MEVhWFUwQ3A1a08zamlxQzFKLzhvbi9SMEFNREpZNERL?=
 =?utf-8?B?eDZoWWtGQ2R0emx4VEgyVldpeWR5MEU3SjlNQTVEN0VaSWlmMlhwV1dNNkQ3?=
 =?utf-8?B?c3pJTlkyNWhFcThUaURQK211WXM2ZCtMUm1SUTNNRkhFd080QnlYdWs5Z2xm?=
 =?utf-8?B?Yko1UzBNaHBFbjV0NlR0SjFkaFlpalY3VXFDSlc3NzNZYUFhR1ZxeXo0M3Vi?=
 =?utf-8?B?ZVB1Y29aMVo5c0htYjFFRERTYXVSSGpkM2pGR25PeEpLYjhLM3JHMkxHWTFk?=
 =?utf-8?B?d0JDNW5TbkVPci8zZE5vaGRsQi9NWG1uS1FmYVB1R0pXMmkwTE03a0o0THo5?=
 =?utf-8?B?QjJJa3ZESzBDeTVzUGZYYjhMbitEaEV2S2NyL3hXMTd1RlJxK2NwWDJMamlM?=
 =?utf-8?B?WGxiUFFwN3JxOENXMDd1bVNaZEFJVExSY2ZrVzBzTm1wcmpBRXc0ZytXYnpq?=
 =?utf-8?B?a3ZHOFNKVzVlSllrVVUxc1B2cFlPeEJUS0dHbFNNV1hjV2hkZEYzMTlwUDcr?=
 =?utf-8?Q?9T2A2iFs+zeeX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZHWVRpcE9BVXE2RlovNUZyZlBBQlVIQ0lwSncxTGhKNUdNQVdkclI5U05U?=
 =?utf-8?B?LzZVekZSM3c1WnUvbTQ0cG9iWURPMzI5NFpOV2RDZlYwZTlqZHNqNGY4MDJm?=
 =?utf-8?B?UjV5dklrNnF5SjVnWVVCY1BNU29xRk1XYllpVEdVV2Jpc3NnYTlMZVh2cnF5?=
 =?utf-8?B?UTRrM0tiREhMZnRHZC9mcWQ1WlhOOWNnUm5FNURMdk5qVHZYeFc1WXZJUUMx?=
 =?utf-8?B?SmhsWi9VUkoweFduaW1hMitmWGpOWm9wMDZOTnF3VmNIWnd2S09HRzU0RUoz?=
 =?utf-8?B?WmpieFhGRE15ekVBOVhhUTJVZE1LMDJ3b2svS1R1NEtyYk9ZdFFudTdncWhH?=
 =?utf-8?B?UGJia2FVajc0LzVHV3MzSFYyUkVUVnRmaWlucDhnSE9KT1FVWW5RSzdyM1JY?=
 =?utf-8?B?TXBGRldtbmUxd2NtVWhqNXpVVWNsSE9GMTdIMnczMUNjYUtWY01xOGRsdDcv?=
 =?utf-8?B?OE41LzFQMGl6QXA3VUMrTFVzUG5hUWQxVzVUdHNyS2hHS2RMSTRCQlJCS3Z0?=
 =?utf-8?B?a0pVSWxiNDUra09jbElndGlWdGg5d2FVMTNmaW1UckdCbzkrK1dpQnN2MUJs?=
 =?utf-8?B?RUxHK0IrNUIxdUsvK2duNXhWc2Y5d2hRYzBUQjB4NWxqc1BzSFRXTVllSXRk?=
 =?utf-8?B?S0JKelcvYmJsclpGN3FPdkFtRXE1azBldWd2a1VHY3IzR3R3TDRYMEJwU3Br?=
 =?utf-8?B?amZCSlNaNkdzWFdkcCsrRGdlcUNDNnp0ZjZuSXpac0g5bndnZmViVk5STDFJ?=
 =?utf-8?B?bCtOUjBTTjdFbXVEakNpUERSTndnTkNsRVlFd1ZNMmlOaWdpM2ErT3BmQVpN?=
 =?utf-8?B?dEtXczdmRGFCNWszaXl3QXNObVZRMklaS2Q4Ymh0TlRlQ2ZaQzlLdVc1N2VX?=
 =?utf-8?B?bER1NHVHei9sT0Z6cFFCVDM3SHpPb092NTN3UUtDWEtMSlFQTmJ6QzRCa2o2?=
 =?utf-8?B?SENtQWtnV2R4VWZnTnZFKzZzYVR2dERoQWpZbWMwTmtWS2tubVd0Wmx1TzB0?=
 =?utf-8?B?bHdBckhpZW9WRXlJSXF2TnppZXZUR01Ndy9RQVowaGZOOHVoWU1NZGdRV0ty?=
 =?utf-8?B?VEE5RWtPN0NndWRqNmlydEJDd3Q2T3F6NnBFcXlkWnlGYVBtN1RFTjB3UGww?=
 =?utf-8?B?N0RCUlVaOWdCaFRpdXVZWVlkSktRZVd3bGhUVlFOdWRpVkZrR3hMZkk5VDN3?=
 =?utf-8?B?YjBOY20rNlEwNC9BRkZIeCtpWERTR3YrUGRxMGk1aEpMdnkxdHAvaVFmblQz?=
 =?utf-8?B?MktjZEhtcVR3NWovMXo0akdMMEhSa3hYM2hXVGFVVkxaSThsazZFaUtrejRS?=
 =?utf-8?B?eXdZakVtcDhKRm9ZUzhKY0dGNVBaYStkeTVDaG5vNkl1K3h5K01hZlNWZkFI?=
 =?utf-8?B?VEkzUkIxYVg5eE9kK0dtZmFtaE1xL2hVMk5BRXYzSDV3NTA5ci8vRjRxeUkv?=
 =?utf-8?B?NGNGQmpwZUVZejYyYVJrdGhESE54NHJVOTB6V0p0cTdYMGNOZXdJM3NUcjNW?=
 =?utf-8?B?NFY3RUl3R21pcWlQZmVLa1VVeDgrVmQ0UXAvM2R0WWw1Zyt4cDBQd3RaVDRq?=
 =?utf-8?B?K1V1aXBtTWhiWWJ5bTRkcDA0aU9QS25haHZJb0svSXA0TXRmODNGUGY0TzBz?=
 =?utf-8?B?U2hWaVVqeUJLaml1RUNMQm1ZQVZ1ZjdkVFptZUZuNlBnNmNnNlZYTUpXT1pv?=
 =?utf-8?B?b2JNSkhJUTgrU3lCVE9ldDhrSXpRbmtsOHBxd00xOHpKM0sxOVp1QlRna0Y1?=
 =?utf-8?B?d2E2cmp2Y2RBZGkra2lWM0VvRE5lK2xwYXFZSHhEV2dEMTNXT0xzV1BiMFMz?=
 =?utf-8?B?aEk3MjhHU29Hc2c3RXdjNE1qUjVrYnhnMUUvQjlubjZwcnIvUlRRS0ZXdGZj?=
 =?utf-8?B?bzBJUkJjNXFVdE85eURxcll6Wm9SNUdEcnZWMUQ0YnU2WG94R010N3FYL1B0?=
 =?utf-8?B?NzJzQ1N3cTBlQTFqUmh5dWVOV3NBM1QyTVJjdW1OdW5XTDJKekZLY3pkblRx?=
 =?utf-8?B?QTdRYXVBU0JTVVFKTXZsbS9KTXZLZ1RpZ1VBRGcyUDc3M3VEcWRBTm9pcFRj?=
 =?utf-8?B?Y3lHeEJkNlJHOUdsdGR4by9WeDV5R1U1S3RtNnZPQnpPeThpaUJRc2VQVHNV?=
 =?utf-8?B?WmtERzZjQlVFKyt6cVRWZC9WWUExMlM0aUVXSGpKaUtBQ2Z4TFJMaTkyVVRt?=
 =?utf-8?Q?prtBFzCrp2aIeKrI0N9mR5s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ydb1s0jd09mjBF4gG31HDn9+aUUo0FqLUUzX2oymozAJ74C3eSvvkuYarOpXezESJCwsveH6+Kp9P10uPgZNygSlusX4hpDcxLjxiqFY6QTYI4CxAOYYORiu1zUSbr54aRHmhNl5VdeVkozu/gU1uxXpnzZjzCOkEsOG1DtZuVCJg98aCtlvQLYrnft95cOdsXJvGleLBAvZpsrnezJitprrC5NKQresACrRSqQthRtVg7BUC7tCxUadzN8iTnFY7p+UndlwYVnnrSkXtcvjRQO6WATm1XgfbhTAKdf0kNNWBSCrZNRuOT+Gk4tG9giHOK41eHhkCQAqD0YddFsNbeoxhDvVKPjzHIB7idDcM5GfM+JAL2iUcW1JFLws46rxXweENsOuKsBkhXrISZ/FVlJaB637LcuBRTi/VVQ7J7urMu+QV0qTpVPtzuTMr6j4d5vHGMGlC17FkDQLva73ZWpPLHvNatgcMpzyya22laLc7sbARtvnJHoVRTM2UDM7ymJnWJt4GqARUZfNwVpI2W92XSGlW/6l9V+zqLwqVvATZ+5mhdkvfNZtlsIWPqckqKrfeSVJ70nRhXJfQ8XrtpzAyPF2KMwc6N5TNOkmiqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c469c0-8e77-4a7f-c54e-08dd3a2fbe9e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:24:49.3771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Irvb0x+MhRWO1D/XB59MjNwolqvl8YPOYArSofsadBRARgLSsO1JMnIC/u+WuAVOvTRGSWg11F/rjmyvnHe3dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_06,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210125
X-Proofpoint-GUID: WfOfKXTb8QyjkxF6Ksj-65EG-zibSCx0
X-Proofpoint-ORIG-GUID: WfOfKXTb8QyjkxF6Ksj-65EG-zibSCx0
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 1/16/25 2:00 PM, Eugenio Perez Martin wrote:
> On Fri, Jan 10, 2025 at 6:09 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Implements the GPA->IOVA tree for handling mapping and unmapping for
>> guest memory. This, alongside the SVQ IOVA->HVA tree & IOVA-only tree
>> implemented in the previous patches, allows us to handle guest and
>> host-only memory mapping operations separately via their own respective
>> trees.
>>
>> The next patches will implement a method to determine if an incomming
> 
> s/incomming/incoming/ (credits to google syntax highlight actually :) )
> 

Whoops! Good catch. Maybe I should add a spellchecker plugin to my Vim 
configuration haha.

>> address for translation is backed by guest or host-only memory.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-iova-tree.c | 50 +++++++++++++++++++++++++++++++++++++
>>   hw/virtio/vhost-iova-tree.h |  4 +++
>>   hw/virtio/vhost-vdpa.c      | 22 ++++++++++------
>>   include/qemu/iova-tree.h    | 22 ++++++++++++++++
>>   util/iova-tree.c            | 46 ++++++++++++++++++++++++++++++++++
>>   5 files changed, 136 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>> index f6a5694857..540bc35660 100644
>> --- a/hw/virtio/vhost-iova-tree.c
>> +++ b/hw/virtio/vhost-iova-tree.c
>> @@ -31,6 +31,9 @@ struct VhostIOVATree {
>>
>>       /* Allocated IOVA addresses */
>>       IOVATree *iova_map;
>> +
>> +    /* GPA to IOVA address memory maps */
>> +    IOVATree *gpa_iova_map;
>>   };
>>
>>   /**
>> @@ -48,6 +51,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>
>>       tree->iova_taddr_map = iova_tree_new();
>>       tree->iova_map = iova_tree_new();
>> +    tree->gpa_iova_map = gpa_tree_new();
>>       return tree;
>>   }
>>
>> @@ -58,6 +62,7 @@ void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>   {
>>       iova_tree_destroy(iova_tree->iova_taddr_map);
>>       iova_tree_destroy(iova_tree->iova_map);
>> +    iova_tree_destroy(iova_tree->gpa_iova_map);
>>       g_free(iova_tree);
>>   }
>>
>> @@ -134,3 +139,48 @@ int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>
>>       return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>   }
>> +
>> +/** Insert a new GPA->IOVA mapping to the GPA->IOVA tree
>> + *
>> + * @iova_tree: The VhostIOVATree
>> + * @map: The GPA->IOVA mapping
>> + *
>> + * Returns:
>> + * - IOVA_OK if the map fits in the container
>> + * - IOVA_ERR_INVALID if the map does not make sense (e.g. size overflow)
>> + * - IOVA_ERR_OVERLAP if the GPA range overlaps with an existing range
>> + */
>> +int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map)
>> +{
>> +    if (map->iova + map->size < map->iova || map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    return gpa_tree_insert(iova_tree->gpa_iova_map, map);
>> +}
>> +
>> +/**
>> + * Find the IOVA address stored from a guest memory address (GPA)
>> + *
>> + * @tree: The VhostIOVATree
>> + * @map: The map with the guest memory address
>> + *
>> + * Returns the stored GPA->IOVA mapping, or NULL if not found.
>> + */
>> +const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *tree,
>> +                                       const DMAMap *map)
>> +{
>> +    return iova_tree_find_iova(tree->gpa_iova_map, map);
>> +}
>> +
>> +/**
>> + * Remove existing mappings from the GPA->IOVA & IOVA trees
>> + *
>> + * @iova_tree: The VhostIOVATree
>> + * @map: The guest memory address map to remove
>> + */
>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
>> +{
>> +    iova_tree_remove(iova_tree->gpa_iova_map, map);
>> +    iova_tree_remove(iova_tree->iova_map, map);
>> +}
>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>> index 8bf7b64786..3e3dcd04fe 100644
>> --- a/hw/virtio/vhost-iova-tree.h
>> +++ b/hw/virtio/vhost-iova-tree.h
>> @@ -24,5 +24,9 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>   int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>> +int vhost_iova_tree_insert_gpa(VhostIOVATree *iova_tree, DMAMap *map);
>> +const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree,
>> +                                       const DMAMap *map);
>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
>>
>>   #endif
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index f5803f35f4..8587f3f6c8 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>       if (s->shadow_data) {
>>           int r;
>>
>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
>>           mem_region.size = int128_get64(llsize) - 1,
>>           mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>
>> +        /* Allocate an IOVA range in the IOVA tree */
>>           r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>           if (unlikely(r != IOVA_OK)) {
>>               error_report("Can't allocate a mapping (%d)", r);
>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>           }
>>
>>           iova = mem_region.iova;
>> +        mem_region.translated_addr = section->offset_within_address_space;
>> +
>> +        /* Add GPA->IOVA mapping to the GPA->IOVA tree */
>> +        r = vhost_iova_tree_insert_gpa(s->iova_tree, &mem_region);
>> +        if (unlikely(r != IOVA_OK)) {
>> +            error_report("Can't add listener region mapping (%d)", r);
>> +            goto fail_map;
>> +        }
> 
> If we want to make the two disjoint trees, we need to make the
> previous commits working. I mean, either insert hva and then switch to
> gpa here, or merge patches, or something similar. Otherwise, bisection
> breaks.
> 
> 

Gotcha. In the future I'll be more careful and make sure individual 
patches in a series actually work. My apologies.

Will fix this in the next series.

>>       }
>>
>>       vhost_vdpa_iotlb_batch_begin_once(s);
>> @@ -386,7 +394,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>
>>   fail_map:
>>       if (s->shadow_data) {
>> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
>> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
>>       }
>>
>>   fail:
>> @@ -440,21 +448,19 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>
>>       if (s->shadow_data) {
>>           const DMAMap *result;
>> -        const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>> -            section->offset_within_region +
>> -            (iova - section->offset_within_address_space);
>>           DMAMap mem_region = {
>> -            .translated_addr = (hwaddr)(uintptr_t)vaddr,
>> +            .translated_addr = section->offset_within_address_space,
>>               .size = int128_get64(llsize) - 1,
>>           };
>>
>> -        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
>> +        /* Search the GPA->IOVA tree */
>> +        result = vhost_iova_tree_find_gpa(s->iova_tree, &mem_region);
>>           if (!result) {
>>               /* The memory listener map wasn't mapped */
>>               return;
>>           }
>>           iova = result->iova;
>> -        vhost_iova_tree_remove(s->iova_tree, *result);
>> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
>>       }
>>       vhost_vdpa_iotlb_batch_begin_once(s);
>>       /*
>> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
>> index 44a45931d5..8467912a0b 100644
>> --- a/include/qemu/iova-tree.h
>> +++ b/include/qemu/iova-tree.h
>> @@ -40,6 +40,15 @@ typedef struct DMAMap {
>>   } QEMU_PACKED DMAMap;
>>   typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>
>> +/**
>> + * gpa_tree_new:
>> + *
>> + * Create a new GPA->IOVA tree.
>> + *
>> + * Returns: the tree pointer on success, or NULL otherwise.
>> + */
>> +IOVATree *gpa_tree_new(void);
>> +
>>   /**
>>    * iova_tree_new:
>>    *
>> @@ -49,6 +58,19 @@ typedef gboolean (*iova_tree_iterator)(DMAMap *map);
>>    */
>>   IOVATree *iova_tree_new(void);
>>
>> +/**
>> + * gpa_tree_insert:
>> + *
>> + * @tree: The GPA->IOVA tree we're inserting the mapping to
>> + * @map: The GPA->IOVA mapping to insert
>> + *
>> + * Inserts a GPA range to the GPA->IOVA tree. If there are overlapped
>> + * ranges, IOVA_ERR_OVERLAP will be returned.
>> + *
>> + * Return: 0 if successful, < 0 otherwise.
>> + */
>> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map);
>> +
>>   /**
>>    * iova_tree_insert:
>>    *
>> diff --git a/util/iova-tree.c b/util/iova-tree.c
>> index 06295e2755..f45e63c3de 100644
>> --- a/util/iova-tree.c
>> +++ b/util/iova-tree.c
>> @@ -55,6 +55,22 @@ static void iova_tree_alloc_args_iterate(struct IOVATreeAllocArgs *args,
>>       args->this = next;
>>   }
>>
>> +static int gpa_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
>> +{
>> +    const DMAMap *m1 = a, *m2 = b;
>> +
>> +    if (m1->translated_addr > m2->translated_addr + m2->size) {
>> +        return 1;
>> +    }
>> +
>> +    if (m1->translated_addr + m1->size < m2->translated_addr) {
>> +        return -1;
>> +    }
>> +
>> +    /* Overlapped */
>> +    return 0;
>> +}
>> +
>>   static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
>>   {
>>       const DMAMap *m1 = a, *m2 = b;
>> @@ -71,6 +87,15 @@ static int iova_tree_compare(gconstpointer a, gconstpointer b, gpointer data)
>>       return 0;
>>   }
>>
>> +IOVATree *gpa_tree_new(void)
>> +{
>> +    IOVATree *gpa_tree = g_new0(IOVATree, 1);
>> +
>> +    gpa_tree->tree = g_tree_new_full(gpa_tree_compare, NULL, g_free, NULL);
>> +
>> +    return gpa_tree;
>> +}
>> +
>>   IOVATree *iova_tree_new(void)
>>   {
>>       IOVATree *iova_tree = g_new0(IOVATree, 1);
>> @@ -121,6 +146,27 @@ static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
>>       g_tree_insert(gtree, range, range);
>>   }
>>
>> +int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
>> +{
>> +    DMAMap *new;
>> +
>> +    if (map->translated_addr + map->size < map->translated_addr ||
>> +        map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    /* We don't allow inserting ranges that overlap with existing ones */
>> +    if (iova_tree_find(tree,map)) {
>> +        return IOVA_ERR_OVERLAP;
>> +    }
>> +
>> +    new = g_new0(DMAMap, 1);
>> +    memcpy(new, map, sizeof(*new));
>> +    iova_tree_insert_internal(tree->tree, new);
>> +
>> +    return IOVA_OK;
>> +}
>> +
> 
> I'm missing the advantage of using all of these functions, why not use
> another iova_tree_new and iova_tree_insert? gpa_tree_compare seems
> like a 1:1 copy of iova_tree_compare to me. Same with _insert.
> 

It's mainly due to how the GPA tree is configured. That is, GPA->IOVA 
(or translated_addr->iova).

The existing functions assume the configuration of the tree to be
iova->translated_addr (e.g. IOVA->HVA).

I think I could still use the existing functions but then it'd have to 
be a IOVA->GPA tree, else a GPA->IOVA tree would mean DMAMap map->iova 
== GPA and map->translated_addr == IOVA, which obviously would cause 
confusion for the API users.

>>   int iova_tree_insert(IOVATree *tree, const DMAMap *map)
>>   {
>>       DMAMap *new;
>> --
>> 2.43.5
>>
> 


